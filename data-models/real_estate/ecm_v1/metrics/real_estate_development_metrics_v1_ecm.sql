-- Metric views for domain: development | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_dev_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core development project performance metrics tracking budget, cost variance, schedule adherence, and project health for capital deployment decisions"
  source: "`real_estate_ecm`.`development`.`dev_project`"
  dimensions:
    - name: "project_name"
      expr: project_name
      comment: "Development project name"
    - name: "project_number"
      expr: project_number
      comment: "Unique project identifier"
    - name: "project_status"
      expr: project_status
      comment: "Current project status (e.g., Planning, Under Construction, Complete)"
    - name: "current_phase"
      expr: current_phase
      comment: "Current development phase"
    - name: "project_year"
      expr: YEAR(actual_start_date)
      comment: "Year project started"
    - name: "project_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date), '-', YEAR(actual_start_date))
      comment: "Quarter and year project started"
    - name: "estimated_completion_year"
      expr: YEAR(estimated_completion_date)
      comment: "Year project is estimated to complete"
    - name: "esg_flag"
      expr: esg_flag
      comment: "Whether project has ESG considerations"
  measures:
    - name: "total_project_count"
      expr: COUNT(DISTINCT dev_project_id)
      comment: "Total number of development projects"
    - name: "total_budget_usd"
      expr: SUM(CAST(total_budget_usd AS DOUBLE))
      comment: "Total budgeted capital across all projects"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_to_date_usd AS DOUBLE))
      comment: "Total actual costs incurred to date across all projects"
    - name: "total_hard_cost_budget_usd"
      expr: SUM(CAST(hard_cost_budget_usd AS DOUBLE))
      comment: "Total hard construction costs budgeted"
    - name: "total_soft_cost_budget_usd"
      expr: SUM(CAST(soft_cost_budget_usd AS DOUBLE))
      comment: "Total soft costs (fees, permits, financing) budgeted"
    - name: "total_contingency_budget_usd"
      expr: SUM(CAST(contingency_budget_usd AS DOUBLE))
      comment: "Total contingency reserves across all projects"
    - name: "avg_budget_per_project_usd"
      expr: AVG(CAST(total_budget_usd AS DOUBLE))
      comment: "Average total budget per project"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget consumed to date - key capital efficiency metric"
    - name: "total_target_gla_sqft"
      expr: SUM(CAST(target_gla_sqft AS DOUBLE))
      comment: "Total gross leasable area under development"
    - name: "total_target_nla_sqft"
      expr: SUM(CAST(target_nla_sqft AS DOUBLE))
      comment: "Total net leasable area under development"
    - name: "cost_per_sqft_gla"
      expr: ROUND(SUM(CAST(actual_cost_to_date_usd AS DOUBLE)) / NULLIF(SUM(CAST(target_gla_sqft AS DOUBLE)), 0), 2)
      comment: "Actual cost per gross leasable square foot - key unit economics metric"
    - name: "avg_far_proposed"
      expr: AVG(CAST(far_proposed AS DOUBLE))
      comment: "Average floor area ratio proposed across projects - density metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_construction_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction budget line-item performance tracking cost variance, commitment, and forecast accuracy for capital allocation decisions"
  source: "`real_estate_ecm`.`development`.`construction_budget`"
  dimensions:
    - name: "budget_name"
      expr: budget_name
      comment: "Construction budget name"
    - name: "budget_code"
      expr: budget_code
      comment: "Budget code identifier"
    - name: "budget_status"
      expr: budget_status
      comment: "Current budget status"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Original, Revised)"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category classification"
    - name: "cost_code"
      expr: cost_code
      comment: "Detailed cost code"
    - name: "cost_code_level"
      expr: cost_code_level
      comment: "Cost code hierarchy level"
    - name: "budget_year"
      expr: YEAR(budget_start_date)
      comment: "Year budget period starts"
    - name: "reporting_period"
      expr: DATE_TRUNC('MONTH', reporting_period_date)
      comment: "Monthly reporting period"
  measures:
    - name: "total_budget_lines"
      expr: COUNT(DISTINCT construction_budget_id)
      comment: "Total number of budget line items"
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of original budget amounts across all lines"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Sum of approved budget amounts"
    - name: "total_current_budget"
      expr: SUM(CAST(current_budget_amount AS DOUBLE))
      comment: "Sum of current budget amounts including approved changes"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual costs incurred to date"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs via contracts and POs"
    - name: "total_forecast_at_completion"
      expr: SUM(CAST(forecast_at_completion AS DOUBLE))
      comment: "Total forecasted cost at project completion"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (budget vs actual)"
    - name: "total_approved_change_orders"
      expr: SUM(CAST(approved_change_order_amount AS DOUBLE))
      comment: "Total approved change order amounts"
    - name: "total_pending_change_orders"
      expr: SUM(CAST(pending_change_order_amount AS DOUBLE))
      comment: "Total pending change order amounts"
    - name: "cost_variance_percentage"
      expr: ROUND(100.0 * SUM(CAST(cost_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as percentage of approved budget - key budget control metric"
    - name: "budget_burn_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_to_date AS DOUBLE)) / NULLIF(SUM(CAST(current_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of current budget consumed - capital deployment velocity metric"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed via contracts - procurement progress metric"
    - name: "forecast_variance_percentage"
      expr: ROUND(100.0 * (SUM(CAST(forecast_at_completion AS DOUBLE)) - SUM(CAST(current_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(current_budget_amount AS DOUBLE)), 0), 2)
      comment: "Forecast variance as percentage of current budget - predictive accuracy metric"
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency reserves"
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Total remaining contingency reserves"
    - name: "contingency_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(contingency_budget AS DOUBLE)) - SUM(CAST(contingency_remaining AS DOUBLE))) / NULLIF(SUM(CAST(contingency_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of contingency reserves consumed - risk buffer depletion metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order impact analysis tracking cost and schedule impacts, approval velocity, and dispute rates for project control and risk management"
  source: "`real_estate_ecm`.`development`.`change_order`"
  dimensions:
    - name: "change_order_number"
      expr: number
      comment: "Change order number"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., Scope, Cost, Schedule)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status"
    - name: "approving_authority"
      expr: approving_authority
      comment: "Authority responsible for approval"
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category"
    - name: "cost_code"
      expr: cost_code
      comment: "Cost code affected by change"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether change order is disputed"
    - name: "is_time_and_material"
      expr: is_time_and_material
      comment: "Whether change is time and material basis"
    - name: "submitted_year"
      expr: YEAR(submitted_date)
      comment: "Year change order was submitted"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month change order was submitted"
    - name: "approved_year"
      expr: YEAR(approved_date)
      comment: "Year change order was approved"
  measures:
    - name: "total_change_orders"
      expr: COUNT(DISTINCT change_order_id)
      comment: "Total number of change orders"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders"
    - name: "total_lump_sum_amount"
      expr: SUM(CAST(lump_sum_amount AS DOUBLE))
      comment: "Total lump sum change order amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on change orders"
    - name: "avg_cost_impact_per_co"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order"
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on change orders"
    - name: "disputed_change_order_count"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed change orders"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_disputed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT change_order_id), 0), 2)
      comment: "Percentage of change orders disputed - project conflict indicator"
    - name: "change_order_frequency"
      expr: COUNT(DISTINCT change_order_id)
      comment: "Number of change orders - scope stability metric"
    - name: "total_cumulative_co_amount"
      expr: SUM(CAST(cumulative_co_amount AS DOUBLE))
      comment: "Total cumulative change order amounts"
    - name: "co_impact_on_original_contract"
      expr: ROUND(100.0 * SUM(CAST(cost_impact_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_contract_amount AS DOUBLE)), 0), 2)
      comment: "Change order cost impact as percentage of original contract - scope creep metric"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage on change orders"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_construction_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction contract performance tracking contract value growth, retainage, bonding, and compliance for procurement and risk management decisions"
  source: "`real_estate_ecm`.`development`.`construction_contract`"
  dimensions:
    - name: "contract_number"
      expr: contract_number
      comment: "Construction contract number"
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status"
    - name: "contract_category"
      expr: contract_category
      comment: "Contract category classification"
    - name: "trade_division"
      expr: trade_division
      comment: "Trade division (e.g., CSI division)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle terms"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms"
    - name: "bonding_required"
      expr: bonding_required
      comment: "Whether bonding is required"
    - name: "lien_waiver_required"
      expr: lien_waiver_required
      comment: "Whether lien waivers are required"
    - name: "prevailing_wage_required"
      expr: prevailing_wage_required
      comment: "Whether prevailing wage is required"
    - name: "minority_business_required"
      expr: minority_business_required
      comment: "Whether minority business participation is required"
    - name: "executed_year"
      expr: YEAR(executed_date)
      comment: "Year contract was executed"
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year work commenced"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT construction_contract_id)
      comment: "Total number of construction contracts"
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Total original contract values"
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract values including changes"
    - name: "total_change_order_allowance"
      expr: SUM(CAST(change_order_allowance AS DOUBLE))
      comment: "Total change order allowances"
    - name: "contract_growth_rate"
      expr: ROUND(100.0 * (SUM(CAST(revised_contract_value AS DOUBLE)) - SUM(CAST(original_contract_value AS DOUBLE))) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Contract value growth from original to revised - scope change magnitude metric"
    - name: "avg_retainage_percentage"
      expr: AVG(CAST(retainage_percentage AS DOUBLE))
      comment: "Average retainage percentage held"
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amounts"
    - name: "total_payment_bond_amount"
      expr: SUM(CAST(payment_bond_amount AS DOUBLE))
      comment: "Total payment bond amounts"
    - name: "avg_liquidated_damages_per_day"
      expr: AVG(CAST(liquidated_damages_per_day AS DOUBLE))
      comment: "Average liquidated damages per day of delay"
    - name: "bonding_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN bonding_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT construction_contract_id), 0), 2)
      comment: "Percentage of contracts requiring bonding - risk mitigation metric"
    - name: "prevailing_wage_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN prevailing_wage_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT construction_contract_id), 0), 2)
      comment: "Percentage of contracts with prevailing wage requirements - labor compliance metric"
    - name: "minority_business_participation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN minority_business_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT construction_contract_id), 0), 2)
      comment: "Percentage of contracts with minority business requirements - diversity compliance metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_draw_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction draw request performance tracking disbursement velocity, retainage, completion progress, and lien waiver compliance for cash flow and lender reporting"
  source: "`real_estate_ecm`.`development`.`draw_request`"
  dimensions:
    - name: "draw_number"
      expr: draw_number
      comment: "Draw request number"
    - name: "draw_status"
      expr: draw_status
      comment: "Current draw status"
    - name: "lender_approval_status"
      expr: lender_approval_status
      comment: "Lender approval status"
    - name: "owner_approval_status"
      expr: owner_approval_status
      comment: "Owner approval status"
    - name: "title_review_status"
      expr: title_review_status
      comment: "Title review status"
    - name: "lien_waiver_status"
      expr: lien_waiver_status
      comment: "Lien waiver status"
    - name: "waiver_type"
      expr: waiver_type
      comment: "Type of lien waiver"
    - name: "is_notarized"
      expr: is_notarized
      comment: "Whether draw is notarized"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year draw was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month draw was submitted"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Billing period month"
  measures:
    - name: "total_draw_requests"
      expr: COUNT(DISTINCT draw_request_id)
      comment: "Total number of draw requests"
    - name: "total_scheduled_value"
      expr: SUM(CAST(scheduled_value AS DOUBLE))
      comment: "Total scheduled value of work"
    - name: "total_work_completed_current"
      expr: SUM(CAST(work_completed_current AS DOUBLE))
      comment: "Total work completed in current period"
    - name: "total_work_completed_previous"
      expr: SUM(CAST(work_completed_previous AS DOUBLE))
      comment: "Total work completed in previous periods"
    - name: "total_earned_to_date"
      expr: SUM(CAST(total_earned_to_date AS DOUBLE))
      comment: "Total earned value to date"
    - name: "total_retainage_withheld"
      expr: SUM(CAST(total_retainage_withheld AS DOUBLE))
      comment: "Total retainage withheld"
    - name: "total_previous_payments"
      expr: SUM(CAST(previous_payments AS DOUBLE))
      comment: "Total previous payments made"
    - name: "total_net_payment_due"
      expr: SUM(CAST(net_payment_due AS DOUBLE))
      comment: "Total net payment due in current draw"
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total amount actually disbursed"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average project completion percentage"
    - name: "avg_retainage_rate"
      expr: AVG(CAST(retainage_rate AS DOUBLE))
      comment: "Average retainage rate"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CAST(total_earned_to_date AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_value AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled value earned - project progress metric"
    - name: "retainage_percentage_of_earned"
      expr: ROUND(100.0 * SUM(CAST(total_retainage_withheld AS DOUBLE)) / NULLIF(SUM(CAST(total_earned_to_date AS DOUBLE)), 0), 2)
      comment: "Retainage as percentage of earned value - cash flow impact metric"
    - name: "disbursement_efficiency"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_payment_due AS DOUBLE)), 0), 2)
      comment: "Percentage of requested amount actually disbursed - funding velocity metric"
    - name: "total_materials_stored"
      expr: SUM(CAST(materials_stored AS DOUBLE))
      comment: "Total value of materials stored on site"
    - name: "total_balance_to_finish"
      expr: SUM(CAST(balance_to_finish AS DOUBLE))
      comment: "Total remaining balance to complete work"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_proforma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Development proforma investment return analysis tracking IRR, equity multiple, yield on cost, and development spread for capital allocation and investment committee decisions"
  source: "`real_estate_ecm`.`development`.`proforma`"
  dimensions:
    - name: "proforma_name"
      expr: proforma_name
      comment: "Proforma name"
    - name: "proforma_number"
      expr: proforma_number
      comment: "Proforma number"
    - name: "proforma_status"
      expr: proforma_status
      comment: "Current proforma status"
    - name: "proforma_type"
      expr: proforma_type
      comment: "Type of proforma"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Scenario type (e.g., Base, Upside, Downside)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status"
    - name: "waterfall_structure"
      expr: waterfall_structure
      comment: "Waterfall structure type"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year proforma is effective"
    - name: "construction_start_year"
      expr: YEAR(construction_start_date)
      comment: "Year construction is planned to start"
    - name: "stabilization_year"
      expr: YEAR(stabilization_date)
      comment: "Year property is expected to stabilize"
  measures:
    - name: "total_proformas"
      expr: COUNT(DISTINCT proforma_id)
      comment: "Total number of proformas"
    - name: "total_project_cost"
      expr: SUM(CAST(total_project_cost_usd AS DOUBLE))
      comment: "Total project cost across all proformas"
    - name: "total_land_cost"
      expr: SUM(CAST(land_cost_usd AS DOUBLE))
      comment: "Total land acquisition cost"
    - name: "total_hard_cost"
      expr: SUM(CAST(hard_cost_usd AS DOUBLE))
      comment: "Total hard construction costs"
    - name: "total_soft_cost"
      expr: SUM(CAST(soft_cost_usd AS DOUBLE))
      comment: "Total soft costs"
    - name: "total_financing_cost"
      expr: SUM(CAST(financing_cost_usd AS DOUBLE))
      comment: "Total financing costs"
    - name: "total_contingency"
      expr: SUM(CAST(contingency_usd AS DOUBLE))
      comment: "Total contingency reserves"
    - name: "total_equity_contribution"
      expr: SUM(CAST(equity_contribution_usd AS DOUBLE))
      comment: "Total equity capital required"
    - name: "total_construction_loan_amount"
      expr: SUM(CAST(construction_loan_amount_usd AS DOUBLE))
      comment: "Total construction loan amounts"
    - name: "total_stabilized_noi"
      expr: SUM(CAST(stabilized_noi_usd AS DOUBLE))
      comment: "Total stabilized net operating income"
    - name: "total_projected_sale_proceeds"
      expr: SUM(CAST(projected_sale_proceeds_usd AS DOUBLE))
      comment: "Total projected sale proceeds"
    - name: "avg_target_irr_pct"
      expr: AVG(CAST(target_irr_pct AS DOUBLE))
      comment: "Average target internal rate of return - key investment return metric"
    - name: "avg_target_equity_multiple"
      expr: AVG(CAST(target_equity_multiple AS DOUBLE))
      comment: "Average target equity multiple - key return on equity metric"
    - name: "avg_yield_on_cost_pct"
      expr: AVG(CAST(yield_on_cost_pct AS DOUBLE))
      comment: "Average yield on cost - stabilized NOI return metric"
    - name: "avg_exit_cap_rate_pct"
      expr: AVG(CAST(exit_cap_rate_pct AS DOUBLE))
      comment: "Average exit capitalization rate"
    - name: "avg_development_spread_bps"
      expr: AVG(CAST(development_spread_bps AS DOUBLE))
      comment: "Average development spread in basis points - profit margin metric"
    - name: "avg_construction_loan_ltv_pct"
      expr: AVG(CAST(construction_loan_ltv_pct AS DOUBLE))
      comment: "Average construction loan to value percentage"
    - name: "avg_preferred_return_pct"
      expr: AVG(CAST(preferred_return_pct AS DOUBLE))
      comment: "Average preferred return percentage"
    - name: "avg_gp_promote_pct"
      expr: AVG(CAST(gp_promote_pct AS DOUBLE))
      comment: "Average general partner promote percentage"
    - name: "avg_hold_period_years"
      expr: AVG(CAST(hold_period_years AS DOUBLE))
      comment: "Average investment hold period in years"
    - name: "leverage_ratio"
      expr: ROUND(SUM(CAST(construction_loan_amount_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_project_cost_usd AS DOUBLE)), 0), 2)
      comment: "Debt to total cost ratio - leverage metric"
    - name: "equity_ratio"
      expr: ROUND(SUM(CAST(equity_contribution_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_project_cost_usd AS DOUBLE)), 0), 2)
      comment: "Equity to total cost ratio - capital structure metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction inspection quality and compliance tracking deficiency rates, reinspection frequency, and OSHA compliance for quality control and safety management"
  source: "`real_estate_ecm`.`development`.`inspection_event`"
  dimensions:
    - name: "inspection_number"
      expr: inspection_number
      comment: "Inspection event number"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection"
    - name: "inspection_category"
      expr: inspection_category
      comment: "Inspection category"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Inspection result (e.g., Pass, Fail, Conditional)"
    - name: "inspector_affiliation"
      expr: inspector_affiliation
      comment: "Inspector affiliation (e.g., Third Party, Municipal)"
    - name: "deficiency_severity"
      expr: deficiency_severity
      comment: "Severity of deficiencies found"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required"
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether reinspection is required"
    - name: "coo_related"
      expr: coo_related
      comment: "Whether inspection is certificate of occupancy related"
    - name: "lender_draw_related"
      expr: lender_draw_related
      comment: "Whether inspection is lender draw related"
    - name: "osha_compliance_flag"
      expr: osha_compliance_flag
      comment: "OSHA compliance flag"
    - name: "osha_violation_noted"
      expr: osha_violation_noted
      comment: "Whether OSHA violation was noted"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year inspection occurred"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month inspection occurred"
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT inspection_event_id)
      comment: "Total number of inspection events"
    - name: "reinspection_count"
      expr: SUM(CASE WHEN reinspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring reinspection"
    - name: "reinspection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reinspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT inspection_event_id), 0), 2)
      comment: "Percentage of inspections requiring reinspection - quality failure rate metric"
    - name: "corrective_action_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring corrective action"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT inspection_event_id), 0), 2)
      comment: "Percentage of inspections requiring corrective action - deficiency rate metric"
    - name: "osha_violation_count"
      expr: SUM(CASE WHEN osha_violation_noted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections with OSHA violations"
    - name: "osha_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN osha_violation_noted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT inspection_event_id), 0), 2)
      comment: "Percentage of inspections with OSHA violations - safety compliance metric"
    - name: "coo_inspection_count"
      expr: SUM(CASE WHEN coo_related = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certificate of occupancy related inspections"
    - name: "lender_draw_inspection_count"
      expr: SUM(CASE WHEN lender_draw_related = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lender draw related inspections"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`development_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Land entitlement and zoning approval tracking FAR compliance, density approvals, affordable housing requirements, and approval velocity for development feasibility decisions"
  source: "`real_estate_ecm`.`development`.`entitlement`"
  dimensions:
    - name: "entitlement_name"
      expr: entitlement_name
      comment: "Entitlement name"
    - name: "entitlement_number"
      expr: entitlement_number
      comment: "Entitlement number"
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current entitlement status"
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement"
    - name: "land_use_designation"
      expr: land_use_designation
      comment: "Land use designation"
    - name: "environmental_review_status"
      expr: environmental_review_status
      comment: "Environmental review status"
    - name: "environmental_review_type"
      expr: environmental_review_type
      comment: "Type of environmental review"
    - name: "far_compliance_status"
      expr: far_compliance_status
      comment: "Floor area ratio compliance status"
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Whether appeal was filed"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year entitlement was applied for"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year entitlement was approved"
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT entitlement_id)
      comment: "Total number of entitlements"
    - name: "total_site_area_sqf"
      expr: SUM(CAST(site_area_sqf AS DOUBLE))
      comment: "Total site area under entitlement"
    - name: "total_proposed_gfa"
      expr: SUM(CAST(proposed_gross_floor_area_sqf AS DOUBLE))
      comment: "Total proposed gross floor area"
    - name: "avg_proposed_far"
      expr: AVG(CAST(proposed_far AS DOUBLE))
      comment: "Average proposed floor area ratio"
    - name: "avg_base_far_allowance"
      expr: AVG(CAST(base_far_allowance AS DOUBLE))
      comment: "Average base FAR allowance"
    - name: "avg_bonus_far"
      expr: AVG(CAST(bonus_far AS DOUBLE))
      comment: "Average bonus FAR obtained"
    - name: "avg_total_allowable_far"
      expr: AVG(CAST(total_allowable_far AS DOUBLE))
      comment: "Average total allowable FAR"
    - name: "avg_as_built_far"
      expr: AVG(CAST(as_built_far AS DOUBLE))
      comment: "Average as-built FAR"
    - name: "far_utilization_rate"
      expr: ROUND(100.0 * AVG(CAST(proposed_far AS DOUBLE)) / NULLIF(AVG(CAST(total_allowable_far AS DOUBLE)), 0), 2)
      comment: "Proposed FAR as percentage of allowable - density utilization metric"
    - name: "bonus_far_capture_rate"
      expr: ROUND(100.0 * AVG(CAST(bonus_far AS DOUBLE)) / NULLIF(AVG(CAST(total_allowable_far AS DOUBLE)), 0), 2)
      comment: "Bonus FAR as percentage of total allowable - incentive capture metric"
    - name: "avg_proposed_building_height_ft"
      expr: AVG(CAST(proposed_building_height_ft AS DOUBLE))
      comment: "Average proposed building height"
    - name: "avg_max_building_height_ft"
      expr: AVG(CAST(max_building_height_ft AS DOUBLE))
      comment: "Average maximum allowed building height"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT entitlement_id), 0), 2)
      comment: "Percentage of entitlements appealed - approval controversy metric"
$$;