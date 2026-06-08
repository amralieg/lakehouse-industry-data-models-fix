-- Metric views for domain: compliance | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_regulatory_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for tracking regulatory violations, penalties, enforcement actions, and corrective action performance across the airline's operations"
  source: "`airlines_ecm`.`compliance`.`regulatory_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of regulatory violation (e.g., safety, operational, environmental)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the violation (e.g., critical, major, minor)"
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation case (e.g., open, under review, closed)"
    - name: "enforcement_action_type"
      expr: enforcement_action_type
      comment: "Type of enforcement action taken by the regulatory authority"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required for this violation"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal has been filed against the violation"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether the violation requires public disclosure"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year when the violation incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date), '-', YEAR(incident_date))
      comment: "Quarter when the violation incident occurred"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year when the violation was discovered"
    - name: "aircraft_registration"
      expr: aircraft_registration
      comment: "Aircraft registration number associated with the violation"
    - name: "departure_airport_code"
      expr: departure_airport_code
      comment: "Departure airport code where violation occurred"
    - name: "arrival_airport_code"
      expr: arrival_airport_code
      comment: "Arrival airport code where violation occurred"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of regulatory violations recorded"
    - name: "total_penalty_assessed"
      expr: SUM(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Total monetary penalties assessed across all violations"
    - name: "total_penalty_paid"
      expr: SUM(CAST(penalty_amount_paid AS DOUBLE))
      comment: "Total monetary penalties actually paid"
    - name: "avg_penalty_per_violation"
      expr: AVG(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Average penalty amount assessed per violation"
    - name: "outstanding_penalty_amount"
      expr: SUM(CAST(penalty_amount_assessed AS DOUBLE) - CAST(penalty_amount_paid AS DOUBLE))
      comment: "Total outstanding penalty amount not yet paid"
    - name: "violations_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations requiring corrective action"
    - name: "violations_with_appeals"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations where appeals have been filed"
    - name: "public_disclosure_violations"
      expr: SUM(CASE WHEN public_disclosure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of violations requiring public disclosure"
    - name: "avg_days_to_disposition"
      expr: AVG(DATEDIFF(disposition_date, discovery_date))
      comment: "Average number of days from discovery to final disposition"
    - name: "avg_days_discovery_to_notification"
      expr: AVG(DATEDIFF(notification_date, discovery_date))
      comment: "Average days from violation discovery to regulatory notification"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) performance metrics tracking action completion, cost, effectiveness, and risk reduction"
  source: "`airlines_ecm`.`compliance`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective or preventive action)"
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., open, in progress, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA (e.g., critical, high, medium, low)"
    - name: "risk_level_before"
      expr: risk_level_before
      comment: "Risk level before CAPA implementation"
    - name: "risk_level_after"
      expr: risk_level_after
      comment: "Risk level after CAPA implementation"
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (e.g., audit, incident, inspection)"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the CAPA is reportable to regulatory authorities"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of CAPA verification (e.g., effective, ineffective)"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion date"
    - name: "actual_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year of actual completion date"
    - name: "closure_year"
      expr: YEAR(closure_date)
      comment: "Year when CAPA was closed"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPAs recorded"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of all CAPAs in USD"
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost of all CAPAs in USD"
    - name: "avg_actual_cost_per_capa"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per CAPA in USD"
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE) - CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total cost variance between actual and estimated CAPA costs"
    - name: "capas_completed_on_time"
      expr: SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END)
      comment: "Count of CAPAs completed on or before target date"
    - name: "capas_overdue"
      expr: SUM(CASE WHEN actual_completion_date > target_completion_date THEN 1 ELSE 0 END)
      comment: "Count of CAPAs completed after target date"
    - name: "recurring_issues"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs addressing recurring issues"
    - name: "regulatory_reportable_capas"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs that are reportable to regulatory authorities"
    - name: "avg_days_to_complete"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average number of days from CAPA creation to completion"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, actual_completion_date))
      comment: "Average number of days from completion to closure"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit event performance metrics tracking audit outcomes, findings, corrective actions, and compliance assessment ratings"
  source: "`airlines_ecm`.`compliance`.`audit_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of audit event (e.g., internal, external, regulatory)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the audit event"
    - name: "audit_location_type"
      expr: audit_location_type
      comment: "Type of location where audit was conducted"
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organization or body conducting the audit"
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard being audited against"
    - name: "assessment_rating"
      expr: assessment_rating
      comment: "Overall assessment rating from the audit"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall outcome of the audit event"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required based on audit findings"
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Whether a follow-up audit is required"
    - name: "aircraft_type"
      expr: aircraft_type
      comment: "Aircraft type audited"
    - name: "audit_year"
      expr: YEAR(scheduled_date)
      comment: "Year when audit was scheduled"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_date), '-', YEAR(scheduled_date))
      comment: "Quarter when audit was scheduled"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year when audit actually started"
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of audit events conducted"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS INT))
      comment: "Total count of critical findings across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS INT))
      comment: "Total count of major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS INT))
      comment: "Total count of minor findings across all audits"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS INT))
      comment: "Total count of all findings across all audits"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit event"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring corrective action"
    - name: "audits_requiring_follow_up"
      expr: SUM(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring follow-up audits"
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average duration of audit events in days"
    - name: "avg_days_scheduled_to_actual"
      expr: AVG(DATEDIFF(actual_start_date, scheduled_date))
      comment: "Average days between scheduled and actual audit start"
    - name: "avg_days_to_report_issuance"
      expr: AVG(DATEDIFF(audit_report_issued_date, actual_end_date))
      comment: "Average days from audit end to report issuance"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_emissions_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon emissions and offset performance metrics tracking fuel burn, CO2 emissions, offset obligations, and compliance with environmental regulations"
  source: "`airlines_ecm`.`compliance`.`emissions_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of emissions report (e.g., CORSIA, EU ETS, voluntary)"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the emissions report"
    - name: "scope"
      expr: scope
      comment: "Emissions scope (e.g., Scope 1, Scope 2, Scope 3)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used (e.g., Jet A, SAF blend)"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority to which report is submitted"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the emissions report"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of emissions and offsets"
    - name: "compliance_period"
      expr: compliance_period
      comment: "Compliance period for the emissions report"
    - name: "route_code"
      expr: route_code
      comment: "Route code for which emissions are reported"
    - name: "reporting_year"
      expr: YEAR(reporting_period_start)
      comment: "Year of the reporting period start"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when report was submitted"
  measures:
    - name: "total_emissions_reports"
      expr: COUNT(1)
      comment: "Total number of emissions reports filed"
    - name: "total_fuel_burn_tonnes"
      expr: SUM(CAST(fuel_burn_tonnes AS DOUBLE))
      comment: "Total fuel burned in tonnes across all reports"
    - name: "total_co2_emissions_tonnes"
      expr: SUM(CAST(total_co2_emissions_tonnes AS DOUBLE))
      comment: "Total CO2 emissions in tonnes across all reports"
    - name: "avg_emission_factor"
      expr: AVG(CAST(emission_factor AS DOUBLE))
      comment: "Average emission factor used in calculations"
    - name: "total_offset_obligation_tonnes"
      expr: SUM(CAST(offset_obligation_tonnes AS DOUBLE))
      comment: "Total offset obligation in tonnes of CO2e"
    - name: "total_offsets_retired_tonnes"
      expr: SUM(CAST(offsets_retired_tonnes AS DOUBLE))
      comment: "Total carbon offsets retired in tonnes of CO2e"
    - name: "total_shortfall_tonnes"
      expr: SUM(CAST(shortfall_tonnes AS DOUBLE))
      comment: "Total shortfall in offset obligations in tonnes"
    - name: "total_surplus_tonnes"
      expr: SUM(CAST(surplus_tonnes AS DOUBLE))
      comment: "Total surplus offsets in tonnes"
    - name: "avg_saf_percentage"
      expr: AVG(CAST(saf_percentage AS DOUBLE))
      comment: "Average sustainable aviation fuel (SAF) percentage used"
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, reporting_period_end))
      comment: "Average days from reporting period end to submission"
    - name: "avg_days_to_verification"
      expr: AVG(DATEDIFF(verification_date, submission_date))
      comment: "Average days from submission to verification"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_consumer_protection_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer protection case metrics tracking passenger rights violations, compensation amounts, regulatory thresholds, and case resolution performance"
  source: "`airlines_ecm`.`compliance`.`consumer_protection_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of consumer protection case (e.g., delay, cancellation, denied boarding)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the consumer protection case"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the consumer protection issue"
    - name: "compensation_required_flag"
      expr: compensation_required_flag
      comment: "Whether compensation is required for affected passengers"
    - name: "regulatory_threshold_breached"
      expr: regulatory_threshold_breached
      comment: "Whether regulatory threshold was breached triggering the case"
    - name: "reported_to_authority_flag"
      expr: reported_to_authority_flag
      comment: "Whether case was reported to regulatory authority"
    - name: "passenger_complaint_received_flag"
      expr: passenger_complaint_received_flag
      comment: "Whether passenger complaint was received"
    - name: "accessibility_violation_flag"
      expr: accessibility_violation_flag
      comment: "Whether case involves accessibility violation"
    - name: "accessibility_violation_type"
      expr: accessibility_violation_type
      comment: "Type of accessibility violation if applicable"
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of regulatory threshold (e.g., delay minutes, cancellation notice)"
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport code for the affected flight"
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport code for the affected flight"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year when the consumer protection incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date), '-', YEAR(incident_date))
      comment: "Quarter when the consumer protection incident occurred"
  measures:
    - name: "total_consumer_protection_cases"
      expr: COUNT(1)
      comment: "Total number of consumer protection cases"
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount_total AS DOUBLE))
      comment: "Total compensation amount paid across all cases"
    - name: "avg_compensation_per_case"
      expr: AVG(CAST(compensation_amount_total AS DOUBLE))
      comment: "Average compensation amount per case"
    - name: "avg_compensation_per_passenger"
      expr: AVG(CAST(compensation_per_passenger AS DOUBLE))
      comment: "Average compensation amount per affected passenger"
    - name: "total_passengers_affected"
      expr: SUM(CAST(passenger_count_affected AS INT))
      comment: "Total number of passengers affected across all cases"
    - name: "cases_requiring_compensation"
      expr: SUM(CASE WHEN compensation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases requiring passenger compensation"
    - name: "cases_breaching_threshold"
      expr: SUM(CASE WHEN regulatory_threshold_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases breaching regulatory thresholds"
    - name: "cases_reported_to_authority"
      expr: SUM(CASE WHEN reported_to_authority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases reported to regulatory authorities"
    - name: "accessibility_violation_cases"
      expr: SUM(CASE WHEN accessibility_violation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases involving accessibility violations"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, incident_date))
      comment: "Average number of days from incident to case resolution"
    - name: "avg_days_complaint_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, complaint_receipt_date))
      comment: "Average days from complaint receipt to resolution"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics tracking submission timeliness, acceptance rates, rejection reasons, and filing compliance"
  source: "`airlines_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., schedule, financial, operational)"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (e.g., portal, email, paper)"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether this filing is an amendment to a previous filing"
    - name: "confidential_flag"
      expr: confidential_flag
      comment: "Whether the filing contains confidential information"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for the filing"
    - name: "compliance_quarter"
      expr: compliance_quarter
      comment: "Compliance quarter for the filing"
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the filing"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when filing was submitted"
    - name: "due_date_year"
      expr: YEAR(due_date)
      comment: "Year of the filing due date"
  measures:
    - name: "total_regulatory_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings submitted"
    - name: "filings_submitted_on_time"
      expr: SUM(CASE WHEN submission_date <= due_date THEN 1 ELSE 0 END)
      comment: "Count of filings submitted on or before due date"
    - name: "filings_submitted_late"
      expr: SUM(CASE WHEN submission_date > due_date THEN 1 ELSE 0 END)
      comment: "Count of filings submitted after due date"
    - name: "filings_accepted"
      expr: SUM(CASE WHEN acceptance_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of filings accepted by regulatory authority"
    - name: "filings_rejected"
      expr: SUM(CASE WHEN rejection_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of filings rejected by regulatory authority"
    - name: "amendment_filings"
      expr: SUM(CASE WHEN amendment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of filings that are amendments"
    - name: "confidential_filings"
      expr: SUM(CASE WHEN confidential_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of filings marked as confidential"
    - name: "avg_days_before_due_date"
      expr: AVG(DATEDIFF(due_date, submission_date))
      comment: "Average days between submission and due date (positive = early)"
    - name: "avg_days_to_acknowledgment"
      expr: AVG(DATEDIFF(acknowledgment_date, submission_date))
      comment: "Average days from submission to acknowledgment"
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average days from submission to acceptance"
    - name: "avg_document_count"
      expr: AVG(CAST(document_count AS DOUBLE))
      comment: "Average number of documents per filing"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_ad_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Airworthiness Directive (AD) compliance metrics tracking AD completion, costs, intervals, and terminating actions for fleet safety"
  source: "`airlines_ecm`.`compliance`.`ad_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the AD"
    - name: "compliance_method"
      expr: compliance_method
      comment: "Method used to comply with the AD"
    - name: "applicability_status"
      expr: applicability_status
      comment: "Applicability status of the AD to the aircraft"
    - name: "amoc_approved_flag"
      expr: amoc_approved_flag
      comment: "Whether Alternative Method of Compliance (AMOC) was approved"
    - name: "terminating_action_flag"
      expr: terminating_action_flag
      comment: "Whether this compliance action is a terminating action"
    - name: "ad_number"
      expr: ad_number
      comment: "Airworthiness Directive number"
    - name: "certifying_organization"
      expr: certifying_organization
      comment: "Organization that certified the compliance"
    - name: "compliance_year"
      expr: YEAR(compliance_date)
      comment: "Year when AD compliance was completed"
    - name: "compliance_quarter"
      expr: CONCAT('Q', QUARTER(compliance_date), '-', YEAR(compliance_date))
      comment: "Quarter when AD compliance was completed"
    - name: "due_date_year"
      expr: YEAR(due_date)
      comment: "Year of the AD compliance due date"
  measures:
    - name: "total_ad_compliance_records"
      expr: COUNT(1)
      comment: "Total number of AD compliance records"
    - name: "total_compliance_cost"
      expr: SUM(CAST(compliance_cost_amount AS DOUBLE))
      comment: "Total cost of AD compliance across all records"
    - name: "avg_compliance_cost"
      expr: AVG(CAST(compliance_cost_amount AS DOUBLE))
      comment: "Average cost per AD compliance action"
    - name: "ads_with_amoc"
      expr: SUM(CASE WHEN amoc_approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ADs with approved Alternative Method of Compliance"
    - name: "terminating_actions"
      expr: SUM(CASE WHEN terminating_action_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of AD compliance actions that are terminating actions"
    - name: "ads_completed_on_time"
      expr: SUM(CASE WHEN compliance_date <= due_date THEN 1 ELSE 0 END)
      comment: "Count of ADs completed on or before due date"
    - name: "ads_completed_late"
      expr: SUM(CASE WHEN compliance_date > due_date THEN 1 ELSE 0 END)
      comment: "Count of ADs completed after due date"
    - name: "avg_aircraft_hours_at_compliance"
      expr: AVG(CAST(aircraft_hours_at_compliance AS DOUBLE))
      comment: "Average aircraft hours at time of AD compliance"
    - name: "avg_compliance_interval_hours"
      expr: AVG(CAST(compliance_interval_hours AS DOUBLE))
      comment: "Average compliance interval in aircraft hours"
    - name: "avg_days_to_compliance"
      expr: AVG(DATEDIFF(compliance_date, created_timestamp))
      comment: "Average days from AD record creation to compliance completion"
    - name: "avg_days_before_due"
      expr: AVG(DATEDIFF(due_date, compliance_date))
      comment: "Average days between compliance and due date (positive = early)"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`compliance_obligation_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation register metrics tracking obligation completion, escalations, risk ratings, and regulatory compliance status"
  source: "`airlines_ecm`.`compliance`.`obligation_register`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., regulatory, contractual, policy)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation (e.g., critical, high, medium, low)"
    - name: "compliance_method"
      expr: compliance_method
      comment: "Method used to achieve compliance"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the obligation has been escalated"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver has been granted for this obligation"
    - name: "training_requirement_flag"
      expr: training_requirement_flag
      comment: "Whether training is required for this obligation"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether this is an environmental compliance obligation"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction under which the obligation applies"
    - name: "applicable_operation_type"
      expr: applicable_operation_type
      comment: "Type of operation to which obligation applies"
    - name: "applicable_aircraft_type"
      expr: applicable_aircraft_type
      comment: "Aircraft type to which obligation applies"
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Frequency at which obligation recurs"
    - name: "due_date_year"
      expr: YEAR(due_date)
      comment: "Year of the obligation due date"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year when obligation was completed"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations in the register"
    - name: "obligations_completed"
      expr: SUM(CASE WHEN completion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of obligations that have been completed"
    - name: "obligations_overdue"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE() AND completion_date IS NULL THEN 1 ELSE 0 END)
      comment: "Count of obligations that are overdue and not yet completed"
    - name: "obligations_escalated"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of obligations that have been escalated"
    - name: "obligations_with_waiver"
      expr: SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of obligations with granted waivers"
    - name: "obligations_requiring_training"
      expr: SUM(CASE WHEN training_requirement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of obligations requiring training"
    - name: "environmental_obligations"
      expr: SUM(CASE WHEN environmental_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of environmental compliance obligations"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount exposure for non-compliance"
    - name: "avg_penalty_per_obligation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation"
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(completion_date, created_timestamp))
      comment: "Average days from obligation creation to completion"
    - name: "avg_days_before_due"
      expr: AVG(DATEDIFF(due_date, completion_date))
      comment: "Average days between completion and due date (positive = early)"
$$;