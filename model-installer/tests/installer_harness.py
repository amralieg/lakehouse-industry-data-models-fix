"""Test doubles for exercising the installer's sample path without a Spark cluster.

`FakeSpark` answers the three information_schema reads the engine issues, serves the
`SELECT * FROM t LIMIT 0` schema probe from the same fixture, and records every write,
so a test can assert on the rows that WOULD land in Unity Catalog.
"""
import json
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
INSTALLER = HERE.parent / "data-model-installer.ipynb"
ENGINE = HERE.parent / "sample_engine.py"


# ---------------------------------------------------------------- notebook access

def notebook_cells():
    return json.loads(INSTALLER.read_text())["cells"]


def cell_source(cell):
    src = cell.get("source", "")
    return "".join(src) if isinstance(src, list) else src


def find_cell(needle):
    for cell in notebook_cells():
        if cell.get("cell_type") == "code" and needle in cell_source(cell):
            return cell_source(cell)
    raise LookupError("no code cell contains %r" % needle)


def load_engine():
    """Exec the notebook's sample cell, so tests bind to what actually ships."""
    namespace = {"__name__": "installer_sample_cell"}
    exec(compile(find_cell("def generate_sample_data"), "<sample-cell>", "exec"), namespace)
    return namespace


# ---------------------------------------------------------------- fake spark

class FakeField(object):
    def __init__(self, name):
        self.name = name


class FakeSchema(object):
    def __init__(self, names):
        self.fields = [FakeField(n) for n in names]


class FakeResult(object):
    def __init__(self, rows, schema=None):
        self._rows = rows
        self.schema = schema

    def collect(self):
        return list(self._rows)


class FakeWriter(object):
    def __init__(self, frame):
        self._frame = frame

    def mode(self, _mode):
        return self

    def saveAsTable(self, name):
        self._frame.spark.written.setdefault(name, []).extend(self._frame.rows)


class FakeFrame(object):
    def __init__(self, spark, rows, schema):
        self.spark = spark
        self.rows = rows
        self.schema = schema

    @property
    def write(self):
        return FakeWriter(self)


class FakeSpark(object):
    """Serves information_schema from a fixture dict and records writes.

    fixture = {"catalog": str,
               "tables": {(schema, table): {"columns": [(name, type, nullable)],
                                            "pk": [...],
                                            "fks": [{"columns": [...],
                                                     "parent": (schema, table),
                                                     "parent_columns": [...]}]}}}
    """

    def __init__(self, fixture, ai_response=None, ai_error=False, write_error=()):
        self.fixture = fixture
        self.ai_response = ai_response
        self.ai_error = ai_error
        self.write_error = set(write_error)
        self.written = {}
        self.queries = []

    # -- helpers ---------------------------------------------------------------
    def _columns_rows(self):
        rows = []
        for (schema, table), spec in self.fixture["tables"].items():
            for position, (name, dtype, nullable) in enumerate(spec["columns"], start=1):
                rows.append((schema, table, name, dtype,
                             "YES" if nullable else "NO", position))
        return rows

    def _pk_rows(self):
        rows = []
        for (schema, table), spec in self.fixture["tables"].items():
            for position, column in enumerate(spec.get("pk", []), start=1):
                rows.append((schema, table, column, position))
        return rows

    def _fk_rows(self):
        rows, seq = [], 0
        catalog = self.fixture["catalog"]
        for (schema, table), spec in self.fixture["tables"].items():
            for fk in spec.get("fks", []):
                seq += 1
                name = "%s_%s_fk%d" % (table, schema, seq)
                parent_schema, parent_table = fk["parent"]
                for position, column in enumerate(fk["columns"], start=1):
                    for parent_column in fk["parent_columns"]:
                        rows.append((name, schema, table, column, position,
                                     catalog, parent_schema, parent_table, parent_column))
        return rows

    # -- api -------------------------------------------------------------------
    def sql(self, query):
        self.queries.append(query)
        flat = " ".join(query.split())
        if "ai_query" in flat:
            if self.ai_error:
                raise RuntimeError("endpoint unavailable")
            return FakeResult([(self.ai_response or "",)])
        if "information_schema.columns" in flat:
            return FakeResult(self._columns_rows())
        if "constraint_column_usage" in flat:
            return FakeResult(self._fk_rows())
        if "key_column_usage" in flat:
            return FakeResult(self._pk_rows())
        probe = re.match(r"SELECT \* FROM `([^`]+)`\.`([^`]+)`\.`([^`]+)` LIMIT 0", flat)
        if probe:
            _catalog, schema, table = probe.groups()
            if (schema, table) in self.write_error:
                raise RuntimeError("table is not writable")
            spec = self.fixture["tables"][(schema, table)]
            return FakeResult([], FakeSchema([c[0] for c in spec["columns"]]))
        return FakeResult([])

    def createDataFrame(self, rows, schema):
        return FakeFrame(self, list(rows), schema)


