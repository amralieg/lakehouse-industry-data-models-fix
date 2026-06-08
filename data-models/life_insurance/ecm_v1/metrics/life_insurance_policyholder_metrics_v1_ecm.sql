-- Metric views for domain: policyholder | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:37:32

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_annuitant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annuitant business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`annuitant`"
  dimensions:
    - name: "Annuitant Number"
      expr: annuitant_number
    - name: "Annuity Start Date"
      expr: annuity_start_date
    - name: "Annuity Type"
      expr: annuity_type
    - name: "Contract Qualification Type"
      expr: contract_qualification_type
    - name: "Current Age"
      expr: current_age
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Death Benefit Option"
      expr: death_benefit_option
    - name: "Death Date"
      expr: death_date
    - name: "Death Verified Date"
      expr: death_verified_date
    - name: "Gender"
      expr: gender
    - name: "Gmab Indicator"
      expr: gmab_indicator
    - name: "Gmdb Indicator"
      expr: gmdb_indicator
    - name: "Gmib Indicator"
      expr: gmib_indicator
    - name: "Gmwb Indicator"
      expr: gmwb_indicator
    - name: "Is Joint Annuitant"
      expr: is_joint_annuitant
    - name: "Issue Age"
      expr: issue_age
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Annuitant"
      expr: COUNT(DISTINCT annuitant_id)
    - name: "Total Benefit Base Amount"
      expr: SUM(benefit_base_amount)
    - name: "Average Benefit Base Amount"
      expr: AVG(benefit_base_amount)
    - name: "Total Death Benefit Amount"
      expr: SUM(death_benefit_amount)
    - name: "Average Death Benefit Amount"
      expr: AVG(death_benefit_amount)
    - name: "Total Joint Survivor Pct"
      expr: SUM(joint_survivor_pct)
    - name: "Average Joint Survivor Pct"
      expr: AVG(joint_survivor_pct)
    - name: "Total Withholding Pct"
      expr: SUM(withholding_pct)
    - name: "Average Withholding Pct"
      expr: AVG(withholding_pct)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_beneficiary_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Beneficiary Designation business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`beneficiary_designation`"
  dimensions:
    - name: "Allocation Basis"
      expr: allocation_basis
    - name: "Aml Screening Date"
      expr: aml_screening_date
    - name: "Aml Screening Status"
      expr: aml_screening_status
    - name: "Beneficiary Entity Type"
      expr: beneficiary_entity_type
    - name: "Beneficiary Relationship"
      expr: beneficiary_relationship
    - name: "Change Reason"
      expr: change_reason
    - name: "Contingent Condition"
      expr: contingent_condition
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Designation Method"
      expr: designation_method
    - name: "Designation Number"
      expr: designation_number
    - name: "Designation Status"
      expr: designation_status
    - name: "Designation Type"
      expr: designation_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Form Number"
      expr: form_number
    - name: "Form Version"
      expr: form_version
    - name: "Guardian Name"
      expr: guardian_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Beneficiary Designation"
      expr: COUNT(DISTINCT beneficiary_designation_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_communication_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication Preference business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`communication_preference`"
  dimensions:
    - name: "Cease And Desist"
      expr: cease_and_desist
    - name: "Channel"
      expr: channel
    - name: "Consent Ip Address"
      expr: consent_ip_address
    - name: "Consent Version"
      expr: consent_version
    - name: "Contact Purpose"
      expr: contact_purpose
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dnc Scrub Date"
      expr: dnc_scrub_date
    - name: "Do Not Call"
      expr: do_not_call
    - name: "Do Not Email"
      expr: do_not_email
    - name: "Do Not Mail"
      expr: do_not_mail
    - name: "Do Not Sms"
      expr: do_not_sms
    - name: "Document Delivery Method"
      expr: document_delivery_method
    - name: "E Delivery Consent Date"
      expr: e_delivery_consent_date
    - name: "E Delivery Consent Method"
      expr: e_delivery_consent_method
    - name: "E Delivery Enrolled"
      expr: e_delivery_enrolled
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Communication Preference"
      expr: COUNT(DISTINCT communication_preference_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent Record business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`consent_record`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Language Code"
      expr: consent_language_code
    - name: "Consent Method"
      expr: consent_method
    - name: "Consent Reference Number"
      expr: consent_reference_number
    - name: "Consent Scope"
      expr: consent_scope
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Consent Type"
      expr: consent_type
    - name: "Consent Version"
      expr: consent_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Parties"
      expr: data_sharing_parties
    - name: "Data Sharing Third Party Flag"
      expr: data_sharing_third_party_flag
    - name: "Device Fingerprint"
      expr: device_fingerprint
    - name: "Do Not Contact Flag"
      expr: do_not_contact_flag
    - name: "E Delivery Email"
      expr: e_delivery_email
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Consent Record"
      expr: COUNT(DISTINCT consent_record_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_contract_owner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Owner business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`contract_owner`"
  dimensions:
    - name: "Absolute Assignment Flag"
      expr: absolute_assignment_flag
    - name: "Aml Risk Rating"
      expr: aml_risk_rating
    - name: "Beneficiary Designation Authority"
      expr: beneficiary_designation_authority
    - name: "Collateral Assignee Name"
      expr: collateral_assignee_name
    - name: "Collateral Assignment Date"
      expr: collateral_assignment_date
    - name: "Collateral Assignment Flag"
      expr: collateral_assignment_flag
    - name: "Correspondence Preference"
      expr: correspondence_preference
    - name: "Electronic Consent Date"
      expr: electronic_consent_date
    - name: "Electronic Consent Flag"
      expr: electronic_consent_flag
    - name: "Entity State Of Formation"
      expr: entity_state_of_formation
    - name: "Exchange 1035 Flag"
      expr: exchange_1035_flag
    - name: "Insurable Interest Type"
      expr: insurable_interest_type
    - name: "Is Also Annuitant"
      expr: is_also_annuitant
    - name: "Is Also Insured"
      expr: is_also_insured
    - name: "Is Primary Owner"
      expr: is_primary_owner
    - name: "Kyc Status"
      expr: kyc_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Owner"
      expr: COUNT(DISTINCT contract_owner_id)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_death_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Death Verification business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`death_verification`"
  dimensions:
    - name: "Aps Received Date"
      expr: aps_received_date
    - name: "Aps Received Flag"
      expr: aps_received_flag
    - name: "Beneficiary Notification Date"
      expr: beneficiary_notification_date
    - name: "Beneficiary Notified Flag"
      expr: beneficiary_notified_flag
    - name: "Cause Of Death"
      expr: cause_of_death
    - name: "Claim Initiated Flag"
      expr: claim_initiated_flag
    - name: "Coroner Report Flag"
      expr: coroner_report_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Death Certificate Issue Date"
      expr: death_certificate_issue_date
    - name: "Death Certificate Issuing State"
      expr: death_certificate_issuing_state
    - name: "Death Certificate Number"
      expr: death_certificate_number
    - name: "Death Certificate Received Flag"
      expr: death_certificate_received_flag
    - name: "Death Date"
      expr: death_date
    - name: "Death Date Source"
      expr: death_date_source
    - name: "Dmf Match Date"
      expr: dmf_match_date
    - name: "Dmf Match Flag"
      expr: dmf_match_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Death Verification"
      expr: COUNT(DISTINCT death_verification_id)
    - name: "Total Dmf Match Score"
      expr: SUM(dmf_match_score)
    - name: "Average Dmf Match Score"
      expr: AVG(dmf_match_score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_group_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Member business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`group_member`"
  dimensions:
    - name: "Aml Review Required"
      expr: aml_review_required
    - name: "Beneficiary Designation On File"
      expr: beneficiary_designation_on_file
    - name: "Beneficiary Last Updated Date"
      expr: beneficiary_last_updated_date
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Cobra Election Date"
      expr: cobra_election_date
    - name: "Cobra Expiration Date"
      expr: cobra_expiration_date
    - name: "Conversion Elected"
      expr: conversion_elected
    - name: "Conversion Election Date"
      expr: conversion_election_date
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Class"
      expr: eligibility_class
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Eoi Decision Date"
      expr: eoi_decision_date
    - name: "Eoi Required"
      expr: eoi_required
    - name: "Eoi Status"
      expr: eoi_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Member"
      expr: COUNT(DISTINCT group_member_id)
    - name: "Total Ad D Coverage Amount"
      expr: SUM(ad_d_coverage_amount)
    - name: "Average Ad D Coverage Amount"
      expr: AVG(ad_d_coverage_amount)
    - name: "Total Coverage Amount"
      expr: SUM(coverage_amount)
    - name: "Average Coverage Amount"
      expr: AVG(coverage_amount)
    - name: "Total Guaranteed Issue Amount"
      expr: SUM(guaranteed_issue_amount)
    - name: "Average Guaranteed Issue Amount"
      expr: AVG(guaranteed_issue_amount)
    - name: "Total Salary Amount"
      expr: SUM(salary_amount)
    - name: "Average Salary Amount"
      expr: AVG(salary_amount)
    - name: "Total Supplemental Coverage Amount"
      expr: SUM(supplemental_coverage_amount)
    - name: "Average Supplemental Coverage Amount"
      expr: AVG(supplemental_coverage_amount)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_group_sponsor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group Sponsor business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`group_sponsor`"
  dimensions:
    - name: "Aml Risk Rating"
      expr: aml_risk_rating
    - name: "Billing Mode"
      expr: billing_mode
    - name: "Contract Anniversary Date"
      expr: contract_anniversary_date
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Termination Date"
      expr: contract_termination_date
    - name: "Contributory Type"
      expr: contributory_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dba Name"
      expr: dba_name
    - name: "Dol Plan Year End"
      expr: dol_plan_year_end
    - name: "Enrolled Count"
      expr: enrolled_count
    - name: "Erisa Plan Number"
      expr: erisa_plan_number
    - name: "Group Size"
      expr: group_size
    - name: "Kyc Status"
      expr: kyc_status
    - name: "Mailing Address Line1"
      expr: mailing_address_line1
    - name: "Mailing Address Line2"
      expr: mailing_address_line2
    - name: "Mailing City"
      expr: mailing_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Group Sponsor"
      expr: COUNT(DISTINCT group_sponsor_id)
    - name: "Total Participation Rate Pct"
      expr: SUM(participation_rate_pct)
    - name: "Average Participation Rate Pct"
      expr: AVG(participation_rate_pct)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_insured`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insured business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`insured`"
  dimensions:
    - name: "Adb Eligible Flag"
      expr: adb_eligible_flag
    - name: "Adl Impairment Count"
      expr: adl_impairment_count
    - name: "Aps Received Date"
      expr: aps_received_date
    - name: "Aps Required Flag"
      expr: aps_required_flag
    - name: "Attained Age"
      expr: attained_age
    - name: "Aviation Flag"
      expr: aviation_flag
    - name: "Citizenship Country"
      expr: citizenship_country
    - name: "Coverage Effective Date"
      expr: coverage_effective_date
    - name: "Coverage Termination Date"
      expr: coverage_termination_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Exclusion Rider Description"
      expr: exclusion_rider_description
    - name: "Exclusion Rider Flag"
      expr: exclusion_rider_flag
    - name: "Flat Extra Expiry Date"
      expr: flat_extra_expiry_date
    - name: "Foreign Travel Flag"
      expr: foreign_travel_flag
    - name: "Gender"
      expr: gender
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Insured"
      expr: COUNT(DISTINCT insured_id)
    - name: "Total Face Amount"
      expr: SUM(face_amount)
    - name: "Average Face Amount"
      expr: AVG(face_amount)
    - name: "Total Flat Extra Premium"
      expr: SUM(flat_extra_premium)
    - name: "Average Flat Extra Premium"
      expr: AVG(flat_extra_premium)
    - name: "Total Nar Amount"
      expr: SUM(nar_amount)
    - name: "Average Nar Amount"
      expr: AVG(nar_amount)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_insured_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insured Risk Assessment business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`insured_risk_assessment`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Outcome"
      expr: assessment_outcome
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Insured Sequence Number"
      expr: insured_sequence_number
    - name: "Overall Risk Classification"
      expr: overall_risk_classification
    - name: "Risk Classification"
      expr: risk_classification
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assessment Date Month"
      expr: DATE_TRUNC('MONTH', assessment_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Insured Risk Assessment"
      expr: COUNT(DISTINCT insured_risk_assessment_id)
    - name: "Total Financial Risk Score"
      expr: SUM(financial_risk_score)
    - name: "Average Financial Risk Score"
      expr: AVG(financial_risk_score)
    - name: "Total Medical Risk Score"
      expr: SUM(medical_risk_score)
    - name: "Average Medical Risk Score"
      expr: AVG(medical_risk_score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_kyc_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kyc Verification business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`kyc_verification`"
  dimensions:
    - name: "Aml Program Version"
      expr: aml_program_version
    - name: "Beneficial Owner Verified"
      expr: beneficial_owner_verified
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enhanced Due Diligence Required"
      expr: enhanced_due_diligence_required
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Identity Document Expiry Date"
      expr: identity_document_expiry_date
    - name: "Identity Document Issuing Country"
      expr: identity_document_issuing_country
    - name: "Identity Document Number"
      expr: identity_document_number
    - name: "Identity Document Type"
      expr: identity_document_type
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Kyc Program Type"
      expr: kyc_program_type
    - name: "Mib Check Flag"
      expr: mib_check_flag
    - name: "Mib Match Flag"
      expr: mib_match_flag
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Ofac Match Flag"
      expr: ofac_match_flag
    - name: "Party Role"
      expr: party_role
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Kyc Verification"
      expr: COUNT(DISTINCT kyc_verification_id)
    - name: "Total Ofac Match Score"
      expr: SUM(ofac_match_score)
    - name: "Average Ofac Match Score"
      expr: AVG(ofac_match_score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_ownership_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership Transfer business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`ownership_transfer`"
  dimensions:
    - name: "Aml Review Required"
      expr: aml_review_required
    - name: "Aml Review Status"
      expr: aml_review_status
    - name: "Approval Date"
      expr: approval_date
    - name: "Collateral Assignee Name"
      expr: collateral_assignee_name
    - name: "Collateral Assignment Release Date"
      expr: collateral_assignment_release_date
    - name: "Completion Date"
      expr: completion_date
    - name: "Consideration Currency"
      expr: consideration_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Ilit Indicator"
      expr: ilit_indicator
    - name: "Insurable Interest Verified"
      expr: insurable_interest_verified
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Legal Doc Reference"
      expr: legal_doc_reference
    - name: "Legal Doc Type"
      expr: legal_doc_type
    - name: "Legal Doc Verification Date"
      expr: legal_doc_verification_date
    - name: "Legal Doc Verified"
      expr: legal_doc_verified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ownership Transfer"
      expr: COUNT(DISTINCT ownership_transfer_id)
    - name: "Total Collateral Assignment Amount"
      expr: SUM(collateral_assignment_amount)
    - name: "Average Collateral Assignment Amount"
      expr: AVG(collateral_assignment_amount)
    - name: "Total Consideration Amount"
      expr: SUM(consideration_amount)
    - name: "Average Consideration Amount"
      expr: AVG(consideration_amount)
    - name: "Total Policy Csv At Transfer"
      expr: SUM(policy_csv_at_transfer)
    - name: "Average Policy Csv At Transfer"
      expr: AVG(policy_csv_at_transfer)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`party`"
  dimensions:
    - name: "Aml Risk Rating"
      expr: aml_risk_rating
    - name: "Citizenship Country"
      expr: citizenship_country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Deceased Date"
      expr: deceased_date
    - name: "Deceased Verified Date"
      expr: deceased_verified_date
    - name: "Entity Formation Date"
      expr: entity_formation_date
    - name: "Entity State Of Formation"
      expr: entity_state_of_formation
    - name: "First Name"
      expr: first_name
    - name: "Gender"
      expr: gender
    - name: "Grantor Name"
      expr: grantor_name
    - name: "Kyc Status"
      expr: kyc_status
    - name: "Kyc Verified Date"
      expr: kyc_verified_date
    - name: "Last Name"
      expr: last_name
    - name: "Legal Name"
      expr: legal_name
    - name: "Middle Name"
      expr: middle_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party"
      expr: COUNT(DISTINCT party_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_party_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party Address business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`party_address`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Address Source"
      expr: address_source
    - name: "Address Status"
      expr: address_status
    - name: "Address Type"
      expr: address_type
    - name: "Address Verified By"
      expr: address_verified_by
    - name: "Address Verified Date"
      expr: address_verified_date
    - name: "Cass Return Code"
      expr: cass_return_code
    - name: "Cass Validated"
      expr: cass_validated
    - name: "Cass Validation Date"
      expr: cass_validation_date
    - name: "Census Tract"
      expr: census_tract
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "County"
      expr: county
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Do Not Mail"
      expr: do_not_mail
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party Address"
      expr: COUNT(DISTINCT party_address_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_party_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party Contact business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`party_contact`"
  dimensions:
    - name: "Best Contact Time End"
      expr: best_contact_time_end
    - name: "Best Contact Time Start"
      expr: best_contact_time_start
    - name: "Bounce Count"
      expr: bounce_count
    - name: "Contact Rank"
      expr: contact_rank
    - name: "Contact Status"
      expr: contact_status
    - name: "Contact Subtype"
      expr: contact_subtype
    - name: "Contact Type"
      expr: contact_type
    - name: "Contact Use Purpose"
      expr: contact_use_purpose
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Do Not Contact"
      expr: do_not_contact
    - name: "Do Not Contact Reason"
      expr: do_not_contact_reason
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Opt In Date"
      expr: email_opt_in_date
    - name: "Email Opt In Status"
      expr: email_opt_in_status
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party Contact"
      expr: COUNT(DISTINCT party_contact_id)
    - name: "Total Contact Value"
      expr: SUM(contact_value)
    - name: "Average Contact Value"
      expr: AVG(contact_value)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_policyholder_beneficiary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policyholder Beneficiary business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`policyholder_beneficiary`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Aml Screening Status"
      expr: aml_screening_status
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "Beneficiary Category"
      expr: beneficiary_category
    - name: "Beneficiary Type"
      expr: beneficiary_type
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Designation Form Reference"
      expr: designation_form_reference
    - name: "Designation Sequence"
      expr: designation_sequence
    - name: "Designation Status"
      expr: designation_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Email Address"
      expr: email_address
    - name: "Entity Name"
      expr: entity_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Policyholder Beneficiary"
      expr: COUNT(DISTINCT policyholder_beneficiary_id)
    - name: "Total Designation Percentage"
      expr: SUM(designation_percentage)
    - name: "Average Designation Percentage"
      expr: AVG(designation_percentage)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_policyholder_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policyholder Training Completion business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`policyholder_training_completion`"
  dimensions:
    - name: "Attempt Number"
      expr: attempt_number
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Method"
      expr: completion_method
    - name: "Completion Status"
      expr: completion_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Platform Used"
      expr: delivery_platform_used
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Instructor Name"
      expr: instructor_name
    - name: "Pass Fail Status"
      expr: pass_fail_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Completion Date Month"
      expr: DATE_TRUNC('MONTH', completion_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Policyholder Training Completion"
      expr: COUNT(DISTINCT policyholder_training_completion_id)
    - name: "Total Score"
      expr: SUM(score)
    - name: "Average Score"
      expr: AVG(score)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_power_of_attorney`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Power Of Attorney business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`power_of_attorney`"
  dimensions:
    - name: "Aml Review Required"
      expr: aml_review_required
    - name: "Aml Review Status"
      expr: aml_review_status
    - name: "Beneficiary Change Authority"
      expr: beneficiary_change_authority
    - name: "Claims Authority"
      expr: claims_authority
    - name: "Court Appointment Flag"
      expr: court_appointment_flag
    - name: "Court Case Number"
      expr: court_case_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Verification Date"
      expr: document_verification_date
    - name: "Document Verified"
      expr: document_verified
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Granted Powers"
      expr: granted_powers
    - name: "Guardianship Type"
      expr: guardianship_type
    - name: "Jurisdiction State Code"
      expr: jurisdiction_state_code
    - name: "Kyc Verification Date"
      expr: kyc_verification_date
    - name: "Kyc Verified"
      expr: kyc_verified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Power Of Attorney"
      expr: COUNT(DISTINCT power_of_attorney_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Relationship business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`relationship`"
  dimensions:
    - name: "Aml Review Required"
      expr: aml_review_required
    - name: "Consent Date"
      expr: consent_date
    - name: "Consent Obtained"
      expr: consent_obtained
    - name: "Court Appointment Date"
      expr: court_appointment_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Guardianship Expiration Date"
      expr: guardianship_expiration_date
    - name: "Guardianship Jurisdiction"
      expr: guardianship_jurisdiction
    - name: "Guardianship Type"
      expr: guardianship_type
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Insurable Interest Basis"
      expr: insurable_interest_basis
    - name: "Insurable Interest Verified"
      expr: insurable_interest_verified
    - name: "Is Primary"
      expr: is_primary
    - name: "Kyc Verified"
      expr: kyc_verified
    - name: "Legal Doc Reference"
      expr: legal_doc_reference
    - name: "Legal Doc Type"
      expr: legal_doc_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Relationship"
      expr: COUNT(DISTINCT relationship_id)
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policyholder_trust`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trust business metrics"
  source: "`life_insurance_ecm`.`policyholder`.`trust`"
  dimensions:
    - name: "Aml Risk Rating"
      expr: aml_risk_rating
    - name: "Beneficial Owner Disclosed"
      expr: beneficial_owner_disclosed
    - name: "Beneficial Owner Verified"
      expr: beneficial_owner_verified
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference"
      expr: document_reference
    - name: "Document Verification Date"
      expr: document_verification_date
    - name: "Document Verified"
      expr: document_verified
    - name: "Effective Date"
      expr: effective_date
    - name: "Ein"
      expr: ein
    - name: "Establishment Date"
      expr: establishment_date
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Ilit Indicator"
      expr: ilit_indicator
    - name: "Insurable Interest Basis"
      expr: insurable_interest_basis
    - name: "Insurable Interest Verified"
      expr: insurable_interest_verified
    - name: "Kyc Status"
      expr: kyc_status
    - name: "Kyc Verified Date"
      expr: kyc_verified_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trust"
      expr: COUNT(DISTINCT trust_id)
$$;