-- Metric views for domain: customer | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:27:35

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`account`"
  dimensions:
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Assigned Territory"
      expr: assigned_territory
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Account Code"
      expr: crm_account_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Dba Name"
      expr: dba_name
    - name: "Duns Number"
      expr: duns_number
    - name: "Erp Customer Number"
      expr: erp_customer_number
    - name: "Established Date"
      expr: established_date
    - name: "Gdpr Consent Date"
      expr: gdpr_consent_date
    - name: "Gdpr Consent Flag"
      expr: gdpr_consent_flag
    - name: "Hipaa Baa Effective Date"
      expr: hipaa_baa_effective_date
    - name: "Hipaa Baa Flag"
      expr: hipaa_baa_flag
    - name: "Industry Vertical"
      expr: industry_vertical
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Account"
      expr: COUNT(DISTINCT account_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`accreditation`"
  dimensions:
    - name: "Accreditation Scope"
      expr: accreditation_scope
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Accreditation Type"
      expr: accreditation_type
    - name: "Audit Frequency Months"
      expr: audit_frequency_months
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Complexity Level"
      expr: complexity_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Url"
      expr: document_url
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Gxp Compliance Status"
      expr: gxp_compliance_status
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Body"
      expr: issuing_body
    - name: "Ivd Authorized Flag"
      expr: ivd_authorized_flag
    - name: "Laboratory Director License Number"
      expr: laboratory_director_license_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accreditation"
      expr: COUNT(DISTINCT accreditation_id)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Address business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`address`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Address Type"
      expr: address_type
    - name: "Biosafety Level"
      expr: biosafety_level
    - name: "City"
      expr: city
    - name: "Cold Chain Eligible Flag"
      expr: cold_chain_eligible_flag
    - name: "Cold Chain Temperature Range"
      expr: cold_chain_temperature_range
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Instructions"
      expr: delivery_instructions
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hazmat Receiving Authorized Flag"
      expr: hazmat_receiving_authorized_flag
    - name: "Hazmat Un Classes Accepted"
      expr: hazmat_un_classes_accepted
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line 1"
      expr: line_1
    - name: "Line 2"
      expr: line_2
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Address"
      expr: COUNT(DISTINCT address_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contact business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`contact`"
  dimensions:
    - name: "Contact Role"
      expr: contact_role
    - name: "Contact Status"
      expr: contact_status
    - name: "Contact Type"
      expr: contact_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department"
      expr: department
    - name: "Email Address"
      expr: email_address
    - name: "Fax Number"
      expr: fax_number
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
    - name: "Gdpr Consent Date"
      expr: gdpr_consent_date
    - name: "Gdpr Consent Status"
      expr: gdpr_consent_status
    - name: "Job Title"
      expr: job_title
    - name: "Language Preference"
      expr: language_preference
    - name: "Last Activity Date"
      expr: last_activity_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Name"
      expr: last_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contact"
      expr: COUNT(DISTINCT contact_id)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_installed_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Installed Instrument business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`installed_instrument`"
  dimensions:
    - name: "Biosafety Level"
      expr: biosafety_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Data Sharing Consent Status"
      expr: data_sharing_consent_status
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Instrument Location Description"
      expr: instrument_location_description
    - name: "Instrument Serial Number"
      expr: instrument_serial_number
    - name: "Instrument Status"
      expr: instrument_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Service Date"
      expr: last_service_date
    - name: "Network Connectivity Type"
      expr: network_connectivity_type
    - name: "Next Scheduled Service Date"
      expr: next_scheduled_service_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Installed Instrument"
      expr: COUNT(DISTINCT installed_instrument_id)
    - name: "Total Total Operational Hours"
      expr: SUM(total_operational_hours)
    - name: "Average Total Operational Hours"
      expr: AVG(total_operational_hours)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "Application Area"
      expr: application_area
    - name: "Attendee Count"
      expr: attendee_count
    - name: "Channel"
      expr: channel
    - name: "Competitive Mention Flag"
      expr: competitive_mention_flag
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Employee Role"
      expr: employee_role
    - name: "Gdpr Consent Verified Flag"
      expr: gdpr_consent_verified_flag
    - name: "Interaction Date"
      expr: interaction_date
    - name: "Interaction Status"
      expr: interaction_status
    - name: "Interaction Timestamp"
      expr: interaction_timestamp
    - name: "Interaction Type"
      expr: interaction_type
    - name: "Language"
      expr: language
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Interaction"
      expr: COUNT(DISTINCT interaction_id)
    - name: "Total Engagement Score"
      expr: SUM(engagement_score)
    - name: "Average Engagement Score"
      expr: AVG(engagement_score)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`segment`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Consent Requirement Flag"
      expr: consent_requirement_flag
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Gxp Compliance Required Flag"
      expr: gxp_compliance_required_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Sub Vertical"
      expr: market_sub_vertical
    - name: "Market Vertical"
      expr: market_vertical
    - name: "Owner Email"
      expr: owner_email
    - name: "Owner Name"
      expr: owner_name
    - name: "Payment Terms Days"
      expr: payment_terms_days
    - name: "Phi Handling Required Flag"
      expr: phi_handling_required_flag
    - name: "Preferred Sales Channel"
      expr: preferred_sales_channel
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Segment"
      expr: COUNT(DISTINCT segment_id)
    - name: "Total Credit Limit Usd"
      expr: SUM(credit_limit_usd)
    - name: "Average Credit Limit Usd"
      expr: AVG(credit_limit_usd)
    - name: "Total Target Annual Revenue Usd"
      expr: SUM(target_annual_revenue_usd)
    - name: "Average Target Annual Revenue Usd"
      expr: AVG(target_annual_revenue_usd)
    - name: "Total Target Asp Usd"
      expr: SUM(target_asp_usd)
    - name: "Average Target Asp Usd"
      expr: AVG(target_asp_usd)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Agreement business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`service_agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Commercial Conversion Outcome"
      expr: commercial_conversion_outcome
    - name: "Confidentiality Agreement Flag"
      expr: confidentiality_agreement_flag
    - name: "Contract Owner"
      expr: contract_owner
    - name: "Covered Instruments"
      expr: covered_instruments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Feedback Summary"
      expr: customer_feedback_summary
    - name: "End Date"
      expr: end_date
    - name: "Escalation Contact"
      expr: escalation_contact
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Agreement"
      expr: COUNT(DISTINCT service_agreement_id)
    - name: "Total Annual Contract Value"
      expr: SUM(annual_contract_value)
    - name: "Average Annual Contract Value"
      expr: AVG(annual_contract_value)
    - name: "Total Response Time Hours"
      expr: SUM(response_time_hours)
    - name: "Average Response Time Hours"
      expr: AVG(response_time_hours)
    - name: "Total Uptime Guarantee Percentage"
      expr: SUM(uptime_guarantee_percentage)
    - name: "Average Uptime Guarantee Percentage"
      expr: AVG(uptime_guarantee_percentage)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_support_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Support Case business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`support_case`"
  dimensions:
    - name: "Assigned To Team"
      expr: assigned_to_team
    - name: "Case Number"
      expr: case_number
    - name: "Case Status"
      expr: case_status
    - name: "Case Type"
      expr: case_type
    - name: "Channel"
      expr: channel
    - name: "Closed Date"
      expr: closed_date
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Feedback"
      expr: customer_feedback
    - name: "Customer Satisfaction Score"
      expr: customer_satisfaction_score
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "On Site Visit Required Flag"
      expr: on_site_visit_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Support Case"
      expr: COUNT(DISTINCT support_case_id)
    - name: "Total Sla Target Hours"
      expr: SUM(sla_target_hours)
    - name: "Average Sla Target Hours"
      expr: AVG(sla_target_hours)
    - name: "Total Tat Hours"
      expr: SUM(tat_hours)
    - name: "Average Tat Hours"
      expr: AVG(tat_hours)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_technical_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technical Requirement business metrics"
  source: "`genomics_biotech_ecm`.`customer`.`technical_requirement`"
  dimensions:
    - name: "Application Type"
      expr: application_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Capture Timestamp"
      expr: capture_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Delivery Format"
      expr: data_delivery_format
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
    - name: "Data Storage Location Preference"
      expr: data_storage_location_preference
    - name: "Engagement Type"
      expr: engagement_type
    - name: "Flow Cell Type"
      expr: flow_cell_type
    - name: "Gxp Compliance Required Flag"
      expr: gxp_compliance_required_flag
    - name: "Index Strategy"
      expr: index_strategy
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Library Prep Method"
      expr: library_prep_method
    - name: "Multiplexing Required Flag"
      expr: multiplexing_required_flag
    - name: "Notes"
      expr: notes
    - name: "Phi Handling Required Flag"
      expr: phi_handling_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Technical Requirement"
      expr: COUNT(DISTINCT technical_requirement_id)
    - name: "Total Budget Constraint Usd"
      expr: SUM(budget_constraint_usd)
    - name: "Average Budget Constraint Usd"
      expr: AVG(budget_constraint_usd)
    - name: "Total Minimum Coverage Depth"
      expr: SUM(minimum_coverage_depth)
    - name: "Average Minimum Coverage Depth"
      expr: AVG(minimum_coverage_depth)
    - name: "Total Target Coverage Depth"
      expr: SUM(target_coverage_depth)
    - name: "Average Target Coverage Depth"
      expr: AVG(target_coverage_depth)
    - name: "Total Throughput Requirement Gb"
      expr: SUM(throughput_requirement_gb)
    - name: "Average Throughput Requirement Gb"
      expr: AVG(throughput_requirement_gb)
$$;