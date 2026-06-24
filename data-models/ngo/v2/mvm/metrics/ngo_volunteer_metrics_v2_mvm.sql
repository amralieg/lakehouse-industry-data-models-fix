-- Metric views for domain: volunteer | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core volunteer workforce metrics covering active capacity, availability, and engagement depth. Used by volunteer managers and program directors to assess workforce size, readiness, and retention."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Categorises volunteers by type (e.g. community, professional, corporate) for workforce segmentation."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the volunteer, enabling capacity planning by available vs. unavailable cohorts."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Stage of the volunteer onboarding pipeline, used to track pipeline health and conversion."
    - name: "gender"
      expr: gender
      comment: "Gender of the volunteer for diversity and inclusion reporting."
    - name: "nationality"
      expr: nationality
      comment: "Volunteer nationality for geographic diversity analysis and deployment eligibility."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language spoken, used to match volunteers to language-specific program needs."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Recognition tier of the volunteer, indicating engagement depth and loyalty."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the volunteer background check, critical for safeguarding compliance tracking."
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Boolean flag indicating whether the volunteer is willing to travel, used for deployment planning."
    - name: "first_volunteer_year"
      expr: YEAR(first_volunteer_date)
      comment: "Year the volunteer first engaged, used for cohort retention and tenure analysis."
  measures:
    - name: "total_active_volunteers"
      expr: COUNT(DISTINCT CASE WHEN availability_status = 'Active' THEN volunteer_id END)
      comment: "Count of distinct volunteers currently marked as active. Core workforce capacity KPI for program planning."
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total registered volunteer headcount across all statuses. Baseline for pipeline and retention analysis."
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly hours volunteers are available to contribute. Drives capacity planning and program scheduling."
    - name: "total_available_hours_per_week"
      expr: SUM(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Aggregate weekly volunteer capacity in hours across the active pool. Used to assess whether supply meets program demand."
    - name: "total_cumulative_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Sum of all lifetime volunteer hours contributed. Reflects total organisational investment and volunteer engagement depth."
    - name: "avg_cumulative_hours_per_volunteer"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average lifetime hours per volunteer. Indicates engagement depth and helps identify high-value vs. low-engagement volunteers."
    - name: "onboarding_completion_rate"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN volunteer_id END)
      comment: "Count of volunteers who have completed onboarding. Numerator for onboarding conversion rate; tracks pipeline efficiency."
    - name: "background_check_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'Cleared' THEN volunteer_id END)
      comment: "Number of volunteers with a cleared background check. Safeguarding compliance KPI used by risk and compliance teams."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer application pipeline metrics covering recruitment funnel conversion, screening efficiency, and onboarding throughput. Used by recruitment coordinators and program managers to optimise volunteer intake."
  source: "`vibe_ngo_v1`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g. Submitted, Under Review, Approved, Rejected) for funnel stage analysis."
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision outcome on the application, used to measure approval and rejection rates."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel through which the volunteer was recruited (e.g. website, referral, event), used for channel effectiveness analysis."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding pipeline stage for approved applicants, used to track post-approval conversion."
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the screening process, used to identify bottlenecks in the pre-approval pipeline."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status on the application, used for safeguarding compliance tracking."
    - name: "background_check_outcome"
      expr: background_check_outcome
      comment: "Outcome of the background check (e.g. Pass, Fail, Pending), used for risk management reporting."
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of the interview stage, used to assess interview-to-approval conversion."
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year of application submission for trend and cohort analysis."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application submission for seasonal recruitment pattern analysis."
    - name: "commitment_duration_months"
      expr: commitment_duration_months
      comment: "Stated commitment duration in months, used to segment applicants by short-term vs. long-term intent."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total number of volunteer applications submitted. Top-of-funnel recruitment volume KPI."
    - name: "approved_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'Approved' THEN application_id END)
      comment: "Number of applications that received an approval decision. Numerator for approval rate calculation."
    - name: "rejected_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'Rejected' THEN application_id END)
      comment: "Number of applications rejected. Used to monitor rejection rates and identify systemic barriers to volunteer intake."
    - name: "onboarding_completed_applications"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN application_id END)
      comment: "Applications where onboarding was fully completed. Measures end-to-end pipeline conversion from application to deployment-ready volunteer."
    - name: "background_check_required_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_required = TRUE THEN application_id END)
      comment: "Number of applications requiring a background check. Used to plan safeguarding workload and compliance timelines."
    - name: "avg_hours_per_week_committed"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours committed by applicants. Informs capacity planning and role-matching decisions."
    - name: "total_hours_per_week_committed"
      expr: SUM(CAST(hours_per_week AS DOUBLE))
      comment: "Total weekly hours committed across all applications. Aggregate supply-side capacity signal for program planning."
    - name: "code_of_conduct_signed_count"
      expr: COUNT(DISTINCT CASE WHEN code_of_conduct_signed = TRUE THEN application_id END)
      comment: "Number of applicants who have signed the code of conduct. Safeguarding and compliance completeness KPI."
    - name: "safeguarding_acknowledged_count"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_acknowledged = TRUE THEN application_id END)
      comment: "Number of applicants who acknowledged the safeguarding policy. Critical compliance metric for donor and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer deployment operational metrics covering utilisation, hours delivery, performance, and attrition. Primary KPI layer for program directors and field operations managers to assess volunteer deployment effectiveness."
  source: "`vibe_ngo_v1`.`volunteer`.`deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (e.g. Active, Completed, Withdrawn) for pipeline and attrition analysis."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (e.g. Emergency, Development, Capacity Building) for programmatic segmentation."
    - name: "volunteer_deployment_status"
      expr: volunteer_deployment_status
      comment: "Volunteer-level deployment status, used to track individual volunteer engagement within a deployment."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Indicates whether the deployment is remote or in-person, used for operational cost and modality analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the deployment for geographic distribution and resource allocation analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the deployment, used to ensure high-priority programs are adequately staffed."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for the deployment, used for risk and compliance reporting."
    - name: "deployment_year"
      expr: YEAR(start_date)
      comment: "Year the deployment started, used for annual trend and cohort analysis."
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the deployment started, used for seasonal and operational planning analysis."
    - name: "orientation_completed_flag"
      expr: orientation_completed_flag
      comment: "Whether orientation was completed before deployment, used to track compliance with pre-deployment requirements."
  measures:
    - name: "total_deployments"
      expr: COUNT(DISTINCT deployment_id)
      comment: "Total number of volunteer deployments. Core operational throughput KPI for program delivery."
    - name: "active_deployments"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'Active' THEN deployment_id END)
      comment: "Number of currently active deployments. Real-time operational capacity indicator for field management."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total volunteer hours contributed across all deployments. Primary measure of volunteer labour input and program delivery capacity."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned volunteer hours across deployments. Denominator for hours utilisation rate; reflects program demand."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours recorded against deployments. Used alongside planned hours to compute delivery efficiency."
    - name: "avg_fte_equivalent"
      expr: AVG(CAST(fte_equivalent AS DOUBLE))
      comment: "Average FTE equivalent per deployment. Translates volunteer effort into comparable staffing units for budget and planning."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total FTE equivalent across all deployments. Enables comparison of volunteer workforce to paid staff equivalents."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average volunteer performance rating across deployments. Quality KPI used to assess volunteer effectiveness and inform recognition decisions."
    - name: "withdrawal_count"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN deployment_id END)
      comment: "Number of deployments that ended in withdrawal. Attrition KPI used to identify retention risks and programme design issues."
    - name: "recognition_awarded_count"
      expr: COUNT(DISTINCT CASE WHEN recognition_awarded_flag = TRUE THEN deployment_id END)
      comment: "Number of deployments where recognition was awarded. Tracks volunteer recognition programme reach and engagement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular volunteer hour logging metrics covering verified contribution, in-kind value, approval efficiency, and activity patterns. Used by program managers, finance teams, and donor reporting functions."
  source: "`vibe_ngo_v1`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of volunteer activity performed (e.g. direct service, training, admin), used for programmatic activity mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hour log entry (e.g. Approved, Pending, Rejected), used to track verification pipeline health."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the hour log (e.g. mobile, web, paper), used for digital adoption and data quality analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the hours (e.g. supervisor sign-off, GPS, photo), used for audit and data integrity reporting."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Indicates whether the activity was virtual or in-person, used for modality analysis and cost attribution."
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Indicates whether the activity was a group activity, used to assess collective vs. individual contribution patterns."
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Flag indicating whether the hour log is eligible for donor reporting. Critical for grant compliance and donor accountability."
    - name: "log_month"
      expr: DATE_TRUNC('MONTH', log_date)
      comment: "Month the hours were logged, used for monthly trend and reporting period analysis."
    - name: "log_year"
      expr: YEAR(log_date)
      comment: "Year the hours were logged, used for annual programme delivery trend analysis."
  measures:
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours claimed across all log entries. Top-line measure of volunteer labour input before verification."
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total volunteer hours that have been verified. The authoritative measure of confirmed volunteer contribution used in donor and regulatory reporting."
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total monetary value of in-kind volunteer contributions. Used in financial reporting, grant compliance, and cost-sharing calculations."
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate applied to volunteer hours. Used to validate in-kind valuation methodology and ensure consistency."
    - name: "approved_log_entries"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN hour_log_id END)
      comment: "Number of hour log entries that have been approved. Measures verification pipeline throughput and data completeness."
    - name: "donor_reportable_hours"
      expr: SUM(CAST(CASE WHEN donor_report_eligible = TRUE THEN hours_verified ELSE 0 END AS DOUBLE))
      comment: "Total verified hours eligible for donor reporting. Direct input to grant compliance and donor accountability reporting."
    - name: "distinct_active_volunteers_logging"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of distinct volunteers who have submitted hour logs. Measures active engagement breadth across the volunteer pool."
    - name: "recognition_milestone_triggered_count"
      expr: COUNT(DISTINCT CASE WHEN recognition_milestone_triggered = TRUE THEN hour_log_id END)
      comment: "Number of hour log entries that triggered a recognition milestone. Tracks volunteer recognition programme activation rate."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer training pipeline metrics covering completion rates, assessment performance, certification issuance, and compliance training coverage. Used by learning & development leads and compliance officers."
  source: "`vibe_ngo_v1`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the training enrollment (e.g. Enrolled, Completed, Withdrawn) for pipeline stage analysis."
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Mode of training delivery (e.g. in-person, e-learning, blended), used for modality effectiveness analysis."
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Compliance category of the training (e.g. safeguarding, PSEA, data protection), used for regulatory compliance tracking."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Indicates whether the training is mandatory, used to prioritise completion tracking for compliance purposes."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether a certificate was issued upon completion, used to track credentialing outcomes."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Whether recertification is required, used to plan future training demand and compliance renewal cycles."
    - name: "training_language"
      expr: training_language
      comment: "Language in which the training was delivered, used for language accessibility and inclusion analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of the enrollment (e.g. self-enrolled, manager-assigned), used to understand training demand drivers."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for training intake trend analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total number of training enrollments. Top-line measure of training programme reach and demand."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN training_enrollment_id END)
      comment: "Number of training enrollments completed. Numerator for training completion rate; core L&D performance KPI."
    - name: "mandatory_training_completions"
      expr: COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE AND enrollment_status = 'Completed' THEN training_enrollment_id END)
      comment: "Number of mandatory training completions. Critical compliance KPI for safeguarding, PSEA, and regulatory requirements."
    - name: "certifications_issued"
      expr: COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of certifications issued through training completions. Measures credentialing output and volunteer qualification pipeline."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training enrollments. Measures learning effectiveness and training quality."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered across all enrollments. Measures organisational investment in volunteer capacity building."
    - name: "total_enrollment_cost"
      expr: SUM(CAST(enrollment_cost AS DOUBLE))
      comment: "Total cost of training enrollments. Used for L&D budget management and cost-per-completion analysis."
    - name: "avg_feedback_rating"
      expr: AVG(CAST(feedback_rating AS DOUBLE))
      comment: "Average participant feedback rating for training. Measures training satisfaction and quality from the learner perspective."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned by volunteers. Tracks professional development output and accreditation compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer certification portfolio metrics covering compliance coverage, expiry risk, cost, and deployment eligibility. Used by compliance officers, program managers, and HR to manage volunteer qualification standards."
  source: "`vibe_ngo_v1`.`volunteer`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. first aid, safeguarding, technical) for qualification portfolio analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the certification belongs to, used for regulatory and donor compliance tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification status of the certification (e.g. Verified, Pending, Expired), used for compliance risk management."
    - name: "deployment_eligible"
      expr: deployment_eligible
      comment: "Whether the certification makes the volunteer eligible for deployment, used for deployment readiness planning."
    - name: "mandatory_for_role"
      expr: mandatory_for_role
      comment: "Whether the certification is mandatory for the assigned role, used for compliance gap analysis."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires renewal, used to forecast future training and recertification demand."
    - name: "reimbursed_by_organization"
      expr: reimbursed_by_organization
      comment: "Whether the certification cost was reimbursed by the organisation, used for cost management and policy compliance."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category associated with the certification, used for workforce skills gap analysis."
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Proficiency level of the certification (e.g. Basic, Intermediate, Advanced), used for skills depth analysis."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued, used for certification cohort and renewal cycle analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total number of certifications held across the volunteer workforce. Baseline measure of qualification portfolio breadth."
    - name: "deployment_eligible_certifications"
      expr: COUNT(DISTINCT CASE WHEN deployment_eligible = TRUE THEN certification_id END)
      comment: "Number of certifications that confer deployment eligibility. Directly measures deployment-ready volunteer qualification coverage."
    - name: "mandatory_certifications_verified"
      expr: COUNT(DISTINCT CASE WHEN mandatory_for_role = TRUE AND verification_status = 'Verified' THEN certification_id END)
      comment: "Number of mandatory role certifications that are verified. Critical compliance KPI for safeguarding and role-readiness assurance."
    - name: "expiring_certifications_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date IS NOT NULL AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN certification_id END)
      comment: "Number of certifications expiring within 90 days. Risk management KPI used to trigger renewal actions and prevent compliance gaps."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications across the volunteer workforce. Used for L&D budget management and cost-per-volunteer analysis."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score at certification. Measures quality of certification attainment across the volunteer pool."
    - name: "total_training_hours_for_certification"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested to achieve certifications. Measures organisational capacity building investment."
    - name: "distinct_certified_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of distinct volunteers holding at least one certification. Measures qualified workforce breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`volunteer_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer team performance and capacity metrics used by field operations and program managers to assess team effectiveness, resource allocation, and operational health."
  source: "`vibe_ngo_v1`.`volunteer`.`volunteer_team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of volunteer team (e.g. emergency response, community outreach, logistics), used for programmatic segmentation."
    - name: "volunteer_team_status"
      expr: volunteer_team_status
      comment: "Current operational status of the team (e.g. Active, Dissolved, Forming), used for capacity and lifecycle management."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area the team operates in, used for geographic coverage and resource distribution analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the team, used for language accessibility and program matching."
    - name: "meeting_frequency"
      expr: meeting_frequency
      comment: "How frequently the team meets, used as a proxy for team cohesion and operational engagement."
    - name: "training_completion_required"
      expr: training_completion_required
      comment: "Whether training completion is required for team membership, used for compliance and readiness tracking."
    - name: "formation_year"
      expr: YEAR(formation_date)
      comment: "Year the team was formed, used for team tenure and maturity analysis."
  measures:
    - name: "total_active_teams"
      expr: COUNT(DISTINCT CASE WHEN volunteer_team_status = 'Active' THEN volunteer_team_id END)
      comment: "Number of currently active volunteer teams. Core operational capacity KPI for field management."
    - name: "total_volunteer_hours_by_teams"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed across all teams. Measures aggregate team-level labour input for programme delivery."
    - name: "avg_operational_hours_per_team"
      expr: AVG(CAST(operational_hours AS DOUBLE))
      comment: "Average operational hours per team. Used to benchmark team productivity and identify under-performing teams."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across volunteer teams. Used for financial planning and cost-per-team analysis."
    - name: "avg_budget_per_team"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocated per volunteer team. Used to assess equity of resource distribution across teams."
    - name: "total_teams"
      expr: COUNT(DISTINCT volunteer_team_id)
      comment: "Total number of volunteer teams across all statuses. Baseline for team portfolio management and scaling decisions."
$$;