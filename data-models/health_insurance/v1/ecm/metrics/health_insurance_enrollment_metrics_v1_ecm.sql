-- Metric views for domain: enrollment | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment eligibility metrics tracking active coverage spans, coverage types, retroactive adjustments, and enrollment event patterns for population health management and financial planning."
  source: "`health_insurance_ecm`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, etc.) for segmenting enrollment metrics"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid, exchange) for strategic portfolio analysis"
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the span for active vs terminated analysis"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event (new enrollment, renewal, termination, etc.)"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or source through which enrollment originated"
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage for benefit structure analysis"
    - name: "is_primary_coverage"
      expr: CAST(is_primary_coverage AS STRING)
      comment: "Whether this is the member's primary coverage"
    - name: "retroactive_adjustment_flag"
      expr: CAST(retroactive_adjustment_flag AS STRING)
      comment: "Whether the span involved a retroactive adjustment"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual enrollment cycle analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year of enrollment effective date for trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of enrollment effective date for seasonal pattern analysis"
  measures:
    - name: "total_enrollment_spans"
      expr: COUNT(1)
      comment: "Total number of enrollment eligibility spans for volume tracking"
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with enrollment spans, key population size metric"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across enrollment spans for cost-sharing analysis"
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit exposure across all spans for risk capacity planning"
    - name: "avg_oop_maximum"
      expr: AVG(CAST(oop_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum for member financial protection analysis"
    - name: "retroactive_adjustment_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retroactive adjustments indicating operational rework and financial restatement risk"
    - name: "distinct_groups_enrolled"
      expr: COUNT(DISTINCT group_id)
      comment: "Unique employer groups with active enrollment for group retention analysis"
    - name: "waiver_applied_count"
      expr: SUM(CASE WHEN is_waiver_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spans with waivers applied for coverage gap and opt-out analysis"
    - name: "avg_moop_threshold"
      expr: AVG(CAST(moop_threshold AS DOUBLE))
      comment: "Average maximum out-of-pocket threshold for actuarial and benefit design analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment transaction metrics tracking financial impact, processing efficiency, and transaction patterns for operational performance and revenue integrity."
  source: "`health_insurance_ecm`.`enrollment`.`transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the enrollment transaction for pipeline monitoring"
    - name: "processing_status"
      expr: processing_status
      comment: "Processing stage of the transaction for operational throughput analysis"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment transaction (new, change, termination, reinstatement)"
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Health plan type associated with the transaction for product mix analysis"
    - name: "transaction_source"
      expr: transaction_source
      comment: "Source system or channel originating the transaction"
    - name: "enrollment_origin"
      expr: enrollment_origin
      comment: "Origin of the enrollment for channel attribution"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the transaction"
    - name: "retroactive_adjustment_flag"
      expr: CAST(retroactive_adjustment_flag AS STRING)
      comment: "Whether the transaction is a retroactive adjustment"
    - name: "is_grace_period"
      expr: CAST(is_grace_period AS STRING)
      comment: "Whether the transaction is within a grace period"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of transaction effective date for trend analysis"
    - name: "coverage_period_type"
      expr: coverage_period_type
      comment: "Type of coverage period for duration analysis"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total enrollment transactions processed for volume and capacity planning"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross premium amount across transactions for revenue tracking"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after adjustments for actual revenue recognition"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts indicating financial corrections and retroactive changes"
    - name: "avg_net_amount_per_transaction"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per transaction for PMPM and unit economics analysis"
    - name: "retroactive_transaction_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retroactive transactions indicating operational lag and financial restatement exposure"
    - name: "financial_impact_transaction_count"
      expr: SUM(CASE WHEN financial_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions with financial impact for revenue materiality assessment"
    - name: "grace_period_transaction_count"
      expr: SUM(CASE WHEN is_grace_period = TRUE THEN 1 ELSE 0 END)
      comment: "Count of grace period transactions indicating payment risk and potential disenrollment"
    - name: "distinct_members_transacted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with enrollment transactions for churn and activity analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_exchange_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health insurance exchange (marketplace) enrollment metrics tracking APTC subsidies, effectuation rates, and premium collection for ACA compliance and marketplace performance."
  source: "`health_insurance_ecm`.`enrollment`.`exchange_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status on the exchange for active membership tracking"
    - name: "effectuation_status"
      expr: effectuation_status
      comment: "Whether enrollment has been effectuated (payment received) — critical for actual coverage"
    - name: "marketplace_source"
      expr: marketplace_source
      comment: "Source marketplace (FFM, SBM) for regulatory reporting segmentation"
    - name: "marketplace_state"
      expr: marketplace_state
      comment: "State of the marketplace for geographic and regulatory analysis"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage elected on the exchange"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of exchange enrollment (initial, renewal, SEP)"
    - name: "payment_status"
      expr: payment_status
      comment: "Premium payment status for revenue collection and effectuation tracking"
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (APTC, CSR) for financial assistance analysis"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for annual enrollment cycle comparison"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of effective date for enrollment wave analysis"
    - name: "enrollment_renewal_indicator"
      expr: CAST(enrollment_renewal_indicator AS STRING)
      comment: "Whether this is a renewal vs new enrollment for retention analysis"
  measures:
    - name: "total_exchange_enrollments"
      expr: COUNT(1)
      comment: "Total exchange enrollment records for marketplace volume tracking"
    - name: "distinct_exchange_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members enrolled through exchanges for marketplace penetration"
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total gross premium amount for exchange revenue tracking"
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total Advanced Premium Tax Credit amount for subsidy exposure and reconciliation"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount across all types for government payment forecasting"
    - name: "avg_premium_per_enrollment"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per exchange enrollment for pricing and affordability analysis"
    - name: "avg_aptc_per_enrollment"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC subsidy per enrollment for financial assistance utilization analysis"
    - name: "effectuated_enrollment_count"
      expr: SUM(CASE WHEN effectuation_status = 'effectuated' THEN 1 ELSE 0 END)
      comment: "Count of effectuated enrollments — only these represent actual covered lives"
    - name: "renewal_count"
      expr: SUM(CASE WHEN enrollment_renewal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of renewal enrollments for retention rate calculation"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_pend_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment pend queue metrics tracking operational bottlenecks, SLA compliance, and resolution efficiency for enrollment processing quality management."
  source: "`health_insurance_ecm`.`enrollment`.`pend_queue`"
  dimensions:
    - name: "pend_status"
      expr: pend_status
      comment: "Current status of the pended item for workload distribution analysis"
    - name: "pend_reason_code"
      expr: pend_reason_code
      comment: "Reason code for pending for root cause analysis of enrollment processing issues"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pended item for workload prioritization"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level for management attention tracking"
    - name: "resolver_team"
      expr: resolver_team
      comment: "Team responsible for resolution for capacity and performance management"
    - name: "sla_compliance_status"
      expr: sla_compliance_status
      comment: "Whether the item is within SLA for service level monitoring"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the pend for process improvement analysis"
    - name: "is_auto_resolved"
      expr: CAST(is_auto_resolved AS STRING)
      comment: "Whether the pend was auto-resolved for automation effectiveness tracking"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether the pend has compliance implications for regulatory risk monitoring"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of effective date for trend analysis of pend volumes"
  measures:
    - name: "total_pended_items"
      expr: COUNT(1)
      comment: "Total items in pend queue for operational volume and backlog tracking"
    - name: "distinct_members_pended"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with pended enrollment items for member impact assessment"
    - name: "escalated_item_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated items indicating complex issues requiring management intervention"
    - name: "manual_review_required_count"
      expr: SUM(CASE WHEN is_manual_review_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of items requiring manual review for automation opportunity identification"
    - name: "auto_resolved_count"
      expr: SUM(CASE WHEN is_auto_resolved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-resolved items for automation success rate tracking"
    - name: "compliance_flagged_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compliance-flagged pends for regulatory risk exposure monitoring"
    - name: "duplicate_flag_count"
      expr: SUM(CASE WHEN is_duplicate_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of duplicate-flagged items indicating data quality issues upstream"
    - name: "eligibility_discrepancy_count"
      expr: SUM(CASE WHEN is_eligibility_discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of eligibility discrepancy pends for enrollment accuracy monitoring"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan election metrics tracking member plan choices, premium contributions, and benefit elections for product strategy, pricing analysis, and employer contribution modeling."
  source: "`health_insurance_ecm`.`enrollment`.`plan_election`"
  dimensions:
    - name: "plan_election_status"
      expr: plan_election_status
      comment: "Status of the plan election for active vs terminated election tracking"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family) for actuarial and pricing analysis"
    - name: "election_type"
      expr: election_type
      comment: "Type of election (initial, change, open enrollment) for enrollment pattern analysis"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Event type triggering the election for lifecycle analysis"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel of the plan election"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of premium payments for cash flow analysis"
    - name: "dental_rider_flag"
      expr: CAST(dental_rider_flag AS STRING)
      comment: "Whether dental rider was elected for ancillary product uptake analysis"
    - name: "vision_rider_flag"
      expr: CAST(vision_rider_flag AS STRING)
      comment: "Whether vision rider was elected for ancillary product uptake analysis"
    - name: "is_cobra_eligible"
      expr: CAST(is_cobra_eligible AS STRING)
      comment: "COBRA eligibility status for continuation coverage risk assessment"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of election effective date for enrollment wave analysis"
  measures:
    - name: "total_plan_elections"
      expr: COUNT(1)
      comment: "Total plan elections for enrollment volume tracking"
    - name: "distinct_members_elected"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with plan elections for coverage penetration analysis"
    - name: "total_premium"
      expr: SUM(CAST(total_premium AS DOUBLE))
      comment: "Total premium across all elections for gross premium revenue"
    - name: "total_employee_contribution"
      expr: SUM(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Total employee premium contributions for member cost burden analysis"
    - name: "total_employer_contribution"
      expr: SUM(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Total employer premium contributions for group funding analysis"
    - name: "avg_total_premium"
      expr: AVG(CAST(total_premium AS DOUBLE))
      comment: "Average total premium per election for pricing benchmark analysis"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Average employee contribution for affordability and cost-sharing analysis"
    - name: "dental_rider_election_count"
      expr: SUM(CASE WHEN dental_rider_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dental rider elections for ancillary product penetration"
    - name: "vision_rider_election_count"
      expr: SUM(CASE WHEN vision_rider_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vision rider elections for ancillary product penetration"
    - name: "hsa_election_count"
      expr: SUM(CASE WHEN hsa_election_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HSA elections for consumer-directed health plan adoption tracking"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment reconciliation metrics tracking discrepancies between carrier and employer/exchange records, financial impact, and resolution for data integrity and revenue assurance."
  source: "`health_insurance_ecm`.`enrollment`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation for pipeline and backlog monitoring"
    - name: "run_type"
      expr: run_type
      comment: "Type of reconciliation run (daily, weekly, monthly, ad-hoc) for process cadence analysis"
    - name: "source_system"
      expr: source_system
      comment: "Source system being reconciled for system-level quality tracking"
    - name: "auto_resolution_flag"
      expr: CAST(auto_resolution_flag AS STRING)
      comment: "Whether discrepancies were auto-resolved for automation effectiveness"
    - name: "period_month"
      expr: DATE_TRUNC('month', period_start)
      comment: "Reconciliation period month for trend analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial impact for multi-currency operations"
  measures:
    - name: "total_reconciliation_runs"
      expr: COUNT(1)
      comment: "Total reconciliation runs for operational cadence monitoring"
    - name: "total_financial_impact_gross"
      expr: SUM(CAST(financial_impact_gross AS DOUBLE))
      comment: "Total gross financial impact of discrepancies for revenue leakage assessment"
    - name: "total_financial_impact_net"
      expr: SUM(CAST(financial_impact_net AS DOUBLE))
      comment: "Total net financial impact after adjustments for actual P&L exposure"
    - name: "total_financial_adjustment"
      expr: SUM(CAST(financial_impact_adjustment AS DOUBLE))
      comment: "Total financial adjustments made during reconciliation for correction volume tracking"
    - name: "avg_financial_impact_net_per_run"
      expr: AVG(CAST(financial_impact_net AS DOUBLE))
      comment: "Average net financial impact per reconciliation run for materiality trending"
    - name: "distinct_groups_reconciled"
      expr: COUNT(DISTINCT group_id)
      comment: "Unique employer groups reconciled for coverage breadth of reconciliation process"
    - name: "auto_resolved_count"
      expr: SUM(CASE WHEN auto_resolution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-resolved reconciliations for straight-through processing rate"
    - name: "manual_resolved_count"
      expr: SUM(CASE WHEN manual_resolution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of manually resolved reconciliations for operational labor demand"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_cobra_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation coverage election metrics tracking election rates, premium collection, and subsidy utilization for regulatory compliance and revenue forecasting."
  source: "`health_insurance_ecm`.`enrollment`.`cobra_election`"
  dimensions:
    - name: "election_status"
      expr: election_status
      comment: "Current COBRA election status for pipeline and compliance tracking"
    - name: "election_decision"
      expr: election_decision
      comment: "Member's election decision (elected, waived, no response) for take-up rate analysis"
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying event triggering COBRA eligibility"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of COBRA coverage elected"
    - name: "payment_status"
      expr: payment_status
      comment: "Premium payment status for revenue collection monitoring"
    - name: "subsidy_eligibility_flag"
      expr: CAST(subsidy_eligibility_flag AS STRING)
      comment: "Whether member is eligible for COBRA subsidy"
    - name: "early_termination_flag"
      expr: CAST(early_termination_flag AS STRING)
      comment: "Whether COBRA coverage was terminated early"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Frequency of COBRA premium payments"
    - name: "qualifying_event_month"
      expr: DATE_TRUNC('month', qualifying_event_date)
      comment: "Month of qualifying event for trend analysis"
  measures:
    - name: "total_cobra_elections"
      expr: COUNT(1)
      comment: "Total COBRA election records for volume and compliance tracking"
    - name: "distinct_cobra_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members with COBRA elections for population sizing"
    - name: "total_cobra_premium"
      expr: SUM(CAST(cobra_premium_amount AS DOUBLE))
      comment: "Total COBRA premium amount for revenue forecasting"
    - name: "avg_cobra_premium"
      expr: AVG(CAST(cobra_premium_amount AS DOUBLE))
      comment: "Average COBRA premium for pricing and affordability analysis"
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total COBRA subsidy amount for government reimbursement tracking"
    - name: "early_termination_count"
      expr: SUM(CASE WHEN early_termination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of early COBRA terminations for attrition and duration analysis"
    - name: "subsidy_eligible_count"
      expr: SUM(CASE WHEN subsidy_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subsidy-eligible COBRA elections for government program exposure"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS enrollment submission metrics tracking submission quality, compliance, risk adjustment impact, and processing efficiency for Medicare/Medicaid regulatory reporting."
  source: "`health_insurance_ecm`.`enrollment`.`enrollment_cms_submission`"
  dimensions:
    - name: "enrollment_cms_submission_status"
      expr: enrollment_cms_submission_status
      comment: "Status of the CMS submission for pipeline monitoring"
    - name: "processing_status"
      expr: processing_status
      comment: "Processing stage of the submission for operational tracking"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission for categorization"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether submission passed compliance checks"
    - name: "risk_adjustment_flag"
      expr: CAST(risk_adjustment_flag AS STRING)
      comment: "Whether submission impacts risk adjustment scores"
    - name: "submission_source_system"
      expr: submission_source_system
      comment: "Source system generating the submission"
    - name: "is_test_submission"
      expr: CAST(is_test_submission AS STRING)
      comment: "Whether this is a test submission for filtering production data"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of effective date for submission cycle analysis"
  measures:
    - name: "total_cms_submissions"
      expr: COUNT(1)
      comment: "Total CMS submissions for regulatory reporting volume tracking"
    - name: "distinct_members_submitted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique members in CMS submissions for coverage reporting completeness"
    - name: "total_premium_submitted"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount in CMS submissions for revenue reconciliation with CMS"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount in submissions for financial accuracy tracking"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts in CMS submissions for correction volume monitoring"
    - name: "avg_raf_score_impact"
      expr: AVG(CAST(raf_score_impact AS DOUBLE))
      comment: "Average RAF score impact per submission for risk adjustment revenue optimization"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for submission accuracy monitoring"
    - name: "compliance_failure_count"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of submissions failing compliance checks for regulatory risk assessment"
    - name: "risk_adjustment_submission_count"
      expr: SUM(CASE WHEN risk_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk-adjustment-impacting submissions for RAF revenue tracking"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`enrollment_medicaid_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicaid eligibility metrics tracking enrollment volumes, income levels, dual eligibility, and redetermination for government program management and compliance."
  source: "`health_insurance_ecm`.`enrollment`.`medicaid_eligibility`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current Medicaid eligibility status for active population tracking"
    - name: "eligibility_category"
      expr: eligibility_category
      comment: "Medicaid eligibility category (expansion, traditional, CHIP, etc.)"
    - name: "medicaid_program_type"
      expr: medicaid_program_type
      comment: "Type of Medicaid program for program-level analysis"
    - name: "dual_eligible_flag"
      expr: CAST(dual_eligible_flag AS STRING)
      comment: "Whether member is dual-eligible (Medicare + Medicaid) for special needs population tracking"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of Medicaid enrollment for channel analysis"
    - name: "income_verification_status"
      expr: income_verification_status
      comment: "Status of income verification for eligibility integrity monitoring"
    - name: "state_agency"
      expr: state_agency
      comment: "State Medicaid agency for geographic and regulatory segmentation"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of eligibility effective date for enrollment trend analysis"
  measures:
    - name: "total_medicaid_eligibility_records"
      expr: COUNT(1)
      comment: "Total Medicaid eligibility records for program volume tracking"
    - name: "distinct_medicaid_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Unique Medicaid-eligible members for population sizing and capitation"
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage for income distribution analysis"
    - name: "avg_income_amount"
      expr: AVG(CAST(income_amount AS DOUBLE))
      comment: "Average income amount for socioeconomic analysis of Medicaid population"
    - name: "dual_eligible_count"
      expr: SUM(CASE WHEN dual_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dual-eligible members for D-SNP and MLTSS program planning"
    - name: "medical_need_count"
      expr: SUM(CASE WHEN medical_need_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members qualifying via medical need for high-acuity population identification"
    - name: "total_assets_amount"
      expr: SUM(CAST(assets_amount AS DOUBLE))
      comment: "Total reported assets for asset-test eligibility monitoring"
$$;