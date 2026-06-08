-- Metric views for domain: production | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic production project performance metrics tracking budget efficiency, delivery timeliness, and project portfolio health for executive steering and resource allocation decisions."
  source: "`media_broadcasting_ecm`.`production`.`project`"
  dimensions:
    - name: "production_phase"
      expr: production_phase
      comment: "Current production phase (pre-production, principal photography, post-production) for lifecycle analysis"
    - name: "project_type"
      expr: project_type
      comment: "Type of production project (film, series, documentary, etc.) for portfolio segmentation"
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre classification for genre performance analysis"
    - name: "greenlight_status"
      expr: greenlight_status
      comment: "Project greenlight approval status for pipeline health monitoring"
    - name: "production_country"
      expr: production_country
      comment: "Country where production takes place for geographic cost and incentive analysis"
    - name: "greenlight_year"
      expr: YEAR(greenlight_date)
      comment: "Year project was greenlit for cohort analysis"
    - name: "greenlight_quarter"
      expr: CONCAT('Q', QUARTER(greenlight_date), '-', YEAR(greenlight_date))
      comment: "Quarter project was greenlit for seasonal trend analysis"
    - name: "co_production_flag"
      expr: co_production_flag
      comment: "Whether project is a co-production for partnership strategy analysis"
    - name: "drm_required"
      expr: drm_required
      comment: "Whether DRM is required for rights management complexity assessment"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of production projects for portfolio size tracking"
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved production budgets in USD for capital allocation visibility"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual production spend in USD for cost control and variance analysis"
    - name: "avg_approved_budget_usd"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average approved budget per project for investment sizing benchmarks"
    - name: "avg_actual_spend_usd"
      expr: AVG(CAST(actual_spend_usd AS DOUBLE))
      comment: "Average actual spend per project for cost efficiency benchmarking"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent - critical KPI for financial discipline and forecasting accuracy"
    - name: "projects_over_budget"
      expr: SUM(CASE WHEN CAST(actual_spend_usd AS DOUBLE) > CAST(approved_budget_usd AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of projects exceeding approved budget for risk management and oversight"
    - name: "projects_delivered_late"
      expr: SUM(CASE WHEN actual_delivery_date > target_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of projects delivered past target date for schedule performance tracking"
    - name: "greenlit_projects"
      expr: SUM(CASE WHEN greenlight_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of greenlit projects for pipeline conversion analysis"
    - name: "co_production_count"
      expr: SUM(CASE WHEN co_production_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of co-production projects for partnership strategy effectiveness"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production budget management metrics tracking cost control, variance, and fiscal discipline across production phases and cost categories for CFO and production finance teams."
  source: "`media_broadcasting_ecm`.`production`.`budget`"
  dimensions:
    - name: "production_phase"
      expr: production_phase
      comment: "Production phase for lifecycle cost analysis"
    - name: "cost_category_name"
      expr: cost_category_name
      comment: "Cost category for spend composition analysis"
    - name: "cost_line_type"
      expr: cost_line_type
      comment: "Type of cost line (above-the-line, below-the-line) for cost structure analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for governance and control tracking"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual budget performance reporting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly budget tracking"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency budget analysis"
    - name: "is_greenlight_budget"
      expr: is_greenlight_budget
      comment: "Whether this is the greenlight budget version for baseline tracking"
    - name: "is_locked"
      expr: is_locked
      comment: "Whether budget is locked for change control analysis"
  measures:
    - name: "total_budget_lines"
      expr: COUNT(1)
      comment: "Total number of budget line items for budget complexity tracking"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount for authorized spend ceiling"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual costs incurred for spend tracking and variance analysis"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amounts (POs issued) for cash flow forecasting"
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted spend for forward-looking budget projections"
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves for risk buffer analysis"
    - name: "budget_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs approved) for cost overrun visibility"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget utilized - key financial discipline KPI"
    - name: "commitment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget committed via POs for procurement velocity tracking"
    - name: "contingency_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(contingency_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount AS DOUBLE)), 0), 2)
      comment: "Contingency as percentage of approved budget for risk management adequacy"
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage across budget lines for risk planning benchmarks"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode-level production efficiency and delivery metrics tracking cost per episode, schedule adherence, and content readiness for series production management and content operations."
  source: "`media_broadcasting_ecm`.`production`.`production_episode`"
  dimensions:
    - name: "production_status"
      expr: production_status
      comment: "Current production status for pipeline stage analysis"
    - name: "content_type"
      expr: content_type
      comment: "Type of content (scripted, unscripted, etc.) for production model analysis"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating for audience targeting and compliance tracking"
    - name: "audio_language_code"
      expr: audio_language_code
      comment: "Primary audio language for localization strategy analysis"
    - name: "shoot_country_code"
      expr: shoot_country_code
      comment: "Country where episode was shot for production location analysis"
    - name: "master_format"
      expr: master_format
      comment: "Master format specification for technical standards tracking"
    - name: "closed_captioning_compliant"
      expr: closed_captioning_compliant
      comment: "Whether episode meets closed captioning requirements for accessibility compliance"
    - name: "greenlight_year"
      expr: YEAR(greenlight_date)
      comment: "Year episode was greenlit for cohort analysis"
    - name: "first_air_year"
      expr: YEAR(first_air_date)
      comment: "Year of first air date for release schedule analysis"
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of production episodes for volume tracking"
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved episode budgets for series investment visibility"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual episode costs for series cost control"
    - name: "avg_cost_per_episode_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average cost per episode - critical efficiency KPI for series economics"
    - name: "avg_approved_budget_per_episode_usd"
      expr: AVG(CAST(approved_budget_usd AS DOUBLE))
      comment: "Average approved budget per episode for planning benchmarks"
    - name: "episode_budget_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_usd AS DOUBLE)) - SUM(CAST(approved_budget_usd AS DOUBLE))) / NULLIF(SUM(CAST(approved_budget_usd AS DOUBLE)), 0), 2)
      comment: "Episode budget variance percentage for cost control effectiveness"
    - name: "episodes_delivered_late"
      expr: SUM(CASE WHEN actual_delivery_date > delivery_date THEN 1 ELSE 0 END)
      comment: "Count of episodes delivered late for schedule performance tracking"
    - name: "episodes_cc_compliant"
      expr: SUM(CASE WHEN closed_captioning_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of closed captioning compliant episodes for accessibility compliance rate"
    - name: "cc_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_captioning_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of episodes meeting closed captioning requirements - regulatory compliance KPI"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content deliverable fulfillment and quality metrics tracking on-time delivery, QC pass rates, and partner obligation compliance for distribution operations and content supply chain management."
  source: "`media_broadcasting_ecm`.`production`.`deliverable`"
  dimensions:
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Type of deliverable (master, proxy, trailer, etc.) for deliverable mix analysis"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status for fulfillment tracking"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (FTP, Aspera, physical) for logistics analysis"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Aspect ratio for technical specification compliance"
    - name: "language_code"
      expr: language_code
      comment: "Primary language for localization tracking"
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Whether deliverable passed QC for quality control analysis"
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Whether deliverable includes closed captions for accessibility compliance"
    - name: "audio_description_flag"
      expr: audio_description_flag
      comment: "Whether deliverable includes audio description for accessibility compliance"
    - name: "compliance_certificate_flag"
      expr: compliance_certificate_flag
      comment: "Whether compliance certificate is included for regulatory tracking"
    - name: "delivery_year"
      expr: YEAR(actual_delivery_timestamp)
      comment: "Year of actual delivery for trend analysis"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_timestamp)
      comment: "Month of actual delivery for monthly fulfillment tracking"
  measures:
    - name: "total_deliverables"
      expr: COUNT(1)
      comment: "Total number of deliverables for volume tracking"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of deliverables for supply chain cost visibility"
    - name: "avg_cost_per_deliverable"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per deliverable for efficiency benchmarking"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Total file size in gigabytes for storage and bandwidth planning"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE)) / 60.0
      comment: "Average duration in minutes for content length analysis"
    - name: "deliverables_qc_passed"
      expr: SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deliverables passing QC for quality performance tracking"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables passing QC - critical quality KPI for content operations"
    - name: "deliverables_on_time"
      expr: SUM(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp THEN 1 ELSE 0 END)
      comment: "Count of deliverables delivered on or before scheduled time for SLA tracking"
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_delivery_timestamp <= scheduled_delivery_timestamp THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables delivered on time - key SLA and partner satisfaction KPI"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_flag = TRUE AND audio_description_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliverables meeting full accessibility requirements - regulatory compliance KPI"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew resource utilization and labor cost metrics tracking assignment efficiency, union compliance, and crew capacity planning for production operations and labor relations."
  source: "`media_broadcasting_ecm`.`production`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status for crew availability tracking"
    - name: "department"
      expr: department
      comment: "Production department for departmental resource analysis"
    - name: "role_title"
      expr: role_title
      comment: "Crew role title for skill mix analysis"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (weekly, daily, flat) for compensation structure analysis"
    - name: "production_company"
      expr: production_company
      comment: "Production company for multi-company resource tracking"
    - name: "overtime_eligible"
      expr: overtime_eligible
      comment: "Whether crew member is eligible for overtime for labor cost modeling"
    - name: "residuals_eligible"
      expr: residuals_eligible
      comment: "Whether crew member is eligible for residuals for long-term cost planning"
    - name: "work_permit_required"
      expr: work_permit_required
      comment: "Whether work permit is required for immigration compliance tracking"
    - name: "safety_training_certified"
      expr: safety_training_certified
      comment: "Whether crew member is safety certified for safety compliance tracking"
    - name: "assignment_year"
      expr: YEAR(start_date)
      comment: "Year of assignment start for workforce trend analysis"
  measures:
    - name: "total_crew_assignments"
      expr: COUNT(1)
      comment: "Total number of crew assignments for workforce volume tracking"
    - name: "unique_crew_members"
      expr: COUNT(DISTINCT talent_profile_id)
      comment: "Count of unique crew members for workforce capacity analysis"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate per crew member for labor cost benchmarking"
    - name: "total_box_rental_cost"
      expr: SUM(CAST(box_rental_rate AS DOUBLE))
      comment: "Total box rental costs for equipment rental expense tracking"
    - name: "total_kit_rental_cost"
      expr: SUM(CAST(kit_rental_rate AS DOUBLE))
      comment: "Total kit rental costs for equipment rental expense tracking"
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem costs for living expense tracking"
    - name: "total_travel_allowance"
      expr: SUM(CAST(travel_allowance AS DOUBLE))
      comment: "Total travel allowances for travel expense tracking"
    - name: "avg_overtime_rate_multiplier"
      expr: AVG(CAST(overtime_rate_multiplier AS DOUBLE))
      comment: "Average overtime rate multiplier for overtime cost modeling"
    - name: "crew_safety_certified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_training_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crew with safety certification - critical safety compliance KPI"
    - name: "work_permit_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN work_permit_required = FALSE OR work_permit_expiry_date >= CURRENT_DATE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crew in compliance with work permit requirements - immigration compliance KPI"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_qc_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control review performance metrics tracking QC pass rates, error severity distribution, and remediation efficiency for content quality assurance and technical operations."
  source: "`media_broadcasting_ecm`.`production`.`qc_review`"
  dimensions:
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC review (technical, editorial, compliance) for QC process analysis"
    - name: "qc_result"
      expr: qc_result
      comment: "Result of QC review (pass, fail, conditional) for quality outcome tracking"
    - name: "review_status"
      expr: review_status
      comment: "Current review status for QC workflow tracking"
    - name: "final_approval_status"
      expr: final_approval_status
      comment: "Final approval status for release readiness tracking"
    - name: "qc_platform"
      expr: qc_platform
      comment: "QC platform used for tool effectiveness analysis"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec for technical specification compliance"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec for technical specification compliance"
    - name: "closed_caption_compliance_flag"
      expr: closed_caption_compliance_flag
      comment: "Whether closed caption compliance was met for accessibility tracking"
    - name: "loudness_compliance_flag"
      expr: loudness_compliance_flag
      comment: "Whether loudness compliance was met for broadcast standards tracking"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required for rework tracking"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of review for monthly QC performance tracking"
  measures:
    - name: "total_qc_reviews"
      expr: COUNT(1)
      comment: "Total number of QC reviews for QC volume tracking"
    - name: "qc_reviews_passed"
      expr: SUM(CASE WHEN qc_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of QC reviews passed for quality performance tracking"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC reviews passed on first attempt - critical quality efficiency KPI"
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average QC review duration in minutes for QC efficiency benchmarking"
    - name: "total_p1_critical_errors"
      expr: SUM(CAST(p1_critical_error_count AS BIGINT))
      comment: "Total P1 critical errors for severity analysis and quality improvement"
    - name: "total_p2_major_errors"
      expr: SUM(CAST(p2_major_error_count AS BIGINT))
      comment: "Total P2 major errors for severity analysis and quality improvement"
    - name: "total_p3_minor_errors"
      expr: SUM(CAST(p3_minor_error_count AS BIGINT))
      comment: "Total P3 minor errors for severity analysis and quality improvement"
    - name: "avg_total_errors_per_review"
      expr: AVG(CAST(total_error_count AS BIGINT))
      comment: "Average total errors per review for quality trend tracking"
    - name: "remediation_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews requiring remediation - rework cost and efficiency KPI"
    - name: "cc_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews meeting closed caption compliance - accessibility compliance KPI"
    - name: "loudness_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN loudness_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews meeting loudness compliance - broadcast standards compliance KPI"
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness in LUFS for audio quality benchmarking"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_shoot_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production shoot efficiency and labor compliance metrics tracking shoot day utilization, overtime frequency, and schedule adherence for production management and labor cost control."
  source: "`media_broadcasting_ecm`.`production`.`shoot_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current schedule status for shoot planning tracking"
    - name: "shoot_type"
      expr: shoot_type
      comment: "Type of shoot (principal, second unit, pickup) for production activity analysis"
    - name: "production_unit"
      expr: production_unit
      comment: "Production unit for multi-unit resource tracking"
    - name: "day_out_of_days_type"
      expr: day_out_of_days_type
      comment: "Day out of days classification (work, travel, hold) for crew scheduling analysis"
    - name: "is_overtime_day"
      expr: is_overtime_day
      comment: "Whether shoot day involved overtime for labor cost tracking"
    - name: "meal_penalty_flag"
      expr: meal_penalty_flag
      comment: "Whether meal penalties were incurred for labor compliance tracking"
    - name: "weather_contingency_flag"
      expr: weather_contingency_flag
      comment: "Whether weather contingency was activated for risk event tracking"
    - name: "shoot_month"
      expr: DATE_TRUNC('MONTH', shoot_date)
      comment: "Month of shoot for monthly production activity tracking"
    - name: "shoot_year"
      expr: YEAR(shoot_date)
      comment: "Year of shoot for annual production trend analysis"
  measures:
    - name: "total_shoot_days"
      expr: COUNT(1)
      comment: "Total number of shoot days for production volume tracking"
    - name: "total_page_count"
      expr: SUM(CAST(page_count AS DOUBLE))
      comment: "Total script pages shot for production progress tracking"
    - name: "avg_pages_per_day"
      expr: AVG(CAST(page_count AS DOUBLE))
      comment: "Average script pages shot per day - critical production efficiency KPI"
    - name: "total_actual_shoot_hours"
      expr: SUM(CAST(actual_shoot_hours AS DOUBLE))
      comment: "Total actual shoot hours for labor hour tracking"
    - name: "avg_shoot_hours_per_day"
      expr: AVG(CAST(actual_shoot_hours AS DOUBLE))
      comment: "Average shoot hours per day for schedule intensity analysis"
    - name: "overtime_days"
      expr: SUM(CASE WHEN is_overtime_day = TRUE THEN 1 ELSE 0 END)
      comment: "Count of overtime shoot days for labor cost and compliance tracking"
    - name: "overtime_day_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_overtime_day = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days involving overtime - labor cost control KPI"
    - name: "meal_penalty_days"
      expr: SUM(CASE WHEN meal_penalty_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of days with meal penalties for labor compliance tracking"
    - name: "meal_penalty_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN meal_penalty_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shoot days incurring meal penalties - union compliance and cost KPI"
    - name: "weather_contingency_days"
      expr: SUM(CASE WHEN weather_contingency_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of days with weather contingency activated for risk event tracking"
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_hours AS DOUBLE))
      comment: "Average turnaround hours between shoot days for crew rest compliance tracking"
$$;