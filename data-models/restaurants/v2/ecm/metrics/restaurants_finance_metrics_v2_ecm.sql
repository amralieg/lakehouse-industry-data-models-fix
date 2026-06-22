-- Metric views for domain: finance | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor spend, discount capture, tax liability, and payment cycle performance across the restaurant enterprise."
  source: "`vibe_restaurants_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. Open, Approved, Paid, Disputed)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. Standard, Credit Memo, Recurring)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which the invoice was posted, used for year-over-year spend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the invoice for period-level spend trending."
    - name: "company_code"
      expr: company_code
      comment: "Company code identifying the legal entity responsible for the invoice."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency spend analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "PO/GR/Invoice three-way match result — key control indicator for procurement compliance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the invoice, used to identify bottlenecks in the AP process."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of vendor billing activity."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due, used for cash flow forecasting and aging analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices — primary measure of vendor spend volume."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts, representing actual payable obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across AP invoices — used for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or negotiated discounts captured — measures procurement savings performance."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments — required for tax compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices — baseline volume metric for AP workload and vendor activity."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount — used to detect anomalies and benchmark vendor billing patterns."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross spend captured as discounts — measures effectiveness of early-payment discount programs."
    - name: "tax_rate_effective_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate on AP invoices — used to validate tax coding accuracy and monitor tax exposure."
    - name: "local_currency_total_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total invoice amount in local functional currency — used for FX exposure and currency risk analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics covering payment volumes, discount utilization, withholding tax, and settlement efficiency."
  source: "`vibe_restaurants_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment — identifies unreconciled items requiring investigation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual cash outflow reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for monthly cash management analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code of the paying entity for legal entity-level cash reporting."
    - name: "document_currency"
      expr: document_currency
      comment: "Currency in which the payment was executed for FX analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment execution for cash outflow trend analysis."
    - name: "clearing_date_month"
      expr: DATE_TRUNC('MONTH', clearing_date)
      comment: "Month the payment was cleared in the bank for reconciliation timing analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed to vendors — primary measure of AP cash outflow."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts captured at payment time — measures realized savings from payment terms optimization."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted at payment — required for tax compliance and vendor remittance reporting."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local functional currency — used for FX gain/loss analysis."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments executed — baseline volume metric for payment run efficiency."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction — used to benchmark payment batch sizes and detect outliers."
    - name: "discount_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_taken_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Discount captured as a percentage of total payments — measures the financial benefit of early payment programs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics for franchise royalties, catering billings, and other revenue streams — tracking outstanding balances, aging, and collection performance."
  source: "`vibe_restaurants_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (Open, Partially Paid, Paid, Written Off) for aging and collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (Royalty, Franchise Fee, Catering, etc.) for revenue stream segmentation."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity issuing the invoice for entity-level revenue reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency revenue analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level — identifies overdue invoices requiring collection action."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for revenue trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due for cash flow forecasting."
  measures:
    - name: "total_gross_ar_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR billed — primary measure of revenue billed to franchisees and customers."
    - name: "total_net_ar_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR after discounts — represents actual revenue recognized."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid AR balance — critical metric for cash flow management and collection prioritization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on AR invoices — used for tax liability and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices — measures revenue leakage from billing adjustments."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to AR invoices — used to track billing corrections and credit notes."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued — baseline volume metric for billing activity."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net AR invoice amount — used to benchmark billing patterns and detect anomalies."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(net_amount AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed AR that has been collected — primary KPI for AR collection effectiveness."
    - name: "outstanding_balance_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Outstanding balance as a percentage of gross billed — measures overall AR aging risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable payment receipt metrics tracking cash collections, unapplied cash, and payment processing efficiency."
  source: "`vibe_restaurants_v1`.`finance`.`ar_payment`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment receipt for annual cash collection reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for monthly cash collection trend analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity receiving the payment for entity-level cash reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the payment was reversed — used to identify payment processing errors."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of payment receipt for cash collection trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the payment was posted to the ledger for period-level cash reporting."
  measures:
    - name: "total_payment_received"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash received from customers and franchisees — primary measure of AR cash collection."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to open AR invoices — measures how effectively receipts are being matched to invoices."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet applied to invoices — identifies cash application backlog requiring resolution."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total discounts taken by customers at payment — measures revenue impact of payment term discounts."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receipts in functional currency — used for FX gain/loss analysis on foreign currency collections."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payments received — baseline volume metric for cash application workload."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash that remains unapplied — key operational KPI for AR cash application efficiency."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed AR payments — used to monitor payment processing quality and fraud risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volumes, reversal rates, intercompany activity, and period-close quality."
  source: "`vibe_restaurants_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. SA=G/L Account, AA=Asset Posting) for transaction classification."
    - name: "company_code"
      expr: company_code
      comment: "Company code of the posting entity for legal entity-level GL analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual GL activity reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close quality and volume analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag identifying intercompany journal entries — used for elimination and reconciliation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the entry was reversed — used to measure posting error rates."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Approval workflow status of the journal entry — identifies entries pending approval at period close."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting for period-level activity trend analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the journal entry — used for integration quality monitoring."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted — baseline measure of GL activity volume and close complexity."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries — measures posting error rate and rework in the close process."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that were reversed — key quality KPI for the financial close process."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries — used to monitor intercompany transaction volume for elimination purposes."
    - name: "parked_entry_count"
      expr: COUNT(CASE WHEN parked_indicator = TRUE THEN 1 END)
      comment: "Number of parked (incomplete) journal entries — identifies entries that need completion before period close."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to journal entries — used to monitor currency translation consistency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line-level metrics for GL balance analysis, debit/credit volumes, tax postings, and variance detection at the account level."
  source: "`vibe_restaurants_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code of the GL posting for entity-level balance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the line item for annual balance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly balance trend analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether this line was part of a reversal entry — used for net posting analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for period-level GL balance trending."
    - name: "document_currency_code"
      expr: document_currency_code
      comment: "Currency of the document for multi-currency GL analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency code for entity-level reporting."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line item — used for tax posting analysis and compliance."
  measures:
    - name: "total_document_currency_amount"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total posted amount in document currency — primary measure of GL transaction volume."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total posted amount in local functional currency — used for entity-level financial reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted on journal entry lines — used for tax provision and compliance reporting."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines — measures GL posting volume and close complexity."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entry lines — used to quantify rework and error correction in the GL."
    - name: "avg_line_amount"
      expr: AVG(CAST(amount_document_currency AS DOUBLE))
      comment: "Average journal entry line amount — used to detect unusual posting patterns and outliers."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and control metrics tracking approved budget amounts, version management, and budget coverage across the restaurant portfolio."
  source: "`vibe_restaurants_v1`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning cycle analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency planning analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (Corporate, Franchise) for budget segmentation by business model."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional budget allocation analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand for brand-level budget planning and performance comparison."
    - name: "nro_flag"
      expr: nro_flag
      comment: "Flag indicating whether the budget is for a new restaurant opening — used for NRO investment tracking."
    - name: "version_code"
      expr: version_code
      comment: "Budget version (Original, Revised, Forecast) for version comparison analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the budget was approved — used to track planning cycle timeliness."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total approved budget amount — primary measure of planned financial commitment across the organization."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline budget amount before revisions — used to measure budget revision magnitude."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records — measures planning coverage and budget granularity."
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average budget amount per budget record — used to benchmark budget sizes across units and cost centers."
    - name: "nro_budget_amount"
      expr: SUM(CASE WHEN nro_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total budget allocated to new restaurant openings — key capital investment planning metric."
    - name: "budget_revision_amount"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(baseline_amount AS DOUBLE))
      comment: "Total net revision to budgets from baseline — measures the magnitude of in-year budget adjustments."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level metrics for granular spend planning, variance threshold management, and GL account-level budget allocation analysis."
  source: "`vibe_restaurants_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line for annual planning analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget distribution analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level budget line reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for multi-currency planning."
    - name: "daypart"
      expr: daypart
      comment: "Daypart (Breakfast, Lunch, Dinner) for time-of-day budget allocation analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based budget lines (e.g. labor hours, covers)."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate the budget line (e.g. headcount, revenue-based) for allocation quality analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines — primary measure of detailed budget commitment."
    - name: "total_baseline_amount"
      expr: SUM(CAST(baseline_amount AS DOUBLE))
      comment: "Total baseline budget line amount before revisions — used to quantify budget changes."
    - name: "total_quantity_target"
      expr: SUM(CAST(quantity_target AS DOUBLE))
      comment: "Total quantity target (e.g. labor hours, transaction counts) across budget lines — used for operational planning."
    - name: "total_variance_threshold_amount"
      expr: SUM(CAST(variance_threshold_amount AS DOUBLE))
      comment: "Total variance threshold amounts set across budget lines — measures the tolerance band for budget monitoring."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines — measures planning granularity and budget detail coverage."
    - name: "avg_planned_amount"
      expr: AVG(CAST(planned_amount AS DOUBLE))
      comment: "Average planned amount per budget line — used to benchmark line-level budget sizes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project metrics tracking investment approvals, spend execution, budget variance, and ROI performance across restaurant development and renovation projects."
  source: "`vibe_restaurants_v1`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capex project (Planning, In Progress, Completed, Cancelled) for portfolio management."
    - name: "project_type"
      expr: project_type
      comment: "Type of capex project (NRO, Remodel, Equipment, Technology) for investment category analysis."
    - name: "capex_category"
      expr: capex_category
      comment: "Capex category for spend classification and budget allocation analysis."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for the capex investment — used for depreciation planning and asset portfolio analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the capex project — identifies projects pending authorization."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level capex reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Project currency for multi-currency capex analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the capex project — used for portfolio risk management and prioritization."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the project was planned to start — used for investment pipeline timing analysis."
    - name: "actual_completion_date_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Month the project was actually completed — used for schedule adherence analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capex budget across all projects — primary measure of authorized capital investment."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capex spend incurred — measures capital deployment against approved budgets."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed but not yet spent capex — used for cash flow forecasting and budget availability analysis."
    - name: "total_capitalized_amount"
      expr: SUM(CAST(capitalized_amount AS DOUBLE))
      comment: "Total amount capitalized to fixed assets — measures the conversion of capex spend into balance sheet assets."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining capex budget available — critical for investment pipeline management and authorization decisions."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs approved) across capex projects — key project control metric."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of capex projects — measures investment portfolio size and development activity."
    - name: "avg_project_budget"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per capex project — used to benchmark investment sizes by project type."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved capex budget actually spent — measures capital deployment efficiency."
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percent AS DOUBLE))
      comment: "Average expected ROI across capex projects — used to prioritize investment decisions and evaluate portfolio returns."
    - name: "avg_payback_period_months"
      expr: AVG(CAST(payback_period_months AS DOUBLE))
      comment: "Average payback period in months across capex projects — key investment efficiency metric for capital allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_asset_depreciation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset depreciation metrics tracking depreciation charges, accumulated depreciation, net book values, and impairment across the restaurant asset portfolio."
  source: "`vibe_restaurants_v1`.`finance`.`asset_depreciation`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (Equipment, Leasehold Improvements, Furniture) for depreciation analysis by asset category."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance) for accounting policy analysis."
    - name: "depreciation_status"
      expr: depreciation_status
      comment: "Status of the depreciation run — identifies failed or pending depreciation postings."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation run for annual depreciation expense reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly depreciation expense trend analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level depreciation reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the depreciation posting for multi-currency asset reporting."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating whether the asset has been impaired — used for impairment review and write-down analysis."
    - name: "depreciation_run_date_month"
      expr: DATE_TRUNC('MONTH', depreciation_run_date)
      comment: "Month of the depreciation run for period-level expense analysis."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense charged in the period — primary P&L impact measure for asset management."
    - name: "total_depreciation_expense_gl"
      expr: SUM(CAST(gl_account_depreciation_expense AS DOUBLE))
      comment: "Total depreciation expense posted to GL accounts — used to reconcile depreciation runs to the general ledger."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets — measures the aging and consumption of the asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all assets — key balance sheet metric for asset portfolio valuation."
    - name: "total_acquisition_value"
      expr: SUM(CAST(acquisition_value AS DOUBLE))
      comment: "Total original acquisition cost of assets — used to measure gross asset investment."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized — measures write-downs required due to asset value deterioration."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of asset depreciation records — measures the size of the depreciable asset portfolio."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across assets — used to forecast future depreciation charges and asset replacement needs."
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(depreciation_amount AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_value AS DOUBLE)), 0), 2)
      comment: "Depreciation as a percentage of acquisition value — measures the rate of asset consumption across the portfolio."
    - name: "impairment_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of impaired assets — used to monitor asset quality and trigger impairment review processes."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_royalty_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise royalty accrual metrics tracking royalty revenue recognition, marketing fund contributions, technology fees, and accrual accuracy across the franchise system."
  source: "`vibe_restaurants_v1`.`finance`.`royalty_accrual`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Revenue recognition status of the royalty accrual — identifies accruals pending posting or reversal."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the royalty accrual for annual franchise revenue reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly royalty revenue trend analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level royalty revenue reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty accrual for multi-currency franchise reporting."
    - name: "adjustment_indicator"
      expr: adjustment_indicator
      comment: "Flag indicating whether this is an adjustment accrual — used to separate original from correcting entries."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the accrual was reversed — used to measure accrual accuracy."
    - name: "accrual_period_start_month"
      expr: DATE_TRUNC('MONTH', accrual_period_start_date)
      comment: "Month the accrual period started — used for period-level royalty revenue analysis."
  measures:
    - name: "total_accrued_royalty_amount"
      expr: SUM(CAST(accrued_royalty_amount AS DOUBLE))
      comment: "Total royalty revenue accrued — primary measure of franchise royalty income for the period."
    - name: "total_royalty_base_net_sales"
      expr: SUM(CAST(royalty_base_net_sales AS DOUBLE))
      comment: "Total net sales used as the royalty calculation base — measures the revenue base driving franchise income."
    - name: "total_marketing_fund_contribution"
      expr: SUM(CAST(marketing_fund_contribution AS DOUBLE))
      comment: "Total marketing fund contributions accrued from franchisees — used for marketing fund budget management."
    - name: "total_technology_fee"
      expr: SUM(CAST(technology_fee AS DOUBLE))
      comment: "Total technology fees accrued from franchisees — measures technology revenue stream from the franchise system."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total combined accrual (royalty + marketing fund + technology fee) — comprehensive franchise fee income measure."
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Total number of royalty accrual records — measures accrual volume and franchise system activity."
    - name: "avg_royalty_rate_pct"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate applied across franchisees — used to monitor rate consistency and contract compliance."
    - name: "avg_marketing_fund_rate_pct"
      expr: AVG(CAST(marketing_fund_rate_percent AS DOUBLE))
      comment: "Average marketing fund contribution rate — used to monitor fund contribution consistency across the franchise system."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed royalty accruals — measures accrual accuracy and the frequency of correction entries."
    - name: "effective_royalty_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accrued_royalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(royalty_base_net_sales AS DOUBLE)), 0), 2)
      comment: "Effective royalty rate as a percentage of net sales — validates that royalty calculations align with contracted rates."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_pos_settlement_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS settlement batch metrics tracking daily sales settlement, deposit amounts, processing fees, refunds, and reconciliation status across restaurant units."
  source: "`vibe_restaurants_v1`.`finance`.`pos_settlement_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the settlement batch (Pending, Settled, Reconciled, Failed) for cash management monitoring."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (Card, Cash, Digital Wallet) for payment method analysis."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Settlement method used for the batch — used for payment processor performance analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card type (Visa, Mastercard, Amex) for payment mix analysis and interchange fee management."
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the settlement — used for processor performance and fee benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-currency cash management."
    - name: "reconciled_indicator"
      expr: reconciled_indicator
      comment: "Flag indicating whether the batch has been reconciled to the bank — key control metric for cash management."
    - name: "batch_date_month"
      expr: DATE_TRUNC('MONTH', batch_date)
      comment: "Month of the settlement batch for monthly cash flow trend analysis."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month funds were settled to the bank account — used for cash receipt timing analysis."
  measures:
    - name: "total_gross_settlement_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross sales settled through POS — primary measure of daily cash and card revenue collected."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net settlement amount after fees and refunds — represents actual cash deposited to the bank."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total amount deposited to bank accounts — used for bank reconciliation and cash position management."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total processing fees charged on settlements — measures payment processing cost as a percentage of revenue."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds processed through POS — used to monitor refund rates and potential fraud or quality issues."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts collected through POS — used for tip compliance reporting and labor cost analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected through POS settlements — used for sales tax remittance and compliance reporting."
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Total number of settlement batches — measures POS settlement activity volume."
    - name: "unreconciled_batch_count"
      expr: COUNT(CASE WHEN reconciled_indicator = FALSE THEN 1 END)
      comment: "Number of unreconciled settlement batches — critical control metric identifying cash reconciliation gaps."
    - name: "processing_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Processing fees as a percentage of gross settlement — measures payment processing cost efficiency."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Refunds as a percentage of gross settlement — used to monitor customer satisfaction and potential fraud."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_lease_liability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease liability metrics under ASC 842/IFRS 16 tracking right-of-use asset values, liability balances, interest expense, and principal reduction across the restaurant real estate portfolio."
  source: "`vibe_restaurants_v1`.`finance`.`lease_liability`"
  dimensions:
    - name: "lease_classification"
      expr: lease_classification
      comment: "Lease classification (Operating, Finance) under ASC 842/IFRS 16 — determines P&L and balance sheet treatment."
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard applied (ASC 842, IFRS 16) for multi-GAAP reporting analysis."
    - name: "liability_status"
      expr: liability_status
      comment: "Current status of the lease liability (Active, Terminated, Renewed) for portfolio management."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level lease liability reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease liability for multi-currency balance sheet reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual lease liability balance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly lease liability amortization analysis."
    - name: "remeasurement_indicator"
      expr: remeasurement_indicator
      comment: "Flag indicating whether the lease was remeasured in the period — used to track lease modification activity."
    - name: "commencement_date_year"
      expr: DATE_TRUNC('YEAR', commencement_date)
      comment: "Year the lease commenced — used for lease vintage analysis and maturity profiling."
    - name: "maturity_date_year"
      expr: DATE_TRUNC('YEAR', maturity_date)
      comment: "Year the lease matures — used for lease renewal pipeline and cash flow forecasting."
  measures:
    - name: "total_initial_liability_amount"
      expr: SUM(CAST(initial_liability_amount AS DOUBLE))
      comment: "Total initial lease liability recognized at commencement — measures the scale of lease obligations taken on."
    - name: "total_current_liability_balance"
      expr: SUM(CAST(current_liability_balance AS DOUBLE))
      comment: "Total current portion of lease liabilities — key balance sheet metric for short-term obligation reporting."
    - name: "total_noncurrent_portion_amount"
      expr: SUM(CAST(noncurrent_portion_amount AS DOUBLE))
      comment: "Total long-term portion of lease liabilities — measures the long-term real estate financial commitment."
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on lease liabilities — P&L impact measure for finance lease accounting."
    - name: "total_principal_reduction_amount"
      expr: SUM(CAST(principal_reduction_amount AS DOUBLE))
      comment: "Total principal reduction on lease liabilities in the period — measures liability amortization progress."
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value — key balance sheet metric representing the economic value of leased properties."
    - name: "total_monthly_payment_amount"
      expr: SUM(CAST(monthly_payment_amount AS DOUBLE))
      comment: "Total monthly lease payment obligations — used for cash flow planning and liquidity management."
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Total number of lease liabilities — measures the size of the leased property portfolio."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate applied to lease liabilities — used to monitor the cost of capital embedded in lease accounting."
    - name: "avg_incremental_borrowing_rate"
      expr: AVG(CAST(incremental_borrowing_rate AS DOUBLE))
      comment: "Average incremental borrowing rate used for lease discounting — measures the effective financing cost of the lease portfolio."
    - name: "remeasurement_count"
      expr: COUNT(CASE WHEN remeasurement_indicator = TRUE THEN 1 END)
      comment: "Number of lease liabilities remeasured in the period — measures lease modification activity and accounting complexity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial period close metrics tracking close cycle duration, reconciliation status, and close quality across legal entities — used to manage and accelerate the financial close process."
  source: "`vibe_restaurants_v1`.`finance`.`period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Current status of the period close (In Progress, Completed, Reopened) for close management."
    - name: "period_type"
      expr: period_type
      comment: "Type of close period (Monthly, Quarterly, Annual) for close cycle analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level close performance analysis."
    - name: "ap_reconciliation_status"
      expr: ap_reconciliation_status
      comment: "AP sub-ledger reconciliation status — identifies entities with unresolved AP reconciliation issues at close."
    - name: "ar_reconciliation_status"
      expr: ar_reconciliation_status
      comment: "AR sub-ledger reconciliation status — identifies entities with unresolved AR reconciliation issues at close."
    - name: "bank_reconciliation_status"
      expr: bank_reconciliation_status
      comment: "Bank reconciliation status — identifies entities with unreconciled bank accounts at close."
    - name: "depreciation_run_status"
      expr: depreciation_run_status
      comment: "Status of the depreciation run for the period — ensures all asset depreciation is posted before close."
    - name: "audit_readiness_flag"
      expr: audit_readiness_flag
      comment: "Flag indicating whether the close package is audit-ready — used for external audit preparation tracking."
    - name: "actual_close_date_month"
      expr: DATE_TRUNC('MONTH', actual_close_date)
      comment: "Month the period was actually closed — used for close cycle trend analysis."
  measures:
    - name: "total_close_duration_hours"
      expr: SUM(CAST(close_duration_hours AS DOUBLE))
      comment: "Total hours spent on period close activities — measures close process efficiency and resource consumption."
    - name: "avg_close_duration_hours"
      expr: AVG(CAST(close_duration_hours AS DOUBLE))
      comment: "Average close duration in hours — primary KPI for financial close cycle efficiency benchmarking."
    - name: "period_close_count"
      expr: COUNT(1)
      comment: "Total number of period close records — measures close activity volume across entities and periods."
    - name: "audit_ready_count"
      expr: COUNT(CASE WHEN audit_readiness_flag = TRUE THEN 1 END)
      comment: "Number of period closes that achieved audit-ready status — measures close quality and compliance readiness."
    - name: "audit_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_readiness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of period closes achieving audit-ready status — key quality metric for the financial close process."
    - name: "reopen_count"
      expr: COUNT(CASE WHEN close_status = 'Reopened' THEN 1 END)
      comment: "Number of periods that were reopened after close — measures close quality and the frequency of post-close corrections."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics tracking sales tax, VAT, and withholding tax liabilities across restaurant units and legal entities — used for tax compliance, filing, and audit management."
  source: "`vibe_restaurants_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (Sales Tax, VAT, Withholding Tax, Use Tax) for tax liability segmentation."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the posting — used for tax rate analysis and jurisdiction compliance."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Tax direction (Input/Output) for VAT analysis and net tax position calculation."
    - name: "tax_filing_status"
      expr: tax_filing_status
      comment: "Filing status of the tax posting — identifies unfiled tax liabilities requiring action."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for multi-jurisdiction tax compliance and nexus analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual tax liability reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly tax accrual and payment analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level tax reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the tax posting was reversed — used to measure tax correction frequency."
    - name: "audit_flag"
      expr: audit_flag
      comment: "Flag indicating the posting is under tax audit — used to track audit exposure and manage audit responses."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of the tax posting for period-level tax liability trend analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted — primary measure of tax liability across all jurisdictions and tax types."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — used to validate effective tax rates and identify under/over-taxation."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings — measures tax transaction volume and compliance activity."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average tax rate applied across postings — used to monitor rate consistency and detect misapplied tax codes."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_base_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable base — validates tax code application accuracy and identifies compliance risks."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed tax postings — measures tax correction frequency and posting quality."
    - name: "audit_flagged_count"
      expr: COUNT(CASE WHEN audit_flag = TRUE THEN 1 END)
      comment: "Number of tax postings flagged for audit — measures tax audit exposure and risk concentration."
    - name: "audit_flagged_tax_amount"
      expr: SUM(CASE WHEN audit_flag = TRUE THEN tax_amount ELSE 0 END)
      comment: "Total tax amount under audit review — measures the financial exposure from tax audit activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking cross-entity transaction volumes, elimination status, and reconciliation quality — critical for consolidated financial reporting."
  source: "`vibe_restaurants_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (Loan, Service Charge, Royalty, Goods Transfer) for elimination analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the intercompany transaction — identifies unresolved items blocking consolidation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between sending and receiving entities — key control metric for consolidation quality."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany elimination reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany reconciliation analysis."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag indicating whether the transaction has been eliminated in consolidation — measures consolidation completeness."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the transaction was reversed — used to measure intercompany correction frequency."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for period-level intercompany activity analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount — primary measure of cross-entity financial activity requiring elimination."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in group reporting currency — used for consolidated elimination analysis."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in local currency — used for entity-level intercompany reporting."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions — measures cross-entity activity volume and consolidation complexity."
    - name: "uneliminated_count"
      expr: COUNT(CASE WHEN elimination_flag = FALSE THEN 1 END)
      comment: "Number of intercompany transactions not yet eliminated — critical metric for consolidation completeness."
    - name: "uneliminated_amount"
      expr: SUM(CASE WHEN elimination_flag = FALSE THEN transaction_amount ELSE 0 END)
      comment: "Total value of uneliminated intercompany transactions — measures the financial risk to consolidated reporting accuracy."
    - name: "elimination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intercompany transactions successfully eliminated — key consolidation quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`finance_bank_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank statement line metrics tracking cash transaction volumes, reconciliation status, fraud flags, and clearing efficiency — used for treasury and cash management."
  source: "`vibe_restaurants_v1`.`finance`.`bank_statement_line`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of bank transaction (Payment, Receipt, Fee, Transfer) for cash flow categorization."
    - name: "credit_debit_indicator"
      expr: credit_debit_indicator
      comment: "Credit or debit indicator for cash inflow/outflow analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the bank line — identifies unmatched items requiring investigation."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Clearing status of the bank line — used to monitor open items in the bank reconciliation."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating a potential fraudulent transaction — used for fraud monitoring and investigation."
    - name: "matched_indicator"
      expr: matched_indicator
      comment: "Flag indicating whether the bank line has been matched to an internal document — measures auto-matching efficiency."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the bank line was reversed — used to identify returned payments and corrections."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cash flow reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash management analysis."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the bank transaction for cash flow trend analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bank transaction amount — primary measure of cash movement through bank accounts."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total transaction amount in local functional currency — used for FX analysis on foreign currency bank accounts."
    - name: "total_reconciliation_difference"
      expr: SUM(CAST(reconciliation_difference_amount AS DOUBLE))
      comment: "Total reconciliation differences between bank and book — measures cash reconciliation accuracy and identifies errors."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of bank statement lines — measures cash transaction volume and bank account activity."
    - name: "unmatched_count"
      expr: COUNT(CASE WHEN matched_indicator = FALSE THEN 1 END)
      comment: "Number of unmatched bank lines — measures the backlog of items requiring manual matching in bank reconciliation."
    - name: "fraud_flagged_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of bank lines flagged for potential fraud — critical risk metric for treasury and internal audit."
    - name: "fraud_flagged_amount"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN amount ELSE 0 END)
      comment: "Total amount of fraud-flagged bank transactions — measures the financial exposure from potential fraudulent activity."
    - name: "auto_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN matched_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bank lines automatically matched to internal documents — measures bank reconciliation automation efficiency."
$$;