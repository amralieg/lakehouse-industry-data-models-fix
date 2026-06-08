-- Metric views for domain: finance | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable invoice metrics tracking payable liability, payment efficiency, discount capture, tax exposure, and approval cycle health for the restaurant network. Used by CFO, AP managers, and controllers to manage vendor obligations and cash outflow."
  source: "`restaurants_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. Open, Paid, Disputed, Cancelled) — primary filter for aging and liability analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. Standard, Credit Memo, Recurring) — used to segment payable volumes by transaction type."
    - name: "expense_category"
      expr: expense_category
      comment: "Business expense category (e.g. Food & Beverage, Maintenance, Marketing) — enables cost-category spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice — supports multi-currency payable reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used or designated for payment (e.g. ACH, Wire, Check) — used to analyse payment channel mix."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Vendor payment terms code (e.g. Net30, Net60) — key dimension for DPO and early-payment discount analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO / GR / invoice three-way match — critical for procurement compliance and fraud risk monitoring."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Escalation level of vendor dunning notices — indicates overdue or disputed invoice severity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice — used to track bottlenecks in the AP approval pipeline."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of the invoice date — standard time dimension for monthly AP trend analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the invoice is due — used for cash-flow forecasting and aging bucket analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Calendar month the invoice was posted to the ledger — aligns AP activity to financial periods."
  measures:
    - name: "total_gross_payable"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount before discounts and taxes. Core liability measure used by treasury and controllers to size vendor obligations."
    - name: "total_net_payable"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts. Represents actual cash outflow obligation — primary measure for cash-flow planning."
    - name: "total_tax_payable"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices. Used by tax teams to reconcile input VAT / sales tax liabilities."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or trade discounts captured on AP invoices. Measures working-capital efficiency and vendor discount programme performance."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for tax compliance reporting and vendor remittance reconciliation."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AP invoice amount expressed in local functional currency. Used for entity-level financial reporting and FX exposure analysis."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Baseline volume measure for AP workload, vendor activity, and process throughput benchmarking."
    - name: "distinct_vendor_invoice_count"
      expr: COUNT(DISTINCT purchase_order_number)
      comment: "Count of distinct purchase orders referenced across AP invoices. Proxies vendor/PO diversity and procurement breadth."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Tracks typical transaction size — a sudden shift signals vendor pricing changes or invoice splitting behaviour."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross payable captured as discounts. Measures effectiveness of early-payment discount programmes — a key working-capital KPI."
    - name: "tax_rate_on_payables_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate on AP invoices (tax / net amount). Used by tax and finance teams to monitor input tax burden across expense categories."
    - name: "avg_days_to_payment"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average number of days from invoice date to payment date. Core DPO proxy — measures AP cycle efficiency and vendor relationship health."
    - name: "avg_days_to_approval"
      expr: AVG(CAST(DATEDIFF(approval_date, invoice_date) AS DOUBLE))
      comment: "Average days from invoice receipt to approval. Identifies bottlenecks in the AP approval workflow that delay payment and risk late fees."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable payment execution metrics covering cash disbursement volumes, discount realisation, payment method mix, and reconciliation status. Used by treasury, AP operations, and CFO to manage outgoing cash and vendor settlement efficiency."
  source: "`restaurants_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AP payment (e.g. Cleared, Pending, Rejected) — primary filter for outstanding and failed payment analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the payment transaction (e.g. Vendor Payment, Intercompany, Refund) — used to segment disbursement by type."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment channel used (e.g. ACH, Wire, Check) — key dimension for payment channel optimisation and cost analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment — used to identify unreconciled items and close the books accurately."
    - name: "payment_priority"
      expr: payment_priority
      comment: "Priority assigned to the payment run item — used to analyse urgency distribution and prioritisation policy adherence."
    - name: "document_currency"
      expr: document_currency
      comment: "Currency of the payment document — supports multi-currency disbursement analysis."
    - name: "business_area"
      expr: business_area
      comment: "Business area associated with the payment — enables segment-level cash outflow analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of the payment date — standard time dimension for monthly disbursement trend reporting."
    - name: "clearing_month"
      expr: DATE_TRUNC('MONTH', clearing_date)
      comment: "Calendar month the payment cleared the bank — used for bank reconciliation and cash-position reporting."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed via AP payments. Primary treasury KPI for monitoring outgoing cash flow and vendor settlement volumes."
    - name: "total_local_currency_payment"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AP payment amount in local functional currency. Used for entity-level cash reporting and FX translation reconciliation."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts realised at payment execution. Measures actual working-capital savings from vendor discount programmes."
    - name: "total_withholding_tax_deducted"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted at payment. Required for tax compliance and vendor remittance advice accuracy."
    - name: "payment_transaction_count"
      expr: COUNT(1)
      comment: "Total number of AP payment transactions. Baseline volume measure for AP operations throughput and payment run sizing."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average AP payment amount per transaction. Tracks typical disbursement size — shifts indicate vendor mix or invoice consolidation changes."
    - name: "discount_realisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_taken_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payment amount captured as early-payment discounts. Measures working-capital programme effectiveness at the payment execution level."
    - name: "avg_days_to_clearing"
      expr: AVG(CAST(DATEDIFF(clearing_date, payment_date) AS DOUBLE))
      comment: "Average days from payment initiation to bank clearing. Measures payment settlement speed — critical for accurate daily cash-position management."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-receivable invoice metrics covering franchise fee billings, outstanding balances, revenue recognition, and collection efficiency. Used by CFO, AR managers, and franchise finance teams to manage receivable health and revenue realisation."
  source: "`restaurants_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AR invoice (e.g. Open, Paid, Overdue, Written-Off) — primary filter for receivable aging and collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the AR invoice (e.g. Royalty, Franchise Fee, Rent, Marketing Fund) — enables revenue stream segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the AR invoice — supports multi-currency receivable reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method designated for the invoice — used to analyse collection channel mix."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Customer payment terms code — key dimension for DSO and collection cycle analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Escalation level of collection dunning notices — indicates overdue severity and collection risk."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — enables geographic receivable and revenue analysis."
    - name: "business_area"
      expr: business_area
      comment: "Business area associated with the AR invoice — supports segment-level receivable reporting."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of the invoice date — standard time dimension for monthly AR trend analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the invoice is due — used for cash-flow forecasting and aging bucket analysis."
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Calendar month revenue is recognised — aligns AR billings to the income statement under ASC 606 / IFRS 15."
  measures:
    - name: "total_gross_billed"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to franchisees and customers. Top-line revenue billing volume — primary KPI for franchise finance and revenue reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments. Core income statement measure used by CFO and finance leadership."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid AR balance across all open invoices. Primary receivable health KPI — drives collection prioritisation and credit risk decisions."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices. Used by tax teams to reconcile output VAT / sales tax obligations."
    - name: "total_discount_granted"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted to franchisees and customers. Measures revenue leakage from discount programmes — monitored by revenue management."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-billing adjustments applied to AR invoices. High adjustment volumes signal billing accuracy issues or dispute activity."
    - name: "ar_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline billing volume measure for AR workload and franchisee activity tracking."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value per AR transaction. Tracks typical billing size — shifts indicate franchisee mix or fee structure changes."
    - name: "outstanding_balance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross billed amount still outstanding. Core AR collection efficiency KPI — high rates signal collection risk or disputes."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross billed amount. Measures revenue dilution from discount programmes — monitored by revenue management and CFO."
    - name: "avg_days_to_due"
      expr: AVG(CAST(DATEDIFF(due_date, invoice_date) AS DOUBLE))
      comment: "Average payment terms length in days (invoice date to due date). Reflects credit terms extended to franchisees — input to DSO benchmarking."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-receivable payment collection metrics covering cash receipts, application rates, unapplied cash, and reversal activity. Used by AR operations, treasury, and CFO to monitor collection performance and cash application quality."
  source: "`restaurants_ecm`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AR payment (e.g. Applied, Unapplied, Reversed, Pending) — primary filter for collection and cash application analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the AR payment (e.g. Franchise Fee, Royalty, Rent) — used to segment collections by revenue stream."
    - name: "payment_method"
      expr: payment_method
      comment: "Collection channel used (e.g. ACH, Wire, Check) — used to analyse collection channel mix and processing costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the AR payment — supports multi-currency collection reporting."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Indicates whether the payment was reversed — used to identify collection quality issues and fraud risk."
    - name: "reversal_reason_code"
      expr: reversal_reason_code
      comment: "Reason code for payment reversal — used to categorise and root-cause collection failures."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Calendar month the payment was received — standard time dimension for monthly cash collection trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Calendar month the payment was posted to the ledger — aligns cash receipts to financial periods."
  measures:
    - name: "total_payment_received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash collected from franchisees and customers. Primary collection KPI — measures revenue realisation and cash inflow performance."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to open AR invoices. Measures cash application efficiency — high applied amounts reduce DSO."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices. Unapplied cash is a balance-sheet risk and operational inefficiency — monitored by AR ops."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts taken by customers at payment. Measures revenue impact of discount programmes from the collection side."
    - name: "total_functional_currency_collected"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total collections expressed in functional currency. Used for entity-level revenue reporting and FX translation reconciliation."
    - name: "ar_payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payment transactions. Baseline collection volume measure for AR operations throughput benchmarking."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed AR payments. High reversal counts signal collection quality issues, NSF cheques, or fraud — triggers investigation."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of collected cash successfully applied to invoices. Core AR operations efficiency KPI — low rates increase DSO and balance-sheet risk."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AR payments that were reversed. Measures collection quality and payment reliability — high rates indicate systemic collection issues."
    - name: "avg_days_to_receipt"
      expr: AVG(CAST(DATEDIFF(receipt_date, posting_date) AS DOUBLE))
      comment: "Average days between posting date and receipt date. Proxy for collection lag — used in DSO analysis and cash-flow forecasting."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and allocation metrics covering approved budget amounts, baseline comparisons, and budget programme health across the restaurant network. Used by FP&A, CFO, and business unit leaders for annual planning, reforecasting, and variance governance."
  source: "`restaurants_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g. Operating, Capital, Marketing) — primary segmentation for budget analysis by financial category."
    - name: "budget_category"
      expr: budget_category
      comment: "High-level budget category (e.g. Revenue, COGS, Labor, G&A) — used to analyse budget allocation across P&L lines."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the budget (e.g. Draft, Approved, Locked) — used to filter active vs. in-progress budgets."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the budgeted unit (e.g. Franchise, Company-Owned) — enables budget analysis by operating model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts — supports multi-currency budget consolidation."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the budget — enables regional budget allocation and performance analysis."
    - name: "version_code"
      expr: version_code
      comment: "Budget version identifier (e.g. v1, Revised, Final) — used to compare budget iterations and track reforecast changes."
    - name: "nro_flag"
      expr: CAST(nro_flag AS STRING)
      comment: "Indicates whether the budget is for a new restaurant opening (NRO) — used to isolate NRO capital and pre-opening cost budgets."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget period begins — used for time-series budget planning analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the budget was approved — used to track budget approval cycle timeliness."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total approved budget amount. Primary FP&A KPI — represents total financial commitment authorised for the period across all categories."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline budget amount (prior-year or zero-based reference). Used to measure budget growth and reforecast magnitude."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Measures planning coverage breadth — used to ensure all cost centres and units have approved budgets."
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average budget amount per budget record. Used to benchmark typical budget size across units, regions, or categories."
    - name: "budget_vs_baseline_variance"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(baseline_amount AS DOUBLE))
      comment: "Total variance between approved budget and baseline. Measures net budget growth or reduction vs. the reference baseline — key FP&A steering metric."
    - name: "budget_growth_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE) - CAST(baseline_amount AS DOUBLE)) / NULLIF(SUM(CAST(baseline_amount AS DOUBLE)), 0), 2)
      comment: "Percentage growth of approved budget vs. baseline. Measures year-over-year or version-over-version budget expansion — used in board-level planning reviews."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_pct AS DOUBLE))
      comment: "Average variance tolerance threshold set on budgets. Indicates how tightly budgets are governed — lower thresholds signal stricter financial discipline."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-item metrics providing granular planned spend, quantity targets, and variance governance at the GL account and cost centre level. Used by FP&A analysts, controllers, and business unit managers for detailed budget tracking and reforecast management."
  source: "`restaurants_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "High-level budget category of the line item (e.g. Revenue, COGS, Labor) — primary P&L segmentation dimension."
    - name: "budget_subcategory"
      expr: budget_subcategory
      comment: "Sub-category of the budget line (e.g. Food Cost, Crew Labor, Utilities) — enables granular cost analysis within P&L categories."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval status of the budget line (e.g. Draft, Approved, Locked) — used to filter active planning data."
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget line (e.g. Original, Revised Q2) — used to compare planning iterations and track reforecast changes."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate the budget line (e.g. Direct, Proportional, Headcount-Based) — used to audit allocation logic and governance."
    - name: "daypart"
      expr: daypart
      comment: "Daypart associated with the budget line (e.g. Breakfast, Lunch, Dinner) — enables daypart-level budget planning for restaurant operations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line amounts — supports multi-currency budget consolidation."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for the budget line — used for entity-level budget reporting and consolidation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget line becomes effective — used for time-phased budget analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned spend across all budget lines. Primary FP&A measure for detailed cost planning — used in budget reviews and reforecast cycles."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline reference amount for budget lines. Used to compute planned vs. baseline variance at the line-item level."
    - name: "total_quantity_target"
      expr: SUM(CAST(quantity_target AS DOUBLE))
      comment: "Total quantity target across budget lines (e.g. covers, transactions, labour hours). Enables volume-based budget analysis alongside financial amounts."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items. Measures planning granularity and coverage — used to ensure complete budget build-out."
    - name: "planned_vs_baseline_variance"
      expr: SUM(CAST(planned_amount AS DOUBLE) - CAST(baseline_amount AS DOUBLE))
      comment: "Total variance between planned and baseline amounts at the line level. Identifies where budget growth or cuts are concentrated — key FP&A drill-down metric."
    - name: "avg_planned_amount_per_line"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned amount per budget line. Used to benchmark line-item sizing and identify outlier allocations."
    - name: "avg_variance_threshold_amount"
      expr: AVG(CAST(variance_threshold_amount AS DOUBLE))
      comment: "Average absolute variance tolerance set on budget lines. Reflects financial governance tightness — used by controllers to calibrate budget monitoring alerts."
    - name: "avg_budget_percentage_target"
      expr: AVG(CAST(budget_percentage_target AS DOUBLE))
      comment: "Average percentage-of-revenue or percentage-of-total target set on budget lines. Used to monitor cost ratio targets (e.g. food cost %, labor %) against plan."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset lifecycle and depreciation metrics covering capital investment, accumulated depreciation, net book value, impairment, and asset utilisation across the restaurant estate. Used by CFO, controllers, and real estate teams for capex governance and balance-sheet management."
  source: "`restaurants_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "High-level asset classification (e.g. Equipment, Leasehold Improvements, Furniture) — primary dimension for capex and depreciation analysis."
    - name: "asset_subclass"
      expr: asset_subclass
      comment: "Detailed asset sub-classification — enables granular asset portfolio analysis within each asset class."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the asset (e.g. Active, Disposed, Impaired, Under Construction) — used to filter the active asset base."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. Straight-Line, Declining Balance) — used to analyse depreciation policy consistency and P&L impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset amounts — supports multi-currency asset reporting."
    - name: "impairment_indicator"
      expr: CAST(impairment_indicator AS STRING)
      comment: "Indicates whether the asset has been impaired — used to identify and quantify impaired assets on the balance sheet."
    - name: "lease_indicator"
      expr: CAST(lease_indicator AS STRING)
      comment: "Indicates whether the asset is a right-of-use lease asset — used to segregate owned vs. leased assets for IFRS 16 / ASC 842 reporting."
    - name: "acquisition_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year the asset was acquired — used for capex vintage analysis and asset age distribution reporting."
    - name: "disposal_year"
      expr: DATE_TRUNC('YEAR', disposal_date)
      comment: "Year the asset was disposed — used for asset retirement trend analysis and disposal proceeds reporting."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Primary capex investment measure — used by CFO and board to track capital deployment across the restaurant estate."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets. Measures the consumed economic value of the asset base — key balance-sheet and P&L input."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (NBV) of fixed assets. Represents the remaining balance-sheet value of the capital base — primary asset health KPI."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognised on fixed assets. High impairment signals underperforming locations or obsolete equipment — triggers strategic review."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Used to calculate gain/loss on disposal and measure asset monetisation efficiency."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of fixed assets. Used in depreciation base calculations and end-of-life asset planning."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed asset records. Baseline measure for asset portfolio size — used in asset density and capex-per-unit benchmarking."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets with recognised impairment. Measures impairment prevalence — high counts signal location performance issues or technology obsolescence."
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost. Measures average asset age/consumption — high rates indicate an ageing asset base requiring reinvestment."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life assigned to fixed assets in years. Used to benchmark depreciation policy and assess asset longevity assumptions."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Used to benchmark asset value density and identify over/under-invested asset categories."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, reversal activity, intercompany transactions, and workflow health. Used by controllers, internal audit, and CFO to monitor close quality, detect anomalies, and govern the financial reporting process."
  source: "`restaurants_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g. SA, KR, DR) — primary classification for GL posting analysis."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Approval workflow status of the journal entry — used to identify entries pending approval and close bottlenecks."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Indicates whether the journal entry is a reversal — used to segregate original postings from reversals in volume and amount analysis."
    - name: "intercompany_indicator"
      expr: CAST(intercompany_indicator AS STRING)
      comment: "Indicates whether the journal entry is an intercompany transaction — used for intercompany elimination and consolidation analysis."
    - name: "adjustment_period_indicator"
      expr: CAST(adjustment_period_indicator AS STRING)
      comment: "Indicates whether the entry was posted in an adjustment period — used to monitor period-end adjustment activity and audit risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry — supports multi-currency GL analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the journal entry (e.g. POS, ERP, Payroll) — used to trace postings back to operational systems."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Calendar month of the GL posting date — standard time dimension for monthly close volume and trend analysis."
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Calendar month the journal entry was created — used to measure entry-to-posting lag and close timeliness."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline GL activity measure — used to benchmark close workload, detect volume anomalies, and audit posting frequency."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal counts signal posting errors or period-end corrections — key close quality indicator."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used to monitor intercompany transaction volumes for consolidation and elimination completeness."
    - name: "adjustment_period_entry_count"
      expr: COUNT(CASE WHEN adjustment_period_indicator = TRUE THEN 1 END)
      comment: "Number of entries posted in adjustment periods. Elevated counts may indicate late adjustments or audit risk — monitored by controllers and internal audit."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. Core close quality KPI — high rates indicate systemic posting errors or accrual management issues."
    - name: "avg_days_entry_to_posting"
      expr: AVG(CAST(DATEDIFF(posting_date, entry_date) AS DOUBLE))
      comment: "Average days from journal entry creation to GL posting. Measures close process efficiency — high lag indicates approval bottlenecks or workflow delays."
    - name: "avg_days_entry_to_approval"
      expr: AVG(CAST(DATEDIFF(approval_timestamp, posting_timestamp) AS DOUBLE))
      comment: "Average days between posting and approval timestamps. Measures approval cycle speed — used to identify workflow bottlenecks in the financial close."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL journal entry line-item metrics covering debit/credit amounts, tax postings, and line-level reversal activity. Used by controllers, accountants, and auditors for detailed ledger analysis, account reconciliation, and financial statement preparation."
  source: "`restaurants_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Indicates whether the line is a debit (D) or credit (C) posting — fundamental GL dimension for balance verification and account analysis."
    - name: "document_currency_code"
      expr: document_currency_code
      comment: "Currency of the journal entry line document — supports multi-currency ledger analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency of the posting entity — used for entity-level financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry line — used to align GL postings to the financial reporting calendar."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry line — used for annual financial statement analysis and year-over-year comparisons."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Indicates whether the line is part of a reversal entry — used to segregate original postings from reversals in amount analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the journal entry line — used for tax reporting and VAT reconciliation."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Calendar month of the line posting date — standard time dimension for monthly GL trend analysis."
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Calendar month the line was entered — used to measure entry-to-posting lag at the line level."
  measures:
    - name: "total_document_currency_amount"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total GL posting amount in document currency. Core ledger balance measure — used for account reconciliation and financial statement preparation."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total GL posting amount in local functional currency. Used for entity-level financial reporting and currency translation reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted at the journal entry line level. Used by tax teams for VAT/GST reconciliation and tax return preparation."
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines. Measures GL posting granularity and close workload — used to benchmark accounting complexity."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entry lines. Used to quantify reversal activity at the line level — high counts indicate close quality issues."
    - name: "avg_line_document_amount"
      expr: AVG(CAST(amount_document_currency AS DOUBLE))
      comment: "Average document currency amount per journal entry line. Used to benchmark typical posting size and detect outlier transactions."
    - name: "reversal_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entry lines that are reversals. Measures close quality at the line level — high rates signal systemic posting errors."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics covering batch disbursement volumes, processing efficiency, error rates, and settlement performance. Used by treasury, AP operations, and CFO to govern automated payment processing and cash disbursement quality."
  source: "`restaurants_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g. Completed, Failed, Pending, Reversed) — primary filter for run health and exception analysis."
    - name: "payment_run_type"
      expr: payment_run_type
      comment: "Type of payment run (e.g. Vendor, Intercompany, Payroll) — used to segment disbursement volumes by run category."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (e.g. ACH, Wire, Check) — used to analyse payment channel mix and processing costs."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment run was executed — used to monitor channel utilisation and optimise payment routing."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the payment run — used to identify runs pending authorisation and governance compliance."
    - name: "is_automated"
      expr: CAST(is_automated AS STRING)
      comment: "Indicates whether the payment run was automated or manual — used to track automation adoption and reduce manual processing risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment run — supports multi-currency disbursement analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the payment run — enables regional cash disbursement analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Calendar month the payment run was scheduled — used for monthly disbursement planning and trend analysis."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Calendar month the payment run settled — used for cash-position and bank reconciliation reporting."
  measures:
    - name: "total_gross_disbursed"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount disbursed across all payment runs. Primary treasury KPI for monitoring total outgoing cash flow from batch payment processing."
    - name: "total_net_disbursed"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount disbursed after discounts. Represents actual cash outflow from payment runs — used for bank reconciliation and cash-position management."
    - name: "total_tax_disbursed"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount included in payment runs. Used by tax teams to reconcile tax payments and withholding obligations."
    - name: "total_discount_applied"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discounts applied across payment runs. Measures working-capital savings from early-payment discount programmes at the run level."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed. Baseline operational measure for AP processing throughput and run frequency benchmarking."
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total number of individual payment transactions across all runs. Measures AP processing volume — used to size operations capacity and automation ROI."
    - name: "total_error_count"
      expr: SUM(CAST(error_count AS BIGINT))
      comment: "Total number of errors encountered across payment runs. High error counts signal systemic processing issues — triggers AP operations investigation."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(error_count AS BIGINT)) / NULLIF(SUM(CAST(transaction_count AS BIGINT)), 0), 2)
      comment: "Percentage of payment transactions that encountered errors. Core payment processing quality KPI — high rates indicate system or data quality issues requiring remediation."
    - name: "avg_transactions_per_run"
      expr: AVG(CAST(transaction_count AS DOUBLE))
      comment: "Average number of transactions per payment run. Used to benchmark run sizing and optimise batch processing frequency."
    - name: "avg_gross_amount_per_run"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross disbursement amount per payment run. Used to monitor run value consistency and detect anomalous high-value runs."
$$;