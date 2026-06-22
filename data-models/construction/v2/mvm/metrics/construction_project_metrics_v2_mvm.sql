-- Metric views for domain: project | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level KPIs for the construction project portfolio — contract value, budget performance, schedule performance, and physical progress. Used in portfolio steering, board reporting, and PMO dashboards."
  source: "`vibe_construction_v1`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, Closed, On Hold) — primary filter for portfolio health views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project type (e.g. Civil, MEP, Infrastructure) — used to segment portfolio by work category."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (e.g. EPC, Design-Build, LSTK) — key dimension for benchmarking performance across procurement strategies."
    - name: "region"
      expr: region
      comment: "Geographic region of the project — used for regional portfolio analysis and resource allocation decisions."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the project location — supports country-level regulatory and financial reporting."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk classification (e.g. High, Medium, Low) — used to prioritise safety interventions across the portfolio."
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "PMO tier or classification assigned to the project — used to segment reporting by strategic importance."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the project is a joint venture — used to separate JV exposure from wholly-owned project performance."
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract — required for multi-currency portfolio aggregation and FX risk analysis."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the project was planned to start — used for vintage cohort analysis of project performance."
    - name: "planned_completion_year"
      expr: YEAR(planned_completion_date)
      comment: "Year the project is planned to complete — used for workload forecasting and resource capacity planning."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across the portfolio. Core revenue exposure metric used in board-level portfolio reporting and financial forecasting."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved budget across all projects. Used to assess overall capital commitment and compare against contract value for margin analysis."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN construction_project_id END)
      comment: "Number of currently active projects. Key portfolio size indicator used in PMO capacity and resource planning."
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across the portfolio. Used to assess overall portfolio delivery pace and identify lagging projects."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index (CPI) across projects. CPI < 1.0 signals cost overrun; used in executive steering to trigger corrective action."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI) across projects. SPI < 1.0 signals schedule slippage; used in PMO dashboards and board reporting."
    - name: "total_jv_partner_share_pct"
      expr: AVG(CASE WHEN is_joint_venture = TRUE THEN CAST(jv_partner_share_pct AS DOUBLE) END)
      comment: "Average JV partner share percentage for joint venture projects. Used to assess risk exposure and profit-sharing obligations in JV portfolio."
    - name: "total_retention_exposure"
      expr: SUM(CAST(contract_value AS DOUBLE) * CAST(retention_pct AS DOUBLE) / 100.0)
      comment: "Estimated total retention amount held across the portfolio (contract value × retention %). Critical for cash flow forecasting and working capital management."
    - name: "projects_at_high_hse_risk"
      expr: COUNT(CASE WHEN hse_risk_level = 'High' THEN construction_project_id END)
      comment: "Number of projects classified at High HSE risk. Used by HSE leadership to prioritise safety audits and resource deployment."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average daily liquidated damages rate across projects. Used to quantify schedule delay financial exposure at the portfolio level."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost control KPIs at the cost account level — budget vs actuals, earned value, cost variance, and forecast at completion. Used by project controllers, PMO, and finance for cost performance management."
  source: "`vibe_construction_v1`.`project`.`cost_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the cost account (e.g. Active, Closed, On Hold) — used to filter active cost control scope."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost account — required for multi-currency cost consolidation."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates whether the cost account is lump sum or re-measurable — affects how cost performance is interpreted."
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Indicates whether the cost account covers subcontracted scope — used to separate direct vs subcontract cost performance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities in this cost account — used for productivity and unit rate analysis."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Reporting period month — used to trend cost performance over time in monthly project control reports."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code — used to reconcile project costs against financial accounting records."
  measures:
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across cost accounts. Baseline for all cost performance comparisons and variance analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred. Core cost control metric used to assess spend against budget."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost (contracts awarded but not yet invoiced). Used for cash flow forecasting and exposure management."
    - name: "total_cost_to_complete"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total estimated cost to complete remaining scope. Critical input to Estimate at Completion (EAC) and project financial forecasting."
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total forecast cost at completion (EAC). Used by finance and PMO to project final cost outturn and assess budget adequacy."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (Earned Value minus Actual Cost). Negative values indicate cost overrun; used in project control reviews."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total earned value (BCWP) across cost accounts. Foundation of EVM analysis — measures value of work actually performed."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order value incorporated into cost accounts. Used to track scope growth and its cost impact."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget held across cost accounts. Used to assess remaining risk buffer and contingency drawdown rate."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across cost accounts. CPI < 1.0 signals cost overrun; used in project control dashboards."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across cost accounts. Used to assess overall scope delivery progress."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed by actual costs. Key cost control ratio used in project financial health assessments."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_evm_period_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period-level Earned Value Management (EVM) KPIs — BCWP, BCWS, ACWP, CPI, SPI, EAC, VAC. Used by PMO and project controls for schedule and cost performance trending and forecasting."
  source: "`vibe_construction_v1`.`project`.`evm_period_record`"
  dimensions:
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of the EVM measurement — used to trend CPI/SPI performance over time."
    - name: "data_date_month"
      expr: DATE_TRUNC('month', data_date)
      comment: "Data date month for the EVM record — used to align period records to reporting cycles."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EVM record — required for multi-currency portfolio EVM consolidation."
    - name: "cpi_trend"
      expr: cpi_trend
      comment: "Trend direction of CPI (Improving, Stable, Declining) — used to flag projects requiring intervention."
    - name: "spi_trend"
      expr: spi_trend
      comment: "Trend direction of SPI (Improving, Stable, Declining) — used to identify schedule recovery or deterioration patterns."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Method used to forecast EAC (e.g. CPI-based, ETC-based) — affects comparability of EAC values across projects."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Level of EVM measurement (e.g. WBS, Cost Account, Project) — used to filter appropriate granularity for analysis."
    - name: "record_status"
      expr: record_status
      comment: "Approval status of the EVM record (e.g. Submitted, Approved) — used to filter to approved records for reporting."
  measures:
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value). Core EVM metric measuring value of work accomplished."
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value). Baseline against which earned value is compared to assess schedule performance."
    - name: "total_acwp"
      expr: SUM(CAST(acwp AS DOUBLE))
      comment: "Total Actual Cost of Work Performed. Used to compute cost variance and CPI at the portfolio level."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (BCWP - ACWP). Negative values indicate cost overrun across the portfolio."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance (BCWP - BCWS). Negative values indicate schedule slippage; used in PMO steering reviews."
    - name: "total_eac"
      expr: SUM(CAST(eac AS DOUBLE))
      comment: "Total Estimate at Completion across all EVM records. Used by finance to project final cost outturn and assess budget adequacy."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC). Denominator for VAC% and overall EVM budget baseline."
    - name: "total_vac"
      expr: SUM(CAST(vac AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC). Negative VAC signals projected cost overrun at project completion."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across EVM period records. CPI < 1.0 triggers cost recovery planning."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across EVM period records. SPI < 1.0 triggers schedule recovery planning."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index (TCPI). TCPI > 1.0 indicates the remaining work must be performed more efficiently than historical CPI — a key project recovery signal."
    - name: "avg_physical_percent_complete"
      expr: AVG(CAST(physical_percent_complete AS DOUBLE))
      comment: "Average physical percent complete across EVM records. Used to validate earned value claims against physical progress."
    - name: "period_bcwp"
      expr: SUM(CAST(period_bcwp AS DOUBLE))
      comment: "Total period earned value (BCWP for the current period only). Used for period-on-period EVM trending in monthly project control reports."
    - name: "period_acwp"
      expr: SUM(CAST(period_acwp AS DOUBLE))
      comment: "Total period actual cost (ACWP for the current period only). Used alongside period BCWP to compute period CPI for trend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order KPIs — volume, cost impact, approval rates, and contingency drawdown. Used by project managers, contract managers, and PMO to control scope creep and manage contract risk."
  source: "`vibe_construction_v1`.`project`.`project_change_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change order (e.g. Approved, Pending, Rejected) — used to separate approved vs pending cost exposure."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. Scope, Design, Client Instruction) — used to analyse root causes of scope growth."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the change order — used for root cause analysis and lessons learned reporting."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model associated with the change order — used to benchmark change order frequency by contract type."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the change order is disputed — used to track commercial risk and potential claims exposure."
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Flag indicating whether liquidated damages apply to this change order — used to quantify LD exposure from scope changes."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the change order was approved — used to trend change order approval velocity over time."
    - name: "submitted_month"
      expr: DATE_TRUNC('month', submitted_date)
      comment: "Month the change order was submitted — used to measure approval cycle time and backlog aging."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Primary metric for tracking scope growth and its financial effect on the project budget."
    - name: "approved_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of approved change orders only. Used to update the approved budget and assess confirmed scope growth."
    - name: "pending_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Pending' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of pending change orders. Represents unresolved financial exposure requiring management attention."
    - name: "total_contingency_drawn"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency budget drawn down by change orders. Used to monitor contingency burn rate and remaining risk buffer."
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost component of change orders. Used to separate direct cost from overhead and profit in change order analysis."
    - name: "total_overhead_and_profit"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit claimed in change orders. Used to assess contractor margin uplift from scope changes."
    - name: "change_order_count"
      expr: COUNT(project_change_order_id)
      comment: "Total number of change orders raised. Used to measure scope instability and change management effectiveness."
    - name: "disputed_change_order_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN project_change_order_id END)
      comment: "Number of disputed change orders. High dispute counts signal commercial risk and potential claims escalation."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN project_change_order_id END) / NULLIF(COUNT(project_change_order_id), 0), 2)
      comment: "Percentage of change orders that have been approved. Used to assess change management efficiency and client responsiveness."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CASE WHEN is_ld_applicable = TRUE THEN CAST(ld_rate_per_day AS DOUBLE) END)
      comment: "Average daily liquidated damages rate for LD-applicable change orders. Used to quantify daily financial exposure from schedule delays linked to change orders."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone performance KPIs — on-time delivery, LD exposure, payment triggers, and critical path adherence. Used by project managers, contract managers, and clients to track key delivery commitments."
  source: "`vibe_construction_v1`.`project`.`project_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Achieved, Overdue, At Risk) — primary filter for milestone health dashboards."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Contractual, Internal, Payment) — used to segment milestone performance by obligation type."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of the milestone (e.g. Design, Procurement, Construction) — used for phase-level milestone tracking."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag indicating whether the milestone is a contractual obligation — used to prioritise contractual delivery commitments."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the milestone is on the critical path — used to focus management attention on schedule-critical deliverables."
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Flag indicating whether missing this milestone triggers liquidated damages — used to quantify financial risk from milestone delays."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model associated with the milestone — used to benchmark milestone performance by contract type."
    - name: "planned_date_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned milestone month — used to build milestone completion forecasts and workload calendars."
  measures:
    - name: "total_milestone_count"
      expr: COUNT(project_milestone_id)
      comment: "Total number of milestones in scope. Used as the denominator for milestone completion rate calculations."
    - name: "achieved_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Achieved' THEN project_milestone_id END)
      comment: "Number of milestones achieved. Used to compute milestone completion rate and track delivery performance."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Overdue' THEN project_milestone_id END)
      comment: "Number of overdue milestones. Key risk indicator used in project steering meetings to trigger recovery planning."
    - name: "contractual_milestone_count"
      expr: COUNT(CASE WHEN is_contractual = TRUE THEN project_milestone_id END)
      comment: "Number of contractual milestones. Used to track compliance with contractual delivery obligations."
    - name: "ld_trigger_milestone_count"
      expr: COUNT(CASE WHEN is_ld_trigger = TRUE THEN project_milestone_id END)
      comment: "Number of milestones that trigger liquidated damages if missed. Used to quantify LD exposure across the project."
    - name: "total_ld_exposure"
      expr: SUM(CASE WHEN is_ld_trigger = TRUE THEN CAST(ld_rate_per_day AS DOUBLE) ELSE 0 END)
      comment: "Total daily LD rate exposure from LD-trigger milestones. Used to quantify maximum daily financial penalty from milestone delays."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment value linked to payment-trigger milestones. Used for cash flow forecasting and revenue recognition planning."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Achieved' THEN project_milestone_id END) / NULLIF(COUNT(project_milestone_id), 0), 2)
      comment: "Percentage of milestones achieved out of total milestones. Key delivery performance KPI used in client reporting and PMO dashboards."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all milestones. Used to assess overall milestone delivery progress."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk KPIs — risk exposure, probability-weighted cost impact, mitigation coverage, and escalation rates. Used by risk managers, PMO, and executives to steer risk response and monitor residual exposure."
  source: "`vibe_construction_v1`.`project`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed) — primary filter for active risk exposure analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g. Commercial, Technical, HSE, Regulatory) — used to segment risk exposure by type."
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk (e.g. Threat, Opportunity) — used to separate downside risk from upside opportunity analysis."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Qualitative probability rating (e.g. High, Medium, Low) — used to filter and segment risks by likelihood."
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Risk response strategy (e.g. Mitigate, Transfer, Accept) — used to assess adequacy of risk treatment across the portfolio."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether the risk has been escalated — used to track risks requiring senior management attention."
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Flag indicating whether the risk has an HSE dimension — used to prioritise safety-related risk responses."
    - name: "regulatory_risk_flag"
      expr: regulatory_risk_flag
      comment: "Flag indicating whether the risk has a regulatory dimension — used to track compliance-related risk exposure."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the risk was identified — used to trend risk identification rates and assess risk register currency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the risk cost impact — required for multi-currency risk exposure consolidation."
  measures:
    - name: "total_risk_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total gross cost impact of all risks. Used to quantify maximum financial exposure from the risk register."
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency cost allocated to risks. Used to assess whether contingency reserves are adequate to cover identified risks."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Number of open risks. Key risk portfolio health indicator used in risk steering meetings."
    - name: "escalated_risk_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN risk_register_id END)
      comment: "Number of escalated risks requiring senior management attention. Used to prioritise executive risk review agenda."
    - name: "hse_risk_count"
      expr: COUNT(CASE WHEN hse_risk_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks with an HSE dimension. Used by HSE leadership to assess safety risk exposure across the portfolio."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the risk register. Used to track overall risk profile trend — rising scores trigger risk response reviews."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation. Compared against gross risk score to assess mitigation effectiveness."
    - name: "probability_weighted_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE) * CAST(probability_score AS DOUBLE))
      comment: "Probability-weighted cost impact (cost impact × probability score). Used for quantitative risk analysis and contingency adequacy assessment."
    - name: "risk_mitigation_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_status IN ('Mitigated', 'Closed') THEN risk_register_id END) / NULLIF(COUNT(risk_register_id), 0), 2)
      comment: "Percentage of risks that have been mitigated or closed. Used to assess risk management programme effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Phase-level performance KPIs — budget vs actuals, earned value, schedule adherence, and gate approval status. Used by PMO and project directors to manage phase-gate delivery and cost performance."
  source: "`vibe_construction_v1`.`project`.`phase`"
  dimensions:
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (e.g. Active, Completed, On Hold) — primary filter for active phase performance analysis."
    - name: "phase_type"
      expr: phase_type
      comment: "Type of phase (e.g. Design, Procurement, Construction, Commissioning) — used to segment performance by project lifecycle stage."
    - name: "gate_approval_status"
      expr: gate_approval_status
      comment: "Status of the phase gate approval (e.g. Approved, Pending, Rejected) — used to track phase-gate governance compliance."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the phase — used to benchmark phase performance across contract strategies."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the phase is on the critical path — used to prioritise management attention on schedule-critical phases."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the phase (e.g. High, Medium, Low) — used to segment phase performance by risk profile."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the phase budget — required for multi-currency phase cost consolidation."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start month of the phase — used for workload forecasting and resource capacity planning."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across phases. Used as the baseline for phase-level cost performance analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across phases. Used to assess cost performance against phase budgets."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across phases. Used in EVM analysis to measure value of work performed at the phase level."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency budget held across phases. Used to assess risk buffer adequacy at the phase level."
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across phases. Used to quantify financial penalty risk from phase schedule delays."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across phases. Used to assess overall project delivery progress at the phase level."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_pct AS DOUBLE))
      comment: "Average deliverables completion percentage across phases. Used to track documentation and deliverable readiness for phase gate reviews."
    - name: "phase_cost_variance"
      expr: SUM(CAST(earned_value AS DOUBLE) - CAST(actual_cost AS DOUBLE))
      comment: "Total cost variance (Earned Value minus Actual Cost) across phases. Negative values indicate cost overrun at the phase level."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of phase budget consumed by actual costs. Used to assess phase-level cost control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deliverable performance KPIs — submission rates, acceptance rates, overdue deliverables, and weighted completion. Used by document control, PMO, and project managers to track contractual deliverable obligations."
  source: "`vibe_construction_v1`.`project`.`deliverable`"
  dimensions:
    - name: "deliverable_status"
      expr: deliverable_status
      comment: "Current status of the deliverable (e.g. Issued, Under Review, Accepted, Overdue) — primary filter for deliverable health dashboards."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (e.g. Drawing, Report, Specification, Certificate) — used to segment deliverable performance by category."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Client acceptance status of the deliverable — used to track formal acceptance rates and identify outstanding approvals."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or construction discipline responsible for the deliverable — used to identify discipline-level delivery bottlenecks."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag indicating whether the deliverable is a contractual obligation — used to prioritise contractual deliverable tracking."
    - name: "is_handover_required"
      expr: is_handover_required
      comment: "Flag indicating whether the deliverable is required for project handover — used to track handover readiness."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the deliverable (e.g. Critical, High, Normal) — used to focus management attention on high-priority items."
    - name: "planned_issue_month"
      expr: DATE_TRUNC('month', planned_issue_date)
      comment: "Planned issue month of the deliverable — used to build deliverable submission forecasts and workload calendars."
  measures:
    - name: "total_deliverable_count"
      expr: COUNT(deliverable_id)
      comment: "Total number of deliverables in scope. Used as the denominator for completion rate and acceptance rate calculations."
    - name: "accepted_deliverable_count"
      expr: COUNT(CASE WHEN acceptance_status = 'Accepted' THEN deliverable_id END)
      comment: "Number of deliverables formally accepted by the client. Used to track contractual acceptance progress."
    - name: "overdue_deliverable_count"
      expr: COUNT(CASE WHEN deliverable_status = 'Overdue' THEN deliverable_id END)
      comment: "Number of overdue deliverables. Key risk indicator used in document control and PMO reviews to trigger escalation."
    - name: "contractual_deliverable_count"
      expr: COUNT(CASE WHEN is_contractual = TRUE THEN deliverable_id END)
      comment: "Number of contractual deliverables. Used to track compliance with contractual documentation obligations."
    - name: "handover_deliverable_count"
      expr: COUNT(CASE WHEN is_handover_required = TRUE THEN deliverable_id END)
      comment: "Number of deliverables required for project handover. Used to track handover readiness and identify outstanding items."
    - name: "deliverable_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN deliverable_id END) / NULLIF(COUNT(deliverable_id), 0), 2)
      comment: "Percentage of deliverables formally accepted. Used to measure document quality and client approval efficiency."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all deliverables. Used to assess overall deliverable portfolio progress."
    - name: "weighted_completion_score"
      expr: SUM(CAST(percent_complete AS DOUBLE) * CAST(weight_factor AS DOUBLE))
      comment: "Weighted deliverable completion score (percent complete × weight factor). Used for earned value measurement based on deliverable weights."
$$;