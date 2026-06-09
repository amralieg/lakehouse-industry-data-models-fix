-- Metric views for domain: compliance | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_cafe_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level CAFE compliance KPIs useful for executive oversight of fuel‑economy performance and associated penalties."
  source: "`automotive_ecm`.`compliance`.`cafe_compliance_record`"
  dimensions:
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Regulatory jurisdiction identifier"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "fleet_type"
      expr: fleet_type
      comment: "Category of fleet (e.g., passenger, commercial)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority overseeing the record"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year the compliance was reported"
    - name: "is_active"
      expr: is_active
      comment: "Indicates if the record is currently active"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Total number of CAFE compliance records"
    - name: "total_fine_liability_usd"
      expr: SUM(CAST(fine_liability_usd AS DOUBLE))
      comment: "Sum of fines associated with non‑compliance"
    - name: "avg_compliance_gap_mpg"
      expr: AVG(CAST(compliance_gap_mpg AS DOUBLE))
      comment: "Average MPG shortfall versus required CAFE value"
    - name: "avg_actual_cafe_mpg"
      expr: AVG(CAST(actual_cafe_mpg AS DOUBLE))
      comment: "Average actual CAFE fuel‑economy achieved"
    - name: "avg_required_cafe_mpg"
      expr: AVG(CAST(required_cafe_mpg AS DOUBLE))
      comment: "Average required CAFE fuel‑economy"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_recall_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall defect reporting metrics that drive safety and compliance actions."
  source: "`automotive_ecm`.`compliance`.`recall_defect_report`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the affected vehicle"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Agency responsible for the recall"
    - name: "recall_number"
      expr: recall_number
      comment: "Official recall identifier"
    - name: "source_system"
      expr: source_system
      comment: "Source system that recorded the defect report"
    - name: "vehicle_model"
      expr: vehicle_model
      comment: "Vehicle model name"
  measures:
    - name: "recall_report_count"
      expr: COUNT(1)
      comment: "Number of recall defect reports filed"
    - name: "distinct_models_affected"
      expr: COUNT(DISTINCT model_id)
      comment: "Count of unique vehicle models impacted by recalls"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_zev_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key ZEV credit KPIs for tracking credit inventory and financial impact."
  source: "`automotive_ecm`.`compliance`.`zev_credit`"
  dimensions:
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction where the credit is applicable"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Type of powertrain (e.g., BEV, PHEV)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the credit"
    - name: "region"
      expr: region
      comment: "Geographic region of the credit"
    - name: "credit_type"
      expr: credit_type
      comment: "Classification of the credit"
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of the credit (e.g., active, retired)"
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the credit"
  measures:
    - name: "total_credit_quantity"
      expr: SUM(CAST(credit_quantity AS DOUBLE))
      comment: "Total quantity of ZEV credits"
    - name: "total_credit_value_usd"
      expr: SUM(credit_price_usd * credit_quantity)
      comment: "Aggregate monetary value of ZEV credits"
    - name: "avg_credit_price_usd"
      expr: AVG(CAST(credit_price_usd AS DOUBLE))
      comment: "Average price per ZEV credit in USD"
    - name: "credit_count"
      expr: COUNT(1)
      comment: "Number of ZEV credit records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental permit metrics to monitor compliance exposure and permit portfolio."
  source: "`automotive_ecm`.`compliance`.`environmental_permit`"
  dimensions:
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction of the permit"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant associated with the permit"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority issuing the permit"
    - name: "permit_type"
      expr: permit_type
      comment: "Type of environmental permit"
    - name: "environmental_permit_status"
      expr: environmental_permit_status
      comment: "Current status of the permit"
    - name: "is_exempt"
      expr: is_exempt
      comment: "Indicates if the permit is exempt from certain requirements"
  measures:
    - name: "permit_count"
      expr: COUNT(1)
      comment: "Total number of environmental permits"
    - name: "non_exempt_permit_count"
      expr: SUM(CASE WHEN is_exempt = FALSE THEN 1 ELSE 0 END)
      comment: "Count of permits that are not exempt"
    - name: "avg_pollutant_limit"
      expr: AVG(CAST(pollutant_limit_value AS DOUBLE))
      comment: "Average pollutant limit value across permits"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`compliance_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test result KPIs to assess quality and compliance of emissions testing."
  source: "`automotive_ecm`.`compliance`.`compliance_test_result`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the test was performed"
    - name: "lab_location_code"
      expr: lab_location_code
      comment: "Code of the laboratory location"
    - name: "test_phase"
      expr: test_phase
      comment: "Phase of the testing process"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Result status of the test (Pass/Fail)"
    - name: "is_outlier"
      expr: is_outlier
      comment: "Flag indicating if the result is an outlier"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the recorded value"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of compliance test results recorded"
    - name: "passed_tests"
      expr: SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of tests that passed"
    - name: "failed_tests"
      expr: SUM(CASE WHEN pass_fail_status = 'Fail' THEN 1 ELSE 0 END)
      comment: "Count of tests that failed"
    - name: "outlier_count"
      expr: SUM(CASE WHEN is_outlier = TRUE THEN 1 ELSE 0 END)
      comment: "Number of test results flagged as outliers"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all tests"
$$;