-- Metric views for domain: candidate | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core candidate profile metrics tracking candidate acquisition, source effectiveness, and workforce authorization status"
  source: "`staffing_hr_ecm`.`candidate`.`profile`"
  dimensions:
    - name: "candidate_status"
      expr: candidate_status
      comment: "Current status of the candidate in the recruitment lifecycle"
    - name: "candidate_type"
      expr: candidate_type
      comment: "Classification of candidate (e.g., active, passive, employee referral)"
    - name: "source_channel_type"
      expr: source_channel_type
      comment: "Type of channel through which candidate was sourced (e.g., job board, referral, social media)"
    - name: "source_channel_name"
      expr: source_channel_name
      comment: "Specific name of the sourcing channel"
    - name: "work_authorization_status"
      expr: work_authorization_status
      comment: "Candidate's work authorization status (e.g., citizen, visa holder, requires sponsorship)"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the candidate"
    - name: "gender"
      expr: gender
      comment: "Gender of the candidate"
    - name: "country_code"
      expr: country_code
      comment: "Country code of candidate's location"
    - name: "state_province"
      expr: state_province
      comment: "State or province of candidate's location"
    - name: "sourcing_year"
      expr: YEAR(sourcing_date)
      comment: "Year the candidate was sourced"
    - name: "sourcing_month"
      expr: DATE_TRUNC('MONTH', sourcing_date)
      comment: "Month the candidate was sourced"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter for digital attribution"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter for digital attribution"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether candidate has provided GDPR consent"
    - name: "do_not_contact_flag"
      expr: do_not_contact_flag
      comment: "Whether candidate has requested not to be contacted"
  measures:
    - name: "total_candidates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidate profiles"
    - name: "avg_cost_per_source"
      expr: AVG(CAST(cost_per_source AS DOUBLE))
      comment: "Average cost per candidate by source channel, used to optimize recruitment spend"
    - name: "total_source_cost"
      expr: SUM(CAST(cost_per_source AS DOUBLE))
      comment: "Total recruitment sourcing cost across all candidates"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate assessment and screening metrics tracking pass rates, completion rates, and assessment quality"
  source: "`staffing_hr_ecm`.`candidate`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g., skills test, drug screen, background check, cognitive test)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., scheduled, completed, expired)"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Binary pass/fail outcome of the assessment"
    - name: "provider_name"
      expr: provider_name
      comment: "Name of the assessment provider or vendor"
    - name: "skill_category"
      expr: skill_category
      comment: "Category of skill being assessed"
    - name: "competency_level"
      expr: competency_level
      comment: "Level of competency measured (e.g., beginner, intermediate, expert)"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which assessment was delivered (e.g., online, in-person)"
    - name: "is_proctored"
      expr: is_proctored
      comment: "Whether the assessment was proctored"
    - name: "adverse_action_flag"
      expr: adverse_action_flag
      comment: "Whether adverse action was taken based on assessment results"
    - name: "administered_year"
      expr: YEAR(administered_date)
      comment: "Year the assessment was administered"
    - name: "administered_month"
      expr: DATE_TRUNC('MONTH', administered_date)
      comment: "Month the assessment was administered"
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT assessment_id)
      comment: "Total number of assessments administered"
    - name: "total_candidates_assessed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates who completed assessments"
    - name: "avg_normalized_score"
      expr: AVG(CAST(normalized_score AS DOUBLE))
      comment: "Average normalized assessment score across all assessments, used to benchmark candidate quality"
    - name: "avg_raw_score"
      expr: AVG(CAST(raw_score AS DOUBLE))
      comment: "Average raw assessment score"
    - name: "avg_percentile_rank"
      expr: AVG(CAST(percentile_rank AS DOUBLE))
      comment: "Average percentile rank of candidates, indicating relative performance"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate availability and placement readiness metrics tracking bench capacity and candidate preferences"
  source: "`staffing_hr_ecm`.`candidate`.`availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the candidate (e.g., available, on assignment, unavailable)"
    - name: "preferred_employment_type"
      expr: preferred_employment_type
      comment: "Candidate's preferred employment type (e.g., contract, permanent, temp-to-perm)"
    - name: "preferred_work_arrangement"
      expr: preferred_work_arrangement
      comment: "Candidate's preferred work arrangement (e.g., remote, hybrid, on-site)"
    - name: "preferred_shift"
      expr: preferred_shift
      comment: "Candidate's preferred work shift"
    - name: "geo_state"
      expr: geo_state
      comment: "Geographic state of candidate availability"
    - name: "geo_city"
      expr: geo_city
      comment: "Geographic city of candidate availability"
    - name: "willing_to_relocate"
      expr: willing_to_relocate
      comment: "Whether candidate is willing to relocate"
    - name: "willing_to_travel"
      expr: willing_to_travel
      comment: "Whether candidate is willing to travel"
    - name: "do_not_place_flag"
      expr: do_not_place_flag
      comment: "Whether candidate is flagged as do-not-place"
    - name: "redeployment_candidate"
      expr: redeployment_candidate
      comment: "Whether candidate is eligible for redeployment"
    - name: "worker_classification_preference"
      expr: worker_classification_preference
      comment: "Candidate's preferred worker classification (e.g., W2, 1099, corp-to-corp)"
  measures:
    - name: "total_available_candidates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with availability records, representing bench capacity"
    - name: "avg_desired_pay_rate_min"
      expr: AVG(CAST(desired_pay_rate_min AS DOUBLE))
      comment: "Average minimum desired pay rate across candidates, used for rate benchmarking"
    - name: "avg_desired_pay_rate_max"
      expr: AVG(CAST(desired_pay_rate_max AS DOUBLE))
      comment: "Average maximum desired pay rate across candidates"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate engagement and communication metrics tracking recruiter effectiveness and candidate responsiveness"
  source: "`staffing_hr_ecm`.`candidate`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g., phone call, email, text, in-person meeting)"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction"
    - name: "direction"
      expr: direction
      comment: "Direction of interaction (inbound vs outbound)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (e.g., completed, scheduled, cancelled)"
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the interaction (e.g., screening, follow-up, offer discussion)"
    - name: "interview_format"
      expr: interview_format
      comment: "Format of interview if applicable (e.g., phone, video, in-person)"
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of interview interaction"
    - name: "candidate_lifecycle_stage"
      expr: candidate_lifecycle_stage
      comment: "Lifecycle stage of candidate at time of interaction"
    - name: "sentiment_tag"
      expr: sentiment_tag
      comment: "Sentiment classification of the interaction"
    - name: "response_received"
      expr: response_received
      comment: "Whether a response was received from the candidate"
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the interaction met SLA targets"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the interaction was automated"
    - name: "interaction_year"
      expr: YEAR(interaction_timestamp)
      comment: "Year of the interaction"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of candidate interactions"
    - name: "total_candidates_contacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates contacted"
    - name: "total_recruiters_active"
      expr: COUNT(DISTINCT staff_profile_id)
      comment: "Total unique recruiters conducting interactions"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_pay_rate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pay rate and compensation agreement metrics tracking rate competitiveness and margin potential"
  source: "`staffing_hr_ecm`.`candidate`.`pay_rate_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the pay rate agreement (e.g., active, expired, pending)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (e.g., contract, contract-to-hire, direct hire)"
    - name: "flsa_exemption_status"
      expr: flsa_exemption_status
      comment: "FLSA exemption classification (exempt vs non-exempt)"
    - name: "prevailing_wage_flag"
      expr: prevailing_wage_flag
      comment: "Whether prevailing wage requirements apply"
    - name: "work_state_code"
      expr: work_state_code
      comment: "State code where work will be performed"
    - name: "workers_comp_code"
      expr: workers_comp_code
      comment: "Workers compensation classification code"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement became effective"
  measures:
    - name: "total_pay_agreements"
      expr: COUNT(DISTINCT pay_rate_agreement_id)
      comment: "Total number of pay rate agreements"
    - name: "total_candidates_with_agreements"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with pay rate agreements"
    - name: "avg_burden_rate_pct"
      expr: AVG(CAST(burden_rate_pct AS DOUBLE))
      comment: "Average burden rate percentage, used to calculate fully-loaded labor costs"
    - name: "avg_holiday_rate_multiplier"
      expr: AVG(CAST(holiday_rate_multiplier AS DOUBLE))
      comment: "Average holiday rate multiplier"
    - name: "avg_max_weekly_hours"
      expr: AVG(CAST(max_weekly_hours AS DOUBLE))
      comment: "Average maximum weekly hours across agreements"
    - name: "avg_min_guaranteed_hours"
      expr: AVG(CAST(min_guaranteed_hours AS DOUBLE))
      comment: "Average minimum guaranteed hours"
    - name: "avg_ot_threshold_hours"
      expr: AVG(CAST(ot_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours"
    - name: "avg_prevailing_wage_rate"
      expr: AVG(CAST(prevailing_wage_rate AS DOUBLE))
      comment: "Average prevailing wage rate where applicable"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_right_to_represent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Right-to-represent and candidate submission authorization metrics tracking compliance and exclusivity"
  source: "`staffing_hr_ecm`.`candidate`.`right_to_represent`"
  dimensions:
    - name: "rtr_status"
      expr: rtr_status
      comment: "Status of the right-to-represent (e.g., active, expired, revoked)"
    - name: "rtr_scope"
      expr: rtr_scope
      comment: "Scope of the RTR (e.g., client-specific, job-specific, general)"
    - name: "grant_method"
      expr: grant_method
      comment: "Method by which RTR was granted (e.g., electronic signature, verbal, written)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement the RTR covers"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the RTR is exclusive"
    - name: "is_revoked"
      expr: is_revoked
      comment: "Whether the RTR has been revoked"
    - name: "revocation_reason"
      expr: revocation_reason
      comment: "Reason for RTR revocation if applicable"
    - name: "candidate_acknowledged"
      expr: candidate_acknowledged
      comment: "Whether candidate has acknowledged the RTR"
    - name: "nda_required"
      expr: nda_required
      comment: "Whether NDA is required for this RTR"
    - name: "nda_signed"
      expr: nda_signed
      comment: "Whether NDA has been signed"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether there is a dispute on this RTR"
    - name: "grant_year"
      expr: YEAR(grant_timestamp)
      comment: "Year the RTR was granted"
    - name: "grant_month"
      expr: DATE_TRUNC('MONTH', grant_timestamp)
      comment: "Month the RTR was granted"
  measures:
    - name: "total_rtrs"
      expr: COUNT(DISTINCT right_to_represent_id)
      comment: "Total number of right-to-represent records"
    - name: "total_candidates_with_rtr"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with RTR authorization"
    - name: "total_clients_with_rtr"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Total unique clients with RTR agreements"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_skill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate skills inventory and proficiency metrics tracking skill supply and rate premiums"
  source: "`staffing_hr_ecm`.`candidate`.`skill`"
  dimensions:
    - name: "skill_name"
      expr: skill_name
      comment: "Name of the skill"
    - name: "normalized_skill_name"
      expr: normalized_skill_name
      comment: "Normalized/standardized skill name for consistent reporting"
    - name: "skill_category"
      expr: skill_category
      comment: "Category of the skill (e.g., technical, soft skill, certification)"
    - name: "subcategory"
      expr: subcategory
      comment: "Subcategory of the skill"
    - name: "proficiency_level"
      expr: proficiency_level
      comment: "Proficiency level (e.g., beginner, intermediate, advanced, expert)"
    - name: "skill_status"
      expr: skill_status
      comment: "Status of the skill (e.g., active, deprecated)"
    - name: "is_primary"
      expr: is_primary
      comment: "Whether this is a primary skill for the candidate"
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the skill has been verified"
    - name: "skill_source"
      expr: skill_source
      comment: "Source of the skill data (e.g., resume, assessment, self-reported)"
    - name: "redeployment_eligible"
      expr: redeployment_eligible
      comment: "Whether the skill makes candidate eligible for redeployment"
    - name: "taxonomy_source"
      expr: taxonomy_source
      comment: "Source of skill taxonomy (e.g., O*NET, proprietary)"
  measures:
    - name: "total_skill_records"
      expr: COUNT(DISTINCT skill_id)
      comment: "Total number of skill records"
    - name: "total_candidates_with_skills"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with documented skills"
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across all skill records"
    - name: "avg_proficiency_score"
      expr: AVG(CAST(proficiency_score AS DOUBLE))
      comment: "Average proficiency score across skills"
    - name: "avg_demand_index"
      expr: AVG(CAST(demand_index AS DOUBLE))
      comment: "Average demand index for skills, indicating market demand"
    - name: "avg_pay_rate_premium"
      expr: AVG(CAST(pay_rate_premium AS DOUBLE))
      comment: "Average pay rate premium associated with skills, used to price specialized talent"
    - name: "avg_billable_rate_premium"
      expr: AVG(CAST(billable_rate_premium AS DOUBLE))
      comment: "Average billable rate premium for skills, used to optimize margin on specialized skills"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate lifecycle and pipeline progression metrics tracking conversion rates and time-in-stage"
  source: "`staffing_hr_ecm`.`candidate`.`status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New status the candidate transitioned to"
    - name: "prior_status"
      expr: prior_status
      comment: "Previous status before the transition"
    - name: "transition_reason_code"
      expr: transition_reason_code
      comment: "Coded reason for the status transition"
    - name: "transition_trigger"
      expr: transition_trigger
      comment: "What triggered the status transition (e.g., user action, automated rule)"
    - name: "ats_workflow_step"
      expr: ats_workflow_step
      comment: "ATS workflow step associated with this status"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement (e.g., contract, permanent)"
    - name: "worker_type"
      expr: worker_type
      comment: "Type of worker classification"
    - name: "is_dnp"
      expr: is_dnp
      comment: "Whether this transition resulted in do-not-place status"
    - name: "dnp_reason_code"
      expr: dnp_reason_code
      comment: "Reason code for do-not-place status"
    - name: "is_fall_off"
      expr: is_fall_off
      comment: "Whether this represents a candidate fall-off from the pipeline"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for candidate rejection if applicable"
    - name: "interview_type"
      expr: interview_type
      comment: "Type of interview if status relates to interview"
    - name: "interview_outcome"
      expr: interview_outcome
      comment: "Outcome of interview if applicable"
    - name: "compliance_hold"
      expr: compliance_hold
      comment: "Whether candidate is on compliance hold"
    - name: "redeployment_eligible"
      expr: redeployment_eligible
      comment: "Whether candidate is eligible for redeployment at this stage"
    - name: "transition_year"
      expr: YEAR(transition_timestamp)
      comment: "Year of the status transition"
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the status transition"
  measures:
    - name: "total_status_transitions"
      expr: COUNT(DISTINCT status_history_id)
      comment: "Total number of status transitions, indicating pipeline activity volume"
    - name: "total_candidates_with_transitions"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with status transitions"
    - name: "total_orders_with_transitions"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Total unique job orders with candidate status transitions"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_talent_pool_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent pool composition and readiness metrics tracking bench quality and deployment readiness"
  source: "`staffing_hr_ecm`.`candidate`.`talent_pool_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Status of talent pool membership (e.g., active, inactive, deployed)"
    - name: "membership_type"
      expr: membership_type
      comment: "Type of membership (e.g., bench, pipeline, alumni)"
    - name: "availability_type"
      expr: availability_type
      comment: "Type of availability (e.g., immediate, 2-week notice, future)"
    - name: "primary_skill_category"
      expr: primary_skill_category
      comment: "Primary skill category of the candidate"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (e.g., W2, 1099, corp-to-corp)"
    - name: "preferred_work_type"
      expr: preferred_work_type
      comment: "Candidate's preferred work type"
    - name: "is_redeployment_candidate"
      expr: is_redeployment_candidate
      comment: "Whether candidate is flagged for redeployment"
    - name: "is_willing_to_relocate"
      expr: is_willing_to_relocate
      comment: "Whether candidate is willing to relocate"
    - name: "is_willing_to_travel"
      expr: is_willing_to_travel
      comment: "Whether candidate is willing to travel"
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status"
    - name: "drug_screen_status"
      expr: drug_screen_status
      comment: "Drug screen status"
    - name: "i9_verified"
      expr: i9_verified
      comment: "Whether I-9 has been verified"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the candidate in the pool"
    - name: "preferred_location_state"
      expr: preferred_location_state
      comment: "Candidate's preferred work location state"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which candidate was sourced into pool"
  measures:
    - name: "total_pool_memberships"
      expr: COUNT(DISTINCT talent_pool_membership_id)
      comment: "Total number of talent pool memberships"
    - name: "total_candidates_in_pools"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates in talent pools, representing bench capacity"
    - name: "total_talent_pools"
      expr: COUNT(DISTINCT talent_pool_id)
      comment: "Total unique talent pools"
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum pay rate for pool members"
    - name: "avg_pay_rate_max"
      expr: AVG(CAST(pay_rate_max AS DOUBLE))
      comment: "Average maximum pay rate for pool members"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_work_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate work experience and tenure metrics tracking experience quality and employment stability"
  source: "`staffing_hr_ecm`.`candidate`.`work_history`"
  dimensions:
    - name: "employer_name"
      expr: employer_name
      comment: "Name of the employer"
    - name: "job_title"
      expr: job_title
      comment: "Job title held by candidate"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (e.g., full-time, part-time, contract)"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the employer"
    - name: "job_function"
      expr: job_function
      comment: "Job function or department"
    - name: "management_level"
      expr: management_level
      comment: "Management level of the position"
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the candidate's current position"
    - name: "is_relevant_experience"
      expr: is_relevant_experience
      comment: "Whether this experience is relevant to target roles"
    - name: "is_staffing_agency_placement"
      expr: is_staffing_agency_placement
      comment: "Whether this was a staffing agency placement"
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the work history has been verified"
    - name: "has_employment_gap"
      expr: has_employment_gap
      comment: "Whether there is an employment gap before this position"
    - name: "reason_for_leaving"
      expr: reason_for_leaving
      comment: "Reason candidate left this position"
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (e.g., remote, on-site, hybrid)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for this position"
    - name: "employer_location_country"
      expr: employer_location_country
      comment: "Country of employer location"
    - name: "employer_location_state"
      expr: employer_location_state
      comment: "State of employer location"
  measures:
    - name: "total_work_history_records"
      expr: COUNT(DISTINCT work_history_id)
      comment: "Total number of work history records"
    - name: "total_candidates_with_history"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with work history"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for work history records"
    - name: "avg_reported_pay_rate"
      expr: AVG(CAST(reported_pay_rate AS DOUBLE))
      comment: "Average reported pay rate from work history, used for market rate benchmarking"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_education`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Candidate education and credential metrics tracking qualification levels and verification status"
  source: "`staffing_hr_ecm`.`candidate`.`education`"
  dimensions:
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree (e.g., Bachelor's, Master's, PhD, Associate)"
    - name: "degree_name"
      expr: degree_name
      comment: "Name of the degree"
    - name: "field_of_study"
      expr: field_of_study
      comment: "Field of study or major"
    - name: "major"
      expr: major
      comment: "Major area of study"
    - name: "institution_name"
      expr: institution_name
      comment: "Name of educational institution"
    - name: "institution_type"
      expr: institution_type
      comment: "Type of institution (e.g., university, college, technical school)"
    - name: "institution_country"
      expr: institution_country
      comment: "Country of institution"
    - name: "institution_state"
      expr: institution_state
      comment: "State of institution"
    - name: "is_accredited"
      expr: is_accredited
      comment: "Whether the institution is accredited"
    - name: "is_completed"
      expr: is_completed
      comment: "Whether the degree was completed"
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the education has been verified"
    - name: "is_highest_degree"
      expr: is_highest_degree
      comment: "Whether this is the candidate's highest degree"
    - name: "is_international_credential"
      expr: is_international_credential
      comment: "Whether this is an international credential"
    - name: "credential_evaluation_status"
      expr: credential_evaluation_status
      comment: "Status of credential evaluation for international degrees"
    - name: "graduation_year"
      expr: graduation_year
      comment: "Year of graduation"
  measures:
    - name: "total_education_records"
      expr: COUNT(DISTINCT education_id)
      comment: "Total number of education records"
    - name: "total_candidates_with_education"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with education records"
    - name: "avg_gpa"
      expr: AVG(CAST(gpa AS DOUBLE))
      comment: "Average GPA across education records"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for education records"
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`candidate_resume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resume quality and parsing effectiveness metrics tracking data completeness and skill extraction"
  source: "`staffing_hr_ecm`.`candidate`.`resume`"
  dimensions:
    - name: "file_format"
      expr: file_format
      comment: "Format of the resume file (e.g., PDF, DOCX, TXT)"
    - name: "parse_status"
      expr: parse_status
      comment: "Status of resume parsing (e.g., success, failed, pending)"
    - name: "parsing_engine"
      expr: parsing_engine
      comment: "Parsing engine used to extract resume data"
    - name: "is_parsed"
      expr: is_parsed
      comment: "Whether the resume has been parsed"
    - name: "is_active_version"
      expr: is_active_version
      comment: "Whether this is the active version of the resume"
    - name: "is_searchable"
      expr: is_searchable
      comment: "Whether the resume is searchable"
    - name: "upload_source"
      expr: upload_source
      comment: "Source from which resume was uploaded"
    - name: "source_job_board"
      expr: source_job_board
      comment: "Job board from which resume was sourced"
    - name: "language_code"
      expr: language_code
      comment: "Language of the resume"
    - name: "highest_education_level"
      expr: highest_education_level
      comment: "Highest education level parsed from resume"
    - name: "primary_skill_category"
      expr: primary_skill_category
      comment: "Primary skill category identified in resume"
    - name: "candidate_consent_flag"
      expr: candidate_consent_flag
      comment: "Whether candidate has consented to resume storage and use"
  measures:
    - name: "total_resumes"
      expr: COUNT(DISTINCT resume_id)
      comment: "Total number of resume records"
    - name: "total_candidates_with_resumes"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total unique candidates with resumes on file"
    - name: "avg_parse_confidence_score"
      expr: AVG(CAST(parse_confidence_score AS DOUBLE))
      comment: "Average parsing confidence score, indicating resume data quality"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average resume quality score, used to prioritize candidate outreach"
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience parsed from resumes"
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage size of all resume files"
$$;