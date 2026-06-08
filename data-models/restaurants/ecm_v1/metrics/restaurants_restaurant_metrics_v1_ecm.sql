-- Metric views for domain: restaurant | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_unit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance KPIs per restaurant unit and period"
  source: "`restaurants_ecm`.`restaurant`.`unit_performance`"
  dimensions:
    - name: "performance_period_id"
      expr: performance_period_id
      comment: "Foreign key to the performance period"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Identifier of the restaurant unit"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the performance period"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the performance period"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across all units for the selected period"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA (earnings before interest, taxes, depreciation, amortization) across units"
    - name: "average_labor_percent"
      expr: AVG(CAST(labor_percent AS DOUBLE))
      comment: "Average labor cost as a percent of revenue"
    - name: "average_cogs_percent"
      expr: AVG(CAST(cogs_percent AS DOUBLE))
      comment: "Average cost of goods sold as a percent of revenue"
    - name: "total_acv"
      expr: SUM(CAST(acv_amount AS DOUBLE))
      comment: "Total annual contract value (ACV) for the period"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of unit performance records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_table_turn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency KPIs for table turnover"
  source: "`restaurants_ecm`.`restaurant`.`table_turn_log`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Identifier of the restaurant unit"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week of the turn"
    - name: "daypart"
      expr: daypart
      comment: "Meal period (e.g., breakfast, lunch, dinner)"
    - name: "turn_date"
      expr: turn_date
      comment: "Date of the table turn"
    - name: "table_section"
      expr: table_section
      comment: "Section of the restaurant where the table is located"
  measures:
    - name: "total_turns"
      expr: COUNT(1)
      comment: "Count of table turn events"
    - name: "average_total_turn_time_minutes"
      expr: AVG(CAST(total_turn_time_minutes AS DOUBLE))
      comment: "Average total time per table turn in minutes"
    - name: "average_wait_time_minutes"
      expr: AVG(CAST(wait_time_minutes AS DOUBLE))
      comment: "Average guest wait time before being seated"
    - name: "average_seating_to_order_minutes"
      expr: AVG(CAST(seating_to_order_minutes AS DOUBLE))
      comment: "Average time from seating to order placement"
    - name: "average_order_to_delivery_minutes"
      expr: AVG(CAST(order_to_delivery_minutes AS DOUBLE))
      comment: "Average time from order placement to delivery"
    - name: "sum_revenue_per_cover"
      expr: SUM(CAST(revenue_per_cover AS DOUBLE))
      comment: "Total revenue per cover (guest)"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_ops_visit_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and compliance KPIs from operational visits"
  source: "`restaurants_ecm`.`restaurant`.`ops_visit`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Identifier of the restaurant unit"
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the operational visit"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., routine, audit)"
    - name: "visit_category"
      expr: visit_category
      comment: "Category of the visit"
    - name: "brand_standard_compliance_status"
      expr: brand_standard_compliance_status
      comment: "Compliance status with brand standards"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Number of operational visits"
    - name: "average_overall_score"
      expr: AVG(CAST(overall_visit_score AS DOUBLE))
      comment: "Average overall visit score"
    - name: "average_food_quality_score"
      expr: AVG(CAST(food_quality_score AS DOUBLE))
      comment: "Average food quality score"
    - name: "average_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score"
    - name: "average_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety compliance score"
    - name: "average_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score"
    - name: "corrective_actions_required"
      expr: SUM(CASE WHEN corrective_action_required_flag THEN 1 ELSE 0 END)
      comment: "Count of visits where corrective action was required"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`restaurant_throughput_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benchmark targets for throughput and labor planning"
  source: "`restaurants_ecm`.`restaurant`.`throughput_benchmark`"
  dimensions:
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Identifier of the restaurant unit"
    - name: "daypart_id"
      expr: daypart_id
      comment: "Identifier of the daypart (e.g., breakfast, lunch)"
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (e.g., quick‑service, casual)"
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel (e.g., dine‑in, drive‑thru)"
  measures:
    - name: "average_target_throughput_transactions_per_hour"
      expr: AVG(CAST(target_throughput_transactions_per_hour AS DOUBLE))
      comment: "Average benchmark for transactions per hour"
    - name: "average_target_acv"
      expr: AVG(CAST(target_acv AS DOUBLE))
      comment: "Average target annual contract value"
    - name: "average_target_adt"
      expr: AVG(CAST(target_adt AS DOUBLE))
      comment: "Average target average daily traffic (ADT)"
    - name: "average_labor_fte_requirement"
      expr: AVG(CAST(labor_fte_requirement AS DOUBLE))
      comment: "Average full‑time‑equivalent labor requirement"
    - name: "benchmark_record_count"
      expr: COUNT(1)
      comment: "Number of benchmark records"
$$;