-- Metric views for domain: hcp | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:49:06

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affiliation business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`affiliation`"
  dimensions:
    - name: "Admitting Privileges Flag"
      expr: admitting_privileges_flag
    - name: "Affiliation Status"
      expr: affiliation_status
    - name: "Affiliation Type"
      expr: affiliation_type
    - name: "Compensation Arrangement Type"
      expr: compensation_arrangement_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Data Source System"
      expr: data_source_system
    - name: "Dea Number"
      expr: dea_number
    - name: "Department Name"
      expr: department_name
    - name: "End Date"
      expr: end_date
    - name: "Formulary Influence Level"
      expr: formulary_influence_level
    - name: "Is Primary Affiliation"
      expr: is_primary_affiliation
    - name: "Kol Designation Flag"
      expr: kol_designation_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Verification Date"
      expr: last_verification_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Affiliation"
      expr: COUNT(DISTINCT affiliation_id)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Full Time Equivalent"
      expr: SUM(full_time_equivalent)
    - name: "Average Full Time Equivalent"
      expr: AVG(full_time_equivalent)
    - name: "Total Strength Score"
      expr: SUM(strength_score)
    - name: "Average Strength Score"
      expr: AVG(strength_score)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent Record business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`consent_record`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Consent Expiration Date"
      expr: consent_expiration_date
    - name: "Consent Granted Date"
      expr: consent_granted_date
    - name: "Consent Language"
      expr: consent_language
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Source"
      expr: consent_source
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Text"
      expr: consent_text
    - name: "Consent Type"
      expr: consent_type
    - name: "Consent Version"
      expr: consent_version
    - name: "Consent Withdrawn Date"
      expr: consent_withdrawn_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Digital Channel Sync Flag"
      expr: digital_channel_sync_flag
    - name: "Dnc Flag"
      expr: dnc_flag
    - name: "Email Platform Sync Flag"
      expr: email_platform_sync_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent Record"
      expr: COUNT(DISTINCT consent_record_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`contract`"
  dimensions:
    - name: "Business Unit"
      expr: business_unit
    - name: "Compliance Approval Date"
      expr: compliance_approval_date
    - name: "Compliance Approval Status"
      expr: compliance_approval_status
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Cost Center"
      expr: cost_center
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Screening Date"
      expr: exclusion_screening_date
    - name: "Exclusion Screening Status"
      expr: exclusion_screening_status
    - name: "Fda Debarment Screening Result"
      expr: fda_debarment_screening_result
    - name: "Fmv Methodology"
      expr: fmv_methodology
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract"
      expr: COUNT(DISTINCT contract_id)
    - name: "Total Annual Cap Amount"
      expr: SUM(annual_cap_amount)
    - name: "Average Annual Cap Amount"
      expr: AVG(annual_cap_amount)
    - name: "Total Honorarium Rate"
      expr: SUM(honorarium_rate)
    - name: "Average Honorarium Rate"
      expr: AVG(honorarium_rate)
    - name: "Total Hourly Rate Max"
      expr: SUM(hourly_rate_max)
    - name: "Average Hourly Rate Max"
      expr: AVG(hourly_rate_max)
    - name: "Total Hourly Rate Min"
      expr: SUM(hourly_rate_min)
    - name: "Average Hourly Rate Min"
      expr: AVG(hourly_rate_min)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`engagement`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Engagement"
      expr: COUNT(DISTINCT engagement_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_hco_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hco Master business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`hco_master`"
  dimensions:
    - name: "Accreditation Expiration Date"
      expr: accreditation_expiration_date
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Accrediting Body"
      expr: accrediting_body
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Bed Count"
      expr: bed_count
    - name: "City"
      expr: city
    - name: "Cms Certification Number"
      expr: cms_certification_number
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Dba Name"
      expr: dba_name
    - name: "Dea Registration Number"
      expr: dea_registration_number
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hco Master"
      expr: COUNT(DISTINCT hco_master_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_hcp_advisory_board`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hcp Advisory Board business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board`"
  dimensions:
    - name: "Advisory Board Name"
      expr: advisory_board_name
    - name: "Agenda Topics"
      expr: agenda_topics
    - name: "Board Type"
      expr: board_type
    - name: "Conflict Of Interest Disclosed Flag"
      expr: conflict_of_interest_disclosed_flag
    - name: "Contract Execution Date"
      expr: contract_execution_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Follow Up Actions"
      expr: follow_up_actions
    - name: "Hcp Role"
      expr: hcp_role
    - name: "Honorarium Currency Code"
      expr: honorarium_currency_code
    - name: "Kol Tier"
      expr: kol_tier
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Meeting City"
      expr: meeting_city
    - name: "Meeting Country Code"
      expr: meeting_country_code
    - name: "Meeting Date"
      expr: meeting_date
    - name: "Meeting End Time"
      expr: meeting_end_time
    - name: "Meeting Format"
      expr: meeting_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hcp Advisory Board"
      expr: COUNT(DISTINCT hcp_advisory_board_id)
    - name: "Total Honorarium Amount"
      expr: SUM(honorarium_amount)
    - name: "Average Honorarium Amount"
      expr: AVG(honorarium_amount)
    - name: "Total Meal Accommodation Amount"
      expr: SUM(meal_accommodation_amount)
    - name: "Average Meal Accommodation Amount"
      expr: AVG(meal_accommodation_amount)
    - name: "Total Total Payment Amount"
      expr: SUM(total_payment_amount)
    - name: "Average Total Payment Amount"
      expr: AVG(total_payment_amount)
    - name: "Total Travel Reimbursement Amount"
      expr: SUM(travel_reimbursement_amount)
    - name: "Average Travel Reimbursement Amount"
      expr: AVG(travel_reimbursement_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_hcp_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hcp Engagement business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`hcp_engagement`"
  dimensions:
    - name: "Adverse Event Reported Flag"
      expr: adverse_event_reported_flag
    - name: "Call Objective"
      expr: call_objective
    - name: "Channel"
      expr: channel
    - name: "Compliance Reviewed Flag"
      expr: compliance_reviewed_flag
    - name: "Consent Obtained Flag"
      expr: consent_obtained_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Time"
      expr: end_time
    - name: "Engagement Date"
      expr: engagement_date
    - name: "Engagement Number"
      expr: engagement_number
    - name: "Engagement Status"
      expr: engagement_status
    - name: "Engagement Type"
      expr: engagement_type
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Frequency"
      expr: frequency
    - name: "Hcp Feedback"
      expr: hcp_feedback
    - name: "Key Message Delivered"
      expr: key_message_delivered
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hcp Engagement"
      expr: COUNT(DISTINCT hcp_engagement_id)
    - name: "Total Relationship Strength Score"
      expr: SUM(relationship_strength_score)
    - name: "Average Relationship Strength Score"
      expr: AVG(relationship_strength_score)
    - name: "Total Transfer Of Value Amount"
      expr: SUM(transfer_of_value_amount)
    - name: "Average Transfer Of Value Amount"
      expr: AVG(transfer_of_value_amount)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_hcp_kol_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hcp Kol Profile business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile`"
  dimensions:
    - name: "Academic Rank"
      expr: academic_rank
    - name: "Advisory Board Participation Count"
      expr: advisory_board_participation_count
    - name: "Clinical Trial Investigator Flag"
      expr: clinical_trial_investigator_flag
    - name: "Compliance Clearance Date"
      expr: compliance_clearance_date
    - name: "Compliance Clearance Expiry Date"
      expr: compliance_clearance_expiry_date
    - name: "Compliance Clearance Status"
      expr: compliance_clearance_status
    - name: "Conflict Of Interest Disclosure"
      expr: conflict_of_interest_disclosure
    - name: "Congress Speaking Count"
      expr: congress_speaking_count
    - name: "Data Source"
      expr: data_source
    - name: "Department Chair Flag"
      expr: department_chair_flag
    - name: "Fellowship Institution"
      expr: fellowship_institution
    - name: "Guideline Authorship Flag"
      expr: guideline_authorship_flag
    - name: "H Index"
      expr: h_index
    - name: "Kol Status"
      expr: kol_status
    - name: "Kol Tier"
      expr: kol_tier
    - name: "Last Congress Speaking Date"
      expr: last_congress_speaking_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hcp Kol Profile"
      expr: COUNT(DISTINCT hcp_kol_profile_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_hcp_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hcp Publication business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`hcp_publication`"
  dimensions:
    - name: "Abstract Text"
      expr: abstract_text
    - name: "Affiliation At Publication"
      expr: affiliation_at_publication
    - name: "Author Order"
      expr: author_order
    - name: "Citation Count"
      expr: citation_count
    - name: "Company Product Mentioned"
      expr: company_product_mentioned
    - name: "Company Sponsored Flag"
      expr: company_sponsored_flag
    - name: "Conflict Of Interest Disclosed"
      expr: conflict_of_interest_disclosed
    - name: "Corresponding Author Flag"
      expr: corresponding_author_flag
    - name: "Country"
      expr: country
    - name: "Data Source"
      expr: data_source
    - name: "Doi"
      expr: doi
    - name: "External Source Code"
      expr: external_source_code
    - name: "Journal Name"
      expr: journal_name
    - name: "Keywords"
      expr: keywords
    - name: "Kol Tier At Publication"
      expr: kol_tier_at_publication
    - name: "Language"
      expr: language
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hcp Publication"
      expr: COUNT(DISTINCT hcp_publication_id)
    - name: "Total Impact Factor"
      expr: SUM(impact_factor)
    - name: "Average Impact Factor"
      expr: AVG(impact_factor)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_hcp_speaker_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hcp Speaker Program business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program`"
  dimensions:
    - name: "Audience Size"
      expr: audience_size
    - name: "Certification Status"
      expr: certification_status
    - name: "Compliance Approval Date"
      expr: compliance_approval_date
    - name: "Compliance Approval Status"
      expr: compliance_approval_status
    - name: "Compliance Certification Date"
      expr: compliance_certification_date
    - name: "Compliance Certification Status"
      expr: compliance_certification_status
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Honorarium Currency Code"
      expr: honorarium_currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Materials Used"
      expr: materials_used
    - name: "Mlr Approval Number"
      expr: mlr_approval_number
    - name: "Program Event Number"
      expr: program_event_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hcp Speaker Program"
      expr: COUNT(DISTINCT hcp_speaker_program_id)
    - name: "Total Honorarium Paid Usd"
      expr: SUM(honorarium_paid_usd)
    - name: "Average Honorarium Paid Usd"
      expr: AVG(honorarium_paid_usd)
    - name: "Total Honorarium Rate Usd"
      expr: SUM(honorarium_rate_usd)
    - name: "Average Honorarium Rate Usd"
      expr: AVG(honorarium_rate_usd)
    - name: "Total Speaker Performance Rating"
      expr: SUM(speaker_performance_rating)
    - name: "Average Speaker Performance Rating"
      expr: AVG(speaker_performance_rating)
    - name: "Total Total Spend Usd"
      expr: SUM(total_spend_usd)
    - name: "Average Total Spend Usd"
      expr: AVG(total_spend_usd)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_investigator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigator business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`investigator`"
  dimensions:
    - name: "Active Trials Count"
      expr: active_trials_count
    - name: "Conflict Of Interest Declared"
      expr: conflict_of_interest_declared
    - name: "Cv Last Updated Date"
      expr: cv_last_updated_date
    - name: "Cv On File"
      expr: cv_on_file
    - name: "Data Source"
      expr: data_source
    - name: "Disqualification Date"
      expr: disqualification_date
    - name: "Disqualification Reason"
      expr: disqualification_reason
    - name: "External Source Code"
      expr: external_source_code
    - name: "Fda 1572 On File"
      expr: fda_1572_on_file
    - name: "Fda 1572 Signature Date"
      expr: fda_1572_signature_date
    - name: "Financial Disclosure Date"
      expr: financial_disclosure_date
    - name: "Financial Disclosure Status"
      expr: financial_disclosure_status
    - name: "Gcp Training Completion Date"
      expr: gcp_training_completion_date
    - name: "Gcp Training Expiration Date"
      expr: gcp_training_expiration_date
    - name: "Gcp Training Status"
      expr: gcp_training_status
    - name: "Initiated Trial Flag"
      expr: initiated_trial_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Investigator"
      expr: COUNT(DISTINCT investigator_id)
    - name: "Total Average Enrollment Rate"
      expr: SUM(average_enrollment_rate)
    - name: "Average Average Enrollment Rate"
      expr: AVG(average_enrollment_rate)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`license`"
  dimensions:
    - name: "Board Name"
      expr: board_name
    - name: "Certification Level"
      expr: certification_level
    - name: "Comments"
      expr: comments
    - name: "Controlled Substance Authority"
      expr: controlled_substance_authority
    - name: "Data Source"
      expr: data_source
    - name: "Data Source Record Reference"
      expr: data_source_record_reference
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Disciplinary Action Description"
      expr: disciplinary_action_description
    - name: "Disciplinary Action Flag"
      expr: disciplinary_action_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Issuing Country"
      expr: issuing_country
    - name: "Issuing State"
      expr: issuing_state
    - name: "License Number"
      expr: license_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct License"
      expr: COUNT(DISTINCT license_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`master`"
  dimensions:
    - name: "Board Certification Date"
      expr: board_certification_date
    - name: "Board Certification Expiration Date"
      expr: board_certification_expiration_date
    - name: "Board Certification Status"
      expr: board_certification_status
    - name: "Data Source"
      expr: data_source
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Dea Expiration Date"
      expr: dea_expiration_date
    - name: "Dea Number"
      expr: dea_number
    - name: "Dea Status"
      expr: dea_status
    - name: "External Source Code"
      expr: external_source_code
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Hcp Status"
      expr: hcp_status
    - name: "Kol Status"
      expr: kol_status
    - name: "Kol Tier"
      expr: kol_tier
    - name: "Last Name"
      expr: last_name
    - name: "Middle Name"
      expr: middle_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Master"
      expr: COUNT(DISTINCT master_id)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_med_info_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Med Info Request business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`med_info_request`"
  dimensions:
    - name: "Adverse Event Flag"
      expr: adverse_event_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Assigned To"
      expr: assigned_to
    - name: "Congress Date"
      expr: congress_date
    - name: "Congress Name"
      expr: congress_name
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Follow Up Date"
      expr: follow_up_date
    - name: "Follow Up Required Flag"
      expr: follow_up_required_flag
    - name: "Hcp Specialty"
      expr: hcp_specialty
    - name: "Literature References"
      expr: literature_references
    - name: "Off Label Inquiry Flag"
      expr: off_label_inquiry_flag
    - name: "Question Category"
      expr: question_category
    - name: "Question Text"
      expr: question_text
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Med Info Request"
      expr: COUNT(DISTINCT med_info_request_id)
    - name: "Total Response Turnaround Hours"
      expr: SUM(response_turnaround_hours)
    - name: "Average Response Turnaround Hours"
      expr: AVG(response_turnaround_hours)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_prescribing_pattern`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prescribing Pattern business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`prescribing_pattern`"
  dimensions:
    - name: "Data Classification"
      expr: data_classification
    - name: "Data Provider"
      expr: data_provider
    - name: "Data Refresh Date"
      expr: data_refresh_date
    - name: "Decile Classification"
      expr: decile_classification
    - name: "Formulary Status"
      expr: formulary_status
    - name: "Geography Level"
      expr: geography_level
    - name: "Is Key Opinion Leader"
      expr: is_key_opinion_leader
    - name: "Patient Count Estimate"
      expr: patient_count_estimate
    - name: "Prescribing Channel"
      expr: prescribing_channel
    - name: "Prescribing Rank National"
      expr: prescribing_rank_national
    - name: "Prescribing Rank Regional"
      expr: prescribing_rank_regional
    - name: "Prescribing Trend"
      expr: prescribing_trend
    - name: "Projection Method"
      expr: projection_method
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Reporting Period End Date"
      expr: reporting_period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Prescribing Pattern"
      expr: COUNT(DISTINCT prescribing_pattern_id)
    - name: "Total Average Days Supply"
      expr: SUM(average_days_supply)
    - name: "Average Average Days Supply"
      expr: AVG(average_days_supply)
    - name: "Total Brand Prescriptions"
      expr: SUM(brand_prescriptions)
    - name: "Average Brand Prescriptions"
      expr: AVG(brand_prescriptions)
    - name: "Total Brand Vs Generic Ratio"
      expr: SUM(brand_vs_generic_ratio)
    - name: "Average Brand Vs Generic Ratio"
      expr: AVG(brand_vs_generic_ratio)
    - name: "Total Competitive Product Prescriptions"
      expr: SUM(competitive_product_prescriptions)
    - name: "Average Competitive Product Prescriptions"
      expr: AVG(competitive_product_prescriptions)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Data Source Coverage Percent"
      expr: SUM(data_source_coverage_percent)
    - name: "Average Data Source Coverage Percent"
      expr: AVG(data_source_coverage_percent)
    - name: "Total Generic Prescriptions"
      expr: SUM(generic_prescriptions)
    - name: "Average Generic Prescriptions"
      expr: AVG(generic_prescriptions)
    - name: "Total Market Share Percent"
      expr: SUM(market_share_percent)
    - name: "Average Market Share Percent"
      expr: AVG(market_share_percent)
    - name: "Total New Prescriptions Nrx"
      expr: SUM(new_prescriptions_nrx)
    - name: "Average New Prescriptions Nrx"
      expr: AVG(new_prescriptions_nrx)
    - name: "Total Prior Authorization Rate Percent"
      expr: SUM(prior_authorization_rate_percent)
    - name: "Average Prior Authorization Rate Percent"
      expr: AVG(prior_authorization_rate_percent)
    - name: "Total Refill Prescriptions"
      expr: SUM(refill_prescriptions)
    - name: "Average Refill Prescriptions"
      expr: AVG(refill_prescriptions)
    - name: "Total Total Prescriptions Trx"
      expr: SUM(total_prescriptions_trx)
    - name: "Average Total Prescriptions Trx"
      expr: AVG(total_prescriptions_trx)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample Request business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`sample_request`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Controlled Substance Flag"
      expr: controlled_substance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dea Number"
      expr: dea_number
    - name: "Dea Schedule"
      expr: dea_schedule
    - name: "Delivery Address Line1"
      expr: delivery_address_line1
    - name: "Delivery Address Line2"
      expr: delivery_address_line2
    - name: "Delivery City"
      expr: delivery_city
    - name: "Delivery Country Code"
      expr: delivery_country_code
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Delivery Postal Code"
      expr: delivery_postal_code
    - name: "Delivery State Province"
      expr: delivery_state_province
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fulfillment Date"
      expr: fulfillment_date
    - name: "Hcp Signature Captured"
      expr: hcp_signature_captured
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sample Request"
      expr: COUNT(DISTINCT sample_request_id)
    - name: "Total Sample Value Usd"
      expr: SUM(sample_value_usd)
    - name: "Average Sample Value Usd"
      expr: AVG(sample_value_usd)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_speaker_program_presentation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Speaker Program Presentation business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation`"
  dimensions:
    - name: "Approved Product List"
      expr: approved_product_list
    - name: "Audience Size"
      expr: audience_size
    - name: "Audience Type"
      expr: audience_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Event Date"
      expr: event_date
    - name: "Event End Time"
      expr: event_end_time
    - name: "Event Format"
      expr: event_format
    - name: "Event Start Time"
      expr: event_start_time
    - name: "Materials Used"
      expr: materials_used
    - name: "Mlr Approval Number"
      expr: mlr_approval_number
    - name: "Presentation Date"
      expr: presentation_date
    - name: "Speaker Performance Rating"
      expr: speaker_performance_rating
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Venue"
      expr: venue
    - name: "Venue Address"
      expr: venue_address
    - name: "Venue City"
      expr: venue_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Speaker Program Presentation"
      expr: COUNT(DISTINCT speaker_program_presentation_id)
    - name: "Total Honorarium Paid"
      expr: SUM(honorarium_paid)
    - name: "Average Honorarium Paid"
      expr: AVG(honorarium_paid)
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`hcp_sunshine_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sunshine Transfer business metrics"
  source: "`pharmaceuticals_ecm`.`hcp`.`sunshine_transfer`"
  dimensions:
    - name: "Cms Publication Date"
      expr: cms_publication_date
    - name: "Cms Reporting Status"
      expr: cms_reporting_status
    - name: "Cms Submission Date"
      expr: cms_submission_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delay Publication Indicator"
      expr: delay_publication_indicator
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Form Of Payment"
      expr: form_of_payment
    - name: "Internal Transaction Number"
      expr: internal_transaction_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nature Of Payment"
      expr: nature_of_payment
    - name: "Payment Currency"
      expr: payment_currency
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Type"
      expr: payment_type
    - name: "Product Indication"
      expr: product_indication
    - name: "Product Name"
      expr: product_name
    - name: "Product Ndc"
      expr: product_ndc
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sunshine Transfer"
      expr: COUNT(DISTINCT sunshine_transfer_id)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Payment Amount Usd"
      expr: SUM(payment_amount_usd)
    - name: "Average Payment Amount Usd"
      expr: AVG(payment_amount_usd)
$$;