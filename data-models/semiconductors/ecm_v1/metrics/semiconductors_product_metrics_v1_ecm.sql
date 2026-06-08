-- Metric views for domain: product | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_ic_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for the IC catalog covering volume and core physical characteristics"
  source: "`semiconductors_ecm`.`product`.`ic_catalog`"
  dimensions:
    - name: "process_technology"
      expr: process_technology
      comment: "Process technology node of the IC (e.g., 7nm, 14nm)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the IC (e.g., Active, End-of-Life)"
  measures:
    - name: "total_ic_count"
      expr: COUNT(1)
      comment: "Total number of IC catalog entries"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters across all ICs"
    - name: "avg_power_max_mw"
      expr: AVG(CAST(power_max_mw AS DOUBLE))
      comment: "Average maximum power consumption (mW) of ICs"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic cost and risk metrics for product BOMs"
  source: "`semiconductors_ecm`.`product`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., Approved, Draft)"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant identifier"
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of Bills of Materials"
    - name: "sum_total_material_cost"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Aggregate material cost across all BOMs"
    - name: "avg_total_material_cost"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average material cost per BOM"
    - name: "critical_material_bom_count"
      expr: SUM(CASE WHEN critical_material_flag THEN 1 ELSE 0 END)
      comment: "Number of BOMs flagged as containing critical materials"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component‑level cost and risk indicators for BOMs"
  source: "`semiconductors_ecm`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type/category of the component (e.g., Resistor, IC)"
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Indicates whether the component is made in‑house or purchased"
  measures:
    - name: "total_bom_line_count"
      expr: COUNT(1)
      comment: "Total number of BOM line items"
    - name: "sum_quantity_per_assembly"
      expr: SUM(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Total quantity per assembly across all lines"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per component"
    - name: "critical_component_line_count"
      expr: SUM(CASE WHEN critical_component_flag THEN 1 ELSE 0 END)
      comment: "Count of BOM lines marked as critical components"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_pcn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change‑management KPIs that track volume and speed of product changes"
  source: "`semiconductors_ecm`.`product`.`pcn`"
  dimensions:
    - name: "pcn_status"
      expr: pcn_status
      comment: "Current status of the PCN (e.g., Open, Closed)"
    - name: "automotive_qualification_required_flag"
      expr: automotive_qualification_required_flag
      comment: "Whether automotive qualification is required for the change"
  measures:
    - name: "total_pcn_count"
      expr: COUNT(1)
      comment: "Total number of Product Change Notifications (PCNs)"
    - name: "avg_time_to_implementation_days"
      expr: AVG(DATEDIFF(implementation_date, DATE(created_timestamp)))
      comment: "Average days from PCN creation to implementation"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue‑related and availability metrics for product SKUs"
  source: "`semiconductors_ecm`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the SKU (e.g., Active, Discontinued)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured"
  measures:
    - name: "total_sku_count"
      expr: COUNT(1)
      comment: "Total number of SKUs"
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price in USD across SKUs"
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost in USD across SKUs"
    - name: "orderable_sku_count"
      expr: SUM(CASE WHEN orderable_flag THEN 1 ELSE 0 END)
      comment: "Number of SKUs that are currently orderable"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic IP portfolio metrics focusing on power and complexity"
  source: "`semiconductors_ecm`.`product`.`product_ip_core`"
  dimensions:
    - name: "ip_category"
      expr: ip_category
      comment: "Category of IP core (e.g., Analog, Digital)"
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model applied to the IP core"
  measures:
    - name: "total_ip_core_count"
      expr: COUNT(1)
      comment: "Total number of IP cores"
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption (mW) of IP cores"
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count per IP core"
$$;