-- Metric views for domain: restaurant | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and operational KPIs per restaurant unit per performance period. Used by finance, operations, and executive leadership to evaluate unit-level P&L, comp sales trends, and cost efficiency."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit_performance`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the performance period for year-over-year trending."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly business review reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., 4-week period) for granular P&L analysis."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for monthly performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial figures are reported."
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (e.g., final, preliminary) for data quality filtering."
    - name: "record_created_date"
      expr: DATE_TRUNC('month', record_created_timestamp)
      comment: "Month the performance record was created, for recency analysis."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across all units in the period. Primary top-line KPI for executive revenue reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments. Used for margin and profitability analysis."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold. Drives food cost management decisions."
    - name: "avg_cogs_percent"
      expr: AVG(CAST(cogs_percent AS DOUBLE))
      comment: "Average COGS as a percentage of revenue across units. Benchmark against target to identify cost outliers."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across units. Key driver of controllable expenses and scheduling decisions."
    - name: "avg_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percentage of revenue. Compared against labor targets to flag overstaffing or understaffing."
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across units. Core profitability metric used in investor and board reporting."
    - name: "total_operating_income"
      expr: SUM(CAST(operating_income_amount AS DOUBLE))
      comment: "Total operating income. Measures operational efficiency after all operating expenses."
    - name: "total_net_income"
      expr: SUM(CAST(net_income_amount AS DOUBLE))
      comment: "Total net income across units. Bottom-line profitability for financial reporting."
    - name: "avg_sss_growth_percent"
      expr: AVG(CAST(sss_growth_percent AS DOUBLE))
      comment: "Average same-store sales growth percentage. Critical comp sales KPI for franchise and corporate performance reviews."
    - name: "total_comp_sales"
      expr: SUM(CAST(comp_sales_amount AS DOUBLE))
      comment: "Total comparable store sales. Used to measure organic growth excluding new unit openings."
    - name: "avg_comp_sales_variance"
      expr: AVG(CAST(comp_sales_variance_amount AS DOUBLE))
      comment: "Average variance of comp sales versus prior period. Identifies units underperforming vs. system average."
    - name: "avg_acv"
      expr: AVG(CAST(acv_amount AS DOUBLE))
      comment: "Average annual contract value / average unit volume. Used to benchmark unit productivity against system AUV targets."
    - name: "total_marketing_expense"
      expr: SUM(CAST(marketing_expense_amount AS DOUBLE))
      comment: "Total marketing spend across units. Evaluated against sales lift to assess marketing ROI."
    - name: "avg_waste_percent"
      expr: AVG(CAST(waste_percent AS DOUBLE))
      comment: "Average food waste as a percentage of revenue. Drives waste reduction programs and inventory management decisions."
    - name: "total_waste_amount"
      expr: SUM(CAST(waste_amount AS DOUBLE))
      comment: "Total dollar value of food waste. Quantifies financial impact of waste for cost reduction initiatives."
    - name: "total_rent_expense"
      expr: SUM(CAST(rent_expense_amount AS DOUBLE))
      comment: "Total occupancy/rent expense. Key fixed cost component for unit-level P&L and lease renegotiation decisions."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses_amount AS DOUBLE))
      comment: "Total operating expenses across all units. Used to compute operating leverage and efficiency ratios."
    - name: "unit_count"
      expr: COUNT(DISTINCT primary_restaurant_unit_id)
      comment: "Number of distinct restaurant units with performance records in the period. Denominator for system-wide averages."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant unit master metrics covering portfolio composition, operational status, and unit-level attributes. Used by real estate, operations, and franchise teams to manage the unit portfolio."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit`"
  dimensions:
    - name: "ownership_model"
      expr: ownership_model
      comment: "Ownership model (company-owned, franchised, licensed) for portfolio segmentation."
    - name: "concept_type"
      expr: concept_type
      comment: "Restaurant concept type (QSR, fast casual, casual dining) for format-level analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the unit operates for geographic portfolio analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province for regional performance segmentation."
    - name: "city"
      expr: city
      comment: "City for local market analysis."
    - name: "opening_date_month"
      expr: DATE_TRUNC('month', opening_date)
      comment: "Month of unit opening for new restaurant opening (NRO) pipeline tracking."
    - name: "closure_date_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month of unit closure for portfolio attrition analysis."
    - name: "has_drive_thru"
      expr: CASE WHEN drive_thru_lanes IS NOT NULL AND drive_thru_lanes != '0' THEN TRUE ELSE FALSE END
      comment: "Whether the unit has a drive-thru, for format mix analysis."
    - name: "has_online_ordering"
      expr: has_online_ordering
      comment: "Whether the unit supports online ordering, for digital channel penetration analysis."
    - name: "has_third_party_delivery"
      expr: has_third_party_delivery
      comment: "Whether the unit is enabled for third-party delivery platforms."
    - name: "haccp_certified"
      expr: haccp_certified
      comment: "Whether the unit holds HACCP food safety certification."
  measures:
    - name: "total_units"
      expr: COUNT(DISTINCT unit_id)
      comment: "Total number of restaurant units in the portfolio. Primary portfolio size KPI for executive reporting."
    - name: "avg_unit_volume_usd"
      expr: AVG(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Average unit volume (AUV) in USD across the portfolio. Core productivity benchmark for franchise and operations leadership."
    - name: "total_portfolio_auv"
      expr: SUM(CAST(average_unit_volume_usd AS DOUBLE))
      comment: "Sum of AUV across all units. Represents total system sales potential for investor reporting."
    - name: "avg_health_inspection_score"
      expr: AVG(CAST(health_inspection_score AS DOUBLE))
      comment: "Average health inspection score across units. Food safety compliance KPI monitored by operations and regulatory teams."
    - name: "avg_table_turn_rate"
      expr: AVG(CAST(table_turn_rate AS DOUBLE))
      comment: "Average table turn rate across units. Throughput efficiency metric for full-service restaurant formats."
    - name: "avg_same_store_sales_pct"
      expr: AVG(CAST(same_store_sales_pct AS DOUBLE))
      comment: "Average same-store sales percentage across the portfolio. Comp sales health indicator for system-wide performance."
    - name: "online_ordering_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN has_online_ordering = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units enabled for online ordering. Digital channel readiness KPI for technology investment decisions."
    - name: "third_party_delivery_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN has_third_party_delivery = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units enabled for third-party delivery. Delivery channel coverage metric for off-premise strategy decisions."
    - name: "haccp_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units with active HACCP certification. Food safety compliance rate for regulatory and brand standard reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_sos_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Speed-of-service (SOS) operational KPIs measuring order fulfillment speed, target attainment, and guest satisfaction. Used by operations leadership to drive throughput and service quality improvements."
  source: "`vibe_restaurants_v1`.`restaurant`.`sos_measurement`"
  dimensions:
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (drive-thru, dine-in, delivery, kiosk) for channel-level SOS benchmarking."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of the SOS measurement (timer, POS, manual) for data quality segmentation."
    - name: "peak_period_flag"
      expr: peak_period_flag
      comment: "Whether the measurement occurred during a peak period. Enables peak vs. off-peak SOS comparison."
    - name: "equipment_issue_flag"
      expr: equipment_issue_flag
      comment: "Whether an equipment issue was present during measurement. Used to isolate equipment-driven SOS degradation."
    - name: "target_met_flag"
      expr: target_met_flag
      comment: "Whether the SOS target was met for this transaction. Primary compliance indicator."
    - name: "service_recovery_flag"
      expr: service_recovery_flag
      comment: "Whether a service recovery action was taken. Tracks service failure frequency."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement for trend analysis."
    - name: "measurement_week"
      expr: DATE_TRUNC('week', measurement_timestamp)
      comment: "Week of measurement for weekly operational review."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of SOS measurements. Volume denominator for rate calculations."
    - name: "avg_measurement_quality_score"
      expr: AVG(CAST(measurement_quality_score AS DOUBLE))
      comment: "Average quality score of SOS measurements. Ensures measurement reliability before acting on SOS data."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score associated with SOS measurements. Links service speed to guest satisfaction outcomes."
    - name: "avg_order_complexity_score"
      expr: AVG(CAST(order_complexity_score AS DOUBLE))
      comment: "Average order complexity score. Used to normalize SOS targets for complex vs. simple orders."
    - name: "sos_target_attainment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN target_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SOS measurements where the target was met. Primary SOS compliance KPI for operations dashboards."
    - name: "peak_period_measurement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN peak_period_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements occurring during peak periods. Used to weight SOS performance by traffic intensity."
    - name: "equipment_issue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN equipment_issue_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SOS measurements impacted by equipment issues. Drives equipment maintenance prioritization decisions."
    - name: "service_recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN service_recovery_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring service recovery. Indicates service failure frequency and guest experience risk."
    - name: "distinct_units_measured"
      expr: COUNT(DISTINCT sos_restaurant_unit_id)
      comment: "Number of distinct restaurant units with SOS measurements. Coverage metric for operational monitoring completeness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operations visit quality and compliance KPIs. Used by field operations, brand standards, and franchise teams to track unit compliance, corrective action rates, and visit outcomes."
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of operations visit (scheduled, unannounced, follow-up) for visit program analysis."
    - name: "visit_category"
      expr: visit_category
      comment: "Category of visit (brand standards, food safety, operations) for compliance domain segmentation."
    - name: "brand_standard_compliance_status"
      expr: brand_standard_compliance_status
      comment: "Overall brand standard compliance status from the visit. Primary compliance classification dimension."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (completed, in-progress, cancelled) for pipeline management."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether a corrective action was required. Segments visits by compliance severity."
    - name: "follow_up_visit_required_flag"
      expr: follow_up_visit_required_flag
      comment: "Whether a follow-up visit was required. Indicates persistent compliance issues."
    - name: "visit_date_month"
      expr: DATE_TRUNC('month', visit_date)
      comment: "Month of the visit for trend analysis of compliance over time."
    - name: "visit_priority_level"
      expr: visit_priority_level
      comment: "Priority level of the visit for resource allocation analysis."
    - name: "daypart_observed"
      expr: daypart_observed
      comment: "Daypart during which the visit was conducted (breakfast, lunch, dinner) for daypart-level compliance analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of operations visits conducted. Volume KPI for field operations program coverage."
    - name: "avg_overall_visit_score"
      expr: AVG(CAST(overall_visit_score AS DOUBLE))
      comment: "Average overall visit score across all units. Primary brand standards compliance KPI for executive reporting."
    - name: "avg_food_quality_score"
      expr: AVG(CAST(food_quality_score AS DOUBLE))
      comment: "Average food quality score from visits. Drives menu execution and training investment decisions."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score from visits. Key hygiene and brand standard compliance metric."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score from visits. Linked to guest satisfaction and training program effectiveness."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score from visits. Regulatory compliance and risk management KPI."
    - name: "avg_speed_score"
      expr: AVG(CAST(speed_score AS DOUBLE))
      comment: "Average speed-of-service score from visits. Operational throughput quality indicator."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_percentage AS DOUBLE))
      comment: "Average checklist completion percentage. Measures thoroughness of visit execution by field teams."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits requiring corrective action. Key compliance risk indicator for franchise and operations leadership."
    - name: "follow_up_visit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_visit_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits requiring a follow-up. Indicates persistent non-compliance requiring escalation."
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(visit_duration_minutes AS DOUBLE))
      comment: "Average duration of operations visits in minutes. Used to assess field team efficiency and visit depth."
    - name: "distinct_units_visited"
      expr: COUNT(DISTINCT ops_restaurant_unit_id)
      comment: "Number of distinct units visited. Coverage metric for operations visit program completeness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_ops_visit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular findings from operations visits. Used by brand standards, compliance, and franchise teams to identify recurring issues, escalation patterns, and financial impact of non-compliance."
  source: "`vibe_restaurants_v1`.`restaurant`.`ops_visit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (food safety, cleanliness, service, equipment) for issue classification."
    - name: "finding_subcategory"
      expr: finding_subcategory
      comment: "Subcategory for granular root cause analysis of compliance issues."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding (critical, major, minor) for risk prioritization."
    - name: "ops_visit_finding_status"
      expr: ops_visit_finding_status
      comment: "Current status of the finding (open, resolved, waived) for corrective action tracking."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required for this finding."
    - name: "corrective_action_completed_flag"
      expr: corrective_action_completed_flag
      comment: "Whether the corrective action has been completed. Tracks remediation progress."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding from a prior visit. Identifies chronic compliance failures."
    - name: "regulatory_violation_flag"
      expr: regulatory_violation_flag
      comment: "Whether the finding constitutes a regulatory violation. Flags legal and compliance risk."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the finding requires escalation to senior management."
    - name: "finding_month"
      expr: DATE_TRUNC('month', finding_timestamp)
      comment: "Month the finding was recorded for trend analysis."
    - name: "brand_standard_code"
      expr: brand_standard_code
      comment: "Brand standard code associated with the finding for standard-level compliance analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of findings across all visits. Volume metric for compliance issue tracking."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of findings in USD. Quantifies the business cost of non-compliance for prioritization."
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per finding. Used to prioritize remediation by economic severity."
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeat occurrences. Chronic non-compliance indicator driving escalation and training decisions."
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required corrective actions that have been completed. Remediation effectiveness KPI for franchise and operations management."
    - name: "regulatory_violation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_violation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are regulatory violations. Legal and compliance risk indicator for executive and legal teams."
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring escalation. Severity distribution metric for operations leadership."
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity findings. High-priority compliance metric for immediate operational intervention."
    - name: "distinct_units_with_findings"
      expr: COUNT(DISTINCT ops_restaurant_unit_id)
      comment: "Number of distinct units with findings. Breadth of compliance issues across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_table_turn_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Table turn efficiency and revenue-per-cover KPIs for full-service restaurant formats. Used by operations and revenue management teams to optimize seating utilization and throughput."
  source: "`vibe_restaurants_v1`.`restaurant`.`table_turn_log`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Daypart (breakfast, lunch, dinner, late night) for time-of-day throughput analysis."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for weekly traffic pattern analysis."
    - name: "turn_status"
      expr: turn_status
      comment: "Status of the table turn (completed, abandoned, in-progress) for completion rate analysis."
    - name: "is_peak_period"
      expr: is_peak_period
      comment: "Whether the turn occurred during a peak period for peak vs. off-peak throughput comparison."
    - name: "reservation_flag"
      expr: reservation_flag
      comment: "Whether the party had a reservation. Analyzes reservation vs. walk-in throughput differences."
    - name: "special_occasion_flag"
      expr: special_occasion_flag
      comment: "Whether the visit was for a special occasion. Identifies high-value guest segments."
    - name: "server_station"
      expr: server_station
      comment: "Server station assignment for station-level performance analysis."
    - name: "turn_date_month"
      expr: DATE_TRUNC('month', turn_date)
      comment: "Month of the table turn for trend analysis."
  measures:
    - name: "total_table_turns"
      expr: COUNT(1)
      comment: "Total number of table turns. Primary throughput volume metric for full-service restaurants."
    - name: "avg_total_turn_time_minutes"
      expr: AVG(CAST(total_turn_time_minutes AS DOUBLE))
      comment: "Average total table turn time in minutes. Core throughput efficiency KPI compared against SOS targets."
    - name: "avg_seating_to_order_minutes"
      expr: AVG(CAST(seating_to_order_minutes AS DOUBLE))
      comment: "Average time from seating to order placement. Identifies service speed bottlenecks in the front-of-house."
    - name: "avg_order_to_delivery_minutes"
      expr: AVG(CAST(order_to_delivery_minutes AS DOUBLE))
      comment: "Average time from order to food delivery. Kitchen throughput efficiency metric."
    - name: "avg_delivery_to_check_minutes"
      expr: AVG(CAST(delivery_to_check_minutes AS DOUBLE))
      comment: "Average time from food delivery to check presentation. Server efficiency metric."
    - name: "avg_check_to_cleared_minutes"
      expr: AVG(CAST(check_to_cleared_minutes AS DOUBLE))
      comment: "Average time from check presentation to table cleared. Payment and turnover efficiency metric."
    - name: "avg_revenue_per_cover"
      expr: AVG(CAST(revenue_per_cover AS DOUBLE))
      comment: "Average revenue per cover. Key revenue productivity metric for menu engineering and upsell program decisions."
    - name: "total_check_revenue"
      expr: SUM(CAST(check_total_amount AS DOUBLE))
      comment: "Total revenue from all table turns. Aggregate revenue contribution from dine-in channel."
    - name: "avg_wait_time_minutes"
      expr: AVG(CAST(wait_time_minutes AS DOUBLE))
      comment: "Average guest wait time before seating. Guest experience metric linked to satisfaction and retention."
    - name: "sos_target_attainment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sos_variance_minutes <= 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of table turns meeting the SOS target (non-positive variance). Throughput compliance rate for operations management."
    - name: "avg_sos_variance_minutes"
      expr: AVG(CAST(sos_variance_minutes AS DOUBLE))
      comment: "Average variance between actual turn time and SOS target in minutes. Positive values indicate underperformance vs. target."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_renovation_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure and renovation project KPIs for restaurant units. Used by real estate, finance, and operations leadership to track project delivery, budget performance, and ROI."
  source: "`vibe_restaurants_v1`.`restaurant`.`renovation_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the renovation project (planning, in-progress, completed, cancelled) for pipeline management."
    - name: "project_type"
      expr: project_type
      comment: "Type of renovation (remodel, refresh, rebuild, ADA upgrade) for capital program categorization."
    - name: "project_priority"
      expr: project_priority
      comment: "Priority level of the project for capital allocation decisions."
    - name: "financing_method"
      expr: financing_method
      comment: "How the project is financed (company-funded, franchisee-funded, co-investment) for capital structure analysis."
    - name: "ada_compliance_flag"
      expr: ada_compliance_flag
      comment: "Whether the project includes ADA compliance upgrades. Regulatory compliance tracking."
    - name: "energy_efficiency_upgrade_flag"
      expr: energy_efficiency_upgrade_flag
      comment: "Whether the project includes energy efficiency upgrades. Sustainability investment tracking."
    - name: "partial_closure_flag"
      expr: partial_closure_flag
      comment: "Whether the unit operated under partial closure during renovation. Revenue impact assessment."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start month for project pipeline scheduling."
    - name: "actual_completion_month"
      expr: DATE_TRUNC('month', actual_completion_date)
      comment: "Actual completion month for delivery performance tracking."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of renovation projects. Portfolio volume metric for capital program management."
    - name: "total_estimated_capex"
      expr: SUM(CAST(estimated_capex_usd AS DOUBLE))
      comment: "Total estimated capital expenditure across all projects. Capital budget planning KPI for finance and real estate."
    - name: "total_actual_capex"
      expr: SUM(CAST(actual_capex_usd AS DOUBLE))
      comment: "Total actual capital expenditure incurred. Compared against budget to assess capital discipline."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_usd AS DOUBLE))
      comment: "Total budget variance (actual vs. estimated capex). Positive values indicate cost overruns requiring management attention."
    - name: "avg_budget_variance"
      expr: AVG(CAST(budget_variance_usd AS DOUBLE))
      comment: "Average budget variance per project. Measures capital project execution discipline."
    - name: "avg_expected_auv_lift_pct"
      expr: AVG(CAST(expected_auv_lift_percent AS DOUBLE))
      comment: "Average expected AUV lift percentage from renovation. Used to justify capital investment in remodel programs."
    - name: "avg_actual_auv_lift_pct"
      expr: AVG(CAST(actual_auv_lift_percent AS DOUBLE))
      comment: "Average actual AUV lift percentage post-renovation. Validates ROI assumptions for future capital allocation decisions."
    - name: "avg_roi_payback_period_months"
      expr: AVG(CAST(roi_payback_period_months AS DOUBLE))
      comment: "Average ROI payback period in months. Core capital efficiency metric for investment committee decisions."
    - name: "avg_closure_duration_days"
      expr: AVG(CAST(closure_duration_days AS DOUBLE))
      comment: "Average unit closure duration during renovation in days. Revenue impact metric for renovation scheduling decisions."
    - name: "on_budget_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN budget_variance_usd <= 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of projects completed at or under budget. Capital execution quality KPI for contractor and project management evaluation."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_throughput_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Throughput benchmark KPIs defining target capacity and service speed standards per unit and daypart. Used by operations and engineering teams to set and validate performance targets."
  source: "`vibe_restaurants_v1`.`restaurant`.`throughput_benchmark`"
  dimensions:
    - name: "benchmark_type"
      expr: benchmark_type
      comment: "Type of benchmark (system average, top quartile, brand standard) for target-setting context."
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of the benchmark data (internal, industry, consultant) for credibility assessment."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, fast casual, drive-thru only) for format-appropriate benchmarking."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (drive-thru, dine-in, delivery) for channel-specific throughput targets."
    - name: "throughput_benchmark_status"
      expr: throughput_benchmark_status
      comment: "Status of the benchmark (active, superseded, draft) for filtering to current standards."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the benchmark became effective for version tracking."
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of throughput benchmarks defined. Coverage metric for standards completeness."
    - name: "avg_target_throughput_covers_per_hour"
      expr: AVG(CAST(target_throughput_covers_per_hour AS DOUBLE))
      comment: "Average target throughput in covers per hour. Core capacity planning KPI for full-service formats."
    - name: "avg_target_throughput_transactions_per_hour"
      expr: AVG(CAST(target_throughput_transactions_per_hour AS DOUBLE))
      comment: "Average target throughput in transactions per hour. Core capacity planning KPI for QSR and fast casual formats."
    - name: "avg_target_adt"
      expr: AVG(CAST(target_adt AS DOUBLE))
      comment: "Average target average daily transactions (ADT). Used to set staffing and production capacity plans."
    - name: "avg_target_atc"
      expr: AVG(CAST(target_atc AS DOUBLE))
      comment: "Average target average ticket count. Revenue productivity benchmark for unit performance evaluation."
    - name: "avg_target_acv"
      expr: AVG(CAST(target_acv AS DOUBLE))
      comment: "Average target average check value. Revenue per transaction benchmark for menu engineering decisions."
    - name: "avg_sos_compliance_threshold_pct"
      expr: AVG(CAST(sos_compliance_threshold_pct AS DOUBLE))
      comment: "Average SOS compliance threshold percentage across benchmarks. Defines the minimum acceptable SOS attainment rate."
    - name: "avg_labor_fte_requirement"
      expr: AVG(CAST(labor_fte_requirement AS DOUBLE))
      comment: "Average labor FTE requirement per benchmark. Used for labor scheduling and cost planning against throughput targets."
    - name: "avg_peak_hour_multiplier"
      expr: AVG(CAST(peak_hour_multiplier AS DOUBLE))
      comment: "Average peak hour throughput multiplier. Used to scale staffing and production capacity for peak periods."
    - name: "distinct_units_benchmarked"
      expr: COUNT(DISTINCT throughput_restaurant_unit_id)
      comment: "Number of distinct units with active throughput benchmarks. Coverage metric for standards deployment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_store_campaign_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local marketing campaign execution and ROI KPIs at the store level. Used by marketing and operations leadership to evaluate campaign effectiveness, spend efficiency, and sales lift."
  source: "`vibe_restaurants_v1`.`restaurant`.`store_campaign_assignment`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel (digital, print, radio, social) for channel-level ROI analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign assignment for pipeline and compliance tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the campaign assignment is compliant with brand standards."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area (DMA) for geographic campaign performance analysis."
    - name: "store_campaign_assignment_status"
      expr: store_campaign_assignment_status
      comment: "Current status of the store campaign assignment (active, completed, cancelled)."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the campaign started for temporal performance analysis."
    - name: "initiative_code"
      expr: initiative_code
      comment: "Marketing initiative code for program-level aggregation."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of store campaign assignments. Volume metric for campaign reach."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned marketing spend across store assignments. Budget planning KPI for marketing fund management."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend incurred. Compared against planned spend for budget discipline."
    - name: "total_lmf_fund_amount"
      expr: SUM(CAST(lmf_fund_amount AS DOUBLE))
      comment: "Total local marketing fund (LMF) amount allocated. Tracks fund deployment across the portfolio."
    - name: "total_lmf_fund_used"
      expr: SUM(CAST(lmf_fund_used AS DOUBLE))
      comment: "Total LMF funds actually used. Measures fund utilization efficiency."
    - name: "lmf_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lmf_fund_used AS DOUBLE)) / NULLIF(SUM(CAST(lmf_fund_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated LMF funds utilized. Marketing fund efficiency KPI for franchise and marketing leadership."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comp sales lift percentage from campaign assignments. Primary marketing ROI metric for campaign effectiveness evaluation."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comp sales lift percentage. Baseline for comparing actual vs. projected campaign performance."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual average daily transaction (ADT) lift from campaigns. Traffic-driving effectiveness metric."
    - name: "spend_variance"
      expr: SUM((CAST(actual_spend AS DOUBLE)) - (CAST(planned_spend AS DOUBLE)))
      comment: "Total variance between actual and planned marketing spend. Positive values indicate overspend requiring management review."
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of store campaign assignments that are compliant with brand standards. Brand integrity metric for marketing governance."
    - name: "distinct_units_in_campaign"
      expr: COUNT(DISTINCT store_unit_id)
      comment: "Number of distinct units participating in campaigns. Campaign reach metric for marketing coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset lifecycle and maintenance KPIs. Used by facilities, operations, and finance teams to manage asset health, maintenance compliance, and capital replacement planning."
  source: "`vibe_restaurants_v1`.`restaurant`.`equipment_asset`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (cooking, refrigeration, POS, HVAC) for asset class analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type for granular asset management."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether equipment is owned, leased, or rented. Impacts capital vs. operating expense classification."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Current condition rating of the asset (excellent, good, fair, poor) for replacement prioritization."
    - name: "temperature_critical_flag"
      expr: temperature_critical_flag
      comment: "Whether the equipment is temperature-critical (refrigeration, freezers). Food safety risk flag."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, accelerated) for financial reporting segmentation."
    - name: "installation_date_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year of installation for asset age cohort analysis."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer for vendor performance and warranty management analysis."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets in the portfolio. Asset inventory volume metric."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of all equipment assets. Capital investment baseline for depreciation and replacement planning."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average acquisition cost per asset. Used for budgeting replacement capital expenditure."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total current replacement cost of all assets. Capital reserve planning metric for finance and facilities teams."
    - name: "avg_replacement_cost"
      expr: AVG(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Average replacement cost per asset. Used to estimate capital requirements for asset refresh programs."
    - name: "temperature_critical_asset_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_critical_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assets that are temperature-critical. Food safety risk exposure metric for operations and compliance teams."
    - name: "avg_temperature_max_f"
      expr: AVG(CAST(temperature_max_f AS DOUBLE))
      comment: "Average maximum operating temperature across temperature-critical assets. Used for food safety compliance monitoring."
    - name: "avg_temperature_min_f"
      expr: AVG(CAST(temperature_min_f AS DOUBLE))
      comment: "Average minimum operating temperature across temperature-critical assets. Cold chain compliance metric."
    - name: "distinct_units_with_assets"
      expr: COUNT(DISTINCT equipment_restaurant_unit_id)
      comment: "Number of distinct units with equipment assets tracked. Asset management coverage metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_unit_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restaurant unit status change and lifecycle KPIs. Used by operations, real estate, and franchise teams to track openings, closures, renovations, and revenue impact of status changes."
  source: "`vibe_restaurants_v1`.`restaurant`.`unit_status_history`"
  dimensions:
    - name: "unit_status_history_status"
      expr: unit_status_history_status
      comment: "The new status the unit transitioned to (open, closed, renovating, temporarily closed) for lifecycle analysis."
    - name: "previous_status"
      expr: previous_status
      comment: "The prior status before the transition. Used to analyze transition patterns."
    - name: "closure_type"
      expr: closure_type
      comment: "Type of closure (permanent, temporary, renovation, health) for closure reason analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the status change. Enables root cause analysis of closures and disruptions."
    - name: "nro_flag"
      expr: nro_flag
      comment: "Whether the status event is related to a new restaurant opening. NRO pipeline tracking."
    - name: "is_sss_eligible"
      expr: is_sss_eligible
      comment: "Whether the unit is eligible for same-store sales calculation. Comp sales base management."
    - name: "approval_required"
      expr: approval_required
      comment: "Whether the status change required approval. Governance and compliance tracking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the status change became effective for trend analysis."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of unit status change events. Portfolio activity volume metric."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Total estimated revenue impact of all status changes. Quantifies financial exposure from closures and disruptions for executive reporting."
    - name: "avg_estimated_revenue_impact"
      expr: AVG(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Average estimated revenue impact per status event. Used to prioritize mitigation of high-impact closures."
    - name: "nro_event_count"
      expr: SUM(CASE WHEN nro_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of new restaurant opening events. NRO pipeline execution metric for development and franchise teams."
    - name: "sss_eligible_unit_count"
      expr: COUNT(DISTINCT CASE WHEN is_sss_eligible = TRUE THEN primary_restaurant_unit_id END)
      comment: "Number of distinct units eligible for same-store sales calculation. Comp sales base size metric for financial reporting."
    - name: "distinct_units_with_status_changes"
      expr: COUNT(DISTINCT primary_restaurant_unit_id)
      comment: "Number of distinct units that experienced a status change. Portfolio volatility metric for operations leadership."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`restaurant_area_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Area management hierarchy KPIs for multi-unit operators. Used by regional operations, franchise, and finance leadership to set and track area-level performance targets and portfolio composition."
  source: "`vibe_restaurants_v1`.`restaurant`.`area_management`"
  dimensions:
    - name: "area_type"
      expr: area_type
      comment: "Type of area (region, district, division) for hierarchy-level analysis."
    - name: "area_status"
      expr: area_status
      comment: "Current status of the area (active, inactive) for filtering to operational areas."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the management hierarchy for organizational structure analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country code for international portfolio segmentation."
    - name: "division"
      expr: division
      comment: "Business division for divisional P&L reporting."
    - name: "brand"
      expr: brand
      comment: "Brand associated with the area for multi-brand portfolio analysis."
    - name: "franchise_agreement_flag"
      expr: franchise_agreement_flag
      comment: "Whether the area operates under a franchise agreement. Ownership model segmentation."
  measures:
    - name: "total_areas"
      expr: COUNT(1)
      comment: "Total number of management areas. Organizational structure size metric."
    - name: "avg_auv_target"
      expr: AVG(CAST(auv_target AS DOUBLE))
      comment: "Average AUV target across areas. Used to assess ambition level of area performance plans."
    - name: "avg_cogs_percent_target"
      expr: AVG(CAST(cogs_percent_target AS DOUBLE))
      comment: "Average COGS percentage target across areas. Food cost management benchmark for area operators."
    - name: "avg_labor_percent_target"
      expr: AVG(CAST(labor_percent_target AS DOUBLE))
      comment: "Average labor percentage target across areas. Labor cost management benchmark for scheduling and staffing decisions."
    - name: "avg_csat_target_score"
      expr: AVG(CAST(csat_target_score AS DOUBLE))
      comment: "Average customer satisfaction target score across areas. Guest experience standard-setting metric."
    - name: "avg_nps_target_score"
      expr: AVG(CAST(nps_target_score AS DOUBLE))
      comment: "Average NPS target score across areas. Guest loyalty standard-setting metric."
    - name: "avg_sss_target_percent"
      expr: AVG(CAST(sss_target_percent AS DOUBLE))
      comment: "Average same-store sales growth target percentage. Comp sales ambition metric for area performance planning."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across areas. Franchise revenue planning metric."
    - name: "avg_marketing_fund_contribution_percent"
      expr: AVG(CAST(marketing_fund_contribution_percent AS DOUBLE))
      comment: "Average marketing fund contribution percentage. Marketing fund revenue planning metric for franchise operations."
$$;