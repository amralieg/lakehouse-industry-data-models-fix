-- Metric views for domain: service | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_field_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for field service orders — tracks cost, labor efficiency, travel overhead, and resolution outcomes to steer field service performance."
  source: "`vibe_manufacturing_v1`.`service`.`field_service_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of field service order (e.g. installation, repair, preventive maintenance) for segmenting performance by work category."
    - name: "service_category"
      expr: service_category
      comment: "Service category (e.g. electrical, mechanical, software) enabling cost and volume analysis by discipline."
    - name: "priority"
      expr: priority
      comment: "Order priority level (e.g. critical, high, normal) for SLA compliance and escalation analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the field service order (e.g. open, in-progress, closed) for pipeline visibility."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion outcome of the order (e.g. resolved, unresolved, escalated) for first-time fix rate analysis."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Standardized outcome code for the service visit, used to track resolution quality and repeat-visit rates."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification of the service issue, enabling failure pattern analysis and preventive action targeting."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates whether the order is covered under warranty, separating warranty cost from billable service revenue."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month of scheduled service start for trend analysis of order volume and cost over time."
    - name: "country"
      expr: country
      comment: "Country where the field service was performed, enabling geographic performance benchmarking."
  measures:
    - name: "total_field_service_orders"
      expr: COUNT(1)
      comment: "Total number of field service orders — baseline volume KPI for capacity planning and workload management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all field service orders — directly informs workforce cost management and billing accuracy."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost consumed in field service — drives spare parts inventory investment decisions."
    - name: "total_travel_cost"
      expr: SUM(CAST(travel_cost AS DOUBLE))
      comment: "Total travel cost incurred for field service visits — key input for optimizing dispatch zones and remote diagnostics ROI."
    - name: "total_gross_service_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross service order value — top-line revenue indicator for the field service business."
    - name: "total_net_service_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net service order value after discounts — true revenue contribution from field service operations."
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discounts applied to field service orders — monitors discount leakage and pricing discipline."
    - name: "avg_labor_hours_per_order"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per field service order — efficiency benchmark for engineer productivity and job scoping accuracy."
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance per field service order — informs zone optimization and remote diagnostic substitution opportunities."
    - name: "avg_travel_hours_per_order"
      expr: AVG(CAST(travel_hours AS DOUBLE))
      comment: "Average travel time per order — measures non-productive time and supports dispatch efficiency improvements."
    - name: "travel_cost_as_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(travel_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_amount AS DOUBLE)), 0), 2)
      comment: "Travel cost as a percentage of gross service revenue — strategic KPI for assessing field service model efficiency vs. remote alternatives."
    - name: "avg_tax_amount"
      expr: AVG(CAST(tax_amount AS DOUBLE))
      comment: "Average tax amount per field service order — supports tax compliance monitoring and regional tax rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service request KPIs covering volume, cost, SLA performance, and resolution quality — core metrics for service operations steering."
  source: "`vibe_manufacturing_v1`.`service`.`request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (e.g. incident, change, warranty claim) for volume and cost segmentation."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request (e.g. open, resolved, escalated) for pipeline and backlog management."
    - name: "service_category"
      expr: service_category
      comment: "Service category of the request enabling cost and resolution analysis by discipline."
    - name: "priority"
      expr: priority
      comment: "Priority level of the request — critical for SLA breach analysis and resource prioritization."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the request — tracks escalation frequency and severity for service quality management."
    - name: "channel"
      expr: channel
      comment: "Intake channel (e.g. phone, email, portal, field) for channel mix analysis and digital deflection measurement."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the request — enables SLA compliance analysis by contract tier."
    - name: "warranty_flag"
      expr: warranty_flag
      comment: "Indicates warranty coverage — separates warranty cost burden from billable service revenue."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the request was created — enables trend analysis of inbound service demand."
    - name: "site_country"
      expr: site_country
      comment: "Country of the service site — supports geographic performance benchmarking."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests — baseline demand volume KPI for capacity and staffing decisions."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to resolve service requests — key input for service P&L and cost-to-serve analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for open service requests — forward-looking cost exposure for budget management."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Total parts cost consumed across service requests — drives spare parts inventory and procurement planning."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost to resolve a service request — efficiency benchmark for cost-to-serve optimization."
    - name: "avg_travel_distance_km"
      expr: AVG(CAST(travel_distance_km AS DOUBLE))
      comment: "Average travel distance per service request — informs zone design and remote resolution investment decisions."
    - name: "cost_overrun_ratio"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to estimated cost — values above 1.0 indicate systematic underestimation, driving quoting and scoping improvements."
    - name: "escalated_request_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level <> '' THEN 1 END)
      comment: "Number of escalated service requests — high escalation rates signal systemic service quality or staffing issues requiring executive attention."
    - name: "warranty_request_count"
      expr: COUNT(CASE WHEN warranty_flag = TRUE THEN 1 END)
      comment: "Number of requests covered under warranty — tracks warranty cost exposure and product reliability signals."
    - name: "warranty_cost_total"
      expr: SUM(CASE WHEN warranty_flag = TRUE THEN CAST(actual_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of warranty-covered service requests — quantifies warranty liability and informs product quality investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract portfolio KPIs covering contract value, renewal performance, SLA commitments, and coverage scope — essential for service revenue management."
  source: "`vibe_manufacturing_v1`.`service`.`service_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of service contract (e.g. full-service, time-and-material, preventive) for portfolio mix analysis."
    - name: "contract_category"
      expr: contract_category
      comment: "Contract category for segmenting the portfolio by business line or customer tier."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier (e.g. gold, silver, bronze) — key dimension for SLA commitment and revenue tier analysis."
    - name: "service_contract_status"
      expr: service_contract_status
      comment: "Current contract status (e.g. active, expired, pending renewal) for portfolio health monitoring."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates auto-renewal contracts — used to forecast recurring revenue and identify at-risk manual renewals."
    - name: "warranty_included_flag"
      expr: warranty_included_flag
      comment: "Indicates whether warranty is bundled in the contract — affects margin analysis and warranty cost allocation."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (e.g. monthly, quarterly, annual) for cash flow and revenue recognition planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency revenue analysis and FX exposure management."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective — enables cohort analysis of contract starts and renewal cycles."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the contract is a renewal — tracks renewal rate as a leading indicator of customer retention."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(1)
      comment: "Total number of service contracts in the portfolio — baseline KPI for service business scale and coverage."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted service revenue value — top-line KPI for service business revenue planning and forecasting."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after discounts — true service revenue contribution for margin analysis."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value — benchmark for deal sizing, upsell opportunity identification, and pricing strategy."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate applied to service contracts — monitors pricing discipline and discount leakage."
    - name: "avg_response_time_target_hours"
      expr: AVG(CAST(response_time_target_hours AS DOUBLE))
      comment: "Average SLA response time commitment across contracts — informs staffing and dispatch capacity requirements."
    - name: "avg_resolution_time_target_hours"
      expr: AVG(CAST(resolution_time_target_hours AS DOUBLE))
      comment: "Average SLA resolution time commitment — drives engineer skill mix and spare parts positioning decisions."
    - name: "avg_uptime_guarantee_pct"
      expr: AVG(CAST(uptime_guarantee_percent AS DOUBLE))
      comment: "Average uptime guarantee committed across contracts — key risk indicator for service delivery capability vs. commitments."
    - name: "renewal_contract_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Number of renewed contracts — numerator for renewal rate calculation, a leading indicator of customer retention."
    - name: "auto_renewal_contract_value"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN CAST(contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of auto-renewing contracts — quantifies locked-in recurring service revenue for financial planning."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average tax rate across service contracts — supports tax compliance monitoring and regional pricing adjustments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_contract_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service contract line-level KPIs covering coverage value, SLA commitments, billing structure, and renewal exposure — enables granular contract profitability and compliance analysis."
  source: "`vibe_manufacturing_v1`.`service`.`contract_line`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage provided (e.g. parts-only, labor-only, full-service) for margin and scope analysis."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level tier (e.g. basic, standard, premium) for SLA and revenue tier segmentation."
    - name: "service_level"
      expr: service_level
      comment: "Service level commitment on the contract line — drives staffing and parts positioning requirements."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the contract line (e.g. active, expired, suspended) for portfolio health monitoring."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the contract line — supports cash flow and revenue recognition planning."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the line auto-renews — used to forecast recurring revenue and identify at-risk manual renewals."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract line for multi-currency revenue analysis."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Month coverage begins — enables cohort analysis of contract line starts and renewal cycles."
  measures:
    - name: "total_contract_lines"
      expr: COUNT(1)
      comment: "Total number of contract lines — baseline volume KPI for contract portfolio depth and coverage breadth."
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total contracted line value — revenue contribution from individual contract line items."
    - name: "total_line_price"
      expr: SUM(CAST(line_price AS DOUBLE))
      comment: "Total list price across contract lines — used to calculate effective discount rates and pricing realization."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per contract line — benchmark for pricing consistency and upsell opportunity identification."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to contract lines — monitors pricing discipline and discount leakage."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average SLA response time commitment across contract lines — informs staffing and dispatch capacity requirements."
    - name: "avg_covered_quantity"
      expr: AVG(CAST(covered_quantity AS DOUBLE))
      comment: "Average quantity of assets or units covered per contract line — supports capacity and parts planning."
    - name: "total_entitlement_units"
      expr: SUM(CAST(entitlement_units AS DOUBLE))
      comment: "Total service entitlement units committed across contract lines — quantifies service delivery obligations."
    - name: "auto_renew_line_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Number of auto-renewing contract lines — quantifies locked-in recurring service revenue at line level."
    - name: "avg_renewal_term_months"
      expr: AVG(CAST(renewal_term_months AS DOUBLE))
      comment: "Average renewal term length in months — informs long-term revenue visibility and contract structure strategy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_engineer_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engineer assignment utilization and efficiency KPIs — tracks planned vs. actual hours, billability, and allocation rates to optimize field workforce deployment."
  source: "`vibe_manufacturing_v1`.`service`.`engineer_assignment`"
  dimensions:
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the engineer on the assignment (e.g. lead, support, specialist) for skill utilization analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (e.g. scheduled, in-progress, completed) for workforce pipeline visibility."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the assignment is billable — key dimension for revenue realization vs. non-billable overhead analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of the assignment — enables trend analysis of engineer utilization and demand patterns."
    - name: "role"
      expr: role
      comment: "Engineer role classification for workforce capacity planning and skill gap analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of engineer assignments — baseline volume KPI for workforce demand and scheduling load."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned engineer hours — forward-looking capacity commitment for workforce planning."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked on assignments — true labor consumption for cost and productivity analysis."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours for assignments — used to assess estimation accuracy and job scoping quality."
    - name: "total_allocated_hours"
      expr: SUM(CAST(allocated_hours AS DOUBLE))
      comment: "Total allocated hours across assignments — measures committed capacity against available engineer time."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average allocation percentage per assignment — key utilization metric for identifying over- or under-utilized engineers."
    - name: "hours_variance"
      expr: SUM(CAST(actual_hours AS DOUBLE) - CAST(planned_hours AS DOUBLE))
      comment: "Total variance between actual and planned hours — positive values indicate scope creep or underestimation requiring corrective action."
    - name: "billable_hours_total"
      expr: SUM(CASE WHEN billable_flag = TRUE THEN CAST(actual_hours AS DOUBLE) ELSE 0 END)
      comment: "Total billable hours worked — directly tied to service revenue realization and engineer productivity."
    - name: "non_billable_hours_total"
      expr: SUM(CASE WHEN billable_flag = FALSE THEN CAST(actual_hours AS DOUBLE) ELSE 0 END)
      comment: "Total non-billable hours — quantifies overhead and investment in non-revenue activities for cost management."
    - name: "billable_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN CAST(actual_hours AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of actual hours that are billable — primary engineer productivity KPI used in service business reviews."
    - name: "hours_estimation_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(estimated_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to estimated hours as a percentage — values near 100% indicate accurate job scoping; deviations drive quoting process improvements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_sla_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA milestone compliance KPIs — tracks breach rates, escalation frequency, and response performance to manage contractual service commitments and customer satisfaction."
  source: "`vibe_manufacturing_v1`.`service`.`sla_milestone`"
  dimensions:
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the SLA milestone (e.g. acknowledgment, first response, resolution) for stage-level compliance analysis."
    - name: "sla_milestone_status"
      expr: sla_milestone_status
      comment: "Current status of the milestone (e.g. met, breached, pending) for real-time SLA compliance monitoring."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Indicates whether the SLA milestone was breached — primary dimension for SLA compliance reporting."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Indicates whether the milestone triggered an escalation — tracks escalation frequency and severity."
    - name: "priority"
      expr: priority
      comment: "Priority of the associated service request — enables SLA compliance analysis by priority tier."
    - name: "entitlement_tier"
      expr: entitlement_tier
      comment: "Customer entitlement tier (e.g. gold, silver) — enables SLA performance analysis by contract tier."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for the milestone — enables team-level SLA accountability and performance benchmarking."
    - name: "milestone_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the milestone was created — enables trend analysis of SLA performance over time."
  measures:
    - name: "total_sla_milestones"
      expr: COUNT(1)
      comment: "Total SLA milestones tracked — baseline volume for SLA compliance rate calculations."
    - name: "breached_milestone_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of SLA milestones breached — primary KPI for contractual compliance risk and customer satisfaction impact."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA milestones breached — executive KPI for service quality and contract penalty risk management."
    - name: "escalated_milestone_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of escalated SLA milestones — high escalation rates signal systemic service delivery failures requiring leadership intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA milestones that triggered escalation — leading indicator of service quality deterioration."
    - name: "breach_and_escalation_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE AND escalated_flag = TRUE THEN 1 END)
      comment: "Number of milestones that were both breached and escalated — identifies the most severe SLA failures requiring immediate corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service warranty portfolio KPIs covering coverage value, renewal rates, and claims exposure — essential for warranty liability management and product quality signaling."
  source: "`vibe_manufacturing_v1`.`service`.`service_warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (e.g. standard, extended, on-site) for portfolio mix and liability analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current warranty lifecycle status (e.g. active, expired, claimed) for portfolio health monitoring."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier of the warranty — enables analysis of coverage commitment vs. cost."
    - name: "claims_allowed_flag"
      expr: claims_allowed_flag
      comment: "Indicates whether claims are currently allowed — used to track claimable warranty exposure."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the warranty has been renewed — tracks renewal rate as a customer retention signal."
    - name: "transferability_flag"
      expr: transferability_flag
      comment: "Indicates whether the warranty is transferable — affects asset resale value and secondary market analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the warranty coverage amount for multi-currency liability analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month warranty coverage begins — enables cohort analysis of warranty starts and expiry cycles."
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of service warranties in the portfolio — baseline KPI for warranty coverage breadth."
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total warranty coverage value — quantifies maximum warranty liability exposure for financial risk management."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average warranty coverage amount per warranty — benchmark for warranty pricing and liability per unit."
    - name: "claimable_warranty_count"
      expr: COUNT(CASE WHEN claims_allowed_flag = TRUE THEN 1 END)
      comment: "Number of warranties currently open for claims — active liability exposure count for financial provisioning."
    - name: "claimable_coverage_value"
      expr: SUM(CASE WHEN claims_allowed_flag = TRUE THEN CAST(coverage_amount AS DOUBLE) ELSE 0 END)
      comment: "Total coverage value of claimable warranties — maximum current warranty liability for balance sheet provisioning."
    - name: "renewed_warranty_count"
      expr: COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END)
      comment: "Number of renewed warranties — tracks warranty renewal rate as a customer loyalty and recurring revenue indicator."
    - name: "renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warranties that have been renewed — strategic KPI for customer retention and recurring service revenue."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction KPIs from post-service surveys — tracks NPS, overall scores, and dimension ratings to steer service quality improvement and customer retention."
  source: "`vibe_manufacturing_v1`.`service`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g. post-repair, post-installation, annual) for satisfaction analysis by service event type."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was collected (e.g. email, phone, portal) for response bias analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Survey lifecycle status (e.g. sent, responded, closed) for response rate tracking."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month the survey response was received — enables trend analysis of customer satisfaction over time."
    - name: "survey_version"
      expr: survey_version
      comment: "Version of the survey instrument — ensures comparability of scores across survey redesigns."
  measures:
    - name: "total_surveys_collected"
      expr: COUNT(1)
      comment: "Total number of satisfaction surveys collected — baseline for response rate and statistical significance assessment."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall customer satisfaction score — primary customer experience KPI used in executive and board reviews."
    - name: "total_overall_score"
      expr: SUM(CAST(overall_score AS DOUBLE))
      comment: "Sum of overall satisfaction scores — used as numerator for weighted satisfaction calculations across segments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service CAPA (Corrective and Preventive Action) KPIs — tracks issue resolution cost, closure rates, and risk levels to drive continuous service quality improvement."
  source: "`vibe_manufacturing_v1`.`service`.`service_capa_record`"
  dimensions:
    - name: "service_capa_record_status"
      expr: service_capa_record_status
      comment: "Current CAPA status (e.g. open, in-progress, closed, verified) for pipeline and backlog management."
    - name: "priority"
      expr: priority
      comment: "Priority of the CAPA record — enables resource allocation analysis by urgency."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying issue — critical for risk-based prioritization of corrective actions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification of the CAPA — used to prioritize high-risk issues for executive escalation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the service issue — enables systemic failure pattern analysis and prevention targeting."
    - name: "source"
      expr: source
      comment: "Source of the CAPA (e.g. customer complaint, audit, field observation) for origin analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family associated with the CAPA — enables product-level quality issue tracking."
    - name: "is_closed"
      expr: is_closed
      comment: "Indicates whether the CAPA has been closed — used to calculate open vs. closed CAPA ratios."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the CAPA was created — enables trend analysis of service quality issues over time."
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of service CAPA records — baseline volume KPI for service quality issue tracking."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN is_closed = FALSE THEN 1 END)
      comment: "Number of open CAPA records — active quality risk backlog requiring management attention and resource allocation."
    - name: "capa_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPA records closed — measures effectiveness of corrective action processes and quality management maturity."
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA activities — quantifies quality failure cost for management review and prevention investment justification."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of open CAPAs — forward-looking quality cost exposure for budget provisioning."
    - name: "avg_actual_cost_per_capa"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average cost per CAPA record — benchmark for quality failure cost and ROI of preventive investments."
    - name: "high_risk_capa_count"
      expr: COUNT(CASE WHEN risk_level IN ('high', 'critical', 'HIGH', 'CRITICAL') THEN 1 END)
      comment: "Number of high or critical risk CAPA records — executive-level risk indicator requiring immediate escalation and resource prioritization."
    - name: "cost_overrun_ratio"
      expr: ROUND(SUM(CAST(cost_actual AS DOUBLE)) / NULLIF(SUM(CAST(cost_estimate AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to estimated CAPA cost — values above 1.0 indicate systematic underestimation of quality failure remediation costs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_installed_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Installed base asset health and performance KPIs — tracks equipment reliability, maintenance frequency, and operational efficiency to drive proactive service and lifecycle decisions."
  source: "`vibe_manufacturing_v1`.`service`.`installed_base`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "Product category of the installed asset — enables performance and reliability analysis by equipment type."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance applied (e.g. preventive, corrective, predictive) for maintenance strategy effectiveness analysis."
    - name: "installation_method"
      expr: installation_method
      comment: "Method used for installation — enables correlation analysis between installation quality and subsequent reliability."
    - name: "country_code"
      expr: country_code
      comment: "Country where the asset is installed — supports geographic reliability and service cost benchmarking."
    - name: "installation_month"
      expr: DATE_TRUNC('MONTH', installation_date)
      comment: "Month of installation — enables cohort analysis of asset reliability and maintenance frequency over time."
    - name: "firmware_version"
      expr: firmware_version
      comment: "Firmware version running on the installed asset — used to correlate firmware versions with reliability and failure rates."
  measures:
    - name: "total_installed_assets"
      expr: COUNT(1)
      comment: "Total number of installed base assets — baseline KPI for service addressable market and coverage planning."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average mean time between failures — primary asset reliability KPI used to benchmark product quality and maintenance strategy effectiveness."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average mean time to repair — measures service responsiveness and repair efficiency; high MTTR signals staffing or parts availability issues."
    - name: "avg_oee"
      expr: AVG(CAST(overall_equipment_effectiveness AS DOUBLE))
      comment: "Average overall equipment effectiveness (OEE) across installed base — strategic KPI for customer operational performance and upsell of service upgrades."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating of installed assets — used for energy consumption analysis and capacity planning."
    - name: "total_capacity_kw"
      expr: SUM(CAST(capacity_kw AS DOUBLE))
      comment: "Total installed capacity in kilowatts — measures the scale of customer operational infrastructure under service coverage."
    - name: "avg_voltage"
      expr: AVG(CAST(voltage AS DOUBLE))
      comment: "Average voltage rating of installed assets — supports electrical safety compliance and maintenance planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_remote_diagnostic_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote diagnostic session KPIs — tracks resolution rates, session efficiency, and field dispatch avoidance to quantify the ROI of remote service capabilities."
  source: "`vibe_manufacturing_v1`.`service`.`remote_diagnostic_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of remote diagnostic session (e.g. fault diagnosis, firmware update, performance check) for session mix analysis."
    - name: "remote_diagnostic_session_status"
      expr: remote_diagnostic_session_status
      comment: "Current status of the session (e.g. active, completed, failed) for session pipeline monitoring."
    - name: "connection_method"
      expr: connection_method
      comment: "Connection method used (e.g. VPN, cloud, direct) for technology performance and reliability analysis."
    - name: "diagnostic_tool"
      expr: diagnostic_tool
      comment: "Diagnostic tool used in the session — enables tool effectiveness and adoption analysis."
    - name: "resolved_flag"
      expr: resolved_flag
      comment: "Indicates whether the issue was resolved remotely — primary KPI dimension for field dispatch avoidance rate."
    - name: "field_dispatch_needed"
      expr: field_dispatch_needed
      comment: "Indicates whether a field dispatch was required after the session — measures remote resolution effectiveness."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the session started — enables trend analysis of remote diagnostic volume and resolution rates."
  measures:
    - name: "total_remote_sessions"
      expr: COUNT(1)
      comment: "Total number of remote diagnostic sessions — baseline volume KPI for remote service channel adoption."
    - name: "resolved_session_count"
      expr: COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END)
      comment: "Number of issues resolved remotely without field dispatch — measures remote resolution effectiveness and cost avoidance."
    - name: "remote_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolved_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remote sessions that resolved the issue without field dispatch — strategic KPI for remote service ROI and field cost avoidance."
    - name: "field_dispatch_avoidance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN field_dispatch_needed = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions where field dispatch was avoided — directly quantifies cost savings from remote diagnostics investment."
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average remote session duration in seconds — efficiency benchmark for diagnostic tool and engineer effectiveness."
    - name: "avg_data_volume_mb"
      expr: AVG(CAST(data_volume_mb AS DOUBLE))
      comment: "Average data volume transferred per session — informs network infrastructure and bandwidth planning for remote service."
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average session latency in milliseconds — network quality KPI affecting remote diagnostic effectiveness and engineer productivity."
    - name: "avg_bandwidth_mbps"
      expr: AVG(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Average bandwidth per session — used to assess connectivity quality and plan remote service infrastructure investments."
    - name: "field_dispatch_triggered_count"
      expr: COUNT(CASE WHEN field_dispatch_needed = TRUE THEN 1 END)
      comment: "Number of remote sessions that still required a field dispatch — identifies cases where remote diagnostics failed to resolve issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_part_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service parts consumption KPIs — tracks parts spend, fulfillment performance, and warranty coverage to optimize spare parts inventory and service cost management."
  source: "`vibe_manufacturing_v1`.`service`.`part_consumption`"
  dimensions:
    - name: "source_type"
      expr: source_type
      comment: "Source of the part (e.g. warehouse, supplier, field stock) for supply chain and cost analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the part order (e.g. delivered, pending, backordered) for parts availability monitoring."
    - name: "order_urgency"
      expr: order_urgency
      comment: "Urgency level of the parts order (e.g. emergency, standard) for expedite cost and supply chain stress analysis."
    - name: "warranty_coverage_flag"
      expr: warranty_coverage_flag
      comment: "Indicates whether the part consumption is covered under warranty — separates warranty cost from billable parts revenue."
    - name: "contract_coverage_flag"
      expr: contract_coverage_flag
      comment: "Indicates whether the part is covered under a service contract — tracks contract cost consumption vs. billable parts."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the consumed part — ensures accurate quantity and cost aggregation."
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', consumption_timestamp)
      comment: "Month of part consumption — enables trend analysis of parts demand and spend over time."
  measures:
    - name: "total_part_consumption_events"
      expr: COUNT(1)
      comment: "Total number of part consumption events — baseline volume KPI for parts demand and inventory turnover analysis."
    - name: "total_parts_spend"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total parts spend across all service events — key cost driver for service P&L and inventory investment decisions."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of consumed parts — benchmark for parts pricing and supplier cost management."
    - name: "warranty_covered_spend"
      expr: SUM(CASE WHEN warranty_coverage_flag = TRUE THEN CAST(line_total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total parts spend covered under warranty — quantifies warranty liability from parts consumption for financial provisioning."
    - name: "contract_covered_spend"
      expr: SUM(CASE WHEN contract_coverage_flag = TRUE THEN CAST(line_total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total parts spend covered under service contracts — measures contract cost consumption vs. contract revenue."
    - name: "billable_parts_spend"
      expr: SUM(CASE WHEN warranty_coverage_flag = FALSE AND contract_coverage_flag = FALSE THEN CAST(line_total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total billable parts spend not covered by warranty or contract — represents direct parts revenue opportunity."
    - name: "warranty_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN warranty_coverage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of part consumption events covered under warranty — tracks warranty utilization rate and product reliability signals."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`service_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs — tracks PM compliance, overdue schedules, and labor estimates to ensure proactive maintenance execution and equipment uptime."
  source: "`vibe_manufacturing_v1`.`service`.`service_pm_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of PM schedule (e.g. time-based, usage-based, condition-based) for maintenance strategy analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the PM schedule (e.g. active, suspended, expired) for schedule portfolio health monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the PM schedule (e.g. compliant, overdue, at-risk) — primary KPI dimension for maintenance compliance reporting."
    - name: "priority"
      expr: priority
      comment: "Priority of the PM schedule — enables resource allocation analysis by maintenance urgency."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the PM is mandatory (e.g. regulatory or safety-critical) — separates compliance-driven from discretionary maintenance."
    - name: "interval_unit"
      expr: interval_unit
      comment: "Unit of the maintenance interval (e.g. days, hours, cycles) for schedule frequency analysis."
    - name: "classification_or_type"
      expr: classification_or_type
      comment: "Classification of the PM schedule for grouping by maintenance discipline or equipment class."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the next PM is due — enables forward-looking workload planning and resource scheduling."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of preventive maintenance schedules — baseline KPI for PM program scope and coverage."
    - name: "mandatory_pm_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory PM schedules — quantifies regulatory and safety-critical maintenance obligations."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for all PM schedules — forward-looking capacity requirement for maintenance workforce planning."
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per PM schedule — benchmark for job scoping accuracy and resource planning."
    - name: "avg_maintenance_interval"
      expr: AVG(CAST(maintenance_interval AS DOUBLE))
      comment: "Average maintenance interval across PM schedules — informs maintenance frequency strategy and equipment uptime planning."
    - name: "mandatory_labor_hours"
      expr: SUM(CASE WHEN is_mandatory = TRUE THEN CAST(estimated_labor_hours AS DOUBLE) ELSE 0 END)
      comment: "Total estimated labor hours for mandatory PM schedules — quantifies non-discretionary maintenance labor commitment."
$$;