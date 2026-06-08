-- Metric views for domain: finance | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial transaction metrics tracking posted amounts, intercompany activity, and tax impact across fiscal periods and organizational dimensions"
  source: "`semiconductors_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for year-over-year analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) for monthly trending and period close analysis"
    - name: "posting_status"
      expr: posting_status
      comment: "Status of journal entry posting (posted, pending, rejected) for reconciliation tracking"
    - name: "document_type"
      expr: document_type
      comment: "Type of financial document (invoice, payment, adjustment, accrual) for transaction classification"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for double-entry bookkeeping validation"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany transactions requiring elimination in consolidation"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversal entries for accrual and adjustment tracking"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency reporting and FX analysis"
    - name: "business_area"
      expr: business_area
      comment: "Business area or segment for segment reporting and profitability analysis"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (R&D, manufacturing, sales, G&A) for functional cost analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_timestamp)
      comment: "Month of posting for monthly financial close and trending"
    - name: "posting_quarter"
      expr: DATE_TRUNC('QUARTER', posting_timestamp)
      comment: "Quarter of posting for quarterly reporting and board reviews"
  measures:
    - name: "total_posted_amount_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total posted amount in local currency for P&L and balance sheet aggregation"
    - name: "total_posted_amount_base"
      expr: SUM(CAST(amount_base AS DOUBLE))
      comment: "Total posted amount in base reporting currency for consolidated financial statements"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after tax for net income and cash flow analysis"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax provision reconciliation and effective tax rate calculation"
    - name: "journal_entry_count"
      expr: COUNT(DISTINCT journal_entry_id)
      comment: "Count of unique journal entries for transaction volume monitoring and close efficiency"
    - name: "intercompany_transaction_value"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN CAST(amount_base AS DOUBLE) ELSE 0 END)
      comment: "Total value of intercompany transactions requiring consolidation elimination"
    - name: "reversal_transaction_value"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(amount_base AS DOUBLE) ELSE 0 END)
      comment: "Total value of reversal entries for accrual accuracy and period-end adjustment tracking"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate for FX exposure analysis and currency risk management"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital asset performance metrics tracking acquisition cost, depreciation, utilization, and net book value for capital efficiency and asset lifecycle management"
  source: "`semiconductors_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of fixed asset (equipment, building, tooling) for asset class analysis"
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for detailed asset classification and depreciation policy application"
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Current status of asset (active, idle, disposed) for utilization and lifecycle tracking"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, accelerated) for accounting policy compliance"
    - name: "capitalized"
      expr: capitalized
      comment: "Flag indicating whether asset is capitalized for balance sheet vs expense treatment"
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating asset impairment for impairment loss recognition and asset quality"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and capital deployment trends"
    - name: "location_building"
      expr: location_building
      comment: "Building location of asset for site-level asset tracking and utilization"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for asset for accountability and cost allocation"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets for capital investment analysis and ROI calculation"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation for asset age assessment and replacement planning"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (acquisition cost minus accumulated depreciation) for balance sheet reporting"
    - name: "total_depreciation_expense"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense for P&L impact and cash flow adjustment"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment losses recognized for asset quality and earnings impact"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals for gain/loss calculation and cash generation"
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total government grant amounts (e.g., CHIPS Act funding) reducing net capital investment"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average asset utilization rate for capacity planning and capital efficiency assessment"
    - name: "asset_count"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Count of fixed assets for asset portfolio size and diversification tracking"
    - name: "impaired_asset_count"
      expr: COUNT(DISTINCT CASE WHEN impairment_indicator = TRUE THEN fixed_asset_id END)
      comment: "Count of impaired assets for asset quality monitoring and risk assessment"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking planned vs actual spend, CHIPS Act funding compliance, and budget performance across organizational units"
  source: "`semiconductors_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of budget plan for annual planning cycle and year-over-year comparison"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, R&D) for budget category analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of budget plan for governance and approval workflow tracking"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status (draft, approved, active, closed) for budget lifecycle management"
    - name: "chips_act_funding_indicator"
      expr: chips_act_funding_indicator
      comment: "Flag indicating CHIPS Act funded budget items for compliance and grant tracking"
    - name: "compliance_regulation_flag"
      expr: compliance_regulation_flag
      comment: "Flag indicating budget items subject to regulatory compliance requirements"
    - name: "planning_method"
      expr: planning_method
      comment: "Planning method (zero-based, incremental, driver-based) for planning process analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of budget plan for multi-currency budget consolidation"
    - name: "organization_unit_code"
      expr: organization_unit_code
      comment: "Organization unit code for departmental and divisional budget accountability"
  measures:
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned budget amount in local currency for budget allocation and resource planning"
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned budget amount in group reporting currency for consolidated budget reporting"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity (units, headcount, etc.) for operational capacity planning"
    - name: "total_variance_to_prior_year_amount"
      expr: SUM(CAST(variance_to_prior_year_amount AS DOUBLE))
      comment: "Total budget variance to prior year in absolute terms for growth and investment trend analysis"
    - name: "avg_variance_to_prior_year_percent"
      expr: AVG(CAST(variance_to_prior_year_percent AS DOUBLE))
      comment: "Average budget variance to prior year as percentage for normalized growth rate assessment"
    - name: "chips_act_funded_budget"
      expr: SUM(CASE WHEN chips_act_funding_indicator = TRUE THEN CAST(planned_amount_group AS DOUBLE) ELSE 0 END)
      comment: "Total budget funded by CHIPS Act for grant compliance and government reporting"
    - name: "budget_plan_count"
      expr: COUNT(DISTINCT budget_plan_id)
      comment: "Count of budget plans for planning complexity and organizational scope tracking"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request metrics tracking approval pipeline, funding sources, and investment justification for capital allocation decisions"
  source: "`semiconductors_ecm`.`finance`.`capex_request`"
  dimensions:
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Status of capex request (submitted, approved, rejected, completed) for pipeline tracking"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and approval workflow monitoring"
    - name: "approval_stage"
      expr: approval_stage
      comment: "Current approval stage (department, finance, executive) for approval bottleneck analysis"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (internal cash, debt, grant) for capital structure and financing analysis"
    - name: "chips_act_funding_eligible"
      expr: chips_act_funding_eligible
      comment: "Flag indicating eligibility for CHIPS Act funding for grant application prioritization"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment requested for technology investment mix analysis"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of capex request for risk-adjusted capital allocation"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Planned depreciation method for accounting policy consistency"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of capex request for annual capital planning and trend analysis"
    - name: "request_quarter"
      expr: DATE_TRUNC('QUARTER', request_date)
      comment: "Quarter of capex request for quarterly capital deployment tracking"
  measures:
    - name: "total_request_amount"
      expr: SUM(CAST(request_amount AS DOUBLE))
      comment: "Total requested capital expenditure for capital demand and pipeline visibility"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved capital expenditure for committed capital and budget execution tracking"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for capex requests for budget vs actual variance analysis"
    - name: "capex_request_count"
      expr: COUNT(DISTINCT capex_request_id)
      comment: "Count of capex requests for approval throughput and process efficiency monitoring"
    - name: "chips_act_eligible_request_value"
      expr: SUM(CASE WHEN chips_act_funding_eligible = TRUE THEN CAST(request_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of CHIPS Act eligible capex requests for grant application strategy"
    - name: "avg_request_amount"
      expr: AVG(CAST(request_amount AS DOUBLE))
      comment: "Average capex request size for investment scale and project sizing analysis"
    - name: "approval_rate_by_value"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved amount for approval rate calculation (numerator for approval rate ratio)"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center performance metrics tracking budget allocation, actual spend, and organizational cost structure for cost management and accountability"
  source: "`semiconductors_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, service, administrative) for cost classification"
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category of cost center for hierarchical cost reporting"
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Status of cost center (active, inactive, closed) for active cost center tracking"
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering to current operational cost centers"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Cost allocation method (direct, activity-based, proportional) for allocation transparency"
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental cost analysis and accountability"
    - name: "region_code"
      expr: region_code
      comment: "Region code for geographic cost analysis and regional P&L"
    - name: "country_code"
      expr: country_code
      comment: "Country code for country-level cost reporting and transfer pricing"
    - name: "budget_year"
      expr: budget_year
      comment: "Budget year for annual budget cycle tracking"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for cost centers for budget allocation and planning"
    - name: "cost_center_count"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Count of cost centers for organizational complexity and span of control analysis"
    - name: "active_cost_center_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN cost_center_id END)
      comment: "Count of active cost centers for current operational structure tracking"
    - name: "avg_budget_per_cost_center"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per cost center for budget distribution and sizing analysis"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_wafer_cost_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer cost modeling metrics tracking cost per wafer, yield impact, and cost structure for semiconductor manufacturing cost management and pricing decisions"
  source: "`semiconductors_ecm`.`finance`.`wafer_cost_model`"
  dimensions:
    - name: "wafer_cost_model_status"
      expr: wafer_cost_model_status
      comment: "Status of cost model (active, draft, archived) for model lifecycle management"
    - name: "model_code"
      expr: model_code
      comment: "Cost model code for model identification and version tracking"
    - name: "version_number"
      expr: version_number
      comment: "Version number of cost model for model evolution and change tracking"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost model for multi-currency cost comparison"
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in millimeters (200mm, 300mm) for wafer size cost analysis"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year of cost model effectiveness for cost trend analysis over time"
  measures:
    - name: "total_cost_per_wafer_usd"
      expr: SUM(CAST(total_cost_per_wafer_usd AS DOUBLE))
      comment: "Total cost per wafer in USD for wafer-level cost aggregation and benchmarking"
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(total_cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer for cost efficiency benchmarking and pricing strategy"
    - name: "total_mask_set_cost_usd"
      expr: SUM(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Total mask set cost for NRE cost tracking and amortization planning"
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage for yield assumption validation and cost sensitivity"
    - name: "avg_equipment_depreciation_per_wafer"
      expr: AVG(CAST(equipment_depreciation_usd_per_wafer AS DOUBLE))
      comment: "Average equipment depreciation per wafer for capital intensity and asset efficiency"
    - name: "avg_labor_rate_usd_per_hour"
      expr: AVG(CAST(labor_rate_usd_per_hour AS DOUBLE))
      comment: "Average labor rate per hour for labor cost benchmarking and productivity analysis"
    - name: "avg_fab_overhead_rate_percent"
      expr: AVG(CAST(fab_overhead_rate_percent AS DOUBLE))
      comment: "Average fab overhead rate as percentage for overhead allocation and cost structure analysis"
    - name: "avg_silicon_wafer_cost_usd"
      expr: AVG(CAST(silicon_wafer_cost_usd AS DOUBLE))
      comment: "Average silicon wafer material cost for raw material cost tracking and supplier negotiation"
    - name: "avg_chemicals_gases_cost_per_wafer"
      expr: AVG(CAST(chemicals_gases_cost_usd_per_wafer AS DOUBLE))
      comment: "Average chemicals and gases cost per wafer for consumables cost management"
    - name: "cost_model_count"
      expr: COUNT(DISTINCT wafer_cost_model_id)
      comment: "Count of wafer cost models for model portfolio and complexity tracking"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision metrics tracking tax expense, deferred tax positions, effective tax rate, and tax credit utilization for tax planning and compliance"
  source: "`semiconductors_ecm`.`finance`.`tax_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of tax provision for annual tax planning and reporting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for quarterly tax provision and effective tax rate tracking"
    - name: "tax_provision_status"
      expr: tax_provision_status
      comment: "Status of tax provision (draft, approved, filed) for tax close process tracking"
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (income, VAT, property, payroll) for tax category analysis"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction code for multi-jurisdictional tax reporting and compliance"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for tax provision governance and sign-off tracking"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversal of prior provision for tax true-up and adjustment tracking"
    - name: "tax_rate_change_indicator"
      expr: tax_rate_change_indicator
      comment: "Flag indicating tax rate change impact for tax reform and legislative change analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of tax provision for multi-currency tax consolidation"
  measures:
    - name: "total_tax_expense_amount"
      expr: SUM(CAST(tax_expense_amount AS DOUBLE))
      comment: "Total tax expense for P&L impact and effective tax rate calculation"
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total tax base (taxable income) for tax planning and rate reconciliation"
    - name: "total_deferred_tax_asset_amount"
      expr: SUM(CAST(deferred_tax_asset_amount AS DOUBLE))
      comment: "Total deferred tax assets for balance sheet reporting and valuation allowance assessment"
    - name: "total_deferred_tax_liability_amount"
      expr: SUM(CAST(deferred_tax_liability_amount AS DOUBLE))
      comment: "Total deferred tax liabilities for balance sheet reporting and temporary difference tracking"
    - name: "total_tax_credit_used_amount"
      expr: SUM(CAST(tax_credit_used_amount AS DOUBLE))
      comment: "Total tax credits utilized for R&D credit and incentive tracking"
    - name: "total_tax_credit_carryforward_amount"
      expr: SUM(CAST(tax_credit_carryforward_amount AS DOUBLE))
      comment: "Total tax credit carryforward for future tax benefit and cash tax planning"
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate for tax efficiency benchmarking and rate reconciliation"
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average statutory tax rate for jurisdictional rate comparison"
    - name: "tax_provision_count"
      expr: COUNT(DISTINCT tax_provision_id)
      comment: "Count of tax provisions for tax complexity and multi-jurisdictional footprint tracking"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_internal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal order metrics tracking project cost accumulation, budget performance, and capitalization for project accounting and cost control"
  source: "`semiconductors_ecm`.`finance`.`internal_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of internal order (investment, overhead, R&D) for order classification"
    - name: "internal_order_status"
      expr: internal_order_status
      comment: "Status of internal order (open, released, closed) for order lifecycle tracking"
    - name: "capitalization_eligibility"
      expr: capitalization_eligibility
      comment: "Flag indicating eligibility for capitalization for capital vs expense treatment"
    - name: "real_indicator"
      expr: real_indicator
      comment: "Flag indicating real (actual cost) vs statistical order for cost type filtering"
    - name: "statistical_indicator"
      expr: statistical_indicator
      comment: "Flag indicating statistical order for non-financial tracking"
    - name: "auditor_approval_flag"
      expr: auditor_approval_flag
      comment: "Flag indicating auditor approval for SOX compliance and audit trail"
    - name: "settlement_rule"
      expr: settlement_rule
      comment: "Settlement rule for cost allocation and settlement method tracking"
    - name: "order_year"
      expr: YEAR(order_created_timestamp)
      comment: "Year of order creation for annual project portfolio analysis"
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred on internal orders for project cost tracking and variance analysis"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for internal orders for budget allocation and planning"
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed amount (purchase orders, contracts) for commitment tracking and budget control"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount for net cost analysis after settlements and allocations"
    - name: "internal_order_count"
      expr: COUNT(DISTINCT internal_order_id)
      comment: "Count of internal orders for project portfolio size and complexity tracking"
    - name: "capitalization_eligible_cost"
      expr: SUM(CASE WHEN capitalization_eligibility = TRUE THEN CAST(actual_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost eligible for capitalization for capital vs expense split and balance sheet impact"
    - name: "avg_actual_cost_per_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per internal order for project sizing and cost benchmarking"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics tracking budget allocation, actual spend, variance, and profitability for segment reporting and accountability"
  source: "`semiconductors_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (product line, geography, business unit) for segment classification"
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category of profit center for hierarchical segment reporting"
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Status of profit center (active, inactive) for active segment tracking"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Flag indicating consolidation status for consolidation scope and elimination tracking"
    - name: "sox_compliant"
      expr: sox_compliant
      comment: "Flag indicating SOX compliance for internal control and audit scope"
    - name: "transfer_pricing_indicator"
      expr: transfer_pricing_indicator
      comment: "Flag indicating transfer pricing applicability for intercompany pricing and tax compliance"
    - name: "product_line"
      expr: product_line
      comment: "Product line for product-level profitability analysis"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional profitability and market analysis"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for technology-level profitability and investment analysis"
    - name: "fab_location"
      expr: fab_location
      comment: "Fab location for site-level profitability and operational efficiency"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for profit centers for segment budget allocation and planning"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend for profit centers for segment cost tracking and performance"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs budget) for segment performance and cost control"
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage for cost allocation transparency and methodology validation"
    - name: "profit_center_count"
      expr: COUNT(DISTINCT profit_center_id)
      comment: "Count of profit centers for organizational complexity and segment portfolio size"
    - name: "sox_compliant_profit_center_count"
      expr: COUNT(DISTINCT CASE WHEN sox_compliant = TRUE THEN profit_center_id END)
      comment: "Count of SOX-compliant profit centers for compliance scope and audit coverage"
$$;