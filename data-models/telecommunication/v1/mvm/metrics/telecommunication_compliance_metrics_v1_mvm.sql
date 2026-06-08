-- Metric views for domain: compliance | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:29:05

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit business metrics"
  source: "`telecommunication_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Audit Scope"
      expr: audit_scope
    - name: "Audit Status"
      expr: audit_status
    - name: "Audit Type"
      expr: audit_type
    - name: "Auditing Body"
      expr: auditing_body
    - name: "Auditing Body Accreditation Number"
      expr: auditing_body_accreditation_number
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Certification Issue Date"
      expr: certification_issue_date
    - name: "Certification Issued Flag"
      expr: certification_issued_flag
    - name: "Certification Reference Number"
      expr: certification_reference_number
    - name: "Certification Renewal Status"
      expr: certification_renewal_status
    - name: "Certification Scope"
      expr: certification_scope
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Risk Level"
      expr: compliance_risk_level
    - name: "Corrective Action Deadline"
      expr: corrective_action_deadline
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Audit"
      expr: COUNT(DISTINCT audit_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_data_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data Breach Incident business metrics"
  source: "`telecommunication_ecm`.`compliance`.`data_breach_incident`"
  dimensions:
    - name: "Affected Data Categories"
      expr: affected_data_categories
    - name: "Affected Systems"
      expr: affected_systems
    - name: "Breach Severity Level"
      expr: breach_severity_level
    - name: "Breach Status"
      expr: breach_status
    - name: "Breach Type"
      expr: breach_type
    - name: "Closure Timestamp"
      expr: closure_timestamp
    - name: "Containment Timestamp"
      expr: containment_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Monitoring Offered"
      expr: credit_monitoring_offered
    - name: "Data Exfiltration Confirmed"
      expr: data_exfiltration_confirmed
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Encryption In Place"
      expr: encryption_in_place
    - name: "External Forensics Firm Engaged"
      expr: external_forensics_firm_engaged
    - name: "External Forensics Firm Name"
      expr: external_forensics_firm_name
    - name: "Financial Impact Currency Code"
      expr: financial_impact_currency_code
    - name: "Incident Reference Number"
      expr: incident_reference_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Data Breach Incident"
      expr: COUNT(DISTINCT data_breach_incident_id)
    - name: "Total Confirmed Affected Individuals Count"
      expr: SUM(confirmed_affected_individuals_count)
    - name: "Average Confirmed Affected Individuals Count"
      expr: AVG(confirmed_affected_individuals_count)
    - name: "Total Estimated Affected Individuals Count"
      expr: SUM(estimated_affected_individuals_count)
    - name: "Average Estimated Affected Individuals Count"
      expr: AVG(estimated_affected_individuals_count)
    - name: "Total Estimated Financial Impact Amount"
      expr: SUM(estimated_financial_impact_amount)
    - name: "Average Estimated Financial Impact Amount"
      expr: AVG(estimated_financial_impact_amount)
    - name: "Total Regulatory Fine Amount"
      expr: SUM(regulatory_fine_amount)
    - name: "Average Regulatory Fine Amount"
      expr: AVG(regulatory_fine_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_lawful_intercept_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lawful Intercept Order business metrics"
  source: "`telecommunication_ecm`.`compliance`.`lawful_intercept_order`"
  dimensions:
    - name: "Access Control Level"
      expr: access_control_level
    - name: "Activation Timestamp"
      expr: activation_timestamp
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Chain Of Custody Log"
      expr: chain_of_custody_log
    - name: "Court Order Reference"
      expr: court_order_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Destination"
      expr: delivery_destination
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Encryption Method"
      expr: encryption_method
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Intercept Service Scope"
      expr: intercept_service_scope
    - name: "Intercept Status"
      expr: intercept_status
    - name: "Intercept Technology"
      expr: intercept_technology
    - name: "Intercept Type"
      expr: intercept_type
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Issuing Jurisdiction"
      expr: issuing_jurisdiction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lawful Intercept Order"
      expr: COUNT(DISTINCT lawful_intercept_order_id)
    - name: "Total Total Data Volume Bytes"
      expr: SUM(total_data_volume_bytes)
    - name: "Average Total Data Volume Bytes"
      expr: AVG(total_data_volume_bytes)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_mnp_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mnp Compliance business metrics"
  source: "`telecommunication_ecm`.`compliance`.`mnp_compliance`"
  dimensions:
    - name: "Account Number Verified Flag"
      expr: account_number_verified_flag
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Authorization Method"
      expr: authorization_method
    - name: "Authorization Timestamp"
      expr: authorization_timestamp
    - name: "Billing Address Verified Flag"
      expr: billing_address_verified_flag
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Compliance Review Status"
      expr: compliance_review_status
    - name: "Compliance Review Timestamp"
      expr: compliance_review_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Authorization Verified Flag"
      expr: customer_authorization_verified_flag
    - name: "Data Retention Expiry Date"
      expr: data_retention_expiry_date
    - name: "Donor Operator Code"
      expr: donor_operator_code
    - name: "Donor Operator Name"
      expr: donor_operator_name
    - name: "Fraud Check Status"
      expr: fraud_check_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Msisdn"
      expr: msisdn
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mnp Compliance"
      expr: COUNT(DISTINCT mnp_compliance_id)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Sla Breach Duration Hours"
      expr: SUM(sla_breach_duration_hours)
    - name: "Average Sla Breach Duration Hours"
      expr: AVG(sla_breach_duration_hours)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_privacy_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy Consent business metrics"
  source: "`telecommunication_ecm`.`compliance`.`privacy_consent`"
  dimensions:
    - name: "Audit Rights Granted"
      expr: audit_rights_granted
    - name: "Calea Compliance Flag"
      expr: calea_compliance_flag
    - name: "Consent Category"
      expr: consent_category
    - name: "Consent Channel"
      expr: consent_channel
    - name: "Consent Proof Document Uri"
      expr: consent_proof_document_uri
    - name: "Consent Reference Number"
      expr: consent_reference_number
    - name: "Consent Status"
      expr: consent_status
    - name: "Consent Type"
      expr: consent_type
    - name: "Consent Version"
      expr: consent_version
    - name: "Counterparty Name"
      expr: counterparty_name
    - name: "Counterparty Type"
      expr: counterparty_type
    - name: "Cpni Protection Flag"
      expr: cpni_protection_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Border Transfer Mechanism"
      expr: cross_border_transfer_mechanism
    - name: "Data Categories"
      expr: data_categories
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Privacy Consent"
      expr: COUNT(DISTINCT privacy_consent_id)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy Request business metrics"
  source: "`telecommunication_ecm`.`compliance`.`privacy_request`"
  dimensions:
    - name: "Assignment Timestamp"
      expr: assignment_timestamp
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Complexity Level"
      expr: complexity_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Records Retrieved Count"
      expr: data_records_retrieved_count
    - name: "Data Subject Notified"
      expr: data_subject_notified
    - name: "Data Systems Accessed Count"
      expr: data_systems_accessed_count
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Extended Sla Deadline"
      expr: extended_sla_deadline
    - name: "Fee Currency Code"
      expr: fee_currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Privacy Request"
      expr: COUNT(DISTINCT privacy_request_id)
    - name: "Total Fee Charged Amount"
      expr: SUM(fee_charged_amount)
    - name: "Average Fee Charged Amount"
      expr: AVG(fee_charged_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Filing business metrics"
  source: "`telecommunication_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Amendment Flag"
      expr: amendment_flag
    - name: "Comment Period End Date"
      expr: comment_period_end_date
    - name: "Compliance Risk Level"
      expr: compliance_risk_level
    - name: "Confidential Treatment Requested"
      expr: confidential_treatment_requested
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Count"
      expr: document_count
    - name: "Due Date"
      expr: due_date
    - name: "External Counsel Firm Name"
      expr: external_counsel_firm_name
    - name: "External Counsel Involved"
      expr: external_counsel_involved
    - name: "Filing Description"
      expr: filing_description
    - name: "Filing Fee Currency Code"
      expr: filing_fee_currency_code
    - name: "Filing Format"
      expr: filing_format
    - name: "Filing Period End Date"
      expr: filing_period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Filing"
      expr: COUNT(DISTINCT regulatory_filing_id)
    - name: "Total Filing Fee Amount"
      expr: SUM(filing_fee_amount)
    - name: "Average Filing Fee Amount"
      expr: AVG(filing_fee_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Obligation business metrics"
  source: "`telecommunication_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "Applicable Service Types"
      expr: applicable_service_types
    - name: "Audit Trail Required Flag"
      expr: audit_trail_required_flag
    - name: "Automation Feasibility"
      expr: automation_feasibility
    - name: "Compliance Frequency"
      expr: compliance_frequency
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Period Days"
      expr: data_retention_period_days
    - name: "Effective Date"
      expr: effective_date
    - name: "Enforcement Authority"
      expr: enforcement_authority
    - name: "Exemption Expiry Date"
      expr: exemption_expiry_date
    - name: "Exemption Status"
      expr: exemption_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Internal Policy Reference"
      expr: internal_policy_reference
    - name: "Is Active"
      expr: is_active
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Compliance Assessment Date"
      expr: last_compliance_assessment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Obligation"
      expr: COUNT(DISTINCT regulatory_obligation_id)
    - name: "Total Annual Compliance Cost Estimate"
      expr: SUM(annual_compliance_cost_estimate)
    - name: "Average Annual Compliance Cost Estimate"
      expr: AVG(annual_compliance_cost_estimate)
    - name: "Total Maximum Penalty Amount"
      expr: SUM(maximum_penalty_amount)
    - name: "Average Maximum Penalty Amount"
      expr: AVG(maximum_penalty_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_spectrum_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spectrum License business metrics"
  source: "`telecommunication_ecm`.`compliance`.`spectrum_license`"
  dimensions:
    - name: "Acquisition Cost Currency Code"
      expr: acquisition_cost_currency_code
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Acquisition Method"
      expr: acquisition_method
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Enforcement Action Description"
      expr: enforcement_action_description
    - name: "Enforcement Action Flag"
      expr: enforcement_action_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fee Currency Code"
      expr: fee_currency_code
    - name: "Frequency Band"
      expr: frequency_band
    - name: "Granting Authority"
      expr: granting_authority
    - name: "Granting Authority Country Code"
      expr: granting_authority_country_code
    - name: "Interference Protection Flag"
      expr: interference_protection_flag
    - name: "Issue Date"
      expr: issue_date
    - name: "Last Compliance Review Date"
      expr: last_compliance_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spectrum License"
      expr: COUNT(DISTINCT spectrum_license_id)
    - name: "Total Acquisition Cost Amount"
      expr: SUM(acquisition_cost_amount)
    - name: "Average Acquisition Cost Amount"
      expr: AVG(acquisition_cost_amount)
    - name: "Total Annual Fee Amount"
      expr: SUM(annual_fee_amount)
    - name: "Average Annual Fee Amount"
      expr: AVG(annual_fee_amount)
    - name: "Total Bandwidth Mhz"
      expr: SUM(bandwidth_mhz)
    - name: "Average Bandwidth Mhz"
      expr: AVG(bandwidth_mhz)
    - name: "Total Lower Frequency Mhz"
      expr: SUM(lower_frequency_mhz)
    - name: "Average Lower Frequency Mhz"
      expr: AVG(lower_frequency_mhz)
    - name: "Total Minimum Utilization Percentage"
      expr: SUM(minimum_utilization_percentage)
    - name: "Average Minimum Utilization Percentage"
      expr: AVG(minimum_utilization_percentage)
    - name: "Total Upper Frequency Mhz"
      expr: SUM(upper_frequency_mhz)
    - name: "Average Upper Frequency Mhz"
      expr: AVG(upper_frequency_mhz)
$$;