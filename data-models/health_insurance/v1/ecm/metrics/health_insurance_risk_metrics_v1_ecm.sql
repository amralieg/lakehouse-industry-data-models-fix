-- Metric views for domain: risk | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core risk pool metrics tracking financial performance, membership, and risk adequacy across pools, market segments, and lines of business. Risk pools are the fundamental unit of risk aggregation in health insurance."
  source: "`health_insurance_ecm`.`risk`.`pool`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Commercial, Medicare Advantage, Medicaid) for the risk pool"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g., Individual, Small Group, Large Group) of the risk pool"
    - name: "pool_status"
      expr: pool_status
      comment: "Current operational status of the risk pool"
    - name: "pool_type"
      expr: pool_type
      comment: "Type classification of the risk pool"
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for the risk pool"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the risk pool coverage area"
    - name: "aca_compliance_flag"
      expr: aca_compliance_flag
      comment: "Whether the pool is ACA-compliant"
    - name: "is_excluded_from_mlr"
      expr: is_excluded_from_mlr
      comment: "Whether the pool is excluded from Medical Loss Ratio calculations"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the risk pool became effective"
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory basis governing the risk pool"
  measures:
    - name: "total_paid_claims"
      expr: SUM(CAST(total_paid_claims AS DOUBLE))
      comment: "Total paid claims across risk pools — primary financial outflow measure for reserving and profitability analysis"
    - name: "total_incurred_claims"
      expr: SUM(CAST(total_incurred_claims AS DOUBLE))
      comment: "Total incurred claims (paid + reserved) across risk pools — key actuarial liability measure"
    - name: "total_reserve_amount"
      expr: SUM(CAST(total_reserve_amount AS DOUBLE))
      comment: "Total reserve amounts held across risk pools — critical for solvency and regulatory compliance"
    - name: "total_member_months"
      expr: SUM(CAST(member_months AS DOUBLE))
      comment: "Total member months across risk pools — denominator for PMPM calculations and exposure measurement"
    - name: "avg_pmpm"
      expr: AVG(CAST(pmpm AS DOUBLE))
      comment: "Average per-member-per-month cost across risk pools — core unit cost metric for pricing and trend analysis"
    - name: "avg_risk_score"
      expr: AVG(CAST(average_risk_score AS DOUBLE))
      comment: "Average risk adjustment score across pools — indicates population acuity and expected cost burden"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor — measures revenue adjustment relative to baseline population"
    - name: "risk_score_variability"
      expr: AVG(CAST(risk_score_stddev AS DOUBLE))
      comment: "Average standard deviation of risk scores — measures heterogeneity within pools, important for reinsurance and stop-loss decisions"
    - name: "pool_count"
      expr: COUNT(1)
      comment: "Count of risk pools — baseline for portfolio breadth analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_member_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member-level risk scoring metrics tracking CMS risk adjustment scores, plan-calculated scores, and score accuracy. Critical for Medicare Advantage revenue optimization and risk adjustment compliance."
  source: "`health_insurance_ecm`.`risk`.`member_risk_score`"
  dimensions:
    - name: "risk_score_type"
      expr: risk_score_type
      comment: "Type of risk score (e.g., prospective, retrospective, concurrent)"
    - name: "risk_score_status"
      expr: risk_score_status
      comment: "Current status of the risk score (e.g., preliminary, final, submitted)"
    - name: "model_name"
      expr: model_name
      comment: "CMS or proprietary risk model used for scoring"
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk scoring model"
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year the risk score applies to"
    - name: "risk_adjustment_factor_category"
      expr: risk_adjustment_factor_category
      comment: "RAF category classification for the member"
    - name: "cms_submission_status"
      expr: cms_submission_status
      comment: "Status of CMS submission for this risk score"
    - name: "risk_score_source"
      expr: risk_score_source
      comment: "Source system or process that generated the risk score"
    - name: "variance_category"
      expr: variance_category
      comment: "Category of variance between plan-calculated and CMS-published scores"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Whether the score was manually overridden"
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status"
    - name: "score_effective_month"
      expr: DATE_TRUNC('MONTH', score_effective_date)
      comment: "Month the risk score became effective"
  measures:
    - name: "avg_risk_score_value"
      expr: AVG(CAST(risk_score_value AS DOUBLE))
      comment: "Average member risk score — primary indicator of population acuity and expected cost"
    - name: "avg_cms_published_score"
      expr: AVG(CAST(cms_published_score AS DOUBLE))
      comment: "Average CMS-published risk score — the official score driving MA revenue"
    - name: "avg_plan_calculated_score"
      expr: AVG(CAST(plan_calculated_score AS DOUBLE))
      comment: "Average plan-calculated risk score — internal estimate before CMS adjudication"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between plan-calculated and CMS scores — measures coding/capture accuracy and revenue leakage risk"
    - name: "avg_demographic_factor_score"
      expr: AVG(CAST(demographic_factor_score AS DOUBLE))
      comment: "Average demographic factor component of risk scores — baseline acuity from age/gender"
    - name: "avg_risk_score_confidence"
      expr: AVG(CAST(risk_score_confidence_score AS DOUBLE))
      comment: "Average confidence score of risk predictions — measures model reliability"
    - name: "scored_member_count"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of distinct members with risk scores — population coverage of scoring program"
    - name: "manual_override_count"
      expr: SUM(CASE WHEN is_manual_override = TRUE THEN 1 ELSE 0 END)
      comment: "Count of manually overridden risk scores — monitors exception handling volume and potential audit exposure"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_ibnr_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incurred But Not Reported (IBNR) reserve metrics tracking reserve adequacy, actuarial confidence, and financial exposure. IBNR is a critical balance sheet liability and regulatory reporting requirement."
  source: "`health_insurance_ecm`.`risk`.`ibnr_reserve`"
  dimensions:
    - name: "ibnr_reserve_status"
      expr: ibnr_reserve_status
      comment: "Status of the IBNR reserve estimate (e.g., preliminary, final, approved)"
    - name: "reserve_methodology"
      expr: reserve_methodology
      comment: "Actuarial methodology used (e.g., chain ladder, Bornhuetter-Ferguson)"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for the reserve"
    - name: "plan_type"
      expr: plan_type
      comment: "Health plan type (e.g., HMO, PPO, EPO)"
    - name: "reserve_adequacy_flag"
      expr: reserve_adequacy_flag
      comment: "Flag indicating whether reserves meet adequacy thresholds"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether this reserve is subject to regulatory reporting"
    - name: "forecast_horizon_months"
      expr: forecast_horizon_months
      comment: "Forecast horizon in months for the IBNR estimate"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reserve amounts"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_month)
      comment: "Service month for which IBNR is estimated"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Valuation date month when the IBNR was calculated"
  measures:
    - name: "total_ibnr_amount"
      expr: SUM(CAST(ibnr_amount AS DOUBLE))
      comment: "Total IBNR reserve amount — key balance sheet liability and solvency indicator"
    - name: "avg_ibnr_pmpm"
      expr: AVG(CAST(ibnr_pmpm AS DOUBLE))
      comment: "Average IBNR per-member-per-month — unit cost of unreported claims liability"
    - name: "avg_expected_loss_ratio"
      expr: AVG(CAST(expected_loss_ratio AS DOUBLE))
      comment: "Average expected loss ratio embedded in IBNR estimates — profitability outlook indicator"
    - name: "avg_actuarial_confidence_level"
      expr: AVG(CAST(actuarial_confidence_level AS DOUBLE))
      comment: "Average actuarial confidence level — measures certainty of reserve estimates"
    - name: "total_rbc_impact_amount"
      expr: SUM(CAST(rbc_impact_amount AS DOUBLE))
      comment: "Total risk-based capital impact of IBNR reserves — regulatory capital adequacy measure"
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average loss development factor — indicates claim maturity and completion patterns"
    - name: "total_hcc_weighted_amount"
      expr: SUM(CAST(hcc_weighted_amount AS DOUBLE))
      comment: "Total HCC-weighted IBNR amount — risk-adjusted reserve reflecting population acuity"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of inputs to IBNR — measures reliability of reserve estimates"
    - name: "avg_confidence_interval_width"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE) - CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average width of confidence interval around IBNR estimates — measures estimation uncertainty"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_adjustment_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment payment metrics tracking CMS payment transfers, reconciliation status, and financial impact. These payments represent the core revenue mechanism for Medicare Advantage risk adjustment."
  source: "`health_insurance_ecm`.`risk`.`adjustment_payment`"
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of risk adjustment payment (e.g., initial, mid-year, final)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment processing status"
    - name: "program_type"
      expr: program_type
      comment: "Risk adjustment program type (e.g., CMS-HCC, RxHCC, ESRD)"
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year for the adjustment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment disbursement"
    - name: "payment_source"
      expr: payment_source
      comment: "Source of the payment (e.g., CMS, state Medicaid agency)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the adjustment payment record"
    - name: "reconciliation_flag"
      expr: reconciliation_flag
      comment: "Whether the payment has been reconciled"
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for the risk adjustment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "payment_effective_month"
      expr: DATE_TRUNC('MONTH', payment_effective_date)
      comment: "Month the payment becomes effective"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment payment amount — net revenue impact from CMS risk adjustment transfers"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross risk adjustment amount before offsets — measures total program revenue"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net risk adjustment amount after offsets — actual cash flow impact"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with adjustment payments — links payment to population acuity"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Count of risk adjustment payment transactions — volume indicator for reconciliation workload"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members receiving risk adjustment payments — population coverage of RA program"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_rbc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-Based Capital (RBC) calculation metrics tracking solvency ratios, capital adequacy, and regulatory action thresholds. RBC is a mandatory regulatory requirement for health insurers monitored by state DOIs and the NAIC."
  source: "`health_insurance_ecm`.`risk`.`rbc_calculation`"
  dimensions:
    - name: "rbc_status"
      expr: rbc_status
      comment: "Current status of the RBC calculation (e.g., preliminary, final, filed)"
    - name: "action_threshold_status"
      expr: action_threshold_status
      comment: "Regulatory action level triggered (e.g., No Action, Company Action, Regulatory Action, Authorized Control, Mandatory Control)"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used for RBC calculation"
    - name: "calculation_period_year"
      expr: YEAR(calculation_period_end_date)
      comment: "Year of the RBC calculation period"
    - name: "source_system"
      expr: source_system
      comment: "Source system for the RBC data"
  measures:
    - name: "avg_rbc_ratio"
      expr: AVG(CAST(rbc_ratio AS DOUBLE))
      comment: "Average RBC ratio (Total Adjusted Capital / Authorized Control Level) — primary solvency indicator; ratios below 200% trigger regulatory scrutiny"
    - name: "avg_total_adjusted_capital"
      expr: AVG(CAST(total_adjusted_capital AS DOUBLE))
      comment: "Average total adjusted capital — numerator of the RBC ratio representing available capital"
    - name: "avg_authorized_control_level"
      expr: AVG(CAST(authorized_control_level_rbc AS DOUBLE))
      comment: "Average authorized control level RBC — the threshold below which regulators can seize control"
    - name: "avg_underwriting_risk"
      expr: AVG(CAST(h1_underwriting_risk AS DOUBLE))
      comment: "Average H1 underwriting risk component — largest risk charge for health insurers, driven by claims volatility"
    - name: "avg_credit_risk"
      expr: AVG(CAST(h2_credit_risk AS DOUBLE))
      comment: "Average H2 credit risk component — counterparty and receivables risk"
    - name: "avg_asset_risk"
      expr: AVG(CAST(h0_asset_risk AS DOUBLE))
      comment: "Average H0 asset risk component — investment portfolio risk charge"
    - name: "avg_covariance_adjustment"
      expr: AVG(CAST(covariance_adjustment AS DOUBLE))
      comment: "Average covariance adjustment — diversification benefit reducing total required capital"
    - name: "calculation_count"
      expr: COUNT(1)
      comment: "Count of RBC calculations — tracks frequency of capital adequacy assessments"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_reinsurance_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance arrangement metrics tracking ceded premium, attachment points, and risk transfer capacity. Reinsurance is critical for managing catastrophic loss exposure and capital efficiency."
  source: "`health_insurance_ecm`.`risk`.`reinsurance_arrangement`"
  dimensions:
    - name: "treaty_type"
      expr: treaty_type
      comment: "Type of reinsurance treaty (e.g., quota share, excess of loss, stop loss)"
    - name: "stop_loss_type"
      expr: stop_loss_type
      comment: "Type of stop-loss coverage (e.g., specific, aggregate)"
    - name: "reinsurance_arrangement_status"
      expr: reinsurance_arrangement_status
      comment: "Current status of the reinsurance arrangement"
    - name: "lob_coverage"
      expr: lob_coverage
      comment: "Line of business covered by the reinsurance arrangement"
    - name: "reinsurer_name"
      expr: reinsurer_name
      comment: "Name of the reinsurance counterparty"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the reinsurance arrangement became effective"
  measures:
    - name: "total_premium_ceded"
      expr: SUM(CAST(premium_ceded AS DOUBLE))
      comment: "Total premium ceded to reinsurers — cost of risk transfer and capital relief"
    - name: "total_maximum_liability"
      expr: SUM(CAST(maximum_liability AS DOUBLE))
      comment: "Total maximum liability covered by reinsurance — upper bound of risk transfer capacity"
    - name: "total_maximum_recovery_limit"
      expr: SUM(CAST(maximum_recovery_limit AS DOUBLE))
      comment: "Total maximum recovery limit — ceiling on reinsurance recoveries"
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point AS DOUBLE))
      comment: "Average attachment point — retention level before reinsurance coverage begins"
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold — aggregate loss level triggering coverage"
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage — proportion of risk shared with reinsurer"
    - name: "total_aggregate_attachment"
      expr: SUM(CAST(aggregate_attachment_amount AS DOUBLE))
      comment: "Total aggregate attachment amounts — aggregate retention before coverage activates"
    - name: "arrangement_count"
      expr: COUNT(1)
      comment: "Count of reinsurance arrangements — portfolio diversification indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_reinsurance_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance claim recovery metrics tracking recoverable amounts, claim status, and recovery effectiveness. Monitors the financial return on reinsurance investment."
  source: "`health_insurance_ecm`.`risk`.`reinsurance_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the reinsurance claim"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of reinsurance claim (e.g., specific, aggregate)"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery from the reinsurer"
    - name: "loss_category"
      expr: loss_category
      comment: "Category of loss driving the reinsurance claim"
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (e.g., individual, group)"
    - name: "is_aggregated"
      expr: is_aggregated
      comment: "Whether the claim is an aggregated submission"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the reinsurance claim"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of claim amounts"
  measures:
    - name: "total_recoverable_amount"
      expr: SUM(CAST(recoverable_amount AS DOUBLE))
      comment: "Total amount recoverable from reinsurers — expected cash inflow from risk transfer"
    - name: "total_incurred_amount"
      expr: SUM(CAST(total_incurred_amount AS DOUBLE))
      comment: "Total incurred amount on reinsurance claims — gross loss before recovery"
    - name: "total_attachment_point_amount"
      expr: SUM(CAST(attachment_point_amount AS DOUBLE))
      comment: "Total attachment point amounts — retained loss before reinsurance applies"
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Count of reinsurance claims — frequency of large loss events"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members with reinsurance claims — identifies high-cost member concentration"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_hcc_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HCC (Hierarchical Condition Category) mapping metrics tracking diagnosis-to-HCC coding accuracy, risk score weights, and adjustment factors. HCC mappings are the foundation of CMS risk adjustment revenue."
  source: "`health_insurance_ecm`.`risk`.`hcc_mapping`"
  dimensions:
    - name: "hcc_code"
      expr: hcc_code
      comment: "HCC condition category code"
    - name: "hcc_mapping_status"
      expr: hcc_mapping_status
      comment: "Status of the HCC mapping (e.g., active, inactive, pending review)"
    - name: "model_year"
      expr: model_year
      comment: "CMS model year for the HCC mapping"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the HCC hierarchy — higher levels supersede lower ones"
    - name: "mapping_source"
      expr: mapping_source
      comment: "Source of the HCC mapping (e.g., CMS official, internal crosswalk)"
    - name: "review_status"
      expr: review_status
      comment: "Review status of the mapping"
    - name: "is_excluded"
      expr: is_excluded
      comment: "Whether the mapping is excluded from scoring"
    - name: "is_mapped"
      expr: is_mapped
      comment: "Whether the ICD-10 code is successfully mapped to an HCC"
    - name: "disease_interaction_group"
      expr: disease_interaction_group
      comment: "Disease interaction group for HCC interaction scoring"
  measures:
    - name: "avg_coefficient"
      expr: AVG(CAST(coefficient AS DOUBLE))
      comment: "Average HCC coefficient — the incremental risk score contribution per condition category"
    - name: "avg_risk_score_weight"
      expr: AVG(CAST(risk_score_weight AS DOUBLE))
      comment: "Average risk score weight — relative importance of each HCC in the risk model"
    - name: "avg_age_adjustment_factor"
      expr: AVG(CAST(age_adjustment_factor AS DOUBLE))
      comment: "Average age adjustment factor applied to HCC mappings"
    - name: "avg_demographic_adjustment_factor"
      expr: AVG(CAST(demographic_adjustment_factor AS DOUBLE))
      comment: "Average demographic adjustment factor — population characteristic modifier"
    - name: "mapped_diagnosis_count"
      expr: COUNT(1)
      comment: "Total count of ICD-10 to HCC mappings — coding capture breadth indicator"
    - name: "distinct_hcc_count"
      expr: COUNT(DISTINCT hcc_code)
      comment: "Count of distinct HCC codes in the mapping — condition category coverage"
    - name: "excluded_mapping_count"
      expr: SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END)
      comment: "Count of excluded mappings — monitors hierarchy suppression and coding exclusions"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS risk adjustment submission metrics tracking submission volumes, acceptance rates, and financial impact. Monitors the effectiveness of the encounter/RAPS data submission pipeline that drives MA revenue."
  source: "`health_insurance_ecm`.`risk`.`risk_cms_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the CMS submission"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., initial, resubmission, void)"
    - name: "cms_acknowledgment_status"
      expr: cms_acknowledgment_status
      comment: "CMS acknowledgment status of the submission"
    - name: "payment_year"
      expr: payment_year
      comment: "CMS payment year for the submission"
    - name: "service_year"
      expr: service_year
      comment: "Service year of the encounters submitted"
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter data submitted"
    - name: "error_disposition"
      expr: error_disposition
      comment: "Disposition of submission errors"
    - name: "contract_number"
      expr: contract_number
      comment: "CMS contract number for the submission"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission to CMS"
  measures:
    - name: "total_record_count"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Total records submitted to CMS — volume of risk adjustment data flowing to CMS"
    - name: "total_accepted_records"
      expr: SUM(CAST(accepted_record_count AS DOUBLE))
      comment: "Total records accepted by CMS — successful data submissions driving revenue"
    - name: "total_rejected_records"
      expr: SUM(CAST(rejected_record_count AS DOUBLE))
      comment: "Total records rejected by CMS — data quality failures requiring remediation"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment amount from submissions — financial impact of submitted data"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount from CMS submissions — net revenue impact after adjustments"
    - name: "total_claim_amount"
      expr: SUM(CAST(total_claim_amount AS DOUBLE))
      comment: "Total claim amounts in CMS submissions — underlying medical cost basis"
    - name: "avg_risk_adjustment_score"
      expr: AVG(CAST(risk_adjustment_score AS DOUBLE))
      comment: "Average risk adjustment score across submissions — population acuity indicator"
    - name: "submission_count"
      expr: COUNT(1)
      comment: "Count of CMS submissions — operational throughput of the RA submission pipeline"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_rate_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate development metrics tracking premium rate components, rating factors, and MLR targets. Rate development is the actuarial process that determines premium pricing and directly impacts revenue and competitiveness."
  source: "`health_insurance_ecm`.`risk`.`rate_development`"
  dimensions:
    - name: "rate_development_status"
      expr: rate_development_status
      comment: "Status of the rate development (e.g., draft, approved, filed)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the rate development"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type being rated (e.g., HMO, PPO, HDHP)"
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area"
    - name: "rate_methodology"
      expr: rate_methodology
      comment: "Methodology used for rate development (e.g., experience-rated, manual-rated, blended)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the developed rate becomes effective"
    - name: "rating_period_start"
      expr: DATE_TRUNC('MONTH', rating_period_start)
      comment: "Start of the rating period"
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate — foundational premium rate before adjustments"
    - name: "avg_final_approved_rate"
      expr: AVG(CAST(final_approved_rate AS DOUBLE))
      comment: "Average final approved rate — the rate filed with regulators and charged to members"
    - name: "avg_trend_factor"
      expr: AVG(CAST(trend_factor AS DOUBLE))
      comment: "Average medical cost trend factor — year-over-year cost inflation assumption"
    - name: "avg_credibility_factor"
      expr: AVG(CAST(credibility_factor AS DOUBLE))
      comment: "Average credibility factor — weight given to group's own experience vs. manual rate"
    - name: "avg_mlr_target"
      expr: AVG(CAST(mlr_target AS DOUBLE))
      comment: "Average Medical Loss Ratio target — regulatory minimum percentage of premium spent on medical care"
    - name: "avg_administrative_loading"
      expr: AVG(CAST(administrative_loading AS DOUBLE))
      comment: "Average administrative loading — non-medical cost component of premium"
    - name: "avg_profit_margin"
      expr: AVG(CAST(profit_margin AS DOUBLE))
      comment: "Average profit margin embedded in rates — target underwriting gain"
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic rating factor — area cost adjustment"
    - name: "rate_development_count"
      expr: COUNT(1)
      comment: "Count of rate developments — pricing activity volume"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_radv_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Adjustment Data Validation (RADV) audit metrics tracking CMS audit findings, payment errors, and settlement amounts. RADV audits represent significant financial and compliance risk for MA plans."
  source: "`health_insurance_ecm`.`risk`.`radv_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the RADV audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of RADV audit (e.g., national, contract-level, targeted)"
    - name: "audit_year"
      expr: audit_year
      comment: "Year of the RADV audit"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against audit findings"
    - name: "audit_error_flag"
      expr: audit_error_flag
      comment: "Whether errors were found in the audit"
    - name: "contract_number"
      expr: contract_number
      comment: "CMS contract number being audited"
    - name: "medical_record_request_status"
      expr: medical_record_request_status
      comment: "Status of medical record retrieval for audit support"
    - name: "audit_source"
      expr: audit_source
      comment: "Source or initiator of the audit"
  measures:
    - name: "total_extrapolated_payment_error"
      expr: SUM(CAST(extrapolated_payment_error AS DOUBLE))
      comment: "Total extrapolated payment error — CMS-estimated overpayment exposure from audit findings, potentially billions in industry impact"
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement amounts — actual financial resolution of RADV audits"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor from audited populations — validated acuity level"
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Count of RADV audits — compliance exposure and audit activity volume"
    - name: "error_audit_count"
      expr: SUM(CASE WHEN audit_error_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits with errors found — coding accuracy failure rate indicator"
    - name: "distinct_member_audited"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of distinct members audited — sample size and exposure breadth"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_score_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk score run execution metrics tracking model performance, population scoring coverage, and RAF score distributions. Score runs are the operational execution of risk models that drive revenue forecasting."
  source: "`health_insurance_ecm`.`risk`.`score_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the score run"
    - name: "run_type"
      expr: run_type
      comment: "Type of score run (e.g., production, test, ad-hoc)"
    - name: "model_name"
      expr: model_name
      comment: "Name of the risk model executed"
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk model"
    - name: "risk_model_type"
      expr: risk_model_type
      comment: "Type of risk model (e.g., CMS-HCC, RxHCC, prospective)"
    - name: "cms_model_year"
      expr: cms_model_year
      comment: "CMS model year for the score run"
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment scored (e.g., community, institutional, ESRD)"
    - name: "model_status"
      expr: model_status
      comment: "Status of the model used in the run"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the input data"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the score run execution"
  measures:
    - name: "total_raf_score"
      expr: SUM(CAST(total_raf_score AS DOUBLE))
      comment: "Total RAF score across all score runs — aggregate risk adjustment factor driving MA revenue"
    - name: "avg_raf_score"
      expr: AVG(CAST(average_raf_score AS DOUBLE))
      comment: "Average RAF score per run — population-level acuity indicator"
    - name: "total_member_population"
      expr: SUM(CAST(member_population_count AS DOUBLE))
      comment: "Total members scored across runs — scoring program reach"
    - name: "avg_normalization_factor"
      expr: AVG(CAST(normalization_factor AS DOUBLE))
      comment: "Average CMS normalization factor applied — annual adjustment that reduces RAF scores industry-wide"
    - name: "score_run_count"
      expr: COUNT(1)
      comment: "Count of score runs executed — operational cadence of risk scoring"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting case metrics tracking premium development, risk classification, and group risk assessment. Underwriting is the gatekeeping function that determines pricing adequacy and portfolio risk selection."
  source: "`health_insurance_ecm`.`risk`.`risk_underwriting_case`"
  dimensions:
    - name: "risk_underwriting_case_status"
      expr: risk_underwriting_case_status
      comment: "Status of the underwriting case (e.g., pending, approved, declined)"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification assigned to the case (e.g., standard, substandard, preferred)"
    - name: "underwriting_tier"
      expr: underwriting_tier
      comment: "Underwriting tier assignment"
    - name: "lob"
      expr: lob
      comment: "Line of business for the underwriting case"
    - name: "applicant_type"
      expr: applicant_type
      comment: "Type of applicant (e.g., new business, renewal)"
    - name: "is_self_insured"
      expr: is_self_insured
      comment: "Whether the group is self-insured (ASO)"
    - name: "premium_rate_type"
      expr: premium_rate_type
      comment: "Type of premium rate (e.g., community-rated, experience-rated)"
    - name: "medical_underwriting_status"
      expr: medical_underwriting_status
      comment: "Medical underwriting status"
    - name: "stop_loss_arrangement"
      expr: stop_loss_arrangement
      comment: "Stop-loss arrangement type for the case"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the underwriting case was submitted"
    - name: "rating_period"
      expr: rating_period
      comment: "Rating period for the underwriting case"
  measures:
    - name: "total_gross_premium"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium from underwriting cases — top-line revenue from underwritten business"
    - name: "total_net_premium"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after adjustments — actual premium revenue retained"
    - name: "total_premium_adjustment"
      expr: SUM(CAST(premium_adjustment_amount AS DOUBLE))
      comment: "Total premium adjustments — modifications from base pricing due to risk factors"
    - name: "avg_overall_group_risk_score"
      expr: AVG(CAST(overall_group_risk_score AS DOUBLE))
      comment: "Average group risk score — composite measure of group health risk profile"
    - name: "avg_expected_claims_pmpm"
      expr: AVG(CAST(expected_claims_pmpm AS DOUBLE))
      comment: "Average expected claims PMPM — projected per-member cost used in pricing"
    - name: "avg_prior_year_claims_pmpm"
      expr: AVG(CAST(prior_year_claims_pmpm AS DOUBLE))
      comment: "Average prior year claims PMPM — historical cost basis for experience rating"
    - name: "avg_morbidity_factor"
      expr: AVG(CAST(morbidity_factor AS DOUBLE))
      comment: "Average morbidity factor — population health adjustment in underwriting"
    - name: "avg_industry_risk_factor"
      expr: AVG(CAST(industry_risk_factor AS DOUBLE))
      comment: "Average industry risk factor — SIC/NAICS-based risk adjustment"
    - name: "avg_chronic_condition_prevalence"
      expr: AVG(CAST(chronic_condition_prevalence_rate AS DOUBLE))
      comment: "Average chronic condition prevalence rate — key driver of expected claims cost"
    - name: "case_count"
      expr: COUNT(1)
      comment: "Count of underwriting cases — new business and renewal pipeline volume"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`risk_actuarial_assumption_set`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial assumption set metrics tracking trend rates, loss development factors, and credibility parameters. These assumptions underpin all pricing, reserving, and financial projections."
  source: "`health_insurance_ecm`.`risk`.`actuarial_assumption_set`"
  dimensions:
    - name: "actuarial_assumption_set_status"
      expr: actuarial_assumption_set_status
      comment: "Status of the assumption set (e.g., draft, approved, expired)"
    - name: "actuarial_assumption_set_type"
      expr: actuarial_assumption_set_type
      comment: "Type of assumption set (e.g., pricing, reserving, forecasting)"
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the assumption set"
    - name: "is_peer_reviewed"
      expr: is_peer_reviewed
      comment: "Whether the assumptions have been peer reviewed"
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Whether the assumptions meet regulatory compliance standards"
    - name: "peer_review_status"
      expr: peer_review_status
      comment: "Status of peer review process"
    - name: "methodology_description"
      expr: methodology_description
      comment: "Description of the actuarial methodology used"
  measures:
    - name: "avg_trend_rate_medical_cost"
      expr: AVG(CAST(trend_rate_medical_cost AS DOUBLE))
      comment: "Average medical cost trend rate — year-over-year medical inflation assumption driving pricing"
    - name: "avg_trend_rate_pharmacy"
      expr: AVG(CAST(trend_rate_pharmacy AS DOUBLE))
      comment: "Average pharmacy trend rate — drug cost inflation assumption, often highest trend component"
    - name: "avg_trend_rate_utilization"
      expr: AVG(CAST(trend_rate_utilization AS DOUBLE))
      comment: "Average utilization trend rate — service volume change assumption"
    - name: "avg_compound_trend_factor"
      expr: AVG(CAST(compound_trend_factor AS DOUBLE))
      comment: "Average compound trend factor — combined multi-year trend projection"
    - name: "avg_lapse_rate"
      expr: AVG(CAST(lapse_rate AS DOUBLE))
      comment: "Average lapse rate assumption — member attrition rate affecting revenue projections"
    - name: "avg_mortality_rate"
      expr: AVG(CAST(mortality_rate AS DOUBLE))
      comment: "Average mortality rate assumption — critical for life and stop-loss pricing"
    - name: "avg_credibility_weight"
      expr: AVG(CAST(credibility_weight AS DOUBLE))
      comment: "Average credibility weight — statistical reliability of experience data"
    - name: "avg_loss_development_factor_cumulative"
      expr: AVG(CAST(loss_development_factor_cumulative AS DOUBLE))
      comment: "Average cumulative loss development factor — projects immature claims to ultimate cost"
    - name: "assumption_set_count"
      expr: COUNT(1)
      comment: "Count of actuarial assumption sets — governance and version control indicator"
$$;