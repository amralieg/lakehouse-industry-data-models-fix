-- Metric views for domain: contract | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:58:38

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_afa_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Afa Arrangement business metrics"
  source: "`legal_ecm`.`contract`.`afa_arrangement`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Arrangement Name"
      expr: arrangement_name
    - name: "Arrangement Number"
      expr: arrangement_number
    - name: "Arrangement Status"
      expr: arrangement_status
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Disbursement Handling"
      expr: disbursement_handling
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active"
      expr: is_active
    - name: "Ledes Billing Code"
      expr: ledes_billing_code
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Afa Arrangement"
      expr: COUNT(DISTINCT afa_arrangement_id)
    - name: "Total Actual Hours To Date"
      expr: SUM(actual_hours_to_date)
    - name: "Average Actual Hours To Date"
      expr: AVG(actual_hours_to_date)
    - name: "Total Afa In Agreement"
      expr: SUM(afa_in_agreement)
    - name: "Average Afa In Agreement"
      expr: AVG(afa_in_agreement)
    - name: "Total Afa To Agreement"
      expr: SUM(afa_to_agreement)
    - name: "Average Afa To Agreement"
      expr: AVG(afa_to_agreement)
    - name: "Total Agreed Fee Amount"
      expr: SUM(agreed_fee_amount)
    - name: "Average Agreed Fee Amount"
      expr: AVG(agreed_fee_amount)
    - name: "Total Blended Rate Amount"
      expr: SUM(blended_rate_amount)
    - name: "Average Blended Rate Amount"
      expr: AVG(blended_rate_amount)
    - name: "Total Budget Cap Amount"
      expr: SUM(budget_cap_amount)
    - name: "Average Budget Cap Amount"
      expr: AVG(budget_cap_amount)
    - name: "Total Collected Amount To Date"
      expr: SUM(collected_amount_to_date)
    - name: "Average Collected Amount To Date"
      expr: AVG(collected_amount_to_date)
    - name: "Total Contingency Percentage"
      expr: SUM(contingency_percentage)
    - name: "Average Contingency Percentage"
      expr: AVG(contingency_percentage)
    - name: "Total Disbursement Cap Amount"
      expr: SUM(disbursement_cap_amount)
    - name: "Average Disbursement Cap Amount"
      expr: AVG(disbursement_cap_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Estimated Hours"
      expr: SUM(estimated_hours)
    - name: "Average Estimated Hours"
      expr: AVG(estimated_hours)
    - name: "Total Invoiced Amount To Date"
      expr: SUM(invoiced_amount_to_date)
    - name: "Average Invoiced Amount To Date"
      expr: AVG(invoiced_amount_to_date)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_agreement_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Type business metrics"
  source: "`legal_ecm`.`contract`.`agreement_type`"
  dimensions:
    - name: "Agreement Type Category"
      expr: agreement_type_category
    - name: "Aml Kyc Required"
      expr: aml_kyc_required
    - name: "Approval Workflow Required"
      expr: approval_workflow_required
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Conflict Check Required"
      expr: conflict_check_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Dispute Resolution"
      expr: default_dispute_resolution
    - name: "Default Governing Law"
      expr: default_governing_law
    - name: "Default Notice Period Days"
      expr: default_notice_period_days
    - name: "Default Term Months"
      expr: default_term_months
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Electronic Signature Allowed"
      expr: electronic_signature_allowed
    - name: "Frand Applicable"
      expr: frand_applicable
    - name: "Gdpr Applicable"
      expr: gdpr_applicable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Type"
      expr: COUNT(DISTINCT agreement_type_id)
    - name: "Total Financial Threshold Usd"
      expr: SUM(financial_threshold_usd)
    - name: "Average Financial Threshold Usd"
      expr: AVG(financial_threshold_usd)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_agreement_type_clause_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Type Clause Policy business metrics"
  source: "`legal_ecm`.`contract`.`agreement_type_clause_policy`"
  dimensions:
    - name: "Agreement Type Clause Policy Status"
      expr: agreement_type_clause_policy_status
    - name: "Approval Authority Required"
      expr: approval_authority_required
    - name: "Created Date"
      expr: created_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Default Flag"
      expr: is_default_flag
    - name: "Is Mandatory Flag"
      expr: is_mandatory_flag
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Negotiation Flexibility Level"
      expr: negotiation_flexibility_level
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Policy Rationale"
      expr: policy_rationale
    - name: "Usage Tier"
      expr: usage_tier
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Type Clause Policy"
      expr: COUNT(DISTINCT agreement_type_clause_policy_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment business metrics"
  source: "`legal_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Type"
      expr: amendment_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Clauses Modified"
      expr: clauses_modified
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Counterparty Name"
      expr: counterparty_name
    - name: "Counterparty Signatory Name"
      expr: counterparty_signatory_name
    - name: "Counterparty Signatory Title"
      expr: counterparty_signatory_title
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Execution Status"
      expr: execution_status
    - name: "Financial Impact Currency"
      expr: financial_impact_currency
    - name: "Firm Signatory Name"
      expr: firm_signatory_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Amendment"
      expr: COUNT(DISTINCT amendment_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
    - name: "Total To Agreement"
      expr: SUM(to_agreement)
    - name: "Average To Agreement"
      expr: AVG(to_agreement)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_clause_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clause Deviation business metrics"
  source: "`legal_ecm`.`contract`.`clause_deviation`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved Position"
      expr: approved_position
    - name: "Approving Partner Name"
      expr: approving_partner_name
    - name: "Clause Section Reference"
      expr: clause_section_reference
    - name: "Clause Type Code"
      expr: clause_type_code
    - name: "Clause Type Name"
      expr: clause_type_name
    - name: "Counterparty Name"
      expr: counterparty_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deviation Category"
      expr: deviation_category
    - name: "Deviation Rationale"
      expr: deviation_rationale
    - name: "Deviation Summary"
      expr: deviation_summary
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "External Counsel Involved Flag"
      expr: external_counsel_involved_flag
    - name: "External Counsel Name"
      expr: external_counsel_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Clause Deviation"
      expr: COUNT(DISTINCT clause_deviation_id)
    - name: "Total Deviation In Agreement"
      expr: SUM(deviation_in_agreement)
    - name: "Average Deviation In Agreement"
      expr: AVG(deviation_in_agreement)
    - name: "Total Deviation To Agreement"
      expr: SUM(deviation_to_agreement)
    - name: "Average Deviation To Agreement"
      expr: AVG(deviation_to_agreement)
    - name: "Total Indemnity Exposure Amount"
      expr: SUM(indemnity_exposure_amount)
    - name: "Average Indemnity Exposure Amount"
      expr: AVG(indemnity_exposure_amount)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_clause_library`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clause Library business metrics"
  source: "`legal_ecm`.`contract`.`clause_library`"
  dimensions:
    - name: "Aml Kyc Required Flag"
      expr: aml_kyc_required_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved Text"
      expr: approved_text
    - name: "Clause Category"
      expr: clause_category
    - name: "Clause Library Description"
      expr: clause_library_description
    - name: "Clause Library Status"
      expr: clause_library_status
    - name: "Clause Type"
      expr: clause_type
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Source Reference"
      expr: external_source_reference
    - name: "Fallback Text"
      expr: fallback_text
    - name: "Frand Applicable Flag"
      expr: frand_applicable_flag
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Clause Library"
      expr: COUNT(DISTINCT clause_library_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Agreement business metrics"
  source: "`legal_ecm`.`contract`.`contract_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Aml Kyc Verified Flag"
      expr: aml_kyc_verified_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Confidentiality Classification"
      expr: confidentiality_classification
    - name: "Conflict Check Cleared Flag"
      expr: conflict_check_cleared_flag
    - name: "Counterparty Name"
      expr: counterparty_name
    - name: "Counterparty Type"
      expr: counterparty_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Document Storage Path"
      expr: document_storage_path
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Agreement"
      expr: COUNT(DISTINCT contract_agreement_id)
    - name: "Total Contract Value"
      expr: SUM(contract_value)
    - name: "Average Contract Value"
      expr: AVG(contract_value)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_contract_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Party business metrics"
  source: "`legal_ecm`.`contract`.`contract_party`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Authorized Signatory Name"
      expr: authorized_signatory_name
    - name: "City"
      expr: city
    - name: "Confidentiality Obligation Flag"
      expr: confidentiality_obligation_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Email"
      expr: email
    - name: "Execution Date"
      expr: execution_date
    - name: "Execution Method"
      expr: execution_method
    - name: "Indemnity Obligation Flag"
      expr: indemnity_obligation_flag
    - name: "Is Client"
      expr: is_client
    - name: "Is Firm Entity"
      expr: is_firm_entity
    - name: "Is Opposing Counsel"
      expr: is_opposing_counsel
    - name: "Is Vendor"
      expr: is_vendor
    - name: "Kyc Aml Clearance Date"
      expr: kyc_aml_clearance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Party"
      expr: COUNT(DISTINCT contract_party_id)
    - name: "Total Liability Cap Amount"
      expr: SUM(liability_cap_amount)
    - name: "Average Liability Cap Amount"
      expr: AVG(liability_cap_amount)
    - name: "Total Party On Agreement"
      expr: SUM(party_on_agreement)
    - name: "Average Party On Agreement"
      expr: AVG(party_on_agreement)
    - name: "Total Party To Agreement"
      expr: SUM(party_to_agreement)
    - name: "Average Party To Agreement"
      expr: AVG(party_to_agreement)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_execution_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution Record business metrics"
  source: "`legal_ecm`.`contract`.`execution_record`"
  dimensions:
    - name: "Audit Trail Reference"
      expr: audit_trail_reference
    - name: "Binding Effective Date"
      expr: binding_effective_date
    - name: "Board Resolution Reference"
      expr: board_resolution_reference
    - name: "Counterparty Execution Date"
      expr: counterparty_execution_date
    - name: "Counterparty Signatory Name"
      expr: counterparty_signatory_name
    - name: "Counterparty Signatory Title"
      expr: counterparty_signatory_title
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Electronic Signature Certificate Reference"
      expr: electronic_signature_certificate_reference
    - name: "Electronic Signature Platform"
      expr: electronic_signature_platform
    - name: "Electronic Signature Transaction Reference"
      expr: electronic_signature_transaction_reference
    - name: "Executed Document Version"
      expr: executed_document_version
    - name: "Executing Party Name"
      expr: executing_party_name
    - name: "Execution Date"
      expr: execution_date
    - name: "Execution Location"
      expr: execution_location
    - name: "Execution Method"
      expr: execution_method
    - name: "Execution Notes"
      expr: execution_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Execution Record"
      expr: COUNT(DISTINCT execution_record_id)
    - name: "Total Execution Of Agreement"
      expr: SUM(execution_of_agreement)
    - name: "Average Execution Of Agreement"
      expr: AVG(execution_of_agreement)
    - name: "Total Execution To Agreement"
      expr: SUM(execution_to_agreement)
    - name: "Average Execution To Agreement"
      expr: AVG(execution_to_agreement)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone business metrics"
  source: "`legal_ecm`.`contract`.`milestone`"
  dimensions:
    - name: "Actual Date"
      expr: actual_date
    - name: "Alert Lead Time Days"
      expr: alert_lead_time_days
    - name: "Completion Notes"
      expr: completion_notes
    - name: "Contractual Clause Reference"
      expr: contractual_clause_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "External System Reference"
      expr: external_system_reference
    - name: "Is Active"
      expr: is_active
    - name: "Is Critical Path Flag"
      expr: is_critical_path_flag
    - name: "Is Regulatory Milestone Flag"
      expr: is_regulatory_milestone_flag
    - name: "Milestone Description"
      expr: milestone_description
    - name: "Milestone Name"
      expr: milestone_name
    - name: "Milestone Status"
      expr: milestone_status
    - name: "Milestone Type"
      expr: milestone_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Milestone"
      expr: COUNT(DISTINCT milestone_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_negotiation_round`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Negotiation Round business metrics"
  source: "`legal_ecm`.`contract`.`negotiation_round`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Agreed Issues Count"
      expr: agreed_issues_count
    - name: "Client Approval Date"
      expr: client_approval_date
    - name: "Client Approval Received Flag"
      expr: client_approval_received_flag
    - name: "Client Approval Required Flag"
      expr: client_approval_required_flag
    - name: "Communication Method"
      expr: communication_method
    - name: "Counterparty Negotiator Email"
      expr: counterparty_negotiator_email
    - name: "Counterparty Negotiator Name"
      expr: counterparty_negotiator_name
    - name: "Counterparty Organization Name"
      expr: counterparty_organization_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Escalated Issues Count"
      expr: escalated_issues_count
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Escalation Required Flag"
      expr: escalation_required_flag
    - name: "External System Reference"
      expr: external_system_reference
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Negotiation Round"
      expr: COUNT(DISTINCT negotiation_round_id)
    - name: "Total Cycle Time Days"
      expr: SUM(cycle_time_days)
    - name: "Average Cycle Time Days"
      expr: AVG(cycle_time_days)
    - name: "Total Internal Review Duration Hours"
      expr: SUM(internal_review_duration_hours)
    - name: "Average Internal Review Duration Hours"
      expr: AVG(internal_review_duration_hours)
    - name: "Total Negotiation For Agreement"
      expr: SUM(negotiation_for_agreement)
    - name: "Average Negotiation For Agreement"
      expr: AVG(negotiation_for_agreement)
    - name: "Total Negotiation To Agreement"
      expr: SUM(negotiation_to_agreement)
    - name: "Average Negotiation To Agreement"
      expr: AVG(negotiation_to_agreement)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation business metrics"
  source: "`legal_ecm`.`contract`.`obligation`"
  dimensions:
    - name: "Beneficiary Party Name"
      expr: beneficiary_party_name
    - name: "Breach Consequence"
      expr: breach_consequence
    - name: "Breach Notice Required"
      expr: breach_notice_required
    - name: "Clause Reference"
      expr: clause_reference
    - name: "Condition Precedent Flag"
      expr: condition_precedent_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cure Period Days"
      expr: cure_period_days
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Reference"
      expr: document_reference
    - name: "Due Date"
      expr: due_date
    - name: "Escalation Threshold Days"
      expr: escalation_threshold_days
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Obligation"
      expr: COUNT(DISTINCT obligation_id)
    - name: "Total From Agreement"
      expr: SUM(from_agreement)
    - name: "Average From Agreement"
      expr: AVG(from_agreement)
    - name: "Total Fulfillment Percentage"
      expr: SUM(fulfillment_percentage)
    - name: "Average Fulfillment Percentage"
      expr: AVG(fulfillment_percentage)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
    - name: "Total To Agreement"
      expr: SUM(to_agreement)
    - name: "Average To Agreement"
      expr: AVG(to_agreement)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_obligation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation Event business metrics"
  source: "`legal_ecm`.`contract`.`obligation_event`"
  dimensions:
    - name: "Actor Type"
      expr: actor_type
    - name: "Breach Notice Date"
      expr: breach_notice_date
    - name: "Breach Severity"
      expr: breach_severity
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cure Deadline"
      expr: cure_deadline
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Event Description"
      expr: event_description
    - name: "Event Status"
      expr: event_status
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Financial Impact Currency"
      expr: financial_impact_currency
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Obligation Event"
      expr: COUNT(DISTINCT obligation_event_id)
    - name: "Total Completion Percentage"
      expr: SUM(completion_percentage)
    - name: "Average Completion Percentage"
      expr: AVG(completion_percentage)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewal business metrics"
  source: "`legal_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Client Approval Received Date"
      expr: client_approval_received_date
    - name: "Client Approval Required"
      expr: client_approval_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision"
      expr: decision
    - name: "Decision Date"
      expr: decision_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fee Adjustment Reason"
      expr: fee_adjustment_reason
    - name: "Fee Arrangement Type"
      expr: fee_arrangement_type
    - name: "Fee Currency"
      expr: fee_currency
    - name: "Initiated By"
      expr: initiated_by
    - name: "Notes"
      expr: notes
    - name: "Notice Period Days"
      expr: notice_period_days
    - name: "Notice To Cancel Deadline"
      expr: notice_to_cancel_deadline
    - name: "Notification Sent Date"
      expr: notification_sent_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Renewal"
      expr: COUNT(DISTINCT renewal_id)
    - name: "Total Fee Adjustment Percentage"
      expr: SUM(fee_adjustment_percentage)
    - name: "Average Fee Adjustment Percentage"
      expr: AVG(fee_adjustment_percentage)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Of Agreement"
      expr: SUM(of_agreement)
    - name: "Average Of Agreement"
      expr: AVG(of_agreement)
    - name: "Total To Agreement"
      expr: SUM(to_agreement)
    - name: "Average To Agreement"
      expr: AVG(to_agreement)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Template business metrics"
  source: "`legal_ecm`.`contract`.`template`"
  dimensions:
    - name: "Access Control Level"
      expr: access_control_level
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Client Facing Flag"
      expr: client_facing_flag
    - name: "Compliance Tags"
      expr: compliance_tags
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dms Document Reference"
      expr: dms_document_reference
    - name: "Dms Folder Path"
      expr: dms_folder_path
    - name: "Document Format"
      expr: document_format
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Industry Sector"
      expr: industry_sector
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Keywords"
      expr: keywords
    - name: "Language Locale"
      expr: language_locale
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Template"
      expr: COUNT(DISTINCT template_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_template_clause`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Template Clause business metrics"
  source: "`legal_ecm`.`contract`.`template_clause`"
  dimensions:
    - name: "Approved By Attorney"
      expr: approved_by_attorney
    - name: "Clause Library References"
      expr: clause_library_references
    - name: "Clause Sequence Order"
      expr: clause_sequence_order
    - name: "Customization Notes"
      expr: customization_notes
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inclusion Date"
      expr: inclusion_date
    - name: "Is Mandatory Flag"
      expr: is_mandatory_flag
    - name: "Is Optional Flag"
      expr: is_optional_flag
    - name: "Jurisdiction Specific Flag"
      expr: jurisdiction_specific_flag
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Usage Tier Override"
      expr: usage_tier_override
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Template Clause"
      expr: COUNT(DISTINCT template_clause_id)
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`contract_termination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Termination business metrics"
  source: "`legal_ecm`.`contract`.`termination`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Contractual Clause Reference"
      expr: contractual_clause_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Effective Termination Date"
      expr: effective_termination_date
    - name: "External System Reference"
      expr: external_system_reference
    - name: "Grounds For Termination"
      expr: grounds_for_termination
    - name: "Is Active"
      expr: is_active
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Notice Date"
      expr: notice_date
    - name: "Notice Period Days"
      expr: notice_period_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Termination"
      expr: COUNT(DISTINCT termination_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
    - name: "Total Of Agreement"
      expr: SUM(of_agreement)
    - name: "Average Of Agreement"
      expr: AVG(of_agreement)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total To Agreement"
      expr: SUM(to_agreement)
    - name: "Average To Agreement"
      expr: AVG(to_agreement)
$$;