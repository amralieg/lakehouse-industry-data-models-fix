-- Metric views for domain: finance | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor payment obligations, discount capture efficiency, tax exposure, and payment cycle performance for treasury and procurement leadership."
  source: "`vibe_retail_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. open, paid, disputed, blocked) for aging and workflow analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. standard, credit memo, recurring) to segment payables by type."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency payables exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, wire, check) to analyze payment channel mix."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Vendor payment terms code (e.g. Net30, 2/10Net30) for discount capture and cash flow planning."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "PO/GR/invoice three-way match result to identify exceptions requiring manual intervention."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period payables trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly payables reporting."
    - name: "is_edi_received"
      expr: is_edi_received
      comment: "Flag indicating whether the invoice was received electronically, supporting automation rate tracking."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for trend analysis of payables volume."
    - name: "due_date"
      expr: DATE_TRUNC('month', due_date)
      comment: "Payment due date truncated to month for cash outflow forecasting."
  measures:
    - name: "total_gross_payables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of AP invoices — primary measure of vendor payment obligations outstanding."
    - name: "total_net_payables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts, representing actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices for tax liability reporting and compliance."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured — measures treasury efficiency in leveraging vendor terms."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts raised against vendors — signals vendor compliance and dispute volume."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per AP invoice — baseline for vendor spend concentration analysis."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed — measures payables processing volume and workload."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'disputed' THEN 1 END)
      comment: "Number of invoices in disputed status — high values indicate vendor or receiving quality issues."
    - name: "three_way_match_exception_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'matched' THEN 1 END)
      comment: "Number of invoices failing three-way match — drives manual intervention cost and payment delays."
    - name: "edi_invoice_count"
      expr: COUNT(CASE WHEN is_edi_received = TRUE THEN 1 END)
      comment: "Number of invoices received via EDI — measures AP automation adoption rate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics covering revenue billed, collections performance, write-off exposure, and dispute management for finance and credit leadership."
  source: "`vibe_retail_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current AR invoice status (e.g. open, paid, written-off, disputed) for aging and collections segmentation."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (e.g. standard, credit memo) to segment receivables by billing category."
    - name: "billing_category"
      expr: billing_category
      comment: "Business billing category (e.g. product sale, service, subscription) for revenue mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency receivables exposure reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method on the AR invoice for collections channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Customer payment terms for DSO and collections efficiency benchmarking."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute resolution status to track collections friction and resolution cycle time."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "ASC 606 revenue recognition status (e.g. recognized, deferred, pending) for compliance reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period AR trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR aging and collections reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice date truncated to month for billing volume trend analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Collections dunning level reached — indicates severity of overdue status and escalation stage."
  measures:
    - name: "total_gross_receivables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR billed — primary measure of revenue invoiced to customers."
    - name: "total_net_receivables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after cash discounts — actual expected cash inflow."
    - name: "total_open_receivables"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding open AR balance — key liquidity and collections performance indicator."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total cash applied against AR invoices — measures collections effectiveness."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total AR written off as uncollectible — measures credit risk materialization and bad debt expense."
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total cash discounts granted to customers — measures cost of early payment incentives."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on AR invoices for tax liability and compliance reporting."
    - name: "avg_open_receivable_amount"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open AR balance per invoice — baseline for collections prioritization and DSO modeling."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total AR invoices issued — measures billing volume and customer transaction activity."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'resolved' THEN 1 END)
      comment: "Number of AR invoices in active dispute — high values signal customer satisfaction or billing accuracy issues."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN write_off_amount > 0 THEN 1 END)
      comment: "Number of invoices with write-off activity — tracks bad debt incidence rate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budget performance metrics tracking planned vs actual vs forecast spend, variance analysis, and budget utilization across cost centers, profit centers, and organizational units for CFO and FP&A leadership."
  source: "`vibe_retail_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (e.g. capex, opex, headcount, marketing) for spend category analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly budget review and reforecast cycles."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget vs actual reporting."
    - name: "channel"
      expr: channel
      comment: "Business channel (e.g. store, ecommerce, wholesale) for channel-level budget allocation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status to track planning cycle completion and governance compliance."
    - name: "plan_version_type"
      expr: plan_version_type
      comment: "Plan version type (e.g. original budget, reforecast, actuals) for version comparison analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting methodology used (e.g. driver-based, trend, zero-based) for planning quality assessment."
    - name: "is_locked"
      expr: is_locked
      comment: "Whether the budget version is locked from further edits — tracks planning cycle closure."
    - name: "is_reforecast"
      expr: is_reforecast
      comment: "Flag indicating this is a reforecast version rather than original budget."
    - name: "plan_start_date"
      expr: DATE_TRUNC('month', plan_start_date)
      comment: "Budget plan start date truncated to month for planning horizon analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount — primary baseline for all budget vs actual variance analysis."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend recorded against budget — measures execution against plan."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast amount for the period — forward-looking view of expected spend vs plan."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (encumbered) spend — measures obligations not yet invoiced but contractually committed."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus plan) — primary FP&A metric for budget performance management."
    - name: "total_revenue_projection"
      expr: SUM(CAST(revenue_projection AS DOUBLE))
      comment: "Total projected revenue in the budget — key input for P&L planning and investor guidance."
    - name: "total_cogs_projection"
      expr: SUM(CAST(cogs_projection AS DOUBLE))
      comment: "Total projected cost of goods sold — drives gross margin planning and merchandising targets."
    - name: "total_gross_margin_projection"
      expr: SUM(CAST(gross_margin_projection AS DOUBLE))
      comment: "Total projected gross margin — primary profitability planning metric for executive review."
    - name: "total_ebitda_projection"
      expr: SUM(CAST(ebitda_projection AS DOUBLE))
      comment: "Total projected EBITDA — key metric for investor reporting and operational efficiency benchmarking."
    - name: "total_otb_amount"
      expr: SUM(CAST(otb_amount AS DOUBLE))
      comment: "Total open-to-buy budget — critical merchandising constraint for inventory investment planning."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average budget variance percentage across budget lines — measures overall planning accuracy."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines — measures planning granularity and FP&A workload."
    - name: "over_budget_line_count"
      expr: COUNT(CASE WHEN variance_amount > 0 THEN 1 END)
      comment: "Number of budget lines where actuals exceed plan — identifies overspend hotspots requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volume, document amounts, reversal activity, and accrual patterns for controller and accounting operations leadership."
  source: "`vibe_retail_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. SA, AB, KR) classifying the nature of the accounting entry."
    - name: "entry_type"
      expr: entry_type
      comment: "Entry type (e.g. manual, automated, accrual, reversal) for automation rate and manual entry risk analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status (e.g. posted, parked, held) for close cycle monitoring."
    - name: "source_module"
      expr: source_module
      comment: "Source system or module that generated the journal entry for subledger reconciliation analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period journal entry volume and amount analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close activity monitoring."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for balance verification and entry composition analysis."
    - name: "accrual_indicator"
      expr: accrual_indicator
      comment: "Flag indicating accrual entries — tracks accrual volume as a proportion of total postings."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversal entries — high reversal rates signal posting quality issues."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag for intercompany journal entries — used for elimination and consolidation analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for close cycle volume and timing analysis."
  measures:
    - name: "total_document_amount"
      expr: SUM(CAST(document_amount AS DOUBLE))
      comment: "Total document currency amount across all journal entries — measures total GL posting volume."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total local currency amount posted — primary measure for entity-level P&L and balance sheet impact."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries — supports tax provision and compliance reporting."
    - name: "avg_document_amount"
      expr: AVG(CAST(document_amount AS DOUBLE))
      comment: "Average journal entry document amount — baseline for anomaly detection and materiality assessment."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted — measures accounting operations volume and close cycle workload."
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN entry_type = 'manual' THEN 1 END)
      comment: "Number of manually created journal entries — high manual entry rates increase audit risk and error exposure."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries — tracks posting correction activity and accounting quality."
    - name: "accrual_entry_count"
      expr: COUNT(CASE WHEN accrual_indicator = TRUE THEN 1 END)
      comment: "Number of accrual journal entries — measures period-end accrual workload and estimation activity."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries — drives consolidation elimination workload and intercompany reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL journal entry line-level metrics for detailed ledger analysis, subledger reconciliation, and audit trail review by accounting operations and internal audit."
  source: "`vibe_retail_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "GL account type (e.g. asset, liability, revenue, expense) for financial statement line analysis."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the parent journal entry for line-level classification."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator at the line level for balance verification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period line-level GL analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly subledger reconciliation."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied at the line level for tax reporting and jurisdiction analysis."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating this line has been reversed — tracks correction activity at line level."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for close cycle line volume analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-bearing line items (e.g. inventory postings)."
  measures:
    - name: "total_amount_local_currency"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total local currency amount across all journal entry lines — primary measure for entity-level ledger balance."
    - name: "total_amount_doc_currency"
      expr: SUM(CAST(amount_doc_currency AS DOUBLE))
      comment: "Total document currency amount — used for transaction-currency reporting and FX analysis."
    - name: "total_amount_group_currency"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total group currency amount — used for consolidated group reporting and intercompany elimination."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line level — supports detailed tax provision and jurisdiction-level tax reporting."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity posted on quantity-bearing lines — supports inventory and goods movement reconciliation."
    - name: "avg_amount_local_currency"
      expr: AVG(CAST(amount_local_currency AS DOUBLE))
      comment: "Average local currency amount per journal line — baseline for materiality and anomaly detection."
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines — measures GL posting granularity and close cycle workload."
    - name: "reversed_line_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of reversed journal lines — tracks posting correction volume and accounting quality."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking asset base value, accumulated depreciation, net book value, impairment exposure, and asset lifecycle for CFO, controller, and capital planning leadership."
  source: "`vibe_retail_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (e.g. buildings, equipment, vehicles, IT) for capital allocation and depreciation analysis by category."
    - name: "asset_status"
      expr: asset_status
      comment: "Current asset lifecycle status (e.g. active, retired, disposed, under construction) for asset base management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. straight-line, declining balance) for accounting policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Asset currency for multi-currency fixed asset reporting."
    - name: "impairment_indicator_flag"
      expr: impairment_indicator_flag
      comment: "Flag indicating assets with impairment indicators — critical for financial statement accuracy and audit."
    - name: "acquisition_date"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Asset acquisition date truncated to year for capital vintage analysis."
    - name: "capitalization_date"
      expr: DATE_TRUNC('year', capitalization_date)
      comment: "Capitalization date truncated to year for depreciation start cohort analysis."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (e.g. book, tax, IFRS) for multi-GAAP asset reporting."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets — primary measure of capital investment in the asset base."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset base aging and remaining useful life consumption."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — key balance sheet metric for asset base reporting."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of assets — impacts depreciation base and disposal gain/loss projections."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized — measures asset write-down exposure and P&L impact."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures capital recovery from asset retirement activity."
    - name: "total_last_depreciation_amount"
      expr: SUM(CAST(last_depreciation_amount AS DOUBLE))
      comment: "Total depreciation charged in the most recent depreciation run — current period depreciation expense."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years — informs capital planning and replacement cycle forecasting."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — baseline for asset utilization and replacement prioritization."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in the register — measures asset base size and management scope."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator_flag = TRUE THEN 1 END)
      comment: "Number of assets with impairment indicators — drives impairment testing workload and financial risk assessment."
    - name: "retired_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'retired' THEN 1 END)
      comment: "Number of retired assets — tracks asset lifecycle turnover and capital replacement activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_lease_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease contract metrics for ASC 842/IFRS 16 compliance, tracking right-of-use asset values, lease liability balances, rent obligations, and lease portfolio composition for real estate and finance leadership."
  source: "`vibe_retail_v1`.`finance`.`lease_contract`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Lease classification (e.g. operating, finance) under ASC 842/IFRS 16 for balance sheet and P&L treatment."
    - name: "lease_status"
      expr: lease_status
      comment: "Current lease lifecycle status (e.g. active, expired, terminated, modified) for portfolio management."
    - name: "leased_asset_category"
      expr: leased_asset_category
      comment: "Category of leased asset (e.g. retail store, warehouse, equipment, vehicle) for portfolio segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Lease currency for multi-currency lease portfolio reporting."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Lease payment frequency (e.g. monthly, quarterly, annual) for cash flow planning."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the lease has a renewal option — impacts lease term determination and liability measurement."
    - name: "purchase_option_flag"
      expr: purchase_option_flag
      comment: "Whether the lease includes a purchase option — affects lease classification and asset recognition."
    - name: "short_term_lease_flag"
      expr: short_term_lease_flag
      comment: "Short-term lease exemption flag (term ≤12 months) — these leases are expensed rather than capitalized."
    - name: "low_value_asset_flag"
      expr: low_value_asset_flag
      comment: "Low-value asset exemption flag — these leases are expensed rather than capitalized under IFRS 16."
    - name: "commencement_date"
      expr: DATE_TRUNC('year', commencement_date)
      comment: "Lease commencement date truncated to year for vintage analysis of the lease portfolio."
  measures:
    - name: "total_lease_liability_balance"
      expr: SUM(CAST(lease_liability_balance AS DOUBLE))
      comment: "Total current lease liability balance — primary balance sheet metric for ASC 842/IFRS 16 compliance reporting."
    - name: "total_lease_liability_initial"
      expr: SUM(CAST(lease_liability_initial AS DOUBLE))
      comment: "Total initial lease liability recognized at commencement — measures new lease obligation additions."
    - name: "total_rou_asset_carrying_value"
      expr: SUM(CAST(rou_asset_carrying_value AS DOUBLE))
      comment: "Total right-of-use asset carrying value — key balance sheet asset metric for lease accounting compliance."
    - name: "total_rou_asset_initial_value"
      expr: SUM(CAST(rou_asset_initial_value AS DOUBLE))
      comment: "Total initial ROU asset value recognized — measures gross lease asset additions to the balance sheet."
    - name: "total_monthly_base_rent"
      expr: SUM(CAST(base_rent_monthly AS DOUBLE))
      comment: "Total monthly base rent obligation across all active leases — primary cash flow planning metric for real estate."
    - name: "total_lease_incentive_amount"
      expr: SUM(CAST(lease_incentive_amount AS DOUBLE))
      comment: "Total lease incentives received (e.g. tenant improvement allowances) — reduces effective lease cost."
    - name: "total_initial_direct_cost"
      expr: SUM(CAST(initial_direct_cost AS DOUBLE))
      comment: "Total initial direct costs capitalized on leases — measures transaction cost burden of the lease portfolio."
    - name: "avg_weighted_remaining_term"
      expr: AVG(CAST(weighted_avg_remaining_term AS DOUBLE))
      comment: "Average weighted remaining lease term in months — key disclosure metric for ASC 842/IFRS 16 footnotes."
    - name: "avg_incremental_borrowing_rate"
      expr: AVG(CAST(incremental_borrowing_rate AS DOUBLE))
      comment: "Average incremental borrowing rate used for lease discounting — reflects cost of capital for lease obligations."
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Total number of lease contracts in the portfolio — measures real estate and equipment lease footprint."
    - name: "active_lease_count"
      expr: COUNT(CASE WHEN lease_status = 'active' THEN 1 END)
      comment: "Number of currently active leases — measures the live lease portfolio size for compliance and planning."
    - name: "renewal_option_lease_count"
      expr: COUNT(CASE WHEN renewal_option_flag = TRUE THEN 1 END)
      comment: "Number of leases with renewal options — informs real estate strategy and long-term occupancy planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics for ASC 606 compliance, tracking recognized revenue, deferred revenue balances, gross margin, and recognition timing by channel and category for CFO and technical accounting leadership."
  source: "`vibe_retail_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current revenue recognition status (e.g. recognized, deferred, pending, reversed) for compliance monitoring."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (e.g. point-in-time, over-time) per ASC 606 performance obligation analysis."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category (e.g. product, service, gift card breakage, loyalty) for disaggregated revenue disclosure."
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g. store, ecommerce, wholesale) for channel-level revenue recognition analysis."
    - name: "asc606_step"
      expr: asc606_step
      comment: "ASC 606 five-step model step at which the event was triggered for compliance audit trail."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue recognition reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue recognition trend and disclosure analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating a reversal event — tracks revenue correction activity and restatement risk."
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Flag indicating a contract modification event — impacts transaction price reallocation under ASC 606."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for monthly revenue recognition trend analysis."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period — primary top-line metric for P&L and investor reporting."
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price allocated across performance obligations — measures gross contract value."
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to specific performance obligations — ASC 606 Step 4 compliance metric."
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance — key balance sheet liability metric for subscription and gift card programs."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue — drives gross margin calculation."
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin on recognized revenue — primary profitability metric for executive P&L review."
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration (e.g. rebates, returns, discounts) included in transaction price — measures revenue estimation uncertainty."
    - name: "total_loyalty_point_fair_value"
      expr: SUM(CAST(loyalty_point_fair_value AS DOUBLE))
      comment: "Total fair value of loyalty points issued as separate performance obligations — measures loyalty program revenue deferral."
    - name: "total_gift_card_breakage"
      expr: SUM(CAST(gift_card_breakage_rate AS DOUBLE))
      comment: "Total gift card breakage rate applied — measures unredeemed gift card revenue recognized as breakage income."
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events — measures recognition activity volume and ASC 606 processing workload."
    - name: "reversal_event_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of revenue reversal events — tracks revenue correction activity and potential restatement exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking tax liability by jurisdiction, tax type, and direction for tax compliance, provision accuracy, and regulatory filing support for the tax and finance leadership."
  source: "`vibe_retail_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Tax type (e.g. sales tax, VAT, use tax, withholding) for tax liability segmentation by obligation type."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Tax direction (input/output) for VAT/GST net position calculation and filing."
    - name: "tax_jurisdiction_country"
      expr: tax_jurisdiction_country
      comment: "Country of tax jurisdiction for cross-border tax exposure and compliance reporting."
    - name: "tax_jurisdiction_state"
      expr: tax_jurisdiction_state
      comment: "State/province of tax jurisdiction for state-level tax liability and nexus analysis."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Full tax jurisdiction code for granular tax authority reporting and remittance."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the posting for tax rate and treatment analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt transactions — tracks exempt sale volume and exemption certificate compliance."
    - name: "nexus_indicator"
      expr: nexus_indicator
      comment: "Flag indicating economic or physical nexus in the jurisdiction — critical for sales tax compliance."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating a tax posting reversal — tracks correction activity and amended filing needs."
    - name: "document_type"
      expr: document_type
      comment: "Source document type generating the tax posting (e.g. invoice, credit memo) for audit trail analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for monthly tax accrual and remittance analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted — primary metric for tax liability reporting and remittance obligation tracking."
    - name: "total_tax_amount_local_currency"
      expr: SUM(CAST(tax_amount_local_currency AS DOUBLE))
      comment: "Total tax amount in local currency — used for entity-level tax provision and local statutory reporting."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — measures the revenue base subject to tax for effective rate analysis."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average effective tax rate across postings — measures blended tax burden and jurisdiction mix."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings — measures tax transaction volume and compliance processing workload."
    - name: "exempt_transaction_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END)
      comment: "Number of tax-exempt transactions — tracks exempt sale volume requiring exemption certificate management."
    - name: "nexus_jurisdiction_count"
      expr: COUNT(DISTINCT tax_jurisdiction_code)
      comment: "Number of distinct tax jurisdictions with nexus — measures compliance footprint and filing obligation scope."
    - name: "reversal_posting_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed tax postings — tracks tax correction activity and amended return exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics tracking payment volume, success rates, total disbursements, and processing efficiency for treasury and accounts payable operations leadership."
  source: "`vibe_retail_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Current status of the payment run (e.g. completed, failed, in-progress, reversed) for execution monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Payment run type (e.g. regular, emergency, reversal) for payment cycle analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used in the run (e.g. ACH, wire, check) for payment channel mix analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel (e.g. domestic, international, intercompany) for treasury routing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency disbursement reporting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating a recurring payment run — tracks automated vs ad-hoc payment execution."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment run — tracks cash reconciliation completion."
    - name: "scheduled_date"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Scheduled payment date truncated to month for cash outflow forecasting."
    - name: "gl_posting_date"
      expr: DATE_TRUNC('month', gl_posting_date)
      comment: "GL posting date truncated to month for period-level disbursement reporting."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total amount disbursed across all payment runs — primary treasury metric for cash outflow management."
    - name: "avg_payment_run_amount"
      expr: AVG(CAST(total_payment_amount AS DOUBLE))
      comment: "Average total amount per payment run — baseline for payment run sizing and treasury planning."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed — measures AP payment processing volume and frequency."
    - name: "completed_run_count"
      expr: COUNT(CASE WHEN payment_run_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed payment runs — measures payment execution reliability."
    - name: "failed_run_count"
      expr: COUNT(CASE WHEN payment_run_status = 'failed' THEN 1 END)
      comment: "Number of failed payment runs — high failure rates indicate system or data quality issues requiring escalation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transaction volumes, netting positions, elimination status, and reconciliation quality for group consolidation and transfer pricing compliance."
  source: "`vibe_retail_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Intercompany transaction type (e.g. loan, service charge, goods transfer) for elimination and disclosure analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current transaction status (e.g. open, settled, eliminated, disputed) for consolidation readiness monitoring."
    - name: "netting_status"
      expr: netting_status
      comment: "Netting status of the transaction — tracks which intercompany balances have been netted for settlement."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Intercompany reconciliation status — unreconciled balances block period close and consolidation."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag indicating the transaction has been eliminated in consolidation — tracks consolidation completeness."
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Company code of the sending entity for intercompany flow analysis."
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Company code of the receiving entity for intercompany flow analysis."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied (e.g. CUP, cost-plus, TNMM) for tax compliance and documentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany balance and elimination analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany reconciliation and close monitoring."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Posting date truncated to month for intercompany transaction volume trend analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount — primary metric for group consolidation elimination and transfer pricing review."
    - name: "total_local_amount_sending"
      expr: SUM(CAST(local_currency_amount_sending AS DOUBLE))
      comment: "Total transaction amount in the sending entity local currency — used for entity-level intercompany reporting."
    - name: "total_local_amount_receiving"
      expr: SUM(CAST(local_currency_amount_receiving AS DOUBLE))
      comment: "Total transaction amount in the receiving entity local currency — used for entity-level intercompany reporting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total intercompany variance amount — unresolved variances block consolidation and indicate reconciliation failures."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to intercompany transactions — monitors FX translation consistency."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions — measures cross-entity activity volume and consolidation workload."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN 1 END)
      comment: "Number of unreconciled intercompany transactions — critical metric for period close readiness and audit risk."
    - name: "eliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END)
      comment: "Number of transactions eliminated in consolidation — measures consolidation completeness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_netting_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany netting run metrics tracking gross-to-net settlement efficiency, netting coverage, and cash flow optimization for treasury and group finance leadership."
  source: "`vibe_retail_v1`.`finance`.`netting_run`"
  dimensions:
    - name: "netting_run_status"
      expr: netting_run_status
      comment: "Current status of the netting run (e.g. completed, failed, reversed) for execution monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Netting run type (e.g. bilateral, multilateral) for settlement structure analysis."
    - name: "netting_method"
      expr: netting_method
      comment: "Netting method applied for settlement efficiency benchmarking."
    - name: "netting_scope"
      expr: netting_scope
      comment: "Scope of the netting run (e.g. domestic, cross-border) for treasury risk and regulatory analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-currency netting analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating a reversed netting run — tracks settlement correction activity."
    - name: "posted_to_gl_flag"
      expr: posted_to_gl_flag
      comment: "Flag indicating the netting run has been posted to GL — tracks accounting completion."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual netting efficiency and cash flow optimization analysis."
    - name: "execution_date"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Netting execution date truncated to month for monthly settlement cycle analysis."
  measures:
    - name: "total_gross_payable"
      expr: SUM(CAST(total_gross_payable_amount AS DOUBLE))
      comment: "Total gross intercompany payable amount before netting — measures pre-netting cash outflow obligation."
    - name: "total_gross_receivable"
      expr: SUM(CAST(total_gross_receivable_amount AS DOUBLE))
      comment: "Total gross intercompany receivable amount before netting — measures pre-netting cash inflow expectation."
    - name: "total_netted_amount"
      expr: SUM(CAST(total_netted_amount AS DOUBLE))
      comment: "Total net settlement amount after netting — measures actual cash movement and netting efficiency."
    - name: "avg_netted_amount"
      expr: AVG(CAST(total_netted_amount AS DOUBLE))
      comment: "Average net settlement amount per netting run — baseline for treasury cash flow planning."
    - name: "netting_run_count"
      expr: COUNT(1)
      comment: "Total number of netting runs executed — measures intercompany settlement processing frequency."
    - name: "completed_run_count"
      expr: COUNT(CASE WHEN netting_run_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed netting runs — measures settlement execution reliability."
    - name: "gl_batch_total"
      expr: SUM(CAST(gl_batch_code AS DOUBLE))
      comment: "Sum of GL batch codes posted — used as a proxy for GL posting volume from netting activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account portfolio metrics tracking cash balances, overdraft exposure, and account utilization for treasury management and liquidity planning."
  source: "`vibe_retail_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current bank account status (e.g. active, closed, dormant) for treasury portfolio management."
    - name: "account_type"
      expr: account_type
      comment: "Bank account type (e.g. checking, savings, money market, concentration) for liquidity structure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Account currency for multi-currency cash position reporting."
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the banking institution for bank relationship concentration analysis."
    - name: "branch_country_code"
      expr: branch_country_code
      comment: "Country of the bank branch for geographic cash distribution analysis."
    - name: "ach_enabled"
      expr: ach_enabled
      comment: "Flag indicating ACH payment capability — measures electronic payment infrastructure coverage."
    - name: "wire_transfer_enabled"
      expr: wire_transfer_enabled
      comment: "Flag indicating wire transfer capability — measures high-value payment infrastructure coverage."
    - name: "account_opened_date"
      expr: DATE_TRUNC('year', account_opened_date)
      comment: "Account opening date truncated to year for bank relationship vintage analysis."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current cash balance across all bank accounts — primary treasury liquidity metric."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available (cleared) cash balance — measures immediately deployable liquidity."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across accounts — baseline for period cash flow reconciliation."
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Total overdraft facility available — measures contingency liquidity buffer from banking relationships."
    - name: "total_minimum_balance_required"
      expr: SUM(CAST(minimum_balance_required AS DOUBLE))
      comment: "Total minimum balance requirements across accounts — measures trapped cash and liquidity constraints."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per bank account — baseline for cash concentration and pooling analysis."
    - name: "bank_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts — measures treasury banking relationship complexity and rationalization opportunity."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'active' THEN 1 END)
      comment: "Number of active bank accounts — measures live treasury infrastructure footprint."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking ASC 606 compliance, performance obligation satisfaction, and deferred revenue management"
  source: "`vibe_retail_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Category of revenue"
    - name: "asc606_step"
      expr: asc606_step
      comment: "ASC 606 five-step model step"
    - name: "channel"
      expr: channel
      comment: "Sales channel"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of recognition"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of recognition"
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Whether the contract was modified"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the recognition was reversed"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month of revenue recognition start"
  measures:
    - name: "total_recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price of contracts"
    - name: "total_allocated_transaction_price"
      expr: SUM(CAST(allocated_transaction_price AS DOUBLE))
      comment: "Total allocated transaction price to performance obligations"
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance"
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin"
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration amount"
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Total standalone selling price"
    - name: "total_loyalty_points_redeemed"
      expr: SUM(CAST(loyalty_points_redeemed AS DOUBLE))
      comment: "Total loyalty points redeemed"
    - name: "avg_gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(recognized_amount AS DOUBLE)), 0), 2)
      comment: "Average gross margin percentage"
    - name: "revenue_recognition_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_transaction_price AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated transaction price recognized"
    - name: "deferred_revenue_ratio"
      expr: ROUND(SUM(CAST(deferred_revenue_balance AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Ratio of deferred revenue to total transaction price"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with revenue recognition events"
    - name: "contract_modification_count"
      expr: COUNT(CASE WHEN contract_modification_flag = TRUE THEN 1 END)
      comment: "Number of contracts with modifications"
$$;