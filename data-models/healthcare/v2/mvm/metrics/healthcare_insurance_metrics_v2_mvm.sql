-- Metric views for domain: insurance | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment KPIs tracking active membership, premium revenue, subsidy exposure, and enrollment channel mix. Used by VP of Enrollment Operations and CFO to monitor membership growth, premium yield, and subsidy liability."
  source: "`vibe_healthcare_v1`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Pending) — primary segmentation for membership reporting."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment event (New, Renewal, COBRA, Special Enrollment) — used to analyze enrollment mix and channel strategy."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (Exchange, Employer, Direct, Broker) — drives channel ROI analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier selected by the member (Individual, Family, Employee+Spouse, etc.) — key driver of premium revenue segmentation."
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current premium payment status (Paid, Delinquent, Grace Period) — critical for lapse risk monitoring."
    - name: "premium_payment_frequency"
      expr: premium_payment_frequency
      comment: "Frequency of premium payments (Monthly, Quarterly, Annual) — used in cash flow forecasting."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied (APTC, CSR, Medicaid, None) — used for regulatory reporting and subsidy liability tracking."
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "Indicates whether the enrollment is under COBRA continuation coverage — used to track COBRA population size and risk."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for enrollment termination (Non-Payment, Voluntary, Aging Off, etc.) — used to analyze churn drivers."
    - name: "enrollment_effective_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Month of enrollment effective date — used for cohort and trend analysis of new enrollments."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start_date)
      comment: "Month the benefit period begins — used for benefit year planning and renewal cycle analysis."
    - name: "enrollment_source_system"
      expr: enrollment_source_system
      comment: "Source system that originated the enrollment record — used for data quality and system integration monitoring."
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Member's relationship to the subscriber (Self, Spouse, Child, Dependent) — used for household-level enrollment analysis."
  measures:
    - name: "total_enrolled_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Total count of distinct enrolled members (by MPI record). Core membership census metric used in all executive dashboards."
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue across all enrollment records. Primary top-line revenue KPI for the insurance business."
    - name: "avg_premium_per_member"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per enrollment record. Used to track premium yield trends and pricing effectiveness."
    - name: "total_subsidy_liability"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount across all enrollments. Tracks government subsidy exposure and regulatory financial liability."
    - name: "avg_subsidy_per_member"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per enrollment. Used to assess subsidy dependency and ACA compliance cost per member."
    - name: "cobra_enrollment_count"
      expr: COUNT(CASE WHEN cobra_indicator = TRUE THEN member_enrollment_id END)
      comment: "Count of active COBRA enrollments. Tracks COBRA population size, which carries elevated claims risk and administrative cost."
    - name: "delinquent_premium_enrollment_count"
      expr: COUNT(CASE WHEN premium_payment_status = 'Delinquent' THEN member_enrollment_id END)
      comment: "Count of enrollments with delinquent premium payments. Leading indicator of membership lapse and revenue at risk."
    - name: "terminated_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Terminated' THEN member_enrollment_id END)
      comment: "Count of terminated enrollments. Used to calculate churn rate and assess membership retention performance."
    - name: "total_enrollment_records"
      expr: COUNT(1)
      comment: "Total enrollment record count (all statuses). Baseline denominator for enrollment rate and mix calculations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health plan portfolio KPIs covering cost-sharing design, deductible and OOP exposure, and plan mix. Used by Actuarial, Product, and Finance teams to evaluate plan design competitiveness and financial risk."
  source: "`vibe_healthcare_v1`.`insurance`.`health_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (HMO, PPO, EPO, HDHP, POS) — primary segmentation for plan portfolio analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the health plan (Active, Inactive, Pending) — used to filter active plan portfolio."
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) — key dimension for regulatory reporting and actuarial value analysis."
    - name: "funding_type"
      expr: funding_type
      comment: "Plan funding type (Fully Insured, Self-Funded, Level-Funded) — drives financial risk and regulatory treatment."
    - name: "issuer_state"
      expr: issuer_state
      comment: "State where the plan is issued — used for geographic market analysis and state regulatory compliance."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year of the plan — used for year-over-year plan design and cost-sharing trend analysis."
    - name: "hsa_eligible"
      expr: hsa_eligible
      comment: "Indicates whether the plan is HSA-eligible — used to track HDHP/HSA adoption and consumer-directed health strategy."
    - name: "out_of_network_coverage"
      expr: out_of_network_coverage
      comment: "Indicates whether the plan covers out-of-network services — key plan design differentiator affecting member choice."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether the plan requires prior authorization — used to assess administrative burden and utilization management intensity."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the plan became effective — used for plan vintage and lifecycle analysis."
  measures:
    - name: "total_active_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN health_plan_id END)
      comment: "Count of currently active health plans in the portfolio. Core plan inventory metric for product management."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount across plans. Used by actuarial and product teams to benchmark cost-sharing design."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount across plans. Tracks family cost-sharing burden and plan competitiveness."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(individual_oop_max_amount AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across plans. Key actuarial metric for catastrophic risk exposure per member."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(family_oop_max_amount AS DOUBLE))
      comment: "Average family out-of-pocket maximum across plans. Tracks maximum financial exposure for family units."
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(primary_care_copay_amount AS DOUBLE))
      comment: "Average primary care copay across plans. Used to assess access barriers and plan design competitiveness for primary care utilization."
    - name: "avg_specialist_copay"
      expr: AVG(CAST(specialist_copay_amount AS DOUBLE))
      comment: "Average specialist copay across plans. Tracks specialist access cost and its impact on referral patterns."
    - name: "avg_emergency_room_copay"
      expr: AVG(CAST(emergency_room_copay_amount AS DOUBLE))
      comment: "Average emergency room copay across plans. Used to evaluate ER cost-sharing design and its effect on appropriate utilization."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans. Tracks member cost-sharing burden after deductible and informs actuarial value calculations."
    - name: "hsa_eligible_plan_count"
      expr: COUNT(CASE WHEN hsa_eligible = TRUE THEN health_plan_id END)
      comment: "Count of HSA-eligible plans. Tracks consumer-directed health plan strategy and HDHP portfolio depth."
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total count of health plan records. Baseline denominator for plan mix and portfolio composition analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber-level KPIs tracking coverage status, premium yield, dual eligibility, and COBRA exposure. Used by Member Services, Finance, and Compliance to manage subscriber lifecycle and revenue integrity."
  source: "`vibe_healthcare_v1`.`insurance`.`subscriber`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status of the subscriber (Active, Terminated, Suspended) — primary filter for active membership reporting."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage held by the subscriber (Medical, Dental, Vision, Pharmacy) — used for product line analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier assigned to the subscriber — used to analyze network utilization and tiered benefit design effectiveness."
    - name: "gender"
      expr: gender
      comment: "Subscriber gender — used for demographic segmentation in actuarial and population health analysis."
    - name: "state"
      expr: state
      comment: "Subscriber state of residence — used for geographic market analysis and state regulatory compliance."
    - name: "dual_eligible_flag"
      expr: dual_eligible_flag
      comment: "Indicates Medicare-Medicaid dual eligibility — critical for risk adjustment, care coordination, and regulatory reporting."
    - name: "medicare_eligible_flag"
      expr: medicare_eligible_flag
      comment: "Indicates Medicare eligibility — used to identify Medicare Advantage population and coordination of benefits requirements."
    - name: "medicaid_eligible_flag"
      expr: medicaid_eligible_flag
      comment: "Indicates Medicaid eligibility — used for Medicaid managed care population tracking and regulatory reporting."
    - name: "cobra_eligible_flag"
      expr: cobra_eligible_flag
      comment: "Indicates COBRA eligibility — used to track COBRA-eligible population and associated premium risk."
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of premium billing (Monthly, Quarterly, Annual) — used for cash flow forecasting and billing operations."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for coverage termination — used to analyze churn drivers and retention intervention opportunities."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year coverage became effective — used for subscriber vintage cohort analysis."
  measures:
    - name: "total_active_subscribers"
      expr: COUNT(CASE WHEN coverage_status = 'Active' THEN subscriber_id END)
      comment: "Count of active subscribers. Core membership census KPI used in all executive and regulatory reporting."
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all subscribers. Primary revenue metric for the subscriber book of business."
    - name: "avg_premium_per_subscriber"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per subscriber. Tracks premium yield and pricing effectiveness across the subscriber base."
    - name: "dual_eligible_subscriber_count"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE THEN subscriber_id END)
      comment: "Count of dual-eligible (Medicare + Medicaid) subscribers. Critical for risk adjustment revenue and care management program sizing."
    - name: "cobra_subscriber_count"
      expr: COUNT(CASE WHEN cobra_eligible_flag = TRUE THEN subscriber_id END)
      comment: "Count of COBRA-eligible subscribers. Tracks COBRA population which carries higher claims risk and administrative cost."
    - name: "total_subscriber_count"
      expr: COUNT(1)
      comment: "Total subscriber record count. Baseline denominator for subscriber mix and penetration rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_payer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer contract KPIs tracking reimbursement rates, contract status, risk arrangements, and quality incentive eligibility. Used by Contracting, Finance, and Network Management to optimize payer relationships and revenue cycle performance."
  source: "`vibe_healthcare_v1`.`insurance`.`payer_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the payer contract (Active, Expired, Pending, Terminated) — primary filter for active contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of payer contract (Fee-for-Service, Capitation, Bundled Payment, Value-Based) — key dimension for reimbursement model analysis."
    - name: "reimbursement_method"
      expr: reimbursement_method
      comment: "Reimbursement methodology (FFS, Per Diem, Case Rate, Capitation) — used to analyze payment model mix and financial risk."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (Full Risk, Shared Savings, Upside Only) — used to track value-based care contract maturity."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of the contract (Preferred, Standard, Out-of-Network) — used for tiered network strategy analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the contract applies — used for geographic market and regulatory compliance analysis."
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Indicates whether the contract includes quality bonus provisions — used to track value-based incentive contract penetration."
    - name: "quality_penalty_eligible"
      expr: quality_penalty_eligible
      comment: "Indicates whether the contract includes quality penalty provisions — used to assess downside risk exposure."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — used for contract management and renewal pipeline planning."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective — used for contract vintage and lifecycle analysis."
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year the contract terminates — used for contract expiration pipeline and renewal planning."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN payer_contract_id END)
      comment: "Count of active payer contracts. Core contracting portfolio metric used by Network Management and Finance."
    - name: "avg_base_reimbursement_percentage"
      expr: AVG(CAST(base_reimbursement_percentage AS DOUBLE))
      comment: "Average base reimbursement percentage across contracts. Key financial metric for assessing payer reimbursement adequacy and negotiation outcomes."
    - name: "total_stop_loss_threshold"
      expr: SUM(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Total stop-loss threshold exposure across all contracts. Used by Finance and Actuarial to quantify maximum risk retention under current contract portfolio."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Average stop-loss threshold per contract. Used to benchmark risk retention levels and inform reinsurance purchasing decisions."
    - name: "quality_bonus_eligible_contract_count"
      expr: COUNT(CASE WHEN quality_bonus_eligible = TRUE THEN payer_contract_id END)
      comment: "Count of contracts with quality bonus provisions. Tracks value-based contract penetration and potential upside revenue from quality performance."
    - name: "value_based_contract_count"
      expr: COUNT(CASE WHEN risk_arrangement_type IS NOT NULL AND risk_arrangement_type != 'None' THEN payer_contract_id END)
      comment: "Count of contracts with a risk arrangement (value-based contracts). Tracks the organization's transition from fee-for-service to value-based care."
    - name: "expiring_contracts_count"
      expr: COUNT(CASE WHEN termination_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN payer_contract_id END)
      comment: "Count of contracts expiring within the next 90 days. Critical operational metric for contract renewal pipeline management."
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total payer contract record count. Baseline denominator for contract mix and portfolio composition analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_fee_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule line-level KPIs tracking contracted rates, RVU values, reimbursement ranges, and rate adequacy. Used by Revenue Cycle, Contracting, and Finance to monitor reimbursement rates and identify underpayment risk."
  source: "`vibe_healthcare_v1`.`insurance`.`fee_schedule_line`"
  dimensions:
    - name: "fee_schedule_line_status"
      expr: fee_schedule_line_status
      comment: "Status of the fee schedule line (Active, Inactive, Superseded) — used to filter to current active rates."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for the rate calculation (RVU, Per Diem, Case Rate, Percent of Charges) — key dimension for reimbursement model analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility where service is rendered (Inpatient, Outpatient, ASC) — used for site-of-care rate analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code — used to analyze rate variation by care setting."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Indicates whether prior authorization is required for this service line — used to assess administrative burden by service category."
    - name: "assistant_surgeon_allowed"
      expr: assistant_surgeon_allowed
      comment: "Indicates whether an assistant surgeon is allowed and reimbursable — used for surgical service line analysis."
    - name: "quality_reporting_required"
      expr: quality_reporting_required
      comment: "Indicates whether quality reporting is required for this service line — used to track quality-linked reimbursement obligations."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the fee schedule line became effective — used for rate trend and vintage analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code associated with the service line — used for revenue code-level rate analysis and billing compliance."
  measures:
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Average contracted rate amount across fee schedule lines. Primary metric for assessing reimbursement adequacy and payer negotiation outcomes."
    - name: "total_contracted_rate_value"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total contracted rate value across all active fee schedule lines. Used to quantify total contracted revenue potential in the fee schedule portfolio."
    - name: "avg_rvu_total"
      expr: AVG(CAST(rvu_total AS DOUBLE))
      comment: "Average total RVU value per fee schedule line. Used by Finance and Contracting to benchmark RVU-based reimbursement against Medicare rates."
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVU per fee schedule line. Tracks physician work intensity component of reimbursement — key input for provider compensation modeling."
    - name: "avg_percent_of_medicare"
      expr: AVG(CAST(percent_of_medicare AS DOUBLE))
      comment: "Average reimbursement as a percentage of Medicare rates. Critical benchmarking metric for assessing payer rate adequacy relative to Medicare baseline."
    - name: "avg_maximum_reimbursement"
      expr: AVG(CAST(maximum_reimbursement AS DOUBLE))
      comment: "Average maximum reimbursement cap per fee schedule line. Used to identify rate ceiling constraints that may limit revenue capture."
    - name: "avg_minimum_reimbursement"
      expr: AVG(CAST(minimum_reimbursement AS DOUBLE))
      comment: "Average minimum reimbursement floor per fee schedule line. Used to ensure contracted rates meet cost floor thresholds."
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average RVU conversion factor across fee schedule lines. Used to compare conversion factors across payers and identify negotiation opportunities."
    - name: "total_fee_schedule_lines"
      expr: COUNT(1)
      comment: "Total count of fee schedule line records. Baseline denominator for rate coverage and completeness analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_prior_auth_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization rule KPIs tracking PA requirement coverage, auto-approval eligibility, turnaround time standards, and step therapy burden. Used by Medical Management, Compliance, and Operations to manage utilization management program design and administrative efficiency."
  source: "`vibe_healthcare_v1`.`insurance`.`prior_auth_rule`"
  dimensions:
    - name: "prior_auth_rule_status"
      expr: prior_auth_rule_status
      comment: "Current status of the prior auth rule (Active, Inactive, Superseded) — used to filter to currently enforced rules."
    - name: "pa_requirement_type"
      expr: pa_requirement_type
      comment: "Type of PA requirement (Standard, Urgent, Retrospective, Concurrent) — used to analyze PA program complexity and administrative burden."
    - name: "service_category"
      expr: service_category
      comment: "Clinical service category subject to the PA rule (Imaging, Surgery, Behavioral Health, Pharmacy) — used for utilization management program analysis."
    - name: "auto_approval_eligible"
      expr: auto_approval_eligible
      comment: "Indicates whether the rule allows auto-approval — used to track automation rate and administrative efficiency of the PA program."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicates whether step therapy is required — used to assess step therapy program scope and member access implications."
    - name: "submission_method"
      expr: submission_method
      comment: "Method for PA submission (Portal, Fax, Phone, EDI) — used to track electronic submission adoption and operational efficiency."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code for the PA rule — used to analyze PA requirements by care setting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the PA rule became effective — used for rule vintage and program evolution analysis."
    - name: "gender_restriction"
      expr: gender_restriction
      comment: "Gender restriction applied by the PA rule — used for equity analysis and compliance with non-discrimination requirements."
  measures:
    - name: "total_active_pa_rules"
      expr: COUNT(CASE WHEN prior_auth_rule_status = 'Active' THEN prior_auth_rule_id END)
      comment: "Count of currently active prior authorization rules. Tracks the scope and complexity of the utilization management program."
    - name: "auto_approval_eligible_rule_count"
      expr: COUNT(CASE WHEN auto_approval_eligible = TRUE THEN prior_auth_rule_id END)
      comment: "Count of PA rules eligible for auto-approval. Tracks automation potential in the PA program — higher auto-approval rates reduce administrative cost and member friction."
    - name: "step_therapy_rule_count"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN prior_auth_rule_id END)
      comment: "Count of PA rules requiring step therapy. Tracks step therapy program scope — used by Medical Management and Pharmacy to assess access barriers and regulatory compliance."
    - name: "avg_quantity_limit"
      expr: AVG(CAST(quantity_limit AS DOUBLE))
      comment: "Average quantity limit across PA rules that have quantity restrictions. Used to benchmark utilization management stringency for pharmacy and procedure rules."
    - name: "total_pa_rule_count"
      expr: COUNT(1)
      comment: "Total count of prior authorization rule records. Baseline denominator for PA program coverage and rule density analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_provider_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider network KPIs tracking network adequacy, provider counts, telehealth enablement, and network status. Used by Network Management, Compliance, and Regulatory Affairs to ensure network adequacy standards and CMS filing compliance."
  source: "`vibe_healthcare_v1`.`insurance`.`provider_network`"
  dimensions:
    - name: "network_status"
      expr: network_status
      comment: "Current status of the provider network (Active, Inactive, Pending) — primary filter for active network portfolio."
    - name: "network_type"
      expr: network_type
      comment: "Type of provider network (HMO, PPO, EPO, POS, Narrow) — key dimension for network design and product strategy analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (Preferred, Standard, Broad) — used for tiered network strategy and member cost-sharing analysis."
    - name: "network_model"
      expr: network_model
      comment: "Network model type (Staff, Group, IPA, Mixed) — used for network structure and risk arrangement analysis."
    - name: "network_adequacy_status"
      expr: network_adequacy_status
      comment: "CMS/state network adequacy status (Adequate, Deficient, Under Review) — critical regulatory compliance dimension."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the network is currently active — used for operational network inventory filtering."
    - name: "telehealth_enabled_flag"
      expr: telehealth_enabled_flag
      comment: "Indicates whether the network supports telehealth services — used to track telehealth-enabled network coverage and digital care strategy."
    - name: "behavioral_health_included_flag"
      expr: behavioral_health_included_flag
      comment: "Indicates whether behavioral health services are included in the network — used for mental health parity compliance and network adequacy analysis."
    - name: "cms_filing_status"
      expr: cms_filing_status
      comment: "CMS filing status for the network (Filed, Approved, Pending, Rejected) — used for regulatory compliance tracking."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (County, State, Regional, National) — used for geographic coverage analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the network became effective — used for network vintage and lifecycle analysis."
  measures:
    - name: "total_active_networks"
      expr: COUNT(CASE WHEN is_active = TRUE THEN provider_network_id END)
      comment: "Count of currently active provider networks. Core network portfolio metric used by Network Management and Regulatory Affairs."
    - name: "adequate_network_count"
      expr: COUNT(CASE WHEN network_adequacy_status = 'Adequate' THEN provider_network_id END)
      comment: "Count of networks meeting adequacy standards. Critical regulatory compliance metric — inadequate networks trigger CMS corrective action and member access issues."
    - name: "telehealth_enabled_network_count"
      expr: COUNT(CASE WHEN telehealth_enabled_flag = TRUE THEN provider_network_id END)
      comment: "Count of networks with telehealth capabilities. Tracks digital care access strategy and telehealth network penetration."
    - name: "behavioral_health_network_count"
      expr: COUNT(CASE WHEN behavioral_health_included_flag = TRUE THEN provider_network_id END)
      comment: "Count of networks including behavioral health services. Used for mental health parity compliance and behavioral health access reporting."
    - name: "networks_pending_cms_approval"
      expr: COUNT(CASE WHEN cms_filing_status = 'Pending' THEN provider_network_id END)
      comment: "Count of networks with pending CMS filing approval. Tracks regulatory pipeline and potential compliance risk from unapproved networks."
    - name: "total_network_count"
      expr: COUNT(1)
      comment: "Total count of provider network records. Baseline denominator for network portfolio composition and adequacy rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit design KPIs tracking cost-sharing parameters, coverage limits, and benefit program characteristics. Used by Product, Actuarial, and Compliance teams to analyze benefit design competitiveness, essential health benefit compliance, and formulary structure."
  source: "`vibe_healthcare_v1`.`insurance`.`benefit`"
  dimensions:
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit (Active, Inactive, Pending) — primary filter for active benefit catalog."
    - name: "category"
      expr: category
      comment: "Benefit category (Medical, Pharmacy, Dental, Vision, Behavioral Health) — primary segmentation for benefit portfolio analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Benefit subcategory for granular service-level analysis within each category."
    - name: "network_type"
      expr: network_type
      comment: "Network type applicable to the benefit (In-Network, Out-of-Network, Both) — used for network benefit design analysis."
    - name: "cost_sharing_tier"
      expr: cost_sharing_tier
      comment: "Cost-sharing tier for the benefit — used to analyze tiered benefit design and member cost exposure."
    - name: "essential_health_benefit_flag"
      expr: essential_health_benefit_flag
      comment: "Indicates whether the benefit is an ACA Essential Health Benefit — critical for regulatory compliance and plan certification."
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Indicates whether prior authorization is required for this benefit — used to assess utilization management burden by benefit type."
    - name: "preventive_care_flag"
      expr: preventive_care_flag
      comment: "Indicates whether the benefit is a preventive care service — used for ACA preventive care compliance and population health strategy."
    - name: "deductible_applies_flag"
      expr: deductible_applies_flag
      comment: "Indicates whether the deductible applies to this benefit — used for benefit design analysis and member cost-sharing modeling."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier for pharmacy benefits (Tier 1-4, Specialty) — used for pharmacy benefit design and drug cost management analysis."
    - name: "hsa_eligible_flag"
      expr: hsa_eligible_flag
      comment: "Indicates whether the benefit is HSA-eligible — used for HDHP/HSA plan design compliance analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the benefit became effective — used for benefit design vintage and year-over-year change analysis."
  measures:
    - name: "total_active_benefits"
      expr: COUNT(CASE WHEN benefit_status = 'Active' THEN benefit_id END)
      comment: "Count of currently active benefits in the benefit catalog. Core benefit inventory metric for product management and compliance."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across benefits. Used by Actuarial and Product teams to benchmark member cost-sharing levels and plan competitiveness."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across benefits. Tracks member cost-sharing burden and informs actuarial value calculations."
    - name: "avg_coverage_percentage"
      expr: AVG(CAST(coverage_percentage AS DOUBLE))
      comment: "Average coverage percentage across benefits. Key metric for assessing plan generosity and actuarial value across the benefit portfolio."
    - name: "avg_dollar_limit_amount"
      expr: AVG(CAST(dollar_limit_amount AS DOUBLE))
      comment: "Average dollar limit per benefit. Used to assess benefit cap exposure and mental health parity compliance (dollar limits on behavioral health vs. medical benefits)."
    - name: "essential_health_benefit_count"
      expr: COUNT(CASE WHEN essential_health_benefit_flag = TRUE THEN benefit_id END)
      comment: "Count of Essential Health Benefits in the catalog. Critical ACA compliance metric — plans must cover all 10 EHB categories."
    - name: "prior_auth_required_benefit_count"
      expr: COUNT(CASE WHEN prior_authorization_required_flag = TRUE THEN benefit_id END)
      comment: "Count of benefits requiring prior authorization. Tracks utilization management program scope and administrative burden on members and providers."
    - name: "total_benefit_count"
      expr: COUNT(1)
      comment: "Total count of benefit records. Baseline denominator for benefit mix and coverage completeness analysis."
$$;