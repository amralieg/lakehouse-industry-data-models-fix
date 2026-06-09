-- Metric views for domain: compliance | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit performance and compliance metrics"
  source: "`ecommerce_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type/category of the audit"
    - name: "audit_category"
      expr: audit_category
      comment: "Higher‑level audit category"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the audit"
    - name: "ccpa_compliance_flag"
      expr: ccpa_compliance_flag
      comment: "Boolean flag indicating CCPA compliance"
    - name: "gdpr_compliance_flag"
      expr: gdpr_compliance_flag
      comment: "Boolean flag indicating GDPR compliance"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit"
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start)
      comment: "Month of the audit period start"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit records"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Sum of audit cost amounts"
    - name: "average_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit"
    - name: "approved_audit_count"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of audits with approval status = Approved"
    - name: "ccpa_compliant_audit_count"
      expr: SUM(CASE WHEN ccpa_compliance_flag THEN 1 ELSE 0 END)
      comment: "Count of audits flagged as CCPA compliant"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`compliance_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control effectiveness and risk metrics"
  source: "`ecommerce_ecm`.`compliance`.`control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current lifecycle status of the control"
    - name: "control_type"
      expr: control_type
      comment: "Technical or procedural type of the control"
    - name: "control_category"
      expr: control_category
      comment: "Business category of the control"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification"
    - name: "owner"
      expr: owner
      comment: "Owner responsible for the control"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month when the control became effective"
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of control records"
    - name: "active_control_count"
      expr: SUM(CASE WHEN control_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of controls currently active"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across controls"
    - name: "automated_control_count"
      expr: SUM(CASE WHEN automation_flag THEN 1 ELSE 0 END)
      comment: "Count of controls flagged as automated"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding quality and risk metrics"
  source: "`ecommerce_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating assigned to the finding"
    - name: "priority"
      expr: priority
      comment: "Priority level of the finding"
    - name: "finding_type"
      expr: finding_type
      comment: "Type/category of the finding"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction associated with the finding"
    - name: "finding_created_month"
      expr: DATE_TRUNC('month', finding_created_timestamp)
      comment: "Month the finding was created"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "high_severity_finding_count"
      expr: SUM(CASE WHEN severity_rating = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings with high severity"
    - name: "average_finding_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of findings"
    - name: "closed_finding_count"
      expr: SUM(CASE WHEN audit_finding_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of findings that are closed"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`compliance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic compliance program performance metrics"
  source: "`ecommerce_ecm`.`compliance`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the program"
    - name: "program_type"
      expr: program_type
      comment: "Type of compliance program"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction of the program"
    - name: "owner"
      expr: owner
      comment: "Program owner or sponsor"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the program became effective"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of compliance programs"
    - name: "compliant_program_count"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of programs with compliance status = Compliant"
    - name: "average_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across programs"
    - name: "total_program_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to programs"
$$;