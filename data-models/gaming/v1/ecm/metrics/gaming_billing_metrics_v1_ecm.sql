-- Metric views for domain: billing | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction metrics tracking revenue, volume, fraud, and gateway performance across all payment channels and methods"
  source: "`gaming_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment transaction (authorized, captured, failed, refunded, etc.)"
    - name: "method_type"
      expr: method_type
      comment: "Type of payment method used (credit card, PayPal, bank transfer, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was initiated (web, mobile, console, API)"
    - name: "gateway_provider"
      expr: gateway_provider
      comment: "Payment gateway provider processing the transaction"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "ISO country code of the billing address"
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand (Visa, Mastercard, Amex, etc.) for card payments"
    - name: "purchase_type"
      expr: purchase_type
      comment: "Type of purchase (one-time, subscription, in-app, DLC, etc.)"
    - name: "fraud_review_status"
      expr: fraud_review_status
      comment: "Status of fraud review process (approved, pending, rejected, flagged)"
    - name: "three_ds_authentication_status"
      expr: three_ds_authentication_status
      comment: "3D Secure authentication status for card transactions"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_timestamp)
      comment: "Month of payment transaction for time-series analysis"
    - name: "payment_date"
      expr: DATE(payment_timestamp)
      comment: "Date of payment transaction"
    - name: "is_test_transaction"
      expr: is_test_transaction
      comment: "Flag indicating whether this is a test transaction"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount processed across all transactions"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after deducting gateway fees and platform fees"
    - name: "total_gateway_fees"
      expr: SUM(CAST(gateway_fee_amount AS DOUBLE))
      comment: "Total fees paid to payment gateway providers"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees deducted from gross payment amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all payment transactions"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "payment_count"
      expr: COUNT(payment_id)
      comment: "Total number of payment transactions"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players making payments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction value"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across all payment transactions"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(refund_amount AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(payment_id), 0), 2)
      comment: "Percentage of payments that resulted in refunds"
    - name: "avg_net_revenue_per_player"
      expr: AVG(CAST(net_revenue_amount AS DOUBLE))
      comment: "Average net revenue per payment transaction per player"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription lifecycle and recurring revenue metrics tracking MRR, churn, retention, and subscription health"
  source: "`gaming_ecm`.`billing`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, expired, suspended, trial)"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Tier or level of subscription plan (basic, premium, ultimate, etc.)"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle frequency (monthly, quarterly, annual)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which subscription was acquired"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling recurring billing"
    - name: "platform_subscription_status"
      expr: platform_subscription_status
      comment: "Platform-specific subscription status from external storefront"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Flag indicating whether auto-renewal is enabled"
    - name: "is_trial_active"
      expr: is_trial_active
      comment: "Flag indicating whether subscription is currently in trial period"
    - name: "is_gift_subscription"
      expr: is_gift_subscription
      comment: "Flag indicating whether subscription was gifted by another player"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when subscription started"
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Month when subscription was cancelled"
  measures:
    - name: "total_subscription_revenue"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Total subscription revenue across all active and historical subscriptions"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total amount from most recent payments across all subscriptions"
    - name: "subscription_count"
      expr: COUNT(subscription_id)
      comment: "Total number of subscriptions"
    - name: "active_subscription_count"
      expr: SUM(CASE WHEN subscription_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active subscriptions"
    - name: "cancelled_subscription_count"
      expr: SUM(CASE WHEN subscription_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled subscriptions"
    - name: "trial_subscription_count"
      expr: SUM(CASE WHEN is_trial_active = TRUE THEN 1 ELSE 0 END)
      comment: "Number of subscriptions currently in trial period"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscription_player_account_id)
      comment: "Number of unique players with subscriptions"
    - name: "avg_subscription_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average subscription price across all subscription plans"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to subscriptions"
    - name: "churn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN subscription_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renew_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(subscription_id), 0), 2)
      comment: "Percentage of subscriptions with auto-renewal enabled"
    - name: "gift_subscription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gift_subscription = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(subscription_id), 0), 2)
      comment: "Percentage of subscriptions that were gifted"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback and dispute metrics tracking financial impact, fraud indicators, and resolution outcomes"
  source: "`gaming_ecm`.`billing`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback case (received, under_review, won, lost, pending)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute (fraud, product_not_received, unauthorized, etc.)"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Standardized reason code provided by card network"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final outcome of chargeback resolution (won, lost, reversed, withdrawn)"
    - name: "card_network"
      expr: card_network
      comment: "Card network that processed the chargeback (Visa, Mastercard, Amex, etc.)"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "ISO country code of the billing address"
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Flag indicating whether chargeback is suspected to be fraudulent"
    - name: "arbitration_requested"
      expr: arbitration_requested
      comment: "Flag indicating whether arbitration was requested"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the original transaction"
    - name: "platform_storefront"
      expr: platform_storefront
      comment: "Platform or storefront where the original purchase occurred"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month when chargeback was received"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month when chargeback was resolved"
  measures:
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of chargebacks received"
    - name: "total_chargeback_fees"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees incurred from chargebacks"
    - name: "total_arbitration_fees"
      expr: SUM(CAST(arbitration_fee AS DOUBLE))
      comment: "Total arbitration fees paid for escalated disputes"
    - name: "total_reversal_amount"
      expr: SUM(CAST(reversal_amount AS DOUBLE))
      comment: "Total amount reversed back to merchant after winning disputes"
    - name: "total_financial_impact"
      expr: SUM(CAST(total_financial_impact AS DOUBLE))
      comment: "Total financial impact including chargeback amounts, fees, and reversals"
    - name: "chargeback_count"
      expr: COUNT(chargeback_id)
      comment: "Total number of chargeback cases"
    - name: "fraud_chargeback_count"
      expr: SUM(CASE WHEN fraud_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of chargebacks flagged as fraudulent"
    - name: "arbitration_count"
      expr: SUM(CASE WHEN arbitration_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of chargebacks escalated to arbitration"
    - name: "unique_affected_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players involved in chargebacks"
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average chargeback amount per case"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across chargeback cases"
    - name: "win_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_outcome = 'won' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN resolution_outcome IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of resolved chargebacks won by the merchant"
    - name: "fraud_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(chargeback_id), 0), 2)
      comment: "Percentage of chargebacks flagged as fraudulent"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund processing metrics tracking refund volume, reasons, processing efficiency, and financial impact"
  source: "`gaming_ecm`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (requested, approved, processed, rejected, pending)"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (full, partial, credit, cash)"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund request"
    - name: "reason_description"
      expr: reason_description
      comment: "Detailed description of refund reason"
    - name: "return_method"
      expr: return_method
      comment: "Method used to return funds (original payment method, store credit, etc.)"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the refund"
    - name: "storefront_code"
      expr: storefront_code
      comment: "Storefront or platform where the original purchase occurred"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction code for the refund"
    - name: "is_automated_refund"
      expr: is_automated_refund
      comment: "Flag indicating whether refund was processed automatically"
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Flag indicating whether this is a partial refund"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating suspected fraudulent refund request"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating refund required by regulatory compliance"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_timestamp)
      comment: "Month when refund was requested"
    - name: "processed_month"
      expr: DATE_TRUNC('MONTH', processed_timestamp)
      comment: "Month when refund was processed"
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "total_credit_applied"
      expr: SUM(CAST(credit_applied_amount AS DOUBLE))
      comment: "Total amount applied as store credit instead of cash refund"
    - name: "total_platform_fee_refund"
      expr: SUM(CAST(platform_fee_refund_amount AS DOUBLE))
      comment: "Total platform fees refunded"
    - name: "total_tax_refund"
      expr: SUM(CAST(tax_refund_amount AS DOUBLE))
      comment: "Total tax amount refunded"
    - name: "refund_count"
      expr: COUNT(refund_id)
      comment: "Total number of refund transactions"
    - name: "approved_refund_count"
      expr: SUM(CASE WHEN refund_status = 'approved' OR refund_status = 'processed' THEN 1 ELSE 0 END)
      comment: "Number of refunds that were approved and processed"
    - name: "rejected_refund_count"
      expr: SUM(CASE WHEN refund_status = 'rejected' THEN 1 ELSE 0 END)
      comment: "Number of refund requests that were rejected"
    - name: "automated_refund_count"
      expr: SUM(CASE WHEN is_automated_refund = TRUE THEN 1 ELSE 0 END)
      comment: "Number of refunds processed automatically without manual review"
    - name: "partial_refund_count"
      expr: SUM(CASE WHEN is_partial_refund = TRUE THEN 1 ELSE 0 END)
      comment: "Number of partial refunds issued"
    - name: "unique_refunded_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who received refunds"
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_status = 'approved' OR refund_status = 'processed' THEN 1 ELSE 0 END) / NULLIF(COUNT(refund_id), 0), 2)
      comment: "Percentage of refund requests that were approved"
    - name: "automation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_automated_refund = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(refund_id), 0), 2)
      comment: "Percentage of refunds processed automatically"
    - name: "credit_refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(credit_applied_amount AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(refund_id), 0), 2)
      comment: "Percentage of refunds issued as store credit"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice and billing metrics tracking invoicing volume, payment status, revenue recognition, and collections performance"
  source: "`gaming_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (draft, issued, paid, overdue, voided, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit_memo, debit_memo, proforma, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or expected for the invoice"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received"
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "Revenue recognition category for accounting purposes"
    - name: "storefront_code"
      expr: storefront_code
      comment: "Storefront or platform code associated with the invoice"
    - name: "tax_exemption_code"
      expr: tax_exemption_code
      comment: "Tax exemption code if applicable"
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Flag indicating whether invoice has associated chargeback"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when invoice payment is due"
    - name: "paid_month"
      expr: DATE_TRUNC('MONTH', paid_date)
      comment: "Month when invoice was paid"
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Start month of the billing period covered by the invoice"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoice amount including all charges and taxes"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal amount before taxes and fees"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "total_platform_fee"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees charged across all invoices"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded from invoices"
    - name: "invoice_count"
      expr: COUNT(invoice_id)
      comment: "Total number of invoices issued"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Number of invoices that have been paid"
    - name: "overdue_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'overdue' THEN 1 ELSE 0 END)
      comment: "Number of invoices that are overdue"
    - name: "voided_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'voided' THEN 1 ELSE 0 END)
      comment: "Number of invoices that have been voided"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'disputed' THEN 1 ELSE 0 END)
      comment: "Number of invoices under dispute"
    - name: "chargeback_invoice_count"
      expr: SUM(CASE WHEN chargeback_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of invoices with associated chargebacks"
    - name: "unique_billed_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who were invoiced"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate percentage applied to invoices"
    - name: "payment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN invoice_status = 'paid' THEN 1 ELSE 0 END) / NULLIF(COUNT(invoice_id), 0), 2)
      comment: "Percentage of invoices that have been paid"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount applied relative to subtotal"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_dunning_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and payment recovery metrics tracking failed payment recovery attempts, success rates, and churn risk"
  source: "`gaming_ecm`.`billing`.`dunning_event`"
  dimensions:
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current status of the dunning event (pending, retrying, recovered, failed, abandoned)"
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Standardized code for payment failure reason"
    - name: "resolution_method"
      expr: resolution_method
      comment: "Method used to resolve the failed payment (retry, payment_method_update, manual, etc.)"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor that handled the transaction"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform or storefront code"
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify player of failed payment (email, SMS, push, in-app)"
    - name: "player_response_action"
      expr: player_response_action
      comment: "Action taken by player in response to dunning notification"
    - name: "access_revoked_flag"
      expr: access_revoked_flag
      comment: "Flag indicating whether player access was revoked due to failed payment"
    - name: "is_voluntary_cancellation"
      expr: is_voluntary_cancellation
      comment: "Flag indicating whether failure resulted in voluntary cancellation"
    - name: "attempt_month"
      expr: DATE_TRUNC('MONTH', attempt_timestamp)
      comment: "Month when dunning attempt was made"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_timestamp)
      comment: "Month when dunning event was resolved"
  measures:
    - name: "total_attempted_amount"
      expr: SUM(CAST(attempted_amount AS DOUBLE))
      comment: "Total amount attempted to be recovered through dunning"
    - name: "dunning_event_count"
      expr: COUNT(dunning_event_id)
      comment: "Total number of dunning events"
    - name: "recovered_event_count"
      expr: SUM(CASE WHEN dunning_status = 'recovered' THEN 1 ELSE 0 END)
      comment: "Number of dunning events that successfully recovered payment"
    - name: "failed_event_count"
      expr: SUM(CASE WHEN dunning_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Number of dunning events that failed to recover payment"
    - name: "abandoned_event_count"
      expr: SUM(CASE WHEN dunning_status = 'abandoned' THEN 1 ELSE 0 END)
      comment: "Number of dunning events that were abandoned"
    - name: "access_revoked_count"
      expr: SUM(CASE WHEN access_revoked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of events where player access was revoked"
    - name: "voluntary_cancellation_count"
      expr: SUM(CASE WHEN is_voluntary_cancellation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of events resulting in voluntary cancellation"
    - name: "unique_affected_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players affected by dunning events"
    - name: "unique_affected_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Number of unique subscriptions affected by dunning events"
    - name: "avg_attempted_amount"
      expr: AVG(CAST(attempted_amount AS DOUBLE))
      comment: "Average amount attempted per dunning event"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across dunning events"
    - name: "avg_ltv_at_dunning"
      expr: AVG(CAST(ltv_at_dunning AS DOUBLE))
      comment: "Average lifetime value of players at time of dunning event"
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dunning_status = 'recovered' THEN 1 ELSE 0 END) / NULLIF(COUNT(dunning_event_id), 0), 2)
      comment: "Percentage of dunning events that successfully recovered payment"
    - name: "voluntary_churn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_voluntary_cancellation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(dunning_event_id), 0), 2)
      comment: "Percentage of dunning events resulting in voluntary cancellation"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition and deferred revenue metrics tracking recognized vs deferred revenue, recognition methods, and accounting compliance"
  source: "`gaming_ecm`.`billing`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition event (recognized, deferred, pending, reversed)"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition (point_in_time, over_time, milestone, etc.)"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue for classification purposes"
    - name: "revenue_type"
      expr: revenue_type
      comment: "Type of revenue (product_sale, subscription, DLC, in-app_purchase, etc.)"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the recognition event"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the recognition event"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the revenue"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate transaction price across performance obligations"
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Flag indicating whether recognition relates to a contract modification"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating whether this is a revenue reversal entry"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month when revenue was recognized"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the original transaction"
    - name: "service_period_start_month"
      expr: DATE_TRUNC('MONTH', service_period_start_date)
      comment: "Start month of the service period"
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period"
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred for future recognition"
    - name: "total_remaining_deferred_balance"
      expr: SUM(CAST(remaining_deferred_balance AS DOUBLE))
      comment: "Total remaining deferred revenue balance yet to be recognized"
    - name: "total_transaction_amount"
      expr: SUM(CAST(total_transaction_amount AS DOUBLE))
      comment: "Total transaction amount subject to revenue recognition"
    - name: "recognition_event_count"
      expr: COUNT(revenue_recognition_id)
      comment: "Total number of revenue recognition events"
    - name: "reversal_event_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revenue reversal events"
    - name: "contract_modification_count"
      expr: SUM(CASE WHEN contract_modification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recognition events related to contract modifications"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players with revenue recognition events"
    - name: "unique_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of unique invoices with revenue recognition events"
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average revenue recognized per event"
    - name: "avg_recognition_percentage"
      expr: AVG(CAST(recognition_percentage AS DOUBLE))
      comment: "Average percentage of transaction amount recognized per event"
    - name: "deferral_rate"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_transaction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of transaction amount deferred for future recognition"
    - name: "recognition_rate"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_transaction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of transaction amount recognized in current period"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_storefront_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storefront order and transaction metrics tracking order volume, conversion, average order value, and platform performance"
  source: "`gaming_ecm`.`billing`.`storefront_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the storefront order (pending, completed, cancelled, refunded, failed)"
    - name: "storefront_platform"
      expr: storefront_platform
      comment: "Platform or storefront where order was placed (Steam, PlayStation, Xbox, Epic, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor that handled the transaction"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used to place the order (PC, console, mobile, tablet)"
    - name: "player_region"
      expr: player_region
      comment: "Geographic region of the player"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Marketing attribution source for the order"
    - name: "entitlement_delivery_status"
      expr: entitlement_delivery_status
      comment: "Status of entitlement delivery to player (delivered, pending, failed)"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Flag indicating whether this is the player's first purchase"
    - name: "is_subscription"
      expr: is_subscription
      comment: "Flag indicating whether order is for a subscription"
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Flag indicating whether order has associated chargeback"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month when order was placed"
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_timestamp)
      comment: "Month when order was completed"
  measures:
    - name: "total_order_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross order value across all orders"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal amount before taxes and fees"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after platform fees and discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees charged across all orders"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded from orders"
    - name: "order_count"
      expr: COUNT(storefront_order_id)
      comment: "Total number of storefront orders"
    - name: "completed_order_count"
      expr: SUM(CASE WHEN order_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of orders that were completed successfully"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of orders that were cancelled"
    - name: "first_purchase_count"
      expr: SUM(CASE WHEN is_first_purchase = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders that were first-time purchases"
    - name: "subscription_order_count"
      expr: SUM(CASE WHEN is_subscription = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders for subscriptions"
    - name: "chargeback_order_count"
      expr: SUM(CASE WHEN chargeback_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders with associated chargebacks"
    - name: "unique_buyers"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who placed orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value across all orders"
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across orders"
    - name: "avg_platform_fee_percentage"
      expr: AVG(CAST(platform_fee_percentage AS DOUBLE))
      comment: "Average platform fee percentage charged"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(storefront_order_id), 0), 2)
      comment: "Percentage of orders that were completed successfully"
    - name: "first_purchase_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_first_purchase = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(storefront_order_id), 0), 2)
      comment: "Percentage of orders that were first-time purchases"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount applied relative to subtotal"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional code redemption and campaign effectiveness metrics tracking redemption volume, discount impact, and fraud detection"
  source: "`gaming_ecm`.`billing`.`promo_redemption`"
  dimensions:
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the promo code redemption (successful, failed, reversed, pending)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, fixed_amount, free_shipping, etc.)"
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which promo code was redeemed (web, mobile, console, etc.)"
    - name: "redemption_platform"
      expr: redemption_platform
      comment: "Platform where redemption occurred"
    - name: "redemption_region"
      expr: redemption_region
      comment: "Geographic region of redemption"
    - name: "redemption_country_code"
      expr: redemption_country_code
      comment: "ISO country code of redemption location"
    - name: "redemption_device_type"
      expr: redemption_device_type
      comment: "Type of device used for redemption"
    - name: "attribution_source"
      expr: attribution_source
      comment: "Marketing attribution source for the redemption"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Flag indicating whether redemption was for first purchase"
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether promo code was stackable with other offers"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating suspected fraudulent redemption"
    - name: "terms_accepted_flag"
      expr: terms_accepted_flag
      comment: "Flag indicating whether terms and conditions were accepted"
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month when promo code was redeemed"
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied through promo code redemptions"
    - name: "total_original_order_amount"
      expr: SUM(CAST(original_order_amount AS DOUBLE))
      comment: "Total original order amount before promo discount"
    - name: "total_final_order_amount"
      expr: SUM(CAST(final_order_amount AS DOUBLE))
      comment: "Total final order amount after promo discount"
    - name: "redemption_count"
      expr: COUNT(promo_redemption_id)
      comment: "Total number of promo code redemptions"
    - name: "successful_redemption_count"
      expr: SUM(CASE WHEN redemption_status = 'successful' THEN 1 ELSE 0 END)
      comment: "Number of successful promo code redemptions"
    - name: "failed_redemption_count"
      expr: SUM(CASE WHEN redemption_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Number of failed redemption attempts"
    - name: "reversed_redemption_count"
      expr: SUM(CASE WHEN redemption_status = 'reversed' THEN 1 ELSE 0 END)
      comment: "Number of redemptions that were reversed"
    - name: "first_purchase_redemption_count"
      expr: SUM(CASE WHEN is_first_purchase = TRUE THEN 1 ELSE 0 END)
      comment: "Number of redemptions for first-time purchases"
    - name: "fraud_redemption_count"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of redemptions flagged as fraudulent"
    - name: "unique_redeemers"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Number of unique players who redeemed promo codes"
    - name: "unique_promo_codes"
      expr: COUNT(DISTINCT promo_code_id)
      comment: "Number of unique promo codes redeemed"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT marketing_campaign_id)
      comment: "Number of unique marketing campaigns with redemptions"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across redemptions"
    - name: "success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN redemption_status = 'successful' THEN 1 ELSE 0 END) / NULLIF(COUNT(promo_redemption_id), 0), 2)
      comment: "Percentage of redemption attempts that were successful"
    - name: "fraud_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(promo_redemption_id), 0), 2)
      comment: "Percentage of redemptions flagged as fraudulent"
    - name: "avg_discount_impact"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_order_amount AS DOUBLE)), 0), 2)
      comment: "Average percentage discount impact on original order value"
$$;