# ---------------------------------------------------------------- fixtures

def shop_fixture():
    """A model with every shape the engine has to survive.

    single-column key, string key, composite key, cross-schema FK, composite FK,
    self FK, a two-table FK cycle, a narrow decimal and an ordered date pair.
    """
    return {
        "catalog": "demo",
        "tables": {
            ("sales", "customer"): {
                "columns": [("customer_id", "BIGINT", False),
                            ("customer_name", "STRING", False),
                            ("country_code", "STRING", True),
                            ("email", "STRING", True),
                            ("loyalty_score", "DECIMAL(5,4)", True),
                            ("status", "STRING", False),
                            ("created_date", "DATE", True),
                            ("updated_date", "DATE", True),
                            ("primary_order_id", "BIGINT", True)],
                "pk": ["customer_id"],
                # cycle: customer -> order -> customer
                "fks": [{"columns": ["primary_order_id"], "parent": ("sales", "order"),
                         "parent_columns": ["order_id"]}],
            },
            ("sales", "order"): {
                "columns": [("order_id", "BIGINT", False),
                            ("customer_id", "BIGINT", False),
                            ("order_date", "DATE", True),
                            ("ship_date", "DATE", True),
                            ("total_amount", "DECIMAL(18,2)", True),
                            ("quantity", "INT", True),
                            ("order_status", "STRING", True)],
                "pk": ["order_id"],
                "fks": [{"columns": ["customer_id"], "parent": ("sales", "customer"),
                         "parent_columns": ["customer_id"]}],
            },
            ("sales", "order_line"): {
                "columns": [("order_id", "BIGINT", False),
                            ("line_no", "INT", False),
                            ("unit_price", "DECIMAL(10,2)", True),
                            ("quantity", "INT", True)],
                "pk": ["order_id", "line_no"],
                "fks": [{"columns": ["order_id"], "parent": ("sales", "order"),
                         "parent_columns": ["order_id"]}],
            },
            ("hr", "employee"): {
                "columns": [("employee_id", "BIGINT", False),
                            ("full_name", "STRING", False),
                            ("manager_id", "BIGINT", True),
                            ("hire_date", "DATE", True),
                            ("termination_date", "DATE", True)],
                "pk": ["employee_id"],
                "fks": [{"columns": ["manager_id"], "parent": ("hr", "employee"),
                         "parent_columns": ["employee_id"]}],
            },
            ("ops", "shipment"): {
                "columns": [("shipment_id", "STRING", False),
                            ("order_id", "BIGINT", True),
                            ("carrier_name", "STRING", True),
                            ("dispatch_timestamp", "TIMESTAMP", True)],
                "pk": ["shipment_id"],
                "fks": [{"columns": ["order_id"], "parent": ("sales", "order"),
                         "parent_columns": ["order_id"]}],
            },
            ("ops", "line_event"): {
                "columns": [("event_id", "BIGINT", False),
                            ("order_id", "BIGINT", True),
                            ("line_no", "INT", True),
                            ("event_type", "STRING", True)],
                "pk": ["event_id"],
                "fks": [{"columns": ["order_id", "line_no"],
                         "parent": ("sales", "order_line"),
                         "parent_columns": ["order_id", "line_no"]}],
            },
            ("ops", "reference_country"): {
                "columns": [("country_code", "STRING", False),
                            ("country_name", "STRING", False)],
                "pk": ["country_code"],
                "fks": [],
            },
        },
    }


def sample_config(**overrides):
    cfg = {"enabled": True, "rows": 10, "seed": 20260801, "threads": 2,
           "llm": False, "llm_endpoints": []}
    cfg.update(overrides)
    return cfg
