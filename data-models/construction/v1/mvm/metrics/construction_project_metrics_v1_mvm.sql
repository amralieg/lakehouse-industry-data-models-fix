-- Metric views for domain: project | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the construction project master. Covers portfolio health, financial performance, schedule adherence, and delivery model mix for executive steering and PMO governance."
  source: "`construction_ecm`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Active, Closed, On-Hold) — primary filter for portfolio views."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project type (e.g. Infrastructure, Commercial, Energy) for portfolio segmentation."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contractual delivery model (e.g. EPC, EPCM, Design-Build) used to segment performance by procurement strategy."
    - name: "region"
      expr: region
      comment: "Geographic region of the project for regional portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the project site for country-level reporting."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk classification (e.g. High, Medium, Low) enabling risk-stratified portfolio views."
    - name: "pmo_classification"
      expr: pmo_classification
      comment: "PMO tier or classification (e.g. Major, Standard, Minor) for governance-level segmentation."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the project is executed as a joint venture, relevant for risk and margin analysis."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level (e.g. Gold, Platinum) for sustainability portfolio tracking."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year of planned project start for cohort and vintage analysis."
    - name: "planned_completion_year"
      expr: DATE_TRUNC('YEAR', planned_completion_date)
      comment: "Year of planned project completion for delivery pipeline forecasting."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted revenue across the portfolio. Core financial KPI for executive revenue pipeline reporting."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved project budget across the portfolio. Used to assess capital commitment and budget adequacy."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per project. Indicates portfolio scale and project size mix."
    - name: "total_jv_partner_share_pct"
      expr: AVG(CAST(jv_partner_share_pct AS DOUBLE))
      comment: "Average JV partner equity share across joint-venture projects. Informs risk exposure and revenue attribution for JV portfolio."
    - name: "avg_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across active projects. Key operational KPI for portfolio delivery health."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across projects. CPI < 1.0 signals cost overrun; used by PMO to flag at-risk projects."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across projects. SPI < 1.0 signals schedule slippage; drives executive intervention decisions."
    - name: "avg_retention_pct"
      expr: AVG(CAST(retention_pct AS DOUBLE))
      comment: "Average contractual retention percentage across projects. Impacts cash flow forecasting and working capital management."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average daily LD rate across projects. Quantifies financial exposure from schedule delays at portfolio level."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of projects in the portfolio. Baseline denominator for portfolio-level ratio KPIs."
    - name: "active_project_count"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Number of currently active projects. Used to size operational workload and resource demand."
    - name: "joint_venture_project_count"
      expr: COUNT(CASE WHEN is_joint_venture = TRUE THEN 1 END)
      comment: "Number of projects executed as joint ventures. Informs JV risk exposure and partner management overhead."
    - name: "budget_vs_contract_variance"
      expr: SUM(CAST(contract_value AS DOUBLE) - CAST(approved_budget AS DOUBLE))
      comment: "Aggregate difference between contract value and approved budget across the portfolio. Positive value indicates margin headroom; negative signals budget overcommitment."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value Management and cost control KPI layer over project cost accounts. Supports PMO cost performance monitoring, variance analysis, and forecast-at-completion reporting."
  source: "`construction_ecm`.`project`.`cost_account`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost (e.g. Labour, Material, Subcontract, Equipment) for cost category analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the cost account (e.g. Open, Closed, Pending) for active cost monitoring."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial reporting and departmental cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the cost account for multi-currency portfolio analysis."
    - name: "is_subcontract_scope"
      expr: is_subcontract_scope
      comment: "Flag indicating whether the cost account covers subcontracted scope, enabling subcontract cost analysis."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating lump-sum vs. remeasurable contract basis, relevant for cost risk profiling."
    - name: "reporting_period_date"
      expr: DATE_TRUNC('MONTH', reporting_period_date)
      comment: "Reporting month for period-over-period cost trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system (e.g. SAP, Procore) from which the cost account data originates, for data lineage and reconciliation."
  measures:
    - name: "total_approved_budget_amount"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across cost accounts. Baseline for budget utilisation and variance reporting."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred. Core cost performance KPI for executive and PMO cost dashboards."
    - name: "total_committed_cost_amount"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed costs (purchase orders, subcontracts). Represents financial obligations not yet invoiced."
    - name: "total_forecast_cost_at_completion"
      expr: SUM(CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Total Estimate at Completion (EAC) across cost accounts. Primary forward-looking cost KPI for project financial health."
    - name: "total_earned_value_amount"
      expr: SUM(CAST(earned_value_amount AS DOUBLE))
      comment: "Total Earned Value (EV) — budgeted cost of work performed. Core EVM metric for schedule and cost performance."
    - name: "total_planned_value_amount"
      expr: SUM(CAST(planned_value_amount AS DOUBLE))
      comment: "Total Planned Value (PV) — budgeted cost of work scheduled. Used to compute Schedule Variance."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total Cost Variance (EV - AC). Negative value signals cost overrun across the portfolio."
    - name: "total_cost_to_complete_amount"
      expr: SUM(CAST(cost_to_complete_amount AS DOUBLE))
      comment: "Total Estimate to Complete (ETC). Represents remaining cost to finish all work in scope."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget held across cost accounts. Indicates risk reserve adequacy."
    - name: "total_change_order_amount"
      expr: SUM(CAST(change_order_amount AS DOUBLE))
      comment: "Total change order value incorporated into cost accounts. Tracks scope growth and its cost impact."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across cost accounts. CPI < 1.0 indicates cost overrun; drives PMO corrective action."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across cost accounts. SPI < 1.0 indicates schedule slippage."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across cost accounts. Measures overall work progress for the reporting period."
    - name: "budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed by actual costs. Signals budget burn rate and potential overrun risk."
    - name: "variance_at_completion"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE) - CAST(forecast_cost_at_completion AS DOUBLE))
      comment: "Aggregate Variance at Completion (BAC - EAC). Negative value signals projected cost overrun at portfolio level."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order performance and financial impact KPI layer. Tracks scope growth, cost exposure, schedule impact, and approval efficiency — critical for contract management and project financial control."
  source: "`construction_ecm`.`project`.`project_change_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the change order (e.g. Approved, Pending, Rejected) for pipeline and backlog analysis."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. Scope, Design, Client-Directed) for root-cause analysis of scope growth."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the change order, enabling Pareto analysis of change drivers."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model of the associated project for change order frequency analysis by contract type."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the change order is under dispute, highlighting commercial risk exposure."
    - name: "is_ld_applicable"
      expr: is_ld_applicable
      comment: "Flag indicating whether liquidated damages apply to this change order, for LD liability tracking."
    - name: "cost_impact_currency"
      expr: cost_impact_currency
      comment: "Currency of the cost impact for multi-currency change order analysis."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month the change order was submitted for trend analysis of change order volume over time."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the change order was approved for approval cycle time and backlog trending."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order (e.g. High, Medium, Low) for triage and escalation management."
  measures:
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Quantifies cumulative scope growth cost — a primary contract financial health KPI."
    - name: "total_direct_cost_amount"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct cost component of change orders. Used to separate direct vs. overhead cost escalation."
    - name: "total_overhead_and_profit_amount"
      expr: SUM(CAST(overhead_and_profit_amount AS DOUBLE))
      comment: "Total overhead and profit claimed in change orders. Informs margin impact of scope changes."
    - name: "total_contingency_drawn_amount"
      expr: SUM(CAST(contingency_drawn_amount AS DOUBLE))
      comment: "Total contingency budget consumed by change orders. Tracks contingency depletion rate and remaining risk reserve."
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders. Baseline volume metric for change order frequency and process efficiency analysis."
    - name: "approved_change_order_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved change orders. Used to compute approval rate and assess commercial team effectiveness."
    - name: "disputed_change_order_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed change orders. Signals commercial conflict exposure and potential legal/arbitration risk."
    - name: "change_order_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change orders that have been approved. Low approval rate signals client resistance or poor change documentation."
    - name: "avg_cost_impact_per_co"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Indicates the typical financial magnitude of scope changes."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average daily liquidated damages rate across LD-applicable change orders. Quantifies daily financial exposure from schedule delays."
    - name: "total_approved_cost_impact"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of approved change orders only. Represents confirmed scope growth value incorporated into the contract."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone delivery performance KPI layer. Tracks schedule adherence, LD exposure, payment trigger milestones, and critical path delivery — essential for contract compliance and client reporting."
  source: "`construction_ecm`.`project`.`project_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g. Achieved, Pending, Delayed) for delivery performance tracking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Contractual, Internal, Regulatory) for categorised schedule analysis."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Business category of the milestone (e.g. Handover, Commissioning, Design Freeze) for domain-specific tracking."
    - name: "is_contractual"
      expr: is_contractual
      comment: "Flag indicating contractually binding milestones — critical for LD liability and client reporting."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the milestone is on the critical path, prioritising management attention."
    - name: "is_payment_trigger"
      expr: is_payment_trigger
      comment: "Flag indicating milestones that trigger client payment, directly linking schedule to cash flow."
    - name: "is_ld_trigger"
      expr: is_ld_trigger
      comment: "Flag indicating milestones whose delay triggers liquidated damages, quantifying schedule financial risk."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model of the associated project for milestone performance analysis by contract type."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for achieving the milestone (e.g. Contractor, Client, Engineer) for accountability tracking."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month of planned milestone date for schedule pipeline and look-ahead reporting."
  measures:
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of milestones. Baseline for milestone completion rate and schedule density analysis."
    - name: "achieved_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END)
      comment: "Number of milestones achieved. Measures delivery execution effectiveness."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of delayed milestones. Key schedule health KPI triggering PMO escalation and client notifications."
    - name: "milestone_achievement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved on time. Primary schedule delivery KPI for executive dashboards and client reporting."
    - name: "payment_trigger_milestone_count"
      expr: COUNT(CASE WHEN is_payment_trigger = TRUE THEN 1 END)
      comment: "Number of payment-trigger milestones. Directly linked to cash flow forecasting and billing pipeline."
    - name: "ld_trigger_milestone_count"
      expr: COUNT(CASE WHEN is_ld_trigger = TRUE THEN 1 END)
      comment: "Number of milestones that trigger liquidated damages on delay. Quantifies LD exposure concentration in the schedule."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment value linked to payment-trigger milestones. Represents the billing pipeline tied to schedule delivery."
    - name: "total_ld_rate_per_day"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Total daily LD rate exposure across all LD-trigger milestones. Quantifies maximum daily financial penalty from schedule delays."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones. Indicates overall milestone progress for portfolio-level schedule health."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path milestones. Informs schedule risk concentration and management focus areas."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_progress_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Earned Value and physical progress KPI layer over progress measurement records. Supports period-over-period progress tracking, EVM performance, and billing eligibility analysis."
  source: "`construction_ecm`.`project`.`progress_measurement`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the progress measurement record (e.g. Approved, Pending, Rejected) for data quality and approval pipeline tracking."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g. Physical, Financial, Quantity-based) for methodology analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. Milestone, Percent Complete, Units Installed) for EVM methodology governance."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or construction discipline (e.g. Civil, Mechanical, Electrical) for discipline-level progress analysis."
    - name: "is_billing_eligible"
      expr: is_billing_eligible
      comment: "Flag indicating whether the measurement is eligible for client billing, linking progress to revenue recognition."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating milestone-based measurements for milestone progress tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the measurement values for multi-currency portfolio analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of the measurement for period-over-period progress trend analysis."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Reporting period end month for aligning measurements to financial reporting cycles."
    - name: "work_area"
      expr: work_area
      comment: "Physical work area or zone on site for spatial progress analysis."
  measures:
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total Earned Value (EV) across measurements. Core EVM metric representing budgeted cost of work performed."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total Planned Value (PV) across measurements. Represents budgeted cost of work scheduled — baseline for Schedule Variance."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) across measurements. Denominator for percent complete and EVM ratio calculations."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total Cost Variance (EV - AC) across measurements. Negative value signals cost overrun."
    - name: "total_schedule_variance"
      expr: SUM(CAST(schedule_variance AS DOUBLE))
      comment: "Total Schedule Variance (EV - PV) across measurements. Negative value signals schedule slippage."
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed to date. Physical progress KPI for quantity-based scope tracking."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current reporting period. Measures productivity rate for the period."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across measurement records. Portfolio-level progress indicator."
    - name: "avg_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across measurements. CPI < 1.0 signals cost overrun; drives PMO corrective action."
    - name: "avg_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across measurements. SPI < 1.0 signals schedule slippage."
    - name: "billing_eligible_measurement_count"
      expr: COUNT(CASE WHEN is_billing_eligible = TRUE THEN 1 END)
      comment: "Number of billing-eligible measurements. Indicates the volume of progress records ready for client invoicing."
    - name: "schedule_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(schedule_variance AS DOUBLE)) / NULLIF(SUM(CAST(planned_value AS DOUBLE)), 0), 2)
      comment: "Schedule Variance as a percentage of Planned Value. Normalised schedule performance indicator for cross-project comparison."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_variance AS DOUBLE)) / NULLIF(SUM(CAST(earned_value AS DOUBLE)), 0), 2)
      comment: "Cost Variance as a percentage of Earned Value. Normalised cost performance indicator for cross-project comparison."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk portfolio KPI layer. Tracks risk exposure, cost impact, mitigation effectiveness, and risk concentration by category — essential for executive risk governance and insurance/contingency planning."
  source: "`construction_ecm`.`project`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Closed, Mitigated) for active risk portfolio management."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g. Commercial, Technical, HSE, Regulatory) for risk concentration analysis."
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk for granular classification and Pareto analysis of risk drivers."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Qualitative probability rating (e.g. High, Medium, Low) for risk heat map analysis."
    - name: "cost_impact_rating"
      expr: cost_impact_rating
      comment: "Qualitative cost impact rating for risk prioritisation and contingency sizing."
    - name: "schedule_impact_rating"
      expr: schedule_impact_rating
      comment: "Qualitative schedule impact rating for schedule risk concentration analysis."
    - name: "mitigation_response_type"
      expr: mitigation_response_type
      comment: "Risk response strategy (e.g. Mitigate, Transfer, Accept, Avoid) for response portfolio analysis."
    - name: "hse_risk_flag"
      expr: hse_risk_flag
      comment: "Flag indicating HSE-related risks for safety risk portfolio tracking."
    - name: "regulatory_risk_flag"
      expr: regulatory_risk_flag
      comment: "Flag indicating regulatory compliance risks for compliance risk monitoring."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating risks escalated to senior management for executive attention tracking."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified for risk emergence trend analysis."
  measures:
    - name: "risk_count"
      expr: COUNT(1)
      comment: "Total number of risks in the register. Baseline for risk density and portfolio risk volume analysis."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open (unresolved) risks. Primary risk portfolio health KPI for executive risk dashboards."
    - name: "escalated_risk_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated risks requiring senior management attention. Drives executive risk review agenda."
    - name: "hse_risk_count"
      expr: COUNT(CASE WHEN hse_risk_flag = TRUE THEN 1 END)
      comment: "Number of HSE-related risks. Critical safety governance KPI for HSE leadership and regulatory reporting."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total potential cost impact of all risks. Quantifies gross financial exposure for contingency planning."
    - name: "total_contingency_cost_amount"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Total contingency allocated to risks. Measures adequacy of risk reserves against identified exposures."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the register. Composite risk severity indicator for portfolio-level risk health."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation. Measures effectiveness of risk response strategies."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average probability score across risks. Indicates overall likelihood of risk materialisation in the portfolio."
    - name: "risk_mitigation_effectiveness_pct"
      expr: ROUND(100.0 * (1 - AVG(CAST(residual_risk_score AS DOUBLE)) / NULLIF(AVG(CAST(risk_score AS DOUBLE)), 0)) * 100, 2)
      comment: "Percentage reduction in risk score achieved through mitigation. Measures overall effectiveness of risk response actions."
    - name: "contingency_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(contingency_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_impact_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total risk cost impact covered by contingency reserves. Below 100% signals under-provisioned risk reserves."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project phase performance KPI layer. Tracks phase-level cost performance, schedule adherence, EVM metrics, and gate approval status — supporting PMO governance and phase-gate decision-making."
  source: "`construction_ecm`.`project`.`phase`"
  dimensions:
    - name: "phase_status"
      expr: phase_status
      comment: "Current status of the phase (e.g. Active, Completed, On-Hold) for phase portfolio management."
    - name: "phase_type"
      expr: phase_type
      comment: "Type of phase (e.g. Design, Construction, Commissioning) for phase-type performance benchmarking."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model of the phase for performance analysis by contract strategy."
    - name: "gate_approval_status"
      expr: gate_approval_status
      comment: "Status of the phase gate approval (e.g. Approved, Pending, Rejected) for governance pipeline tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the phase is on the critical path, prioritising management focus."
    - name: "leed_applicable"
      expr: leed_applicable
      comment: "Flag indicating LEED-applicable phases for sustainability performance tracking."
    - name: "quality_plan_approved"
      expr: quality_plan_approved
      comment: "Flag indicating whether the quality plan has been approved for this phase — a governance compliance indicator."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of phase financial values for multi-currency analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned phase start for schedule pipeline analysis."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across phases. Baseline for phase-level budget utilisation and variance analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across phases. Core cost performance KPI for phase-level financial control."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total Earned Value across phases. Core EVM metric for phase-level schedule and cost performance."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget AS DOUBLE))
      comment: "Total contingency budget held at phase level. Indicates risk reserve adequacy by phase."
    - name: "total_ld_exposure_amount"
      expr: SUM(CAST(ld_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across phases. Quantifies financial penalty risk from phase schedule delays."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across phases. Portfolio-level phase progress indicator."
    - name: "avg_deliverables_completion_pct"
      expr: AVG(CAST(deliverables_completion_pct AS DOUBLE))
      comment: "Average deliverables completion percentage across phases. Measures documentation and deliverable readiness."
    - name: "budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of phase budget consumed by actual costs. Signals budget burn rate and overrun risk at phase level."
    - name: "phase_count"
      expr: COUNT(1)
      comment: "Total number of phases. Baseline for phase completion rate and governance pipeline analysis."
    - name: "gate_approved_phase_count"
      expr: COUNT(CASE WHEN gate_approval_status = 'Approved' THEN 1 END)
      comment: "Number of phases with approved gate reviews. Measures governance compliance and phase progression velocity."
    - name: "critical_path_phase_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of phases on the critical path. Informs schedule risk concentration and management prioritisation."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "WBS element cost and progress KPI layer. Provides granular EVM performance, budget control, and scope delivery tracking at the work breakdown structure level — the foundational unit of project cost and schedule control."
  source: "`construction_ecm`.`project`.`wbs_element`"
  dimensions:
    - name: "wbs_status"
      expr: wbs_status
      comment: "Current status of the WBS element (e.g. Active, Closed, On-Hold) for active scope management."
    - name: "wbs_type"
      expr: wbs_type
      comment: "Type of WBS element (e.g. Summary, Work Package, Control Account) for hierarchical analysis."
    - name: "wbs_level"
      expr: wbs_level
      comment: "Hierarchical level of the WBS element for drill-down analysis from project to work package."
    - name: "responsible_discipline"
      expr: responsible_discipline
      comment: "Engineering or construction discipline responsible for the WBS element for discipline-level performance tracking."
    - name: "charge_type"
      expr: charge_type
      comment: "Charge type (e.g. Direct, Indirect, Overhead) for cost classification analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model associated with the WBS element for performance analysis by contract strategy."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating lump-sum vs. remeasurable WBS elements for cost risk profiling."
    - name: "evm_enabled"
      expr: evm_enabled
      comment: "Flag indicating whether EVM is enabled for this WBS element, scoping EVM KPIs to valid records."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of WBS element financial values for multi-currency analysis."
    - name: "percent_complete_method"
      expr: percent_complete_method
      comment: "Method used to measure percent complete (e.g. Milestone, Weighted Steps, Physical Measurement) for methodology governance."
  measures:
    - name: "total_budgeted_cost"
      expr: SUM(CAST(budgeted_cost AS DOUBLE))
      comment: "Total budgeted cost across WBS elements. Baseline for budget control and variance analysis at work package level."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS elements. Core cost performance KPI for granular cost control."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total Earned Value across WBS elements. Core EVM metric for work package schedule and cost performance."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total Planned Value across WBS elements. Baseline for Schedule Variance calculation at WBS level."
    - name: "total_original_budget_cost"
      expr: SUM(CAST(original_budget_cost AS DOUBLE))
      comment: "Total original (pre-change) budget cost. Used to quantify scope growth by comparing to current budgeted cost."
    - name: "total_approved_budget_changes"
      expr: SUM(CAST(approved_budget_changes AS DOUBLE))
      comment: "Total approved budget changes (change orders) incorporated into WBS elements. Tracks cumulative scope growth."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percent complete across WBS elements. Granular progress indicator for work package delivery."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity installed across WBS elements. Physical progress KPI for quantity-based scope tracking."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across WBS elements. Baseline for quantity variance and productivity analysis."
    - name: "budget_cost_variance"
      expr: SUM(CAST(budgeted_cost AS DOUBLE) - CAST(actual_cost AS DOUBLE))
      comment: "Aggregate cost variance (Budget - Actual) across WBS elements. Negative value signals cost overrun at work package level."
    - name: "scope_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(budgeted_cost AS DOUBLE)) - SUM(CAST(original_budget_cost AS DOUBLE))) / NULLIF(SUM(CAST(original_budget_cost AS DOUBLE)), 0), 2)
      comment: "Percentage increase in budgeted cost vs. original budget. Measures cumulative scope growth at WBS level — a key project financial health KPI."
    - name: "quantity_productivity_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Actual quantity installed as a percentage of planned quantity. Measures field productivity and installation rate performance."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_baseline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project baseline governance and variance KPI layer. Tracks baseline revisions, budget evolution, contingency adequacy, and variance at completion — critical for PMO governance and contract financial control."
  source: "`construction_ecm`.`project`.`project_baseline`"
  dimensions:
    - name: "baseline_status"
      expr: baseline_status
      comment: "Current status of the baseline (e.g. Active, Superseded, Draft) for baseline governance tracking."
    - name: "baseline_type"
      expr: baseline_type
      comment: "Type of baseline (e.g. Original, Revised, Re-baseline) for baseline evolution analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Governance approval level required for the baseline (e.g. PMO, Board, Client) for approval pipeline tracking."
    - name: "is_current_baseline"
      expr: is_current_baseline
      comment: "Flag indicating the currently active baseline — scopes KPIs to the live performance baseline."
    - name: "is_client_approved"
      expr: is_client_approved
      comment: "Flag indicating client-approved baselines for contract compliance tracking."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model associated with the baseline for performance analysis by contract strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of baseline financial values for multi-currency analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of baseline approval for baseline revision frequency trend analysis."
  measures:
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion (BAC) across baselines. Primary financial baseline KPI for portfolio budget sizing."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value incorporated in baselines. Used to reconcile baseline budget against contracted revenue."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserve held in baselines. Measures risk reserve adequacy at portfolio level."
    - name: "total_management_reserve_amount"
      expr: SUM(CAST(management_reserve_amount AS DOUBLE))
      comment: "Total management reserve across baselines. Represents discretionary budget held above contingency for unforeseen scope."
    - name: "total_variance_at_completion"
      expr: SUM(CAST(variance_at_completion AS DOUBLE))
      comment: "Total Variance at Completion (BAC - EAC) across baselines. Negative value signals projected cost overrun at portfolio level."
    - name: "total_co_value_incorporated"
      expr: SUM(CAST(co_value_incorporated AS DOUBLE))
      comment: "Total change order value incorporated into baselines. Tracks cumulative scope growth formalised in approved baselines."
    - name: "budget_revision_impact"
      expr: SUM(CAST(budget_after_revision AS DOUBLE) - CAST(budget_before_revision AS DOUBLE))
      comment: "Net budget change from baseline revisions (After - Before). Quantifies the financial impact of re-baselining events."
    - name: "baseline_count"
      expr: COUNT(1)
      comment: "Total number of baselines. Baseline revision frequency is a governance health indicator — excessive revisions signal scope instability."
    - name: "client_approved_baseline_count"
      expr: COUNT(CASE WHEN is_client_approved = TRUE THEN 1 END)
      comment: "Number of client-approved baselines. Measures contract compliance and client alignment on project scope and budget."
    - name: "contingency_to_bac_pct"
      expr: ROUND(100.0 * SUM(CAST(contingency_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_at_completion AS DOUBLE)), 0), 2)
      comment: "Contingency as a percentage of Budget at Completion. Measures risk reserve adequacy relative to total project budget."
$$;