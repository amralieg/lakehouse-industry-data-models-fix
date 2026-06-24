-- Metric views for domain: member | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the subscriber population — risk profile, income distribution, demographic mix, and attrition signals. Used by actuarial, population-health, and executive teams to steer underwriting, care-management investment, and retention programs."
  source: "`vibe_health_insurance_v1`.`member`.`subscriber`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g. Commercial, Medicare, Medicaid) — primary segmentation axis for all subscriber KPIs."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (e.g. Individual, Family, Group) — used to segment premium and risk metrics."
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current lifecycle status of the subscriber (Active, Terminated, Suspended) — essential for active-member filtering."
    - name: "gender"
      expr: gender
      comment: "Subscriber gender — used for demographic equity analysis and actuarial segmentation."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which the subscriber enrolled (e.g. Employer, Exchange, Direct) — informs acquisition cost and retention strategy."
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status of the subscriber — used for care-management program targeting and regulatory reporting."
    - name: "tobacco_use_status"
      expr: tobacco_use_status
      comment: "Tobacco use indicator — used for risk-adjusted premium analysis and wellness program targeting."
    - name: "marital_status"
      expr: marital_status
      comment: "Marital status — used for demographic segmentation and dependent-coverage propensity analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language — used for member-experience and health-equity reporting."
    - name: "race_ethnicity"
      expr: race_ethnicity
      comment: "Race/ethnicity — used for health-equity and HEDIS demographic stratification."
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status flag — used for specialized benefit program targeting and regulatory reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of subscriber effective date — used to track enrollment cohorts and seasonal enrollment trends."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of subscriber termination — used to track attrition cohorts and churn seasonality."
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total unique subscribers — the foundational membership count KPI used in every executive dashboard and regulatory filing."
    - name: "active_subscribers"
      expr: COUNT(DISTINCT CASE WHEN subscriber_status = 'Active' THEN subscriber_id END)
      comment: "Count of subscribers with Active status — the primary operational membership metric driving premium revenue forecasts and care-management capacity planning."
    - name: "terminated_subscribers"
      expr: COUNT(DISTINCT CASE WHEN subscriber_status = 'Terminated' THEN subscriber_id END)
      comment: "Count of terminated subscribers — used to measure voluntary and involuntary attrition; a rising value triggers retention intervention."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category (HCC) risk score across subscribers — the primary actuarial risk indicator used to set capitation rates and identify high-risk cohorts for care management."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor — used by actuarial and finance teams to project risk-adjusted revenue and validate CMS risk-corridor submissions."
    - name: "total_annual_income"
      expr: SUM(CAST(annual_income AS DOUBLE))
      comment: "Sum of reported annual income across subscribers — used for subsidy eligibility analysis, income-based premium tier validation, and Medicaid/CHIP threshold reporting."
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income per subscriber — used to assess affordability, subsidy exposure, and income-stratified health-equity metrics."
    - name: "deceased_subscribers"
      expr: COUNT(DISTINCT CASE WHEN is_deceased = TRUE THEN subscriber_id END)
      comment: "Count of subscribers flagged as deceased — used for mortality tracking, claims fraud detection, and timely disenrollment compliance."
    - name: "cob_indicator_subscribers"
      expr: COUNT(DISTINCT CASE WHEN cob_indicator = TRUE THEN subscriber_id END)
      comment: "Count of subscribers with Coordination of Benefits (COB) flag — used to identify dual-coverage members and manage COB recovery revenue."
    - name: "consent_to_electronic_communication_subscribers"
      expr: COUNT(DISTINCT CASE WHEN consent_to_electronic_communication = TRUE THEN subscriber_id END)
      comment: "Count of subscribers who have consented to electronic communication — used to measure digital engagement readiness and optimize outreach channel mix."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and lifecycle KPIs for member policies — premium revenue, deductible exposure, out-of-pocket limits, and coverage status. Used by finance, actuarial, and product teams to manage premium yield, renewal performance, and coverage risk."
  source: "`vibe_health_insurance_v1`.`member`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current status of the policy (Active, Terminated, Lapsed) — primary filter for in-force book-of-business analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (Individual, Group, Medicare Advantage, etc.) — used to segment premium and financial exposure metrics."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (Medical, Dental, Vision, etc.) — used to analyze premium mix and benefit cost exposure."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status (Active, Suspended, Terminated) — used to filter active coverage for financial reporting."
    - name: "coverage_limit_type"
      expr: coverage_limit_type
      comment: "Type of coverage limit (Annual, Lifetime, etc.) — used to segment exposure and liability analysis."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the policy — used to track renewal pipeline health and forecast premium retention."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for policy termination — used to diagnose involuntary vs. voluntary churn and drive retention strategy."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month coverage began — used to cohort policies by enrollment vintage for retention and loss-ratio analysis."
    - name: "coverage_end_month"
      expr: DATE_TRUNC('MONTH', coverage_end_date)
      comment: "Month coverage ended — used to track policy lapse and termination trends over time."
    - name: "renewal_date_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month of policy renewal — used to forecast renewal premium volume and manage renewal operations capacity."
  measures:
    - name: "total_policies"
      expr: COUNT(DISTINCT policy_id)
      comment: "Total unique policies — the foundational book-of-business count used in executive reporting and regulatory filings."
    - name: "active_policies"
      expr: COUNT(DISTINCT CASE WHEN policy_status = 'Active' THEN policy_id END)
      comment: "Count of active policies — the primary in-force metric driving premium revenue projections and claims liability estimates."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium billed across all policies — the top-line revenue KPI for the insurance book of business, used in every financial review."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy — used to track premium yield trends, benchmark against market rates, and detect under-pricing risk."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across all policies — used by actuarial to model member cost-sharing and claims net-of-deductible liability."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible per policy — used to assess plan design competitiveness and member affordability risk."
    - name: "total_out_of_pocket_max_amount"
      expr: SUM(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Total out-of-pocket maximum exposure across all policies — used to quantify maximum member financial liability and ACA compliance."
    - name: "avg_out_of_pocket_max_amount"
      expr: AVG(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum per policy — used to benchmark plan design against regulatory limits and competitor offerings."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit amount across all policies — used to quantify aggregate liability exposure for reinsurance and capital adequacy analysis."
    - name: "total_renewal_premium_amount"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Total renewal premium across renewing policies — used to forecast forward premium revenue and measure renewal rate adequacy."
    - name: "avg_renewal_premium_amount"
      expr: AVG(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Average renewal premium per policy — used to track premium trend (rate increases) year-over-year and assess renewal pricing strategy."
    - name: "total_renewal_deductible_amount"
      expr: SUM(CAST(renewal_deductible_amount AS DOUBLE))
      comment: "Total renewal deductible exposure — used to assess plan design changes at renewal and their impact on member cost-sharing."
    - name: "terminated_policies"
      expr: COUNT(DISTINCT CASE WHEN policy_status = 'Terminated' THEN policy_id END)
      comment: "Count of terminated policies — used to measure policy lapse rate and trigger retention and win-back programs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility and coverage continuity KPIs — premium revenue, gap-in-coverage rates, retroactive eligibility, and enrollment-type mix. Used by operations, compliance, and actuarial teams to ensure accurate eligibility, minimize coverage gaps, and manage premium liability."
  source: "`vibe_health_insurance_v1`.`member`.`eligibility_span2`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status (Active, Terminated, Pending) — primary filter for active-coverage analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (Medical, Dental, Vision, etc.) — used to segment eligibility and premium metrics by benefit line."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid) — primary business segmentation for eligibility KPIs."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Enrollment type (Open Enrollment, Special Enrollment, Auto-Enroll) — used to analyze enrollment channel mix and compliance."
    - name: "eligibility_source"
      expr: eligibility_source
      comment: "Source system that generated the eligibility record — used for data quality and reconciliation analysis."
    - name: "subscriber_relationship_code"
      expr: subscriber_relationship_code
      comment: "Relationship of the member to the subscriber (Self, Spouse, Child) — used to analyze dependent coverage patterns."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for eligibility termination — used to diagnose involuntary disenrollment and compliance risk."
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Flag indicating whether this is the member's primary coverage — used to identify COB secondary-coverage populations."
    - name: "gap_in_coverage_flag"
      expr: gap_in_coverage_flag
      comment: "Flag indicating a gap in coverage continuity — used to measure coverage disruption rates and ACA continuous-coverage compliance."
    - name: "retroactive_eligibility_flag"
      expr: retroactive_eligibility_flag
      comment: "Flag indicating retroactive eligibility adjustment — used to track retro-enrollment volume and its financial impact on claims liability."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month eligibility became effective — used to track enrollment cohorts and seasonal eligibility trends."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month eligibility was terminated — used to track disenrollment trends and coverage-end seasonality."
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(DISTINCT eligibility_span2_id)
      comment: "Total eligibility spans — the foundational coverage-record count used to measure enrollment volume and validate eligibility file completeness."
    - name: "active_eligibility_spans"
      expr: COUNT(DISTINCT CASE WHEN eligibility_status = 'Active' THEN eligibility_span2_id END)
      comment: "Count of active eligibility spans — the primary in-force membership metric used for capitation payment calculations and regulatory member-month reporting."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium across all eligibility spans — used to reconcile premium billing with enrollment records and detect premium leakage."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per eligibility span — used to track per-member-per-month (PMPM) premium yield and benchmark against plan pricing."
    - name: "primary_coverage_spans"
      expr: COUNT(DISTINCT CASE WHEN is_primary_coverage = TRUE THEN eligibility_span2_id END)
      comment: "Count of eligibility spans designated as primary coverage — used to identify the primary-payer population for COB and claims coordination analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent population KPIs — coverage status, age-out risk, disability, student status, and CHIP/Medicaid eligibility. Used by member services, actuarial, and compliance teams to manage dependent lifecycle events and regulatory eligibility requirements."
  source: "`vibe_health_insurance_v1`.`member`.`dependent`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status of the dependent (Active, Terminated, Pending) — primary filter for active dependent population analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Relationship of the dependent to the subscriber (Spouse, Child, Domestic Partner) — used to analyze dependent mix and benefit utilization patterns."
    - name: "gender"
      expr: gender
      comment: "Dependent gender — used for demographic equity analysis and actuarial risk segmentation."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language of the dependent — used for health-equity and member-experience reporting."
    - name: "age_out_eligibility_flag"
      expr: age_out_eligibility_flag
      comment: "Flag indicating the dependent is approaching or has reached the age-out threshold (typically 26) — used to trigger proactive outreach and transition-to-individual-coverage programs."
    - name: "chip_eligibility_flag"
      expr: chip_eligibility_flag
      comment: "Flag indicating CHIP eligibility — used for CHIP enrollment reporting and state regulatory submissions."
    - name: "medicaid_eligibility_flag"
      expr: medicaid_eligibility_flag
      comment: "Flag indicating Medicaid eligibility — used for dual-eligibility identification and Medicaid managed care reporting."
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status of the dependent — used for care-management program targeting and ADA/regulatory compliance."
    - name: "student_status"
      expr: student_status
      comment: "Student status flag — used to validate extended dependent coverage eligibility under ACA student provisions."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month dependent coverage began — used to track dependent enrollment cohorts and seasonal enrollment patterns."
    - name: "coverage_end_month"
      expr: DATE_TRUNC('MONTH', coverage_end_date)
      comment: "Month dependent coverage ended — used to track dependent attrition and age-out event timing."
  measures:
    - name: "total_dependents"
      expr: COUNT(DISTINCT dependent_id)
      comment: "Total unique dependents — the foundational dependent population count used in member-month calculations, premium rating, and regulatory reporting."
    - name: "active_dependents"
      expr: COUNT(DISTINCT CASE WHEN coverage_status = 'Active' THEN dependent_id END)
      comment: "Count of dependents with active coverage — used to measure the in-force dependent population for premium and claims liability projections."
    - name: "dependents_at_age_out_risk"
      expr: COUNT(DISTINCT CASE WHEN age_out_eligibility_flag = TRUE THEN dependent_id END)
      comment: "Count of dependents flagged for age-out eligibility risk — used to proactively manage coverage transitions and prevent unintended lapses, reducing member disruption and compliance risk."
    - name: "chip_eligible_dependents"
      expr: COUNT(DISTINCT CASE WHEN chip_eligibility_flag = TRUE THEN dependent_id END)
      comment: "Count of CHIP-eligible dependents — used for CHIP enrollment tracking, state reporting, and outreach program targeting."
    - name: "medicaid_eligible_dependents"
      expr: COUNT(DISTINCT CASE WHEN medicaid_eligibility_flag = TRUE THEN dependent_id END)
      comment: "Count of Medicaid-eligible dependents — used for dual-eligibility management, Medicaid managed care reporting, and COB coordination."
    - name: "disabled_dependents"
      expr: COUNT(DISTINCT CASE WHEN disability_status = TRUE THEN dependent_id END)
      comment: "Count of dependents with disability status — used for care-management program targeting, extended eligibility validation, and regulatory compliance reporting."
    - name: "student_dependents"
      expr: COUNT(DISTINCT CASE WHEN student_status = TRUE THEN dependent_id END)
      comment: "Count of dependents with active student status — used to validate ACA extended dependent coverage eligibility and manage student-status verification workflows."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Care Provider (PCP) assignment KPIs — assignment rates, panel status, network tier distribution, and assignment change velocity. Used by network management, care coordination, and quality teams to ensure members have active PCP relationships, a key HEDIS and Stars quality driver."
  source: "`vibe_health_insurance_v1`.`member`.`pcp_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the PCP assignment (Active, Terminated, Pending) — primary filter for active PCP relationship analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of PCP assignment (Member-Selected, Auto-Assigned, Plan-Assigned) — used to analyze assignment method mix and its correlation with member satisfaction and retention."
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason for the PCP assignment — used to understand drivers of assignment events and optimize auto-assignment algorithms."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for PCP change — used to identify dissatisfaction signals and network adequacy gaps driving PCP switches."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of the assigned PCP (Tier 1, Tier 2, Out-of-Network) — used to analyze in-network assignment rates and their impact on cost and quality."
    - name: "panel_status"
      expr: panel_status
      comment: "Panel status of the assigned PCP (Open, Closed, Restricted) — used to identify network capacity constraints and access-to-care risks."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating this is the member's current active PCP assignment — used to filter to the most recent assignment record per member."
    - name: "is_primary"
      expr: is_primary
      comment: "Flag indicating this is the member's primary PCP assignment — used to distinguish primary from secondary care coordinator relationships."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the PCP assignment became effective — used to track assignment volume trends and seasonal PCP change patterns."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month the PCP assignment was terminated — used to track PCP relationship churn and network disruption events."
  measures:
    - name: "total_pcp_assignments"
      expr: COUNT(DISTINCT pcp_assignment_id)
      comment: "Total PCP assignment records — the foundational count for PCP assignment volume tracking and operational workflow monitoring."
    - name: "active_pcp_assignments"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'Active' THEN pcp_assignment_id END)
      comment: "Count of active PCP assignments — the primary metric for PCP assignment rate reporting, a key HEDIS and CMS Stars quality measure driver."
    - name: "pcp_changes"
      expr: COUNT(DISTINCT CASE WHEN change_reason IS NOT NULL THEN pcp_assignment_id END)
      comment: "Count of PCP assignment change events — used to measure PCP churn rate; high values signal member dissatisfaction or network instability requiring intervention."
    - name: "tier1_network_assignments"
      expr: COUNT(DISTINCT CASE WHEN network_tier = 'Tier 1' THEN pcp_assignment_id END)
      comment: "Count of PCP assignments in Tier 1 network — used to measure preferred-network utilization, which directly impacts cost efficiency and quality scores."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cob_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) KPIs — COB order distribution, MSP compliance, subrogation flags, and verification status. Used by COB operations, compliance, and finance teams to maximize COB recovery revenue and ensure Medicare Secondary Payer (MSP) regulatory compliance."
  source: "`vibe_health_insurance_v1`.`member`.`cob_record`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB record (Active, Inactive, Pending Verification) — primary filter for active COB relationship analysis."
    - name: "cob_order"
      expr: cob_order
      comment: "COB order (Primary, Secondary, Tertiary) — used to analyze payer order distribution and identify primary vs. secondary payer populations."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of the other-coverage policy (Commercial, Medicare, Medicaid, etc.) — used to segment COB by other-payer type for recovery strategy."
    - name: "coordination_of_benefits_rule"
      expr: coordination_of_benefits_rule
      comment: "COB rule applied (Standard, Non-Duplication, Maintenance of Benefits) — used to analyze COB methodology mix and its impact on claims payment."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify COB information (EDI, Phone, Web Portal) — used to assess verification efficiency and data quality."
    - name: "is_msp_compliant"
      expr: is_msp_compliant
      comment: "Flag indicating Medicare Secondary Payer compliance — used for CMS MSP regulatory reporting and audit risk management."
    - name: "is_subrogation_flag"
      expr: is_subrogation_flag
      comment: "Flag indicating a subrogation opportunity — used to identify and track subrogation recovery cases."
    - name: "birthday_rule_applicable"
      expr: birthday_rule_applicable
      comment: "Flag indicating the birthday rule applies for dependent COB order determination — used to validate COB order assignments for dependents."
    - name: "cob_verification_date_month"
      expr: DATE_TRUNC('MONTH', cob_verification_date)
      comment: "Month COB was verified — used to track verification recency and identify stale COB records requiring re-verification."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the COB record became effective — used to track COB enrollment trends and seasonal dual-coverage patterns."
  measures:
    - name: "total_cob_records"
      expr: COUNT(DISTINCT cob_record_id)
      comment: "Total COB records — the foundational count for COB population sizing, used to estimate COB recovery revenue potential."
    - name: "active_cob_records"
      expr: COUNT(DISTINCT CASE WHEN cob_status = 'Active' THEN cob_record_id END)
      comment: "Count of active COB records — the primary metric for in-force dual-coverage population, directly tied to COB recovery revenue opportunity."
    - name: "msp_non_compliant_records"
      expr: COUNT(DISTINCT CASE WHEN is_msp_compliant = FALSE THEN cob_record_id END)
      comment: "Count of COB records not in MSP compliance — a critical regulatory risk metric; non-zero values trigger immediate CMS compliance remediation to avoid penalties."
    - name: "subrogation_opportunity_records"
      expr: COUNT(DISTINCT CASE WHEN is_subrogation_flag = TRUE THEN cob_record_id END)
      comment: "Count of COB records with subrogation opportunities — used to size the subrogation recovery pipeline and prioritize recovery operations."
    - name: "secondary_payer_records"
      expr: COUNT(DISTINCT CASE WHEN cob_order = 'Secondary' THEN cob_record_id END)
      comment: "Count of COB records where the plan is secondary payer — used to quantify the population where the plan can recover costs from the primary payer."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_identity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member identity and risk profile KPIs — risk score distribution, eligibility status, demographic completeness, and verification status. Used by population health, actuarial, and compliance teams to manage risk stratification, identity verification, and health-equity reporting."
  source: "`vibe_health_insurance_v1`.`member`.`identity`"
  dimensions:
    - name: "member_status"
      expr: member_status
      comment: "Current member status (Active, Terminated, Suspended) — primary filter for active member population analysis."
    - name: "member_type"
      expr: member_type
      comment: "Type of member (Subscriber, Dependent, Retiree) — used to segment risk and eligibility metrics by member role."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status of the member identity record — used to validate active coverage and detect eligibility discrepancies."
    - name: "lob"
      expr: lob
      comment: "Line of business (Commercial, Medicare, Medicaid) — primary business segmentation for identity-level KPIs."
    - name: "gender"
      expr: gender
      comment: "Member gender — used for demographic equity analysis and actuarial risk segmentation."
    - name: "ethnicity"
      expr: ethnicity
      comment: "Member ethnicity — used for health-equity reporting and HEDIS demographic stratification."
    - name: "race"
      expr: race
      comment: "Member race — used for health-equity reporting and CMS demographic data requirements."
    - name: "marital_status"
      expr: marital_status
      comment: "Member marital status — used for demographic segmentation and dependent-coverage propensity analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language — used for health-equity and member-experience reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Identity verification status — used to track identity verification completion rates and compliance with KYC requirements."
    - name: "relationship_to_subscriber"
      expr: relationship_to_subscriber
      comment: "Relationship of this identity to the subscriber (Self, Spouse, Child) — used to analyze dependent population mix."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month coverage began for this identity — used to track enrollment cohorts and vintage-based risk analysis."
    - name: "enrollment_effective_month"
      expr: DATE_TRUNC('MONTH', enrollment_effective_date)
      comment: "Month enrollment became effective — used to track enrollment processing timeliness and cohort analysis."
  measures:
    - name: "total_member_identities"
      expr: COUNT(DISTINCT identity_id)
      comment: "Total unique member identity records — the foundational member count used in regulatory member-month reporting and population health program sizing."
    - name: "active_member_identities"
      expr: COUNT(DISTINCT CASE WHEN member_status = 'Active' THEN identity_id END)
      comment: "Count of active member identities — the primary active membership metric used in per-member-per-month (PMPM) cost and quality calculations."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across member identities — the primary population-health risk stratification metric used to target care management interventions and validate risk-adjusted revenue."
    - name: "high_risk_members"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 2.0 THEN identity_id END)
      comment: "Count of members with risk score >= 2.0 (high-risk threshold) — used to size the high-risk care management program population and allocate care coordination resources."
    - name: "unverified_identities"
      expr: COUNT(DISTINCT CASE WHEN verification_status != 'Verified' THEN identity_id END)
      comment: "Count of member identities not yet verified — used to track identity verification backlog, a compliance and fraud-prevention KPI requiring operational action when elevated."
    - name: "terminated_member_identities"
      expr: COUNT(DISTINCT CASE WHEN member_status = 'Terminated' THEN identity_id END)
      comment: "Count of terminated member identities — used to measure membership attrition and validate timely disenrollment processing."
$$;