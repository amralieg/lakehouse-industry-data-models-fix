-- Metric views for domain: finance | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics for Water Utilities — tracks invoice volumes, amounts, discount capture, tax exposure, and approval cycle health to support cash management and vendor payment governance."
  source: "`water_utilities_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) within the fiscal year for granular budget tracking."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (e.g., standard, credit memo, recurring) to segment payable flows."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., open, paid, disputed, cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status to monitor bottlenecks in the invoice approval process."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, check, wire) for payment channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) to assess discount eligibility and cash planning."
    - name: "is_capex"
      expr: is_capex
      comment: "Flag indicating whether the invoice relates to capital expenditure vs. operating expenditure."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the invoice is a recurring obligation for baseline spend forecasting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/invoice three-way match to identify compliance and payment hold risk."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity or multi-utility financial segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency exposure analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for monthly AP volume and spend trending."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for cash outflow forecasting."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices — primary measure of accounts payable liability and vendor spend."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments — reflects actual cash obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on AP invoices — supports tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts available on invoices — measures discount capture opportunity."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on AP invoices — required for regulatory tax compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed — baseline volume metric for AP workload and vendor activity."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoiced — measures vendor base breadth and concentration risk."
    - name: "capex_invoice_count"
      expr: COUNT(CASE WHEN is_capex = TRUE THEN 1 END)
      comment: "Number of capital expenditure invoices — supports CIP tracking and capital budget monitoring."
    - name: "capex_gross_amount"
      expr: SUM(CASE WHEN is_capex = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross amount of capital expenditure invoices — directly feeds CIP and rate base calculations."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Disputed' THEN 1 END)
      comment: "Number of invoices in dispute — signals vendor relationship issues and payment delay risk."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN invoice_status = 'Disputed' THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross amount of disputed invoices — quantifies financial exposure from unresolved vendor disputes."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Failed' THEN 1 END)
      comment: "Number of invoices failing three-way match — key internal control metric for procurement compliance."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount — benchmarks typical vendor transaction size and detects anomalies."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics — tracks payment amounts, timing, discount utilization, withholding, and void activity to govern cash disbursement efficiency and vendor payment compliance."
  source: "`water_utilities_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual cash disbursement reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for monthly cash flow management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, check, wire) for channel efficiency and cost analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., regular, advance, final) for payment classification."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., cleared, outstanding, voided) for cash reconciliation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms associated with the payment for discount and timing compliance."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag for recurring payments to separate baseline obligations from one-time disbursements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash management."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for monthly cash outflow trending."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash disbursed to vendors — primary measure of AP cash outflow."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and withholding — actual cash leaving the utility."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured — measures working capital optimization from prompt payment."
    - name: "total_withholding_tax_paid"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax remitted — required for tax compliance and regulatory reporting."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions — baseline volume for AP processing workload."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN void_date IS NOT NULL THEN 1 END)
      comment: "Number of voided payments — signals payment errors, fraud risk, or vendor disputes requiring investigation."
    - name: "voided_payment_amount"
      expr: SUM(CASE WHEN void_date IS NOT NULL THEN CAST(payment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of voided payments — quantifies financial exposure from payment reversals."
    - name: "distinct_vendor_payment_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors paid — measures vendor payment breadth and concentration."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction — benchmarks typical disbursement size and flags outliers."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were voided — key quality metric for payment processing accuracy."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable transaction metrics for Water Utilities — tracks outstanding balances, collections performance, write-offs, dispute activity, and aging to manage revenue recovery and credit risk."
  source: "`water_utilities_ecm`.`finance`.`ar_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of AR transaction (e.g., invoice, credit memo, adjustment) for receivables classification."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the AR transaction (e.g., open, closed, disputed) for collections prioritization."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket (e.g., 0-30, 31-60, 61-90, 90+ days) — critical for collections risk stratification."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status to track progress through the collections lifecycle."
    - name: "collection_priority"
      expr: collection_priority
      comment: "Priority level assigned to the collection effort for resource allocation in collections teams."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the transaction is under dispute — segments clean vs. contested receivables."
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Flag indicating whether the customer is on a payment plan — important for low-income assistance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency receivables reporting."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction date truncated to month for monthly AR origination trending."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for cash inflow forecasting."
  measures:
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original billed amount across all AR transactions — measures gross revenue billed."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivables balance — primary measure of uncollected revenue and liquidity risk."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected from customers — measures collections effectiveness and cash inflow."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable — key credit risk and bad debt expense metric."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to AR transactions — monitors billing correction activity and revenue leakage."
    - name: "ar_transaction_count"
      expr: COUNT(1)
      comment: "Total number of AR transactions — baseline volume for billing and collections workload."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with AR transactions — measures customer base exposure."
    - name: "disputed_outstanding_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Outstanding balance on disputed transactions — quantifies revenue at risk from billing disputes."
    - name: "payment_plan_outstanding_amount"
      expr: SUM(CASE WHEN payment_plan_flag = TRUE THEN CAST(outstanding_amount AS DOUBLE) ELSE 0 END)
      comment: "Outstanding balance on payment plan accounts — tracks deferred collection risk and assistance program exposure."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount collected — primary collections efficiency KPI for revenue recovery performance."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount written off — measures bad debt risk and collections program effectiveness."
    - name: "avg_outstanding_per_transaction"
      expr: AVG(CAST(outstanding_amount AS DOUBLE))
      comment: "Average outstanding balance per AR transaction — benchmarks typical receivable size and flags high-value delinquencies."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line execution metrics — tracks original vs. amended budgets, actual expenditures, encumbrances, available balances, and variances by cost center, fund, and fiscal period to govern financial performance against plan."
  source: "`water_utilities_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line for annual budget performance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for intra-year budget monitoring and variance analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (e.g., O&M, capital, debt service) for spend classification."
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget line (e.g., active, closed, amended) for budget lifecycle management."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (e.g., rate revenue, grants, bonds) for funding mix analysis."
    - name: "debt_service_flag"
      expr: debt_service_flag
      comment: "Flag indicating debt service budget lines — separates debt obligations from operational spend."
    - name: "rate_case_flag"
      expr: rate_case_flag
      comment: "Flag indicating budget lines included in rate case filings — critical for regulatory cost recovery."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag for regulatory compliance budget lines — ensures mandated expenditures are tracked separately."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget — baseline for all budget variance and execution analysis."
    - name: "total_amended_budget"
      expr: SUM(CAST(amended_budget_amount AS DOUBLE))
      comment: "Total amended budget after adjustments — reflects current authorized spending authority."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditures charged against budget lines — measures budget consumption and burn rate."
    - name: "total_encumbrance"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered amounts (committed but not yet spent) — critical for available balance and cash flow planning."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance_amount AS DOUBLE))
      comment: "Total remaining available budget balance — primary metric for spending authority and budget headroom."
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (budget minus actuals) — measures over/under-spend against plan."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(amended_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of amended budget consumed by actual expenditures — key budget execution efficiency KPI."
    - name: "encumbrance_to_budget_pct"
      expr: ROUND(100.0 * SUM(CAST(encumbrance_amount AS DOUBLE)) / NULLIF(SUM(CAST(amended_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed via encumbrances — measures forward spending commitment against authority."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines — summarizes overall budget adherence quality."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of active budget lines — measures budget structure complexity and scope."
    - name: "rate_case_budget_amount"
      expr: SUM(CASE WHEN rate_case_flag = TRUE THEN CAST(amended_budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amended budget for rate-case-eligible lines — directly supports regulatory cost recovery filings."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_debt_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt portfolio metrics for Water Utilities — tracks outstanding principal, interest rates, debt structure, and bond ratings to support debt management, CAFR reporting, and rate case cost-of-capital analysis."
  source: "`water_utilities_ecm`.`finance`.`debt_instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of debt instrument (e.g., revenue bond, GO bond, SRF loan) for debt portfolio classification."
    - name: "instrument_status"
      expr: instrument_status
      comment: "Current status of the debt instrument (e.g., active, retired, called) for portfolio lifecycle management."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Fixed vs. variable rate classification — critical for interest rate risk exposure analysis."
    - name: "bond_rating"
      expr: bond_rating
      comment: "Credit rating of the debt instrument — key indicator of borrowing cost and creditworthiness."
    - name: "gasb_classification"
      expr: gasb_classification
      comment: "GASB accounting classification for financial statement and CAFR reporting compliance."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt status — affects effective cost of debt and investor demand."
    - name: "callable_flag"
      expr: callable_flag
      comment: "Flag indicating whether the instrument is callable — relevant for refinancing opportunity analysis."
    - name: "amortization_type"
      expr: amortization_type
      comment: "Amortization structure (e.g., level debt, level principal) for debt service cash flow modeling."
    - name: "issuance_date_year"
      expr: YEAR(issuance_date)
      comment: "Year of debt issuance for vintage analysis and maturity ladder construction."
    - name: "maturity_date_year"
      expr: YEAR(maturity_date)
      comment: "Year of debt maturity for refinancing risk and maturity concentration analysis."
  measures:
    - name: "total_original_principal"
      expr: SUM(CAST(original_principal_amount AS DOUBLE))
      comment: "Total original principal issued — measures total debt capacity utilized over the portfolio lifecycle."
    - name: "total_outstanding_principal"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Total outstanding principal balance — primary measure of current debt obligation and leverage."
    - name: "total_debt_service_reserve"
      expr: SUM(CAST(debt_service_reserve_requirement AS DOUBLE))
      comment: "Total debt service reserve requirements — measures liquidity reserves mandated by bond covenants."
    - name: "debt_instrument_count"
      expr: COUNT(1)
      comment: "Total number of debt instruments in the portfolio — measures debt structure complexity."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across the debt portfolio — key cost-of-capital metric for rate case and refinancing decisions."
    - name: "variable_rate_outstanding_principal"
      expr: SUM(CASE WHEN interest_rate_type = 'Variable' THEN CAST(outstanding_principal_balance AS DOUBLE) ELSE 0 END)
      comment: "Outstanding principal on variable-rate instruments — quantifies interest rate risk exposure."
    - name: "tax_exempt_outstanding_principal"
      expr: SUM(CASE WHEN tax_exempt_flag = TRUE THEN CAST(outstanding_principal_balance AS DOUBLE) ELSE 0 END)
      comment: "Outstanding principal on tax-exempt debt — measures tax-advantaged financing utilization."
    - name: "callable_outstanding_principal"
      expr: SUM(CASE WHEN callable_flag = TRUE THEN CAST(outstanding_principal_balance AS DOUBLE) ELSE 0 END)
      comment: "Outstanding principal on callable instruments — quantifies refinancing opportunity if rates decline."
    - name: "principal_repaid_pct"
      expr: ROUND(100.0 * (SUM(CAST(original_principal_amount AS DOUBLE)) - SUM(CAST(outstanding_principal_balance AS DOUBLE))) / NULLIF(SUM(CAST(original_principal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original principal repaid — measures debt retirement progress across the portfolio."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_debt_service_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt service payment metrics — tracks principal, interest, fees, and total debt service payments, covenant compliance, late payment risk, and reserve fund draws to ensure bond covenant adherence and financial health."
  source: "`water_utilities_ecm`.`finance`.`debt_service_payment`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the debt service payment for annual debt service budget reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for intra-year debt service cash flow monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of debt service payment (e.g., principal, interest, combined) for debt service component analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the debt service payment (e.g., paid, pending, overdue) for covenant compliance monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for debt service disbursement."
    - name: "late_payment_indicator"
      expr: late_payment_indicator
      comment: "Flag indicating late payment — critical for bond covenant compliance and credit rating protection."
    - name: "covenant_compliance_indicator"
      expr: covenant_compliance_indicator
      comment: "Flag indicating whether the payment meets covenant requirements — key regulatory and bondholder obligation."
    - name: "reserve_fund_draw_indicator"
      expr: reserve_fund_draw_indicator
      comment: "Flag indicating a reserve fund draw was required — signals financial stress and covenant trigger risk."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for monthly debt service cash outflow planning."
  measures:
    - name: "total_debt_service_paid"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total debt service payments made — primary measure of debt obligation cash outflow."
    - name: "total_principal_paid"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Total principal repaid — measures debt retirement progress and balance sheet deleveraging."
    - name: "total_interest_paid"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest paid — measures cost of debt and supports rate case interest expense recovery."
    - name: "total_fees_paid"
      expr: SUM(CAST(fees_amount AS DOUBLE))
      comment: "Total fees paid on debt instruments — captures trustee, paying agent, and other financing costs."
    - name: "total_late_penalty_amount"
      expr: SUM(CAST(late_payment_penalty_amount AS DOUBLE))
      comment: "Total late payment penalties incurred — measures financial cost of payment timing failures."
    - name: "total_reserve_fund_draws"
      expr: SUM(CAST(reserve_fund_draw_amount AS DOUBLE))
      comment: "Total reserve fund draws — signals liquidity stress and potential covenant violation risk."
    - name: "avg_debt_service_coverage_ratio"
      expr: AVG(CAST(debt_service_coverage_ratio AS DOUBLE))
      comment: "Average debt service coverage ratio — critical bond covenant metric; must stay above minimum threshold."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_payment_indicator = TRUE THEN 1 END)
      comment: "Number of late debt service payments — key covenant compliance and credit rating risk indicator."
    - name: "covenant_non_compliance_count"
      expr: COUNT(CASE WHEN covenant_compliance_indicator = FALSE THEN 1 END)
      comment: "Number of payments failing covenant compliance — triggers bondholder notification and remediation obligations."
    - name: "late_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_payment_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of debt service payments made late — measures payment discipline and covenant risk exposure."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset financial metrics — tracks acquisition costs, accumulated depreciation, net book values, disposal proceeds, and asset condition to support capital asset management, GASB reporting, and rate base calculations."
  source: "`water_utilities_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g., in service, retired, disposed) for active asset base analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., straight-line, declining balance) for accounting policy analysis."
    - name: "gasb_capital_asset_category"
      expr: gasb_capital_asset_category
      comment: "GASB capital asset category for government financial statement and CAFR compliance reporting."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Physical condition rating of the asset — links financial value to infrastructure health for capital planning."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the asset — prioritizes capital investment in mission-critical infrastructure."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the asset — enables departmental capital asset reporting."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (e.g., sale, scrapped, transferred) for disposal program analysis."
    - name: "acquisition_date_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and replacement cycle planning."
    - name: "in_service_date_year"
      expr: YEAR(in_service_date)
      comment: "Year asset was placed in service — used for depreciation schedule and useful life tracking."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets — measures gross capital investment in utility infrastructure."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset aging and remaining useful life across the capital base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — primary rate base component for regulatory cost recovery."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value — used in depreciation calculations and asset retirement planning."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures capital recovery from retired infrastructure."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total insured value of fixed assets — measures insurance coverage adequacy for the capital asset base."
    - name: "fixed_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets — measures capital asset base size and portfolio complexity."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — benchmarks typical asset value and identifies high-value concentrations."
    - name: "depreciation_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost depreciated — measures overall asset age and infrastructure renewal urgency."
    - name: "in_service_asset_net_book_value"
      expr: SUM(CASE WHEN asset_status = 'In Service' THEN CAST(net_book_value AS DOUBLE) ELSE 0 END)
      comment: "Net book value of assets currently in service — the active rate base component for regulatory filings."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant portfolio metrics — tracks award amounts, drawdowns, remaining balances, matching requirements, and compliance status to maximize federal and state funding utilization and ensure single audit compliance."
  source: "`water_utilities_ecm`.`finance`.`grant`"
  dimensions:
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant (e.g., federal, state, local, private) for funding source diversification analysis."
    - name: "grant_status"
      expr: grant_status
      comment: "Current status of the grant (e.g., active, closed, pending) for portfolio lifecycle management."
    - name: "grantor_agency_name"
      expr: grantor_agency_name
      comment: "Name of the granting agency for agency-level funding relationship management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency (e.g., quarterly, annual) for compliance workload planning."
    - name: "single_audit_required_flag"
      expr: single_audit_required_flag
      comment: "Flag indicating single audit requirement — identifies grants subject to federal audit compliance."
    - name: "award_date_year"
      expr: YEAR(award_date)
      comment: "Year of grant award for funding vintage and pipeline analysis."
    - name: "period_of_performance_end_year"
      expr: YEAR(period_of_performance_end_date)
      comment: "Year the grant performance period ends — critical for drawdown deadline management."
  measures:
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total grant award amounts — measures total external funding secured for capital and operational programs."
    - name: "total_amount_drawn"
      expr: SUM(CAST(total_amount_drawn AS DOUBLE))
      comment: "Total grant funds drawn down — measures funding utilization and cash inflow from grant sources."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining undrawn grant balance — measures funding available for future project expenditures."
    - name: "total_matching_required"
      expr: SUM(CAST(matching_amount_required AS DOUBLE))
      comment: "Total matching funds required across grants — measures local funding obligation tied to grant awards."
    - name: "grant_count"
      expr: COUNT(1)
      comment: "Total number of grants in the portfolio — measures grant program breadth and administrative complexity."
    - name: "grant_drawdown_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_amount_drawn AS DOUBLE)) / NULLIF(SUM(CAST(award_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total grant awards drawn down — key utilization metric; low rates risk grant forfeiture."
    - name: "avg_grant_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average grant award size — benchmarks typical grant scale and informs grant pursuit strategy."
    - name: "single_audit_grant_amount"
      expr: SUM(CASE WHEN single_audit_required_flag = TRUE THEN CAST(award_amount AS DOUBLE) ELSE 0 END)
      comment: "Total award amount for grants requiring single audit — measures federal compliance audit exposure."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant expenditure compliance metrics — tracks eligible vs. ineligible expenditures, matching contributions, audit findings, and approval status to ensure grant fund compliance and maximize reimbursable costs."
  source: "`water_utilities_ecm`.`finance`.`grant_expenditure`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the grant expenditure (e.g., approved, pending, rejected) for compliance workflow tracking."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the expenditure (e.g., direct labor, equipment, indirect) for allowable cost analysis."
    - name: "eligibility_classification"
      expr: eligibility_classification
      comment: "Classification of expenditure eligibility — separates reimbursable from non-reimbursable costs."
    - name: "audit_finding_flag"
      expr: audit_finding_flag
      comment: "Flag indicating an audit finding on the expenditure — critical for compliance risk management."
    - name: "match_requirement_flag"
      expr: match_requirement_flag
      comment: "Flag indicating the expenditure counts toward matching requirements — tracks local match fulfillment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the grant expenditure for multi-currency grant reporting."
    - name: "expenditure_date_month"
      expr: DATE_TRUNC('MONTH', expenditure_date)
      comment: "Expenditure date truncated to month for monthly grant burn rate monitoring."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the grant reporting period for period-specific compliance reporting."
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total grant expenditures incurred — measures grant fund consumption and project progress."
    - name: "total_eligible_amount"
      expr: SUM(CAST(eligible_amount AS DOUBLE))
      comment: "Total eligible (reimbursable) expenditure amount — directly determines grant drawdown and reimbursement claims."
    - name: "total_ineligible_amount"
      expr: SUM(CAST(ineligible_amount AS DOUBLE))
      comment: "Total ineligible expenditure amount — measures non-reimbursable costs that must be funded from other sources."
    - name: "total_match_amount"
      expr: SUM(CAST(match_amount AS DOUBLE))
      comment: "Total matching contribution amount — tracks fulfillment of local match obligations required by grant terms."
    - name: "grant_expenditure_count"
      expr: COUNT(1)
      comment: "Total number of grant expenditure transactions — measures grant program activity volume."
    - name: "audit_finding_count"
      expr: COUNT(CASE WHEN audit_finding_flag = TRUE THEN 1 END)
      comment: "Number of expenditures with audit findings — key compliance risk metric requiring immediate remediation."
    - name: "audit_finding_amount"
      expr: SUM(CASE WHEN audit_finding_flag = TRUE THEN CAST(expenditure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure amount with audit findings — quantifies financial exposure from grant compliance failures."
    - name: "eligibility_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(eligible_amount AS DOUBLE)) / NULLIF(SUM(CAST(expenditure_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of expenditures classified as eligible — measures grant cost compliance and reimbursement efficiency."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_rate_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate case regulatory metrics — tracks revenue requirements, rate base, allowed returns, rate impacts, and regulatory lag to support utility rate setting, regulatory strategy, and revenue sufficiency management."
  source: "`water_utilities_ecm`.`finance`.`rate_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the rate case (e.g., filed, pending, approved, withdrawn) for regulatory pipeline tracking."
    - name: "case_type"
      expr: case_type
      comment: "Type of rate case (e.g., general rate case, surcharge, interim) for regulatory proceeding classification."
    - name: "test_year_type"
      expr: test_year_type
      comment: "Test year methodology (e.g., historical, future, hybrid) used in the rate case filing."
    - name: "rate_design_methodology"
      expr: rate_design_methodology
      comment: "Rate design approach (e.g., tiered, flat, inclining block) for rate structure analysis."
    - name: "settlement_agreement_flag"
      expr: settlement_agreement_flag
      comment: "Flag indicating whether the case was resolved via settlement — measures regulatory negotiation outcomes."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Flag indicating an appeal was filed — signals contested regulatory outcomes and prolonged proceedings."
    - name: "filing_date_year"
      expr: YEAR(filing_date)
      comment: "Year of rate case filing for historical rate case frequency and cycle analysis."
    - name: "decision_date_year"
      expr: YEAR(decision_date)
      comment: "Year of regulatory decision for rate case resolution timeline analysis."
  measures:
    - name: "total_requested_revenue_requirement"
      expr: SUM(CAST(requested_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement requested in rate case filings — measures utility's stated revenue need."
    - name: "total_approved_revenue_requirement"
      expr: SUM(CAST(approved_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement approved by regulators — determines authorized revenue and rate levels."
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base — the capital investment on which the utility earns its allowed return."
    - name: "total_revenue_increase"
      expr: SUM(CAST(revenue_increase_amount AS DOUBLE))
      comment: "Total approved revenue increase — measures regulatory outcome and revenue recovery success."
    - name: "total_operating_expense"
      expr: SUM(CAST(operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses included in rate cases — measures O&M cost recovery through rates."
    - name: "total_debt_service_in_rates"
      expr: SUM(CAST(debt_service_amount AS DOUBLE))
      comment: "Total debt service included in rate cases — measures debt cost recovery through customer rates."
    - name: "avg_allowed_rate_of_return"
      expr: AVG(CAST(allowed_rate_of_return AS DOUBLE))
      comment: "Average allowed rate of return across rate cases — key cost-of-capital benchmark for financial planning."
    - name: "avg_revenue_increase_pct"
      expr: AVG(CAST(revenue_increase_percentage AS DOUBLE))
      comment: "Average approved revenue increase percentage — measures regulatory outcome and rate affordability impact."
    - name: "revenue_requirement_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_revenue_requirement AS DOUBLE)) / NULLIF(SUM(CAST(requested_revenue_requirement AS DOUBLE)), 0), 2)
      comment: "Percentage of requested revenue requirement approved — measures regulatory success rate and filing quality."
    - name: "rate_case_count"
      expr: COUNT(1)
      comment: "Total number of rate cases — measures regulatory activity frequency and proceeding pipeline."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`finance_revenue_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue requirement calculation metrics — tracks total revenue requirements, rate base, O&M expenses, depreciation, debt service, and revenue sufficiency gaps to support rate setting and financial sustainability analysis."
  source: "`water_utilities_ecm`.`finance`.`revenue_requirement`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the revenue requirement calculation (e.g., draft, approved, filed) for workflow tracking."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Methodology used to calculate the revenue requirement for regulatory consistency analysis."
    - name: "cost_allocation_method"
      expr: cost_allocation_method
      comment: "Cost allocation methodology applied — affects how costs are distributed across customer classes."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body with jurisdiction over the revenue requirement — for multi-jurisdiction utility reporting."
    - name: "test_year"
      expr: test_year
      comment: "Test year used in the revenue requirement calculation for regulatory filing alignment."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the revenue requirement becomes effective — for rate implementation timeline tracking."
  measures:
    - name: "total_revenue_requirement"
      expr: SUM(CAST(total_revenue_requirement_amount AS DOUBLE))
      comment: "Total authorized revenue requirement — the foundational metric for rate setting and financial sustainability."
    - name: "total_current_revenue"
      expr: SUM(CAST(current_revenue_amount AS DOUBLE))
      comment: "Total current revenue being collected — compared against requirement to identify revenue sufficiency gaps."
    - name: "total_revenue_sufficiency_gap"
      expr: SUM(CAST(revenue_sufficiency_gap_amount AS DOUBLE))
      comment: "Total revenue sufficiency gap (requirement minus current revenue) — measures under-recovery and rate increase need."
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base included in revenue requirement — the capital investment base earning allowed return."
    - name: "total_om_expense"
      expr: SUM(CAST(om_expense_amount AS DOUBLE))
      comment: "Total O&M expense in revenue requirement — measures operational cost recovery through customer rates."
    - name: "total_depreciation_expense"
      expr: SUM(CAST(depreciation_expense_amount AS DOUBLE))
      comment: "Total depreciation expense in revenue requirement — measures capital cost recovery for asset replacement funding."
    - name: "total_debt_service"
      expr: SUM(CAST(debt_service_amount AS DOUBLE))
      comment: "Total debt service in revenue requirement — measures financing cost recovery through rates."
    - name: "total_grant_funding_offset"
      expr: SUM(CAST(grant_funding_amount AS DOUBLE))
      comment: "Total grant funding offsetting revenue requirement — measures external funding reducing customer rate burden."
    - name: "avg_rate_adjustment_pct"
      expr: AVG(CAST(rate_adjustment_percentage AS DOUBLE))
      comment: "Average rate adjustment percentage — measures typical rate change magnitude for customer impact analysis."
    - name: "revenue_sufficiency_gap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_sufficiency_gap_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue_requirement_amount AS DOUBLE)), 0), 2)
      comment: "Revenue sufficiency gap as a percentage of total requirement — measures financial sustainability risk and rate increase urgency."
$$;