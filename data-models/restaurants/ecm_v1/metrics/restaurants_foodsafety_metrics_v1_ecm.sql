-- Metric views for domain: foodsafety | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_allergen_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key safety incident metrics for allergen exposure events."
  source: "`restaurants_ecm`.`foodsafety`.`allergen_incident`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Identifier of the restaurant unit where the incident occurred."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the allergen incident (e.g., cross‑contact, labeling error)."
    - name: "incident_date"
      expr: DATE_TRUNC('day', incident_timestamp)
      comment: "Date of the incident (day granularity)."
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of allergen incidents recorded."
    - name: "fda_medwatch_filed_count"
      expr: SUM(CASE WHEN fda_medwatch_filed THEN 1 ELSE 0 END)
      comment: "Count of incidents that were reported to FDA MedWatch."
    - name: "repeat_incident_count"
      expr: SUM(CASE WHEN is_repeat_incident THEN 1 ELSE 0 END)
      comment: "Count of repeat allergen incidents."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated metrics for food safety audits across units."
  source: "`restaurants_ecm`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit audited."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)."
    - name: "audit_date"
      expr: DATE_TRUNC('day', audit_timestamp)
      comment: "Date of the audit (day granularity)."
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of food safety audits performed."
    - name: "compliance_score_avg"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audits."
    - name: "passed_audit_count"
      expr: SUM(CASE WHEN pass_fail = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of audits that passed."
    - name: "sanitation_schedule_compliant_count"
      expr: SUM(CASE WHEN sanitation_schedule_compliant THEN 1 ELSE 0 END)
      comment: "Count of audits where the sanitation schedule was compliant."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics summarizing audit findings and their severity."
  source: "`restaurants_ecm`.`foodsafety`.`audit_finding`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit associated with the finding."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., hygiene, documentation)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level label of the finding."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (Open, Closed, etc.)."
  measures:
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded."
    - name: "severity_score_avg"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of findings."
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of findings classified as Critical severity."
    - name: "open_finding_count"
      expr: SUM(CASE WHEN audit_finding_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of findings that remain open."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_food_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level recall performance indicators."
  source: "`restaurants_ecm`.`foodsafety`.`food_recall`"
  dimensions:
    - name: "recall_class"
      expr: recall_class
      comment: "Regulatory class of the recall (e.g., Class I, II, III)."
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (Open, Closed)."
    - name: "recall_initiation_date"
      expr: DATE_TRUNC('day', recall_initiation_timestamp)
      comment: "Date the recall was initiated."
  measures:
    - name: "recall_count"
      expr: COUNT(1)
      comment: "Total number of food recalls initiated."
    - name: "voluntary_recall_count"
      expr: SUM(CASE WHEN is_voluntary THEN 1 ELSE 0 END)
      comment: "Count of recalls that were voluntary."
    - name: "severity_score_avg"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score across recalls."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Temperature monitoring KPIs for food safety compliance."
  source: "`restaurants_ecm`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "equipment_asset_id"
      expr: equipment_equipment_asset_id
      comment: "Equipment asset that recorded the temperature."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Location of the stock item being monitored."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of the temperature reading (day granularity)."
  measures:
    - name: "reading_count"
      expr: COUNT(1)
      comment: "Total temperature readings captured."
    - name: "avg_temperature"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature across all readings."
    - name: "deviation_flag_count"
      expr: SUM(CASE WHEN deviation_flag THEN 1 ELSE 0 END)
      comment: "Number of readings flagged as deviations."
    - name: "out_of_range_high_count"
      expr: SUM(CASE WHEN temperature_value > critical_limit_high THEN 1 ELSE 0 END)
      comment: "Readings exceeding the high critical limit."
    - name: "out_of_range_low_count"
      expr: SUM(CASE WHEN temperature_value < critical_limit_low THEN 1 ELSE 0 END)
      comment: "Readings falling below the low critical limit."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core health inspection performance indicators."
  source: "`restaurants_ecm`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit inspected."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (e.g., routine, follow‑up)."
    - name: "inspection_date"
      expr: DATE_TRUNC('day', inspection_date)
      comment: "Date of the inspection (day granularity)."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of health inspections performed."
    - name: "total_fee_amount"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Sum of inspection fees charged."
    - name: "passed_inspection_count"
      expr: SUM(CASE WHEN pass_fail = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of inspections that passed."
$$;