-- Metric views for domain: agent | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_producer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the producer (agent) population — workforce size, production performance, compliance posture, and attrition. Used by distribution leadership to steer recruiting, retention, and productivity programs."
  source: "`life_insurance_ecm`.`agent`.`producer`"
  dimensions:
    - name: "producer_type"
      expr: producer_type
      comment: "Classifies the producer as captive, independent, broker, etc. — primary segmentation for workforce analysis."
    - name: "producer_status"
      expr: producer_status
      comment: "Current active/inactive/terminated status of the producer — used to filter active force vs. attrited."
    - name: "contracting_status"
      expr: contracting_status
      comment: "Contracting lifecycle stage of the producer — identifies producers in onboarding vs. fully contracted."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Organizational hierarchy tier (e.g., GA, MGA, agent) — enables roll-up analysis across distribution tiers."
    - name: "state_code"
      expr: state_code
      comment: "State where the producer is domiciled — supports geographic performance and compliance analysis."
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage of the producer — identifies pipeline bottlenecks in agent activation."
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know-Your-Customer verification status — critical compliance dimension for regulatory oversight."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background screening outcome — used to monitor compliance and identify at-risk producers."
    - name: "hire_year_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month the producer was hired — enables cohort analysis of production ramp and retention by vintage."
    - name: "termination_year_month"
      expr: DATE_TRUNC('month', termination_date)
      comment: "Month the producer was terminated — used to track attrition trends over time."
    - name: "eo_coverage_indicator"
      expr: eo_coverage_indicator
      comment: "Whether the producer carries Errors and Omissions coverage — compliance and risk management dimension."
  measures:
    - name: "total_active_producers"
      expr: COUNT(CASE WHEN producer_status = 'Active' THEN producer_id END)
      comment: "Count of currently active producers — primary workforce size KPI used by distribution leadership to track field force capacity."
    - name: "total_ytd_production_amount"
      expr: SUM(CAST(ytd_production_amount AS DOUBLE))
      comment: "Sum of year-to-date production amounts across all producers — top-line revenue production KPI for executive dashboards."
    - name: "avg_ytd_production_per_producer"
      expr: AVG(CAST(ytd_production_amount AS DOUBLE))
      comment: "Average YTD production amount per producer — measures producer productivity and identifies performance gaps vs. targets."
    - name: "total_lifetime_production_amount"
      expr: SUM(CAST(lifetime_production_amount AS DOUBLE))
      comment: "Sum of lifetime production amounts across all producers — indicates long-term value of the producer force."
    - name: "avg_annual_production_target"
      expr: AVG(CAST(annual_production_target AS DOUBLE))
      comment: "Average annual production target set for producers — benchmarks ambition level of the distribution plan."
    - name: "total_annual_production_target"
      expr: SUM(CAST(annual_production_target AS DOUBLE))
      comment: "Total annual production target across all producers — used to assess aggregate goal vs. actual YTD production."
    - name: "ytd_production_target_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(ytd_production_amount AS DOUBLE)) / NULLIF(SUM(CAST(annual_production_target AS DOUBLE)), 0), 2)
      comment: "Percentage of annual production target achieved YTD across the producer population — primary performance-to-plan KPI for QBRs."
    - name: "producers_with_eo_coverage_count"
      expr: COUNT(CASE WHEN eo_coverage_indicator = TRUE THEN producer_id END)
      comment: "Count of producers with active E&O coverage — compliance KPI; gaps trigger regulatory and operational risk escalation."
    - name: "eo_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eo_coverage_indicator = TRUE THEN producer_id END) / NULLIF(COUNT(producer_id), 0), 2)
      comment: "Percentage of producers carrying E&O coverage — compliance health metric monitored by compliance and legal leadership."
    - name: "terminated_producer_count"
      expr: COUNT(CASE WHEN producer_status = 'Terminated' THEN producer_id END)
      comment: "Count of terminated producers — attrition volume KPI used to monitor field force stability and trigger retention programs."
    - name: "kyc_verified_producer_count"
      expr: COUNT(CASE WHEN kyc_status = 'Verified' THEN producer_id END)
      comment: "Count of producers with completed KYC verification — regulatory compliance KPI; unverified producers cannot transact."
    - name: "kyc_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Verified' THEN producer_id END) / NULLIF(COUNT(producer_id), 0), 2)
      comment: "Percentage of producers with verified KYC status — AML/compliance health metric reported to compliance officers and regulators."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_production_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial production KPIs aggregated from agent production activity records — covers premium volume, policy counts, product mix, persistency, and placement efficiency. Core dashboard for distribution and product leadership."
  source: "`life_insurance_ecm`.`agent`.`production_activity`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Reporting period granularity (monthly, quarterly, annual) — controls time-series aggregation level."
    - name: "activity_period_start_month"
      expr: DATE_TRUNC('month', activity_period_start_date)
      comment: "Month the activity period begins — primary time dimension for trend analysis of production KPIs."
    - name: "activity_period_end_month"
      expr: DATE_TRUNC('month', activity_period_end_date)
      comment: "Month the activity period ends — used alongside start month to define reporting windows."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel (e.g., direct, broker, bank) — critical segmentation for channel profitability and strategy decisions."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Organizational hierarchy tier of the producing unit — enables roll-up from agent to GA to MGA level."
    - name: "activity_status"
      expr: activity_status
      comment: "Status of the production activity record — used to filter finalized vs. pending activity."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the production record — used for data lineage and reconciliation."
  measures:
    - name: "total_premium_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium written across all product lines — top-line revenue KPI for distribution and finance leadership."
    - name: "total_first_year_premium_amount"
      expr: SUM(CAST(first_year_premium_amount AS DOUBLE))
      comment: "Sum of first-year premiums — measures new business production, the primary growth driver for life insurance."
    - name: "total_renewal_premium_amount"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Sum of renewal premiums — measures in-force book retention and recurring revenue quality."
    - name: "total_face_amount"
      expr: SUM(CAST(total_face_amount AS DOUBLE))
      comment: "Total face amount (death benefit) of policies written — measures risk exposure and production volume in insurance terms."
    - name: "total_ape_amount"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Sum of Annualized Premium Equivalent — industry-standard production metric normalizing single and regular premiums for cross-product comparison."
    - name: "total_commission_earned_amount"
      expr: SUM(CAST(commission_earned_amount AS DOUBLE))
      comment: "Total commissions earned by producers — distribution cost KPI used by finance to manage expense ratios."
    - name: "total_bonus_earned_amount"
      expr: SUM(CAST(bonus_earned_amount AS DOUBLE))
      comment: "Total bonus compensation earned — incentive cost KPI used alongside production to evaluate ROI of bonus programs."
    - name: "avg_placement_rate"
      expr: AVG(CAST(placement_rate AS DOUBLE))
      comment: "Average placement rate (issued policies / submitted applications) — quality-of-business KPI; low rates indicate underwriting or NIGO issues."
    - name: "avg_persistency_ratio"
      expr: AVG(CAST(persistency_ratio AS DOUBLE))
      comment: "Average policy persistency ratio — measures how well the in-force book is retained; directly tied to profitability and lapse risk."
    - name: "avg_conservation_rate"
      expr: AVG(CAST(conservation_rate AS DOUBLE))
      comment: "Average conservation rate — measures success in retaining policies that were at risk of lapse or surrender."
    - name: "total_term_life_premium_amount"
      expr: SUM(CAST(term_life_premium_amount AS DOUBLE))
      comment: "Total term life premium written — product-line revenue KPI for product mix and pricing strategy decisions."
    - name: "total_whole_life_premium_amount"
      expr: SUM(CAST(whole_life_premium_amount AS DOUBLE))
      comment: "Total whole life premium written — permanent life product revenue KPI for product mix analysis."
    - name: "total_universal_life_premium_amount"
      expr: SUM(CAST(universal_life_premium_amount AS DOUBLE))
      comment: "Total universal life premium written — flexible premium product revenue KPI."
    - name: "total_iul_premium_amount"
      expr: SUM(CAST(iul_premium_amount AS DOUBLE))
      comment: "Total indexed universal life (IUL) premium written — high-growth product segment KPI tracked by product leadership."
    - name: "total_vul_premium_amount"
      expr: SUM(CAST(vul_premium_amount AS DOUBLE))
      comment: "Total variable universal life (VUL) premium written — securities-based product revenue KPI requiring FINRA oversight."
    - name: "total_annuity_premium_amount"
      expr: SUM(CAST(annuity_premium_amount AS DOUBLE))
      comment: "Total annuity premium written — retirement product revenue KPI for the annuity business segment."
    - name: "commission_to_premium_ratio"
      expr: ROUND(100.0 * SUM(CAST(commission_earned_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Commission expense as a percentage of total premium — distribution cost efficiency KPI; high ratios trigger expense management reviews."
    - name: "first_year_to_total_premium_ratio"
      expr: ROUND(100.0 * SUM(CAST(first_year_premium_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Proportion of total premium from new business — growth vs. renewal mix indicator used in strategic planning."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking agent appointment status, compliance training completion, and appointment lifecycle across states and carriers. Used by compliance and distribution operations to ensure producers are properly appointed before selling."
  source: "`life_insurance_ecm`.`agent`.`appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (Active, Pending, Terminated) — primary filter for active selling authority."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (e.g., life, health, variable) — used to analyze appointment coverage by product line."
    - name: "state_of_appointment"
      expr: state_of_appointment
      comment: "State jurisdiction of the appointment — geographic compliance dimension for multi-state appointment tracking."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel associated with the appointment — enables channel-level compliance analysis."
    - name: "line_of_authority"
      expr: line_of_authority
      comment: "Line of authority granted by the appointment (e.g., Life, Annuity, Variable) — product authorization dimension."
    - name: "appointing_carrier_code"
      expr: appointing_carrier_code
      comment: "Carrier issuing the appointment — used to analyze appointment distribution across carrier relationships."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Organizational hierarchy level of the appointed producer — enables tier-level compliance roll-up."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the appointment became effective — used to track appointment activation velocity."
    - name: "termination_year_month"
      expr: DATE_TRUNC('month', termination_date)
      comment: "Month the appointment was terminated — used to monitor appointment attrition trends."
  measures:
    - name: "total_active_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'Active' THEN appointment_id END)
      comment: "Count of active appointments — measures the breadth of authorized selling capacity across states and carriers."
    - name: "total_appointments"
      expr: COUNT(appointment_id)
      comment: "Total appointment records — baseline volume metric for appointment pipeline and lifecycle tracking."
    - name: "aml_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN anti_money_laundering_training_completed_flag = TRUE THEN appointment_id END) / NULLIF(COUNT(appointment_id), 0), 2)
      comment: "Percentage of appointments with completed AML training — regulatory compliance KPI; non-compliance triggers regulatory sanctions."
    - name: "suitability_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN suitability_training_completed_flag = TRUE THEN appointment_id END) / NULLIF(COUNT(appointment_id), 0), 2)
      comment: "Percentage of appointments with completed suitability training — compliance KPI for annuity and variable product sales authorization."
    - name: "background_check_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN background_check_completed_flag = TRUE THEN appointment_id END) / NULLIF(COUNT(appointment_id), 0), 2)
      comment: "Percentage of appointments with completed background checks — risk and compliance KPI; incomplete checks block appointment activation."
    - name: "terminated_appointment_count"
      expr: COUNT(CASE WHEN appointment_status = 'Terminated' THEN appointment_id END)
      comment: "Count of terminated appointments — attrition and compliance monitoring KPI; spikes may indicate regulatory actions."
    - name: "appointment_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'Active' THEN appointment_id END) / NULLIF(COUNT(appointment_id), 0), 2)
      comment: "Percentage of all appointments that are currently active — measures effectiveness of the appointment pipeline in converting to active selling authority."
    - name: "distinct_states_appointed_count"
      expr: COUNT(DISTINCT state_of_appointment)
      comment: "Number of distinct states with active or historical appointments — measures geographic reach of the distribution force."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License compliance and renewal KPIs for the producer population. Tracks CE hour completion, license status, renewal timeliness, and penalty exposure. Used by compliance operations to prevent unlicensed sales and manage regulatory risk."
  source: "`life_insurance_ecm`.`agent`.`license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (Active, Expired, Suspended, Terminated) — primary compliance filter."
    - name: "license_class"
      expr: license_class
      comment: "Class of license (e.g., Life, Health, Variable) — product authorization dimension for compliance analysis."
    - name: "line_of_authority"
      expr: line_of_authority
      comment: "Line of authority granted by the license — determines which products the producer is authorized to sell."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the license — geographic compliance dimension for multi-state license tracking."
    - name: "ce_compliance_status"
      expr: ce_compliance_status
      comment: "Continuing education compliance status — identifies producers at risk of license lapse due to CE deficiency."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment status linked to the license — used to correlate license and appointment compliance."
    - name: "expiration_year_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the license expires — used to build renewal pipeline and prioritize outreach."
    - name: "late_renewal_penalty_flag"
      expr: late_renewal_penalty_flag
      comment: "Indicates whether a late renewal penalty was assessed — used to track compliance process failures."
  measures:
    - name: "total_active_licenses"
      expr: COUNT(CASE WHEN license_status = 'Active' THEN license_id END)
      comment: "Count of active licenses — measures the licensed selling capacity of the producer force; drops trigger immediate compliance alerts."
    - name: "total_licenses"
      expr: COUNT(license_id)
      comment: "Total license records — baseline volume for license portfolio management."
    - name: "ce_hours_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(ce_hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(ce_hours_required AS DOUBLE)), 0), 2)
      comment: "Percentage of required CE hours completed across all licenses — compliance health KPI; below 100% indicates renewal risk."
    - name: "total_ce_hours_completed"
      expr: SUM(CAST(ce_hours_completed AS DOUBLE))
      comment: "Total CE hours completed across all producers — measures training investment and compliance progress."
    - name: "total_ce_hours_required"
      expr: SUM(CAST(ce_hours_required AS DOUBLE))
      comment: "Total CE hours required across all licenses — denominator for CE compliance rate; used in workforce planning."
    - name: "total_late_renewal_penalty_amount"
      expr: SUM(CAST(late_penalty_amount AS DOUBLE))
      comment: "Total late renewal penalty fees incurred — financial cost of compliance failures; used to justify proactive renewal programs."
    - name: "total_renewal_fee_amount"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total license renewal fees — operational cost KPI for compliance budget planning."
    - name: "licenses_with_late_penalty_count"
      expr: COUNT(CASE WHEN late_renewal_penalty_flag = TRUE THEN license_id END)
      comment: "Count of licenses that incurred late renewal penalties — compliance process quality KPI; high counts indicate systemic renewal management failures."
    - name: "license_active_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN license_status = 'Active' THEN license_id END) / NULLIF(COUNT(license_id), 0), 2)
      comment: "Percentage of licenses in active status — overall license portfolio health metric used by compliance leadership."
    - name: "avg_ce_hours_completed_per_license"
      expr: AVG(CAST(ce_hours_completed AS DOUBLE))
      comment: "Average CE hours completed per license — benchmarks training progress and identifies under-performing cohorts."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_onboarding_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agent onboarding pipeline KPIs tracking case volume, completion rates, NIGO rates, background check outcomes, and compliance training completion. Used by distribution operations to optimize onboarding throughput and reduce time-to-active."
  source: "`life_insurance_ecm`.`agent`.`onboarding_case`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current stage of the onboarding case (Pending, In Review, Approved, Rejected) — primary pipeline status dimension."
    - name: "application_type"
      expr: application_type
      comment: "Type of onboarding application (new, transfer, reinstatement) — used to segment onboarding volume by case type."
    - name: "background_check_result_status"
      expr: background_check_result_status
      comment: "Outcome of the background check (Clear, Adverse, Pending) — risk screening dimension for compliance oversight."
    - name: "background_check_type"
      expr: background_check_type
      comment: "Type of background check performed — used to analyze screening coverage and vendor performance."
    - name: "license_verification_status"
      expr: license_verification_status
      comment: "Status of license verification in the onboarding process — compliance gate dimension."
    - name: "finra_verification_status"
      expr: finra_verification_status
      comment: "FINRA registration verification status — required for variable product authorization."
    - name: "eo_validation_status"
      expr: eo_validation_status
      comment: "E&O coverage validation status — compliance gate for producers requiring E&O coverage."
    - name: "system_provisioning_status"
      expr: system_provisioning_status
      comment: "Status of system access provisioning — operational readiness dimension; delays here block producer activation."
    - name: "application_submission_year_month"
      expr: DATE_TRUNC('month', application_submission_date)
      comment: "Month the onboarding application was submitted — primary time dimension for onboarding pipeline trend analysis."
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Indicates whether the case was flagged as Not In Good Order — quality dimension for application completeness analysis."
    - name: "adverse_action_flag"
      expr: adverse_action_flag
      comment: "Indicates whether an adverse action was taken — risk and compliance dimension for regulatory reporting."
  measures:
    - name: "total_onboarding_cases"
      expr: COUNT(onboarding_case_id)
      comment: "Total onboarding cases submitted — pipeline volume KPI used to track recruiting and activation throughput."
    - name: "approved_onboarding_case_count"
      expr: COUNT(CASE WHEN onboarding_status = 'Approved' THEN onboarding_case_id END)
      comment: "Count of approved onboarding cases — measures successful activation throughput of the onboarding pipeline."
    - name: "onboarding_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_status = 'Approved' THEN onboarding_case_id END) / NULLIF(COUNT(onboarding_case_id), 0), 2)
      comment: "Percentage of onboarding cases approved — pipeline conversion efficiency KPI; low rates indicate quality or compliance issues."
    - name: "nigo_case_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN onboarding_case_id END)
      comment: "Count of cases flagged as Not In Good Order — application quality KPI; high NIGO rates delay activation and increase operational cost."
    - name: "nigo_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN onboarding_case_id END) / NULLIF(COUNT(onboarding_case_id), 0), 2)
      comment: "Percentage of onboarding cases flagged as NIGO — quality-of-submission KPI; drives process improvement and recruiter training initiatives."
    - name: "adverse_action_case_count"
      expr: COUNT(CASE WHEN adverse_action_flag = TRUE THEN onboarding_case_id END)
      comment: "Count of cases resulting in adverse action — risk and regulatory compliance KPI; triggers FCRA reporting obligations."
    - name: "adverse_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_action_flag = TRUE THEN onboarding_case_id END) / NULLIF(COUNT(onboarding_case_id), 0), 2)
      comment: "Percentage of onboarding cases resulting in adverse action — risk screening effectiveness KPI used by compliance leadership."
    - name: "aml_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN aml_training_completed_flag = TRUE THEN onboarding_case_id END) / NULLIF(COUNT(onboarding_case_id), 0), 2)
      comment: "Percentage of onboarding cases with completed AML training — regulatory compliance gate KPI; incomplete training blocks activation."
    - name: "suitability_training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN suitability_training_completed_flag = TRUE THEN onboarding_case_id END) / NULLIF(COUNT(onboarding_case_id), 0), 2)
      comment: "Percentage of onboarding cases with completed suitability training — compliance KPI for annuity and variable product authorization."
    - name: "regulatory_disqualification_count"
      expr: COUNT(CASE WHEN regulatory_disqualification_flag = TRUE THEN onboarding_case_id END)
      comment: "Count of cases with regulatory disqualification flags — critical compliance KPI; disqualified producers cannot be appointed."
    - name: "rejected_case_count"
      expr: COUNT(CASE WHEN onboarding_status = 'Rejected' THEN onboarding_case_id END)
      comment: "Count of rejected onboarding cases — pipeline quality and risk KPI; high rejection rates may indicate recruiting quality issues."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_contracting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract lifecycle KPIs for producer contracting — tracks contract status, NIGO rates, unearned commission exposure, and regulatory reporting compliance. Used by contracting operations and compliance to manage contract quality and regulatory obligations."
  source: "`life_insurance_ecm`.`agent`.`contracting`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (Active, Pending, Terminated, Expired) — primary lifecycle dimension."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., captive, independent, broker) — used to segment contracting volume by distribution model."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Organizational hierarchy level of the contracting producer — enables tier-level contracting analysis."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check outcome for the contracting producer — compliance gate dimension."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "Status of regulatory reporting obligations for the contract — compliance dimension for state notification tracking."
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Indicates whether the contract was flagged as Not In Good Order — application quality dimension."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of contract termination (voluntary, for cause, regulatory) — used to analyze attrition quality and risk."
    - name: "contracting_year_month"
      expr: DATE_TRUNC('month', contracting_date)
      comment: "Month the contract was initiated — primary time dimension for contracting pipeline trend analysis."
    - name: "u5_filing_required_flag"
      expr: u5_filing_required_flag
      comment: "Indicates whether a U5 filing is required upon termination — FINRA regulatory compliance dimension."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN contracting_id END)
      comment: "Count of active producer contracts — measures the contracted distribution force size; drops trigger distribution capacity alerts."
    - name: "total_contracts"
      expr: COUNT(contracting_id)
      comment: "Total contracting records — baseline volume for contracting pipeline management."
    - name: "nigo_contract_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN contracting_id END)
      comment: "Count of contracts flagged as Not In Good Order — contracting quality KPI; high NIGO rates delay producer activation and increase operational cost."
    - name: "nigo_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN contracting_id END) / NULLIF(COUNT(contracting_id), 0), 2)
      comment: "Percentage of contracts flagged as NIGO — quality-of-submission KPI used to drive process improvement in contracting operations."
    - name: "total_unearned_commission_amount"
      expr: SUM(CAST(unearned_commission_amount AS DOUBLE))
      comment: "Total unearned commission liability across terminated contracts — financial risk KPI; large balances require recovery action and impact P&L."
    - name: "avg_unearned_commission_amount"
      expr: AVG(CAST(unearned_commission_amount AS DOUBLE))
      comment: "Average unearned commission per contract — benchmarks commission recovery exposure per terminated producer."
    - name: "unearned_commission_return_count"
      expr: COUNT(CASE WHEN unearned_commission_return_flag = TRUE THEN contracting_id END)
      comment: "Count of contracts requiring unearned commission return — financial recovery KPI tracked by finance and contracting operations."
    - name: "u5_filing_required_count"
      expr: COUNT(CASE WHEN u5_filing_required_flag = TRUE THEN contracting_id END)
      comment: "Count of contracts requiring U5 FINRA filing — regulatory obligation volume KPI; missed filings trigger FINRA sanctions."
    - name: "terminated_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Terminated' THEN contracting_id END)
      comment: "Count of terminated contracts — attrition volume KPI used to monitor distribution force stability."
    - name: "contract_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contract_status = 'Active' THEN contracting_id END) / NULLIF(COUNT(contracting_id), 0), 2)
      comment: "Percentage of all contracts that are currently active — pipeline conversion efficiency KPI for contracting operations."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_termination_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Producer termination KPIs covering attrition volume, for-cause rates, severance exposure, regulatory reporting obligations, and book-of-business transfer activity. Used by HR, compliance, and distribution leadership to manage attrition risk and regulatory obligations."
  source: "`life_insurance_ecm`.`agent`.`termination_event`"
  dimensions:
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (voluntary, involuntary, for cause, regulatory) — primary segmentation for attrition quality analysis."
    - name: "termination_status"
      expr: termination_status
      comment: "Current processing status of the termination event — used to track termination workflow completion."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Coded reason for termination — enables root-cause analysis of attrition patterns."
    - name: "initiated_by"
      expr: initiated_by
      comment: "Party that initiated the termination (producer, carrier, regulator) — used to distinguish voluntary vs. involuntary attrition."
    - name: "for_cause_indicator"
      expr: for_cause_indicator
      comment: "Indicates whether the termination was for cause — critical risk dimension; for-cause terminations trigger regulatory reporting."
    - name: "regulatory_reportable_indicator"
      expr: regulatory_reportable_indicator
      comment: "Indicates whether the termination must be reported to regulators — compliance dimension for state DOI and FINRA reporting."
    - name: "finra_reportable_indicator"
      expr: finra_reportable_indicator
      comment: "Indicates whether the termination requires FINRA U5 filing — securities compliance dimension."
    - name: "rehire_eligible_indicator"
      expr: rehire_eligible_indicator
      comment: "Indicates whether the terminated producer is eligible for rehire — talent pipeline dimension for future recruiting."
    - name: "termination_effective_year_month"
      expr: DATE_TRUNC('month', termination_effective_date)
      comment: "Month the termination became effective — primary time dimension for attrition trend analysis."
    - name: "book_of_business_transfer_indicator"
      expr: book_of_business_transfer_indicator
      comment: "Indicates whether the producer's book of business was transferred — operational continuity dimension."
  measures:
    - name: "total_termination_events"
      expr: COUNT(termination_event_id)
      comment: "Total termination events — attrition volume KPI used by distribution and HR leadership to monitor field force stability."
    - name: "for_cause_termination_count"
      expr: COUNT(CASE WHEN for_cause_indicator = TRUE THEN termination_event_id END)
      comment: "Count of for-cause terminations — risk and compliance KPI; high counts indicate conduct issues and trigger regulatory scrutiny."
    - name: "for_cause_termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN for_cause_indicator = TRUE THEN termination_event_id END) / NULLIF(COUNT(termination_event_id), 0), 2)
      comment: "Percentage of terminations that were for cause — conduct risk KPI reported to compliance and executive leadership; elevated rates trigger culture and oversight reviews."
    - name: "regulatory_reportable_termination_count"
      expr: COUNT(CASE WHEN regulatory_reportable_indicator = TRUE THEN termination_event_id END)
      comment: "Count of terminations requiring regulatory reporting — compliance obligation volume KPI; missed reports trigger regulatory sanctions."
    - name: "finra_u5_filing_count"
      expr: COUNT(CASE WHEN finra_reportable_indicator = TRUE THEN termination_event_id END)
      comment: "Count of terminations requiring FINRA U5 filing — securities compliance KPI; timely filing is a FINRA regulatory requirement."
    - name: "total_severance_amount"
      expr: SUM(CAST(severance_amount AS DOUBLE))
      comment: "Total severance paid to terminated producers — financial liability KPI used by finance and HR to manage termination costs."
    - name: "avg_severance_amount"
      expr: AVG(CAST(severance_amount AS DOUBLE))
      comment: "Average severance amount per termination event — benchmarks severance cost per departure for budget planning."
    - name: "severance_eligible_termination_count"
      expr: COUNT(CASE WHEN severance_eligible_indicator = TRUE THEN termination_event_id END)
      comment: "Count of terminations where the producer is eligible for severance — financial exposure KPI for HR and finance planning."
    - name: "book_of_business_transfer_count"
      expr: COUNT(CASE WHEN book_of_business_transfer_indicator = TRUE THEN termination_event_id END)
      comment: "Count of terminations with book-of-business transfers — operational continuity KPI; untransferred books represent revenue retention risk."
    - name: "book_transfer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN book_of_business_transfer_indicator = TRUE THEN termination_event_id END) / NULLIF(COUNT(termination_event_id), 0), 2)
      comment: "Percentage of terminations where the book of business was successfully transferred — client retention and revenue continuity KPI."
    - name: "rehire_eligible_count"
      expr: COUNT(CASE WHEN rehire_eligible_indicator = TRUE THEN termination_event_id END)
      comment: "Count of terminated producers eligible for rehire — talent pipeline KPI used by recruiting to identify re-engagement opportunities."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_producer_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance and investment KPIs for the producer population — tracks CE credit completion, training cost, pass rates, waiver usage, and compliance requirement fulfillment. Used by compliance and training operations to ensure producers meet regulatory and product training obligations."
  source: "`life_insurance_ecm`.`agent`.`producer_training`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (Completed, In Progress, Failed, Waived) — primary training pipeline dimension."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (CE, product, compliance, suitability) — used to segment training volume by regulatory vs. product requirement."
    - name: "training_category"
      expr: training_category
      comment: "Category of training content — enables analysis of training investment by subject area."
    - name: "training_delivery_method"
      expr: training_delivery_method
      comment: "Delivery method (online, classroom, webinar) — used to analyze training channel effectiveness and cost."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Type of compliance requirement the training fulfills — links training to specific regulatory obligations."
    - name: "pass_fail_indicator"
      expr: pass_fail_indicator
      comment: "Pass or fail outcome of the training — quality dimension for training effectiveness analysis."
    - name: "state_of_credit"
      expr: state_of_credit
      comment: "State for which CE credit is awarded — geographic compliance dimension for multi-state CE tracking."
    - name: "training_completion_year_month"
      expr: DATE_TRUNC('month', training_completion_date)
      comment: "Month training was completed — primary time dimension for training throughput trend analysis."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Indicates whether a training waiver was granted — compliance exception dimension; high waiver rates may indicate process gaps."
    - name: "compliance_requirement_met"
      expr: compliance_requirement_met
      comment: "Indicates whether the training fulfilled the compliance requirement — primary compliance outcome dimension."
  measures:
    - name: "total_training_records"
      expr: COUNT(producer_training_id)
      comment: "Total training records — baseline volume KPI for training program throughput and capacity planning."
    - name: "compliance_requirement_met_count"
      expr: COUNT(CASE WHEN compliance_requirement_met = TRUE THEN producer_training_id END)
      comment: "Count of training records where the compliance requirement was fulfilled — regulatory compliance achievement KPI."
    - name: "compliance_requirement_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirement_met = TRUE THEN producer_training_id END) / NULLIF(COUNT(producer_training_id), 0), 2)
      comment: "Percentage of training records fulfilling their compliance requirement — overall training compliance health KPI reported to compliance leadership."
    - name: "total_ce_credit_hours_awarded"
      expr: SUM(CAST(ce_credit_hours_awarded AS DOUBLE))
      comment: "Total CE credit hours awarded across all training records — measures regulatory CE obligation fulfillment volume."
    - name: "avg_completion_score"
      expr: AVG(CAST(completion_score AS DOUBLE))
      comment: "Average training completion score — measures training quality and knowledge retention across the producer population."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_indicator = 'Pass' THEN producer_training_id END) / NULLIF(COUNT(producer_training_id), 0), 2)
      comment: "Percentage of training attempts resulting in a pass — training effectiveness KPI; low pass rates trigger curriculum review."
    - name: "total_training_cost_amount"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training cost incurred — financial investment KPI used by finance and training leadership to manage training budgets."
    - name: "avg_training_cost_per_record"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average training cost per training record — cost efficiency KPI used to benchmark training delivery methods and vendors."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN producer_training_id END)
      comment: "Count of training waivers granted — compliance exception KPI; high waiver counts may indicate systemic compliance gaps or process abuse."
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN producer_training_id END) / NULLIF(COUNT(producer_training_id), 0), 2)
      comment: "Percentage of training records where a waiver was granted — compliance exception rate KPI; elevated rates trigger compliance program review."
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours — used to benchmark training program intensity and plan producer time commitments."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`agent_agency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency-level production, contracting, and compliance KPIs. Used by distribution leadership to evaluate agency performance, contracting health, and production target attainment across the agency network."
  source: "`life_insurance_ecm`.`agent`.`agency`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of agency (GA, MGA, IMO, etc.) — primary segmentation for agency network analysis."
    - name: "contracting_status"
      expr: contracting_status
      comment: "Current contracting status of the agency — lifecycle dimension for agency activation and attrition tracking."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment status of the agency — compliance dimension for authorized selling capacity."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Organizational hierarchy tier of the agency — enables roll-up analysis across distribution tiers."
    - name: "state_code"
      expr: state_code
      comment: "State where the agency is domiciled — geographic performance and compliance dimension."
    - name: "domicile_state"
      expr: domicile_state
      comment: "Domicile state of the agency — used for regulatory jurisdiction analysis."
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage of the agency — pipeline dimension for agency activation tracking."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status of the agency — compliance gate dimension."
    - name: "appointment_year_month"
      expr: DATE_TRUNC('month', appointment_date)
      comment: "Month the agency was appointed — used for cohort analysis of agency production ramp."
    - name: "eo_coverage_required_flag"
      expr: eo_coverage_required_flag
      comment: "Indicates whether E&O coverage is required for the agency — compliance dimension."
  measures:
    - name: "total_agencies"
      expr: COUNT(agency_id)
      comment: "Total agency count — baseline network size KPI for distribution capacity planning."
    - name: "total_ytd_production_amount"
      expr: SUM(CAST(ytd_production_amount AS DOUBLE))
      comment: "Sum of YTD production amounts across all agencies — top-line agency network revenue KPI for executive dashboards."
    - name: "total_lifetime_production_amount"
      expr: SUM(CAST(lifetime_production_amount AS DOUBLE))
      comment: "Sum of lifetime production amounts across all agencies — measures long-term value of the agency network."
    - name: "total_annual_production_target"
      expr: SUM(CAST(annual_production_target AS DOUBLE))
      comment: "Total annual production target across all agencies — aggregate goal for distribution planning."
    - name: "ytd_production_target_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(ytd_production_amount AS DOUBLE)) / NULLIF(SUM(CAST(annual_production_target AS DOUBLE)), 0), 2)
      comment: "Percentage of annual production target achieved YTD across the agency network — primary performance-to-plan KPI for QBRs and board reporting."
    - name: "avg_ytd_production_per_agency"
      expr: AVG(CAST(ytd_production_amount AS DOUBLE))
      comment: "Average YTD production per agency — productivity benchmark used to identify high and low performers in the agency network."
    - name: "active_agency_count"
      expr: COUNT(CASE WHEN contracting_status = 'Active' THEN agency_id END)
      comment: "Count of actively contracted agencies — measures the active distribution network size."
    - name: "agency_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contracting_status = 'Active' THEN agency_id END) / NULLIF(COUNT(agency_id), 0), 2)
      comment: "Percentage of agencies with active contracting status — network health KPI measuring how much of the agency portfolio is actively producing."
$$;