-- Metric views for domain: compliance | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key compliance audit finding metrics for executive oversight."
  source: "`agriculture_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "audit_area"
      expr: audit_area
      comment: "Area of the audit (e.g., Food Safety, Environmental)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., Open, Closed)."
    - name: "facility_id"
      expr: facility_id
      comment: "Identifier of the facility where the finding originated."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency overseeing the audit."
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status <> 'Closed' THEN 1 END)
      comment: "Count of audit findings that are not yet closed."
    - name: "average_days_to_close"
      expr: AVG(DATEDIFF(closure_date, identified_date))
      comment: "Average number of days between finding identification and closure for closed findings."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`compliance_violation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Violation record metrics to monitor regulatory risk and financial exposure."
  source: "`agriculture_ecm`.`compliance`.`violation_record`"
  dimensions:
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation (e.g., Pending, Resolved)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation."
    - name: "violation_type"
      expr: violation_type
      comment: "Type/category of the violation."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the violation occurred."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency that issued the violation."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of recorded violations."
    - name: "high_severity_violations"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Count of violations classified as high severity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on corrective action plans to track remediation efficiency and cost."
  source: "`agriculture_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (e.g., Open, Closed)."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility associated with the corrective action plan."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency linked to the plan."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to the corrective action."
  measures:
    - name: "total_corrective_action_plans"
      expr: COUNT(1)
      comment: "Total number of corrective action plans created."
    - name: "completed_plans_count"
      expr: COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END)
      comment: "Number of corrective action plans that have been completed (closed)."
    - name: "average_days_to_complete"
      expr: AVG(DATEDIFF(closure_date, initiated_date))
      comment: "Average duration in days from plan initiation to closure for completed plans."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Sum of estimated remediation costs across all plans."
    - name: "average_estimated_remediation_cost"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average estimated remediation cost per plan."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit portfolio metrics to manage compliance obligations and financial exposure."
  source: "`agriculture_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., Active, Expired)."
    - name: "permit_type"
      expr: permit_type
      comment: "Type/category of the permit."
    - name: "facility_id"
      expr: facility_id
      comment: "Facility to which the permit applies."
    - name: "regulatory_agency_id"
      expr: regulatory_agency_id
      comment: "Regulatory agency issuing the permit."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits on record."
    - name: "active_permits_count"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Count of permits that are currently active."
    - name: "permits_expiring_30d"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of permits expiring within the next 30 days."
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Sum of bond amounts required across all permits."
    - name: "average_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond amount per permit."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`compliance_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall event metrics to assess product safety incidents and financial risk."
  source: "`agriculture_ecm`.`compliance`.`event`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility associated with the recall event."
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of recall events recorded."
$$;