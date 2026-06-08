-- Metric views for domain: quality | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_audit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit execution and timeliness metrics for executive quality oversight"
  source: "`semiconductors_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Internal, External)"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (e.g., Process, Product)"
    - name: "audit_month"
      expr: DATE_TRUNC('month', record_audit_created)
      comment: "Month of audit record creation"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits recorded"
    - name: "completed_audit_count"
      expr: SUM(CASE WHEN audit_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of audits that reached Completed status"
    - name: "average_audit_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average duration of audits in days"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key yield and defect density metrics for wafer production"
  source: "`semiconductors_ecm`.`quality`.`yield_record`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for the product"
    - name: "wafer_id"
      expr: wafer_id
      comment: "Wafer identifier"
    - name: "inspection_lot_id"
      expr: inspection_lot_id
      comment: "Associated inspection lot identifier"
    - name: "production_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record creation"
  measures:
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total number of dies processed"
    - name: "good_die_count"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total number of good (non-defective) dies"
    - name: "average_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across records"
    - name: "average_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per cm²"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint volume and resolution performance"
  source: "`semiconductors_ecm`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Category of the complaint"
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the complaint"
    - name: "complaint_month"
      expr: DATE_TRUNC('month', complaint_timestamp)
      comment: "Month when the complaint was logged"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints recorded"
    - name: "closed_complaints"
      expr: SUM(CASE WHEN status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of complaints that have been closed"
    - name: "average_resolution_days"
      expr: AVG(DATEDIFF(resolution_date, complaint_timestamp))
      comment: "Average time to resolve a complaint in days"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_capa_effectiveness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA creation and closure efficiency metrics for quality improvement"
  source: "`semiconductors_ecm`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of corrective action (e.g., Process, Design)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the CAPA"
    - name: "priority"
      expr: priority
      comment: "Priority of the CAPA"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the CAPA record was created"
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of CAPA records created"
    - name: "closed_capa_records"
      expr: SUM(CASE WHEN capa_record_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of CAPA records that have been closed"
    - name: "average_time_to_close_days"
      expr: AVG(DATEDIFF(closure_date, created_timestamp))
      comment: "Average number of days from CAPA creation to closure"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity and scoring metrics for governance oversight"
  source: "`semiconductors_ecm`.`quality`.`quality_audit_finding`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Internal, Supplier)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding"
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the finding (e.g., Non‑conformance, Observation)"
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month when the audit finding was recorded"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings classified as High severity"
    - name: "average_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across findings"
$$;