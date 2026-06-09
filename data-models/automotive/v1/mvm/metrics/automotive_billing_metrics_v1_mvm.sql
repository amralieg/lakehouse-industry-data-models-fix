-- Metric views for domain: billing | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice revenue and performance metrics for automotive billing operations, tracking gross revenue, net revenue, discounts, taxes, and payment collection efficiency."
  source: "`automotive_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., open, paid, cancelled, disputed)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., vehicle sale, parts, service, warranty)"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region where the invoice was generated"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle (for vehicle invoices)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used or expected"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and taxes - primary revenue metric"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all invoices"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total amount still outstanding and unpaid across all invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid across all invoices"
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value - key metric for invoice size analysis"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per invoice"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of gross revenue - key pricing and margin metric"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net invoice value collected - critical cash flow and credit risk metric"
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_date IS NOT NULL THEN invoice_id END)
      comment: "Number of invoices with disputes - quality and customer satisfaction indicator"
    - name: "cancelled_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN cancelled_timestamp IS NOT NULL THEN invoice_id END)
      comment: "Number of cancelled invoices - operational efficiency metric"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash flow metrics tracking payment volume, timing, reconciliation efficiency, and dispute rates for automotive billing operations."
  source: "`automotive_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., cleared, pending, returned)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, check, ACH, credit card)"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was received"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was received"
    - name: "currency"
      expr: currency
      comment: "Currency of the payment"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation with invoices"
    - name: "clearing_year_month"
      expr: DATE_TRUNC('MONTH', clearing_date)
      comment: "Month when payment was cleared"
    - name: "payer_entity_type"
      expr: payer_entity_type
      comment: "Type of entity making the payment (e.g., dealer, fleet, retail customer)"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received - primary cash flow metric"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices - working capital efficiency metric"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction size"
    - name: "payment_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payments successfully applied to invoices - reconciliation efficiency metric"
    - name: "disputed_payment_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN payment_id END)
      comment: "Number of payments with disputes - quality and customer satisfaction indicator"
    - name: "returned_payment_count"
      expr: COUNT(DISTINCT CASE WHEN return_date IS NOT NULL THEN payment_id END)
      comment: "Number of returned payments - credit risk and process quality metric"
    - name: "unique_payer_count"
      expr: COUNT(DISTINCT payment_party_id)
      comment: "Number of unique parties making payments"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and collection performance metrics tracking outstanding balances, aging buckets, collection efficiency, and credit risk for automotive billing."
  source: "`automotive_ecm`.`billing`.`receivable`"
  dimensions:
    - name: "receivable_status"
      expr: receivable_status
      comment: "Current status of the receivable (e.g., open, closed, written off)"
    - name: "receivable_type"
      expr: receivable_type
      comment: "Type of receivable (e.g., trade, warranty, incentive)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification (e.g., current, 30 days, 60 days, 90+ days)"
    - name: "collection_status"
      expr: collection_status
      comment: "Status of collection efforts"
    - name: "customer_type"
      expr: customer_type
      comment: "Type of customer (e.g., dealer, fleet, retail)"
    - name: "dealer_code"
      expr: dealer_code
      comment: "Dealer code for dealer receivables"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region of the receivable"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receivable"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for collection escalation"
    - name: "invoice_year_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the original invoice was issued"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment was due"
  measures:
    - name: "total_receivable_count"
      expr: COUNT(1)
      comment: "Total number of receivable records"
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original receivable amount at inception"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance - primary AR metric for cash flow forecasting"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible - credit loss metric"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per receivable"
    - name: "collection_effectiveness_pct"
      expr: ROUND(100.0 * (SUM(CAST(original_amount AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original receivables collected - key collection performance metric"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Write-off rate as percentage of original receivables - credit risk and loss metric"
    - name: "disputed_receivable_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN receivable_id END)
      comment: "Number of receivables in dispute - quality and customer satisfaction indicator"
    - name: "credit_hold_count"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN receivable_id END)
      comment: "Number of receivables on credit hold - credit risk management metric"
    - name: "written_off_receivable_count"
      expr: COUNT(DISTINCT CASE WHEN write_off_flag = TRUE THEN receivable_id END)
      comment: "Number of receivables written off"
    - name: "unique_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with outstanding receivables"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_dealer_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer statement and aging metrics tracking dealer account balances, aging buckets, payment performance, and floorplan financing for automotive dealer network management."
  source: "`automotive_ecm`.`billing`.`dealer_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the dealer statement"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of dealer statement"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the statement"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the statement"
    - name: "statement_year_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Month of the statement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the statement"
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization code"
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel code"
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle code for the statement"
    - name: "payment_due_year_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month when payment is due"
  measures:
    - name: "total_statement_count"
      expr: COUNT(1)
      comment: "Total number of dealer statements"
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance_amount AS DOUBLE))
      comment: "Total closing balance across all dealer statements - primary dealer AR metric"
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance_amount AS DOUBLE))
      comment: "Total opening balance across all dealer statements"
    - name: "total_vehicle_sales"
      expr: SUM(CAST(total_vehicle_sales_amount AS DOUBLE))
      comment: "Total vehicle sales amount billed to dealers"
    - name: "total_parts_sales"
      expr: SUM(CAST(total_parts_sales_amount AS DOUBLE))
      comment: "Total parts sales amount billed to dealers"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_invoice_amount AS DOUBLE))
      comment: "Total invoice amount on dealer statements"
    - name: "total_payment_received"
      expr: SUM(CAST(total_payment_received_amount AS DOUBLE))
      comment: "Total payments received from dealers"
    - name: "total_incentive_amount"
      expr: SUM(CAST(total_incentive_amount AS DOUBLE))
      comment: "Total incentive amount credited to dealers"
    - name: "total_warranty_reimbursement"
      expr: SUM(CAST(total_warranty_reimbursement_amount AS DOUBLE))
      comment: "Total warranty reimbursement amount credited to dealers"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount on dealer statements"
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total disputed amount on dealer statements"
    - name: "total_aging_current"
      expr: SUM(CAST(aging_bucket_current_amount AS DOUBLE))
      comment: "Total current aging bucket amount (not past due)"
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_bucket_30_days_amount AS DOUBLE))
      comment: "Total aging bucket amount 1-30 days past due"
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_bucket_60_days_amount AS DOUBLE))
      comment: "Total aging bucket amount 31-60 days past due"
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_bucket_90_days_amount AS DOUBLE))
      comment: "Total aging bucket amount 61-90 days past due"
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_bucket_over_90_days_amount AS DOUBLE))
      comment: "Total aging bucket amount over 90 days past due - high credit risk indicator"
    - name: "dealer_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_payment_received_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_invoice_amount AS DOUBLE)), 0), 2)
      comment: "Dealer payment rate as percentage of invoiced amount - dealer credit performance metric"
    - name: "disputed_statement_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN dealer_statement_id END)
      comment: "Number of dealer statements with disputes"
    - name: "floorplan_statement_count"
      expr: COUNT(DISTINCT CASE WHEN floorplan_financing_flag = TRUE THEN dealer_statement_id END)
      comment: "Number of statements with floorplan financing"
    - name: "unique_dealer_count"
      expr: COUNT(DISTINCT dealer_account_id)
      comment: "Number of unique dealers with statements"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate and incentive program performance metrics tracking accrued rebates, settlement efficiency, volume achievement, and program ROI for automotive incentive management."
  source: "`automotive_ecm`.`billing`.`rebate_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the rebate agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of rebate agreement (e.g., volume-based, promotional, loyalty)"
    - name: "beneficiary_type"
      expr: beneficiary_type
      comment: "Type of beneficiary (e.g., dealer, fleet, end customer)"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Status of rebate settlement"
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency of rebate settlement (e.g., monthly, quarterly, annual)"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the rebate agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate agreement"
    - name: "dealer_tier"
      expr: dealer_tier
      comment: "Dealer tier classification for tiered rebate programs"
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used for rebate accrual calculation"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of rebate payment"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the rebate agreement became effective"
  measures:
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of rebate agreements"
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total rebate amount accrued - primary rebate liability metric"
    - name: "total_settled_amount"
      expr: SUM(CAST(total_settled_amount AS DOUBLE))
      comment: "Total rebate amount settled and paid out"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding rebate balance not yet settled - working capital metric"
    - name: "avg_rebate_per_unit"
      expr: AVG(CAST(rebate_amount_per_unit AS DOUBLE))
      comment: "Average rebate amount per unit across agreements"
    - name: "avg_rebate_rate_pct"
      expr: AVG(CAST(rebate_rate_percent AS DOUBLE))
      comment: "Average rebate rate percentage across agreements"
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_accrued_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accrued rebates settled - settlement efficiency and cash flow metric"
    - name: "disputed_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN rebate_agreement_id END)
      comment: "Number of rebate agreements with disputes"
    - name: "retroactive_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN is_retroactive = TRUE THEN rebate_agreement_id END)
      comment: "Number of retroactive rebate agreements"
    - name: "unique_beneficiary_count"
      expr: COUNT(DISTINCT beneficiary_account_id)
      comment: "Number of unique beneficiaries with rebate agreements"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer account health and credit risk metrics tracking credit exposure, payment performance, account status, and auto-pay adoption for automotive billing account management."
  source: "`automotive_ecm`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account"
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., dealer, fleet, retail)"
    - name: "credit_rating_code"
      expr: credit_rating_code
      comment: "Credit rating code assigned to the account"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the account"
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel code"
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization code"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for collection escalation"
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Method of invoice delivery (e.g., email, mail, portal)"
    - name: "payment_method_preference"
      expr: payment_method_preference
      comment: "Preferred payment method for the account"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code of the billing address"
    - name: "opened_year_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month when the account was opened"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit across all accounts - credit capacity metric"
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Total credit exposure across all accounts - credit risk metric"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "avg_credit_exposure"
      expr: AVG(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Average credit exposure per account"
    - name: "avg_payment_performance_score"
      expr: AVG(CAST(payment_performance_score AS DOUBLE))
      comment: "Average payment performance score - account health indicator"
    - name: "credit_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_exposure_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Credit utilization rate as percentage of credit limit - credit risk and capacity metric"
    - name: "auto_pay_enrolled_count"
      expr: COUNT(DISTINCT CASE WHEN auto_pay_enrolled_flag = TRUE THEN account_id END)
      comment: "Number of accounts enrolled in auto-pay - payment automation metric"
    - name: "auto_pay_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_pay_enrolled_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Auto-pay adoption rate - payment automation and efficiency metric"
    - name: "consolidated_billing_count"
      expr: COUNT(DISTINCT CASE WHEN consolidated_billing_flag = TRUE THEN account_id END)
      comment: "Number of accounts with consolidated billing"
    - name: "dunning_blocked_count"
      expr: COUNT(DISTINCT CASE WHEN dunning_block_flag = TRUE THEN account_id END)
      comment: "Number of accounts with dunning blocked"
    - name: "unique_party_count"
      expr: COUNT(DISTINCT party_id)
      comment: "Number of unique parties with billing accounts"
$$;