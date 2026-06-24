-- Metric views for domain: risk | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-level risk score analytics tracking plan-calculated vs CMS-published scores, score variance, and demographic/HCC-driven risk components. Core KPI surface for risk adjustment program management."
  source: "`vibe_health_insurance_v1`.`risk`.`member_risk_score`"
  dimensions:
    - name: "record_status"
      expr: record_status
      comment: "Current lifecycle status of the risk score record (e.g., active, superseded, pending)."
    - name: "model_name"
      expr: model_name
      comment: "Name of the risk model used to produce the score (e.g., CMS-HCC V24, V28)."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk model applied."
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "Status of the CMS submission associated with this risk score."
    - name: "variance_category"
      expr: variance_category
      comment: "Categorization of the score variance between plan-calculated and CMS-published scores."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Indicates whether the risk score was manually overridden, flagging potential data quality or audit concerns."
    - name: "score_effective_date"
      expr: DATE_TRUNC('month', score_effective_date)
      comment: "Month in which the risk score became effective, used for trend analysis."
    - name: "payment_year"
      expr: CAST(payment_year AS INT)
      comment: "CMS payment year associated with the risk score, used for year-over-year comparison."
  measures:
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average plan-calculated risk score across the population. Drives premium adequacy and risk adjustment transfer estimates."
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average CMS-published risk score. Benchmark against plan-calculated scores to identify systematic coding gaps."
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between plan-calculated and CMS-published scores. Negative variance signals under-coding risk and revenue leakage."
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic component of the risk score. Isolates age/gender contribution to overall risk."
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average confidence score for risk score calculations. Low confidence signals data quality issues requiring remediation."
    - name: "manual_override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk scores that were manually overridden. High rates indicate process or model reliability concerns."
    - name: "total_risk_score_value"
      expr: SUM(CAST(risk_score_value AS DOUBLE))
      comment: "Sum of all risk score values across the population. Used to compute population-level risk adjustment transfer amounts."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_ibnr_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IBNR (Incurred But Not Reported) reserve analytics for actuarial adequacy monitoring, regulatory reporting, and financial close. Critical MVM metric per VREQ-022."
  source: "`vibe_health_insurance_v1`.`risk`.`ibnr_reserve`"
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business associated with the IBNR reserve (e.g., Commercial, Medicare, Medicaid)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (e.g., HMO, PPO, EPO) for segmenting reserve adequacy by product."
    - name: "version_number"
      expr: version_number
      comment: "Version of the IBNR reserve estimate, supporting actuarial revision tracking."
    - name: "forecast_horizon_months"
      expr: forecast_horizon_months
      comment: "Forecast horizon in months used for the IBNR projection."
    - name: "reserve_adequacy_flag"
      expr: reserve_adequacy_flag
      comment: "Boolean flag indicating whether the reserve is deemed actuarially adequate."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether this reserve record is included in regulatory filings."
    - name: "valuation_date"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of the actuarial valuation date, used for trend and period-over-period analysis."
    - name: "service_month"
      expr: DATE_TRUNC('month', service_month)
      comment: "Service month the IBNR reserve covers, enabling lag analysis."
  measures:
    - name: "total_ibnr_amount"
      expr: SUM(CAST(ibnr_amount AS DOUBLE))
      comment: "Total IBNR reserve amount. Primary actuarial liability metric used in financial close and regulatory filings."
    - name: "avg_ibnr_pmpm"
      expr: AVG(CAST(ibnr_pmpm AS DOUBLE))
      comment: "Average IBNR per member per month. Normalizes reserve levels for cross-period and cross-LOB comparison."
    - name: "total_hcc_weighted_amount"
      expr: SUM(CAST(hcc_weighted_amount AS DOUBLE))
      comment: "Total HCC-weighted IBNR amount. Reflects risk-adjusted reserve liability driven by member acuity."
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average loss development factor applied to IBNR projections. Tracks actuarial methodology consistency."
    - name: "avg_expected_loss_ratio"
      expr: AVG(CAST(expected_loss_ratio AS DOUBLE))
      comment: "Average expected loss ratio embedded in IBNR calculations. Signals pricing adequacy assumptions."
    - name: "avg_actuarial_confidence_level"
      expr: AVG(CAST(actuarial_confidence_level AS DOUBLE))
      comment: "Average actuarial confidence level for reserve estimates. Low confidence triggers additional actuarial review."
    - name: "total_rbc_impact_amount"
      expr: SUM(CAST(rbc_impact_amount AS DOUBLE))
      comment: "Total risk-based capital impact from IBNR reserves. Directly affects solvency margin and regulatory capital adequacy."
    - name: "reserve_adequacy_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reserve_adequacy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IBNR reserve records flagged as actuarially adequate. Below-target rates trigger reserve strengthening actions."
    - name: "avg_confidence_interval_spread"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE) - CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average width of the actuarial confidence interval. Wide spreads indicate high estimation uncertainty and elevated reserve risk."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to IBNR reserves. Tracks the impact of risk adjustment on reserve adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk pool performance analytics covering member months, claims experience, PMPM costs, and risk score distribution. Foundation for risk adjustment transfer calculations and pool adequacy monitoring."
  source: "`vibe_health_insurance_v1`.`risk`.`pool`"
  dimensions:
    - name: "pool_type"
      expr: pool_type
      comment: "Type of risk pool (e.g., individual, small group, large group, Medicare)."
    - name: "pool_status"
      expr: pool_status
      comment: "Current operational status of the risk pool."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the pool (e.g., Commercial, Medicare Advantage, Medicaid)."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g., individual, small group) for regulatory and competitive analysis."
    - name: "state_code"
      expr: state_code
      comment: "State in which the risk pool operates, enabling geographic performance comparison."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the pool (e.g., statewide, regional, national)."
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory framework governing the pool (e.g., ACA, ERISA, state-regulated)."
    - name: "aca_compliance_flag"
      expr: aca_compliance_flag
      comment: "Indicates whether the pool is subject to ACA risk adjustment requirements."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the pool became effective, used for cohort and vintage analysis."
  measures:
    - name: "total_member_months"
      expr: SUM(CAST(member_months AS DOUBLE))
      comment: "Total member months across all risk pools. Primary denominator for PMPM cost and risk score normalization."
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims across risk pools. Core financial metric for loss ratio and risk transfer calculations."
    - name: "total_paid_claims"
      expr: SUM(CAST(total_paid_claims AS DOUBLE))
      comment: "Total paid claims across risk pools. Tracks cash outflow and payment completion rates."
    - name: "total_reserve_amount"
      expr: SUM(CAST(total_reserve_amount AS DOUBLE))
      comment: "Total reserve amount held across risk pools. Monitors aggregate liability and capital adequacy."
    - name: "avg_pmpm"
      expr: AVG(CAST(pmpm AS DOUBLE))
      comment: "Average per-member-per-month cost across pools. Benchmark for pricing adequacy and trend monitoring."
    - name: "avg_risk_score"
      expr: AVG(CAST(average_risk_score AS DOUBLE))
      comment: "Average risk score across pools. Drives risk adjustment transfer amounts and premium calibration."
    - name: "avg_risk_score_stddev"
      expr: AVG(CAST(risk_score_stddev AS DOUBLE))
      comment: "Average standard deviation of risk scores within pools. High dispersion signals adverse selection or coding inconsistency."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across pools. Directly impacts CMS transfer payments and premium revenue."
    - name: "claims_incurred_vs_paid_gap"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE) - CAST(total_paid_claims AS DOUBLE))
      comment: "Aggregate gap between incurred and paid claims. Represents outstanding liability and IBNR exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_raps_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RAPS (Risk Adjustment Processing System) submission quality and performance analytics. Tracks acceptance rates, rejection rates, and risk score outcomes for CMS risk adjustment compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`raps_submission`"
  dimensions:
    - name: "raps_submission_status"
      expr: raps_submission_status
      comment: "Current status of the RAPS submission (e.g., accepted, rejected, pending)."
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status for the submission batch."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the RAPS submission."
    - name: "risk_adjustment_year"
      expr: risk_adjustment_year
      comment: "Risk adjustment program year for the submission."
    - name: "plan_contract_number"
      expr: plan_contract_number
      comment: "CMS contract number for the health plan submitting RAPS data."
    - name: "submission_timestamp"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of submission, used for submission volume and timeliness trend analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of RAPS submission batches. Baseline volume metric for submission program activity."
    - name: "total_records_submitted"
      expr: SUM(CAST(total_record_count AS DOUBLE))
      comment: "Total number of records submitted across all RAPS batches. Measures program throughput."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across RAPS submissions. Tracks risk adjustment program effectiveness over time."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average RAF value from RAPS submissions. Directly drives CMS payment calculations."
    - name: "avg_payment_year"
      expr: AVG(CAST(payment_year AS DOUBLE))
      comment: "Average payment year across submissions. Used to confirm submissions are targeting the correct program year."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS risk adjustment submission analytics tracking acceptance rates, rejection rates, financial impact, and submission quality. Critical for ACA risk adjustment compliance and revenue integrity."
  source: "`vibe_health_insurance_v1`.`risk`.`risk_cms_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the CMS submission (e.g., accepted, rejected, pending review)."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (e.g., initial, resubmission, correction)."
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status for the submission."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter data included in the submission (e.g., professional, facility, pharmacy)."
    - name: "service_year"
      expr: service_year
      comment: "Service year for the submitted risk adjustment data."
    - name: "transition_flag"
      expr: transition_flag
      comment: "Indicates whether the submission is part of a transition year program."
    - name: "submission_timestamp"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of submission for trend and timeliness analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of CMS risk adjustment submissions. Baseline activity metric."
    - name: "total_records_submitted"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Total records submitted to CMS. Measures submission program throughput."
    - name: "total_accepted_records"
      expr: SUM(CAST(accepted_record_count AS DOUBLE))
      comment: "Total records accepted by CMS. Drives revenue recognition for risk adjustment transfers."
    - name: "total_rejected_records"
      expr: SUM(CAST(rejected_record_count AS DOUBLE))
      comment: "Total records rejected by CMS. High rejection counts signal data quality or coding issues requiring remediation."
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_record_count AS DOUBLE)) / NULLIF(SUM(CAST(record_count AS DOUBLE)), 0), 2)
      comment: "Percentage of submitted records accepted by CMS. Primary quality KPI for risk adjustment submission programs."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_record_count AS DOUBLE)) / NULLIF(SUM(CAST(record_count AS DOUBLE)), 0), 2)
      comment: "Percentage of submitted records rejected by CMS. Triggers root-cause analysis and resubmission workflows."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total financial adjustment amount from CMS risk adjustment submissions. Direct revenue impact metric."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount from CMS risk adjustment. Bottom-line financial outcome of the submission program."
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total claim amount included in CMS submissions. Validates submission completeness against claims data."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average RAF across CMS submissions. Tracks risk adjustment program performance and population acuity trends."
    - name: "avg_risk_adjustment_score"
      expr: AVG(CAST(risk_adjustment_score AS DOUBLE))
      comment: "Average risk adjustment score across submissions. Monitors scoring consistency and model performance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RADV (Risk Adjustment Data Validation) audit analytics tracking audit outcomes, payment errors, and settlement amounts. Critical for CMS compliance and risk adjustment revenue protection."
  source: "`vibe_health_insurance_v1`.`risk`.`radv_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the RADV audit (e.g., in-progress, complete, appealed)."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (e.g., CMS-initiated, plan-initiated, targeted)."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against RADV audit findings."
    - name: "audit_year"
      expr: audit_year
      comment: "Program year under audit. Used for year-over-year error rate trending."
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Indicates whether the audit identified a payment error."
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record requests for RADV audit documentation."
    - name: "audit_source"
      expr: audit_source
      comment: "Source initiating the RADV audit (e.g., CMS, internal compliance)."
    - name: "audit_start_timestamp"
      expr: DATE_TRUNC('year', audit_start_timestamp)
      comment: "Year the audit started, used for cohort analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of RADV audits. Baseline metric for audit program volume."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RADV audits with identified payment errors. Primary compliance KPI; high rates trigger corrective action plans."
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error amount from RADV audits. Represents maximum financial exposure from CMS recoupment."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amount from RADV audits. Actual financial impact after appeals and negotiations."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average RAF validated through RADV audits. Benchmark for assessing coding accuracy and risk score integrity."
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_status IS NOT NULL AND appeal_status != 'none' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RADV audits with an active or completed appeal. Tracks plan's use of appeal rights to protect revenue."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_reinsurance_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance claim analytics tracking recoverable amounts, recovery status, and loss categories. Monitors stop-loss program effectiveness and reinsurance asset realization."
  source: "`vibe_health_insurance_v1`.`risk`.`reinsurance_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the reinsurance claim (e.g., submitted, paid, denied, pending)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of reinsurance claim (e.g., specific stop-loss, aggregate stop-loss)."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of the reinsurance recovery (e.g., recovered, outstanding, disputed)."
    - name: "loss_category"
      expr: loss_category
      comment: "Category of loss driving the reinsurance claim (e.g., catastrophic, chronic, transplant)."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (e.g., individual member, group)."
    - name: "is_aggregated"
      expr: is_aggregated
      comment: "Indicates whether the claim is an aggregate stop-loss claim vs. specific."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether the reinsurance claim is subject to regulatory reporting."
    - name: "covered_start_date"
      expr: DATE_TRUNC('year', covered_start_date)
      comment: "Year the covered period started, used for vintage analysis of reinsurance claims."
  measures:
    - name: "total_reinsurance_claims"
      expr: COUNT(1)
      comment: "Total number of reinsurance claims filed. Baseline metric for stop-loss program utilization."
    - name: "total_incurred_amount"
      expr: SUM(CAST(total_incurred_amount AS DOUBLE))
      comment: "Total incurred loss amount across reinsurance claims. Measures gross exposure before recovery."
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total amount recoverable from reinsurers. Key asset metric for financial planning and cash flow management."
    - name: "total_attachment_point_amount"
      expr: SUM(CAST(attachment_point_amount AS DOUBLE))
      comment: "Total attachment point amounts across claims. Validates that claims exceed stop-loss thresholds."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recovery_status = 'recovered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reinsurance claims with completed recovery. Tracks reinsurance asset realization efficiency."
    - name: "avg_recoverable_per_claim"
      expr: AVG(CAST(recoverable_amount AS DOUBLE))
      comment: "Average recoverable amount per reinsurance claim. Benchmarks stop-loss program value per high-cost event."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_reinsurance_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance arrangement portfolio analytics covering premium ceded, stop-loss thresholds, and coverage terms. Supports risk transfer strategy and reinsurance cost management."
  source: "`vibe_health_insurance_v1`.`risk`.`reinsurance_arrangement`"
  dimensions:
    - name: "reinsurance_arrangement_status"
      expr: reinsurance_arrangement_status
      comment: "Current status of the reinsurance arrangement (e.g., active, expired, terminated)."
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (e.g., quota share, excess of loss, stop-loss)."
    - name: "stop_loss_type"
      expr: stop_loss_type
      comment: "Type of stop-loss coverage (e.g., specific, aggregate)."
    - name: "lob_coverage"
      expr: lob_coverage
      comment: "Line of business covered by the reinsurance arrangement."
    - name: "reinsurer_name"
      expr: reinsurer_name
      comment: "Name of the reinsurer. Used for counterparty concentration risk analysis."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the arrangement became effective, used for portfolio vintage analysis."
  measures:
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total number of active reinsurance arrangements. Baseline metric for reinsurance portfolio breadth."
    - name: "total_premium_ceded"
      expr: SUM(CAST(premium_ceded AS DOUBLE))
      comment: "Total premium ceded to reinsurers. Primary cost metric for the reinsurance program."
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point AS DOUBLE))
      comment: "Average attachment point across arrangements. Indicates the level of self-insured retention before reinsurance kicks in."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across arrangements. Measures the proportion of risk transferred to reinsurers."
    - name: "total_maximum_liability"
      expr: SUM(CAST(maximum_liability AS DOUBLE))
      comment: "Total maximum liability covered by reinsurance arrangements. Caps the plan's catastrophic loss exposure."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold across arrangements. Benchmarks the level at which aggregate losses trigger reinsurance recovery."
    - name: "total_maximum_recovery_limit"
      expr: SUM(CAST(maximum_recovery_limit AS DOUBLE))
      comment: "Total maximum recovery limit across all arrangements. Represents the ceiling on reinsurance asset value."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rbc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-Based Capital (RBC) calculation analytics for solvency monitoring and regulatory compliance. Tracks RBC ratios, capital adequacy thresholds, and component risk exposures."
  source: "`vibe_health_insurance_v1`.`risk`.`rbc_calculation`"
  dimensions:
    - name: "rbc_status"
      expr: rbc_status
      comment: "Current RBC status (e.g., adequate, company action level, regulatory action level)."
    - name: "action_threshold_status"
      expr: action_threshold_status
      comment: "Regulatory action threshold status triggered by the RBC ratio."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Methodology used for the RBC calculation (e.g., NAIC formula, state-specific)."
    - name: "calculation_period_start_date"
      expr: DATE_TRUNC('year', calculation_period_start_date)
      comment: "Year of the RBC calculation period, used for annual solvency trend analysis."
  measures:
    - name: "avg_rbc_ratio"
      expr: AVG(CAST(rbc_ratio AS DOUBLE))
      comment: "Average RBC ratio across calculation periods. Primary solvency KPI; ratios below 200% trigger regulatory intervention."
    - name: "min_rbc_ratio"
      expr: MIN(rbc_ratio)
      comment: "Minimum RBC ratio observed. Identifies the most stressed solvency position for risk management escalation."
    - name: "avg_total_adjusted_capital"
      expr: AVG(CAST(total_adjusted_capital AS DOUBLE))
      comment: "Average total adjusted capital. Measures the capital base available to absorb losses."
    - name: "avg_company_action_level_rbc"
      expr: AVG(CAST(company_action_level_rbc AS DOUBLE))
      comment: "Average company action level RBC threshold. Benchmarks the capital floor below which management action is required."
    - name: "avg_authorized_control_level_rbc"
      expr: AVG(CAST(authorized_control_level_rbc AS DOUBLE))
      comment: "Average authorized control level RBC. Represents the regulatory takeover threshold for capital adequacy."
    - name: "total_h1_underwriting_risk"
      expr: SUM(CAST(h1_underwriting_risk AS DOUBLE))
      comment: "Total underwriting risk component (H1) across RBC calculations. Largest driver of health insurer RBC requirements."
    - name: "total_h2_credit_risk"
      expr: SUM(CAST(h2_credit_risk AS DOUBLE))
      comment: "Total credit risk component (H2). Tracks counterparty and investment credit exposure in the capital model."
    - name: "total_h0_asset_risk"
      expr: SUM(CAST(h0_asset_risk AS DOUBLE))
      comment: "Total asset risk component (H0). Measures investment portfolio risk contribution to RBC requirements."
    - name: "avg_covariance_adjustment"
      expr: AVG(CAST(covariance_adjustment AS DOUBLE))
      comment: "Average covariance adjustment applied to RBC calculations. Reflects diversification benefit across risk components."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_rate_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial rate development analytics tracking base rates, trend factors, and final approved rates by line of business and rating area. Supports pricing adequacy and regulatory filing management."
  source: "`vibe_health_insurance_v1`.`risk`.`rate_development`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the rate development (e.g., individual, small group, Medicare)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (e.g., HMO, PPO) for rate segmentation."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for the rate development."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the rates become effective, used for annual rate cycle analysis."
    - name: "rating_period_start"
      expr: DATE_TRUNC('year', rating_period_start)
      comment: "Year of the rating period start for cohort analysis."
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across rate development records. Baseline for pricing adequacy assessment."
    - name: "avg_final_approved_rate"
      expr: AVG(CAST(final_approved_rate AS DOUBLE))
      comment: "Average final approved rate. Reflects the actuarially and regulatorily approved premium level."
    - name: "avg_trend_factor"
      expr: AVG(CAST(trend_factor AS DOUBLE))
      comment: "Average medical cost trend factor applied in rate development. Tracks inflation assumptions embedded in pricing."
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility factor. Low credibility signals insufficient experience data, increasing pricing uncertainty."
    - name: "avg_mlr_target"
      expr: AVG(CAST(mlr_target AS DOUBLE))
      comment: "Average MLR target embedded in rate development. Ensures rates are designed to meet ACA MLR requirements."
    - name: "avg_profit_margin"
      expr: AVG(CAST(profit_margin AS DOUBLE))
      comment: "Average profit margin loading in rates. Tracks pricing strategy and competitive positioning."
    - name: "avg_administrative_loading"
      expr: AVG(CAST(administrative_loading AS DOUBLE))
      comment: "Average administrative cost loading in rates. Monitors expense ratio trends in pricing."
    - name: "rate_increase_pct"
      expr: ROUND(100.0 * AVG((final_approved_rate - base_rate) / NULLIF(base_rate, 0)), 2)
      comment: "Average percentage increase from base rate to final approved rate. Measures actuarial adjustment magnitude in the rate filing process."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_score_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk score run analytics tracking population coverage, average RAF scores, and model performance across score run batches. Supports risk adjustment program management and model governance."
  source: "`vibe_health_insurance_v1`.`risk`.`score_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the score run (e.g., complete, failed, in-progress)."
    - name: "run_type"
      expr: run_type
      comment: "Type of score run (e.g., production, test, restatement)."
    - name: "model_name"
      expr: model_name
      comment: "Name of the risk model used in the score run."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk model applied."
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model (e.g., CMS-HCC, HHS-HCC, Rx-HCC)."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment scored in the run (e.g., Medicare, Medicaid, Commercial)."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Indicates whether data quality issues were detected in the score run."
    - name: "run_date"
      expr: DATE_TRUNC('month', run_date)
      comment: "Month of the score run, used for production cadence and trend analysis."
  measures:
    - name: "total_score_runs"
      expr: COUNT(1)
      comment: "Total number of score runs executed. Baseline metric for risk adjustment program production cadence."
    - name: "total_members_scored"
      expr: SUM(CAST(member_population_count AS DOUBLE))
      comment: "Total members scored across all runs. Measures risk adjustment program population coverage."
    - name: "avg_raf_score"
      expr: AVG(CAST(average_raf_score AS DOUBLE))
      comment: "Average RAF score across score runs. Primary output metric for risk adjustment program performance."
    - name: "total_raf_score"
      expr: SUM(CAST(total_raf_score AS DOUBLE))
      comment: "Sum of total RAF scores across runs. Aggregated risk adjustment factor driving CMS payment calculations."
    - name: "avg_normalization_factor"
      expr: AVG(CAST(normalization_factor AS DOUBLE))
      comment: "Average normalization factor applied across score runs. Tracks CMS normalization adjustments affecting payment."
    - name: "data_quality_failure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_quality_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of score runs with data quality issues. High rates signal upstream data pipeline problems affecting risk adjustment accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_hcc_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCC (Hierarchical Condition Category) mapping analytics tracking coding coverage, coefficient weights, and mapping quality. Supports risk adjustment model governance and coding program management."
  source: "`vibe_health_insurance_v1`.`risk`.`hcc_mapping`"
  dimensions:
    - name: "hcc_mapping_status"
      expr: hcc_mapping_status
      comment: "Current status of the HCC mapping record (e.g., active, deprecated, under review)."
    - name: "model_year"
      expr: model_year
      comment: "CMS model year for the HCC mapping. Used for year-over-year model comparison."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchical level of the HCC code within the disease grouping structure."
    - name: "disease_interaction_group"
      expr: disease_interaction_group
      comment: "Disease interaction group for HCC codes that have interaction effects on risk scores."
    - name: "is_mapped"
      expr: is_mapped
      comment: "Indicates whether the ICD-10 code is actively mapped to an HCC."
    - name: "is_excluded"
      expr: is_excluded
      comment: "Indicates whether the HCC mapping is excluded from risk score calculations."
    - name: "interaction_flag"
      expr: interaction_flag
      comment: "Indicates whether the HCC has a disease interaction coefficient."
    - name: "review_status"
      expr: review_status
      comment: "Clinical review status of the HCC mapping."
  measures:
    - name: "total_hcc_mappings"
      expr: COUNT(1)
      comment: "Total number of HCC mapping records. Baseline metric for coding model coverage."
    - name: "avg_coefficient"
      expr: AVG(CAST(coefficient AS DOUBLE))
      comment: "Average HCC coefficient (risk score weight). Tracks the average risk contribution per HCC code."
    - name: "avg_risk_score_weight"
      expr: AVG(CAST(risk_score_weight AS DOUBLE))
      comment: "Average risk score weight across HCC mappings. Measures the average actuarial impact per mapped condition."
    - name: "avg_age_adjustment_factor"
      expr: AVG(CAST(age_adjustment_factor AS DOUBLE))
      comment: "Average age adjustment factor across HCC mappings. Quantifies age-related risk score modification."
    - name: "mapping_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mapped = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ICD-10 codes with active HCC mappings. Low coverage rates signal coding gaps reducing risk adjustment revenue."
    - name: "exclusion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HCC mappings excluded from risk score calculations. High exclusion rates may indicate model or data issues."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting case analytics tracking risk classification, premium adequacy, and underwriting decision outcomes. Supports group underwriting performance management and stop-loss program oversight."
  source: "`vibe_health_insurance_v1`.`risk`.`risk_underwriting_case`"
  dimensions:
    - name: "risk_underwriting_case_status"
      expr: risk_underwriting_case_status
      comment: "Current status of the underwriting case (e.g., pending, approved, declined, referred)."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification assigned to the group (e.g., standard, substandard, preferred)."
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant (e.g., new group, renewal, individual)."
    - name: "lob"
      expr: lob
      comment: "Line of business for the underwriting case."
    - name: "underwriting_tier"
      expr: underwriting_tier
      comment: "Underwriting tier assigned to the case, reflecting risk level."
    - name: "is_self_insured"
      expr: is_self_insured
      comment: "Indicates whether the group is self-insured, affecting underwriting approach and stop-loss requirements."
    - name: "reinsurance_flag"
      expr: reinsurance_flag
      comment: "Indicates whether stop-loss or reinsurance was applied to the case."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the underwriting case became effective, used for cohort analysis."
  measures:
    - name: "total_underwriting_cases"
      expr: COUNT(1)
      comment: "Total number of underwriting cases. Baseline metric for underwriting pipeline volume."
    - name: "avg_overall_group_risk_score"
      expr: AVG(CAST(overall_group_risk_score AS DOUBLE))
      comment: "Average overall group risk score across underwriting cases. Primary risk assessment metric driving premium decisions."
    - name: "avg_expected_claims_pmpm"
      expr: AVG(CAST(expected_claims_pmpm AS DOUBLE))
      comment: "Average expected claims PMPM. Benchmarks actuarial cost projections against actual experience."
    - name: "avg_premium_rate"
      expr: AVG(CAST(premium_rate AS DOUBLE))
      comment: "Average premium rate across underwriting cases. Tracks pricing levels and competitive positioning."
    - name: "total_gross_premium_amount"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium amount from underwriting cases. Measures revenue pipeline from new and renewal business."
    - name: "avg_morbidity_factor"
      expr: AVG(CAST(morbidity_factor AS DOUBLE))
      comment: "Average morbidity factor applied in underwriting. Tracks health status adjustments to base rates."
    - name: "avg_chronic_condition_prevalence_rate"
      expr: AVG(CAST(chronic_condition_prevalence_rate AS DOUBLE))
      comment: "Average chronic condition prevalence rate across underwriting cases. Signals population health risk and long-term claims trajectory."
    - name: "reinsurance_attachment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reinsurance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of underwriting cases with stop-loss or reinsurance applied. Tracks risk transfer program utilization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_actuarial_assumption_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial assumption set analytics tracking trend rates, loss development factors, and assumption governance. Supports actuarial model validation and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`risk`.`actuarial_assumption_set`"
  dimensions:
    - name: "actuarial_assumption_set_status"
      expr: actuarial_assumption_set_status
      comment: "Current status of the assumption set (e.g., draft, approved, superseded)."
    - name: "actuarial_assumption_set_type"
      expr: actuarial_assumption_set_type
      comment: "Type of assumption set (e.g., pricing, reserving, IBNR, rate development)."
    - name: "peer_review_status"
      expr: peer_review_status
      comment: "Status of peer review for the assumption set."
    - name: "is_peer_reviewed"
      expr: is_peer_reviewed
      comment: "Indicates whether the assumption set has been peer reviewed."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Indicates whether the assumption set meets regulatory requirements."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the assumption set became effective, used for annual assumption cycle analysis."
  measures:
    - name: "avg_trend_rate_medical_cost"
      expr: AVG(CAST(trend_rate_medical_cost AS DOUBLE))
      comment: "Average medical cost trend rate across assumption sets. Core pricing and reserving input; drives premium adequacy."
    - name: "avg_trend_rate_pharmacy"
      expr: AVG(CAST(trend_rate_pharmacy AS DOUBLE))
      comment: "Average pharmacy trend rate. Tracks drug cost inflation assumptions embedded in pricing and reserves."
    - name: "avg_trend_rate_utilization"
      expr: AVG(CAST(trend_rate_utilization AS DOUBLE))
      comment: "Average utilization trend rate. Measures assumed changes in healthcare service use rates."
    - name: "avg_loss_development_factor_cumulative"
      expr: AVG(CAST(loss_development_factor_cumulative AS DOUBLE))
      comment: "Average cumulative loss development factor. Key actuarial input for IBNR reserve calculations."
    - name: "avg_credibility_weight"
      expr: AVG(CAST(credibility_weight AS DOUBLE))
      comment: "Average credibility weight assigned to assumption sets. Low credibility signals reliance on industry benchmarks over own experience."
    - name: "peer_review_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_peer_reviewed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assumption sets that have been peer reviewed. Governance KPI for actuarial quality control."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_regulatory_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assumption sets flagged as regulatory compliant. Critical compliance KPI for state and federal actuarial filings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_prospective_risk_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospective risk model analytics tracking model performance, score ranges, and production status. Supports predictive analytics governance and risk stratification program management."
  source: "`vibe_health_insurance_v1`.`risk`.`prospective_risk_model`"
  dimensions:
    - name: "model_status"
      expr: model_status
      comment: "Current status of the prospective risk model (e.g., active, retired, in-development)."
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model (e.g., CMS-HCC, commercial predictive, pharmacy-based)."
    - name: "model_category"
      expr: model_category
      comment: "Category of the model (e.g., clinical, financial, utilization)."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment the model is designed for (e.g., Medicare, Medicaid, Commercial)."
    - name: "is_production"
      expr: is_production
      comment: "Indicates whether the model is currently in production use."
    - name: "cms_model_year"
      expr: cms_model_year
      comment: "CMS model year for regulatory alignment."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the model became effective, used for model lifecycle analysis."
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of prospective risk models. Baseline metric for model portfolio breadth."
    - name: "avg_normalization_factor"
      expr: AVG(CAST(normalization_factor AS DOUBLE))
      comment: "Average normalization factor across models. Tracks CMS normalization adjustments affecting risk score outputs."
    - name: "avg_risk_score_max"
      expr: AVG(CAST(risk_score_max AS DOUBLE))
      comment: "Average maximum risk score across models. Benchmarks the upper bound of risk stratification."
    - name: "avg_risk_score_min"
      expr: AVG(CAST(risk_score_min AS DOUBLE))
      comment: "Average minimum risk score across models. Benchmarks the lower bound of risk stratification."
    - name: "production_model_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_production = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk models currently in production. Tracks model governance and deployment pipeline health."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`risk_adjustment_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment payment analytics tracking gross, net, and adjustment amounts by program type and payment year. Supports CMS risk adjustment transfer reconciliation and revenue management."
  source: "`vibe_health_insurance_v1`.`risk`.`adjustment_payment`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the adjustment payment (e.g., pending, processed, reconciled)."
    - name: "program_type"
      expr: program_type
      comment: "Risk adjustment program type (e.g., ACA, Medicare Advantage, Medicaid)."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for the risk adjustment payment."
    - name: "reconciliation_flag"
      expr: reconciliation_flag
      comment: "Indicates whether the payment has been reconciled."
    - name: "payment_effective_date"
      expr: DATE_TRUNC('year', payment_effective_date)
      comment: "Year the payment became effective, used for annual risk adjustment cycle analysis."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross risk adjustment payment amount. Measures total CMS transfer before adjustments."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net risk adjustment payment amount. Bottom-line financial impact of risk adjustment transfers."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to risk adjustment payments. Tracks correction and reconciliation activity."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with adjustment payments. Links payment levels to population acuity."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustment payments that have been reconciled. Tracks financial close completeness for risk adjustment."
$$;