-- Metric views for domain: volunteer | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core volunteer roster KPIs tracking workforce size, availability, engagement depth, and retention signals. Used by Volunteer Managers and Program Directors to steer recruitment, retention, and capacity planning. Aligns with UN-agency volunteer management systems (UNV Online, SAP HR) and INGO platforms (Salesforce NPSP, Better Impact)."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Classifies volunteers by type (e.g., community, international, national, UN Volunteer) for segmented workforce analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the volunteer (active, on-leave, unavailable) for capacity planning."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding pipeline stage to track conversion from registered to fully onboarded volunteers."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Safeguarding compliance dimension — volunteers with cleared vs. pending background checks."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for diversity and inclusion reporting required by most institutional donors (USAID, ECHO, UN agencies)."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of volunteer for international deployment eligibility and diversity tracking."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language spoken — critical for matching volunteers to field contexts and community engagement."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Current recognition tier of the volunteer, used to assess retention program effectiveness."
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Boolean flag indicating travel willingness — key filter for emergency deployment pool sizing."
  measures:
    - name: "total_active_volunteers"
      expr: COUNT(DISTINCT CASE WHEN availability_status = 'active' THEN volunteer_id END)
      comment: "Count of currently active volunteers. Core workforce capacity KPI used in operational planning and donor reporting."
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total registered volunteer roster size. Baseline headcount for capacity and growth tracking."
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly hours volunteers are available. Drives capacity planning for program delivery and field deployments."
    - name: "total_cumulative_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Sum of all lifetime volunteer hours across the roster. Key in-kind contribution metric for donor reporting and program impact measurement."
    - name: "avg_lifetime_volunteer_hours"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average lifetime hours per volunteer. Indicates volunteer engagement depth and retention quality."
    - name: "onboarding_completion_rate"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN volunteer_id END)
      comment: "Count of volunteers who completed onboarding. Numerator for onboarding funnel conversion rate — divide by total_volunteers in BI layer."
    - name: "background_check_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'cleared' THEN volunteer_id END)
      comment: "Volunteers with cleared background checks. Critical safeguarding compliance KPI — uncleared volunteers cannot be deployed per CHS standards."
    - name: "travel_eligible_volunteer_count"
      expr: COUNT(DISTINCT CASE WHEN willing_to_travel = TRUE THEN volunteer_id END)
      comment: "Volunteers willing to travel — defines the emergency deployment pool size for surge response planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deployment lifecycle KPIs measuring volunteer utilization, hours delivery, and deployment efficiency. Used by Field Directors and Program Managers to assess operational capacity and in-kind contribution value. Relevant to SAP VISION cost tracking and eTools programme management."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (active, completed, withdrawn, cancelled) for pipeline analysis."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (field, remote, emergency, regular) for operational segmentation."
    - name: "region"
      expr: region
      comment: "Geographic region of deployment for geographic distribution analysis and resource allocation."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Distinguishes remote vs. in-person deployments — important for cost modeling and post-COVID operational planning."
    - name: "priority"
      expr: priority
      comment: "Deployment priority level (high, medium, low) for resource allocation and emergency response triage."
    - name: "recognition_awarded_flag"
      expr: recognition_awarded_flag
      comment: "Whether recognition was awarded for this deployment — used to assess recognition program coverage."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required/held for the deployment — critical for high-risk context deployments."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of volunteer deployments. Baseline operational throughput metric for program delivery capacity."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned volunteer hours across all deployments. Used for capacity planning and donor commitment reporting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours delivered by volunteers. Core in-kind contribution metric for grant reporting and program impact."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total hours contributed field — may differ from actual_hours when partial contributions are recorded. Used for reconciliation."
    - name: "avg_fte_equivalent"
      expr: AVG(CAST(fte_equivalent AS DOUBLE))
      comment: "Average FTE equivalent per deployment. Translates volunteer effort into staff-equivalent capacity for budget and planning purposes."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent across all deployments. Quantifies volunteer workforce in staff-equivalent terms for executive reporting."
    - name: "hours_delivery_rate"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Actual hours delivered — use with total_planned_hours in BI to compute delivery rate (actual/planned). Measures deployment execution quality."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average volunteer performance rating across deployments. Drives recognition, redeployment decisions, and quality assurance."
    - name: "withdrawal_count"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'withdrawn' THEN volunteer_deployment_id END)
      comment: "Number of deployments ending in withdrawal. High withdrawal rates signal retention, safety, or matching problems requiring intervention."
    - name: "active_deployment_count"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'active' THEN volunteer_deployment_id END)
      comment: "Currently active deployments. Real-time operational capacity indicator for field management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular volunteer hour tracking KPIs for in-kind valuation, grant compliance, and operational throughput. Hour logs are the primary source for in-kind contribution calculations required by USAID, ECHO, and UN agency grant reporting. Integrates with SAP cost centers and finance fund tracking."
  source: "`vibe_ngo_v1`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of activity performed (distribution, health outreach, WASH, training, etc.) for programmatic analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hour log (pending, approved, rejected) for compliance and payroll-equivalent processing."
    - name: "submission_method"
      expr: submission_method
      comment: "How hours were submitted (mobile, web, paper) for data quality and digital adoption tracking."
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Whether the activity was group-based — affects beneficiary reach calculations and efficiency metrics."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Virtual vs. in-person activity flag for remote engagement analysis and cost modeling."
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Whether this hour log is eligible for donor reporting — critical filter for grant compliance reporting."
    - name: "log_date"
      expr: DATE_TRUNC('month', log_date)
      comment: "Month of hour log for time-series trend analysis of volunteer effort."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify hours (supervisor sign-off, GPS, digital check-in) for data quality assessment."
  measures:
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours claimed. Primary in-kind contribution volume metric for program and grant reporting."
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total verified volunteer hours. Verified hours are the auditable basis for in-kind cost-share calculations required by institutional donors."
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total monetary value of in-kind volunteer contributions. Critical for cost-share compliance with USAID, EU, and UN agency grants."
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate applied to volunteer hours. Used to validate rate consistency and compliance with donor-approved FMV schedules."
    - name: "hours_verification_gap"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Claimed hours — use with total_hours_verified in BI to compute verification gap. Unverified hours cannot be counted toward cost-share, creating compliance risk."
    - name: "approved_hour_log_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'approved' THEN hour_log_id END)
      comment: "Count of approved hour logs. Measures throughput of the approval pipeline and identifies bottlenecks."
    - name: "donor_reportable_hours"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN hours_verified ELSE 0 END)
      comment: "Verified hours eligible for donor reporting. The definitive figure for grant cost-share and in-kind contribution schedules."
    - name: "donor_reportable_in_kind_value"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN in_kind_value ELSE 0 END)
      comment: "In-kind value of donor-reportable hours. Direct input to grant financial reports and cost-share compliance documentation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recruitment pipeline KPIs tracking application volume, conversion rates, screening outcomes, and onboarding efficiency. Used by Volunteer Coordinators and HR to optimize recruitment channels and reduce time-to-deployment. Aligns with Salesforce NPSP recruitment tracking and UN Volunteer recruitment portals."
  source: "`vibe_ngo_v1`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current stage of the application (submitted, screening, interview, approved, rejected, withdrawn) for funnel analysis."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel through which the applicant was recruited (social media, referral, partner, event) for channel effectiveness analysis."
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision outcome (approved, rejected, waitlisted) for conversion rate calculation."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status for safeguarding compliance pipeline monitoring."
    - name: "screening_status"
      expr: screening_status
      comment: "Screening stage status for pipeline bottleneck identification."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding completion status to track post-approval conversion to active volunteer."
    - name: "application_date"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application for recruitment volume trend analysis."
    - name: "code_of_conduct_signed"
      expr: code_of_conduct_signed
      comment: "Whether code of conduct was signed — mandatory safeguarding compliance checkpoint."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total applications received. Baseline recruitment pipeline volume metric."
    - name: "approved_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'approved' THEN application_id END)
      comment: "Applications resulting in approval. Numerator for overall recruitment conversion rate."
    - name: "rejected_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'rejected' THEN application_id END)
      comment: "Rejected applications. High rejection rates may indicate poor channel targeting or misaligned role descriptions."
    - name: "background_check_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'cleared' THEN application_id END)
      comment: "Applications with cleared background checks. Safeguarding compliance throughput metric — uncleared applicants cannot be deployed."
    - name: "onboarding_completed_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'completed' THEN application_id END)
      comment: "Applications that progressed to completed onboarding. Final conversion stage metric — measures end-to-end recruitment effectiveness."
    - name: "avg_hours_per_week_committed"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours committed by applicants. Used to assess whether incoming volunteers meet program capacity requirements."
    - name: "safeguarding_acknowledged_count"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_acknowledged = TRUE THEN application_id END)
      comment: "Applications with safeguarding policy acknowledged. Mandatory compliance checkpoint — 100% acknowledgment required before deployment."
    - name: "code_of_conduct_signed_count"
      expr: COUNT(DISTINCT CASE WHEN code_of_conduct_signed = TRUE THEN application_id END)
      comment: "Applications with signed code of conduct. CHS Standard 1 compliance requirement — all volunteers must sign before engagement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer training pipeline KPIs measuring completion rates, assessment performance, compliance training coverage, and certification issuance. Used by Learning & Development and Compliance teams to ensure volunteers meet mandatory training requirements. Aligns with DHIS2 training tracking and LMS platforms used by UN agencies."
  source: "`vibe_ngo_v1`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (enrolled, in-progress, completed, withdrawn, failed) for training pipeline analysis."
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Delivery modality (in-person, e-learning, blended, on-the-job) for modality effectiveness comparison."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether the training is mandatory — mandatory training completion is a compliance KPI tracked by donors and auditors."
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Compliance category (safeguarding, PSEA, data protection, security) for regulatory compliance tracking."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether a certificate was issued upon completion — tracks credentialing pipeline."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Whether recertification is required — identifies upcoming compliance renewal obligations."
    - name: "enrollment_date"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for training volume trend analysis."
    - name: "training_language"
      expr: training_language
      comment: "Language of training delivery — important for accessibility and localization planning in multilingual field contexts."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total training enrollments. Baseline training pipeline volume metric."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'completed' THEN training_enrollment_id END)
      comment: "Completed training enrollments. Numerator for training completion rate — critical compliance KPI for CHS and donor audits."
    - name: "mandatory_training_completions"
      expr: COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE AND enrollment_status = 'completed' THEN training_enrollment_id END)
      comment: "Mandatory training completions. Compliance KPI — 100% mandatory training completion is required before volunteer deployment per CHS Standard 7."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across enrollments. Measures training effectiveness and knowledge retention."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered to volunteers. Capacity building investment metric for donor reporting and program quality."
    - name: "total_enrollment_cost"
      expr: SUM(CAST(enrollment_cost AS DOUBLE))
      comment: "Total cost of training enrollments. Used for budget tracking and cost-per-trained-volunteer calculations."
    - name: "avg_enrollment_cost"
      expr: AVG(CAST(enrollment_cost AS DOUBLE))
      comment: "Average cost per training enrollment. Efficiency metric for training budget optimization."
    - name: "certificates_issued_count"
      expr: COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of certificates issued. Tracks credentialing pipeline output and compliance certification coverage."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned. Relevant for professional development tracking and accreditation compliance."
    - name: "withdrawal_count"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'withdrawn' THEN training_enrollment_id END)
      comment: "Training withdrawals. High withdrawal rates signal scheduling, accessibility, or relevance issues requiring program adjustment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_stipend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer stipend financial KPIs tracking disbursement volumes, compliance status, tax reporting obligations, and donor-reportable expenditures. Used by Finance and Compliance teams for grant financial reporting, tax compliance, and budget management. Aligns with SAP S/4HANA (VISION) payment processing and USAID cost-share requirements."
  source: "`vibe_ngo_v1`.`volunteer`.`stipend`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Stipend approval status (pending, approved, rejected) for payment pipeline management."
    - name: "stipend_type"
      expr: stipend_type
      comment: "Type of stipend (transport, subsistence, hazard, in-kind) for expenditure categorization and donor reporting."
    - name: "payment_method"
      expr: CAST(payment_method AS STRING)
      comment: "Payment method (bank transfer, mobile money, cash) for financial inclusion and operational risk analysis."
    - name: "tax_reportable_flag"
      expr: tax_reportable_flag
      comment: "Whether the stipend is tax-reportable — drives IRS Form 1099/local tax compliance obligations."
    - name: "donor_reportable_flag"
      expr: donor_reportable_flag
      comment: "Whether the stipend is reportable to donors — critical for grant financial reporting accuracy."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance check status for sanctions screening and donor condition compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the stipend for annual budget and grant period reporting."
    - name: "payment_period_start_date"
      expr: DATE_TRUNC('month', payment_period_start_date)
      comment: "Month of payment period start for time-series expenditure analysis."
  measures:
    - name: "total_stipend_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total stipend amount disbursed. Primary financial KPI for volunteer support cost tracking and grant budget management."
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total stipend value in reporting currency. Used for consolidated financial reporting and donor financial statements."
    - name: "avg_stipend_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average stipend amount per payment. Benchmarks stipend adequacy against living wage standards and donor guidelines."
    - name: "total_stipends_disbursed"
      expr: COUNT(1)
      comment: "Total stipend records. Volume metric for payment processing throughput and volunteer support coverage."
    - name: "approved_stipend_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'approved' THEN stipend_id END)
      comment: "Approved stipend payments. Measures approval pipeline throughput — delays impact volunteer welfare and retention."
    - name: "donor_reportable_stipend_amount"
      expr: SUM(CASE WHEN donor_reportable_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total donor-reportable stipend expenditure. Direct input to grant financial reports and budget vs. actual analysis."
    - name: "tax_reportable_stipend_amount"
      expr: SUM(CASE WHEN tax_reportable_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total tax-reportable stipend amount. Drives tax compliance obligations and IRS/local authority reporting."
    - name: "compliance_cleared_stipend_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_check_status = 'cleared' THEN stipend_id END)
      comment: "Stipends that passed compliance checks. Measures sanctions screening and donor condition compliance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer certification portfolio KPIs tracking credential coverage, expiry risk, compliance status, and organizational investment in volunteer professional development. Used by Volunteer Managers and Compliance teams to ensure deployment eligibility and manage certification renewal pipelines."
  source: "`vibe_ngo_v1`.`volunteer`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (first aid, safeguarding, technical, language) for coverage analysis by category."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status (verified, pending, expired, rejected) for compliance pipeline monitoring."
    - name: "deployment_eligible"
      expr: deployment_eligible
      comment: "Whether the certification makes the volunteer deployment-eligible — key operational readiness flag."
    - name: "mandatory_for_role"
      expr: mandatory_for_role
      comment: "Whether the certification is mandatory for the assigned role — compliance gap identification."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether renewal is required — drives proactive renewal pipeline management."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category of the certification for workforce capability mapping."
    - name: "reimbursed_by_organization"
      expr: reimbursed_by_organization
      comment: "Whether the organization reimbursed the certification cost — tracks investment in volunteer development."
    - name: "issue_date"
      expr: DATE_TRUNC('year', issue_date)
      comment: "Year of certification issuance for cohort analysis of credential acquisition trends."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certifications on record. Baseline credential portfolio size metric."
    - name: "verified_certifications"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'verified' THEN certification_id END)
      comment: "Verified certifications. Only verified credentials count toward deployment eligibility and compliance reporting."
    - name: "deployment_eligible_certifications"
      expr: COUNT(DISTINCT CASE WHEN deployment_eligible = TRUE THEN certification_id END)
      comment: "Certifications that confer deployment eligibility. Directly measures operational readiness of the volunteer workforce."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score for certifications. Measures quality of certification attainment across the volunteer workforce."
    - name: "total_training_hours_for_certifications"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested in achieving certifications. Quantifies organizational investment in volunteer capability building."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications. Tracks organizational investment in volunteer professional development."
    - name: "avg_continuing_education_hours"
      expr: AVG(CAST(continuing_education_hours AS DOUBLE))
      comment: "Average continuing education hours per certification. Measures ongoing professional development investment per credential."
    - name: "mandatory_role_certifications_count"
      expr: COUNT(DISTINCT CASE WHEN mandatory_for_role = TRUE THEN certification_id END)
      comment: "Mandatory role certifications on record. Compliance baseline — all mandatory certifications must be verified before deployment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer and beneficiary feedback KPIs measuring satisfaction, safety perception, supervision quality, and program improvement signals. Used by Program Quality and Accountability teams for CHS accountability compliance, MEAL reporting, and continuous improvement. Aligns with Kobo Toolbox and DHIS2 feedback collection systems."
  source: "`vibe_ngo_v1`.`volunteer`.`feedback`"
  dimensions:
    - name: "feedback_type"
      expr: CAST(feedback_type AS STRING)
      comment: "Type of feedback (satisfaction, complaint, suggestion, compliment) for categorized analysis."
    - name: "channel"
      expr: channel
      comment: "Feedback submission channel (hotline, in-person, digital, community meeting) for accessibility analysis."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether the feedback requires escalation — high escalation rates signal systemic quality or safety issues."
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether the feedback is sensitive (e.g., protection concern, PSEA) — requires confidential handling and escalation protocols."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up action on feedback — measures accountability loop closure rate."
    - name: "would_volunteer_again"
      expr: would_volunteer_again
      comment: "Volunteer retention signal — whether the volunteer would volunteer again. Key retention and satisfaction indicator."
    - name: "submission_date"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of feedback submission for trend analysis of satisfaction and complaint volumes."
    - name: "language_code"
      expr: language_code
      comment: "Language of feedback submission for accessibility and localization analysis."
  measures:
    - name: "total_feedback_submissions"
      expr: COUNT(1)
      comment: "Total feedback submissions received. Baseline accountability mechanism volume metric — low volumes may indicate access barriers."
    - name: "escalation_required_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN feedback_id END)
      comment: "Feedback items requiring escalation. High counts signal systemic quality, safety, or protection issues requiring leadership action."
    - name: "sensitive_feedback_count"
      expr: COUNT(DISTINCT CASE WHEN is_sensitive = TRUE THEN feedback_id END)
      comment: "Sensitive feedback items (protection, PSEA, safety). Requires confidential handling — volume tracked for safeguarding compliance."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across feedback submissions. Aggregate satisfaction signal for program quality monitoring."
    - name: "would_volunteer_again_count"
      expr: COUNT(DISTINCT CASE WHEN would_volunteer_again = TRUE THEN feedback_id END)
      comment: "Feedback where volunteer indicated they would volunteer again. Retention intent metric — use with total_feedback_submissions for retention rate."
    - name: "follow_up_completed_count"
      expr: COUNT(DISTINCT CASE WHEN follow_up_status = 'completed' THEN feedback_id END)
      comment: "Feedback items with completed follow-up. Measures accountability loop closure — CHS Standard 4 requires timely response to all feedback."
    - name: "anonymous_feedback_count"
      expr: COUNT(DISTINCT CASE WHEN is_anonymous = TRUE THEN feedback_id END)
      comment: "Anonymous feedback submissions. High anonymous rates may indicate fear of retaliation — important safeguarding and accountability signal."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_incident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer incident KPIs tracking safety events, severity distribution, investigation outcomes, and resolution timeliness. Used by Safety, Safeguarding, and Risk Management teams to monitor volunteer welfare, comply with donor incident reporting requirements, and drive corrective action. Critical for CHS compliance and duty-of-care obligations."
  source: "`vibe_ngo_v1`.`volunteer`.`incident_report`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (injury, security, safeguarding, property damage) for risk categorization and trend analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Incident severity (critical, high, medium, low) for risk prioritization and escalation management."
    - name: "incident_report_status"
      expr: incident_report_status
      comment: "Current status of the incident report (open, under investigation, resolved, closed) for pipeline management."
    - name: "investigation_required"
      expr: investigation_required
      comment: "Whether a formal investigation is required — tracks compliance with incident investigation protocols."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation (not started, in progress, completed) for investigation pipeline monitoring."
    - name: "medical_attention_required"
      expr: medical_attention_required
      comment: "Whether medical attention was required — key duty-of-care and insurance compliance indicator."
    - name: "incident_date"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident for time-series safety trend analysis."
    - name: "insurance_claim_filed"
      expr: insurance_claim_filed
      comment: "Whether an insurance claim was filed — tracks financial exposure from volunteer incidents."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total incident reports filed. Baseline safety event volume metric — trends inform risk management and field safety protocols."
    - name: "critical_high_severity_incidents"
      expr: COUNT(DISTINCT CASE WHEN severity_level IN ('critical', 'high') THEN incident_report_id END)
      comment: "Critical and high severity incidents. Immediate leadership attention trigger — each requires escalation and formal investigation."
    - name: "open_incidents"
      expr: COUNT(DISTINCT CASE WHEN incident_report_status = 'open' THEN incident_report_id END)
      comment: "Currently open incident reports. Backlog metric — unresolved incidents represent unmitigated risk and potential donor compliance failures."
    - name: "investigations_required_count"
      expr: COUNT(DISTINCT CASE WHEN investigation_required = TRUE THEN incident_report_id END)
      comment: "Incidents requiring formal investigation. Compliance obligation — all required investigations must be completed per donor and CHS requirements."
    - name: "investigations_completed_count"
      expr: COUNT(DISTINCT CASE WHEN investigation_status = 'completed' THEN incident_report_id END)
      comment: "Completed investigations. Use with investigations_required_count to compute investigation completion rate."
    - name: "medical_attention_incidents"
      expr: COUNT(DISTINCT CASE WHEN medical_attention_required = TRUE THEN incident_report_id END)
      comment: "Incidents requiring medical attention. Duty-of-care KPI — high rates indicate unsafe working conditions requiring immediate intervention."
    - name: "insurance_claims_filed_count"
      expr: COUNT(DISTINCT CASE WHEN insurance_claim_filed = TRUE THEN incident_report_id END)
      comment: "Incidents with insurance claims filed. Financial exposure tracking metric for risk management and insurance renewal negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_tool_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data collection tool authorization KPIs tracking volunteer access governance, authorization coverage, proficiency levels, and compliance with data protection requirements. Used by MEL and Data Protection teams to ensure only authorized, trained volunteers collect sensitive beneficiary data. Aligns with Kobo Toolbox and ODK access management."
  source: "`vibe_ngo_v1`.`volunteer`.`tool_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current authorization status (active, suspended, revoked, expired) for access governance monitoring."
    - name: "authorization_level"
      expr: authorization_level
      comment: "Level of access authorized (read, collect, edit, admin) for privilege management analysis."
    - name: "data_sensitivity_level"
      expr: data_sensitivity_level
      comment: "Sensitivity level of data the volunteer is authorized to collect (public, confidential, restricted, highly restricted) — critical for PII and protection data governance."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status for the tool — only certified volunteers should access sensitive data collection tools."
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Volunteer proficiency level with the tool (beginner, intermediate, advanced) for quality assurance."
    - name: "is_active"
      expr: is_active
      comment: "Whether the authorization is currently active — primary access control status flag."
    - name: "geographic_restriction"
      expr: geographic_restriction
      comment: "Geographic scope restriction on the authorization — ensures data collection is limited to authorized areas."
    - name: "authorization_date"
      expr: DATE_TRUNC('month', authorization_date)
      comment: "Month of authorization for access provisioning trend analysis."
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total tool authorizations on record. Baseline access governance coverage metric."
    - name: "active_authorizations"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN tool_authorization_id END)
      comment: "Currently active tool authorizations. Operational access pool size — determines how many volunteers can collect data at any time."
    - name: "revoked_authorizations"
      expr: COUNT(DISTINCT CASE WHEN authorization_status = 'revoked' THEN tool_authorization_id END)
      comment: "Revoked authorizations. High revocation rates signal data protection incidents or compliance failures requiring investigation."
    - name: "high_sensitivity_active_authorizations"
      expr: COUNT(DISTINCT CASE WHEN data_sensitivity_level IN ('restricted', 'highly restricted') AND is_active = TRUE THEN tool_authorization_id END)
      comment: "Active authorizations for high-sensitivity data collection. Privileged access count — must be minimized per data protection principles and GDPR/humanitarian data standards."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score for tool authorizations. Measures quality of volunteer tool proficiency before access is granted."
    - name: "expiring_authorizations_count"
      expr: COUNT(DISTINCT CASE WHEN authorization_status = 'active' AND authorization_expiry_date IS NOT NULL THEN tool_authorization_id END)
      comment: "Active authorizations with expiry dates set. Renewal pipeline metric — expired authorizations create data collection gaps."
    - name: "avg_total_submissions"
      expr: AVG(CAST(total_submissions_count AS DOUBLE))
      comment: "Average total submissions per authorization. Measures tool utilization depth — low utilization may indicate training gaps or tool adoption barriers."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer team performance and capacity KPIs used by Field Managers and Program Directors to assess team effectiveness, safety record, and resource allocation. Teams are the primary operational unit for field delivery — team-level metrics drive deployment planning and performance management."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of volunteer team (distribution, health, WASH, protection, community engagement) for programmatic segmentation."
    - name: "volunteer_team_status"
      expr: volunteer_team_status
      comment: "Current operational status of the team (active, inactive, dissolved) for capacity planning."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area of team operations for geographic distribution analysis."
    - name: "training_completion_required"
      expr: training_completion_required
      comment: "Whether training completion is required for team membership — compliance standard flag."
    - name: "formation_date"
      expr: DATE_TRUNC('year', formation_date)
      comment: "Year of team formation for cohort analysis of team longevity and performance."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary operating language of the team for community engagement and localization planning."
  measures:
    - name: "total_teams"
      expr: COUNT(1)
      comment: "Total volunteer teams. Baseline organizational capacity metric for field operations."
    - name: "active_teams"
      expr: COUNT(DISTINCT CASE WHEN volunteer_team_status = 'active' THEN volunteer_team_id END)
      comment: "Currently active volunteer teams. Operational capacity metric — drives field deployment planning."
    - name: "total_volunteer_hours_by_teams"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed by all teams. Aggregate in-kind contribution metric for program impact reporting."
    - name: "avg_team_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average team performance rating. Drives team-level recognition, resource allocation, and performance improvement decisions."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across volunteer teams. Financial resource distribution metric for budget management."
    - name: "total_safety_incidents"
      expr: SUM(CAST(safety_incidents_count AS DOUBLE))
      comment: "Total safety incidents across all teams. Safety performance KPI — high counts trigger safety protocol reviews and field security assessments."
    - name: "avg_operational_hours"
      expr: AVG(CAST(operational_hours AS DOUBLE))
      comment: "Average operational hours per team. Measures team utilization and workload distribution for equitable resource allocation."
    - name: "total_recognition_awards"
      expr: SUM(CAST(recognition_awards_count AS DOUBLE))
      comment: "Total recognition awards across teams. Measures recognition program reach and team morale investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recognition program KPIs tracking award distribution, monetary value, milestone achievement, and public acknowledgment coverage. Used by Volunteer Management and HR to assess retention program effectiveness and ensure equitable recognition across the volunteer workforce."
  source: "`vibe_ngo_v1`.`volunteer`.`recognition`"
  dimensions:
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition (milestone, performance, peer, leadership) for program mix analysis."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of the recognition (nominated, approved, awarded, declined) for pipeline management."
    - name: "nominator_type"
      expr: nominator_type
      comment: "Who nominated the volunteer (peer, supervisor, beneficiary, self) for recognition culture analysis."
    - name: "public_acknowledgment_flag"
      expr: public_acknowledgment_flag
      comment: "Whether the recognition was publicly acknowledged — public recognition has higher retention impact."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a certificate was issued — tracks formal credentialing of recognition."
    - name: "skills_category"
      expr: skills_category
      comment: "Skills category recognized — identifies which competencies are being reinforced through recognition."
    - name: "award_date"
      expr: DATE_TRUNC('year', award_date)
      comment: "Year of award for recognition program trend analysis."
  measures:
    - name: "total_recognitions"
      expr: COUNT(1)
      comment: "Total recognition records. Baseline recognition program activity metric."
    - name: "awarded_recognitions"
      expr: COUNT(DISTINCT CASE WHEN recognition_status = 'awarded' THEN recognition_id END)
      comment: "Recognitions that resulted in an award. Measures recognition program conversion and follow-through."
    - name: "total_monetary_value_awarded"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of recognition awards. Financial investment in volunteer retention — benchmarked against turnover cost savings."
    - name: "avg_monetary_value_per_recognition"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recognition award. Measures recognition investment per volunteer — informs program budget adequacy."
    - name: "public_acknowledgment_count"
      expr: COUNT(DISTINCT CASE WHEN public_acknowledgment_flag = TRUE THEN recognition_id END)
      comment: "Recognitions with public acknowledgment. Public recognition has higher retention impact — coverage rate informs program design."
    - name: "unique_volunteers_recognized"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of distinct volunteers who received recognition. Measures recognition program reach — low coverage indicates equity gaps in the recognition program."
$$;