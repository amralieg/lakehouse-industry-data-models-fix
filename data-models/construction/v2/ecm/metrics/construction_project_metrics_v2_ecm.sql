-- Metric views for domain: project | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive portfolio-level KPIs across all construction projects — budget health, schedule performance, EVM indices, and portfolio composition for C-level steering and PMO dashboards."
  source: "`vibe_construction_v1`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, Closed, On Hold) for portfolio segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Classification of project type (e.g. Infrastructure, Building, Industrial) for portfolio mix analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (EPC, EPCM, D&B, etc.) to compare performance across procurement strategies."
    - name: "region"
      expr: region
      comment: "Geographic region of the project for regional portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the project is located for cross-border portfolio reporting."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk classification of the project for risk-weighted portfolio views."
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "PMO tier or classification for governance-level segmentation."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the project is a joint venture, enabling JV vs. sole-entity performance comparison."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level for sustainability portfolio segmentation."
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract for multi-currency portfolio analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned project start for pipeline and backlog trending."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month of planned completion for delivery schedule analysis."
    - name: "ntp_date"
      expr: DATE_TRUNC('month', ntp_date)
      comment: "Month of Notice to Proceed issuance for project start cohort analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Total number of distinct construction projects in the portfolio — baseline portfolio size KPI."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Sum of approved budgets across all projects — total capital commitment under management."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Sum of contract values across all projects — total revenue backlog and contract exposure."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per project — indicates typical project scale for resource planning."
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across active projects — portfolio-wide construction completion indicator."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across projects — portfolio cost efficiency; CPI < 1.0 signals cost overrun risk."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across projects — portfolio schedule efficiency; SPI < 1.0 signals schedule slippage."
    - name: "total_jv_partner_share_pct"
      expr: SUM(CAST(jv_partner_share_pct AS DOUBLE))
      comment: "Sum of JV partner share percentages — used to assess total JV exposure in the portfolio."
    - name: "avg_retention_pct"
      expr: AVG(CAST(retention_pct AS DOUBLE))
      comment: "Average retention percentage held across contracts — cash flow impact indicator for finance."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average LD rate per day across projects — risk exposure indicator for schedule delays."
    - name: "projects_at_risk_count"
      expr: COUNT(DISTINCT CASE WHEN cpi < 1.0 OR spi < 1.0 THEN construction_project_id END)
      comment: "Number of projects with CPI or SPI below 1.0 — early warning count for projects requiring PMO intervention."
    - name: "budget_variance_total"
      expr: SUM(CAST(approved_budget AS DOUBLE) - CAST(contract_value AS DOUBLE))
      comment: "Total difference between approved budget and contract value across the portfolio — indicates contingency consumption or scope growth."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_evm_period_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management (EVM) performance metrics by period — the primary source for cost and schedule performance trending, variance analysis, and forecast accuracy used in PMO and executive reporting."
  source: "`vibe_construction_v1`.`project`.`evm_period_record`"
  dimensions:
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Reporting period start month for time-series EVM trending."
    - name: "period_end_date"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Reporting period end month for period-over-period comparison."
    - name: "data_date"
      expr: DATE_TRUNC('month', data_date)
      comment: "EVM data date month for status-date-based analysis."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Level of EVM measurement (project, WBS, cost account) for drill-down analysis."
    - name: "forecast_method"
      expr: forecast_method
      comment: "EAC forecast method used (e.g. CPI-based, ETC-based) for methodology comparison."
    - name: "record_status"
      expr: record_status
      comment: "Status of the EVM record (Draft, Approved, Submitted) for data quality filtering."
    - name: "cpi_trend"
      expr: cpi_trend
      comment: "CPI trend direction (Improving, Stable, Declining) for executive trend dashboards."
    - name: "spi_trend"
      expr: spi_trend
      comment: "SPI trend direction for schedule performance trend dashboards."
    - name: "progress_measurement_method"
      expr: progress_measurement_method
      comment: "Method used to measure physical progress (e.g. Milestone, % Complete) for methodology governance."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for installed quantities enabling cross-discipline quantity analysis."
  measures:
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Total Budgeted Cost of Work Scheduled (Planned Value) — baseline for schedule performance measurement."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) — value of work actually accomplished."
    - name: "total_acwp"
      expr: SUM(CAST(acwp AS DOUBLE))
      comment: "Total Actual Cost of Work Performed — actual spend against earned value for cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (BCWP - ACWP) across all records — negative value signals cost overrun."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (BCWP - BCWS) — negative value signals schedule slippage."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across all WBS elements — total authorized budget."
    - name: "total_eac"
      expr: SUM(CAST(eac AS DOUBLE))
      comment: "Total Estimate at Completion — forecasted final cost; compare to BAC to assess overrun magnitude."
    - name: "total_etc"
      expr: SUM(CAST(etc AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish all work; critical for cash flow forecasting."
    - name: "total_vac"
      expr: SUM(CAST(vac AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC) — projected final cost overrun or saving across the portfolio."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index — portfolio-wide cost efficiency; below 1.0 triggers executive cost review."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index — portfolio-wide schedule efficiency; below 1.0 triggers schedule recovery action."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index — efficiency required to meet BAC; TCPI > 1.1 signals unrealistic recovery plan."
    - name: "avg_physical_percent_complete"
      expr: AVG(CAST(physical_percent_complete AS DOUBLE))
      comment: "Average physical percent complete across all EVM records — overall portfolio progress indicator."
    - name: "total_period_bcwp"
      expr: SUM(CAST(period_bcwp AS DOUBLE))
      comment: "Total earned value in the current period — period productivity measure for velocity tracking."
    - name: "total_period_acwp"
      expr: SUM(CAST(period_acwp AS DOUBLE))
      comment: "Total actual cost in the current period — period burn rate for cash flow management."
    - name: "total_earned_quantity"
      expr: SUM(CAST(earned_quantity AS DOUBLE))
      comment: "Total earned quantity across all records — physical production output measure."
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity — actual physical work-in-place for production rate benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost account performance metrics for project cost control — budget vs. actual analysis, earned value, and cost-to-complete forecasting at the cost account level for project controllers and finance."
  source: "`vibe_construction_v1`.`project`.`cost_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of the cost account (Active, Closed, On Hold) for filtering active cost control scope."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost account for multi-currency cost reporting."
    - name: "phase_code"
      expr: phase_code
      comment: "Project phase associated with the cost account for phase-level cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost accounts enabling productivity analysis."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating lump-sum vs. re-measurable cost accounts for contract type analysis."
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Flag indicating subcontracted scope for make-vs-buy cost analysis."
    - name: "baseline_start_date"
      expr: DATE_TRUNC('month', baseline_start_date)
      comment: "Baseline start month for schedule-cost integration analysis."
    - name: "baseline_finish_date"
      expr: DATE_TRUNC('month', baseline_finish_date)
      comment: "Baseline finish month for cost account completion trending."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Reporting period month for time-series cost performance trending."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all cost accounts — authorized spend baseline."
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original budget before change orders — baseline for change order impact analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred across all cost accounts — primary cost performance indicator."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost (POs, subcontracts) — financial exposure including uncommitted actuals."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total earned value across cost accounts — value of work accomplished per approved budget."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance (EV - AC) — negative value signals cost overrun requiring corrective action."
    - name: "total_cost_to_complete"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total estimated cost to complete remaining work — critical for cash flow and EAC forecasting."
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total forecasted final cost at completion — compare to approved budget for overrun exposure."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order value incorporated into cost accounts — scope growth measurement."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget remaining — risk buffer adequacy indicator."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across cost accounts — cost efficiency benchmark."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across cost accounts — schedule efficiency benchmark."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across cost accounts — overall work progress indicator."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed by actual costs — budget burn rate for cost control alerts."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value_amount AS DOUBLE))
      comment: "Total planned value (BCWS) across cost accounts — scheduled spend baseline for EVM."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order management KPIs — tracks scope growth, cost impact, schedule impact, and approval cycle performance. Critical for contract administration and project cost control."
  source: "`vibe_construction_v1`.`project`.`project_change_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Change order approval status (Pending, Approved, Rejected) for pipeline and backlog analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (Scope, Design, Client-Directed, etc.) for root cause analysis of scope growth."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the change order — identifies systemic causes of scope changes."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for comparing change order frequency across procurement strategies."
    - name: "originator"
      expr: originator
      comment: "Party originating the change order (Client, Contractor, Engineer) for accountability analysis."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating disputed change orders — tracks commercial dispute exposure."
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Flag indicating whether liquidated damages apply — LD exposure tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order for triage and processing queue management."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the change order became effective for time-series scope growth analysis."
    - name: "submitted_date"
      expr: DATE_TRUNC('month', submitted_date)
      comment: "Month of change order submission for approval cycle time analysis."
  measures:
    - name: "total_change_orders"
      expr: COUNT(DISTINCT project_change_order_id)
      comment: "Total number of change orders — volume indicator for scope management effectiveness."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders — cumulative scope growth value affecting project budget."
    - name: "total_direct_cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost component of change orders — separates direct from overhead in scope growth analysis."
    - name: "total_overhead_and_profit"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit on change orders — contractor margin on scope additions."
    - name: "total_contingency_drawn"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency consumed by change orders — measures contingency depletion rate."
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Sum of LD rates per day across applicable change orders — daily LD exposure from schedule-impacting changes."
    - name: "disputed_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN is_disputed = TRUE THEN project_change_order_id END)
      comment: "Number of disputed change orders — commercial dispute risk indicator requiring legal/commercial attention."
    - name: "approved_change_order_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN project_change_order_id END)
      comment: "Number of approved change orders — approved scope growth count for contract administration."
    - name: "avg_cost_impact_per_co"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order — indicates typical change order magnitude for benchmarking."
    - name: "approval_cycle_days_avg"
      expr: AVG(DATEDIFF(effective_date, submitted_date))
      comment: "Average days from submission to effective date — change order processing efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone performance KPIs — tracks on-time delivery, contractual milestone adherence, LD trigger exposure, and payment milestone status for project controls and commercial management."
  source: "`vibe_construction_v1`.`project`.`project_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (Achieved, At Risk, Delayed, Not Started) for portfolio milestone health."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (Contractual, Internal, Payment, Regulatory) for categorized milestone tracking."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of milestone for grouping and filtering in milestone dashboards."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag for contractual milestones — separates legally binding from internal milestones."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag for critical path milestones — focuses attention on schedule-critical deliverables."
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Flag for milestones that trigger liquidated damages — highest-priority milestone monitoring."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for milestone performance comparison across procurement strategies."
    - name: "planned_date"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned milestone month for schedule pipeline analysis."
    - name: "forecast_date"
      expr: DATE_TRUNC('month', forecast_date)
      comment: "Forecast milestone month for updated schedule outlook."
    - name: "actual_date"
      expr: DATE_TRUNC('month', actual_date)
      comment: "Actual achievement month for on-time delivery analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(DISTINCT project_milestone_id)
      comment: "Total number of project milestones — baseline count for milestone portfolio management."
    - name: "contractual_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_contractual = TRUE THEN project_milestone_id END)
      comment: "Number of contractual milestones — scope of legally binding schedule commitments."
    - name: "ld_trigger_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_ld_trigger = TRUE THEN project_milestone_id END)
      comment: "Number of milestones that trigger LDs — total LD exposure event count."
    - name: "critical_path_milestone_count"
      expr: COUNT(DISTINCT CASE WHEN is_critical_path = TRUE THEN project_milestone_id END)
      comment: "Number of critical path milestones — schedule criticality indicator."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment value tied to milestones — revenue recognition trigger value for finance."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average LD rate per day across LD-trigger milestones — daily financial exposure per delayed milestone."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all milestones — overall milestone progress indicator."
    - name: "on_time_milestone_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_date <= planned_date THEN project_milestone_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_date IS NOT NULL THEN project_milestone_id END), 0), 2)
      comment: "Percentage of completed milestones achieved on or before planned date — schedule reliability KPI for executive reporting."
    - name: "avg_schedule_variance_days"
      expr: AVG(DATEDIFF(actual_date, planned_date))
      comment: "Average days variance between actual and planned milestone dates — schedule slippage magnitude indicator."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project cost forecast KPIs — tracks EAC movement, cost variance trends, contingency consumption, and forecast accuracy for PMO and finance executive reporting."
  source: "`vibe_construction_v1`.`project`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (Draft, Submitted, Approved) for data quality filtering."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (Monthly, Quarterly, Annual) for period-appropriate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Forecast currency for multi-currency portfolio analysis."
    - name: "reporting_currency_code"
      expr: reporting_currency_code
      comment: "Reporting currency for consolidated portfolio views."
    - name: "is_client_reported"
      expr: is_client_reported
      comment: "Flag indicating client-facing forecasts — separates internal from external reporting."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Reporting period month for time-series forecast trending."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of forecast approval for approval cycle analysis."
    - name: "completion_date"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Forecast completion month for schedule outlook analysis."
  measures:
    - name: "total_eac_cost"
      expr: SUM(CAST(eac_cost AS DOUBLE))
      comment: "Total Estimate at Completion across all forecasts — total projected final cost for portfolio."
    - name: "total_etc_cost"
      expr: SUM(CAST(etc_cost AS DOUBLE))
      comment: "Total Estimate to Complete — remaining cost to finish all projects; cash flow planning input."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual cost incurred to date across all projects — cumulative spend for financial reporting."
    - name: "total_bac_cost"
      expr: SUM(CAST(bac_cost AS DOUBLE))
      comment: "Total Budget at Completion — total authorized budget for comparison against EAC."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (EV - AC) across all forecasts — portfolio-wide cost overrun/saving."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC) — projected final overrun or saving across portfolio."
    - name: "total_eac_movement"
      expr: SUM(CAST(eac_movement AS DOUBLE))
      comment: "Total EAC movement from prior period — measures forecast volatility and cost trend direction."
    - name: "total_risk_provision"
      expr: SUM(CAST(risk_provision_amount AS DOUBLE))
      comment: "Total risk provision included in forecasts — quantified risk exposure in cost plan."
    - name: "total_contingency_remaining"
      expr: SUM(CAST(contingency_remaining AS DOUBLE))
      comment: "Total contingency remaining across all projects — risk buffer adequacy for portfolio."
    - name: "total_management_reserve_remaining"
      expr: SUM(CAST(management_reserve_remaining AS DOUBLE))
      comment: "Total management reserve remaining — executive-level contingency buffer status."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from forecasts — portfolio cost efficiency trend."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index from forecasts — portfolio schedule efficiency trend."
    - name: "avg_tcpi"
      expr: AVG(CAST(tcpi AS DOUBLE))
      comment: "Average To-Complete Performance Index — feasibility of meeting BAC given current performance."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all project forecasts — portfolio progress indicator."
    - name: "overrun_exposure_total"
      expr: SUM(CASE WHEN CAST(eac_cost AS DOUBLE) > CAST(bac_cost AS DOUBLE) THEN CAST(eac_cost AS DOUBLE) - CAST(bac_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost overrun exposure (EAC > BAC) across all projects — financial risk requiring executive action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk management KPIs — quantifies risk exposure, mitigation effectiveness, and risk portfolio composition for PMO risk reviews and executive risk dashboards."
  source: "`vibe_construction_v1`.`project`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (Open, Mitigated, Closed, Escalated) for active risk portfolio management."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (Commercial, Technical, HSE, Regulatory, etc.) for risk type analysis."
    - name: "risk_type"
      expr: risk_type
      comment: "Risk type classification for detailed risk taxonomy analysis."
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Risk response strategy (Avoid, Mitigate, Transfer, Accept) for response effectiveness analysis."
    - name: "affected_discipline"
      expr: affected_discipline
      comment: "Engineering or project discipline affected by the risk for discipline-level risk analysis."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Qualitative probability rating (Low, Medium, High) for risk matrix positioning."
    - name: "risk_proximity"
      expr: risk_proximity
      comment: "Timeframe within which the risk may materialize for urgency prioritization."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag for escalated risks requiring senior management attention."
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Flag for HSE-related risks — safety risk portfolio indicator."
    - name: "regulatory_risk_flag"
      expr: regulatory_risk_flag
      comment: "Flag for regulatory risks — compliance exposure indicator."
    - name: "insurance_coverage_flag"
      expr: insurance_coverage_flag
      comment: "Flag indicating insurance coverage — insured vs. uninsured risk exposure."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month risk was identified for risk emergence trend analysis."
    - name: "review_date"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month of next risk review for governance calendar management."
  measures:
    - name: "total_open_risks"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Total number of open risks — active risk portfolio size requiring management attention."
    - name: "total_risks"
      expr: COUNT(DISTINCT risk_register_id)
      comment: "Total risks registered — overall risk register volume for governance reporting."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total potential cost impact of all risks — gross financial exposure before mitigation."
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency provisioned for risks — risk-adjusted budget reserve adequacy."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score (probability × impact) across all risks — portfolio risk severity indicator."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation — measures mitigation effectiveness."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score across risks — likelihood-weighted risk portfolio indicator."
    - name: "avg_residual_probability_score"
      expr: AVG(CAST(residual_probability_score AS DOUBLE))
      comment: "Average residual probability after mitigation — probability reduction effectiveness."
    - name: "escalated_risk_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN risk_register_id END)
      comment: "Number of escalated risks — senior management action queue size."
    - name: "hse_risk_count"
      expr: COUNT(DISTINCT CASE WHEN hse_risk_flag = TRUE THEN risk_register_id END)
      comment: "Number of HSE risks — safety risk portfolio size for HSE governance."
    - name: "risk_mitigation_effectiveness"
      expr: ROUND(100.0 * (1 - AVG(CAST(residual_risk_score AS DOUBLE)) / NULLIF(AVG(CAST(risk_score AS DOUBLE)), 0)), 2)
      comment: "Percentage reduction in risk score after mitigation — measures overall risk response effectiveness."
    - name: "uninsured_risk_cost_exposure"
      expr: SUM(CASE WHEN insurance_coverage_flag = FALSE THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost exposure from uninsured risks — net financial risk not covered by insurance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_progress_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical progress measurement KPIs — tracks earned value, installed quantities, and measurement accuracy for project controls, billing, and schedule performance reporting."
  source: "`vibe_construction_v1`.`project`.`progress_measurement`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement record (Draft, Verified, Approved) for data quality filtering."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (Physical, Financial, Milestone) for measurement methodology analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. Milestone, % Complete, Units Installed) for methodology governance."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system or process generating the measurement for data lineage tracking."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (Civil, Mechanical, Electrical, etc.) for discipline-level progress analysis."
    - name: "work_area"
      expr: work_area
      comment: "Physical work area or zone for spatial progress analysis."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag for milestone-based measurements — separates milestone from continuous progress tracking."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for quantity-based progress tracking."
    - name: "measurement_date"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of measurement for time-series progress trending."
    - name: "reporting_period_end_date"
      expr: DATE_TRUNC('month', reporting_period_end_date)
      comment: "Reporting period end month for period-over-period progress comparison."
  measures:
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value from progress measurements — value of work accomplished per budget."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value at measurement date — scheduled work value for SPI calculation."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion across all measurement records — authorized budget scope."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance from progress measurements — cost performance signal."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total schedule variance from progress measurements — schedule performance signal."
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total installed quantity across all measurements — physical production output."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current period — period productivity rate."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity — planned production scope for quantity performance analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all measurement records — overall physical progress."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index from progress measurements — cost efficiency at measurement level."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index from progress measurements — schedule efficiency at measurement level."
    - name: "quantity_productivity_rate"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted quantity installed — physical productivity rate for production benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project baseline management KPIs — tracks baseline revisions, budget changes, and baseline approval status for PMO governance and change control effectiveness."
  source: "`vibe_construction_v1`.`project`.`project_baseline`"
  dimensions:
    - name: "baseline_status"
      expr: baseline_status
      comment: "Status of the baseline (Active, Superseded, Draft) for current vs. historical baseline analysis."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (Original, Revised, Client-Approved) for baseline evolution tracking."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for baseline performance comparison across procurement strategies."
    - name: "is_current_baseline"
      expr: is_current_baseline
      comment: "Flag for the current active baseline — filters to live performance measurement baseline."
    - name: "is_client_approved"
      expr: is_client_approved
      comment: "Flag for client-approved baselines — separates internally approved from contractually agreed baselines."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level for the baseline — governance tier analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Baseline currency for multi-currency portfolio analysis."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of baseline approval for approval cycle analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the baseline became effective for timeline analysis."
  measures:
    - name: "total_baselines"
      expr: COUNT(DISTINCT project_baseline_id)
      comment: "Total number of baselines — baseline revision frequency indicator for change control governance."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total budget at completion across all baselines — authorized cost scope."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value incorporated in baselines — revenue baseline for financial planning."
    - name: "total_co_value_incorporated"
      expr: SUM(CAST(co_value_incorporated AS DOUBLE))
      comment: "Total change order value incorporated into baselines — cumulative scope growth measurement."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency in baselines — risk buffer adequacy across all baseline versions."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve in baselines — executive-level risk buffer tracking."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion in baselines — projected final cost performance vs. baseline."
    - name: "avg_budget_revision_delta"
      expr: AVG(CAST(budget_after_revision AS DOUBLE) - CAST(budget_before_revision AS DOUBLE))
      comment: "Average budget change per baseline revision — typical revision magnitude for change control benchmarking."
    - name: "avg_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average baseline duration in days — typical project duration for portfolio planning."
    - name: "client_approved_baseline_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_client_approved = TRUE THEN project_baseline_id END) / NULLIF(COUNT(DISTINCT project_baseline_id), 0), 2)
      comment: "Percentage of baselines with client approval — contractual alignment rate for commercial governance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_commissioning_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commissioning package completion and handover KPIs — tracks mechanical completion, punch list closure, FAT/SAT status, and DLP management for project closeout and asset handover."
  source: "`vibe_construction_v1`.`project`.`commissioning_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the commissioning package (In Progress, MC Complete, Handed Over) for closeout tracking."
    - name: "package_type"
      expr: package_type
      comment: "Type of commissioning package (Mechanical, Electrical, Instrumentation, etc.) for discipline-level closeout analysis."
    - name: "fat_status"
      expr: fat_status
      comment: "Factory Acceptance Test status for equipment readiness tracking."
    - name: "sat_status"
      expr: sat_status
      comment: "Site Acceptance Test status for commissioning readiness tracking."
    - name: "pre_commissioning_complete"
      expr: pre_commissioning_complete
      comment: "Flag indicating pre-commissioning completion — gate check for commissioning readiness."
    - name: "area_location"
      expr: area_location
      comment: "Physical area or location of the commissioning package for spatial closeout analysis."
    - name: "system_number"
      expr: system_number
      comment: "System number for system-level commissioning progress analysis."
    - name: "priority_tag"
      expr: priority_tag
      comment: "Priority classification for commissioning sequence management."
    - name: "planned_completion_date"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Planned completion month for commissioning schedule analysis."
    - name: "mechanical_completion_date"
      expr: DATE_TRUNC('month', mechanical_completion_date)
      comment: "Mechanical completion month for MC milestone trending."
    - name: "handover_date"
      expr: DATE_TRUNC('month', handover_date)
      comment: "Handover date month for asset transfer timeline analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(DISTINCT commissioning_package_id)
      comment: "Total commissioning packages — scope of commissioning and handover program."
    - name: "avg_punch_list_closure_pct"
      expr: AVG(CAST(punch_list_closure_pct AS DOUBLE))
      comment: "Average punch list closure percentage — commissioning quality and readiness indicator."
    - name: "avg_dlp_duration_days"
      expr: AVG(CAST(dlp_duration_days AS DOUBLE))
      comment: "Average Defects Liability Period duration — post-handover warranty obligation scope."
    - name: "packages_pre_commissioning_complete"
      expr: COUNT(DISTINCT CASE WHEN pre_commissioning_complete = TRUE THEN commissioning_package_id END)
      comment: "Number of packages with pre-commissioning complete — readiness gate for commissioning start."
    - name: "packages_handed_over"
      expr: COUNT(DISTINCT CASE WHEN package_status = 'Handed Over' THEN commissioning_package_id END)
      comment: "Number of packages formally handed over to client — project closeout progress indicator."
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_completion_date <= planned_completion_date THEN commissioning_package_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_completion_date IS NOT NULL THEN commissioning_package_id END), 0), 2)
      comment: "Percentage of commissioning packages completed on or before planned date — closeout schedule performance."
    - name: "avg_schedule_overrun_days"
      expr: AVG(DATEDIFF(actual_completion_date, planned_completion_date))
      comment: "Average days overrun for completed commissioning packages — closeout schedule slippage magnitude."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS element cost and progress KPIs — provides the hierarchical cost and schedule performance view for project controllers, enabling drill-down from project to work package level."
  source: "`vibe_construction_v1`.`project`.`wbs_element`"
  dimensions:
    - name: "wbs_status"
      expr: wbs_status
      comment: "Status of the WBS element (Active, Complete, On Hold) for active scope filtering."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS element (Summary, Work Package, Control Account) for hierarchy-level analysis."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS element for drill-down analysis."
    - name: "responsible_discipline"
      expr: responsible_discipline
      comment: "Discipline responsible for the WBS element for discipline-level cost and progress analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for WBS performance comparison."
    - name: "csi_division_code"
      expr: csi_division_code
      comment: "CSI division code for industry-standard work classification analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the WBS element for multi-currency analysis."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag for lump-sum WBS elements — separates lump-sum from re-measurable scope."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag for milestone WBS elements — identifies milestone-based control accounts."
    - name: "evm_enabled"
      expr: evm_enabled
      comment: "Flag for EVM-enabled WBS elements — scope of earned value measurement."
    - name: "percent_complete_method"
      expr: percent_complete_method
      comment: "Method used to calculate percent complete for methodology governance."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start month for WBS schedule analysis."
    - name: "planned_finish_date"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Planned finish month for WBS completion trending."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across all WBS elements — authorized cost baseline."
    - name: "total_original_budget_cost"
      expr: SUM(CAST(original_budget_cost AS DOUBLE))
      comment: "Total original budget before changes — baseline for change impact analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS elements — cumulative spend for cost control."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across WBS elements — value of work accomplished per budget."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) across WBS elements — scheduled spend baseline."
    - name: "total_approved_budget_changes"
      expr: SUM(CAST(approved_budget_changes AS DOUBLE))
      comment: "Total approved budget changes across WBS elements — cumulative scope growth value."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity installed across WBS elements — physical production output."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across WBS elements — production scope baseline."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across WBS elements — overall work progress indicator."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted cost consumed by actual costs — WBS-level budget burn rate."
    - name: "quantity_productivity_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity actually installed — physical productivity rate for production benchmarking."
    - name: "evm_enabled_element_count"
      expr: COUNT(DISTINCT CASE WHEN evm_enabled = TRUE THEN wbs_element_id END)
      comment: "Number of EVM-enabled WBS elements — scope of earned value measurement coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project phase performance KPIs — tracks phase cost, schedule, and gate approval status for stage-gate governance and phase-level performance benchmarking."
  source: "`vibe_construction_v1`.`project`.`phase`"
  dimensions:
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (Active, Complete, On Hold) for active phase portfolio management."
    - name: "phase_type"
      expr: phase_type
      comment: "Type of phase (Design, Procurement, Construction, Commissioning) for phase-type performance comparison."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for phase performance comparison across procurement strategies."
    - name: "gate_approval_status"
      expr: gate_approval_status
      comment: "Gate review approval status for stage-gate governance tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag for critical path phases — focuses attention on schedule-critical phases."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Flag for HSE plan approval — safety governance gate check."
    - name: "quality_plan_approved"
      expr: quality_plan_approved
      comment: "Flag for quality plan approval — quality governance gate check."
    - name: "leed_applicable"
      expr: leed_applicable
      comment: "Flag for LEED-applicable phases — sustainability scope indicator."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the phase for risk-weighted phase analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Phase currency for multi-currency analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned phase start month for schedule pipeline analysis."
    - name: "planned_finish_date"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Planned phase finish month for completion trending."
    - name: "gate_approval_date"
      expr: DATE_TRUNC('month', gate_approval_date)
      comment: "Gate approval month for stage-gate cycle time analysis."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across all phases — phase-level cost baseline."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across phases — phase-level spend for cost control."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency budget across phases — risk buffer adequacy by phase."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value across phases — value of work accomplished per phase budget."
    - name: "total_ld_exposure"
      expr: SUM(CAST(ld_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across phases — financial risk from schedule delays."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across phases — overall phase progress indicator."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_pct AS DOUBLE))
      comment: "Average deliverables completion percentage across phases — output delivery progress."
    - name: "avg_evm_weight_pct"
      expr: AVG(CAST(evm_weight_pct AS DOUBLE))
      comment: "Average EVM weight percentage across phases — phase contribution to overall project EVM."
    - name: "avg_baseline_duration_days"
      expr: AVG(CAST(baseline_duration_days AS DOUBLE))
      comment: "Average baseline duration in days — typical phase duration for planning benchmarks."
    - name: "phase_cost_overrun_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Actual cost as percentage of budgeted cost — phase-level budget burn rate and overrun indicator."
    - name: "gate_approved_phase_count"
      expr: COUNT(DISTINCT CASE WHEN gate_approval_status = 'Approved' THEN phase_id END)
      comment: "Number of phases with approved gate reviews — stage-gate governance compliance count."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_budget_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget revision KPIs — tracks frequency, magnitude, and approval status of budget revisions for PMO change control governance and financial planning accuracy."
  source: "`vibe_construction_v1`.`project`.`project_budget_revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Status of the budget revision (Pending, Approved, Rejected) for revision pipeline management."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of budget revision (Scope Change, Risk Provision, Contingency Draw) for root cause analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model for revision frequency comparison across procurement strategies."
    - name: "client_approved_flag"
      expr: client_approved_flag
      comment: "Flag for client-approved revisions — separates internally approved from contractually agreed revisions."
    - name: "evm_baseline_flag"
      expr: evm_baseline_flag
      comment: "Flag for revisions that update the EVM baseline — performance measurement baseline change tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Revision currency for multi-currency analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the revision for period-over-period revision frequency analysis."
    - name: "revision_date"
      expr: DATE_TRUNC('month', revision_date)
      comment: "Month of budget revision for time-series revision frequency trending."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the revision became effective for financial planning timeline analysis."
  measures:
    - name: "total_revisions"
      expr: COUNT(DISTINCT project_budget_revision_id)
      comment: "Total number of budget revisions — revision frequency indicator for change control governance."
    - name: "total_revision_amount"
      expr: SUM(CAST(revision_amount AS DOUBLE))
      comment: "Total net budget revision amount — cumulative budget change from all revisions."
    - name: "total_budget_after_revision"
      expr: SUM(CAST(budget_after_revision AS DOUBLE))
      comment: "Total budget after all revisions — current authorized budget across all projects."
    - name: "total_contract_budget_impact"
      expr: SUM(CAST(contract_budget_impact AS DOUBLE))
      comment: "Total contract budget impact from revisions — commercial exposure from budget changes."
    - name: "total_internal_budget_impact"
      expr: SUM(CAST(internal_budget_impact AS DOUBLE))
      comment: "Total internal budget impact — non-contractual budget adjustments for internal cost management."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency in revised budgets — risk buffer adequacy after revisions."
    - name: "total_management_reserve"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve in revised budgets — executive-level risk buffer tracking."
    - name: "avg_revision_amount"
      expr: AVG(CAST(revision_amount AS DOUBLE))
      comment: "Average budget revision amount — typical revision magnitude for change control benchmarking."
    - name: "client_approved_revision_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN client_approved_flag = TRUE THEN project_budget_revision_id END) / NULLIF(COUNT(DISTINCT project_budget_revision_id), 0), 2)
      comment: "Percentage of budget revisions with client approval — contractual alignment rate for commercial governance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied in budget revisions — FX exposure indicator for multi-currency projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_team_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project team resource KPIs — tracks staffing levels, man-day utilization, mobilization status, and key personnel coverage for resource management and project delivery capacity."
  source: "`vibe_construction_v1`.`project`.`team_member`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the team member assignment (Active, Demobilized, Planned) for active headcount analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or project discipline for discipline-level resource analysis."
    - name: "role_category"
      expr: role_category
      comment: "Role category (Management, Engineering, Construction, Support) for workforce composition analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (Direct, Agency, Secondment) for workforce sourcing analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilization status for resource deployment pipeline management."
    - name: "is_key_personnel"
      expr: is_key_personnel
      comment: "Flag for key personnel — contractually required personnel coverage tracking."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type (Site, Office, Remote) for location-based resource analysis."
    - name: "nationality"
      expr: nationality
      comment: "Nationality of team member for local content and workforce diversity reporting."
    - name: "hse_induction_status"
      expr: hse_induction_status
      comment: "HSE induction status for safety compliance tracking."
    - name: "assignment_start_date"
      expr: DATE_TRUNC('month', assignment_start_date)
      comment: "Assignment start month for resource mobilization pipeline analysis."
    - name: "mobilization_date"
      expr: DATE_TRUNC('month', mobilization_date)
      comment: "Mobilization month for workforce deployment trending."
  measures:
    - name: "total_team_members"
      expr: COUNT(DISTINCT team_member_id)
      comment: "Total team members assigned — project headcount for resource capacity management."
    - name: "total_planned_man_days"
      expr: SUM(CAST(planned_man_days AS DOUBLE))
      comment: "Total planned man-days across all assignments — labor resource plan for cost and schedule."
    - name: "total_actual_man_days"
      expr: SUM(CAST(actual_man_days AS DOUBLE))
      comment: "Total actual man-days expended — labor productivity and utilization measurement."
    - name: "total_daily_cost_rate"
      expr: SUM(CAST(cost_rate_daily AS DOUBLE))
      comment: "Total daily cost rate across all active team members — daily labor cost burn rate."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across team members — resource utilization efficiency indicator."
    - name: "key_personnel_count"
      expr: COUNT(DISTINCT CASE WHEN is_key_personnel = TRUE THEN team_member_id END)
      comment: "Number of key personnel on the project — contractual key personnel coverage indicator."
    - name: "man_day_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_man_days AS DOUBLE)) / NULLIF(SUM(CAST(planned_man_days AS DOUBLE)), 0), 2)
      comment: "Actual man-days as percentage of planned — labor utilization efficiency for resource management."
    - name: "hse_inducted_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hse_induction_status = 'Complete' THEN team_member_id END) / NULLIF(COUNT(DISTINCT team_member_id), 0), 2)
      comment: "Percentage of team members with completed HSE induction — safety compliance rate for site access governance."
    - name: "avg_cost_rate_daily"
      expr: AVG(CAST(cost_rate_daily AS DOUBLE))
      comment: "Average daily cost rate per team member — labor cost benchmarking for resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`project_regulatory_oversight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory oversight and compliance KPIs — tracks active regulatory oversight engagements, inspection cycles, compliance ratings, and open findings for project compliance management."
  source: "`vibe_construction_v1`.`project`.`regulatory_oversight`"
  dimensions:
    - name: "oversight_status"
      expr: oversight_status
      comment: "Status of the regulatory oversight engagement (Active, Closed, Suspended) for active compliance scope."
    - name: "oversight_type"
      expr: oversight_type
      comment: "Type of regulatory oversight (Environmental, Safety, Building, Planning) for regulatory domain analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, Under Review) for compliance health dashboard."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Compliance rating assigned by the regulatory authority for performance benchmarking."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of regulatory reporting (Monthly, Quarterly, Annual) for compliance calendar management."
    - name: "is_active"
      expr: is_active
      comment: "Flag for active oversight engagements — filters to current regulatory obligations."
    - name: "oversight_scope"
      expr: oversight_scope
      comment: "Scope of regulatory oversight for categorized compliance analysis."
    - name: "last_inspection_date"
      expr: DATE_TRUNC('month', last_inspection_date)
      comment: "Month of last inspection for inspection frequency analysis."
    - name: "next_review_date"
      expr: DATE_TRUNC('month', next_review_date)
      comment: "Month of next scheduled review for compliance calendar management."
  measures:
    - name: "total_oversight_engagements"
      expr: COUNT(DISTINCT regulatory_oversight_id)
      comment: "Total regulatory oversight engagements — scope of regulatory compliance obligations."
    - name: "active_oversight_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN regulatory_oversight_id END)
      comment: "Number of active regulatory oversight engagements — current compliance obligation load."
    - name: "non_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Non-Compliant' THEN regulatory_oversight_id END)
      comment: "Number of non-compliant oversight engagements — regulatory risk exposure requiring immediate action."
    - name: "avg_days_since_last_inspection"
      expr: AVG(DATEDIFF(CURRENT_DATE(), last_inspection_date))
      comment: "Average days since last regulatory inspection — inspection currency indicator for compliance governance."
    - name: "overdue_review_count"
      expr: COUNT(DISTINCT CASE WHEN next_review_date < CURRENT_DATE() AND oversight_status = 'Active' THEN regulatory_oversight_id END)
      comment: "Number of oversight engagements with overdue reviews — compliance calendar breach indicator."
$$;