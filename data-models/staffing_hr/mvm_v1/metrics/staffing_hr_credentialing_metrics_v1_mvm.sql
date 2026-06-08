-- Metric views for domain: credentialing | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:42:38

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_bgc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bgc Order business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`bgc_order`"
  dimensions:
    - name: "Actual Turnaround Hours"
      expr: actual_turnaround_hours
    - name: "Adjudication Status"
      expr: adjudication_status
    - name: "Adverse Action Notice Date"
      expr: adverse_action_notice_date
    - name: "Client Package Code"
      expr: client_package_code
    - name: "Client Required"
      expr: client_required
    - name: "Completed Date"
      expr: completed_date
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Obtained"
      expr: consent_obtained
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Check Result"
      expr: credit_check_result
    - name: "Criminal Check Result"
      expr: criminal_check_result
    - name: "Dispute Initiated Date"
      expr: dispute_initiated_date
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Drug Screen Result"
      expr: drug_screen_result
    - name: "Education Verification Result"
      expr: education_verification_result
    - name: "Employment Verification Result"
      expr: employment_verification_result
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bgc Order"
      expr: COUNT(DISTINCT bgc_order_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_bgc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bgc Result business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`bgc_result`"
  dimensions:
    - name: "Adjudication Decision"
      expr: adjudication_decision
    - name: "Adverse Action Flag"
      expr: adverse_action_flag
    - name: "Check Component Type"
      expr: check_component_type
    - name: "Collection Date"
      expr: collection_date
    - name: "Collection Site"
      expr: collection_site
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Degree Type"
      expr: degree_type
    - name: "Discrepancy Found Flag"
      expr: discrepancy_found_flag
    - name: "Dot Regulated Flag"
      expr: dot_regulated_flag
    - name: "Drug Panel Type"
      expr: drug_panel_type
    - name: "Education Verification Source"
      expr: education_verification_source
    - name: "Employer Name"
      expr: employer_name
    - name: "Employment End Date"
      expr: employment_end_date
    - name: "Employment Start Date"
      expr: employment_start_date
    - name: "Employment Verification Method"
      expr: employment_verification_method
    - name: "Fcra Compliant Flag"
      expr: fcra_compliant_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bgc Result"
      expr: COUNT(DISTINCT bgc_result_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`credential`"
  dimensions:
    - name: "Advance Notice Days"
      expr: advance_notice_days
    - name: "Assessment Score Type"
      expr: assessment_score_type
    - name: "Bgc Check Type"
      expr: bgc_check_type
    - name: "Ceu Required"
      expr: ceu_required
    - name: "Clearance Level"
      expr: clearance_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Code"
      expr: credential_code
    - name: "Credential Description"
      expr: credential_description
    - name: "Credential Name"
      expr: credential_name
    - name: "Credential Status"
      expr: credential_status
    - name: "Drug Screen Panel"
      expr: drug_screen_panel
    - name: "Effective Date"
      expr: effective_date
    - name: "Everify Required"
      expr: everify_required
    - name: "External Credential Code"
      expr: external_credential_code
    - name: "Flsa Relevance"
      expr: flsa_relevance
    - name: "Governing Body"
      expr: governing_body
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential"
      expr: COUNT(DISTINCT credential_id)
    - name: "Total Assessment Passing Score"
      expr: SUM(assessment_passing_score)
    - name: "Average Assessment Passing Score"
      expr: AVG(assessment_passing_score)
    - name: "Total Ceu Hours Required"
      expr: SUM(ceu_hours_required)
    - name: "Average Ceu Hours Required"
      expr: AVG(ceu_hours_required)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_credential_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential Document business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`credential_document`"
  dimensions:
    - name: "Candidate Consent Obtained"
      expr: candidate_consent_obtained
    - name: "Client Required"
      expr: client_required
    - name: "Consent Date"
      expr: consent_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Number"
      expr: document_number
    - name: "Document Status"
      expr: document_status
    - name: "Document Title"
      expr: document_title
    - name: "Document Type"
      expr: document_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Alert Date"
      expr: expiration_alert_date
    - name: "Expiration Alert Sent"
      expr: expiration_alert_sent
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fcra Compliant"
      expr: fcra_compliant
    - name: "File Format"
      expr: file_format
    - name: "File Size Kb"
      expr: file_size_kb
    - name: "Hipaa Applicable"
      expr: hipaa_applicable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential Document"
      expr: COUNT(DISTINCT credential_document_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_credential_instance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential Instance business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`credential_instance`"
  dimensions:
    - name: "Alert Threshold Days"
      expr: alert_threshold_days
    - name: "Bgc Result"
      expr: bgc_result
    - name: "Clearance Granting Agency"
      expr: clearance_granting_agency
    - name: "Clearance Level"
      expr: clearance_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Category"
      expr: credential_category
    - name: "Days Until Expiration"
      expr: days_until_expiration
    - name: "Document Url"
      expr: document_url
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Investigation Type"
      expr: investigation_type
    - name: "Is Placement Eligible"
      expr: is_placement_eligible
    - name: "Is Primary"
      expr: is_primary
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority Name"
      expr: issuing_authority_name
    - name: "Issuing Country"
      expr: issuing_country
    - name: "Issuing State"
      expr: issuing_state
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential Instance"
      expr: COUNT(DISTINCT credential_instance_id)
    - name: "Total Ceu Completed"
      expr: SUM(ceu_completed)
    - name: "Average Ceu Completed"
      expr: AVG(ceu_completed)
    - name: "Total Ceu Required"
      expr: SUM(ceu_required)
    - name: "Average Ceu Required"
      expr: AVG(ceu_required)
    - name: "Total Renewal Fee Amount"
      expr: SUM(renewal_fee_amount)
    - name: "Average Renewal Fee Amount"
      expr: AVG(renewal_fee_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_credential_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential Package business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`credential_package`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Bgc Components Required"
      expr: bgc_components_required
    - name: "Bgc Package Code"
      expr: bgc_package_code
    - name: "Client Required"
      expr: client_required
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Validity Days"
      expr: credential_validity_days
    - name: "Drug Screen Panel Type"
      expr: drug_screen_panel_type
    - name: "Drug Screen Required"
      expr: drug_screen_required
    - name: "Effective Date"
      expr: effective_date
    - name: "Everify Required"
      expr: everify_required
    - name: "Expiry Date"
      expr: expiry_date
    - name: "I9 Required"
      expr: i9_required
    - name: "Immunization Required"
      expr: immunization_required
    - name: "Industry Vertical"
      expr: industry_vertical
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential Package"
      expr: COUNT(DISTINCT credential_package_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_credential_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential Requirement business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`credential_requirement`"
  dimensions:
    - name: "Acceptable Expiry Window Days"
      expr: acceptable_expiry_window_days
    - name: "Applies To Assignment Start"
      expr: applies_to_assignment_start
    - name: "Approved Date"
      expr: approved_date
    - name: "Bgc Package Code"
      expr: bgc_package_code
    - name: "Client Contract Ref"
      expr: client_contract_ref
    - name: "Client Override Flag"
      expr: client_override_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Category"
      expr: credential_category
    - name: "Drug Screen Panel"
      expr: drug_screen_panel
    - name: "Effective Date"
      expr: effective_date
    - name: "Everify Required"
      expr: everify_required
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gap Analysis Blocking"
      expr: gap_analysis_blocking
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "I9 Required"
      expr: i9_required
    - name: "Industry Vertical"
      expr: industry_vertical
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential Requirement"
      expr: COUNT(DISTINCT credential_requirement_id)
    - name: "Total Assessment Passing Score"
      expr: SUM(assessment_passing_score)
    - name: "Average Assessment Passing Score"
      expr: AVG(assessment_passing_score)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_credential_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential Type business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`credential_type`"
  dimensions:
    - name: "Allowed Document Types"
      expr: allowed_document_types
    - name: "Background Check Scope"
      expr: background_check_scope
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Type Category"
      expr: credential_type_category
    - name: "Credential Type Code"
      expr: credential_type_code
    - name: "Credential Type Description"
      expr: credential_type_description
    - name: "Credential Type Name"
      expr: credential_type_name
    - name: "Credential Type Status"
      expr: credential_type_status
    - name: "Default Validity Period Days"
      expr: default_validity_period_days
    - name: "Display Order"
      expr: display_order
    - name: "Drug Screen Panel Type"
      expr: drug_screen_panel_type
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Industry Vertical"
      expr: industry_vertical
    - name: "Is Client Visible"
      expr: is_client_visible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential Type"
      expr: COUNT(DISTINCT credential_type_id)
    - name: "Total Cost Estimate Usd"
      expr: SUM(cost_estimate_usd)
    - name: "Average Cost Estimate Usd"
      expr: AVG(cost_estimate_usd)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_drug_screen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Screen business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`drug_screen`"
  dimensions:
    - name: "Candidate Consent Obtained"
      expr: candidate_consent_obtained
    - name: "Chain Of Custody Number"
      expr: chain_of_custody_number
    - name: "Collection Date"
      expr: collection_date
    - name: "Collection Site City"
      expr: collection_site_city
    - name: "Collection Site Code"
      expr: collection_site_code
    - name: "Collection Site Name"
      expr: collection_site_name
    - name: "Collection Site State"
      expr: collection_site_state
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Consent Date"
      expr: consent_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dilute Result Action"
      expr: dilute_result_action
    - name: "Dot Agency"
      expr: dot_agency
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Dot Regulated"
      expr: is_dot_regulated
    - name: "Is Observed Collection"
      expr: is_observed_collection
    - name: "Lab Received Date"
      expr: lab_received_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Screen"
      expr: COUNT(DISTINCT drug_screen_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_license_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License Verification business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`license_verification`"
  dimensions:
    - name: "Adverse Action Date"
      expr: adverse_action_date
    - name: "Adverse Action Flag"
      expr: adverse_action_flag
    - name: "Billable To Client"
      expr: billable_to_client
    - name: "Client Required Flag"
      expr: client_required_flag
    - name: "Compact States"
      expr: compact_states
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference Code"
      expr: document_reference_code
    - name: "Expiration Alert Date"
      expr: expiration_alert_date
    - name: "Expiration Alert Sent"
      expr: expiration_alert_sent
    - name: "Is Compact License"
      expr: is_compact_license
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Issuing Country"
      expr: issuing_country
    - name: "Issuing State"
      expr: issuing_state
    - name: "License Expiration Date"
      expr: license_expiration_date
    - name: "License Holder Name"
      expr: license_holder_name
    - name: "License Issue Date"
      expr: license_issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct License Verification"
      expr: COUNT(DISTINCT license_verification_id)
    - name: "Total Verification Cost"
      expr: SUM(verification_cost)
    - name: "Average Verification Cost"
      expr: AVG(verification_cost)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_package_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Requirement business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`package_requirement`"
  dimensions:
    - name: "Acceptable Expiry Window Days"
      expr: acceptable_expiry_window_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Renewal Lead Time Days"
      expr: renewal_lead_time_days
    - name: "Renewal Required"
      expr: renewal_required
    - name: "Requirement Status"
      expr: requirement_status
    - name: "Verification Level"
      expr: verification_level
    - name: "Waiver Allowed"
      expr: waiver_allowed
    - name: "Waiver Approval Level"
      expr: waiver_approval_level
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Requirement"
      expr: COUNT(DISTINCT package_requirement_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_skills_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Skills Assessment business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`skills_assessment`"
  dimensions:
    - name: "Accommodation Notes"
      expr: accommodation_notes
    - name: "Ada Accommodation Applied"
      expr: ada_accommodation_applied
    - name: "Allotted Duration Minutes"
      expr: allotted_duration_minutes
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment End Timestamp"
      expr: assessment_end_timestamp
    - name: "Assessment Number"
      expr: assessment_number
    - name: "Assessment Start Timestamp"
      expr: assessment_start_timestamp
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Assessment Version"
      expr: assessment_version
    - name: "Attempt Number"
      expr: attempt_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Channel"
      expr: delivery_channel
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Is Current Result"
      expr: is_current_result
    - name: "Is Proctored"
      expr: is_proctored
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Skills Assessment"
      expr: COUNT(DISTINCT skills_assessment_id)
    - name: "Total Max Possible Score"
      expr: SUM(max_possible_score)
    - name: "Average Max Possible Score"
      expr: AVG(max_possible_score)
    - name: "Total Pass Threshold"
      expr: SUM(pass_threshold)
    - name: "Average Pass Threshold"
      expr: AVG(pass_threshold)
    - name: "Total Percentile Rank"
      expr: SUM(percentile_rank)
    - name: "Average Percentile Rank"
      expr: AVG(percentile_rank)
    - name: "Total Raw Score"
      expr: SUM(raw_score)
    - name: "Average Raw Score"
      expr: AVG(raw_score)
    - name: "Total Score Percentage"
      expr: SUM(score_percentage)
    - name: "Average Score Percentage"
      expr: AVG(score_percentage)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training Record business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`training_record`"
  dimensions:
    - name: "Assigned By"
      expr: assigned_by
    - name: "Attempts Count"
      expr: attempts_count
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certificate Url"
      expr: certificate_url
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Course Code"
      expr: course_code
    - name: "Course Name"
      expr: course_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Due Date"
      expr: due_date
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Industry Vertical"
      expr: industry_vertical
    - name: "Instructor Name"
      expr: instructor_name
    - name: "Is Client Required"
      expr: is_client_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Training Record"
      expr: COUNT(DISTINCT training_record_id)
    - name: "Total Ceu Credits Earned"
      expr: SUM(ceu_credits_earned)
    - name: "Average Ceu Credits Earned"
      expr: AVG(ceu_credits_earned)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Passing Score Threshold"
      expr: SUM(passing_score_threshold)
    - name: "Average Passing Score Threshold"
      expr: AVG(passing_score_threshold)
    - name: "Total Score"
      expr: SUM(score)
    - name: "Average Score"
      expr: AVG(score)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`credentialing_work_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Authorization business metrics"
  source: "`staffing_hr_ecm_v1`.`credentialing`.`work_authorization`"
  dimensions:
    - name: "Authorization Notes"
      expr: authorization_notes
    - name: "Authorization Status"
      expr: authorization_status
    - name: "Authorized End Date"
      expr: authorized_end_date
    - name: "Authorized Start Date"
      expr: authorized_start_date
    - name: "Authorized To Work Unrestricted"
      expr: authorized_to_work_unrestricted
    - name: "Bullhorn Candidate Ref"
      expr: bullhorn_candidate_ref
    - name: "Cap Exempt"
      expr: cap_exempt
    - name: "Country Of Authorization"
      expr: country_of_authorization
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ead Card Number"
      expr: ead_card_number
    - name: "Everify Case Number"
      expr: everify_case_number
    - name: "Expiration Alert Date"
      expr: expiration_alert_date
    - name: "Expiration Alert Sent"
      expr: expiration_alert_sent
    - name: "Green Card Priority Date"
      expr: green_card_priority_date
    - name: "I140 Approved"
      expr: i140_approved
    - name: "I94 Admission Number"
      expr: i94_admission_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Work Authorization"
      expr: COUNT(DISTINCT work_authorization_id)
$$;