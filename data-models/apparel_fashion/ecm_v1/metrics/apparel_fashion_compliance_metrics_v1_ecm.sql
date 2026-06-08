-- Metric views for domain: compliance | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit performance metrics tracking audit completion, findings severity, compliance scores, and cost efficiency across factories, suppliers, and regulatory programs"
  source: "`apparel_fashion_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted (social, environmental, quality, safety)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in-progress, completed, closed)"
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Organization conducting the audit"
    - name: "program"
      expr: program
      comment: "Compliance program or standard being audited against"
    - name: "region"
      expr: region
      comment: "Geographic region of the audited facility"
    - name: "country_code"
      expr: country_code
      comment: "Country where audit was conducted"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the audit (low, medium, high, critical)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating or grade"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status resulting from audit"
    - name: "approved_for_production_flag"
      expr: approved_for_production_flag
      comment: "Whether facility is approved for production based on audit results"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective actions are required"
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit is required"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year the audit was conducted"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(audit_date))
      comment: "Quarter the audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month the audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all audits in local currencies"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per audit"
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all audits - key performance indicator for supplier quality"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score - primary metric for audit performance"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total count of critical findings across all audits - highest severity issues requiring immediate action"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total count of major findings - significant compliance gaps"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total count of minor findings - lower severity issues"
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action plans"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action - indicator of supplier compliance quality"
    - name: "audits_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up audits"
    - name: "follow_up_audit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up - measure of initial audit failure rate"
    - name: "production_approved_audits"
      expr: COUNT(CASE WHEN approved_for_production_flag = TRUE THEN 1 END)
      comment: "Number of audits resulting in production approval"
    - name: "production_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_for_production_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in production approval - key supplier qualification metric"
    - name: "distinct_factories_audited"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique production facilities audited"
    - name: "distinct_suppliers_audited"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique suppliers audited"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit finding metrics tracking issue severity, remediation progress, financial impact, and closure rates to drive corrective action effectiveness"
  source: "`apparel_fashion_ecm`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (critical, major, minor)"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of compliance finding (labor, safety, environmental, quality)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in-progress, closed, verified)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of remediation actions"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation for the finding"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether finding must be reported to regulatory authorities"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring finding"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority relevant to the finding"
    - name: "affected_product_category"
      expr: affected_product_category
      comment: "Product category impacted by the finding"
    - name: "finding_year"
      expr: YEAR(finding_date)
      comment: "Year the finding was identified"
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_date)
      comment: "Month the finding was identified"
    - name: "closure_year"
      expr: YEAR(closure_date)
      comment: "Year the finding was closed"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of compliance audit findings"
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost to remediate all findings - key financial exposure metric"
    - name: "avg_remediation_cost"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average remediation cost per finding"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across findings - composite risk indicator"
    - name: "closed_findings"
      expr: COUNT(CASE WHEN finding_status = 'closed' THEN 1 END)
      comment: "Number of findings that have been closed"
    - name: "finding_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status = 'closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings closed - key remediation effectiveness metric"
    - name: "verified_findings"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Number of findings with verified remediation"
    - name: "verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings with verified remediation - quality of corrective action metric"
    - name: "recurring_findings"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring findings"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurring - indicator of systemic compliance issues"
    - name: "regulatory_reportable_findings"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Number of findings requiring regulatory reporting"
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring regulatory reporting - regulatory exposure indicator"
    - name: "distinct_factories_with_findings"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique factories with compliance findings"
    - name: "distinct_suppliers_with_findings"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique suppliers with compliance findings"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan effectiveness metrics tracking completion rates, cost, escalation, and on-time delivery to drive compliance remediation performance"
  source: "`apparel_fashion_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Current status of the corrective action plan"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the issue being addressed"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of compliance issue (labor, safety, environmental, quality)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the CAP has been escalated"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this addresses a recurring issue"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required as part of remediation"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for executing the CAP"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the compliance issue"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the issue"
    - name: "product_category"
      expr: product_category
      comment: "Product category affected by the issue"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year the CAP is targeted for completion"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the CAP is targeted for completion"
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of all corrective action plans - financial commitment to compliance remediation"
    - name: "avg_cap_cost"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average cost per corrective action plan"
    - name: "completed_caps"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of corrective action plans completed"
    - name: "cap_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs completed - primary remediation effectiveness metric"
    - name: "on_time_caps"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL AND actual_completion_date <= target_completion_date THEN 1 END)
      comment: "Number of CAPs completed on or before target date"
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL AND actual_completion_date <= target_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed CAPs delivered on time - execution quality metric"
    - name: "escalated_caps"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of corrective action plans that have been escalated"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs requiring escalation - indicator of remediation difficulty"
    - name: "recurring_issue_caps"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of CAPs addressing recurring issues"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs for recurring issues - systemic compliance problem indicator"
    - name: "training_required_caps"
      expr: COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END)
      comment: "Number of CAPs requiring training"
    - name: "training_completed_caps"
      expr: COUNT(CASE WHEN training_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of CAPs with training completed"
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required training completed - capability building metric"
    - name: "verified_caps"
      expr: COUNT(CASE WHEN verification_date IS NOT NULL THEN 1 END)
      comment: "Number of CAPs with verified remediation"
    - name: "verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs with verified remediation - quality assurance metric"
    - name: "distinct_factories_with_caps"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique factories with corrective action plans"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_product_safety_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product safety testing metrics tracking pass rates, failure reasons, remediation requirements, and testing costs to ensure regulatory compliance and consumer safety"
  source: "`apparel_fashion_ecm`.`compliance`.`product_safety_test`"
  dimensions:
    - name: "test_result"
      expr: test_result
      comment: "Result of the safety test (pass, fail, conditional)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test (scheduled, in-progress, completed, cancelled)"
    - name: "test_type"
      expr: test_type
      comment: "Type of safety test conducted"
    - name: "test_standard"
      expr: test_standard
      comment: "Safety standard or regulation being tested against"
    - name: "product_category"
      expr: product_category
      comment: "Category of product being tested"
    - name: "age_group"
      expr: age_group
      comment: "Target age group for the product (adult, children, infant)"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction requiring the test"
    - name: "testing_laboratory_name"
      expr: testing_laboratory_name
      comment: "Name of the laboratory conducting the test"
    - name: "certification_required"
      expr: certification_required
      comment: "Whether certification is required based on test results"
    - name: "remediation_required"
      expr: remediation_required
      comment: "Whether remediation is required for failed tests"
    - name: "retest_required"
      expr: retest_required
      comment: "Whether retesting is required"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the product being tested"
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year the test was conducted"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was conducted"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of product safety tests conducted"
    - name: "total_test_cost"
      expr: SUM(CAST(test_cost AS DOUBLE))
      comment: "Total cost of all product safety testing - compliance investment metric"
    - name: "avg_test_cost"
      expr: AVG(CAST(test_cost AS DOUBLE))
      comment: "Average cost per safety test"
    - name: "passed_tests"
      expr: COUNT(CASE WHEN test_result = 'pass' THEN 1 END)
      comment: "Number of tests that passed"
    - name: "test_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests passed - primary product safety quality metric"
    - name: "failed_tests"
      expr: COUNT(CASE WHEN test_result = 'fail' THEN 1 END)
      comment: "Number of tests that failed"
    - name: "test_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'fail' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests failed - product safety risk indicator"
    - name: "tests_requiring_remediation"
      expr: COUNT(CASE WHEN remediation_required = TRUE THEN 1 END)
      comment: "Number of tests requiring remediation"
    - name: "remediation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests requiring remediation - corrective action burden metric"
    - name: "tests_requiring_retest"
      expr: COUNT(CASE WHEN retest_required = TRUE THEN 1 END)
      comment: "Number of tests requiring retesting"
    - name: "retest_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests requiring retest - first-time quality failure indicator"
    - name: "tests_requiring_certification"
      expr: COUNT(CASE WHEN certification_required = TRUE THEN 1 END)
      comment: "Number of tests requiring certification"
    - name: "distinct_styles_tested"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles tested"
    - name: "distinct_skus_tested"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs tested"
    - name: "distinct_materials_tested"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials tested"
    - name: "distinct_factories_tested"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique factories with products tested"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance incident metrics tracking severity, financial impact, regulatory notification requirements, and closure rates to manage compliance risk and regulatory exposure"
  source: "`apparel_fashion_ecm`.`compliance`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of compliance incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework violated or at risk"
    - name: "affected_jurisdiction"
      expr: affected_jurisdiction
      comment: "Legal jurisdiction affected by the incident"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority with jurisdiction over the incident"
    - name: "identification_source"
      expr: identification_source
      comment: "Source that identified the incident (internal audit, customer complaint, regulatory inspection)"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "public_disclosure_required"
      expr: public_disclosure_required
      comment: "Whether public disclosure is required"
    - name: "escalated_to_executive"
      expr: escalated_to_executive
      comment: "Whether incident was escalated to executive leadership"
    - name: "recurrence_indicator"
      expr: recurrence_indicator
      comment: "Whether this is a recurring incident"
    - name: "affected_business_unit"
      expr: affected_business_unit
      comment: "Business unit affected by the incident"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the incident was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the incident was identified"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of all incidents - compliance risk exposure metric"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per incident"
    - name: "total_actual_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Total actual penalties paid for compliance incidents - realized compliance cost"
    - name: "avg_actual_penalty"
      expr: AVG(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Average penalty amount per incident"
    - name: "total_affected_individuals"
      expr: SUM(CAST(affected_individuals_count AS DOUBLE))
      comment: "Total number of individuals affected by compliance incidents"
    - name: "closed_incidents"
      expr: COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END)
      comment: "Number of incidents that have been closed"
    - name: "incident_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents closed - incident resolution effectiveness metric"
    - name: "regulatory_notification_incidents"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring regulatory notification"
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring regulatory notification - regulatory exposure indicator"
    - name: "notified_incidents"
      expr: COUNT(CASE WHEN regulatory_notification_date IS NOT NULL THEN 1 END)
      comment: "Number of incidents where regulatory notification was completed"
    - name: "regulatory_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required notifications completed - regulatory compliance metric"
    - name: "public_disclosure_incidents"
      expr: COUNT(CASE WHEN public_disclosure_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring public disclosure"
    - name: "executive_escalation_incidents"
      expr: COUNT(CASE WHEN escalated_to_executive = TRUE THEN 1 END)
      comment: "Number of incidents escalated to executive leadership"
    - name: "executive_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_to_executive = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents escalated to executives - severity and materiality indicator"
    - name: "recurring_incidents"
      expr: COUNT(CASE WHEN recurrence_indicator = TRUE THEN 1 END)
      comment: "Number of recurring incidents"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are recurring - systemic compliance problem indicator"
    - name: "distinct_factories_with_incidents"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique factories with compliance incidents"
    - name: "distinct_suppliers_with_incidents"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique suppliers with compliance incidents"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics tracking submission timeliness, approval rates, non-conformances, and renewal requirements to ensure regulatory compliance and minimize filing risk"
  source: "`apparel_fashion_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (draft, submitted, approved, rejected)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the filing"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the filing"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body receiving the filing"
    - name: "compliance_level"
      expr: compliance_level
      comment: "Level of compliance achieved"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification of the filing"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the filing"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether renewal is required"
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by the filing"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for products in the filing"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the filing was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the filing was submitted"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "total_filing_cost"
      expr: SUM(CAST(filing_cost AS DOUBLE))
      comment: "Total cost of all regulatory filings - compliance administrative burden metric"
    - name: "avg_filing_cost"
      expr: AVG(CAST(filing_cost AS DOUBLE))
      comment: "Average cost per regulatory filing"
    - name: "total_non_conformances"
      expr: SUM(CAST(non_conformance_count AS DOUBLE))
      comment: "Total number of non-conformances across all filings"
    - name: "avg_non_conformances_per_filing"
      expr: AVG(CAST(non_conformance_count AS DOUBLE))
      comment: "Average number of non-conformances per filing - filing quality metric"
    - name: "approved_filings"
      expr: COUNT(CASE WHEN filing_status = 'approved' THEN 1 END)
      comment: "Number of filings that have been approved"
    - name: "filing_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings approved - regulatory compliance success metric"
    - name: "rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Number of filings that were rejected"
    - name: "filing_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings rejected - regulatory compliance failure indicator"
    - name: "on_time_filings"
      expr: COUNT(CASE WHEN submission_date IS NOT NULL AND submission_date <= due_date THEN 1 END)
      comment: "Number of filings submitted on or before due date"
    - name: "on_time_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date IS NOT NULL AND submission_date <= due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of filings submitted on time - regulatory deadline compliance metric"
    - name: "filings_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of filings requiring corrective action"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings requiring corrective action - filing quality issue indicator"
    - name: "filings_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of filings requiring renewal"
    - name: "distinct_factories_in_filings"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique factories covered in regulatory filings"
    - name: "distinct_suppliers_in_filings"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique suppliers covered in regulatory filings"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation management metrics tracking active obligations, completion rates, SLA breaches, and risk levels to ensure regulatory and policy adherence"
  source: "`apparel_fashion_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (regulatory, contractual, policy)"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the obligation"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory or governing body imposing the obligation"
    - name: "applicable_business_process"
      expr: applicable_business_process
      comment: "Business process to which the obligation applies"
    - name: "applicable_product_category"
      expr: applicable_product_category
      comment: "Product category to which the obligation applies"
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for fulfilling the obligation"
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the obligation has breached its SLA"
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency at which the obligation must be reviewed"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective"
    - name: "filing_deadline_year"
      expr: YEAR(filing_deadline)
      comment: "Year of the filing deadline"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active obligations"
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations - compliance risk exposure metric"
    - name: "avg_maximum_penalty"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation"
    - name: "completed_obligations"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of obligations completed"
    - name: "obligation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations completed - compliance fulfillment metric"
    - name: "on_time_obligations"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL AND actual_completion_date <= planned_completion_date THEN 1 END)
      comment: "Number of obligations completed on or before planned date"
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL AND actual_completion_date <= planned_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of obligations completed on time - compliance timeliness metric"
    - name: "sla_breached_obligations"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of obligations that have breached their SLA"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations breaching SLA - compliance performance risk indicator"
    - name: "obligations_with_audit_scheduled"
      expr: COUNT(CASE WHEN audit_scheduled_date IS NOT NULL THEN 1 END)
      comment: "Number of obligations with audits scheduled"
    - name: "obligations_with_certification_renewal"
      expr: COUNT(CASE WHEN certification_renewal_date IS NOT NULL THEN 1 END)
      comment: "Number of obligations requiring certification renewal"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`compliance_trade_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade compliance metrics tracking duty optimization, preferential trade program utilization, classification accuracy, and landed cost to minimize import costs and ensure customs compliance"
  source: "`apparel_fashion_ecm`.`compliance`.`trade_compliance_record`"
  dimensions:
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the product"
    - name: "hs_code"
      expr: hs_code
      comment: "Harmonized System tariff classification code"
    - name: "trade_agreement_code"
      expr: trade_agreement_code
      comment: "Trade agreement code for preferential duty treatment"
    - name: "trade_lane_code"
      expr: trade_lane_code
      comment: "Trade lane identifier"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Trade compliance status of the record"
    - name: "classification_method"
      expr: classification_method
      comment: "Method used for tariff classification"
    - name: "coo_determination_method"
      expr: coo_determination_method
      comment: "Method used to determine country of origin"
    - name: "gsp_eligible_flag"
      expr: gsp_eligible_flag
      comment: "Whether product is eligible for Generalized System of Preferences"
    - name: "gsp_beneficiary_country"
      expr: gsp_beneficiary_country
      comment: "GSP beneficiary country if applicable"
    - name: "antidumping_duty_flag"
      expr: antidumping_duty_flag
      comment: "Whether antidumping duties apply"
    - name: "countervailing_duty_flag"
      expr: countervailing_duty_flag
      comment: "Whether countervailing duties apply"
    - name: "quota_applicable_flag"
      expr: quota_applicable_flag
      comment: "Whether import quotas apply"
    - name: "sanctioned_country_flag"
      expr: sanctioned_country_flag
      comment: "Whether country is under trade sanctions"
    - name: "export_license_required_flag"
      expr: export_license_required_flag
      comment: "Whether export license is required"
    - name: "certificate_of_origin_required_flag"
      expr: certificate_of_origin_required_flag
      comment: "Whether certificate of origin is required"
    - name: "duty_optimization_strategy"
      expr: duty_optimization_strategy
      comment: "Strategy used for duty optimization"
    - name: "restricted_party_screening_status"
      expr: restricted_party_screening_status
      comment: "Status of restricted party screening"
    - name: "classification_year"
      expr: YEAR(classification_date)
      comment: "Year the classification was performed"
  measures:
    - name: "total_trade_records"
      expr: COUNT(1)
      comment: "Total number of trade compliance records"
    - name: "total_landed_duty_paid"
      expr: SUM(CAST(landed_duty_paid_amount AS DOUBLE))
      comment: "Total landed duty paid amount - total import duty cost"
    - name: "avg_landed_duty_paid"
      expr: AVG(CAST(landed_duty_paid_amount AS DOUBLE))
      comment: "Average landed duty paid per record"
    - name: "avg_import_duty_rate"
      expr: AVG(CAST(import_duty_rate AS DOUBLE))
      comment: "Average import duty rate across all records"
    - name: "avg_preferential_duty_rate"
      expr: AVG(CAST(preferential_duty_rate AS DOUBLE))
      comment: "Average preferential duty rate for eligible products"
    - name: "gsp_eligible_records"
      expr: COUNT(CASE WHEN gsp_eligible_flag = TRUE THEN 1 END)
      comment: "Number of records eligible for GSP preferential treatment"
    - name: "gsp_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gsp_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records utilizing GSP - duty savings opportunity metric"
    - name: "antidumping_duty_records"
      expr: COUNT(CASE WHEN antidumping_duty_flag = TRUE THEN 1 END)
      comment: "Number of records subject to antidumping duties"
    - name: "antidumping_exposure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN antidumping_duty_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records subject to antidumping duties - trade penalty exposure"
    - name: "countervailing_duty_records"
      expr: COUNT(CASE WHEN countervailing_duty_flag = TRUE THEN 1 END)
      comment: "Number of records subject to countervailing duties"
    - name: "quota_applicable_records"
      expr: COUNT(CASE WHEN quota_applicable_flag = TRUE THEN 1 END)
      comment: "Number of records subject to import quotas"
    - name: "sanctioned_country_records"
      expr: COUNT(CASE WHEN sanctioned_country_flag = TRUE THEN 1 END)
      comment: "Number of records from sanctioned countries"
    - name: "sanctioned_country_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctioned_country_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records from sanctioned countries - trade compliance risk indicator"
    - name: "export_license_required_records"
      expr: COUNT(CASE WHEN export_license_required_flag = TRUE THEN 1 END)
      comment: "Number of records requiring export licenses"
    - name: "certificate_of_origin_required_records"
      expr: COUNT(CASE WHEN certificate_of_origin_required_flag = TRUE THEN 1 END)
      comment: "Number of records requiring certificate of origin"
    - name: "distinct_hs_codes"
      expr: COUNT(DISTINCT hs_code)
      comment: "Number of unique HS codes in trade records"
    - name: "distinct_origin_countries"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of unique countries of origin"
    - name: "distinct_trade_lanes"
      expr: COUNT(DISTINCT trade_lane_code)
      comment: "Number of unique trade lanes"
    - name: "distinct_styles_in_trade"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles in trade compliance records"
$$;