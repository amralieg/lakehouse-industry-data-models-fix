-- Metric views for domain: insurance | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for member enrollment health, premium revenue, subsidy exposure, and coverage mix. Used by VP of Enrollment Operations and CFO to monitor membership growth, premium yield, and benefit period coverage."
  source: "`healthcare_ecm`.`insurance`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, terminated, pending) — primary segmentation for membership reporting."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (new, renewal, COBRA, special enrollment) — used to analyze enrollment channel mix."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (exchange, employer, direct) — informs acquisition strategy."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family, employee+spouse, etc.) — drives premium and benefit cost analysis."
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Member relationship to the primary subscriber — used to distinguish primary vs. dependent enrollment."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied (APTC, CSR, Medicaid, none) — critical for regulatory and financial reporting."
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "Current premium payment status (paid, delinquent, grace period) — used to identify at-risk members."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for enrollment termination — used to analyze voluntary vs. involuntary churn."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or broker that originated the enrollment — used for channel attribution."
    - name: "benefit_period_start_year"
      expr: YEAR(benefit_period_start_date)
      comment: "Benefit period start year — used for year-over-year enrollment trend analysis."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start_date)
      comment: "Benefit period start month — used for monthly enrollment cohort analysis."
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "Indicates whether the member is enrolled under COBRA continuation coverage."
  measures:
    - name: "total_enrolled_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Total distinct members enrolled. Core membership census metric used by executives to track plan size and growth trajectory."
    - name: "total_enrollment_records"
      expr: COUNT(1)
      comment: "Total enrollment records including all spans and re-enrollments. Used to measure enrollment transaction volume."
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium billed across all enrolled members. Primary revenue KPI for the insurance line of business, used in CFO dashboards."
    - name: "avg_premium_per_member"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per enrollment record. Used to benchmark pricing adequacy and detect premium erosion across plan types."
    - name: "total_subsidy_exposure"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy dollars applied across enrolled members. Critical for ACA compliance reporting and financial risk assessment."
    - name: "avg_subsidy_per_member"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average subsidy amount per enrollment record. Used to assess subsidy dependency and regulatory exposure per plan."
    - name: "cobra_enrolled_members"
      expr: COUNT(DISTINCT CASE WHEN cobra_indicator = TRUE THEN mpi_record_id END)
      comment: "Number of distinct members enrolled under COBRA. Used to monitor COBRA utilization and associated premium risk."
    - name: "active_enrolled_members"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN mpi_record_id END)
      comment: "Number of currently active enrolled members. Core operational metric for capacity planning and premium forecasting."
    - name: "terminated_enrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'terminated' THEN 1 END)
      comment: "Count of terminated enrollment records. Used to calculate churn rate and identify retention risk."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking member deductible and out-of-pocket accumulation progress. Used by actuaries, care management, and finance to monitor cost-sharing exposure, threshold attainment, and benefit period utilization."
  source: "`healthcare_ecm`.`insurance`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, out-of-pocket maximum, copay, etc.) — primary segmentation for cost-sharing analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record — used to filter active vs. closed accumulators."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (individual, family) — used to distinguish individual vs. aggregate accumulator tracking."
    - name: "network_type"
      expr: network_type
      comment: "Network type (in-network, out-of-network) — used to analyze cost-sharing by network participation."
    - name: "service_category"
      expr: service_category
      comment: "Service category driving accumulation (medical, pharmacy, behavioral health) — used for benefit category analysis."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year associated with the accumulator — used for year-over-year cost-sharing trend analysis."
    - name: "threshold_met_indicator"
      expr: threshold_met_indicator
      comment: "Indicates whether the accumulator threshold has been met — used to identify members who have exhausted cost-sharing."
    - name: "carryover_indicator"
      expr: carryover_indicator
      comment: "Indicates whether accumulated amounts carry over to the next benefit period."
    - name: "embedded_deductible_indicator"
      expr: embedded_deductible_indicator
      comment: "Indicates whether an embedded deductible applies — used to distinguish family plan deductible structures."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start_date)
      comment: "Benefit period start month — used for cohort-based accumulation trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of accumulator amounts — used for multi-currency financial reporting."
  measures:
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total amount accumulated toward deductibles and out-of-pocket maximums. Core cost-sharing KPI used by actuaries to project benefit exhaustion and financial liability."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining amount before threshold is met across all accumulators. Used to forecast future member cost-sharing exposure and plan liability."
    - name: "total_threshold_amount"
      expr: SUM(CAST(threshold_amount AS DOUBLE))
      comment: "Total threshold (deductible or OOP max) amounts across all accumulators. Used to benchmark plan design cost-sharing levels."
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per accumulator record. Used to assess typical member cost-sharing burden and plan adequacy."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to accumulators. Used to monitor retroactive corrections and their financial impact on cost-sharing balances."
    - name: "total_carryover_amount"
      expr: SUM(CAST(carryover_amount AS DOUBLE))
      comment: "Total carryover amounts from prior benefit periods. Used to assess the financial impact of carryover provisions on plan liability."
    - name: "members_at_threshold"
      expr: COUNT(DISTINCT CASE WHEN threshold_met_indicator = TRUE THEN member_enrollment_id END)
      comment: "Number of distinct member enrollments that have met their accumulator threshold. Used to identify members with no remaining cost-sharing obligation, driving high utilization risk."
    - name: "threshold_attainment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN threshold_met_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accumulator records where the threshold has been met. Key actuarial KPI for projecting plan liability and pricing adequacy."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs for capitation payment performance, PMPM rates, quality withholds, and risk adjustment. Used by CFO, VP of Value-Based Care, and finance operations to monitor capitated contract financial performance."
  source: "`healthcare_ecm`.`insurance`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (paid, pending, voided, adjusted) — primary filter for financial reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (EFT, check, wire) — used for treasury and reconciliation reporting."
    - name: "contract_year"
      expr: contract_year
      comment: "Contract year of the capitation payment — used for year-over-year financial performance comparison."
    - name: "payment_period_year"
      expr: payment_period_year
      comment: "Year of the payment period — used for annual financial planning and budget variance analysis."
    - name: "payment_period_month"
      expr: payment_period_month
      comment: "Month of the payment period — used for monthly cash flow and PMPM trend analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment — used to identify unreconciled payments requiring action."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for payment adjustment — used to categorize and monitor retroactive payment corrections."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the capitation payment — used for multi-currency financial consolidation."
    - name: "revenue_recognition_period"
      expr: revenue_recognition_period
      comment: "Period in which revenue is recognized — used for GAAP revenue recognition compliance reporting."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month the payment was due — used for cash flow forecasting and payment timeliness analysis."
  measures:
    - name: "total_gross_capitation"
      expr: SUM(CAST(gross_capitation_amount AS DOUBLE))
      comment: "Total gross capitation payments before withholds and adjustments. Primary revenue KPI for value-based care contracts, used in CFO and VBC dashboards."
    - name: "total_net_payment"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payments after withholds and adjustments. Represents actual cash outflow for capitated contracts — critical for budget vs. actual analysis."
    - name: "total_quality_withhold"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold amounts retained from capitation payments. Used to monitor quality incentive program financial exposure and provider performance accountability."
    - name: "total_risk_adjusted_amount"
      expr: SUM(CAST(risk_adjusted_amount AS DOUBLE))
      comment: "Total risk-adjusted capitation amounts. Used to assess the financial impact of risk adjustment on capitation revenue."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total retroactive adjustment amounts applied to capitation payments. Used to monitor payment correction volume and financial restatement risk."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between expected and actual capitation payments. Used to identify systematic payment discrepancies requiring contract or process remediation."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month capitation rate. Benchmark KPI for comparing capitation rates across contracts, geographies, and plan types."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to capitation payments. Used to assess population health acuity and its financial impact on capitation rates."
    - name: "avg_quality_withhold_percentage"
      expr: AVG(CAST(quality_withhold_percentage AS DOUBLE))
      comment: "Average quality withhold percentage across capitation payments. Used to benchmark quality incentive program design and provider accountability levels."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of capitation payment transactions. Used to monitor payment volume and detect anomalies in payment processing."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_utilization_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and quality KPIs for utilization review decisions, denial rates, turnaround times, and appeal activity. Used by Medical Directors, VP of Clinical Operations, and compliance teams to monitor UR program effectiveness and regulatory compliance."
  source: "`healthcare_ecm`.`insurance`.`utilization_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of utilization review (prior authorization, concurrent, retrospective) — primary segmentation for UR program analysis."
    - name: "review_decision"
      expr: review_decision
      comment: "Final UR decision (approved, denied, partially approved, pended) — core dimension for denial rate and approval rate analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (open, closed, appealed) — used to monitor UR workflow throughput."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized denial reason code — used to identify top denial drivers and inform clinical criteria review."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for the reviewed service — used to analyze UR decisions by care setting."
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Indicates whether an appeal was filed against the UR decision — used to monitor appeal rates and denial quality."
    - name: "regulatory_timeframe_met"
      expr: regulatory_timeframe_met
      comment: "Indicates whether the regulatory turnaround time requirement was met — critical compliance KPI."
    - name: "peer_to_peer_requested"
      expr: peer_to_peer_requested
      comment: "Indicates whether a peer-to-peer review was requested — used to monitor clinical engagement and denial overturn rates."
    - name: "review_initiation_month"
      expr: DATE_TRUNC('MONTH', review_initiation_date)
      comment: "Month the review was initiated — used for monthly UR volume and decision trend analysis."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of the service under review — used for service utilization trend analysis."
    - name: "reviewer_credentials"
      expr: reviewer_credentials
      comment: "Credentials of the reviewer (MD, RN, PharmD) — used to ensure appropriate clinical review level compliance."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of utilization review records. Core volume KPI for UR program capacity planning and workload management."
    - name: "total_denied_reviews"
      expr: COUNT(CASE WHEN review_decision = 'denied' THEN 1 END)
      comment: "Total number of denied utilization reviews. Used by Medical Directors to monitor denial volume and identify clinical criteria issues."
    - name: "denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_decision = 'denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of utilization reviews resulting in denial. Key quality and compliance KPI — high denial rates trigger regulatory scrutiny and member satisfaction risk."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UR decisions that resulted in an appeal. Used to assess denial quality — high appeal rates indicate potential over-denial or criteria misapplication."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_timeframe_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UR decisions completed within regulatory timeframe requirements. Critical compliance KPI — failures expose the plan to regulatory penalties and member harm."
    - name: "peer_to_peer_request_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where a peer-to-peer discussion was requested. Used to monitor clinical engagement levels and identify denial categories with high provider pushback."
    - name: "distinct_members_reviewed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct members who had at least one utilization review. Used to assess UR program reach and identify high-utilization member cohorts."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_risk_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and clinical KPIs for risk adjustment program performance, HCC capture rates, payment impact, and submission quality. Used by VP of Risk Adjustment, actuaries, and compliance teams to maximize accurate risk score capture and CMS payment accuracy."
  source: "`healthcare_ecm`.`insurance`.`risk_adjustment`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the risk adjustment submission (accepted, rejected, pending) — primary filter for submission quality analysis."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (initial, supplemental, deletion) — used to analyze submission strategy and correction volume."
    - name: "hcc_code"
      expr: hcc_code
      comment: "Hierarchical Condition Category code — primary clinical dimension for risk score contribution analysis."
    - name: "model"
      expr: model
      comment: "Risk adjustment model used (CMS-HCC, RxHCC, CDPS) — used to segment risk score analysis by regulatory model."
    - name: "model_version"
      expr: model_version
      comment: "Version of the risk adjustment model — used to track model year transitions and their financial impact."
    - name: "payment_year"
      expr: payment_year
      comment: "Payment year for the risk adjustment — used for year-over-year risk score and payment trend analysis."
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis driving the HCC (face-to-face, chart review, encounter) — used to assess documentation source quality."
    - name: "medical_record_review_status"
      expr: medical_record_review_status
      comment: "Status of medical record review for the risk adjustment record — used to monitor chart review program throughput."
    - name: "radv_audit_status"
      expr: radv_audit_status
      comment: "RADV audit status — critical compliance dimension for CMS audit risk management."
    - name: "recapture_flag"
      expr: recapture_flag
      comment: "Indicates whether this is a recapture submission for a previously missed HCC — used to measure prospective vs. retrospective capture strategy."
    - name: "suspect_flag"
      expr: suspect_flag
      comment: "Indicates whether the HCC was identified as a suspect condition — used to monitor suspect identification program effectiveness."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of risk adjustment submission — used for submission cadence and deadline compliance analysis."
    - name: "deleted_flag"
      expr: deleted_flag
      comment: "Indicates whether the risk adjustment record has been deleted — used to filter active vs. voided submissions."
  measures:
    - name: "total_risk_adjustment_records"
      expr: COUNT(1)
      comment: "Total number of risk adjustment submissions. Core volume KPI for risk adjustment program throughput and CMS submission compliance."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total risk adjustment payment amounts. Primary financial KPI for risk adjustment program — directly impacts plan revenue from CMS."
    - name: "total_payment_impact"
      expr: SUM(CAST(payment_impact_amount AS DOUBLE))
      comment: "Total incremental payment impact from risk adjustment submissions. Used to quantify the financial value of the risk adjustment program and prioritize HCC capture efforts."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across submitted records. Benchmark KPI for population health acuity — used to validate actuarial assumptions and premium adequacy."
    - name: "avg_disease_score"
      expr: AVG(CAST(disease_score AS DOUBLE))
      comment: "Average disease score component of the risk score. Used to assess the clinical complexity of the enrolled population."
    - name: "avg_demographic_score"
      expr: AVG(CAST(demographic_score AS DOUBLE))
      comment: "Average demographic score component of the risk score. Used to assess age/gender contribution to overall risk and validate demographic data quality."
    - name: "submission_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk adjustment submissions accepted by CMS. Quality KPI for submission accuracy — low acceptance rates indicate data quality or coding issues."
    - name: "recapture_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recapture_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that are recaptures of previously missed HCCs. Used to assess retrospective capture program effectiveness and identify prospective documentation gaps."
    - name: "distinct_members_risk_adjusted"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct members with at least one risk adjustment submission. Used to measure risk adjustment program coverage across the enrolled population."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for member eligibility coverage, premium collection, subsidy utilization, and dual/special eligibility populations. Used by enrollment operations, finance, and compliance teams to monitor eligibility accuracy and coverage continuity."
  source: "`healthcare_ecm`.`insurance`.`eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status (eligible, ineligible, pending) — primary filter for active coverage analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, pharmacy) — used to analyze eligibility by benefit type."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (individual, family, employee+spouse) — used for premium and benefit cost segmentation."
    - name: "coverage_order"
      expr: coverage_order
      comment: "COB coverage order (primary, secondary, tertiary) — used for coordination of benefits analysis."
    - name: "dual_eligibility_indicator"
      expr: dual_eligibility_indicator
      comment: "Indicates dual Medicare/Medicaid eligibility — critical for special population management and regulatory reporting."
    - name: "dual_eligibility_type"
      expr: dual_eligibility_type
      comment: "Type of dual eligibility (full dual, partial dual, QMB, SLMB) — used for targeted care management program enrollment."
    - name: "medicaid_indicator"
      expr: medicaid_indicator
      comment: "Indicates Medicaid eligibility — used for Medicaid managed care enrollment and compliance reporting."
    - name: "medicare_indicator"
      expr: medicare_indicator
      comment: "Indicates Medicare eligibility — used for Medicare Advantage enrollment and CMS reporting."
    - name: "exchange_indicator"
      expr: exchange_indicator
      comment: "Indicates ACA exchange enrollment — used for APTC/CSR subsidy compliance and CMS reporting."
    - name: "cobra_indicator"
      expr: cobra_indicator
      comment: "Indicates COBRA continuation coverage — used to monitor COBRA population and associated premium risk."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy applied (APTC, CSR, none) — used for ACA financial reporting and subsidy reconciliation."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for eligibility termination — used to analyze involuntary vs. voluntary coverage loss."
    - name: "eligibility_start_month"
      expr: DATE_TRUNC('MONTH', eligibility_start_date)
      comment: "Month eligibility began — used for cohort-based coverage trend analysis."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method used to enroll (online, paper, EDI 834) — used to analyze enrollment channel efficiency."
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total number of eligibility span records. Core volume metric for eligibility data completeness and enrollment system throughput."
    - name: "distinct_eligible_members"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of distinct members with at least one eligibility span. Primary membership census KPI used for plan sizing and premium forecasting."
    - name: "total_premium_billed"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium billed across all eligibility spans. Core revenue KPI for insurance operations — used in monthly financial close and budget vs. actual reporting."
    - name: "avg_premium_per_span"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per eligibility span. Used to benchmark premium adequacy and detect pricing anomalies across plan types and coverage levels."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy dollars applied across eligibility spans. Critical for ACA APTC/CSR reconciliation and regulatory financial reporting."
    - name: "dual_eligible_member_count"
      expr: COUNT(DISTINCT CASE WHEN dual_eligibility_indicator = TRUE THEN mpi_record_id END)
      comment: "Number of distinct dual-eligible members (Medicare and Medicaid). Used to size special needs plan (SNP) populations and target care management resources."
    - name: "exchange_enrolled_member_count"
      expr: COUNT(DISTINCT CASE WHEN exchange_indicator = TRUE THEN mpi_record_id END)
      comment: "Number of distinct members enrolled through the ACA exchange. Used for CMS reporting, APTC reconciliation, and exchange market performance analysis."
    - name: "eligibility_verification_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verification_status = 'verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligibility spans with completed verification. Operational quality KPI — low rates indicate data integrity risk and potential claims payment errors."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan design and financial structure KPIs for health plan portfolio management. Used by product management, actuaries, and executives to analyze plan mix, cost-sharing design, and portfolio composition."
  source: "`healthcare_ecm`.`insurance`.`health_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Health plan type (HMO, PPO, EPO, HDHP, POS) — primary segmentation for plan portfolio analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current plan status (active, terminated, pending) — used to filter active plan portfolio."
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) — used for ACA market segment analysis and actuarial value benchmarking."
    - name: "funding_type"
      expr: funding_type
      comment: "Plan funding type (fully insured, self-funded, level-funded) — critical for financial risk and regulatory reporting segmentation."
    - name: "issuer_state"
      expr: issuer_state
      comment: "State where the plan is issued — used for geographic market analysis and state regulatory compliance."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year of the plan — used for year-over-year plan portfolio comparison."
    - name: "hsa_eligible"
      expr: hsa_eligible
      comment: "Indicates whether the plan is HSA-eligible — used to analyze HDHP/HSA product penetration."
    - name: "out_of_network_coverage"
      expr: out_of_network_coverage
      comment: "Indicates whether out-of-network coverage is included — used to differentiate open vs. closed network plan designs."
    - name: "requires_pcp_selection"
      expr: requires_pcp_selection
      comment: "Indicates whether PCP selection is required — used to distinguish managed care vs. open access plan designs."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the plan became effective — used for plan vintage analysis and portfolio lifecycle management."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of health plan records in the portfolio. Used by product management to track plan portfolio size and complexity."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'active' THEN 1 END)
      comment: "Number of currently active health plans. Core portfolio KPI used by product management to assess market presence and plan rationalization opportunities."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount across plans. Used by actuaries and product teams to benchmark plan design cost-sharing levels against market standards."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount across plans. Used to assess family coverage affordability and plan design competitiveness."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(individual_oop_max_amount AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across plans. Key plan design KPI — used to assess member financial protection levels and ACA compliance."
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(primary_care_copay_amount AS DOUBLE))
      comment: "Average primary care copay amount across plans. Used to benchmark access barriers to primary care and assess plan design competitiveness."
    - name: "avg_specialist_copay"
      expr: AVG(CAST(specialist_copay_amount AS DOUBLE))
      comment: "Average specialist copay amount across plans. Used to assess specialist access cost-sharing and its impact on care utilization patterns."
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans. Used to benchmark member cost-sharing burden and actuarial value across the plan portfolio."
    - name: "hsa_eligible_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hsa_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans that are HSA-eligible. Used to assess HDHP/HSA product strategy penetration and consumer-directed health plan adoption."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_payer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for payer contract portfolio management, reimbursement rates, contract status, and risk arrangement mix. Used by VP of Contracting, CFO, and network management teams to optimize payer relationships and reimbursement performance."
  source: "`healthcare_ecm`.`insurance`.`payer_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated, pending) — primary filter for active contract portfolio analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of payer contract (fee-for-service, capitation, bundled payment, shared savings) — used to analyze reimbursement model mix."
    - name: "reimbursement_method"
      expr: reimbursement_method
      comment: "Reimbursement methodology (DRG, per diem, percent of charges, case rate) — used to assess payment model complexity and financial risk."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Type of risk arrangement (full risk, partial risk, no risk) — used to assess value-based care contract penetration."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of the contract (preferred, standard, out-of-network) — used for tiered network strategy analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the contract applies — used for geographic market analysis and state-specific regulatory compliance."
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Indicates whether the contract includes quality bonus provisions — used to assess value-based incentive program penetration."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — used to manage contract renewal pipeline and negotiation calendar."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective — used for contract vintage and renewal cycle analysis."
    - name: "credentialing_required"
      expr: credentialing_required
      comment: "Indicates whether credentialing is required under the contract — used for provider onboarding compliance monitoring."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of payer contracts. Core portfolio KPI for network management — used to assess contracting coverage and complexity."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of currently active payer contracts. Used by VP of Contracting to monitor active network coverage and identify gaps."
    - name: "avg_base_reimbursement_percentage"
      expr: AVG(CAST(base_reimbursement_percentage AS DOUBLE))
      comment: "Average base reimbursement percentage across contracts. Key financial KPI for benchmarking reimbursement adequacy and negotiation performance."
    - name: "total_stop_loss_threshold"
      expr: SUM(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Total stop-loss threshold amounts across contracts. Used to assess aggregate financial risk exposure under payer contracts."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold_amount AS DOUBLE))
      comment: "Average stop-loss threshold per contract. Used to benchmark risk protection levels and identify contracts with inadequate stop-loss provisions."
    - name: "value_based_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_arrangement_type != 'no risk' AND risk_arrangement_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with a value-based risk arrangement. Strategic KPI for tracking VBC transformation progress — used in board and executive reporting."
    - name: "quality_bonus_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_bonus_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with quality bonus eligibility. Used to assess quality incentive program penetration across the payer contract portfolio."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN termination_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of contracts expiring within the next 90 days. Operational KPI for contract renewal pipeline management — used to prioritize renegotiation efforts."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_fee_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reimbursement rate KPIs for fee schedule line items, RVU analysis, and contracted rate benchmarking. Used by contracting, finance, and revenue cycle teams to monitor reimbursement adequacy and fee schedule competitiveness."
  source: "`healthcare_ecm`.`insurance`.`fee_schedule_line`"
  dimensions:
    - name: "fee_schedule_line_status"
      expr: fee_schedule_line_status
      comment: "Status of the fee schedule line (active, terminated, superseded) — used to filter active reimbursement rates."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for the reimbursement rate (RVU, per diem, case rate, percent of charges) — used to analyze reimbursement model mix."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type (facility, non-facility) — used to distinguish site-of-service reimbursement differentials."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code — used to analyze reimbursement rates by care setting."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty code — used to benchmark reimbursement rates by clinical specialty."
    - name: "bundled_indicator"
      expr: bundled_indicator
      comment: "Indicates whether the service is part of a bundled payment arrangement — used to analyze bundled vs. unbundled reimbursement."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Indicates whether prior authorization is required for this service — used to assess administrative burden by service type."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the fee schedule line became effective — used for rate trend analysis and annual rate update tracking."
    - name: "quality_reporting_required"
      expr: quality_reporting_required
      comment: "Indicates whether quality reporting is required for this service — used to assess quality program compliance requirements."
  measures:
    - name: "total_fee_schedule_lines"
      expr: COUNT(1)
      comment: "Total number of fee schedule line items. Used to assess fee schedule complexity and coverage breadth."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Average contracted reimbursement rate per fee schedule line. Primary benchmarking KPI for contracting teams — used to assess rate competitiveness and negotiation outcomes."
    - name: "avg_rvu_total"
      expr: AVG(CAST(rvu_total AS DOUBLE))
      comment: "Average total RVU value per fee schedule line. Used to benchmark service complexity and validate RVU-based reimbursement adequacy."
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average physician work RVU per fee schedule line. Used to assess physician effort component of reimbursement and benchmark against Medicare rates."
    - name: "avg_percent_of_medicare"
      expr: AVG(CAST(percent_of_medicare AS DOUBLE))
      comment: "Average contracted rate as a percentage of Medicare. Industry-standard benchmarking KPI for assessing reimbursement adequacy relative to the Medicare fee schedule."
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average RVU conversion factor across fee schedule lines. Used to assess the dollar value applied to RVUs and benchmark against CMS conversion factors."
    - name: "avg_multiple_procedure_reduction"
      expr: AVG(CAST(multiple_procedure_reduction AS DOUBLE))
      comment: "Average multiple procedure reduction percentage. Used to assess the financial impact of multiple procedure payment rules on provider reimbursement."
    - name: "total_contracted_rate_value"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total contracted rate value across all active fee schedule lines. Used to assess aggregate reimbursement commitment and fee schedule financial exposure."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_capitation_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for capitation contract portfolio management, PMPM rates, shared savings/loss parameters, and quality withhold design. Used by VP of Value-Based Care and CFO to monitor VBC contract performance and financial risk."
  source: "`healthcare_ecm`.`insurance`.`capitation_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated, pending) — primary filter for active VBC contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of capitation contract (global capitation, partial capitation, PMPM) — used to analyze VBC model mix."
    - name: "vbc_model"
      expr: vbc_model
      comment: "Value-based care model type (ACO, PCMH, bundled payment, full risk) — used to track VBC transformation strategy."
    - name: "risk_adjustment_methodology"
      expr: risk_adjustment_methodology
      comment: "Risk adjustment methodology applied to the contract — used to assess risk stratification approach across VBC contracts."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency of financial settlement (monthly, quarterly, annual) — used for cash flow planning and reconciliation scheduling."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year of the contract — used for year-over-year VBC performance comparison."
    - name: "pmpm_currency_code"
      expr: pmpm_currency_code
      comment: "Currency of the PMPM rate — used for multi-currency financial consolidation."
    - name: "auto_assignment_eligible"
      expr: auto_assignment_eligible
      comment: "Indicates whether members can be auto-assigned to this contract — used to assess attribution methodology."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the capitation contract became effective — used for contract vintage and renewal analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of capitation contracts. Core portfolio KPI for VBC program scale and coverage."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of currently active capitation contracts. Used by VP of VBC to monitor active risk-bearing relationships."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month capitation rate across contracts. Primary financial benchmarking KPI for VBC contract negotiations and actuarial pricing."
    - name: "total_quality_withhold_amount"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold amounts across capitation contracts. Used to assess aggregate quality incentive financial exposure and provider accountability."
    - name: "avg_quality_withhold_percentage"
      expr: AVG(CAST(quality_withhold_percentage AS DOUBLE))
      comment: "Average quality withhold percentage across contracts. Used to benchmark quality incentive program design and assess provider performance accountability levels."
    - name: "avg_shared_savings_percentage"
      expr: AVG(CAST(shared_savings_percentage AS DOUBLE))
      comment: "Average shared savings percentage across contracts. Used to assess the financial incentive structure for cost reduction in VBC arrangements."
    - name: "avg_shared_loss_percentage"
      expr: AVG(CAST(shared_loss_percentage AS DOUBLE))
      comment: "Average shared loss percentage across contracts. Used to assess downside risk exposure for providers in two-sided VBC arrangements."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold across capitation contracts. Used to assess catastrophic risk protection levels and identify contracts with inadequate stop-loss provisions."
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate required before shared savings are triggered. Used to assess the difficulty of achieving shared savings and benchmark contract design."
$$;