-- Metric views for domain: project | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capital project performance metrics tracking investment returns, budget adherence, and schedule performance for mining capital investments"
  source: "`mining_ecm`.`project`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capital project (e.g., Planning, Execution, Commissioning, Closed)"
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (e.g., Expansion, Sustaining, Greenfield, Brownfield)"
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category classification"
    - name: "stage_gate_phase"
      expr: stage_gate_phase
      comment: "Current stage gate phase of the project lifecycle"
    - name: "commodity"
      expr: commodity
      comment: "Primary commodity targeted by the project (e.g., Iron Ore, Copper, Lithium)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating of the project"
    - name: "strategic_alignment"
      expr: strategic_alignment
      comment: "Strategic alignment classification of the project"
    - name: "sanction_year"
      expr: YEAR(sanction_date)
      comment: "Year the project was sanctioned"
    - name: "planned_completion_year"
      expr: YEAR(planned_completion_date)
      comment: "Year the project is planned to complete"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across all capital projects"
    - name: "total_forecast_completion_cost"
      expr: SUM(CAST(forecast_completion_cost AS DOUBLE))
      comment: "Total forecast cost to complete all projects"
    - name: "total_npv"
      expr: SUM(CAST(npv_amount AS DOUBLE))
      comment: "Total net present value across all capital projects"
    - name: "avg_irr_percentage"
      expr: AVG(CAST(irr_percentage AS DOUBLE))
      comment: "Average internal rate of return percentage across projects"
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years across projects"
    - name: "total_design_capacity"
      expr: SUM(CAST(design_capacity AS DOUBLE))
      comment: "Total design capacity across all projects"
    - name: "avg_life_of_mine_years"
      expr: AVG(CAST(life_of_mine_years AS DOUBLE))
      comment: "Average life of mine in years across projects"
    - name: "project_count"
      expr: COUNT(DISTINCT capital_project_id)
      comment: "Count of distinct capital projects"
    - name: "total_closure_provision"
      expr: SUM(CAST(closure_provision_amount AS DOUBLE))
      comment: "Total closure provision amount across all projects"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_expenditure_actual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actual capital expenditure tracking metrics for monitoring project spend, cost control, and financial performance against commitments"
  source: "`mining_ecm`.`project`.`expenditure_actual`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the expenditure"
    - name: "cost_element_code"
      expr: cost_element_code
      comment: "Cost element code for expenditure classification"
    - name: "cost_category_code"
      expr: cost_category_code
      comment: "Cost category code for expenditure grouping"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of expenditure posting"
    - name: "transaction_currency"
      expr: transaction_currency_code
      comment: "Currency code of the transaction"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Name of the vendor for the expenditure"
    - name: "is_reversal"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal transaction"
  measures:
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual expenditure amount across all transactions"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total expenditure in local currency"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods or services procured"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to transactions"
    - name: "transaction_count"
      expr: COUNT(DISTINCT expenditure_actual_id)
      comment: "Count of distinct expenditure transactions"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_code)
      comment: "Count of unique vendors with expenditure"
    - name: "unique_invoices"
      expr: COUNT(DISTINCT invoice_reference_number)
      comment: "Count of unique invoices processed"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget management metrics tracking approved budgets, contingencies, and financial planning across project lifecycle stages"
  source: "`mining_ecm`.`project`.`project_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the project budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Original, Revised, Forecast)"
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category classification"
    - name: "capex_phase"
      expr: capex_phase
      comment: "Capital expenditure phase of the budget"
    - name: "approval_gate"
      expr: approval_gate
      comment: "Stage gate at which budget was approved"
    - name: "is_baseline"
      expr: baseline_budget_flag
      comment: "Flag indicating if this is the baseline budget"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the budget was approved"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the budget"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget amount across all project budgets"
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency budget allocated"
    - name: "total_direct_cost_budget"
      expr: SUM(CAST(direct_cost_budget AS DOUBLE))
      comment: "Total direct cost budget allocated"
    - name: "total_indirect_cost_budget"
      expr: SUM(CAST(indirect_cost_budget AS DOUBLE))
      comment: "Total indirect cost budget allocated"
    - name: "total_owner_cost_budget"
      expr: SUM(CAST(owner_cost_budget AS DOUBLE))
      comment: "Total owner cost budget allocated"
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage across budgets"
    - name: "avg_irr_at_approval"
      expr: AVG(CAST(irr_at_approval AS DOUBLE))
      comment: "Average internal rate of return at budget approval"
    - name: "total_npv_at_approval"
      expr: SUM(CAST(npv_at_approval AS DOUBLE))
      comment: "Total net present value at budget approval"
    - name: "budget_count"
      expr: COUNT(DISTINCT project_budget_id)
      comment: "Count of distinct project budgets"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_cost_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost commitment tracking metrics for monitoring contractual obligations, purchase orders, and committed spend against project budgets"
  source: "`mining_ecm`.`project`.`cost_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the cost commitment"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of cost commitment (e.g., Contract, Purchase Order, Service Agreement)"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the commitment"
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category of the commitment"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category associated with the commitment"
    - name: "is_change_order"
      expr: is_change_order
      comment: "Flag indicating if commitment is related to a change order"
    - name: "commitment_year"
      expr: YEAR(commitment_date)
      comment: "Year the commitment was made"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the commitment"
    - name: "buyer_name"
      expr: buyer_name
      comment: "Name of the buyer who created the commitment"
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount across all commitments"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced amount against commitments"
    - name: "total_remaining_commitment"
      expr: SUM(CAST(remaining_commitment AS DOUBLE))
      comment: "Total remaining commitment not yet invoiced"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total commitment amount in functional currency"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across commitments"
    - name: "commitment_count"
      expr: COUNT(DISTINCT cost_commitment_id)
      comment: "Count of distinct cost commitments"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT procurement_vendor_id)
      comment: "Count of unique vendors with commitments"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone performance metrics tracking schedule adherence, critical path items, and payment triggers for capital project delivery"
  source: "`mining_ecm`.`project`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., Design, Procurement, Construction, Commissioning)"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category classification of the milestone"
    - name: "is_critical"
      expr: criticality_flag
      comment: "Flag indicating if milestone is on critical path"
    - name: "is_payment_trigger"
      expr: payment_trigger_flag
      comment: "Flag indicating if milestone triggers payment"
    - name: "is_stage_gate"
      expr: stage_gate_flag
      comment: "Flag indicating if milestone is a stage gate"
    - name: "is_contractual_obligation"
      expr: contractual_obligation_flag
      comment: "Flag indicating if milestone is a contractual obligation"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the milestone"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone is planned"
    - name: "delay_reason"
      expr: delay_reason_code
      comment: "Code indicating reason for milestone delay"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount associated with milestones"
    - name: "avg_weight_percentage"
      expr: AVG(CAST(weight_percentage AS DOUBLE))
      comment: "Average weight percentage of milestones in project schedule"
    - name: "milestone_count"
      expr: COUNT(DISTINCT milestone_id)
      comment: "Count of distinct milestones"
    - name: "completed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN milestone_id END)
      comment: "Count of completed milestones with actual dates"
    - name: "critical_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN criticality_flag = TRUE THEN milestone_id END)
      comment: "Count of critical path milestones"
    - name: "payment_trigger_count"
      expr: COUNT(DISTINCT CASE WHEN payment_trigger_flag = TRUE THEN milestone_id END)
      comment: "Count of milestones that trigger payments"
    - name: "delayed_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN delay_reason_code IS NOT NULL THEN milestone_id END)
      comment: "Count of milestones with recorded delays"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order impact metrics tracking scope changes, cost impacts, and schedule impacts for project change management and control"
  source: "`mining_ecm`.`project`.`change_order`"
  dimensions:
    - name: "change_order_status"
      expr: change_order_status
      comment: "Current status of the change order"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., Scope, Design, Specification)"
    - name: "change_category"
      expr: change_category
      comment: "Category classification of the change"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order"
    - name: "is_critical_path_impact"
      expr: critical_path_impact_flag
      comment: "Flag indicating if change impacts critical path"
    - name: "is_baseline_update"
      expr: baseline_update_flag
      comment: "Flag indicating if change requires baseline update"
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Level of authority required for approval"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the change order was submitted"
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders"
    - name: "total_capex_impact"
      expr: SUM(CAST(capex_impact_amount AS DOUBLE))
      comment: "Total capital expenditure impact of change orders"
    - name: "total_opex_impact"
      expr: SUM(CAST(opex_impact_amount AS DOUBLE))
      comment: "Total operating expenditure impact of change orders"
    - name: "change_order_count"
      expr: COUNT(DISTINCT change_order_id)
      comment: "Count of distinct change orders"
    - name: "approved_change_count"
      expr: COUNT(DISTINCT CASE WHEN approval_date IS NOT NULL THEN change_order_id END)
      comment: "Count of approved change orders"
    - name: "rejected_change_count"
      expr: COUNT(DISTINCT CASE WHEN rejection_date IS NOT NULL THEN change_order_id END)
      comment: "Count of rejected change orders"
    - name: "critical_path_impact_count"
      expr: COUNT(DISTINCT CASE WHEN critical_path_impact_flag = TRUE THEN change_order_id END)
      comment: "Count of change orders impacting critical path"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_risk_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk management metrics tracking risk exposure, mitigation effectiveness, and potential cost and schedule impacts"
  source: "`mining_ecm`.`project`.`risk_item`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk item"
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk (e.g., Technical, Commercial, Environmental, Safety)"
    - name: "risk_category"
      expr: risk_category
      comment: "Category classification of the risk"
    - name: "risk_response_strategy"
      expr: risk_response_strategy
      comment: "Strategy for responding to the risk (e.g., Mitigate, Transfer, Accept, Avoid)"
    - name: "risk_proximity"
      expr: risk_proximity
      comment: "Proximity or timing of when risk may occur"
    - name: "likelihood_pre_mitigation"
      expr: likelihood_rating_pre_mitigation
      comment: "Likelihood rating before mitigation actions"
    - name: "likelihood_post_mitigation"
      expr: likelihood_rating_post_mitigation
      comment: "Likelihood rating after mitigation actions"
    - name: "consequence_pre_mitigation"
      expr: consequence_rating_pre_mitigation
      comment: "Consequence rating before mitigation actions"
    - name: "consequence_post_mitigation"
      expr: consequence_rating_post_mitigation
      comment: "Consequence rating after mitigation actions"
    - name: "residual_risk_status"
      expr: residual_risk_status
      comment: "Status of residual risk after mitigation"
    - name: "is_active"
      expr: record_active_flag
      comment: "Flag indicating if risk is currently active"
  measures:
    - name: "total_cost_impact_estimate"
      expr: SUM(CAST(cost_impact_estimate_usd AS DOUBLE))
      comment: "Total estimated cost impact of all risks in USD"
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average probability percentage across all risks"
    - name: "risk_count"
      expr: COUNT(DISTINCT risk_item_id)
      comment: "Count of distinct risk items"
    - name: "active_risk_count"
      expr: COUNT(DISTINCT CASE WHEN record_active_flag = TRUE THEN risk_item_id END)
      comment: "Count of active risk items"
    - name: "closed_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_closed_date IS NOT NULL THEN risk_item_id END)
      comment: "Count of closed risk items"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_feasibility_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feasibility study economics metrics tracking project viability, capital costs, operating costs, and financial returns for investment decisions"
  source: "`mining_ecm`.`project`.`feasibility_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of feasibility study (e.g., Scoping, Pre-Feasibility, Feasibility, Bankable)"
    - name: "study_status"
      expr: study_status
      comment: "Current status of the feasibility study"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the study"
    - name: "capital_cost_class"
      expr: capital_cost_class
      comment: "Class of capital cost estimate (e.g., AACE Class 5, 4, 3, 2, 1)"
    - name: "environmental_approval_status"
      expr: environmental_approval_status
      comment: "Status of environmental approvals"
    - name: "study_completion_year"
      expr: YEAR(study_completion_date)
      comment: "Year the study was completed"
    - name: "has_risk_assessment"
      expr: risk_assessment_completed
      comment: "Flag indicating if risk assessment was completed"
    - name: "has_sensitivity_analysis"
      expr: sensitivity_analysis_completed
      comment: "Flag indicating if sensitivity analysis was completed"
    - name: "has_social_impact_assessment"
      expr: social_impact_assessment_completed
      comment: "Flag indicating if social impact assessment was completed"
  measures:
    - name: "total_capital_cost_estimate"
      expr: SUM(CAST(capital_cost_estimate AS DOUBLE))
      comment: "Total capital cost estimate across all feasibility studies"
    - name: "total_operating_cost_estimate"
      expr: SUM(CAST(operating_cost_estimate AS DOUBLE))
      comment: "Total operating cost estimate across all studies"
    - name: "total_npv"
      expr: SUM(CAST(npv AS DOUBLE))
      comment: "Total net present value across all feasibility studies"
    - name: "avg_irr"
      expr: AVG(CAST(irr AS DOUBLE))
      comment: "Average internal rate of return across studies"
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years across studies"
    - name: "total_annual_production_rate"
      expr: SUM(CAST(annual_production_rate AS DOUBLE))
      comment: "Total annual production rate across all studies"
    - name: "avg_life_of_mine_years"
      expr: AVG(CAST(life_of_mine_years AS DOUBLE))
      comment: "Average life of mine in years across studies"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate used in studies"
    - name: "avg_commodity_price_assumption"
      expr: AVG(CAST(commodity_price_assumption AS DOUBLE))
      comment: "Average commodity price assumption across studies"
    - name: "study_count"
      expr: COUNT(DISTINCT feasibility_study_id)
      comment: "Count of distinct feasibility studies"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project contract performance metrics tracking contract value, variations, completion progress, and contractor performance"
  source: "`mining_ecm`.`project`.`project_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the project contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Lump Sum, Unit Rate, Cost Plus, EPC)"
    - name: "is_insurance_required"
      expr: insurance_required
      comment: "Flag indicating if insurance is required"
    - name: "is_performance_bond_required"
      expr: performance_bond_required
      comment: "Flag indicating if performance bond is required"
    - name: "is_liquidated_damages_applicable"
      expr: liquidated_damages_applicable
      comment: "Flag indicating if liquidated damages are applicable"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year the contract was executed"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the contract"
    - name: "is_active"
      expr: record_active_flag
      comment: "Flag indicating if contract is currently active"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across all contracts"
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract value including variations"
    - name: "total_variation_amount"
      expr: SUM(CAST(total_variation_amount AS DOUBLE))
      comment: "Total variation amount across all contracts"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed cost across all contracts"
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual cost incurred to date across all contracts"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount held across all contracts"
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond amount across all contracts"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all contracts"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across all contracts"
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across contracts"
    - name: "contract_count"
      expr: COUNT(DISTINCT project_contract_id)
      comment: "Count of distinct project contracts"
    - name: "unique_contractors"
      expr: COUNT(DISTINCT contractor_id)
      comment: "Count of unique contractors engaged"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`project_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project phase performance metrics tracking phase-level budget, schedule, and cost performance for capital project execution"
  source: "`mining_ecm`.`project`.`phase`"
  dimensions:
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the project phase"
    - name: "phase_name"
      expr: phase_name
      comment: "Name of the project phase"
    - name: "is_critical_path"
      expr: critical_path_flag
      comment: "Flag indicating if phase is on critical path"
    - name: "is_gate_approval_required"
      expr: gate_approval_required
      comment: "Flag indicating if gate approval is required"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the phase"
    - name: "is_active"
      expr: record_active_flag
      comment: "Flag indicating if phase is currently active"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the phase is planned to start"
    - name: "currency"
      expr: currency_code
      comment: "Currency code of the phase budget"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget amount across all phases"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all phases"
    - name: "total_forecast_cost"
      expr: SUM(CAST(forecast_cost AS DOUBLE))
      comment: "Total forecast cost across all phases"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed cost across all phases"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance across all phases"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all phases"
    - name: "phase_count"
      expr: COUNT(DISTINCT phase_id)
      comment: "Count of distinct project phases"
    - name: "completed_phase_count"
      expr: COUNT(DISTINCT CASE WHEN actual_finish_date IS NOT NULL THEN phase_id END)
      comment: "Count of completed phases"
    - name: "critical_path_phase_count"
      expr: COUNT(DISTINCT CASE WHEN critical_path_flag = TRUE THEN phase_id END)
      comment: "Count of phases on critical path"
$$;