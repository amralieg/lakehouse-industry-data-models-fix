-- Metric views for domain: safeguarding | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safeguarding incident metrics tracking incident volume, severity distribution, investigation outcomes, and response timeliness for organizational accountability and donor reporting"
  source: "`ngo_ecm`.`safeguarding`.`safeguarding_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safeguarding incident (SEA, child abuse, harassment, etc.)"
    - name: "incident_subtype"
      expr: subtype
      comment: "Detailed subtype classification of the incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (critical, high, medium, low)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (reported, under investigation, closed, etc.)"
    - name: "alleged_perpetrator_type"
      expr: alleged_perpetrator_type
      comment: "Type of alleged perpetrator (staff, partner, beneficiary, external, etc.)"
    - name: "reporter_type"
      expr: reporter_type
      comment: "Type of person reporting the incident (beneficiary, staff, community member, etc.)"
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (hotline, email, in-person, etc.)"
    - name: "location_country"
      expr: location_country
      comment: "Country where the incident occurred"
    - name: "location_region"
      expr: location_region
      comment: "Region where the incident occurred"
    - name: "survivor_gender"
      expr: survivor_gender
      comment: "Gender of the survivor"
    - name: "survivor_age_group"
      expr: survivor_age_group
      comment: "Age group of the survivor"
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (substantiated, unsubstantiated, inconclusive, etc.)"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year when the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month when the incident occurred"
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year when the incident was reported"
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month when the incident was reported"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safeguarding incidents reported"
    - name: "incidents_with_survivors"
      expr: SUM(CASE WHEN survivor_involved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents involving identified survivors"
    - name: "incidents_requiring_investigation"
      expr: SUM(CASE WHEN investigation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents flagged as requiring formal investigation"
    - name: "incidents_with_law_enforcement_notification"
      expr: SUM(CASE WHEN law_enforcement_notified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents where law enforcement was notified"
    - name: "incidents_with_donor_notification"
      expr: SUM(CASE WHEN donor_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring donor notification"
    - name: "incidents_with_survivor_support"
      expr: SUM(CASE WHEN survivor_support_provided_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents where survivor support was provided"
    - name: "incidents_with_referrals"
      expr: SUM(CASE WHEN referral_made_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents where external referrals were made"
    - name: "incidents_with_disciplinary_action"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_action_taken IS NOT NULL THEN safeguarding_incident_id END)
      comment: "Number of incidents resulting in disciplinary action"
    - name: "pct_incidents_with_survivor_support"
      expr: ROUND(100.0 * SUM(CASE WHEN survivor_support_provided_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents where survivor support was provided - key quality indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigation performance metrics tracking investigation timeliness, completion rates, outcomes, and resource utilization for accountability and process improvement"
  source: "`ngo_ecm`.`safeguarding`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (formal, preliminary, external, etc.)"
    - name: "investigation_category"
      expr: investigation_category
      comment: "Category of investigation (SEA, fraud, misconduct, etc.)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "final_determination"
      expr: final_determination
      comment: "Final determination of the investigation (substantiated, unsubstantiated, etc.)"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the investigation"
    - name: "investigation_start_year"
      expr: YEAR(start_date)
      comment: "Year when the investigation started"
    - name: "investigation_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the investigation started"
    - name: "investigation_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year when the investigation was completed"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations conducted"
    - name: "completed_investigations"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN investigation_id END)
      comment: "Number of investigations that have been completed"
    - name: "investigations_with_law_enforcement_referral"
      expr: SUM(CASE WHEN law_enforcement_referral_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of investigations referred to law enforcement"
    - name: "investigations_requiring_external_reporting"
      expr: SUM(CASE WHEN external_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of investigations requiring external reporting to donors or authorities"
    - name: "total_investigation_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of investigations in USD"
    - name: "avg_investigation_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per investigation in USD"
    - name: "total_interviews_conducted"
      expr: SUM(CAST(interviews_conducted_count AS DOUBLE))
      comment: "Total number of interviews conducted across all investigations"
    - name: "total_evidence_items_collected"
      expr: SUM(CAST(evidence_items_collected_count AS DOUBLE))
      comment: "Total number of evidence items collected across all investigations"
    - name: "avg_interviews_per_investigation"
      expr: AVG(CAST(interviews_conducted_count AS DOUBLE))
      comment: "Average number of interviews conducted per investigation"
    - name: "pct_investigations_completed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN investigation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that have been completed - key performance indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_survivor_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survivor support metrics tracking survivor demographics, support provision, case management, and confidentiality compliance for survivor-centered response"
  source: "`ngo_ecm`.`safeguarding`.`survivor_record`"
  dimensions:
    - name: "survivor_type"
      expr: survivor_type
      comment: "Type of survivor (direct, indirect, witness, etc.)"
    - name: "gender"
      expr: gender
      comment: "Gender of the survivor"
    - name: "age_group"
      expr: age_group
      comment: "Age group of the survivor"
    - name: "support_status"
      expr: support_status
      comment: "Current status of support provision (active, completed, declined, etc.)"
    - name: "consent_status"
      expr: consent_status
      comment: "Status of survivor consent for support and data processing"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the survivor referral"
    - name: "access_restriction_level"
      expr: access_restriction_level
      comment: "Access restriction level for survivor data"
    - name: "case_closure_reason"
      expr: case_closure_reason
      comment: "Reason for case closure"
    - name: "support_start_year"
      expr: YEAR(support_start_date)
      comment: "Year when support started"
    - name: "support_start_month"
      expr: DATE_TRUNC('MONTH', support_start_date)
      comment: "Month when support started"
  measures:
    - name: "total_survivors"
      expr: COUNT(1)
      comment: "Total number of survivor records"
    - name: "survivors_receiving_medical_support"
      expr: SUM(CASE WHEN medical_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received medical support"
    - name: "survivors_receiving_psychosocial_support"
      expr: SUM(CASE WHEN psychosocial_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received psychosocial support"
    - name: "survivors_receiving_legal_support"
      expr: SUM(CASE WHEN legal_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received legal support"
    - name: "survivors_receiving_economic_support"
      expr: SUM(CASE WHEN economic_support_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors who received economic support"
    - name: "survivors_with_external_referrals"
      expr: SUM(CASE WHEN external_referral_made = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors referred to external support services"
    - name: "survivors_with_safety_plans"
      expr: SUM(CASE WHEN safety_plan_in_place = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivors with documented safety plans"
    - name: "survivors_with_confidentiality_breaches"
      expr: SUM(CASE WHEN confidentiality_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of survivor records with documented confidentiality breaches - critical compliance metric"
    - name: "pct_survivors_with_psychosocial_support"
      expr: ROUND(100.0 * SUM(CASE WHEN psychosocial_support_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survivors receiving psychosocial support - key quality indicator"
    - name: "pct_survivors_with_safety_plans"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_plan_in_place = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survivors with safety plans - key protection indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance metrics tracking completion rates, assessment performance, certification status, and overdue training for workforce safeguarding capacity"
  source: "`ngo_ecm`.`safeguarding`.`safeguarding_training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of training completion (completed, in progress, not started, etc.)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the training assessment"
    - name: "participant_type"
      expr: participant_type
      comment: "Type of participant (staff, partner, volunteer, etc.)"
    - name: "completion_channel"
      expr: completion_channel
      comment: "Channel through which training was completed (online, in-person, hybrid, etc.)"
    - name: "language"
      expr: language
      comment: "Language in which training was delivered"
    - name: "training_location"
      expr: training_location
      comment: "Location where training was conducted"
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Whether the training is mandatory"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a certificate was issued"
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Whether the training is overdue"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year when training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when training was completed"
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completion records"
    - name: "completed_trainings"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN safeguarding_training_completion_id END)
      comment: "Number of trainings that have been completed"
    - name: "passed_trainings"
      expr: COUNT(DISTINCT CASE WHEN pass_fail_status = 'pass' THEN safeguarding_training_completion_id END)
      comment: "Number of trainings that were passed"
    - name: "mandatory_trainings"
      expr: SUM(CASE WHEN mandatory_training_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of mandatory training completions"
    - name: "overdue_trainings"
      expr: SUM(CASE WHEN overdue_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of overdue training completions - critical compliance metric"
    - name: "certificates_issued"
      expr: SUM(CASE WHEN certificate_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of certificates issued"
    - name: "total_training_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of training in USD"
    - name: "avg_training_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training completion in USD"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours"
    - name: "pct_trainings_completed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN safeguarding_training_completion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings completed - key compliance indicator"
    - name: "pct_trainings_passed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_status = 'pass' THEN safeguarding_training_completion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings passed - key quality indicator"
    - name: "pct_trainings_overdue"
      expr: ROUND(100.0 * SUM(CASE WHEN overdue_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trainings overdue - critical compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safeguarding audit performance metrics tracking audit completion, findings severity, compliance scores, and corrective action requirements for governance and accountability"
  source: "`ngo_ecm`.`safeguarding`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, donor-mandated, etc.)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (PSEA, safeguarding, compliance, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit (country office, program, organization-wide, etc.)"
    - name: "overall_safeguarding_maturity_rating"
      expr: overall_safeguarding_maturity_rating
      comment: "Overall safeguarding maturity rating from the audit"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the audit"
    - name: "commissioning_organization"
      expr: commissioning_organization
      comment: "Organization that commissioned the audit"
    - name: "audit_start_year"
      expr: YEAR(start_date)
      comment: "Year when the audit started"
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the audit started"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safeguarding audits conducted"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring corrective action plans"
    - name: "audits_requiring_follow_up"
      expr: SUM(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring follow-up audits"
    - name: "audits_requiring_external_reporting"
      expr: SUM(CASE WHEN external_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring external reporting"
    - name: "audits_with_management_response"
      expr: SUM(CASE WHEN management_response_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits with received management responses"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits - key performance indicator"
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of audits in USD"
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per audit in USD"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total number of major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total number of minor findings across all audits"
    - name: "total_recommendations"
      expr: SUM(CAST(recommendations_count AS DOUBLE))
      comment: "Total number of recommendations issued across all audits"
    - name: "total_interviews_conducted"
      expr: SUM(CAST(interviews_conducted_count AS DOUBLE))
      comment: "Total number of interviews conducted during audits"
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average number of critical findings per audit - key risk indicator"
    - name: "pct_audits_requiring_corrective_action"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action plans - key governance indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_partner_psea_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner PSEA capacity assessment metrics tracking partner safeguarding readiness, capacity scores, critical gaps, and capacity building needs for partnership risk management"
  source: "`ngo_ecm`.`safeguarding`.`partner_psea_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of PSEA assessment (initial, reassessment, light-touch, etc.)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment"
    - name: "overall_capacity_rating"
      expr: overall_capacity_rating
      comment: "Overall PSEA capacity rating of the partner"
    - name: "partnership_approval_status"
      expr: partnership_approval_status
      comment: "Approval status for partnership based on assessment"
    - name: "policy_existence_rating"
      expr: policy_existence_rating
      comment: "Rating for existence of PSEA policies"
    - name: "reporting_mechanism_rating"
      expr: reporting_mechanism_rating
      comment: "Rating for reporting mechanism adequacy"
    - name: "staff_training_rating"
      expr: staff_training_rating
      comment: "Rating for staff training on PSEA"
    - name: "investigation_capacity_rating"
      expr: investigation_capacity_rating
      comment: "Rating for investigation capacity"
    - name: "survivor_support_rating"
      expr: survivor_support_rating
      comment: "Rating for survivor support mechanisms"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when the assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month when the assessment was conducted"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of partner PSEA assessments conducted"
    - name: "assessments_with_critical_gaps"
      expr: SUM(CASE WHEN critical_gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments identifying critical gaps - key risk indicator"
    - name: "assessments_triggering_capacity_building"
      expr: SUM(CASE WHEN capacity_building_plan_triggered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments triggering capacity building plans"
    - name: "assessments_requiring_reassessment"
      expr: SUM(CASE WHEN reassessment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments requiring follow-up reassessment"
    - name: "completed_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_completion_date IS NOT NULL THEN partner_psea_assessment_id END)
      comment: "Number of completed assessments"
    - name: "approved_assessments"
      expr: COUNT(DISTINCT CASE WHEN approval_date IS NOT NULL THEN partner_psea_assessment_id END)
      comment: "Number of approved assessments"
    - name: "avg_capacity_score"
      expr: AVG(CAST(capacity_score AS DOUBLE))
      comment: "Average PSEA capacity score across all partner assessments - key performance indicator"
    - name: "avg_maximum_possible_score"
      expr: AVG(CAST(maximum_possible_score AS DOUBLE))
      comment: "Average maximum possible score across assessments"
    - name: "pct_assessments_with_critical_gaps"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_gap_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with critical gaps - critical partnership risk indicator"
    - name: "pct_assessments_completed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN assessment_completion_date IS NOT NULL THEN partner_psea_assessment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments completed - key process indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_audit_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit recommendation implementation metrics tracking recommendation closure rates, overdue actions, implementation progress, and verification outcomes for accountability and continuous improvement"
  source: "`ngo_ecm`.`safeguarding`.`audit_recommendation`"
  dimensions:
    - name: "recommendation_type"
      expr: recommendation_type
      comment: "Type of recommendation (policy, process, training, resource, etc.)"
    - name: "recommendation_category"
      expr: recommendation_category
      comment: "Category of recommendation (PSEA, safeguarding, compliance, etc.)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the recommendation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the recommendation (critical, high, medium, low)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level if recommendation is not implemented"
    - name: "management_acceptance_status"
      expr: management_acceptance_status
      comment: "Management acceptance status of the recommendation"
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of verification of implementation"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for implementing the recommendation"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year when recommendation is targeted for completion"
  measures:
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of audit recommendations issued"
    - name: "recommendations_requiring_budget"
      expr: SUM(CASE WHEN budget_allocated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recommendations requiring budget allocation"
    - name: "recommendations_requiring_donor_reporting"
      expr: SUM(CASE WHEN donor_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recommendations requiring donor reporting"
    - name: "recommendations_requiring_follow_up"
      expr: SUM(CASE WHEN follow_up_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recommendations requiring follow-up action"
    - name: "recommendations_requiring_verification"
      expr: SUM(CASE WHEN verification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recommendations requiring verification"
    - name: "verified_recommendations"
      expr: COUNT(DISTINCT CASE WHEN verification_date IS NOT NULL THEN audit_recommendation_id END)
      comment: "Number of recommendations that have been verified"
    - name: "completed_recommendations"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN audit_recommendation_id END)
      comment: "Number of recommendations that have been completed"
    - name: "total_implementation_cost_usd"
      expr: SUM(CAST(implementation_cost_usd AS DOUBLE))
      comment: "Total cost of implementing recommendations in USD"
    - name: "avg_implementation_cost_usd"
      expr: AVG(CAST(implementation_cost_usd AS DOUBLE))
      comment: "Average cost per recommendation implementation in USD"
    - name: "avg_implementation_progress_pct"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all recommendations"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average number of days overdue for recommendations"
    - name: "pct_recommendations_completed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN audit_recommendation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations completed - key accountability indicator"
    - name: "pct_recommendations_verified"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN verification_date IS NOT NULL THEN audit_recommendation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations verified - key quality assurance indicator"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`safeguarding_alleged_perpetrator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alleged perpetrator case management metrics tracking investigation outcomes, disciplinary actions, criminal referrals, and misconduct database reporting for accountability and organizational protection"
  source: "`ngo_ecm`.`safeguarding`.`alleged_perpetrator`"
  dimensions:
    - name: "allegation_type"
      expr: allegation_type
      comment: "Type of allegation (SEA, harassment, fraud, etc.)"
    - name: "allegation_severity"
      expr: allegation_severity
      comment: "Severity level of the allegation"
    - name: "relationship_to_organization"
      expr: relationship_to_organization
      comment: "Relationship of alleged perpetrator to the organization (staff, partner, volunteer, etc.)"
    - name: "employment_status_at_incident"
      expr: employment_status_at_incident
      comment: "Employment status at the time of the incident"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the investigation (substantiated, unsubstantiated, etc.)"
    - name: "case_outcome"
      expr: case_outcome
      comment: "Final outcome of the case"
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Rehire eligibility status"
    - name: "country_office_at_incident"
      expr: country_office_at_incident
      comment: "Country office where the incident occurred"
    - name: "allegation_year"
      expr: YEAR(allegation_date)
      comment: "Year when the allegation was made"
    - name: "allegation_month"
      expr: DATE_TRUNC('MONTH', allegation_date)
      comment: "Month when the allegation was made"
  measures:
    - name: "total_alleged_perpetrators"
      expr: COUNT(1)
      comment: "Total number of alleged perpetrator records"
    - name: "cases_with_criminal_referral"
      expr: SUM(CASE WHEN criminal_referral_made = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases referred to criminal authorities - critical accountability metric"
    - name: "cases_reported_to_misconduct_database"
      expr: SUM(CASE WHEN misconduct_database_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases reported to misconduct database - key sector protection metric"
    - name: "cases_with_disciplinary_action"
      expr: COUNT(DISTINCT CASE WHEN disciplinary_action_date IS NOT NULL THEN alleged_perpetrator_id END)
      comment: "Number of cases resulting in disciplinary action"
    - name: "cases_with_termination"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN alleged_perpetrator_id END)
      comment: "Number of cases resulting in termination"
    - name: "cases_with_suspension"
      expr: COUNT(DISTINCT CASE WHEN suspension_start_date IS NOT NULL THEN alleged_perpetrator_id END)
      comment: "Number of cases with suspension applied"
    - name: "cases_with_interim_measures"
      expr: COUNT(DISTINCT CASE WHEN interim_measures_applied IS NOT NULL THEN alleged_perpetrator_id END)
      comment: "Number of cases with interim measures applied"
    - name: "completed_investigations"
      expr: COUNT(DISTINCT CASE WHEN investigation_completion_date IS NOT NULL THEN alleged_perpetrator_id END)
      comment: "Number of completed investigations"
    - name: "pct_cases_with_criminal_referral"
      expr: ROUND(100.0 * SUM(CASE WHEN criminal_referral_made = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases referred to criminal authorities - key accountability indicator"
    - name: "pct_cases_reported_to_misconduct_database"
      expr: ROUND(100.0 * SUM(CASE WHEN misconduct_database_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases reported to misconduct database - critical sector protection indicator"
    - name: "pct_investigations_completed"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN investigation_completion_date IS NOT NULL THEN alleged_perpetrator_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations completed - key process indicator"
$$;