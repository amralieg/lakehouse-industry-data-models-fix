-- Metric views for domain: matter | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core matter portfolio metrics tracking financial exposure, lifecycle efficiency, and risk profile across all active and closed legal matters. Used by firm leadership to steer resource allocation, fee strategy, and risk management."
  source: "`legal_ecm`.`matter`.`matter`"
  dimensions:
    - name: "matter_status"
      expr: matter_status
      comment: "Current lifecycle status of the matter (e.g., Open, Closed, Pending) — primary segmentation for portfolio health analysis."
    - name: "matter_type"
      expr: matter_type
      comment: "Classification of the matter by legal service type (e.g., Litigation, Transactional, Advisory) — drives practice group reporting."
    - name: "fee_arrangement_type"
      expr: fee_arrangement_type
      comment: "Billing model for the matter (e.g., Hourly, Fixed Fee, Contingency) — critical for revenue forecasting and profitability analysis."
    - name: "practice_area"
      expr: ledes_matter_category
      comment: "LEDES-standard matter category code used for industry-standard practice area benchmarking and reporting."
    - name: "office_code"
      expr: office_code
      comment: "Office responsible for the matter — enables geographic and office-level performance segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Firm-assigned risk rating for the matter — used to monitor high-risk matter concentration."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Sensitivity classification of the matter — used for access governance and compliance reporting."
    - name: "conflict_cleared_flag"
      expr: conflict_cleared_flag
      comment: "Boolean indicating whether conflict clearance has been completed — flags matters at intake compliance risk."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the matter was opened — used for intake volume trending and seasonality analysis."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the matter was closed — used for matter closure rate trending."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing legal jurisdiction for the matter — used for jurisdictional exposure analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the client is billed (e.g., Monthly, Quarterly) — used for cash flow planning."
  measures:
    - name: "total_active_matters"
      expr: COUNT(CASE WHEN matter_status = 'Open' THEN matter_id END)
      comment: "Count of currently open matters — baseline KPI for firm capacity and workload management."
    - name: "total_matters"
      expr: COUNT(matter_id)
      comment: "Total matter count across all statuses — used as denominator for rate calculations and portfolio sizing."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of client-approved budget amounts across all matters — represents total authorized financial exposure under management."
    - name: "avg_budget_per_matter"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average approved budget per matter — used to benchmark matter complexity and fee strategy effectiveness."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated attorney hours across all matters — used for capacity planning and resource forecasting."
    - name: "avg_estimated_hours_per_matter"
      expr: AVG(CAST(estimated_hours AS DOUBLE))
      comment: "Average estimated hours per matter — benchmarks matter complexity and staffing requirements."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts across all matters — key financial outcome metric for litigation portfolio valuation."
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per matter — used to benchmark dispute resolution outcomes and negotiate future settlements."
    - name: "conflict_clearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conflict_cleared_flag = TRUE THEN matter_id END) / NULLIF(COUNT(matter_id), 0), 2)
      comment: "Percentage of matters with completed conflict clearance — critical compliance KPI; low rates signal intake process risk."
    - name: "matters_with_engagement_letter_signed"
      expr: COUNT(CASE WHEN engagement_letter_signed_date IS NOT NULL THEN matter_id END)
      comment: "Count of matters with a signed engagement letter — measures intake process completion and client onboarding quality."
    - name: "engagement_letter_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN engagement_letter_signed_date IS NOT NULL THEN matter_id END) / NULLIF(COUNT(matter_id), 0), 2)
      comment: "Percentage of matters with a signed engagement letter — flags risk exposure from matters proceeding without formal client authorization."
    - name: "distinct_clients"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients with active or historical matters — measures client base breadth and concentration risk."
    - name: "avg_days_to_close"
      expr: AVG(CAST(DATEDIFF(close_date, open_date) AS DOUBLE))
      comment: "Average number of days from matter open to close — measures matter lifecycle efficiency and throughput velocity."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_phase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter phase execution metrics tracking budget adherence, hours utilization, and schedule performance at the phase level. Used by matter managers and practice group leaders to identify cost overruns and delivery risk early."
  source: "`legal_ecm`.`matter`.`phase`"
  dimensions:
    - name: "phase_name"
      expr: phase_name
      comment: "Name of the matter phase (e.g., Discovery, Trial Preparation) — primary grouping for phase-level performance analysis."
    - name: "phase_type"
      expr: phase_type
      comment: "Classification of the phase type — used to benchmark performance across similar phase categories."
    - name: "phase_status"
      expr: phase_status
      comment: "Current execution status of the phase (e.g., Active, Completed, On Hold) — used to filter in-flight vs. completed phases."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the phase is billable to the client — used to separate billable from non-billable work for profitability analysis."
    - name: "is_contingent"
      expr: is_contingent
      comment: "Whether the phase is under a contingency fee arrangement — affects revenue recognition and financial risk profiling."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the phase — used to prioritize management attention on high-risk phases."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the phase was planned to start — used for schedule adherence trending."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the phase actually started — compared against planned start to measure schedule slippage."
  measures:
    - name: "total_phases"
      expr: COUNT(phase_id)
      comment: "Total number of matter phases — baseline count for phase portfolio sizing."
    - name: "total_budgeted_fees"
      expr: SUM(CAST(budgeted_fees AS DOUBLE))
      comment: "Total budgeted fee amount across all phases — represents planned revenue commitment for matter execution."
    - name: "total_actual_fees_to_date"
      expr: SUM(CAST(actual_fees_to_date AS DOUBLE))
      comment: "Total fees incurred to date across all phases — compared against budget to identify overruns."
    - name: "total_budgeted_hours"
      expr: SUM(CAST(budgeted_hours AS DOUBLE))
      comment: "Total budgeted hours across all phases — used for capacity planning and resource allocation."
    - name: "total_actual_hours_to_date"
      expr: SUM(CAST(actual_hours_to_date AS DOUBLE))
      comment: "Total hours worked to date across all phases — compared against budget to identify scope creep."
    - name: "total_budgeted_disbursements"
      expr: SUM(CAST(budgeted_disbursements AS DOUBLE))
      comment: "Total budgeted disbursements across all phases — used for client cost forecasting and billing accuracy."
    - name: "total_actual_disbursements_to_date"
      expr: SUM(CAST(actual_disbursements_to_date AS DOUBLE))
      comment: "Total disbursements incurred to date — compared against budget to monitor out-of-pocket cost control."
    - name: "fee_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_fees_to_date AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_fees AS DOUBLE)), 0), 2)
      comment: "Percentage of fee budget consumed to date — primary KPI for matter financial health; values above 100% signal overrun."
    - name: "hours_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours_to_date AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of hours budget consumed to date — used to detect scope creep and staffing inefficiency early."
    - name: "fee_budget_variance"
      expr: SUM(CAST(actual_fees_to_date AS DOUBLE) - CAST(budgeted_fees AS DOUBLE))
      comment: "Absolute fee variance (actual minus budget) across all phases — negative values indicate under-budget performance; positive values signal overruns requiring client communication."
    - name: "hours_budget_variance"
      expr: SUM(CAST(actual_hours_to_date AS DOUBLE) - CAST(budgeted_hours AS DOUBLE))
      comment: "Absolute hours variance (actual minus budget) — used to identify phases consuming more attorney time than planned."
    - name: "avg_fee_budget_per_phase"
      expr: AVG(CAST(budgeted_fees AS DOUBLE))
      comment: "Average budgeted fee per phase — used to benchmark phase complexity and set future phase budgets."
    - name: "phases_over_fee_budget"
      expr: COUNT(CASE WHEN actual_fees_to_date > budgeted_fees THEN phase_id END)
      comment: "Count of phases where actual fees have exceeded the approved budget — used to trigger client notification and budget amendment workflows."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter budget governance metrics tracking approved financial limits, rate structures, and budget compliance across matters. Used by finance and billing teams to enforce outside counsel guidelines and manage rate approval workflows."
  source: "`legal_ecm`.`matter`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., Phase, Matter-Level, Blended Rate) — used to segment budget analysis by authorization structure."
    - name: "budget_status"
      expr: budget_status
      comment: "Current approval status of the budget (e.g., Approved, Pending, Expired) — used to filter active vs. lapsed budgets."
    - name: "budget_source"
      expr: budget_source
      comment: "Origin of the budget (e.g., Client-Directed, Firm-Estimated) — used to distinguish client-mandated from internally set budgets."
    - name: "currency"
      expr: currency
      comment: "Currency denomination of the budget — used for multi-currency portfolio normalization."
    - name: "rate_type"
      expr: rate_type
      comment: "Type of billing rate (e.g., Standard, Blended, Discounted) — used to analyze rate strategy effectiveness."
    - name: "rate_approval_status"
      expr: rate_approval_status
      comment: "Approval status of the rate schedule — used to flag unapproved rates that may violate outside counsel guidelines."
    - name: "timekeeper_role"
      expr: timekeeper_role
      comment: "Role of the timekeeper associated with the budget line (e.g., Partner, Associate, Paralegal) — used for rate benchmarking by seniority."
    - name: "client_agreed_flag"
      expr: client_agreed_flag
      comment: "Whether the client has formally agreed to this budget — used to identify budgets lacking client authorization."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month the budget was approved — used for budget approval cycle time analysis."
    - name: "rate_schedule_name"
      expr: rate_schedule_name
      comment: "Name of the applicable rate schedule — used to track which rate cards are in use across the matter portfolio."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total approved budget amount across all matter budgets — represents total authorized financial commitment under management."
    - name: "avg_budget_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average approved budget per budget record — used to benchmark matter financial scope and set future budget expectations."
    - name: "total_hourly_rate_amount"
      expr: SUM(CAST(hourly_rate_amount AS DOUBLE))
      comment: "Sum of hourly rate amounts across budget records — used for blended rate analysis and rate card benchmarking."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate_amount AS DOUBLE))
      comment: "Average hourly billing rate across all budget records — key metric for rate competitiveness and outside counsel guideline compliance."
    - name: "total_budgets"
      expr: COUNT(budget_id)
      comment: "Total number of budget records — baseline count for budget portfolio sizing."
    - name: "client_agreed_budget_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_agreed_flag = TRUE THEN budget_id END) / NULLIF(COUNT(budget_id), 0), 2)
      comment: "Percentage of budgets with formal client agreement — measures billing governance compliance; low rates indicate authorization risk."
    - name: "approved_rate_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_approval_status = 'Approved' THEN budget_id END) / NULLIF(COUNT(budget_id), 0), 2)
      comment: "Percentage of budget records with approved rate status — used to enforce outside counsel guideline compliance and flag unapproved billing rates."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_percentage AS DOUBLE))
      comment: "Average budget variance threshold percentage across all budgets — used to assess how much tolerance clients have granted for budget overruns."
    - name: "distinct_matters_with_budget"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one approved budget — measures budget coverage across the matter portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_deadline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deadline compliance and malpractice risk metrics tracking completion rates, extension patterns, and escalation flags across all matter deadlines. Used by risk management and practice group leaders to prevent missed deadlines and malpractice exposure."
  source: "`legal_ecm`.`matter`.`deadline`"
  dimensions:
    - name: "deadline_type"
      expr: deadline_type
      comment: "Classification of the deadline (e.g., Court Filing, Statute of Limitations, Regulatory) — used to prioritize high-risk deadline categories."
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the deadline (e.g., Completed, Missed, Pending) — primary KPI dimension for compliance monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the deadline — used to focus management attention on critical deadlines."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with missing this deadline — used to triage malpractice exposure."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction governing the deadline — used for jurisdictional compliance analysis."
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for meeting the deadline — used for team-level accountability reporting."
    - name: "malpractice_risk_flag"
      expr: malpractice_risk_flag
      comment: "Boolean flag indicating malpractice risk if deadline is missed — used to escalate high-stakes deadlines to firm leadership."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Whether an extension was granted for this deadline — used to analyze extension patterns and court accommodation rates."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the deadline has been escalated — used to monitor escalation volume and response effectiveness."
    - name: "deadline_date_month"
      expr: DATE_TRUNC('MONTH', deadline_date)
      comment: "Month of the deadline — used for deadline volume trending and workload forecasting."
    - name: "adr_proceeding_flag"
      expr: adr_proceeding_flag
      comment: "Whether the deadline relates to an ADR proceeding — used to segment court vs. ADR deadline compliance."
  measures:
    - name: "total_deadlines"
      expr: COUNT(deadline_id)
      comment: "Total number of deadlines across all matters — baseline count for deadline portfolio sizing and workload assessment."
    - name: "completed_deadlines"
      expr: COUNT(CASE WHEN completion_status = 'Completed' THEN deadline_id END)
      comment: "Count of deadlines successfully completed — numerator for deadline compliance rate calculation."
    - name: "missed_deadlines"
      expr: COUNT(CASE WHEN completion_status = 'Missed' THEN deadline_id END)
      comment: "Count of missed deadlines — critical risk KPI; any missed deadline may constitute malpractice and triggers immediate escalation."
    - name: "deadline_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'Completed' THEN deadline_id END) / NULLIF(COUNT(deadline_id), 0), 2)
      comment: "Percentage of deadlines completed on time — primary compliance KPI for risk management; below 98% triggers firm-wide review."
    - name: "malpractice_risk_deadline_count"
      expr: COUNT(CASE WHEN malpractice_risk_flag = TRUE THEN deadline_id END)
      comment: "Count of deadlines flagged as malpractice risk — used by risk management to prioritize monitoring and insurance notification."
    - name: "escalated_deadline_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN deadline_id END)
      comment: "Count of escalated deadlines — measures escalation volume and identifies systemic deadline management failures."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN deadline_id END)
      comment: "Count of deadlines where an extension was granted — used to analyze court accommodation patterns and opposing counsel dynamics."
    - name: "extension_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_granted_flag = TRUE THEN deadline_id END) / NULLIF(COUNT(deadline_id), 0), 2)
      comment: "Percentage of deadlines receiving extensions — high rates may indicate systemic scheduling issues or resource constraints."
    - name: "alert_sent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_sent_flag = TRUE THEN deadline_id END) / NULLIF(COUNT(deadline_id), 0), 2)
      comment: "Percentage of deadlines for which an alert was sent — measures deadline notification process effectiveness; gaps indicate system failures."
    - name: "distinct_matters_with_deadlines"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one deadline — used to assess deadline management coverage across the matter portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter task execution metrics tracking cost efficiency, hours accuracy, and delivery quality at the task level. Used by matter managers to identify scope creep, resource inefficiency, and billing accuracy issues."
  source: "`legal_ecm`.`matter`.`task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g., Open, In Progress, Completed, Blocked) — primary dimension for task pipeline health monitoring."
    - name: "task_category"
      expr: task_category
      comment: "Category of the task (e.g., Research, Drafting, Court Appearance) — used to analyze time allocation by work type."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the task — used to focus management attention on high-priority deliverables."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the task is billable to the client — used to separate billable from non-billable work for profitability analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the task requires client or partner approval — used to identify bottlenecks in approval workflows."
    - name: "is_milestone_flag"
      expr: is_milestone_flag
      comment: "Whether the task is a matter milestone — used to track milestone completion rates and matter progress."
    - name: "utbms_task_code"
      expr: utbms_task_code
      comment: "UTBMS standard task code — used for industry-standard billing analysis and outside counsel guideline compliance."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the task is due — used for workload forecasting and deadline concentration analysis."
    - name: "client_visible_flag"
      expr: client_visible_flag
      comment: "Whether the task is visible to the client — used to manage client transparency and engagement."
  measures:
    - name: "total_tasks"
      expr: COUNT(task_id)
      comment: "Total number of tasks across all matters — baseline count for task portfolio sizing and workload assessment."
    - name: "completed_tasks"
      expr: COUNT(CASE WHEN task_status = 'Completed' THEN task_id END)
      comment: "Count of completed tasks — used to measure matter execution throughput and team productivity."
    - name: "task_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'Completed' THEN task_id END) / NULLIF(COUNT(task_id), 0), 2)
      comment: "Percentage of tasks completed — measures matter execution efficiency; low rates signal delivery risk."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all tasks — used for capacity planning and resource forecasting."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all tasks — compared against estimates to measure scoping accuracy."
    - name: "total_hours_variance"
      expr: SUM(CAST(budget_variance_hours AS DOUBLE))
      comment: "Total hours variance (actual minus estimated) across all tasks — positive values indicate scope creep; negative values indicate over-estimation."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all tasks — used for matter budget validation and client cost forecasting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all tasks — compared against estimates to measure cost control effectiveness."
    - name: "total_cost_variance"
      expr: SUM(CAST(budget_variance_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) across all tasks — key financial control metric; large positive values trigger budget amendment workflows."
    - name: "hours_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(estimated_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated hours as a percentage — measures scoping accuracy; values significantly above 100% indicate systematic under-estimation."
    - name: "cost_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated cost as a percentage — measures cost estimation accuracy; used to improve future matter budgeting."
    - name: "milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_milestone_flag = TRUE AND task_status = 'Completed' THEN task_id END) / NULLIF(COUNT(CASE WHEN is_milestone_flag = TRUE THEN task_id END), 0), 2)
      comment: "Percentage of milestone tasks completed — used by matter managers and clients to assess matter progress against key deliverables."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter outcome performance metrics tracking win rates, financial recoveries, and client satisfaction across resolved matters. Used by firm leadership to evaluate litigation strategy effectiveness, practice group performance, and business development positioning."
  source: "`legal_ecm`.`matter`.`outcome`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of matter outcome (e.g., Settlement, Judgment, Dismissal, Withdrawal) — primary dimension for outcome portfolio analysis."
    - name: "outcome_category"
      expr: outcome_category
      comment: "Broader category of the outcome — used for strategic reporting and practice group benchmarking."
    - name: "win_loss_classification"
      expr: win_loss_classification
      comment: "Win/loss/neutral classification of the outcome — primary KPI dimension for litigation performance reporting."
    - name: "favorable_outcome_flag"
      expr: favorable_outcome_flag
      comment: "Boolean indicating whether the outcome was favorable to the client — used for client satisfaction and firm reputation analysis."
    - name: "prevailing_party"
      expr: prevailing_party
      comment: "Party that prevailed in the matter — used to analyze win rates by practice area, judge, and jurisdiction."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the outcome (e.g., Final, Under Appeal, Pending Enforcement) — used to filter actionable vs. closed outcomes."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed — used to measure appeal rates and identify matters with continued litigation risk."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the outcome was rendered — used for jurisdictional win rate benchmarking."
    - name: "practice_group_code"
      expr: practice_group_code
      comment: "Practice group responsible for the matter — used for practice group performance reporting."
    - name: "office_code"
      expr: office_code
      comment: "Office that handled the matter — used for office-level outcome performance analysis."
    - name: "outcome_date_month"
      expr: DATE_TRUNC('MONTH', outcome_date)
      comment: "Month the outcome was recorded — used for outcome volume trending and seasonality analysis."
    - name: "contingent_fee_triggered_flag"
      expr: contingent_fee_triggered_flag
      comment: "Whether the outcome triggered a contingency fee — used for contingency revenue recognition and forecasting."
    - name: "enforcement_action_required_flag"
      expr: enforcement_action_required_flag
      comment: "Whether enforcement action is required to collect on the outcome — used to track post-judgment collection risk."
  measures:
    - name: "total_outcomes"
      expr: COUNT(outcome_id)
      comment: "Total number of resolved matter outcomes — baseline count for outcome portfolio sizing."
    - name: "favorable_outcome_count"
      expr: COUNT(CASE WHEN favorable_outcome_flag = TRUE THEN outcome_id END)
      comment: "Count of outcomes favorable to the client — numerator for win rate calculation."
    - name: "favorable_outcome_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN favorable_outcome_flag = TRUE THEN outcome_id END) / NULLIF(COUNT(outcome_id), 0), 2)
      comment: "Percentage of outcomes favorable to the client — primary litigation performance KPI used in business development, client reporting, and partner evaluations."
    - name: "total_damages_awarded"
      expr: SUM(CAST(damages_awarded_amount AS DOUBLE))
      comment: "Total damages awarded across all outcomes — measures financial recovery performance for the client portfolio."
    - name: "avg_damages_awarded"
      expr: AVG(CAST(damages_awarded_amount AS DOUBLE))
      comment: "Average damages awarded per outcome — used to benchmark recovery effectiveness and set client expectations."
    - name: "total_transaction_value"
      expr: SUM(CAST(transaction_value_amount AS DOUBLE))
      comment: "Total transaction value across all transactional matter outcomes — measures deal value delivered to clients."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN outcome_id END) / NULLIF(COUNT(outcome_id), 0), 2)
      comment: "Percentage of outcomes that were appealed — high appeal rates may indicate unfavorable outcomes or aggressive opposing counsel strategies."
    - name: "contingent_fee_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contingent_fee_triggered_flag = TRUE THEN outcome_id END) / NULLIF(COUNT(outcome_id), 0), 2)
      comment: "Percentage of outcomes that triggered a contingency fee — used for contingency revenue forecasting and fee arrangement performance analysis."
    - name: "enforcement_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enforcement_action_required_flag = TRUE THEN outcome_id END) / NULLIF(COUNT(outcome_id), 0), 2)
      comment: "Percentage of outcomes requiring enforcement action — measures post-judgment collection risk and opposing party compliance."
    - name: "distinct_matters_resolved"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with a recorded outcome — measures matter resolution throughput."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_hearing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hearing scheduling and outcome metrics tracking continuance rates, ruling issuance, and virtual appearance adoption. Used by litigation managers and court operations teams to optimize court scheduling and monitor judicial outcomes."
  source: "`legal_ecm`.`matter`.`hearing`"
  dimensions:
    - name: "hearing_type"
      expr: hearing_type
      comment: "Type of hearing (e.g., Motion, Trial, Status Conference, Arbitration) — primary dimension for hearing portfolio analysis."
    - name: "hearing_status"
      expr: hearing_status
      comment: "Current status of the hearing (e.g., Scheduled, Completed, Continued, Cancelled) — used to monitor hearing pipeline health."
    - name: "appearance_type"
      expr: appearance_type
      comment: "Type of appearance (e.g., In-Person, Virtual, Telephonic) — used to track virtual appearance adoption and court technology utilization."
    - name: "continuance_flag"
      expr: continuance_flag
      comment: "Whether the hearing was continued — used to measure continuance rates and scheduling efficiency."
    - name: "ruling_issued_flag"
      expr: ruling_issued_flag
      comment: "Whether a ruling was issued at the hearing — used to track judicial decision velocity."
    - name: "adr_proceeding_flag"
      expr: adr_proceeding_flag
      comment: "Whether the hearing is part of an ADR proceeding — used to segment court vs. ADR hearing analytics."
    - name: "client_attendance_flag"
      expr: client_attendance_flag
      comment: "Whether the client attended the hearing — used to measure client engagement and manage attendance logistics."
    - name: "transcript_available_flag"
      expr: transcript_available_flag
      comment: "Whether a transcript is available for the hearing — used to track record-keeping completeness."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the hearing is scheduled — used for court calendar volume trending and resource planning."
    - name: "virtual_platform"
      expr: virtual_platform
      comment: "Virtual platform used for remote hearings (e.g., Zoom, Teams, CourtCall) — used to track technology adoption and vendor performance."
  measures:
    - name: "total_hearings"
      expr: COUNT(hearing_id)
      comment: "Total number of hearings across all matters — baseline count for court calendar sizing and resource planning."
    - name: "completed_hearings"
      expr: COUNT(CASE WHEN hearing_status = 'Completed' THEN hearing_id END)
      comment: "Count of completed hearings — used to measure court appearance throughput."
    - name: "continuance_count"
      expr: COUNT(CASE WHEN continuance_flag = TRUE THEN hearing_id END)
      comment: "Count of hearings that were continued — measures scheduling disruption and its impact on matter timelines."
    - name: "continuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN continuance_flag = TRUE THEN hearing_id END) / NULLIF(COUNT(hearing_id), 0), 2)
      comment: "Percentage of hearings that were continued — high rates indicate scheduling inefficiency or contested matters requiring management attention."
    - name: "ruling_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ruling_issued_flag = TRUE THEN hearing_id END) / NULLIF(COUNT(CASE WHEN hearing_status = 'Completed' THEN hearing_id END), 0), 2)
      comment: "Percentage of completed hearings resulting in a ruling — measures judicial decision velocity and matter progression efficiency."
    - name: "virtual_appearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appearance_type = 'Virtual' THEN hearing_id END) / NULLIF(COUNT(hearing_id), 0), 2)
      comment: "Percentage of hearings conducted virtually — tracks remote appearance adoption, which reduces travel costs and attorney time."
    - name: "transcript_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transcript_available_flag = TRUE THEN hearing_id END) / NULLIF(COUNT(CASE WHEN hearing_status = 'Completed' THEN hearing_id END), 0), 2)
      comment: "Percentage of completed hearings with an available transcript — measures record-keeping completeness for appellate preparation."
    - name: "distinct_matters_with_hearings"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one hearing — measures active litigation portfolio breadth."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Court filing compliance and cost metrics tracking deadline adherence, filing fees, and ECF adoption across all matter filings. Used by litigation operations and compliance teams to ensure timely, accurate court submissions."
  source: "`legal_ecm`.`matter`.`filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of court filing (e.g., Complaint, Motion, Brief, Answer) — primary dimension for filing portfolio analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g., Filed, Rejected, Pending) — used to monitor filing pipeline health and rejection rates."
    - name: "deadline_compliance_flag"
      expr: deadline_compliance_flag
      comment: "Whether the filing was submitted by the required deadline — primary compliance KPI dimension."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Whether the filing cost is billable to the client — used to separate billable from non-billable filing costs."
    - name: "expedited_flag"
      expr: expedited_flag
      comment: "Whether the filing was expedited — used to track emergency filing volume and associated premium costs."
    - name: "sealed_flag"
      expr: sealed_flag
      comment: "Whether the filing is sealed — used for confidentiality compliance monitoring."
    - name: "service_method"
      expr: service_method
      comment: "Method used to serve the filing (e.g., ECF, Mail, Personal Service) — used to track service method adoption and compliance."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the filing was submitted — used for filing volume trending and workload forecasting."
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency of the filing fee — used for multi-currency cost analysis."
  measures:
    - name: "total_filings"
      expr: COUNT(filing_id)
      comment: "Total number of court filings across all matters — baseline count for filing operations sizing."
    - name: "deadline_compliant_filings"
      expr: COUNT(CASE WHEN deadline_compliance_flag = TRUE THEN filing_id END)
      comment: "Count of filings submitted by the required deadline — numerator for filing compliance rate."
    - name: "filing_deadline_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deadline_compliance_flag = TRUE THEN filing_id END) / NULLIF(COUNT(filing_id), 0), 2)
      comment: "Percentage of filings submitted by the required deadline — critical compliance KPI; missed filing deadlines can result in case dismissal or sanctions."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN filing_id END)
      comment: "Count of rejected filings — measures filing quality and court compliance; high rejection rates indicate process or formatting issues."
    - name: "filing_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_status = 'Rejected' THEN filing_id END) / NULLIF(COUNT(filing_id), 0), 2)
      comment: "Percentage of filings rejected by the court — used to identify systemic filing quality issues requiring process improvement."
    - name: "total_filing_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total court filing fees paid across all filings — used for cost recovery analysis and client billing reconciliation."
    - name: "avg_filing_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average filing fee per submission — used to benchmark filing costs and validate client disbursement billing."
    - name: "expedited_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedited_flag = TRUE THEN filing_id END) / NULLIF(COUNT(filing_id), 0), 2)
      comment: "Percentage of filings submitted on an expedited basis — high rates indicate deadline management issues or reactive litigation posture."
    - name: "distinct_matters_with_filings"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one court filing — measures active litigation portfolio breadth."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_judgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Judgment financial and enforcement metrics tracking award amounts, appeal activity, and satisfaction rates across all court judgments. Used by litigation leadership and finance to manage post-judgment recovery and assess litigation financial outcomes."
  source: "`legal_ecm`.`matter`.`judgment`"
  dimensions:
    - name: "judgment_type"
      expr: judgment_type
      comment: "Type of judgment (e.g., Default, Consent, Summary, Final) — used to segment judgment portfolio by legal mechanism."
    - name: "judgment_status"
      expr: judgment_status
      comment: "Current status of the judgment (e.g., Entered, Satisfied, Under Appeal, Enforced) — used to monitor post-judgment lifecycle."
    - name: "for_client"
      expr: for_client
      comment: "Boolean indicating whether the judgment was in favor of the client — primary win/loss dimension for judgment analytics."
    - name: "prevailing_party"
      expr: prevailing_party
      comment: "Party that prevailed in the judgment — used for win rate analysis by practice area and jurisdiction."
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Status of judgment enforcement (e.g., Pending, Active, Completed) — used to track post-judgment collection effectiveness."
    - name: "final_judgment_flag"
      expr: final_judgment_flag
      comment: "Whether the judgment is final — used to filter actionable judgments from interlocutory orders."
    - name: "injunctive_relief_flag"
      expr: injunctive_relief_flag
      comment: "Whether the judgment includes injunctive relief — used to track non-monetary remedies and compliance obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the judgment amount — used for multi-currency financial analysis."
    - name: "entry_date_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month the judgment was entered — used for judgment volume trending and financial forecasting."
    - name: "lien_filed_flag"
      expr: lien_filed_flag
      comment: "Whether a lien was filed to enforce the judgment — used to track enforcement action intensity."
  measures:
    - name: "total_judgments"
      expr: COUNT(judgment_id)
      comment: "Total number of judgments across all matters — baseline count for judgment portfolio sizing."
    - name: "favorable_judgment_count"
      expr: COUNT(CASE WHEN for_client = TRUE THEN judgment_id END)
      comment: "Count of judgments in favor of the client — numerator for judgment win rate calculation."
    - name: "judgment_win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN for_client = TRUE THEN judgment_id END) / NULLIF(COUNT(judgment_id), 0), 2)
      comment: "Percentage of judgments in favor of the client — primary litigation performance KPI used in business development and partner evaluations."
    - name: "total_judgment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of all judgments — measures aggregate financial outcome of litigation portfolio."
    - name: "avg_judgment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average judgment amount — used to benchmark case value and set litigation strategy thresholds."
    - name: "total_attorney_fees_awarded"
      expr: SUM(CAST(attorney_fees_awarded AS DOUBLE))
      comment: "Total attorney fees awarded by courts — measures fee-shifting outcomes and their impact on client net recovery."
    - name: "total_cost_awards"
      expr: SUM(CAST(cost_award_amount AS DOUBLE))
      comment: "Total cost awards across all judgments — used to track litigation cost recovery for clients."
    - name: "satisfied_judgment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN satisfaction_date IS NOT NULL THEN judgment_id END) / NULLIF(COUNT(CASE WHEN for_client = TRUE THEN judgment_id END), 0), 2)
      comment: "Percentage of favorable judgments that have been satisfied (collected) — measures post-judgment enforcement effectiveness and actual financial recovery."
    - name: "appeal_filed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN judgment_id END) / NULLIF(COUNT(judgment_id), 0), 2)
      comment: "Percentage of judgments that were appealed — used to assess litigation finality and continued exposure risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`matter_docket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Litigation docket portfolio metrics tracking case complexity, estimated value, and scheduling across all active court dockets. Used by litigation leadership to manage court calendar, assess financial exposure, and prioritize high-value cases."
  source: "`legal_ecm`.`matter`.`docket`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the docket case (e.g., Active, Closed, Stayed) — primary dimension for active litigation portfolio monitoring."
    - name: "case_type"
      expr: case_type
      comment: "Type of case (e.g., Civil, Criminal, Arbitration) — used to segment docket portfolio by legal proceeding type."
    - name: "case_subtype"
      expr: case_subtype
      comment: "Sub-classification of the case type — used for granular practice area reporting."
    - name: "case_complexity_level"
      expr: case_complexity_level
      comment: "Complexity rating of the case — used to allocate senior resources to high-complexity matters."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current appeal status of the case — used to track appellate workload and continued litigation exposure."
    - name: "venue"
      expr: venue
      comment: "Court venue where the case is filed — used for venue-level workload and outcome analysis."
    - name: "adr_proceeding_type"
      expr: adr_proceeding_type
      comment: "Type of ADR proceeding if applicable — used to segment court vs. ADR docket analytics."
    - name: "case_value_currency"
      expr: case_value_currency
      comment: "Currency of the estimated case value — used for multi-currency financial exposure analysis."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month the case was filed — used for new case intake volume trending."
    - name: "ecf_registration_status"
      expr: ecf_registration_status
      comment: "ECF registration status for the docket — used to ensure electronic filing compliance."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the docket — used for access governance and sensitive matter reporting."
  measures:
    - name: "total_dockets"
      expr: COUNT(docket_id)
      comment: "Total number of dockets across all matters — baseline count for litigation portfolio sizing."
    - name: "active_dockets"
      expr: COUNT(CASE WHEN is_active = TRUE THEN docket_id END)
      comment: "Count of currently active dockets — measures active litigation workload and court calendar exposure."
    - name: "total_estimated_case_value"
      expr: SUM(CAST(estimated_case_value AS DOUBLE))
      comment: "Total estimated financial value across all active dockets — measures aggregate litigation financial exposure for risk management and insurance purposes."
    - name: "avg_estimated_case_value"
      expr: AVG(CAST(estimated_case_value AS DOUBLE))
      comment: "Average estimated case value per docket — used to benchmark case significance and prioritize resource allocation."
    - name: "cases_with_trial_date"
      expr: COUNT(CASE WHEN trial_date IS NOT NULL THEN docket_id END)
      comment: "Count of dockets with a scheduled trial date — used for trial calendar management and resource planning."
    - name: "trial_scheduling_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trial_date IS NOT NULL THEN docket_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN docket_id END), 0), 2)
      comment: "Percentage of active dockets with a scheduled trial date — measures litigation progression and trial readiness across the portfolio."
    - name: "cases_under_appeal"
      expr: COUNT(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN docket_id END)
      comment: "Count of dockets with an active appeal status — measures appellate workload and continued litigation exposure."
    - name: "distinct_clients_in_litigation"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct clients with active dockets — measures client litigation portfolio breadth and concentration."
    - name: "avg_days_to_case_close"
      expr: AVG(CAST(DATEDIFF(case_closed_date, filing_date) AS DOUBLE))
      comment: "Average number of days from case filing to closure — measures litigation cycle time efficiency and court system throughput."
$$;