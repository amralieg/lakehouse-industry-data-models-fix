-- Metric views for domain: credentialing | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_bgc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Background check order performance and compliance metrics tracking turnaround time, SLA adherence, adjudication outcomes, and screening component results"
  source: "`staffing_hr_ecm`.`credentialing`.`bgc_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the background check order (pending, in progress, completed, cancelled)"
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Final adjudication decision on the background check (clear, consider, adverse)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall background check result classification"
    - name: "screening_type"
      expr: screening_type
      comment: "Type of background screening performed (standard, enhanced, basic)"
    - name: "package_type"
      expr: package_type
      comment: "Background check package tier or bundle"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical for the background check (healthcare, finance, technology, etc.)"
    - name: "position_type"
      expr: position_type
      comment: "Type of position being screened for (permanent, temporary, contract)"
    - name: "sla_met_flag"
      expr: client_required
      comment: "Whether the background check was required by the client"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the background check order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the background check order was placed"
    - name: "completed_year"
      expr: YEAR(completed_date)
      comment: "Year the background check was completed"
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_date)
      comment: "Month the background check was completed"
  measures:
    - name: "total_bgc_orders"
      expr: COUNT(bgc_order_id)
      comment: "Total number of background check orders placed"
    - name: "total_candidates_screened"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates who underwent background screening"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks completed within SLA turnaround time"
    - name: "clear_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adjudication_status = 'clear' THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks resulting in clear adjudication"
    - name: "adverse_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_action_notice_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks triggering adverse action notices"
    - name: "criminal_fail_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN criminal_check_result IN ('fail', 'consider', 'adverse') THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks with criminal check concerns"
    - name: "drug_screen_fail_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drug_screen_result IN ('fail', 'positive', 'non-negative') THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks with failed drug screens"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_initiated_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks where candidate initiated a dispute"
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(bgc_order_id), 0), 2)
      comment: "Percentage of background checks with proper candidate consent obtained"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_credential_instance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential lifecycle and compliance metrics tracking credential validity, expiration risk, renewal activity, and placement eligibility across the candidate population"
  source: "`staffing_hr_ecm`.`credentialing`.`credential_instance`"
  dimensions:
    - name: "credential_category"
      expr: credential_category
      comment: "Category of credential (license, certification, training, background check, etc.)"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State or province that issued the credential"
    - name: "issuing_country"
      expr: issuing_country
      comment: "Country that issued the credential"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status of the credential (current, pending, expired, renewed)"
    - name: "placement_eligibility_flag"
      expr: is_placement_eligible
      comment: "Whether the credential status allows the candidate to be placed"
    - name: "clearance_level"
      expr: clearance_level
      comment: "Security clearance level if applicable (confidential, secret, top secret)"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the credential was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the credential was issued"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the credential expires"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the credential expires"
  measures:
    - name: "total_credentials"
      expr: COUNT(credential_instance_id)
      comment: "Total number of credential instances tracked"
    - name: "total_credentialed_candidates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates with at least one credential on file"
    - name: "placement_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_placement_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(credential_instance_id), 0), 2)
      comment: "Percentage of credentials that meet placement eligibility requirements"
    - name: "expired_credential_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN expiration_date < CURRENT_DATE THEN 1 ELSE 0 END) / NULLIF(COUNT(credential_instance_id), 0), 2)
      comment: "Percentage of credentials that have expired"
    - name: "expiring_soon_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 ELSE 0 END) / NULLIF(COUNT(credential_instance_id), 0), 2)
      comment: "Percentage of credentials expiring within the next 30 days"
    - name: "renewal_in_progress_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN renewal_status IN ('pending', 'in_progress', 'submitted') THEN 1 ELSE 0 END) / NULLIF(COUNT(credential_instance_id), 0), 2)
      comment: "Percentage of credentials currently undergoing renewal process"
    - name: "avg_ceu_completion_rate"
      expr: ROUND(100.0 * AVG(CASE WHEN CAST(ceu_required AS DOUBLE) > 0 THEN CAST(ceu_completed AS DOUBLE) / CAST(ceu_required AS DOUBLE) ELSE NULL END), 2)
      comment: "Average percentage of required continuing education units completed across credentials requiring CEUs"
    - name: "total_ceu_completed"
      expr: SUM(CAST(ceu_completed AS DOUBLE))
      comment: "Total continuing education units completed across all credentials"
    - name: "total_ceu_required"
      expr: SUM(CAST(ceu_required AS DOUBLE))
      comment: "Total continuing education units required across all credentials"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_readiness_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate placement readiness and compliance posture metrics tracking credential completeness, blocking issues, and time-to-ready for workforce deployment"
  source: "`staffing_hr_ecm`.`credentialing`.`readiness_status`"
  dimensions:
    - name: "overall_status"
      expr: overall_status
      comment: "Overall readiness status of the candidate (ready, pending, blocked, incomplete)"
    - name: "placement_eligible_flag"
      expr: placement_eligible
      comment: "Whether the candidate is currently eligible for placement"
    - name: "compliance_hold_flag"
      expr: compliance_hold
      comment: "Whether the candidate is on compliance hold preventing placement"
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check completion status (clear, pending, consider, adverse)"
    - name: "drug_screen_status"
      expr: drug_screen_status
      comment: "Drug screening status (pass, fail, pending, not required)"
    - name: "i9_status"
      expr: i9_status
      comment: "I-9 employment eligibility verification status"
    - name: "everify_status"
      expr: everify_status
      comment: "E-Verify electronic employment verification status"
    - name: "license_verification_status"
      expr: license_verification_status
      comment: "Professional license verification status"
    - name: "skills_assessment_status"
      expr: skills_assessment_status
      comment: "Skills assessment completion status"
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Required training completion status"
    - name: "vms_clearance_status"
      expr: vms_clearance_status
      comment: "Vendor management system clearance status"
    - name: "staffing_vertical"
      expr: staffing_vertical
      comment: "Staffing industry vertical (healthcare, IT, finance, industrial, etc.)"
    - name: "evaluation_year"
      expr: YEAR(last_evaluated_date)
      comment: "Year of most recent readiness evaluation"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', last_evaluated_date)
      comment: "Month of most recent readiness evaluation"
  measures:
    - name: "total_readiness_evaluations"
      expr: COUNT(readiness_status_id)
      comment: "Total number of candidate readiness evaluations performed"
    - name: "total_candidates_evaluated"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates with readiness evaluations"
    - name: "placement_ready_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN placement_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates currently eligible for placement"
    - name: "compliance_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_hold = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates on compliance hold"
    - name: "credential_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outstanding_credential_count = '0' THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates with all required credentials completed"
    - name: "bgc_clear_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN bgc_status = 'clear' THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates with clear background check status"
    - name: "drug_screen_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drug_screen_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates with passed drug screening"
    - name: "i9_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN i9_status = 'complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates with completed I-9 verification"
    - name: "everify_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN everify_status = 'employment_authorized' THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates with successful E-Verify authorization"
    - name: "vms_clearance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vms_clearance_status = 'cleared' THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates cleared in vendor management systems"
    - name: "client_requirements_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN client_specific_requirements_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(readiness_status_id), 0), 2)
      comment: "Percentage of candidates meeting all client-specific credentialing requirements"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_license_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional license verification performance and compliance metrics tracking verification turnaround, license validity, expiration risk, and regulatory compliance"
  source: "`staffing_hr_ecm`.`credentialing`.`license_verification`"
  dimensions:
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Result of the license verification (verified, not verified, expired, invalid)"
    - name: "license_status_at_verification"
      expr: license_status_at_verification
      comment: "Status of the license at time of verification (active, expired, suspended, revoked)"
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the professional license"
    - name: "issuing_country"
      expr: issuing_country
      comment: "Country that issued the professional license"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the license (primary source, online registry, phone, etc.)"
    - name: "compact_license_flag"
      expr: is_compact_license
      comment: "Whether the license is a multi-state compact license"
    - name: "adverse_action_flag"
      expr: adverse_action_flag
      comment: "Whether the verification triggered adverse action"
    - name: "client_required_flag"
      expr: client_required_flag
      comment: "Whether the license verification was required by the client"
    - name: "recheck_required_flag"
      expr: recheck_required
      comment: "Whether the license requires re-verification"
    - name: "staffing_vertical"
      expr: staffing_vertical
      comment: "Staffing industry vertical (healthcare, legal, finance, etc.)"
    - name: "verification_year"
      expr: YEAR(verification_date)
      comment: "Year the license verification was performed"
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_date)
      comment: "Month the license verification was performed"
    - name: "expiration_year"
      expr: YEAR(license_expiration_date)
      comment: "Year the license expires"
  measures:
    - name: "total_license_verifications"
      expr: COUNT(license_verification_id)
      comment: "Total number of professional license verifications performed"
    - name: "total_candidates_verified"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates who underwent license verification"
    - name: "verification_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_outcome = 'verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(license_verification_id), 0), 2)
      comment: "Percentage of license verifications that successfully confirmed valid licenses"
    - name: "active_license_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN license_status_at_verification = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(license_verification_id), 0), 2)
      comment: "Percentage of verified licenses that were active at time of verification"
    - name: "expired_license_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN license_status_at_verification = 'expired' THEN 1 ELSE 0 END) / NULLIF(COUNT(license_verification_id), 0), 2)
      comment: "Percentage of verified licenses that were expired at time of verification"
    - name: "adverse_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_action_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(license_verification_id), 0), 2)
      comment: "Percentage of license verifications triggering adverse action"
    - name: "recheck_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recheck_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(license_verification_id), 0), 2)
      comment: "Percentage of license verifications requiring follow-up re-verification"
    - name: "compact_license_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_compact_license = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(license_verification_id), 0), 2)
      comment: "Percentage of verified licenses that are multi-state compact licenses"
    - name: "total_verification_cost"
      expr: SUM(CAST(verification_cost AS DOUBLE))
      comment: "Total cost incurred for all license verifications"
    - name: "avg_verification_cost"
      expr: AVG(CAST(verification_cost AS DOUBLE))
      comment: "Average cost per license verification"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_drug_screen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug screening program performance and compliance metrics tracking pass rates, turnaround time, DOT compliance, MRO review outcomes, and specimen validity"
  source: "`staffing_hr_ecm`.`credentialing`.`drug_screen`"
  dimensions:
    - name: "screen_status"
      expr: screen_status
      comment: "Current status of the drug screen (pending, completed, cancelled)"
    - name: "result_status"
      expr: result_status
      comment: "Result status of the drug screen (negative, positive, dilute, invalid, cancelled)"
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Final pass/fail determination for the drug screen"
    - name: "mro_decision"
      expr: mro_decision
      comment: "Medical Review Officer final decision (negative, positive, test cancelled)"
    - name: "mro_review_status"
      expr: mro_review_status
      comment: "Status of MRO review process"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected (urine, hair, oral fluid, blood)"
    - name: "dot_regulated_flag"
      expr: is_dot_regulated
      comment: "Whether the drug screen is DOT-regulated"
    - name: "observed_collection_flag"
      expr: is_observed_collection
      comment: "Whether the specimen collection was directly observed"
    - name: "recollection_required_flag"
      expr: recollection_required
      comment: "Whether a recollection was required due to specimen issues"
    - name: "consent_obtained_flag"
      expr: candidate_consent_obtained
      comment: "Whether candidate consent was properly obtained"
    - name: "collection_year"
      expr: YEAR(collection_date)
      comment: "Year the specimen was collected"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month the specimen was collected"
    - name: "result_year"
      expr: YEAR(result_date)
      comment: "Year the drug screen result was finalized"
  measures:
    - name: "total_drug_screens"
      expr: COUNT(drug_screen_id)
      comment: "Total number of drug screens performed"
    - name: "total_candidates_screened"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates who underwent drug screening"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_determination = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens resulting in pass determination"
    - name: "fail_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_determination = 'fail' THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens resulting in fail determination"
    - name: "positive_result_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN result_status = 'positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens with positive laboratory results"
    - name: "mro_negative_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mro_decision = 'negative' THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens with MRO negative decision"
    - name: "dilute_specimen_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN result_status = 'dilute' THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens with dilute specimen results"
    - name: "recollection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recollection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens requiring specimen recollection"
    - name: "dot_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_dot_regulated = TRUE AND pass_fail_determination = 'pass' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_dot_regulated = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Pass rate for DOT-regulated drug screens"
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN candidate_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(drug_screen_id), 0), 2)
      comment: "Percentage of drug screens with proper candidate consent obtained"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training program effectiveness and compliance metrics tracking completion rates, pass rates, CEU attainment, and mandatory training adherence"
  source: "`staffing_hr_ecm`.`credentialing`.`training_record`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Training completion status (completed, in progress, not started, expired)"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result for the training"
    - name: "course_code"
      expr: course_code
      comment: "Unique code identifying the training course"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (online, in-person, virtual instructor-led, self-paced)"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of training provider (internal, external, vendor, client)"
    - name: "mandatory_flag"
      expr: is_mandatory
      comment: "Whether the training is mandatory for the candidate"
    - name: "client_required_flag"
      expr: is_client_required
      comment: "Whether the training is required by the client"
    - name: "placement_prerequisite_flag"
      expr: is_placement_prerequisite
      comment: "Whether the training is a prerequisite for placement"
    - name: "renewal_required_flag"
      expr: renewal_required
      comment: "Whether the training requires periodic renewal"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical for the training (healthcare, safety, compliance, technical)"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year the candidate enrolled in the training"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the candidate enrolled in the training"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the training was completed"
  measures:
    - name: "total_training_records"
      expr: COUNT(training_record_id)
      comment: "Total number of training records tracked"
    - name: "total_candidates_trained"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates with training records"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(training_record_id), 0), 2)
      comment: "Percentage of training records with completed status"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_result = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(training_record_id), 0), 2)
      comment: "Percentage of training records with pass result"
    - name: "mandatory_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mandatory = TRUE AND completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Completion rate for mandatory training courses"
    - name: "client_required_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_client_required = TRUE AND completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_client_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Completion rate for client-required training"
    - name: "placement_prerequisite_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_placement_prerequisite = TRUE AND completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_placement_prerequisite = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Completion rate for training that is a placement prerequisite"
    - name: "total_ceu_earned"
      expr: SUM(CAST(ceu_credits_earned AS DOUBLE))
      comment: "Total continuing education units earned across all training"
    - name: "avg_ceu_per_training"
      expr: AVG(CAST(ceu_credits_earned AS DOUBLE))
      comment: "Average continuing education units earned per training record"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours delivered across all records"
    - name: "avg_training_duration"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training duration in hours per record"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_skills_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Skills assessment program performance metrics tracking pass rates, proficiency levels, score distributions, and assessment validity for candidate qualification"
  source: "`staffing_hr_ecm`.`credentialing`.`skills_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the skills assessment (scheduled, in progress, completed, cancelled)"
    - name: "result_status"
      expr: result_status
      comment: "Result status of the assessment (pass, fail, pending review, incomplete)"
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Proficiency level achieved (novice, intermediate, advanced, expert)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of skills assessment (technical, behavioral, cognitive, job-specific)"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which assessment was delivered (online, in-person, phone, video)"
    - name: "proctored_flag"
      expr: is_proctored
      comment: "Whether the assessment was proctored"
    - name: "current_result_flag"
      expr: is_current_result
      comment: "Whether this is the most current assessment result for the candidate"
    - name: "provider_type"
      expr: provider_type
      comment: "Type of assessment provider (internal, third-party, client-provided)"
    - name: "language"
      expr: language
      comment: "Language in which the assessment was administered"
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_applied
      comment: "Whether ADA accommodations were applied"
    - name: "staffing_vertical"
      expr: staffing_vertical
      comment: "Staffing industry vertical for the assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was taken"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was taken"
  measures:
    - name: "total_assessments"
      expr: COUNT(skills_assessment_id)
      comment: "Total number of skills assessments administered"
    - name: "total_candidates_assessed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates who took skills assessments"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN result_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(skills_assessment_id), 0), 2)
      comment: "Percentage of skills assessments resulting in pass status"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN assessment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(skills_assessment_id), 0), 2)
      comment: "Percentage of skills assessments that were completed"
    - name: "avg_score_percentage"
      expr: AVG(CAST(score_percentage AS DOUBLE))
      comment: "Average score percentage across all assessments"
    - name: "avg_raw_score"
      expr: AVG(CAST(raw_score AS DOUBLE))
      comment: "Average raw score across all assessments"
    - name: "avg_percentile_rank"
      expr: AVG(CAST(percentile_rank AS DOUBLE))
      comment: "Average percentile rank of candidates across all assessments"
    - name: "advanced_proficiency_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN proficiency_level IN ('advanced', 'expert') THEN 1 ELSE 0 END) / NULLIF(COUNT(skills_assessment_id), 0), 2)
      comment: "Percentage of assessments achieving advanced or expert proficiency"
    - name: "proctored_assessment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_proctored = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(skills_assessment_id), 0), 2)
      comment: "Percentage of assessments that were proctored"
    - name: "ada_accommodation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ada_accommodation_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(skills_assessment_id), 0), 2)
      comment: "Percentage of assessments where ADA accommodations were applied"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`credentialing_work_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work authorization and immigration compliance metrics tracking visa status, E-Verify compliance, sponsorship requirements, and work eligibility for candidate placement"
  source: "`staffing_hr_ecm`.`credentialing`.`work_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current work authorization status (authorized, pending, expired, denied)"
    - name: "visa_category"
      expr: visa_category
      comment: "Visa category or classification (H-1B, L-1, TN, F-1 OPT, Green Card, etc.)"
    - name: "country_of_authorization"
      expr: country_of_authorization
      comment: "Country where work authorization is valid"
    - name: "unrestricted_work_flag"
      expr: authorized_to_work_unrestricted
      comment: "Whether the candidate is authorized to work without restrictions"
    - name: "sponsorship_required_flag"
      expr: sponsorship_required
      comment: "Whether the candidate requires visa sponsorship"
    - name: "placement_restriction_flag"
      expr: placement_restriction_flag
      comment: "Whether there are placement restrictions due to work authorization"
    - name: "reverification_required_flag"
      expr: reverification_required
      comment: "Whether work authorization requires reverification"
    - name: "opt_stem_extension_flag"
      expr: opt_stem_extension
      comment: "Whether the candidate has OPT STEM extension"
    - name: "i140_approved_flag"
      expr: i140_approved
      comment: "Whether the candidate has an approved I-140 immigrant petition"
    - name: "cap_exempt_flag"
      expr: cap_exempt
      comment: "Whether the visa is cap-exempt (not subject to H-1B lottery)"
    - name: "portability_eligible_flag"
      expr: portability_eligible
      comment: "Whether the visa allows portability to new employer"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify work authorization (E-Verify, I-9, document review)"
    - name: "staffing_vertical"
      expr: staffing_vertical
      comment: "Staffing industry vertical"
    - name: "authorized_start_year"
      expr: YEAR(authorized_start_date)
      comment: "Year work authorization became effective"
    - name: "authorized_end_year"
      expr: YEAR(authorized_end_date)
      comment: "Year work authorization expires"
  measures:
    - name: "total_work_authorizations"
      expr: COUNT(work_authorization_id)
      comment: "Total number of work authorization records tracked"
    - name: "total_candidates_tracked"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique count of candidates with work authorization records"
    - name: "authorized_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_status = 'authorized' THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of work authorization records with authorized status"
    - name: "unrestricted_work_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorized_to_work_unrestricted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of candidates authorized to work without restrictions"
    - name: "sponsorship_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sponsorship_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of candidates requiring visa sponsorship"
    - name: "placement_restriction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN placement_restriction_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of candidates with placement restrictions due to work authorization"
    - name: "reverification_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reverification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of work authorizations requiring reverification"
    - name: "expired_authorization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorized_end_date < CURRENT_DATE THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of work authorizations that have expired"
    - name: "expiring_soon_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorized_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of work authorizations expiring within the next 90 days"
    - name: "i140_approved_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN i140_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(work_authorization_id), 0), 2)
      comment: "Percentage of candidates with approved I-140 immigrant petitions"
$$;