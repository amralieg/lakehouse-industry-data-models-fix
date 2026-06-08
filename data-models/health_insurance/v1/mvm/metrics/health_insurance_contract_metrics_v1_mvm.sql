-- Metric views for domain: contract | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider contract metrics tracking contract volume, status distribution, payment methodologies, and value-based care adoption across provider networks and lines of business."
  source: "`health_insurance_ecm`.`contract`.`provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the provider contract (active, terminated, pending, etc.)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of provider contract (professional, facility, ancillary, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Primary payment methodology (fee-for-service, capitation, bundled, value-based, etc.)"
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business applicability (commercial, Medicare, Medicaid, etc.)"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider (physician, hospital, ancillary, etc.)"
    - name: "contract_tier"
      expr: contract_tier
      comment: "Contract tier designation (tier 1, tier 2, tier 3, etc.)"
    - name: "risk_sharing_model"
      expr: risk_sharing_model
      comment: "Risk sharing model type (upside only, downside, two-sided, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the contract became effective"
    - name: "vbc_flag"
      expr: vbc_flag
      comment: "Indicates whether contract includes value-based care arrangements"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether contract auto-renews"
    - name: "delegation_flag"
      expr: delegation_flag
      comment: "Indicates whether contract includes delegated functions"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT provider_contract_id)
      comment: "Total number of unique provider contracts"
    - name: "active_contracts"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN provider_contract_id END)
      comment: "Number of active provider contracts"
    - name: "vbc_contracts"
      expr: COUNT(DISTINCT CASE WHEN vbc_flag = TRUE THEN provider_contract_id END)
      comment: "Number of contracts with value-based care arrangements"
    - name: "vbc_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vbc_flag = TRUE THEN provider_contract_id END) / NULLIF(COUNT(DISTINCT provider_contract_id), 0), 2)
      comment: "Percentage of contracts that include value-based care arrangements"
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate per member per month across contracts"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment financial metrics tracking payment volume, amounts, risk adjustments, and withhold performance across provider arrangements."
  source: "`health_insurance_ecm`.`contract`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the capitation payment (paid, pending, voided, etc.)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of capitation payment (regular, adjustment, settlement, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, EFT, ACH, wire, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the capitation payment"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "payment_quarter"
      expr: CONCAT('Q', QUARTER(payment_date), '-', YEAR(payment_date))
      comment: "Quarter and year the payment was made"
    - name: "prior_period_adjustment_flag"
      expr: prior_period_adjustment_flag
      comment: "Indicates whether payment includes prior period adjustments"
    - name: "vbc_contract_flag"
      expr: vbc_contract_flag
      comment: "Indicates whether payment is associated with a value-based care contract"
    - name: "capitation_rate_tier"
      expr: capitation_rate_tier
      comment: "Tier of capitation rate applied"
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT capitation_payment_id)
      comment: "Total number of capitation payments"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross capitation payment amount before adjustments"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payment amount after all adjustments and withholds"
    - name: "total_quality_withhold_amount"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total amount withheld for quality performance incentives"
    - name: "total_risk_pool_withhold_amount"
      expr: SUM(CAST(risk_pool_withhold_amount AS DOUBLE))
      comment: "Total amount withheld for risk pool participation"
    - name: "total_enrollment_adjustment_amount"
      expr: SUM(CAST(enrollment_adjustment_amount AS DOUBLE))
      comment: "Total enrollment-based adjustments to capitation payments"
    - name: "total_stop_loss_recovery_amount"
      expr: SUM(CAST(stop_loss_recovery_amount AS DOUBLE))
      comment: "Total stop-loss recoveries reducing capitation payments"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per member per month capitation rate"
    - name: "avg_risk_adjusted_pmpm_rate"
      expr: AVG(CAST(risk_adjusted_pmpm_rate AS DOUBLE))
      comment: "Average risk-adjusted per member per month capitation rate"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score applied to capitation payments"
    - name: "quality_withhold_rate"
      expr: ROUND(100.0 * SUM(CAST(quality_withhold_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payments withheld for quality performance"
    - name: "risk_pool_withhold_rate"
      expr: ROUND(100.0 * SUM(CAST(risk_pool_withhold_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payments withheld for risk pool participation"
    - name: "net_payment_yield"
      expr: ROUND(100.0 * SUM(CAST(net_payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payments that result in net payments after all adjustments"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_vbc_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract performance metrics tracking shared savings, shared losses, quality performance, and financial reconciliation outcomes."
  source: "`health_insurance_ecm`.`contract`.`vbc_contract`"
  dimensions:
    - name: "vbc_model_type"
      expr: vbc_model_type
      comment: "Type of value-based care model (ACO, bundled payment, episode-based, shared savings, etc.)"
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (upside only, downside, two-sided, etc.)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the VBC contract"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation (pending, in progress, completed, disputed, etc.)"
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track for ACO arrangements (Track 1, Track 2, Track 3, etc.)"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the VBC contract"
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether quality gate requirements were met"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether VBC contract auto-renews"
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode for episode-based payment models"
  measures:
    - name: "total_vbc_contracts"
      expr: COUNT(DISTINCT vbc_contract_id)
      comment: "Total number of value-based care contracts"
    - name: "total_benchmark_expenditure_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure target across all VBC contracts"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure across all VBC contracts"
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned across all VBC contracts"
    - name: "total_episode_target_price"
      expr: SUM(CAST(episode_target_price AS DOUBLE))
      comment: "Total episode target price for episode-based payment models"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC contracts"
    - name: "avg_max_shared_savings_rate"
      expr: AVG(CAST(max_shared_savings_rate AS DOUBLE))
      comment: "Average maximum shared savings rate across VBC contracts"
    - name: "avg_max_shared_loss_rate"
      expr: AVG(CAST(max_shared_loss_rate AS DOUBLE))
      comment: "Average maximum shared loss rate across VBC contracts"
    - name: "quality_gate_achievement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN vbc_contract_id END) / NULLIF(COUNT(DISTINCT vbc_contract_id), 0), 2)
      comment: "Percentage of VBC contracts that met quality gate requirements"
    - name: "expenditure_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_expenditure AS DOUBLE)) - SUM(CAST(benchmark_expenditure_target AS DOUBLE))) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual expenditure and benchmark target"
    - name: "shared_savings_yield"
      expr: ROUND(100.0 * SUM(CAST(shared_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Shared savings as a percentage of benchmark expenditure target"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_vbc_performance_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care performance period metrics tracking period-level financial reconciliation, quality performance, risk adjustment, and settlement outcomes."
  source: "`health_insurance_ecm`.`contract`.`vbc_performance_period`"
  dimensions:
    - name: "period_status"
      expr: period_status
      comment: "Status of the performance period (active, closed, reconciled, appealed, etc.)"
    - name: "period_type"
      expr: period_type
      comment: "Type of performance period (annual, semi-annual, quarterly, etc.)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation for the period"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the period"
    - name: "lob"
      expr: lob
      comment: "Line of business for the performance period"
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model type for the period"
    - name: "risk_model"
      expr: risk_model
      comment: "Risk adjustment model applied to the period"
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track for ACO arrangements"
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether quality gate requirements were met for the period"
    - name: "period_quarter"
      expr: CONCAT('Q', QUARTER(start_date), '-', YEAR(start_date))
      comment: "Quarter and year of the performance period start date"
  measures:
    - name: "total_performance_periods"
      expr: COUNT(DISTINCT vbc_performance_period_id)
      comment: "Total number of VBC performance periods"
    - name: "total_benchmark_expenditure_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure target across all performance periods"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure across all performance periods"
    - name: "total_expenditure_variance"
      expr: SUM(CAST(expenditure_variance AS DOUBLE))
      comment: "Total expenditure variance (actual minus benchmark) across all periods"
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned across all performance periods"
    - name: "total_shared_loss_amount"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses incurred across all performance periods"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount (savings minus losses) across all periods"
    - name: "total_withhold_amount"
      expr: SUM(CAST(withhold_amount AS DOUBLE))
      comment: "Total amount withheld for quality or risk pool participation"
    - name: "total_prior_period_adjustment"
      expr: SUM(CAST(prior_period_adjustment AS DOUBLE))
      comment: "Total prior period adjustments applied to settlements"
    - name: "total_ibnr_reserve_amount"
      expr: SUM(CAST(ibnr_reserve_amount AS DOUBLE))
      comment: "Total incurred but not reported reserve amount"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across performance periods"
    - name: "avg_hedis_composite_score"
      expr: AVG(CAST(hedis_composite_score AS DOUBLE))
      comment: "Average HEDIS composite score across performance periods"
    - name: "avg_cahps_composite_score"
      expr: AVG(CAST(cahps_composite_score AS DOUBLE))
      comment: "Average CAHPS composite score across performance periods"
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across performance periods"
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average risk adjustment factor score across performance periods"
    - name: "avg_hcc_capture_rate"
      expr: AVG(CAST(hcc_capture_rate AS DOUBLE))
      comment: "Average hierarchical condition category capture rate"
    - name: "avg_benchmark_pmpm"
      expr: AVG(CAST(benchmark_pmpm AS DOUBLE))
      comment: "Average benchmark per member per month across performance periods"
    - name: "avg_actual_pmpm"
      expr: AVG(CAST(actual_pmpm AS DOUBLE))
      comment: "Average actual per member per month across performance periods"
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate applied across performance periods"
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate applied across performance periods"
    - name: "quality_gate_achievement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN vbc_performance_period_id END) / NULLIF(COUNT(DISTINCT vbc_performance_period_id), 0), 2)
      comment: "Percentage of performance periods that met quality gate requirements"
    - name: "expenditure_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(expenditure_variance AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual expenditure and benchmark target"
    - name: "net_settlement_yield"
      expr: ROUND(100.0 * SUM(CAST(net_settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_target AS DOUBLE)), 0), 2)
      comment: "Net settlement amount as a percentage of benchmark expenditure target"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment metrics tracking amendment volume, approval rates, rate changes, and regulatory compliance across contract modifications."
  source: "`health_insurance_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of contract amendment (rate change, scope change, term extension, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the amendment (pending, approved, rejected, etc.)"
    - name: "initiating_party"
      expr: initiating_party
      comment: "Party that initiated the amendment (provider, plan, mutual, etc.)"
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology affected by the amendment"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code affected by the amendment"
    - name: "negotiation_outcome"
      expr: negotiation_outcome
      comment: "Outcome of amendment negotiation (accepted, rejected, counter-offered, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter and year the amendment became effective"
    - name: "retroactive_flag"
      expr: retroactive_flag
      comment: "Indicates whether amendment has retroactive effect"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether amendment is driven by regulatory mandate"
    - name: "claims_reprocess_required"
      expr: claims_reprocess_required
      comment: "Indicates whether amendment requires claims reprocessing"
    - name: "prior_auth_impact_flag"
      expr: prior_auth_impact_flag
      comment: "Indicates whether amendment impacts prior authorization requirements"
    - name: "formulary_impact_flag"
      expr: formulary_impact_flag
      comment: "Indicates whether amendment impacts formulary"
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT amendment_id)
      comment: "Total number of contract amendments"
    - name: "approved_amendments"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN amendment_id END)
      comment: "Number of approved contract amendments"
    - name: "retroactive_amendments"
      expr: COUNT(DISTINCT CASE WHEN retroactive_flag = TRUE THEN amendment_id END)
      comment: "Number of amendments with retroactive effect"
    - name: "regulatory_mandate_amendments"
      expr: COUNT(DISTINCT CASE WHEN regulatory_mandate_flag = TRUE THEN amendment_id END)
      comment: "Number of amendments driven by regulatory mandates"
    - name: "claims_reprocess_amendments"
      expr: COUNT(DISTINCT CASE WHEN claims_reprocess_required = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring claims reprocessing"
    - name: "avg_rate_change_pct"
      expr: AVG(CAST(rate_change_pct AS DOUBLE))
      comment: "Average rate change percentage across amendments"
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate per member per month in amendments"
    - name: "avg_risk_share_pct"
      expr: AVG(CAST(risk_share_pct AS DOUBLE))
      comment: "Average risk share percentage in amendments"
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN amendment_id END) / NULLIF(COUNT(DISTINCT amendment_id), 0), 2)
      comment: "Percentage of amendments that are approved"
    - name: "retroactive_amendment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retroactive_flag = TRUE THEN amendment_id END) / NULLIF(COUNT(DISTINCT amendment_id), 0), 2)
      comment: "Percentage of amendments with retroactive effect"
    - name: "regulatory_mandate_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_mandate_flag = TRUE THEN amendment_id END) / NULLIF(COUNT(DISTINCT amendment_id), 0), 2)
      comment: "Percentage of amendments driven by regulatory mandates"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule metrics tracking schedule volume, payment methodologies, conversion factors, and applicability rules across provider networks and service categories."
  source: "`health_insurance_ecm`.`contract`.`fee_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the fee schedule (active, inactive, pending, superseded, etc.)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of fee schedule (professional, facility, ancillary, etc.)"
    - name: "payment_basis"
      expr: payment_basis
      comment: "Payment basis for the fee schedule (Medicare, billed charges, custom, etc.)"
    - name: "service_category"
      expr: service_category
      comment: "Service category covered by the fee schedule"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for the fee schedule"
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic applicability"
    - name: "fee_schedule_source"
      expr: fee_schedule_source
      comment: "Source of the fee schedule (CMS, custom, state, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the fee schedule became effective"
    - name: "drg_applicable"
      expr: drg_applicable
      comment: "Indicates whether DRG-based payment is applicable"
    - name: "anesthesia_applicable"
      expr: anesthesia_applicable
      comment: "Indicates whether anesthesia conversion factor is applicable"
    - name: "modifier_applicable"
      expr: modifier_applicable
      comment: "Indicates whether modifiers are applicable"
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization is required"
    - name: "stop_loss_applicable"
      expr: stop_loss_applicable
      comment: "Indicates whether stop-loss provisions are applicable"
  measures:
    - name: "total_fee_schedules"
      expr: COUNT(DISTINCT fee_schedule_id)
      comment: "Total number of fee schedules"
    - name: "active_fee_schedules"
      expr: COUNT(DISTINCT CASE WHEN schedule_status = 'Active' THEN fee_schedule_id END)
      comment: "Number of active fee schedules"
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average conversion factor across fee schedules"
    - name: "avg_anesthesia_conversion_factor"
      expr: AVG(CAST(anesthesia_conversion_factor AS DOUBLE))
      comment: "Average anesthesia conversion factor across fee schedules"
    - name: "avg_drg_base_rate"
      expr: AVG(CAST(drg_base_rate AS DOUBLE))
      comment: "Average DRG base rate across fee schedules"
    - name: "avg_payment_basis_pct"
      expr: AVG(CAST(payment_basis_pct AS DOUBLE))
      comment: "Average payment basis percentage across fee schedules"
    - name: "avg_outlier_threshold_amt"
      expr: AVG(CAST(outlier_threshold_amt AS DOUBLE))
      comment: "Average outlier threshold amount across fee schedules"
    - name: "avg_stop_loss_threshold_amt"
      expr: AVG(CAST(stop_loss_threshold_amt AS DOUBLE))
      comment: "Average stop-loss threshold amount across fee schedules"
    - name: "drg_applicable_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN drg_applicable = TRUE THEN fee_schedule_id END) / NULLIF(COUNT(DISTINCT fee_schedule_id), 0), 2)
      comment: "Percentage of fee schedules with DRG-based payment applicable"
    - name: "prior_auth_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN prior_authorization_required = TRUE THEN fee_schedule_id END) / NULLIF(COUNT(DISTINCT fee_schedule_id), 0), 2)
      comment: "Percentage of fee schedules requiring prior authorization"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_incentive_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider incentive arrangement metrics tracking incentive volume, earned amounts, quality performance, withhold release, and penalty outcomes."
  source: "`health_insurance_ecm`.`contract`.`incentive_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the incentive arrangement (active, closed, settled, etc.)"
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of incentive arrangement (quality, utilization, cost, composite, etc.)"
    - name: "earned_status"
      expr: earned_status
      comment: "Status of incentive earned (earned, not earned, partially earned, pending, etc.)"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for the incentive arrangement"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the incentive arrangement"
    - name: "performance_threshold_tier"
      expr: performance_threshold_tier
      comment: "Performance threshold tier achieved (bronze, silver, gold, platinum, etc.)"
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Indicates whether quality gate requirements were met"
    - name: "aco_arrangement_flag"
      expr: aco_arrangement_flag
      comment: "Indicates whether arrangement is part of an ACO"
    - name: "withhold_pool_type"
      expr: withhold_pool_type
      comment: "Type of withhold pool (quality, utilization, risk, etc.)"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure performance"
  measures:
    - name: "total_incentive_arrangements"
      expr: COUNT(DISTINCT incentive_arrangement_id)
      comment: "Total number of incentive arrangements"
    - name: "total_maximum_incentive_amount"
      expr: SUM(CAST(maximum_incentive_amount AS DOUBLE))
      comment: "Total maximum incentive amount available across all arrangements"
    - name: "total_maximum_penalty_amount"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty amount at risk across all arrangements"
    - name: "total_withheld_amount"
      expr: SUM(CAST(total_withheld_amount AS DOUBLE))
      comment: "Total amount withheld across all incentive arrangements"
    - name: "total_amount_released"
      expr: SUM(CAST(amount_released AS DOUBLE))
      comment: "Total amount released from withhold pools"
    - name: "total_amount_forfeited"
      expr: SUM(CAST(amount_forfeited AS DOUBLE))
      comment: "Total amount forfeited from withhold pools"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across incentive arrangements"
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average withhold percentage across incentive arrangements"
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate across incentive arrangements"
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate across incentive arrangements"
    - name: "quality_gate_achievement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_gate_met = TRUE THEN incentive_arrangement_id END) / NULLIF(COUNT(DISTINCT incentive_arrangement_id), 0), 2)
      comment: "Percentage of incentive arrangements that met quality gate requirements"
    - name: "withhold_release_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_released AS DOUBLE)) / NULLIF(SUM(CAST(total_withheld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of withheld amounts that were released"
    - name: "withhold_forfeiture_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_forfeited AS DOUBLE)) / NULLIF(SUM(CAST(total_withheld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of withheld amounts that were forfeited"
    - name: "incentive_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_released AS DOUBLE)) / NULLIF(SUM(CAST(maximum_incentive_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of maximum incentive amount that was earned and released"
$$;