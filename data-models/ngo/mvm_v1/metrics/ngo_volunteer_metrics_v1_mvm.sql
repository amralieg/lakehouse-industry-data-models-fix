-- Metric views for domain: volunteer | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core volunteer roster metrics tracking workforce capacity, availability, engagement depth, and demographic composition. Used by volunteer managers and program directors to assess volunteer pipeline health and deployment readiness."
  source: "`ngo_ecm`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Categorizes volunteers by type (e.g. individual, corporate, skilled) to segment capacity and engagement analysis."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the volunteer, used to filter active vs. inactive capacity."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Tracks where volunteers are in the onboarding pipeline, enabling bottleneck identification."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Compliance dimension indicating whether background screening is cleared, pending, or failed."
    - name: "nationality"
      expr: nationality
      comment: "Volunteer nationality for geographic diversity and deployment eligibility analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of residence for geographic distribution and regional capacity planning."
    - name: "gender"
      expr: gender
      comment: "Gender dimension for diversity reporting and equity monitoring."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language spoken by the volunteer, critical for matching to program language requirements."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Volunteer recognition tier reflecting cumulative contribution and loyalty, used for retention strategy."
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Boolean flag indicating travel willingness, key for emergency deployment pool sizing."
    - name: "first_volunteer_year"
      expr: YEAR(first_volunteer_date)
      comment: "Year the volunteer first engaged, used for cohort retention and tenure analysis."
  measures:
    - name: "total_active_volunteers"
      expr: COUNT(DISTINCT CASE WHEN availability_status = 'Active' THEN volunteer_id END)
      comment: "Count of distinct volunteers currently marked as active. Core capacity KPI for program planning and deployment readiness."
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total distinct volunteers in the roster regardless of status. Baseline for pipeline and funnel analysis."
    - name: "total_cumulative_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Sum of all cumulative volunteer hours across the roster. Represents the total in-kind labor contribution to the organization's mission."
    - name: "avg_volunteer_hours_per_volunteer"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average cumulative hours per volunteer. Indicates engagement depth and helps identify high-value vs. low-engagement volunteers."
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly hours volunteers are available. Used for capacity planning and matching volunteers to program demand."
    - name: "total_weekly_capacity_hours"
      expr: SUM(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Total weekly volunteer capacity in hours across all active volunteers. Drives resource allocation decisions for program managers."
    - name: "onboarding_completion_rate_numerator"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN volunteer_id END)
      comment: "Count of volunteers who have completed onboarding. Use with total_volunteers to compute onboarding completion rate in BI layer."
    - name: "background_check_cleared_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'Cleared' THEN volunteer_id END)
      comment: "Number of volunteers with cleared background checks. Compliance KPI ensuring deployment-eligible pool is accurately sized."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recruitment funnel and screening pipeline metrics. Tracks application volume, conversion through screening stages, onboarding throughput, and time-to-decision. Used by recruitment coordinators and HR leadership to optimize volunteer acquisition."
  source: "`ngo_ecm`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g. Submitted, Under Review, Approved, Rejected) for funnel stage analysis."
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision outcome on the application, used to measure approval and rejection rates."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel through which the volunteer was recruited (e.g. website, referral, event). Drives channel effectiveness analysis."
    - name: "screening_status"
      expr: screening_status
      comment: "Status of the screening process, used to identify bottlenecks in the pre-approval pipeline."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Background check status on the application, critical for compliance and deployment eligibility tracking."
    - name: "background_check_outcome"
      expr: background_check_outcome
      comment: "Outcome of the background check (e.g. Pass, Fail, Pending) for compliance reporting."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding pipeline status for applications that have been approved, tracking readiness to deploy."
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of the volunteer interview stage, used to assess interview-to-approval conversion."
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year of application submission for trend and cohort analysis."
    - name: "application_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month of application submission for seasonal recruitment pattern analysis."
    - name: "commitment_duration_months"
      expr: commitment_duration_months
      comment: "Stated commitment duration from the applicant, used to segment short-term vs. long-term volunteer pipeline."
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total number of volunteer applications submitted. Top-of-funnel recruitment volume KPI."
    - name: "approved_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'Approved' THEN application_id END)
      comment: "Number of applications that received an approval decision. Used to compute approval rate and assess recruitment quality."
    - name: "rejected_applications"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'Rejected' THEN application_id END)
      comment: "Number of rejected applications. Elevated rejection rates may signal misaligned recruitment channels or unclear role requirements."
    - name: "onboarding_completed_applications"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN application_id END)
      comment: "Applications where onboarding has been fully completed. Measures end-to-end recruitment funnel conversion."
    - name: "background_check_required_count"
      expr: COUNT(DISTINCT CASE WHEN background_check_required = TRUE THEN application_id END)
      comment: "Number of applications requiring a background check. Used for compliance workload planning."
    - name: "avg_committed_hours_per_week"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average weekly hours committed by applicants. Informs capacity planning and role-fit assessment during recruitment."
    - name: "total_committed_hours_per_week"
      expr: SUM(CAST(hours_per_week AS DOUBLE))
      comment: "Total weekly hours committed across all applications in scope. Represents potential capacity entering the pipeline."
    - name: "orientation_completion_rate_numerator"
      expr: COUNT(DISTINCT CASE WHEN orientation_completed = TRUE THEN application_id END)
      comment: "Count of applications where orientation was completed. Combine with total_applications in BI to compute orientation completion rate."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer deployment performance and utilization metrics. Tracks planned vs. actual hours, deployment completion rates, FTE equivalents, and performance ratings. Primary operational KPI view for program directors and field coordinators managing volunteer labor."
  source: "`ngo_ecm`.`volunteer`.`volunteer_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment (e.g. Active, Completed, Withdrawn) for pipeline and completion analysis."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (e.g. Emergency, Programmatic, Capacity Building) for strategic resource allocation analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the deployment is taking place, enabling geographic performance comparison."
    - name: "region"
      expr: region
      comment: "Regional grouping of deployments for portfolio-level resource and performance analysis."
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Indicates whether the deployment is remote or in-person, used to analyze modality mix and cost implications."
    - name: "priority"
      expr: priority
      comment: "Deployment priority level (e.g. High, Medium, Low) for triage and resource allocation decisions."
    - name: "orientation_completed_flag"
      expr: orientation_completed_flag
      comment: "Whether orientation was completed before deployment start, a compliance and readiness indicator."
    - name: "recognition_awarded_flag"
      expr: recognition_awarded_flag
      comment: "Whether a recognition award was given for this deployment, used for volunteer retention and engagement analysis."
    - name: "deployment_start_year"
      expr: YEAR(start_date)
      comment: "Year the deployment started, for trend and cohort analysis."
    - name: "deployment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the deployment started, for seasonal and operational planning analysis."
    - name: "volunteer_deployment_status"
      expr: volunteer_deployment_status
      comment: "Granular deployment lifecycle status field for detailed pipeline tracking."
  measures:
    - name: "total_deployments"
      expr: COUNT(DISTINCT volunteer_deployment_id)
      comment: "Total number of volunteer deployments. Core operational volume KPI for program capacity and throughput."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned volunteer hours across all deployments. Baseline for utilization and variance analysis."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours delivered by volunteers. Measures real labor contribution vs. plan."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total hours contributed as recorded on the deployment record. Used for in-kind value reporting to donors and boards."
    - name: "avg_actual_hours_per_deployment"
      expr: AVG(CAST(actual_hours AS DOUBLE))
      comment: "Average actual hours per deployment. Indicates typical engagement intensity and helps identify under-utilized deployments."
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Sum of FTE equivalents across all deployments. Translates volunteer labor into staff-equivalent units for budget and capacity planning."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average volunteer performance rating across deployments. Quality KPI used to assess volunteer effectiveness and inform recognition decisions."
    - name: "hours_variance"
      expr: SUM((actual_hours) - (planned_hours))
      comment: "Aggregate difference between actual and planned hours. Negative values indicate under-delivery; positive values indicate over-delivery. Key operational efficiency signal."
    - name: "completed_deployments"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'Completed' THEN volunteer_deployment_id END)
      comment: "Number of deployments that reached completed status. Used to compute deployment completion rate and assess program execution quality."
    - name: "withdrawn_deployments"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'Withdrawn' THEN volunteer_deployment_id END)
      comment: "Number of deployments that were withdrawn. Elevated withdrawal rates signal retention or role-fit issues requiring intervention."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer hour logging and in-kind value metrics. Tracks verified vs. claimed hours, in-kind contribution value, approval rates, and activity patterns. Used by finance, program, and donor reporting teams to quantify volunteer labor value and ensure compliance."
  source: "`ngo_ecm`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of volunteer activity logged (e.g. Direct Service, Training, Admin) for program-level contribution analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hour log entry (e.g. Approved, Pending, Rejected) for compliance and audit tracking."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Indicates whether the activity was conducted virtually, enabling modality mix analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flags overtime hours for workload management and volunteer welfare monitoring."
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Indicates whether the logged activity was a group effort, used for team contribution analysis."
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Flags hours eligible for donor reporting, critical for grant compliance and in-kind matching calculations."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the hour log (e.g. Mobile, Web, Manual) for data quality and process improvement analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the hours (e.g. Supervisor Sign-off, GPS, System) for audit and compliance purposes."
    - name: "log_year"
      expr: YEAR(log_date)
      comment: "Year the hours were logged, for annual trend and reporting analysis."
    - name: "log_month"
      expr: DATE_TRUNC('MONTH', log_date)
      comment: "Month the hours were logged, for operational planning and monthly reporting."
    - name: "recognition_milestone_triggered"
      expr: recognition_milestone_triggered
      comment: "Whether this log entry triggered a recognition milestone, used for volunteer engagement and retention analysis."
  measures:
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours claimed across all log entries. Top-line labor contribution metric before verification."
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total volunteer hours that have been verified and approved. The authoritative labor contribution figure for donor and board reporting."
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total monetary in-kind value of volunteer hours. Directly used in grant reporting, donor matching, and organizational impact statements."
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate applied to volunteer hours. Used to assess valuation methodology consistency across programs."
    - name: "approved_log_entries"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN hour_log_id END)
      comment: "Number of hour log entries that have been approved. Measures throughput of the verification pipeline."
    - name: "total_log_entries"
      expr: COUNT(DISTINCT hour_log_id)
      comment: "Total number of hour log entries submitted. Baseline volume metric for pipeline and compliance monitoring."
    - name: "donor_eligible_hours"
      expr: SUM(CASE WHEN donor_report_eligible = TRUE THEN hours_verified ELSE 0 END)
      comment: "Total verified hours eligible for donor reporting. Critical for grant compliance and in-kind match calculations."
    - name: "hours_verification_gap"
      expr: SUM((hours_claimed) - (hours_verified))
      comment: "Difference between claimed and verified hours. Large gaps indicate verification bottlenecks or data quality issues requiring management attention."
    - name: "avg_hours_per_log_entry"
      expr: AVG(CAST(hours_claimed AS DOUBLE))
      comment: "Average hours per log entry. Helps identify unusually large or small submissions that may require audit review."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer training completion, certification issuance, and compliance training metrics. Tracks enrollment throughput, completion rates, assessment performance, and mandatory training compliance. Used by L&D coordinators, compliance officers, and program directors."
  source: "`ngo_ecm`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the training enrollment (e.g. Enrolled, Completed, Withdrawn) for pipeline and completion analysis."
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Delivery modality (e.g. In-Person, Online, Blended) for modality effectiveness and cost analysis."
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Indicates whether the training is mandatory, used to prioritize compliance monitoring and escalation."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether a certification was issued upon completion, used to track credentialing outcomes."
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Flags enrollments requiring recertification, used for compliance calendar and renewal planning."
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Compliance category of the training (e.g. Safeguarding, PSEA, Data Protection) for regulatory reporting."
    - name: "training_language"
      expr: training_language
      comment: "Language in which training was delivered, used for accessibility and inclusion analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of the enrollment (e.g. Self-Enrolled, Manager-Assigned) for learning culture analysis."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for trend and annual compliance reporting."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for operational planning and cohort analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total number of training enrollments. Baseline volume metric for L&D throughput and compliance coverage."
    - name: "completed_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN training_enrollment_id END)
      comment: "Number of enrollments that reached completion. Core training effectiveness KPI."
    - name: "mandatory_training_completions"
      expr: COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE AND enrollment_status = 'Completed' THEN training_enrollment_id END)
      comment: "Completions of mandatory training. Critical compliance KPI — low values trigger regulatory and donor risk escalation."
    - name: "certifications_issued"
      expr: COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of certifications issued through training completions. Measures credentialing output and deployment eligibility pipeline."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered across all enrollments. Quantifies L&D investment and capacity building effort."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across enrollments. Indicates training effectiveness and knowledge retention quality."
    - name: "total_enrollment_cost"
      expr: SUM(CAST(enrollment_cost AS DOUBLE))
      comment: "Total cost of training enrollments. Used for L&D budget management and cost-per-completion analysis."
    - name: "avg_enrollment_cost"
      expr: AVG(CAST(enrollment_cost AS DOUBLE))
      comment: "Average cost per training enrollment. Enables cost efficiency benchmarking across delivery modalities and training types."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned across all enrollments. Tracks professional development output for volunteers."
    - name: "withdrawn_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Withdrawn' THEN training_enrollment_id END)
      comment: "Number of training withdrawals. Elevated withdrawal rates signal scheduling, relevance, or accessibility issues requiring intervention."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer certification portfolio metrics tracking credentialing coverage, compliance status, expiry risk, and cost of certification. Used by compliance officers and program directors to ensure deployment-eligible volunteers maintain required credentials."
  source: "`ngo_ecm`.`volunteer`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Technical, Compliance, Safety) for portfolio composition analysis."
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the certification for granular credential tracking and gap analysis."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category associated with the certification, used to map credentialing to program capability requirements."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the certification (e.g. Safeguarding, PSEA) for regulatory reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification status of the certification (e.g. Verified, Pending, Expired) for compliance monitoring."
    - name: "deployment_eligible"
      expr: deployment_eligible
      comment: "Whether the certification makes the volunteer eligible for deployment, a critical readiness indicator."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flags certifications requiring renewal, used for proactive compliance calendar management."
    - name: "recognized_by_organization"
      expr: recognized_by_organization
      comment: "Whether the certification is formally recognized by the organization, used to validate credential quality."
    - name: "reimbursed_by_organization"
      expr: reimbursed_by_organization
      comment: "Whether the certification cost was reimbursed, used for financial tracking and volunteer benefit analysis."
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Proficiency level achieved (e.g. Basic, Intermediate, Advanced) for capability depth analysis."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued, for cohort and trend analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires, used for renewal pipeline planning and compliance risk forecasting."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total number of certifications held across the volunteer workforce. Baseline credentialing coverage metric."
    - name: "deployment_eligible_certifications"
      expr: COUNT(DISTINCT CASE WHEN deployment_eligible = TRUE THEN certification_id END)
      comment: "Number of certifications that confer deployment eligibility. Directly sizes the deployable volunteer pool."
    - name: "verified_certifications"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN certification_id END)
      comment: "Number of certifications with verified status. Compliance KPI ensuring credential authenticity."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications across the volunteer workforce. Used for L&D budget management and cost-benefit analysis."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Enables benchmarking across certification types and informs reimbursement policy decisions."
    - name: "total_training_hours_for_certification"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested to achieve certifications. Quantifies the learning effort behind the credentialing portfolio."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score at certification. Indicates quality of credentialing outcomes across the volunteer workforce."
    - name: "total_continuing_education_hours"
      expr: SUM(CAST(continuing_education_hours AS DOUBLE))
      comment: "Total continuing education hours accumulated through certifications. Tracks ongoing professional development investment."
    - name: "certifications_requiring_renewal"
      expr: COUNT(DISTINCT CASE WHEN renewal_required = TRUE THEN certification_id END)
      comment: "Number of certifications requiring renewal. Drives proactive compliance management and renewal workload planning."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer team performance, capacity, and operational health metrics. Used by field coordinators and program managers to assess team effectiveness, budget utilization, and readiness for program delivery."
  source: "`ngo_ecm`.`volunteer`.`volunteer_team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of volunteer team (e.g. Emergency Response, Community Outreach) for portfolio and capability analysis."
    - name: "volunteer_team_status"
      expr: volunteer_team_status
      comment: "Current operational status of the team (e.g. Active, Dissolved, Forming) for capacity planning."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area of team operations for regional coverage and resource distribution analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the team, used for program-team matching and accessibility analysis."
    - name: "training_completion_required"
      expr: training_completion_required
      comment: "Whether training completion is required for team membership, a compliance and readiness indicator."
    - name: "formation_year"
      expr: YEAR(formation_date)
      comment: "Year the team was formed, used for cohort and maturity analysis."
  measures:
    - name: "total_teams"
      expr: COUNT(DISTINCT volunteer_team_id)
      comment: "Total number of volunteer teams. Baseline organizational capacity metric."
    - name: "active_teams"
      expr: COUNT(DISTINCT CASE WHEN volunteer_team_status = 'Active' THEN volunteer_team_id END)
      comment: "Number of currently active volunteer teams. Operational capacity KPI for program delivery planning."
    - name: "total_team_volunteer_hours"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed across all teams. Aggregate labor contribution metric for program impact reporting."
    - name: "avg_team_volunteer_hours"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average volunteer hours per team. Identifies high-performing vs. under-utilized teams for resource reallocation decisions."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation AS DOUBLE))
      comment: "Total budget allocated across all volunteer teams. Used for financial oversight and budget utilization analysis."
    - name: "avg_budget_per_team"
      expr: AVG(CAST(budget_allocation AS DOUBLE))
      comment: "Average budget allocation per team. Enables equity and efficiency analysis across the team portfolio."
$$;