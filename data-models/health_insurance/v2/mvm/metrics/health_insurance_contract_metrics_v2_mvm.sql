-- Metric views for domain: contract | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for capitation arrangements — tracks PMPM rates, risk-sharing economics, stop-loss thresholds, and withhold percentages to steer value-based care financial performance."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of capitation arrangement (e.g., global, professional, institutional) — primary segmentation for rate and risk analysis."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current lifecycle status of the arrangement (e.g., active, terminated, pending) — used to filter operational vs. historical views."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (e.g., Medicare Advantage, Medicaid, Commercial) — critical for regulatory and financial segmentation."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation — used to compare PMPM rates and risk economics across tier levels."
    - name: "payment_methodology_code"
      expr: CAST(payment_methodology AS STRING)
      comment: "Payment methodology code cast to string for grouping — distinguishes capitation, fee-for-service, and hybrid models."
    - name: "geographic_service_area"
      expr: geographic_service_area
      comment: "Geographic service area of the arrangement — enables regional performance comparison."
    - name: "aco_arrangement_flag"
      expr: aco_arrangement_flag
      comment: "Indicates whether the arrangement is part of an ACO — used to isolate ACO-specific financial metrics."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Indicates whether the arrangement is a value-based care arrangement — key segmentation for VBC program performance."
    - name: "risk_adjustment_applicable"
      expr: risk_adjustment_applicable
      comment: "Whether risk adjustment applies to this arrangement — affects net payment calculations and financial forecasting."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the arrangement became effective — used for year-over-year trend analysis of PMPM rates and risk economics."
    - name: "rate_effective_year"
      expr: DATE_TRUNC('YEAR', rate_effective_date)
      comment: "Year the capitation rate became effective — used to track rate escalation trends over time."
  measures:
    - name: "total_active_arrangements"
      expr: COUNT(CASE WHEN arrangement_status = 'active' THEN capitation_arrangement_id END)
      comment: "Count of active capitation arrangements — baseline KPI for portfolio size and operational scale."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month capitation rate across arrangements — core financial metric for pricing adequacy and competitiveness."
    - name: "total_pmpm_rate_currency_value"
      expr: SUM(CAST(pmpm_rate_currency AS DOUBLE))
      comment: "Total PMPM rate currency value — used to assess aggregate financial exposure across all capitation arrangements."
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk-share percentage across arrangements — measures the degree of financial risk transferred to providers, a key VBC governance metric."
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average quality withhold percentage — tracks the proportion of capitation payments held pending quality performance, informing quality incentive program design."
    - name: "avg_raf_adjustment_factor"
      expr: AVG(CAST(raf_adjustment_factor AS DOUBLE))
      comment: "Average Risk Adjustment Factor (RAF) across arrangements — indicates the acuity-adjusted payment level and risk coding intensity."
    - name: "avg_aggregate_stop_loss_threshold"
      expr: AVG(CAST(aggregate_stop_loss_threshold AS DOUBLE))
      comment: "Average aggregate stop-loss threshold — measures the financial protection ceiling for catastrophic cost exposure across arrangements."
    - name: "avg_individual_stop_loss_threshold"
      expr: AVG(CAST(individual_stop_loss_threshold AS DOUBLE))
      comment: "Average individual stop-loss threshold — measures per-member catastrophic cost protection, critical for reinsurance and risk management decisions."
    - name: "avg_annual_rate_escalator"
      expr: AVG(CAST(annual_rate_escalator AS DOUBLE))
      comment: "Average annual rate escalator across arrangements — tracks built-in rate growth commitments, informing multi-year financial planning."
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total count of capitation arrangement records — denominator for portfolio-level rate and risk averages."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for capitation payments — tracks gross and net payment volumes, quality withholds, stop-loss recoveries, enrollment adjustments, and prior-period corrections to govern payment accuracy and financial integrity."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_payment`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the payment (e.g., Medicare Advantage, Medicaid) — primary financial segmentation dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the payment — required for multi-currency financial reporting."
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Indicates whether the payment is a prior-period adjustment — used to isolate retroactive corrections from current-period payments."
    - name: "vbc_contract_flag"
      expr: vbc_contract_flag
      comment: "Indicates whether the payment is associated with a value-based care contract — enables VBC vs. traditional payment comparison."
    - name: "void_reason"
      expr: void_reason
      comment: "Reason a payment was voided — used to analyze payment error patterns and operational quality."
    - name: "ap_voucher_number"
      expr: ap_voucher_number
      comment: "Accounts payable voucher number — used for payment reconciliation and audit tracing."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross capitation payment amount — top-line financial KPI representing total capitation expenditure before withholds and adjustments."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payment amount after withholds and adjustments — the actual cash outflow, critical for cash management and financial close."
    - name: "total_quality_withhold_amount"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold amount held from capitation payments — measures the financial leverage of quality incentive programs."
    - name: "total_risk_pool_withhold_amount"
      expr: SUM(CAST(risk_pool_withhold_amount AS DOUBLE))
      comment: "Total risk pool withhold amount — tracks funds held in shared risk pools, informing risk-sharing program financial exposure."
    - name: "total_stop_loss_recovery_amount"
      expr: SUM(CAST(stop_loss_recovery_amount AS DOUBLE))
      comment: "Total stop-loss recovery amount — measures reinsurance recoveries, a key indicator of catastrophic cost events and stop-loss program effectiveness."
    - name: "total_enrollment_adjustment_amount"
      expr: SUM(CAST(enrollment_adjustment_amount AS DOUBLE))
      comment: "Total enrollment adjustment amount — tracks payment corrections due to enrollment changes, informing eligibility data quality."
    - name: "avg_pmpm_rate_paid"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average PMPM rate actually paid — compared against contracted PMPM to detect payment accuracy issues."
    - name: "avg_capitation_rate_tier"
      expr: AVG(CAST(capitation_rate_tier AS DOUBLE))
      comment: "Average capitation rate tier value — used to assess the distribution of payments across rate tiers."
    - name: "total_prior_period_adjustment_payments"
      expr: COUNT(CASE WHEN prior_period_adjustment_flag = TRUE THEN capitation_payment_id END)
      comment: "Count of prior-period adjustment payments — high volumes indicate retroactive correction issues, a key operational quality signal."
    - name: "total_payment_records"
      expr: COUNT(1)
      comment: "Total count of capitation payment records — baseline volume metric for payment operations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy and participation KPIs — tracks provider network composition, credentialing status, in-network coverage, and VBC participation to govern network strategy and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`contract`.`contract_network_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status of the provider in the network (e.g., active, terminated, pending) — primary filter for network adequacy analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation — used to analyze participation distribution across preferred, standard, and out-of-network tiers."
    - name: "lob"
      expr: lob
      comment: "Line of business for the network participation — enables network adequacy analysis by product line."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the participation — used to assess network coverage by product offering."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the participating provider — critical for compliance and quality governance."
    - name: "service_area_state"
      expr: service_area_state
      comment: "State of the service area — enables geographic network adequacy analysis by state."
    - name: "service_area_county"
      expr: service_area_county
      comment: "County of the service area — enables sub-state geographic network adequacy analysis."
    - name: "in_network_flag"
      expr: in_network_flag
      comment: "Indicates whether the provider is in-network — used to measure in-network vs. out-of-network participation ratios."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Indicates whether the provider is accepting new patients — key network access metric for member experience and adequacy standards."
    - name: "pcp_assignment_eligible_flag"
      expr: pcp_assignment_eligible_flag
      comment: "Indicates whether the provider is eligible for PCP assignment — used to assess primary care network capacity."
    - name: "aco_participant_flag"
      expr: aco_participant_flag
      comment: "Indicates ACO participation — used to track ACO network composition and growth."
    - name: "vbc_arrangement_type"
      expr: vbc_arrangement_type
      comment: "Type of value-based care arrangement for this participation — used to segment VBC network participation by model type."
    - name: "quality_tier_designation"
      expr: quality_tier_designation
      comment: "Quality tier designation of the participating provider — used to analyze network quality composition."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the participation became effective — used for year-over-year network growth trend analysis."
  measures:
    - name: "total_active_participations"
      expr: COUNT(CASE WHEN participation_status = 'active' THEN contract_network_participation_id END)
      comment: "Count of active network participations — primary network size KPI for adequacy reporting and regulatory filings."
    - name: "total_in_network_participations"
      expr: COUNT(CASE WHEN in_network_flag = TRUE THEN contract_network_participation_id END)
      comment: "Count of in-network participations — measures the size of the contracted in-network provider panel."
    - name: "total_accepting_new_patients"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN contract_network_participation_id END)
      comment: "Count of providers accepting new patients — critical network access metric for member assignment capacity and adequacy standards."
    - name: "total_credentialed_participations"
      expr: COUNT(CASE WHEN credentialing_status = 'credentialed' THEN contract_network_participation_id END)
      comment: "Count of fully credentialed participations — measures compliance with credentialing requirements, a key regulatory and quality metric."
    - name: "total_pcp_eligible_participations"
      expr: COUNT(CASE WHEN pcp_assignment_eligible_flag = TRUE THEN contract_network_participation_id END)
      comment: "Count of PCP-assignment-eligible participations — measures primary care network capacity for member attribution."
    - name: "total_aco_participations"
      expr: COUNT(CASE WHEN aco_participant_flag = TRUE THEN contract_network_participation_id END)
      comment: "Count of ACO participations — tracks ACO network scale, informing ACO program investment and expansion decisions."
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk-share percentage across network participations — measures the degree of financial risk sharing embedded in network contracts."
    - name: "total_telehealth_eligible_participations"
      expr: COUNT(CASE WHEN telehealth_eligible_flag = TRUE THEN contract_network_participation_id END)
      comment: "Count of telehealth-eligible participations — measures telehealth network capacity, a strategic access and cost-efficiency metric."
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total count of network participation records — denominator for participation rate and adequacy ratio calculations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule governance KPIs — tracks conversion factors, DRG base rates, stop-loss thresholds, and schedule lifecycle to govern provider payment rates and reimbursement policy compliance."
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of fee schedule (e.g., Medicare-based, negotiated, RVU) — primary segmentation for reimbursement methodology analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current lifecycle status of the fee schedule (e.g., active, superseded, expired) — used to filter current vs. historical schedules."
    - name: "service_category"
      expr: service_category
      comment: "Service category covered by the fee schedule — enables rate analysis by clinical service type."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code — used to segment fee schedules by product line for pricing governance."
    - name: "state_code"
      expr: state_code
      comment: "State code for the fee schedule — enables geographic rate variation analysis."
    - name: "locality_code"
      expr: locality_code
      comment: "CMS locality code — used for Medicare fee schedule geographic adjustment analysis."
    - name: "drg_applicable"
      expr: drg_applicable
      comment: "Indicates whether DRG-based payment applies — used to segment inpatient vs. outpatient fee schedule analysis."
    - name: "stop_loss_applicable"
      expr: stop_loss_applicable
      comment: "Indicates whether stop-loss provisions apply to this schedule — used to assess financial protection coverage."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization is required under this schedule — used to assess utilization management burden."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the fee schedule became effective — used for year-over-year rate trend analysis."
  measures:
    - name: "total_active_fee_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'active' THEN fee_schedule_id END)
      comment: "Count of active fee schedules — baseline KPI for reimbursement policy portfolio size."
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average RVU conversion factor across fee schedules — core pricing metric that directly determines provider payment levels."
    - name: "avg_drg_base_rate"
      expr: AVG(CAST(drg_base_rate AS DOUBLE))
      comment: "Average DRG base rate — measures inpatient payment levels, a key driver of hospital contract economics."
    - name: "avg_anesthesia_conversion_factor"
      expr: AVG(CAST(anesthesia_conversion_factor AS DOUBLE))
      comment: "Average anesthesia conversion factor — tracks anesthesia-specific payment rates for specialty contract governance."
    - name: "avg_stop_loss_threshold_amt"
      expr: AVG(CAST(stop_loss_threshold_amt AS DOUBLE))
      comment: "Average stop-loss threshold amount — measures the financial protection ceiling embedded in fee schedules."
    - name: "avg_outlier_threshold_amt"
      expr: AVG(CAST(outlier_threshold_amt AS DOUBLE))
      comment: "Average outlier threshold amount — tracks the cost threshold above which outlier payments are triggered, informing high-cost case management."
    - name: "avg_payment_basis_pct"
      expr: AVG(CAST(payment_basis_pct AS DOUBLE))
      comment: "Average payment basis percentage — measures the proportion of billed charges or Medicare rates used as the payment basis."
    - name: "avg_cms_fee_schedule_year"
      expr: AVG(CAST(cms_fee_schedule_year AS DOUBLE))
      comment: "Average CMS fee schedule year referenced — used to assess how current the Medicare benchmark references are across the portfolio."
    - name: "total_fee_schedules"
      expr: COUNT(1)
      comment: "Total count of fee schedule records — denominator for portfolio-level rate averages and status distribution analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure-level reimbursement rate KPIs — tracks allowed amounts, per-diem rates, Medicare fee schedule percentages, and bundled payment amounts to govern clinical service pricing and rate adequacy."
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code (CPT/HCPCS) — primary clinical dimension for rate analysis by service type."
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Type of procedure code (e.g., CPT, HCPCS, Revenue) — used to segment rate analysis by coding system."
    - name: "service_category"
      expr: service_category
      comment: "Service category for the rate line — enables rate analysis by clinical service category."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the rate — used to compare rates across Medicare, Medicaid, and Commercial products."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for the rate — used to analyze rate differentials across network tiers."
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type for the rate — enables rate analysis by provider specialty and type."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty code — used to analyze rate variation by clinical specialty."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code — used to compare rates across care settings (inpatient, outpatient, office)."
    - name: "product_type"
      expr: product_type
      comment: "Product type for the rate — used to segment rate analysis by insurance product."
    - name: "state_code"
      expr: state_code
      comment: "State code for the rate — enables geographic rate variation analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for the rate — used for regional rate benchmarking."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the rate became effective — used for year-over-year rate trend analysis."
  measures:
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per procedure rate line — core pricing KPI for assessing reimbursement adequacy and competitive positioning."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all rate lines — measures aggregate reimbursement commitment in the fee schedule portfolio."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per-diem rate — key inpatient and post-acute payment metric for hospital and SNF contract governance."
    - name: "avg_medicare_fee_schedule_pct"
      expr: AVG(CAST(medicare_fee_schedule_pct AS DOUBLE))
      comment: "Average percentage of Medicare fee schedule — measures how contracted rates compare to Medicare benchmark, a standard industry pricing reference."
    - name: "avg_bundled_payment_amount"
      expr: AVG(CAST(bundled_payment_amount AS DOUBLE))
      comment: "Average bundled payment amount — tracks episode-based payment levels for value-based care bundled payment programs."
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate PMPM at the procedure/service level — used to assess service-level capitation adequacy."
    - name: "avg_rate_percent_of_billed"
      expr: AVG(CAST(rate_percent_of_billed AS DOUBLE))
      comment: "Average rate as a percentage of billed charges — measures discount depth from billed charges, a key contract negotiation metric."
    - name: "avg_mac_amount"
      expr: AVG(CAST(mac_amount AS DOUBLE))
      comment: "Average Maximum Allowable Cost (MAC) amount — tracks drug and supply cost ceilings embedded in fee schedules."
    - name: "avg_rbp_reference_amount"
      expr: AVG(CAST(rbp_reference_amount AS DOUBLE))
      comment: "Average Reference-Based Pricing (RBP) reference amount — measures the benchmark used for RBP payment calculations."
    - name: "avg_awp_percent"
      expr: AVG(CAST(awp_percent AS DOUBLE))
      comment: "Average AWP (Average Wholesale Price) percentage — tracks pharmacy pricing benchmarks embedded in fee schedules."
    - name: "total_rate_lines"
      expr: COUNT(1)
      comment: "Total count of fee schedule rate lines — measures fee schedule comprehensiveness and coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract performance KPIs — tracks shared savings, expenditure vs. benchmark, quality scores, risk corridor utilization, and settlement outcomes to govern VBC program financial and quality performance."
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_contract`"
  dimensions:
    - name: "vbc_model_type"
      expr: vbc_model_type
      comment: "Type of VBC model (e.g., MSSP, BPCI, direct contracting) — primary segmentation for VBC program performance analysis."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Risk arrangement type (e.g., upside-only, two-sided) — used to analyze financial risk distribution across VBC contracts."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the VBC contract — enables performance comparison across Medicare, Medicaid, and Commercial VBC programs."
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track designation — used to segment ACO and bundled payment performance by regulatory program track."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status of the VBC contract — used to track settlement progress and identify contracts pending financial close."
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether the quality gate was met — used to determine eligibility for shared savings distributions."
    - name: "episode_type"
      expr: episode_type
      comment: "Type of clinical episode for bundled payment contracts — used to analyze performance by episode category."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year of the VBC contract — used for year-over-year VBC program performance trending."
    - name: "performance_period_start_year"
      expr: DATE_TRUNC('YEAR', performance_period_start)
      comment: "Year the performance period started — used for cohort-based VBC performance analysis."
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Member attribution methodology used — used to compare performance outcomes across attribution approaches."
  measures:
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings amount earned across VBC contracts — top-line VBC financial performance KPI for executive reporting."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC contracts — measures clinical quality performance, a prerequisite for shared savings eligibility."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure across VBC contracts — measures total cost of care, the primary driver of shared savings or loss calculations."
    - name: "total_benchmark_expenditure_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure target across VBC contracts — the financial target against which actual expenditure is measured."
    - name: "avg_savings_sharing_rate"
      expr: AVG(CAST(savings_sharing_rate AS DOUBLE))
      comment: "Average savings sharing rate — measures the proportion of generated savings returned to providers, a key VBC incentive design metric."
    - name: "avg_max_shared_savings_rate"
      expr: AVG(CAST(max_shared_savings_rate AS DOUBLE))
      comment: "Average maximum shared savings rate cap — measures the ceiling on provider savings distributions across the VBC portfolio."
    - name: "avg_max_shared_loss_rate"
      expr: AVG(CAST(max_shared_loss_rate AS DOUBLE))
      comment: "Average maximum shared loss rate — measures the downside risk cap for two-sided VBC arrangements."
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate threshold — measures the minimum savings percentage required before shared savings are distributed."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold across VBC contracts — measures catastrophic cost protection levels in VBC arrangements."
    - name: "total_contracts_meeting_quality_gate"
      expr: COUNT(CASE WHEN quality_gate_met = TRUE THEN vbc_contract_id END)
      comment: "Count of VBC contracts where the quality gate was met — measures quality program success rate and shared savings eligibility."
    - name: "total_vbc_contracts"
      expr: COUNT(1)
      comment: "Total count of VBC contracts — baseline portfolio size metric for VBC program scale assessment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contracting party governance KPIs — tracks provider credentialing status, OIG exclusions, sanctions, delegation scope, and network participation type to govern provider network integrity and compliance."
  source: "`vibe_health_insurance_v1`.`contract`.`party`"
  dimensions:
    - name: "party_type"
      expr: party_type
      comment: "Type of contracting party (e.g., individual provider, group practice, facility) — primary segmentation for network composition analysis."
    - name: "party_role"
      expr: party_role
      comment: "Role of the party in the contract (e.g., provider, payer, delegate) — used to segment party governance metrics by role."
    - name: "party_status"
      expr: party_status
      comment: "Current status of the party (e.g., active, terminated, suspended) — primary filter for active network analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the party — critical compliance dimension for network integrity governance."
    - name: "network_participation_type"
      expr: network_participation_type
      comment: "Type of network participation (e.g., in-network, preferred, out-of-network) — used to analyze network tier composition."
    - name: "primary_specialty_code"
      expr: primary_specialty_code
      comment: "Primary specialty code of the provider party — used for specialty-level network adequacy and rate analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the party — used to segment provider participation by product line."
    - name: "service_area_state"
      expr: service_area_state
      comment: "State of the party's service area — enables geographic network composition analysis."
    - name: "vbc_arrangement_type"
      expr: vbc_arrangement_type
      comment: "Type of VBC arrangement the party participates in — used to track VBC provider network composition."
    - name: "npi_type"
      expr: npi_type
      comment: "NPI type (Type 1 = individual, Type 2 = organization) — used to distinguish individual providers from organizational entities."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the party became effective — used for year-over-year network growth analysis."
  measures:
    - name: "total_active_parties"
      expr: COUNT(CASE WHEN party_status = 'active' THEN party_id END)
      comment: "Count of active contracting parties — primary network size KPI for adequacy reporting."
    - name: "total_credentialed_parties"
      expr: COUNT(CASE WHEN credentialing_status = 'credentialed' THEN party_id END)
      comment: "Count of fully credentialed parties — measures compliance with credentialing requirements, a key regulatory metric."
    - name: "total_oig_excluded_parties"
      expr: COUNT(CASE WHEN oig_exclusion_indicator = TRUE THEN party_id END)
      comment: "Count of parties with OIG exclusion flags — critical compliance KPI; any non-zero value requires immediate remediation to avoid federal program violations."
    - name: "total_sanctioned_parties"
      expr: COUNT(CASE WHEN sanction_indicator = TRUE THEN party_id END)
      comment: "Count of parties with active sanctions — measures network integrity risk; high values indicate compliance program failures."
    - name: "total_aco_parties"
      expr: COUNT(CASE WHEN aco_indicator = TRUE THEN party_id END)
      comment: "Count of parties participating in ACO arrangements — measures ACO network scale for program investment decisions."
    - name: "total_capitation_eligible_parties"
      expr: COUNT(CASE WHEN capitation_eligible_indicator = TRUE THEN party_id END)
      comment: "Count of parties eligible for capitation payment — measures the capitation-eligible provider panel size."
    - name: "total_delegation_parties"
      expr: COUNT(CASE WHEN delegation_indicator = TRUE THEN party_id END)
      comment: "Count of parties with delegation arrangements — measures the scope of delegated functions (credentialing, UM, claims) in the network."
    - name: "total_raf_applicable_parties"
      expr: COUNT(CASE WHEN raf_applicable_indicator = TRUE THEN party_id END)
      comment: "Count of parties where RAF adjustment applies — measures the scope of risk-adjusted payment arrangements in the provider network."
    - name: "total_parties"
      expr: COUNT(1)
      comment: "Total count of contracting party records — denominator for compliance rate and network composition calculations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract term governance KPIs — tracks capitation rates, incentive amounts, quality metric thresholds, withhold percentages, and term lifecycle to govern contract compliance and financial obligations."
  source: "`vibe_health_insurance_v1`.`contract`.`term`"
  dimensions:
    - name: "term_type"
      expr: term_type
      comment: "Type of contract term (e.g., payment, quality, compliance, administrative) — primary segmentation for term analysis."
    - name: "term_status"
      expr: term_status
      comment: "Current lifecycle status of the term (e.g., active, expired, superseded) — used to filter current vs. historical terms."
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business applicability of the term — used to segment term analysis by product line."
    - name: "governing_state"
      expr: governing_state
      comment: "State law governing the term — used for regulatory compliance analysis by jurisdiction."
    - name: "payment_methodology_code"
      expr: CAST(payment_methodology AS STRING)
      comment: "Payment methodology code cast to string — used to segment terms by reimbursement approach."
    - name: "risk_sharing_model"
      expr: risk_sharing_model
      comment: "Risk sharing model specified in the term — used to analyze the distribution of risk-sharing arrangements across the contract portfolio."
    - name: "is_adjudication_rule"
      expr: is_adjudication_rule
      comment: "Indicates whether the term is a claims adjudication rule — used to isolate operational payment rules from strategic contract terms."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Indicates whether the term auto-renews — used to assess contract renewal risk and pipeline management."
    - name: "termination_cause_type"
      expr: termination_cause_type
      comment: "Cause type for term termination — used to analyze contract termination patterns and root causes."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the term became effective — used for year-over-year contract term trend analysis."
    - name: "expiration_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year the term expires — used for contract renewal pipeline and expiration risk management."
  measures:
    - name: "total_active_terms"
      expr: COUNT(CASE WHEN term_status = 'active' THEN term_id END)
      comment: "Count of active contract terms — baseline KPI for contract portfolio operational scope."
    - name: "avg_capitation_rate"
      expr: AVG(CAST(capitation_rate AS DOUBLE))
      comment: "Average capitation rate specified in contract terms — measures contracted payment levels for capitation-based arrangements."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount specified in contract terms — measures the financial value of performance incentives embedded in contracts."
    - name: "avg_quality_metric_threshold"
      expr: AVG(CAST(quality_metric_threshold AS DOUBLE))
      comment: "Average quality metric threshold specified in contract terms — measures the performance bar set for quality-linked payments."
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average withhold percentage in contract terms — measures the proportion of payments held pending quality or performance outcomes."
    - name: "avg_reduction_percentage"
      expr: AVG(CAST(reduction_percentage AS DOUBLE))
      comment: "Average payment reduction percentage in contract terms — measures the financial impact of contractual payment reductions."
    - name: "total_auto_renew_terms"
      expr: COUNT(CASE WHEN auto_renew = TRUE THEN term_id END)
      comment: "Count of auto-renewing contract terms — measures the proportion of the contract portfolio that renews automatically, informing renewal risk management."
    - name: "total_terms"
      expr: COUNT(1)
      comment: "Total count of contract term records — denominator for term composition and compliance rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_reimbursement_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reimbursement policy governance KPIs — tracks payment methodology, reduction percentages, regulatory mandates, and policy lifecycle to govern claims adjudication rules and payment accuracy."
  source: "`vibe_health_insurance_v1`.`contract`.`reimbursement_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of reimbursement policy (e.g., NCCI edit, multiple procedure reduction, global surgery) — primary segmentation for policy analysis."
    - name: "policy_status"
      expr: policy_status
      comment: "Current lifecycle status of the policy (e.g., active, superseded, expired) — used to filter current vs. historical policies."
    - name: "lob"
      expr: lob
      comment: "Line of business for the policy — used to segment reimbursement policy analysis by product line."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for the policy — used to analyze policy application across network tiers."
    - name: "ncci_edit_type"
      expr: ncci_edit_type
      comment: "NCCI edit type — used to analyze the distribution of CMS bundling and mutually exclusive code edits."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code for the policy — used to analyze policy application by care setting."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the policy is driven by a regulatory mandate — used to distinguish compliance-required policies from discretionary ones."
    - name: "applies_to_facility"
      expr: applies_to_facility
      comment: "Indicates whether the policy applies to facility claims — used to segment policy analysis by claim type."
    - name: "applies_to_professional"
      expr: applies_to_professional
      comment: "Indicates whether the policy applies to professional claims — used to segment policy analysis by claim type."
    - name: "override_allowed"
      expr: override_allowed
      comment: "Indicates whether policy override is allowed — used to assess the flexibility and exception risk in reimbursement policies."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the policy became effective — used for year-over-year policy portfolio trend analysis."
  measures:
    - name: "total_active_policies"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN reimbursement_policy_id END)
      comment: "Count of active reimbursement policies — baseline KPI for adjudication rule portfolio size."
    - name: "total_regulatory_mandate_policies"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN reimbursement_policy_id END)
      comment: "Count of regulatory mandate-driven policies — measures compliance-required policy coverage, a key regulatory audit metric."
    - name: "total_override_allowed_policies"
      expr: COUNT(CASE WHEN override_allowed = TRUE THEN reimbursement_policy_id END)
      comment: "Count of policies where override is allowed — measures exception risk in the adjudication rule set; high counts may indicate policy governance gaps."
    - name: "avg_reduction_pct"
      expr: AVG(CAST(reduction_pct AS DOUBLE))
      comment: "Average payment reduction percentage across reimbursement policies — measures the aggregate discount impact of adjudication rules on provider payments."
    - name: "avg_revenue_code_range_start"
      expr: AVG(CAST(revenue_code_range_start AS DOUBLE))
      comment: "Average revenue code range start — used to assess the breadth of revenue code coverage in reimbursement policies."
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total count of reimbursement policy records — denominator for policy composition and compliance rate calculations."
$$;