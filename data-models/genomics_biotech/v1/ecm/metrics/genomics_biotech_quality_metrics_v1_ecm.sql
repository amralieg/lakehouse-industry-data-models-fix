-- Metric views for domain: quality | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core audit performance and compliance metrics"
  source: "`genomics_biotech_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month of the audit based on actual start date"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type/category of the audit"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit"
    - name: "department_scope"
      expr: department_scope
      comment: "Department scope of the audit"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit records"
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of audits in hours"
    - name: "audits_with_follow_up"
      expr: SUM(CASE WHEN follow_up_required_flag THEN 1 ELSE 0 END)
      comment: "Count of audits that require follow‑up actions"
    - name: "passed_audits"
      expr: SUM(CASE WHEN outcome = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of audits with a passing outcome"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding effectiveness and risk metrics"
  source: "`genomics_biotech_ecm`.`quality`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the finding"
    - name: "gxp_impact_flag"
      expr: gxp_impact_flag
      comment: "Whether the finding impacts GxP compliance"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "findings_with_gxp_impact"
      expr: SUM(CASE WHEN gxp_impact_flag THEN 1 ELSE 0 END)
      comment: "Count of findings that have GxP impact"
    - name: "avg_time_to_closure_days"
      expr: AVG(DATEDIFF(closure_date, identified_date))
      comment: "Average days from identification to closure of findings"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) performance metrics"
  source: "`genomics_biotech_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA"
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the CAPA was initiated"
  measures:
    - name: "total_capa"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "closed_capa"
      expr: SUM(CASE WHEN closed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of CAPA records that have been closed"
    - name: "avg_time_to_close_days"
      expr: AVG(DATEDIFF(closed_date, initiated_date))
      comment: "Average days from CAPA initiation to closure"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non‑conformance financial and regulatory impact metrics"
  source: "`genomics_biotech_ecm`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the non‑conformance"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the non‑conformance is regulatory reportable"
    - name: "detection_source"
      expr: detection_source
      comment: "Source of detection for the non‑conformance"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detected_date)
      comment: "Month the non‑conformance was detected"
  measures:
    - name: "total_nonconformance"
      expr: COUNT(1)
      comment: "Total number of non‑conformance records"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Sum of financial impact amounts for non‑conformances"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reportable_flag THEN 1 ELSE 0 END)
      comment: "Count of non‑conformances that are regulatory reportable"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_qc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control result performance metrics"
  source: "`genomics_biotech_ecm`.`quality`.`qc_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of test performed"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the test result"
    - name: "out_of_specification_flag"
      expr: out_of_specification_flag
      comment: "Flag indicating result is out of specification"
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month the test was performed"
  measures:
    - name: "total_qc_results"
      expr: COUNT(1)
      comment: "Total number of QC result records"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across QC results"
    - name: "out_of_specification_count"
      expr: SUM(CASE WHEN out_of_specification_flag THEN 1 ELSE 0 END)
      comment: "Count of QC results flagged as out of specification"
$$;