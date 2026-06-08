-- Metric views for domain: billing | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice KPIs tracking billing performance, revenue recognition, payment efficiency, and dispute exposure across billing cycles and account segments."
  source: "`telecommunication_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., issued, paid, overdue, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., regular, adjustment, credit)"
    - name: "billing_segment"
      expr: billing_segment
      comment: "Customer billing segment for cohort analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the invoice"
    - name: "dunning_status"
      expr: dunning_status
      comment: "Dunning status indicating collection stage"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which invoice was delivered (e.g., email, portal, paper)"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether invoice is under dispute"
    - name: "is_paperless"
      expr: is_paperless
      comment: "Flag indicating paperless billing enrollment"
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating tax exemption status"
    - name: "bill_month"
      expr: DATE_TRUNC('MONTH', bill_date)
      comment: "Month of invoice bill date for time-series analysis"
    - name: "bill_quarter"
      expr: DATE_TRUNC('QUARTER', bill_date)
      comment: "Quarter of invoice bill date for quarterly reporting"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of invoice due date for cash flow forecasting"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Payment terms in days for DSO analysis"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Distinct count of billing accounts invoiced"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total invoice amount due across all invoices"
    - name: "total_current_charges"
      expr: SUM(CAST(current_charges_amount AS DOUBLE))
      comment: "Sum of current period charges"
    - name: "total_previous_balance"
      expr: SUM(CAST(previous_balance_amount AS DOUBLE))
      comment: "Sum of previous balance carried forward"
    - name: "total_adjustments"
      expr: SUM(CAST(adjustments_amount AS DOUBLE))
      comment: "Total adjustments applied to invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed"
    - name: "total_fees"
      expr: SUM(CAST(fees_amount AS DOUBLE))
      comment: "Total fees charged (late fees, paper bill fees, etc.)"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid against invoices"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding balance across all invoices"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount per invoice"
    - name: "avg_outstanding_amount"
      expr: AVG(CAST(outstanding_amount AS DOUBLE))
      comment: "Average outstanding balance per invoice"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices currently disputed"
    - name: "paperless_invoice_count"
      expr: SUM(CASE WHEN is_paperless = TRUE THEN 1 ELSE 0 END)
      comment: "Count of paperless invoices for sustainability tracking"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment performance KPIs tracking collection efficiency, payment channel effectiveness, processing costs, and cash application metrics."
  source: "`telecommunication_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., applied, pending, failed, reversed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., credit card, bank transfer, cash)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., regular, advance, partial)"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received"
    - name: "gateway"
      expr: gateway
      comment: "Payment gateway used for processing"
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating automatic payment enrollment"
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Flag indicating partial payment"
    - name: "application_status"
      expr: application_status
      comment: "Status of payment application to invoices"
    - name: "card_type"
      expr: card_type
      comment: "Type of card used (if card payment)"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for time-series analysis"
    - name: "payment_quarter"
      expr: DATE_TRUNC('QUARTER', payment_date)
      comment: "Quarter of payment for quarterly cash flow reporting"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month when payment was received"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "unique_billing_accounts_paid"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Distinct count of billing accounts making payments"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount successfully applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount not yet applied to invoices (cash application backlog)"
    - name: "total_processing_fees"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total processing fees incurred across all payments"
    - name: "total_net_received"
      expr: SUM(CAST(net_received_amount AS DOUBLE))
      comment: "Total net amount received after fees"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "avg_processing_fee"
      expr: AVG(CAST(processing_fee_amount AS DOUBLE))
      comment: "Average processing fee per payment"
    - name: "auto_pay_count"
      expr: SUM(CASE WHEN is_auto_pay = TRUE THEN 1 ELSE 0 END)
      comment: "Count of automatic payments for auto-pay adoption tracking"
    - name: "partial_payment_count"
      expr: SUM(CASE WHEN is_partial_payment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of partial payments indicating financial stress"
    - name: "failed_payment_count"
      expr: SUM(CASE WHEN payment_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed payment attempts for collection risk assessment"
    - name: "reversed_payment_count"
      expr: SUM(CASE WHEN payment_status = 'reversed' THEN 1 ELSE 0 END)
      comment: "Count of reversed payments for chargeback tracking"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular charge-level KPIs tracking revenue composition, discount effectiveness, proration accuracy, and MRR contribution across product offerings and service instances."
  source: "`telecommunication_ecm`.`billing`.`billing_charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the billing charge"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (e.g., recurring, one-time, usage, setup)"
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge for revenue classification"
    - name: "charge_source"
      expr: charge_source
      comment: "Source system or process that generated the charge"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for charges requiring authorization"
    - name: "is_prorated"
      expr: is_prorated
      comment: "Flag indicating whether charge was prorated"
    - name: "tax_class"
      expr: tax_class
      comment: "Tax classification of the charge"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for charge (especially for adjustments/waivers)"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level if charge is overdue"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of charge effective date for time-series revenue analysis"
    - name: "charge_quarter"
      expr: DATE_TRUNC('QUARTER', effective_date)
      comment: "Quarter of charge effective date for quarterly revenue reporting"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start)
      comment: "Month of charge period start"
  measures:
    - name: "charge_count"
      expr: COUNT(1)
      comment: "Total number of billing charges"
    - name: "unique_subscribers_charged"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with charges"
    - name: "unique_subscriptions_charged"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Distinct count of subscriptions generating charges"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross charge amount before discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to charges"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net charge amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on charges"
    - name: "total_mrr_contribution"
      expr: SUM(CAST(mrr_contribution AS DOUBLE))
      comment: "Total monthly recurring revenue contribution from charges"
    - name: "avg_gross_charge"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross charge amount per charge line"
    - name: "avg_net_charge"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net charge amount per charge line"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per charge"
    - name: "avg_proration_factor"
      expr: AVG(CAST(proration_factor AS DOUBLE))
      comment: "Average proration factor for prorated charges"
    - name: "prorated_charge_count"
      expr: SUM(CASE WHEN is_prorated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of prorated charges for mid-cycle change tracking"
    - name: "waived_charge_count"
      expr: SUM(CASE WHEN waiver_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of waived charges for revenue leakage analysis"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_rated_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage rating KPIs tracking event processing performance, roaming revenue, inter-operator charges, and rating accuracy across network technologies and service types."
  source: "`telecommunication_ecm`.`billing`.`rated_event`"
  dimensions:
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the rating process (e.g., rated, failed, pending)"
    - name: "event_type"
      expr: event_type
      comment: "Type of usage event (e.g., voice, SMS, data)"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge applied to the event"
    - name: "event_direction"
      expr: event_direction
      comment: "Direction of event (e.g., inbound, outbound)"
    - name: "is_roaming"
      expr: is_roaming
      comment: "Flag indicating roaming event"
    - name: "network_technology"
      expr: network_technology
      comment: "Network technology used (e.g., 4G, 5G)"
    - name: "rating_mode"
      expr: rating_mode
      comment: "Rating mode (e.g., real-time, batch)"
    - name: "rating_tier"
      expr: rating_tier
      comment: "Rating tier applied to the event"
    - name: "rating_engine"
      expr: rating_engine
      comment: "Rating engine that processed the event"
    - name: "roaming_country_code"
      expr: roaming_country_code
      comment: "Country code for roaming events"
    - name: "bundle_consumed"
      expr: bundle_consumed
      comment: "Flag indicating whether event consumed bundle allowance"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month of event start for time-series usage analysis"
    - name: "event_quarter"
      expr: DATE_TRUNC('QUARTER', event_start_timestamp)
      comment: "Quarter of event start for quarterly usage reporting"
    - name: "rating_month"
      expr: DATE_TRUNC('MONTH', rating_timestamp)
      comment: "Month when event was rated"
  measures:
    - name: "rated_event_count"
      expr: COUNT(1)
      comment: "Total number of rated usage events"
    - name: "unique_subscribers_with_usage"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers with rated usage"
    - name: "unique_subscriptions_with_usage"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Distinct count of subscriptions with rated usage"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount from rated events"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to rated events"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on rated events"
    - name: "total_inter_operator_charge"
      expr: SUM(CAST(inter_operator_charge AS DOUBLE))
      comment: "Total inter-operator charges for interconnect settlement"
    - name: "total_rated_duration_seconds"
      expr: SUM(CAST(rated_duration_seconds AS DOUBLE))
      comment: "Total rated duration in seconds for voice events"
    - name: "total_rated_volume_bytes"
      expr: SUM(CAST(rated_volume_bytes AS DOUBLE))
      comment: "Total rated data volume in bytes"
    - name: "total_rated_unit_count"
      expr: SUM(CAST(rated_unit_count AS DOUBLE))
      comment: "Total rated unit count (e.g., SMS count)"
    - name: "avg_charge_per_event"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per rated event"
    - name: "avg_rated_duration_seconds"
      expr: AVG(CAST(rated_duration_seconds AS DOUBLE))
      comment: "Average rated duration per voice event"
    - name: "roaming_event_count"
      expr: SUM(CASE WHEN is_roaming = TRUE THEN 1 ELSE 0 END)
      comment: "Count of roaming events for roaming revenue tracking"
    - name: "bundle_consumed_event_count"
      expr: SUM(CASE WHEN bundle_consumed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events consuming bundle allowance"
    - name: "failed_rating_count"
      expr: SUM(CASE WHEN rating_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed rating attempts for rating engine health monitoring"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account health KPIs tracking account balance, credit exposure, payment behavior, MRR, and dunning status for credit risk and collections management."
  source: "`telecommunication_ecm`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account"
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., individual, corporate)"
    - name: "prepaid_postpaid_indicator"
      expr: prepaid_postpaid_indicator
      comment: "Indicator of prepaid vs postpaid billing model"
    - name: "credit_class_code"
      expr: credit_class_code
      comment: "Credit class for risk segmentation"
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current dunning status for collections tracking"
    - name: "payment_method"
      expr: payment_method
      comment: "Default payment method for the account"
    - name: "auto_pay_enabled"
      expr: auto_pay_enabled
      comment: "Flag indicating auto-pay enrollment"
    - name: "consolidated_billing"
      expr: consolidated_billing
      comment: "Flag indicating consolidated billing across multiple accounts"
    - name: "dispute_in_progress"
      expr: dispute_in_progress
      comment: "Flag indicating active dispute"
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating tax exemption status"
    - name: "arpu_segment_code"
      expr: arpu_segment_code
      comment: "ARPU segment for revenue cohort analysis"
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle code for cycle-based analysis"
    - name: "bill_delivery_method"
      expr: bill_delivery_method
      comment: "Method of bill delivery (e.g., email, paper, portal)"
  measures:
    - name: "billing_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all accounts"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount for collections prioritization"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to accounts"
    - name: "total_mrr"
      expr: SUM(CAST(mrr_amount AS DOUBLE))
      comment: "Total monthly recurring revenue across all accounts"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount held"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of last payment amounts"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account"
    - name: "avg_overdue_amount"
      expr: AVG(CAST(overdue_amount AS DOUBLE))
      comment: "Average overdue amount per account"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "avg_mrr"
      expr: AVG(CAST(mrr_amount AS DOUBLE))
      comment: "Average monthly recurring revenue per account"
    - name: "auto_pay_account_count"
      expr: SUM(CASE WHEN auto_pay_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with auto-pay enabled for payment automation tracking"
    - name: "disputed_account_count"
      expr: SUM(CASE WHEN dispute_in_progress = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with disputes in progress"
    - name: "overdue_account_count"
      expr: SUM(CASE WHEN overdue_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of accounts with overdue balances for collections workload sizing"
    - name: "tax_exempt_account_count"
      expr: SUM(CASE WHEN tax_exempt = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tax-exempt accounts for compliance reporting"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment KPIs tracking revenue leakage, credit issuance, adjustment approval patterns, and root-cause analysis for billing quality improvement."
  source: "`telecommunication_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., credit, debit, waiver)"
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Category of adjustment for root-cause classification"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment"
    - name: "document_type"
      expr: document_type
      comment: "Type of document generated (e.g., credit note, debit note)"
    - name: "approval_threshold_breached"
      expr: approval_threshold_breached
      comment: "Flag indicating whether adjustment breached approval threshold"
    - name: "requires_manager_approval"
      expr: requires_manager_approval
      comment: "Flag indicating manager approval requirement"
    - name: "is_customer_visible"
      expr: is_customer_visible
      comment: "Flag indicating whether adjustment is visible to customer"
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating tax exemption on adjustment"
    - name: "revenue_recognition_flag"
      expr: revenue_recognition_flag
      comment: "Flag indicating revenue recognition impact"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', applied_date)
      comment: "Month of adjustment application for time-series leakage analysis"
    - name: "adjustment_quarter"
      expr: DATE_TRUNC('QUARTER', applied_date)
      comment: "Quarter of adjustment application for quarterly leakage reporting"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of adjustment effective date"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of billing adjustments"
    - name: "unique_subscribers_adjusted"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers receiving adjustments"
    - name: "unique_billing_accounts_adjusted"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Distinct count of billing accounts with adjustments"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross adjustment amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net adjustment amount after tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on adjustments"
    - name: "total_tax_reversal_amount"
      expr: SUM(CAST(tax_reversal_amount AS DOUBLE))
      comment: "Total tax reversal amount"
    - name: "total_credited_onetime_amount"
      expr: SUM(CAST(credited_onetime_amount AS DOUBLE))
      comment: "Total one-time charges credited"
    - name: "total_credited_recurring_amount"
      expr: SUM(CAST(credited_recurring_amount AS DOUBLE))
      comment: "Total recurring charges credited (MRR impact)"
    - name: "total_credited_usage_amount"
      expr: SUM(CAST(credited_usage_amount AS DOUBLE))
      comment: "Total usage charges credited"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average adjustment amount per adjustment"
    - name: "approval_threshold_breach_count"
      expr: SUM(CASE WHEN approval_threshold_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments breaching approval threshold for policy review"
    - name: "manager_approval_required_count"
      expr: SUM(CASE WHEN requires_manager_approval = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments requiring manager approval"
    - name: "customer_visible_adjustment_count"
      expr: SUM(CASE WHEN is_customer_visible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of customer-visible adjustments for customer experience impact"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute KPIs tracking dispute volume, resolution effectiveness, SLA compliance, escalation patterns, and regulatory complaint exposure."
  source: "`telecommunication_ecm`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., billing error, service quality, fraud)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of dispute resolution (e.g., approved, denied, partial)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the dispute"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether dispute was escalated"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation (e.g., tier 1, tier 2, executive)"
    - name: "sla_breached"
      expr: sla_breached
      comment: "Flag indicating SLA breach on dispute resolution"
    - name: "regulatory_complaint_flag"
      expr: regulatory_complaint_flag
      comment: "Flag indicating regulatory complaint filed"
    - name: "repeat_dispute_flag"
      expr: repeat_dispute_flag
      comment: "Flag indicating repeat dispute from same customer"
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for dispute pattern analysis"
    - name: "service_type"
      expr: service_type
      comment: "Service type related to the dispute"
    - name: "raised_month"
      expr: DATE_TRUNC('MONTH', raised_date)
      comment: "Month when dispute was raised for time-series dispute volume analysis"
    - name: "raised_quarter"
      expr: DATE_TRUNC('QUARTER', raised_date)
      comment: "Quarter when dispute was raised"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when dispute was resolved"
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes"
    - name: "unique_subscribers_disputing"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers raising disputes"
    - name: "unique_billing_accounts_disputing"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Distinct count of customer accounts with disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "total_approved_credit_amount"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Total credit amount approved through dispute resolution"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute"
    - name: "avg_approved_credit_amount"
      expr: AVG(CAST(approved_credit_amount AS DOUBLE))
      comment: "Average approved credit per dispute"
    - name: "escalated_dispute_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated disputes for escalation rate tracking"
    - name: "sla_breached_dispute_count"
      expr: SUM(CASE WHEN sla_breached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputes with SLA breach for compliance monitoring"
    - name: "regulatory_complaint_count"
      expr: SUM(CASE WHEN regulatory_complaint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputes escalated to regulatory complaint for regulatory risk tracking"
    - name: "repeat_dispute_count"
      expr: SUM(CASE WHEN repeat_dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat disputes indicating systemic billing issues"
    - name: "resolved_dispute_count"
      expr: SUM(CASE WHEN dispute_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Count of resolved disputes"
    - name: "open_dispute_count"
      expr: SUM(CASE WHEN dispute_status IN ('open', 'pending', 'investigating') THEN 1 ELSE 0 END)
      comment: "Count of open disputes for workload sizing"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_prepaid_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prepaid balance KPIs tracking balance utilization, recharge behavior, auto-recharge adoption, bucket consumption, and prepaid churn risk indicators."
  source: "`telecommunication_ecm`.`billing`.`prepaid_balance`"
  dimensions:
    - name: "balance_status"
      expr: balance_status
      comment: "Current status of the prepaid balance (e.g., active, suspended, expired)"
    - name: "auto_recharge_enabled"
      expr: auto_recharge_enabled
      comment: "Flag indicating auto-recharge enrollment"
    - name: "low_balance_notification_enabled"
      expr: low_balance_notification_enabled
      comment: "Flag indicating low balance notification enrollment"
    - name: "balance_freeze_reason"
      expr: balance_freeze_reason
      comment: "Reason for balance freeze (if applicable)"
    - name: "last_recharge_channel"
      expr: last_recharge_channel
      comment: "Channel used for last recharge"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of balance activation for cohort analysis"
    - name: "activation_quarter"
      expr: DATE_TRUNC('QUARTER', activation_date)
      comment: "Quarter of balance activation"
    - name: "last_recharge_month"
      expr: DATE_TRUNC('MONTH', last_recharge_date)
      comment: "Month of last recharge for recharge recency analysis"
    - name: "main_balance_expiry_month"
      expr: DATE_TRUNC('MONTH', main_balance_expiry_date)
      comment: "Month when main balance expires for churn risk forecasting"
  measures:
    - name: "prepaid_balance_count"
      expr: COUNT(1)
      comment: "Total number of prepaid balance records"
    - name: "unique_subscribers_prepaid"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of prepaid subscribers"
    - name: "unique_subscriptions_prepaid"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Distinct count of prepaid subscriptions"
    - name: "total_main_balance"
      expr: SUM(CAST(main_balance_amount AS DOUBLE))
      comment: "Total main balance amount across all prepaid accounts"
    - name: "total_bonus_balance"
      expr: SUM(CAST(bonus_balance_amount AS DOUBLE))
      comment: "Total bonus balance amount"
    - name: "total_reserved_balance"
      expr: SUM(CAST(reserved_balance_amount AS DOUBLE))
      comment: "Total reserved balance amount"
    - name: "total_content_credit_balance"
      expr: SUM(CAST(content_credit_balance AS DOUBLE))
      comment: "Total content credit balance"
    - name: "total_data_bucket_mb"
      expr: SUM(CAST(data_bucket_mb AS DOUBLE))
      comment: "Total data bucket volume in MB"
    - name: "total_voice_bucket_minutes"
      expr: SUM(CAST(voice_bucket_minutes AS DOUBLE))
      comment: "Total voice bucket minutes"
    - name: "total_sms_bucket_units"
      expr: SUM(CAST(sms_bucket_units AS DOUBLE))
      comment: "Total SMS bucket units"
    - name: "total_last_recharge_amount"
      expr: SUM(CAST(last_recharge_amount AS DOUBLE))
      comment: "Total of last recharge amounts"
    - name: "avg_main_balance"
      expr: AVG(CAST(main_balance_amount AS DOUBLE))
      comment: "Average main balance per prepaid account"
    - name: "avg_last_recharge_amount"
      expr: AVG(CAST(last_recharge_amount AS DOUBLE))
      comment: "Average last recharge amount per account"
    - name: "avg_recharge_count_current_month"
      expr: AVG(CAST(recharge_count_current_month AS DOUBLE))
      comment: "Average recharge count in current month per account"
    - name: "auto_recharge_enabled_count"
      expr: SUM(CASE WHEN auto_recharge_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with auto-recharge enabled for auto-recharge adoption tracking"
    - name: "low_balance_notification_enabled_count"
      expr: SUM(CASE WHEN low_balance_notification_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with low balance notification enabled"
    - name: "zero_balance_count"
      expr: SUM(CASE WHEN main_balance_amount = 0 THEN 1 ELSE 0 END)
      comment: "Count of accounts with zero main balance for churn risk identification"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_recharge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prepaid recharge transaction KPIs tracking recharge volume, channel effectiveness, bonus allocation, processing performance, and fraud detection patterns."
  source: "`telecommunication_ecm`.`billing`.`recharge`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the recharge transaction (e.g., success, failed, pending)"
    - name: "recharge_type"
      expr: recharge_type
      comment: "Type of recharge (e.g., voucher, online, auto-recharge)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for recharge"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating recharge reversal"
    - name: "roaming_flag"
      expr: roaming_flag
      comment: "Flag indicating recharge performed while roaming"
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Reason code for failed recharge"
    - name: "home_country_code"
      expr: home_country_code
      comment: "Home country code of the subscriber"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that processed the recharge"
    - name: "recharge_month"
      expr: DATE_TRUNC('MONTH', recharge_date)
      comment: "Month of recharge for time-series recharge volume analysis"
    - name: "recharge_quarter"
      expr: DATE_TRUNC('QUARTER', recharge_date)
      comment: "Quarter of recharge for quarterly recharge revenue reporting"
  measures:
    - name: "recharge_count"
      expr: COUNT(1)
      comment: "Total number of recharge transactions"
    - name: "unique_subscribers_recharging"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct count of subscribers performing recharges"
    - name: "total_recharge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total recharge amount (gross revenue from recharges)"
    - name: "total_net_credited_amount"
      expr: SUM(CAST(net_credited_amount AS DOUBLE))
      comment: "Total net amount credited to subscriber balances"
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus amount granted with recharges"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on recharges"
    - name: "total_data_bonus_mb"
      expr: SUM(CAST(data_bonus_mb AS DOUBLE))
      comment: "Total data bonus granted in MB"
    - name: "total_voice_bonus_minutes"
      expr: SUM(CAST(voice_bonus_minutes AS DOUBLE))
      comment: "Total voice bonus granted in minutes"
    - name: "total_sms_bonus_count"
      expr: SUM(CAST(sms_bonus_count AS DOUBLE))
      comment: "Total SMS bonus granted"
    - name: "avg_recharge_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average recharge amount per transaction"
    - name: "avg_bonus_amount"
      expr: AVG(CAST(bonus_amount AS DOUBLE))
      comment: "Average bonus amount per recharge"
    - name: "avg_balance_after"
      expr: AVG(CAST(balance_after AS DOUBLE))
      comment: "Average balance after recharge"
    - name: "successful_recharge_count"
      expr: SUM(CASE WHEN transaction_status = 'success' THEN 1 ELSE 0 END)
      comment: "Count of successful recharge transactions"
    - name: "failed_recharge_count"
      expr: SUM(CASE WHEN transaction_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed recharge transactions for system health monitoring"
    - name: "reversed_recharge_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed recharges for fraud detection"
    - name: "roaming_recharge_count"
      expr: SUM(CASE WHEN roaming_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recharges performed while roaming"
$$;