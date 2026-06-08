-- Metric views for domain: placement | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core placement assignment metrics tracking active workforce deployment, rate economics, and assignment lifecycle health. Used by operations, finance, and executive leadership to monitor workforce utilization, margin performance, and placement quality."
  source: "`staffing_hr_ecm_v1`.`placement`.`assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current lifecycle status of the assignment (e.g., Active, Ended, Cancelled). Primary filter for operational dashboards."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Classification of the assignment type (e.g., Temporary, Contract, Contract-to-Hire). Drives workforce mix analysis."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (e.g., W2, 1099, Corp-to-Corp). Critical for compliance and cost modeling."
    - name: "flsa_classification"
      expr: flsa_classification
      comment: "FLSA exempt/non-exempt status. Used for overtime cost risk analysis and regulatory compliance."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the placed worker. Enables skill-category and role-level performance analysis."
    - name: "department"
      expr: department
      comment: "Client department where the worker is placed. Supports departmental workforce spend analysis."
    - name: "cost_center"
      expr: cost_center
      comment: "Cost center code for the assignment. Enables financial allocation and chargeback reporting."
    - name: "is_remote"
      expr: is_remote
      comment: "Indicates whether the assignment is fully remote. Used for workforce distribution and real-estate cost analysis."
    - name: "is_redeployment_eligible"
      expr: is_redeployment_eligible
      comment: "Flags workers eligible for redeployment at assignment end. Drives talent retention and bench cost reduction strategies."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding completion status. Used to track time-to-productivity and onboarding bottlenecks."
    - name: "bgc_status"
      expr: bgc_status
      comment: "Background check status for the assignment. Compliance and risk management dimension."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the assignment started. Used for cohort analysis and seasonal placement trend reporting."
    - name: "scheduled_end_month"
      expr: DATE_TRUNC('MONTH', scheduled_end_date)
      comment: "Month the assignment is scheduled to end. Used for workforce capacity planning and end-of-assignment pipeline forecasting."
    - name: "workers_comp_code"
      expr: workers_comp_code
      comment: "Workers compensation classification code. Used for insurance cost allocation and risk segmentation."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN assignment_id END)
      comment: "Total number of currently active assignments. Core operational headcount KPI used by staffing operations and executive leadership to monitor live workforce deployment."
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total assignment records in scope. Baseline volume metric for placement throughput analysis."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across assignments. Tracks pricing trends and rate competitiveness; a key revenue-per-head indicator for account management."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across assignments. Monitors labor cost trends and informs compensation benchmarking."
    - name: "avg_spread"
      expr: AVG(CAST(spread AS DOUBLE))
      comment: "Average spread (bill rate minus pay rate) per assignment. Direct proxy for gross margin per worker; a primary profitability KPI for staffing operations."
    - name: "total_spread"
      expr: SUM(CAST(spread AS DOUBLE))
      comment: "Total spread dollars across all assignments in scope. Aggregate gross margin contribution from the placement portfolio; used in P&L and revenue forecasting."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across assignments. Measures pricing efficiency and margin discipline relative to pay cost."
    - name: "avg_scheduled_hours_per_week"
      expr: AVG(CAST(scheduled_hours_per_week AS DOUBLE))
      comment: "Average scheduled weekly hours per assignment. Indicates workforce utilization intensity and part-time vs. full-time mix."
    - name: "total_scheduled_weekly_hours"
      expr: SUM(CAST(scheduled_hours_per_week AS DOUBLE))
      comment: "Total scheduled weekly hours across all active assignments. Aggregate capacity metric used for workforce planning and revenue run-rate estimation."
    - name: "redeployment_eligible_count"
      expr: COUNT(CASE WHEN is_redeployment_eligible = TRUE THEN assignment_id END)
      comment: "Number of assignments flagged as redeployment-eligible. Measures the size of the redeployable talent pool, directly impacting bench cost and talent retention ROI."
    - name: "remote_assignment_count"
      expr: COUNT(CASE WHEN is_remote = TRUE THEN assignment_id END)
      comment: "Number of remote assignments. Tracks remote workforce penetration for real-estate, compliance, and workforce strategy decisions."
    - name: "avg_ot_bill_rate"
      expr: AVG(CAST(ot_bill_rate AS DOUBLE))
      comment: "Average overtime bill rate. Used to assess overtime pricing adequacy and client cost exposure from OT-heavy engagements."
    - name: "avg_conversion_fee"
      expr: AVG(CAST(conversion_fee AS DOUBLE))
      comment: "Average conversion fee on assignments with a conversion event. Tracks temp-to-perm revenue opportunity and fee realization."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_assignment_extension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for assignment extension activity, tracking extension volume, rate changes, spread economics, and fall-off risk. Used by account management and operations to monitor workforce continuity, pricing adjustments, and redeployment pipeline health."
  source: "`staffing_hr_ecm_v1`.`placement`.`assignment_extension`"
  dimensions:
    - name: "extension_status"
      expr: extension_status
      comment: "Current status of the extension request (e.g., Approved, Pending, Rejected). Primary operational filter for extension pipeline management."
    - name: "extension_reason_code"
      expr: extension_reason_code
      comment: "Coded reason for the extension. Enables root-cause analysis of extension drivers (e.g., project delay, client request, backfill)."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification on the extension. Used for compliance and cost segmentation."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Type of work location (on-site, remote, hybrid) for the extension. Supports workforce distribution analysis."
    - name: "rate_change_flag"
      expr: rate_change_flag
      comment: "Indicates whether the extension includes a rate change. Used to track pricing renegotiation frequency and margin impact."
    - name: "fall_off_risk_flag"
      expr: fall_off_risk_flag
      comment: "Flags extensions with elevated fall-off risk. Critical early-warning dimension for revenue-at-risk monitoring."
    - name: "redeployment_candidate_flag"
      expr: redeployment_candidate_flag
      comment: "Indicates the worker is a redeployment candidate at extension end. Drives talent retention pipeline planning."
    - name: "msp_program_flag"
      expr: msp_program_flag
      comment: "Indicates whether the extension is under an MSP program. Used for program-level performance and compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the extension rates. Required for multi-currency financial consolidation."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the extension was requested. Used for extension volume trend analysis and pipeline forecasting."
    - name: "new_end_month"
      expr: DATE_TRUNC('MONTH', new_end_date)
      comment: "Month of the new assignment end date post-extension. Used for workforce capacity planning."
  measures:
    - name: "total_extensions"
      expr: COUNT(1)
      comment: "Total number of assignment extensions. Measures workforce continuity and client retention; a high extension rate signals strong client satisfaction and placement stickiness."
    - name: "approved_extensions"
      expr: COUNT(CASE WHEN extension_status = 'Approved' THEN assignment_extension_id END)
      comment: "Number of approved extensions. Tracks successful extension conversion, a key indicator of account management effectiveness."
    - name: "fall_off_risk_extensions"
      expr: COUNT(CASE WHEN fall_off_risk_flag = TRUE THEN assignment_extension_id END)
      comment: "Number of extensions flagged as fall-off risk. Quantifies revenue-at-risk from potential early terminations; triggers proactive account intervention."
    - name: "rate_change_extensions"
      expr: COUNT(CASE WHEN rate_change_flag = TRUE THEN assignment_extension_id END)
      comment: "Number of extensions with a rate change. Measures pricing renegotiation frequency and its impact on margin."
    - name: "avg_spread_revised"
      expr: AVG(CAST(spread_revised AS DOUBLE))
      comment: "Average revised spread on extensions. Tracks margin trajectory post-extension; declining spread signals pricing pressure."
    - name: "avg_spread_prior"
      expr: AVG(CAST(spread_prior AS DOUBLE))
      comment: "Average spread prior to extension. Baseline for measuring margin change driven by extension rate negotiations."
    - name: "avg_revised_bill_rate"
      expr: AVG(CAST(revised_bill_rate AS DOUBLE))
      comment: "Average revised bill rate on extensions. Monitors pricing trends and rate escalation patterns across the extended workforce."
    - name: "avg_revised_pay_rate"
      expr: AVG(CAST(revised_pay_rate AS DOUBLE))
      comment: "Average revised pay rate on extensions. Tracks labor cost changes at extension and informs compensation benchmarking."
    - name: "redeployment_candidate_count"
      expr: COUNT(CASE WHEN redeployment_candidate_flag = TRUE THEN assignment_extension_id END)
      comment: "Number of extension workers flagged as redeployment candidates. Measures the redeployable talent pipeline emerging from extensions."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for temp-to-perm conversion activity, tracking conversion volume, fee economics, fall-off rates, and payment realization. Used by account management, finance, and executive leadership to measure the value of the conversion revenue stream and placement quality."
  source: "`staffing_hr_ecm_v1`.`placement`.`conversion`"
  dimensions:
    - name: "conversion_status"
      expr: conversion_status
      comment: "Current status of the conversion (e.g., Confirmed, Pending, Cancelled). Primary filter for conversion pipeline management."
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (e.g., Temp-to-Perm, Contract-to-Hire). Enables revenue stream segmentation."
    - name: "fee_basis_type"
      expr: fee_basis_type
      comment: "Basis for the conversion fee calculation (e.g., percentage of salary, flat fee). Used for fee structure analysis and contract compliance."
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency of the conversion fee. Required for multi-currency financial consolidation."
    - name: "fee_waiver_flag"
      expr: fee_waiver_flag
      comment: "Indicates whether the conversion fee was waived. Tracks revenue leakage from fee waivers."
    - name: "fall_off_reason"
      expr: fall_off_reason
      comment: "Reason for conversion fall-off. Enables root-cause analysis of failed conversions and placement quality issues."
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month the conversion occurred. Used for conversion volume trend analysis and revenue recognition timing."
    - name: "permanent_start_month"
      expr: DATE_TRUNC('MONTH', permanent_start_date)
      comment: "Month the converted worker started in the permanent role. Used for revenue realization and workforce transition tracking."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the conversion record. Used for data lineage and system reconciliation."
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversion events. Measures the volume of temp-to-perm placements, a key revenue diversification and client satisfaction KPI."
    - name: "confirmed_conversions"
      expr: COUNT(CASE WHEN conversion_status = 'Confirmed' THEN conversion_id END)
      comment: "Number of confirmed conversions. Tracks realized conversion revenue events; used in fee revenue forecasting."
    - name: "total_conversion_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total conversion fee revenue across all conversions. Direct P&L contribution from the temp-to-perm revenue stream; a primary executive KPI."
    - name: "avg_conversion_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average conversion fee per placement. Benchmarks fee realization and pricing effectiveness for conversion engagements."
    - name: "avg_converted_annual_salary"
      expr: AVG(CAST(converted_worker_annual_salary AS DOUBLE))
      comment: "Average annual salary of converted workers. Indicates the seniority and value of talent being converted; correlates with fee revenue potential."
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage charged on conversions. Monitors pricing discipline and competitiveness in the conversion fee market."
    - name: "fee_waiver_count"
      expr: COUNT(CASE WHEN fee_waiver_flag = TRUE THEN conversion_id END)
      comment: "Number of conversions where the fee was waived. Quantifies revenue leakage from fee waivers; triggers pricing policy review when elevated."
    - name: "fall_off_count"
      expr: COUNT(CASE WHEN fall_off_date IS NOT NULL THEN conversion_id END)
      comment: "Number of conversions that fell off (worker did not stay). Measures placement quality and guarantee period risk; high fall-off rates signal candidate or client fit issues."
    - name: "avg_actual_hours_worked"
      expr: AVG(CAST(actual_hours_worked AS DOUBLE))
      comment: "Average hours worked by the worker prior to conversion. Indicates tenure depth before conversion and informs minimum tenure policy effectiveness."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_direct_hire`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for direct hire (permanent placement) activity, tracking placement volume, fee revenue, salary levels, fall-off rates, and placement quality. Used by executive leadership, finance, and recruitment operations to manage the permanent placement revenue stream."
  source: "`staffing_hr_ecm_v1`.`placement`.`direct_hire`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Current status of the direct hire placement (e.g., Active, Filled, Cancelled). Primary operational filter."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of direct hire placement (e.g., Contingency, Retained, RPO). Enables revenue stream segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type of the placed candidate (e.g., Full-Time, Part-Time). Used for workforce mix analysis."
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (on-site, remote, hybrid). Tracks remote placement trends and client preference shifts."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which the candidate was sourced (e.g., referral, job board, direct). Measures sourcing ROI and channel effectiveness."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the placed candidate. Enables role-level placement volume and fee analysis."
    - name: "department"
      expr: department
      comment: "Client department for the direct hire. Supports departmental hiring spend analysis."
    - name: "eeoc_job_category"
      expr: eeoc_job_category
      comment: "EEOC job category of the placement. Required for diversity, equity, and inclusion reporting and regulatory compliance."
    - name: "fee_invoiced"
      expr: fee_invoiced
      comment: "Indicates whether the placement fee has been invoiced. Used for revenue recognition and accounts receivable tracking."
    - name: "fee_collected"
      expr: fee_collected
      comment: "Indicates whether the placement fee has been collected. Tracks cash realization and collection efficiency."
    - name: "replacement_obligation"
      expr: replacement_obligation
      comment: "Indicates whether a replacement obligation exists. Tracks contingent liability from guarantee period commitments."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the direct hire started. Used for placement volume trend analysis and revenue recognition timing."
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month the offer was extended. Used for offer-to-start conversion funnel analysis."
  measures:
    - name: "total_direct_hire_placements"
      expr: COUNT(1)
      comment: "Total number of direct hire placements. Core volume KPI for the permanent placement business line; tracked by executive leadership and sales."
    - name: "total_placement_fee_revenue"
      expr: SUM(CAST(conversion_fee_amount AS DOUBLE))
      comment: "Total placement fee revenue from direct hires. Primary P&L metric for the permanent placement revenue stream."
    - name: "avg_placement_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage charged on direct hire placements. Monitors pricing discipline and fee competitiveness in the permanent placement market."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary of placed candidates. Indicates the seniority level of placements and correlates with fee revenue potential."
    - name: "total_base_salary_placed"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary value of all placed candidates. Aggregate measure of the talent value delivered; used to benchmark fee revenue against salary volume."
    - name: "fall_off_count"
      expr: COUNT(CASE WHEN fall_off_date IS NOT NULL THEN direct_hire_id END)
      comment: "Number of direct hire placements that fell off. Measures placement quality and guarantee period risk; high fall-off rates trigger recruiter performance reviews."
    - name: "fee_invoiced_count"
      expr: COUNT(CASE WHEN fee_invoiced = TRUE THEN direct_hire_id END)
      comment: "Number of placements where the fee has been invoiced. Tracks billing completeness and revenue recognition pipeline."
    - name: "fee_collected_count"
      expr: COUNT(CASE WHEN fee_collected = TRUE THEN direct_hire_id END)
      comment: "Number of placements where the fee has been collected. Measures cash realization efficiency; gap between invoiced and collected signals collection risk."
    - name: "replacement_obligation_count"
      expr: COUNT(CASE WHEN replacement_obligation = TRUE THEN direct_hire_id END)
      comment: "Number of placements with an active replacement obligation. Quantifies contingent liability from guarantee commitments; used in risk and quality management."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_fall_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for placement fall-off events, tracking fall-off volume, revenue impact, guarantee period exposure, and replacement fulfillment. Used by operations, account management, and executive leadership to manage placement quality risk and revenue protection."
  source: "`staffing_hr_ecm_v1`.`placement`.`fall_off`"
  dimensions:
    - name: "fall_off_status"
      expr: fall_off_status
      comment: "Current status of the fall-off event (e.g., Confirmed, Under Review, Resolved). Primary operational filter for fall-off case management."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement that fell off (Temporary, Direct Hire, SOW). Enables fall-off rate analysis by placement category."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the fall-off (e.g., candidate no-show, client termination, compliance failure). Drives root-cause analysis and preventive action."
    - name: "within_guarantee_period"
      expr: within_guarantee_period
      comment: "Indicates whether the fall-off occurred within the guarantee period. Determines replacement obligation and fee credit liability."
    - name: "replacement_status"
      expr: replacement_status
      comment: "Status of the replacement fulfillment (e.g., Fulfilled, In Progress, Not Required). Tracks replacement SLA performance."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the fall-off has been escalated. Used to monitor high-severity placement failures requiring leadership attention."
    - name: "redeployment_candidate_flag"
      expr: redeployment_candidate_flag
      comment: "Indicates whether the fallen-off worker is a redeployment candidate. Measures talent salvage opportunity from fall-off events."
    - name: "work_location_type"
      expr: work_location_type
      comment: "Work location type of the fallen-off placement. Used to identify location-related fall-off patterns."
    - name: "fall_off_month"
      expr: DATE_TRUNC('MONTH', fall_off_date)
      comment: "Month the fall-off occurred. Used for fall-off trend analysis and seasonal quality risk monitoring."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the fallen-off placement. Enables role-level fall-off rate analysis to identify high-risk positions."
  measures:
    - name: "total_fall_offs"
      expr: COUNT(1)
      comment: "Total number of fall-off events. Core placement quality KPI; elevated fall-off volume signals systemic candidate, client, or process issues."
    - name: "within_guarantee_fall_offs"
      expr: COUNT(CASE WHEN within_guarantee_period = TRUE THEN fall_off_id END)
      comment: "Number of fall-offs occurring within the guarantee period. Directly triggers replacement obligations and fee credit liability; a primary risk management KPI."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from fall-off events. Quantifies the financial cost of placement failures; used in P&L risk reporting and quality investment decisions."
    - name: "avg_revenue_impact"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per fall-off event. Benchmarks the cost of individual placement failures and informs quality improvement ROI calculations."
    - name: "total_fee_credit_issued"
      expr: SUM(CAST(fee_credit_amount AS DOUBLE))
      comment: "Total fee credits issued due to fall-offs. Measures direct revenue concession from placement quality failures; tracked by finance and account management."
    - name: "total_placement_fee_at_risk"
      expr: SUM(CAST(placement_fee_amount AS DOUBLE))
      comment: "Total placement fee value associated with fall-off events. Quantifies the gross revenue exposure from all fall-off cases in scope."
    - name: "escalated_fall_off_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN fall_off_id END)
      comment: "Number of fall-offs that have been escalated. Tracks high-severity placement failures requiring executive or client escalation."
    - name: "replacement_fulfilled_count"
      expr: COUNT(CASE WHEN replacement_fulfilled_date IS NOT NULL THEN fall_off_id END)
      comment: "Number of fall-offs where a replacement was successfully fulfilled. Measures replacement SLA performance and client retention effectiveness."
    - name: "redeployment_salvage_count"
      expr: COUNT(CASE WHEN redeployment_candidate_flag = TRUE THEN fall_off_id END)
      comment: "Number of fallen-off workers flagged for redeployment. Measures talent salvage rate from fall-off events, reducing bench cost and improving workforce ROI."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for offer management, tracking offer volume, acceptance rates, decline patterns, compensation levels, and negotiation dynamics. Used by recruitment operations and executive leadership to optimize offer strategy, improve acceptance rates, and manage compensation competitiveness."
  source: "`staffing_hr_ecm_v1`.`placement`.`offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (e.g., Accepted, Declined, Pending, Rescinded). Primary filter for offer pipeline management."
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (e.g., Temporary, Direct Hire, Contract). Enables offer analysis by placement category."
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type associated with the offer. Used for cross-placement-type offer performance comparison."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification on the offer. Used for compliance and cost segmentation."
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (on-site, remote, hybrid) offered. Tracks how work arrangement affects offer acceptance rates."
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which the candidate was sourced. Measures sourcing channel quality via offer acceptance rates."
    - name: "decline_reason_code"
      expr: decline_reason_code
      comment: "Coded reason for offer decline. Enables root-cause analysis of offer failures and informs compensation and benefits strategy."
    - name: "exempt_status"
      expr: exempt_status
      comment: "FLSA exempt/non-exempt status on the offer. Used for compensation compliance and overtime cost analysis."
    - name: "msp_program_flag"
      expr: msp_program_flag
      comment: "Indicates whether the offer is under an MSP program. Used for program-level offer performance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the offer. Required for multi-currency compensation analysis."
    - name: "offer_month"
      expr: DATE_TRUNC('MONTH', offer_date)
      comment: "Month the offer was extended. Used for offer volume trend analysis and recruitment pipeline velocity tracking."
    - name: "job_title"
      expr: job_title
      comment: "Job title on the offer. Enables role-level offer acceptance and compensation analysis."
    - name: "department"
      expr: department
      comment: "Client department for the offer. Supports departmental hiring funnel analysis."
  measures:
    - name: "total_offers_extended"
      expr: COUNT(1)
      comment: "Total number of offers extended. Core recruitment funnel volume KPI; tracks hiring activity and pipeline throughput."
    - name: "accepted_offers"
      expr: COUNT(CASE WHEN offer_status = 'Accepted' THEN offer_id END)
      comment: "Number of accepted offers. Measures offer conversion success; directly tied to placement revenue realization."
    - name: "declined_offers"
      expr: COUNT(CASE WHEN offer_status = 'Declined' THEN offer_id END)
      comment: "Number of declined offers. Tracks offer failure volume; elevated decline rates trigger compensation and process reviews."
    - name: "rescinded_offers"
      expr: COUNT(CASE WHEN offer_status = 'Rescinded' THEN offer_id END)
      comment: "Number of rescinded offers. Measures late-stage placement failures; rescissions signal compliance, BGC, or client-side issues."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate on offers. Tracks pricing trends at the offer stage and informs rate competitiveness analysis."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate on offers. Monitors compensation competitiveness and labor cost trends at the offer stage."
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary AS DOUBLE))
      comment: "Average annual salary offered on direct hire offers. Benchmarks compensation levels and informs salary band strategy."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on offers. Measures pricing margin at the offer stage; declining markup signals competitive pricing pressure."
    - name: "avg_sign_on_bonus"
      expr: AVG(CAST(sign_on_bonus AS DOUBLE))
      comment: "Average sign-on bonus offered. Tracks incentive compensation trends and their correlation with offer acceptance rates."
    - name: "counter_offer_count"
      expr: COUNT(CASE WHEN counter_offer_amount > 0 THEN offer_id END)
      comment: "Number of offers that received a counter-offer. Measures negotiation frequency; high counter-offer rates indicate compensation misalignment."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for rate management, tracking bill rates, pay rates, spread economics, markup, gross margin, and overtime rate structures. Used by finance, pricing, and executive leadership to monitor rate competitiveness, margin health, and pricing strategy effectiveness."
  source: "`staffing_hr_ecm_v1`.`placement`.`rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (e.g., Standard, Overtime, Holiday, Per Diem). Enables rate analysis by rate category."
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type associated with the rate. Used for rate benchmarking across placement categories."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate (e.g., Approved, Pending, Rejected). Used for rate governance and compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate. Required for multi-currency financial consolidation."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the rate is currently active. Used to filter for current vs. historical rate analysis."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Indicates whether the rate is taxable. Used for tax liability and compliance analysis."
    - name: "job_classification_code"
      expr: job_classification_code
      comment: "Job classification code for the rate. Enables rate benchmarking by job category and skill level."
    - name: "per_diem_category"
      expr: per_diem_category
      comment: "Category of per diem allowance. Used for per diem cost analysis and policy compliance."
    - name: "rate_source"
      expr: rate_source
      comment: "Source of the rate (e.g., negotiated, GSA schedule, VMS). Tracks rate origin for pricing governance."
    - name: "work_state_code"
      expr: work_state_code
      comment: "State where the work is performed. Enables geographic rate analysis and state-level compliance monitoring."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate became effective. Used for rate trend analysis and pricing strategy review."
  measures:
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across rate records. Core pricing KPI; tracks revenue-per-hour trends and rate competitiveness."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across rate records. Monitors labor cost trends and compensation benchmarking."
    - name: "avg_spread_amount"
      expr: AVG(CAST(spread_amount AS DOUBLE))
      comment: "Average spread (bill minus pay) per rate record. Direct gross margin proxy per hour; a primary profitability KPI for pricing strategy."
    - name: "total_spread_amount"
      expr: SUM(CAST(spread_amount AS DOUBLE))
      comment: "Total spread dollars across all rate records. Aggregate gross margin contribution from the rate portfolio."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across rates. Measures pricing efficiency and margin discipline relative to pay cost."
    - name: "avg_gross_margin_percentage"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage across rate records. Key profitability KPI used by finance and executive leadership to assess margin health."
    - name: "avg_ot_bill_rate"
      expr: AVG(CAST(ot_bill_rate AS DOUBLE))
      comment: "Average overtime bill rate. Used to assess OT pricing adequacy and client cost exposure from overtime-heavy engagements."
    - name: "avg_burden_rate"
      expr: AVG(CAST(burden_rate AS DOUBLE))
      comment: "Average burden rate (employer taxes and benefits cost). Tracks total labor cost beyond base pay; critical for accurate margin modeling."
    - name: "avg_workers_comp_rate"
      expr: AVG(CAST(workers_comp_rate AS DOUBLE))
      comment: "Average workers compensation rate. Monitors insurance cost trends and their impact on total labor cost and margin."
    - name: "avg_per_diem_daily_allowance"
      expr: AVG(CAST(per_diem_daily_allowance AS DOUBLE))
      comment: "Average per diem daily allowance. Tracks per diem cost trends and policy compliance across the workforce."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_redeployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for worker redeployment activity, tracking redeployment pipeline volume, success rates, outreach effectiveness, and bench cost risk. Used by talent operations and executive leadership to maximize workforce utilization, reduce bench costs, and improve talent retention."
  source: "`staffing_hr_ecm_v1`.`placement`.`redeployment`"
  dimensions:
    - name: "redeployment_status"
      expr: redeployment_status
      comment: "Current status of the redeployment effort (e.g., Active, Placed, Unavailable). Primary filter for redeployment pipeline management."
    - name: "redeployment_type"
      expr: redeployment_type
      comment: "Type of redeployment (e.g., Internal, External, Cross-Client). Enables redeployment strategy segmentation."
    - name: "redeployment_source"
      expr: redeployment_source
      comment: "Source triggering the redeployment (e.g., assignment end, early termination). Used for root-cause analysis of redeployment pipeline drivers."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the redeployment effort (e.g., Redeployed, Separated, Declined). Measures redeployment success and talent retention effectiveness."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the redeployment case. Used to ensure high-value workers receive timely outreach."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category of the worker being redeployed. Enables supply-demand matching analysis by skill area."
    - name: "preferred_work_type"
      expr: preferred_work_type
      comment: "Worker's preferred work type (e.g., Temporary, Permanent). Used to align redeployment opportunities with worker preferences."
    - name: "remote_eligible"
      expr: remote_eligible
      comment: "Indicates whether the worker is eligible for remote redeployment. Expands the redeployable talent pool for remote-capable roles."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for the redeployment candidate. Used for compliance and cost segmentation."
    - name: "availability_month"
      expr: DATE_TRUNC('MONTH', availability_date)
      comment: "Month the worker becomes available for redeployment. Used for redeployment pipeline capacity planning."
    - name: "separation_reason"
      expr: separation_reason
      comment: "Reason for the worker's separation from the prior assignment. Enables root-cause analysis of redeployment pipeline drivers."
  measures:
    - name: "total_redeployment_candidates"
      expr: COUNT(1)
      comment: "Total number of workers in the redeployment pipeline. Core workforce utilization KPI; a large pipeline signals bench cost risk if not converted."
    - name: "successfully_redeployed_count"
      expr: COUNT(CASE WHEN actual_redeploy_date IS NOT NULL THEN redeployment_id END)
      comment: "Number of workers successfully redeployed. Measures redeployment program effectiveness and talent retention ROI."
    - name: "total_bench_cost_risk"
      expr: SUM(CAST(bench_cost_risk AS DOUBLE))
      comment: "Total bench cost risk across the redeployment pipeline. Quantifies the financial exposure from undeployed workers; a primary cost management KPI."
    - name: "avg_bench_cost_risk"
      expr: AVG(CAST(bench_cost_risk AS DOUBLE))
      comment: "Average bench cost risk per redeployment candidate. Benchmarks per-worker cost exposure and informs prioritization of high-cost redeployment cases."
    - name: "avg_pay_rate_min"
      expr: AVG(CAST(pay_rate_min AS DOUBLE))
      comment: "Average minimum acceptable pay rate for redeployment candidates. Used to assess compensation expectations and match candidates to available opportunities."
    - name: "avg_conversion_fee"
      expr: AVG(CAST(conversion_fee AS DOUBLE))
      comment: "Average conversion fee associated with redeployment cases. Tracks revenue opportunity from redeployment-to-conversion pathways."
    - name: "remote_eligible_count"
      expr: COUNT(CASE WHEN remote_eligible = TRUE THEN redeployment_id END)
      comment: "Number of redeployment candidates eligible for remote work. Measures the remote-deployable talent pool size, expanding placement opportunity."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_sow_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for Statement of Work (SOW) engagement performance, tracking engagement volume, financial value, hours utilization, billing realization, and fall-off risk. Used by program management, finance, and executive leadership to manage the SOW/IC revenue stream and delivery performance."
  source: "`staffing_hr_ecm_v1`.`placement`.`sow_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the SOW engagement (e.g., Active, Completed, Cancelled). Primary operational filter."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of SOW engagement (e.g., Fixed-Price, Time-and-Materials, Milestone). Enables revenue recognition and risk analysis by contract type."
    - name: "placement_type"
      expr: placement_type
      comment: "Placement type for the SOW engagement. Used for cross-placement-type performance comparison."
    - name: "work_arrangement"
      expr: work_arrangement
      comment: "Work arrangement (on-site, remote, hybrid) for the engagement. Tracks remote SOW trends."
    - name: "ic_classification_flag"
      expr: ic_classification_flag
      comment: "Indicates whether the worker is classified as an independent contractor. Critical for co-employment risk and compliance monitoring."
    - name: "co_employment_risk_level"
      expr: co_employment_risk_level
      comment: "Co-employment risk level for the engagement. Used for compliance risk management and client advisory."
    - name: "milestone_billing_flag"
      expr: milestone_billing_flag
      comment: "Indicates whether billing is milestone-based. Used for revenue recognition timing and cash flow forecasting."
    - name: "fall_off_flag"
      expr: fall_off_flag
      comment: "Indicates whether the SOW engagement fell off. Used to track SOW placement quality and revenue loss."
    - name: "department"
      expr: department
      comment: "Client department for the SOW engagement. Supports departmental SOW spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the SOW engagement. Required for multi-currency financial consolidation."
    - name: "engagement_start_month"
      expr: DATE_TRUNC('MONTH', engagement_start_date)
      comment: "Month the SOW engagement started. Used for engagement volume trend analysis and revenue pipeline tracking."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the SOW engagement record. Used for data lineage and system reconciliation."
  measures:
    - name: "total_sow_engagements"
      expr: COUNT(1)
      comment: "Total number of SOW engagements. Core volume KPI for the SOW/IC business line; tracked by program management and executive leadership."
    - name: "active_sow_engagements"
      expr: COUNT(CASE WHEN engagement_status = 'Active' THEN sow_engagement_id END)
      comment: "Number of currently active SOW engagements. Measures live SOW portfolio size and revenue run-rate."
    - name: "total_sow_value"
      expr: SUM(CAST(total_sow_value AS DOUBLE))
      comment: "Total contracted SOW value across all engagements. Primary revenue pipeline KPI for the SOW business line; used in P&L and forecasting."
    - name: "avg_sow_value"
      expr: AVG(CAST(total_sow_value AS DOUBLE))
      comment: "Average SOW engagement value. Benchmarks deal size and informs sales strategy for SOW business development."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced across SOW engagements. Measures revenue realization from the SOW portfolio; gap vs. total SOW value indicates unbilled exposure."
    - name: "total_hours_budgeted"
      expr: SUM(CAST(total_hours_budgeted AS DOUBLE))
      comment: "Total hours budgeted across SOW engagements. Aggregate capacity commitment metric used for workforce planning and resource allocation."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Total hours worked across SOW engagements. Measures actual delivery against budgeted hours; used for utilization and burn rate analysis."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across SOW engagements. Tracks SOW pricing trends and rate competitiveness."
    - name: "fall_off_sow_count"
      expr: COUNT(CASE WHEN fall_off_flag = TRUE THEN sow_engagement_id END)
      comment: "Number of SOW engagements that fell off. Measures SOW placement quality and revenue loss from early terminations."
    - name: "high_co_employment_risk_count"
      expr: COUNT(CASE WHEN co_employment_risk_level = 'High' THEN sow_engagement_id END)
      comment: "Number of SOW engagements with high co-employment risk. Quantifies regulatory compliance exposure; triggers legal review and client advisory actions."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`placement_assignment_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for assignment-level compliance tracking, monitoring requirement completion rates, waiver usage, expiration risk, and verification quality. Used by compliance officers and operations leadership to manage regulatory risk and ensure workforce compliance standards are met."
  source: "`staffing_hr_ecm_v1`.`placement`.`assignment_compliance`"
  dimensions:
    - name: "requirement_status"
      expr: requirement_status
      comment: "Current status of the compliance requirement (e.g., Compliant, Non-Compliant, Pending, Expired). Primary filter for compliance risk monitoring."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the compliance requirement (e.g., Document Review, Electronic, Third-Party). Used for verification quality and audit trail analysis."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether a compliance waiver was granted. Tracks waiver frequency and associated compliance risk exposure."
    - name: "waiver_reason"
      expr: waiver_reason
      comment: "Reason for the compliance waiver. Enables root-cause analysis of waiver patterns and policy review."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the compliance requirement was completed. Used for compliance completion trend analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the compliance requirement expires. Used for proactive expiration risk management and renewal pipeline planning."
  measures:
    - name: "total_compliance_requirements"
      expr: COUNT(1)
      comment: "Total number of assignment compliance requirement records. Baseline volume metric for compliance program scope."
    - name: "compliant_requirements"
      expr: COUNT(CASE WHEN requirement_status = 'Compliant' THEN assignment_compliance_id END)
      comment: "Number of compliance requirements in compliant status. Measures overall compliance program health; a primary regulatory risk KPI."
    - name: "non_compliant_requirements"
      expr: COUNT(CASE WHEN requirement_status = 'Non-Compliant' THEN assignment_compliance_id END)
      comment: "Number of non-compliant requirements. Quantifies active compliance risk exposure; triggers immediate remediation actions."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN assignment_compliance_id END)
      comment: "Number of compliance requirements with an active waiver. Tracks waiver frequency; elevated waiver rates signal systemic compliance gaps or policy misalignment."
    - name: "expiring_soon_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN assignment_compliance_id END)
      comment: "Number of compliance requirements expiring within the next 30 days. Proactive risk management KPI; drives renewal outreach and prevents compliance lapses."
$$;