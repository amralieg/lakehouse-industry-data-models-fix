-- Metric views for domain: insurance | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_vbc_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract performance: shared savings/loss, total cost of care, quality scores, and settlement outcomes. Core executive KPI layer for VBC program steering."
  source: "`vibe_healthcare_v1`.`insurance`.`vbc_performance`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Performance measurement year for VBC trend and cohort analysis."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (upside-only, two-sided, full risk) to segment performance by risk model."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the VBC settlement is in dispute, used to monitor contract friction."
    - name: "performance_period_start"
      expr: DATE_TRUNC('MONTH', performance_period_start_date)
      comment: "Performance period start bucketed to month for time-series analysis."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of VBC performance records, baseline volume measure."
    - name: "total_savings_loss_amount"
      expr: SUM(CAST(savings_loss_amount AS DOUBLE))
      comment: "Net savings or loss across VBC contracts; directly informs financial outcome of value-based programs."
    - name: "total_shared_savings_distribution"
      expr: SUM(CAST(shared_savings_distribution_amount AS DOUBLE))
      comment: "Total shared savings distributed to the organization; key revenue driver from VBC."
    - name: "total_shared_loss_amount"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared loss exposure across contracts; key risk/cost metric for leadership."
    - name: "total_cost_of_care"
      expr: SUM(CAST(total_cost_of_care_amount AS DOUBLE))
      comment: "Aggregate total cost of care across attributed populations; primary VBC cost denominator."
    - name: "total_benchmark_tcoc"
      expr: SUM(CAST(benchmark_tcoc_amount AS DOUBLE))
      comment: "Aggregate benchmark TCOC; compared against actual TCOC by BI to derive performance vs benchmark."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score; gates shared savings eligibility and is a board-level quality KPI."
    - name: "total_quality_withhold_earned"
      expr: SUM(CAST(quality_withhold_earned_amount AS DOUBLE))
      comment: "Quality withhold dollars earned back; ties quality performance to financial recovery."
    - name: "total_quality_withhold_forfeited"
      expr: SUM(CAST(quality_withhold_forfeited_amount AS DOUBLE))
      comment: "Quality withhold dollars forfeited; signals quality underperformance with direct revenue loss."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment performance: gross/net payments, adjustments, risk adjustment, and payment timeliness. Steers PMPM revenue management."
  source: "`vibe_healthcare_v1`.`insurance`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment lifecycle status for tracking received vs outstanding capitation payments."
    - name: "payment_period_year"
      expr: payment_period_year
      comment: "Capitation payment period year for revenue trend analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status to monitor unreconciled capitation revenue."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Payment due date bucketed to month for cash-flow forecasting."
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of capitation payment records; baseline volume."
    - name: "total_gross_capitation"
      expr: SUM(CAST(gross_capitation_amount AS DOUBLE))
      comment: "Total gross capitation revenue; primary capitated revenue stream KPI."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payments received after adjustments and withholds; actual cash realized."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total capitation adjustments; signals revenue leakage or correction volume."
    - name: "total_risk_adjusted_amount"
      expr: SUM(CAST(risk_adjusted_amount AS DOUBLE))
      comment: "Total risk-adjusted capitation; reflects acuity-based revenue impact."
    - name: "total_quality_withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold dollars held back from capitation, linking quality to revenue at risk."
    - name: "avg_days_to_payment"
      expr: AVG(CAST(days_to_payment AS DOUBLE))
      comment: "Average days to receive capitation payment; payment-cycle efficiency metric. (days_to_payment is dimension-stored but numeric value; cast for averaging timeliness.)"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total payment variance vs expected; drives reconciliation and dispute action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_premium_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium billing and collections: billed premium, payments, outstanding balances, and delinquency. Steers membership revenue and AR risk."
  source: "`vibe_healthcare_v1`.`insurance`.`premium_billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status to track invoiced, paid, and delinquent premium accounts."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence (monthly, quarterly) for premium revenue segmentation."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of premium billing (group, COBRA, individual) for revenue mix analysis."
    - name: "billing_period_start"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start bucketed to month for premium revenue trend."
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of premium billing records; baseline volume."
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium billed; primary membership revenue KPI."
    - name: "total_net_premium_due"
      expr: SUM(CAST(net_premium_due AS DOUBLE))
      comment: "Total net premium due after adjustments/subsidies; expected collectible revenue."
    - name: "total_payment_received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total premium payments collected; cash realization KPI."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding premium balance; AR risk and collections priority metric."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer premium contribution; group revenue composition."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee premium contribution; member cost-share composition."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total premium subsidies; exchange/ACA revenue dependency indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment and retention: active membership, premium, subsidies, and enrollment mix. Core membership-growth steering layer."
  source: "`vibe_healthcare_v1`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status to distinguish active, terminated, and pending members."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Enrollment type (new, renewal, special) for membership-growth analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family) for membership mix and revenue per member."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which member enrolled; informs acquisition channel performance."
    - name: "enrollment_effective_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Enrollment effective date bucketed to month for membership trend."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of enrollment records; baseline membership volume."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total enrolled-member premium; recurring revenue base from membership."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per enrollment; revenue per member indicator."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidies applied to enrollments; subsidy dependency metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_risk_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment and HCC capture: risk scores, payment impact, RADV audit, and recapture. Steers revenue integrity in risk-bearing contracts."
  source: "`vibe_healthcare_v1`.`insurance`.`risk_adjustment`"
  dimensions:
    - name: "payment_year"
      expr: payment_year
      comment: "Risk adjustment payment year for HCC capture trend analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status to track accepted, rejected, and pending HCC submissions."
    - name: "radv_audit_status"
      expr: radv_audit_status
      comment: "RADV audit status; monitors audit exposure on submitted diagnoses."
    - name: "model_version"
      expr: model_version
      comment: "Risk model version (e.g., HCC v24/v28) for methodology-based segmentation."
    - name: "recapture_flag"
      expr: recapture_flag
      comment: "Whether the HCC is a recapture opportunity; drives coding/documentation action."
  measures:
    - name: "hcc_record_count"
      expr: COUNT(1)
      comment: "Number of risk adjustment records; baseline HCC volume."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score (RAF); drives risk-adjusted revenue and is a core revenue-integrity KPI."
    - name: "total_payment_impact"
      expr: SUM(CAST(payment_impact_amount AS DOUBLE))
      comment: "Total payment impact from risk adjustment; quantifies revenue at stake in HCC capture."
    - name: "avg_disease_score"
      expr: AVG(CAST(disease_score AS DOUBLE))
      comment: "Average disease component of risk score; clinical acuity contribution to RAF."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with risk adjustment activity; population coverage of HCC capture."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_utilization_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management: review decisions, denials, turnaround, appeals, and length-of-stay. Steers UM efficiency and medical cost control."
  source: "`vibe_healthcare_v1`.`insurance`.`utilization_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "UR review type (prospective, concurrent, retrospective) for UM workflow segmentation."
    - name: "review_decision"
      expr: review_decision
      comment: "Review outcome (approved, denied, partial) to monitor approval/denial rates."
    - name: "review_status"
      expr: review_status
      comment: "Review status to track in-progress vs completed reviews."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Whether an appeal was filed; signals decision friction and rework."
    - name: "review_initiation_month"
      expr: DATE_TRUNC('MONTH', review_initiation_date)
      comment: "Review initiation bucketed to month for UM volume trend."
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Number of utilization reviews; baseline UM workload volume."
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average UR turnaround hours; regulatory-compliance and member-experience efficiency KPI."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members undergoing UR; UM reach across population."
    - name: "avg_approved_length_of_stay"
      expr: AVG(CAST(approved_length_of_stay AS DOUBLE))
      comment: "Average approved length of stay; medical-cost control and bed-utilization driver."
    - name: "avg_requested_length_of_stay"
      expr: AVG(CAST(requested_length_of_stay AS DOUBLE))
      comment: "Average requested length of stay; compared with approved LOS to derive UM impact."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_network_adequacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy compliance: access standards, provider ratios, wait times, and remediation. Steers regulatory network compliance."
  source: "`vibe_healthcare_v1`.`insurance`.`network_adequacy`"
  dimensions:
    - name: "adequacy_determination"
      expr: adequacy_determination
      comment: "Adequacy determination (adequate/deficient) to monitor compliance posture."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Assessment lifecycle status for tracking review completion."
    - name: "specialty_category"
      expr: specialty_category
      comment: "Specialty category assessed; identifies access gaps by specialty."
    - name: "state_code"
      expr: state_code
      comment: "State of the network assessment for regulatory jurisdiction analysis."
  measures:
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Number of network adequacy assessments; baseline compliance-review volume."
    - name: "avg_pct_members_within_standard"
      expr: AVG(CAST(percentage_members_within_standard AS DOUBLE))
      comment: "Average percent of members meeting time/distance standard; core network-access compliance KPI."
    - name: "avg_actual_distance_miles"
      expr: AVG(CAST(actual_average_distance_miles AS DOUBLE))
      comment: "Average actual member-to-provider distance; access-adequacy indicator."
    - name: "avg_provider_to_member_ratio"
      expr: AVG(CAST(actual_provider_to_member_ratio AS DOUBLE))
      comment: "Average actual provider-to-member ratio; network sufficiency KPI driving recruitment action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_payer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer contract portfolio: reimbursement terms, risk arrangements, and renewal pipeline. Steers payer negotiation and contract management."
  source: "`vibe_healthcare_v1`.`insurance`.`payer_contract`"
  dimensions:
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Risk arrangement type to assess portfolio risk exposure."
    - name: "reimbursement_method"
      expr: reimbursement_method
      comment: "Reimbursement method for payment-model analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Contract effective date bucketed to month for portfolio timeline."
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of payer contracts; baseline portfolio size."
    - name: "avg_base_reimbursement_pct"
      expr: AVG(CAST(base_reimbursement_percentage AS DOUBLE))
      comment: "Average base reimbursement percentage; key negotiation outcome and revenue-rate KPI."
    - name: "total_stop_loss_threshold"
      expr: SUM(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Aggregate stop-loss thresholds; quantifies risk-protection exposure across contracts."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_accountable_care_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ACO performance: shared savings/loss, benchmark vs actual expenditure, and quality. Steers ACO program financial and quality outcomes."
  source: "`vibe_healthcare_v1`.`insurance`.`accountable_care_organization`"
  dimensions:
    - name: "aco_type"
      expr: aco_type
      comment: "ACO type/track for program-model segmentation."
    - name: "performance_year"
      expr: performance_year
      comment: "ACO performance year for outcome trend analysis."
    - name: "track_level"
      expr: track_level
      comment: "ACO risk track level to segment by upside/downside risk."
    - name: "aco_status"
      expr: accountable_care_organization_status
      comment: "ACO status to track active vs terminated entities."
  measures:
    - name: "aco_count"
      expr: COUNT(1)
      comment: "Number of ACO records; baseline program participation volume."
    - name: "total_shared_savings"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total ACO shared savings earned; primary financial outcome of ACO participation."
    - name: "total_shared_loss"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total ACO shared loss; downside risk realized."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure across ACOs; cost performance numerator."
    - name: "total_benchmark_expenditure"
      expr: SUM(CAST(benchmark_expenditure_amount AS DOUBLE))
      comment: "Total benchmark expenditure; compared with actual to derive savings/loss."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average ACO quality score; gates shared savings and is a board-level quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member accumulators: deductible/OOP progress, remaining amounts, and threshold attainment. Steers member cost-share and benefit utilization."
  source: "`vibe_healthcare_v1`.`insurance`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Accumulator type (deductible, OOP max) for cost-share category analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Accumulator status to track active vs reset accumulators."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for accumulator trend across plan years."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (individual/family) for accumulator segmentation."
    - name: "threshold_met_indicator"
      expr: threshold_met_indicator
      comment: "Whether the accumulator threshold has been met; drives benefit-payout exposure."
  measures:
    - name: "accumulator_count"
      expr: COUNT(1)
      comment: "Number of accumulator records; baseline volume."
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total accumulated cost-share dollars; member spend toward deductible/OOP."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining accumulator amount; forecasts plan payout liability as members hit limits."
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per member; cost-share burden indicator."
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with accumulators; population with active cost-share tracking."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_member_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member attribution: attributed populations, risk, confidence, and care visit volume. Steers VBC population assignment and panel management."
  source: "`vibe_healthcare_v1`.`insurance`.`member_attribution`"
  dimensions:
    - name: "attribution_method"
      expr: attribution_method
      comment: "Attribution method (claims-based, voluntary) for assignment-logic analysis."
    - name: "attribution_status"
      expr: attribution_status
      comment: "Attribution status to track active vs ended attributions."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for attribution trend across program cycles."
    - name: "shared_savings_eligible"
      expr: shared_savings_eligible
      comment: "Whether the attributed member is eligible for shared savings; drives VBC financial scope."
  measures:
    - name: "attribution_count"
      expr: COUNT(1)
      comment: "Number of attribution records; baseline volume."
    - name: "distinct_attributed_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct attributed subscribers; size of VBC managed population, a core program-scale KPI."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average attributed-member risk score; acuity of managed population driving revenue and care resourcing."
    - name: "avg_attribution_confidence"
      expr: AVG(CAST(attribution_confidence_score AS DOUBLE))
      comment: "Average attribution confidence; data-quality KPI for attribution integrity."
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation tied to attributed members; capitated revenue from attribution."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`insurance_payer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider payer enrollment and credentialing lifecycle: enrollment status, credentialing decisions, revalidation timelines, and network participation. Steers revenue-cycle enablement by ensuring providers are enrolled and in-network."
  source: "`vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment lifecycle status (submitted, approved, denied, terminated) to monitor the provider-enrollment pipeline that gates billable revenue."
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status to track in-progress vs completed credentialing, a prerequisite for in-network billing."
    - name: "network_status"
      expr: network_status
      comment: "Network participation status (in/out of network) impacting reimbursement rates."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type (commercial, Medicare, Medicaid) for enrollment-mix analysis across payer lines."
    - name: "enrollment_category"
      expr: enrollment_category
      comment: "Enrollment category for segmenting individual vs group/roster enrollments."
    - name: "application_submitted_month"
      expr: DATE_TRUNC('MONTH', application_submitted_date)
      comment: "Application submission bucketed to month for enrollment-throughput trend."
  measures:
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of payer enrollment records; baseline enrollment workload volume."
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Distinct providers being enrolled; reach of payer-enrollment operations across the provider base."
    - name: "distinct_payer_count"
      expr: COUNT(DISTINCT insurance_payer_id)
      comment: "Distinct payers enrolled with; payer-coverage breadth that determines billable network access."
    - name: "avg_enrollment_age_days"
      expr: AVG(CAST(enrollment_age_days AS DOUBLE))
      comment: "Average enrollment age in days; cycle-time KPI exposing enrollment backlog that delays revenue recognition."
$$;