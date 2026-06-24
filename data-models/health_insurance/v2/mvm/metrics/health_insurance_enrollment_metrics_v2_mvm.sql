-- Metric views for domain: enrollment | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment eligibility metrics tracking active coverage spans, financial exposure, and benefit utilization across lines of business. Used by VP of Enrollment Operations and CFO to monitor coverage health, retroactive adjustments, and deductible/OOP liability."
  source: "`vibe_health_insurance_v1`.`enrollment`.`eligibility_span`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) for segmenting enrollment metrics by product portfolio."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (e.g., Medical, Dental, Vision) enabling benefit-level analysis of enrollment spans."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the span (e.g., Active, Terminated, Pending) for operational monitoring."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or system through which enrollment was initiated (e.g., Exchange, Employer, Direct) for source attribution."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year associated with the eligibility span for annual cohort analysis."
    - name: "coverage_category"
      expr: coverage_category
      comment: "Broad coverage category (e.g., Individual, Family, COBRA) for population segmentation."
    - name: "subscriber_relationship"
      expr: subscriber_relationship
      comment: "Relationship of the member to the subscriber (e.g., Self, Spouse, Dependent) for household-level analysis."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Indicates whether the eligibility span has a retroactive adjustment, used to isolate retro-enrollment activity."
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Indicates whether this is the member's primary coverage, enabling COB (Coordination of Benefits) analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of coverage effective date for trend analysis of new enrollment cohorts."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of coverage termination for churn and lapse trend analysis."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event (e.g., New Enrollment, Renewal, Termination) for event-driven operational reporting."
  measures:
    - name: "active_eligibility_span_count"
      expr: COUNT(CASE WHEN eligibility_status = 'Active' THEN eligibility_span_id END)
      comment: "Count of currently active eligibility spans. Core KPI for tracking enrolled membership volume used in capacity planning and premium revenue forecasting."
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total number of eligibility span records across all statuses. Baseline denominator for conversion and status-mix rate calculations."
    - name: "retroactive_adjustment_count"
      expr: COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN eligibility_span_id END)
      comment: "Count of eligibility spans with retroactive adjustments. High values signal operational risk, premium reconciliation exposure, and potential compliance issues."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across eligibility spans. Informs actuarial pricing reviews and member cost-sharing strategy decisions."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total aggregate coverage limit exposure across all active spans. Critical for risk management and reinsurance threshold monitoring."
    - name: "avg_oop_maximum"
      expr: AVG(CAST(oop_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum across eligibility spans. Used by actuarial and product teams to benchmark plan design competitiveness."
    - name: "total_moop_threshold"
      expr: SUM(CAST(moop_threshold AS DOUBLE))
      comment: "Total maximum out-of-pocket threshold exposure across all spans. Regulatory compliance metric for ACA MOOP limit adherence monitoring."
    - name: "waiver_applied_count"
      expr: COUNT(CASE WHEN is_waiver_applied = TRUE THEN eligibility_span_id END)
      comment: "Count of eligibility spans where a waiver has been applied. Tracks waiver program utilization for compliance and cost impact assessment."
    - name: "prior_coverage_indicator_count"
      expr: COUNT(CASE WHEN prior_coverage_indicator = TRUE THEN eligibility_span_id END)
      comment: "Count of spans with prior coverage indicated. Used in underwriting and risk stratification to assess continuity of coverage patterns."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan election metrics tracking member benefit selections, rider adoption, and enrollment event patterns. Used by Product, Actuarial, and Enrollment Operations leadership to evaluate plan uptake, benefit attachment rates, and COBRA exposure."
  source: "`vibe_health_insurance_v1`.`enrollment`.`plan_election`"
  dimensions:
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier selected (e.g., Employee Only, Employee + Spouse, Family) for premium tier mix analysis."
    - name: "election_type"
      expr: election_type
      comment: "Type of plan election (e.g., New, Change, Renewal, Termination) for enrollment event classification."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Enrollment event driving the election (e.g., Open Enrollment, QLE, COBRA) for event-source attribution."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which the plan election was submitted for distribution channel performance analysis."
    - name: "plan_election_status"
      expr: plan_election_status
      comment: "Current status of the plan election (e.g., Active, Pending, Terminated) for pipeline and operational monitoring."
    - name: "is_cobra_eligible"
      expr: is_cobra_eligible
      comment: "Indicates COBRA eligibility for the election, enabling COBRA population sizing and cost exposure analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of plan election effective date for enrollment volume trend analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of plan election termination for lapse and disenrollment trend analysis."
  measures:
    - name: "total_plan_elections"
      expr: COUNT(1)
      comment: "Total number of plan elections. Baseline volume metric for enrollment throughput and open enrollment campaign performance."
    - name: "active_plan_election_count"
      expr: COUNT(CASE WHEN plan_election_status = 'Active' THEN plan_election_id END)
      comment: "Count of currently active plan elections. Core membership KPI used in premium revenue forecasting and capacity planning."
    - name: "dental_rider_adoption_count"
      expr: COUNT(CASE WHEN dental_rider_flag = TRUE THEN plan_election_id END)
      comment: "Count of plan elections with dental rider attached. Measures ancillary benefit attachment rate for product revenue and member engagement analysis."
    - name: "vision_rider_adoption_count"
      expr: COUNT(CASE WHEN vision_rider_flag = TRUE THEN plan_election_id END)
      comment: "Count of plan elections with vision rider attached. Measures vision benefit attachment rate for ancillary product performance tracking."
    - name: "hsa_election_count"
      expr: COUNT(CASE WHEN hsa_election_flag = TRUE THEN plan_election_id END)
      comment: "Count of plan elections with HSA elected. Tracks HSA-eligible plan uptake, a key indicator of HDHP adoption and member financial engagement."
    - name: "fsa_election_count"
      expr: COUNT(CASE WHEN fsa_election_flag = TRUE THEN plan_election_id END)
      comment: "Count of plan elections with FSA elected. Monitors FSA program utilization for benefits administration planning."
    - name: "hra_election_count"
      expr: COUNT(CASE WHEN hra_election_flag = TRUE THEN plan_election_id END)
      comment: "Count of plan elections with HRA elected. Tracks employer-funded HRA adoption, informing cost-sharing strategy and employer group retention."
    - name: "cobra_election_count"
      expr: COUNT(CASE WHEN is_cobra_eligible = TRUE THEN plan_election_id END)
      comment: "Count of COBRA-eligible plan elections. Monitors COBRA population size for compliance, premium collection risk, and adverse selection management."
    - name: "avg_premium_frequency"
      expr: AVG(CAST(premium_frequency AS DOUBLE))
      comment: "Average premium payment frequency value across plan elections. Used by billing operations to assess payment cycle distribution and cash flow planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment transaction financial and operational metrics tracking gross/net premium flows, retroactive adjustments, and processing quality. Used by CFO, VP Finance, and Enrollment Operations to monitor premium revenue, financial adjustments, and transaction processing health."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  dimensions:
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment transaction (e.g., New, Renewal, Termination, Change) for transaction mix analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the transaction (e.g., Completed, Pending, Failed) for operational pipeline monitoring."
    - name: "processing_status"
      expr: processing_status
      comment: "Detailed processing status for SLA and throughput performance tracking."
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Type of health plan associated with the transaction (e.g., HMO, PPO, EPO) for plan-type financial analysis."
    - name: "enrollment_origin"
      expr: enrollment_origin
      comment: "Origin system or channel of the enrollment transaction for source attribution and data quality monitoring."
    - name: "coverage_period_type"
      expr: coverage_period_type
      comment: "Type of coverage period (e.g., Annual, Short-Term) for premium duration analysis."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Flags transactions with retroactive adjustments for financial restatement risk monitoring."
    - name: "financial_impact_flag"
      expr: financial_impact_flag
      comment: "Indicates whether the transaction has a financial impact, enabling financial vs. administrative transaction segmentation."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of transaction effective date for premium revenue trend analysis."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for coverage termination (e.g., Non-Payment, Voluntary, Aging Off) for churn root-cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency financial reporting."
  measures:
    - name: "total_gross_premium"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross premium amount across all enrollment transactions. Primary revenue KPI used in financial reporting, forecasting, and board-level revenue dashboards."
    - name: "total_net_premium"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net premium after adjustments. Core financial metric for actual earned revenue recognition and margin analysis."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total premium adjustment amount across transactions. Monitors financial restatement exposure and retroactive correction magnitude."
    - name: "avg_gross_premium_per_transaction"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross premium per enrollment transaction. Benchmarks per-member premium yield and informs pricing adequacy reviews."
    - name: "retroactive_transaction_count"
      expr: COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN transaction_id END)
      comment: "Count of transactions with retroactive adjustments. High volumes indicate operational risk, billing system issues, or eligibility data quality problems requiring executive intervention."
    - name: "financial_impact_transaction_count"
      expr: COUNT(CASE WHEN financial_impact_flag = TRUE THEN transaction_id END)
      comment: "Count of transactions with direct financial impact. Used to size the financially material transaction population for audit and reconciliation prioritization."
    - name: "grace_period_transaction_count"
      expr: COUNT(CASE WHEN is_grace_period = TRUE THEN transaction_id END)
      comment: "Count of transactions in grace period status. Monitors premium payment delinquency exposure and potential lapse risk in the enrolled population."
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total enrollment transaction volume. Baseline throughput metric for enrollment operations capacity and SLA monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDI 834 transaction processing metrics tracking file throughput, processing success rates, and data quality. Used by Enrollment Operations, IT, and Compliance leadership to monitor EDI pipeline health, error rates, and reconciliation status."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  dimensions:
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing status of the EDI transaction (e.g., Processed, Failed, Pending) for pipeline health monitoring."
  measures:
    - name: "total_edi_transactions"
      expr: COUNT(1)
      comment: "Total EDI transaction volume processed. Baseline throughput KPI for EDI pipeline capacity and trading partner activity monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time eligibility verification metrics tracking benefit utilization, deductible/OOP remaining balances, and verification response performance. Used by Medical Directors, Network Operations, and CFO to monitor point-of-care eligibility accuracy and benefit liability exposure."
  source: "`vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status returned by the verification (e.g., Active, Inactive, Unknown) for verification outcome analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage being verified (e.g., Medical, Dental, Pharmacy) for benefit-category verification volume analysis."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category queried during verification for service-level utilization and benefit limit monitoring."
    - name: "service_code"
      expr: service_code
      comment: "Service code associated with the eligibility inquiry for procedure-level benefit verification analysis."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Indicates whether prior authorization is required for the verified service, enabling auth requirement rate monitoring."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_timestamp)
      comment: "Month of eligibility inquiry for verification volume trend analysis."
    - name: "error_code"
      expr: error_code
      comment: "Error code from failed verifications for root-cause analysis of eligibility system issues."
    - name: "member_identifier_type"
      expr: member_identifier_type
      comment: "Type of member identifier used in the verification request (e.g., MBI, SSN, Member ID) for identifier quality analysis."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total eligibility verification inquiries. Baseline volume metric for point-of-care eligibility system utilization and provider portal activity."
    - name: "avg_response_time_seconds"
      expr: AVG(CAST(response_time_seconds AS DOUBLE))
      comment: "Average eligibility verification response time in seconds. Critical SLA metric — slow response times directly impact provider workflow and care delivery at point of service."
    - name: "total_benefit_limit"
      expr: SUM(CAST(benefit_limit AS DOUBLE))
      comment: "Total benefit limit exposure across all verified eligibility records. Used by actuarial and finance teams to monitor aggregate benefit liability."
    - name: "total_benefit_remaining"
      expr: SUM(CAST(benefit_remaining AS DOUBLE))
      comment: "Total remaining benefit balance across verified members. Informs benefit utilization forecasting and reserve adequacy assessments."
    - name: "total_benefit_used"
      expr: SUM(CAST(benefit_used AS DOUBLE))
      comment: "Total benefit amount consumed across verified members. Core utilization metric for medical cost trend analysis and benefit design reviews."
    - name: "total_deductible_remaining"
      expr: SUM(CAST(deductible_remaining AS DOUBLE))
      comment: "Total deductible balance remaining across verified members. Used to forecast when members will transition to plan-paid coverage, impacting medical cost projections."
    - name: "total_oop_remaining"
      expr: SUM(CAST(oop_remaining AS DOUBLE))
      comment: "Total out-of-pocket balance remaining across verified members. Key financial exposure metric for estimating member cost-sharing liability and plan payment obligations."
    - name: "authorization_required_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN eligibility_verification_id END)
      comment: "Count of verifications where prior authorization is required. Monitors auth burden on providers and members, informing utilization management program design."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualifying Life Event (QLE) and Special Enrollment Period (SEP) metrics tracking event volumes, verification outcomes, and SEP window compliance. Used by Enrollment Operations, Compliance, and Product leadership to monitor SEP integrity, denial rates, and CMS regulatory outcomes."
  source: "`vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of qualifying life event (e.g., Marriage, Birth, Job Loss, Divorce) for SEP trigger analysis and enrollment pattern monitoring."
    - name: "qualifying_life_event_status"
      expr: qualifying_life_event_status
      comment: "Current status of the QLE (e.g., Approved, Denied, Pending) for SEP approval pipeline monitoring."
    - name: "verification_status"
      expr: verification_status
      comment: "Documentation verification status for the QLE, used to track verification completion rates and compliance with SEP documentation requirements."
    - name: "sep_category_code"
      expr: sep_category_code
      comment: "CMS SEP category code for regulatory reporting and SEP type distribution analysis."
    - name: "cms_sep_outcome"
      expr: cms_sep_outcome
      comment: "CMS-reported SEP outcome for regulatory compliance monitoring and Exchange reconciliation."
    - name: "sep_window_status"
      expr: sep_window_status
      comment: "Status of the SEP enrollment window (e.g., Open, Closed, Expired) for enrollment deadline compliance monitoring."
    - name: "documentation_type"
      expr: documentation_type
      comment: "Type of documentation submitted to support the QLE for documentation completeness analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the qualifying life event for seasonal SEP volume trend analysis."
  measures:
    - name: "total_qualifying_life_events"
      expr: COUNT(1)
      comment: "Total qualifying life events submitted. Baseline SEP volume metric for enrollment operations staffing and Exchange compliance reporting."
    - name: "approved_qle_count"
      expr: COUNT(CASE WHEN qualifying_life_event_status = 'Approved' THEN qualifying_life_event_id END)
      comment: "Count of approved qualifying life events. Measures SEP approval throughput and is a leading indicator of mid-year enrollment volume."
    - name: "denied_qle_count"
      expr: COUNT(CASE WHEN qualifying_life_event_status = 'Denied' THEN qualifying_life_event_id END)
      comment: "Count of denied qualifying life events. High denial rates may indicate documentation barriers, fraud risk, or process issues requiring compliance review."
    - name: "pending_verification_count"
      expr: COUNT(CASE WHEN verification_status = 'Pending' THEN qualifying_life_event_id END)
      comment: "Count of QLEs with pending documentation verification. Monitors verification backlog that could delay member enrollment and trigger regulatory penalties."
    - name: "distinct_event_types"
      expr: COUNT(DISTINCT event_type)
      comment: "Count of distinct QLE event types observed. Monitors breadth of SEP triggers in the enrolled population for product and compliance planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Enrollment Period (OEP) performance metrics tracking enrollment campaign execution, volume target attainment, and regulatory compliance. Used by VP of Sales, Chief Actuary, and Compliance leadership to evaluate OEP outcomes against targets and regulatory filing requirements."
  source: "`vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`"
  dimensions:
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment period (e.g., Annual Open Enrollment, Special Enrollment, Initial Enrollment) for period-type performance comparison."
    - name: "lob"
      expr: lob
      comment: "Line of business for the enrollment period (e.g., Individual, Small Group, Medicare) for LOB-level OEP performance analysis."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Exchange type (e.g., FFM, SBE, Off-Exchange) for marketplace channel performance analysis."
    - name: "open_enrollment_period_status"
      expr: open_enrollment_period_status
      comment: "Current status of the enrollment period (e.g., Active, Closed, Upcoming) for pipeline and planning visibility."
    - name: "eligibility_segment"
      expr: eligibility_segment
      comment: "Eligibility segment targeted by the enrollment period (e.g., Under 65, Medicare-Eligible) for population-level OEP analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the enrollment period for compliance risk monitoring."
    - name: "is_annual"
      expr: is_annual
      comment: "Indicates whether the period is an annual open enrollment, enabling annual vs. special period performance comparison."
    - name: "volume_target_met"
      expr: volume_target_met
      comment: "Indicates whether the enrollment volume target was met for OEP success rate tracking."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the enrollment period started for seasonal OEP calendar analysis."
  measures:
    - name: "total_enrollment_periods"
      expr: COUNT(1)
      comment: "Total number of open enrollment periods defined. Baseline metric for enrollment calendar management and regulatory filing tracking."
    - name: "active_enrollment_period_count"
      expr: COUNT(CASE WHEN open_enrollment_period_status = 'Active' THEN open_enrollment_period_id END)
      comment: "Count of currently active enrollment periods. Operational metric for monitoring concurrent enrollment windows and resource allocation."
    - name: "volume_target_met_count"
      expr: COUNT(CASE WHEN volume_target_met = TRUE THEN open_enrollment_period_id END)
      comment: "Count of enrollment periods that met their volume target. Key performance metric for evaluating OEP campaign effectiveness and sales execution."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required = TRUE THEN open_enrollment_period_id END)
      comment: "Count of enrollment periods requiring regulatory filing. Compliance workload metric for tracking CMS and state regulatory submission obligations."
    - name: "retrospective_allowed_count"
      expr: COUNT(CASE WHEN is_retrospective_allowed = TRUE THEN open_enrollment_period_id END)
      comment: "Count of enrollment periods allowing retrospective enrollment. Monitors retroactive enrollment exposure which carries premium collection and adverse selection risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicaid_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicaid eligibility metrics tracking program enrollment, income verification, dual eligibility, and redetermination compliance. Used by VP of Government Programs, Compliance, and Actuarial leadership to monitor Medicaid population health, FPL distribution, and redetermination risk."
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current Medicaid eligibility status (e.g., Active, Terminated, Pending) for program enrollment monitoring."
    - name: "eligibility_category"
      expr: eligibility_category
      comment: "Medicaid eligibility category (e.g., MAGI, ABD, CHIP) for program-type population analysis."
    - name: "medicaid_program_type"
      expr: medicaid_program_type
      comment: "Type of Medicaid program (e.g., Fee-for-Service, Managed Care) for program structure analysis."
    - name: "dual_eligible_flag"
      expr: dual_eligible_flag
      comment: "Indicates dual Medicare-Medicaid eligibility for dual-eligible population monitoring, a high-cost, high-complexity cohort."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of Medicaid enrollment (e.g., State Agency, Exchange, Auto-Enrollment) for enrollment channel analysis."
    - name: "eligibility_verification_method"
      expr: eligibility_verification_method
      comment: "Method used to verify Medicaid eligibility (e.g., Electronic, Manual, Self-Attestation) for verification quality analysis."
    - name: "state_agency"
      expr: state_agency
      comment: "State Medicaid agency for multi-state program performance comparison and state-level compliance monitoring."
    - name: "federal_program_indicator"
      expr: federal_program_indicator
      comment: "Indicates federal program participation (e.g., FMAP-eligible) for federal funding and reporting segmentation."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month of Medicaid coverage start for enrollment cohort trend analysis."
    - name: "redetermination_due_month"
      expr: DATE_TRUNC('MONTH', redetermination_due_date)
      comment: "Month redetermination is due for proactive redetermination workload planning and compliance monitoring."
  measures:
    - name: "total_medicaid_eligibility_records"
      expr: COUNT(1)
      comment: "Total Medicaid eligibility records. Baseline metric for Medicaid program enrollment volume used in capitation rate setting and state reporting."
    - name: "active_medicaid_count"
      expr: COUNT(CASE WHEN eligibility_status = 'Active' THEN medicaid_eligibility_id END)
      comment: "Count of active Medicaid eligibility records. Core government program KPI for capitation payment reconciliation and state contract compliance."
    - name: "dual_eligible_count"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE THEN medicaid_eligibility_id END)
      comment: "Count of dual Medicare-Medicaid eligible members. Critical population metric — dual eligibles represent disproportionate medical cost and require specialized care coordination programs."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage across Medicaid members. Key actuarial metric for risk stratification, subsidy calculation, and program eligibility threshold analysis."
    - name: "avg_income_amount"
      expr: AVG(CAST(income_amount AS DOUBLE))
      comment: "Average reported income amount across Medicaid eligibility records. Used in eligibility category validation and income-based program qualification analysis."
    - name: "avg_assets_amount"
      expr: AVG(CAST(assets_amount AS DOUBLE))
      comment: "Average reported assets amount for Medicaid eligibility records. Relevant for ABD and long-term care Medicaid programs where asset tests apply."
    - name: "redetermination_due_count"
      expr: COUNT(CASE WHEN redetermination_due_date IS NOT NULL THEN medicaid_eligibility_id END)
      comment: "Count of Medicaid records with a pending redetermination due date. Monitors redetermination workload pipeline — failure to complete redeterminations on time creates federal compliance risk and potential enrollment errors."
    - name: "medical_need_flag_count"
      expr: COUNT(CASE WHEN medical_need_flag = TRUE THEN medicaid_eligibility_id END)
      comment: "Count of Medicaid members with a documented medical need flag. Identifies medically complex population for care management program targeting and cost management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicare_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare entitlement metrics tracking Part A/B/D enrollment, dual eligibility, LIS/Extra Help status, and IRMAA exposure. Used by VP of Medicare, Actuarial, and Compliance leadership to monitor Medicare Advantage membership, premium surcharge risk, and CMS regulatory compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of Medicare entitlement (e.g., Age, Disability, ESRD) for entitlement basis analysis and risk stratification."
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current Medicare entitlement status (e.g., Active, Terminated, Pending) for membership monitoring."
    - name: "verification_status"
      expr: verification_status
      comment: "CMS verification status of the entitlement record for data quality and compliance monitoring."
    - name: "is_dual_eligible"
      expr: is_dual_eligible
      comment: "Indicates dual Medicare-Medicaid eligibility for dual-eligible population monitoring and D-SNP program analysis."
    - name: "lis_status"
      expr: lis_status
      comment: "Low Income Subsidy (LIS/Extra Help) status for Part D premium subsidy population monitoring."
    - name: "extra_help_status"
      expr: extra_help_status
      comment: "Extra Help program status for Part D cost-sharing subsidy population analysis."
    - name: "irmaa_status"
      expr: irmaa_status
      comment: "Income-Related Monthly Adjustment Amount (IRMAA) status for premium surcharge population monitoring."
    - name: "is_retired"
      expr: is_retired
      comment: "Indicates retirement status of the Medicare member for retiree vs. working-aged Medicare population segmentation."
    - name: "part_a_entitlement_month"
      expr: DATE_TRUNC('MONTH', part_a_entitlement_date)
      comment: "Month of Medicare Part A entitlement for enrollment cohort trend analysis."
    - name: "ma_enrollment_month"
      expr: DATE_TRUNC('MONTH', ma_enrollment_effective_date)
      comment: "Month of Medicare Advantage enrollment effective date for MA membership growth trend analysis."
  measures:
    - name: "total_medicare_entitlements"
      expr: COUNT(1)
      comment: "Total Medicare entitlement records. Baseline Medicare membership volume metric for CMS bid submissions, capitation reconciliation, and MA star ratings denominator."
    - name: "active_entitlement_count"
      expr: COUNT(CASE WHEN entitlement_status = 'Active' THEN medicare_entitlement_id END)
      comment: "Count of active Medicare entitlements. Core MA membership KPI used in CMS monthly membership reconciliation and capitation payment validation."
    - name: "dual_eligible_count"
      expr: COUNT(CASE WHEN is_dual_eligible = TRUE THEN medicare_entitlement_id END)
      comment: "Count of dual-eligible Medicare members. Critical population metric for D-SNP program sizing, risk score adjustment, and CMS compliance reporting."
    - name: "lis_enrolled_count"
      expr: COUNT(CASE WHEN lis_status = 'Active' THEN medicare_entitlement_id END)
      comment: "Count of members with active Low Income Subsidy. Monitors LIS population size for Part D premium subsidy cost forecasting and CMS reconciliation."
    - name: "irmaa_surcharge_count"
      expr: COUNT(CASE WHEN irmaa_status = 'Active' THEN medicare_entitlement_id END)
      comment: "Count of members subject to IRMAA premium surcharge. Monitors high-income Medicare population for premium revenue uplift and member communication planning."
    - name: "avg_irmaa_income_bracket"
      expr: AVG(CAST(irmaa_income_bracket AS DOUBLE))
      comment: "Average IRMAA income bracket value across affected members. Used by actuarial teams to model premium surcharge revenue and assess income distribution of the Medicare population."
    - name: "part_d_enrolled_count"
      expr: COUNT(CASE WHEN part_d_enrollment_effective_date IS NOT NULL THEN medicare_entitlement_id END)
      comment: "Count of members enrolled in Medicare Part D. Monitors Part D enrollment penetration rate for pharmacy benefit program sizing and CMS creditable coverage compliance."
    - name: "ma_enrolled_count"
      expr: COUNT(CASE WHEN ma_enrollment_effective_date IS NOT NULL THEN medicare_entitlement_id END)
      comment: "Count of members enrolled in Medicare Advantage. Core MA growth metric used in CMS bid planning, capitation revenue forecasting, and competitive market share analysis."
$$;