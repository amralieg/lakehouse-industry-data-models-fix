-- Metric views for domain: research | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`research_competitor_benchmark`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for competitor benchmarking activities"
  source: "`food_beverage_ecm`.`research`.`competitor_benchmark`"
  dimensions:
    - name: "benchmark_date"
      expr: benchmark_date
      comment: "Date of the benchmark observation"
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region of the benchmark"
    - name: "competitor_brand"
      expr: competitor_brand
      comment: "Brand name of the competitor"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the benchmarked SKU"
  measures:
    - name: "total_benchmarks"
      expr: COUNT(1)
      comment: "Total number of competitor benchmark records"
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price of benchmarked competitor products"
    - name: "avg_nutritional_fat_g"
      expr: AVG(CAST(nutritional_fat_g AS DOUBLE))
      comment: "Average fat content (g) across benchmarks"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of benchmarks that are compliant"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`research_concept`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of R&D concepts and their projected business impact"
  source: "`food_beverage_ecm`.`research`.`concept`"
  dimensions:
    - name: "concept_status"
      expr: concept_status
      comment: "Current status of the concept"
    - name: "concept_category"
      expr: concept_category
      comment: "Category classification of the concept"
    - name: "target_market"
      expr: target_market
      comment: "Intended market for the concept"
    - name: "owner_role"
      expr: owner_role
      comment: "Role of the concept owner"
    - name: "launch_window_estimate"
      expr: launch_window_estimate
      comment: "Estimated launch window date"
  measures:
    - name: "total_concepts"
      expr: COUNT(1)
      comment: "Total number of concepts"
    - name: "avg_projected_margin_pct"
      expr: AVG(CAST(projected_margin_percent AS DOUBLE))
      comment: "Average projected margin percent across concepts"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score for concepts"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score for concepts"
    - name: "avg_purchase_intent_rating"
      expr: AVG(CAST(purchase_intent_rating AS DOUBLE))
      comment: "Average purchase intent rating from concept testing"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`research_innovation_pipeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and performance metrics for the innovation pipeline"
  source: "`food_beverage_ecm`.`research`.`innovation_pipeline`"
  dimensions:
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Current stage of the pipeline project"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the project"
    - name: "market_opportunity"
      expr: market_opportunity
      comment: "Qualitative description of market opportunity"
    - name: "strategic_category"
      expr: strategic_category
      comment: "Strategic category classification"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of innovation pipeline projects"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend in USD across projects"
    - name: "avg_estimated_cost_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost in USD per project"
    - name: "avg_estimated_revenue_usd"
      expr: AVG(CAST(estimated_revenue_usd AS DOUBLE))
      comment: "Average estimated revenue in USD per project"
    - name: "avg_projected_roi_percent"
      expr: AVG(CAST(projected_roi_percent AS DOUBLE))
      comment: "Average projected ROI percent across projects"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`research_rd_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and status metrics for R&D projects"
  source: "`food_beverage_ecm`.`research`.`rd_project`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the R&D project"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment targeted by the project"
    - name: "target_market"
      expr: target_market
      comment: "Geographic target market"
    - name: "stage_gate_phase"
      expr: stage_gate_phase
      comment: "Current stage‑gate phase of the project"
    - name: "strategic_goal"
      expr: strategic_goal
      comment: "Strategic goal associated with the project"
  measures:
    - name: "total_rd_projects"
      expr: COUNT(1)
      comment: "Total number of R&D projects"
    - name: "total_actual_spent_usd"
      expr: SUM(CAST(actual_spent AS DOUBLE))
      comment: "Total actual spend in USD for R&D projects"
    - name: "avg_expected_margin_pct"
      expr: AVG(CAST(expected_margin_percent AS DOUBLE))
      comment: "Average expected margin percent across projects"
    - name: "avg_expected_cogs"
      expr: AVG(CAST(expected_cogs AS DOUBLE))
      comment: "Average expected cost of goods sold (COGS) per project"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`research_rd_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and outcome metrics for R&D test results"
  source: "`food_beverage_ecm`.`research`.`rd_test_result`"
  dimensions:
    - name: "test_method"
      expr: test_method
      comment: "Method used for the test"
    - name: "instrument_code"
      expr: instrument_code
      comment: "Instrument identifier used for measurement"
    - name: "rd_test_result_status"
      expr: rd_test_result_status
      comment: "Current status of the test result record"
    - name: "regulatory_reference"
      expr: regulatory_reference
      comment: "Regulatory reference linked to the test"
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of R&D test results recorded"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across test results"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_flag = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of test results that passed"
    - name: "fail_count"
      expr: SUM(CASE WHEN pass_fail_flag = 'Fail' THEN 1 ELSE 0 END)
      comment: "Count of test results that failed"
$$;