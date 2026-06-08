-- Metric views for domain: quality | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key inspection KPIs for quality oversight"
  source: "`construction_ecm`.`quality`.`inspection`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Identifier of the construction project"
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date the inspection took place"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type/category of the inspection"
    - name: "location_description"
      expr: location_description
      comment: "Free‑text description of the inspection location"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions recorded during the inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection records"
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity measured during inspections"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature recorded during inspections"
    - name: "inspections_with_ncr_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Count of inspections that raised a non‑conformance report (NCR)"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect management KPIs to monitor cost and severity"
  source: "`construction_ecm`.`quality`.`defect`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier"
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (e.g., Open, Closed)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the defect"
    - name: "defect_type"
      expr: defect_type
      comment: "Type/category of the defect"
    - name: "location_building"
      expr: location_building
      comment: "Building where the defect was identified"
    - name: "identified_date"
      expr: identified_date
      comment: "Date the defect was identified"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "total_rectification_cost"
      expr: SUM(CAST(rectification_cost AS DOUBLE))
      comment: "Sum of all rectification costs for defects"
    - name: "avg_rectification_cost"
      expr: AVG(CAST(rectification_cost AS DOUBLE))
      comment: "Average rectification cost per defect"
    - name: "high_severity_defect_count"
      expr: COUNT(CASE WHEN severity = 'High' THEN 1 END)
      comment: "Count of defects classified as high severity"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour performance and quality metrics"
  source: "`construction_ecm`.`quality`.`concrete_pour_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier"
    - name: "pour_date"
      expr: pour_date
      comment: "Date the concrete pour occurred"
    - name: "concrete_grade"
      expr: concrete_grade
      comment: "Grade/specification of the concrete used"
    - name: "supplier_name"
      expr: supplier_name
      comment: "Supplier of the concrete mix"
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during the pour"
  measures:
    - name: "total_pours"
      expr: COUNT(1)
      comment: "Total number of concrete pour records"
    - name: "total_volume_m3"
      expr: SUM(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Cumulative concrete volume poured (cubic meters)"
    - name: "avg_volume_per_pour"
      expr: AVG(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Average volume per concrete pour"
    - name: "slump_test_passed_count"
      expr: COUNT(CASE WHEN slump_test_passed = TRUE THEN 1 END)
      comment: "Number of pours where the slump test passed"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list KPIs to track remediation effort and cost"
  source: "`construction_ecm`.`quality`.`punch_item`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier"
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch item"
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item"
    - name: "identified_date"
      expr: identified_date
      comment: "Date the punch item was identified"
    - name: "location"
      expr: location
      comment: "Location description of the punch item"
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total number of punch items recorded"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Aggregate cost impact of all punch items"
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per punch item"
    - name: "high_priority_punch_count"
      expr: COUNT(CASE WHEN priority = 'High' THEN 1 END)
      comment: "Count of punch items marked as high priority"
$$;