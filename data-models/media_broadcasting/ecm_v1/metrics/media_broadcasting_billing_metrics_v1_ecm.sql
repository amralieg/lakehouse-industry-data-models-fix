-- Metric views for domain: billing | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice level financial performance metrics"
  source: "`media_broadcasting_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for time series analysis"
    - name: "billing_account_id"
      expr: billing_account_id
      comment: "Billing account identifier"
  measures:
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Sum of total amount due across invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding balances"
    - name: "total_paid_amount"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Sum of amounts actually paid"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average total amount due per invoice"
    - name: "average_days_to_payment"
      expr: AVG(DATEDIFF(paid_date, invoice_date))
      comment: "Average days between invoice date and payment date"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN invoice_status = 'Paid' THEN 1 ELSE 0 END)
      comment: "Count of invoices with status Paid"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_ad_billing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad billing order financial metrics"
  source: "`media_broadcasting_ecm`.`billing`.`ad_billing_order`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the ad order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the ad order"
    - name: "advertiser_id"
      expr: advertiser_id
      comment: "Advertiser identifier"
  measures:
    - name: "ad_billing_order_count"
      expr: COUNT(1)
      comment: "Number of ad billing orders"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount"
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted amount"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding amount"
    - name: "average_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate"
    - name: "average_grp_rate"
      expr: AVG(CAST(grp_rate AS DOUBLE))
      comment: "Average GRP rate"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing metrics"
  source: "`media_broadcasting_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_method_type"
      expr: method_type
      comment: "Payment method type"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "is_autopay"
      expr: is_autopay
      comment: "Flag indicating if payment is auto-pay"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of payments"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account financial health metrics"
  source: "`media_broadcasting_ecm`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account"
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code of billing address"
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency of the account"
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Whether auto-pay is enabled"
  measures:
    - name: "billing_account_count"
      expr: COUNT(1)
      comment: "Number of billing accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Sum of current balances across accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Sum of credit limits"
    - name: "average_current_balance"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Average current balance per account"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`billing_dunning_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collection activity metrics"
  source: "`media_broadcasting_ecm`.`billing`.`dunning_event`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of dunning action taken"
    - name: "dunning_step_number"
      expr: dunning_step_number
      comment: "Current step in dunning workflow"
    - name: "service_suspension_flag"
      expr: service_suspension_flag
      comment: "Whether service was suspended"
    - name: "account_termination_flag"
      expr: account_termination_flag
      comment: "Whether account was terminated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the dunning event"
  measures:
    - name: "dunning_event_count"
      expr: COUNT(1)
      comment: "Number of dunning events"
    - name: "total_amount_recovered"
      expr: SUM(CAST(amount_recovered AS DOUBLE))
      comment: "Total amount recovered through dunning"
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score associated with dunning events"
    - name: "service_suspension_count"
      expr: SUM(CASE WHEN service_suspension_flag THEN 1 ELSE 0 END)
      comment: "Count of events that resulted in service suspension"
$$;