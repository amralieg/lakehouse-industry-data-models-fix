-- Metric views for domain: project | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_cip_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over Capital Improvement Projects (CIP). Tracks portfolio health, cost performance, schedule adherence, and delivery progress across all active infrastructure investments."
  source: "`water_utilities_ecm`.`project`.`cip_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the CIP project (e.g., Active, Closed, On Hold) — primary filter for portfolio dashboards."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project type (e.g., Rehabilitation, New Construction, Expansion) — used to segment capital spend by investment category."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project (e.g., Planning, Design, Construction, Closeout) — enables phase-gate performance analysis."
    - name: "infrastructure_category"
      expr: infrastructure_category
      comment: "Infrastructure asset category (e.g., Transmission, Distribution, Treatment) — aligns capital spend to asset class strategy."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Executive-assigned priority tier for the project — used to focus resources on highest-impact investments."
    - name: "funding_source"
      expr: funding_source
      comment: "Primary funding source (e.g., Rate Revenue, Bond, Grant) — critical for capital financing and rate case reporting."
    - name: "sponsoring_department"
      expr: sponsoring_department
      comment: "Department sponsoring the project — enables departmental accountability and budget ownership analysis."
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Regulatory mandate or driver behind the project — used to prioritize compliance-driven capital investments."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class associated with the project output — links capital investment to asset lifecycle management."
    - name: "cip_program_year"
      expr: cip_program_year
      comment: "CIP program year the project belongs to — enables year-over-year capital program comparison."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the project was planned to start — used for capital program scheduling analysis."
    - name: "planned_completion_year"
      expr: DATE_TRUNC('YEAR', planned_completion_date)
      comment: "Year the project was planned to complete — used for delivery timeline tracking."
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Indicates whether a permit is required for the project — used to track regulatory compliance readiness."
  measures:
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized capital budget across all CIP projects. Core metric for capital program sizing and rate case justification."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Sum of estimated total costs across all CIP projects. Compared against authorized budget to identify funding gaps."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total capital expenditure incurred to date across all active CIP projects. Key cash flow and budget burn metric."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Aggregate cost variance (actual vs. authorized budget) across the CIP portfolio. Negative values signal budget overruns requiring executive intervention."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across all CIP projects. Tracks overall portfolio delivery progress."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design capacity in million gallons per day (MGD) being added or rehabilitated across the CIP portfolio. Directly tied to service capacity planning."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN cip_project_id END)
      comment: "Number of currently active CIP projects. Used to assess portfolio workload and resource allocation adequacy."
    - name: "projects_with_permit_required"
      expr: COUNT(CASE WHEN permit_required_flag = TRUE THEN cip_project_id END)
      comment: "Count of CIP projects requiring regulatory permits. Tracks permitting pipeline risk to project delivery schedules."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_to_date AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized budget consumed to date across the CIP portfolio. Key indicator of capital program execution pace and budget burn rate."
    - name: "cost_overrun_project_count"
      expr: COUNT(CASE WHEN cost_variance_amount < 0 THEN cip_project_id END)
      comment: "Number of CIP projects with negative cost variance (i.e., over budget). Triggers executive review and corrective action."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial governance KPI layer over project budgets. Tracks budget adequacy, contingency health, encumbrance levels, and funding source composition for capital program financial stewardship."
  source: "`water_utilities_ecm`.`project`.`project_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the project budget (e.g., Approved, Pending, Closed) — primary filter for active budget analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget line (e.g., Construction, Design, Contingency) — enables spend category analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget — enables year-over-year capital budget comparison and rate case alignment."
    - name: "funding_source_primary"
      expr: funding_source_primary
      comment: "Primary funding source for the budget (e.g., Rate Revenue, Bond, Grant) — critical for capital financing strategy."
    - name: "funding_source_secondary"
      expr: funding_source_secondary
      comment: "Secondary funding source — used to analyze blended financing structures."
    - name: "phase"
      expr: phase
      comment: "Project phase associated with the budget (e.g., Design, Construction) — enables phase-level budget tracking."
    - name: "is_multi_year_budget"
      expr: is_multi_year_budget
      comment: "Indicates whether the budget spans multiple fiscal years — used to identify long-duration capital commitments."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the budget became effective — used for temporal budget trend analysis."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of all original approved budget amounts. Baseline for measuring budget growth due to amendments and change orders."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget_amount AS DOUBLE))
      comment: "Total current approved budget including all amendments. The authoritative budget figure for financial reporting and rate cases."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual capital expenditures recorded against project budgets. Core metric for capital spend tracking."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent budget across all project budgets. Indicates available capital capacity and funding adequacy."
    - name: "total_encumbered_amount"
      expr: SUM(CAST(encumbered_amount AS DOUBLE))
      comment: "Total encumbered (committed but not yet spent) budget. Critical for cash flow forecasting and avoiding over-commitment."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves held across all project budgets. Tracks risk buffer adequacy for the capital program."
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total grant funding secured across all project budgets. Measures success in reducing ratepayer-funded capital burden."
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total bond-financed capital across all project budgets. Key input for debt service coverage and rate case modeling."
    - name: "total_capex_amount"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure (CAPEX) budget across all projects. Directly feeds rate base calculations and regulatory filings."
    - name: "budget_execution_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of current approved budget that has been spent. Measures capital program execution efficiency — low rates signal delivery delays."
    - name: "contingency_utilization_rate"
      expr: ROUND(100.0 * (SUM(CAST(current_approved_budget_amount AS DOUBLE)) - SUM(CAST(original_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(contingency_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of budget growth (amendments) to available contingency. High values signal contingency depletion risk requiring executive attention."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage held across project budgets. Benchmarked against utility industry standards (typically 10-15%) to assess risk posture."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract change management KPI layer. Tracks change order volume, cost impact, approval cycle performance, and scope/regulatory drivers — critical for construction contract cost control and contractor performance management."
  source: "`water_utilities_ecm`.`project`.`change_order`"
  dimensions:
    - name: "change_order_status"
      expr: change_order_status
      comment: "Current status of the change order (e.g., Pending, Approved, Rejected) — primary filter for active change order pipeline."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g., Scope Addition, Differing Site Conditions, Design Error) — used to identify systemic root causes of cost growth."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order — used to triage and expedite high-impact changes."
    - name: "scope_addition_flag"
      expr: scope_addition_flag
      comment: "Indicates whether the change order adds scope to the contract — used to distinguish growth from corrections."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Indicates whether the change order is driven by a regulatory requirement — used to separate mandated cost growth from discretionary changes."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the change order has environmental impact — used for environmental compliance tracking."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Indicates whether the change order has safety implications — used to prioritize safety-critical changes."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the change order was approved — enables year-over-year change order trend analysis."
    - name: "initiated_year"
      expr: DATE_TRUNC('YEAR', initiated_date)
      comment: "Year the change order was initiated — used to track change order origination trends."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. The primary measure of contract cost growth — directly affects project budget adequacy and rate case projections."
    - name: "total_cumulative_change_order_value"
      expr: SUM(CAST(cumulative_change_order_value AS DOUBLE))
      comment: "Sum of cumulative change order values across all contracts. Measures total contract value growth from original award."
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original contract values at award. Baseline for calculating change order impact as a percentage of contract value."
    - name: "change_order_count"
      expr: COUNT(change_order_id)
      comment: "Total number of change orders. High volumes signal poor scope definition, design quality issues, or site condition surprises."
    - name: "approved_change_order_count"
      expr: COUNT(CASE WHEN change_order_status = 'Approved' THEN change_order_id END)
      comment: "Number of approved change orders. Used to track approved cost growth and contract modification volume."
    - name: "regulatory_driven_change_order_count"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN change_order_id END)
      comment: "Number of change orders driven by regulatory requirements. Measures compliance-mandated cost growth that may be recoverable in rate cases."
    - name: "cost_impact_as_pct_of_original_contract"
      expr: ROUND(100.0 * SUM(CAST(cost_impact_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Total change order cost impact as a percentage of original contract value. Industry benchmark KPI — values above 10% signal contract management issues requiring executive attention."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Used to assess the materiality of individual changes and set approval threshold policies."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_construction_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction contract performance KPI layer. Tracks contract value, payment progress, retainage, liquidated damages, and delivery performance — essential for contractor management and capital program financial control."
  source: "`water_utilities_ecm`.`project`.`construction_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the construction contract (e.g., Active, Closed, Suspended) — primary filter for active contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of construction contract (e.g., Lump Sum, Unit Price, Cost Plus) — used to analyze risk allocation and cost predictability by contract structure."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — used to assess contractor risk mitigation coverage."
    - name: "payment_bond_required"
      expr: payment_bond_required
      comment: "Indicates whether a payment bond is required — used to protect subcontractors and suppliers."
    - name: "insurance_certificate_received"
      expr: insurance_certificate_received
      comment: "Indicates whether the contractor's insurance certificate has been received — tracks compliance with contract requirements."
    - name: "award_year"
      expr: DATE_TRUNC('YEAR', award_date)
      comment: "Year the contract was awarded — enables year-over-year contract award volume and value analysis."
    - name: "substantial_completion_year"
      expr: DATE_TRUNC('YEAR', substantial_completion_date)
      comment: "Year of substantial completion — used to track delivery performance against planned schedules."
  measures:
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of all awarded construction contracts. Core capital program commitment metric used in financial planning and rate cases."
    - name: "total_current_contract_value"
      expr: SUM(CAST(current_contract_value AS DOUBLE))
      comment: "Total current contract value including all approved change orders. Reflects true financial exposure across the construction portfolio."
    - name: "total_paid_to_date"
      expr: SUM(CAST(total_paid_to_date AS DOUBLE))
      comment: "Total payments made to contractors to date. Key cash flow metric for capital program financial management."
    - name: "total_retainage_held"
      expr: SUM(CAST(retainage_amount AS DOUBLE))
      comment: "Total retainage withheld from contractor payments. Represents financial leverage for ensuring contract completion and defect correction."
    - name: "total_liquidated_damages_assessed"
      expr: SUM(CAST(liquidated_damages_assessed AS DOUBLE))
      comment: "Total liquidated damages assessed against contractors for schedule delays. Measures financial consequences of contractor non-performance."
    - name: "total_change_order_amount"
      expr: SUM(CAST(total_change_order_amount AS DOUBLE))
      comment: "Total approved change order value across all construction contracts. Measures aggregate contract cost growth from original award."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across all active construction contracts. Tracks overall construction delivery progress."
    - name: "contract_cost_growth_rate"
      expr: ROUND(100.0 * SUM(CAST(total_change_order_amount AS DOUBLE)) / NULLIF(SUM(CAST(awarded_contract_value AS DOUBLE)), 0), 2)
      comment: "Total change order value as a percentage of original awarded contract value. Industry benchmark KPI for construction contract cost control — values above 10% trigger management review."
    - name: "payment_progress_rate"
      expr: ROUND(100.0 * SUM(CAST(total_paid_to_date AS DOUBLE)) / NULLIF(SUM(CAST(current_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of current contract value paid to date. Measures payment velocity and cash flow execution against contract commitments."
    - name: "avg_retainage_percentage"
      expr: AVG(CAST(retainage_percentage AS DOUBLE))
      comment: "Average retainage percentage held across construction contracts. Benchmarked against standard utility practice (typically 5-10%) to ensure appropriate contractor incentives."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project cost transaction KPI layer. Tracks actual capital expenditure flows, capitalization rates, cost type composition, and transaction volumes — essential for project cost accounting, WBS-level cost control, and asset capitalization compliance."
  source: "`water_utilities_ecm`.`project`.`cost_transaction`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost transaction (e.g., Labor, Materials, Equipment, Overhead) — enables cost structure analysis by category."
    - name: "cost_element"
      expr: cost_element
      comment: "Specific cost element code — provides granular cost classification for project accounting and WBS reporting."
    - name: "capitalization_flag"
      expr: capitalization_flag
      comment: "Indicates whether the cost is capitalizable to a fixed asset. Critical for rate base calculation and regulatory asset accounting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the transaction is a reversal/correction. Used to identify and investigate accounting adjustments."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the cost posting (e.g., Posted, Pending, Reversed) — used to ensure only finalized costs are included in financial reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost transaction — enables year-over-year capital spend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost transaction — enables monthly capital spend tracking and budget variance reporting."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class associated with the cost transaction — links expenditure to asset lifecycle and depreciation categories."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the cost transaction (e.g., SAP, Oracle, Maximo) — used for data lineage and reconciliation."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the cost transaction — enables monthly capital spend trend analysis and cash flow forecasting."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total cost transaction amount across all project cost postings. The primary measure of actual capital expenditure — core input for project cost reporting and rate base calculations."
    - name: "total_capitalizable_amount"
      expr: SUM(CASE WHEN capitalization_flag = TRUE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of costs flagged as capitalizable to fixed assets. Directly determines rate base additions and depreciation calculations for regulatory filings."
    - name: "total_non_capitalizable_amount"
      expr: SUM(CASE WHEN capitalization_flag = FALSE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of costs not capitalizable (expensed). Used to identify and minimize non-capitalizable project costs that reduce rate base."
    - name: "capitalization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capitalization_flag = TRUE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(transaction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total project costs that are capitalizable. Low rates signal potential accounting issues or excessive overhead allocation — benchmarked against regulatory expectations."
    - name: "transaction_count"
      expr: COUNT(cost_transaction_id)
      comment: "Total number of cost transactions. Used to assess transaction volume and identify periods of high activity or potential data quality issues."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN cost_transaction_id END)
      comment: "Number of reversal/correction transactions. High reversal rates signal project cost accounting quality issues requiring process improvement."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN cost_transaction_id END) / NULLIF(COUNT(cost_transaction_id), 0), 2)
      comment: "Percentage of cost transactions that are reversals. A key data quality and process health indicator — high rates trigger accounting process review."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average cost transaction amount. Used to detect anomalous transactions and benchmark transaction size against historical norms."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_pay_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor payment application KPI layer. Tracks payment certification, retainage management, billing progress, and payment cycle performance — essential for construction cash flow management and contractor relationship health."
  source: "`water_utilities_ecm`.`project`.`pay_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the pay application (e.g., Submitted, Certified, Paid, Rejected) — primary filter for payment pipeline management."
    - name: "billing_period_year"
      expr: DATE_TRUNC('YEAR', billing_period_end_date)
      comment: "Year of the billing period — enables year-over-year payment volume analysis."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_end_date)
      comment: "Month of the billing period — enables monthly cash flow tracking and payment cycle analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the pay application was submitted — used to track submission timeliness and payment cycle duration."
  measures:
    - name: "total_current_payment_due"
      expr: SUM(CAST(current_payment_due_amount AS DOUBLE))
      comment: "Total payment amounts currently due to contractors. Core cash flow metric for capital program financial management and treasury planning."
    - name: "total_owner_approved_amount"
      expr: SUM(CAST(owner_approved_amount AS DOUBLE))
      comment: "Total amounts approved by the owner for payment. Measures payment approval throughput and identifies certification bottlenecks."
    - name: "total_engineer_certified_amount"
      expr: SUM(CAST(engineer_certified_amount AS DOUBLE))
      comment: "Total amounts certified by the engineer of record. Tracks engineering certification throughput and identifies discrepancies between engineer and owner approvals."
    - name: "total_retainage_withheld"
      expr: SUM(CAST(retainage_amount AS DOUBLE))
      comment: "Total retainage withheld across all pay applications. Represents the financial leverage pool for ensuring contract completion."
    - name: "total_work_completed_to_date"
      expr: SUM(CAST(work_completed_to_date_amount AS DOUBLE))
      comment: "Total value of work completed to date across all contracts. Measures aggregate construction progress in financial terms."
    - name: "total_balance_to_finish"
      expr: SUM(CAST(balance_to_finish_amount AS DOUBLE))
      comment: "Total remaining contract value to be earned. Measures remaining financial exposure and future cash flow requirements."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across all pay applications. Tracks overall construction delivery progress from a payment perspective."
    - name: "certification_approval_variance"
      expr: ROUND(SUM(CAST(engineer_certified_amount AS DOUBLE)) - SUM(CAST(owner_approved_amount AS DOUBLE)), 2)
      comment: "Difference between engineer-certified and owner-approved payment amounts. Persistent positive values indicate owner is systematically under-approving certified work, creating contractor disputes."
    - name: "retainage_rate"
      expr: ROUND(100.0 * SUM(CAST(retainage_amount AS DOUBLE)) / NULLIF(SUM(CAST(work_completed_to_date_amount AS DOUBLE)), 0), 2)
      comment: "Effective retainage rate as a percentage of work completed to date. Ensures retainage is being applied consistently per contract terms."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_budget_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget amendment governance KPI layer. Tracks amendment frequency, financial impact, contingency consumption, and approval patterns — essential for capital program cost control and board-level budget governance."
  source: "`water_utilities_ecm`.`project`.`budget_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the budget amendment (e.g., Pending, Approved, Rejected) — primary filter for active amendment pipeline."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of budget amendment (e.g., Scope Change, Contingency Draw, Regulatory) — used to identify systemic drivers of budget growth."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the amendment — enables root cause analysis of budget deviations."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority level required to approve the amendment (e.g., PM, Director, Board) — used to track governance compliance and approval cycle times."
    - name: "contingency_impact_flag"
      expr: contingency_impact_flag
      comment: "Indicates whether the amendment draws from contingency reserves — used to track contingency depletion rate."
    - name: "approval_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year the amendment was approved — enables year-over-year budget amendment trend analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the amendment became effective — used for temporal budget revision analysis."
  measures:
    - name: "total_amendment_amount"
      expr: SUM(CAST(amendment_amount AS DOUBLE))
      comment: "Total net budget amendment amount across all amendments. Measures aggregate budget growth from original authorization — key board governance metric."
    - name: "total_contingency_amount_used"
      expr: SUM(CAST(contingency_amount_used AS DOUBLE))
      comment: "Total contingency reserves consumed by amendments. Tracks depletion of risk buffers — high values signal project risk materialization."
    - name: "total_remaining_contingency"
      expr: SUM(CAST(remaining_contingency AS DOUBLE))
      comment: "Total remaining contingency reserves after amendments. Measures residual risk buffer adequacy across the capital program."
    - name: "amendment_count"
      expr: COUNT(budget_amendment_id)
      comment: "Total number of budget amendments. High amendment frequency signals poor initial scope definition or inadequate risk assessment."
    - name: "contingency_drawing_amendment_count"
      expr: COUNT(CASE WHEN contingency_impact_flag = TRUE THEN budget_amendment_id END)
      comment: "Number of amendments that draw from contingency reserves. Tracks how frequently risk events are materializing and consuming contingency."
    - name: "avg_amendment_amount"
      expr: AVG(CAST(amendment_amount AS DOUBLE))
      comment: "Average amendment amount per budget amendment. Used to assess materiality of individual amendments and calibrate approval threshold policies."
    - name: "budget_growth_rate"
      expr: ROUND(100.0 * SUM(CAST(amendment_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_budget_amount AS DOUBLE)), 0), 2)
      comment: "Total amendment amount as a percentage of original budget. The primary measure of budget discipline — values above 15% trigger board-level review of project scope and risk management."
    - name: "contingency_consumption_rate"
      expr: ROUND(100.0 * SUM(CAST(contingency_amount_used AS DOUBLE)) / NULLIF(SUM(CAST(contingency_amount_used AS DOUBLE)) + SUM(CAST(remaining_contingency AS DOUBLE)), 0), 2)
      comment: "Percentage of total contingency that has been consumed. Critical risk indicator — values above 80% signal imminent budget overrun risk requiring executive intervention."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone performance KPI layer. Tracks schedule adherence, critical path delivery, regulatory milestone compliance, and completion rates — essential for project delivery governance and regulatory reporting."
  source: "`water_utilities_ecm`.`project`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Completed, In Progress, At Risk, Missed) — primary filter for delivery performance dashboards."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., Design Complete, Construction Start, Substantial Completion) — enables phase-gate performance analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path — used to focus management attention on schedule-critical deliverables."
    - name: "is_regulatory_milestone"
      expr: is_regulatory_milestone
      comment: "Indicates whether the milestone is a regulatory commitment — used to track compliance with consent orders, permits, and regulatory agreements."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the milestone (e.g., Low, Medium, High) — used to prioritize management intervention."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for the milestone (e.g., Owner, Contractor, Regulator) — used for accountability tracking."
    - name: "baseline_year"
      expr: DATE_TRUNC('YEAR', baseline_date)
      comment: "Year of the baseline milestone date — enables year-over-year schedule performance analysis."
    - name: "forecast_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month of the forecasted milestone completion — used for near-term schedule risk identification."
  measures:
    - name: "total_milestone_count"
      expr: COUNT(milestone_id)
      comment: "Total number of project milestones. Provides denominator for completion rate and on-time delivery calculations."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN milestone_id END)
      comment: "Number of milestones that have been completed. Tracks overall project delivery progress across the portfolio."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN milestone_id END)
      comment: "Number of milestones on the critical path. Used to assess schedule risk concentration and resource prioritization needs."
    - name: "regulatory_milestone_count"
      expr: COUNT(CASE WHEN is_regulatory_milestone = TRUE THEN milestone_id END)
      comment: "Number of regulatory milestones. Tracks the volume of compliance commitments that must be met to avoid enforcement actions."
    - name: "milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' THEN milestone_id END) / NULLIF(COUNT(milestone_id), 0), 2)
      comment: "Percentage of milestones that have been completed. Primary delivery performance KPI — low rates signal systemic schedule execution issues."
    - name: "regulatory_milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_milestone = TRUE AND milestone_status = 'Completed' THEN milestone_id END) / NULLIF(COUNT(CASE WHEN is_regulatory_milestone = TRUE THEN milestone_id END), 0), 2)
      comment: "Percentage of regulatory milestones that have been completed. Critical compliance KPI — missed regulatory milestones can trigger enforcement actions and financial penalties."
    - name: "total_budget_impact_from_milestones"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total budget impact associated with milestone variances. Quantifies the financial consequence of schedule deviations across the project portfolio."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all milestones. Provides a portfolio-level view of delivery progress weighted by milestone count."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Breakdown Structure (WBS) earned value and cost performance KPI layer. Tracks planned vs. actual cost, earned value, schedule performance, and budget adherence at the WBS level — the foundational layer for project cost control and earned value management (EVM)."
  source: "`water_utilities_ecm`.`project`.`wbs_element`"
  dimensions:
    - name: "wbs_element_status"
      expr: wbs_element_status
      comment: "Current status of the WBS element (e.g., Active, Closed, On Hold) — primary filter for active work package analysis."
    - name: "wbs_element_type"
      expr: wbs_element_type
      comment: "Type of WBS element (e.g., Work Package, Planning Package, Summary) — used to filter to executable work packages for EVM analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the WBS hierarchy — used to roll up cost and schedule performance from work packages to project summary level."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area associated with the WBS element (e.g., Civil, Mechanical, Electrical) — enables discipline-level cost performance analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the WBS element — used to focus cost control attention on high-risk work packages."
    - name: "commissioning_required_flag"
      expr: commissioning_required_flag
      comment: "Indicates whether commissioning is required for the WBS element — used to track commissioning readiness across the project."
    - name: "regulatory_permit_required_flag"
      expr: regulatory_permit_required_flag
      comment: "Indicates whether a regulatory permit is required for the WBS element — used to track permitting dependencies on project schedule."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the WBS element was planned to start — used for resource loading and schedule analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost across all WBS elements (Budget at Completion / BAC in EVM terms). The baseline for all cost performance calculations."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all WBS elements (Actual Cost of Work Performed / ACWP in EVM terms). Core cost performance metric."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across all WBS elements (Budgeted Cost of Work Performed / BCWP in EVM terms). Measures the value of work actually accomplished."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value across all WBS elements (Budgeted Cost of Work Scheduled / BCWS in EVM terms). Baseline for schedule performance measurement."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed costs (purchase orders, contracts) across all WBS elements. Measures financial obligations not yet invoiced — critical for cash flow forecasting."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 3)
      comment: "Cost Performance Index (CPI = EV / AC). The primary EVM efficiency metric — values below 1.0 indicate cost overrun; values above 1.0 indicate cost underrun. Used by executives to forecast final project cost."
    - name: "schedule_performance_index"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) / NULLIF(SUM(CAST(planned_value AS DOUBLE)), 0), 3)
      comment: "Schedule Performance Index (SPI = EV / PV). Measures schedule efficiency — values below 1.0 indicate schedule delay; values above 1.0 indicate ahead of schedule. Used to forecast project completion dates."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) - SUM(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Cost Variance (CV = EV - AC). Positive values indicate under-budget performance; negative values indicate cost overruns. The primary EVM cost health indicator."
    - name: "schedule_variance"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) - SUM(CAST(planned_value AS DOUBLE)), 2)
      comment: "Schedule Variance (SV = EV - PV). Positive values indicate ahead-of-schedule performance; negative values indicate schedule delays. Used to quantify schedule risk in financial terms."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across all WBS elements. Provides a portfolio-level delivery progress indicator."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`project_design_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design and engineering contract KPI layer. Tracks design contract value, payment progress, retainage, and DBE participation — essential for engineering procurement management and design quality governance."
  source: "`water_utilities_ecm`.`project`.`design_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the design contract (e.g., Active, Completed, Terminated) — primary filter for active design contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of design contract (e.g., Fixed Fee, Time and Materials, Lump Sum) — used to analyze risk allocation in engineering procurement."
    - name: "design_phase"
      expr: design_phase
      comment: "Current design phase (e.g., Preliminary, 30%, 60%, 90%, Final) — enables phase-gate design progress tracking."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Method used to procure the design contract (e.g., QBS, RFP, Sole Source) — used to assess procurement compliance and competition."
    - name: "construction_administration_included"
      expr: construction_administration_included
      comment: "Indicates whether construction administration services are included in the design contract — used to track CA coverage across the project portfolio."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required for the design contract — tracks risk mitigation coverage."
    - name: "execution_year"
      expr: DATE_TRUNC('YEAR', execution_date)
      comment: "Year the design contract was executed — enables year-over-year design procurement volume analysis."
  measures:
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Total original design contract value at execution. Baseline for measuring design contract cost growth due to amendments."
    - name: "total_current_contract_value"
      expr: SUM(CAST(current_contract_value AS DOUBLE))
      comment: "Total current design contract value including all amendments. Reflects true engineering cost exposure across the project portfolio."
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date AS DOUBLE))
      comment: "Total payments made to design consultants to date. Key cash flow metric for engineering services management."
    - name: "total_invoiced_to_date"
      expr: SUM(CAST(invoiced_to_date AS DOUBLE))
      comment: "Total amounts invoiced by design consultants to date. Compared against paid-to-date to identify payment processing backlogs."
    - name: "total_retainage_held"
      expr: SUM(CAST(retainage_amount AS DOUBLE))
      comment: "Total retainage withheld from design consultant payments. Represents financial leverage for ensuring deliverable completion."
    - name: "total_amendment_value"
      expr: SUM(CAST(amendment_value AS DOUBLE))
      comment: "Total value of design contract amendments. Measures design scope growth — high values may indicate inadequate initial scope definition or design complexity."
    - name: "total_dbe_participation"
      expr: SUM(CAST(disadvantaged_business_enterprise_participation AS DOUBLE))
      comment: "Total Disadvantaged Business Enterprise (DBE) participation value across design contracts. Tracks compliance with DBE program goals and regulatory requirements."
    - name: "design_contract_cost_growth_rate"
      expr: ROUND(100.0 * SUM(CAST(amendment_value AS DOUBLE)) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Design contract amendment value as a percentage of original contract value. Measures design scope creep — values above 15% signal inadequate initial scope definition or design complexity."
    - name: "payment_progress_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_to_date AS DOUBLE)) / NULLIF(SUM(CAST(current_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of current design contract value paid to date. Measures payment velocity and identifies contracts with payment processing issues."
$$;