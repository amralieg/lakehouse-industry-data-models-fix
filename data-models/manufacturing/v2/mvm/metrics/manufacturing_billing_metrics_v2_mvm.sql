-- Metric views for domain: billing | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice-level KPIs tracking revenue recognition, discount impact, tax exposure, and collection health across the billing cycle. Primary steering dashboard for AR and revenue operations."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classifies the invoice as standard, credit memo, proforma, etc. — enables revenue vs. reversal analysis."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle state of the invoice (draft, issued, paid, overdue, cancelled) — critical for AR aging and collection prioritisation."
    - name: "collection_status"
      expr: collection_status
      comment: "Indicates the collection stage (current, dunning, written-off) — used to segment receivables risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — enables multi-currency revenue reporting and FX exposure analysis."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month bucket of the billing period start date — supports monthly revenue trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month bucket of invoice due date — used for cash-flow forecasting and DSO trending."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', CAST(issue_timestamp AS DATE))
      comment: "Month the invoice was issued — supports billing cycle cadence and revenue recognition timing."
    - name: "is_self_billing"
      expr: is_self_billing
      comment: "Flags self-billing invoices (customer-generated) vs. supplier-generated — affects revenue recognition rules."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the invoice is tax-exempt — used for tax compliance and reporting segmentation."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value before discounts and taxes. Primary top-line revenue KPI for billing operations."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts. Represents recognised revenue from invoiced transactions."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across all invoices. Required for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoices. Measures commercial discount leakage impacting margin."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied across invoices. Signals pricing discipline and commercial policy adherence."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput and workload analysis."
    - name: "distinct_billing_account_count"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts invoiced. Measures active customer billing reach."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Tracks deal size trends and supports revenue-per-customer benchmarking."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across invoices. Used for tax planning and jurisdiction-level compliance review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing KPIs enabling product/SKU revenue analysis, discount and tax breakdown, and deferred revenue tracking. Supports margin management and revenue recognition governance."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (product, service, freight, tax, etc.) — enables revenue mix analysis by line category."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the invoice line — used to filter active vs. cancelled or disputed lines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line — supports multi-currency revenue reporting."
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the billed quantity — enables volume analysis by unit type."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flags credit memo lines — used to separate revenue reversals from forward billings."
    - name: "is_bundle_line"
      expr: is_bundle_line
      comment: "Indicates whether the line is part of a bundled product offering — supports bundle revenue analysis."
    - name: "is_royalty_line"
      expr: is_royalty_line
      comment: "Flags royalty-bearing lines — used for royalty obligation tracking and compliance."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates tax-exempt lines — required for tax compliance segmentation."
    - name: "service_start_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month bucket of service start date — supports deferred revenue scheduling and period allocation."
    - name: "posted_month"
      expr: DATE_TRUNC('MONTH', CAST(posted_timestamp AS DATE))
      comment: "Month the line was posted to the ledger — used for revenue recognition period analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total gross line amount before discounts. Represents the full billed value at line level."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net line amount after discounts. Core revenue measure at the most granular billing level."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level. Supports detailed tax liability and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at line level. Measures discount leakage by product, customer, or line type."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity billed across invoice lines. Supports volume-based revenue and pricing analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across billed lines. Tracks pricing realisation and detects price erosion."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at line level. Signals commercial discipline and pricing policy compliance."
    - name: "total_royalty_amount"
      expr: SUM(CASE WHEN is_royalty_line = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net revenue from royalty lines. Tracks royalty obligation exposure and licensing revenue."
    - name: "total_credit_memo_amount"
      expr: SUM(CASE WHEN is_credit_memo = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of credit memo lines. Measures revenue reversals and their impact on net billing."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs billed. Indicates product breadth in billing and supports SKU-level revenue analysis."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CASE WHEN is_royalty_line = TRUE THEN CAST(royalty_rate_percent AS DOUBLE) END)
      comment: "Average royalty rate on royalty-bearing lines. Used to monitor royalty rate compliance and contract adherence."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment-level KPIs tracking cash collection performance, discount utilisation, reconciliation health, and payment channel mix. Drives cash flow management and AR efficiency decisions."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (receipt, refund, adjustment, etc.) — enables cash flow categorisation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of payment allocation to invoices (allocated, partially allocated, unallocated) — critical for AR reconciliation."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Method by which the payment was allocated (automatic, manual, partial) — supports process efficiency analysis."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status of the payment — used for cash position and treasury reporting."
    - name: "channel"
      expr: channel
      comment: "Payment channel (bank transfer, card, cheque, etc.) — enables channel mix and cost-to-collect analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — supports multi-currency cash collection reporting."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flags whether the payment has been reconciled — used to track outstanding reconciliation backlog."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', CAST(allocation_date AS DATE))
      comment: "Month of payment allocation — supports monthly cash collection trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the payment was due — used for on-time payment rate and DSO analysis."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross payment amount received. Primary cash collection KPI for treasury and AR management."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net payment amount after discounts and fees. Represents actual cash applied to receivables."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoices. Measures how much collected cash has been matched to open AR."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Tracks cost of early payment incentive programmes."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred. Supports cost-to-collect analysis by channel."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of payments received. Required for tax remittance and compliance reporting."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume metric for payment processing throughput."
    - name: "reconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END)
      comment: "Number of reconciled payments. Measures reconciliation completeness and treasury close efficiency."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Number of unreconciled payments. Flags outstanding reconciliation backlog requiring treasury action."
    - name: "avg_payment_gross_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross payment amount. Tracks typical payment size and detects anomalies in collection patterns."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original payment amount before exchange rate conversion. Used for FX gain/loss and multi-currency reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing schedule KPIs tracking milestone billing performance, planned vs. actual billing variance, retention exposure, and schedule execution health. Critical for project and contract billing governance."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_schedule`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing schedule entry (pending, billed, cancelled, on-hold) — drives billing backlog and execution analysis."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of billing milestone (delivery, completion, advance, retention release) — enables milestone mix and revenue phasing analysis."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency of the billing schedule — supports multi-currency contract billing reporting."
    - name: "is_retention_applicable"
      expr: is_retention_applicable
      comment: "Flags schedules with retention clauses — used to track retention exposure and release timing."
    - name: "planned_billing_month"
      expr: DATE_TRUNC('MONTH', planned_billing_date)
      comment: "Month of planned billing — supports forward-looking billing pipeline and cash flow forecasting."
    - name: "actual_billing_month"
      expr: DATE_TRUNC('MONTH', actual_billing_date)
      comment: "Month billing was actually executed — used to measure billing timeliness vs. plan."
  measures:
    - name: "total_planned_billing_amount"
      expr: SUM(CAST(planned_billing_amount AS DOUBLE))
      comment: "Total planned billing value across all schedule entries. Represents the contracted billing pipeline."
    - name: "total_actual_billed_amount"
      expr: SUM(CAST(actual_billed_amount AS DOUBLE))
      comment: "Total amount actually billed. Core execution KPI measuring billing realisation against plan."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount withheld across billing schedules. Tracks cash tied up in retention clauses."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied at billing schedule level. Measures commercial concessions in contract billing."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on billing schedule entries. Supports tax liability tracking for project-based billing."
    - name: "billing_variance_amount"
      expr: SUM(CAST(actual_billed_amount AS DOUBLE) - CAST(planned_billing_amount AS DOUBLE))
      comment: "Aggregate variance between actual and planned billing amounts. Negative values indicate under-billing risk; positive values indicate over-billing or accelerated recognition."
    - name: "avg_percentage_complete_trigger"
      expr: AVG(CAST(percentage_complete_trigger AS DOUBLE))
      comment: "Average completion percentage threshold that triggers billing. Indicates how far into project delivery billing is initiated."
    - name: "schedule_entry_count"
      expr: COUNT(1)
      comment: "Total number of billing schedule entries. Baseline volume metric for billing schedule complexity and workload."
    - name: "retention_applicable_count"
      expr: COUNT(CASE WHEN is_retention_applicable = TRUE THEN 1 END)
      comment: "Number of billing schedule entries with retention applicable. Quantifies retention exposure across the billing portfolio."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of distinct projects with active billing schedules. Measures project billing portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account KPIs tracking credit exposure, AR balance health, and account portfolio composition. Supports credit risk management, collections strategy, and customer financial health monitoring."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (corporate, government, distributor, etc.) — enables portfolio segmentation by customer class."
    - name: "billing_account_status"
      expr: billing_account_status
      comment: "Current status of the billing account (active, suspended, closed, on-hold) — drives account health and risk segmentation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the account is billed (monthly, quarterly, milestone, etc.) — supports billing cycle planning."
    - name: "collection_stage"
      expr: collection_stage
      comment: "Current collections stage of the account (current, 30-day, 60-day, legal, etc.) — critical for AR aging and collections prioritisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the account — supports multi-currency AR and credit exposure reporting."
    - name: "dunning_procedure"
      expr: dunning_procedure
      comment: "Dunning procedure assigned to the account — used to segment accounts by collections escalation path."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "Method by which invoices are delivered (email, portal, post) — supports digital adoption and cost-to-serve analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the account is tax-exempt — required for tax compliance and revenue reporting segmentation."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the billing account was opened — supports account vintage analysis and cohort-based AR trending."
  measures:
    - name: "total_current_ar_balance"
      expr: SUM(CAST(current_ar_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all billing accounts. Primary KPI for receivables exposure and cash flow risk."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all billing accounts. Measures aggregate credit exposure in the customer portfolio."
    - name: "avg_credit_rating"
      expr: AVG(CAST(credit_rating AS DOUBLE))
      comment: "Average credit rating across billing accounts. Tracks portfolio credit quality and risk concentration."
    - name: "billing_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline metric for active customer billing portfolio size."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN billing_account_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active billing accounts. Measures the productive billing base excluding suspended or closed accounts."
    - name: "tax_exempt_account_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END)
      comment: "Number of tax-exempt billing accounts. Required for tax compliance reporting and revenue recognition adjustments."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per billing account. Benchmarks credit policy generosity and supports limit review decisions."
    - name: "avg_current_ar_balance"
      expr: AVG(CAST(current_ar_balance AS DOUBLE))
      comment: "Average AR balance per billing account. Identifies accounts with disproportionate receivables exposure."
$$;