-- Metric views for domain: quality | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality inspection metrics tracking pass/fail rates, defect volumes, and inspection coverage across products, suppliers, and quality gates"
  source: "`apparel_fashion_ecm`.`quality`.`inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date the inspection was performed"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., pre-production, inline, final)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "pass_fail_outcome"
      expr: pass_fail_outcome
      comment: "Final pass or fail outcome of the inspection"
    - name: "stage"
      expr: stage
      comment: "Production stage at which inspection occurred"
    - name: "product_category"
      expr: product_category
      comment: "Product category being inspected"
    - name: "aql_level"
      expr: aql_level
      comment: "Acceptable Quality Limit level applied"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision (accept, reject, rework, conditional)"
    - name: "agency"
      expr: agency
      comment: "Third-party inspection agency if applicable"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Whether a quality hold was triggered"
    - name: "capa_triggered"
      expr: capa_triggered
      comment: "Whether corrective and preventive action was triggered"
    - name: "lab_test_required"
      expr: lab_test_required
      comment: "Whether lab testing is required"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections performed"
    - name: "total_units_inspected"
      expr: SUM(CAST(units_inspected AS DOUBLE))
      comment: "Total units inspected across all inspections"
    - name: "total_defects_found"
      expr: SUM(CAST(total_defects_found AS DOUBLE))
      comment: "Total defects identified across all inspections"
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defects_found AS DOUBLE))
      comment: "Total critical defects found"
    - name: "total_major_defects"
      expr: SUM(CAST(major_defects_found AS DOUBLE))
      comment: "Total major defects found"
    - name: "total_minor_defects"
      expr: SUM(CAST(minor_defects_found AS DOUBLE))
      comment: "Total minor defects found"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_outcome = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of inspections that passed"
    - name: "fail_count"
      expr: SUM(CASE WHEN pass_fail_outcome = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of inspections that failed"
    - name: "hold_triggered_count"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections that triggered a quality hold"
    - name: "capa_triggered_count"
      expr: SUM(CASE WHEN capa_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections that triggered corrective action"
    - name: "defect_rate_per_unit"
      expr: SUM(CAST(total_defects_found AS DOUBLE)) / NULLIF(SUM(CAST(units_inspected AS DOUBLE)), 0)
      comment: "Average defects per unit inspected (defect density)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_non_conformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-conformance tracking metrics measuring quality failures, financial impact, closure rates, and root cause patterns"
  source: "`apparel_fashion_ecm`.`quality`.`non_conformance`"
  dimensions:
    - name: "detection_date"
      expr: detection_date
      comment: "Date the non-conformance was detected"
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current status of the non-conformance report"
    - name: "non_conformance_category"
      expr: non_conformance_category
      comment: "Category of non-conformance"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the non-conformance"
    - name: "detected_at_stage"
      expr: detected_at_stage
      comment: "Production or supply chain stage where detected"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision (scrap, rework, use-as-is, return)"
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause category"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the non-conformance"
    - name: "customer_impact_flag"
      expr: customer_impact_flag
      comment: "Whether the non-conformance impacted customers"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial impact"
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of non-conformance reports"
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of units affected by non-conformances"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of non-conformances"
    - name: "avg_financial_impact_per_ncr"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per non-conformance"
    - name: "closed_ncr_count"
      expr: SUM(CASE WHEN ncr_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of closed non-conformance reports"
    - name: "open_ncr_count"
      expr: SUM(CASE WHEN ncr_status IN ('Open', 'In Progress') THEN 1 ELSE 0 END)
      comment: "Number of open or in-progress non-conformance reports"
    - name: "customer_impact_ncr_count"
      expr: SUM(CASE WHEN customer_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of non-conformances that impacted customers"
    - name: "recurring_ncr_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recurring non-conformances"
    - name: "critical_severity_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity non-conformances"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness metrics tracking closure rates, cycle time, cost impact, and recurrence prevention"
  source: "`apparel_fashion_ecm`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level"
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used for root cause analysis"
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of corrective action verification"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for action"
    - name: "quality_gate_stage"
      expr: quality_gate_stage
      comment: "Quality gate stage associated with the action"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether the issue recurred after corrective action"
    - name: "affected_product_category"
      expr: affected_product_category
      comment: "Product category affected"
    - name: "target_completion_date"
      expr: target_completion_date
      comment: "Target date for completion"
    - name: "actual_completion_date"
      expr: actual_completion_date
      comment: "Actual completion date"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions"
    - name: "total_cost_of_quality_impact"
      expr: SUM(CAST(cost_of_quality_impact AS DOUBLE))
      comment: "Total cost of quality impact from corrective actions"
    - name: "avg_cost_of_quality_impact"
      expr: AVG(CAST(cost_of_quality_impact AS DOUBLE))
      comment: "Average cost of quality impact per corrective action"
    - name: "closed_action_count"
      expr: SUM(CASE WHEN corrective_action_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of closed corrective actions"
    - name: "open_action_count"
      expr: SUM(CASE WHEN corrective_action_status IN ('Open', 'In Progress') THEN 1 ELSE 0 END)
      comment: "Number of open or in-progress corrective actions"
    - name: "overdue_action_count"
      expr: SUM(CASE WHEN corrective_action_status != 'Closed' AND target_completion_date < CURRENT_DATE THEN 1 ELSE 0 END)
      comment: "Number of overdue corrective actions"
    - name: "recurrence_count_total"
      expr: SUM(CAST(recurrence_count AS DOUBLE))
      comment: "Total recurrence count across all corrective actions"
    - name: "actions_with_recurrence"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of corrective actions where issue recurred"
    - name: "verified_effective_count"
      expr: SUM(CASE WHEN verification_outcome = 'Effective' THEN 1 ELSE 0 END)
      comment: "Number of corrective actions verified as effective"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab testing metrics tracking test volumes, pass rates, compliance, cost, and cycle time for material and product validation"
  source: "`apparel_fashion_ecm`.`quality`.`lab_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of lab test performed"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall test result (pass, fail, conditional)"
    - name: "test_purpose"
      expr: test_purpose
      comment: "Purpose of the test"
    - name: "lab_name"
      expr: lab_name
      comment: "Name of the testing laboratory"
    - name: "lab_location"
      expr: lab_location
      comment: "Location of the testing laboratory"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether test is for regulatory compliance"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required based on test results"
    - name: "market_destination"
      expr: market_destination
      comment: "Target market for the tested product"
    - name: "test_priority"
      expr: test_priority
      comment: "Priority level of the test"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the tested product"
    - name: "test_request_date"
      expr: test_request_date
      comment: "Date the test was requested"
    - name: "test_completion_date"
      expr: test_completion_date
      comment: "Date the test was completed"
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total number of lab tests performed"
    - name: "total_test_cost"
      expr: SUM(CAST(test_cost_amount AS DOUBLE))
      comment: "Total cost of lab testing"
    - name: "avg_test_cost"
      expr: AVG(CAST(test_cost_amount AS DOUBLE))
      comment: "Average cost per lab test"
    - name: "pass_count"
      expr: SUM(CASE WHEN overall_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of tests that passed"
    - name: "fail_count"
      expr: SUM(CASE WHEN overall_result = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of tests that failed"
    - name: "completed_test_count"
      expr: SUM(CASE WHEN test_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of completed tests"
    - name: "in_progress_test_count"
      expr: SUM(CASE WHEN test_status = 'In Progress' THEN 1 ELSE 0 END)
      comment: "Number of tests currently in progress"
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tests requiring remediation"
    - name: "regulatory_compliance_test_count"
      expr: SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of regulatory compliance tests"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold metrics tracking hold volumes, duration, financial impact, and disposition outcomes to measure supply chain disruption"
  source: "`apparel_fashion_ecm`.`quality`.`quality_hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold"
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for held inventory"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where hold is applied"
    - name: "location_code"
      expr: location_code
      comment: "Specific location code"
    - name: "factory_name"
      expr: factory_name
      comment: "Factory name if hold is at production facility"
    - name: "supplier_code"
      expr: supplier_code
      comment: "Supplier code"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for held goods"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether reinspection is required"
    - name: "reinspection_result"
      expr: reinspection_result
      comment: "Result of reinspection if performed"
    - name: "initiation_date"
      expr: initiation_date
      comment: "Date the hold was initiated"
    - name: "release_date"
      expr: release_date
      comment: "Date the hold was released"
  measures:
    - name: "total_quality_holds"
      expr: COUNT(1)
      comment: "Total number of quality holds"
    - name: "total_quantity_on_hold"
      expr: SUM(CAST(quantity_on_hold AS DOUBLE))
      comment: "Total quantity of units on quality hold"
    - name: "total_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of quality holds"
    - name: "avg_financial_impact_per_hold"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per quality hold"
    - name: "avg_hold_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of quality holds in days"
    - name: "active_hold_count"
      expr: SUM(CASE WHEN hold_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active quality holds"
    - name: "released_hold_count"
      expr: SUM(CASE WHEN hold_status = 'Released' THEN 1 ELSE 0 END)
      comment: "Number of released quality holds"
    - name: "scrapped_disposition_count"
      expr: SUM(CASE WHEN disposition_decision = 'Scrap' THEN 1 ELSE 0 END)
      comment: "Number of holds resulting in scrap disposition"
    - name: "rework_disposition_count"
      expr: SUM(CASE WHEN disposition_decision = 'Rework' THEN 1 ELSE 0 END)
      comment: "Number of holds requiring rework"
    - name: "reinspection_required_count"
      expr: SUM(CASE WHEN reinspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds requiring reinspection"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics tracking audit scores, findings, corrective action closure, and supplier/factory quality performance"
  source: "`apparel_fashion_ecm`.`quality`.`quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of quality audit"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organization conducting the audit"
    - name: "grade"
      expr: grade
      comment: "Audit grade or rating"
    - name: "supplier_approval_status"
      expr: supplier_approval_status
      comment: "Supplier approval status based on audit"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from audit"
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether certification was issued"
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether follow-up audit is required"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit"
    - name: "audit_date"
      expr: audit_date
      comment: "Date the audit was performed"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of quality audits performed"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of quality audits"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per quality audit"
    - name: "avg_audit_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average audit score across all audits"
    - name: "avg_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average audit duration in days"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total critical findings across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total minor findings across all audits"
    - name: "certification_issued_count"
      expr: SUM(CASE WHEN certification_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits resulting in certification"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring follow-up"
    - name: "completed_audit_count"
      expr: SUM(CASE WHEN audit_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of completed audits"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_fit_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fit session metrics tracking fit approval rates, pattern amendment frequency, and fit quality across styles and sizes"
  source: "`apparel_fashion_ecm`.`quality`.`fit_session`"
  dimensions:
    - name: "session_date"
      expr: session_date
      comment: "Date of the fit session"
    - name: "overall_fit_status"
      expr: overall_fit_status
      comment: "Overall fit approval status"
    - name: "fit_stage"
      expr: fit_stage
      comment: "Stage of fit evaluation (proto, SMS, PP, etc.)"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample evaluated"
    - name: "size_evaluated"
      expr: size_evaluated
      comment: "Size evaluated in the fit session"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the style"
    - name: "pattern_amendment_required"
      expr: pattern_amendment_required
      comment: "Whether pattern amendment is required"
    - name: "construction_issue_flag"
      expr: construction_issue_flag
      comment: "Whether construction issues were identified"
    - name: "measurement_variance_flag"
      expr: measurement_variance_flag
      comment: "Whether measurement variance was detected"
    - name: "next_fit_session_required"
      expr: next_fit_session_required
      comment: "Whether another fit session is required"
    - name: "fit_evaluator_team"
      expr: fit_evaluator_team
      comment: "Team conducting the fit evaluation"
  measures:
    - name: "total_fit_sessions"
      expr: COUNT(1)
      comment: "Total number of fit sessions conducted"
    - name: "approved_fit_count"
      expr: SUM(CASE WHEN overall_fit_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of fit sessions with approved status"
    - name: "rejected_fit_count"
      expr: SUM(CASE WHEN overall_fit_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Number of fit sessions with rejected status"
    - name: "pattern_amendment_required_count"
      expr: SUM(CASE WHEN pattern_amendment_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fit sessions requiring pattern amendments"
    - name: "construction_issue_count"
      expr: SUM(CASE WHEN construction_issue_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fit sessions with construction issues"
    - name: "measurement_variance_count"
      expr: SUM(CASE WHEN measurement_variance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fit sessions with measurement variance"
    - name: "next_session_required_count"
      expr: SUM(CASE WHEN next_fit_session_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fit sessions requiring follow-up"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`quality_measurement_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measurement specification compliance metrics tracking pass rates, variance, and pattern correction frequency across garment types and sizes"
  source: "`apparel_fashion_ecm`.`quality`.`measurement_spec`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date the measurement was taken"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the measurement"
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage at which measurement was taken"
    - name: "garment_type"
      expr: garment_type
      comment: "Type of garment measured"
    - name: "measurement_point_name"
      expr: measurement_point_name
      comment: "Specific measurement point on the garment"
    - name: "base_size"
      expr: base_size
      comment: "Base size for the measurement specification"
    - name: "size_range"
      expr: size_range
      comment: "Size range covered by the specification"
    - name: "product_category"
      expr: product_category
      comment: "Product category"
    - name: "season_code"
      expr: season_code
      comment: "Season code"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "fit_approval_status"
      expr: fit_approval_status
      comment: "Fit approval status based on measurements"
    - name: "quality_gate_stage"
      expr: quality_gate_stage
      comment: "Quality gate stage"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of measurements taken"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of measurements that passed"
    - name: "fail_count"
      expr: SUM(CASE WHEN pass_fail_status = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of measurements that failed"
    - name: "avg_measurement_variance"
      expr: AVG(CAST(measurement_variance AS DOUBLE))
      comment: "Average measurement variance from specification"
    - name: "avg_actual_measurement"
      expr: AVG(CAST(actual_measurement AS DOUBLE))
      comment: "Average actual measurement value"
    - name: "avg_base_size_measurement"
      expr: AVG(CAST(base_size_measurement AS DOUBLE))
      comment: "Average base size measurement"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of measurements requiring corrective action"
    - name: "fit_approved_count"
      expr: SUM(CASE WHEN fit_approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of measurements with approved fit status"
$$;