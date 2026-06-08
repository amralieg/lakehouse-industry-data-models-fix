-- Metric views for domain: insurance | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member enrollment metrics tracking enrollment volume, premium economics, and coverage patterns for population health management and revenue forecasting."
  source: "`healthcare_ecm_v1`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the member enrollment (active, terminated, pending)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, transfer, COBRA)"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier level (individual, employee+spouse, family)"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment was initiated"
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Relationship of enrolled member to primary subscriber"
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current premium payment status for delinquency monitoring"
    - name: "enrollment_year"
      expr: YEAR(enrollment_effective_date)
      comment: "Year of enrollment effective date for trending"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_effective_date)
      comment: "Month of enrollment for seasonal analysis"
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "Whether enrollment is COBRA continuation coverage"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for enrollment termination for retention analysis"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total count of member enrollment records"
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Count of currently active enrollments for census reporting"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all enrollments for revenue forecasting"
    - name: "avg_premium_per_member"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per enrolled member for pricing analysis"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts for exchange/marketplace financial reporting"
    - name: "terminated_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'terminated' THEN 1 END)
      comment: "Count of terminated enrollments for churn analysis"
    - name: "cobra_enrollments"
      expr: COUNT(CASE WHEN cobra_indicator = true THEN 1 END)
      comment: "Count of COBRA continuation enrollments for compliance tracking"
    - name: "distinct_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct member count for unduplicated population sizing"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility span metrics for monitoring coverage continuity, gap analysis, and member retention across payer contracts."
  source: "`healthcare_ecm_v1`.`insurance`.`eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status for active coverage monitoring"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, behavioral health)"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (individual, family, employee+children)"
    - name: "network_type"
      expr: COALESCE(coverage_order, 'unknown')
      comment: "Coverage order (primary, secondary, tertiary) for COB analysis"
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method of enrollment for channel effectiveness analysis"
    - name: "dual_eligibility_indicator"
      expr: dual_eligibility_indicator
      comment: "Whether member has dual Medicare/Medicaid eligibility"
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "COBRA continuation coverage flag"
    - name: "eligibility_start_year"
      expr: YEAR(eligibility_start_date)
      comment: "Year eligibility began for cohort analysis"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for eligibility termination for retention strategies"
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total eligibility span records for volume tracking"
    - name: "active_spans"
      expr: COUNT(CASE WHEN eligibility_status = 'active' THEN 1 END)
      comment: "Currently active eligibility spans representing covered lives"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per eligibility span for pricing benchmarking"
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue across all eligibility spans"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts for marketplace financial reporting"
    - name: "dual_eligible_count"
      expr: COUNT(CASE WHEN dual_eligibility_indicator = true THEN 1 END)
      comment: "Count of dual-eligible members for special needs plan reporting"
    - name: "distinct_covered_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with eligibility for unduplicated covered lives reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment metrics for value-based care financial management, PMPM tracking, and payer reconciliation."
  source: "`healthcare_ecm_v1`.`insurance`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status for AR management"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (EFT, check, wire) for treasury operations"
    - name: "payment_period_month"
      expr: payment_period_month
      comment: "Month of capitation payment period for trending"
    - name: "payment_period_year"
      expr: payment_period_year
      comment: "Year of capitation payment period for annual analysis"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for financial close tracking"
    - name: "facility_contract_year"
      expr: facility_contract_year
      comment: "Contract year for multi-year performance comparison"
    - name: "revenue_recognition_period"
      expr: revenue_recognition_period
      comment: "Revenue recognition period for GAAP compliance"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center for departmental financial reporting"
  measures:
    - name: "total_gross_capitation"
      expr: SUM(CAST(gross_capitation_amount AS DOUBLE))
      comment: "Total gross capitation payments before adjustments for revenue reporting"
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payments after withhold and adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments for variance analysis"
    - name: "total_quality_withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold amounts at risk for performance incentive tracking"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate for contract benchmarking"
    - name: "total_risk_adjusted_amount"
      expr: SUM(CAST(risk_adjusted_amount AS DOUBLE))
      comment: "Total risk-adjusted payment amounts for actuarial analysis"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total payment variance for budget-to-actual reporting"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total capitation payment transactions for operational volume tracking"
    - name: "avg_days_to_payment"
      expr: AVG(CAST(days_to_payment AS DOUBLE))
      comment: "Average days from due date to receipt for cash flow management"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_risk_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment metrics for HCC coding accuracy, RAF score management, and Medicare Advantage revenue optimization."
  source: "`healthcare_ecm_v1`.`insurance`.`risk_adjustment`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of risk adjustment submission for pipeline monitoring"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (initial, supplemental, chart review) for workflow analysis"
    - name: "model"
      expr: model
      comment: "CMS-HCC model version used for score calculation"
    - name: "model_version"
      expr: model_version
      comment: "Specific model version for year-over-year comparison"
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for annual revenue impact analysis"
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis for coding pattern analysis"
    - name: "hcc_code"
      expr: hcc_code
      comment: "Hierarchical Condition Category code for condition prevalence analysis"
    - name: "radv_audit_status"
      expr: radv_audit_status
      comment: "RADV audit status for compliance risk monitoring"
    - name: "medical_record_review_status"
      expr: medical_record_review_status
      comment: "Chart review status for coding completeness tracking"
    - name: "recapture_flag"
      expr: recapture_flag
      comment: "Whether this is a recaptured condition from prior year"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total risk adjustment submissions for volume tracking"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average RAF score across population for actuarial benchmarking"
    - name: "total_payment_impact"
      expr: SUM(CAST(payment_impact_amount AS DOUBLE))
      comment: "Total revenue impact of risk adjustment for financial forecasting"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total risk adjustment payment amounts"
    - name: "avg_disease_score"
      expr: AVG(CAST(disease_score AS DOUBLE))
      comment: "Average disease burden score for population health assessment"
    - name: "avg_demographic_score"
      expr: AVG(CAST(demographic_score AS DOUBLE))
      comment: "Average demographic component of risk score"
    - name: "distinct_members_scored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with risk scores for penetration analysis"
    - name: "recaptured_conditions"
      expr: COUNT(CASE WHEN recapture_flag = true THEN 1 END)
      comment: "Count of recaptured HCC conditions for coding effectiveness measurement"
    - name: "suspect_conditions"
      expr: COUNT(CASE WHEN suspect_flag = true THEN 1 END)
      comment: "Count of suspect conditions requiring validation for prospective coding"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_utilization_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization review metrics for prior authorization efficiency, denial management, and clinical appropriateness monitoring."
  source: "`healthcare_ecm_v1`.`insurance`.`utilization_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of utilization review (precertification, concurrent, retrospective)"
    - name: "review_decision"
      expr: review_decision
      comment: "Review outcome decision (approved, denied, partially approved, pended)"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review for workflow management"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for setting-specific approval rate analysis"
    - name: "peer_to_peer_requested"
      expr: peer_to_peer_requested
      comment: "Whether peer-to-peer review was requested indicating clinical complexity"
    - name: "claim_appeal_filed"
      expr: claim_appeal_filed
      comment: "Whether an appeal was filed for denial overturn rate analysis"
    - name: "review_initiation_month"
      expr: DATE_TRUNC('month', review_initiation_date)
      comment: "Month of review initiation for volume trending"
    - name: "regulatory_timeframe_met"
      expr: regulatory_timeframe_met
      comment: "Whether regulatory turnaround requirements were met for compliance"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total utilization reviews for workload and volume analysis"
    - name: "approved_reviews"
      expr: COUNT(CASE WHEN review_decision = 'approved' THEN 1 END)
      comment: "Count of approved reviews for approval rate calculation"
    - name: "denied_reviews"
      expr: COUNT(CASE WHEN review_decision = 'denied' THEN 1 END)
      comment: "Count of denied reviews for denial rate monitoring"
    - name: "peer_to_peer_reviews"
      expr: COUNT(CASE WHEN peer_to_peer_requested = true THEN 1 END)
      comment: "Count of peer-to-peer reviews for clinical escalation tracking"
    - name: "appeals_filed"
      expr: COUNT(CASE WHEN claim_appeal_filed = true THEN 1 END)
      comment: "Count of appeals filed for denial management effectiveness"
    - name: "regulatory_compliant_reviews"
      expr: COUNT(CASE WHEN regulatory_timeframe_met = true THEN 1 END)
      comment: "Count of reviews meeting regulatory turnaround for compliance reporting"
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours for operational efficiency measurement"
    - name: "distinct_members_reviewed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members undergoing utilization review for population impact assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_vbc_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care performance metrics for shared savings/loss tracking, quality score monitoring, and total cost of care management."
  source: "`healthcare_ecm_v1`.`insurance`.`vbc_performance`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Performance measurement year for annual trending"
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (upside only, two-sided, full risk)"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement processing status for financial close tracking"
    - name: "performance_year_type"
      expr: performance_year_type
      comment: "Type of performance year (baseline, performance, reconciliation)"
    - name: "reconciliation_period"
      expr: reconciliation_period
      comment: "Reconciliation period for settlement timing analysis"
    - name: "reporting_entity"
      expr: reporting_entity
      comment: "Entity responsible for reporting for multi-entity analysis"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether performance results are disputed"
  measures:
    - name: "total_cost_of_care"
      expr: SUM(CAST(total_cost_of_care_amount AS DOUBLE))
      comment: "Total cost of care across all VBC arrangements for expenditure monitoring"
    - name: "total_benchmark_tcoc"
      expr: SUM(CAST(benchmark_tcoc_amount AS DOUBLE))
      comment: "Total benchmark expenditure for savings/loss calculation"
    - name: "total_shared_savings"
      expr: SUM(CAST(shared_savings_distribution_amount AS DOUBLE))
      comment: "Total shared savings earned for VBC revenue reporting"
    - name: "total_shared_loss"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses incurred for financial risk exposure"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score for quality gate assessment"
    - name: "total_quality_withhold_earned"
      expr: SUM(CAST(quality_withhold_earned_amount AS DOUBLE))
      comment: "Total quality withhold earned back for incentive performance"
    - name: "total_quality_withhold_forfeited"
      expr: SUM(CAST(quality_withhold_forfeited_amount AS DOUBLE))
      comment: "Total quality withhold forfeited for performance gap identification"
    - name: "avg_data_completeness"
      expr: AVG(CAST(data_completeness_score AS DOUBLE))
      comment: "Average data completeness score for data quality monitoring"
    - name: "total_savings_loss"
      expr: SUM(CAST(savings_loss_amount AS DOUBLE))
      comment: "Net savings or loss amount for overall VBC program financial performance"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Count of VBC performance periods for portfolio sizing"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_member_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member attribution metrics for provider panel management, attribution methodology effectiveness, and value-based care population assignment."
  source: "`healthcare_ecm_v1`.`insurance`.`member_attribution`"
  dimensions:
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current attribution status for panel accuracy monitoring"
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used for attribution (plurality of care, prospective, retrospective)"
    - name: "attribution_type"
      expr: attribution_type
      comment: "Type of attribution for program-specific analysis"
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for annual attribution trending"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Source of attribution data for methodology validation"
    - name: "shared_savings_eligible"
      expr: shared_savings_eligible
      comment: "Whether attributed member is eligible for shared savings"
    - name: "opt_out_indicator"
      expr: opt_out_indicator
      comment: "Whether member has opted out of attribution"
    - name: "state_code"
      expr: state_code
      comment: "State for geographic attribution analysis"
    - name: "capitation_frequency"
      expr: capitation_frequency
      comment: "Frequency of capitation payments for financial planning"
  measures:
    - name: "total_attributed_members"
      expr: COUNT(1)
      comment: "Total attribution records for panel size monitoring"
    - name: "distinct_attributed_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members attributed for unduplicated panel sizing"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of attributed population for acuity assessment"
    - name: "avg_attribution_confidence"
      expr: AVG(CAST(attribution_confidence_score AS DOUBLE))
      comment: "Average confidence score for attribution accuracy monitoring"
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation revenue for attributed members"
    - name: "opted_out_members"
      expr: COUNT(CASE WHEN opt_out_indicator = true THEN 1 END)
      comment: "Count of members who opted out for voluntary alignment tracking"
    - name: "shared_savings_eligible_count"
      expr: COUNT(CASE WHEN shared_savings_eligible = true THEN 1 END)
      comment: "Count of members eligible for shared savings for program sizing"
    - name: "distinct_attributed_providers"
      expr: COUNT(DISTINCT primary_member_clinician_id)
      comment: "Distinct providers with attributed members for network adequacy"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_premium_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium billing metrics for revenue cycle management, collection efficiency, and member retention through payment monitoring."
  source: "`healthcare_ecm_v1`.`insurance`.`premium_billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status for AR aging analysis"
    - name: "billing_type"
      expr: billing_type
      comment: "Type of premium billing for segment analysis"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for collection channel optimization"
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period month for revenue trending"
    - name: "reinstatement_eligible"
      expr: reinstatement_eligible
      comment: "Whether lapsed billing is eligible for reinstatement"
  measures:
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount billed for revenue recognition"
    - name: "total_net_premium_due"
      expr: SUM(CAST(net_premium_due AS DOUBLE))
      comment: "Net premium due after adjustments for AR reporting"
    - name: "total_payments_received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments received for collection rate analysis"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance for delinquency management"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contributions for group billing reconciliation"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contributions for payroll deduction tracking"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts for marketplace financial reporting"
    - name: "avg_premium_per_member"
      expr: AVG(CAST(premium_rate_per_member AS DOUBLE))
      comment: "Average premium rate per member for pricing analysis"
    - name: "billing_count"
      expr: COUNT(1)
      comment: "Total billing records for operational volume tracking"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total billing adjustments for revenue leakage analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_network_adequacy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network adequacy metrics for regulatory compliance, access-to-care monitoring, and provider network sufficiency assessment."
  source: "`healthcare_ecm_v1`.`insurance`.`network_adequacy`"
  dimensions:
    - name: "adequacy_determination"
      expr: adequacy_determination
      comment: "Adequacy determination outcome (adequate, deficient, conditionally adequate)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current assessment status for workflow tracking"
    - name: "specialty_category"
      expr: specialty_category
      comment: "Provider specialty category for specialty-specific adequacy analysis"
    - name: "state_code"
      expr: state_code
      comment: "State for geographic regulatory compliance"
    - name: "geographic_service_area"
      expr: geographic_service_area
      comment: "Service area for regional adequacy monitoring"
    - name: "telehealth_included_flag"
      expr: telehealth_included_flag
      comment: "Whether telehealth providers are included in adequacy calculation"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for trending compliance"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total network adequacy assessments for compliance volume tracking"
    - name: "adequate_assessments"
      expr: COUNT(CASE WHEN adequacy_determination = 'adequate' THEN 1 END)
      comment: "Count of assessments meeting adequacy standards"
    - name: "deficient_assessments"
      expr: COUNT(CASE WHEN adequacy_determination = 'deficient' THEN 1 END)
      comment: "Count of deficient assessments requiring remediation"
    - name: "avg_distance_miles"
      expr: AVG(CAST(actual_average_distance_miles AS DOUBLE))
      comment: "Average distance to provider for access-to-care measurement"
    - name: "avg_provider_to_member_ratio"
      expr: AVG(CAST(actual_provider_to_member_ratio AS DOUBLE))
      comment: "Average provider-to-member ratio for capacity planning"
    - name: "avg_pct_members_within_standard"
      expr: AVG(CAST(percentage_members_within_standard AS DOUBLE))
      comment: "Average percentage of members within time/distance standard for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit accumulator metrics for deductible and out-of-pocket tracking, member cost-sharing analysis, and benefit utilization monitoring."
  source: "`healthcare_ecm_v1`.`insurance`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, out-of-pocket max, copay max)"
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current accumulator status for active benefit tracking"
    - name: "network_type"
      expr: network_type
      comment: "Network type (in-network, out-of-network) for cost-sharing analysis"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (individual, family) for accumulator threshold analysis"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual reset and trending"
    - name: "threshold_met_indicator"
      expr: threshold_met_indicator
      comment: "Whether accumulator threshold has been met"
    - name: "carryover_indicator"
      expr: carryover_indicator
      comment: "Whether amounts carry over to next benefit period"
  measures:
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total accumulated amounts across all members for utilization trending"
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining amounts before thresholds are met for exposure analysis"
    - name: "total_threshold_amount"
      expr: SUM(CAST(threshold_amount AS DOUBLE))
      comment: "Total threshold amounts for benefit design analysis"
    - name: "avg_accumulation_pct"
      expr: AVG(CAST(accumulated_amount AS DOUBLE) / NULLIF(CAST(threshold_amount AS DOUBLE), 0))
      comment: "Average percentage of threshold consumed for benefit exhaustion forecasting"
    - name: "thresholds_met_count"
      expr: COUNT(CASE WHEN threshold_met_indicator = true THEN 1 END)
      comment: "Count of accumulators that have met threshold for catastrophic coverage triggering"
    - name: "total_carryover_amount"
      expr: SUM(CAST(carryover_amount AS DOUBLE))
      comment: "Total carryover amounts for year-end benefit transition planning"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total accumulator adjustments for reconciliation accuracy"
    - name: "distinct_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct members with accumulators for population benefit utilization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health plan metrics for product portfolio analysis, benefit design benchmarking, and plan cost structure monitoring."
  source: "`healthcare_ecm_v1`.`insurance`.`health_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, POS, HDHP) for product mix analysis"
    - name: "plan_status"
      expr: plan_status
      comment: "Current plan status for active product inventory"
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (bronze, silver, gold, platinum) for marketplace analysis"
    - name: "funding_type"
      expr: funding_type
      comment: "Funding type (fully insured, self-funded, level-funded)"
    - name: "issuer_state"
      expr: issuer_state
      comment: "State of plan issuance for geographic product analysis"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual plan cycle analysis"
    - name: "hsa_eligible"
      expr: hsa_eligible
      comment: "HSA eligibility for consumer-directed health plan analysis"
    - name: "out_of_network_coverage"
      expr: out_of_network_coverage
      comment: "Whether plan covers out-of-network services"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total health plan count for product portfolio sizing"
    - name: "active_plans"
      expr: COUNT(CASE WHEN plan_status = 'active' THEN 1 END)
      comment: "Count of currently active plans for market offering inventory"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible for benefit design benchmarking"
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible for benefit design benchmarking"
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(individual_oop_max_amount AS DOUBLE))
      comment: "Average individual out-of-pocket maximum for cost exposure analysis"
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(primary_care_copay_amount AS DOUBLE))
      comment: "Average primary care copay for access and affordability analysis"
    - name: "avg_specialist_copay"
      expr: AVG(CAST(specialist_copay_amount AS DOUBLE))
      comment: "Average specialist copay for specialty access cost analysis"
    - name: "avg_er_copay"
      expr: AVG(CAST(emergency_room_copay_amount AS DOUBLE))
      comment: "Average ER copay for emergency utilization steering analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`insurance_network_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidated network participation metrics for provider network management, credentialing status, and panel capacity monitoring across participant types."
  source: "`healthcare_ecm_v1`.`insurance`.`network_participation`"
  dimensions:
    - name: "participant_type"
      expr: participant_type
      comment: "Type of network participant (clinician, facility, group) for segment analysis"
    - name: "network_participation_status"
      expr: network_participation_status
      comment: "Current participation status for active network monitoring"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of participation contract for arrangement analysis"
    - name: "tier_level"
      expr: tier_level
      comment: "Network tier level for tiered network management"
    - name: "participation_category"
      expr: participation_category
      comment: "Category of participation for network composition analysis"
    - name: "accepting_new_patients"
      expr: accepting_new_patients
      comment: "Whether participant is accepting new patients for access monitoring"
    - name: "auto_assignment_eligible"
      expr: auto_assignment_eligible
      comment: "Whether eligible for auto-assignment of members"
    - name: "service_area_code"
      expr: service_area_code
      comment: "Service area for geographic network coverage analysis"
    - name: "is_current"
      expr: is_current
      comment: "SCD Type 2 current record indicator"
  measures:
    - name: "total_participants"
      expr: COUNT(1)
      comment: "Total network participation records for network size tracking"
    - name: "active_participants"
      expr: COUNT(CASE WHEN network_participation_status = 'active' THEN 1 END)
      comment: "Currently active network participants for adequacy reporting"
    - name: "accepting_patients_count"
      expr: COUNT(CASE WHEN accepting_new_patients = true THEN 1 END)
      comment: "Participants accepting new patients for access availability"
    - name: "avg_capitation_rate"
      expr: AVG(CAST(capitation_rate AS DOUBLE))
      comment: "Average capitation rate for contract benchmarking"
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average withhold percentage for quality incentive analysis"
    - name: "quality_bonus_eligible_count"
      expr: COUNT(CASE WHEN quality_bonus_eligible = true THEN 1 END)
      comment: "Count of participants eligible for quality bonuses for incentive program sizing"
$$;