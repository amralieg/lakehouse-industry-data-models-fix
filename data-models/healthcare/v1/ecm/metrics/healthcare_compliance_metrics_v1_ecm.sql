-- Metric views for domain: compliance | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level audit activity and cost overview for executive steering"
  source: "`healthcare_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits performed"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Sum of audit costs (USD)"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit‑finding efficiency metrics for risk management"
  source: "`healthcare_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding (e.g., High, Medium, Low)"
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded"
    - name: "average_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(actual_resolution_date, identified_date) AS DOUBLE))
      comment: "Average days taken to resolve findings"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance snapshot for workforce development"
  source: "`healthcare_ecm`.`compliance`.`training_completion`"
  dimensions:
    - name: "training_id"
      expr: training_id
      comment: "Reference to the training program"
    - name: "employee_department"
      expr: employee_department
      comment: "Department of the employee"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total training completion records captured"
    - name: "completed_training_count"
      expr: SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of trainings marked as completed"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident volume and resolution speed for compliance leadership"
  source: "`healthcare_ecm`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of privacy incident"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy incidents reported"
    - name: "average_days_to_close"
      expr: AVG(CAST(DATEDIFF(closed_date, incident_date) AS DOUBLE))
      comment: "Average days from incident occurrence to closure"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of policy inventory and attestation obligations"
  source: "`healthcare_ecm`.`compliance`.`compliance_policy`"
  dimensions:
    - name: "policy_category"
      expr: policy_category
      comment: "High‑level category of the policy (e.g., Data Privacy, Security)"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of compliance policies in the catalog"
    - name: "active_policy_count"
      expr: SUM(CASE WHEN policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of policies currently active"
    - name: "policies_requiring_attestation"
      expr: SUM(CASE WHEN attestation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of policies that require employee attestation"
$$;