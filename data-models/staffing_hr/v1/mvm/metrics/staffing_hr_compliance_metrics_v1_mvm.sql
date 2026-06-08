-- Metric views for domain: compliance | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and audit performance metrics tracking financial exposure, findings severity, corrective action velocity, and repeat-finding rates across all compliance audits. Enables risk officers and compliance leadership to prioritize remediation and assess audit program effectiveness."
  source: "`staffing_hr_ecm_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external, regulatory) used to segment audit outcomes by program type."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g., open, closed, in-progress) for pipeline and backlog analysis."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Risk rating assigned to the audit (e.g., high, medium, low) for risk-tiered reporting."
    - name: "overall_disposition"
      expr: overall_disposition
      comment: "Final disposition outcome of the audit for trend and outcome analysis."
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Status of the corrective action plan associated with the audit, used to track remediation progress."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the audit for regional compliance risk analysis."
    - name: "initiating_agency"
      expr: initiating_agency
      comment: "Regulatory or internal agency that initiated the audit, enabling agency-level exposure tracking."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Indicates whether the audit contains repeat findings from prior audits, a key quality signal."
    - name: "legal_counsel_engaged"
      expr: legal_counsel_engaged
      comment: "Indicates whether legal counsel was engaged, used to segment high-severity audits."
    - name: "period_start_year"
      expr: DATE_TRUNC('YEAR', period_start_date)
      comment: "Audit period start year for year-over-year trend analysis."
    - name: "fieldwork_start_month"
      expr: DATE_TRUNC('MONTH', fieldwork_start_date)
      comment: "Month fieldwork began, used for audit volume and cycle-time trending."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline volume metric for audit program capacity and workload management."
    - name: "total_actual_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Total financial penalties actually incurred across all audits. Direct measure of regulatory cost exposure and a key risk management KPI."
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Total estimated financial exposure across open and closed audits. Used by finance and legal to reserve against potential regulatory liability."
    - name: "avg_actual_penalty_per_audit"
      expr: AVG(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Average penalty amount per audit. Benchmarks penalty severity and informs risk-tiering decisions."
    - name: "repeat_finding_audit_count"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Number of audits with repeat findings. High repeat rates signal systemic control failures requiring executive intervention."
    - name: "legal_counsel_engaged_audit_count"
      expr: COUNT(CASE WHEN legal_counsel_engaged = TRUE THEN 1 END)
      comment: "Number of audits requiring legal counsel engagement. Proxy for high-severity regulatory exposure requiring escalation."
    - name: "open_audit_count"
      expr: COUNT(CASE WHEN audit_status = 'Open' THEN 1 END)
      comment: "Number of currently open audits. Tracks compliance team workload and unresolved regulatory risk."
    - name: "avg_fieldwork_duration_days"
      expr: AVG(DATEDIFF(fieldwork_end_date, fieldwork_start_date))
      comment: "Average number of days between fieldwork start and end. Measures audit execution efficiency and resource utilization."
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, fieldwork_end_date))
      comment: "Average days from fieldwork completion to audit closure. Tracks remediation and reporting velocity post-fieldwork."
    - name: "cap_overdue_audit_count"
      expr: COUNT(CASE WHEN corrective_action_plan_status NOT IN ('Completed', 'Closed') AND corrective_action_plan_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of audits where the corrective action plan is past due and not yet completed. Directly signals unresolved compliance risk requiring leadership escalation."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_regulatory_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory violation tracking metrics covering financial penalties, severity distribution, remediation timeliness, and repeat violation rates. Core KPIs for the Chief Compliance Officer and General Counsel to manage legal and regulatory risk."
  source: "`staffing_hr_ecm_v1`.`compliance`.`regulatory_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of regulatory violation (e.g., wage-hour, I-9, OSHA) for risk-type segmentation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the violation (e.g., critical, high, medium, low) for risk-tiered prioritization."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the violation for pipeline and backlog management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory agency associated with the violation (e.g., DOL, EEOC, OSHA) for agency-level exposure tracking."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction of the violation for geographic risk analysis and state-level compliance reporting."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the violation to identify systemic process failures driving repeat violations."
    - name: "repeat_violation_flag"
      expr: repeat_violation_flag
      comment: "Indicates whether this is a repeat violation, a critical signal for systemic compliance program failures."
    - name: "worker_classification_type"
      expr: worker_classification_type
      comment: "Worker classification type associated with the violation (e.g., W2, 1099) for misclassification risk analysis."
    - name: "co_employment_risk_flag"
      expr: co_employment_risk_flag
      comment: "Indicates co-employment risk involvement, relevant for staffing agency liability exposure."
    - name: "discovery_year"
      expr: DATE_TRUNC('YEAR', discovery_date)
      comment: "Year the violation was discovered for year-over-year trend analysis."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the violation was discovered for monthly trend and seasonality analysis."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of regulatory violations recorded. Baseline volume metric for compliance program health."
    - name: "total_financial_penalty_amount"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed across all violations. Primary measure of regulatory cost and legal liability."
    - name: "avg_financial_penalty_per_violation"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average penalty per violation. Benchmarks penalty severity and informs risk reserve calculations."
    - name: "repeat_violation_count"
      expr: COUNT(CASE WHEN repeat_violation_flag = TRUE THEN 1 END)
      comment: "Number of repeat violations. High repeat rates indicate systemic control failures and elevated regulatory scrutiny risk."
    - name: "unresolved_violation_count"
      expr: COUNT(CASE WHEN resolution_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of violations not yet resolved. Tracks open regulatory liability and compliance team backlog."
    - name: "co_employment_risk_violation_count"
      expr: COUNT(CASE WHEN co_employment_risk_flag = TRUE THEN 1 END)
      comment: "Number of violations with co-employment risk. Critical for staffing firms managing joint-employer liability exposure."
    - name: "avg_days_to_remediation"
      expr: AVG(DATEDIFF(remediation_completed_date, discovery_date))
      comment: "Average days from violation discovery to remediation completion. Measures compliance response velocity and operational efficiency."
    - name: "overdue_remediation_count"
      expr: COUNT(CASE WHEN remediation_completed_date IS NULL AND remediation_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of violations past their remediation due date without completion. Directly signals unresolved regulatory risk requiring executive escalation."
    - name: "distinct_affected_clients"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts affected by violations. Measures breadth of client-facing compliance risk and potential contract liability."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_placement_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Placement-level compliance check metrics tracking onboarding clearance rates, background check outcomes, drug screen pass rates, and overall compliance result distribution. Enables operations and compliance teams to manage pre-placement risk and onboarding throughput."
  source: "`staffing_hr_ecm_v1`.`compliance`.`placement_compliance_check`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Type of compliance check performed (e.g., BGC, drug screen, I-9) for check-type segmentation."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the compliance check for pipeline and clearance tracking."
    - name: "overall_compliance_result"
      expr: overall_compliance_result
      comment: "Overall compliance result for the placement (e.g., cleared, blocked, pending) — primary outcome dimension."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding status of the worker associated with the compliance check for funnel analysis."
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status for BGC pass/fail rate analysis."
    - name: "drug_screen_status"
      expr: drug_screen_status
      comment: "Drug screen result status for drug screen pass/fail rate analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement (e.g., temporary, permanent, contract) for compliance rate segmentation by engagement type."
    - name: "ofccp_applicability_flag"
      expr: ofccp_applicability_flag
      comment: "Indicates whether OFCCP requirements apply to this placement, for federal contractor compliance segmentation."
    - name: "eeoc_self_id_collected"
      expr: eeoc_self_id_collected
      comment: "Indicates whether EEOC self-identification data was collected, for EEO compliance completeness tracking."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started, for monthly compliance check volume and clearance rate trending."
    - name: "check_initiated_month"
      expr: DATE_TRUNC('MONTH', check_initiated_date)
      comment: "Month the compliance check was initiated, for processing volume and cycle-time trending."
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of placement compliance checks initiated. Baseline volume metric for onboarding throughput."
    - name: "cleared_placement_count"
      expr: COUNT(CASE WHEN overall_compliance_result = 'Cleared' THEN 1 END)
      comment: "Number of placements fully cleared for compliance. Measures onboarding success rate and operational throughput."
    - name: "blocked_placement_count"
      expr: COUNT(CASE WHEN overall_compliance_result = 'Blocked' THEN 1 END)
      comment: "Number of placements blocked due to compliance failures. Tracks compliance-driven placement fallout and revenue risk."
    - name: "bgc_pass_count"
      expr: COUNT(CASE WHEN bgc_status = 'Pass' THEN 1 END)
      comment: "Number of placements where background check passed. Used to compute BGC pass rate for quality and risk benchmarking."
    - name: "bgc_fail_count"
      expr: COUNT(CASE WHEN bgc_status = 'Fail' THEN 1 END)
      comment: "Number of placements where background check failed. Tracks BGC failure volume for risk and client SLA management."
    - name: "drug_screen_pass_count"
      expr: COUNT(CASE WHEN drug_screen_status = 'Pass' THEN 1 END)
      comment: "Number of placements where drug screen passed. Used to compute drug screen pass rate for safety and compliance benchmarking."
    - name: "drug_screen_fail_count"
      expr: COUNT(CASE WHEN drug_screen_status = 'Fail' THEN 1 END)
      comment: "Number of placements where drug screen failed. Tracks drug screen failure volume for safety risk management."
    - name: "avg_days_check_to_clearance"
      expr: AVG(DATEDIFF(clearance_date, check_initiated_date))
      comment: "Average days from compliance check initiation to clearance. Measures onboarding cycle time efficiency — a key operational KPI for time-to-fill."
    - name: "eeoc_self_id_collection_count"
      expr: COUNT(CASE WHEN eeoc_self_id_collected = TRUE THEN 1 END)
      comment: "Number of placements where EEOC self-identification data was collected. Tracks EEO data completeness for OFCCP and EEOC reporting compliance."
    - name: "distinct_clients_with_checks"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts with active compliance checks. Measures breadth of compliance program coverage across the client portfolio."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_worker_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Worker classification risk metrics tracking misclassification exposure, IC agreement coverage, reclassification activity, and IRS/state audit risk. Critical KPIs for legal, compliance, and finance teams managing independent contractor and co-employment liability."
  source: "`staffing_hr_ecm_v1`.`compliance`.`worker_classification`"
  dimensions:
    - name: "classification_type"
      expr: classification_type
      comment: "Current worker classification type (e.g., W2, 1099-IC, Corp-to-Corp) for classification mix analysis."
    - name: "classification_status"
      expr: classification_status
      comment: "Status of the classification determination (e.g., active, under review, reclassified) for pipeline management."
    - name: "misclassification_risk_level"
      expr: misclassification_risk_level
      comment: "Risk level of potential misclassification (e.g., high, medium, low) for risk-tiered prioritization."
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption status of the worker for wage-hour compliance segmentation."
    - name: "abc_test_result"
      expr: abc_test_result
      comment: "Result of the ABC test for independent contractor classification, relevant in states with strict IC laws."
    - name: "override_flag"
      expr: override_flag
      comment: "Indicates whether the classification was manually overridden, a key governance and audit signal."
    - name: "ic_agreement_on_file"
      expr: ic_agreement_on_file
      comment: "Indicates whether an IC agreement is on file, a baseline documentation compliance requirement."
    - name: "ss8_filed"
      expr: ss8_filed
      comment: "Indicates whether an IRS SS-8 determination was filed, signaling elevated IRS audit exposure."
    - name: "determination_year"
      expr: DATE_TRUNC('YEAR', determination_date)
      comment: "Year of the classification determination for year-over-year trend analysis."
    - name: "reclassification_trigger"
      expr: reclassification_trigger
      comment: "Reason that triggered a reclassification event, used to identify systemic drivers of classification changes."
  measures:
    - name: "total_worker_classifications"
      expr: COUNT(1)
      comment: "Total number of worker classification records. Baseline volume metric for classification program scope."
    - name: "high_misclassification_risk_count"
      expr: COUNT(CASE WHEN misclassification_risk_level = 'High' THEN 1 END)
      comment: "Number of workers classified as high misclassification risk. Primary KPI for legal and compliance leadership to prioritize remediation and manage IRS/DOL audit exposure."
    - name: "override_classification_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Number of classifications with manual overrides. High override rates signal governance gaps and increase audit risk."
    - name: "ic_agreement_missing_count"
      expr: COUNT(CASE WHEN ic_agreement_on_file = FALSE THEN 1 END)
      comment: "Number of IC workers without an agreement on file. Missing IC agreements are a direct compliance deficiency and legal liability."
    - name: "ss8_filed_count"
      expr: COUNT(CASE WHEN ss8_filed = TRUE THEN 1 END)
      comment: "Number of workers with an IRS SS-8 determination filed. Tracks IRS audit exposure volume for legal and tax risk management."
    - name: "reclassification_count"
      expr: COUNT(CASE WHEN reclassification_date IS NOT NULL THEN 1 END)
      comment: "Number of workers who have been reclassified. Tracks classification instability and associated retroactive liability risk."
    - name: "voluntary_classification_settlement_count"
      expr: COUNT(CASE WHEN voluntary_classification_settlement = TRUE THEN 1 END)
      comment: "Number of workers enrolled in IRS Voluntary Classification Settlement Program. Measures proactive tax compliance remediation activity."
    - name: "distinct_clients_with_high_risk_classifications"
      expr: COUNT(DISTINCT CASE WHEN misclassification_risk_level = 'High' THEN client_account_id END)
      comment: "Number of distinct client accounts with at least one high-risk worker classification. Measures breadth of client-facing misclassification liability."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_wage_hour_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wage and hour compliance metrics tracking pay rate validation, overtime threshold compliance, prevailing wage coverage, pay equity review activity, and DOL audit exposure. Essential KPIs for payroll compliance, legal, and finance leadership."
  source: "`staffing_hr_ecm_v1`.`compliance`.`wage_hour_determination`"
  dimensions:
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA classification of the worker (e.g., exempt, non-exempt) for wage-hour compliance segmentation."
    - name: "determination_status"
      expr: determination_status
      comment: "Status of the wage-hour determination (e.g., active, pending, superseded) for pipeline management."
    - name: "work_state"
      expr: work_state
      comment: "State where work is performed for state-level minimum wage and overtime law compliance analysis."
    - name: "pay_rate_type"
      expr: pay_rate_type
      comment: "Type of pay rate (e.g., hourly, salary, piece-rate) for pay structure compliance segmentation."
    - name: "prevailing_wage_flag"
      expr: prevailing_wage_flag
      comment: "Indicates whether prevailing wage requirements apply, for government contract compliance tracking."
    - name: "dol_audit_flag"
      expr: dol_audit_flag
      comment: "Indicates whether this determination is under DOL audit scrutiny, for audit exposure segmentation."
    - name: "pay_equity_review_flag"
      expr: pay_equity_review_flag
      comment: "Indicates whether a pay equity review was triggered, for pay equity compliance program tracking."
    - name: "salary_threshold_met"
      expr: salary_threshold_met
      comment: "Indicates whether the FLSA salary threshold for exemption is met, for misclassification risk analysis."
    - name: "co_employment_risk_level"
      expr: co_employment_risk_level
      comment: "Co-employment risk level associated with the determination, for joint-employer liability segmentation."
    - name: "determination_year"
      expr: DATE_TRUNC('YEAR', determination_date)
      comment: "Year of the wage-hour determination for year-over-year trend analysis."
  measures:
    - name: "total_wage_hour_determinations"
      expr: COUNT(1)
      comment: "Total number of wage-hour determinations. Baseline volume metric for wage compliance program scope."
    - name: "total_validated_pay_rate"
      expr: SUM(CAST(pay_rate_validated AS DOUBLE))
      comment: "Sum of all validated pay rates across determinations. Used with headcount to compute average validated pay rate and benchmark against minimum wage thresholds."
    - name: "avg_validated_pay_rate"
      expr: AVG(CAST(pay_rate_validated AS DOUBLE))
      comment: "Average validated pay rate across all determinations. Benchmarks pay levels against minimum wage and prevailing wage requirements."
    - name: "avg_minimum_wage_applicable"
      expr: AVG(CAST(minimum_wage_applicable AS DOUBLE))
      comment: "Average applicable minimum wage across determinations. Used to assess pay rate compliance margins across jurisdictions."
    - name: "dol_audit_exposure_count"
      expr: COUNT(CASE WHEN dol_audit_flag = TRUE THEN 1 END)
      comment: "Number of determinations flagged for DOL audit. Tracks active DOL audit exposure volume for legal and compliance risk management."
    - name: "prevailing_wage_determination_count"
      expr: COUNT(CASE WHEN prevailing_wage_flag = TRUE THEN 1 END)
      comment: "Number of determinations subject to prevailing wage requirements. Tracks government contract wage compliance scope."
    - name: "pay_equity_review_count"
      expr: COUNT(CASE WHEN pay_equity_review_flag = TRUE THEN 1 END)
      comment: "Number of determinations that triggered a pay equity review. Tracks pay equity compliance program activity and potential liability."
    - name: "salary_threshold_not_met_count"
      expr: COUNT(CASE WHEN salary_threshold_met = FALSE THEN 1 END)
      comment: "Number of determinations where the FLSA salary threshold for exemption is not met. Identifies workers potentially misclassified as exempt, a key wage-hour liability signal."
    - name: "avg_ot_threshold_hours"
      expr: AVG(CAST(ot_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours across determinations. Used to assess overtime policy consistency and compliance with state-specific OT laws."
    - name: "avg_ot_rate_multiplier"
      expr: AVG(CAST(ot_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across determinations. Validates that OT pay rates meet or exceed legal minimums (e.g., 1.5x)."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA incident and workplace safety metrics tracking recordable incident rates, fatality and hospitalization counts, corrective action timeliness, and root cause patterns. Core KPIs for safety leadership, risk management, and client account management."
  source: "`staffing_hr_ecm_v1`.`compliance`.`osha_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the OSHA incident (e.g., open, closed, under investigation) for pipeline management."
    - name: "injury_illness_type"
      expr: injury_illness_type
      comment: "Type of injury or illness (e.g., sprain, laceration, illness) for safety program root cause analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of safety event (e.g., slip/fall, struck-by, overexertion) for hazard identification and prevention."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the incident for systemic safety program improvement."
    - name: "outcome_type"
      expr: outcome_type
      comment: "Outcome of the incident (e.g., days away, restricted duty, medical treatment) for severity classification."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Indicates whether the incident meets OSHA recordability criteria, for regulatory reporting compliance."
    - name: "is_fatality"
      expr: is_fatality
      comment: "Indicates whether the incident resulted in a fatality, the most critical safety outcome dimension."
    - name: "is_hospitalized"
      expr: is_hospitalized
      comment: "Indicates whether the worker was hospitalized, for severity-tiered safety analysis."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry code of the work site, used for industry-benchmarked incident rate analysis."
    - name: "incident_year"
      expr: DATE_TRUNC('YEAR', incident_date)
      comment: "Year of the incident for year-over-year safety trend analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident for monthly safety trend and seasonality analysis."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of OSHA incidents recorded. Baseline safety volume metric for incident rate calculations."
    - name: "osha_recordable_incident_count"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Number of OSHA-recordable incidents. Primary regulatory compliance metric for OSHA 300 log and ITA submission requirements."
    - name: "fatality_count"
      expr: COUNT(CASE WHEN is_fatality = TRUE THEN 1 END)
      comment: "Number of fatality incidents. The most critical safety KPI — any non-zero value triggers immediate executive and regulatory response."
    - name: "hospitalization_count"
      expr: COUNT(CASE WHEN is_hospitalized = TRUE THEN 1 END)
      comment: "Number of incidents resulting in hospitalization. Tracks severe injury volume and OSHA 24-hour reporting obligation triggers."
    - name: "osha_report_submitted_count"
      expr: COUNT(CASE WHEN osha_report_submitted = TRUE THEN 1 END)
      comment: "Number of incidents where OSHA report was submitted. Used to compute OSHA reporting compliance rate against recordable incident count."
    - name: "corrective_action_overdue_count"
      expr: COUNT(CASE WHEN corrective_action_completed_date IS NULL AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of incidents with overdue corrective actions. Tracks unresolved safety hazards and regulatory non-compliance risk."
    - name: "avg_days_to_corrective_action_completion"
      expr: AVG(DATEDIFF(corrective_action_completed_date, incident_date))
      comment: "Average days from incident date to corrective action completion. Measures safety response velocity and program effectiveness."
    - name: "avg_days_away_from_work"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away from work per incident. Measures severity of worker injuries and associated productivity and workers comp cost impact."
    - name: "distinct_clients_with_incidents"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts with OSHA incidents. Measures breadth of client safety risk exposure for account management and contract risk review."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_i9_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "I-9 employment eligibility verification metrics tracking verification completion rates, TNC issuance rates, reverification compliance, and E-Verify submission timeliness. Core KPIs for I-9 compliance program management and ICE audit readiness."
  source: "`staffing_hr_ecm_v1`.`compliance`.`i9_verification`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Current I-9 verification status (e.g., complete, pending, deficient) for compliance pipeline management."
    - name: "citizenship_status"
      expr: citizenship_status
      comment: "Worker citizenship/work authorization status for I-9 document category analysis."
    - name: "everify_status"
      expr: everify_status
      comment: "E-Verify case status associated with the I-9 for E-Verify program compliance tracking."
    - name: "employer_of_record_type"
      expr: employer_of_record_type
      comment: "Type of employer of record for the I-9, relevant for co-employment and EOR compliance segmentation."
    - name: "remote_verification"
      expr: remote_verification
      comment: "Indicates whether remote verification was used, for tracking compliance with DHS remote verification authorization."
    - name: "reverification_required"
      expr: reverification_required
      comment: "Indicates whether reverification is required due to expiring work authorization, for proactive compliance management."
    - name: "tnc_issued"
      expr: tnc_issued
      comment: "Indicates whether a Tentative Non-Confirmation was issued, a key E-Verify compliance signal."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire for year-over-year I-9 volume and compliance rate trending."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for monthly I-9 processing volume and timeliness trending."
  measures:
    - name: "total_i9_verifications"
      expr: COUNT(1)
      comment: "Total number of I-9 verifications initiated. Baseline volume metric for I-9 compliance program scope."
    - name: "complete_i9_count"
      expr: COUNT(CASE WHEN verification_status = 'Complete' THEN 1 END)
      comment: "Number of fully completed I-9 verifications. Used to compute I-9 completion rate, a primary ICE audit readiness KPI."
    - name: "tnc_issued_count"
      expr: COUNT(CASE WHEN tnc_issued = TRUE THEN 1 END)
      comment: "Number of I-9s where a Tentative Non-Confirmation was issued. Tracks E-Verify TNC rate, a key employment eligibility compliance metric."
    - name: "tnc_contested_count"
      expr: COUNT(CASE WHEN tnc_contested = TRUE THEN 1 END)
      comment: "Number of TNCs contested by workers. Tracks worker dispute rate for E-Verify program quality and potential discrimination risk management."
    - name: "reverification_required_count"
      expr: COUNT(CASE WHEN reverification_required = TRUE THEN 1 END)
      comment: "Number of workers requiring I-9 reverification due to expiring work authorization. Tracks proactive compliance workload for reverification program management."
    - name: "reverification_overdue_count"
      expr: COUNT(CASE WHEN reverification_required = TRUE AND reverification_due_date < CURRENT_DATE() AND section3_completed_date IS NULL THEN 1 END)
      comment: "Number of workers past their reverification due date without Section 3 completion. Directly signals I-9 compliance deficiencies and ICE audit risk."
    - name: "avg_days_section1_to_section2"
      expr: AVG(DATEDIFF(section2_completed_date, section1_completed_date))
      comment: "Average days between Section 1 and Section 2 completion. Measures I-9 processing timeliness — Section 2 must be completed by the first day of work per federal law."
    - name: "everify_submission_count"
      expr: COUNT(CASE WHEN everify_submission_date IS NOT NULL THEN 1 END)
      comment: "Number of I-9s with an E-Verify submission. Used to compute E-Verify submission rate for federal contractor and mandatory E-Verify state compliance."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_everify_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "E-Verify case outcome metrics tracking case resolution rates, TNC rates, late submission rates, and referral activity. Enables compliance teams to manage E-Verify program performance and federal contractor obligations."
  source: "`staffing_hr_ecm_v1`.`compliance`.`everify_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current E-Verify case status for pipeline and resolution tracking."
    - name: "final_case_result"
      expr: final_case_result
      comment: "Final E-Verify case result (e.g., Employment Authorized, Final Non-Confirmation) — primary outcome dimension."
    - name: "initial_case_result"
      expr: initial_case_result
      comment: "Initial E-Verify case result for TNC-to-final-result conversion analysis."
    - name: "tnc_type"
      expr: tnc_type
      comment: "Type of TNC issued (e.g., SSA, DHS) for agency-level TNC analysis."
    - name: "tnc_resolution_status"
      expr: tnc_resolution_status
      comment: "Resolution status of the TNC for contested case management."
    - name: "case_verification_type"
      expr: case_verification_type
      comment: "Type of E-Verify verification (e.g., initial, reverification) for program scope segmentation."
    - name: "federal_contractor_flag"
      expr: federal_contractor_flag
      comment: "Indicates federal contractor status, for mandatory E-Verify compliance segmentation."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Indicates whether the E-Verify case was submitted late (after the 3-day window), a direct compliance violation signal."
    - name: "worker_contested_tnc"
      expr: worker_contested_tnc
      comment: "Indicates whether the worker contested the TNC, for anti-discrimination compliance monitoring."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of E-Verify case submission for monthly volume and timeliness trending."
  measures:
    - name: "total_everify_cases"
      expr: COUNT(1)
      comment: "Total number of E-Verify cases created. Baseline volume metric for E-Verify program scope."
    - name: "employment_authorized_count"
      expr: COUNT(CASE WHEN final_case_result = 'Employment Authorized' THEN 1 END)
      comment: "Number of cases resulting in Employment Authorized. Used to compute E-Verify authorization rate, a primary program performance KPI."
    - name: "final_non_confirmation_count"
      expr: COUNT(CASE WHEN final_case_result = 'Final Non-Confirmation' THEN 1 END)
      comment: "Number of Final Non-Confirmation results. Tracks workers found ineligible for employment — a critical legal and compliance outcome."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of E-Verify cases submitted outside the 3-business-day window. Late submissions are a direct E-Verify program violation and federal contractor audit risk."
    - name: "tnc_issued_count"
      expr: COUNT(CASE WHEN further_action_notice_issued = TRUE THEN 1 END)
      comment: "Number of cases where a Further Action Notice (TNC) was issued. Tracks TNC issuance rate for E-Verify program quality monitoring."
    - name: "worker_contested_tnc_count"
      expr: COUNT(CASE WHEN worker_contested_tnc = TRUE THEN 1 END)
      comment: "Number of cases where the worker contested the TNC. Tracks anti-discrimination compliance risk — high contest rates may signal improper E-Verify use."
    - name: "avg_days_to_case_closure"
      expr: AVG(DATEDIFF(case_closure_date, employee_first_day_of_work))
      comment: "Average days from employee first day of work to E-Verify case closure. Measures E-Verify processing velocity and compliance with timely resolution requirements."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN case_status NOT IN ('Closed', 'Final Non-Confirmation') AND case_closure_date IS NULL THEN 1 END)
      comment: "Number of currently open E-Verify cases. Tracks unresolved employment authorization status and associated compliance risk."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`compliance_eeoc_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EEOC EEO-1 filing compliance metrics tracking filing status, headcount reporting completeness, amendment rates, and OFCCP audit flags. Essential KPIs for HR compliance and legal teams managing federal contractor EEO reporting obligations."
  source: "`staffing_hr_ecm_v1`.`compliance`.`eeoc_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the EEOC filing (e.g., submitted, accepted, rejected) for compliance pipeline management."
    - name: "report_type"
      expr: report_type
      comment: "Type of EEO report (e.g., EEO-1, EEO-3) for report-type segmentation."
    - name: "report_component"
      expr: report_component
      comment: "EEO-1 report component (e.g., Component 1, Component 2) for pay data reporting compliance segmentation."
    - name: "filing_year"
      expr: filing_year
      comment: "Reporting year of the EEOC filing for year-over-year compliance trend analysis."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Indicates whether the filing is an amendment to a prior submission, for amendment rate tracking."
    - name: "is_federal_contractor"
      expr: is_federal_contractor
      comment: "Indicates federal contractor status, for mandatory EEO-1 filing obligation segmentation."
    - name: "ofccp_audit_flag"
      expr: ofccp_audit_flag
      comment: "Indicates whether the filing is associated with an OFCCP audit, for audit exposure segmentation."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (e.g., online portal, batch upload) for process efficiency analysis."
    - name: "reporting_period_end_year"
      expr: DATE_TRUNC('YEAR', reporting_period_end)
      comment: "Year of the reporting period end date for annual EEO compliance cycle tracking."
  measures:
    - name: "total_eeoc_filings"
      expr: COUNT(1)
      comment: "Total number of EEOC filings. Baseline volume metric for EEO reporting program scope."
    - name: "accepted_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Accepted' THEN 1 END)
      comment: "Number of EEOC filings accepted by the agency. Used to compute filing acceptance rate, a primary EEO compliance KPI."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Number of EEOC filings rejected. Tracks filing quality issues and compliance program deficiencies requiring remediation."
    - name: "amendment_filing_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of amendment filings. High amendment rates signal data quality issues in the underlying HR and payroll systems."
    - name: "ofccp_audit_flagged_count"
      expr: COUNT(CASE WHEN ofccp_audit_flag = TRUE THEN 1 END)
      comment: "Number of filings flagged for OFCCP audit. Tracks active OFCCP audit exposure for federal contractor compliance management."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN filing_status NOT IN ('Accepted', 'Submitted') AND filing_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of filings past their deadline without accepted status. Tracks EEO reporting non-compliance risk and potential OFCCP enforcement exposure."
    - name: "distinct_clients_filing"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts with EEOC filings. Measures breadth of EEO reporting program coverage across the client portfolio."
$$;