-- Metric views for domain: joborder | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core job order KPIs tracking open requisition volume, rate economics, fill performance, and order mix. Primary steering dashboard for delivery operations and account management."
  source: "`staffing_hr_ecm_v1`.`joborder`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the job order (e.g. Open, Filled, Cancelled, On Hold). Primary filter for pipeline vs. closed analysis."
    - name: "position_type"
      expr: position_type
      comment: "Type of position being filled (e.g. Temporary, Contract, Direct Hire, Temp-to-Perm). Drives revenue model and fulfillment strategy."
    - name: "employment_classification"
      expr: employment_classification
      comment: "Worker classification on the order (e.g. W2, 1099, Corp-to-Corp). Critical for compliance and margin analysis."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Remote, on-site, or hybrid designation. Used to segment demand trends and sourcing strategy."
    - name: "priority_level"
      expr: priority_level
      comment: "Client-assigned urgency tier for the order. Drives SLA prioritization and recruiter workload allocation."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift schedule for the position (e.g. Day, Night, Rotating). Affects candidate pool size and sourcing difficulty."
    - name: "is_temp_to_perm"
      expr: is_temp_to_perm
      comment: "Flag indicating whether the order has a temp-to-perm conversion pathway. Key for tracking conversion pipeline value."
    - name: "is_backfill"
      expr: is_backfill
      comment: "Indicates whether the order is a backfill for a departing worker. Signals client retention risk and attrition patterns."
    - name: "intake_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month the order was received. Used for demand trend analysis and recruiter capacity planning."
    - name: "target_start_month"
      expr: DATE_TRUNC('MONTH', target_start_date)
      comment: "Month the client needs the worker to start. Used for forward-looking pipeline and delivery forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order rates. Required for multi-currency revenue normalization."
    - name: "originating_source"
      expr: originating_source
      comment: "Channel or system that originated the order (e.g. VMS, Direct, Portal). Informs channel mix and cost-of-acquisition analysis."
  measures:
    - name: "total_open_orders"
      expr: COUNT(CASE WHEN order_status = 'Open' THEN order_header_id END)
      comment: "Count of currently open job orders. Primary pipeline volume KPI for delivery capacity planning and recruiter workload management."
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total job orders in scope. Baseline volume metric for demand trend analysis and period-over-period comparison."
    - name: "total_headcount_target"
      expr: COUNT(CASE WHEN headcount_target IS NOT NULL THEN order_header_id END)
      comment: "Count of orders with a defined headcount target. Proxy for total workforce demand volume when numeric headcount is unavailable."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average standard bill rate across orders. Tracks pricing trends and rate competitiveness versus market benchmarks."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across orders. Used alongside bill rate to monitor spread and margin health at the order level."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across orders. Direct indicator of gross margin positioning and pricing discipline."
    - name: "avg_ot_bill_rate"
      expr: AVG(CAST(ot_bill_rate AS DOUBLE))
      comment: "Average overtime bill rate. Monitors OT pricing consistency and revenue uplift from overtime-heavy engagements."
    - name: "avg_hours_per_week"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average contracted hours per week across orders. Drives revenue run-rate estimation and worker utilization benchmarking."
    - name: "avg_conversion_fee"
      expr: AVG(CAST(conversion_fee AS DOUBLE))
      comment: "Average temp-to-perm conversion fee on orders. Tracks direct-hire revenue opportunity embedded in the contingent workforce pipeline."
    - name: "total_conversion_fee_potential"
      expr: SUM(CAST(conversion_fee AS DOUBLE))
      comment: "Total potential conversion fee revenue across all temp-to-perm orders. Strategic KPI for direct-hire revenue forecasting."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem allowance on orders. Tracks reimbursable cost exposure and its impact on total bill economics."
    - name: "bgc_required_order_count"
      expr: COUNT(CASE WHEN bgc_required = TRUE THEN order_header_id END)
      comment: "Number of orders requiring background checks. Drives compliance workload estimation and onboarding cycle time planning."
    - name: "drug_screen_required_order_count"
      expr: COUNT(CASE WHEN drug_screen_required = TRUE THEN order_header_id END)
      comment: "Number of orders requiring drug screening. Informs pre-employment compliance cost and time-to-fill risk."
    - name: "temp_to_perm_order_count"
      expr: COUNT(CASE WHEN is_temp_to_perm = TRUE THEN order_header_id END)
      comment: "Count of orders with a temp-to-perm conversion pathway. Tracks the direct-hire conversion pipeline volume."
    - name: "temp_to_perm_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_temp_to_perm = TRUE THEN order_header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders designated as temp-to-perm. Strategic KPI for measuring direct-hire pipeline penetration and revenue diversification."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_fulfillment_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier and recruiter fulfillment performance metrics covering assignment activity, commission economics, workload distribution, and sourcing effectiveness. Used by delivery leadership to manage vendor performance and internal team productivity."
  source: "`staffing_hr_ecm_v1`.`joborder`.`fulfillment_team`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the fulfillment assignment (e.g. Active, Completed, Cancelled). Primary filter for active vs. historical performance analysis."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the fulfillment team member (e.g. Primary Recruiter, Account Manager, Sourcer). Enables performance benchmarking by function."
    - name: "assignment_priority"
      expr: assignment_priority
      comment: "Priority tier assigned to this fulfillment engagement. Used to assess whether high-priority orders receive proportionally more resources."
    - name: "sourcing_channel_focus"
      expr: sourcing_channel_focus
      comment: "Primary sourcing channel the team member is leveraging (e.g. Job Boards, Referrals, Internal Database). Informs channel effectiveness analysis."
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Business reason for the fulfillment assignment. Supports root-cause analysis of reassignments and escalations."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Qualitative performance rating for the fulfillment team member on this assignment. Drives talent development and vendor scorecard inputs."
    - name: "primary_assignment_flag"
      expr: primary_assignment_flag
      comment: "Indicates whether this is the primary fulfillment assignment for the order. Separates lead-recruiter metrics from support-role metrics."
    - name: "commission_eligible_flag"
      expr: commission_eligible_flag
      comment: "Whether the assignment is eligible for commission. Used to segment incentivized vs. non-incentivized fulfillment activity."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the fulfillment assignment started. Used for cohort analysis of recruiter ramp and seasonal demand patterns."
    - name: "assignment_end_month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
      comment: "Month the fulfillment assignment ended. Used for tenure and completion rate analysis."
  measures:
    - name: "total_fulfillment_assignments"
      expr: COUNT(1)
      comment: "Total fulfillment team assignments. Baseline volume metric for recruiter and supplier workload analysis."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN fulfillment_team_id END)
      comment: "Count of currently active fulfillment assignments. Real-time workload indicator for delivery capacity management."
    - name: "avg_commission_split_percentage"
      expr: AVG(CAST(commission_split_percentage AS DOUBLE))
      comment: "Average commission split percentage across fulfillment assignments. Tracks incentive cost distribution and fairness of commission allocation."
    - name: "avg_workload_weight"
      expr: AVG(CAST(workload_weight AS DOUBLE))
      comment: "Average workload weight assigned to fulfillment team members. Monitors workload balance and identifies over- or under-utilized recruiters."
    - name: "total_workload_weight"
      expr: SUM(CAST(workload_weight AS DOUBLE))
      comment: "Total workload weight across all fulfillment assignments. Used to assess aggregate team capacity consumption."
    - name: "commission_eligible_assignment_count"
      expr: COUNT(CASE WHEN commission_eligible_flag = TRUE THEN fulfillment_team_id END)
      comment: "Number of assignments eligible for commission. Drives incentive cost forecasting and compensation planning."
    - name: "primary_assignment_count"
      expr: COUNT(CASE WHEN primary_assignment_flag = TRUE THEN fulfillment_team_id END)
      comment: "Count of primary (lead) fulfillment assignments. Measures direct recruiter accountability and ownership across the order pipeline."
    - name: "client_authorized_assignment_count"
      expr: COUNT(CASE WHEN client_contact_authorized_flag = TRUE THEN fulfillment_team_id END)
      comment: "Number of assignments explicitly authorized by the client contact. Tracks client engagement and approval compliance in the fulfillment process."
    - name: "unique_orders_covered"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct job orders covered by fulfillment team assignments. Measures breadth of delivery team engagement across the order pipeline."
    - name: "unique_suppliers_engaged"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers engaged in fulfillment. Tracks supplier diversity and concentration risk in the delivery model."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning KPIs covering budget utilization, headcount targets, rate economics, and plan approval health. Used by workforce planning teams and finance to govern labor demand and budget adherence."
  source: "`staffing_hr_ecm_v1`.`joborder`.`headcount_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the headcount plan (e.g. Draft, Approved, Closed). Primary filter for active planning pipeline."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of headcount plan (e.g. Annual, Quarterly, Ad Hoc). Enables comparison of structured vs. reactive workforce planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the plan. Tracks governance compliance and bottlenecks in the headcount authorization process."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type targeted by the plan (e.g. Temporary, Permanent, Contract). Drives workforce mix strategy analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the headcount plan. Enables year-over-year budget and demand trend comparison."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the headcount plan. Used to triage resource allocation when budget is constrained."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Remote, on-site, or hybrid designation for planned headcount. Tracks evolution of flexible work demand."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for planned positions (e.g. W2, 1099). Critical for compliance cost modeling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the plan budget. Required for multi-currency budget consolidation."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Start month of the planning period. Used for demand forecasting and capacity planning timelines."
    - name: "is_active"
      expr: is_active
      comment: "Whether the headcount plan is currently active. Filters live plans from historical or superseded versions."
    - name: "supplier_diversity_requirement"
      expr: supplier_diversity_requirement
      comment: "Supplier diversity mandate associated with the plan. Tracks compliance with diversity sourcing commitments."
  measures:
    - name: "total_headcount_plans"
      expr: COUNT(1)
      comment: "Total headcount plans in scope. Baseline volume metric for workforce planning activity."
    - name: "approved_headcount_plans"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN headcount_plan_id END)
      comment: "Number of headcount plans that have received formal approval. Tracks governance throughput and planning cycle efficiency."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted labor spend across all headcount plans. Primary financial KPI for workforce cost governance and budget utilization tracking."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per headcount plan. Benchmarks plan sizing and identifies outlier engagements requiring additional scrutiny."
    - name: "avg_target_bill_rate"
      expr: AVG(CAST(target_bill_rate AS DOUBLE))
      comment: "Average target bill rate across headcount plans. Tracks planned pricing versus actual order rates to identify rate drift."
    - name: "avg_target_pay_rate"
      expr: AVG(CAST(target_pay_rate AS DOUBLE))
      comment: "Average target pay rate across headcount plans. Used to assess labor cost assumptions in workforce planning models."
    - name: "avg_target_markup_percentage"
      expr: AVG(CAST(target_markup_percentage AS DOUBLE))
      comment: "Average planned markup percentage. Tracks margin targets set at planning stage versus actuals at order execution."
    - name: "avg_target_gross_margin_percentage"
      expr: AVG(CAST(target_gross_margin_percentage AS DOUBLE))
      comment: "Average target gross margin percentage across plans. Strategic KPI for finance to validate that planned engagements meet margin thresholds."
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average FTE equivalency percentage across headcount plans. Used to convert contingent headcount into FTE-equivalent demand for capacity modeling."
    - name: "avg_hours_per_week"
      expr: AVG(CAST(hours_per_week AS DOUBLE))
      comment: "Average planned hours per week. Drives total labor hour demand estimation and cost modeling."
    - name: "total_planned_budget"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget amount for approved headcount plans only. Represents committed workforce spend for financial forecasting."
    - name: "plan_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN headcount_plan_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of headcount plans that have been approved. Measures planning governance efficiency and identifies bottlenecks in the approval workflow."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_order_extension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment extension KPIs tracking extension volume, rate changes, revenue impact, and approval compliance. Used by account management and finance to monitor workforce tenure, rate renegotiation trends, and extension-driven revenue."
  source: "`staffing_hr_ecm_v1`.`joborder`.`order_extension`"
  dimensions:
    - name: "extension_status"
      expr: extension_status
      comment: "Current status of the extension request (e.g. Pending, Approved, Rejected). Primary filter for active vs. resolved extension pipeline."
    - name: "extension_reason"
      expr: extension_reason
      comment: "Business reason for the extension (e.g. Project Delay, Client Request, Performance). Informs root-cause analysis of workforce tenure patterns."
    - name: "rate_change_indicator"
      expr: rate_change_indicator
      comment: "Flag indicating whether the extension includes a rate change. Critical for margin impact analysis and rate renegotiation tracking."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate structure for the extension (e.g. Hourly, Daily, Fixed). Affects revenue recognition and billing model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the extension rates. Required for multi-currency revenue consolidation."
    - name: "approval_required"
      expr: approval_required
      comment: "Whether formal approval is required for this extension. Tracks governance compliance in the extension process."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Whether client-side approval is required. Monitors client engagement in extension governance."
    - name: "temp_to_perm_conversion_reset"
      expr: temp_to_perm_conversion_reset
      comment: "Flag indicating whether the extension resets the temp-to-perm conversion clock. Tracks impact on direct-hire conversion pipeline."
    - name: "extension_request_month"
      expr: DATE_TRUNC('MONTH', extension_request_date)
      comment: "Month the extension was requested. Used for trend analysis of extension demand and workforce tenure patterns."
    - name: "extension_start_month"
      expr: DATE_TRUNC('MONTH', extension_start_date)
      comment: "Month the extension period begins. Used for forward-looking revenue and headcount forecasting."
  measures:
    - name: "total_extensions"
      expr: COUNT(1)
      comment: "Total order extensions processed. Baseline volume metric for workforce tenure and extension activity analysis."
    - name: "approved_extensions"
      expr: COUNT(CASE WHEN extension_status = 'Approved' THEN order_extension_id END)
      comment: "Number of approved extensions. Tracks successful extension throughput and client satisfaction with extended engagements."
    - name: "extension_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_status = 'Approved' THEN order_extension_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of extension requests that are approved. Measures client retention effectiveness and the health of the extended workforce pipeline."
    - name: "rate_change_extension_count"
      expr: COUNT(CASE WHEN rate_change_indicator = TRUE THEN order_extension_id END)
      comment: "Number of extensions that include a rate change. Tracks rate renegotiation frequency and its potential margin impact."
    - name: "avg_extended_bill_rate"
      expr: AVG(CAST(extended_bill_rate AS DOUBLE))
      comment: "Average bill rate on extended assignments. Compared against original bill rate to measure rate drift over assignment tenure."
    - name: "avg_original_bill_rate"
      expr: AVG(CAST(original_bill_rate AS DOUBLE))
      comment: "Average original bill rate at assignment start. Baseline for measuring rate change impact across extensions."
    - name: "avg_extended_markup_percentage"
      expr: AVG(CAST(extended_markup_percentage AS DOUBLE))
      comment: "Average markup percentage on extended assignments. Tracks margin evolution over the assignment lifecycle."
    - name: "avg_extended_spread"
      expr: AVG(CAST(extended_spread AS DOUBLE))
      comment: "Average bill-pay spread on extended assignments. Direct measure of gross profit per hour on extended workforce."
    - name: "total_projected_revenue_impact"
      expr: SUM(CAST(projected_revenue_impact AS DOUBLE))
      comment: "Total projected revenue impact from all extensions. Strategic KPI for revenue forecasting and account growth planning."
    - name: "avg_extension_duration_weeks"
      expr: AVG(CAST(extension_duration_weeks AS DOUBLE))
      comment: "Average duration of extensions in weeks. Measures workforce tenure extension length and informs long-term placement revenue modeling."
    - name: "total_revenue_impact_approved"
      expr: SUM(CASE WHEN extension_status = 'Approved' THEN CAST(projected_revenue_impact AS DOUBLE) ELSE 0 END)
      comment: "Total projected revenue impact from approved extensions only. Represents committed incremental revenue from workforce tenure extensions."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_sla_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA governance KPIs tracking fill rate targets, submittal performance commitments, interview-to-offer ratios, and penalty exposure. Used by program management and vendor governance teams to enforce contractual service levels."
  source: "`staffing_hr_ecm_v1`.`joborder`.`sla_commitment`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA commitment (e.g. Active, Expired, Waived). Primary filter for live vs. historical SLA analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the SLA commitment is currently active. Separates enforceable commitments from expired or superseded ones."
    - name: "exclusive_submittal_period_flag"
      expr: exclusive_submittal_period_flag
      comment: "Whether the SLA includes an exclusive submittal window for preferred suppliers. Tracks preferred supplier program compliance."
    - name: "rtr_enforcement_flag"
      expr: rtr_enforcement_flag
      comment: "Whether Right-to-Represent enforcement is active on this SLA. Critical compliance flag for candidate ownership disputes."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether an SLA waiver has been granted. Tracks exceptions to standard service level commitments."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the SLA auto-renews. Informs contract management and renewal pipeline planning."
    - name: "penalty_breach_fee_currency"
      expr: penalty_breach_fee_currency
      comment: "Currency of the breach penalty fee. Required for multi-currency penalty exposure consolidation."
    - name: "sla_effective_month"
      expr: DATE_TRUNC('MONTH', sla_effective_date)
      comment: "Month the SLA became effective. Used for cohort analysis of SLA vintage and performance over time."
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "How SLA performance is measured (e.g. Calendar Days, Business Days). Affects comparability of SLA metrics across programs."
  measures:
    - name: "total_sla_commitments"
      expr: COUNT(1)
      comment: "Total SLA commitments in scope. Baseline volume metric for SLA governance coverage analysis."
    - name: "active_sla_commitments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN sla_commitment_id END)
      comment: "Number of currently active SLA commitments. Measures the scope of enforceable service level obligations."
    - name: "avg_fill_rate_target_percentage"
      expr: AVG(CAST(fill_rate_target_percentage AS DOUBLE))
      comment: "Average fill rate target across SLA commitments. Benchmarks the contractual fill performance standard the organization is held to."
    - name: "avg_interview_to_offer_ratio_target"
      expr: AVG(CAST(interview_to_offer_ratio_target AS DOUBLE))
      comment: "Average interview-to-offer ratio target. Tracks quality-of-submittal commitments and candidate screening effectiveness standards."
    - name: "avg_qos_minimum_score"
      expr: AVG(CAST(qos_minimum_score AS DOUBLE))
      comment: "Average quality-of-service minimum score threshold across SLA commitments. Monitors the contractual quality floor for supplier performance."
    - name: "total_penalty_breach_fee_exposure"
      expr: SUM(CAST(penalty_breach_fee_amount AS DOUBLE))
      comment: "Total financial exposure from SLA breach penalties across all active commitments. Critical risk KPI for contract management and financial planning."
    - name: "avg_penalty_breach_fee_amount"
      expr: AVG(CAST(penalty_breach_fee_amount AS DOUBLE))
      comment: "Average breach penalty fee per SLA commitment. Benchmarks penalty severity and informs risk-weighted SLA prioritization."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN sla_commitment_id END)
      comment: "Number of SLA commitments with an approved waiver. Tracks exception frequency and governance discipline in SLA enforcement."
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN sla_commitment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA commitments that have received a waiver. High waiver rates signal systemic delivery challenges or overly aggressive SLA targets."
    - name: "exclusive_submittal_period_count"
      expr: COUNT(CASE WHEN exclusive_submittal_period_flag = TRUE THEN sla_commitment_id END)
      comment: "Number of SLA commitments with exclusive submittal periods. Tracks preferred supplier program utilization and its impact on competitive sourcing."
    - name: "unique_orders_under_sla"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct job orders covered by SLA commitments. Measures SLA governance coverage across the active order pipeline."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order lifecycle event KPIs tracking status transition velocity, SLA breach rates, escalation frequency, and fill progress. Used by operations and delivery leadership to monitor order health and identify systemic fulfillment bottlenecks."
  source: "`staffing_hr_ecm_v1`.`joborder`.`order_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "The status the order transitioned into. Used to analyze flow rates between lifecycle stages."
    - name: "previous_status"
      expr: previous_status
      comment: "The status before the transition. Combined with new_status to analyze specific transition patterns and bottlenecks."
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event that triggered the status change. Categorizes transitions for funnel and process analysis."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Business milestone associated with the status event (e.g. First Submittal, Interview Scheduled, Offer Extended). Tracks key fulfillment milestones."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether this status event represents an SLA breach. Primary flag for SLA compliance monitoring."
    - name: "sla_breach_severity"
      expr: sla_breach_severity
      comment: "Severity level of the SLA breach. Enables prioritized escalation and remediation of the most critical compliance failures."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether this event triggered an escalation. Tracks escalation frequency as a proxy for delivery quality issues."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level at which the escalation was raised (e.g. Team Lead, Director, Executive). Measures severity of delivery failures."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the status transition. Enables structured root-cause analysis of delays, cancellations, and escalations."
    - name: "triggering_system"
      expr: triggering_system
      comment: "System that triggered the status event (e.g. VMS, ATS, Manual). Tracks automation coverage and manual intervention rates."
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the status transition. Used for trend analysis of order lifecycle velocity and SLA breach patterns."
    - name: "is_active"
      expr: is_active
      comment: "Whether this is the current active status record for the order. Filters to latest state for point-in-time pipeline analysis."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total order status transition events. Baseline volume metric for order lifecycle activity and process throughput analysis."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN order_status_history_id END)
      comment: "Number of status events that represent SLA breaches. Primary KPI for contractual compliance monitoring and vendor accountability."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN order_status_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status events that are SLA breaches. Strategic KPI for delivery quality — high rates trigger vendor performance reviews and contract renegotiation."
    - name: "escalation_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN order_status_history_id END)
      comment: "Number of escalated status events. Tracks delivery failure frequency and the operational burden of exception management."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN order_status_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status events that trigger escalations. Measures systemic delivery quality — high escalation rates indicate structural fulfillment problems."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN order_status_history_id END)
      comment: "Number of status events where notifications were sent. Tracks stakeholder communication compliance and automation coverage."
    - name: "notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN order_status_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status events where required notifications were sent. Measures process automation and stakeholder communication discipline."
    - name: "unique_orders_with_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN order_header_id END)
      comment: "Number of distinct orders that have experienced at least one SLA breach. Measures breadth of SLA compliance failures across the order portfolio."
    - name: "unique_orders_tracked"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders with status history records. Measures lifecycle tracking coverage across the order pipeline."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_rate_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate override KPIs tracking pricing exception volume, margin impact of overrides, and approval compliance. Used by pricing governance, finance, and account management to control rate discipline and protect gross margin."
  source: "`staffing_hr_ecm_v1`.`joborder`.`rate_override`"
  dimensions:
    - name: "override_status"
      expr: override_status
      comment: "Current status of the rate override (e.g. Pending, Approved, Rejected). Primary filter for active vs. resolved override pipeline."
    - name: "override_reason"
      expr: override_reason
      comment: "Business justification for the rate override. Enables root-cause analysis of pricing exceptions and identification of systemic rate pressure."
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the override rate (e.g. Client Negotiation, Market Survey, Contract Amendment). Tracks the origin of pricing exceptions."
    - name: "rate_unit"
      expr: rate_unit
      comment: "Unit of the rate (e.g. Hourly, Daily, Weekly). Ensures rate comparisons are made on a consistent basis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the override rates. Required for multi-currency margin analysis."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Whether client approval is required for this override. Tracks governance compliance in the rate exception process."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rate override becomes effective. Used for trend analysis of pricing exception timing and volume."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the override was approved. Used to measure approval cycle time and governance throughput."
  measures:
    - name: "total_rate_overrides"
      expr: COUNT(1)
      comment: "Total rate overrides processed. Baseline volume metric for pricing exception frequency and governance workload."
    - name: "approved_rate_overrides"
      expr: COUNT(CASE WHEN override_status = 'Approved' THEN rate_override_id END)
      comment: "Number of approved rate overrides. Tracks pricing exception approval throughput and governance compliance."
    - name: "override_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_status = 'Approved' THEN rate_override_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate overrides that are approved. High approval rates may indicate weak pricing governance; low rates may signal overly rigid pricing policies."
    - name: "avg_override_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate on overridden orders. Compared against standard rates to quantify the pricing concession being granted."
    - name: "avg_override_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on rate overrides. Tracks margin erosion from pricing exceptions."
    - name: "avg_override_gross_margin_percentage"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage on overridden rates. Primary margin health KPI for pricing governance — identifies overrides that breach minimum margin thresholds."
    - name: "avg_override_spread"
      expr: AVG(CAST(spread AS DOUBLE))
      comment: "Average bill-pay spread on rate overrides. Measures gross profit per hour on exception-priced engagements."
    - name: "avg_burden_rate"
      expr: AVG(CAST(burden_rate AS DOUBLE))
      comment: "Average burden rate on overridden assignments. Tracks employer cost load and its impact on true margin on exception-priced work."
    - name: "avg_per_diem_allowance"
      expr: AVG(CAST(per_diem_allowance AS DOUBLE))
      comment: "Average per diem allowance on rate overrides. Monitors reimbursable cost exposure on exception-priced engagements."
    - name: "unique_orders_with_overrides"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Number of distinct orders with rate overrides. Measures the breadth of pricing exception exposure across the order portfolio."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_vms_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VMS program KPIs tracking order distribution, submittal activity, rate cap compliance, and supplier tier performance. Used by MSP/VMS program managers to govern vendor-managed staffing programs and optimize supplier distribution strategies."
  source: "`staffing_hr_ecm_v1`.`joborder`.`vms_order`"
  dimensions:
    - name: "vms_order_status"
      expr: vms_order_status
      comment: "Current status of the VMS order (e.g. Open, Filled, Cancelled). Primary filter for active VMS pipeline analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the VMS order. Tracks governance compliance in the VMS order authorization workflow."
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Supplier tier designation on the VMS order. Enables performance analysis by preferred, secondary, and open-market supplier tiers."
    - name: "vms_platform_name"
      expr: vms_platform_name
      comment: "Name of the VMS platform (e.g. Fieldglass, Beeline, Coupa). Enables cross-platform performance benchmarking."
    - name: "msp_name"
      expr: msp_name
      comment: "Name of the Managed Service Provider overseeing the program. Used for MSP performance benchmarking and program governance."
    - name: "vms_client_name"
      expr: vms_client_name
      comment: "Client name as recorded in the VMS. Used for client-level VMS program performance analysis."
    - name: "vms_department_name"
      expr: vms_department_name
      comment: "Client department associated with the VMS order. Enables department-level demand and spend analysis within VMS programs."
    - name: "supplier_diversity_requirement"
      expr: supplier_diversity_requirement
      comment: "Supplier diversity mandate on the VMS order. Tracks compliance with diversity sourcing commitments in managed programs."
    - name: "auto_distribution_flag"
      expr: auto_distribution_flag
      comment: "Whether the order was automatically distributed to suppliers. Measures automation coverage in the VMS distribution process."
    - name: "rtr_required_flag"
      expr: rtr_required_flag
      comment: "Whether Right-to-Represent is required on this VMS order. Tracks RTR compliance exposure across the VMS program."
    - name: "sync_status"
      expr: sync_status
      comment: "Integration sync status between the VMS and internal systems. Monitors data quality and integration health."
    - name: "distribution_month"
      expr: DATE_TRUNC('MONTH', distribution_date)
      comment: "Month the order was distributed to suppliers. Used for demand trend analysis and supplier response time benchmarking."
  measures:
    - name: "total_vms_orders"
      expr: COUNT(1)
      comment: "Total VMS orders in scope. Baseline volume metric for VMS program demand analysis."
    - name: "open_vms_orders"
      expr: COUNT(CASE WHEN vms_order_status = 'Open' THEN vms_order_id END)
      comment: "Number of currently open VMS orders. Real-time pipeline volume KPI for VMS program capacity planning."
    - name: "auto_distributed_order_count"
      expr: COUNT(CASE WHEN auto_distribution_flag = TRUE THEN vms_order_id END)
      comment: "Number of orders automatically distributed to suppliers. Tracks VMS automation adoption and its impact on distribution speed."
    - name: "auto_distribution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_distribution_flag = TRUE THEN vms_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VMS orders distributed automatically. Measures process automation maturity in the VMS program — higher rates reduce manual effort and improve time-to-distribute."
    - name: "avg_vms_bill_rate_cap"
      expr: AVG(CAST(vms_bill_rate_cap AS DOUBLE))
      comment: "Average bill rate cap set in the VMS. Tracks pricing ceiling constraints and their impact on supplier participation and fill rates."
    - name: "avg_vms_pay_rate_cap"
      expr: AVG(CAST(vms_pay_rate_cap AS DOUBLE))
      comment: "Average pay rate cap set in the VMS. Monitors labor cost ceiling constraints and their impact on candidate quality and availability."
    - name: "avg_vms_markup_cap_percentage"
      expr: AVG(CAST(vms_markup_cap_percentage AS DOUBLE))
      comment: "Average markup cap percentage in the VMS. Tracks margin ceiling constraints imposed by the client program and their impact on profitability."
    - name: "rtr_required_order_count"
      expr: COUNT(CASE WHEN rtr_required_flag = TRUE THEN vms_order_id END)
      comment: "Number of VMS orders requiring Right-to-Represent. Tracks RTR compliance workload and candidate ownership risk exposure."
    - name: "unique_suppliers_in_vms"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers participating in VMS orders. Measures supplier network breadth and concentration risk in the VMS program."
    - name: "unique_programs_active"
      expr: COUNT(DISTINCT managed_program_id)
      comment: "Number of distinct managed programs with VMS orders. Tracks program portfolio breadth and diversification of VMS-managed business."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`joborder_job_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Job category market intelligence KPIs tracking rate benchmarks, demand levels, and workforce classification attributes. Used by pricing teams, recruiters, and workforce strategists to calibrate rates and sourcing strategies by skill category."
  source: "`staffing_hr_ecm_v1`.`joborder`.`job_category`"
  dimensions:
    - name: "category_type"
      expr: category_type
      comment: "High-level classification of the job category (e.g. IT, Healthcare, Engineering). Enables cross-category demand and rate benchmarking."
    - name: "job_family"
      expr: job_family
      comment: "Job family grouping within the category. Provides mid-level segmentation for workforce planning and rate analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level designation (e.g. Entry, Mid, Senior, Expert). Critical dimension for rate benchmarking and candidate sourcing strategy."
    - name: "market_demand_level"
      expr: market_demand_level
      comment: "Current market demand level for the category (e.g. High, Medium, Low). Informs sourcing investment prioritization and rate competitiveness."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for the category (e.g. W2, 1099, Corp-to-Corp). Affects compliance requirements and cost modeling."
    - name: "typical_employment_type"
      expr: typical_employment_type
      comment: "Most common employment type for this category. Used to align sourcing strategy with market norms."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt/non-exempt classification. Critical for overtime cost modeling and compliance risk assessment."
    - name: "remote_work_eligible"
      expr: remote_work_eligible
      comment: "Whether positions in this category are eligible for remote work. Tracks remote work demand trends by skill category."
    - name: "job_category_status"
      expr: job_category_status
      comment: "Active/inactive status of the job category. Filters to current categories for active rate and demand analysis."
    - name: "eeoc_job_category"
      expr: eeoc_job_category
      comment: "EEOC job category classification. Required for regulatory reporting and workforce diversity analysis."
  measures:
    - name: "total_job_categories"
      expr: COUNT(1)
      comment: "Total job categories defined. Baseline metric for taxonomy coverage and catalog completeness."
    - name: "avg_bill_rate"
      expr: AVG(CAST(average_bill_rate AS DOUBLE))
      comment: "Average market bill rate across job categories. Benchmarks pricing competitiveness and informs rate card development."
    - name: "avg_pay_rate"
      expr: AVG(CAST(average_pay_rate AS DOUBLE))
      comment: "Average market pay rate across job categories. Used to validate pay rate competitiveness and assess talent acquisition cost."
    - name: "avg_typical_markup_percentage"
      expr: AVG(CAST(typical_markup_percentage AS DOUBLE))
      comment: "Average typical markup percentage by job category. Benchmarks margin expectations and informs pricing strategy by skill segment."
    - name: "remote_eligible_category_count"
      expr: COUNT(CASE WHEN remote_work_eligible = TRUE THEN job_category_id END)
      comment: "Number of job categories eligible for remote work. Tracks the breadth of remote-capable talent supply and informs flexible workforce strategy."
    - name: "remote_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remote_work_eligible = TRUE THEN job_category_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of job categories eligible for remote work. Strategic KPI for workforce flexibility strategy and geographic sourcing expansion."
    - name: "prevailing_wage_applicable_count"
      expr: COUNT(CASE WHEN prevailing_wage_applicable = TRUE THEN job_category_id END)
      comment: "Number of job categories subject to prevailing wage requirements. Tracks regulatory compliance exposure and its impact on labor cost modeling."
    - name: "drug_screen_required_count"
      expr: COUNT(CASE WHEN drug_screen_required = TRUE THEN job_category_id END)
      comment: "Number of job categories requiring drug screening. Informs pre-employment compliance cost and onboarding cycle time planning."
$$;