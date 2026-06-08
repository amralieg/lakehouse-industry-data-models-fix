-- Metric views for domain: finance | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_client_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client billing and revenue metrics tracking invoice amounts, payment status, and revenue recognition performance"
  source: "`advertising_ecm`.`finance`.`client_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the client invoice (e.g., draft, sent, paid, overdue)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit, adjustment)"
    - name: "fiscal_year"
      expr: YEAR(invoice_date)
      comment: "Fiscal year when the invoice was issued"
    - name: "fiscal_quarter"
      expr: CONCAT('Q', QUARTER(invoice_date))
      comment: "Fiscal quarter when the invoice was issued"
    - name: "fiscal_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Fiscal month when the invoice was issued"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the client (e.g., Net 30, Net 60)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "is_overdue"
      expr: CASE WHEN due_date < CURRENT_DATE() AND invoice_status != 'Paid' THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the invoice is past its due date and unpaid"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed amount across all client invoices"
    - name: "total_amount_outstanding"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total outstanding receivables not yet collected from clients"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected from clients"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts successfully collected from clients"
    - name: "avg_invoice_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount per client invoice"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on client invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to client invoices"
    - name: "invoice_count"
      expr: COUNT(client_invoice_id)
      comment: "Total number of client invoices issued"
    - name: "days_sales_outstanding"
      expr: AVG(DATEDIFF(COALESCE(payment_received_date, CURRENT_DATE()), invoice_date))
      comment: "Average number of days between invoice issuance and payment receipt"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_vendor_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor payment and accounts payable metrics tracking amounts owed, payment timing, and cash management"
  source: "`advertising_ecm`.`finance`.`vendor_payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the vendor payable (e.g., pending, paid, disputed)"
    - name: "fiscal_year"
      expr: YEAR(invoice_date)
      comment: "Fiscal year when the vendor invoice was received"
    - name: "fiscal_quarter"
      expr: CONCAT('Q', QUARTER(invoice_date))
      comment: "Fiscal quarter when the vendor invoice was received"
    - name: "fiscal_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Fiscal month when the vendor invoice was received"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with the vendor"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payable is denominated"
    - name: "is_overdue"
      expr: CASE WHEN due_date < CURRENT_DATE() AND payment_status != 'Paid' THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the payable is past its due date and unpaid"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of reconciliation between vendor invoice and internal records"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount owed to vendors before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount owed to vendors after discounts and adjustments"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured from vendors"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available vendor discounts successfully captured through early payment"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on vendor payables"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments"
    - name: "avg_payable_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per vendor payable"
    - name: "payable_count"
      expr: COUNT(vendor_payable_id)
      comment: "Total number of vendor payables recorded"
    - name: "days_payable_outstanding"
      expr: AVG(DATEDIFF(COALESCE(payment_date, CURRENT_DATE()), invoice_date))
      comment: "Average number of days between vendor invoice receipt and payment"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance and variance metrics tracking planned vs actual spend and commitment levels"
  source: "`advertising_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line (e.g., draft, approved, rejected)"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost for the budget line (e.g., media, production, talent)"
    - name: "channel_type"
      expr: channel_type
      comment: "Media or marketing channel type for the budget allocation"
    - name: "billing_category"
      expr: billing_category
      comment: "Billing category for the budget line"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the budget line is currently active"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the budget line is billable to the client"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year when the budget flight period begins"
    - name: "flight_quarter"
      expr: CONCAT('Q', QUARTER(flight_start_date))
      comment: "Quarter when the budget flight period begins"
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total budget amount allocated across all budget lines"
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after adjustments"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total amount committed through purchase orders or contracts"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend against budget lines"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget committed through contracts or POs"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between allocated budget and actual spend"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across budget lines"
    - name: "budget_line_count"
      expr: COUNT(budget_line_id)
      comment: "Total number of budget lines"
    - name: "remaining_budget"
      expr: SUM((CAST(allocated_amount AS DOUBLE)) - (CAST(actual_spend AS DOUBLE)))
      comment: "Total remaining unspent budget across all budget lines"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition and performance obligation metrics tracking earned revenue, deferred revenue, and milestone completion"
  source: "`advertising_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition (e.g., pending, recognized, deferred)"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition (e.g., point-in-time, over-time, milestone)"
    - name: "revenue_type"
      expr: revenue_type
      comment: "Type of revenue (e.g., service, media, commission)"
    - name: "service_line"
      expr: service_line
      comment: "Service line generating the revenue"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for revenue recognition"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for revenue recognition"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for revenue recognition"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the revenue recognition schedule is active"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which revenue is recognized"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all performance obligations"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount_to_date AS DOUBLE))
      comment: "Total revenue recognized to date across all contracts"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred and not yet recognized"
    - name: "total_unbilled_revenue"
      expr: SUM(CAST(unbilled_revenue_amount AS DOUBLE))
      comment: "Total revenue earned but not yet billed to clients"
    - name: "revenue_recognition_rate"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount_to_date AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value recognized as revenue"
    - name: "avg_percentage_complete"
      expr: AVG(CAST(percentage_complete AS DOUBLE))
      comment: "Average completion percentage across all performance obligations"
    - name: "performance_obligation_count"
      expr: COUNT(revenue_recognition_id)
      comment: "Total number of performance obligations tracked"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per performance obligation"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual accounting metrics tracking estimated liabilities, approval status, and variance between estimates and actuals"
  source: "`advertising_ecm`.`finance`.`accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g., media cost, production cost, service fee)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual (e.g., pending, approved, rejected)"
    - name: "reversal_status"
      expr: reversal_status
      comment: "Status of accrual reversal (e.g., not reversed, reversed, partial)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the accrual"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the accrual"
    - name: "is_material"
      expr: is_material
      comment: "Flag indicating whether the accrual is material to financial statements"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the accrual is denominated"
    - name: "accrual_month"
      expr: DATE_TRUNC('MONTH', accrual_date)
      comment: "Month when the accrual was recorded"
  measures:
    - name: "total_estimated_amount"
      expr: SUM(CAST(estimated_amount AS DOUBLE))
      comment: "Total estimated accrual amount across all accruals"
    - name: "total_actual_invoice_amount"
      expr: SUM(CAST(actual_invoice_amount AS DOUBLE))
      comment: "Total actual invoice amount received for accrued items"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between estimated accruals and actual invoices"
    - name: "accrual_accuracy_rate"
      expr: ROUND(100.0 - (ABS(SUM(CAST(variance_amount AS DOUBLE))) / NULLIF(SUM(CAST(estimated_amount AS DOUBLE)), 0) * 100.0), 2)
      comment: "Percentage accuracy of accrual estimates compared to actual invoices"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between estimated and actual amounts"
    - name: "accrual_count"
      expr: COUNT(accrual_id)
      comment: "Total number of accruals recorded"
    - name: "avg_estimated_amount"
      expr: AVG(CAST(estimated_amount AS DOUBLE))
      comment: "Average estimated amount per accrual"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing and cash flow metrics tracking payment amounts, timing, methods, and reconciliation status"
  source: "`advertising_ecm`.`finance`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., pending, processed, failed, reconciled)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, ACH, check, credit card)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., vendor payment, client receipt, refund)"
    - name: "direction"
      expr: direction
      comment: "Direction of payment flow (inbound or outbound)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payment"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year when the payment was made"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period when the payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when the payment was made"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was made"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating whether this is a reversal payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount across all payments"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency after exchange rate conversion"
    - name: "payment_count"
      expr: COUNT(payment_id)
      comment: "Total number of payments processed"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "avg_days_to_reconcile"
      expr: AVG(DATEDIFF(reconciliation_date, payment_date))
      comment: "Average number of days between payment and bank reconciliation"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_media_cost_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media cost reconciliation metrics tracking variance between planned and billed media costs, impression delivery, and dispute resolution"
  source: "`advertising_ecm`.`finance`.`media_cost_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of media cost reconciliation (e.g., pending, reconciled, disputed)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the reconciliation is under dispute"
    - name: "make_good_flag"
      expr: make_good_flag
      comment: "Flag indicating whether make-good impressions were provided"
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Code categorizing the reason for cost variance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which media costs are reconciled"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period being reconciled"
    - name: "billing_quarter"
      expr: CONCAT('Q', QUARTER(billing_period_start_date))
      comment: "Quarter of the billing period being reconciled"
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost_amount AS DOUBLE))
      comment: "Total planned media cost across all reconciliations"
    - name: "total_billed_cost"
      expr: SUM(CAST(billed_cost_amount AS DOUBLE))
      comment: "Total billed media cost from vendors"
    - name: "total_reconciled_amount"
      expr: SUM(CAST(reconciled_amount AS DOUBLE))
      comment: "Total reconciled media cost after adjustments"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between planned and billed media costs"
    - name: "cost_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_cost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage variance between planned and billed media costs"
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions across all media buys"
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total impressions delivered by vendors"
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_impressions AS DOUBLE)) / NULLIF(SUM(CAST(planned_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of planned impressions actually delivered"
    - name: "avg_planned_cpm"
      expr: AVG(CAST(planned_cpm AS DOUBLE))
      comment: "Average planned cost per thousand impressions"
    - name: "avg_actual_cpm"
      expr: AVG(CAST(actual_cpm AS DOUBLE))
      comment: "Average actual cost per thousand impressions based on billing"
    - name: "total_make_good_impressions"
      expr: SUM(CAST(make_good_impressions AS DOUBLE))
      comment: "Total make-good impressions provided by vendors to compensate for under-delivery"
    - name: "reconciliation_count"
      expr: COUNT(media_cost_reconciliation_id)
      comment: "Total number of media cost reconciliations performed"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`finance_financial_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial close process metrics tracking close cycle time, compliance flags, and period-end completion status"
  source: "`advertising_ecm`.`finance`.`financial_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Status of the financial close process (e.g., in progress, completed, reopened)"
    - name: "close_type"
      expr: close_type
      comment: "Type of financial close (e.g., monthly, quarterly, annual)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the close period"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the close period"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the close"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the financial close"
    - name: "cfo_sign_off_flag"
      expr: cfo_sign_off_flag
      comment: "Flag indicating whether CFO has signed off on the close"
    - name: "controller_sign_off_flag"
      expr: controller_sign_off_flag
      comment: "Flag indicating whether Controller has signed off on the close"
    - name: "sox_compliance_flag"
      expr: sox_compliance_flag
      comment: "Flag indicating SOX compliance status for the close"
    - name: "audit_ready_flag"
      expr: audit_ready_flag
      comment: "Flag indicating whether the close is audit-ready"
  measures:
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(actual_close_date, target_close_date))
      comment: "Average number of days between target and actual close date"
    - name: "close_cycle_time"
      expr: AVG(DATEDIFF(actual_close_date, DATE_TRUNC('MONTH', actual_close_date)))
      comment: "Average number of days from period end to actual close completion"
    - name: "on_time_close_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_close_date <= target_close_date THEN 1 END) / NULLIF(COUNT(financial_close_id), 0), 2)
      comment: "Percentage of financial closes completed on or before target date"
    - name: "sox_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(financial_close_id), 0), 2)
      comment: "Percentage of closes meeting SOX compliance requirements"
    - name: "cfo_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cfo_sign_off_flag = TRUE THEN 1 END) / NULLIF(COUNT(financial_close_id), 0), 2)
      comment: "Percentage of closes with CFO sign-off"
    - name: "close_count"
      expr: COUNT(financial_close_id)
      comment: "Total number of financial close periods"
$$;