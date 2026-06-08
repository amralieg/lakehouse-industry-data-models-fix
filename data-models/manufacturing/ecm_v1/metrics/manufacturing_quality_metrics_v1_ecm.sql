-- Metric views for domain: quality | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA effectiveness and timeliness"
  source: "`manufacturing_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., Open, Closed)"
  measures:
    - name: "total_capa"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint volume and resolution"
  source: "`manufacturing_ecm`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type/category of the complaint"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to the complaint"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the complaint"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the complaint"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result quality metrics"
  source: "`manufacturing_ecm`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Overall status of the inspection result"
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic inspected"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where inspection took place"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for the inspection"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which inspection was performed"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection results recorded"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP submission quality and safety metrics"
  source: "`manufacturing_ecm`.`quality`.`ppap_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the PPAP submission"
    - name: "submission_level"
      expr: submission_level
      comment: "Level of PPAP submission (e.g., Level 1, Level 2)"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the PPAP submission"
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total number of PPAP submissions"
$$;