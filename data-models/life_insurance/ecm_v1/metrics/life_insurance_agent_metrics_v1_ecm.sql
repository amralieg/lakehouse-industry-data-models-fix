-- Metric views for domain: agent | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_producer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core producer performance and status metrics for agent workforce management and production tracking"
  source: "`life_insurance_ecm`.`agent`.`producer`"
  dimensions:
    - name: "producer_type"
      expr: producer_type
      comment: "Type of producer (captive, independent, broker, etc.)"
    - name: "producer_status"
      expr: producer_status
      comment: "Current status of producer (active, inactive, terminated, suspended)"
    - name: "contracting_status"
      expr: contracting_status
      comment: "Current contracting status of producer"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the producer hierarchy (agent, manager, director, etc.)"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current stage in the onboarding process"
    - name: "state_code"
      expr: state_code
      comment: "State where producer is domiciled"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer verification status"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check (passed, failed, pending)"
    - name: "eo_coverage_indicator"
      expr: eo_coverage_indicator
      comment: "Whether producer has errors and omissions coverage"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year producer was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month producer was hired"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for producer termination if applicable"
  measures:
    - name: "total_producers"
      expr: COUNT(DISTINCT producer_id)
      comment: "Total number of unique producers"
    - name: "total_ytd_production"
      expr: SUM(CAST(ytd_production_amount AS DOUBLE))
      comment: "Total year-to-date production amount across all producers"
    - name: "total_lifetime_production"
      expr: SUM(CAST(lifetime_production_amount AS DOUBLE))
      comment: "Total lifetime production amount across all producers"
    - name: "total_annual_target"
      expr: SUM(CAST(annual_production_target AS DOUBLE))
      comment: "Total annual production target across all producers"
    - name: "avg_ytd_production_per_producer"
      expr: AVG(CAST(ytd_production_amount AS DOUBLE))
      comment: "Average year-to-date production per producer"
    - name: "avg_lifetime_production_per_producer"
      expr: AVG(CAST(lifetime_production_amount AS DOUBLE))
      comment: "Average lifetime production per producer"
    - name: "avg_annual_target_per_producer"
      expr: AVG(CAST(annual_production_target AS DOUBLE))
      comment: "Average annual production target per producer"
    - name: "producers_with_eo_coverage"
      expr: COUNT(DISTINCT CASE WHEN eo_coverage_indicator = TRUE THEN producer_id END)
      comment: "Number of producers with errors and omissions coverage"
    - name: "producers_kyc_verified"
      expr: COUNT(DISTINCT CASE WHEN kyc_status = 'Verified' THEN producer_id END)
      comment: "Number of producers with verified KYC status"
    - name: "producers_background_check_passed"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'Passed' THEN producer_id END)
      comment: "Number of producers who passed background checks"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_production_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production activity metrics for measuring agent sales performance, product mix, and quality indicators"
  source: "`life_insurance_ecm`.`agent`.`production_activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the production activity record"
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (monthly, quarterly, annual)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the production"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the producer"
    - name: "activity_period_start_month"
      expr: DATE_TRUNC('MONTH', activity_period_start_date)
      comment: "Month when activity period started"
    - name: "activity_period_start_quarter"
      expr: DATE_TRUNC('QUARTER', activity_period_start_date)
      comment: "Quarter when activity period started"
    - name: "activity_period_start_year"
      expr: YEAR(activity_period_start_date)
      comment: "Year when activity period started"
  measures:
    - name: "total_production_records"
      expr: COUNT(1)
      comment: "Total number of production activity records"
    - name: "total_premium_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount across all production activities"
    - name: "total_first_year_premium"
      expr: SUM(CAST(first_year_premium_amount AS DOUBLE))
      comment: "Total first year premium amount"
    - name: "total_renewal_premium"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Total renewal premium amount"
    - name: "total_ape"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total annualized premium equivalent (APE) amount"
    - name: "total_face_amount"
      expr: SUM(CAST(total_face_amount AS DOUBLE))
      comment: "Total face amount of policies issued"
    - name: "total_commission_earned"
      expr: SUM(CAST(commission_earned_amount AS DOUBLE))
      comment: "Total commission earned by producers"
    - name: "total_bonus_earned"
      expr: SUM(CAST(bonus_earned_amount AS DOUBLE))
      comment: "Total bonus earned by producers"
    - name: "total_whole_life_premium"
      expr: SUM(CAST(whole_life_premium_amount AS DOUBLE))
      comment: "Total premium from whole life products"
    - name: "total_term_life_premium"
      expr: SUM(CAST(term_life_premium_amount AS DOUBLE))
      comment: "Total premium from term life products"
    - name: "total_universal_life_premium"
      expr: SUM(CAST(universal_life_premium_amount AS DOUBLE))
      comment: "Total premium from universal life products"
    - name: "total_iul_premium"
      expr: SUM(CAST(iul_premium_amount AS DOUBLE))
      comment: "Total premium from indexed universal life products"
    - name: "total_vul_premium"
      expr: SUM(CAST(vul_premium_amount AS DOUBLE))
      comment: "Total premium from variable universal life products"
    - name: "total_annuity_premium"
      expr: SUM(CAST(annuity_premium_amount AS DOUBLE))
      comment: "Total premium from annuity products"
    - name: "avg_conservation_rate"
      expr: AVG(CAST(conservation_rate AS DOUBLE))
      comment: "Average conservation rate (policy retention)"
    - name: "avg_persistency_ratio"
      expr: AVG(CAST(persistency_ratio AS DOUBLE))
      comment: "Average persistency ratio across production activities"
    - name: "avg_placement_rate"
      expr: AVG(CAST(placement_rate AS DOUBLE))
      comment: "Average placement rate (issued / submitted)"
    - name: "total_submitted_applications"
      expr: SUM(CAST(submitted_application_count AS BIGINT))
      comment: "Total number of applications submitted"
    - name: "total_issued_policies"
      expr: SUM(CAST(issued_policy_count AS BIGINT))
      comment: "Total number of policies issued"
    - name: "total_nigo_count"
      expr: SUM(CAST(nigo_count AS BIGINT))
      comment: "Total number of not-in-good-order (NIGO) applications"
    - name: "total_lapse_count"
      expr: SUM(CAST(lapse_count AS BIGINT))
      comment: "Total number of lapsed policies"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Producer licensing metrics for compliance monitoring, renewal tracking, and regulatory oversight"
  source: "`life_insurance_ecm`.`agent`.`license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (active, expired, suspended, terminated)"
    - name: "license_class"
      expr: license_class
      comment: "Class of license (resident, non-resident, etc.)"
    - name: "line_of_authority"
      expr: line_of_authority
      comment: "Line of authority covered by the license (life, accident and health, variable, etc.)"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Status of carrier appointment"
    - name: "ce_compliance_status"
      expr: ce_compliance_status
      comment: "Continuing education compliance status"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check"
    - name: "eo_coverage_required"
      expr: eo_coverage_required
      comment: "Whether errors and omissions coverage is required"
    - name: "finra_registration_required"
      expr: finra_registration_required
      comment: "Whether FINRA registration is required"
    - name: "late_renewal_penalty_flag"
      expr: late_renewal_penalty_flag
      comment: "Whether a late renewal penalty was assessed"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the license became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the license expires"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the license expires"
  measures:
    - name: "total_licenses"
      expr: COUNT(DISTINCT license_id)
      comment: "Total number of unique licenses"
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees collected"
    - name: "total_late_penalties"
      expr: SUM(CAST(late_penalty_amount AS DOUBLE))
      comment: "Total late renewal penalties assessed"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per license"
    - name: "total_ce_hours_completed"
      expr: SUM(CAST(ce_hours_completed AS DOUBLE))
      comment: "Total continuing education hours completed"
    - name: "total_ce_hours_required"
      expr: SUM(CAST(ce_hours_required AS DOUBLE))
      comment: "Total continuing education hours required"
    - name: "avg_ce_hours_completed"
      expr: AVG(CAST(ce_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed per license"
    - name: "licenses_with_late_penalty"
      expr: COUNT(DISTINCT CASE WHEN late_renewal_penalty_flag = TRUE THEN license_id END)
      comment: "Number of licenses with late renewal penalties"
    - name: "licenses_ce_compliant"
      expr: COUNT(DISTINCT CASE WHEN ce_compliance_status = 'Compliant' THEN license_id END)
      comment: "Number of licenses with compliant continuing education status"
    - name: "licenses_requiring_eo_coverage"
      expr: COUNT(DISTINCT CASE WHEN eo_coverage_required = TRUE THEN license_id END)
      comment: "Number of licenses requiring errors and omissions coverage"
    - name: "licenses_requiring_finra"
      expr: COUNT(DISTINCT CASE WHEN finra_registration_required = TRUE THEN license_id END)
      comment: "Number of licenses requiring FINRA registration"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_contracting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Producer contracting metrics for onboarding efficiency, termination analysis, and contract lifecycle management"
  source: "`life_insurance_ecm`.`agent`.`contracting`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (active, pending, terminated, expired)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (captive, independent, broker, etc.)"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the contracted producer"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check"
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Whether contract was not-in-good-order (NIGO)"
    - name: "nigo_reason"
      expr: nigo_reason
      comment: "Reason for NIGO status"
    - name: "eo_coverage_required_flag"
      expr: eo_coverage_required_flag
      comment: "Whether errors and omissions coverage is required"
    - name: "finra_registration_required_flag"
      expr: finra_registration_required_flag
      comment: "Whether FINRA registration is required"
    - name: "state_notification_required_flag"
      expr: state_notification_required_flag
      comment: "Whether state notification is required"
    - name: "u5_filing_required_flag"
      expr: u5_filing_required_flag
      comment: "Whether U5 filing is required for termination"
    - name: "unearned_commission_return_flag"
      expr: unearned_commission_return_flag
      comment: "Whether unearned commissions must be returned"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, for cause, etc.)"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Code representing reason for termination"
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting"
    - name: "contracting_year"
      expr: YEAR(contracting_date)
      comment: "Year the contract was executed"
    - name: "contracting_month"
      expr: DATE_TRUNC('MONTH', contracting_date)
      comment: "Month the contract was executed"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year the contract was terminated"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT contracting_id)
      comment: "Total number of unique contracts"
    - name: "total_unearned_commission"
      expr: SUM(CAST(unearned_commission_amount AS DOUBLE))
      comment: "Total unearned commission amount across all contracts"
    - name: "avg_unearned_commission"
      expr: AVG(CAST(unearned_commission_amount AS DOUBLE))
      comment: "Average unearned commission per contract"
    - name: "contracts_nigo"
      expr: COUNT(DISTINCT CASE WHEN nigo_flag = TRUE THEN contracting_id END)
      comment: "Number of contracts flagged as not-in-good-order"
    - name: "contracts_requiring_eo"
      expr: COUNT(DISTINCT CASE WHEN eo_coverage_required_flag = TRUE THEN contracting_id END)
      comment: "Number of contracts requiring errors and omissions coverage"
    - name: "contracts_requiring_finra"
      expr: COUNT(DISTINCT CASE WHEN finra_registration_required_flag = TRUE THEN contracting_id END)
      comment: "Number of contracts requiring FINRA registration"
    - name: "contracts_requiring_state_notification"
      expr: COUNT(DISTINCT CASE WHEN state_notification_required_flag = TRUE THEN contracting_id END)
      comment: "Number of contracts requiring state notification"
    - name: "contracts_requiring_u5"
      expr: COUNT(DISTINCT CASE WHEN u5_filing_required_flag = TRUE THEN contracting_id END)
      comment: "Number of contracts requiring U5 filing"
    - name: "contracts_with_unearned_commission_return"
      expr: COUNT(DISTINCT CASE WHEN unearned_commission_return_flag = TRUE THEN contracting_id END)
      comment: "Number of contracts requiring unearned commission return"
    - name: "terminated_contracts"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN contracting_id END)
      comment: "Number of terminated contracts"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_onboarding_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Onboarding case metrics for measuring recruitment efficiency, compliance completion, and time-to-productivity"
  source: "`life_insurance_ecm`.`agent`.`onboarding_case`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding case (in progress, completed, rejected, etc.)"
    - name: "application_type"
      expr: application_type
      comment: "Type of application (new producer, transfer, etc.)"
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Whether the case was flagged as not-in-good-order"
    - name: "nigo_reason_code"
      expr: nigo_reason_code
      comment: "Code representing reason for NIGO status"
    - name: "background_check_result_status"
      expr: background_check_result_status
      comment: "Result status of background check"
    - name: "background_check_type"
      expr: background_check_type
      comment: "Type of background check performed"
    - name: "license_verification_status"
      expr: license_verification_status
      comment: "Status of license verification"
    - name: "eo_validation_status"
      expr: eo_validation_status
      comment: "Status of errors and omissions coverage validation"
    - name: "finra_verification_status"
      expr: finra_verification_status
      comment: "Status of FINRA registration verification"
    - name: "system_provisioning_status"
      expr: system_provisioning_status
      comment: "Status of system access provisioning"
    - name: "adverse_action_flag"
      expr: adverse_action_flag
      comment: "Whether adverse action was taken"
    - name: "regulatory_disqualification_flag"
      expr: regulatory_disqualification_flag
      comment: "Whether candidate was disqualified for regulatory reasons"
    - name: "aml_training_completed_flag"
      expr: aml_training_completed_flag
      comment: "Whether anti-money laundering training was completed"
    - name: "suitability_training_completed_flag"
      expr: suitability_training_completed_flag
      comment: "Whether suitability training was completed"
    - name: "eo_coverage_required_flag"
      expr: eo_coverage_required_flag
      comment: "Whether errors and omissions coverage is required"
    - name: "finra_registration_required_flag"
      expr: finra_registration_required_flag
      comment: "Whether FINRA registration is required"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code representing reason for rejection"
    - name: "application_submission_month"
      expr: DATE_TRUNC('MONTH', application_submission_date)
      comment: "Month when application was submitted"
    - name: "onboarding_completion_month"
      expr: DATE_TRUNC('MONTH', onboarding_completion_date)
      comment: "Month when onboarding was completed"
  measures:
    - name: "total_onboarding_cases"
      expr: COUNT(DISTINCT onboarding_case_id)
      comment: "Total number of unique onboarding cases"
    - name: "cases_nigo"
      expr: COUNT(DISTINCT CASE WHEN nigo_flag = TRUE THEN onboarding_case_id END)
      comment: "Number of cases flagged as not-in-good-order"
    - name: "cases_with_adverse_action"
      expr: COUNT(DISTINCT CASE WHEN adverse_action_flag = TRUE THEN onboarding_case_id END)
      comment: "Number of cases with adverse action taken"
    - name: "cases_regulatory_disqualified"
      expr: COUNT(DISTINCT CASE WHEN regulatory_disqualification_flag = TRUE THEN onboarding_case_id END)
      comment: "Number of cases disqualified for regulatory reasons"
    - name: "cases_aml_training_completed"
      expr: COUNT(DISTINCT CASE WHEN aml_training_completed_flag = TRUE THEN onboarding_case_id END)
      comment: "Number of cases with completed anti-money laundering training"
    - name: "cases_suitability_training_completed"
      expr: COUNT(DISTINCT CASE WHEN suitability_training_completed_flag = TRUE THEN onboarding_case_id END)
      comment: "Number of cases with completed suitability training"
    - name: "cases_completed"
      expr: COUNT(DISTINCT CASE WHEN onboarding_completion_date IS NOT NULL THEN onboarding_case_id END)
      comment: "Number of completed onboarding cases"
    - name: "cases_rejected"
      expr: COUNT(DISTINCT CASE WHEN rejection_date IS NOT NULL THEN onboarding_case_id END)
      comment: "Number of rejected onboarding cases"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance event metrics for regulatory risk monitoring, violation tracking, and remediation oversight"
  source: "`life_insurance_ecm`.`agent`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event (complaint, violation, investigation, etc.)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the compliance event"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the compliance event (low, medium, high, critical)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of event resolution"
    - name: "source_authority_type"
      expr: source_authority_type
      comment: "Type of authority reporting the event (state DOI, FINRA, SEC, internal, etc.)"
    - name: "source_authority"
      expr: source_authority
      comment: "Specific authority or entity reporting the event"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for the compliance event"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "finra_disclosure_required_flag"
      expr: finra_disclosure_required_flag
      comment: "Whether FINRA disclosure is required"
    - name: "external_counsel_engaged_flag"
      expr: external_counsel_engaged_flag
      comment: "Whether external legal counsel was engaged"
    - name: "aml_sar_filed_flag"
      expr: aml_sar_filed_flag
      comment: "Whether a Suspicious Activity Report was filed"
    - name: "license_impact_flag"
      expr: license_impact_flag
      comment: "Whether the event impacts producer licensing"
    - name: "contracting_impact_flag"
      expr: contracting_impact_flag
      comment: "Whether the event impacts producer contracting"
    - name: "appointment_impact_action"
      expr: appointment_impact_action
      comment: "Action taken regarding producer appointment"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the compliance event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the compliance event occurred"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year the event was resolved"
  measures:
    - name: "total_compliance_events"
      expr: COUNT(DISTINCT compliance_event_id)
      comment: "Total number of unique compliance events"
    - name: "total_monetary_penalties"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all compliance events"
    - name: "avg_monetary_penalty"
      expr: AVG(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Average monetary penalty per compliance event"
    - name: "events_requiring_escalation"
      expr: COUNT(DISTINCT CASE WHEN escalation_required_flag = TRUE THEN compliance_event_id END)
      comment: "Number of events requiring escalation"
    - name: "events_requiring_finra_disclosure"
      expr: COUNT(DISTINCT CASE WHEN finra_disclosure_required_flag = TRUE THEN compliance_event_id END)
      comment: "Number of events requiring FINRA disclosure"
    - name: "events_with_external_counsel"
      expr: COUNT(DISTINCT CASE WHEN external_counsel_engaged_flag = TRUE THEN compliance_event_id END)
      comment: "Number of events where external counsel was engaged"
    - name: "events_with_sar_filed"
      expr: COUNT(DISTINCT CASE WHEN aml_sar_filed_flag = TRUE THEN compliance_event_id END)
      comment: "Number of events where a Suspicious Activity Report was filed"
    - name: "events_impacting_license"
      expr: COUNT(DISTINCT CASE WHEN license_impact_flag = TRUE THEN compliance_event_id END)
      comment: "Number of events impacting producer licensing"
    - name: "events_impacting_contracting"
      expr: COUNT(DISTINCT CASE WHEN contracting_impact_flag = TRUE THEN compliance_event_id END)
      comment: "Number of events impacting producer contracting"
    - name: "events_resolved"
      expr: COUNT(DISTINCT CASE WHEN resolution_date IS NOT NULL THEN compliance_event_id END)
      comment: "Number of resolved compliance events"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_termination_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Termination event metrics for attrition analysis, regulatory reporting, and workforce planning"
  source: "`life_insurance_ecm`.`agent`.`termination_event`"
  dimensions:
    - name: "termination_status"
      expr: termination_status
      comment: "Current status of the termination event"
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, retirement, etc.)"
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Code representing reason for termination"
    - name: "initiated_by"
      expr: initiated_by
      comment: "Party who initiated the termination (producer, company, mutual)"
    - name: "for_cause_indicator"
      expr: for_cause_indicator
      comment: "Whether termination was for cause"
    - name: "finra_reportable_indicator"
      expr: finra_reportable_indicator
      comment: "Whether termination is reportable to FINRA"
    - name: "regulatory_reportable_indicator"
      expr: regulatory_reportable_indicator
      comment: "Whether termination is reportable to regulatory authorities"
    - name: "book_of_business_transfer_indicator"
      expr: book_of_business_transfer_indicator
      comment: "Whether book of business was transferred"
    - name: "exit_interview_completed_indicator"
      expr: exit_interview_completed_indicator
      comment: "Whether exit interview was completed"
    - name: "severance_eligible_indicator"
      expr: severance_eligible_indicator
      comment: "Whether producer is eligible for severance"
    - name: "rehire_eligible_indicator"
      expr: rehire_eligible_indicator
      comment: "Whether producer is eligible for rehire"
    - name: "commission_payout_status"
      expr: commission_payout_status
      comment: "Status of final commission payout"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority to which termination was reported"
    - name: "termination_year"
      expr: YEAR(termination_effective_date)
      comment: "Year the termination became effective"
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_effective_date)
      comment: "Month the termination became effective"
    - name: "termination_quarter"
      expr: DATE_TRUNC('QUARTER', termination_effective_date)
      comment: "Quarter the termination became effective"
  measures:
    - name: "total_termination_events"
      expr: COUNT(DISTINCT termination_event_id)
      comment: "Total number of unique termination events"
    - name: "total_severance_amount"
      expr: SUM(CAST(severance_amount AS DOUBLE))
      comment: "Total severance amount paid across all terminations"
    - name: "avg_severance_amount"
      expr: AVG(CAST(severance_amount AS DOUBLE))
      comment: "Average severance amount per termination"
    - name: "terminations_for_cause"
      expr: COUNT(DISTINCT CASE WHEN for_cause_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations for cause"
    - name: "terminations_finra_reportable"
      expr: COUNT(DISTINCT CASE WHEN finra_reportable_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations reportable to FINRA"
    - name: "terminations_regulatory_reportable"
      expr: COUNT(DISTINCT CASE WHEN regulatory_reportable_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations reportable to regulatory authorities"
    - name: "terminations_with_book_transfer"
      expr: COUNT(DISTINCT CASE WHEN book_of_business_transfer_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations with book of business transfer"
    - name: "terminations_with_exit_interview"
      expr: COUNT(DISTINCT CASE WHEN exit_interview_completed_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations with completed exit interview"
    - name: "terminations_severance_eligible"
      expr: COUNT(DISTINCT CASE WHEN severance_eligible_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations eligible for severance"
    - name: "terminations_rehire_eligible"
      expr: COUNT(DISTINCT CASE WHEN rehire_eligible_indicator = TRUE THEN termination_event_id END)
      comment: "Number of terminations eligible for rehire"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_agency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency performance and organizational metrics for distribution management and hierarchical production tracking"
  source: "`life_insurance_ecm`.`agent`.`agency`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of agency (general agency, managing general agency, broker-dealer, etc.)"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current appointment status of the agency"
    - name: "contracting_status"
      expr: contracting_status
      comment: "Current contracting status of the agency"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage for new agencies"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of agency background check"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the agency hierarchy"
    - name: "state_code"
      expr: state_code
      comment: "State where agency is domiciled"
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for the agency"
    - name: "eo_coverage_required_flag"
      expr: eo_coverage_required_flag
      comment: "Whether errors and omissions coverage is required"
    - name: "finra_registration_required_flag"
      expr: finra_registration_required_flag
      comment: "Whether FINRA registration is required"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for agency termination if applicable"
    - name: "appointment_year"
      expr: YEAR(appointment_date)
      comment: "Year the agency was appointed"
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month the agency was appointed"
  measures:
    - name: "total_agencies"
      expr: COUNT(DISTINCT agency_id)
      comment: "Total number of unique agencies"
    - name: "total_annual_production_target"
      expr: SUM(CAST(annual_production_target AS DOUBLE))
      comment: "Total annual production target across all agencies"
    - name: "total_ytd_production"
      expr: SUM(CAST(ytd_production_amount AS DOUBLE))
      comment: "Total year-to-date production across all agencies"
    - name: "total_lifetime_production"
      expr: SUM(CAST(lifetime_production_amount AS DOUBLE))
      comment: "Total lifetime production across all agencies"
    - name: "avg_annual_target_per_agency"
      expr: AVG(CAST(annual_production_target AS DOUBLE))
      comment: "Average annual production target per agency"
    - name: "avg_ytd_production_per_agency"
      expr: AVG(CAST(ytd_production_amount AS DOUBLE))
      comment: "Average year-to-date production per agency"
    - name: "avg_lifetime_production_per_agency"
      expr: AVG(CAST(lifetime_production_amount AS DOUBLE))
      comment: "Average lifetime production per agency"
    - name: "agencies_requiring_eo_coverage"
      expr: COUNT(DISTINCT CASE WHEN eo_coverage_required_flag = TRUE THEN agency_id END)
      comment: "Number of agencies requiring errors and omissions coverage"
    - name: "agencies_requiring_finra"
      expr: COUNT(DISTINCT CASE WHEN finra_registration_required_flag = TRUE THEN agency_id END)
      comment: "Number of agencies requiring FINRA registration"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_program_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incentive program participation metrics for measuring engagement, qualification rates, and award effectiveness"
  source: "`life_insurance_ecm`.`agent`.`program_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current status of program participation (enrolled, active, qualified, disqualified, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Status of qualification for program awards"
    - name: "tier_achieved"
      expr: tier_achieved
      comment: "Tier level achieved in the incentive program"
    - name: "ranking"
      expr: ranking
      comment: "Ranking of participant within the program"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year the producer enrolled in the program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the producer enrolled in the program"
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year the producer qualified for the program"
    - name: "payout_year"
      expr: YEAR(award_payout_date)
      comment: "Year the award was paid out"
  measures:
    - name: "total_participants"
      expr: COUNT(DISTINCT program_participation_id)
      comment: "Total number of unique program participants"
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total award amount paid across all participants"
    - name: "total_qualifying_production"
      expr: SUM(CAST(production_amount_qualifying AS DOUBLE))
      comment: "Total production amount that qualified for awards"
    - name: "avg_award_per_participant"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award amount per participant"
    - name: "avg_qualifying_production_per_participant"
      expr: AVG(CAST(production_amount_qualifying AS DOUBLE))
      comment: "Average qualifying production per participant"
    - name: "participants_qualified"
      expr: COUNT(DISTINCT CASE WHEN qualification_date IS NOT NULL THEN program_participation_id END)
      comment: "Number of participants who qualified for awards"
    - name: "participants_paid"
      expr: COUNT(DISTINCT CASE WHEN award_payout_date IS NOT NULL THEN program_participation_id END)
      comment: "Number of participants who received award payouts"
$$;