-- Metric views for domain: member | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscriber population metrics tracking enrollment health, risk profile, and demographic composition across the member base. Used by VP of Membership and Chief Actuary to monitor membership trends, risk concentration, and retention."
  source: "`vibe_health_insurance_v1`.`member`.`subscriber`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, etc.) for segmenting membership KPIs by product line."
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current lifecycle status of the subscriber (Active, Terminated, Suspended) for cohort filtering."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (Individual, Family, Employee-Only) for benefit utilization segmentation."
    - name: "gender"
      expr: gender
      comment: "Subscriber gender for demographic equity and actuarial analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which the subscriber enrolled (Exchange, Employer, Direct) for acquisition analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for member communications, used to assess language access compliance."
    - name: "tobacco_use_status"
      expr: tobacco_use_status
      comment: "Tobacco use indicator for wellness program targeting and premium surcharge analysis."
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for special needs population segmentation and care management routing."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of subscriber effective date for cohort enrollment trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of subscriber termination for churn trend analysis."
  measures:
    - name: "total_active_subscribers"
      expr: COUNT(CASE WHEN subscriber_status = 'Active' THEN subscriber_id END)
      comment: "Count of currently active subscribers. Primary membership census KPI used in board reporting and CMS submissions."
    - name: "total_subscribers"
      expr: COUNT(1)
      comment: "Total subscriber count across all statuses. Baseline denominator for rate calculations."
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC risk score across subscribers. Drives risk adjustment revenue projections and actuarial reserve calculations."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor (RAF) across subscribers. Directly impacts CMS risk adjustment payments and revenue forecasting."
    - name: "avg_annual_income"
      expr: AVG(CAST(annual_income AS DOUBLE))
      comment: "Average annual income of subscribers. Used for subsidy eligibility analysis and ACA premium tax credit program management."
    - name: "total_cob_subscribers"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN subscriber_id END)
      comment: "Count of subscribers with coordination of benefits. Informs COB recovery program scope and potential subrogation revenue."
    - name: "deceased_subscriber_count"
      expr: COUNT(CASE WHEN is_deceased = TRUE THEN subscriber_id END)
      comment: "Count of deceased subscribers still in the system. Operational quality metric for timely disenrollment and fraud prevention."
    - name: "veteran_subscriber_count"
      expr: COUNT(CASE WHEN veteran_status = TRUE THEN subscriber_id END)
      comment: "Count of veteran subscribers for VA coordination program eligibility and special population reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility span metrics tracking coverage continuity, premium revenue, retroactive adjustments, and gap-in-coverage rates. Critical for CMS compliance reporting, premium billing reconciliation, and enrollment operations."
  source: "`vibe_health_insurance_v1`.`member`.`member_eligibility_span`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status (Active, Terminated, Pending) for coverage population segmentation."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for eligibility span segmentation across product lines."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (Medical, Dental, Vision) for benefit-level eligibility analysis."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Enrollment type (Open Enrollment, SEP, Auto-Renew) for enrollment channel performance analysis."
    - name: "eligibility_source"
      expr: eligibility_source
      comment: "Source system that generated the eligibility record (EDI 834, Exchange, Manual) for data quality monitoring."
    - name: "subscriber_relationship_code"
      expr: subscriber_relationship_code
      comment: "Relationship of covered member to subscriber (Self, Spouse, Child) for dependent coverage analysis."
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Flag indicating primary vs. secondary coverage for COB and claims adjudication analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of eligibility effective date for enrollment trend and seasonality analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of eligibility termination for churn and disenrollment trend analysis."
    - name: "termination_reason_code"
      expr: termination_reason_code
      comment: "Reason code for eligibility termination for root-cause disenrollment analysis."
  measures:
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total eligibility span records. Baseline enrollment census used in CMS submissions and premium billing."
    - name: "active_eligibility_spans"
      expr: COUNT(CASE WHEN eligibility_status = 'Active' THEN member_eligibility_span_id END)
      comment: "Count of currently active eligibility spans. Primary covered lives metric for financial and regulatory reporting."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium billed across all eligibility spans. Core revenue metric for premium income reporting and actuarial analysis."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per eligibility span. Used for pricing adequacy analysis and rate development benchmarking."
    - name: "gap_in_coverage_count"
      expr: COUNT(CASE WHEN gap_in_coverage_flag = TRUE THEN member_eligibility_span_id END)
      comment: "Count of eligibility spans with a gap in coverage. Regulatory compliance metric for continuity of care and ACA continuous coverage requirements."
    - name: "retroactive_eligibility_count"
      expr: COUNT(CASE WHEN retroactive_eligibility_flag = TRUE THEN member_eligibility_span_id END)
      comment: "Count of retroactive eligibility adjustments. Operational quality metric impacting claims reprocessing volume and premium reconciliation costs."
    - name: "primary_coverage_spans"
      expr: COUNT(CASE WHEN is_primary_coverage = TRUE THEN member_eligibility_span_id END)
      comment: "Count of primary coverage eligibility spans. Used to distinguish primary from secondary covered lives for COB program management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment transaction metrics covering enrollment volume, premium revenue, subsidy utilization, special enrollment activity, and effectuation rates. Used by VP of Enrollment Operations and CFO for ACA compliance, revenue forecasting, and operational throughput monitoring."
  source: "`vibe_health_insurance_v1`.`member`.`member_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Pending) for pipeline and census analysis."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment transaction (New, Renewal, Change, Termination) for operational volume analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment was submitted (Exchange, Broker, Direct, Employer) for acquisition cost analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for enrollment segmentation across product lines."
    - name: "metal_level"
      expr: metal_level
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) for plan selection and actuarial value analysis."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage tier (Individual, Family, Employee+Spouse) for premium and benefit analysis."
    - name: "is_special_enrollment"
      expr: is_special_enrollment
      comment: "Flag for special enrollment period transactions for SEP compliance and volume monitoring."
    - name: "is_cobra"
      expr: is_cobra
      comment: "Flag for COBRA enrollments for COBRA program management and premium tracking."
    - name: "coverage_effective_date_month"
      expr: DATE_TRUNC('MONTH', coverage_effective_date)
      comment: "Month of coverage effective date for enrollment cohort and seasonality analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for annual enrollment cycle analysis and year-over-year comparison."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for regional enrollment and premium analysis."
    - name: "csr_level"
      expr: csr_level
      comment: "Cost-sharing reduction level for ACA subsidy program analysis and CMS reconciliation."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total enrollment transactions. Baseline operational throughput metric for enrollment operations management."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN member_enrollment_id END)
      comment: "Count of currently active enrollments. Primary covered lives census for financial and regulatory reporting."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium across all enrollment records. Core revenue metric for premium income reporting."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per enrollment. Used for pricing adequacy and rate development benchmarking."
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total Advanced Premium Tax Credit (APTC) subsidies applied. Critical ACA financial reconciliation metric for CMS 3R program management."
    - name: "avg_aptc_amount"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC subsidy per enrollment. Used for subsidy adequacy analysis and exchange program evaluation."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount across all enrollments. Tracks government subsidy exposure and ACA financial liability."
    - name: "total_tobacco_surcharge_amount"
      expr: SUM(CAST(tobacco_surcharge_amount AS DOUBLE))
      comment: "Total tobacco surcharge revenue collected. Wellness incentive program revenue and ACA compliance metric."
    - name: "special_enrollment_count"
      expr: COUNT(CASE WHEN is_special_enrollment = TRUE THEN member_enrollment_id END)
      comment: "Count of special enrollment period transactions. SEP compliance monitoring and fraud detection metric."
    - name: "binder_payment_received_count"
      expr: COUNT(CASE WHEN enrollment_binder_payment_received = TRUE THEN member_enrollment_id END)
      comment: "Count of enrollments with binder payment received. Effectuation rate numerator — critical for revenue recognition and membership census accuracy."
    - name: "total_binder_payment_amount"
      expr: SUM(CAST(enrollment_binder_payment_amount AS DOUBLE))
      comment: "Total binder payment amounts collected. First-payment revenue metric for enrollment effectuation financial reporting."
    - name: "retroactive_enrollment_count"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN member_enrollment_id END)
      comment: "Count of retroactive enrollment transactions. Operational quality metric impacting claims reprocessing and premium reconciliation costs."
    - name: "avg_age_rating_factor"
      expr: AVG(CAST(age_rating_factor AS DOUBLE))
      comment: "Average age rating factor across enrollments. Actuarial pricing adequacy metric for ACA community rating compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_dependent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dependent coverage metrics tracking family unit composition, age-out eligibility, disability coverage, and coverage continuity. Used by VP of Membership and Compliance to manage dependent eligibility rules, ACA age-26 compliance, and CHIP coordination."
  source: "`vibe_health_insurance_v1`.`member`.`dependent`"
  dimensions:
    - name: "relationship_type"
      expr: relationship_type
      comment: "Relationship of dependent to subscriber (Spouse, Child, Domestic Partner) for family composition analysis."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current coverage status of the dependent for active covered lives reporting."
    - name: "gender"
      expr: gender
      comment: "Dependent gender for demographic and actuarial analysis."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status for data quality and operational monitoring."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month dependent coverage began for enrollment trend analysis."
    - name: "coverage_end_month"
      expr: DATE_TRUNC('MONTH', coverage_end_date)
      comment: "Month dependent coverage ended for churn and disenrollment analysis."
  measures:
    - name: "total_dependents"
      expr: COUNT(1)
      comment: "Total dependent records. Covered lives denominator for family unit and per-member cost analysis."
    - name: "active_dependents"
      expr: COUNT(CASE WHEN coverage_status = 'Active' THEN dependent_id END)
      comment: "Count of dependents with active coverage. Primary dependent census metric for premium billing and CMS reporting."
    - name: "age_out_eligible_count"
      expr: COUNT(CASE WHEN age_out_eligibility_flag = TRUE THEN dependent_id END)
      comment: "Count of dependents approaching ACA age-26 eligibility limit. Proactive outreach metric for retention and SEP conversion programs."
    - name: "disabled_dependent_count"
      expr: COUNT(CASE WHEN disability_status = TRUE THEN dependent_id END)
      comment: "Count of dependents with disability status. Drives extended coverage eligibility beyond age-26 and special needs care management routing."
    - name: "chip_eligible_dependent_count"
      expr: COUNT(CASE WHEN chip_eligibility_flag = TRUE THEN dependent_id END)
      comment: "Count of CHIP-eligible dependents. State CHIP coordination and Medicaid/CHIP transition program management metric."
    - name: "medicaid_eligible_dependent_count"
      expr: COUNT(CASE WHEN medicaid_eligibility_flag = TRUE THEN dependent_id END)
      comment: "Count of Medicaid-eligible dependents. Dual-eligible coordination and premium tax credit reconciliation metric."
    - name: "student_dependent_count"
      expr: COUNT(CASE WHEN student_status = TRUE THEN dependent_id END)
      comment: "Count of student dependents. Used for student coverage program management and age-26 extension eligibility tracking."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member grievance metrics tracking complaint volume, resolution rates, regulatory reporting obligations, and financial dispute amounts. Used by VP of Member Experience, Chief Compliance Officer, and state/federal regulators for NCQA, CMS, and state DOI compliance."
  source: "`vibe_health_insurance_v1`.`member`.`member_grievance`"
  dimensions:
    - name: "member_grievance_status"
      expr: member_grievance_status
      comment: "Current status of the grievance (Open, Resolved, Escalated, Closed) for pipeline and SLA monitoring."
    - name: "type_code"
      expr: type_code
      comment: "Grievance type code for categorizing complaint nature and regulatory reporting."
    - name: "issue_category_code"
      expr: issue_category_code
      comment: "Issue category for root-cause analysis and operational improvement targeting."
    - name: "resolution_type_code"
      expr: resolution_type_code
      comment: "Resolution outcome type for member satisfaction and regulatory compliance analysis."
    - name: "grievance_source"
      expr: grievance_source
      comment: "Source channel of grievance submission (Phone, Portal, Mail, Regulator) for intake channel analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business associated with the grievance for product-level complaint analysis."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for state-level regulatory reporting and compliance monitoring."
    - name: "cms_reportable_indicator"
      expr: cms_reportable_indicator
      comment: "Flag for CMS-reportable grievances for federal compliance reporting segmentation."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month grievance was received for trend and seasonality analysis."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month grievance was resolved for resolution cycle time trend analysis."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total grievance volume. Primary complaint census metric for regulatory reporting and member experience benchmarking."
    - name: "open_grievances"
      expr: COUNT(CASE WHEN member_grievance_status = 'Open' THEN member_grievance_id END)
      comment: "Count of open/unresolved grievances. Operational backlog metric for staffing and SLA compliance management."
    - name: "cms_reportable_grievances"
      expr: COUNT(CASE WHEN cms_reportable_indicator = TRUE THEN member_grievance_id END)
      comment: "Count of CMS-reportable grievances. Federal compliance metric for CMS Part C/D grievance reporting requirements."
    - name: "regulatory_reporting_grievances"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN member_grievance_id END)
      comment: "Count of grievances requiring regulatory reporting. Compliance exposure metric for state and federal oversight."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount disputed across grievances. Financial exposure metric for claims dispute resolution and member liability management."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per grievance. Used for financial risk assessment and grievance program cost analysis."
    - name: "avg_member_satisfaction_score"
      expr: AVG(CAST(member_satisfaction_score AS DOUBLE))
      comment: "Average member satisfaction score from grievance resolution. CAHPS and NCQA quality metric for member experience program management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cobra_continuant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COBRA continuation coverage metrics tracking election rates, premium collection, coverage exhaustion, and qualifying event patterns. Used by VP of Enrollment Operations and Benefits Administration to manage COBRA compliance, premium revenue, and coverage transition programs."
  source: "`vibe_health_insurance_v1`.`member`.`cobra_continuant`"
  dimensions:
    - name: "cobra_continuant_status"
      expr: cobra_continuant_status
      comment: "Current COBRA status (Elected, Active, Terminated, Exhausted) for COBRA population management."
    - name: "qualifying_event_type"
      expr: qualifying_event_type
      comment: "Type of qualifying event that triggered COBRA eligibility (Termination, Divorce, Death, etc.) for event-based analysis."
    - name: "premium_payment_status"
      expr: premium_payment_status
      comment: "COBRA premium payment status (Current, Delinquent, Lapsed) for collections and coverage termination management."
    - name: "member_relationship"
      expr: member_relationship
      comment: "Relationship of COBRA continuant to former subscriber for family coverage analysis."
    - name: "cobra_eligibility_reason"
      expr: cobra_eligibility_reason
      comment: "Reason for COBRA eligibility for compliance and program analysis."
    - name: "election_month"
      expr: DATE_TRUNC('MONTH', election_date)
      comment: "Month of COBRA election for election rate trend analysis."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month COBRA coverage began for cohort analysis."
  measures:
    - name: "total_cobra_continuants"
      expr: COUNT(1)
      comment: "Total COBRA continuant records. COBRA population census for compliance and premium revenue management."
    - name: "active_cobra_continuants"
      expr: COUNT(CASE WHEN cobra_continuant_status = 'Active' THEN cobra_continuant_id END)
      comment: "Count of currently active COBRA continuants. Active COBRA covered lives for premium billing and claims liability."
    - name: "cobra_elected_count"
      expr: COUNT(CASE WHEN cobra_eligibility_indicator = TRUE THEN cobra_continuant_id END)
      comment: "Count of COBRA-eligible members who elected coverage. COBRA election rate numerator for program uptake analysis."
    - name: "exhausted_cobra_count"
      expr: COUNT(CASE WHEN is_exhausted = TRUE THEN cobra_continuant_id END)
      comment: "Count of COBRA continuants who exhausted maximum coverage. Transition program trigger metric for marketplace enrollment outreach."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total COBRA premium billed. Revenue metric for COBRA program financial management and billing reconciliation."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average COBRA premium per continuant. Pricing adequacy metric for COBRA rate setting and affordability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_pcp_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Care Provider (PCP) assignment metrics tracking assignment rates, panel status, network tier distribution, and assignment change patterns. Used by VP of Network Management and Medical Director to monitor PCP access, panel capacity, and care continuity."
  source: "`vibe_health_insurance_v1`.`member`.`pcp_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current PCP assignment status (Active, Pending, Terminated) for assignment population management."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of PCP assignment (Member-Selected, Auto-Assigned, Plan-Assigned) for assignment method analysis."
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason for PCP assignment for operational and compliance analysis."
    - name: "panel_status"
      expr: panel_status
      comment: "PCP panel status (Open, Closed, Restricted) for network capacity and access analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier of assigned PCP for tiered benefit and cost-sharing analysis."
    - name: "pcp_specialty_code"
      expr: pcp_specialty_code
      comment: "Specialty code of assigned PCP for specialty distribution and access adequacy analysis."
    - name: "is_primary"
      expr: is_primary
      comment: "Flag for primary PCP assignment for deduplication and primary care attribution."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of PCP assignment effective date for assignment trend analysis."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for PCP change for member satisfaction and network stability analysis."
  measures:
    - name: "total_pcp_assignments"
      expr: COUNT(1)
      comment: "Total PCP assignment records. Baseline metric for PCP assignment program scope and coverage."
    - name: "active_pcp_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN pcp_assignment_id END)
      comment: "Count of active PCP assignments. Primary care attribution metric for HEDIS, quality reporting, and care management."
    - name: "auto_assigned_count"
      expr: COUNT(CASE WHEN assignment_type = 'Auto-Assigned' THEN pcp_assignment_id END)
      comment: "Count of auto-assigned PCPs. Operational metric for member engagement — auto-assigned members have lower care utilization and satisfaction."
    - name: "open_panel_assignments"
      expr: COUNT(CASE WHEN panel_status = 'Open' THEN pcp_assignment_id END)
      comment: "Count of assignments to open-panel PCPs. Network access adequacy metric for regulatory compliance and member access reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lob_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line of business assignment metrics tracking risk stratification, dual eligibility, SNP enrollment, and care management eligibility across the member population. Used by Chief Medical Officer and VP of Population Health to drive care management program targeting and risk-based interventions."
  source: "`vibe_health_insurance_v1`.`member`.`lob_assignment`"
  dimensions:
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code (Commercial, Medicare, Medicaid, CHIP) for population segmentation."
    - name: "lob_assignment_status"
      expr: lob_assignment_status
      comment: "Current LOB assignment status for active population filtering."
    - name: "snp_type"
      expr: snp_type
      comment: "Special Needs Plan type (D-SNP, C-SNP, I-SNP) for SNP population management and CMS reporting."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk stratification tier for care management program targeting and resource allocation."
    - name: "cms_region"
      expr: cms_region
      comment: "CMS region for geographic risk and regulatory analysis."
    - name: "state_code"
      expr: state_code
      comment: "State code for state-level population and regulatory analysis."
    - name: "star_rating_cohort"
      expr: star_rating_cohort
      comment: "Star rating cohort assignment for CMS Star Ratings quality program management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of LOB assignment effective date for population trend analysis."
    - name: "segmentation_source"
      expr: segmentation_source
      comment: "Source of segmentation model for data lineage and model performance analysis."
  measures:
    - name: "total_lob_assignments"
      expr: COUNT(1)
      comment: "Total LOB assignment records. Population census baseline for line-of-business reporting."
    - name: "dual_eligible_count"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE THEN lob_assignment_id END)
      comment: "Count of dual-eligible (Medicare + Medicaid) members. Critical population for D-SNP program management, CMS reporting, and care coordination investment."
    - name: "care_management_eligible_count"
      expr: COUNT(CASE WHEN care_management_eligibility_flag = TRUE THEN lob_assignment_id END)
      comment: "Count of members eligible for care management programs. Drives care management program capacity planning and ROI analysis."
    - name: "chronic_condition_count"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN lob_assignment_id END)
      comment: "Count of members with chronic conditions. Disease management program targeting metric and medical cost driver analysis."
    - name: "rising_risk_count"
      expr: COUNT(CASE WHEN rising_risk_indicator = TRUE THEN lob_assignment_id END)
      comment: "Count of rising-risk members. Proactive intervention targeting metric to prevent high-cost utilization escalation."
    - name: "sdoh_risk_count"
      expr: COUNT(CASE WHEN sdoh_risk_flag = TRUE THEN lob_assignment_id END)
      comment: "Count of members with social determinants of health risk flags. SDOH program investment and community health intervention targeting metric."
    - name: "avg_hcc_risk_score_tier"
      expr: AVG(CAST(hcc_risk_score_tier AS DOUBLE))
      comment: "Average HCC risk score tier across LOB assignments. Risk adjustment revenue projection and actuarial reserve metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_disenrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disenrollment metrics tracking termination volume, reasons, financial adjustments, and appeal rights notification compliance. Used by VP of Enrollment Operations and Chief Compliance Officer for churn analysis, regulatory compliance, and premium refund management."
  source: "`vibe_health_insurance_v1`.`member`.`disenrollment`"
  dimensions:
    - name: "disenrollment_status"
      expr: disenrollment_status
      comment: "Current disenrollment processing status for operational pipeline management."
    - name: "reason_code"
      expr: reason_code
      comment: "Disenrollment reason code for root-cause churn analysis and retention program targeting."
    - name: "termination_type"
      expr: termination_type
      comment: "Type of termination (Voluntary, Involuntary, Non-Payment, Death) for churn classification."
    - name: "source"
      expr: source
      comment: "Source system or channel that initiated the disenrollment for data quality and process analysis."
    - name: "appeal_rights_notified"
      expr: appeal_rights_notified
      comment: "Flag indicating whether member was notified of appeal rights. Regulatory compliance metric for CMS and state DOI requirements."
    - name: "eligibility_loss_indicator"
      expr: eligibility_loss_indicator
      comment: "Flag for disenrollments due to eligibility loss for Medicaid/CHIP transition program management."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month disenrollment was requested for churn trend and seasonality analysis."
  measures:
    - name: "total_disenrollments"
      expr: COUNT(1)
      comment: "Total disenrollment transactions. Primary churn volume metric for membership retention and revenue impact analysis."
    - name: "appeal_rights_not_notified_count"
      expr: COUNT(CASE WHEN appeal_rights_notified = FALSE THEN disenrollment_id END)
      comment: "Count of disenrollments where appeal rights notification was not sent. Critical regulatory compliance metric — CMS and state DOI require timely notice."
    - name: "total_refund_gross_amount"
      expr: SUM(CAST(refund_gross_amount AS DOUBLE))
      comment: "Total gross premium refund amount from disenrollments. Financial liability metric for premium reconciliation and cash flow management."
    - name: "total_refund_net_amount"
      expr: SUM(CAST(refund_net_amount AS DOUBLE))
      comment: "Total net premium refund amount after adjustments. Net financial impact metric for disenrollment program cost management."
    - name: "total_refund_adjustment_amount"
      expr: SUM(CAST(refund_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to disenrollment refunds. Retroactive adjustment exposure metric for premium reconciliation."
    - name: "eligibility_loss_disenrollments"
      expr: COUNT(CASE WHEN eligibility_loss_indicator = TRUE THEN disenrollment_id END)
      comment: "Count of disenrollments due to eligibility loss. Medicaid/CHIP churn metric for state program coordination and transition outreach."
    - name: "cobra_eligible_disenrollments"
      expr: COUNT(CASE WHEN cobro_eligibility = TRUE THEN disenrollment_id END)
      comment: "Count of disenrollments where COBRA eligibility applies. COBRA election opportunity pipeline metric for continuation coverage program management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_cob_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) metrics tracking COB population, MSP compliance, verification status, and subrogation flags. Used by VP of Claims and Chief Financial Officer to manage COB recovery revenue, Medicare Secondary Payer compliance, and subrogation program scope."
  source: "`vibe_health_insurance_v1`.`member`.`cob_record`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current COB record status (Active, Inactive, Pending Verification) for COB population management."
    - name: "cob_order"
      expr: cob_order
      comment: "COB order (Primary, Secondary, Tertiary) for claims adjudication sequencing analysis."
    - name: "coordination_of_benefits_rule"
      expr: coordination_of_benefits_rule
      comment: "COB rule applied (Birthday Rule, Non-Duplication, Maintenance of Benefits) for adjudication logic analysis."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of other carrier policy for COB program segmentation."
    - name: "other_carrier_relationship_type"
      expr: other_carrier_relationship_type
      comment: "Relationship type to other carrier for COB coordination analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify COB information for data quality and compliance analysis."
    - name: "cob_verification_date_month"
      expr: DATE_TRUNC('MONTH', cob_verification_date)
      comment: "Month of COB verification for verification currency and staleness analysis."
  measures:
    - name: "total_cob_records"
      expr: COUNT(1)
      comment: "Total COB records. COB program population census for recovery revenue estimation."
    - name: "active_cob_records"
      expr: COUNT(CASE WHEN cob_status = 'Active' THEN cob_record_id END)
      comment: "Count of active COB records. Active COB population for claims adjudication and recovery program management."
    - name: "msp_compliant_count"
      expr: COUNT(CASE WHEN is_msp_compliant = TRUE THEN cob_record_id END)
      comment: "Count of MSP-compliant COB records. Medicare Secondary Payer compliance metric — non-compliance carries significant CMS penalty exposure."
    - name: "msp_non_compliant_count"
      expr: COUNT(CASE WHEN is_msp_compliant = FALSE THEN cob_record_id END)
      comment: "Count of MSP non-compliant COB records. Regulatory risk exposure metric for CMS MSP compliance program management."
    - name: "subrogation_flagged_count"
      expr: COUNT(CASE WHEN is_subrogation_flag = TRUE THEN cob_record_id END)
      comment: "Count of COB records flagged for subrogation. Subrogation recovery program pipeline metric for financial recovery management."
    - name: "birthday_rule_applicable_count"
      expr: COUNT(CASE WHEN birthday_rule_applicable = TRUE THEN cob_record_id END)
      comment: "Count of COB records where birthday rule applies. Dependent COB adjudication complexity metric for claims operations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member consent metrics tracking consent coverage, 42 CFR Part 2 compliance, electronic signature adoption, and consent expiration. Used by Chief Privacy Officer and Chief Compliance Officer for HIPAA compliance, substance use disorder privacy (42 CFR Part 2), and member rights management."
  source: "`vibe_health_insurance_v1`.`member`.`consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (Active, Revoked, Expired) for consent population management."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (Treatment, Marketing, Research, Disclosure) for consent program segmentation."
    - name: "collection_method"
      expr: collection_method
      comment: "Method of consent collection (Electronic, Paper, Verbal) for process and compliance analysis."
    - name: "language"
      expr: language
      comment: "Language of consent document for language access compliance analysis."
    - name: "state_of_residence"
      expr: state_of_residence
      comment: "State of residence for state-specific consent law compliance analysis."
    - name: "is_42cfr_part2_applicable"
      expr: is_42cfr_part2_applicable
      comment: "Flag for 42 CFR Part 2 substance use disorder consent applicability for heightened privacy compliance monitoring."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained for consent program trend analysis."
  measures:
    - name: "total_consents"
      expr: COUNT(1)
      comment: "Total consent records. Consent program coverage baseline for HIPAA and state privacy compliance."
    - name: "active_consents"
      expr: COUNT(CASE WHEN consent_status = 'Active' THEN consent_id END)
      comment: "Count of active, non-revoked consents. Active consent coverage metric for treatment authorization and disclosure compliance."
    - name: "revoked_consents"
      expr: COUNT(CASE WHEN consent_status = 'Revoked' THEN consent_id END)
      comment: "Count of revoked consents. Member rights exercise metric and trigger for downstream disclosure restriction enforcement."
    - name: "cfr_part2_consents"
      expr: COUNT(CASE WHEN is_42cfr_part2_applicable = TRUE THEN consent_id END)
      comment: "Count of 42 CFR Part 2 substance use disorder consents. Heightened privacy compliance metric — violations carry significant federal penalty exposure."
    - name: "electronic_signature_consents"
      expr: COUNT(CASE WHEN is_electronic_signature = TRUE THEN consent_id END)
      comment: "Count of consents obtained via electronic signature. Digital transformation metric for consent process modernization and cost reduction."
    - name: "minimum_necessary_consents"
      expr: COUNT(CASE WHEN is_minimum_necessary = TRUE THEN consent_id END)
      comment: "Count of consents applying minimum necessary standard. HIPAA minimum necessary compliance metric for privacy program quality."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member segmentation metrics tracking risk stratification, chronic condition prevalence, dual eligibility, and SDOH risk distribution across the member population. Used by Chief Medical Officer and VP of Population Health for care management program targeting, risk-based contracting, and Star Ratings improvement."
  source: "`vibe_health_insurance_v1`.`member`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current segment status for active population filtering."
    - name: "segment_category"
      expr: segment_category
      comment: "High-level segment category for population grouping and program routing."
    - name: "segment_name"
      expr: segment_name
      comment: "Segment name for population cohort identification and care management program assignment."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk stratification tier for care management intensity and resource allocation."
    - name: "chronic_condition_code"
      expr: chronic_condition_code
      comment: "Chronic condition code for disease management program targeting."
    - name: "dual_eligible"
      expr: dual_eligible
      comment: "Dual eligibility flag for Medicare-Medicaid coordination program segmentation."
    - name: "snp_eligibility"
      expr: snp_eligibility
      comment: "SNP eligibility flag for Special Needs Plan enrollment targeting."
    - name: "star_rating_cohort"
      expr: star_rating_cohort
      comment: "Star rating cohort for CMS Star Ratings quality program management."
    - name: "segmentation_source"
      expr: segmentation_source
      comment: "Source of segmentation model for model performance and data lineage analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of segment effective date for population trend analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total segment assignment records. Population segmentation coverage baseline."
    - name: "current_segments"
      expr: COUNT(CASE WHEN is_current = TRUE THEN segment_id END)
      comment: "Count of current active segment assignments. Active segmented population for care management program targeting."
    - name: "chronic_condition_members"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN segment_id END)
      comment: "Count of members with chronic conditions. Disease management program scope metric and medical cost driver analysis."
    - name: "dual_eligible_members"
      expr: COUNT(CASE WHEN dual_eligible = TRUE THEN segment_id END)
      comment: "Count of dual-eligible members in segmentation. D-SNP and integrated care program targeting metric."
    - name: "snp_eligible_members"
      expr: COUNT(CASE WHEN snp_eligibility = TRUE THEN segment_id END)
      comment: "Count of SNP-eligible members. Special Needs Plan enrollment opportunity and CMS compliance metric."
    - name: "avg_sdoh_risk_score"
      expr: AVG(CAST(sdoh_risk_score AS DOUBLE))
      comment: "Average SDOH risk score across segments. Social determinants of health program investment prioritization metric."
    - name: "avg_hcc_risk_score_tier"
      expr: AVG(CAST(hcc_risk_score_tier AS DOUBLE))
      comment: "Average HCC risk score tier across segments. Risk adjustment revenue projection and actuarial reserve metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level metrics tracking family unit composition, income, subsidy eligibility, FPL distribution, and Medicaid eligibility. Used by VP of Enrollment Operations and Chief Actuary for ACA subsidy program management, APTC reconciliation, and household-level risk analysis."
  source: "`vibe_health_insurance_v1`.`member`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current household status for active population filtering."
    - name: "household_type"
      expr: household_type
      comment: "Household type (Individual, Family, Multi-Plan) for benefit and subsidy analysis."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status of the household for coverage census analysis."
    - name: "state"
      expr: state
      comment: "State of household for geographic and regulatory analysis."
    - name: "fpl_year"
      expr: fpl_year
      comment: "Federal Poverty Level year for subsidy eligibility cohort analysis."
    - name: "medicaid_eligible"
      expr: medicaid_eligible
      comment: "Medicaid eligibility flag for Medicaid/marketplace transition program management."
    - name: "income_verification_flag"
      expr: income_verification_flag
      comment: "Income verification status for ACA subsidy compliance and audit risk management."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month household coverage began for enrollment trend analysis."
  measures:
    - name: "total_households"
      expr: COUNT(1)
      comment: "Total household records. Household census baseline for ACA subsidy program management."
    - name: "active_households"
      expr: COUNT(CASE WHEN household_status = 'Active' THEN household_id END)
      comment: "Count of active households. Active covered household census for premium billing and subsidy reconciliation."
    - name: "medicaid_eligible_households"
      expr: COUNT(CASE WHEN medicaid_eligible = TRUE THEN household_id END)
      comment: "Count of Medicaid-eligible households. Medicaid/marketplace transition program scope and APTC reconciliation metric."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amount across households. ACA subsidy program financial exposure metric for CMS reconciliation."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total premium tax credit amount across households. APTC financial liability metric for IRS and CMS reconciliation."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage across households. Subsidy eligibility distribution metric for program adequacy analysis."
    - name: "avg_total_income"
      expr: AVG(CAST(total_income AS DOUBLE))
      comment: "Average household total income. Income distribution metric for subsidy program design and affordability analysis."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average household risk score. Household-level risk concentration metric for actuarial and underwriting analysis."
    - name: "income_not_verified_count"
      expr: COUNT(CASE WHEN income_verification_flag = FALSE THEN household_id END)
      comment: "Count of households with unverified income. ACA subsidy audit risk metric — unverified income creates APTC reconciliation liability."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member policy metrics tracking coverage amounts, premium revenue, deductible levels, out-of-pocket maximums, and renewal activity. Used by Chief Actuary and VP of Product Management for benefit design analysis, pricing adequacy, and renewal program management."
  source: "`vibe_health_insurance_v1`.`member`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current policy status (Active, Terminated, Lapsed, Renewed) for policy population management."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (Individual, Group, Medicare Supplement) for product line analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (Medical, Dental, Vision, Pharmacy) for benefit-level analysis."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status for active covered lives filtering."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status for renewal program management and retention analysis."
    - name: "coverage_limit_type"
      expr: coverage_limit_type
      comment: "Type of coverage limit for benefit design and actuarial analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month policy became effective for enrollment cohort analysis."
    - name: "renewal_date_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month of policy renewal for renewal cycle and retention analysis."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total policy records. Policy census baseline for product portfolio management."
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status = 'Active' THEN policy_id END)
      comment: "Count of active policies. Active policy census for premium revenue and claims liability management."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium across all policies. Core premium revenue metric for financial reporting and pricing adequacy analysis."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy. Pricing adequacy and rate development benchmarking metric."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across policies. Benefit design adequacy metric for member cost-sharing analysis."
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum across policies. ACA OOP maximum compliance and member financial protection metric."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit amount across policies. Aggregate benefit liability metric for actuarial reserve calculations."
    - name: "total_renewal_premium_amount"
      expr: SUM(CAST(renewal_premium_amount AS DOUBLE))
      comment: "Total renewal premium amount. Forward-looking premium revenue metric for renewal cycle financial planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`member_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member lifecycle event metrics tracking qualifying life events, disenrollment triggers, Medicare entitlement, and special enrollment period activity. Used by VP of Enrollment Operations and Chief Compliance Officer for SEP compliance, CMS reporting, and member transition management."
  source: "`vibe_health_insurance_v1`.`member`.`member_lifecycle_event`"
  dimensions:
    - name: "event_type_code"
      expr: event_type_code
      comment: "Type of lifecycle event (Birth, Marriage, Divorce, Job Loss, Medicare Entitlement) for event-based analysis."
    - name: "event_reason_code"
      expr: event_reason_code
      comment: "Reason code for the lifecycle event for detailed root-cause analysis."
    - name: "member_lifecycle_event_status"
      expr: member_lifecycle_event_status
      comment: "Current processing status of the lifecycle event for operational pipeline management."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the lifecycle event for SEP fraud detection and compliance."
    - name: "disenrollment_source"
      expr: disenrollment_source
      comment: "Source of disenrollment trigger for channel and process analysis."
    - name: "relocation_state_code"
      expr: relocation_state_code
      comment: "State code for relocation events for geographic migration and network adequacy analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of lifecycle event for trend and seasonality analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month lifecycle event became effective for enrollment impact analysis."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total lifecycle event records. Event volume baseline for enrollment operations capacity planning."
    - name: "qualified_life_events"
      expr: COUNT(CASE WHEN qualified_life_event_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of qualifying life events. SEP eligibility trigger metric for enrollment operations and ACA compliance."
    - name: "cobra_qualifying_events"
      expr: COUNT(CASE WHEN cobra_qualifying_event_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of COBRA-qualifying lifecycle events. COBRA election opportunity pipeline metric for continuation coverage program management."
    - name: "medicare_entitlement_events"
      expr: COUNT(CASE WHEN medicare_entitlement_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of Medicare entitlement events. Medicare transition program trigger metric for COB setup and disenrollment processing."
    - name: "special_enrollment_period_events"
      expr: COUNT(CASE WHEN special_enrollment_period_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of events triggering special enrollment periods. SEP volume metric for enrollment operations staffing and compliance monitoring."
    - name: "medicaid_eligibility_gain_events"
      expr: COUNT(CASE WHEN medicaid_eligibility_gain_flag = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of Medicaid eligibility gain events. Medicaid transition program metric for marketplace-to-Medicaid handoff management."
    - name: "documentation_not_received_count"
      expr: COUNT(CASE WHEN documentation_received_flag = FALSE THEN member_lifecycle_event_id END)
      comment: "Count of lifecycle events with missing documentation. SEP verification compliance metric — undocumented SEPs create CMS audit risk."
    - name: "cms_reportable_events"
      expr: COUNT(CASE WHEN cms_reporting_indicator = TRUE THEN member_lifecycle_event_id END)
      comment: "Count of CMS-reportable lifecycle events. Federal compliance metric for CMS enrollment reporting requirements."
$$;