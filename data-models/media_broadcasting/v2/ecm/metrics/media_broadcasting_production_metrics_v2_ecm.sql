-- Metric views for domain: production | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level production project portfolio metrics tracking budget performance, greenlight pipeline, and delivery efficiency across all active productions."
  source: "`vibe_media_broadcasting_v1`.`production`.`project`"
  dimensions:
    - name: "production_phase"
      expr: production_phase
      comment: "Current phase of the production (pre-production, principal photography, post-production, delivery) for phase-gate analysis."
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of the production content (drama, comedy, documentary, etc.) for portfolio mix analysis."
    - name: "production_country"
      expr: production_country
      comment: "Country where the production is based, used for geographic cost and tax-credit analysis."
    - name: "co_production_flag"
      expr: co_production_flag
      comment: "Indicates whether the project is a co-production with an external partner, relevant for risk and cost-sharing analysis."
    - name: "original_ip_flag"
      expr: original_ip_flag
      comment: "Flags original IP productions vs. adaptations, informing strategic IP investment decisions."
    - name: "drm_required"
      expr: drm_required
      comment: "Indicates whether DRM is required for the project, relevant for distribution readiness tracking."
    - name: "greenlight_year"
      expr: YEAR(greenlight_date)
      comment: "Year the project received greenlight approval, used for cohort and vintage analysis."
    - name: "target_delivery_year"
      expr: YEAR(target_delivery_date)
      comment: "Year the project is targeted for delivery, used for pipeline and capacity planning."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of production projects in the portfolio. Baseline KPI for pipeline volume and capacity planning."
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved production budget in USD across all projects. Core financial commitment metric for CFO and production finance reviews."
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend to date across all projects. Compared against approved budget to assess financial control."
    - name: "avg_approved_budget_usd"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average approved budget per project. Benchmarks production investment levels and informs greenlight thresholds."
    - name: "avg_actual_spend_usd"
      expr: AVG(CAST(actual_spend_usd AS DOUBLE))
      comment: "Average actual spend per project. Used alongside average budget to assess typical cost performance."
    - name: "projects_with_delivery_overrun"
      expr: COUNT(CASE WHEN actual_delivery_date > target_delivery_date THEN 1 END)
      comment: "Number of projects where actual delivery exceeded the target date. Key operational risk indicator for scheduling and distribution commitments."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= target_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed projects delivered on or before target date. Critical KPI for distribution partner SLA compliance and scheduling reliability."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of approved budget across the portfolio. Signals over/under-spend trends and financial discipline."
    - name: "co_production_project_count"
      expr: COUNT(CASE WHEN co_production_flag = TRUE THEN 1 END)
      comment: "Number of co-production projects. Tracks strategic partnership activity and shared-risk portfolio exposure."
    - name: "original_ip_project_count"
      expr: COUNT(CASE WHEN original_ip_flag = TRUE THEN 1 END)
      comment: "Number of original IP projects. Measures investment in proprietary content creation vs. licensed/adapted content."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production budget performance metrics tracking approved vs. actual vs. forecast spend, variance analysis, and financial control across production phases."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget`"
  dimensions:
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase (development, pre-production, production, post-production) for phase-level budget analysis."
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category (above-the-line, below-the-line, post-production, etc.) for budget breakdown by category."
    - name: "cost_line_type"
      expr: cost_line_type
      comment: "Type of cost line (labor, equipment, facility, etc.) for granular cost structure analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the budget version (draft, submitted, approved, rejected) for governance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual financial planning and reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for periodic budget performance reviews."
    - name: "is_greenlight_budget"
      expr: is_greenlight_budget
      comment: "Flags the official greenlight budget version, distinguishing it from working estimates."
    - name: "is_locked"
      expr: is_locked
      comment: "Indicates whether the budget is locked against further changes, relevant for financial close processes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency portfolio analysis."
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount. Primary financial authorization metric for production finance and executive oversight."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred against the budget. Core spend tracking metric for financial control."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast-to-complete amount. Forward-looking financial exposure metric for cash flow and commitment management."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed spend (POs, contracts) not yet invoiced. Critical for cash flow forecasting and vendor obligation tracking."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (approved minus actual). Negative values indicate overruns requiring executive intervention."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves held across budgets. Measures risk buffer adequacy for production portfolio."
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage held across budget lines. Benchmarks risk provisioning practices against industry norms."
    - name: "budget_overrun_count"
      expr: COUNT(CASE WHEN actual_cost_amount > approved_amount THEN 1 END)
      comment: "Number of budget records where actual cost exceeds approved amount. Signals financial control failures requiring remediation."
    - name: "budget_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Portfolio-level budget variance as a percentage of approved budget. Key CFO metric for production financial health."
    - name: "forecast_vs_approved_pct"
      expr: ROUND(100.0 * SUM(CAST(forecast_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Forecast spend as a percentage of approved budget. Early warning indicator for budget overruns before costs are incurred."
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after change orders. Tracks scope creep and budget amendment activity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular production budget line metrics for cost category analysis, above/below-the-line tracking, union labor cost management, and variance control."
  source: "`vibe_media_broadcasting_v1`.`production`.`budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (above-the-line, below-the-line, post, etc.) for budget structure analysis."
    - name: "cost_sub_category"
      expr: cost_sub_category
      comment: "Detailed cost sub-category for granular spend analysis and benchmarking."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase associated with the budget line for phase-gate financial tracking."
    - name: "is_above_the_line"
      expr: is_above_the_line
      comment: "Distinguishes above-the-line (creative talent) from below-the-line (crew/technical) costs — a fundamental production finance split."
    - name: "is_union_labor"
      expr: is_union_labor
      comment: "Flags union labor lines for guild compliance cost tracking and residual obligation estimation."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Identifies spend eligible for production tax credits, critical for incentive optimization and financial structuring."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line (days, hours, flat fee) for rate benchmarking."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount across all lines. Baseline for cost structure analysis and category benchmarking."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend across all budget lines. Core financial performance metric for production cost control."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed but not yet invoiced spend. Critical for cash flow management and vendor obligation tracking."
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecast-to-complete across all lines. Forward-looking cost exposure for production finance."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued costs for period-end financial close accuracy and revenue recognition alignment."
    - name: "total_revised_budgeted_amount"
      expr: SUM(CAST(revised_budgeted_amount AS DOUBLE))
      comment: "Total revised budget after change orders. Measures scope change financial impact across the production."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across budget lines. Benchmarks labor and resource rates against guild minimums and market rates."
    - name: "avg_fringe_rate_pct"
      expr: AVG(CAST(fringe_rate_pct AS DOUBLE))
      comment: "Average fringe benefit rate applied to labor lines. Informs total labor cost modeling and union compliance."
    - name: "budget_line_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_amount AS DOUBLE)) - SUM(CAST(budgeted_amount AS DOUBLE))) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Actual vs. budgeted variance as a percentage. Identifies cost categories with systematic over/under-spend patterns."
    - name: "tax_credit_eligible_spend"
      expr: SUM(CASE WHEN tax_credit_eligible = TRUE THEN actual_amount ELSE 0 END)
      comment: "Total actual spend eligible for production tax credits. Directly informs incentive claim value and financial structuring decisions."
    - name: "union_labor_spend"
      expr: SUM(CASE WHEN is_union_labor = TRUE THEN actual_amount ELSE 0 END)
      comment: "Total union labor spend. Tracks guild cost exposure and residual obligation basis for talent finance."
    - name: "above_the_line_spend"
      expr: SUM(CASE WHEN is_above_the_line = TRUE THEN actual_amount ELSE 0 END)
      comment: "Total above-the-line spend (writers, directors, producers, cast). Key creative investment metric for production finance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production cost transaction metrics for financial control, payment status tracking, vendor spend analysis, and SAP reconciliation."
  source: "`vibe_media_broadcasting_v1`.`production`.`cost_transaction`"
  dimensions:
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category of the transaction for spend analysis by category."
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase when the cost was incurred for phase-level financial tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (pending, paid, overdue) for accounts payable management and cash flow forecasting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (wire, check, ACH) for treasury and payment operations analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction for annual financial reporting and period-close reconciliation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly cost accrual and close processes."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction for trend analysis and period-over-period cost comparisons."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total gross transaction amount. Primary spend volume metric for production cost management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after taxes and adjustments. Core metric for P&L and cost center reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across transactions. Required for tax compliance reporting and reclaim processes."
    - name: "total_reporting_currency_amount"
      expr: SUM(CAST(reporting_currency_amount AS DOUBLE))
      comment: "Total spend in reporting currency (USD). Enables consolidated financial reporting across multi-currency productions."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount. Benchmarks typical vendor invoice size and flags anomalous transactions."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Volume metric for AP workload and vendor activity tracking."
    - name: "pending_payment_amount"
      expr: SUM(CASE WHEN payment_status = 'PENDING' THEN net_amount ELSE 0 END)
      comment: "Total amount pending payment. Critical cash flow metric for treasury and vendor relationship management."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to transactions. Monitors currency risk exposure in international productions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_shoot_day`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily production efficiency metrics tracking schedule adherence, crew productivity, overtime exposure, and cost performance at the shoot day level."
  source: "`vibe_media_broadcasting_v1`.`production`.`shoot_day`"
  dimensions:
    - name: "shoot_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of the shoot day for trend analysis of production pace and efficiency."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions on the shoot day for analyzing weather-related production disruptions and contingency usage."
    - name: "is_overtime_incurred"
      expr: is_overtime_incurred
      comment: "Flags shoot days where overtime was incurred, enabling overtime cost pattern analysis."
    - name: "dailies_delivered_flag"
      expr: dailies_delivered_flag
      comment: "Indicates whether dailies were delivered on schedule, a key post-production pipeline health indicator."
    - name: "shoot_day_number"
      expr: shoot_day_number
      comment: "Sequential shoot day number for production schedule progress tracking."
  measures:
    - name: "total_shoot_days"
      expr: COUNT(1)
      comment: "Total number of shoot days. Baseline production volume metric for schedule and capacity planning."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost across all shoot days. Core daily production spend metric for budget tracking."
    - name: "total_budget_allocated_amount"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to shoot days. Compared against actual cost to assess daily financial performance."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred across all shoot days. Key cost driver and crew welfare indicator."
    - name: "avg_footage_shot_minutes"
      expr: AVG(CAST(footage_shot_minutes AS DOUBLE))
      comment: "Average footage shot per day in minutes. Measures production throughput and crew efficiency."
    - name: "avg_script_pages_completed"
      expr: AVG(CAST(script_pages_completed AS DOUBLE))
      comment: "Average script pages completed per shoot day. Industry-standard production pace metric (target typically 3-8 pages/day)."
    - name: "schedule_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(script_pages_completed AS DOUBLE)) / NULLIF(SUM(CAST(script_pages_scheduled AS DOUBLE)), 0), 2)
      comment: "Actual pages completed vs. scheduled pages as a percentage. Primary production schedule adherence KPI for line producers."
    - name: "daily_cost_variance_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total cost variance (actual minus budget) across shoot days. Identifies systematic over/under-spend patterns in daily production."
    - name: "overtime_days_count"
      expr: COUNT(CASE WHEN is_overtime_incurred = TRUE THEN 1 END)
      comment: "Number of shoot days with overtime. Tracks crew welfare risk and unplanned cost exposure."
    - name: "dailies_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dailies_delivered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days where dailies were delivered on schedule. Measures post-production pipeline health and editorial readiness."
    - name: "avg_temperature_fahrenheit"
      expr: AVG(CAST(temperature_fahrenheit AS DOUBLE))
      comment: "Average temperature on shoot days. Supports crew safety analysis and weather-related production risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production crew assignment metrics for workforce cost management, union compliance, overtime exposure, and talent utilization across productions."
  source: "`vibe_media_broadcasting_v1`.`production`.`crew_assignment`"
  dimensions:
    - name: "department"
      expr: department
      comment: "Production department (camera, lighting, sound, art, etc.) for departmental cost and headcount analysis."
    - name: "union_guild_affiliation"
      expr: union_guild_affiliation
      comment: "Union or guild affiliation (IATSE, SAG-AFTRA, WGA, DGA, etc.) for labor compliance and residual obligation tracking."
    - name: "role_title"
      expr: role_title
      comment: "Crew role title for rate benchmarking and headcount planning by role."
    - name: "filming_location_country"
      expr: filming_location_country
      comment: "Country where filming occurs for international labor law compliance and tax incentive analysis."
    - name: "residuals_eligible"
      expr: residuals_eligible
      comment: "Flags assignments eligible for residual payments, informing long-term talent cost obligations."
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Flags assignments eligible for overtime pay, used for overtime cost exposure modeling."
    - name: "meal_penalty_eligible"
      expr: meal_penalty_eligible
      comment: "Flags assignments eligible for meal penalty charges, a common production cost overrun driver."
    - name: "work_permit_required"
      expr: work_permit_required
      comment: "Indicates whether a work permit is required, relevant for international production compliance."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the assignment started for workforce planning and seasonal crew demand analysis."
  measures:
    - name: "total_crew_assignments"
      expr: COUNT(1)
      comment: "Total number of crew assignments. Baseline headcount metric for production workforce planning."
    - name: "total_contracted_rate_spend"
      expr: SUM(CAST(contracted_rate AS DOUBLE))
      comment: "Total contracted rate value across all crew assignments. Core labor cost commitment metric for production finance."
    - name: "total_per_diem_rate"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem allowances across crew assignments. Tracks travel and living cost exposure for location productions."
    - name: "total_travel_allowance"
      expr: SUM(CAST(travel_allowance AS DOUBLE))
      comment: "Total travel allowances committed across crew. Significant cost driver for remote and international productions."
    - name: "total_box_rental_rate"
      expr: SUM(CAST(box_rental_rate AS DOUBLE))
      comment: "Total box/kit rental rates paid to crew. Tracks equipment rental cost embedded in crew deals."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate per crew assignment. Benchmarks labor rates against guild minimums and market rates."
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier across eligible assignments. Informs overtime cost modeling and scheduling decisions."
    - name: "residuals_eligible_crew_count"
      expr: COUNT(CASE WHEN residuals_eligible = TRUE THEN 1 END)
      comment: "Number of crew assignments eligible for residuals. Quantifies long-term talent cost obligations for financial planning."
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_hours AS DOUBLE))
      comment: "Average turnaround hours between shifts. Monitors crew rest compliance with union agreements and safety regulations."
    - name: "work_permit_required_count"
      expr: COUNT(CASE WHEN work_permit_required = TRUE THEN 1 END)
      comment: "Number of assignments requiring work permits. Tracks international compliance risk and HR administrative burden."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production deliverable metrics tracking QC pass rates, delivery timeliness, cost per deliverable, and compliance certification across all output formats."
  source: "`vibe_media_broadcasting_v1`.`production`.`deliverable`"
  dimensions:
    - name: "deliverable_type_id"
      expr: CAST(deliverable_type_id AS STRING)
      comment: "Type of deliverable (master, promo, trailer, localized version, etc.) for output mix analysis."
    - name: "delivery_method_id"
      expr: CAST(delivery_method_id AS STRING)
      comment: "Delivery method (satellite, FTP, hard drive, cloud) for logistics and cost analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "QC pass/fail status for quality performance tracking and remediation prioritization."
    - name: "audio_description_flag"
      expr: audio_description_flag
      comment: "Indicates whether audio description track is included, relevant for accessibility compliance tracking."
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Indicates whether closed captions are included, required for FCC compliance and accessibility."
    - name: "compliance_certificate_flag"
      expr: compliance_certificate_flag
      comment: "Flags deliverables with compliance certificates, tracking regulatory clearance completion."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the deliverable is due for pipeline load balancing and deadline management."
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of deliverables in the pipeline. Baseline output volume metric for production operations."
    - name: "total_deliverable_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all deliverables. Core post-production cost metric for budget tracking and vendor management."
    - name: "avg_deliverable_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per deliverable. Benchmarks post-production unit economics and vendor rate efficiency."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN qc_pass_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliverables passing QC on first submission. Critical quality KPI for post-production operations and vendor performance."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp AND actual_delivery_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN scheduled_delivery_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliverables delivered on or before scheduled time. Key SLA metric for distribution partner commitments."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of deliverables in seconds. Used for storage planning and encoding cost estimation."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all deliverables in bytes. Drives storage capacity planning and delivery bandwidth requirements."
    - name: "accessibility_compliant_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audio_description_flag = TRUE AND closed_caption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables meeting both audio description and closed caption requirements. Tracks accessibility compliance portfolio-wide."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control review metrics tracking error rates, review cycle times, remediation rates, and technical compliance across production deliverables."
  source: "`vibe_media_broadcasting_v1`.`production`.`qc_review`"
  dimensions:
    - name: "qc_result"
      expr: qc_result
      comment: "Overall QC result (pass, fail, conditional pass) for quality performance segmentation."
    - name: "qc_platform"
      expr: qc_platform
      comment: "QC platform or tool used (Cerify, Baton, Vidchecker, etc.) for platform performance benchmarking."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Flags reviews requiring remediation, enabling rework cost and delay impact analysis."
    - name: "loudness_compliance_flag"
      expr: loudness_compliance_flag
      comment: "Indicates loudness compliance (CALM Act / EBU R128) — a regulatory requirement for broadcast."
    - name: "closed_caption_compliance_flag"
      expr: closed_caption_compliance_flag
      comment: "Indicates closed caption compliance status for FCC regulatory tracking."
    - name: "audio_description_compliance_flag"
      expr: audio_description_compliance_flag
      comment: "Indicates audio description compliance for accessibility regulatory tracking."
    - name: "review_date_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of the QC review for trend analysis of quality performance over time."
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec of the reviewed asset for codec-level quality issue analysis."
  measures:
    - name: "total_qc_reviews"
      expr: COUNT(1)
      comment: "Total number of QC reviews conducted. Baseline throughput metric for post-production quality operations."
    - name: "first_pass_qc_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets passing QC on first review. Primary quality efficiency KPI — low rates indicate systemic production or encoding issues."
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC reviews requiring remediation. Measures rework burden and its impact on delivery timelines."
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average time to complete a QC review in minutes. Measures QC team efficiency and capacity planning."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness level in LUFS across reviewed assets. Monitors compliance with CALM Act and EBU R128 broadcast standards."
    - name: "loudness_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loudness_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets meeting loudness compliance standards. Regulatory compliance KPI for broadcast distribution."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_caption_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets meeting closed caption compliance. FCC regulatory compliance metric for broadcast operations."
    - name: "avg_video_frame_rate"
      expr: AVG(CAST(video_frame_rate AS DOUBLE))
      comment: "Average video frame rate of reviewed assets. Technical quality benchmark for format specification compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_post_production_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-production task metrics tracking workflow efficiency, cost performance, schedule adherence, and quality outcomes across editing, VFX, color, and audio tasks."
  source: "`vibe_media_broadcasting_v1`.`production`.`post_production_task`"
  dimensions:
    - name: "task_type_id"
      expr: CAST(task_type_id AS STRING)
      comment: "Type of post-production task (edit, color grade, VFX, audio mix, QC, etc.) for workflow analysis by task category."
    - name: "task_status_id"
      expr: CAST(task_status_id AS STRING)
      comment: "Current status of the task (pending, in-progress, complete, on-hold) for pipeline health monitoring."
    - name: "priority"
      expr: priority
      comment: "Task priority level for workload management and critical path analysis."
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "QC pass/fail outcome for the task, measuring quality at the workflow step level."
    - name: "scheduled_due_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_due_date)
      comment: "Month the task is due for pipeline load analysis and deadline management."
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of post-production tasks. Baseline workflow volume metric for capacity planning."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of post-production tasks. Core post-production spend metric for budget management."
    - name: "total_estimated_cost_amount"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of post-production tasks. Compared against actual to assess post-production cost accuracy."
    - name: "cost_variance_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) across post-production tasks. Identifies systematic cost estimation gaps."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(actual_duration_hours AS DOUBLE))
      comment: "Average actual duration per task in hours. Benchmarks post-production throughput and informs future scheduling."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per task. Compared against actual to assess scheduling accuracy."
    - name: "schedule_adherence_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_timestamp <= CAST(scheduled_due_date AS TIMESTAMP) AND actual_completion_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN scheduled_due_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of tasks completed on or before scheduled due date. Critical post-production pipeline health KPI."
    - name: "task_qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN qc_pass_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of post-production tasks passing QC. Measures workflow quality and rework rate at the task level."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_vfx_shot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VFX shot metrics tracking cost performance, delivery timeliness, revision cycles, and complexity distribution across visual effects production."
  source: "`vibe_media_broadcasting_v1`.`production`.`vfx_shot`"
  dimensions:
    - name: "vfx_category_id"
      expr: CAST(vfx_category_id AS STRING)
      comment: "VFX category (compositing, CGI, motion capture, etc.) for cost and complexity analysis by effect type."
    - name: "complexity_tier_id"
      expr: CAST(complexity_tier_id AS STRING)
      comment: "Complexity tier of the VFX shot (simple, medium, complex, hero) for cost benchmarking and resource planning."
    - name: "shot_status_id"
      expr: CAST(shot_status_id AS STRING)
      comment: "Current status of the VFX shot (brief, in-progress, review, approved, delivered) for pipeline tracking."
    - name: "resolution"
      expr: resolution
      comment: "Output resolution of the VFX shot (4K, 2K, HD) for technical specification compliance."
    - name: "delivery_version"
      expr: delivery_version
      comment: "Delivery version of the VFX shot for revision tracking and vendor performance analysis."
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month the VFX shot is scheduled for delivery for pipeline load and deadline management."
  measures:
    - name: "total_vfx_shots"
      expr: COUNT(1)
      comment: "Total number of VFX shots in production. Baseline scope metric for VFX budget and schedule planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual VFX cost across all shots. Core VFX spend metric for budget management and vendor payment."
    - name: "total_approved_cost"
      expr: SUM(CAST(approved_cost AS DOUBLE))
      comment: "Total approved VFX cost. Compared against actual to assess VFX cost control and vendor performance."
    - name: "total_bid_cost"
      expr: SUM(CAST(bid_cost AS DOUBLE))
      comment: "Total bid cost from VFX vendors. Compared against approved and actual to assess bid accuracy and negotiation outcomes."
    - name: "avg_actual_cost_per_shot"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per VFX shot. Industry benchmark metric for VFX unit economics and vendor rate assessment."
    - name: "vfx_cost_overrun_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(approved_cost AS DOUBLE))) / NULLIF(SUM(CAST(approved_cost AS DOUBLE)), 0), 2)
      comment: "VFX actual cost vs. approved cost as a percentage overrun. Key vendor performance and budget control metric."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN scheduled_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of VFX shots delivered on or before scheduled date. Vendor performance KPI for VFX house management."
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate of VFX shots. Technical compliance metric for format specification adherence."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production milestone metrics tracking schedule adherence, critical path performance, budget impact of delays, and approval cycle efficiency."
  source: "`vibe_media_broadcasting_v1`.`production`.`milestone`"
  dimensions:
    - name: "milestone_type_id"
      expr: CAST(milestone_type_id AS STRING)
      comment: "Type of milestone (greenlight, script lock, picture lock, delivery, etc.) for phase-gate performance analysis."
    - name: "milestone_status_id"
      expr: CAST(milestone_status_id AS STRING)
      comment: "Current status of the milestone (pending, in-progress, complete, at-risk) for pipeline health monitoring."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Flags milestones on the critical path — delays here directly impact delivery dates."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the milestone requires formal approval, relevant for governance and cycle time analysis."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the milestone for accountability and performance tracking by department."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone is planned for delivery pipeline and capacity analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of production milestones. Baseline scope metric for project complexity and governance tracking."
    - name: "on_time_milestone_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date <= planned_date AND actual_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of milestones completed on or before planned date. Primary production schedule adherence KPI for executive reporting."
    - name: "total_budget_impact_usd"
      expr: SUM(CAST(budget_impact_usd AS DOUBLE))
      comment: "Total financial impact of milestone delays in USD. Quantifies schedule risk in financial terms for executive decision-making."
    - name: "avg_budget_impact_usd"
      expr: AVG(CAST(budget_impact_usd AS DOUBLE))
      comment: "Average budget impact per milestone. Benchmarks the financial cost of schedule slippage."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of milestones on the critical path. Measures schedule risk concentration and delivery date exposure."
    - name: "critical_path_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_flag = TRUE AND actual_date <= planned_date AND actual_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN critical_path_flag = TRUE AND actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "On-time rate for critical path milestones only. Most important schedule KPI — critical path delays directly threaten delivery commitments."
    - name: "at_risk_milestone_count"
      expr: COUNT(CASE WHEN forecast_date > planned_date AND actual_date IS NULL THEN 1 END)
      comment: "Number of open milestones where forecast date exceeds planned date. Early warning indicator for schedule intervention."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_shoot_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shoot schedule metrics tracking production pace, overtime exposure, schedule efficiency, and daily production throughput."
  source: "`vibe_media_broadcasting_v1`.`production`.`shoot_schedule`"
  dimensions:
    - name: "shoot_type_id"
      expr: CAST(shoot_type_id AS STRING)
      comment: "Type of shoot (interior, exterior, studio, location, second unit) for schedule analysis by shoot type."
    - name: "schedule_status_id"
      expr: CAST(schedule_status_id AS STRING)
      comment: "Current status of the shoot schedule (draft, approved, active, completed) for pipeline tracking."
    - name: "is_overtime_day"
      expr: is_overtime_day
      comment: "Flags scheduled overtime days for cost exposure and crew welfare analysis."
    - name: "meal_penalty_flag"
      expr: meal_penalty_flag
      comment: "Flags schedules with meal penalty risk for union compliance and cost management."
    - name: "weather_contingency_flag"
      expr: weather_contingency_flag
      comment: "Flags schedules with weather contingency plans for risk management analysis."
    - name: "shoot_date_month"
      expr: DATE_TRUNC('MONTH', shoot_date)
      comment: "Month of the shoot for production pace and seasonal analysis."
    - name: "production_unit"
      expr: production_unit
      comment: "Production unit (main unit, second unit, splinter unit) for multi-unit production management."
  measures:
    - name: "total_scheduled_days"
      expr: COUNT(1)
      comment: "Total number of scheduled shoot days. Baseline production volume metric for capacity and cost planning."
    - name: "total_actual_shoot_hours"
      expr: SUM(CAST(actual_shoot_hours AS DOUBLE))
      comment: "Total actual hours shot across all scheduled days. Measures production throughput against planned hours."
    - name: "total_estimated_shoot_hours"
      expr: SUM(CAST(estimated_shoot_hours AS DOUBLE))
      comment: "Total estimated shoot hours. Compared against actual to assess scheduling accuracy."
    - name: "avg_page_count_per_day"
      expr: AVG(CAST(page_count AS DOUBLE))
      comment: "Average script pages scheduled per shoot day. Industry-standard production pace planning metric."
    - name: "shoot_hour_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_shoot_hours AS DOUBLE)) / NULLIF(SUM(CAST(estimated_shoot_hours AS DOUBLE)), 0), 2)
      comment: "Actual shoot hours as a percentage of estimated. Measures production efficiency and scheduling accuracy."
    - name: "overtime_day_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overtime_day = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days with overtime. Tracks crew welfare risk and unplanned labor cost exposure."
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_hours AS DOUBLE))
      comment: "Average crew turnaround hours between shoot days. Union compliance metric — minimum turnaround violations trigger penalties."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_insurance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production insurance portfolio metrics tracking coverage adequacy, premium spend, claims exposure, and compliance status across all production policies."
  source: "`vibe_media_broadcasting_v1`.`production`.`insurance_policy`"
  dimensions:
    - name: "policy_type_id"
      expr: CAST(policy_type_id AS STRING)
      comment: "Type of insurance policy (E&O, general liability, workers comp, equipment, etc.) for coverage portfolio analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Premium payment status for accounts payable and compliance tracking."
    - name: "renewal_flag"
      expr: renewal_flag
      comment: "Indicates whether the policy is a renewal, relevant for long-term vendor relationship and rate negotiation analysis."
    - name: "compliance_requirement_met_flag"
      expr: compliance_requirement_met_flag
      comment: "Flags policies meeting all compliance requirements — non-compliant policies represent production risk."
    - name: "claim_history_flag"
      expr: claim_history_flag
      comment: "Indicates whether the policy has a claims history, relevant for risk assessment and premium forecasting."
    - name: "policy_expiry_month"
      expr: DATE_TRUNC('MONTH', policy_expiration_date)
      comment: "Month of policy expiration for renewal pipeline management and coverage gap prevention."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of active insurance policies. Baseline coverage portfolio metric."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total insurance premium spend across all policies. Core risk management cost metric for production finance."
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total insurance coverage value across all policies. Measures overall risk protection adequacy for the production portfolio."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across all policies. Quantifies self-insured risk retained by the production company."
    - name: "total_claims_paid_amount"
      expr: SUM(CAST(total_claims_paid_amount AS DOUBLE))
      comment: "Total insurance claims paid across all policies. Measures actual loss experience and informs future premium negotiations."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirement_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies meeting all compliance requirements. Risk management KPI — non-compliance can halt production."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per policy. Benchmarks insurance cost efficiency and informs broker negotiation strategy."
    - name: "coverage_to_premium_ratio"
      expr: ROUND(SUM(CAST(coverage_amount AS DOUBLE)) / NULLIF(SUM(CAST(premium_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of total coverage to total premium spend. Measures insurance value efficiency — higher ratios indicate better coverage per dollar."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production episode metrics tracking budget performance, delivery timeliness, post-production completion rates, and content compliance across all episodes."
  source: "`vibe_media_broadcasting_v1`.`production`.`production_episode`"
  dimensions:
    - name: "production_status_id"
      expr: CAST(production_status_id AS STRING)
      comment: "Current production status of the episode for pipeline health and delivery forecasting."
    - name: "content_type_id"
      expr: CAST(content_type_id AS STRING)
      comment: "Content type of the episode (scripted, unscripted, documentary, etc.) for portfolio mix analysis."
    - name: "closed_captioning_compliant"
      expr: closed_captioning_compliant
      comment: "Indicates whether the episode meets closed captioning compliance requirements for FCC regulatory tracking."
    - name: "first_air_year"
      expr: YEAR(first_air_date)
      comment: "Year of first air date for vintage analysis and content lifecycle tracking."
    - name: "shoot_start_month"
      expr: DATE_TRUNC('MONTH', shoot_start_date)
      comment: "Month production shooting began for production calendar and capacity analysis."
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of production episodes. Baseline content volume metric for production portfolio management."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual production cost across all episodes in USD. Core financial performance metric for production finance."
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget across all episodes. Financial authorization baseline for budget variance analysis."
    - name: "avg_actual_cost_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per episode. Benchmarks per-episode production economics for greenlight and renewal decisions."
    - name: "episode_budget_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_usd AS DOUBLE)) - SUM(CAST(approved_budget_usd AS DOUBLE))) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Actual cost vs. approved budget variance as a percentage across episodes. Key financial control KPI for production finance."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of episodes delivered on or before target date. Critical KPI for distribution partner commitments and scheduling."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_captioning_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes meeting closed captioning compliance. FCC regulatory compliance metric for broadcast operations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_equipment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment allocation metrics tracking utilization rates, rental cost efficiency, damage exposure, and insurance compliance across production equipment."
  source: "`vibe_media_broadcasting_v1`.`production`.`equipment_allocation`"
  dimensions:
    - name: "equipment_category_id"
      expr: CAST(equipment_category_id AS STRING)
      comment: "Equipment category (camera, lighting, grip, sound, etc.) for cost and utilization analysis by category."
    - name: "allocation_status_id"
      expr: CAST(allocation_status_id AS STRING)
      comment: "Current allocation status (reserved, checked-out, returned, damaged) for equipment availability tracking."
    - name: "is_owned_asset"
      expr: is_owned_asset
      comment: "Distinguishes owned vs. rented equipment for make-vs-buy and capex analysis."
    - name: "is_insurance_required"
      expr: is_insurance_required
      comment: "Flags allocations requiring insurance coverage for compliance and risk management."
    - name: "production_department"
      expr: production_department
      comment: "Production department using the equipment for departmental cost allocation."
    - name: "rental_rate_type"
      expr: rental_rate_type
      comment: "Rental rate type (daily, weekly, flat) for cost structure analysis."
    - name: "allocation_start_month"
      expr: DATE_TRUNC('MONTH', allocation_start_date)
      comment: "Month the allocation started for equipment demand trend analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of equipment allocations. Baseline utilization volume metric for equipment management."
    - name: "total_rental_rate_amount"
      expr: SUM(CAST(rental_rate_amount AS DOUBLE))
      comment: "Total rental cost across all equipment allocations. Core equipment spend metric for production cost management."
    - name: "total_damage_claim_amount"
      expr: SUM(CAST(damage_claim_amount AS DOUBLE))
      comment: "Total damage claims across all equipment allocations. Risk and loss metric for equipment management and insurance planning."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total insured value of allocated equipment. Measures insurance coverage adequacy for equipment risk management."
    - name: "avg_rental_rate_amount"
      expr: AVG(CAST(rental_rate_amount AS DOUBLE))
      comment: "Average rental rate per allocation. Benchmarks equipment rental costs against market rates."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_claim_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations resulting in damage claims. Equipment care and handling quality metric."
    - name: "owned_vs_rented_ratio"
      expr: ROUND(COUNT(CASE WHEN is_owned_asset = TRUE THEN 1 END) * 1.0 / NULLIF(COUNT(CASE WHEN is_owned_asset = FALSE THEN 1 END), 0), 2)
      comment: "Ratio of owned to rented equipment allocations. Informs capex vs. opex equipment strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`production_daily_production_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily production report metrics aggregating on-set productivity, safety incidents, overtime patterns, and schedule variance for operational steering."
  source: "`vibe_media_broadcasting_v1`.`production`.`daily_production_report`"
  dimensions:
    - name: "production_unit"
      expr: production_unit
      comment: "Production unit (main, second unit, etc.) for multi-unit production performance comparison."
    - name: "accidents_incidents_flag"
      expr: accidents_incidents_flag
      comment: "Flags reports with safety incidents for crew safety trend analysis and risk management."
    - name: "meal_penalty_incurred_flag"
      expr: meal_penalty_incurred_flag
      comment: "Flags reports where meal penalties were incurred for union compliance and cost management."
    - name: "report_date_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month of the daily report for trend analysis of production pace and efficiency."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions on the shoot day for weather impact analysis on production efficiency."
  measures:
    - name: "total_report_days"
      expr: COUNT(1)
      comment: "Total number of daily production reports. Baseline production activity metric."
    - name: "total_pages_shot"
      expr: SUM(CAST(pages_shot AS DOUBLE))
      comment: "Total script pages shot across all report days. Primary production throughput metric for schedule tracking."
    - name: "avg_pages_shot_per_day"
      expr: AVG(CAST(pages_shot AS DOUBLE))
      comment: "Average script pages shot per day. Industry-standard production pace KPI — typically 3-8 pages/day for scripted drama."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours across all shoot days. Key cost driver and crew welfare indicator for production management."
    - name: "avg_total_crew_hours"
      expr: AVG(CAST(total_crew_hours AS DOUBLE))
      comment: "Average total crew hours per shoot day. Measures crew utilization and informs labor cost forecasting."
    - name: "total_digital_media_consumed_tb"
      expr: SUM(CAST(digital_media_consumed_tb AS DOUBLE))
      comment: "Total digital media storage consumed in terabytes. Drives storage capacity planning and data management costs."
    - name: "safety_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accidents_incidents_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days with safety incidents. Critical crew welfare and liability KPI for production management."
    - name: "avg_schedule_variance_days"
      expr: AVG(CAST(schedule_variance_days AS DOUBLE))
      comment: "Average schedule variance in days across all report days. Measures cumulative schedule drift and delivery date risk."
    - name: "meal_penalty_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN meal_penalty_incurred_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days incurring meal penalties. Union compliance metric and unplanned cost indicator."
$$;