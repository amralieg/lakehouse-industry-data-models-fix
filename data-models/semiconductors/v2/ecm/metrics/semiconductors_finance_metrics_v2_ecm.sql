-- Metric views for domain: finance | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget planning KPIs: total planned spend, variance to prior year, and budget utilization by fiscal year, cost center, and budget type. Used by CFO and FP&A to steer annual capital and operating budget allocation."
  source: "`vibe_semiconductors_v1`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan for year-over-year comparison."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (CAPEX, OPEX, R&D, etc.) for category-level analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity / company code for multi-entity budget reporting."
    - name: "plan_status"
      expr: plan_status
      comment: "Approval and lifecycle status of the budget plan."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the budget is denominated."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning methodology (top-down, bottom-up, zero-based) for governance analysis."
    - name: "chips_act_funding_indicator"
      expr: chips_act_funding_indicator
      comment: "Flag indicating whether the plan includes CHIPS Act government funding."
  measures:
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned budget in local currency. Primary KPI for budget sizing and allocation decisions."
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned budget in group/reporting currency for consolidated financial reporting."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Aggregate approved budget amount across all plans. Used to assess total financial commitment."
    - name: "total_variance_to_prior_year_amount"
      expr: SUM(CAST(variance_to_prior_year_amount AS DOUBLE))
      comment: "Sum of year-over-year budget variance amounts. Highlights growth or contraction in planned spend."
    - name: "avg_variance_to_prior_year_percent"
      expr: AVG(CAST(variance_to_prior_year_percent AS DOUBLE))
      comment: "Average percentage variance versus prior year budget. Signals budget growth rate trends for executive review."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity (wafers, units, etc.) across budget plans. Supports capacity planning decisions."
    - name: "budget_plan_count"
      expr: COUNT(1)
      comment: "Number of budget plans in scope. Used to assess planning coverage and governance completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget execution KPIs: planned vs. actual spend, variance analysis, and budget utilization by cost center, GL account, and fiscal period. Core FP&A dashboard for budget control and reforecasting."
  source: "`vibe_semiconductors_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period budget tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for granular budget execution monitoring."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (labor, materials, overhead, etc.) for spend category analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity budget line reporting."
    - name: "cost_element_type"
      expr: cost_element_type
      comment: "Cost element type for detailed cost structure analysis."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Approval and execution status of the budget line."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line for FX-aware reporting."
    - name: "is_frozen"
      expr: is_frozen
      comment: "Indicates whether the budget line is frozen and no longer editable."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total approved budget amount across lines. Baseline for budget utilization analysis."
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned spend amount. Used to compare plan vs. approved budget."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend recorded against budget lines. Primary execution KPI."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (planned minus actual). Negative values indicate overspend requiring management action."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average budget variance percentage. Signals systemic over- or under-spending patterns."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across budget lines. Supports volume-based cost analysis."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget lines. Used to assess budget granularity and planning completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request pipeline KPIs: requested vs. approved amounts, ROI, and approval cycle metrics. Used by CFO and investment committee to prioritize and govern capital allocation for fab equipment and technology."
  source: "`vibe_semiconductors_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the CAPEX request (pending, approved, rejected)."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment being requested (lithography, etch, deposition, etc.)."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node associated with the CAPEX investment for node-level spend analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity CAPEX governance."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (internal, government grant, CHIPS Act, etc.)."
    - name: "chips_act_funding_eligible"
      expr: chips_act_funding_eligible
      comment: "Flag indicating CHIPS Act funding eligibility for government subsidy tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the CAPEX request for risk-adjusted investment prioritization."
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Lifecycle status of the CAPEX request."
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total capital requested across all CAPEX requests. Primary pipeline sizing KPI for investment committee."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total capital approved. Compared against requested to compute approval rate and funding gap."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted CAPEX amount. Used to assess budget vs. request alignment."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average return on investment percentage across CAPEX requests. Key metric for investment quality assessment."
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Number of CAPEX requests in the pipeline. Indicates investment activity volume."
    - name: "total_request_amount"
      expr: SUM(CAST(request_amount AS DOUBLE))
      comment: "Total amount from request_amount field. Cross-validates with requested_amount for data quality."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio KPIs: acquisition cost, net book value, accumulated depreciation, and impairment. Used by finance and operations to manage asset lifecycle, technology refresh cycles, and fab equipment investment."
  source: "`vibe_semiconductors_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (fab equipment, building, IT, etc.) for portfolio segmentation."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for depreciation policy and financial reporting grouping."
    - name: "asset_type"
      expr: asset_type
      comment: "Type of fixed asset for operational classification."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity asset reporting."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance, etc.)."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Lifecycle status of the asset (active, disposed, impaired)."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers associated with the asset for node-level investment analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating whether the asset has been impaired."
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Indicates whether the asset has been capitalized on the balance sheet."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets. Represents gross capital investment in the asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (cost minus accumulated depreciation). Key balance sheet metric for asset valuation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset portfolio. Indicates asset age and replacement urgency."
    - name: "total_depreciation_amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total periodic depreciation charge. Impacts P&L and cost-per-wafer calculations."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded. Signals asset write-downs requiring executive attention."
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total government grant amounts received against fixed assets. Tracks CHIPS Act and other subsidy benefits."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average asset utilization percentage. Low utilization signals underused capital requiring redeployment decisions."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Used to assess asset retirement economics."
    - name: "fixed_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in the portfolio. Baseline for asset density and management overhead analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation run execution KPIs: total depreciation charged, accumulated depreciation, and run completion metrics. Used by finance controllers to validate period-close depreciation accuracy and asset book value integrity."
  source: "`vibe_semiconductors_v1`.`finance`.`depreciation_run`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly depreciation monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method used in the run for policy compliance verification."
    - name: "run_type"
      expr: run_type
      comment: "Type of depreciation run (planned, unplanned, reversal) for run classification."
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the depreciation run (completed, failed, in-progress)."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity depreciation reporting."
    - name: "is_posted"
      expr: is_posted
      comment: "Indicates whether the depreciation run has been posted to the general ledger."
    - name: "depreciation_run_status"
      expr: depreciation_run_status
      comment: "Lifecycle status of the depreciation run record."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(total_depreciation_amount AS DOUBLE))
      comment: "Total depreciation charged in the run. Primary P&L impact metric for period-close validation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(total_accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets in the run. Balance sheet asset valuation metric."
    - name: "total_book_value"
      expr: SUM(CAST(total_book_value AS DOUBLE))
      comment: "Total net book value of assets after depreciation. Key balance sheet metric."
    - name: "total_tax_adjustment"
      expr: SUM(CAST(depreciation_tax_adjustment AS DOUBLE))
      comment: "Total tax depreciation adjustments. Used for tax provision and deferred tax calculations."
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate applied across runs. Monitors policy consistency and rate changes."
    - name: "depreciation_run_count"
      expr: COUNT(1)
      comment: "Number of depreciation runs executed. Tracks period-close activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry KPIs: posting volumes, net amounts, tax amounts, and intercompany activity. Used by controllers and auditors to monitor GL integrity, period-close completeness, and intercompany elimination exposure."
  source: "`vibe_semiconductors_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL activity analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (invoice, payment, accrual, etc.) for transaction classification."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level GL reporting."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (posted, parked, reversed) for close completeness tracking."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag for intercompany transactions requiring elimination in consolidation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating reversal entries for accrual management monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for FX exposure analysis."
    - name: "journal_entry_status"
      expr: journal_entry_status
      comment: "Lifecycle status of the journal entry."
  measures:
    - name: "total_amount_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total journal entry amount in local currency. Core GL volume metric for period-close validation."
    - name: "total_amount_base"
      expr: SUM(CAST(amount_base AS DOUBLE))
      comment: "Total journal entry amount in base/group currency. Used for consolidated financial reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after tax. Represents economic substance of GL postings."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted. Used for tax provision reconciliation and compliance."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Number of journal entries. Baseline for close activity volume and audit scope assessment."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Drives consolidation elimination workload and risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry line-level KPIs: line amounts, tax, and reversal activity by GL account, cost center, and profit center. Used by controllers for detailed GL reconciliation and cost allocation validation."
  source: "`vibe_semiconductors_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level line analysis."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator for balance verification."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the journal entry line."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line amount for FX analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversal lines to track accrual reversals."
    - name: "journal_entry_line_status"
      expr: journal_entry_line_status
      comment: "Lifecycle status of the journal entry line."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (R&D, manufacturing, SG&A) for P&L segment reporting."
  measures:
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total line amount. Core measure for GL line-level financial analysis."
    - name: "total_amount_document_currency"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total amount in document currency. Used for FX translation analysis."
    - name: "total_amount_local_currency"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total amount in local currency. Used for statutory reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal lines. Supports tax reconciliation and compliance reporting."
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Number of journal entry lines. Baseline for GL activity volume and audit scope."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal lines. Tracks accrual reversal completeness for period-close quality."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center portfolio KPIs: budget amounts and cost center governance metrics. Used by finance controllers and department heads to manage cost accountability and budget ownership across the organization."
  source: "`vibe_semiconductors_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, overhead, R&D, admin) for cost structure analysis."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category of cost center for hierarchical cost reporting."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity cost center governance."
    - name: "country_code"
      expr: country_code
      comment: "Country of the cost center for geographic cost analysis."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status for cost center portfolio management."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering operational cost centers."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level for organizational cost rollup analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional grouping for geographic cost analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount across cost centers. Primary measure for budget allocation governance."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Number of cost centers. Tracks organizational cost accountability structure."
    - name: "active_cost_center_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active cost centers. Used to assess operational cost structure size."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation execution KPIs: allocated amounts, allocation rates, and cycle coverage. Used by finance to validate overhead distribution accuracy and ensure equitable cost sharing across cost centers and business units."
  source: "`vibe_semiconductors_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly allocation monitoring."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly allocation review."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method (activity-based, percentage, headcount) for methodology governance."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis used for allocation (machine hours, headcount, revenue) for transparency."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level allocation reporting."
    - name: "cost_allocation_status"
      expr: cost_allocation_status
      comment: "Processing status of the cost allocation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversal allocations to track correction activity."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across all cycles and cost centers. Primary measure for overhead distribution analysis."
    - name: "total_allocation_base_quantity"
      expr: SUM(CAST(allocation_base_quantity AS DOUBLE))
      comment: "Total allocation base quantity (hours, units, etc.). Used to validate allocation driver volumes."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage. Monitors distribution equity and policy compliance."
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate per unit of base. Tracks rate changes and cost driver efficiency."
    - name: "cost_allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocation records. Baseline for allocation cycle completeness."
    - name: "reversal_allocation_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal allocations. Tracks correction volume and allocation quality."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Semiconductor standard cost model KPIs: wafer cost, die cost, yield-adjusted cost, and cost component breakdown. Used by finance and operations to set product pricing, evaluate fab efficiency, and manage cost-per-die targets."
  source: "`vibe_semiconductors_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-level cost benchmarking and roadmap investment decisions."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of standard cost (wafer, die, packaged unit) for cost layer analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category (material, labor, overhead) for cost structure decomposition."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity cost reporting."
    - name: "product_family"
      expr: product_family
      comment: "Product family for product-line cost analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line for detailed cost-to-revenue analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the standard cost record (active, superseded, draft)."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering current standard costs."
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in mm for cost-by-wafer-size analysis."
  measures:
    - name: "avg_total_standard_cost"
      expr: AVG(CAST(total_standard_cost AS DOUBLE))
      comment: "Average total standard cost per product. Primary pricing and margin baseline metric."
    - name: "avg_cost_per_good_die"
      expr: AVG(CAST(cost_per_good_die AS DOUBLE))
      comment: "Average cost per good die. Key semiconductor profitability metric used in pricing and yield improvement ROI."
    - name: "avg_total_wafer_cost"
      expr: AVG(CAST(total_wafer_cost AS DOUBLE))
      comment: "Average total wafer cost. Baseline for fab efficiency and cost reduction program tracking."
    - name: "avg_material_cost_per_wafer"
      expr: AVG(CAST(material_cost_per_wafer AS DOUBLE))
      comment: "Average material cost per wafer. Tracks raw material cost trends and supply chain efficiency."
    - name: "avg_equipment_depreciation_per_wafer"
      expr: AVG(CAST(equipment_depreciation_per_wafer AS DOUBLE))
      comment: "Average equipment depreciation allocated per wafer. Quantifies capital intensity of the manufacturing process."
    - name: "avg_labor_cost"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost component. Tracks workforce cost efficiency in fab operations."
    - name: "avg_overhead_cost"
      expr: AVG(CAST(overhead_cost AS DOUBLE))
      comment: "Average overhead cost component. Monitors fab overhead absorption and allocation accuracy."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage. Baseline for yield improvement program goal-setting."
    - name: "avg_mask_set_cost"
      expr: AVG(CAST(mask_set_cost AS DOUBLE))
      comment: "Average mask set cost amortized into standard cost. Tracks NRE cost recovery in product economics."
    - name: "avg_packaging_cost_per_die"
      expr: AVG(CAST(packaging_cost_per_die AS DOUBLE))
      comment: "Average packaging cost per die. Used for OSAT cost management and make-vs-buy decisions."
    - name: "standard_cost_record_count"
      expr: COUNT(1)
      comment: "Number of standard cost records. Tracks cost model coverage across products and nodes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_wafer_cost_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer cost model KPIs: total cost per wafer, cost component breakdown, yield impact, and fab overhead rates. Used by finance and fab management to optimize wafer economics, benchmark nodes, and drive cost reduction roadmaps."
  source: "`vibe_semiconductors_v1`.`finance`.`wafer_cost_model`"
  dimensions:
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-level wafer cost benchmarking."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for precise technology cost comparison."
    - name: "fab_location"
      expr: fab_location
      comment: "Fab location for geographic cost comparison and fab efficiency benchmarking."
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter for cost-by-wafer-size analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity wafer cost reporting."
    - name: "wafer_cost_model_status"
      expr: wafer_cost_model_status
      comment: "Status of the wafer cost model (active, draft, superseded)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost model for FX-adjusted comparisons."
  measures:
    - name: "avg_total_cost_per_wafer_usd"
      expr: AVG(CAST(total_cost_per_wafer_usd AS DOUBLE))
      comment: "Average total cost per wafer in USD. Primary wafer economics KPI for fab competitiveness assessment."
    - name: "avg_silicon_wafer_cost_usd"
      expr: AVG(CAST(silicon_wafer_cost_usd AS DOUBLE))
      comment: "Average silicon wafer substrate cost. Tracks raw material cost trends and supplier pricing."
    - name: "avg_equipment_depreciation_usd_per_wafer"
      expr: AVG(CAST(equipment_depreciation_usd_per_wafer AS DOUBLE))
      comment: "Average equipment depreciation per wafer. Quantifies capital intensity and drives CAPEX ROI analysis."
    - name: "avg_labor_hours_per_wafer"
      expr: AVG(CAST(labor_hours_per_wafer AS DOUBLE))
      comment: "Average labor hours per wafer. Tracks fab labor efficiency and automation ROI."
    - name: "avg_chemicals_gases_cost_usd_per_wafer"
      expr: AVG(CAST(chemicals_gases_cost_usd_per_wafer AS DOUBLE))
      comment: "Average chemicals and gases cost per wafer. Monitors consumable cost trends and supplier agreements."
    - name: "avg_fab_overhead_rate_percent"
      expr: AVG(CAST(fab_overhead_rate_percent AS DOUBLE))
      comment: "Average fab overhead rate percentage. Tracks overhead absorption efficiency across fabs."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage in cost models. Baseline for yield improvement ROI calculations."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average actual yield percentage in cost models. Compared to target to quantify yield loss cost impact."
    - name: "avg_mask_set_amortization_wafers"
      expr: AVG(CAST(mask_set_amortization_wafers AS DOUBLE))
      comment: "Average number of wafers over which mask set cost is amortized. Drives NRE recovery economics."
    - name: "avg_fixed_cost_per_wafer"
      expr: AVG(CAST(fixed_cost_per_wafer AS DOUBLE))
      comment: "Average fixed cost per wafer. Used to assess fixed cost leverage at different volume levels."
    - name: "avg_variable_cost_per_wafer"
      expr: AVG(CAST(variable_cost_per_wafer AS DOUBLE))
      comment: "Average variable cost per wafer. Tracks marginal cost trends for pricing and volume decisions."
    - name: "wafer_cost_model_count"
      expr: COUNT(1)
      comment: "Number of wafer cost models. Tracks cost modeling coverage across nodes and fabs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision KPIs: current and deferred tax amounts, effective tax rates, and credit utilization. Used by tax and finance leadership to manage global tax exposure, optimize deferred tax positions, and ensure regulatory compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`tax_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual tax provision trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for quarterly tax provision monitoring."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Tax jurisdiction for country-level tax exposure analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code for precise tax authority reporting."
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (income, deferred, withholding) for tax category analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level tax reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tax provision for governance tracking."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag for reversal provisions to track tax position corrections."
    - name: "tax_provision_status"
      expr: tax_provision_status
      comment: "Lifecycle status of the tax provision record."
  measures:
    - name: "total_provision_amount"
      expr: SUM(CAST(provision_amount AS DOUBLE))
      comment: "Total tax provision amount. Primary tax liability metric for financial reporting and cash planning."
    - name: "total_tax_expense_amount"
      expr: SUM(CAST(tax_expense_amount AS DOUBLE))
      comment: "Total income tax expense. Core P&L metric for effective tax rate calculation."
    - name: "total_taxable_income"
      expr: SUM(CAST(taxable_income AS DOUBLE))
      comment: "Total taxable income across jurisdictions. Baseline for tax burden analysis."
    - name: "total_deferred_tax_asset_amount"
      expr: SUM(CAST(deferred_tax_asset_amount AS DOUBLE))
      comment: "Total deferred tax assets. Tracks future tax benefit positions on the balance sheet."
    - name: "total_deferred_tax_liability_amount"
      expr: SUM(CAST(deferred_tax_liability_amount AS DOUBLE))
      comment: "Total deferred tax liabilities. Tracks future tax obligations on the balance sheet."
    - name: "total_tax_credit_carryforward_amount"
      expr: SUM(CAST(tax_credit_carryforward_amount AS DOUBLE))
      comment: "Total tax credit carryforward amounts. Quantifies future tax reduction potential from R&D and CHIPS Act credits."
    - name: "total_tax_credit_used_amount"
      expr: SUM(CAST(tax_credit_used_amount AS DOUBLE))
      comment: "Total tax credits utilized in the period. Tracks credit consumption rate against available carryforwards."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total tax base amount. Used to validate effective tax rate calculations."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate across jurisdictions. Key metric for global tax optimization strategy."
    - name: "avg_statutory_rate"
      expr: AVG(CAST(statutory_rate AS DOUBLE))
      comment: "Average statutory tax rate. Compared to effective rate to quantify tax planning benefit."
    - name: "tax_provision_count"
      expr: COUNT(1)
      comment: "Number of tax provision records. Tracks tax provision coverage across entities and periods."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_transfer_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer pricing KPIs: intercompany pricing amounts, margins, and markup rates. Used by tax and finance to ensure OECD arm's-length compliance, manage intercompany profitability, and support transfer pricing documentation."
  source: "`vibe_semiconductors_v1`.`finance`.`transfer_price`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of transfer pricing agreement (cost-plus, resale-minus, TNMM) for methodology governance."
    - name: "price_method"
      expr: price_method
      comment: "Transfer pricing method applied for OECD compliance classification."
    - name: "product_category"
      expr: product_category
      comment: "Product category for product-level transfer pricing analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category for service-level intercompany pricing analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level transfer pricing reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transfer price for governance tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating OECD/regulatory compliance of the transfer price."
    - name: "transfer_price_status"
      expr: transfer_price_status
      comment: "Lifecycle status of the transfer price record."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Indicates whether the transfer is subject to withholding or other taxes."
  measures:
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transfer pricing amount. Primary intercompany revenue/cost metric for consolidation and tax analysis."
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total price amount under transfer pricing agreements. Used for intercompany revenue recognition."
    - name: "avg_effective_price_per_unit"
      expr: AVG(CAST(effective_price_per_unit AS DOUBLE))
      comment: "Average effective transfer price per unit. Benchmarked against arm's-length ranges for compliance."
    - name: "avg_margin_pct"
      expr: AVG(CAST(margin_pct AS DOUBLE))
      comment: "Average transfer pricing margin percentage. Core OECD compliance metric for arm's-length validation."
    - name: "avg_markup_pct"
      expr: AVG(CAST(markup_pct AS DOUBLE))
      comment: "Average markup percentage on intercompany transactions. Used for cost-plus method compliance."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to transfer pricing transactions. Tracks withholding tax exposure."
    - name: "transfer_price_count"
      expr: COUNT(1)
      comment: "Number of transfer pricing records. Tracks intercompany pricing coverage and documentation completeness."
    - name: "non_compliant_price_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of transfer prices flagged as non-compliant. Critical risk metric for tax audit exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction KPIs: gross/net amounts, tax, elimination status, and transfer pricing margins. Used by consolidation teams and tax to manage intercompany elimination, regulatory reporting, and transfer pricing compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany activity analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany monitoring."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (sale, service, loan, royalty) for category analysis."
    - name: "company_code"
      expr: company_code
      comment: "Sending company code for entity-level intercompany reporting."
    - name: "country_of_jurisdiction"
      expr: country_of_jurisdiction
      comment: "Jurisdiction for regulatory and tax reporting."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag indicating whether the transaction is subject to consolidation elimination."
    - name: "is_eliminated"
      expr: is_eliminated
      comment: "Indicates whether the transaction has been eliminated in consolidation."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag for transactions requiring regulatory reporting."
    - name: "intercompany_transaction_status"
      expr: intercompany_transaction_status
      comment: "Lifecycle status of the intercompany transaction."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross intercompany transaction amount. Primary metric for consolidation elimination scope."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net intercompany amount after tax. Used for net intercompany position analysis."
    - name: "total_amount_tax"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on intercompany transactions. Tracks withholding and indirect tax exposure."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount. Cross-validates with gross amount for data integrity."
    - name: "avg_transfer_pricing_margin"
      expr: AVG(CAST(transfer_pricing_margin AS DOUBLE))
      comment: "Average transfer pricing margin on intercompany transactions. OECD compliance monitoring metric."
    - name: "avg_transfer_pricing_rate"
      expr: AVG(CAST(transfer_pricing_rate AS DOUBLE))
      comment: "Average transfer pricing rate applied. Tracks rate consistency across intercompany flows."
    - name: "intercompany_transaction_count"
      expr: COUNT(1)
      comment: "Number of intercompany transactions. Baseline for consolidation workload and elimination scope."
    - name: "pending_elimination_count"
      expr: COUNT(CASE WHEN elimination_flag = TRUE AND is_eliminated = FALSE THEN 1 END)
      comment: "Number of transactions flagged for elimination but not yet eliminated. Critical close-risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) agreement financial KPIs: total NRE value, billed amounts, and recovery tracking. Used by finance and sales to manage NRE revenue recognition, customer billing milestones, and R&D cost recovery."
  source: "`vibe_semiconductors_v1`.`finance`.`finance_nre_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement (design, mask, process development) for category analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the NRE agreement for pipeline and backlog management."
    - name: "recovery_method"
      expr: recovery_method
      comment: "NRE cost recovery method (milestone, time-and-materials, fixed-fee) for revenue recognition governance."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method (ASC 606 POC, milestone) for accounting compliance."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level NRE reporting."
    - name: "region_code"
      expr: region_code
      comment: "Region for geographic NRE revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE agreement for FX analysis."
    - name: "finance_nre_agreement_status"
      expr: finance_nre_agreement_status
      comment: "Lifecycle status of the finance NRE agreement."
  measures:
    - name: "total_nre_amount"
      expr: SUM(CAST(total_nre_amount AS DOUBLE))
      comment: "Total NRE agreement value. Primary metric for NRE revenue pipeline and backlog sizing."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total NRE amount billed to customers. Tracks billing progress against total agreement value."
    - name: "nre_agreement_count"
      expr: COUNT(1)
      comment: "Number of NRE agreements. Tracks NRE program activity and customer engagement volume."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_nre_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE milestone billing and revenue recognition KPIs: milestone amounts, completion rates, and revenue recognition status. Used by finance to manage NRE cash flow, billing triggers, and ASC 606 compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`finance_nre_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of NRE milestone (design complete, tape-out, qualification) for milestone category analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Completion status of the milestone for billing readiness tracking."
    - name: "finance_nre_milestone_status"
      expr: finance_nre_milestone_status
      comment: "Lifecycle status of the finance NRE milestone record."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status for billing cycle management."
    - name: "is_revenue_recognized"
      expr: is_revenue_recognized
      comment: "Flag indicating whether revenue has been recognized for this milestone."
    - name: "expense_type"
      expr: expense_type
      comment: "Type of expense associated with the milestone for cost classification."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level milestone reporting."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating regulatory compliance of the milestone billing."
  measures:
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total NRE milestone billing amount. Primary metric for NRE revenue pipeline and cash flow forecasting."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross milestone amount before tax. Used for revenue recognition calculations."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net milestone amount after tax. Used for net revenue reporting."
    - name: "total_amount_tax"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on NRE milestones. Tracks indirect tax on NRE billing."
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of NRE milestones. Tracks billing event volume and program complexity."
    - name: "recognized_milestone_count"
      expr: COUNT(CASE WHEN is_revenue_recognized = TRUE THEN 1 END)
      comment: "Number of milestones with recognized revenue. Tracks ASC 606 revenue recognition completeness."
    - name: "pending_recognition_count"
      expr: COUNT(CASE WHEN is_revenue_recognized = FALSE THEN 1 END)
      comment: "Number of milestones with unrecognized revenue. Identifies deferred revenue backlog requiring recognition action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_rd_capitalization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "R&D capitalization KPIs: capitalized amounts, expensed amounts, and amortization tracking. Used by finance and R&D leadership to manage ASC 730/IAS 38 compliance, IP asset creation, and technology investment capitalization decisions."
  source: "`vibe_semiconductors_v1`.`finance`.`rd_capitalization`"
  dimensions:
    - name: "capitalized_asset_type"
      expr: capitalized_asset_type
      comment: "Type of capitalized R&D asset (IP core, PDK, process technology) for asset category analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual R&D capitalization trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly capitalization monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Amortization method for capitalized R&D assets."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level R&D capitalization reporting."
    - name: "compliance_regulation"
      expr: compliance_regulation
      comment: "Accounting standard governing the capitalization (ASC 730, IAS 38, CHIPS Act)."
    - name: "rd_capitalization_status"
      expr: rd_capitalization_status
      comment: "Lifecycle status of the R&D capitalization record."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag for reversal capitalizations to track correction activity."
    - name: "external_audit_flag"
      expr: external_audit_flag
      comment: "Flag indicating external audit review of the capitalization."
  measures:
    - name: "total_capitalized_amount"
      expr: SUM(CAST(capitalized_amount AS DOUBLE))
      comment: "Total R&D costs capitalized as intangible assets. Primary metric for IP asset creation and balance sheet impact."
    - name: "total_expensed_amount"
      expr: SUM(CAST(expensed_amount AS DOUBLE))
      comment: "Total R&D costs expensed in the period. Tracks P&L R&D expense and capitalization ratio."
    - name: "total_original_expense_amount"
      expr: SUM(CAST(original_expense_amount AS DOUBLE))
      comment: "Total original R&D expense before capitalization decision. Used to compute capitalization rate."
    - name: "rd_capitalization_count"
      expr: COUNT(1)
      comment: "Number of R&D capitalization events. Tracks IP creation activity volume."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of capitalization reversals. Tracks correction activity and capitalization quality."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_amortization_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amortization schedule KPIs: period amortization amounts, accumulated amortization, and remaining balance tracking. Used by finance to manage intangible asset amortization, validate period-close charges, and forecast future amortization expense."
  source: "`vibe_semiconductors_v1`.`finance`.`amortization_schedule`"
  dimensions:
    - name: "amortization_method"
      expr: amortization_method
      comment: "Amortization method (straight-line, units-of-production) for policy compliance analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of amortization schedule (IP, software, leasehold) for asset category analysis."
    - name: "period_type"
      expr: period_type
      comment: "Period type (monthly, quarterly, annual) for schedule granularity analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level amortization reporting."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the amortization schedule (active, completed, suspended)."
    - name: "amortization_schedule_status"
      expr: amortization_schedule_status
      comment: "Lifecycle status of the amortization schedule record."
    - name: "tax_effect_flag"
      expr: tax_effect_flag
      comment: "Flag indicating whether the amortization has a tax effect for deferred tax analysis."
    - name: "depreciation_category"
      expr: depreciation_category
      comment: "Depreciation/amortization category for financial reporting classification."
  measures:
    - name: "total_period_amount"
      expr: SUM(CAST(period_amount AS DOUBLE))
      comment: "Total amortization charged in the period. Primary P&L impact metric for intangible asset expense."
    - name: "total_amortized_amount"
      expr: SUM(CAST(amortized_amount AS DOUBLE))
      comment: "Total cumulative amortization charged to date. Tracks intangible asset consumption."
    - name: "total_accumulated_amortization"
      expr: SUM(CAST(accumulated_amortization AS DOUBLE))
      comment: "Total accumulated amortization on the balance sheet. Key intangible asset valuation metric."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining unamortized balance. Represents future amortization expense commitment."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total original amount subject to amortization. Baseline for amortization coverage analysis."
    - name: "amortization_schedule_count"
      expr: COUNT(1)
      comment: "Number of amortization schedules. Tracks intangible asset portfolio size and amortization management complexity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_consolidation_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidation entry KPIs: elimination amounts, adjustment amounts, and intercompany consolidation activity. Used by group finance to manage period-close consolidation, validate elimination completeness, and ensure group financial statement accuracy."
  source: "`vibe_semiconductors_v1`.`finance`.`consolidation_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual consolidation activity analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly consolidation monitoring."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of consolidation entry (elimination, adjustment, reclassification) for entry classification."
    - name: "consolidation_method"
      expr: consolidation_method
      comment: "Consolidation method (full, proportional, equity) for methodology governance."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level consolidation reporting."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Flag for elimination entries to track intercompany elimination completeness."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag for reversal consolidation entries."
    - name: "consolidation_entry_status"
      expr: consolidation_entry_status
      comment: "Lifecycle status of the consolidation entry."
  measures:
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total consolidation entry amount. Primary metric for consolidation adjustment scope."
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross consolidation amount before adjustments. Used for elimination completeness validation."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net consolidation amount after adjustments. Represents group-level financial impact."
    - name: "total_amount_adjustment"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total adjustment amounts in consolidation entries. Tracks consolidation correction volume."
    - name: "consolidation_entry_count"
      expr: COUNT(1)
      comment: "Number of consolidation entries. Baseline for close workload and consolidation complexity."
    - name: "elimination_entry_count"
      expr: COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END)
      comment: "Number of elimination entries. Tracks intercompany elimination completeness for group reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center financial KPIs: budget amounts, actual spend, and variance by product line, technology node, and geography. Used by business unit leaders and CFO to manage P&L accountability and profitability by segment."
  source: "`vibe_semiconductors_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (product line, geography, technology) for P&L segmentation."
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category of profit center for hierarchical P&L reporting."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for node-level profitability analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line for product-level P&L management."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional profitability analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level profit center reporting."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Status of the profit center (active, inactive, merged)."
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Flag indicating whether the profit center is included in group consolidation."
    - name: "sox_compliant"
      expr: sox_compliant
      comment: "SOX compliance flag for internal controls governance."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across profit centers. Baseline for P&L budget governance."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend recorded against profit centers. Primary P&L execution metric."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance across profit centers. Signals P&L performance gaps requiring management action."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average cost allocation percentage to profit centers. Monitors overhead distribution equity."
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Number of profit centers. Tracks P&L accountability structure size."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS element project cost KPIs: planned vs. actual costs, budget utilization, and project financial health. Used by project finance and R&D management to track project cost performance and capital expenditure governance."
  source: "`vibe_semiconductors_v1`.`finance`.`wbs_element`"
  dimensions:
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase (design, development, qualification, production) for phase-level cost analysis."
    - name: "wbs_element_type"
      expr: wbs_element_type
      comment: "Type of WBS element for project structure analysis."
    - name: "wbs_element_level"
      expr: wbs_element_level
      comment: "Hierarchy level of the WBS element for rollup analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level project cost reporting."
    - name: "wbs_element_status"
      expr: wbs_element_status
      comment: "Status of the WBS element (open, closed, locked)."
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Flag indicating CAPEX vs. OPEX classification for investment governance."
    - name: "r_and_d_capitalization_flag"
      expr: r_and_d_capitalization_flag
      comment: "Flag for R&D capitalization eligibility under ASC 730/IAS 38."
    - name: "billing_element_flag"
      expr: billing_element_flag
      comment: "Flag indicating whether the WBS element is a billing element for NRE revenue tracking."
  measures:
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned project cost across WBS elements. Baseline for project budget governance."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred on WBS elements. Primary project execution cost metric."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget for WBS elements. Used for budget vs. actual variance analysis."
    - name: "wbs_element_count"
      expr: COUNT(1)
      comment: "Number of WBS elements. Tracks project structure complexity and cost accountability granularity."
    - name: "capex_element_count"
      expr: COUNT(CASE WHEN is_capital_expenditure = TRUE THEN 1 END)
      comment: "Number of CAPEX WBS elements. Tracks capital project scope and investment governance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_allocation_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation cycle governance KPIs: allocation percentages, cycle activity, and automation coverage. Used by finance controllers to manage overhead allocation cycle completeness, frequency, and policy compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`allocation_cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of allocation cycle (overhead, service, activity-based) for methodology governance."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method applied in the cycle for policy analysis."
    - name: "allocation_frequency"
      expr: allocation_frequency
      comment: "Frequency of the allocation cycle (monthly, quarterly) for scheduling governance."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level cycle reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for cycle timing analysis."
    - name: "allocation_cycle_status"
      expr: allocation_cycle_status
      comment: "Status of the allocation cycle (active, completed, suspended)."
    - name: "is_active"
      expr: is_active
      comment: "Active flag for filtering operational allocation cycles."
    - name: "is_automatic"
      expr: is_automatic
      comment: "Flag indicating automated vs. manual allocation cycles for automation coverage analysis."
  measures:
    - name: "avg_default_allocation_percentage"
      expr: AVG(CAST(default_allocation_percentage AS DOUBLE))
      comment: "Average default allocation percentage across cycles. Monitors allocation rate consistency and policy compliance."
    - name: "allocation_cycle_count"
      expr: COUNT(1)
      comment: "Number of allocation cycles. Tracks overhead distribution governance coverage."
    - name: "automated_cycle_count"
      expr: COUNT(CASE WHEN is_automatic = TRUE THEN 1 END)
      comment: "Number of automated allocation cycles. Tracks finance automation coverage and manual effort reduction."
    - name: "active_cycle_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active allocation cycles. Tracks operational allocation governance scope."
$$;