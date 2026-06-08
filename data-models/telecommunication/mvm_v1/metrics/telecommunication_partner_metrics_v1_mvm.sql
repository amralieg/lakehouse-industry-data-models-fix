-- Metric views for domain: partner | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:31:24

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement business metrics"
  source: "`telecommunication_ecm`.`partner`.`agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Audit Frequency"
      expr: audit_frequency
    - name: "Audit Rights Flag"
      expr: audit_rights_flag
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Confidentiality Period Years"
      expr: confidentiality_period_years
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Protection Addendum Flag"
      expr: data_protection_addendum_flag
    - name: "Data Sharing Permitted Flag"
      expr: data_sharing_permitted_flag
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Document Repository Url"
      expr: document_repository_url
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement"
      expr: COUNT(DISTINCT agreement_id)
    - name: "Total Fixed Fee Amount"
      expr: SUM(fixed_fee_amount)
    - name: "Average Fixed Fee Amount"
      expr: AVG(fixed_fee_amount)
    - name: "Total Insurance Requirement Amount"
      expr: SUM(insurance_requirement_amount)
    - name: "Average Insurance Requirement Amount"
      expr: AVG(insurance_requirement_amount)
    - name: "Total Minimum Commitment Amount"
      expr: SUM(minimum_commitment_amount)
    - name: "Average Minimum Commitment Amount"
      expr: AVG(minimum_commitment_amount)
    - name: "Total Penalty Cap Amount"
      expr: SUM(penalty_cap_amount)
    - name: "Average Penalty Cap Amount"
      expr: AVG(penalty_cap_amount)
    - name: "Total Performance Bond Amount"
      expr: SUM(performance_bond_amount)
    - name: "Average Performance Bond Amount"
      expr: AVG(performance_bond_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
    - name: "Total Termination Penalty Amount"
      expr: SUM(termination_penalty_amount)
    - name: "Average Termination Penalty Amount"
      expr: AVG(termination_penalty_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_dealer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer business metrics"
  source: "`telecommunication_ecm`.`partner`.`dealer`"
  dimensions:
    - name: "Activation Credential Code"
      expr: activation_credential_code
    - name: "Authorized Product Portfolio"
      expr: authorized_product_portfolio
    - name: "Authorized Territory"
      expr: authorized_territory
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "Business Address Line1"
      expr: business_address_line1
    - name: "Business Address Line2"
      expr: business_address_line2
    - name: "Business City"
      expr: business_city
    - name: "Business Country Code"
      expr: business_country_code
    - name: "Business Postal Code"
      expr: business_postal_code
    - name: "Business State Province"
      expr: business_state_province
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Channel Type"
      expr: channel_type
    - name: "Compliance Certification Status"
      expr: compliance_certification_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dealer Code"
      expr: dealer_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dealer"
      expr: COUNT(DISTINCT dealer_id)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_mvno_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mvno Profile business metrics"
  source: "`telecommunication_ecm`.`partner`.`mvno_profile`"
  dimensions:
    - name: "Apn Configuration"
      expr: apn_configuration
    - name: "Billing Arrangement Type"
      expr: billing_arrangement_type
    - name: "Billing Contact Email"
      expr: billing_contact_email
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Subscriber Count"
      expr: current_subscriber_count
    - name: "Esim Support Enabled"
      expr: esim_support_enabled
    - name: "Five G Access Enabled"
      expr: five_g_access_enabled
    - name: "Hlr Provisioning Enabled"
      expr: hlr_provisioning_enabled
    - name: "Hss Provisioning Enabled"
      expr: hss_provisioning_enabled
    - name: "Imsi Range End"
      expr: imsi_range_end
    - name: "Imsi Range Start"
      expr: imsi_range_start
    - name: "International Roaming Enabled"
      expr: international_roaming_enabled
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Mvno Brand Name"
      expr: mvno_brand_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mvno Profile"
      expr: COUNT(DISTINCT mvno_profile_id)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_onboarding_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Onboarding Request business metrics"
  source: "`telecommunication_ecm`.`partner`.`onboarding_request`"
  dimensions:
    - name: "Api Connectivity Validated"
      expr: api_connectivity_validated
    - name: "Application Date"
      expr: application_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Assigned Owner"
      expr: assigned_owner
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Execution Date"
      expr: contract_execution_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Assessment Status"
      expr: credit_assessment_status
    - name: "Credit Score"
      expr: credit_score
    - name: "Documentation Checklist Complete"
      expr: documentation_checklist_complete
    - name: "Go Live Actual Date"
      expr: go_live_actual_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Onboarding Request"
      expr: COUNT(DISTINCT onboarding_request_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner business metrics"
  source: "`telecommunication_ecm`.`partner`.`partner`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Renewal Type"
      expr: contract_renewal_type
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Data Sharing Consent Flag"
      expr: data_sharing_consent_flag
    - name: "Dba Name"
      expr: dba_name
    - name: "Headquarters Address"
      expr: headquarters_address
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Country Code"
      expr: headquarters_country_code
    - name: "Headquarters Postal Code"
      expr: headquarters_postal_code
    - name: "Headquarters State Province"
      expr: headquarters_state_province
    - name: "Industry Classification Code"
      expr: industry_classification_code
    - name: "Last Compliance Review Date"
      expr: last_compliance_review_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner"
      expr: COUNT(DISTINCT partner_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_partner_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Contact business metrics"
  source: "`telecommunication_ecm`.`partner`.`partner_contact`"
  dimensions:
    - name: "Authorization Level"
      expr: authorization_level
    - name: "Billing Notification Enabled"
      expr: billing_notification_enabled
    - name: "Contact Status"
      expr: contact_status
    - name: "Contact Type"
      expr: contact_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department"
      expr: department
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Fax Number"
      expr: fax_number
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
    - name: "Is Escalation Contact"
      expr: is_escalation_contact
    - name: "Is Primary Contact"
      expr: is_primary_contact
    - name: "Job Title"
      expr: job_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Contact"
      expr: COUNT(DISTINCT partner_contact_id)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_partner_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Dispute business metrics"
  source: "`telecommunication_ecm`.`partner`.`partner_dispute`"
  dimensions:
    - name: "Acknowledged Date"
      expr: acknowledged_date
    - name: "Agreed Adjustment Currency Code"
      expr: agreed_adjustment_currency_code
    - name: "Arbitration Body"
      expr: arbitration_body
    - name: "Assigned Department"
      expr: assigned_department
    - name: "Closed Date"
      expr: closed_date
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Direction"
      expr: direction
    - name: "Dispute Category"
      expr: dispute_category
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Number"
      expr: dispute_number
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Disputed Currency Code"
      expr: disputed_currency_code
    - name: "Escalated To Arbitration Flag"
      expr: escalated_to_arbitration_flag
    - name: "Escalation Level"
      expr: escalation_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Dispute"
      expr: COUNT(DISTINCT partner_dispute_id)
    - name: "Total Agreed Adjustment Amount"
      expr: SUM(agreed_adjustment_amount)
    - name: "Average Agreed Adjustment Amount"
      expr: AVG(agreed_adjustment_amount)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_revenue_share_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Share Plan business metrics"
  source: "`telecommunication_ecm`.`partner`.`revenue_share_plan`"
  dimensions:
    - name: "Applicable Product Scope"
      expr: applicable_product_scope
    - name: "Applicable Service Type"
      expr: applicable_service_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Process"
      expr: dispute_resolution_process
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exchange Rate Source"
      expr: exchange_rate_source
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Modified By"
      expr: modified_by
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Share Plan"
      expr: COUNT(DISTINCT revenue_share_plan_id)
    - name: "Total Fixed Rate Amount"
      expr: SUM(fixed_rate_amount)
    - name: "Average Fixed Rate Amount"
      expr: AVG(fixed_rate_amount)
    - name: "Total Maximum Threshold Amount"
      expr: SUM(maximum_threshold_amount)
    - name: "Average Maximum Threshold Amount"
      expr: AVG(maximum_threshold_amount)
    - name: "Total Minimum Threshold Amount"
      expr: SUM(minimum_threshold_amount)
    - name: "Average Minimum Threshold Amount"
      expr: AVG(minimum_threshold_amount)
    - name: "Total Share Percentage"
      expr: SUM(share_percentage)
    - name: "Average Share Percentage"
      expr: AVG(share_percentage)
    - name: "Total Sla Target Accuracy Percentage"
      expr: SUM(sla_target_accuracy_percentage)
    - name: "Average Sla Target Accuracy Percentage"
      expr: AVG(sla_target_accuracy_percentage)
    - name: "Total Withholding Tax Rate"
      expr: SUM(withholding_tax_rate)
    - name: "Average Withholding Tax Rate"
      expr: AVG(withholding_tax_rate)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_roaming_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roaming Agreement business metrics"
  source: "`telecommunication_ecm`.`partner`.`roaming_agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Contract Document Url"
      expr: contract_document_url
    - name: "Coverage Countries"
      expr: coverage_countries
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Period Days"
      expr: dispute_resolution_period_days
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fraud Monitoring Enabled"
      expr: fraud_monitoring_enabled
    - name: "Gsma Aa12 Compliant"
      expr: gsma_aa12_compliant
    - name: "Gsma Aa13 Compliant"
      expr: gsma_aa13_compliant
    - name: "Iot Rate Type"
      expr: iot_rate_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Roaming Agreement"
      expr: COUNT(DISTINCT roaming_agreement_id)
    - name: "Total Data Mb Rate"
      expr: SUM(data_mb_rate)
    - name: "Average Data Mb Rate"
      expr: AVG(data_mb_rate)
    - name: "Total Fraud Threshold Amount"
      expr: SUM(fraud_threshold_amount)
    - name: "Average Fraud Threshold Amount"
      expr: AVG(fraud_threshold_amount)
    - name: "Total Nrtrde Threshold Amount"
      expr: SUM(nrtrde_threshold_amount)
    - name: "Average Nrtrde Threshold Amount"
      expr: AVG(nrtrde_threshold_amount)
    - name: "Total Sla Availability Percent"
      expr: SUM(sla_availability_percent)
    - name: "Average Sla Availability Percent"
      expr: AVG(sla_availability_percent)
    - name: "Total Sla Call Success Rate Percent"
      expr: SUM(sla_call_success_rate_percent)
    - name: "Average Sla Call Success Rate Percent"
      expr: AVG(sla_call_success_rate_percent)
    - name: "Total Sla Data Throughput Mbps"
      expr: SUM(sla_data_throughput_mbps)
    - name: "Average Sla Data Throughput Mbps"
      expr: AVG(sla_data_throughput_mbps)
    - name: "Total Sms Rate"
      expr: SUM(sms_rate)
    - name: "Average Sms Rate"
      expr: AVG(sms_rate)
    - name: "Total Voice Mou Rate"
      expr: SUM(voice_mou_rate)
    - name: "Average Voice Mou Rate"
      expr: AVG(voice_mou_rate)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_settlement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement Line business metrics"
  source: "`telecommunication_ecm`.`partner`.`settlement_line`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cdr Count"
      expr: cdr_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Raised Date"
      expr: dispute_raised_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Line Description"
      expr: line_description
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Originating Network"
      expr: originating_network
    - name: "Product Code"
      expr: product_code
    - name: "Product Name"
      expr: product_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Settlement Line"
      expr: COUNT(DISTINCT settlement_line_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Rate Applied"
      expr: SUM(rate_applied)
    - name: "Average Rate Applied"
      expr: AVG(rate_applied)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Usage Volume"
      expr: SUM(usage_volume)
    - name: "Average Usage Volume"
      expr: AVG(usage_volume)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_settlement_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement Run business metrics"
  source: "`telecommunication_ecm`.`partner`.`settlement_run`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Item Count"
      expr: line_item_count
    - name: "Notes"
      expr: notes
    - name: "Payment Completion Date"
      expr: payment_completion_date
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Instruction Reference"
      expr: payment_instruction_reference
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Run Execution Timestamp"
      expr: run_execution_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Settlement Run"
      expr: COUNT(DISTINCT settlement_run_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Net Payable Amount"
      expr: SUM(net_payable_amount)
    - name: "Average Net Payable Amount"
      expr: AVG(net_payable_amount)
    - name: "Total Reconciliation Variance Amount"
      expr: SUM(reconciliation_variance_amount)
    - name: "Average Reconciliation Variance Amount"
      expr: AVG(reconciliation_variance_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Settlement Amount"
      expr: SUM(total_settlement_amount)
    - name: "Average Total Settlement Amount"
      expr: AVG(total_settlement_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`partner_sla_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sla Definition business metrics"
  source: "`telecommunication_ecm`.`partner`.`sla_definition`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Required Flag"
      expr: compliance_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Formula"
      expr: credit_formula
    - name: "Dispute Resolution Window Days"
      expr: dispute_resolution_window_days
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Escalation Procedure"
      expr: escalation_procedure
    - name: "Exclusion Conditions"
      expr: exclusion_conditions
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Measurement Period"
      expr: measurement_period
    - name: "Metric Description"
      expr: metric_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sla Definition"
      expr: COUNT(DISTINCT sla_definition_id)
    - name: "Total Escalation Threshold"
      expr: SUM(escalation_threshold)
    - name: "Average Escalation Threshold"
      expr: AVG(escalation_threshold)
    - name: "Total Notification Threshold"
      expr: SUM(notification_threshold)
    - name: "Average Notification Threshold"
      expr: AVG(notification_threshold)
    - name: "Total Penalty Cap Amount"
      expr: SUM(penalty_cap_amount)
    - name: "Average Penalty Cap Amount"
      expr: AVG(penalty_cap_amount)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;