-- Metric views for domain: finance | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking vendor payment obligations, discount capture efficiency, tax exposure, and invoice processing health for cash flow and working capital management."
  source: "`retail_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AP invoice (e.g. Open, Paid, Disputed) for aging and workflow analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. Standard, Credit Memo, Recurring) to segment payables by type."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity or company code for multi-entity payables reporting and intercompany reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the invoice (e.g. ACH, Wire, Check) for payment channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Vendor payment terms code (e.g. Net30, 2/10Net30) driving discount eligibility and due date calculations."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/receipt/invoice three-way match for procurement compliance and exception management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual payables trend and budget comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly payables cycle analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for time-series payables volume and amount trending."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "GL posting date truncated to month for period-accurate accrual and payables reporting."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Payment due date truncated to month for cash outflow forecasting and liquidity planning."
    - name: "is_edi_received"
      expr: is_edi_received
      comment: "Flag indicating whether the invoice was received via EDI, supporting automation rate tracking."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating a recurring invoice for fixed-cost commitment visibility."
    - name: "dispute_reason"
      expr: dispute_reason
      comment: "Reason code for disputed invoices to identify systemic vendor or process issues."
  measures:
    - name: "total_gross_payables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount representing the full vendor payment obligation before discounts and adjustments. Core working capital KPI."
    - name: "total_net_payables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts and adjustments, representing actual cash outflow obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices for tax liability reporting and compliance monitoring."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured from vendors, a direct measure of treasury efficiency and vendor terms utilization."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total vendor chargeback amounts for compliance deductions, allowance recovery, and vendor performance management."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed, used as the denominator for per-invoice efficiency and average calculations."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active invoices in the period, indicating supplier base breadth and concentration risk."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per AP invoice, used to detect anomalies and benchmark vendor invoice sizes."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to AP invoices for multi-currency exposure and hedging analysis."
    - name: "three_way_match_pass_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'MATCHED' THEN 1 END)
      comment: "Count of invoices that passed three-way match (PO/receipt/invoice), numerator for match rate KPI and procurement compliance."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'DISPUTED' THEN 1 END)
      comment: "Number of invoices in disputed status, a key risk indicator for vendor relationship health and payables accuracy."
    - name: "edi_received_invoice_count"
      expr: COUNT(CASE WHEN is_edi_received = TRUE THEN 1 END)
      comment: "Count of invoices received via EDI, numerator for AP automation rate — a key operational efficiency metric."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'PAID' THEN 1 END)
      comment: "Count of fully paid invoices for payment cycle completion tracking and DPO analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue recognition, collections efficiency, dispute management, write-off exposure, and DSO drivers for cash flow and credit risk management."
  source: "`retail_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the AR invoice (e.g. Open, Paid, Written-Off, Disputed) for aging and collections prioritization."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the AR invoice (e.g. Standard, Credit Memo, Debit Memo) for revenue type segmentation."
    - name: "billing_category"
      expr: billing_category
      comment: "Billing category grouping invoices by business line or revenue stream for P&L attribution."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for multi-entity AR reporting and intercompany reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency receivables exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used or expected (e.g. Credit Card, ACH, Wire) for collections channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Customer payment terms code driving due date and discount eligibility calculations."
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Revenue recognition status (e.g. Recognized, Deferred, Pending) for ASC 606 compliance and revenue timing analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute resolution status for collections risk and customer dispute management."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Collections dunning escalation level indicating severity of overdue status for credit risk management."
    - name: "sales_org_code"
      expr: sales_org_code
      comment: "Sales organization code for revenue attribution by channel or region."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AR invoice for annual revenue and collections trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR cycle and collections performance reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for time-series revenue and billing volume trending."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Payment due date truncated to month for cash inflow forecasting and DSO analysis."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Revenue recognition date truncated to month for period-accurate revenue reporting under ASC 606."
    - name: "dunning_block"
      expr: dunning_block
      comment: "Flag indicating dunning is blocked for this invoice, used to identify exceptions in collections workflow."
  measures:
    - name: "total_gross_receivables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AR invoice amount representing the full revenue billed to customers. Core revenue and receivables KPI."
    - name: "total_net_receivables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR invoice amount after cash discounts, representing expected cash collections."
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding (uncollected) AR balance, the primary metric for collections focus and DSO calculation."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payments applied against AR invoices, measuring collections effectiveness and cash receipt velocity."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total AR amounts written off as uncollectable, a key credit risk and bad debt expense KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices for sales tax liability and compliance reporting."
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total early-payment cash discounts granted to customers, impacting net revenue realization."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued, used as denominator for per-invoice averages and rate calculations."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts billed in the period, indicating active revenue-generating customer base."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per AR invoice, a proxy for average transaction value and billing size trends."
    - name: "open_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'OPEN' THEN 1 END)
      comment: "Count of open (unpaid) AR invoices for collections workload and aging analysis."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN 1 END)
      comment: "Count of invoices with an active dispute, a key risk indicator for revenue at risk and customer satisfaction."
    - name: "written_off_invoice_count"
      expr: COUNT(CASE WHEN write_off_amount > 0 THEN 1 END)
      comment: "Count of invoices with write-off amounts, used to calculate bad debt rate and credit policy effectiveness."
    - name: "deferred_revenue_invoice_count"
      expr: COUNT(CASE WHEN revenue_recognition_status = 'DEFERRED' THEN 1 END)
      comment: "Count of invoices with deferred revenue recognition, critical for ASC 606 compliance and balance sheet accuracy."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking planned vs. actual vs. forecast financial performance across cost centers, profit centers, channels, and fiscal periods for strategic financial management."
  source: "`retail_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget (e.g. OPEX, CAPEX, Revenue, COGS) for P&L line-item planning analysis."
    - name: "channel"
      expr: channel
      comment: "Business channel (e.g. E-Commerce, In-Store, Wholesale) for channel-level budget allocation and performance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning cycle and year-over-year comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly budget review and reforecast cadence."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget vs. actual variance reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status (e.g. Draft, Approved, Locked) for governance and planning cycle management."
    - name: "plan_version_type"
      expr: plan_version_type
      comment: "Version type of the budget plan (e.g. Original, Revised, Reforecast) for version-controlled planning analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting methodology used (e.g. Top-Down, Bottom-Up, Driver-Based) for planning process governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency planning and FX impact analysis."
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating whether the budget is locked for further changes, supporting governance and audit controls."
    - name: "is_reforecast"
      expr: is_reforecast
      comment: "Flag indicating this is a reforecast version, enabling comparison of original plan vs. revised outlook."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Budget approval date truncated to month for planning cycle timeline analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount representing the approved financial target for the period. Foundation of all budget vs. actual analysis."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend or revenue recorded against the budget, the primary input for variance analysis."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted amount for the period, used for rolling forecast accuracy and full-year outlook management."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (encumbered) spend against budget, critical for available-to-spend and budget utilization management."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus plan), the primary KPI for financial performance vs. plan at any organizational level."
    - name: "total_otb_amount"
      expr: SUM(CAST(otb_amount AS DOUBLE))
      comment: "Total Open-to-Buy amount representing remaining purchasing authority, a critical retail merchandise planning KPI."
    - name: "total_revenue_projection"
      expr: SUM(CAST(revenue_projection AS DOUBLE))
      comment: "Total projected revenue from budget plans, used for top-line growth target setting and investor guidance."
    - name: "total_cogs_projection"
      expr: SUM(CAST(cogs_projection AS DOUBLE))
      comment: "Total projected cost of goods sold from budget plans, used for gross margin planning and merchandise cost management."
    - name: "total_gross_margin_projection"
      expr: SUM(CAST(gross_margin_projection AS DOUBLE))
      comment: "Total projected gross margin from budget plans, a key profitability planning KPI for retail operations."
    - name: "total_ebitda_projection"
      expr: SUM(CAST(ebitda_projection AS DOUBLE))
      comment: "Total projected EBITDA from budget plans, the primary earnings metric used in board and investor reporting."
    - name: "total_prior_forecast_amount"
      expr: SUM(CAST(prior_forecast_amount AS DOUBLE))
      comment: "Total prior forecast amount for forecast accuracy measurement and reforecast delta analysis."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average budget variance percentage across budget lines, indicating overall planning accuracy and financial discipline."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines for planning coverage and granularity assessment."
    - name: "approved_budget_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved budget lines, used to track planning cycle completion and governance compliance."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, document amounts, accrual activity, intercompany transactions, and reversal rates for financial close quality and audit readiness."
  source: "`retail_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. SA, AA, KR) classifying the nature of the GL posting for audit and reporting."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g. Manual, Automated, Accrual, Reversal) for close process quality analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry (e.g. Posted, Parked, Blocked) for close completeness monitoring."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for multi-entity GL consolidation and intercompany elimination."
    - name: "business_area"
      expr: business_area
      comment: "Business area for segment-level P&L reporting and internal management accounting."
    - name: "source_module"
      expr: source_module
      comment: "Source system module that generated the journal entry (e.g. AP, AR, MM, SD) for subledger reconciliation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual GL activity and audit trail analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close activity volume and posting pattern analysis."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for GL balance verification and double-entry accounting validation."
    - name: "accrual_indicator"
      expr: accrual_indicator
      comment: "Flag indicating an accrual entry for accrual volume tracking and period-end close quality assessment."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating an intercompany transaction for elimination and consolidation reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating a reversal entry for close quality and error correction rate monitoring."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for GL activity volume and close timing trend analysis."
    - name: "document_date_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Document date truncated to month for transaction origination timing analysis."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area classification (e.g. Sales, Procurement, Finance) for cost allocation and functional P&L reporting."
  measures:
    - name: "total_document_amount"
      expr: SUM(CAST(document_amount AS DOUBLE))
      comment: "Total document currency amount across all journal entries, representing gross GL posting volume for period-end close monitoring."
    - name: "total_local_amount"
      expr: SUM(CAST(local_amount AS DOUBLE))
      comment: "Total local currency amount across journal entries for entity-level P&L and balance sheet reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries for tax provision and compliance reporting."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted, a key close process volume and efficiency metric."
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN entry_type = 'MANUAL' THEN 1 END)
      comment: "Count of manually created journal entries, numerator for manual journal rate — a key audit risk and control quality indicator."
    - name: "accrual_entry_count"
      expr: COUNT(CASE WHEN accrual_indicator = TRUE THEN 1 END)
      comment: "Count of accrual journal entries for period-end close completeness and accrual management."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversal journal entries for error correction rate and close quality assessment."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries for elimination completeness and consolidation accuracy."
    - name: "distinct_cost_center_count"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers with GL postings in the period for cost center activity coverage analysis."
    - name: "avg_document_amount"
      expr: AVG(CAST(document_amount AS DOUBLE))
      comment: "Average document amount per journal entry for anomaly detection and materiality threshold monitoring."
    - name: "avg_fx_rate"
      expr: AVG(CAST(fx_rate AS DOUBLE))
      comment: "Average FX rate applied across journal entries for multi-currency translation impact analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL journal entry line-item metrics providing granular cost, revenue, and tax posting analysis by account type, cost center, and profit center for detailed financial reporting and subledger reconciliation."
  source: "`retail_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "GL account type (e.g. Asset, Liability, Revenue, Expense) for balance sheet and P&L line-item classification."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the parent journal entry for transaction classification and audit trail."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for double-entry accounting validation and balance verification."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for multi-entity GL line-item reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the line item for annual GL detail and audit trail."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly GL line-item activity and close reconciliation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for time-series GL line-item volume and amount trending."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line item for tax type analysis and jurisdiction reporting."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group for parallel accounting and multi-GAAP reporting (e.g. IFRS vs. US GAAP)."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating the line item has been reversed, for error correction rate and close quality monitoring."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area for cost allocation and functional P&L reporting."
    - name: "business_area"
      expr: business_area
      comment: "Business area for segment-level financial reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency code for entity-level currency reporting."
  measures:
    - name: "total_amount_local_currency"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total GL posting amount in local currency, the primary measure for entity-level P&L and balance sheet reporting."
    - name: "total_amount_doc_currency"
      expr: SUM(CAST(amount_doc_currency AS DOUBLE))
      comment: "Total GL posting amount in document (transaction) currency for multi-currency exposure analysis."
    - name: "total_amount_group_currency"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total GL posting amount in group (consolidated) currency for enterprise-level financial consolidation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line-item level for granular tax provision, compliance, and jurisdiction reporting."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity posted on GL line items for quantity-based cost allocation and inventory valuation reconciliation."
    - name: "line_item_count"
      expr: COUNT(1)
      comment: "Total number of GL line items posted, a key measure of transaction volume and close process complexity."
    - name: "reversed_line_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Count of reversed GL line items for error correction rate and posting quality monitoring."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts with postings, indicating chart-of-accounts utilization and posting spread."
    - name: "avg_amount_local_currency"
      expr: AVG(CAST(amount_local_currency AS DOUBLE))
      comment: "Average local currency amount per GL line item for materiality benchmarking and anomaly detection."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across GL line items for FX translation impact analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax posting metrics covering sales and use tax liability, input tax recovery, tax type distribution, jurisdiction exposure, and exemption rates for tax compliance, audit defense, and regulatory reporting."
  source: "`retail_ecm`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g. Sales Tax, Use Tax, VAT, GST) for tax liability classification and compliance reporting."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Direction of tax posting (Input/Output) for VAT/GST net liability calculation and recoverability analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the transaction for rate-level tax analysis and jurisdiction mapping."
    - name: "tax_jurisdiction_country"
      expr: tax_jurisdiction_country
      comment: "Country of tax jurisdiction for cross-border tax exposure and country-level compliance reporting."
    - name: "tax_jurisdiction_state"
      expr: tax_jurisdiction_state
      comment: "State-level tax jurisdiction for US sales and use tax nexus analysis and state filing obligations."
    - name: "tax_jurisdiction_city"
      expr: tax_jurisdiction_city
      comment: "City-level tax jurisdiction for local tax rate analysis and municipal compliance."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Standardized tax jurisdiction code for systematic tax authority mapping and reporting."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for entity-level tax liability and compliance reporting."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the originating transaction for tax posting source analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt transactions for exemption certificate management and audit defense."
    - name: "nexus_indicator"
      expr: nexus_indicator
      comment: "Flag indicating tax nexus in the jurisdiction for nexus exposure and economic nexus threshold monitoring."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating a reversed tax posting for net tax liability accuracy."
    - name: "reverse_charge_flag"
      expr: reverse_charge_flag
      comment: "Flag indicating reverse charge mechanism for B2B VAT compliance in applicable jurisdictions."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Tax posting date truncated to month for period-level tax accrual and filing calendar management."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the tax posting for entity-level tax liability reporting."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount in transaction currency, the primary KPI for tax liability exposure and compliance reporting."
    - name: "total_tax_amount_local_currency"
      expr: SUM(CAST(tax_amount_local_currency AS DOUBLE))
      comment: "Total tax amount in local currency for entity-level tax provision and statutory filing."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount on which tax is calculated, used for effective tax rate analysis and audit verification."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Total number of tax postings for transaction volume analysis and compliance completeness monitoring."
    - name: "exempt_posting_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN 1 END)
      comment: "Count of tax-exempt postings, numerator for exemption rate KPI and certificate compliance management."
    - name: "nexus_posting_count"
      expr: COUNT(CASE WHEN nexus_indicator = TRUE THEN 1 END)
      comment: "Count of postings with tax nexus, for nexus exposure monitoring and economic nexus threshold tracking by jurisdiction."
    - name: "reversal_posting_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Count of reversed tax postings for net tax liability accuracy and audit trail completeness."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT tax_jurisdiction_code)
      comment: "Number of distinct tax jurisdictions with postings, a key metric for tax compliance complexity and filing obligation scope."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average effective tax rate percentage across postings for blended rate analysis and rate anomaly detection."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to tax postings for multi-currency tax translation impact analysis."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with tax postings for input tax recovery analysis and vendor tax compliance monitoring."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center master data metrics covering budget allocation, organizational structure, and channel-level profitability planning for segment reporting and management accounting governance."
  source: "`retail_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (e.g. Store, Region, Channel, Corporate) for organizational hierarchy analysis."
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category classification of the profit center for segment-level P&L grouping."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Active/inactive status of the profit center for master data governance and reporting scope management."
    - name: "channel_type"
      expr: channel_type
      comment: "Business channel type (e.g. E-Commerce, Physical Retail, Wholesale) for channel profitability analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for multi-entity profit center reporting and intercompany analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the profit center for geographic profitability and regional performance analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional code for sub-national profit center grouping and regional management reporting."
    - name: "profit_center_level"
      expr: profit_center_level
      comment: "Hierarchy level of the profit center for roll-up reporting and organizational drill-down analysis."
    - name: "segment_code"
      expr: segment_code
      comment: "Segment code for IFRS 8 / ASC 280 segment reporting and external financial disclosure."
    - name: "currency_code"
      expr: currency_code
      comment: "Functional currency of the profit center for currency-level profitability analysis."
    - name: "posting_block_flag"
      expr: posting_block_flag
      comment: "Flag indicating posting is blocked for this profit center, for master data governance monitoring."
    - name: "asc280_reportable_flag"
      expr: asc280_reportable_flag
      comment: "Flag indicating the profit center is reportable under ASC 280 segment disclosure requirements."
  measures:
    - name: "total_annual_revenue_budget"
      expr: SUM(CAST(annual_revenue_budget AS DOUBLE))
      comment: "Total annual revenue budget across profit centers, the top-line financial target for segment-level revenue planning."
    - name: "total_annual_cogs_budget"
      expr: SUM(CAST(annual_cogs_budget AS DOUBLE))
      comment: "Total annual COGS budget across profit centers for gross margin planning and merchandise cost management."
    - name: "total_annual_opex_budget"
      expr: SUM(CAST(annual_opex_budget AS DOUBLE))
      comment: "Total annual OPEX budget across profit centers for operating expense planning and cost control."
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Total number of profit centers for organizational scope and master data coverage analysis."
    - name: "active_profit_center_count"
      expr: COUNT(CASE WHEN profit_center_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active profit centers for operational scope and reporting entity management."
    - name: "asc280_reportable_count"
      expr: COUNT(CASE WHEN asc280_reportable_flag = TRUE THEN 1 END)
      comment: "Count of profit centers subject to ASC 280 segment disclosure, for external reporting scope governance."
    - name: "avg_annual_revenue_budget"
      expr: AVG(CAST(annual_revenue_budget AS DOUBLE))
      comment: "Average annual revenue budget per profit center for budget allocation equity and benchmarking analysis."
    - name: "avg_annual_opex_budget"
      expr: AVG(CAST(annual_opex_budget AS DOUBLE))
      comment: "Average annual OPEX budget per profit center for cost allocation benchmarking and efficiency comparison."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center master data and budget metrics tracking annual budget allocation, YTD actuals, commitment levels, and budget utilization for operational cost management and controlling."
  source: "`retail_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (e.g. Production, Administration, Sales) for cost type segmentation and allocation."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category of the cost center for hierarchical cost reporting and management accounting."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status of the cost center for master data governance and reporting scope."
    - name: "cost_center_level"
      expr: cost_center_level
      comment: "Hierarchy level of the cost center for organizational drill-down and roll-up reporting."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for multi-entity cost center reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country of the cost center for geographic cost analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional code for sub-national cost center grouping and regional cost management."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Cost allocation method (e.g. Direct, Indirect, Activity-Based) for cost distribution governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Functional currency of the cost center for currency-level cost reporting."
    - name: "budget_fiscal_year"
      expr: budget_fiscal_year
      comment: "Fiscal year of the cost center budget for annual planning cycle analysis."
    - name: "is_locked_for_posting"
      expr: is_locked_for_posting
      comment: "Flag indicating the cost center is locked for new postings, for master data governance monitoring."
    - name: "is_statistical"
      expr: is_statistical
      comment: "Flag indicating a statistical cost center used for allocation bases rather than direct cost posting."
  measures:
    - name: "total_annual_budget_amount"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget amount across cost centers, the primary cost planning target for operational expense management."
    - name: "total_actual_ytd_amount"
      expr: SUM(CAST(actual_ytd_amount AS DOUBLE))
      comment: "Total year-to-date actual spend across cost centers, the primary KPI for budget utilization and cost control."
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed (encumbered) spend across cost centers for available-to-spend and budget exposure management."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers for organizational scope and master data coverage analysis."
    - name: "active_cost_center_count"
      expr: COUNT(CASE WHEN cost_center_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active cost centers for operational scope and controlling area management."
    - name: "avg_annual_budget_amount"
      expr: AVG(CAST(annual_budget_amount AS DOUBLE))
      comment: "Average annual budget per cost center for budget allocation equity analysis and benchmarking."
    - name: "avg_actual_ytd_amount"
      expr: AVG(CAST(actual_ytd_amount AS DOUBLE))
      comment: "Average YTD actual spend per cost center for cost run-rate analysis and outlier detection."
$$;