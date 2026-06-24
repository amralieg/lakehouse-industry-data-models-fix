-- Metric views for domain: contract | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks contracted reimbursement rates across procedure codes, network tiers, and lines of business. Enables rate benchmarking, Medicare crosswalk analysis, and fee schedule performance monitoring."
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "CPT/HCPCS procedure code for which the rate applies — primary grouping for rate analysis."
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Classification of the procedure code (CPT, HCPCS, Revenue, DRG) for cross-code-set analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (Tier 1, Tier 2, Out-of-Network) driving differential reimbursement rates."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare Advantage, Medicaid) for LOB-level rate segmentation."
    - name: "service_category"
      expr: service_category
      comment: "Clinical service category (Inpatient, Outpatient, Professional, Ancillary) for category-level benchmarking."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "CMS place-of-service code indicating care setting for site-of-service rate differentials."
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type classification (PCP, Specialist, Facility) for provider-segment rate analysis."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for geographic rate variation analysis and regulatory compliance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate became effective — used for rate trend and cohort analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month the rate expires — used for contract renewal and rate expiration monitoring."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total number of fee schedule rate lines — baseline volume metric for rate schedule coverage."
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average contracted allowed amount per procedure — core rate benchmarking KPI for contract negotiations."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total contracted allowed amount across all rate lines — used for financial exposure and budget modeling."
    - name: "avg_medicare_fee_schedule_pct"
      expr: AVG(CAST(medicare_fee_schedule_pct AS DOUBLE))
      comment: "Average reimbursement rate as a percentage of Medicare fee schedule — key benchmark for contract competitiveness."
    - name: "avg_rate_percent_of_billed"
      expr: AVG(CAST(rate_percent_of_billed AS DOUBLE))
      comment: "Average rate as a percentage of billed charges — measures discount depth and contract efficiency."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem inpatient rate — critical for inpatient cost modeling and facility contract benchmarking."
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation rate per member per month — key metric for capitated contract financial planning."
    - name: "avg_bundled_payment_amount"
      expr: AVG(CAST(bundled_payment_amount AS DOUBLE))
      comment: "Average bundled payment amount per episode — used for VBC contract performance and episode cost benchmarking."
    - name: "avg_rbp_reference_amount"
      expr: AVG(CAST(rbp_reference_amount AS DOUBLE))
      comment: "Average reference-based pricing amount — used for RBP program design and cost containment analysis."
    - name: "distinct_procedure_codes"
      expr: COUNT(DISTINCT procedure_code)
      comment: "Count of distinct procedure codes covered by contracted rates — measures fee schedule breadth and coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_performance_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks value-based contract performance period outcomes including shared savings, quality scores, expenditure variance, and settlement results. Core KPI layer for VBC program management and executive reporting."
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_performance_period`"
  dimensions:
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year of the VBC contract — primary time dimension for year-over-year VBC performance comparison."
    - name: "period_type"
      expr: period_type
      comment: "Type of performance period (Annual, Interim, Final) for period-level performance segmentation."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the performance period (Open, Closed, Reconciled, Appealed) for pipeline monitoring."
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track (MSSP Track 1, Track 2, REACH, etc.) for program-level performance benchmarking."
    - name: "lob"
      expr: lob
      comment: "Line of business for the VBC arrangement — enables LOB-level VBC performance comparison."
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Whether the quality gate threshold was met — determines eligibility for shared savings distribution."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (Pending, Complete, Disputed) for settlement pipeline management."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the performance period started — used for cohort and trend analysis."
  measures:
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned across VBC performance periods — primary financial outcome KPI for VBC programs."
    - name: "total_shared_loss_amount"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses incurred — measures downside risk exposure in two-sided VBC arrangements."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts (savings minus losses) — bottom-line VBC financial performance metric."
    - name: "total_expenditure_variance"
      expr: SUM(CAST(expenditure_variance AS DOUBLE))
      comment: "Total variance between actual and benchmark expenditures — measures cost performance against VBC targets."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality composite score across performance periods — key quality gate metric for shared savings eligibility."
    - name: "avg_hedis_composite_score"
      expr: AVG(CAST(hedis_composite_score AS DOUBLE))
      comment: "Average HEDIS composite score — measures clinical quality performance driving VBC incentive payments."
    - name: "avg_cahps_composite_score"
      expr: AVG(CAST(cahps_composite_score AS DOUBLE))
      comment: "Average CAHPS member satisfaction composite score — patient experience component of VBC quality gates."
    - name: "avg_hcc_capture_rate"
      expr: AVG(CAST(hcc_capture_rate AS DOUBLE))
      comment: "Average HCC risk capture rate — measures risk coding completeness affecting benchmark expenditure calculations."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average risk adjustment factor score — key driver of benchmark expenditure and payment adequacy in VBC."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average CMS star rating — quality performance metric tied to Medicare Advantage bonus payments."
    - name: "total_ibnr_reserve_amount"
      expr: SUM(CAST(ibnr_reserve_amount AS DOUBLE))
      comment: "Total IBNR reserve amounts held for VBC performance periods — critical for accurate net settlement calculation."
    - name: "total_withhold_amount"
      expr: SUM(CAST(withhold_amount AS DOUBLE))
      comment: "Total withheld amounts pending quality gate determination — measures at-risk capitation under VBC arrangements."
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate (%) — measures the proportion of savings returned to the ACO/provider."
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate (%) — measures downside risk sharing percentage in two-sided VBC models."
    - name: "quality_gate_met_count"
      expr: COUNT(CASE WHEN quality_gate_met = TRUE THEN 1 END)
      comment: "Count of performance periods where quality gate was met — measures VBC quality program success rate."
    - name: "performance_period_count"
      expr: COUNT(1)
      comment: "Total number of VBC performance periods — baseline volume metric for VBC program scale."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_financial_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides contract-level financial performance summaries including paid claims, capitation, shared savings, IBNR, and settlement metrics. Enables executive-level contract financial performance monitoring."
  source: "`vibe_health_insurance_v1`.`contract`.`financial_summary`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (Capitation, FFS, VBC, Bundled) for contract-model financial comparison."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for LOB-level financial performance segmentation."
    - name: "summary_period_type"
      expr: summary_period_type
      comment: "Period type (Monthly, Quarterly, Annual) for time-granularity financial reporting."
    - name: "summary_type"
      expr: summary_type
      comment: "Summary type (Preliminary, Final, Restated) for financial reporting stage classification."
    - name: "financial_summary_status"
      expr: financial_summary_status
      comment: "Current status of the financial summary (Draft, Approved, Closed) for workflow monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (Pending, Complete, Disputed) for settlement pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency financial reporting."
    - name: "summary_period_start_month"
      expr: DATE_TRUNC('MONTH', summary_period_start)
      comment: "Month the summary period started — primary time dimension for financial trend analysis."
  measures:
    - name: "total_paid_claims_amount"
      expr: SUM(CAST(paid_claims_amount AS DOUBLE))
      comment: "Total paid claims amount across contracts — primary cost metric for contract financial performance."
    - name: "total_capitation_paid"
      expr: SUM(CAST(total_capitation_paid AS DOUBLE))
      comment: "Total capitation payments made — measures capitation spend under managed care contracts."
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned — measures VBC program financial return on investment."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts — bottom-line contract financial performance after all adjustments."
    - name: "total_ibnr_amount"
      expr: SUM(CAST(ibnr_amount AS DOUBLE))
      comment: "Total IBNR (Incurred But Not Reported) reserve amounts — critical for accurate contract financial close."
    - name: "total_ibnr_estimate_amount"
      expr: SUM(CAST(ibnr_estimate_amount AS DOUBLE))
      comment: "Total estimated IBNR amounts — used for actuarial reserve adequacy assessment."
    - name: "total_incentive_earned_amount"
      expr: SUM(CAST(incentive_earned_amount AS DOUBLE))
      comment: "Total incentive amounts earned by providers — measures quality and performance incentive program effectiveness."
    - name: "total_incentive_paid"
      expr: SUM(CAST(total_incentive_paid AS DOUBLE))
      comment: "Total incentive payments disbursed — tracks actual cash outflow for provider incentive programs."
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total contract revenue — top-line financial metric for contract portfolio revenue management."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amounts under contract — measures contracted cost exposure before member cost-sharing."
    - name: "total_withhold_balance"
      expr: SUM(CAST(withhold_balance AS DOUBLE))
      comment: "Total withhold balance outstanding — measures at-risk provider payments pending quality determination."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across contract financial summaries — links financial performance to quality outcomes."
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk share percentage — measures the degree of financial risk transferred to providers."
    - name: "total_mrl_allocation_amount"
      expr: SUM(CAST(mrl_allocation_amount AS DOUBLE))
      comment: "Total MLR allocation amounts — used for medical loss ratio reporting and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks capitation arrangement configurations including PMPM rates, risk-sharing parameters, stop-loss thresholds, and attribution. Enables contract design analysis and capitation program portfolio management."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of capitation arrangement (Global, Partial, Specialty) for arrangement-model comparison."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the arrangement (Active, Terminated, Pending) for portfolio lifecycle monitoring."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for LOB-level capitation program analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for tier-based capitation rate differentiation."
    - name: "stop_loss_type"
      expr: stop_loss_type
      comment: "Type of stop-loss protection (Individual, Aggregate, Both) for risk management analysis."
    - name: "aco_arrangement_flag"
      expr: aco_arrangement_flag
      comment: "Indicates ACO-based capitation arrangements — enables ACO vs. traditional capitation comparison."
    - name: "vbc_arrangement_flag"
      expr: vbc_arrangement_flag
      comment: "Indicates value-based capitation arrangements — enables VBC vs. traditional capitation segmentation."
    - name: "risk_pool_participant"
      expr: risk_pool_participant
      comment: "Indicates whether the arrangement participates in a shared risk pool — for risk pool financial analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the arrangement became effective — used for cohort and trend analysis."
  measures:
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total number of capitation arrangements — baseline portfolio size metric."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average PMPM capitation rate — core pricing benchmark for capitation contract design and negotiation."
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk share percentage — measures the degree of financial risk transferred to providers."
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average quality withhold percentage — measures the proportion of capitation at risk for quality performance."
    - name: "avg_raf_adjustment_factor"
      expr: AVG(CAST(raf_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor — measures the risk acuity of attributed membership driving capitation rates."
    - name: "avg_annual_rate_escalator"
      expr: AVG(CAST(annual_rate_escalator AS DOUBLE))
      comment: "Average annual rate escalator percentage — measures contracted rate trend and inflation exposure."
    - name: "avg_aggregate_stop_loss_threshold"
      expr: AVG(CAST(aggregate_stop_loss_threshold AS DOUBLE))
      comment: "Average aggregate stop-loss threshold — measures the level of catastrophic cost protection in capitation contracts."
    - name: "avg_individual_stop_loss_threshold"
      expr: AVG(CAST(individual_stop_loss_threshold AS DOUBLE))
      comment: "Average individual stop-loss threshold — measures per-member catastrophic cost protection levels."
    - name: "active_arrangement_count"
      expr: COUNT(CASE WHEN arrangement_status = 'Active' THEN 1 END)
      comment: "Count of currently active capitation arrangements — measures active capitation program portfolio size."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks contract audit outcomes including error rates, overpayment/underpayment findings, corrective action plans, and SIU referrals. Enables contract compliance monitoring and payment integrity management."
  source: "`vibe_health_insurance_v1`.`contract`.`contract_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of contract audit (Payment Accuracy, Credentialing, Compliance, Performance) for audit program analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (Scheduled, In Progress, Complete, Closed) for audit pipeline monitoring."
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor (Internal, External, Delegated) for audit governance analysis."
    - name: "findings_severity"
      expr: findings_severity
      comment: "Severity of audit findings (Critical, High, Medium, Low) for risk prioritization."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Indicates whether a corrective action plan is required — used to track compliance remediation workload."
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Status of the corrective action plan (Not Required, Pending, Submitted, Accepted) for CAP tracking."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates regulatory-mandated audits — used to prioritize compliance-driven audit activity."
    - name: "siu_referral_flag"
      expr: siu_referral_flag
      comment: "Indicates whether the audit resulted in an SIU fraud referral — key fraud and abuse detection metric."
    - name: "lob"
      expr: lob
      comment: "Line of business for LOB-level audit performance analysis."
    - name: "scheduled_start_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the audit was scheduled to start — used for audit pipeline and capacity planning."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of contract audits conducted — baseline volume metric for audit program scale."
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayment amounts identified — primary payment integrity KPI for contract audit programs."
    - name: "total_underpayment_amount"
      expr: SUM(CAST(underpayment_amount AS DOUBLE))
      comment: "Total underpayment amounts identified — measures provider underpayment liability and contract compliance."
    - name: "total_net_payment_variance"
      expr: SUM(CAST(net_payment_variance AS DOUBLE))
      comment: "Total net payment variance (overpayments minus underpayments) — net financial impact of audit findings."
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_pct AS DOUBLE))
      comment: "Average payment error rate percentage — key quality metric for contract payment accuracy monitoring."
    - name: "siu_referral_count"
      expr: COUNT(CASE WHEN siu_referral_flag = TRUE THEN 1 END)
      comment: "Count of audits resulting in SIU fraud referrals — measures fraud detection effectiveness."
    - name: "cap_required_count"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Count of audits requiring corrective action plans — measures compliance remediation workload."
    - name: "regulatory_audit_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-mandated audits — tracks compliance-driven audit obligations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks contract disputes including disputed amounts, resolution outcomes, SLA compliance, and escalation patterns. Enables provider relations management and contract dispute resolution performance monitoring."
  source: "`vibe_health_insurance_v1`.`contract`.`contract_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of contract dispute (Rate, Coding, Authorization, Credentialing) for dispute category analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status (Open, In Review, Resolved, Escalated) for dispute pipeline monitoring."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of dispute resolution (Upheld, Overturned, Settled, Withdrawn) for outcome pattern analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level (Critical, High, Medium, Low) for dispute triage and resource allocation."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the dispute was escalated — used to measure escalation rate and resolution complexity."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Indicates whether the SLA resolution deadline was met — key operational quality metric."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Indicates whether regulatory reporting is required — used to track compliance-sensitive disputes."
    - name: "legal_counsel_involved"
      expr: legal_counsel_involved
      comment: "Indicates whether legal counsel was engaged — measures dispute complexity and legal cost exposure."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level dispute analysis."
    - name: "initiation_date_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month the dispute was initiated — primary time dimension for dispute volume trend analysis."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of contract disputes — baseline volume metric for provider relations management."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar amount in dispute — primary financial exposure metric for contract dispute management."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amounts resolved/settled — measures financial resolution of contract disputes."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated disputes — measures dispute complexity and provider relations strain."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END)
      comment: "Count of disputes resolved within SLA — measures dispute resolution operational performance."
    - name: "legal_counsel_dispute_count"
      expr: COUNT(CASE WHEN legal_counsel_involved = TRUE THEN 1 END)
      comment: "Count of disputes requiring legal counsel — measures legal cost exposure and dispute severity."
    - name: "regulatory_reporting_dispute_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Count of disputes requiring regulatory reporting — tracks compliance-sensitive dispute volume."
    - name: "avg_payment_adjustment_required"
      expr: AVG(CAST(payment_adjustment_required AS DOUBLE))
      comment: "Average payment adjustment amount required per dispute — measures the financial impact of dispute resolutions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_incentive_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks provider incentive and pay-for-performance arrangements including quality scores, earned amounts, withhold pools, and settlement outcomes. Enables VBC incentive program performance management."
  source: "`vibe_health_insurance_v1`.`contract`.`incentive_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of incentive arrangement (P4P, Shared Savings, Withhold, Bonus) for program model comparison."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the incentive arrangement (Active, Settled, Terminated) for portfolio monitoring."
    - name: "earned_status"
      expr: earned_status
      comment: "Whether the incentive was earned (Earned, Forfeited, Partial, Pending) for incentive outcome analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level incentive program analysis."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year incentive program comparison."
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Whether the quality gate was met — determines eligibility for incentive payment release."
    - name: "aco_arrangement_flag"
      expr: aco_arrangement_flag
      comment: "Indicates ACO-based incentive arrangements — enables ACO vs. non-ACO incentive comparison."
    - name: "withhold_pool_type"
      expr: withhold_pool_type
      comment: "Type of withhold pool (Quality, Risk, Performance) for withhold program analysis."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month the measurement period started — used for incentive program cohort analysis."
  measures:
    - name: "total_arrangements"
      expr: COUNT(1)
      comment: "Total number of incentive arrangements — baseline portfolio size metric."
    - name: "total_amount_released"
      expr: SUM(CAST(amount_released AS DOUBLE))
      comment: "Total incentive amounts released to providers — measures successful incentive program payouts."
    - name: "total_amount_forfeited"
      expr: SUM(CAST(amount_forfeited AS DOUBLE))
      comment: "Total incentive amounts forfeited — measures provider performance shortfalls and withheld incentives."
    - name: "total_withheld_amount"
      expr: SUM(CAST(total_withheld_amount AS DOUBLE))
      comment: "Total amounts withheld pending performance determination — measures at-risk incentive pool size."
    - name: "total_maximum_incentive_amount"
      expr: SUM(CAST(maximum_incentive_amount AS DOUBLE))
      comment: "Total maximum incentive amounts available — measures total incentive program financial commitment."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across incentive arrangements — measures provider quality performance driving incentive eligibility."
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate — measures the proportion of savings returned to providers under VBC incentives."
    - name: "avg_shared_loss_rate"
      expr: AVG(CAST(shared_loss_rate AS DOUBLE))
      comment: "Average shared loss rate — measures downside risk sharing percentage in two-sided incentive models."
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average withhold percentage — measures the proportion of capitation at risk for quality performance."
    - name: "quality_gate_met_count"
      expr: COUNT(CASE WHEN quality_gate_met = TRUE THEN 1 END)
      comment: "Count of arrangements where quality gate was met — measures incentive program quality success rate."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks value-based contract configurations including benchmark targets, risk corridors, quality gates, and ACO parameters. Enables VBC program portfolio management and contract design analysis."
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_contract`"
  dimensions:
    - name: "vbc_model_type"
      expr: vbc_model_type
      comment: "VBC model type (MSSP, REACH, BPCI, Commercial ACO) for program model comparison."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Risk arrangement type (One-Sided, Two-Sided, Full Risk) for risk model segmentation."
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track for government VBC program analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for LOB-level VBC portfolio analysis."
    - name: "quality_gate_met"
      expr: quality_gate_met
      comment: "Whether the quality gate was met — determines shared savings eligibility."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for settlement pipeline monitoring."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates auto-renewal contracts — used for contract renewal pipeline management."
    - name: "performance_period_start_month"
      expr: DATE_TRUNC('MONTH', performance_period_start)
      comment: "Month the performance period started — primary time dimension for VBC portfolio trend analysis."
  measures:
    - name: "total_vbc_contracts"
      expr: COUNT(1)
      comment: "Total number of VBC contracts — baseline portfolio size metric for VBC program management."
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings earned across VBC contracts — primary financial return metric for VBC programs."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditures under VBC contracts — measures total cost of care managed under VBC."
    - name: "total_benchmark_expenditure_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure targets — measures the total cost target set for VBC performance."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC contracts — measures quality performance driving shared savings eligibility."
    - name: "avg_savings_sharing_rate"
      expr: AVG(CAST(savings_sharing_rate AS DOUBLE))
      comment: "Average savings sharing rate — measures the proportion of savings returned to ACO/provider partners."
    - name: "avg_max_shared_savings_rate"
      expr: AVG(CAST(max_shared_savings_rate AS DOUBLE))
      comment: "Average maximum shared savings rate cap — measures the upside limit of VBC financial incentives."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold — measures catastrophic loss protection levels in two-sided VBC arrangements."
    - name: "quality_gate_met_count"
      expr: COUNT(CASE WHEN quality_gate_met = TRUE THEN 1 END)
      comment: "Count of VBC contracts meeting quality gate — measures VBC quality program success rate."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_bundled_payment_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks bundled payment episode configurations including target prices, quality gates, risk adjustment, and gain/loss sharing parameters. Enables bundled payment program design and financial performance analysis."
  source: "`vibe_health_insurance_v1`.`contract`.`bundled_payment_episode`"
  dimensions:
    - name: "episode_type"
      expr: episode_type
      comment: "Type of clinical episode (Joint Replacement, Cardiac, Oncology) for episode program comparison."
    - name: "program_type"
      expr: program_type
      comment: "Bundled payment program type (BPCI-A, CJR, Commercial) for program-level analysis."
    - name: "episode_status"
      expr: episode_status
      comment: "Current status of the episode definition (Active, Inactive, Pending) for portfolio monitoring."
    - name: "anchor_setting"
      expr: anchor_setting
      comment: "Anchor care setting (Inpatient, Outpatient) for episode trigger analysis."
    - name: "trigger_event_type"
      expr: trigger_event_type
      comment: "Type of event triggering the episode (Admission, Procedure) for episode initiation analysis."
    - name: "quality_gate_required"
      expr: quality_gate_required
      comment: "Indicates whether a quality gate is required for gain sharing — measures quality-linked payment programs."
    - name: "risk_adjustment_applied"
      expr: risk_adjustment_applied
      comment: "Indicates whether risk adjustment is applied to target prices — for risk-adjusted episode analysis."
    - name: "readmission_included"
      expr: readmission_included
      comment: "Indicates whether readmissions are included in the episode — affects episode cost and quality measurement."
    - name: "lob"
      expr: lob
      comment: "Line of business for LOB-level bundled payment program analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the episode definition became effective — used for program cohort analysis."
  measures:
    - name: "total_episode_definitions"
      expr: COUNT(1)
      comment: "Total number of bundled payment episode definitions — baseline portfolio size metric."
    - name: "avg_target_price"
      expr: AVG(CAST(target_price AS DOUBLE))
      comment: "Average episode target price — core financial benchmark for bundled payment program design and negotiation."
    - name: "avg_gain_sharing_rate"
      expr: AVG(CAST(gain_sharing_rate AS DOUBLE))
      comment: "Average gain sharing rate — measures the proportion of savings returned to providers under bundled payments."
    - name: "avg_loss_sharing_rate"
      expr: AVG(CAST(loss_sharing_rate AS DOUBLE))
      comment: "Average loss sharing rate — measures downside risk sharing in two-sided bundled payment models."
    - name: "avg_quality_withhold_rate"
      expr: AVG(CAST(quality_withhold_rate AS DOUBLE))
      comment: "Average quality withhold rate — measures the proportion of bundled payment at risk for quality performance."
    - name: "avg_raf_adjustment_factor"
      expr: AVG(CAST(raf_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor — measures risk acuity adjustment applied to episode target prices."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold — measures catastrophic cost protection levels in bundled payment programs."
    - name: "avg_stop_gain_threshold"
      expr: AVG(CAST(stop_gain_threshold AS DOUBLE))
      comment: "Average stop-gain threshold — measures the cap on shared savings in bundled payment programs."
    - name: "avg_outlier_exclusion_threshold"
      expr: AVG(CAST(outlier_exclusion_threshold AS DOUBLE))
      comment: "Average outlier exclusion threshold — measures the cost level at which episodes are excluded from reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks provider network participation status, credentialing, and contract terms. Enables network adequacy monitoring, credentialing compliance, and provider directory accuracy management."
  source: "`vibe_health_insurance_v1`.`contract`.`network_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status (Active, Terminated, Suspended, Pending) for network roster management."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (Tier 1, Tier 2, Out-of-Network) for tier-based network analysis."
    - name: "lob"
      expr: lob
      comment: "Line of business for LOB-level network participation analysis."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status (Credentialed, Pending, Expired) for credentialing compliance monitoring."
    - name: "in_network_flag"
      expr: in_network_flag
      comment: "Indicates in-network participation — primary flag for network roster accuracy."
    - name: "accepting_new_patients_flag"
      expr: accepting_new_patients_flag
      comment: "Indicates whether the provider is accepting new patients — key network access metric."
    - name: "pcp_assignment_eligible_flag"
      expr: pcp_assignment_eligible_flag
      comment: "Indicates PCP assignment eligibility — used for PCP network adequacy analysis."
    - name: "telehealth_eligible_flag"
      expr: telehealth_eligible_flag
      comment: "Indicates telehealth eligibility — measures telehealth network capacity."
    - name: "vbc_arrangement_type"
      expr: vbc_arrangement_type
      comment: "Type of VBC arrangement for the participation — enables VBC network segmentation."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the participation became effective — used for network growth trend analysis."
  measures:
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total number of network participation records — baseline network roster size metric."
    - name: "active_participation_count"
      expr: COUNT(CASE WHEN participation_status = 'Active' THEN 1 END)
      comment: "Count of active network participations — measures current in-network provider roster size."
    - name: "accepting_new_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients_flag = TRUE THEN 1 END)
      comment: "Count of providers accepting new patients — key network access and adequacy metric."
    - name: "pcp_eligible_count"
      expr: COUNT(CASE WHEN pcp_assignment_eligible_flag = TRUE THEN 1 END)
      comment: "Count of PCP-eligible network participants — measures PCP network capacity for member assignment."
    - name: "telehealth_eligible_count"
      expr: COUNT(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 END)
      comment: "Count of telehealth-eligible providers — measures virtual care network capacity."
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk share percentage across network participations — measures VBC risk transfer in network contracts."
    - name: "credentialing_expired_count"
      expr: COUNT(CASE WHEN credentialing_status = 'Expired' THEN 1 END)
      comment: "Count of participations with expired credentialing — critical compliance metric for network integrity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks contract obligations and compliance status. Enables contract compliance monitoring, regulatory obligation tracking, and remediation management across the provider contract portfolio."
  source: "`vibe_health_insurance_v1`.`contract`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of contract obligation (Regulatory, Quality, Financial, Operational) for obligation category analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, Pending, Waived) for compliance monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean compliance indicator — primary flag for obligation compliance dashboard."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the obligation became effective — used for obligation cohort and trend analysis."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of contract obligations tracked — baseline compliance program scope metric."
    - name: "compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of obligations in compliance — measures overall contract compliance performance."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of non-compliant obligations — measures compliance gap requiring remediation action."
    - name: "distinct_obligation_types"
      expr: COUNT(DISTINCT obligation_type)
      comment: "Count of distinct obligation types tracked — measures breadth of contract compliance program."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_party_regulatory_obligation_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory obligation compliance at the contract party level. Enables party-level compliance monitoring, attestation tracking, and regulatory obligation fulfillment management."
  source: "`vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (HIPAA, State Licensure, CMS, NCQA) for obligation category analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, Pending, Waived) for compliance monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean compliance indicator — primary flag for party compliance dashboard."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the compliance record became effective — used for compliance trend analysis."
    - name: "last_review_date_month"
      expr: DATE_TRUNC('MONTH', last_review_date)
      comment: "Month of the last compliance review — used for review cycle monitoring."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total number of party regulatory obligation compliance records — baseline compliance program scope metric."
    - name: "compliant_party_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of party obligations in compliance — measures overall party compliance performance."
    - name: "non_compliant_party_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of non-compliant party obligations — measures compliance gap requiring remediation."
    - name: "distinct_parties_tracked"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of distinct contract parties with compliance records — measures compliance program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks contract amendments including rate changes, regulatory mandates, retroactive adjustments, and approval workflows. Enables contract change management and amendment impact analysis."
  source: "`vibe_health_insurance_v1`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Rate Change, Scope Change, Regulatory, Administrative) for amendment category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status (Pending, Approved, Rejected, Executed) for amendment workflow monitoring."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level amendment analysis."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates regulatory-mandated amendments — used to track compliance-driven contract changes."
    - name: "retroactive_flag"
      expr: retroactive_flag
      comment: "Indicates retroactive amendments — used to measure retroactive adjustment volume and financial impact."
    - name: "claims_reprocess_required"
      expr: claims_reprocess_required
      comment: "Indicates whether claims reprocessing is required — measures operational impact of contract amendments."
    - name: "formulary_impact_flag"
      expr: formulary_impact_flag
      comment: "Indicates formulary impact — used to track pharmacy benefit changes driven by contract amendments."
    - name: "prior_auth_impact_flag"
      expr: prior_auth_impact_flag
      comment: "Indicates prior authorization impact — used to track UM program changes driven by amendments."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective — primary time dimension for amendment trend analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of contract amendments — baseline volume metric for contract change management."
    - name: "avg_rate_change_pct"
      expr: AVG(CAST(rate_change_pct AS DOUBLE))
      comment: "Average rate change percentage across amendments — measures the magnitude of contracted rate adjustments."
    - name: "avg_risk_share_pct"
      expr: AVG(CAST(risk_share_pct AS DOUBLE))
      comment: "Average risk share percentage in amendments — measures risk transfer changes through contract amendments."
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation PMPM rate in amendments — tracks capitation rate changes through the amendment process."
    - name: "regulatory_mandate_amendment_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-mandated amendments — measures compliance-driven contract change volume."
    - name: "retroactive_amendment_count"
      expr: COUNT(CASE WHEN retroactive_flag = TRUE THEN 1 END)
      comment: "Count of retroactive amendments — measures retroactive adjustment volume and associated operational risk."
    - name: "claims_reprocess_amendment_count"
      expr: COUNT(CASE WHEN claims_reprocess_required = TRUE THEN 1 END)
      comment: "Count of amendments requiring claims reprocessing — measures operational workload from contract changes."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_delegation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegation agreement metrics tracking delegated function oversight, compliance status, and audit readiness for regulatory compliance and risk management."
  source: "`vibe_health_insurance_v1`.`contract`.`delegation_agreement`"
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