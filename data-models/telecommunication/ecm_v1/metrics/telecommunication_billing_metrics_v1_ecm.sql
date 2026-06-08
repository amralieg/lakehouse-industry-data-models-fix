-- Metric views for domain: billing | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial invoice metrics for revenue and collection health"
  source: "`telecommunication_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_year"
      expr: DATE_TRUNC('year', bill_date)
      comment: "Calendar year of the invoice bill date"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', bill_date)
      comment: "Calendar month of the invoice bill date"
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Paid, Unpaid, Cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Regular, Credit Note)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., Credit Card, ACH)"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Sum of total amount due for all invoices"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Sum of outstanding balances across invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of amounts that have been paid"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoice records"
    - name: "average_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average total amount due per invoice"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN paid_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of invoices with a non‑zero payment"
    - name: "overdue_invoice_count"
      expr: SUM(CASE WHEN due_date < current_date() AND outstanding_amount > 0 THEN 1 ELSE 0 END)
      comment: "Count of invoices past due date with outstanding balance"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and charge performance metrics per billing charge"
  source: "`telecommunication_ecm`.`billing`.`billing_charge`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Business category of the charge"
    - name: "charge_type"
      expr: charge_type
      comment: "Technical type of the charge (e.g., Usage, Subscription)"
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the charge"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge amounts"
    - name: "period_year"
      expr: DATE_TRUNC('year', period_start)
      comment: "Fiscal year of the charge period"
    - name: "period_month"
      expr: DATE_TRUNC('month', period_start)
      comment: "Fiscal month of the charge period"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross charge amounts before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net charge amounts after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts applied to charges"
    - name: "charge_count"
      expr: COUNT(1)
      comment: "Number of charge records"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per charge"
    - name: "mrr_contribution_total"
      expr: SUM(CAST(mrr_contribution AS DOUBLE))
      comment: "Total Monthly Recurring Revenue contribution from charges"
    - name: "prorated_charge_count"
      expr: SUM(CASE WHEN is_prorated THEN 1 ELSE 0 END)
      comment: "Count of charges that were prorated"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection and payment method effectiveness metrics"
  source: "`telecommunication_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Completed, Failed)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was processed"
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating if payment was auto‑pay"
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Flag indicating if payment was a partial amount"
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment (e.g., One‑Time, Recurring)"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of payment amounts captured"
    - name: "total_net_received_amount"
      expr: SUM(CAST(net_received_amount AS DOUBLE))
      comment: "Sum of net amounts received after fees"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "auto_payment_count"
      expr: SUM(CASE WHEN is_auto_pay THEN 1 ELSE 0 END)
      comment: "Count of payments made via auto‑pay"
    - name: "partial_payment_count"
      expr: SUM(CASE WHEN is_partial_payment THEN 1 ELSE 0 END)
      comment: "Count of partial payments"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_prepaid_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prepaid account liquidity and usage capacity metrics"
  source: "`telecommunication_ecm`.`billing`.`prepaid_balance`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the prepaid balance"
    - name: "balance_status"
      expr: balance_status
      comment: "Current status of the balance (e.g., Active, Frozen)"
    - name: "activation_year"
      expr: DATE_TRUNC('year', activation_date)
      comment: "Year the prepaid balance was activated"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the prepaid balance was activated"
  measures:
    - name: "total_main_balance"
      expr: SUM(CAST(main_balance_amount AS DOUBLE))
      comment: "Aggregate of main prepaid balances"
    - name: "total_bonus_balance"
      expr: SUM(CAST(bonus_balance_amount AS DOUBLE))
      comment: "Aggregate of bonus prepaid balances"
    - name: "total_data_bucket_mb"
      expr: SUM(CAST(data_bucket_mb AS DOUBLE))
      comment: "Total data bucket volume across prepaid accounts"
    - name: "prepaid_balance_count"
      expr: COUNT(1)
      comment: "Number of prepaid balance records"
    - name: "active_balance_count"
      expr: SUM(CASE WHEN balance_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of prepaid balances currently active"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of billing adjustments and credits"
  source: "`telecommunication_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "High‑level category of the adjustment"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Specific type of adjustment (e.g., Refund, Write‑Off)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current processing status of the adjustment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment amounts"
    - name: "is_customer_visible"
      expr: is_customer_visible
      comment: "Whether the adjustment is visible to the customer"
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year the adjustment was approved"
  measures:
    - name: "total_credited_onetime_amount"
      expr: SUM(CAST(credited_onetime_amount AS DOUBLE))
      comment: "Sum of one‑time credited amounts"
    - name: "total_credited_recurring_amount"
      expr: SUM(CAST(credited_recurring_amount AS DOUBLE))
      comment: "Sum of recurring credited amounts"
    - name: "total_credited_usage_amount"
      expr: SUM(CAST(credited_usage_amount AS DOUBLE))
      comment: "Sum of usage‑based credited amounts"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross adjustment amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net adjustment amounts after taxes"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts associated with adjustments"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustment records"
$$;