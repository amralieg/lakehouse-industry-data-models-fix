-- Metric views for domain: contract | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core provider contract metrics tracking contract portfolio health, value-based care adoption, payment methodology mix, and contract lifecycle status for strategic network management."
  source: "`health_insurance_ecm`.`contract`.`contract_provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the provider contract (e.g., active, terminated, pending)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of provider contract (e.g., facility, professional, ancillary)."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology used (e.g., fee-for-service, capitation, bundled)."
    - name: "provider_type"
      expr: provider_type
      comment: "Type of provider under contract (e.g., hospital, physician group, specialist)."
    - name: "lob_applicability"
      expr: lob_applicability
      comment: "Line of business the contract applies to (e.g., Commercial, Medicare, Medicaid)."
    - name: "risk_sharing_model"
      expr: risk_sharing_model
      comment: "Risk sharing arrangement model (e.g., upside only, two-sided risk)."
    - name: "contract_tier"
      expr: contract_tier
      comment: "Tier classification of the contract for network adequacy and reimbursement levels."
    - name: "vbc_flag"
      expr: CASE WHEN vbc_flag = true THEN 'VBC' ELSE 'Non-VBC' END
      comment: "Whether the contract is a value-based care arrangement."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective for trending analysis."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of record for the contract."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Total number of active provider contracts in the portfolio."
    - name: "vbc_contract_count"
      expr: COUNT(CASE WHEN vbc_flag = true THEN 1 END)
      comment: "Number of value-based care contracts, indicating VBC adoption progress."
    - name: "vbc_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbc_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all contracts that are value-based care arrangements — key strategic KPI for VBC transformation."
    - name: "avg_capitation_rate_pmpm"
      expr: ROUND(AVG(CAST(capitation_rate_pmpm AS DOUBLE)), 2)
      comment: "Average per-member-per-month capitation rate across capitated contracts."
    - name: "quality_incentive_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_incentive_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with quality incentive provisions — measures quality program penetration."
    - name: "delegation_contract_count"
      expr: COUNT(CASE WHEN delegation_flag = true THEN 1 END)
      comment: "Number of contracts with delegated functions, critical for oversight and compliance monitoring."
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts set to auto-renew — indicates contract retention strategy effectiveness."
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total count of provider contracts for portfolio sizing and denominator use."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment metrics tracking payment volumes, PMPM rates, withhold amounts, and risk-adjusted economics for capitated provider arrangements."
  source: "`health_insurance_ecm`.`contract`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the capitation payment (e.g., processed, pending, voided)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of capitation payment (e.g., standard, retroactive, reconciliation)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the payment (e.g., Commercial, Medicare Advantage, Medicaid)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment disbursement (e.g., EFT, check)."
    - name: "capitation_rate_tier"
      expr: capitation_rate_tier
      comment: "Rate tier applied to the capitation payment for tiered arrangements."
    - name: "vbc_contract_flag"
      expr: CASE WHEN vbc_contract_flag = true THEN 'VBC' ELSE 'Non-VBC' END
      comment: "Whether the payment is associated with a value-based care contract."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment month for time-series trending of capitation spend."
    - name: "prior_period_adjustment_flag"
      expr: CASE WHEN prior_period_adjustment_flag = true THEN 'Prior Period Adj' ELSE 'Current Period' END
      comment: "Whether the payment is a prior period adjustment."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross capitation payments before withholds and adjustments — primary capitation spend metric."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payments after all withholds and adjustments — actual cash outflow."
    - name: "total_quality_withhold_amount"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold amounts held back pending performance evaluation."
    - name: "total_risk_pool_withhold_amount"
      expr: SUM(CAST(risk_pool_withhold_amount AS DOUBLE))
      comment: "Total risk pool withhold amounts reserved for shared savings/loss reconciliation."
    - name: "total_stop_loss_recovery"
      expr: SUM(CAST(stop_loss_recovery_amount AS DOUBLE))
      comment: "Total stop-loss recoveries — indicates catastrophic claim protection utilization."
    - name: "avg_pmpm_rate"
      expr: ROUND(AVG(CAST(pmpm_rate AS DOUBLE)), 2)
      comment: "Average PMPM capitation rate across all payments — key unit cost metric."
    - name: "avg_risk_adjusted_pmpm_rate"
      expr: ROUND(AVG(CAST(risk_adjusted_pmpm_rate AS DOUBLE)), 2)
      comment: "Average risk-adjusted PMPM rate — reflects acuity-adjusted payment levels."
    - name: "avg_risk_score"
      expr: ROUND(AVG(CAST(risk_score AS DOUBLE)), 2)
      comment: "Average risk score across capitation payments — monitors population acuity trends."
    - name: "total_enrollment_adjustment"
      expr: SUM(CAST(enrollment_adjustment_amount AS DOUBLE))
      comment: "Total enrollment adjustment amounts reflecting membership changes mid-period."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of capitation payment transactions processed."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract audit metrics tracking audit findings, payment variances, error rates, and corrective action compliance for provider contract oversight."
  source: "`health_insurance_ecm`.`contract`.`contract_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., in-progress, completed, pending review)."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit performed (e.g., claims, financial, compliance, coding)."
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor (e.g., internal, external, regulatory)."
    - name: "findings_severity"
      expr: findings_severity
      comment: "Severity level of audit findings (e.g., critical, major, minor)."
    - name: "lob"
      expr: lob
      comment: "Line of business audited."
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Status of corrective action plan if required."
    - name: "regulatory_mandate_flag"
      expr: CASE WHEN regulatory_mandate_flag = true THEN 'Regulatory Mandated' ELSE 'Voluntary' END
      comment: "Whether the audit was mandated by a regulatory body."
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit was conducted for annual trending."
  measures:
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayments identified through audits — direct recovery opportunity."
    - name: "total_underpayment_amount"
      expr: SUM(CAST(underpayment_amount AS DOUBLE))
      comment: "Total underpayments identified — provider relationship and compliance risk."
    - name: "net_payment_variance"
      expr: SUM(CAST(net_payment_variance AS DOUBLE))
      comment: "Net payment variance (overpayments minus underpayments) — overall payment accuracy indicator."
    - name: "avg_error_rate_pct"
      expr: ROUND(AVG(CAST(error_rate_pct AS DOUBLE)), 2)
      comment: "Average error rate percentage across audits — key quality and compliance metric."
    - name: "cap_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action plans — indicates systemic compliance issues."
    - name: "siu_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN siu_referral_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in Special Investigations Unit referrals — fraud/waste/abuse indicator."
    - name: "completed_audit_count"
      expr: COUNT(CASE WHEN audit_status = 'completed' THEN 1 END)
      comment: "Number of completed audits for throughput tracking."
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of contract audits conducted."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract dispute metrics tracking dispute volumes, resolution rates, financial exposure, and SLA compliance for provider relations management."
  source: "`health_insurance_ecm`.`contract`.`contract_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, under review, resolved, escalated)."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of contract dispute (e.g., rate, payment, term interpretation, credentialing)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispute for triage and resource allocation."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of dispute resolution (e.g., provider favorable, plan favorable, compromise)."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business associated with the dispute."
    - name: "escalation_flag"
      expr: CASE WHEN escalation_flag = true THEN 'Escalated' ELSE 'Standard' END
      comment: "Whether the dispute has been escalated beyond initial handling."
    - name: "initiation_month"
      expr: DATE_TRUNC('month', initiation_date)
      comment: "Month the dispute was initiated for volume trending."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount in dispute — measures financial exposure from provider disagreements."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amounts paid/adjusted in dispute resolutions — actual financial impact."
    - name: "avg_disputed_amount"
      expr: ROUND(AVG(CAST(disputed_amount AS DOUBLE)), 2)
      comment: "Average disputed amount per dispute — indicates typical dispute magnitude."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes resolved within SLA — critical operational and regulatory compliance metric."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that required escalation — indicates first-level resolution effectiveness."
    - name: "legal_involvement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_counsel_involved = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes involving legal counsel — risk and cost escalation indicator."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status IN ('open', 'under_review', 'escalated') THEN 1 END)
      comment: "Number of currently open/active disputes requiring attention."
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of contract disputes filed."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_financial_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract financial summary metrics tracking total allowed and paid amounts, IBNR reserves, withhold balances, and reconciliation status for financial oversight of provider contracts."
  source: "`health_insurance_ecm`.`contract`.`financial_summary`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract for financial segmentation."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology driving the financial summary."
    - name: "financial_summary_status"
      expr: financial_summary_status
      comment: "Status of the financial summary record."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation (e.g., pending, completed, in-progress)."
    - name: "summary_period_type"
      expr: summary_period_type
      comment: "Period type of the summary (e.g., monthly, quarterly, annual)."
    - name: "summary_period_start_month"
      expr: DATE_TRUNC('month', summary_period_start)
      comment: "Start month of the summary period for time-series analysis."
  measures:
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amounts across contracts — represents contractual obligation exposure."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total paid amounts across contracts — actual disbursements to providers."
    - name: "total_ibnr_estimate"
      expr: SUM(CAST(ibnr_estimate_amount AS DOUBLE))
      comment: "Total incurred-but-not-reported reserve estimates — critical for financial reserving and actuarial accuracy."
    - name: "total_withhold_pool_balance"
      expr: SUM(CAST(withhold_pool_balance AS DOUBLE))
      comment: "Total withhold pool balances pending performance evaluation and release."
    - name: "total_incentive_earned"
      expr: SUM(CAST(incentive_earned_amount AS DOUBLE))
      comment: "Total incentive amounts earned by providers — measures VBC program financial impact."
    - name: "total_capitation_accrual_balance"
      expr: SUM(CAST(capitation_accrual_balance AS DOUBLE))
      comment: "Total capitation accrual balances — outstanding capitation financial obligations."
    - name: "total_mrl_allocation"
      expr: SUM(CAST(mrl_allocation_amount AS DOUBLE))
      comment: "Total minimum reserve level allocations — regulatory capital adequacy indicator."
    - name: "avg_quality_score"
      expr: ROUND(AVG(CAST(quality_score AS DOUBLE)), 2)
      comment: "Average quality score across contract financial summaries — links financial performance to quality outcomes."
    - name: "avg_risk_share_percentage"
      expr: ROUND(AVG(CAST(risk_share_percentage AS DOUBLE)), 2)
      comment: "Average risk share percentage — indicates depth of risk-based contracting."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_vbc_performance_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care performance period metrics tracking expenditure vs benchmarks, shared savings/losses, quality scores, and settlement outcomes for VBC program evaluation."
  source: "`health_insurance_ecm`.`contract`.`vbc_performance_period`"
  dimensions:
    - name: "period_status"
      expr: period_status
      comment: "Status of the performance period (e.g., active, reconciled, settled)."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for annual VBC program evaluation."
    - name: "payment_model"
      expr: payment_model
      comment: "VBC payment model type (e.g., shared savings, bundled, global capitation)."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation process for the performance period."
    - name: "quality_gate_met"
      expr: CASE WHEN quality_gate_met = true THEN 'Quality Gate Met' ELSE 'Quality Gate Not Met' END
      comment: "Whether the quality gate threshold was met — determines eligibility for shared savings."
    - name: "lob"
      expr: lob
      comment: "Line of business for the VBC arrangement."
    - name: "risk_model"
      expr: risk_model
      comment: "Risk adjustment model used (e.g., HCC, ACG)."
    - name: "period_type"
      expr: period_type
      comment: "Type of performance period (e.g., annual, semi-annual)."
  measures:
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditures across VBC performance periods — actual cost of care delivered."
    - name: "total_benchmark_expenditure"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure targets — the cost target against which performance is measured."
    - name: "total_expenditure_variance"
      expr: SUM(CAST(expenditure_variance AS DOUBLE))
      comment: "Total expenditure variance (actual vs benchmark) — positive indicates savings, negative indicates overrun."
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned — direct financial benefit of VBC programs."
    - name: "total_shared_loss_amount"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses incurred — financial risk exposure from VBC arrangements."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts — bottom-line financial outcome of VBC programs."
    - name: "avg_quality_score"
      expr: ROUND(AVG(CAST(quality_score AS DOUBLE)), 2)
      comment: "Average quality score across performance periods — measures clinical quality achievement."
    - name: "avg_star_rating"
      expr: ROUND(AVG(CAST(star_rating AS DOUBLE)), 2)
      comment: "Average star rating — CMS quality rating indicator for Medicare Advantage programs."
    - name: "avg_actual_pmpm"
      expr: ROUND(AVG(CAST(actual_pmpm AS DOUBLE)), 2)
      comment: "Average actual PMPM cost — unit cost efficiency metric for VBC populations."
    - name: "avg_benchmark_pmpm"
      expr: ROUND(AVG(CAST(benchmark_pmpm AS DOUBLE)), 2)
      comment: "Average benchmark PMPM — target unit cost for VBC performance evaluation."
    - name: "avg_raf_score"
      expr: ROUND(AVG(CAST(raf_score AS DOUBLE)), 2)
      comment: "Average risk adjustment factor score — population acuity measure critical for fair benchmarking."
    - name: "quality_gate_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_gate_met = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of performance periods meeting quality gate — determines shared savings eligibility."
    - name: "total_withhold_amount"
      expr: SUM(CAST(withhold_amount AS DOUBLE))
      comment: "Total withhold amounts reserved pending performance evaluation."
    - name: "total_ibnr_reserve"
      expr: SUM(CAST(ibnr_reserve_amount AS DOUBLE))
      comment: "Total IBNR reserves for VBC periods — actuarial liability estimate."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_capitation_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation arrangement metrics tracking arrangement portfolio, PMPM rates, risk sharing depth, and stop-loss thresholds for capitated network management."
  source: "`health_insurance_ecm`.`contract`.`capitation_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the capitation arrangement."
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of capitation arrangement (e.g., global, professional, institutional)."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for the capitation arrangement."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology within the capitation arrangement."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of capitation payments (e.g., monthly, bi-weekly)."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of the capitated arrangement."
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used for member attribution to the capitated provider."
    - name: "service_category_scope"
      expr: service_category_scope
      comment: "Scope of services covered under the capitation arrangement."
    - name: "vbc_arrangement_flag"
      expr: CASE WHEN vbc_arrangement_flag = true THEN 'VBC' ELSE 'Non-VBC' END
      comment: "Whether the arrangement is part of a value-based care program."
  measures:
    - name: "avg_pmpm_rate"
      expr: ROUND(AVG(CAST(pmpm_rate AS DOUBLE)), 2)
      comment: "Average PMPM capitation rate across arrangements — key unit cost benchmark."
    - name: "avg_withhold_percentage"
      expr: ROUND(AVG(CAST(withhold_percentage AS DOUBLE)), 2)
      comment: "Average withhold percentage — indicates depth of performance-based risk retention."
    - name: "avg_risk_share_percentage"
      expr: ROUND(AVG(CAST(risk_share_percentage AS DOUBLE)), 2)
      comment: "Average risk share percentage — measures risk transfer depth in capitated arrangements."
    - name: "avg_annual_rate_escalator"
      expr: ROUND(AVG(CAST(annual_rate_escalator AS DOUBLE)), 2)
      comment: "Average annual rate escalator — tracks rate inflation trends in capitation contracts."
    - name: "avg_individual_stop_loss_threshold"
      expr: ROUND(AVG(CAST(individual_stop_loss_threshold AS DOUBLE)), 2)
      comment: "Average individual stop-loss threshold — catastrophic risk protection level per member."
    - name: "avg_aggregate_stop_loss_threshold"
      expr: ROUND(AVG(CAST(aggregate_stop_loss_threshold AS DOUBLE)), 2)
      comment: "Average aggregate stop-loss threshold — total portfolio risk protection level."
    - name: "risk_pool_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_pool_participant = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements participating in risk pools — shared risk adoption indicator."
    - name: "aco_arrangement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN aco_arrangement_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capitation arrangements that are ACO-based — ACO strategy penetration."
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total number of capitation arrangements in the portfolio."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_incentive_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incentive arrangement metrics tracking performance-based incentive pools, withhold amounts, earned vs forfeited incentives, and quality outcomes for VBC program financial management."
  source: "`health_insurance_ecm`.`contract`.`incentive_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Status of the incentive arrangement (e.g., active, settled, pending)."
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of incentive arrangement (e.g., quality bonus, shared savings, P4P)."
    - name: "earned_status"
      expr: earned_status
      comment: "Whether the incentive has been earned, forfeited, or is pending evaluation."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for the incentive arrangement."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance measurement year."
    - name: "vbc_program_name"
      expr: vbc_program_name
      comment: "Name of the VBC program the incentive is associated with."
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure performance for incentive determination."
    - name: "quality_gate_met"
      expr: CASE WHEN quality_gate_met = true THEN 'Met' ELSE 'Not Met' END
      comment: "Whether the quality gate was met for incentive eligibility."
  measures:
    - name: "total_withheld_amount"
      expr: SUM(CAST(total_withheld_amount AS DOUBLE))
      comment: "Total amounts withheld pending performance evaluation — represents at-risk provider compensation."
    - name: "total_amount_released"
      expr: SUM(CAST(amount_released AS DOUBLE))
      comment: "Total incentive amounts released to providers — actual performance-based payouts."
    - name: "total_amount_forfeited"
      expr: SUM(CAST(amount_forfeited AS DOUBLE))
      comment: "Total incentive amounts forfeited due to unmet performance targets — plan savings from underperformance."
    - name: "total_maximum_incentive"
      expr: SUM(CAST(maximum_incentive_amount AS DOUBLE))
      comment: "Total maximum incentive opportunity — ceiling of performance-based compensation."
    - name: "total_maximum_penalty"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure — downside risk in two-sided arrangements."
    - name: "incentive_release_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_released AS DOUBLE)) / NULLIF(SUM(CAST(total_withheld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of withheld amounts released — measures provider performance achievement rate."
    - name: "avg_quality_score"
      expr: ROUND(AVG(CAST(quality_score AS DOUBLE)), 2)
      comment: "Average quality score across incentive arrangements — clinical quality achievement."
    - name: "avg_withhold_percentage"
      expr: ROUND(AVG(CAST(withhold_percentage AS DOUBLE)), 2)
      comment: "Average withhold percentage — depth of at-risk compensation."
    - name: "quality_gate_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_gate_met = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements meeting quality gate — overall quality program success rate."
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total number of incentive arrangements."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_fee_schedule_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule rate metrics tracking reimbursement levels, rate variations, and payment methodology mix for contract rate adequacy and competitiveness analysis."
  source: "`health_insurance_ecm`.`contract`.`fee_schedule_rate`"
  dimensions:
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the fee schedule rate (e.g., active, expired, pending)."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the rate (e.g., fee schedule, percent of billed, per diem)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the rate applies to."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for tiered reimbursement analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category the rate covers (e.g., medical, surgical, diagnostic)."
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Type of procedure code (e.g., CPT, HCPCS, revenue code)."
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type the rate applies to."
    - name: "rate_derivation_method"
      expr: rate_derivation_method
      comment: "Method used to derive the rate (e.g., Medicare benchmark, negotiated, RBP)."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional rate analysis."
  measures:
    - name: "avg_allowed_amount"
      expr: ROUND(AVG(CAST(allowed_amount AS DOUBLE)), 2)
      comment: "Average allowed amount per rate line — key reimbursement adequacy metric."
    - name: "avg_per_diem_rate"
      expr: ROUND(AVG(CAST(per_diem_rate AS DOUBLE)), 2)
      comment: "Average per diem rate for facility-based reimbursement."
    - name: "avg_medicare_fee_schedule_pct"
      expr: ROUND(AVG(CAST(medicare_fee_schedule_pct AS DOUBLE)), 2)
      comment: "Average percentage of Medicare fee schedule — benchmarks commercial rates against Medicare."
    - name: "avg_rate_percent_of_billed"
      expr: ROUND(AVG(CAST(rate_percent_of_billed AS DOUBLE)), 2)
      comment: "Average percent-of-billed-charges rate — discount depth indicator."
    - name: "avg_capitation_rate_pmpm"
      expr: ROUND(AVG(CAST(capitation_rate_pmpm AS DOUBLE)), 2)
      comment: "Average PMPM capitation rate at the rate line level."
    - name: "avg_bundled_payment_amount"
      expr: ROUND(AVG(CAST(bundled_payment_amount AS DOUBLE)), 2)
      comment: "Average bundled payment amount for episode-based reimbursement."
    - name: "total_rate_lines"
      expr: COUNT(1)
      comment: "Total number of fee schedule rate lines for portfolio sizing."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_bundled_payment_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundled payment episode metrics tracking episode target prices, gain/loss sharing rates, quality withhold levels, and risk adjustment for episode-based payment programs."
  source: "`health_insurance_ecm`.`contract`.`bundled_payment_episode`"
  dimensions:
    - name: "episode_status"
      expr: episode_status
      comment: "Status of the bundled payment episode definition."
    - name: "episode_type"
      expr: episode_type
      comment: "Type of episode (e.g., surgical, medical, chronic)."
    - name: "program_type"
      expr: program_type
      comment: "Bundled payment program type (e.g., BPCI-A, CMS, commercial)."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the episode."
    - name: "lob"
      expr: lob
      comment: "Line of business for the bundled payment episode."
    - name: "reconciliation_methodology"
      expr: reconciliation_methodology
      comment: "Methodology used for episode reconciliation."
    - name: "anchor_setting"
      expr: anchor_setting
      comment: "Anchor setting for the episode trigger (e.g., inpatient, outpatient)."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for the bundled payment program."
  measures:
    - name: "avg_target_price"
      expr: ROUND(AVG(CAST(target_price AS DOUBLE)), 2)
      comment: "Average target price per episode — benchmark cost for episode-based payment."
    - name: "avg_gain_sharing_rate"
      expr: ROUND(AVG(CAST(gain_sharing_rate AS DOUBLE)), 2)
      comment: "Average gain sharing rate — provider upside participation in savings."
    - name: "avg_loss_sharing_rate"
      expr: ROUND(AVG(CAST(loss_sharing_rate AS DOUBLE)), 2)
      comment: "Average loss sharing rate — provider downside risk exposure."
    - name: "avg_quality_withhold_rate"
      expr: ROUND(AVG(CAST(quality_withhold_rate AS DOUBLE)), 2)
      comment: "Average quality withhold rate — portion of payment contingent on quality performance."
    - name: "avg_stop_loss_threshold"
      expr: ROUND(AVG(CAST(stop_loss_threshold AS DOUBLE)), 2)
      comment: "Average stop-loss threshold — catastrophic cost protection level per episode."
    - name: "avg_stop_gain_threshold"
      expr: ROUND(AVG(CAST(stop_gain_threshold AS DOUBLE)), 2)
      comment: "Average stop-gain threshold — cap on provider savings participation."
    - name: "avg_outlier_exclusion_threshold"
      expr: ROUND(AVG(CAST(outlier_exclusion_threshold AS DOUBLE)), 2)
      comment: "Average outlier exclusion threshold — cost level above which episodes are excluded from reconciliation."
    - name: "quality_gate_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_gate_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes requiring quality gate — ensures savings are tied to quality."
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of bundled payment episode definitions."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment metrics tracking amendment volumes, rate changes, approval velocity, and regulatory impact for contract change management oversight."
  source: "`health_insurance_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g., rate change, term extension, scope modification)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the amendment (e.g., approved, pending, rejected)."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business affected by the amendment."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology affected by the amendment."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier affected by the amendment."
    - name: "initiating_party"
      expr: initiating_party
      comment: "Party that initiated the amendment (e.g., plan, provider)."
    - name: "negotiation_outcome"
      expr: negotiation_outcome
      comment: "Outcome of the amendment negotiation."
    - name: "regulatory_mandate_flag"
      expr: CASE WHEN regulatory_mandate_flag = true THEN 'Regulatory Mandated' ELSE 'Voluntary' END
      comment: "Whether the amendment was driven by regulatory mandate."
    - name: "retroactive_flag"
      expr: CASE WHEN retroactive_flag = true THEN 'Retroactive' ELSE 'Prospective' END
      comment: "Whether the amendment has retroactive effect."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment becomes effective."
  measures:
    - name: "avg_rate_change_pct"
      expr: ROUND(AVG(CAST(rate_change_pct AS DOUBLE)), 2)
      comment: "Average rate change percentage across amendments — tracks rate trend direction and magnitude."
    - name: "avg_capitation_rate_pmpm"
      expr: ROUND(AVG(CAST(capitation_rate_pmpm AS DOUBLE)), 2)
      comment: "Average capitation PMPM rate in amendments — tracks capitation rate evolution."
    - name: "retroactive_amendment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments with retroactive effect — operational complexity and claims reprocessing indicator."
    - name: "claims_reprocess_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN claims_reprocess_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments requiring claims reprocessing — operational cost and disruption indicator."
    - name: "regulatory_mandate_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_mandate_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments driven by regulatory mandates — regulatory change impact on contract portfolio."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Number of amendments pending approval — workflow bottleneck indicator."
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of contract amendments processed."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`contract_delegation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegation agreement metrics tracking delegated function oversight, compliance status, and audit readiness for regulatory compliance and risk management."
  source: "`health_insurance_ecm`.`contract`.`delegation_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the delegation agreement (e.g., active, terminated, pending)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of delegation agreement."
    - name: "delegated_function_type"
      expr: delegated_function_type
      comment: "Type of function delegated (e.g., claims, credentialing, UM, network management)."
    - name: "delegation_scope"
      expr: delegation_scope
      comment: "Scope of the delegation (e.g., full, partial)."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for the delegation agreement."
    - name: "financial_arrangement_type"
      expr: financial_arrangement_type
      comment: "Financial arrangement type for the delegation."
    - name: "ncqa_compliance_flag"
      expr: CASE WHEN ncqa_compliance_flag = true THEN 'NCQA Compliant' ELSE 'Non-Compliant' END
      comment: "Whether the delegation meets NCQA compliance standards."
  measures:
    - name: "ncqa_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_compliance_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation agreements meeting NCQA compliance — critical for accreditation."
    - name: "urac_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN urac_compliance_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation agreements meeting URAC compliance standards."
    - name: "cms_oversight_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cms_oversight_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegations requiring CMS oversight — regulatory burden indicator."
    - name: "regulatory_filing_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_filing_required = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegations requiring regulatory filing — compliance workload indicator."
    - name: "active_delegation_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of active delegation agreements requiring ongoing oversight."
    - name: "total_delegation_agreements"
      expr: COUNT(1)
      comment: "Total number of delegation agreements in the portfolio."
$$;