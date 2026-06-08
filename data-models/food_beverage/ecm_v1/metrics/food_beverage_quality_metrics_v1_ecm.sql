-- Metric views for domain: quality | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics to monitor quality and compliance impact."
  source: "`food_beverage_ecm`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint."
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint."
    - name: "complaint_status"
      expr: customer_complaint_status
      comment: "Current status of the complaint."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the complaint."
    - name: "complaint_year"
      expr: DATE_TRUNC('year', complaint_timestamp)
      comment: "Year the complaint was logged."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints."
    - name: "average_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact amount per complaint."
    - name: "regulatory_reportable_complaints"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints that are regulatory reportable."
    - name: "open_complaints"
      expr: SUM(CASE WHEN customer_complaint_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of complaints currently open."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_non_conformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key non‑conformance KPIs for risk and cost monitoring."
  source: "`food_beverage_ecm`.`quality`.`non_conformance`"
  dimensions:
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the non‑conformance."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category."
    - name: "event_year"
      expr: DATE_TRUNC('year', event_timestamp)
      comment: "Year the non‑conformance event occurred."
  measures:
    - name: "total_non_conformances"
      expr: COUNT(1)
      comment: "Total number of non‑conformance records."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Sum of cost impact amounts for non‑conformances."
    - name: "average_quality_metric_value"
      expr: AVG(CAST(quality_metric_value AS DOUBLE))
      comment: "Average quality metric value recorded."
    - name: "high_severity_count"
      expr: SUM(CASE WHEN severity_classification = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high‑severity non‑conformances."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall performance metrics to assess impact and effectiveness."
  source: "`food_beverage_ecm`.`quality`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., safety, quality)."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the recall."
    - name: "recall_initiation_year"
      expr: DATE_TRUNC('year', recall_initiation_timestamp)
      comment: "Year the recall was initiated."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recalls."
    - name: "total_monetary_loss"
      expr: SUM(CAST(monetary_loss_amount AS DOUBLE))
      comment: "Sum of monetary loss associated with recalls."
    - name: "voluntary_recalls"
      expr: SUM(CASE WHEN is_voluntary = TRUE THEN 1 ELSE 0 END)
      comment: "Count of voluntary recalls."
    - name: "average_quantity_affected"
      expr: AVG(CAST(quantity_affected AS DOUBLE))
      comment: "Average quantity affected per recall."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_shelf_life_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shelf‑life study metrics to guide product stability planning."
  source: "`food_beverage_ecm`.`quality`.`shelf_life_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of shelf‑life study."
    - name: "storage_temperature_c"
      expr: storage_temperature_c
      comment: "Storage temperature used in the study (°C)."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the study."
    - name: "study_start_year"
      expr: DATE_TRUNC('year', study_start_date)
      comment: "Year the study started."
  measures:
    - name: "total_studies"
      expr: COUNT(1)
      comment: "Total number of shelf‑life studies."
    - name: "average_q10_value"
      expr: AVG(CAST(q10_value AS DOUBLE))
      comment: "Average Q10 acceleration factor across studies."
    - name: "average_storage_humidity"
      expr: AVG(CAST(storage_humidity_percent AS DOUBLE))
      comment: "Average storage humidity percent used in studies."
    - name: "average_temperature_acceleration_factor"
      expr: AVG(CAST(temperature_acceleration_factor AS DOUBLE))
      comment: "Average temperature acceleration factor across studies."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CCP performance metrics for food safety monitoring."
  source: "`food_beverage_ecm`.`quality`.`critical_control_point`"
  dimensions:
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard addressed by the CCP."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the CCP is critical."
    - name: "ccp_code"
      expr: ccp_code
      comment: "Unique code for the CCP."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the CCP."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the CCP became effective."
  measures:
    - name: "total_ccp"
      expr: COUNT(1)
      comment: "Total number of critical control points (CCPs)."
    - name: "average_critical_limit_value"
      expr: AVG(CAST(critical_limit_value AS DOUBLE))
      comment: "Average critical limit value across CCPs."
    - name: "non_compliant_ccp"
      expr: SUM(CASE WHEN compliance_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of CCPs not in compliance."
    - name: "critical_ccp_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CCPs marked as critical."
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`quality_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Specification KPIs to track product quality targets."
  source: "`food_beverage_ecm`.`quality`.`specification`"
  dimensions:
    - name: "spec_type"
      expr: spec_type
      comment: "Type of specification (e.g., nutritional, safety)."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the specification."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU linked to the specification."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the specification is critical."
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the specification became effective."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total number of quality specifications."
    - name: "average_brix_percent"
      expr: AVG(CAST(brix_percent AS DOUBLE))
      comment: "Average Brix percent across specifications."
    - name: "average_ph"
      expr: AVG(CAST(ph AS DOUBLE))
      comment: "Average pH across specifications."
    - name: "average_fat_percent"
      expr: AVG(CAST(fat_percent AS DOUBLE))
      comment: "Average fat percent across specifications."
    - name: "critical_specifications"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of specifications marked as critical."
$$;