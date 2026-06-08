-- Metric views for domain: billing | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:22:48

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing Account business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`billing_account`"
  dimensions:
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Auto Pay Enabled Flag"
      expr: auto_pay_enabled_flag
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Currency Code"
      expr: billing_currency_code
    - name: "Billing Cycle Day"
      expr: billing_cycle_day
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Closed Date"
      expr: closed_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dunning Level"
      expr: dunning_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Billing Account"
      expr: COUNT(DISTINCT billing_account_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Current Balance Amount"
      expr: SUM(current_balance_amount)
    - name: "Average Current Balance Amount"
      expr: AVG(current_balance_amount)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Memo business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`credit_memo`"
  dimensions:
    - name: "Applied Date"
      expr: applied_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Bad Debt Write Off Flag"
      expr: bad_debt_write_off_flag
    - name: "Collection Agency Name"
      expr: collection_agency_name
    - name: "Collection Agency Referral Flag"
      expr: collection_agency_referral_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Memo Number"
      expr: credit_memo_number
    - name: "Credit Memo Status"
      expr: credit_memo_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Issue Date"
      expr: issue_date
    - name: "Makegood Spots Quantity"
      expr: makegood_spots_quantity
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Memo"
      expr: COUNT(DISTINCT credit_memo_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Net Credit Amount"
      expr: SUM(net_credit_amount)
    - name: "Average Net Credit Amount"
      expr: AVG(net_credit_amount)
    - name: "Total Recovery Amount"
      expr: SUM(recovery_amount)
    - name: "Average Recovery Amount"
      expr: AVG(recovery_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`cycle`"
  dimensions:
    - name: "Auto Renew Enabled"
      expr: auto_renew_enabled
    - name: "Billing Period End Day"
      expr: billing_period_end_day
    - name: "Billing Period Start Day"
      expr: billing_period_start_day
    - name: "Billing Run Day Offset"
      expr: billing_run_day_offset
    - name: "Billing Timing"
      expr: billing_timing
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cycle Code"
      expr: cycle_code
    - name: "Cycle Description"
      expr: cycle_description
    - name: "Cycle Name"
      expr: cycle_name
    - name: "Cycle Status"
      expr: cycle_status
    - name: "Cycle Type"
      expr: cycle_type
    - name: "Day"
      expr: day
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cycle"
      expr: COUNT(DISTINCT cycle_id)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "Assigned Resolver Name"
      expr: assigned_resolver_name
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Memo Issued Flag"
      expr: credit_memo_issued_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Disputing Party Name"
      expr: disputing_party_name
    - name: "Disputing Party Type"
      expr: disputing_party_type
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "External Case Number"
      expr: external_case_number
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispute"
      expr: COUNT(DISTINCT dispute_id)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "Billing Period End Date"
      expr: billing_period_end_date
    - name: "Billing Period Start Date"
      expr: billing_period_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Due Date"
      expr: due_date
    - name: "Installment Number"
      expr: installment_number
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Isci Codes"
      expr: isci_codes
    - name: "Mvpd Subscriber Count"
      expr: mvpd_subscriber_count
    - name: "Notes"
      expr: notes
    - name: "Paid Date"
      expr: paid_date
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice"
      expr: COUNT(DISTINCT invoice_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Amount Paid"
      expr: SUM(amount_paid)
    - name: "Average Amount Paid"
      expr: AVG(amount_paid)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount Due"
      expr: SUM(total_amount_due)
    - name: "Average Total Amount Due"
      expr: AVG(total_amount_due)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "Charge Description"
      expr: charge_description
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Code"
      expr: discount_code
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Isci Code"
      expr: isci_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Item Number"
      expr: line_item_number
    - name: "Line Number"
      expr: line_number
    - name: "Makegood Flag"
      expr: makegood_flag
    - name: "Notes"
      expr: notes
    - name: "Revenue Recognition Rule"
      expr: revenue_recognition_rule
    - name: "Service Period End Date"
      expr: service_period_end_date
    - name: "Service Period Start Date"
      expr: service_period_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
    - name: "Total Cpm Rate"
      expr: SUM(cpm_rate)
    - name: "Average Cpm Rate"
      expr: AVG(cpm_rate)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Extended Amount"
      expr: SUM(extended_amount)
    - name: "Average Extended Amount"
      expr: AVG(extended_amount)
    - name: "Total Grp Delivered"
      expr: SUM(grp_delivered)
    - name: "Average Grp Delivered"
      expr: AVG(grp_delivered)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`payment`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Bank Transaction Reference"
      expr: bank_transaction_reference
    - name: "Channel"
      expr: channel
    - name: "Check Number"
      expr: check_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Failure Reason"
      expr: failure_reason
    - name: "Gateway"
      expr: gateway
    - name: "Gateway Transaction Reference"
      expr: gateway_transaction_reference
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Is Autopay"
      expr: is_autopay
    - name: "Is Disputed"
      expr: is_disputed
    - name: "Method Type"
      expr: method_type
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Applied Amount"
      expr: SUM(applied_amount)
    - name: "Average Applied Amount"
      expr: AVG(applied_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Unapplied Amount"
      expr: SUM(unapplied_amount)
    - name: "Average Unapplied Amount"
      expr: AVG(unapplied_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_payment_method`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Method business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`payment_method`"
  dimensions:
    - name: "Bank Account Number Last Four"
      expr: bank_account_number_last_four
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Card Brand"
      expr: card_brand
    - name: "Cardholder Name"
      expr: cardholder_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deactivated Timestamp"
      expr: deactivated_timestamp
    - name: "Deactivation Reason"
      expr: deactivation_reason
    - name: "Expiry Alert Date"
      expr: expiry_alert_date
    - name: "Expiry Month"
      expr: expiry_month
    - name: "Expiry Year"
      expr: expiry_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Method"
      expr: COUNT(DISTINCT payment_method_id)
    - name: "Total Last Transaction Amount"
      expr: SUM(last_transaction_amount)
    - name: "Average Last Transaction Amount"
      expr: AVG(last_transaction_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`refund`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Settlement Date"
      expr: expected_settlement_date
    - name: "Is Chargeback Related"
      expr: is_chargeback_related
    - name: "Is Partial Refund"
      expr: is_partial_refund
    - name: "Notes"
      expr: notes
    - name: "Processing Date"
      expr: processing_date
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Refund Method"
      expr: refund_method
    - name: "Refund Number"
      expr: refund_number
    - name: "Refund Status"
      expr: refund_status
    - name: "Refund Type"
      expr: refund_type
    - name: "Request Date"
      expr: request_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Refund"
      expr: COUNT(DISTINCT refund_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Fee"
      expr: SUM(fee)
    - name: "Average Fee"
      expr: AVG(fee)
    - name: "Total Net Refund Amount"
      expr: SUM(net_refund_amount)
    - name: "Average Net Refund Amount"
      expr: AVG(net_refund_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_revenue_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Recognition Schedule business metrics"
  source: "`media_broadcasting_ecm`.`billing`.`revenue_recognition_schedule`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Business Unit"
      expr: business_unit
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Last Recognition Date"
      expr: last_recognition_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Recognition Date"
      expr: next_recognition_date
    - name: "Notes"
      expr: notes
    - name: "Performance Obligation Description"
      expr: performance_obligation_description
    - name: "Recognition End Date"
      expr: recognition_end_date
    - name: "Recognition Method"
      expr: recognition_method
    - name: "Recognition Period Months"
      expr: recognition_period_months
    - name: "Recognition Start Date"
      expr: recognition_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Recognition Schedule"
      expr: COUNT(DISTINCT revenue_recognition_schedule_id)
    - name: "Total Cumulative Recognized Amount"
      expr: SUM(cumulative_recognized_amount)
    - name: "Average Cumulative Recognized Amount"
      expr: AVG(cumulative_recognized_amount)
    - name: "Total Current Period Recognized Amount"
      expr: SUM(current_period_recognized_amount)
    - name: "Average Current Period Recognized Amount"
      expr: AVG(current_period_recognized_amount)
    - name: "Total Deferred Revenue Balance"
      expr: SUM(deferred_revenue_balance)
    - name: "Average Deferred Revenue Balance"
      expr: AVG(deferred_revenue_balance)
    - name: "Total Monthly Recognized Amount"
      expr: SUM(monthly_recognized_amount)
    - name: "Average Monthly Recognized Amount"
      expr: AVG(monthly_recognized_amount)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
$$;