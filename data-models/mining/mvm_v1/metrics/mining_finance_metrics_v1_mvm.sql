-- Metric views for domain: finance | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure budget performance metrics tracking approved spend, actual spend, forecast-at-completion, and NPV/IRR project economics. Enables CFO and project finance teams to monitor capital allocation efficiency, budget overruns, and sustaining vs growth capex split across mine sites and fiscal periods."
  source: "`mining_ecm`.`finance`.`capex_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capex budget record, used for year-on-year capital spend trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) within the fiscal year for intra-year capex tracking."
    - name: "capex_category"
      expr: capex_category
      comment: "Category of capital expenditure (e.g. sustaining, growth, exploration) for portfolio analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Phase of the capital project (e.g. feasibility, construction, commissioning) for lifecycle tracking."
    - name: "is_sustaining_capex"
      expr: is_sustaining_capex
      comment: "Flag indicating whether the capex is sustaining (maintaining existing operations) vs growth capital."
    - name: "is_lom_capital"
      expr: is_lom_capital
      comment: "Flag indicating whether the capex is included in the Life-of-Mine capital plan."
    - name: "budget_status"
      expr: budget_status
      comment: "Current approval and execution status of the capex budget (e.g. approved, pending, closed)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the capex budget amounts are denominated."
    - name: "project_code"
      expr: project_code
      comment: "Unique project identifier for drilling down to individual capital projects."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Governance body or individual who approved the capex budget, supporting audit and controls reporting."
  measures:
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capital budget amount. Baseline for measuring capital allocation and authorisation levels."
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capital expenditure incurred to date. Compared against approved budget to identify overruns."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (contracted but not yet spent) capital. Represents near-term cash obligations."
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion_amount AS DOUBLE))
      comment: "Total forecast cost at project completion. Key indicator of whether projects will land within approved budget."
    - name: "total_revised_budget_amount"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after amendments. Tracks scope changes and budget reforecasting activity."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves held across capital projects. Indicates risk provisioning in the capital portfolio."
    - name: "total_npv_amount"
      expr: SUM(CAST(npv_amount AS DOUBLE))
      comment: "Aggregate Net Present Value across capital projects. Primary value-creation metric for capital investment decisions."
    - name: "avg_irr_pct"
      expr: AVG(CAST(irr_pct AS DOUBLE))
      comment: "Average Internal Rate of Return across capital projects. Measures portfolio-level return on capital investment."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate applied across capital project valuations. Context for interpreting NPV calculations."
    - name: "budget_variance_amount"
      expr: SUM(forecast_at_completion_amount - approved_budget_amount)
      comment: "Aggregate variance between forecast-at-completion and approved budget. Positive values indicate cost overruns requiring executive attention."
    - name: "remaining_budget_to_spend"
      expr: SUM(approved_budget_amount - actual_spend_amount)
      comment: "Remaining approved budget not yet spent. Indicates capital deployment pace and potential underspend risk."
    - name: "total_aisc_contribution_usd"
      expr: SUM(CAST(aisc_contribution_usd AS DOUBLE))
      comment: "Total sustaining capex contribution to All-In Sustaining Cost (AISC) in USD. Critical input to the industry-standard AISC cost metric reported to investors."
    - name: "capex_project_count"
      expr: COUNT(DISTINCT project_code)
      comment: "Number of distinct capital projects in the portfolio. Indicates capital programme breadth and complexity."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_opex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating expenditure budget performance metrics covering original budget, revised budget, actual spend, forecast, and variance. Enables operations finance and CFO teams to monitor cost control, budget adherence, and opex efficiency across mine sites, cost centres, and commodity types."
  source: "`mining_ecm`.`finance`.`opex_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opex budget for year-on-year cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year for monthly/quarterly opex tracking."
    - name: "opex_classification"
      expr: opex_classification
      comment: "Classification of operating expenditure (e.g. mining, processing, G&A) for cost structure analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category grouping for opex (e.g. labour, consumables, maintenance) enabling cost driver analysis."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type associated with the opex budget for commodity-level cost benchmarking."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and execution status of the opex budget record."
    - name: "is_capitalised"
      expr: is_capitalised
      comment: "Flag indicating whether the opex item has been capitalised, affecting P&L vs balance sheet treatment."
    - name: "is_lom_included"
      expr: is_lom_included
      comment: "Flag indicating whether the opex is included in the Life-of-Mine plan for long-range cost modelling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the opex budget amounts."
    - name: "budget_version"
      expr: budget_version
      comment: "Version of the budget (e.g. original, reforecast 1, reforecast 2) for budget evolution tracking."
  measures:
    - name: "total_original_budget_amount"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved opex budget. Baseline for measuring cost discipline against initial plan."
    - name: "total_revised_budget_amount"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised opex budget after amendments. Tracks reforecasting activity and scope changes."
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual operating expenditure incurred. Primary cost performance measure against budget."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast opex for the period. Forward-looking cost indicator for financial planning."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed opex (contracted but not yet invoiced). Represents near-term cost obligations."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budget opex. Negative values indicate underspend; positive values indicate cost overruns requiring management action."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and budgeted opex. Normalised cost performance indicator for cross-site comparison."
    - name: "total_budget_quantity"
      expr: SUM(CAST(budget_quantity AS DOUBLE))
      comment: "Total budgeted quantity (e.g. tonnes mined, hours worked) underpinning the opex budget. Enables unit cost analysis when combined with spend."
    - name: "opex_budget_line_count"
      expr: COUNT(1)
      comment: "Number of opex budget line items. Indicates budget granularity and planning complexity."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_cost_performance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mine-level cost performance metrics including unit costs, AISC components, mining and processing opex, and variance to budget. This is the primary executive dashboard source for C1 cash cost and AISC reporting — the two most critical cost metrics in the mining industry used for investor reporting and operational benchmarking."
  source: "`mining_ecm`.`finance`.`cost_performance_report`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost performance report for year-on-year cost trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost performance tracking."
    - name: "commodity"
      expr: commodity
      comment: "Commodity type (e.g. copper, gold, iron ore) for commodity-level cost benchmarking."
    - name: "report_type"
      expr: report_type
      comment: "Type of cost performance report (e.g. actual, forecast, budget) for report category filtering."
    - name: "report_status"
      expr: report_status
      comment: "Approval status of the cost performance report (e.g. draft, approved, published)."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Granularity of the reporting period (e.g. monthly, quarterly, annual)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which cost performance amounts are reported."
    - name: "is_guidance_met"
      expr: is_guidance_met
      comment: "Flag indicating whether the AISC guidance range was met in the period. Key investor-facing performance indicator."
    - name: "production_unit_of_measure"
      expr: production_unit_of_measure
      comment: "Unit of measure for production volume (e.g. tonnes, oz) for unit cost normalisation."
    - name: "cost_variance_driver"
      expr: cost_variance_driver
      comment: "Primary driver of cost variance (e.g. volume, price, efficiency) for root cause analysis."
  measures:
    - name: "avg_unit_cost_result"
      expr: AVG(CAST(unit_cost_result AS DOUBLE))
      comment: "Average unit cost of production (e.g. $/t, $/oz). The most fundamental mining cost efficiency metric used for benchmarking and investor reporting."
    - name: "avg_budget_unit_cost"
      expr: AVG(CAST(budget_unit_cost AS DOUBLE))
      comment: "Average budgeted unit cost of production. Baseline for measuring cost performance against plan."
    - name: "avg_prior_period_unit_cost"
      expr: AVG(CAST(prior_period_unit_cost AS DOUBLE))
      comment: "Average unit cost from the prior period. Enables period-on-period cost trend analysis."
    - name: "total_mining_opex"
      expr: SUM(CAST(mining_opex AS DOUBLE))
      comment: "Total mining operating expenditure. Primary cost driver for open-cut and underground mining operations."
    - name: "total_processing_opex"
      expr: SUM(CAST(processing_opex AS DOUBLE))
      comment: "Total processing/milling operating expenditure. Key cost component for mineral processing efficiency analysis."
    - name: "total_ga_cost"
      expr: SUM(CAST(ga_cost AS DOUBLE))
      comment: "Total general and administrative cost. Overhead cost component included in AISC and C1 cost calculations."
    - name: "total_royalty_cost"
      expr: SUM(CAST(royalty_cost AS DOUBLE))
      comment: "Total royalty cost incurred. Government and private royalties are a significant and variable cost component in mining."
    - name: "total_sustaining_capex"
      expr: SUM(CAST(sustaining_capex AS DOUBLE))
      comment: "Total sustaining capital expenditure included in AISC. Critical component of the World Gold Council AISC standard metric."
    - name: "total_byproduct_credit"
      expr: SUM(CAST(byproduct_credit AS DOUBLE))
      comment: "Total byproduct revenue credits applied to reduce net cost. Byproduct credits are a key lever in C1 and AISC cost reduction."
    - name: "total_refining_and_transport_cost"
      expr: SUM(CAST(refining_and_transport_cost AS DOUBLE))
      comment: "Total refining and transport costs. Included in AISC and reflects logistics and offtake cost efficiency."
    - name: "total_cost_usd"
      expr: SUM(CAST(total_cost_usd AS DOUBLE))
      comment: "Total all-in cost in USD across all cost components. Enables cross-currency, cross-site cost comparison in a common currency."
    - name: "total_production_volume"
      expr: SUM(CAST(production_volume AS DOUBLE))
      comment: "Total production volume in the reporting period. Denominator for unit cost calculations and throughput performance."
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average metallurgical recovery rate. Directly impacts unit cost — lower recovery means higher cost per unit of payable metal."
    - name: "avg_head_grade"
      expr: AVG(CAST(head_grade AS DOUBLE))
      comment: "Average ore head grade processed. Key driver of unit cost and revenue — declining grades are a primary cost escalation risk."
    - name: "avg_strip_ratio"
      expr: AVG(CAST(strip_ratio AS DOUBLE))
      comment: "Average strip ratio (waste to ore). Primary driver of open-cut mining cost — higher strip ratios increase mining opex per tonne of ore."
    - name: "avg_variance_to_budget_pct"
      expr: AVG(CAST(variance_to_budget_pct AS DOUBLE))
      comment: "Average percentage variance of actual unit cost vs budget. Normalised cost performance indicator for management reporting."
    - name: "avg_aisc_guidance_midpoint"
      expr: AVG((aisc_guidance_high + aisc_guidance_low) / 2.0)
      comment: "Average midpoint of the AISC guidance range. Provides the market-facing cost target against which actual AISC is benchmarked."
    - name: "guidance_met_period_count"
      expr: COUNT(CASE WHEN is_guidance_met = TRUE THEN 1 END)
      comment: "Number of reporting periods where AISC guidance was met. Tracks consistency of cost guidance delivery — a key investor confidence metric."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for financial control, period-close monitoring, and intercompany transaction analysis. Enables finance controllers to monitor posting volumes, reversal rates, and transaction currency exposure across fiscal periods and legal entities."
  source: "`mining_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for period-based financial analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for monthly close monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g. vendor invoice, manual journal, accrual) for transaction classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the journal entry for FX exposure analysis."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local (functional) currency of the posting entity."
    - name: "ledger_group"
      expr: ledger_group
      comment: "Ledger group (e.g. leading ledger, IFRS, local GAAP) for multi-GAAP reporting analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag identifying intercompany journal entries requiring elimination in group consolidation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag identifying reversal journal entries. High reversal rates may indicate control weaknesses."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area classification of the journal entry for segment reporting."
  measures:
    - name: "total_transaction_currency_amount"
      expr: SUM(CAST(transaction_currency_amount AS DOUBLE))
      comment: "Total transaction currency amount posted across journal entries. Measures gross financial activity volume in the period."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total local currency amount posted. Primary measure for statutory and management reporting in functional currency."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline volume metric for period-close workload and audit sampling."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. Elevated reversal counts signal posting errors and control weaknesses requiring investigation."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Drives group consolidation elimination workload and intercompany reconciliation effort."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across journal entries. Monitors FX rate consistency and translation risk in the period."
    - name: "distinct_document_count"
      expr: COUNT(DISTINCT document_number)
      comment: "Count of distinct source documents posted. Measures transaction processing throughput for the period."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio metrics covering net book value, accumulated depreciation, impairment, and asset lifecycle. Enables CFO and asset management teams to monitor capital asset base health, depreciation adequacy, and impairment exposure — critical for IFRS balance sheet integrity and mine closure planning."
  source: "`mining_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of fixed asset (e.g. mining equipment, plant, infrastructure, land) for asset class analysis."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g. active, under construction, disposed, impaired) for lifecycle tracking."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. straight-line, units-of-production) for accounting policy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which asset values are recorded."
    - name: "location_code"
      expr: location_code
      comment: "Physical location code of the asset for site-level asset base analysis."
    - name: "ifrs6_exploration_flag"
      expr: ifrs6_exploration_flag
      comment: "Flag indicating whether the asset is classified under IFRS 6 exploration and evaluation accounting."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area to which the asset is assigned for segment-level asset reporting."
    - name: "depreciation_key"
      expr: depreciation_key
      comment: "SAP depreciation key controlling the depreciation calculation method and useful life parameters."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Represents the historical capital investment in the asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (NBV) of fixed assets. Primary balance sheet measure of the capital asset base after depreciation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation charged against fixed assets. Indicates asset age and remaining economic life of the portfolio."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognised on fixed assets. Critical IFRS metric — large impairments signal mine viability concerns and trigger investor scrutiny."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of fixed assets at end of useful life. Affects depreciation charge calculations."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments applied to fixed assets. Tracks fair value uplift or write-downs under revaluation model."
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Compared against NBV to identify under-insurance risk in the asset portfolio."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life of fixed assets in years. Indicates asset fleet age and future capex replacement requirements."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average total useful life assigned to fixed assets. Context for depreciation policy and asset longevity benchmarking."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'Active' THEN 1 END)
      comment: "Number of active fixed assets in the portfolio. Baseline for asset utilisation and maintenance planning."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_loss > 0 THEN 1 END)
      comment: "Number of assets with recognised impairment losses. Concentration of impaired assets signals portfolio risk requiring executive review."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking the distribution of shared costs across profit centres, cost centres, and WBS elements. Enables management accountants and operations finance teams to monitor AISC and C1 cost component allocations, intercompany cost flows, and allocation basis efficiency."
  source: "`mining_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost allocation for period-based cost distribution analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost allocation for monthly cost distribution monitoring."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of cost allocation (e.g. direct, indirect, statistical) for allocation methodology analysis."
    - name: "allocation_basis_type"
      expr: allocation_basis_type
      comment: "Basis used to drive the allocation (e.g. headcount, machine hours, production volume) for allocation fairness review."
    - name: "aisc_component"
      expr: aisc_component
      comment: "AISC cost component category to which the allocation contributes. Enables AISC build-up analysis by component."
    - name: "c1_cost_component"
      expr: c1_cost_component
      comment: "C1 cash cost component category. Enables C1 cost build-up analysis by cost driver."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the allocated amount for cost structure analysis."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity to which the allocated cost is attributed for commodity-level cost analysis."
    - name: "allocation_run_type"
      expr: allocation_run_type
      comment: "Type of allocation run (e.g. actual, plan, simulation) for distinguishing actual vs planned cost distributions."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag identifying intercompany cost allocations requiring elimination in group consolidation."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag identifying reversal allocation entries. High reversal rates indicate allocation configuration issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocated amounts."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated in local currency. Primary measure of cost distribution volume across the organisation."
    - name: "total_allocated_amount_usd"
      expr: SUM(CAST(allocated_amount_usd AS DOUBLE))
      comment: "Total cost allocated in USD. Enables cross-currency, cross-entity cost allocation comparison."
    - name: "avg_activity_rate"
      expr: AVG(CAST(activity_rate AS DOUBLE))
      comment: "Average activity rate applied in cost allocations. Monitors rate adequacy and identifies over/under-absorption of shared costs."
    - name: "total_allocation_basis_value"
      expr: SUM(CAST(allocation_basis_value AS DOUBLE))
      comment: "Total allocation basis quantity (e.g. total machine hours, headcount) driving cost distributions. Validates allocation driver volumes."
    - name: "allocation_line_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation lines processed. Measures allocation run completeness and processing volume."
    - name: "intercompany_allocated_amount_usd"
      expr: SUM(CASE WHEN is_intercompany = TRUE THEN allocated_amount_usd ELSE 0 END)
      comment: "Total intercompany cost allocations in USD. Drives group consolidation elimination entries and intercompany reconciliation."
    - name: "reversal_allocated_amount"
      expr: SUM(CASE WHEN is_reversal = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total amount in reversal allocation entries. Elevated reversal amounts indicate allocation errors requiring investigation."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_rehabilitation_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mine rehabilitation and closure provision metrics tracking provision balances, undiscounted cost estimates, regulatory bond adequacy, and disturbance area. Enables CFO, sustainability, and legal teams to monitor IFRS closure liability adequacy, regulatory compliance, and environmental financial assurance — a material balance sheet risk in mining."
  source: "`mining_ecm`.`finance`.`rehabilitation_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the rehabilitation provision for year-on-year liability trend analysis."
    - name: "provision_type"
      expr: provision_type
      comment: "Type of rehabilitation provision (e.g. mine closure, tailings, waste dump) for liability classification."
    - name: "provision_status"
      expr: provision_status
      comment: "Current status of the provision (e.g. active, under review, settled) for lifecycle monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the provision is recorded."
    - name: "aisc_inclusion_flag"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether the rehabilitation provision is included in AISC cost reporting."
    - name: "tsf_related_flag"
      expr: tsf_related_flag
      comment: "Flag identifying provisions related to Tailings Storage Facilities (TSF). TSF liabilities carry heightened regulatory and reputational risk."
    - name: "opex_capex_classification"
      expr: opex_capex_classification
      comment: "Classification of rehabilitation expenditure as opex or capex for P&L vs balance sheet treatment."
    - name: "bond_instrument_type"
      expr: bond_instrument_type
      comment: "Type of financial assurance instrument (e.g. bank guarantee, cash bond, insurance bond) held for regulatory compliance."
    - name: "cost_estimate_basis"
      expr: cost_estimate_basis
      comment: "Basis of the cost estimate (e.g. detailed engineering, parametric, analogous) indicating estimate confidence level."
  measures:
    - name: "total_closing_balance_amount"
      expr: SUM(CAST(closing_balance_amount AS DOUBLE))
      comment: "Total closing balance of rehabilitation provisions. Primary IFRS balance sheet liability measure for mine closure obligations."
    - name: "total_opening_balance_amount"
      expr: SUM(CAST(opening_balance_amount AS DOUBLE))
      comment: "Total opening balance of rehabilitation provisions. Baseline for period movement analysis."
    - name: "total_new_provision_amount"
      expr: SUM(CAST(new_provision_amount AS DOUBLE))
      comment: "Total new provisions recognised in the period. Indicates new disturbance areas and expanding closure liabilities."
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total revisions to existing provisions. Large revisions signal changes in closure cost estimates requiring board-level disclosure."
    - name: "total_unwinding_of_discount"
      expr: SUM(CAST(unwinding_of_discount_amount AS DOUBLE))
      comment: "Total unwinding of discount (accretion expense) on rehabilitation provisions. P&L charge reflecting the time value of money on closure liabilities."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual rehabilitation expenditure incurred. Measures closure activity progress against provision balances."
    - name: "total_undiscounted_cost_estimate"
      expr: SUM(CAST(undiscounted_cost_estimate AS DOUBLE))
      comment: "Total undiscounted rehabilitation cost estimate. Represents the gross future cash outflow for mine closure before discounting."
    - name: "total_regulatory_bond_amount"
      expr: SUM(CAST(regulatory_bond_amount AS DOUBLE))
      comment: "Total regulatory financial assurance bonds held. Compared against provision balances to identify bond coverage gaps and regulatory compliance risk."
    - name: "total_disturbance_area_ha"
      expr: SUM(CAST(disturbance_area_ha AS DOUBLE))
      comment: "Total disturbed area in hectares requiring rehabilitation. Primary physical driver of closure cost estimates."
    - name: "total_rehabilitated_area_ha"
      expr: SUM(CAST(rehabilitation_completed_area_ha AS DOUBLE))
      comment: "Total area rehabilitated to date in hectares. Measures closure programme progress and reduces future liability exposure."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate applied to rehabilitation provisions. Sensitivity driver — lower rates increase provision balances."
    - name: "avg_inflation_rate_pct"
      expr: AVG(CAST(inflation_rate_pct AS DOUBLE))
      comment: "Average inflation rate applied to rehabilitation cost estimates. Escalation assumption driving future cost growth in closure liabilities."
    - name: "provision_site_count"
      expr: COUNT(DISTINCT provision_reference)
      comment: "Number of distinct rehabilitation provision references. Indicates breadth of closure liability portfolio across the asset base."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_royalty_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty obligation metrics tracking accrued liabilities, payment history, rates, and dispute exposure. Enables CFO and legal teams to monitor royalty cost burden, government and private royalty compliance, and disputed amounts — royalties are a significant and variable cost component in mining operations."
  source: "`mining_ecm`.`finance`.`royalty_obligation`"
  dimensions:
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty (e.g. ad valorem, specific rate, profit-based) for royalty structure analysis."
    - name: "commodity"
      expr: commodity
      comment: "Commodity to which the royalty obligation applies for commodity-level royalty cost analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the royalty obligation for regulatory compliance monitoring."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of royalty payee (e.g. government, private landowner, indigenous group) for royalty counterparty analysis."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the royalty obligation (e.g. active, disputed, settled, expired)."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag identifying royalty obligations under dispute. Disputed royalties represent contingent liabilities requiring legal and financial monitoring."
    - name: "aisc_inclusion_flag"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether the royalty is included in AISC cost reporting."
    - name: "c1_cost_inclusion_flag"
      expr: c1_cost_inclusion_flag
      comment: "Flag indicating whether the royalty is included in C1 cash cost reporting."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of royalty payments (e.g. monthly, quarterly, annually) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the royalty obligation is denominated."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for royalty calculation (e.g. revenue, profit, production volume) for rate sensitivity analysis."
  measures:
    - name: "total_accrued_liability_amount"
      expr: SUM(CAST(accrued_liability_amount AS DOUBLE))
      comment: "Total accrued royalty liability. Primary balance sheet measure of outstanding royalty obligations."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent royalty payments made. Indicates recent cash outflow for royalty obligations."
    - name: "total_minimum_royalty_amount"
      expr: SUM(CAST(minimum_royalty_amount AS DOUBLE))
      comment: "Total minimum royalty commitments. Represents the floor royalty cost regardless of production levels."
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across obligations. Benchmarks effective royalty burden and informs jurisdiction-level cost competitiveness."
    - name: "disputed_obligation_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of royalty obligations under dispute. Concentration of disputes signals regulatory relationship risk and contingent liability exposure."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN obligation_status = 'Active' THEN 1 END)
      comment: "Number of active royalty obligations. Measures the breadth of the royalty commitment portfolio."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with royalty obligations. Indicates regulatory complexity and multi-jurisdiction compliance burden."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice processing and accounts payable metrics covering invoice volumes, payment performance, dispute rates, and tax exposure. Enables procurement finance and CFO teams to monitor payment terms compliance, dispute resolution efficiency, and working capital management."
  source: "`mining_ecm`.`finance`.`vendor_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the vendor invoice for period-based payables analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the vendor invoice for monthly payables monitoring."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. posted, parked, blocked, paid) for payables workflow monitoring."
    - name: "opex_capex_classification"
      expr: opex_capex_classification
      comment: "Classification of the invoice as opex or capex for P&L vs balance sheet coding accuracy."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type associated with the invoice for commodity-level cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. EFT, cheque, wire transfer) for payment channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (e.g. Net 30, Net 60) for working capital and DPO analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag identifying invoices under dispute. Disputed invoices delay payment and strain supplier relationships."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of invoice disputes (e.g. open, resolved, escalated) for dispute resolution tracking."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, GR, invoice) for procure-to-pay control monitoring."
    - name: "aisc_inclusion_flag"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether the invoice cost is included in AISC reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the vendor invoice for FX exposure analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross vendor invoice amount. Primary measure of accounts payable liability and procurement spend volume."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_invoice_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Actual payables obligation after early payment discount capture."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total invoice amount in functional currency. Enables cross-currency payables comparison in a common currency."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax (GST/VAT/withholding) on vendor invoices. Monitors tax cash flow and input tax credit recovery."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimisation through prompt payment."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of invoices under dispute. Elevated disputed amounts signal procurement or delivery quality issues and delay cash outflows."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed. Baseline for accounts payable workload and processing efficiency."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute. Dispute rate (disputed/total) is a key supplier relationship and procurement quality metric."
    - name: "three_way_match_fail_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Failed' THEN 1 END)
      comment: "Number of invoices failing three-way match. Match failures indicate procurement control weaknesses and delay payment processing."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to vendor invoices. Monitors FX translation consistency across the payables portfolio."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoiced. Measures supplier base breadth and concentration risk in the supply chain."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_project_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project and mine valuation metrics covering NPV, IRR, payback period, breakeven price, and capital intensity. Enables executive teams and investment committees to evaluate project economics, compare investment alternatives, and monitor the value of the project pipeline — the primary tool for capital allocation decisions in mining."
  source: "`mining_ecm`.`finance`.`project_valuation`"
  dimensions:
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g. pre-feasibility, feasibility, definitive feasibility) indicating study maturity."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of the valuation (e.g. draft, approved, superseded) for version control."
    - name: "study_stage"
      expr: study_stage
      comment: "Stage of the project study (e.g. scoping, PFS, DFS, execution) for project maturity classification."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type of the project for commodity portfolio analysis."
    - name: "ore_reserve_category"
      expr: ore_reserve_category
      comment: "JORC ore reserve category (e.g. Proved, Probable) underpinning the valuation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the valuation is expressed."
    - name: "price_basis"
      expr: price_basis
      comment: "Commodity price basis used in the valuation (e.g. spot, consensus, long-term) for sensitivity context."
    - name: "version_number"
      expr: version_number
      comment: "Version of the project valuation for tracking valuation evolution over time."
  measures:
    - name: "total_npv_base_musd"
      expr: SUM(CAST(npv_base_musd AS DOUBLE))
      comment: "Total base-case NPV across projects in USD millions. Primary value creation metric for the project portfolio — drives capital allocation decisions."
    - name: "total_npv_high_musd"
      expr: SUM(CAST(npv_high_musd AS DOUBLE))
      comment: "Total high-case NPV across projects. Represents upside scenario value for portfolio optimism analysis."
    - name: "total_npv_low_musd"
      expr: SUM(CAST(npv_low_musd AS DOUBLE))
      comment: "Total low-case NPV across projects. Represents downside scenario value for risk-adjusted portfolio assessment."
    - name: "total_capex_musd"
      expr: SUM(CAST(capex_total_musd AS DOUBLE))
      comment: "Total capital expenditure requirement across projects in USD millions. Primary capital demand metric for funding and balance sheet planning."
    - name: "avg_irr_pct"
      expr: AVG(CAST(irr_pct AS DOUBLE))
      comment: "Average Internal Rate of Return across projects. Portfolio-level return metric compared against hurdle rate for investment decisions."
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years across projects. Measures capital recovery speed — shorter payback reduces investment risk."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate (WACC) applied across project valuations. Context for interpreting NPV results."
    - name: "avg_breakeven_price_usd"
      expr: AVG(CAST(breakeven_price_usd AS DOUBLE))
      comment: "Average commodity breakeven price across projects. Measures price floor below which projects destroy value — critical for commodity price risk assessment."
    - name: "avg_aisc_usd"
      expr: AVG(CAST(aisc_usd AS DOUBLE))
      comment: "Average AISC per project valuation in USD. Enables comparison of project cost competitiveness at the portfolio level."
    - name: "avg_c1_cash_cost_usd"
      expr: AVG(CAST(c1_cash_cost_usd AS DOUBLE))
      comment: "Average C1 cash cost per project valuation in USD. Measures operating cost competitiveness of the project pipeline."
    - name: "total_ore_reserve_mt"
      expr: SUM(CAST(total_ore_reserve_mt AS DOUBLE))
      comment: "Total ore reserve in million tonnes across projects. Measures the resource base underpinning the project portfolio value."
    - name: "avg_production_rate_mtpa"
      expr: AVG(CAST(production_rate_mtpa AS DOUBLE))
      comment: "Average annual production rate across projects in million tonnes per annum. Indicates project scale and throughput capacity."
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average metallurgical recovery rate across project valuations. Key assumption driving revenue and unit cost projections."
    - name: "project_count"
      expr: COUNT(DISTINCT valuation_code)
      comment: "Number of distinct projects in the valuation portfolio. Measures pipeline breadth for capital allocation planning."
$$;