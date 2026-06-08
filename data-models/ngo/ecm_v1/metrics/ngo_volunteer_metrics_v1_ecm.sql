-- Metric views for domain: volunteer | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core volunteer engagement and capacity metrics tracking active volunteers, availability, and cumulative contribution hours"
  source: "`ngo_ecm`.`volunteer`.`volunteer`"
  dimensions:
    - name: "volunteer_type"
      expr: volunteer_type
      comment: "Classification of volunteer (e.g., regular, emergency response, skilled professional)"
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the volunteer"
    - name: "country_code"
      expr: country_code
      comment: "Country where the volunteer is based"
    - name: "gender"
      expr: gender
      comment: "Gender of the volunteer for diversity tracking"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding completion status"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background verification process"
    - name: "recognition_level"
      expr: recognition_level
      comment: "Recognition tier based on contribution milestones"
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Whether volunteer is willing to travel for deployments"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language spoken by volunteer"
    - name: "geographic_base"
      expr: geographic_base
      comment: "Geographic base location of the volunteer"
  measures:
    - name: "total_volunteers"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Total number of unique volunteers"
    - name: "total_volunteer_hours_contributed"
      expr: SUM(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Cumulative volunteer hours contributed across all volunteers"
    - name: "avg_volunteer_hours_per_volunteer"
      expr: AVG(CAST(total_volunteer_hours AS DOUBLE))
      comment: "Average cumulative hours contributed per volunteer"
    - name: "avg_availability_hours_per_week"
      expr: AVG(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Average weekly availability hours across volunteers"
    - name: "total_available_capacity_hours_per_week"
      expr: SUM(CAST(availability_hours_per_week AS DOUBLE))
      comment: "Total weekly volunteer capacity available for deployment"
    - name: "volunteers_with_background_check_completed"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'Completed' THEN volunteer_id END)
      comment: "Number of volunteers who have completed background checks"
    - name: "volunteers_onboarded"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN volunteer_id END)
      comment: "Number of volunteers who have completed onboarding"
    - name: "volunteers_willing_to_travel"
      expr: COUNT(DISTINCT CASE WHEN willing_to_travel = TRUE THEN volunteer_id END)
      comment: "Number of volunteers willing to travel for field deployments"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer deployment effectiveness metrics tracking utilization, performance, and deployment outcomes"
  source: "`ngo_ecm`.`volunteer`.`volunteer_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the volunteer deployment"
    - name: "deployment_type"
      expr: deployment_type
      comment: "Type of deployment (e.g., emergency response, long-term program support)"
    - name: "country_code"
      expr: country_code
      comment: "Country where deployment is taking place"
    - name: "region"
      expr: region
      comment: "Geographic region of deployment"
    - name: "remote_deployment_flag"
      expr: remote_deployment_flag
      comment: "Whether deployment is remote or in-person"
    - name: "priority"
      expr: priority
      comment: "Priority level of the deployment"
    - name: "orientation_completed_flag"
      expr: orientation_completed_flag
      comment: "Whether volunteer completed orientation before deployment"
    - name: "recognition_awarded_flag"
      expr: recognition_awarded_flag
      comment: "Whether recognition was awarded for this deployment"
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level required for deployment"
    - name: "role"
      expr: role
      comment: "Role performed during deployment"
  measures:
    - name: "total_deployments"
      expr: COUNT(DISTINCT volunteer_deployment_id)
      comment: "Total number of volunteer deployments"
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned volunteer hours across all deployments"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual volunteer hours delivered across all deployments"
    - name: "avg_deployment_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating across deployments"
    - name: "total_fte_equivalent"
      expr: SUM(CAST(fte_equivalent AS DOUBLE))
      comment: "Total full-time equivalent volunteer capacity deployed"
    - name: "deployments_completed"
      expr: COUNT(DISTINCT CASE WHEN deployment_status = 'Completed' THEN volunteer_deployment_id END)
      comment: "Number of deployments successfully completed"
    - name: "deployments_with_orientation"
      expr: COUNT(DISTINCT CASE WHEN orientation_completed_flag = TRUE THEN volunteer_deployment_id END)
      comment: "Number of deployments where volunteer completed orientation"
    - name: "deployments_with_recognition"
      expr: COUNT(DISTINCT CASE WHEN recognition_awarded_flag = TRUE THEN volunteer_deployment_id END)
      comment: "Number of deployments that resulted in recognition awards"
    - name: "remote_deployments"
      expr: COUNT(DISTINCT CASE WHEN remote_deployment_flag = TRUE THEN volunteer_deployment_id END)
      comment: "Number of remote volunteer deployments"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_hour_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer time contribution and in-kind value metrics tracking hours claimed, verified, and fair market value"
  source: "`ngo_ecm`.`volunteer`.`hour_log`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of volunteer activity performed"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the hour log entry"
    - name: "donor_report_eligible"
      expr: donor_report_eligible
      comment: "Whether hours are eligible for donor reporting"
    - name: "is_group_activity"
      expr: is_group_activity
      comment: "Whether activity was performed as a group"
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether activity was performed virtually"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit hour log"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify hours"
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center to which hours are allocated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for in-kind value calculation"
    - name: "recognition_milestone_triggered"
      expr: recognition_milestone_triggered
      comment: "Whether this log entry triggered a recognition milestone"
  measures:
    - name: "total_hour_logs"
      expr: COUNT(DISTINCT hour_log_id)
      comment: "Total number of hour log entries"
    - name: "total_hours_claimed"
      expr: SUM(CAST(hours_claimed AS DOUBLE))
      comment: "Total volunteer hours claimed across all logs"
    - name: "total_hours_verified"
      expr: SUM(CAST(hours_verified AS DOUBLE))
      comment: "Total volunteer hours verified and approved"
    - name: "total_in_kind_value"
      expr: SUM(CAST(in_kind_value AS DOUBLE))
      comment: "Total in-kind contribution value of volunteer time"
    - name: "avg_fair_market_value_rate"
      expr: AVG(CAST(fair_market_value_rate AS DOUBLE))
      comment: "Average fair market value rate per volunteer hour"
    - name: "approved_hour_logs"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN hour_log_id END)
      comment: "Number of hour logs approved"
    - name: "donor_reportable_hour_logs"
      expr: COUNT(DISTINCT CASE WHEN donor_report_eligible = TRUE THEN hour_log_id END)
      comment: "Number of hour logs eligible for donor reporting"
    - name: "virtual_activity_logs"
      expr: COUNT(DISTINCT CASE WHEN is_virtual = TRUE THEN hour_log_id END)
      comment: "Number of virtual volunteer activity logs"
    - name: "group_activity_logs"
      expr: COUNT(DISTINCT CASE WHEN is_group_activity = TRUE THEN hour_log_id END)
      comment: "Number of group volunteer activity logs"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recruitment pipeline metrics tracking application conversion, screening effectiveness, and onboarding completion"
  source: "`ngo_ecm`.`volunteer`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the volunteer application"
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel through which volunteer was recruited"
    - name: "decision_status"
      expr: decision_status
      comment: "Final decision status on the application"
    - name: "screening_status"
      expr: screening_status
      comment: "Status of screening process"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check"
    - name: "background_check_outcome"
      expr: background_check_outcome
      comment: "Outcome of background check"
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of interview process"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Status of onboarding process"
    - name: "commitment_duration_months"
      expr: commitment_duration_months
      comment: "Committed duration in months"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for application rejection if applicable"
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT application_id)
      comment: "Total number of volunteer applications received"
    - name: "applications_approved"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'Approved' THEN application_id END)
      comment: "Number of applications approved"
    - name: "applications_rejected"
      expr: COUNT(DISTINCT CASE WHEN decision_status = 'Rejected' THEN application_id END)
      comment: "Number of applications rejected"
    - name: "background_checks_completed"
      expr: COUNT(DISTINCT CASE WHEN background_check_status = 'Completed' THEN application_id END)
      comment: "Number of applications with completed background checks"
    - name: "background_checks_passed"
      expr: COUNT(DISTINCT CASE WHEN background_check_outcome = 'Passed' THEN application_id END)
      comment: "Number of applications with passed background checks"
    - name: "interviews_completed"
      expr: COUNT(DISTINCT CASE WHEN interview_outcome IS NOT NULL THEN application_id END)
      comment: "Number of applications with completed interviews"
    - name: "onboarding_completed"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN application_id END)
      comment: "Number of applications with completed onboarding"
    - name: "avg_hours_per_week_committed"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average hours per week committed by applicants"
    - name: "applications_with_code_of_conduct_signed"
      expr: COUNT(DISTINCT CASE WHEN code_of_conduct_signed = TRUE THEN application_id END)
      comment: "Number of applications with signed code of conduct"
    - name: "applications_with_safeguarding_acknowledged"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_acknowledged = TRUE THEN application_id END)
      comment: "Number of applications with safeguarding policy acknowledged"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_training_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer training effectiveness metrics tracking completion rates, assessment performance, and certification outcomes"
  source: "`ngo_ecm`.`volunteer`.`training_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of training enrollment"
    - name: "training_delivery_mode"
      expr: training_delivery_mode
      comment: "Mode of training delivery (e.g., in-person, online, hybrid)"
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether training is mandatory for the volunteer"
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Whether certification was issued upon completion"
    - name: "compliance_training_category"
      expr: compliance_training_category
      comment: "Category of compliance training"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of training enrollment"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the training"
    - name: "training_language"
      expr: training_language
      comment: "Language in which training was delivered"
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Whether recertification is required"
    - name: "feedback_rating"
      expr: feedback_rating
      comment: "Feedback rating provided by volunteer"
  measures:
    - name: "total_training_enrollments"
      expr: COUNT(DISTINCT training_enrollment_id)
      comment: "Total number of training enrollments"
    - name: "training_completions"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'Completed' THEN training_enrollment_id END)
      comment: "Number of training enrollments completed"
    - name: "certifications_issued"
      expr: COUNT(DISTINCT CASE WHEN certification_issued_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of certifications issued"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all enrollments"
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned"
    - name: "total_enrollment_cost"
      expr: SUM(CAST(enrollment_cost AS DOUBLE))
      comment: "Total cost of training enrollments"
    - name: "avg_enrollment_cost"
      expr: AVG(CAST(enrollment_cost AS DOUBLE))
      comment: "Average cost per training enrollment"
    - name: "mandatory_training_enrollments"
      expr: COUNT(DISTINCT CASE WHEN mandatory_training_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of mandatory training enrollments"
    - name: "enrollments_requiring_recertification"
      expr: COUNT(DISTINCT CASE WHEN recertification_required_flag = TRUE THEN training_enrollment_id END)
      comment: "Number of enrollments requiring recertification"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_stipend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer stipend financial metrics tracking disbursements, compliance, and donor reportability"
  source: "`ngo_ecm`.`volunteer`.`stipend`"
  dimensions:
    - name: "stipend_type"
      expr: stipend_type
      comment: "Type of stipend (e.g., living allowance, transportation, subsistence)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the stipend"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of stipend payment"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of stipend payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for stipend amount"
    - name: "donor_reportable_flag"
      expr: donor_reportable_flag
      comment: "Whether stipend is reportable to donors"
    - name: "tax_reportable_flag"
      expr: tax_reportable_flag
      comment: "Whether stipend is tax reportable"
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of compliance check for stipend"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category for financial reporting"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of stipend disbursement"
  measures:
    - name: "total_stipends"
      expr: COUNT(DISTINCT stipend_id)
      comment: "Total number of stipend records"
    - name: "total_stipend_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total stipend amount disbursed"
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total stipend amount in reporting currency"
    - name: "avg_stipend_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average stipend amount per record"
    - name: "stipends_approved"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN stipend_id END)
      comment: "Number of stipends approved"
    - name: "stipends_disbursed"
      expr: COUNT(DISTINCT CASE WHEN disbursement_date IS NOT NULL THEN stipend_id END)
      comment: "Number of stipends disbursed"
    - name: "donor_reportable_stipends"
      expr: COUNT(DISTINCT CASE WHEN donor_reportable_flag = TRUE THEN stipend_id END)
      comment: "Number of stipends reportable to donors"
    - name: "tax_reportable_stipends"
      expr: COUNT(DISTINCT CASE WHEN tax_reportable_flag = TRUE THEN stipend_id END)
      comment: "Number of tax reportable stipends"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to stipends"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer recognition program metrics tracking awards, milestones, and acknowledgment effectiveness"
  source: "`ngo_ecm`.`volunteer`.`recognition`"
  dimensions:
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition award"
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of recognition award"
    - name: "nominator_type"
      expr: nominator_type
      comment: "Type of nominator (e.g., peer, supervisor, beneficiary)"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether certificate was issued"
    - name: "public_acknowledgment_flag"
      expr: public_acknowledgment_flag
      comment: "Whether recognition was publicly acknowledged"
    - name: "channel"
      expr: channel
      comment: "Channel through which recognition was communicated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for monetary recognition value"
    - name: "hours_milestone_threshold"
      expr: hours_milestone_threshold
      comment: "Hours milestone threshold that triggered recognition"
    - name: "skills_category"
      expr: skills_category
      comment: "Skills category for which recognition was awarded"
    - name: "award_title"
      expr: award_title
      comment: "Title of the recognition award"
  measures:
    - name: "total_recognitions"
      expr: COUNT(DISTINCT recognition_id)
      comment: "Total number of recognition awards"
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of recognition awards"
    - name: "avg_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recognition award"
    - name: "certificates_issued"
      expr: COUNT(DISTINCT CASE WHEN certificate_issued_flag = TRUE THEN recognition_id END)
      comment: "Number of recognition certificates issued"
    - name: "public_acknowledgments"
      expr: COUNT(DISTINCT CASE WHEN public_acknowledgment_flag = TRUE THEN recognition_id END)
      comment: "Number of public acknowledgments made"
    - name: "recognitions_approved"
      expr: COUNT(DISTINCT CASE WHEN recognition_status = 'Approved' THEN recognition_id END)
      comment: "Number of recognition awards approved"
    - name: "unique_volunteers_recognized"
      expr: COUNT(DISTINCT volunteer_id)
      comment: "Number of unique volunteers who received recognition"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_incident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer safety and incident management metrics tracking incident severity, investigation outcomes, and corrective actions"
  source: "`ngo_ecm`.`volunteer`.`incident_report`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident reported"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_report_status"
      expr: incident_report_status
      comment: "Current status of the incident report"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of incident investigation"
    - name: "investigation_required"
      expr: investigation_required
      comment: "Whether investigation is required"
    - name: "medical_attention_required"
      expr: medical_attention_required
      comment: "Whether medical attention was required"
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained if applicable"
    - name: "insurance_claim_filed"
      expr: insurance_claim_filed
      comment: "Whether insurance claim was filed"
    - name: "police_report_filed"
      expr: police_report_filed
      comment: "Whether police report was filed"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the incident report"
  measures:
    - name: "total_incident_reports"
      expr: COUNT(DISTINCT incident_report_id)
      comment: "Total number of incident reports filed"
    - name: "incidents_requiring_medical_attention"
      expr: COUNT(DISTINCT CASE WHEN medical_attention_required = TRUE THEN incident_report_id END)
      comment: "Number of incidents requiring medical attention"
    - name: "incidents_requiring_investigation"
      expr: COUNT(DISTINCT CASE WHEN investigation_required = TRUE THEN incident_report_id END)
      comment: "Number of incidents requiring investigation"
    - name: "investigations_completed"
      expr: COUNT(DISTINCT CASE WHEN investigation_status = 'Completed' THEN incident_report_id END)
      comment: "Number of investigations completed"
    - name: "insurance_claims_filed"
      expr: COUNT(DISTINCT CASE WHEN insurance_claim_filed = TRUE THEN incident_report_id END)
      comment: "Number of incidents with insurance claims filed"
    - name: "police_reports_filed"
      expr: COUNT(DISTINCT CASE WHEN police_report_filed = TRUE THEN incident_report_id END)
      comment: "Number of incidents with police reports filed"
    - name: "incidents_resolved"
      expr: COUNT(DISTINCT CASE WHEN incident_report_status = 'Resolved' THEN incident_report_id END)
      comment: "Number of incident reports resolved"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`volunteer_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volunteer experience and satisfaction metrics tracking feedback sentiment, ratings, and follow-up effectiveness"
  source: "`ngo_ecm`.`volunteer`.`feedback`"
  dimensions:
    - name: "feedback_type"
      expr: feedback_type
      comment: "Type of feedback provided"
    - name: "channel"
      expr: channel
      comment: "Channel through which feedback was submitted"
    - name: "overall_satisfaction_rating"
      expr: overall_satisfaction_rating
      comment: "Overall satisfaction rating provided"
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up action on feedback"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether feedback requires escalation"
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether feedback was submitted anonymously"
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether feedback contains sensitive information"
    - name: "consent_to_follow_up"
      expr: consent_to_follow_up
      comment: "Whether volunteer consented to follow-up"
    - name: "would_volunteer_again"
      expr: would_volunteer_again
      comment: "Whether volunteer would volunteer again"
    - name: "net_promoter_score"
      expr: net_promoter_score
      comment: "Net promoter score provided"
  measures:
    - name: "total_feedback_submissions"
      expr: COUNT(DISTINCT feedback_id)
      comment: "Total number of feedback submissions"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across feedback"
    - name: "feedback_requiring_escalation"
      expr: COUNT(DISTINCT CASE WHEN escalation_required = TRUE THEN feedback_id END)
      comment: "Number of feedback items requiring escalation"
    - name: "follow_ups_completed"
      expr: COUNT(DISTINCT CASE WHEN follow_up_status = 'Completed' THEN feedback_id END)
      comment: "Number of feedback follow-ups completed"
    - name: "volunteers_willing_to_volunteer_again"
      expr: COUNT(DISTINCT CASE WHEN would_volunteer_again = TRUE THEN feedback_id END)
      comment: "Number of volunteers willing to volunteer again"
    - name: "anonymous_feedback_submissions"
      expr: COUNT(DISTINCT CASE WHEN is_anonymous = TRUE THEN feedback_id END)
      comment: "Number of anonymous feedback submissions"
    - name: "sensitive_feedback_submissions"
      expr: COUNT(DISTINCT CASE WHEN is_sensitive = TRUE THEN feedback_id END)
      comment: "Number of sensitive feedback submissions"
    - name: "feedback_with_follow_up_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_to_follow_up = TRUE THEN feedback_id END)
      comment: "Number of feedback submissions with follow-up consent"
$$;