-- Metric views for domain: manufacturing | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for manufacturing batch records, covering cost, size, rework, scrap and overall equipment effectiveness."
  source: "`consumer_goods_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Date the batch was manufactured"
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch"
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Identifier of the manufacturing facility"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the batch"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates if batch has been recalled"
  measures:
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Total number of batch records"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Sum of actual cost amount for all batches"
    - name: "avg_batch_size_actual"
      expr: AVG(CAST(batch_size_actual AS DOUBLE))
      comment: "Average actual batch size"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across batches"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across batches"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage for batches"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy and reliability metrics for manufacturing equipment."
  source: "`consumer_goods_ecm`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type/category of equipment"
    - name: "status"
      expr: status
      comment: "Current operational status of equipment"
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Facility where equipment is located"
    - name: "installation_date"
      expr: installation_date
      comment: "Date equipment was installed"
  measures:
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment records"
    - name: "total_energy_consumption"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption (kWh) across equipment"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures (hours)"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair (hours)"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall equipment effectiveness and production output metrics."
  source: "`consumer_goods_ecm`.`manufacturing`.`oee_record`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Facility identifier"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift"
    - name: "shift_name"
      expr: shift_name
      comment: "Name/label of the shift"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being produced"
  measures:
    - name: "oee_record_count"
      expr: COUNT(1)
      comment: "Number of OEE records"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage"
    - name: "total_good_units"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total good units produced"
    - name: "total_units_produced"
      expr: SUM(CAST(total_units_produced AS DOUBLE))
      comment: "Total units produced (including good and rejected)"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime event analysis for operational reliability and cost impact."
  source: "`consumer_goods_ecm`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Facility where downtime occurred"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line impacted"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g., mechanical, quality)"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event"
    - name: "equipment_failure_mode"
      expr: equipment_failure_mode
      comment: "Failure mode of equipment"
    - name: "downtime_start_date"
      expr: DATE_TRUNC('day', downtime_start_timestamp)
      comment: "Date of downtime start"
  measures:
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Number of downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of downtime events"
    - name: "distinct_severity_levels"
      expr: COUNT(DISTINCT severity_level)
      comment: "Count of distinct severity levels observed"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield performance and loss metrics for production runs."
  source: "`consumer_goods_ecm`.`manufacturing`.`yield_record`"
  dimensions:
    - name: "production_order_id"
      expr: production_order_id
      comment: "Production order identifier"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code during which yield was measured"
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates GMP compliance for the yield"
  measures:
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield records"
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage"
    - name: "avg_theoretical_yield_percentage"
      expr: AVG(CAST(theoretical_yield_percentage AS DOUBLE))
      comment: "Average theoretical yield percentage"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across yields"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across yields"
$$;