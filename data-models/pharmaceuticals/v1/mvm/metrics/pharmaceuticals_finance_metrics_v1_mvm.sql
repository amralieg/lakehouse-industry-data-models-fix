-- Metric views for domain: finance | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable KPIs tracking vendor payment obligations, aging, discount capture, and working capital efficiency for the pharmaceuticals finance domain."
  source: "`pharmaceuticals_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "SAP company code identifying the legal entity for AP transactions, enabling entity-level payables analysis."
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of the vendor (e.g., CRO, CMO, raw material supplier), enabling spend segmentation by vendor type."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the payable (e.g., Oncology, Immunology), enabling cost allocation by pipeline area."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the AP record (e.g., Open, Paid, Blocked), used to filter and segment outstanding obligations."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, wire, check), enabling payment channel analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of vendor invoice (e.g., standard, credit memo), used to segment payables by document type."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AP record for period-over-period financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the AP record for intra-year trend analysis."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag indicating whether the payable is an intercompany transaction, enabling elimination and intercompany reconciliation."
    - name: "is_rd_capitalized"
      expr: is_rd_capitalized
      comment: "Flag indicating whether the AP item relates to capitalized R&D spend, supporting IFRS/GAAP capitalization tracking."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month-level bucketing of the AP due date for cash flow forecasting and aging analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month-level bucketing of the posting date for period-close and accrual analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the AP record, enabling multi-currency payables reporting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (e.g., Net30, Net60) governing when payment is due, used for working capital optimization."
  measures:
    - name: "total_gross_ap_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross accounts payable amount outstanding. Core working capital KPI used by CFO and treasury to manage cash outflow obligations."
    - name: "total_net_ap_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net accounts payable amount after discounts and deductions. Represents the actual cash obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total VAT/tax amount on AP invoices. Used for tax liability reporting and indirect tax compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts available on AP invoices. Measures discount capture opportunity for working capital optimization."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Critical for tax compliance and vendor remittance reporting."
    - name: "open_invoice_count"
      expr: COUNT(CASE WHEN payment_status = 'Open' THEN accounts_payable_id END)
      comment: "Number of open (unpaid) AP invoices. Operational KPI for AP team workload and cash obligation visibility."
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoice records. Baseline volume metric for AP processing throughput and vendor activity."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per AP record. Indicates typical vendor transaction size and helps detect anomalies."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_indicator IS NOT NULL AND payment_block_indicator != '' THEN accounts_payable_id END)
      comment: "Number of invoices with a payment block indicator set. Blocked invoices represent process exceptions requiring resolution before payment."
    - name: "rd_capitalized_ap_amount"
      expr: SUM(CASE WHEN is_rd_capitalized = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Total AP net amount flagged as R&D capitalized spend. Supports IFRS/GAAP intangible asset capitalization tracking and R&D investment reporting."
    - name: "intercompany_ap_amount"
      expr: SUM(CASE WHEN is_intercompany = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross AP amount for intercompany transactions. Used for intercompany elimination in consolidated financial statements."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable KPIs tracking revenue collections, aging, DSO drivers, rebate exposure, and customer payment behavior for the pharmaceuticals finance domain."
  source: "`pharmaceuticals_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "SAP company code identifying the legal entity for AR transactions, enabling entity-level receivables analysis."
    - name: "ar_status"
      expr: ar_status
      comment: "Current status of the AR record (e.g., Open, Cleared, Disputed), used to segment receivables by collection stage."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Segment of the customer (e.g., hospital, pharmacy chain, government), enabling revenue and collections analysis by customer type."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the receivable, enabling revenue and collections analysis by pipeline/product area."
    - name: "revenue_recognition_type"
      expr: revenue_recognition_type
      comment: "Type of revenue recognition applied (e.g., point-in-time, over-time), supporting ASC 606 / IFRS 15 compliance reporting."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level indicating how many collection reminders have been sent. Higher levels signal elevated collection risk."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the customer, enabling channel-level collections analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the AR record for period-over-period revenue and collections reporting."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period of the AR record for intra-year trend and period-close analysis."
    - name: "sales_territory"
      expr: sales_territory
      comment: "Sales territory associated with the receivable, enabling geographic revenue and collections analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the AR record for multi-currency receivables reporting."
    - name: "billing_date_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month-level bucketing of the billing date for revenue trend and DSO analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month-level bucketing of the AR due date for aging and cash flow forecasting."
    - name: "document_type"
      expr: document_type
      comment: "Type of AR document (e.g., invoice, credit memo, debit memo), used to segment receivables by transaction type."
  measures:
    - name: "total_gross_ar_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross accounts receivable amount billed to customers. Core revenue and working capital KPI for CFO and commercial finance."
    - name: "total_net_ar_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount after rebates, chargebacks, and discounts. Represents expected cash collections from customers."
    - name: "total_open_ar_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding (uncollected) AR amount. Primary working capital KPI driving DSO and cash flow forecasting."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amounts deducted from AR. Critical for gross-to-net revenue analysis and commercial contract compliance."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts processed against AR. Chargebacks are a major gross-to-net deduction in pharma and must be monitored for financial accuracy."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR invoices. Used for indirect tax compliance and revenue reporting."
    - name: "open_invoice_count"
      expr: COUNT(CASE WHEN ar_status = 'Open' THEN accounts_receivable_id END)
      comment: "Number of open AR invoices not yet collected. Operational KPI for collections team prioritization."
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR records. Baseline volume metric for billing throughput and customer activity."
    - name: "avg_open_ar_amount"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open AR amount per invoice. Indicates typical uncollected balance size and helps identify large exposure concentrations."
    - name: "high_dunning_ar_amount"
      expr: SUM(CASE WHEN dunning_level IN ('3','4','5') THEN CAST(open_amount AS DOUBLE) ELSE 0 END)
      comment: "Total open AR amount at high dunning levels (3+). Represents elevated collection risk requiring escalation or provision."
    - name: "gross_to_net_deduction_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE) + CAST(chargeback_amount AS DOUBLE))
      comment: "Total gross-to-net deductions (rebates + chargebacks) on AR. Key pharma-specific KPI for net revenue realization and commercial contract management."
    - name: "local_currency_ar_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AR amount in local currency. Used for functional currency reporting and FX exposure analysis."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget performance KPIs tracking planned vs. actual spend, variance analysis, and budget utilization across cost centers, therapeutic areas, and fiscal periods for pharmaceuticals financial planning."
  source: "`pharmaceuticals_ecm`.`finance`.`budget`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for the budget record, enabling entity-level budget analysis."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., OPEX, CAPEX, R&D), enabling spend category analysis and resource allocation review."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget line (e.g., clinical trials, manufacturing, SG&A), enabling granular cost allocation analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and execution status of the budget (e.g., Draft, Approved, Closed), used to filter active vs. pending budgets."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the budget for intra-year spend tracking."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code associated with the budget, enabling regional budget allocation and spend analysis."
    - name: "planning_horizon"
      expr: planning_horizon
      comment: "Planning horizon of the budget (e.g., annual, multi-year), used to segment strategic vs. operational budgets."
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Flag indicating whether the budget relates to capitalized expenditure, supporting CAPEX vs. OPEX classification."
    - name: "capitalization_stage"
      expr: capitalization_stage
      comment: "Stage of capitalization for the budget item, relevant for R&D asset capitalization tracking under IFRS/GAAP."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget record for multi-currency financial planning."
    - name: "version"
      expr: version
      comment: "Budget version (e.g., v1, revised, final), enabling comparison across planning iterations."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month-level bucketing of the budget start date for timeline and phasing analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary financial planning KPI used by CFO and FP&A to assess resource allocation."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend against budget. Core execution KPI for budget performance monitoring and variance analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) budget amount. Represents future cash obligations already contractually committed."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (planned minus actual). Negative variance indicates overspend; positive indicates underspend. Key FP&A steering metric."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average budget variance percentage across budget lines. Provides a normalized view of budget adherence for executive reporting."
    - name: "total_budget_lines"
      expr: COUNT(1)
      comment: "Total number of budget lines. Baseline volume metric for budget complexity and planning coverage."
    - name: "overspent_budget_line_count"
      expr: COUNT(CASE WHEN CAST(actual_amount AS DOUBLE) > CAST(planned_amount AS DOUBLE) THEN budget_id END)
      comment: "Number of budget lines where actual spend exceeds planned amount. Operational KPI for identifying cost overruns requiring management intervention."
    - name: "capex_planned_amount"
      expr: SUM(CASE WHEN is_capitalized = TRUE THEN CAST(planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total planned CAPEX budget amount. Supports capital investment planning and asset acquisition oversight."
    - name: "capex_actual_amount"
      expr: SUM(CASE WHEN is_capitalized = TRUE THEN CAST(actual_amount AS DOUBLE) ELSE 0 END)
      comment: "Total actual CAPEX spend. Used alongside capex_planned_amount to assess capital investment execution vs. plan."
    - name: "total_available_budget_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE) - CAST(actual_amount AS DOUBLE) - CAST(committed_amount AS DOUBLE))
      comment: "Total remaining available budget (planned minus actual minus committed). Indicates uncommitted budget headroom for resource allocation decisions."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger KPIs tracking financial position, period activity, intercompany balances, and R&D capitalization for statutory and management reporting in pharmaceuticals."
  source: "`pharmaceuticals_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for the GL account, enabling entity-level financial reporting."
    - name: "account_type"
      expr: account_type
      comment: "Type of GL account (e.g., P&L, Balance Sheet, Cost), used to segment financial statements."
    - name: "account_group"
      expr: account_group
      comment: "GL account group for hierarchical financial reporting and chart of accounts navigation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the GL record for annual financial reporting and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the GL record for period-close and intra-year trend analysis."
    - name: "gaap_standard"
      expr: gaap_standard
      comment: "GAAP standard applied (e.g., IFRS, US GAAP), enabling dual-reporting and standard-specific financial analysis."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area of the GL posting (e.g., R&D, Manufacturing, SG&A), enabling P&L analysis by function."
    - name: "segment"
      expr: segment
      comment: "Business segment associated with the GL record for segment reporting under IFRS 8 / ASC 280."
    - name: "balance_sheet_account"
      expr: balance_sheet_account
      comment: "Flag indicating whether the GL account is a balance sheet account (vs. P&L), used to separate financial statement views."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Flag indicating intercompany GL postings, used for consolidation elimination and intercompany reconciliation."
    - name: "rd_capitalization_flag"
      expr: rd_capitalization_flag
      comment: "Flag indicating R&D capitalization postings, supporting IFRS/GAAP intangible asset capitalization tracking."
    - name: "period_close_status"
      expr: period_close_status
      comment: "Status of the period close for the GL record (e.g., Open, Closed), used to monitor financial close progress."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the GL record for multi-currency financial reporting."
    - name: "account_status"
      expr: account_status
      comment: "Status of the GL account (e.g., Active, Blocked), used to filter valid accounts for reporting."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit postings to the GL. Core financial reporting metric for understanding gross activity and double-entry verification."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit postings to the GL. Used alongside total_debit_amount to verify balanced books and assess financial activity."
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing balance across GL accounts. Primary balance sheet and P&L position metric for period-end financial reporting."
    - name: "total_closing_balance_group_currency"
      expr: SUM(CAST(closing_balance_gc AS DOUBLE))
      comment: "Total closing balance in group currency. Used for consolidated financial reporting at the corporate level."
    - name: "total_closing_balance_local_currency"
      expr: SUM(CAST(closing_balance_lc AS DOUBLE))
      comment: "Total closing balance in local currency. Used for statutory reporting in each legal entity's functional currency."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across GL accounts. Used to compute period movement and verify roll-forward reconciliation."
    - name: "rd_capitalized_gl_balance"
      expr: SUM(CASE WHEN rd_capitalization_flag = TRUE THEN CAST(closing_balance AS DOUBLE) ELSE 0 END)
      comment: "Total GL closing balance for R&D capitalized accounts. Tracks the intangible asset base from capitalized development costs under IFRS/GAAP."
    - name: "intercompany_gl_balance"
      expr: SUM(CASE WHEN intercompany_flag = TRUE THEN CAST(closing_balance AS DOUBLE) ELSE 0 END)
      comment: "Total GL closing balance for intercompany accounts. Used for intercompany elimination and consolidation reconciliation."
    - name: "net_period_movement"
      expr: SUM(CAST(debit_amount AS DOUBLE) - CAST(credit_amount AS DOUBLE))
      comment: "Net period movement (debits minus credits) across GL accounts. Indicates the direction and magnitude of financial activity in the period."
    - name: "active_gl_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN general_ledger_id END)
      comment: "Number of active GL accounts with postings. Indicates the breadth of financial activity and chart of accounts utilization."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice KPIs tracking billing volume, revenue recognition, payment collection efficiency, and dispute management for the pharmaceuticals finance domain."
  source: "`pharmaceuticals_ecm`.`finance`.`invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, intercompany), used to segment billing activity by document type."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., Open, Paid, Disputed, Cancelled), used to segment invoices by collection stage."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit that issued the invoice, enabling revenue and billing analysis by organizational unit."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the invoice, enabling revenue analysis by pipeline/product area."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified on the invoice, enabling payment channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice (e.g., Net30, Net60), used for working capital and DSO analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency revenue reporting."
    - name: "sox_compliant_flag"
      expr: sox_compliant_flag
      comment: "Flag indicating whether the invoice meets SOX compliance requirements, used for internal controls monitoring."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month-level bucketing of the invoice date for revenue trend and billing volume analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month-level bucketing of the invoice due date for cash flow forecasting and aging analysis."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month-level bucketing of the revenue recognition date for ASC 606 / IFRS 15 compliance reporting."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all invoices. Primary revenue billing KPI for commercial finance and executive reporting."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-shipping invoice subtotal. Used for net revenue analysis excluding tax and logistics charges."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on invoices. Used for indirect tax compliance and revenue reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amounts applied to invoices. Measures commercial discount exposure and gross-to-net impact."
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping and logistics charges billed on invoices. Used for supply chain cost recovery analysis."
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline billing volume metric for operational throughput and customer activity."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN invoice_id END)
      comment: "Number of invoices in disputed status. Disputed invoices represent revenue at risk and require resolution to protect cash flow."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN invoice_status = 'Disputed' THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of disputed invoices. Quantifies revenue at risk from billing disputes for executive escalation and collections management."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Paid' THEN invoice_id END)
      comment: "Number of fully paid invoices. Used to compute payment collection rate and monitor collections effectiveness."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount. Indicates typical transaction size and helps detect anomalies or pricing inconsistencies."
    - name: "non_sox_compliant_invoice_count"
      expr: COUNT(CASE WHEN sox_compliant_flag = FALSE THEN invoice_id END)
      comment: "Number of invoices flagged as non-SOX compliant. Critical internal controls KPI for audit readiness and regulatory risk management."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset KPIs tracking asset base value, depreciation, net book value, and GMP/R&D equipment investment for pharmaceuticals capital management and compliance."
  source: "`pharmaceuticals_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code (e.g., machinery, buildings, IT equipment), enabling capital investment analysis by asset category."
    - name: "asset_class_name"
      expr: asset_class_name
      comment: "Descriptive name of the asset class for business-readable capital reporting."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g., Active, Retired, Under Construction), used to filter the active asset base."
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for the fixed asset, enabling entity-level capital asset reporting."
    - name: "location_code"
      expr: location_code
      comment: "Physical location code of the asset, enabling site-level capital investment and utilization analysis."
    - name: "is_gmp_critical"
      expr: is_gmp_critical
      comment: "Flag indicating whether the asset is GMP-critical (Good Manufacturing Practice), essential for pharmaceutical regulatory compliance and validation tracking."
    - name: "is_rd_equipment"
      expr: is_rd_equipment
      comment: "Flag indicating whether the asset is R&D equipment, supporting R&D investment capitalization and tax credit analysis."
    - name: "depreciation_key"
      expr: depreciation_key
      comment: "Depreciation method key (e.g., straight-line, declining balance), used to segment assets by depreciation treatment."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area associated with the asset for segment-level capital reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset valuation for multi-currency capital reporting."
    - name: "capitalization_date_year"
      expr: DATE_TRUNC('YEAR', capitalization_date)
      comment: "Year-level bucketing of the asset capitalization date for vintage analysis and capital investment trend reporting."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year-level bucketing of the asset acquisition date for capital expenditure trend analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Primary CAPEX investment KPI for capital allocation and asset base reporting."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (acquisition cost minus accumulated depreciation) of fixed assets. Core balance sheet KPI for asset valuation and impairment assessment."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets. Measures the consumed economic value of the asset base and drives P&L depreciation charges."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total residual (salvage) value of fixed assets. Used in depreciation calculations and asset disposal planning."
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Used for insurance adequacy assessment and risk management reporting."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'Active' THEN fixed_asset_id END)
      comment: "Number of active fixed assets. Baseline KPI for asset base size and capital investment breadth."
    - name: "gmp_critical_asset_net_book_value"
      expr: SUM(CASE WHEN is_gmp_critical = TRUE THEN CAST(net_book_value AS DOUBLE) ELSE 0 END)
      comment: "Total net book value of GMP-critical assets. Pharma-specific KPI for regulatory compliance investment and manufacturing capability valuation."
    - name: "rd_equipment_acquisition_cost"
      expr: SUM(CASE WHEN is_rd_equipment = TRUE THEN CAST(acquisition_cost AS DOUBLE) ELSE 0 END)
      comment: "Total acquisition cost of R&D equipment. Supports R&D investment reporting, tax credit calculations, and innovation capability assessment."
    - name: "avg_net_book_value_per_asset"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Indicates the typical remaining economic value of assets and helps identify aging or underinvested asset classes."
    - name: "depreciation_coverage_ratio_numerator"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Numerator for depreciation coverage ratio (accumulated depreciation). Combine with total_acquisition_cost in BI to compute asset age/consumption percentage."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_internal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal order KPIs tracking R&D project cost performance, budget adherence, and commitment management for pharmaceuticals program and portfolio finance."
  source: "`pharmaceuticals_ecm`.`finance`.`internal_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of internal order (e.g., R&D, CAPEX, maintenance), enabling cost analysis by order category."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the internal order (e.g., Released, Technically Completed, Closed), used to filter active vs. completed orders."
    - name: "order_category"
      expr: order_category
      comment: "Category of the internal order for hierarchical cost reporting and portfolio analysis."
    - name: "program_phase"
      expr: program_phase
      comment: "R&D program phase associated with the order (e.g., Phase I, Phase II, Phase III), enabling clinical development cost tracking."
    - name: "company_code"
      expr: company_code
      comment: "SAP company code for the internal order, enabling entity-level cost reporting."
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area for the internal order, used for management accounting segmentation."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area of the internal order (e.g., R&D, Manufacturing), enabling P&L analysis by function."
    - name: "capitalization_eligible"
      expr: capitalization_eligible
      comment: "Flag indicating whether the order costs are eligible for capitalization, supporting IFRS/GAAP R&D asset recognition."
    - name: "investment_measure_type"
      expr: investment_measure_type
      comment: "Type of investment measure associated with the order, used for CAPEX and investment program tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the internal order for multi-currency cost reporting."
    - name: "planned_start_date_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year-level bucketing of the planned start date for program timeline and cost phasing analysis."
    - name: "planned_finish_date_year"
      expr: DATE_TRUNC('YEAR', planned_finish_date)
      comment: "Year-level bucketing of the planned finish date for project completion and cost run-rate analysis."
  measures:
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred on internal orders. Primary R&D and project cost KPI for program spend monitoring and portfolio management."
    - name: "total_plan_cost_amount"
      expr: SUM(CAST(plan_cost_amount AS DOUBLE))
      comment: "Total planned cost for internal orders. Used alongside actual costs for budget adherence and cost-to-complete analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget for internal orders. Represents the authorized spend envelope for R&D programs and capital projects."
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) costs on internal orders. Represents future cash obligations already contractually committed."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(plan_cost_amount AS DOUBLE) - CAST(actual_cost_amount AS DOUBLE))
      comment: "Total cost variance (planned minus actual) across internal orders. Negative variance indicates cost overrun; positive indicates underspend. Key program finance KPI."
    - name: "active_order_count"
      expr: COUNT(CASE WHEN order_status = 'Released' THEN internal_order_id END)
      comment: "Number of active (released) internal orders. Indicates the breadth of ongoing R&D and capital programs."
    - name: "capitalization_eligible_actual_cost"
      expr: SUM(CASE WHEN capitalization_eligible = TRUE THEN CAST(actual_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total actual costs on capitalization-eligible orders. Supports IFRS/GAAP R&D asset recognition and intangible asset balance sheet reporting."
    - name: "total_available_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE) - CAST(actual_cost_amount AS DOUBLE) - CAST(commitment_amount AS DOUBLE))
      comment: "Total remaining available budget (budget minus actual minus commitments) on internal orders. Indicates uncommitted program budget headroom for resource allocation."
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per internal order. Indicates typical program spend level and helps benchmark cost efficiency across R&D projects."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_milestone_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone payment KPIs tracking licensing deal economics, R&D milestone obligations, contingent liabilities, and payment execution for pharmaceuticals business development and finance."
  source: "`pharmaceuticals_ecm`.`finance`.`milestone_payment`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., regulatory approval, clinical phase completion, commercial launch), enabling payment analysis by deal event type."
    - name: "development_stage"
      expr: development_stage
      comment: "R&D development stage at which the milestone is triggered (e.g., Phase I, Phase II, NDA), enabling pipeline-stage cost analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the milestone (e.g., Pending, Paid, Disputed), used to segment obligations by execution stage."
    - name: "payment_direction"
      expr: payment_direction
      comment: "Direction of the milestone payment (e.g., Inbound, Outbound), distinguishing payments received from partners vs. payments made to licensors."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the milestone, enabling deal economics analysis by pipeline area."
    - name: "accounting_treatment"
      expr: accounting_treatment
      comment: "Accounting treatment applied to the milestone (e.g., expense, capitalize, contingent liability), supporting IFRS/GAAP compliance."
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Flag indicating whether the milestone payment is capitalized as an intangible asset, supporting R&D asset recognition tracking."
    - name: "is_contingent_liability"
      expr: is_contingent_liability
      comment: "Flag indicating whether the milestone represents a contingent liability, critical for balance sheet disclosure and financial risk reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the milestone payment (e.g., Approved, Pending Approval), used to monitor payment authorization workflow."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the milestone payment for multi-currency deal economics reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month-level bucketing of the payment date for cash flow and deal economics trend analysis."
    - name: "triggering_event_date_year"
      expr: DATE_TRUNC('YEAR', triggering_event_date)
      comment: "Year-level bucketing of the triggering event date for pipeline milestone achievement trend analysis."
  measures:
    - name: "total_contractual_milestone_amount"
      expr: SUM(CAST(contractual_amount AS DOUBLE))
      comment: "Total contractual milestone payment amounts across all agreements. Primary deal economics KPI for business development and licensing portfolio valuation."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net milestone payment amounts after withholding tax. Represents actual cash outflow/inflow from milestone obligations."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total milestone amounts in functional currency. Used for consolidated deal economics reporting and FX-neutral analysis."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on milestone payments. Critical for cross-border deal tax compliance and net cash flow planning."
    - name: "contingent_liability_amount"
      expr: SUM(CASE WHEN is_contingent_liability = TRUE THEN CAST(contractual_amount AS DOUBLE) ELSE 0 END)
      comment: "Total contractual amount of contingent milestone liabilities. Required for balance sheet disclosure and financial risk reporting under IFRS/GAAP."
    - name: "capitalized_milestone_amount"
      expr: SUM(CASE WHEN is_capitalized = TRUE THEN CAST(net_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net milestone payments capitalized as intangible assets. Supports R&D asset recognition and intangible asset balance sheet reporting."
    - name: "outbound_milestone_amount"
      expr: SUM(CASE WHEN payment_direction = 'Outbound' THEN CAST(net_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net outbound milestone payments made to licensors/partners. Measures cash outflow from in-licensing and partnership obligations."
    - name: "inbound_milestone_amount"
      expr: SUM(CASE WHEN payment_direction = 'Inbound' THEN CAST(net_payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net inbound milestone payments received from partners. Measures cash inflow from out-licensing and partnership agreements."
    - name: "pending_milestone_count"
      expr: COUNT(CASE WHEN payment_status = 'Pending' THEN milestone_payment_id END)
      comment: "Number of pending milestone payments. Operational KPI for payment execution monitoring and cash flow planning."
    - name: "total_milestone_count"
      expr: COUNT(1)
      comment: "Total number of milestone payment records. Baseline volume metric for deal activity and licensing portfolio breadth."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_royalty_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty agreement KPIs tracking licensing economics, royalty rate structures, minimum annual obligations, and agreement portfolio management for pharmaceuticals intellectual property finance."
  source: "`pharmaceuticals_ecm`.`finance`.`royalty_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of royalty agreement (e.g., in-license, out-license, cross-license), enabling portfolio analysis by deal structure."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the royalty agreement (e.g., Active, Expired, Terminated), used to filter the active licensing portfolio."
    - name: "royalty_rate_type"
      expr: royalty_rate_type
      comment: "Type of royalty rate structure (e.g., flat, tiered, net sales-based), enabling analysis by deal economics structure."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of royalty payments (e.g., quarterly, annual), used for cash flow planning and payment schedule analysis."
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the royalty agreement, enabling regional licensing economics analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty agreement for multi-currency licensing portfolio reporting."
    - name: "sublicensing_rights_flag"
      expr: sublicensing_rights_flag
      comment: "Flag indicating whether the agreement grants sublicensing rights, used to identify agreements with additional revenue potential."
    - name: "audit_rights_flag"
      expr: audit_rights_flag
      comment: "Flag indicating whether the agreement includes audit rights, used for compliance and royalty verification monitoring."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year-level bucketing of the agreement effective date for portfolio vintage and deal activity trend analysis."
    - name: "expiration_date_year"
      expr: DATE_TRUNC('YEAR', expiration_date)
      comment: "Year-level bucketing of the agreement expiration date for portfolio renewal planning and IP lifecycle management."
  measures:
    - name: "total_upfront_license_fee_amount"
      expr: SUM(CAST(upfront_license_fee_amount AS DOUBLE))
      comment: "Total upfront license fees across royalty agreements. Measures the initial deal value paid/received for IP access, a key business development KPI."
    - name: "total_minimum_annual_royalty_amount"
      expr: SUM(CAST(minimum_annual_royalty_amount AS DOUBLE))
      comment: "Total minimum annual royalty obligations across active agreements. Represents guaranteed floor payments for cash flow planning and licensor relationship management."
    - name: "avg_base_royalty_rate_pct"
      expr: AVG(CAST(base_royalty_rate_pct AS DOUBLE))
      comment: "Average base royalty rate percentage across agreements. Benchmarks the cost of IP access and informs negotiation strategy for new deals."
    - name: "avg_sublicense_royalty_rate_pct"
      expr: AVG(CAST(sublicense_royalty_rate_pct AS DOUBLE))
      comment: "Average sublicense royalty rate percentage. Used to assess the economics of sublicensing arrangements and downstream revenue sharing."
    - name: "avg_withholding_tax_rate_pct"
      expr: AVG(CAST(withholding_tax_rate_pct AS DOUBLE))
      comment: "Average withholding tax rate across royalty agreements. Used for cross-border tax planning and net royalty cash flow forecasting."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN royalty_agreement_id END)
      comment: "Number of active royalty agreements. Indicates the breadth of the licensing portfolio and IP dependency exposure."
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of royalty agreements. Baseline portfolio size metric for licensing activity and IP management."
    - name: "tiered_royalty_agreement_count"
      expr: COUNT(CASE WHEN royalty_rate_type = 'Tiered' THEN royalty_agreement_id END)
      comment: "Number of agreements with tiered royalty rate structures. Tiered agreements have complex economics requiring careful monitoring as sales thresholds are crossed."
    - name: "total_tier1_threshold_amount"
      expr: SUM(CAST(tier1_threshold_amount AS DOUBLE))
      comment: "Total tier 1 net sales threshold amounts across tiered royalty agreements. Used to monitor proximity to rate step-up triggers and forecast royalty cost escalation."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`finance_transfer_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer pricing KPIs tracking intercompany pricing compliance, arm's length range adherence, markup rates, and withholding tax exposure for pharmaceuticals tax and transfer pricing management."
  source: "`pharmaceuticals_ecm`.`finance`.`transfer_price`"
  dimensions:
    - name: "pricing_method"
      expr: pricing_method
      comment: "Transfer pricing method applied (e.g., CUP, TNMM, Cost Plus), enabling compliance analysis by methodology."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (e.g., product sale, service, IP license), enabling transfer pricing analysis by transaction category."
    - name: "product_type"
      expr: product_type
      comment: "Type of product subject to transfer pricing (e.g., finished goods, API, semi-finished), enabling pricing analysis by product category."
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Lifecycle stage of the product (e.g., launch, growth, mature, decline), enabling transfer price analysis by product maturity."
    - name: "record_status"
      expr: record_status
      comment: "Status of the transfer price record (e.g., Active, Expired, Pending Approval), used to filter current vs. historical pricing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer price for multi-currency intercompany pricing analysis."
    - name: "withholding_tax_applicable"
      expr: withholding_tax_applicable
      comment: "Flag indicating whether withholding tax applies to the transfer price transaction, used for cross-border tax exposure analysis."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency of transfer price review (e.g., annual, bi-annual), used to monitor pricing governance and compliance cycle management."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year-level bucketing of the transfer price effective date for pricing trend and policy change analysis."
    - name: "expiry_date_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year-level bucketing of the transfer price expiry date for pricing renewal and compliance calendar management."
  measures:
    - name: "total_approved_price"
      expr: SUM(CAST(approved_price AS DOUBLE))
      comment: "Total approved transfer prices across all records. Baseline measure for intercompany pricing portfolio valuation."
    - name: "avg_approved_price"
      expr: AVG(CAST(approved_price AS DOUBLE))
      comment: "Average approved transfer price. Used to benchmark intercompany pricing levels and detect outliers requiring review."
    - name: "avg_markup_pct"
      expr: AVG(CAST(markup_pct AS DOUBLE))
      comment: "Average markup percentage applied to cost base in transfer pricing. Key indicator of profit allocation between entities and arm's length compliance."
    - name: "avg_cost_base_amount"
      expr: AVG(CAST(cost_base_amount AS DOUBLE))
      comment: "Average cost base amount used in transfer price calculations. Used to assess the cost foundation of intercompany pricing and detect cost allocation anomalies."
    - name: "avg_arm_length_range_min"
      expr: AVG(CAST(arm_length_range_min AS DOUBLE))
      comment: "Average lower bound of the arm's length range. Used to assess whether approved prices are within the acceptable interquartile range for tax compliance."
    - name: "avg_arm_length_range_max"
      expr: AVG(CAST(arm_length_range_max AS DOUBLE))
      comment: "Average upper bound of the arm's length range. Used alongside the minimum to assess the width of acceptable pricing ranges and compliance headroom."
    - name: "avg_withholding_tax_rate_pct"
      expr: AVG(CAST(withholding_tax_rate_pct AS DOUBLE))
      comment: "Average withholding tax rate on transfer price transactions. Used for cross-border tax cost planning and effective tax rate analysis."
    - name: "active_transfer_price_count"
      expr: COUNT(CASE WHEN record_status = 'Active' THEN transfer_price_id END)
      comment: "Number of active transfer price records. Indicates the scope of intercompany pricing arrangements requiring ongoing compliance monitoring."
    - name: "withholding_tax_applicable_count"
      expr: COUNT(CASE WHEN withholding_tax_applicable = TRUE THEN transfer_price_id END)
      comment: "Number of transfer price records subject to withholding tax. Quantifies cross-border tax exposure in the intercompany pricing portfolio."
    - name: "total_transfer_price_count"
      expr: COUNT(1)
      comment: "Total number of transfer price records. Baseline volume metric for intercompany pricing portfolio size and governance coverage."
$$;