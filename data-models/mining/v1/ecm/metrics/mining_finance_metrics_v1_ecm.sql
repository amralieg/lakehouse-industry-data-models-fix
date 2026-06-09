-- Metric views for domain: finance | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_capex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure budget performance metrics tracking approved, committed, and actual spend against sustaining and expansion capital programs"
  source: "`mining_ecm`.`finance`.`capex_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capital budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "capex_category"
      expr: capex_category
      comment: "Category of capital expenditure (e.g., sustaining, expansion, exploration)"
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the capital project"
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget (approved, pending, revised)"
    - name: "is_sustaining_capex"
      expr: is_sustaining_capex
      comment: "Flag indicating whether this is sustaining capital expenditure"
    - name: "is_lom_capital"
      expr: is_lom_capital
      comment: "Flag indicating whether this is life-of-mine capital"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when the budget was approved"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capital budget amount"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual capital expenditure incurred"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed capital expenditure (contractually obligated)"
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion_amount AS DOUBLE))
      comment: "Total forecast cost at project completion"
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget allocated"
    - name: "total_aisc_contribution"
      expr: SUM(CAST(aisc_contribution_usd AS DOUBLE))
      comment: "Total contribution to All-In Sustaining Cost in USD"
    - name: "avg_irr_pct"
      expr: AVG(CAST(irr_pct AS DOUBLE))
      comment: "Average internal rate of return percentage across projects"
    - name: "capex_project_count"
      expr: COUNT(DISTINCT capex_budget_id)
      comment: "Number of distinct capital budget line items"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_opex_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating expenditure budget performance metrics tracking planned vs actual operational costs across cost centres and commodities"
  source: "`mining_ecm`.`finance`.`opex_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the operating budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of operating cost"
    - name: "opex_classification"
      expr: opex_classification
      comment: "Classification of operating expenditure"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity associated with the operating expenditure"
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget (approved, draft, revised)"
    - name: "is_capitalised"
      expr: is_capitalised
      comment: "Flag indicating whether the expenditure is capitalised"
    - name: "is_lom_included"
      expr: is_lom_included
      comment: "Flag indicating whether included in life-of-mine plan"
    - name: "budget_cycle"
      expr: budget_cycle_code
      comment: "Budget cycle code"
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original operating budget amount"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised operating budget amount"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual operating expenditure incurred"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed operating expenditure"
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast operating expenditure"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between budget and actual"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across budget line items"
    - name: "opex_line_item_count"
      expr: COUNT(DISTINCT opex_budget_id)
      comment: "Number of distinct operating budget line items"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecast metrics tracking operating, investing, and financing cash flows with variance analysis against prior forecasts"
  source: "`mining_ecm`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cash flow forecast"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (budget, rolling, scenario)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (draft, approved, superseded)"
    - name: "forecast_horizon"
      expr: forecast_horizon
      comment: "Time horizon of the forecast"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity driving cash flows"
    - name: "debt_covenant_compliance"
      expr: debt_covenant_compliance_flag
      comment: "Flag indicating debt covenant compliance"
    - name: "forecast_period_start_year"
      expr: YEAR(forecast_period_start_date)
      comment: "Year of forecast period start"
  measures:
    - name: "total_operating_cash_inflow"
      expr: SUM(CAST(operating_cash_inflow_amount AS DOUBLE))
      comment: "Total operating cash inflows"
    - name: "total_operating_cash_outflow"
      expr: SUM(CAST(operating_cash_outflow_amount AS DOUBLE))
      comment: "Total operating cash outflows"
    - name: "total_investing_cash_inflow"
      expr: SUM(CAST(investing_cash_inflow_amount AS DOUBLE))
      comment: "Total investing cash inflows"
    - name: "total_investing_cash_outflow"
      expr: SUM(CAST(investing_cash_outflow_amount AS DOUBLE))
      comment: "Total investing cash outflows"
    - name: "total_financing_cash_inflow"
      expr: SUM(CAST(financing_cash_inflow_amount AS DOUBLE))
      comment: "Total financing cash inflows"
    - name: "total_financing_cash_outflow"
      expr: SUM(CAST(financing_cash_outflow_amount AS DOUBLE))
      comment: "Total financing cash outflows"
    - name: "total_net_cash_flow"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Total net cash flow across all categories"
    - name: "total_capex"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure forecast"
    - name: "total_sustaining_capex"
      expr: SUM(CAST(sustaining_capex_amount AS DOUBLE))
      comment: "Total sustaining capital expenditure forecast"
    - name: "total_expansion_capex"
      expr: SUM(CAST(expansion_capex_amount AS DOUBLE))
      comment: "Total expansion capital expenditure forecast"
    - name: "total_commodity_sales"
      expr: SUM(CAST(commodity_sales_amount AS DOUBLE))
      comment: "Total commodity sales revenue forecast"
    - name: "avg_closing_cash_balance"
      expr: AVG(CAST(closing_cash_balance_amount AS DOUBLE))
      comment: "Average closing cash balance across forecast periods"
    - name: "forecast_count"
      expr: COUNT(DISTINCT cash_flow_forecast_id)
      comment: "Number of distinct cash flow forecasts"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_cost_performance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost performance metrics tracking unit costs, AISC, and variance to budget across mining operations and commodities"
  source: "`mining_ecm`.`finance`.`cost_performance_report`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost performance report"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "commodity"
      expr: commodity
      comment: "Commodity being reported on"
    - name: "report_type"
      expr: report_type
      comment: "Type of cost performance report"
    - name: "report_status"
      expr: report_status
      comment: "Status of the report (draft, approved, final)"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual)"
    - name: "is_guidance_met"
      expr: is_guidance_met
      comment: "Flag indicating whether AISC guidance was met"
    - name: "production_unit_of_measure"
      expr: production_unit_of_measure
      comment: "Unit of measure for production volume"
  measures:
    - name: "total_cost_usd"
      expr: SUM(CAST(total_cost_usd AS DOUBLE))
      comment: "Total cost in USD"
    - name: "total_mining_opex"
      expr: SUM(CAST(mining_opex AS DOUBLE))
      comment: "Total mining operating expenditure"
    - name: "total_processing_opex"
      expr: SUM(CAST(processing_opex AS DOUBLE))
      comment: "Total processing operating expenditure"
    - name: "total_ga_cost"
      expr: SUM(CAST(ga_cost AS DOUBLE))
      comment: "Total general and administrative cost"
    - name: "total_royalty_cost"
      expr: SUM(CAST(royalty_cost AS DOUBLE))
      comment: "Total royalty cost"
    - name: "total_sustaining_capex"
      expr: SUM(CAST(sustaining_capex AS DOUBLE))
      comment: "Total sustaining capital expenditure"
    - name: "total_refining_transport_cost"
      expr: SUM(CAST(refining_and_transport_cost AS DOUBLE))
      comment: "Total refining and transport cost"
    - name: "total_byproduct_credit"
      expr: SUM(CAST(byproduct_credit AS DOUBLE))
      comment: "Total byproduct credit"
    - name: "total_production_volume"
      expr: SUM(CAST(production_volume AS DOUBLE))
      comment: "Total production volume"
    - name: "avg_unit_cost_result"
      expr: AVG(CAST(unit_cost_result AS DOUBLE))
      comment: "Average unit cost result per reporting period"
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average recovery rate percentage"
    - name: "avg_strip_ratio"
      expr: AVG(CAST(strip_ratio AS DOUBLE))
      comment: "Average strip ratio (waste to ore)"
    - name: "report_count"
      expr: COUNT(DISTINCT cost_performance_report_id)
      comment: "Number of distinct cost performance reports"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_project_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project valuation metrics tracking NPV, IRR, payback period, and economic viability of mining projects"
  source: "`mining_ecm`.`finance`.`project_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the project valuation"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (feasibility, pre-feasibility, scoping)"
    - name: "study_stage"
      expr: study_stage
      comment: "Stage of the mining study"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity being valued"
    - name: "ore_reserve_category"
      expr: ore_reserve_category
      comment: "Category of ore reserve (proven, probable)"
    - name: "price_basis"
      expr: price_basis
      comment: "Basis for commodity price assumption"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when the valuation was approved"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year when the valuation became effective"
  measures:
    - name: "avg_npv_base"
      expr: AVG(CAST(npv_base_musd AS DOUBLE))
      comment: "Average base case net present value in million USD"
    - name: "avg_npv_high"
      expr: AVG(CAST(npv_high_musd AS DOUBLE))
      comment: "Average high case net present value in million USD"
    - name: "avg_npv_low"
      expr: AVG(CAST(npv_low_musd AS DOUBLE))
      comment: "Average low case net present value in million USD"
    - name: "avg_irr_pct"
      expr: AVG(CAST(irr_pct AS DOUBLE))
      comment: "Average internal rate of return percentage"
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years"
    - name: "total_capex"
      expr: SUM(CAST(capex_total_musd AS DOUBLE))
      comment: "Total capital expenditure in million USD"
    - name: "avg_aisc_usd"
      expr: AVG(CAST(aisc_usd AS DOUBLE))
      comment: "Average all-in sustaining cost in USD"
    - name: "avg_c1_cash_cost_usd"
      expr: AVG(CAST(c1_cash_cost_usd AS DOUBLE))
      comment: "Average C1 cash cost in USD"
    - name: "avg_opex_unit_usd"
      expr: AVG(CAST(opex_unit_usd AS DOUBLE))
      comment: "Average operating expenditure per unit in USD"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate percentage used in valuation"
    - name: "total_ore_reserve"
      expr: SUM(CAST(total_ore_reserve_mt AS DOUBLE))
      comment: "Total ore reserve in million tonnes"
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate_mtpa AS DOUBLE))
      comment: "Average production rate in million tonnes per annum"
    - name: "valuation_count"
      expr: COUNT(DISTINCT project_valuation_id)
      comment: "Number of distinct project valuations"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_rehabilitation_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mine rehabilitation provision metrics tracking closure cost estimates, regulatory bonds, and environmental liability movements"
  source: "`mining_ecm`.`finance`.`rehabilitation_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the rehabilitation provision"
    - name: "provision_status"
      expr: provision_status
      comment: "Status of the rehabilitation provision"
    - name: "provision_type"
      expr: provision_type
      comment: "Type of rehabilitation provision"
    - name: "opex_capex_classification"
      expr: opex_capex_classification
      comment: "Classification as operating or capital expenditure"
    - name: "bond_instrument_type"
      expr: bond_instrument_type
      comment: "Type of bond instrument securing the provision"
    - name: "aisc_inclusion"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether included in AISC calculation"
    - name: "tsf_related"
      expr: tsf_related_flag
      comment: "Flag indicating whether related to tailings storage facility"
    - name: "recognition_year"
      expr: YEAR(recognition_date)
      comment: "Year when the provision was recognized"
  measures:
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance_amount AS DOUBLE))
      comment: "Total opening balance of rehabilitation provisions"
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance_amount AS DOUBLE))
      comment: "Total closing balance of rehabilitation provisions"
    - name: "total_new_provision"
      expr: SUM(CAST(new_provision_amount AS DOUBLE))
      comment: "Total new rehabilitation provisions recognized"
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total revisions to rehabilitation provisions"
    - name: "total_unwinding_discount"
      expr: SUM(CAST(unwinding_of_discount_amount AS DOUBLE))
      comment: "Total unwinding of discount (accretion expense)"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual rehabilitation expenditure incurred"
    - name: "total_undiscounted_estimate"
      expr: SUM(CAST(undiscounted_cost_estimate AS DOUBLE))
      comment: "Total undiscounted rehabilitation cost estimate"
    - name: "total_regulatory_bond"
      expr: SUM(CAST(regulatory_bond_amount AS DOUBLE))
      comment: "Total regulatory bond amount held"
    - name: "total_disturbance_area"
      expr: SUM(CAST(disturbance_area_ha AS DOUBLE))
      comment: "Total disturbed area in hectares"
    - name: "total_rehabilitated_area"
      expr: SUM(CAST(rehabilitation_completed_area_ha AS DOUBLE))
      comment: "Total rehabilitated area in hectares"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate percentage used"
    - name: "provision_count"
      expr: COUNT(DISTINCT rehabilitation_provision_id)
      comment: "Number of distinct rehabilitation provisions"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_royalty_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty obligation metrics tracking rates, accrued liabilities, and payments by commodity and jurisdiction"
  source: "`mining_ecm`.`finance`.`royalty_obligation`"
  dimensions:
    - name: "commodity"
      expr: commodity
      comment: "Commodity subject to royalty"
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty (ad valorem, unit-based, profit-based)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction imposing the royalty"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Status of the royalty obligation"
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (government, private, indigenous)"
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for royalty calculation"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of royalty payments"
    - name: "aisc_inclusion"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether included in AISC"
    - name: "c1_cost_inclusion"
      expr: c1_cost_inclusion_flag
      comment: "Flag indicating whether included in C1 cost"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether royalty is under dispute"
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Flag indicating whether exemption applies"
  measures:
    - name: "total_accrued_liability"
      expr: SUM(CAST(accrued_liability_amount AS DOUBLE))
      comment: "Total accrued royalty liability"
    - name: "total_last_payment"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of last royalty payments made"
    - name: "total_minimum_royalty"
      expr: SUM(CAST(minimum_royalty_amount AS DOUBLE))
      comment: "Total minimum royalty obligations"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate AS DOUBLE))
      comment: "Average royalty rate across obligations"
    - name: "obligation_count"
      expr: COUNT(DISTINCT royalty_obligation_id)
      comment: "Number of distinct royalty obligations"
    - name: "disputed_obligation_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN royalty_obligation_id END)
      comment: "Number of royalty obligations under dispute"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice metrics tracking payables, disputes, payment performance, and cost classification across suppliers"
  source: "`mining_ecm`.`finance`.`vendor_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of the invoice (pending, approved, paid, disputed)"
    - name: "opex_capex_classification"
      expr: opex_capex_classification
      comment: "Classification as operating or capital expenditure"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity associated with the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, GR, invoice)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether invoice is disputed"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of invoice dispute"
    - name: "aisc_inclusion"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether included in AISC"
    - name: "c1_cost_inclusion"
      expr: c1_cost_inclusion_flag
      comment: "Flag indicating whether included in C1 cost"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment date"
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_invoice_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount taken"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total invoice amount in functional currency"
    - name: "invoice_count"
      expr: COUNT(DISTINCT vendor_invoice_id)
      comment: "Number of distinct vendor invoices"
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN vendor_invoice_id END)
      comment: "Number of invoices under dispute"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT procurement_vendor_id)
      comment: "Number of distinct vendors invoiced"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_exploration_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exploration expenditure metrics tracking spend by area of interest, commodity, and capitalisation status under IFRS 6"
  source: "`mining_ecm`.`finance`.`exploration_expenditure`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the exploration expenditure"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of exploration expenditure"
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Category of exploration expenditure"
    - name: "exploration_stage"
      expr: exploration_stage
      comment: "Stage of exploration (grassroots, advanced, feasibility)"
    - name: "mineral_commodity"
      expr: mineral_commodity
      comment: "Mineral commodity being explored"
    - name: "capitalisation_status"
      expr: capitalisation_status
      comment: "Status of capitalisation (expensed, capitalised, impaired)"
    - name: "technical_feasibility_determined"
      expr: technical_feasibility_determined
      comment: "Flag indicating whether technical feasibility has been determined"
    - name: "impairment_indicator_present"
      expr: impairment_indicator_present
      comment: "Flag indicating whether impairment indicators are present"
    - name: "country_code"
      expr: country_code
      comment: "Country where exploration is conducted"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard applied (IFRS 6, local GAAP)"
    - name: "expenditure_year"
      expr: YEAR(expenditure_date)
      comment: "Year of expenditure"
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total exploration expenditure amount"
    - name: "total_accumulated_expenditure"
      expr: SUM(CAST(accumulated_expenditure_amount AS DOUBLE))
      comment: "Total accumulated exploration expenditure"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total exploration budget amount"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment of exploration assets"
    - name: "total_metres_drilled"
      expr: SUM(CAST(metres_drilled AS DOUBLE))
      comment: "Total metres drilled in exploration programs"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(amount_functional_currency AS DOUBLE))
      comment: "Total expenditure in functional currency"
    - name: "expenditure_line_count"
      expr: COUNT(DISTINCT exploration_expenditure_id)
      comment: "Number of distinct exploration expenditure line items"
    - name: "unique_area_of_interest_count"
      expr: COUNT(DISTINCT area_of_interest_code)
      comment: "Number of distinct areas of interest"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking net book value, depreciation, impairment, and useful life across asset classes"
  source: "`mining_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Status of the fixed asset (active, retired, under construction)"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method of depreciation (straight-line, units of production)"
    - name: "ifrs6_exploration_flag"
      expr: ifrs6_exploration_flag
      comment: "Flag indicating whether asset is IFRS 6 exploration asset"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area code"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition"
    - name: "capitalisation_year"
      expr: YEAR(capitalisation_date)
      comment: "Year of asset capitalisation"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment loss recognized"
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation amount"
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total residual value of fixed assets"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years"
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years"
    - name: "asset_count"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Number of distinct fixed assets"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`finance_tax_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax obligation metrics tracking current and deferred tax liabilities, effective tax rates, and compliance by jurisdiction"
  source: "`mining_ecm`.`finance`.`tax_obligation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax obligation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (corporate income, mining, withholding)"
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction code"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Status of the tax obligation"
    - name: "commodity"
      expr: commodity
      comment: "Commodity associated with the tax obligation"
    - name: "aisc_inclusion"
      expr: aisc_inclusion_flag
      comment: "Flag indicating whether included in AISC"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of tax assessment"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year when tax is due"
  measures:
    - name: "total_current_tax_liability"
      expr: SUM(CAST(current_tax_liability_amount AS DOUBLE))
      comment: "Total current tax liability"
    - name: "total_deferred_tax_asset"
      expr: SUM(CAST(deferred_tax_asset_amount AS DOUBLE))
      comment: "Total deferred tax asset"
    - name: "total_deferred_tax_liability"
      expr: SUM(CAST(deferred_tax_liability_amount AS DOUBLE))
      comment: "Total deferred tax liability"
    - name: "total_obligation_amount"
      expr: SUM(CAST(total_obligation_amount AS DOUBLE))
      comment: "Total tax obligation amount"
    - name: "total_taxable_income"
      expr: SUM(CAST(taxable_income_amount AS DOUBLE))
      comment: "Total taxable income"
    - name: "total_tax_adjustment"
      expr: SUM(CAST(tax_adjustment_amount AS DOUBLE))
      comment: "Total tax adjustments"
    - name: "total_tax_instalment"
      expr: SUM(CAST(tax_instalment_amount AS DOUBLE))
      comment: "Total tax instalment payments"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest on tax obligations"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties on tax obligations"
    - name: "total_tax_loss_carryforward"
      expr: SUM(CAST(tax_loss_carryforward_amount AS DOUBLE))
      comment: "Total tax loss carryforward amount"
    - name: "avg_effective_tax_rate_pct"
      expr: AVG(CAST(effective_tax_rate_pct AS DOUBLE))
      comment: "Average effective tax rate percentage"
    - name: "avg_statutory_tax_rate_pct"
      expr: AVG(CAST(statutory_tax_rate_pct AS DOUBLE))
      comment: "Average statutory tax rate percentage"
    - name: "obligation_count"
      expr: COUNT(DISTINCT tax_obligation_id)
      comment: "Number of distinct tax obligations"
$$;