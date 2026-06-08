-- Metric views for domain: campaign | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign-level KPIs covering budget performance, targeting efficiency, and portfolio health. Used by CMOs, campaign directors, and media planners to steer investment allocation and campaign strategy."
  source: "`advertising_ecm`.`campaign`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Lifecycle status of the campaign (e.g. Active, Paused, Completed, Draft) — primary filter for operational vs. historical analysis."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Classification of the campaign by type (e.g. Brand Awareness, Performance, Retargeting) — used to segment KPIs by strategic intent."
    - name: "campaign_tier"
      expr: campaign_tier
      comment: "Priority tier assigned to the campaign (e.g. Tier 1, Tier 2) — enables executive focus on high-value campaigns."
    - name: "objective"
      expr: objective
      comment: "Primary business objective of the campaign (e.g. Awareness, Conversion, Engagement) — aligns KPIs to campaign goals."
    - name: "primary_kpi"
      expr: primary_kpi
      comment: "The declared primary KPI for the campaign (e.g. CPM, CPA, CTR) — used to group campaigns by measurement approach."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the campaign budget is denominated — essential for multi-currency portfolio analysis."
    - name: "iab_category"
      expr: iab_category
      comment: "IAB content category of the campaign — used for brand safety and industry vertical analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the campaign — used to track governance compliance and pipeline readiness."
    - name: "pacing_strategy"
      expr: pacing_strategy
      comment: "Pacing approach applied to the campaign (e.g. Even, Front-loaded, ASAP) — informs delivery risk assessment."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started — enables trend analysis of campaign launches over time."
    - name: "campaign_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the campaign ends — used for forward-looking capacity and budget planning."
    - name: "brand_safety_level"
      expr: brand_safety_level
      comment: "Brand safety classification applied to the campaign — used to assess risk exposure across the portfolio."
    - name: "geo_targeting"
      expr: geo_targeting
      comment: "Geographic targeting scope of the campaign — used for regional performance segmentation."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device targeting configuration (e.g. Mobile, Desktop, CTV) — used to analyze cross-device investment distribution."
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Total number of distinct campaigns — baseline portfolio size metric used in executive dashboards and capacity planning."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total committed budget across all campaigns — primary financial exposure metric for CFO and CMO investment oversight."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign — used to benchmark campaign investment levels and identify outliers in portfolio sizing."
    - name: "total_target_cpa"
      expr: SUM(CAST(target_cpa AS DOUBLE))
      comment: "Sum of target CPA values across campaigns — used to assess aggregate acquisition cost ambition across the portfolio."
    - name: "avg_target_cpa"
      expr: AVG(CAST(target_cpa AS DOUBLE))
      comment: "Average target cost-per-acquisition across campaigns — benchmarks efficiency goals and informs bid strategy decisions."
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM across campaigns — used by media planners to assess pricing ambition and negotiate media rates."
    - name: "avg_target_ctr"
      expr: AVG(CAST(target_ctr AS DOUBLE))
      comment: "Average target click-through rate across campaigns — benchmarks creative and audience engagement expectations."
    - name: "avg_target_roas"
      expr: AVG(CAST(target_roas AS DOUBLE))
      comment: "Average target return on ad spend across campaigns — key profitability benchmark used by performance marketing leadership."
    - name: "active_campaigns"
      expr: COUNT(DISTINCT CASE WHEN campaign_status = 'Active' THEN campaign_id END)
      comment: "Number of currently active campaigns — operational health metric used to monitor live portfolio size and resource load."
    - name: "approved_campaigns"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN campaign_id END)
      comment: "Number of campaigns that have received formal approval — governance compliance metric tracking readiness for launch."
    - name: "total_budget_active_campaigns"
      expr: SUM(CASE WHEN campaign_status = 'Active' THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget committed to currently active campaigns — live financial exposure metric for treasury and media finance teams."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_budget_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget execution and pacing KPIs tracking planned vs. actual spend, remaining budget, and delivery risk across campaigns and flights. Used by finance controllers, media planners, and campaign operations to manage budget health."
  source: "`advertising_ecm`.`campaign`.`budget_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the budget allocation (e.g. Active, Exhausted, Paused) — primary filter for operational budget monitoring."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate budget (e.g. Even, Weighted, Manual) — used to analyze pacing strategy effectiveness."
    - name: "budget_period_type"
      expr: budget_period_type
      comment: "Period granularity of the budget (e.g. Daily, Weekly, Monthly, Flight) — used to segment spend analysis by time horizon."
    - name: "budget_source"
      expr: budget_source
      comment: "Origin of the budget (e.g. Client PO, Internal, Agency) — used for financial reconciliation and source-of-funds reporting."
    - name: "channel_type"
      expr: channel_type
      comment: "Media channel associated with the budget allocation (e.g. Display, Video, Social) — enables cross-channel spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget allocation — required for multi-currency financial consolidation."
    - name: "pacing_type"
      expr: pacing_type
      comment: "Pacing strategy applied to this allocation (e.g. Even, Accelerated) — used to diagnose delivery risk."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Financial reconciliation state of the allocation — used by finance to track billing accuracy and close periods."
    - name: "over_delivery_action"
      expr: over_delivery_action
      comment: "Configured action when over-delivery occurs (e.g. Stop, Continue, Alert) — used to assess delivery risk governance."
    - name: "auto_optimization_enabled"
      expr: auto_optimization_enabled
      comment: "Whether automated budget optimization is active — used to segment performance of AI-optimized vs. manually managed allocations."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget allocation becomes effective — used for monthly spend trend analysis."
    - name: "last_reconciliation_month"
      expr: DATE_TRUNC('MONTH', last_reconciliation_date)
      comment: "Month of the last financial reconciliation — used to identify stale or unreconciled allocations."
  measures:
    - name: "total_planned_budget"
      expr: SUM(CAST(planned_budget_amount AS DOUBLE))
      comment: "Total planned budget across all allocations — baseline financial commitment metric for campaign investment oversight."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend recorded against budget allocations — primary financial execution metric for campaign finance reporting."
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend AS DOUBLE))
      comment: "Total committed (reserved but not yet invoiced) spend — used for cash flow forecasting and liability management."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Total remaining unspent budget — critical pacing health metric used to identify under-delivery risk and reallocation opportunities."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after amendments — used to track budget change magnitude and financial governance compliance."
    - name: "avg_over_delivery_tolerance_pct"
      expr: AVG(CAST(over_delivery_tolerance_pct AS DOUBLE))
      comment: "Average over-delivery tolerance percentage across allocations — used to assess delivery risk appetite and governance standards."
    - name: "avg_pacing_alert_threshold_pct"
      expr: AVG(CAST(pacing_alert_threshold_pct AS DOUBLE))
      comment: "Average pacing alert threshold percentage — used to benchmark sensitivity of pacing monitoring across campaigns."
    - name: "total_daily_spend_cap"
      expr: SUM(CAST(daily_spend_cap AS DOUBLE))
      comment: "Total daily spend cap across all active allocations — used to assess maximum daily financial exposure."
    - name: "total_weekly_spend_cap"
      expr: SUM(CAST(weekly_spend_cap AS DOUBLE))
      comment: "Total weekly spend cap across all allocations — used for weekly budget governance and pacing oversight."
    - name: "budget_variance"
      expr: SUM((CAST(revised_budget_amount AS DOUBLE)) - (CAST(planned_budget_amount AS DOUBLE)))
      comment: "Aggregate difference between revised and planned budget — measures total budget change magnitude, a key financial governance KPI."
    - name: "spend_vs_committed_variance"
      expr: SUM((CAST(actual_spend AS DOUBLE)) - (CAST(committed_spend AS DOUBLE)))
      comment: "Difference between actual spend and committed spend — identifies billing discrepancies and accrual accuracy for finance reconciliation."
    - name: "total_daily_impression_goal"
      expr: SUM(CAST(daily_impression_goal AS DOUBLE))
      comment: "Total daily impression delivery goal across all allocations — used to assess aggregate delivery ambition and capacity planning."
    - name: "total_weekly_impression_goal"
      expr: SUM(CAST(weekly_impression_goal AS DOUBLE))
      comment: "Total weekly impression delivery goal — used for weekly pacing reviews and delivery performance benchmarking."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level delivery, cost, and booking KPIs. The line item is the atomic unit of media buying — these metrics drive day-to-day campaign operations, billing reconciliation, and delivery performance management."
  source: "`advertising_ecm`.`campaign`.`line_item`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Media channel of the line item (e.g. Display, Video, Search, Social) — primary dimension for cross-channel performance analysis."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format of the line item (e.g. Banner, Pre-roll, Native) — used to analyze format-level delivery and cost efficiency."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of media placement (e.g. Programmatic, Direct, Sponsorship) — used to segment buying method performance."
    - name: "rate_type"
      expr: rate_type
      comment: "Pricing model of the line item (e.g. CPM, CPC, CPA, Flat) — essential for cost analysis and billing reconciliation."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery state of the line item (e.g. Delivering, Under-delivering, Completed) — operational health indicator."
    - name: "pacing_status"
      expr: pacing_status
      comment: "Pacing health of the line item (e.g. On Track, Behind, Ahead) — used to trigger delivery interventions."
    - name: "trafficking_status"
      expr: trafficking_status
      comment: "Trafficking state of the line item (e.g. Trafficked, Pending, Error) — used to track operational readiness."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Whether the line item is bought programmatically — used to segment programmatic vs. direct buying performance."
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety classification applied to the line item — used to assess risk exposure by buying tier."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item cost — required for multi-currency financial consolidation."
    - name: "pacing_strategy"
      expr: pacing_strategy
      comment: "Pacing strategy applied to the line item — used to analyze delivery strategy effectiveness."
    - name: "creative_assignment_status"
      expr: creative_assignment_status
      comment: "Status of creative assignment to the line item — used to identify line items at risk due to missing creatives."
    - name: "line_item_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the line item starts — used for monthly delivery and spend trend analysis."
  measures:
    - name: "total_line_items"
      expr: COUNT(DISTINCT line_item_id)
      comment: "Total number of distinct line items — baseline operational volume metric for campaign complexity and trafficking workload assessment."
    - name: "total_gross_cost"
      expr: SUM(CAST(gross_cost AS DOUBLE))
      comment: "Total gross cost across all line items — primary revenue recognition metric for billing and client invoicing."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after agency commission — used for margin analysis and profitability reporting."
    - name: "total_agency_commission"
      expr: SUM((CAST(gross_cost AS DOUBLE)) - (CAST(net_cost AS DOUBLE)))
      comment: "Total agency commission earned (gross minus net cost) — key revenue line for agency P&L and client billing transparency."
    - name: "avg_agency_commission_rate"
      expr: AVG(CAST(agency_commission_rate AS DOUBLE))
      comment: "Average agency commission rate across line items — used to benchmark commission structures and negotiate client agreements."
    - name: "total_booked_impressions"
      expr: SUM(CAST(booked_impressions AS DOUBLE))
      comment: "Total booked impression volume — measures contracted delivery commitment and is the primary reach planning metric."
    - name: "total_booked_clicks"
      expr: SUM(CAST(booked_clicks AS DOUBLE))
      comment: "Total booked click volume — measures contracted engagement commitment for performance campaigns."
    - name: "total_booked_conversions"
      expr: SUM(CAST(booked_conversions AS DOUBLE))
      comment: "Total booked conversion volume — measures contracted acquisition commitment for CPA campaigns."
    - name: "total_booked_views"
      expr: SUM(CAST(booked_views AS DOUBLE))
      comment: "Total booked video view volume — measures contracted video engagement commitment for video campaigns."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average rate amount across line items — used to benchmark media pricing and identify rate anomalies."
    - name: "avg_viewability_target_pct"
      expr: AVG(CAST(viewability_target_percentage AS DOUBLE))
      comment: "Average viewability target percentage across line items — used to assess quality standards and benchmark against industry norms."
    - name: "programmatic_line_items"
      expr: COUNT(DISTINCT CASE WHEN is_programmatic = TRUE THEN line_item_id END)
      comment: "Number of programmatic line items — used to track programmatic adoption rate and buying channel mix."
    - name: "total_gross_cost_programmatic"
      expr: SUM(CASE WHEN is_programmatic = TRUE THEN CAST(gross_cost AS DOUBLE) ELSE 0 END)
      comment: "Total gross cost from programmatic line items — used to measure programmatic spend share and channel investment mix."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight-level reach, frequency, and budget KPIs. Flights represent discrete campaign execution windows — these metrics are used by media planners and campaign managers to evaluate delivery ambition, audience reach, and budget allocation across campaign phases."
  source: "`advertising_ecm`.`campaign`.`flight`"
  dimensions:
    - name: "flight_status"
      expr: flight_status
      comment: "Lifecycle status of the flight (e.g. Active, Completed, Paused) — primary operational filter for live vs. historical analysis."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Media channel mix configured for the flight — used to analyze multi-channel delivery strategy."
    - name: "pacing_type"
      expr: pacing_type
      comment: "Pacing strategy applied to the flight (e.g. Even, Front-loaded) — used to diagnose delivery risk."
    - name: "objective"
      expr: objective
      comment: "Business objective of the flight (e.g. Awareness, Conversion) — used to segment KPIs by strategic intent."
    - name: "geo_targeting"
      expr: geo_targeting
      comment: "Geographic targeting scope of the flight — used for regional delivery analysis."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device targeting configuration of the flight — used to analyze cross-device delivery distribution."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the flight budget — required for multi-currency financial consolidation."
    - name: "creative_rotation"
      expr: creative_rotation
      comment: "Creative rotation strategy applied to the flight (e.g. Even, Weighted, Sequential) — used to assess creative strategy effectiveness."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the flight starts — used for monthly delivery trend analysis and capacity planning."
    - name: "flight_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the flight ends — used for forward-looking delivery and budget planning."
  measures:
    - name: "total_flights"
      expr: COUNT(DISTINCT flight_id)
      comment: "Total number of distinct flights — baseline operational volume metric for campaign execution complexity."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated across all flights — primary financial commitment metric for flight-level investment oversight."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget per flight — used to benchmark flight investment levels and identify outliers."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total target impression volume across flights — measures aggregate reach ambition and is the primary delivery planning metric."
    - name: "total_target_reach"
      expr: SUM(CAST(target_reach AS DOUBLE))
      comment: "Total target unique reach across flights — measures audience breadth ambition for brand campaigns."
    - name: "avg_target_frequency"
      expr: AVG(CAST(target_frequency AS DOUBLE))
      comment: "Average target frequency across flights — used to assess message repetition strategy and frequency cap alignment."
    - name: "avg_target_grp"
      expr: AVG(CAST(target_grp AS DOUBLE))
      comment: "Average target Gross Rating Points across flights — traditional broadcast reach-frequency metric used for TV and video planning."
    - name: "avg_target_trp"
      expr: AVG(CAST(target_trp AS DOUBLE))
      comment: "Average target Target Rating Points across flights — audience-specific reach metric used for demographic targeting effectiveness."
    - name: "active_flights"
      expr: COUNT(DISTINCT CASE WHEN flight_status = 'Active' THEN flight_id END)
      comment: "Number of currently active flights — operational health metric for live delivery monitoring and resource allocation."
    - name: "total_budget_active_flights"
      expr: SUM(CASE WHEN flight_status = 'Active' THEN CAST(budget_allocated AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to currently active flights — live financial exposure metric for treasury and media finance oversight."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_creative_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Creative performance KPIs at the assignment level, measuring engagement rates, delivery volume, and creative effectiveness. Used by creative strategists, media planners, and performance analysts to optimize creative rotation and assess asset ROI."
  source: "`advertising_ecm`.`campaign`.`creative_assignment`"
  dimensions:
    - name: "trafficking_status"
      expr: trafficking_status
      comment: "Trafficking state of the creative assignment (e.g. Live, Pending, Paused) — used to filter active vs. inactive creative assignments."
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority rank of the creative assignment within its rotation — used to analyze performance by creative priority tier."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the creative assignment started — used for monthly creative performance trend analysis."
    - name: "assignment_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the creative assignment ends — used for creative lifecycle and rotation planning."
  measures:
    - name: "total_creative_assignments"
      expr: COUNT(DISTINCT creative_assignment_id)
      comment: "Total number of distinct creative assignments — measures creative portfolio breadth and rotation complexity."
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total impressions delivered across all creative assignments — primary reach delivery metric for campaign performance reporting."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks generated across all creative assignments — primary engagement metric for performance campaign optimization."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to creative assignments — primary acquisition metric for CPA campaign performance."
    - name: "total_views"
      expr: SUM(CAST(view_count AS DOUBLE))
      comment: "Total video views across creative assignments — primary video engagement metric for video campaign performance."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate across creative assignments — key creative effectiveness metric used to rank and optimize creative assets."
    - name: "avg_rotation_weight"
      expr: AVG(CAST(rotation_weight AS DOUBLE))
      comment: "Average rotation weight assigned to creatives — used to assess creative weighting strategy and identify imbalanced rotations."
    - name: "clicks_per_impression"
      expr: SUM(CAST(click_count AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0)
      comment: "Aggregate click-through rate computed from raw counts — more statistically robust than averaging per-assignment CTR; used for portfolio-level creative performance benchmarking."
    - name: "conversions_per_click"
      expr: SUM(CAST(conversion_count AS DOUBLE)) / NULLIF(SUM(CAST(click_count AS DOUBLE)), 0)
      comment: "Aggregate post-click conversion rate — measures creative-to-conversion funnel efficiency; used to identify high-converting creative assets."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI target governance metrics tracking target ambition, benchmark alignment, and stretch goal setting across campaigns. Used by strategy and analytics teams to assess goal-setting rigor and performance target coverage."
  source: "`advertising_ecm`.`campaign`.`campaign_kpi_target`"
  dimensions:
    - name: "kpi_type"
      expr: kpi_type
      comment: "Type of KPI being targeted (e.g. CTR, CPA, ROAS, Viewability) — primary dimension for KPI portfolio analysis."
    - name: "target_status"
      expr: target_status
      comment: "Current status of the KPI target (e.g. Active, Achieved, Missed, Revised) — used to track goal attainment across campaigns."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Media channel scope of the KPI target — used to segment performance targets by channel."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the KPI target — used for regional performance target analysis."
    - name: "is_primary_kpi"
      expr: is_primary_kpi
      comment: "Whether this is the primary KPI for the campaign — used to focus analysis on the most strategically important targets."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of KPI measurement (e.g. Ad Server, Third-Party, Client) — used to assess measurement methodology consistency."
    - name: "reporting_cadence"
      expr: reporting_cadence
      comment: "Frequency at which this KPI is reported (e.g. Daily, Weekly, Monthly) — used to align reporting infrastructure to target governance."
    - name: "optimization_priority"
      expr: optimization_priority
      comment: "Priority level for optimizing toward this KPI — used to rank competing objectives in multi-KPI campaigns."
    - name: "target_period"
      expr: target_period
      comment: "Time period the KPI target applies to (e.g. Flight, Monthly, Campaign) — used to align targets to planning horizons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the KPI target value — required for financial KPI targets in multi-currency environments."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the KPI target becomes effective — used for target timeline analysis."
  measures:
    - name: "total_kpi_targets"
      expr: COUNT(DISTINCT campaign_kpi_target_id)
      comment: "Total number of KPI targets defined — measures goal-setting coverage and governance rigor across the campaign portfolio."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all KPI target values — used to assess aggregate performance ambition across the portfolio."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average KPI target value — used to benchmark goal-setting levels and identify outlier targets."
    - name: "avg_stretch_target_value"
      expr: AVG(CAST(stretch_target_value AS DOUBLE))
      comment: "Average stretch target value — measures the ambition premium above baseline targets; used to assess organizational performance culture."
    - name: "avg_benchmark_value"
      expr: AVG(CAST(benchmark_value AS DOUBLE))
      comment: "Average industry or historical benchmark value — used to assess whether targets are set above or below market norms."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline performance value — used to measure improvement ambition relative to historical starting points."
    - name: "avg_alert_threshold_pct"
      expr: AVG(CAST(alert_threshold_percentage AS DOUBLE))
      comment: "Average alert threshold percentage across KPI targets — used to assess sensitivity of performance monitoring governance."
    - name: "primary_kpi_targets"
      expr: COUNT(DISTINCT CASE WHEN is_primary_kpi = TRUE THEN campaign_kpi_target_id END)
      comment: "Number of primary KPI targets — used to ensure every campaign has a clearly designated primary success metric."
    - name: "stretch_vs_target_premium"
      expr: AVG(CAST(stretch_target_value AS DOUBLE)) - AVG(CAST(target_value AS DOUBLE))
      comment: "Average premium of stretch targets above base targets — measures organizational ambition and goal-setting aggressiveness."
    - name: "target_vs_benchmark_delta"
      expr: AVG(CAST(target_value AS DOUBLE)) - AVG(CAST(benchmark_value AS DOUBLE))
      comment: "Average difference between set targets and industry benchmarks — positive values indicate above-market ambition; used in strategy reviews."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`campaign_trafficking_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trafficking operations KPIs measuring order execution speed, QA quality, SLA compliance, and operational throughput. Used by ad operations managers and trafficking teams to monitor workflow efficiency and delivery readiness."
  source: "`advertising_ecm`.`campaign`.`trafficking_order`"
  dimensions:
    - name: "trafficking_status"
      expr: trafficking_status
      comment: "Current status of the trafficking order (e.g. Submitted, In Progress, Completed, Rejected) — primary operational filter."
    - name: "trafficking_type"
      expr: trafficking_type
      comment: "Type of trafficking order (e.g. New, Revision, Cancellation) — used to segment workload by order type."
    - name: "qa_status"
      expr: qa_status
      comment: "Quality assurance status of the trafficking order (e.g. Passed, Failed, Pending) — used to track QA throughput and error rates."
    - name: "pixel_firing_validation_status"
      expr: pixel_firing_validation_status
      comment: "Pixel firing validation result — used to identify tracking setup errors that would compromise measurement accuracy."
    - name: "vast_tag_validation_status"
      expr: vast_tag_validation_status
      comment: "VAST tag validation result — used to identify video ad serving errors before campaign launch."
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether the trafficking SLA was met — primary SLA compliance dimension for operations performance reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the trafficking order — used to analyze SLA compliance and throughput by priority tier."
    - name: "go_live_month"
      expr: DATE_TRUNC('MONTH', go_live_date)
      comment: "Month the trafficking order is scheduled to go live — used for workload forecasting and capacity planning."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the trafficking order was submitted — used for monthly throughput trend analysis."
  measures:
    - name: "total_trafficking_orders"
      expr: COUNT(DISTINCT trafficking_order_id)
      comment: "Total number of trafficking orders — baseline operational throughput metric for ad operations capacity planning."
    - name: "sla_compliant_orders"
      expr: COUNT(DISTINCT CASE WHEN sla_met_flag = TRUE THEN trafficking_order_id END)
      comment: "Number of trafficking orders that met their SLA — primary operations quality metric used in client SLA reporting and team performance reviews."
    - name: "qa_passed_orders"
      expr: COUNT(DISTINCT CASE WHEN qa_status = 'Passed' THEN trafficking_order_id END)
      comment: "Number of trafficking orders that passed QA — measures quality control effectiveness and first-pass accuracy."
    - name: "qa_failed_orders"
      expr: COUNT(DISTINCT CASE WHEN qa_status = 'Failed' THEN trafficking_order_id END)
      comment: "Number of trafficking orders that failed QA — used to identify quality issues, rework volume, and training needs."
    - name: "pixel_validation_passed_orders"
      expr: COUNT(DISTINCT CASE WHEN pixel_firing_validation_status = 'Passed' THEN trafficking_order_id END)
      comment: "Number of orders with validated pixel firing — measures measurement setup quality and reduces risk of untracked conversions."
    - name: "vast_validation_passed_orders"
      expr: COUNT(DISTINCT CASE WHEN vast_tag_validation_status = 'Passed' THEN trafficking_order_id END)
      comment: "Number of orders with validated VAST tags — measures video ad serving readiness and reduces launch-day errors."
    - name: "completed_orders"
      expr: COUNT(DISTINCT CASE WHEN trafficking_status = 'Completed' THEN trafficking_order_id END)
      comment: "Number of completed trafficking orders — measures operational throughput and team productivity."
    - name: "rejected_orders"
      expr: COUNT(DISTINCT CASE WHEN trafficking_status = 'Rejected' THEN trafficking_order_id END)
      comment: "Number of rejected trafficking orders — measures rework rate and upstream brief quality; high values indicate process breakdown."
$$;