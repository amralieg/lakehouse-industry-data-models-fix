-- Metric views for domain: contract | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:45:21

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation business metrics"
  source: "`staffing_hr_ecm`.`contract`.`allocation`"
  dimensions:
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Reason"
      expr: reason
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Allocation"
      expr: COUNT(DISTINCT allocation_id)
    - name: "Total Actual Cost To Date"
      expr: SUM(actual_cost_to_date)
    - name: "Average Actual Cost To Date"
      expr: AVG(actual_cost_to_date)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment business metrics"
  source: "`staffing_hr_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Status"
      expr: amendment_status
    - name: "Amendment Type"
      expr: amendment_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Change Summary"
      expr: change_summary
    - name: "Client Signatory Name"
      expr: client_signatory_name
    - name: "Client Signatory Title"
      expr: client_signatory_title
    - name: "Client Signature Date"
      expr: client_signature_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Url"
      expr: document_url
    - name: "Effective Date"
      expr: effective_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Finance Approval Date"
      expr: finance_approval_date
    - name: "Finance Approval Notes"
      expr: finance_approval_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Amendment"
      expr: COUNT(DISTINCT amendment_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_contract_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Approval Workflow business metrics"
  source: "`staffing_hr_ecm`.`contract`.`contract_approval_workflow`"
  dimensions:
    - name: "Approval Comments"
      expr: approval_comments
    - name: "Approval Threshold Tier"
      expr: approval_threshold_tier
    - name: "Completed Stages Count"
      expr: completed_stages_count
    - name: "Compliance Review Required Flag"
      expr: compliance_review_required_flag
    - name: "Current Approver Role"
      expr: current_approver_role
    - name: "Current Stage Name"
      expr: current_stage_name
    - name: "Current Stage Sequence"
      expr: current_stage_sequence
    - name: "Delegation Allowed Flag"
      expr: delegation_allowed_flag
    - name: "Delegation Reason"
      expr: delegation_reason
    - name: "Escalated Timestamp"
      expr: escalated_timestamp
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Final Decision"
      expr: final_decision
    - name: "Final Decision Timestamp"
      expr: final_decision_timestamp
    - name: "Finance Review Required Flag"
      expr: finance_review_required_flag
    - name: "Initiated Timestamp"
      expr: initiated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Approval Workflow"
      expr: COUNT(DISTINCT contract_approval_workflow_id)
    - name: "Total Contract Value Usd"
      expr: SUM(contract_value_usd)
    - name: "Average Contract Value Usd"
      expr: AVG(contract_value_usd)
    - name: "Total Total Elapsed Hours"
      expr: SUM(total_elapsed_hours)
    - name: "Average Total Elapsed Hours"
      expr: AVG(total_elapsed_hours)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_contract_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Document business metrics"
  source: "`staffing_hr_ecm`.`contract`.`contract_document`"
  dimensions:
    - name: "Amendment Flag"
      expr: amendment_flag
    - name: "Audit Trail Available Flag"
      expr: audit_trail_available_flag
    - name: "Checksum Hash"
      expr: checksum_hash
    - name: "Client Signatory Email"
      expr: client_signatory_email
    - name: "Client Signatory Name"
      expr: client_signatory_name
    - name: "Client Signatory Title"
      expr: client_signatory_title
    - name: "Confidentiality Classification"
      expr: confidentiality_classification
    - name: "Created Date"
      expr: created_date
    - name: "Document Name"
      expr: document_name
    - name: "Document Status"
      expr: document_status
    - name: "Document Type"
      expr: document_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Esignature Completed Flag"
      expr: esignature_completed_flag
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "File Format"
      expr: file_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Document"
      expr: COUNT(DISTINCT contract_document_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_contract_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Rate Schedule business metrics"
  source: "`staffing_hr_ecm`.`contract`.`contract_rate_schedule`"
  dimensions:
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Reason"
      expr: amendment_reason
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Active"
      expr: is_active
    - name: "Job Category"
      expr: job_category
    - name: "Labor Classification"
      expr: labor_classification
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Rate Card Version"
      expr: rate_card_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Rate Schedule"
      expr: COUNT(DISTINCT contract_rate_schedule_id)
    - name: "Total Bill Rate"
      expr: SUM(bill_rate)
    - name: "Average Bill Rate"
      expr: AVG(bill_rate)
    - name: "Total Burden Rate"
      expr: SUM(burden_rate)
    - name: "Average Burden Rate"
      expr: AVG(burden_rate)
    - name: "Total Double Time Multiplier"
      expr: SUM(double_time_multiplier)
    - name: "Average Double Time Multiplier"
      expr: AVG(double_time_multiplier)
    - name: "Total Gross Margin Percentage"
      expr: SUM(gross_margin_percentage)
    - name: "Average Gross Margin Percentage"
      expr: AVG(gross_margin_percentage)
    - name: "Total Markup Percentage"
      expr: SUM(markup_percentage)
    - name: "Average Markup Percentage"
      expr: AVG(markup_percentage)
    - name: "Total Overtime Multiplier"
      expr: SUM(overtime_multiplier)
    - name: "Average Overtime Multiplier"
      expr: AVG(overtime_multiplier)
    - name: "Total Pay Rate"
      expr: SUM(pay_rate)
    - name: "Average Pay Rate"
      expr: AVG(pay_rate)
    - name: "Total Per Diem Allowance"
      expr: SUM(per_diem_allowance)
    - name: "Average Per Diem Allowance"
      expr: AVG(per_diem_allowance)
    - name: "Total Spread"
      expr: SUM(spread)
    - name: "Average Spread"
      expr: AVG(spread)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_envelope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Envelope business metrics"
  source: "`staffing_hr_ecm`.`contract`.`envelope`"
  dimensions:
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Brand Code"
      expr: brand_code
    - name: "Certificate Of Completion Url"
      expr: certificate_of_completion_url
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custom Field 1"
      expr: custom_field_1
    - name: "Custom Field 2"
      expr: custom_field_2
    - name: "Custom Field 3"
      expr: custom_field_3
    - name: "Declined Reason"
      expr: declined_reason
    - name: "Declined Timestamp"
      expr: declined_timestamp
    - name: "Delivered Timestamp"
      expr: delivered_timestamp
    - name: "Document Type"
      expr: document_type
    - name: "Envelope Status"
      expr: envelope_status
    - name: "Expiration Enabled"
      expr: expiration_enabled
    - name: "Expiration Timestamp"
      expr: expiration_timestamp
    - name: "External Reference Code"
      expr: external_reference_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Envelope"
      expr: COUNT(DISTINCT envelope_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_ic_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ic Agreement business metrics"
  source: "`staffing_hr_ecm`.`contract`.`ic_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Title"
      expr: agreement_title
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Background Check Required Flag"
      expr: background_check_required_flag
    - name: "Client Signatory Name"
      expr: client_signatory_name
    - name: "Client Signatory Title"
      expr: client_signatory_title
    - name: "Confidentiality Term Years"
      expr: confidentiality_term_years
    - name: "Contract Type"
      expr: contract_type
    - name: "Contractor Signatory Name"
      expr: contractor_signatory_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Drug Screen Required Flag"
      expr: drug_screen_required_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Executed Date"
      expr: executed_date
    - name: "Expense Reimbursement Flag"
      expr: expense_reimbursement_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ic Agreement"
      expr: COUNT(DISTINCT ic_agreement_id)
    - name: "Total General Liability Minimum Usd"
      expr: SUM(general_liability_minimum_usd)
    - name: "Average General Liability Minimum Usd"
      expr: AVG(general_liability_minimum_usd)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Payment Rate"
      expr: SUM(payment_rate)
    - name: "Average Payment Rate"
      expr: AVG(payment_rate)
    - name: "Total Professional Liability Minimum Usd"
      expr: SUM(professional_liability_minimum_usd)
    - name: "Average Professional Liability Minimum Usd"
      expr: AVG(professional_liability_minimum_usd)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_msa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Msa business metrics"
  source: "`staffing_hr_ecm`.`contract`.`msa`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Background Check Required Flag"
      expr: background_check_required_flag
    - name: "Client Signatory Name"
      expr: client_signatory_name
    - name: "Client Signatory Title"
      expr: client_signatory_title
    - name: "Confidentiality Term Years"
      expr: confidentiality_term_years
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Drug Screen Required Flag"
      expr: drug_screen_required_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Everify Required Flag"
      expr: everify_required_flag
    - name: "Executed Date"
      expr: executed_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Indemnification Scope"
      expr: indemnification_scope
    - name: "Initial Term Months"
      expr: initial_term_months
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Msa"
      expr: COUNT(DISTINCT msa_id)
    - name: "Total Conversion Fee Percentage"
      expr: SUM(conversion_fee_percentage)
    - name: "Average Conversion Fee Percentage"
      expr: AVG(conversion_fee_percentage)
    - name: "Total Errors Omissions Minimum Usd"
      expr: SUM(errors_omissions_minimum_usd)
    - name: "Average Errors Omissions Minimum Usd"
      expr: AVG(errors_omissions_minimum_usd)
    - name: "Total General Liability Minimum Usd"
      expr: SUM(general_liability_minimum_usd)
    - name: "Average General Liability Minimum Usd"
      expr: AVG(general_liability_minimum_usd)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Workers Comp Minimum Usd"
      expr: SUM(workers_comp_minimum_usd)
    - name: "Average Workers Comp Minimum Usd"
      expr: AVG(workers_comp_minimum_usd)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_msa_credential_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Msa Credential Requirement business metrics"
  source: "`staffing_hr_ecm`.`contract`.`msa_credential_requirement`"
  dimensions:
    - name: "Acceptable Expiry Window Days"
      expr: acceptable_expiry_window_days
    - name: "Client Specific Notes"
      expr: client_specific_notes
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Max Credential Age Days"
      expr: max_credential_age_days
    - name: "Renewal Lead Time Days"
      expr: renewal_lead_time_days
    - name: "Requirement Status"
      expr: requirement_status
    - name: "Verification Level"
      expr: verification_level
    - name: "Waiver Allowed Flag"
      expr: waiver_allowed_flag
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
    - name: "Expiration Date Month"
      expr: DATE_TRUNC('MONTH', expiration_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Msa Credential Requirement"
      expr: COUNT(DISTINCT msa_credential_requirement_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_nda`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nda business metrics"
  source: "`staffing_hr_ecm`.`contract`.`nda`"
  dimensions:
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Carve Outs"
      expr: carve_outs
    - name: "Confidentiality Duration Months"
      expr: confidentiality_duration_months
    - name: "Confidentiality Scope"
      expr: confidentiality_scope
    - name: "Counterparty Title"
      expr: counterparty_title
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Url"
      expr: document_url
    - name: "Effective Date"
      expr: effective_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Governing Law"
      expr: governing_law
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Nda Number"
      expr: nda_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nda"
      expr: COUNT(DISTINCT nda_id)
    - name: "Total Liquidated Damages Amount"
      expr: SUM(liquidated_damages_amount)
    - name: "Average Liquidated Damages Amount"
      expr: AVG(liquidated_damages_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_non_compete`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non Compete business metrics"
  source: "`staffing_hr_ecm`.`contract`.`non_compete`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Breach Date"
      expr: breach_date
    - name: "Breach Description"
      expr: breach_description
    - name: "Breach Reported"
      expr: breach_reported
    - name: "Candidate Solicitation Prohibited"
      expr: candidate_solicitation_prohibited
    - name: "Client Solicitation Prohibited"
      expr: client_solicitation_prohibited
    - name: "Competitive Employment Prohibited"
      expr: competitive_employment_prohibited
    - name: "Consideration Provided"
      expr: consideration_provided
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enforceability Status"
      expr: enforceability_status
    - name: "Execution Date"
      expr: execution_date
    - name: "Execution Status"
      expr: execution_status
    - name: "Geographic Restriction Type"
      expr: geographic_restriction_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Non Compete"
      expr: COUNT(DISTINCT non_compete_id)
    - name: "Total Consideration Amount"
      expr: SUM(consideration_amount)
    - name: "Average Consideration Amount"
      expr: AVG(consideration_amount)
    - name: "Total Geographic Radius Miles"
      expr: SUM(geographic_radius_miles)
    - name: "Average Geographic Radius Miles"
      expr: AVG(geographic_radius_miles)
    - name: "Total Liquidated Damages Amount"
      expr: SUM(liquidated_damages_amount)
    - name: "Average Liquidated Damages Amount"
      expr: AVG(liquidated_damages_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation business metrics"
  source: "`staffing_hr_ecm`.`contract`.`obligation`"
  dimensions:
    - name: "Amendment Reference"
      expr: amendment_reference
    - name: "Audit Ready Flag"
      expr: audit_ready_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Until Due"
      expr: days_until_due
    - name: "Due Date"
      expr: due_date
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Escalation Owner Name"
      expr: escalation_owner_name
    - name: "Evidence Document Reference"
      expr: evidence_document_reference
    - name: "Evidence Submission Date"
      expr: evidence_submission_date
    - name: "Evidence Verified Flag"
      expr: evidence_verified_flag
    - name: "Fulfillment Date"
      expr: fulfillment_date
    - name: "Last Notification Date"
      expr: last_notification_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Obligation"
      expr: COUNT(DISTINCT obligation_id)
    - name: "Total Compliance Score"
      expr: SUM(compliance_score)
    - name: "Average Compliance Score"
      expr: AVG(compliance_score)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewal business metrics"
  source: "`staffing_hr_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Acknowledgment Status"
      expr: acknowledgment_status
    - name: "Alert Lead Time Days"
      expr: alert_lead_time_days
    - name: "Alert Sent Date"
      expr: alert_sent_date
    - name: "Alert Sent Flag"
      expr: alert_sent_flag
    - name: "Auto Renewal Enabled Flag"
      expr: auto_renewal_enabled_flag
    - name: "Compliance Filing Deadline Date"
      expr: compliance_filing_deadline_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Insurance Certificate Renewal Date"
      expr: insurance_certificate_renewal_date
    - name: "Negotiation End Date"
      expr: negotiation_end_date
    - name: "Negotiation Start Date"
      expr: negotiation_start_date
    - name: "Negotiation Status"
      expr: negotiation_status
    - name: "Notes"
      expr: notes
    - name: "Notice Deadline Date"
      expr: notice_deadline_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Renewal"
      expr: COUNT(DISTINCT renewal_id)
    - name: "Total Rate Change Percentage"
      expr: SUM(rate_change_percentage)
    - name: "Average Rate Change Percentage"
      expr: AVG(rate_change_percentage)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla business metrics"
  source: "`staffing_hr_ecm`.`contract`.`sla`"
  dimensions:
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Reason"
      expr: amendment_reason
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Contact"
      expr: escalation_contact
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geography Scope"
      expr: geography_scope
    - name: "Job Category Scope"
      expr: job_category_scope
    - name: "Measurement End Date"
      expr: measurement_end_date
    - name: "Measurement Frequency"
      expr: measurement_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla"
      expr: COUNT(DISTINCT sla_id)
    - name: "Total Breach Threshold"
      expr: SUM(breach_threshold)
    - name: "Average Breach Threshold"
      expr: AVG(breach_threshold)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Penalty Cap Amount"
      expr: SUM(penalty_cap_amount)
    - name: "Average Penalty Cap Amount"
      expr: AVG(penalty_cap_amount)
    - name: "Total Penalty Percentage"
      expr: SUM(penalty_percentage)
    - name: "Average Penalty Percentage"
      expr: AVG(penalty_percentage)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_sla_breach_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Breach Event business metrics"
  source: "`staffing_hr_ecm`.`contract`.`sla_breach_event`"
  dimensions:
    - name: "Breach Event Number"
      expr: breach_event_number
    - name: "Breach Status"
      expr: breach_status
    - name: "Breach Timestamp"
      expr: breach_timestamp
    - name: "Breach Type"
      expr: breach_type
    - name: "Client Notification Sent Flag"
      expr: client_notification_sent_flag
    - name: "Client Notification Timestamp"
      expr: client_notification_timestamp
    - name: "Client Response"
      expr: client_response
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Escalation Recipient Name"
      expr: escalation_recipient_name
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Impact Description"
      expr: impact_description
    - name: "Measurement Period End Date"
      expr: measurement_period_end_date
    - name: "Measurement Period Start Date"
      expr: measurement_period_start_date
    - name: "Metric Name"
      expr: metric_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Breach Event"
      expr: COUNT(DISTINCT sla_breach_event_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Variance"
      expr: SUM(variance)
    - name: "Average Variance"
      expr: AVG(variance)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_sow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sow business metrics"
  source: "`staffing_hr_ecm`.`contract`.`sow`"
  dimensions:
    - name: "Acceptance Criteria"
      expr: acceptance_criteria
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Background Check Required Flag"
      expr: background_check_required_flag
    - name: "Client Signatory Name"
      expr: client_signatory_name
    - name: "Client Signatory Title"
      expr: client_signatory_title
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deliverables Summary"
      expr: deliverables_summary
    - name: "Drug Screen Required Flag"
      expr: drug_screen_required_flag
    - name: "End Date"
      expr: end_date
    - name: "Estimated Duration Days"
      expr: estimated_duration_days
    - name: "Estimated Headcount"
      expr: estimated_headcount
    - name: "Governing Law Jurisdiction"
      expr: governing_law_jurisdiction
    - name: "Insurance Requirements"
      expr: insurance_requirements
    - name: "Invoice Frequency"
      expr: invoice_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sow"
      expr: COUNT(DISTINCT sow_id)
    - name: "Total Estimated Fte Count"
      expr: SUM(estimated_fte_count)
    - name: "Average Estimated Fte Count"
      expr: AVG(estimated_fte_count)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_sow_credential_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sow Credential Requirement business metrics"
  source: "`staffing_hr_ecm`.`contract`.`sow_credential_requirement`"
  dimensions:
    - name: "Acceptable Expiry Window Days"
      expr: acceptable_expiry_window_days
    - name: "Applies To Assignment Start"
      expr: applies_to_assignment_start
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Notes"
      expr: notes
    - name: "Requirement Source"
      expr: requirement_source
    - name: "Verification Level"
      expr: verification_level
    - name: "Waiver Allowed"
      expr: waiver_allowed
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sow Credential Requirement"
      expr: COUNT(DISTINCT sow_credential_requirement_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Template business metrics"
  source: "`staffing_hr_ecm`.`contract`.`template`"
  dimensions:
    - name: "Applicable Client Segments"
      expr: applicable_client_segments
    - name: "Applicable Industries"
      expr: applicable_industries
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Date"
      expr: approved_date
    - name: "Configurable Parameters"
      expr: configurable_parameters
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Jurisdiction"
      expr: default_jurisdiction
    - name: "Default Liability Cap Currency"
      expr: default_liability_cap_currency
    - name: "Default Notice Period Days"
      expr: default_notice_period_days
    - name: "Default Payment Terms"
      expr: default_payment_terms
    - name: "Deprecated Date"
      expr: deprecated_date
    - name: "Docusign Template Reference"
      expr: docusign_template_reference
    - name: "E Signature Enabled"
      expr: e_signature_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Template"
      expr: COUNT(DISTINCT template_id)
    - name: "Total Default Liability Cap Amount"
      expr: SUM(default_liability_cap_amount)
    - name: "Average Default Liability Cap Amount"
      expr: AVG(default_liability_cap_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_vendor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Agreement business metrics"
  source: "`staffing_hr_ecm`.`contract`.`vendor_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Title"
      expr: agreement_title
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Background Check Required Flag"
      expr: background_check_required_flag
    - name: "Background Check Standard"
      expr: background_check_standard
    - name: "Confidentiality Term Years"
      expr: confidentiality_term_years
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Diversity Certification Status"
      expr: diversity_certification_status
    - name: "Drug Screen Panel Type"
      expr: drug_screen_panel_type
    - name: "Drug Screen Required Flag"
      expr: drug_screen_required_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Everify Required Flag"
      expr: everify_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Agreement"
      expr: COUNT(DISTINCT vendor_agreement_id)
    - name: "Total Errors Omissions Minimum Usd"
      expr: SUM(errors_omissions_minimum_usd)
    - name: "Average Errors Omissions Minimum Usd"
      expr: AVG(errors_omissions_minimum_usd)
    - name: "Total General Liability Minimum Usd"
      expr: SUM(general_liability_minimum_usd)
    - name: "Average General Liability Minimum Usd"
      expr: AVG(general_liability_minimum_usd)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Markup Cap Percentage"
      expr: SUM(markup_cap_percentage)
    - name: "Average Markup Cap Percentage"
      expr: AVG(markup_cap_percentage)
    - name: "Total Workers Comp Minimum Usd"
      expr: SUM(workers_comp_minimum_usd)
    - name: "Average Workers Comp Minimum Usd"
      expr: AVG(workers_comp_minimum_usd)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`contract_vendor_cost_center_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Cost Center Allocation business metrics"
  source: "`staffing_hr_ecm`.`contract`.`vendor_cost_center_allocation`"
  dimensions:
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Authorization Date"
      expr: authorization_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Spend Limit Currency"
      expr: spend_limit_currency
    - name: "Authorization Date Month"
      expr: DATE_TRUNC('MONTH', authorization_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Cost Center Allocation"
      expr: COUNT(DISTINCT vendor_cost_center_allocation_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Spend Limit Amount"
      expr: SUM(spend_limit_amount)
    - name: "Average Spend Limit Amount"
      expr: AVG(spend_limit_amount)
$$;