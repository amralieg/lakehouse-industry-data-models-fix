-- Metric views for domain: finance | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics tracking cash outflow, discount capture, payment efficiency, and vendor settlement performance across the agricultural supply chain."
  source: "`agriculture_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. cleared, pending, blocked) used to segment payment pipeline health."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to execute the payment (e.g. ACH, check, wire) for cash management analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment type (e.g. standard, advance, partial) for AP workflow segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cash flow analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for period-over-period financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) of the payment for granular period close analysis."
    - name: "bank_clearing_status"
      expr: bank_clearing_status
      comment: "Bank-side clearing status indicating whether funds have settled, used for cash reconciliation."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date for trend analysis of cash disbursements."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date for period-aligned financial reporting."
    - name: "payment_block_reason"
      expr: payment_block_reason
      comment: "Reason a payment was blocked, used to identify and resolve AP bottlenecks."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash disbursed to vendors. Core AP cash outflow KPI used in treasury and working capital management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net amount paid after discounts and deductions. Reflects actual cash out-the-door for liquidity planning."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Directly measures the financial benefit of prompt payment discipline."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment size per transaction. Useful for benchmarking vendor payment patterns and detecting anomalies."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local reporting currency. Enables consolidated multi-currency cash flow reporting."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed. Baseline volume metric for AP throughput and workload analysis."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors paid. Indicates breadth of supplier settlement activity and concentration risk."
    - name: "blocked_payment_count"
      expr: COUNT(CASE WHEN payment_block_reason IS NOT NULL AND payment_block_reason <> '' THEN 1 END)
      comment: "Number of payments currently blocked. High blocked counts signal AP process failures that delay vendor settlement."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across payments. Monitors currency exposure in international agricultural procurement."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice lifecycle metrics covering invoice volumes, amounts, aging, discount utilization, and three-way match compliance for agricultural procurement spend governance."
  source: "`agriculture_ecm`.`finance`.`finance_ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. open, paid, disputed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. standard, credit memo, recurring) for spend categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval workflow status for identifying bottlenecks in the AP approval chain."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/invoice three-way match — critical compliance control for agricultural procurement."
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "Indicates whether the invoice relates to capital expenditure or operating expenditure for budget classification."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the invoiced goods (e.g. seeds, fertilizer, equipment) for spend analytics."
    - name: "payment_method"
      expr: payment_method
      comment: "Intended payment method for the invoice for cash flow forecasting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-aligned spend reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for granular spend trend analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly AP volume and spend trend reporting."
    - name: "payment_block_status"
      expr: payment_block_status
      comment: "Whether the invoice is blocked for payment, used to track AP clearance efficiency."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating recurring invoices (e.g. lease, subscription) for predictable cash flow planning."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices. Primary spend volume KPI for procurement cost management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and taxes. Reflects actual payable obligation for cash flow planning."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on AP invoices. Required for tax compliance reporting and VAT reclaim analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount available on invoices. Measures potential savings from early payment terms."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Benchmarks typical transaction size and detects unusual invoice patterns."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Baseline volume metric for AP workload and vendor activity measurement."
    - name: "three_way_match_fail_count"
      expr: COUNT(CASE WHEN three_way_match_status NOT IN ('MATCHED', 'APPROVED') THEN 1 END)
      comment: "Number of invoices failing three-way match. High counts indicate procurement control failures and fraud risk."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_status IS NOT NULL AND payment_block_status <> '' THEN 1 END)
      comment: "Number of invoices blocked for payment. Directly impacts vendor relationships and supply continuity."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoicing the business. Measures supplier base breadth and concentration."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital investment project metrics tracking budget utilization, cost variance, ROI, and project execution performance for agricultural infrastructure and equipment investments."
  source: "`agriculture_ecm`.`finance`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the capital project (e.g. approved, in-progress, completed, cancelled)."
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (e.g. irrigation, equipment, facility) for investment portfolio analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project (e.g. planning, execution, closeout) for pipeline stage reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for capital authorization governance."
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of capital expenditure (e.g. land improvement, machinery, buildings) for asset class analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g. internal, loan, government grant) for capital structure analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the project for resource allocation decisions."
    - name: "budget_fiscal_year"
      expr: budget_fiscal_year
      comment: "Fiscal year the capital budget was allocated for period-aligned capex reporting."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Delivery fulfillment status of the project for on-time completion tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of project financials for multi-entity capital reporting."
    - name: "sox_control_relevant"
      expr: sox_control_relevant
      comment: "Flag indicating whether the project is subject to SOX internal controls — critical for audit and compliance."
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total capital budget approved across projects. Primary capex authorization KPI for investment governance."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated project cost at planning stage. Baseline for budget vs. actual variance analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred on capital projects. Core capex spend KPI for investment performance tracking."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed but not yet incurred costs. Measures future cash obligations for treasury planning."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment across capital projects. Key metric for evaluating agricultural investment efficiency."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total cost overrun or underrun vs. estimate. Negative values indicate over-budget projects requiring management attention."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of capital projects in the portfolio. Baseline for project pipeline volume and resource capacity planning."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated project cost. Benchmarks typical investment size for capital planning normalization."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact (savings or efficiency gains) from capital investments. Measures strategic value of capex portfolio."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset lifecycle and depreciation metrics tracking asset base value, accumulated depreciation, net book value, and impairment for agricultural equipment, land improvements, and infrastructure."
  source: "`agriculture_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g. machinery, buildings, land improvements) for portfolio composition analysis."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Detailed asset class code for depreciation schedule and tax treatment classification."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g. active, retired, disposed) for asset lifecycle management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. straight-line, declining balance) for financial reporting consistency."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-aligned depreciation and asset reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of asset valuation for multi-entity consolidated reporting."
    - name: "macrs_property_class"
      expr: macrs_property_class
      comment: "MACRS tax depreciation property class — critical for US agricultural tax planning and IRS compliance."
    - name: "section_179_elected"
      expr: section_179_elected
      comment: "Flag indicating Section 179 immediate expensing election — key tax optimization lever for farm equipment."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and capital investment trend reporting."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of all fixed assets. Represents the total capital invested in the agricultural asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets after depreciation. Core balance sheet KPI for asset base valuation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset portfolio. Measures asset aging and replacement investment need."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized. Signals deterioration in asset value due to damage, obsolescence, or market changes."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Measures asset monetization and fleet renewal activity."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset. Benchmarks typical asset value for insurance and collateral assessment."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets on the register. Baseline for asset base size and management complexity."
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Measures insurance coverage adequacy relative to asset base value."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years. Informs long-term capital replacement planning for farm operations."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agricultural loan portfolio metrics tracking outstanding debt, interest exposure, credit utilization, collateral coverage, and FSA program participation for farm financing governance."
  source: "`agriculture_ecm`.`finance`.`loan`"
  dimensions:
    - name: "loan_status"
      expr: loan_status
      comment: "Current status of the loan (e.g. active, paid off, in default) for portfolio health monitoring."
    - name: "loan_type"
      expr: loan_type
      comment: "Type of loan (e.g. operating, real estate, equipment) for agricultural credit portfolio segmentation."
    - name: "lender_type"
      expr: lender_type
      comment: "Type of lender (e.g. commercial bank, FSA, cooperative) for funding source diversification analysis."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Fixed or variable rate classification for interest rate risk management."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of loan repayments (e.g. monthly, quarterly, annual) for cash flow planning."
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral securing the loan (e.g. land, equipment, crops) for credit risk assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the loan for multi-currency debt portfolio reporting."
    - name: "covenant_compliance_status"
      expr: covenant_compliance_status
      comment: "Status of loan covenant compliance — critical risk indicator for lender relationship management."
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "Whether the loan finances capital or operating expenditure for balance sheet classification."
    - name: "origination_date_year"
      expr: DATE_TRUNC('YEAR', origination_date)
      comment: "Year of loan origination for vintage analysis of the debt portfolio."
    - name: "sox_control_relevant"
      expr: sox_control_relevant
      comment: "Flag for SOX-relevant loans requiring enhanced internal controls and audit documentation."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding loan balance across the portfolio. Primary debt exposure KPI for treasury and credit risk management."
    - name: "total_principal_amount"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Total original principal borrowed. Measures total debt capacity utilized across the farm operation."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest_amount AS DOUBLE))
      comment: "Total accrued interest payable. Measures near-term interest cash obligation for liquidity planning."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit_amount AS DOUBLE))
      comment: "Total undrawn credit available across revolving facilities. Measures liquidity buffer for operational flexibility."
    - name: "total_collateral_value"
      expr: SUM(CAST(collateral_value_amount AS DOUBLE))
      comment: "Total collateral value securing the loan portfolio. Measures asset coverage ratio inputs for credit risk assessment."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across the loan portfolio. Benchmarks cost of debt for refinancing and hedging decisions."
    - name: "loan_count"
      expr: COUNT(1)
      comment: "Total number of active loan facilities. Baseline for debt portfolio complexity and lender relationship management."
    - name: "total_next_payment_amount"
      expr: SUM(CAST(next_payment_amount AS DOUBLE))
      comment: "Total upcoming loan payments due. Critical short-term cash outflow forecast for treasury management."
    - name: "avg_fsa_guarantee_percentage"
      expr: AVG(CAST(fsa_guarantee_percentage AS DOUBLE))
      comment: "Average FSA loan guarantee percentage. Measures government-backed credit support utilization in the farm loan portfolio."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_crop_enterprise_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crop enterprise budget metrics tracking planned vs. actual profitability, cost per hectare, revenue per hectare, breakeven pricing, and yield economics for agricultural production planning."
  source: "`agriculture_ecm`.`finance`.`crop_enterprise_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the crop budget (e.g. draft, approved, final) for planning cycle governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the enterprise budget for financial authorization tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the crop budget for year-over-year agricultural profitability comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for intra-year budget monitoring and variance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-entity consolidated crop economics reporting."
    - name: "yield_uom"
      expr: yield_uom
      comment: "Unit of measure for yield (e.g. bushels/ha, tonnes/ha) for normalized yield economics comparison."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Flag indicating GMO vs. non-GMO crop budget for market channel and premium pricing analysis."
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget (e.g. v1, revised) for tracking planning iterations and forecast accuracy."
    - name: "planting_start_month"
      expr: DATE_TRUNC('MONTH', planting_start_date)
      comment: "Month of planned planting start for seasonal crop economics analysis."
  measures:
    - name: "total_planned_revenue"
      expr: SUM(CAST(planned_total_revenue AS DOUBLE))
      comment: "Total planned crop revenue across all enterprise budgets. Primary top-line agricultural revenue forecast KPI."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_total_cost AS DOUBLE))
      comment: "Total planned production cost across all crop budgets. Core cost of production KPI for margin management."
    - name: "total_planned_net_income"
      expr: SUM(CAST(planned_net_income AS DOUBLE))
      comment: "Total planned net income from crop production. Primary profitability KPI for agricultural enterprise planning."
    - name: "avg_planned_cost_per_ha"
      expr: AVG(CAST(planned_cost_per_ha AS DOUBLE))
      comment: "Average planned cost per hectare. Benchmarks production efficiency and informs land use optimization decisions."
    - name: "avg_planned_revenue_per_ha"
      expr: AVG(CAST(planned_revenue_per_ha AS DOUBLE))
      comment: "Average planned revenue per hectare. Key productivity metric for comparing crop enterprise profitability by field."
    - name: "avg_planned_yield_per_ha"
      expr: AVG(CAST(planned_yield_per_ha AS DOUBLE))
      comment: "Average planned yield per hectare. Core agronomic performance benchmark for production planning."
    - name: "avg_breakeven_price_per_unit"
      expr: AVG(CAST(breakeven_price_per_unit AS DOUBLE))
      comment: "Average breakeven price per unit of output. Critical for marketing strategy and forward contract pricing decisions."
    - name: "total_budget_area_ha"
      expr: SUM(CAST(budget_area_ha AS DOUBLE))
      comment: "Total hectares covered by crop enterprise budgets. Measures scale of planned production for resource allocation."
    - name: "avg_land_rent_per_ha"
      expr: AVG(CAST(land_rent_per_ha AS DOUBLE))
      comment: "Average land rent cost per hectare. Key input cost driver for farm profitability and lease negotiation decisions."
    - name: "avg_government_payment_per_ha"
      expr: AVG(CAST(government_program_payment_per_ha AS DOUBLE))
      comment: "Average government program payment per hectare. Measures subsidy contribution to farm income and program enrollment value."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_government_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Government agricultural program metrics tracking enrollment, payment receipts, compliance status, and program utilization for USDA and FSA program participation management."
  source: "`agriculture_ecm`.`finance`.`government_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of government program (e.g. ARC, PLC, CRP, EQIP) for program portfolio analysis."
    - name: "program_name"
      expr: program_name
      comment: "Name of the specific government program for detailed participation reporting."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (e.g. enrolled, pending, expired) for program participation tracking."
    - name: "conservation_compliance_status"
      expr: conservation_compliance_status
      comment: "Conservation compliance status — required for payment eligibility under most USDA programs."
    - name: "payment_limitation_status"
      expr: payment_limitation_status
      comment: "Status relative to USDA payment limitation caps — critical for maximizing eligible program payments."
    - name: "program_year"
      expr: program_year
      comment: "Program year for year-over-year government payment trend analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the program is administered for geographic program participation analysis."
    - name: "administering_agency"
      expr: administering_agency
      comment: "Government agency administering the program (e.g. FSA, NRCS) for agency-level reporting."
    - name: "payment_currency"
      expr: payment_currency
      comment: "Currency of program payments for financial reporting."
    - name: "wetland_conservation_status"
      expr: wetland_conservation_status
      comment: "Wetland conservation determination status — affects payment eligibility under Swampbuster provisions."
  measures:
    - name: "total_actual_payment_amount"
      expr: SUM(CAST(actual_payment_amount AS DOUBLE))
      comment: "Total government program payments actually received. Primary farm income support KPI for program ROI analysis."
    - name: "total_estimated_payment_amount"
      expr: SUM(CAST(estimated_payment_amount AS DOUBLE))
      comment: "Total estimated government payments expected. Used for farm income forecasting and cash flow planning."
    - name: "total_enrolled_acres"
      expr: SUM(CAST(enrolled_acres AS DOUBLE))
      comment: "Total acres enrolled in government programs. Measures program participation scale and land use commitment."
    - name: "total_base_acres"
      expr: SUM(CAST(base_acres AS DOUBLE))
      comment: "Total program base acres. Determines payment calculation basis for ARC/PLC and other acreage-based programs."
    - name: "total_payment_limitation_amount"
      expr: SUM(CAST(payment_limitation_amount AS DOUBLE))
      comment: "Total payment limitation caps across programs. Measures maximum eligible government support for compliance planning."
    - name: "avg_payment_rate"
      expr: AVG(CAST(payment_rate AS DOUBLE))
      comment: "Average payment rate per unit across programs. Benchmarks program payment efficiency for enrollment decisions."
    - name: "program_enrollment_count"
      expr: COUNT(1)
      comment: "Total number of government program enrollments. Baseline for program participation breadth and administrative workload."
    - name: "avg_insurance_coverage_level"
      expr: AVG(CAST(insurance_coverage_level AS DOUBLE))
      comment: "Average crop insurance coverage level. Measures risk protection adequacy across the farm operation."
    - name: "payment_variance_amount"
      expr: SUM(CAST(actual_payment_amount AS DOUBLE) - CAST(estimated_payment_amount AS DOUBLE))
      comment: "Total variance between actual and estimated government payments. Identifies forecast accuracy and payment shortfalls."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volumes, transaction amounts, intercompany activity, reversal rates, and period close quality for financial reporting integrity."
  source: "`agriculture_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (e.g. SA, KR, DR) for GL transaction classification."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry (e.g. posted, parked, held) for period close completeness monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for journal entry governance and SOX control compliance."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g. manual, automatic, recurring) for control risk stratification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for period-aligned financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for granular period close and month-end reporting."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag for intercompany journal entries requiring elimination in consolidated financial statements."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversed journal entries. High reversal rates signal data quality or process issues."
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Transaction currency for multi-currency GL analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date for monthly financial close volume and trend analysis."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for balance verification and GL integrity checks."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount posted to the GL. Measures total financial activity volume for period reporting."
    - name: "total_company_code_amount"
      expr: SUM(CAST(company_code_amount AS DOUBLE))
      comment: "Total amount in company code currency. Used for local statutory reporting and entity-level P&L analysis."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline for GL activity volume and period close workload measurement."
    - name: "manual_entry_count"
      expr: COUNT(CASE WHEN entry_type = 'MANUAL' THEN 1 END)
      comment: "Number of manual journal entries. High manual entry counts are a SOX audit risk indicator requiring review."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. Elevated reversal rates indicate period close errors or process failures."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries requiring elimination. Critical for consolidated financial statement accuracy."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per journal entry. Benchmarks typical posting size and detects outlier entries."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax compliance and liability metrics tracking tax amounts, penalties, interest, exemptions, and filing status across jurisdictions for agricultural tax governance and regulatory reporting."
  source: "`agriculture_ecm`.`finance`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g. income, sales, property, payroll) for tax liability portfolio analysis."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for detailed classification within each tax type."
    - name: "filing_status"
      expr: filing_status
      comment: "Current filing status (e.g. filed, pending, overdue) for compliance deadline monitoring."
    - name: "jurisdiction_name"
      expr: jurisdiction_name
      comment: "Tax jurisdiction name for geographic tax liability analysis and multi-state compliance reporting."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority (e.g. IRS, state DOR) for authority-level compliance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax record for year-over-year tax liability trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for intra-year tax accrual and payment monitoring."
    - name: "deferred_tax_indicator"
      expr: deferred_tax_indicator
      comment: "Flag for deferred tax positions requiring balance sheet recognition under ASC 740 / IAS 12."
    - name: "amended_indicator"
      expr: amended_indicator
      comment: "Flag for amended tax filings. High amendment rates signal original filing quality issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the tax record for multi-entity consolidated tax reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of tax posting date for monthly tax accrual trend analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total gross tax liability across all records. Primary tax exposure KPI for financial planning and compliance."
    - name: "total_net_tax_amount"
      expr: SUM(CAST(net_tax_amount AS DOUBLE))
      comment: "Total net tax amount after exemptions and credits. Reflects actual tax cash obligation for treasury planning."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount. Measures the economic activity subject to taxation for effective rate analysis."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total tax penalties incurred. Directly measures compliance failure cost and drives corrective action."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on late tax payments. Measures cost of non-compliance for risk management."
    - name: "total_exemption_amount"
      expr: SUM(CAST(exemption_amount AS DOUBLE))
      comment: "Total tax exemptions claimed. Measures tax optimization benefit from agricultural exemptions (e.g. farm use, fuel)."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across records. Benchmarks tax burden and informs tax planning strategy."
    - name: "tax_record_count"
      expr: COUNT(1)
      comment: "Total number of tax records. Baseline for compliance filing volume and tax administration workload."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank account and liquidity metrics tracking available balances, credit facility utilization, overdraft exposure, and reconciliation status for agricultural treasury management."
  source: "`agriculture_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (e.g. operating, payroll, escrow) for treasury portfolio segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the bank account (e.g. active, dormant, closed) for account lifecycle management."
    - name: "bank_name"
      expr: bank_name
      comment: "Name of the banking institution for counterparty concentration and relationship analysis."
    - name: "bank_country_code"
      expr: bank_country_code
      comment: "Country of the bank for geographic treasury exposure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Account currency for multi-currency cash position reporting."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status for identifying unreconciled accounts requiring investigation."
    - name: "usda_program_account"
      expr: usda_program_account
      comment: "Flag for accounts designated for USDA program payments — requires segregated tracking for compliance."
    - name: "dual_signatory_required"
      expr: dual_signatory_required
      comment: "Flag for accounts requiring dual authorization — key internal control for fraud prevention."
    - name: "balance_date_month"
      expr: DATE_TRUNC('MONTH', balance_date)
      comment: "Month of balance snapshot date for cash position trend analysis."
  measures:
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total available cash balance across all bank accounts. Primary liquidity KPI for treasury management."
    - name: "total_daily_balance"
      expr: SUM(CAST(daily_balance AS DOUBLE))
      comment: "Total daily cash balance across accounts. Used for intraday liquidity monitoring and cash concentration."
    - name: "total_credit_facility_limit"
      expr: SUM(CAST(credit_facility_limit AS DOUBLE))
      comment: "Total credit facility limit across all accounts. Measures total borrowing capacity available to the farm operation."
    - name: "total_credit_facility_drawn"
      expr: SUM(CAST(credit_facility_drawn AS DOUBLE))
      comment: "Total credit facility amount currently drawn. Measures credit utilization and remaining borrowing headroom."
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Total overdraft facility limit. Measures short-term liquidity buffer available for operational cash needs."
    - name: "bank_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts. Baseline for treasury complexity and banking relationship management."
    - name: "avg_available_balance"
      expr: AVG(CAST(available_balance AS DOUBLE))
      comment: "Average available balance per account. Benchmarks typical cash holding and identifies idle cash optimization opportunities."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial period close process metrics tracking task completion rates, variance amounts, escalation frequency, and close cycle timeliness for agricultural financial reporting governance."
  source: "`agriculture_ecm`.`finance`.`period_close`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the period close task (e.g. open, in-progress, completed, overdue) for close cycle monitoring."
    - name: "close_task_type"
      expr: close_task_type
      comment: "Type of close task (e.g. reconciliation, accrual, consolidation) for workload categorization."
    - name: "close_period_type"
      expr: close_period_type
      comment: "Period type being closed (e.g. monthly, quarterly, annual) for close cycle complexity analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the period close for year-over-year close efficiency benchmarking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period being closed for granular close cycle performance tracking."
    - name: "gaap_ifrs_standard"
      expr: gaap_ifrs_standard
      comment: "Accounting standard (GAAP or IFRS) applicable to the close task for multi-standard reporting governance."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating escalated close tasks. Escalations signal process failures requiring management intervention."
    - name: "harvest_settlement_flag"
      expr: harvest_settlement_flag
      comment: "Flag for harvest settlement close tasks — unique to agricultural accounting for crop revenue recognition."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Flag for intercompany close tasks requiring elimination entries in consolidated statements."
    - name: "posting_period_locked"
      expr: posting_period_locked
      comment: "Flag indicating whether the posting period has been locked — confirms close finalization."
  measures:
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual financial amount processed during period close. Measures financial activity volume closed in the period."
    - name: "total_estimated_amount"
      expr: SUM(CAST(estimated_amount AS DOUBLE))
      comment: "Total estimated amount for period close tasks. Used for accrual adequacy and close completeness assessment."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and estimated amounts at close. Large variances indicate forecasting or accrual quality issues."
    - name: "close_task_count"
      expr: COUNT(1)
      comment: "Total number of period close tasks. Baseline for close cycle complexity and resource planning."
    - name: "escalated_task_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated close tasks. High escalation counts indicate systemic close process failures."
    - name: "overdue_task_count"
      expr: COUNT(CASE WHEN task_status = 'OVERDUE' THEN 1 END)
      comment: "Number of overdue close tasks. Directly measures close cycle timeliness risk and financial reporting deadline exposure."
    - name: "completed_task_count"
      expr: COUNT(CASE WHEN task_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed close tasks. Used to calculate close completion rate for period-end readiness dashboards."
$$;