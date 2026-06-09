-- Metric views for domain: billing | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_storefront_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue and order performance metrics for storefront transactions, including GMV, net revenue, conversion, and refund analysis"
  source: "`gaming_ecm`.`billing`.`storefront_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', order_timestamp)
      comment: "Order date truncated to day for daily revenue analysis"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_timestamp)
      comment: "Order month for monthly revenue trending"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (completed, cancelled, pending, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the transaction"
    - name: "device_type"
      expr: device_type
      comment: "Device type used to place the order (mobile, console, PC, etc.)"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Flag indicating whether this is the player's first purchase"
    - name: "is_subscription"
      expr: is_subscription
      comment: "Flag indicating whether the order is for a subscription"
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Flag indicating whether the order resulted in a chargeback"
    - name: "entitlement_delivery_status"
      expr: entitlement_delivery_status
      comment: "Status of digital entitlement delivery to the player"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of storefront orders placed"
    - name: "gross_merchandise_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total GMV (gross merchandise value) across all orders before refunds"
    - name: "net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Net revenue after platform fees and refunds"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees charged on orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV) per transaction"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_amount > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that resulted in a refund"
    - name: "chargeback_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN chargeback_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that resulted in a chargeback"
    - name: "first_purchase_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_first_purchase = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are first-time purchases"
    - name: "subscription_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_subscription = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are subscription-based"
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per order"
    - name: "platform_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(platform_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Platform fee as a percentage of GMV"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts placing orders"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing performance metrics including success rates, fraud detection, gateway performance, and settlement analysis"
  source: "`gaming_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_date"
      expr: DATE_TRUNC('day', payment_timestamp)
      comment: "Payment date truncated to day for daily payment analysis"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_timestamp)
      comment: "Payment month for monthly payment trending"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (authorized, captured, failed, refunded, etc.)"
    - name: "method_type"
      expr: method_type
      comment: "Type of payment method used (credit card, PayPal, wallet, etc.)"
    - name: "gateway_provider"
      expr: gateway_provider
      comment: "Payment gateway provider processing the transaction"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was processed"
    - name: "fraud_review_status"
      expr: fraud_review_status
      comment: "Fraud review status (approved, pending, rejected, etc.)"
    - name: "three_ds_authentication_status"
      expr: three_ds_authentication_status
      comment: "3D Secure authentication status for the payment"
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand used for payment (Visa, Mastercard, Amex, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the payment was initiated"
    - name: "purchase_type"
      expr: purchase_type
      comment: "Type of purchase (one-time, subscription, in-app, etc.)"
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount processed across all transactions"
    - name: "net_revenue_after_fees"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Net revenue after gateway fees and refunds"
    - name: "total_gateway_fees"
      expr: SUM(CAST(gateway_fee_amount AS DOUBLE))
      comment: "Total fees paid to payment gateway providers"
    - name: "total_refunded"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected through payments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "payment_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status IN ('authorized', 'captured', 'settled') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were successfully processed"
    - name: "payment_failure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status IN ('failed', 'declined', 'rejected') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that failed or were declined"
    - name: "fraud_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_review_status IN ('pending', 'under_review') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments flagged for fraud review"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across all payments"
    - name: "three_ds_authentication_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN three_ds_authentication_status = 'authenticated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments successfully authenticated via 3D Secure"
    - name: "gateway_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(gateway_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Gateway fees as a percentage of total payment amount"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_amount > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were refunded"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts making payments"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription business health metrics including MRR, churn, retention, lifetime value, and subscription cohort analysis"
  source: "`gaming_ecm`.`billing`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, expired, suspended, etc.)"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Tier or level of the subscription plan"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual, etc.)"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month when the subscription started (cohort analysis)"
    - name: "cancellation_month"
      expr: DATE_TRUNC('month', cancellation_date)
      comment: "Month when the subscription was cancelled"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscription was acquired"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Flag indicating whether auto-renewal is enabled"
    - name: "is_trial_active"
      expr: is_trial_active
      comment: "Flag indicating whether the subscription is in trial period"
    - name: "is_gift_subscription"
      expr: is_gift_subscription
      comment: "Flag indicating whether the subscription was gifted"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling subscription billing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the subscription is billed"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscriptions"
    - name: "active_subscriptions"
      expr: SUM(CASE WHEN subscription_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active subscriptions"
    - name: "cancelled_subscriptions"
      expr: SUM(CASE WHEN subscription_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled subscriptions"
    - name: "trial_subscriptions"
      expr: SUM(CASE WHEN is_trial_active = true THEN 1 ELSE 0 END)
      comment: "Number of subscriptions currently in trial period"
    - name: "monthly_recurring_revenue"
      expr: SUM(CASE WHEN subscription_status = 'active' AND billing_frequency = 'monthly' THEN CAST(price AS DOUBLE) ELSE 0 END)
      comment: "Monthly recurring revenue (MRR) from active monthly subscriptions"
    - name: "annual_recurring_revenue"
      expr: SUM(CASE WHEN subscription_status = 'active' THEN CAST(price AS DOUBLE) * CASE WHEN billing_frequency = 'monthly' THEN 12 WHEN billing_frequency = 'quarterly' THEN 4 WHEN billing_frequency = 'annual' THEN 1 ELSE 0 END ELSE 0 END)
      comment: "Annualized recurring revenue (ARR) from all active subscriptions"
    - name: "avg_subscription_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average subscription price across all subscriptions"
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average amount of the last payment received"
    - name: "total_discount_amount"
      expr: SUM(CAST(price AS DOUBLE) * CAST(discount_percentage AS DOUBLE) / 100.0)
      comment: "Total discount amount applied across all subscriptions"
    - name: "churn_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN subscription_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renew_enabled = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions with auto-renewal enabled"
    - name: "trial_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_trial_active = false AND subscription_status = 'active' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_trial_active = true OR subscription_status = 'active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of trials that converted to paid subscriptions"
    - name: "gift_subscription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gift_subscription = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that were gifted"
    - name: "avg_renewal_count"
      expr: AVG(CAST(renewal_count AS DOUBLE))
      comment: "Average number of renewals per subscription"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with subscriptions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback and dispute management metrics including chargeback rates, win rates, financial impact, and fraud analysis"
  source: "`gaming_ecm`.`billing`.`chargeback`"
  dimensions:
    - name: "chargeback_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month when the chargeback was received"
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback case"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute (fraud, service, product, etc.)"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code provided for the dispute"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the chargeback resolution (won, lost, partial, etc.)"
    - name: "card_network"
      expr: card_network
      comment: "Card network involved in the chargeback (Visa, Mastercard, etc.)"
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Flag indicating whether the chargeback was fraud-related"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the disputed transaction"
    - name: "purchase_type"
      expr: purchase_type
      comment: "Type of purchase that was disputed"
    - name: "arbitration_requested"
      expr: arbitration_requested
      comment: "Flag indicating whether arbitration was requested"
  measures:
    - name: "total_chargebacks"
      expr: COUNT(1)
      comment: "Total number of chargeback cases"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount disputed through chargebacks"
    - name: "total_chargeback_fees"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees incurred from chargebacks"
    - name: "total_arbitration_fees"
      expr: SUM(CAST(arbitration_fee AS DOUBLE))
      comment: "Total arbitration fees incurred"
    - name: "total_financial_impact"
      expr: SUM(CAST(total_financial_impact AS DOUBLE))
      comment: "Total financial impact including amount, fees, and arbitration costs"
    - name: "total_reversal_amount"
      expr: SUM(CAST(reversal_amount AS DOUBLE))
      comment: "Total amount reversed due to chargebacks"
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average amount per chargeback"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across all chargebacks"
    - name: "chargeback_win_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_outcome IN ('won', 'merchant_won') THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN resolution_outcome IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of chargebacks won by the merchant"
    - name: "fraud_chargeback_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of chargebacks that were fraud-related"
    - name: "arbitration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN arbitration_requested = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of chargebacks that went to arbitration"
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(resolution_date, received_timestamp))
      comment: "Average number of days to resolve a chargeback"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with chargebacks"
    - name: "unique_payments_disputed"
      expr: COUNT(DISTINCT payment_id)
      comment: "Number of unique payments that were disputed"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund operations and customer satisfaction metrics including refund rates, processing efficiency, and policy compliance"
  source: "`gaming_ecm`.`billing`.`refund`"
  dimensions:
    - name: "refund_month"
      expr: DATE_TRUNC('month', requested_timestamp)
      comment: "Month when the refund was requested"
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (approved, pending, rejected, processed, etc.)"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (full, partial, credit, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund request"
    - name: "return_method"
      expr: return_method
      comment: "Method used to return funds (original payment method, credit, etc.)"
    - name: "is_automated_refund"
      expr: is_automated_refund
      comment: "Flag indicating whether the refund was processed automatically"
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Flag indicating whether the refund was partial"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating potential fraud in the refund request"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the refund was required for regulatory compliance"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the refund"
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund requests"
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount refunded to customers"
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_refund_amount AS DOUBLE))
      comment: "Total tax amount refunded"
    - name: "total_platform_fee_refunded"
      expr: SUM(CAST(platform_fee_refund_amount AS DOUBLE))
      comment: "Total platform fees refunded"
    - name: "total_credit_applied"
      expr: SUM(CAST(credit_applied_amount AS DOUBLE))
      comment: "Total credit applied to customer accounts instead of cash refund"
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per request"
    - name: "avg_original_payment_amount"
      expr: AVG(CAST(original_payment_amount AS DOUBLE))
      comment: "Average original payment amount for refunded transactions"
    - name: "refund_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_status IN ('approved', 'processed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refund requests that were approved"
    - name: "refund_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refund requests that were rejected"
    - name: "partial_refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_partial_refund = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds that were partial"
    - name: "automated_refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_automated_refund = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds processed automatically"
    - name: "fraud_refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fraud_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds flagged for potential fraud"
    - name: "regulatory_refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds required for regulatory compliance"
    - name: "avg_processing_days"
      expr: AVG(DATEDIFF(processed_timestamp, requested_timestamp))
      comment: "Average number of days to process a refund from request to completion"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts requesting refunds"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice and accounts receivable metrics including billing performance, collection efficiency, and revenue recognition"
  source: "`gaming_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month when the invoice was issued"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (draft, issued, paid, overdue, voided, etc.)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or expected for the invoice"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the invoice (net 30, net 60, due on receipt, etc.)"
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "Revenue recognition category for accounting purposes"
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Flag indicating whether the invoice resulted in a chargeback"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice was issued"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoices issued"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoice amount across all invoices"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal amount before tax and discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees charged on invoices"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded from invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate applied to invoices"
    - name: "paid_invoice_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN invoice_status = 'paid' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been paid"
    - name: "overdue_invoice_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN invoice_status = 'overdue' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that are overdue"
    - name: "voided_invoice_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN invoice_status = 'voided' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that were voided"
    - name: "chargeback_invoice_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN chargeback_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that resulted in chargebacks"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(paid_date, invoice_date))
      comment: "Average number of days from invoice date to payment"
    - name: "unique_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts invoiced"
$$;