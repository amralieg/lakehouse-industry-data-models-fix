-- Metric views for domain: dealer | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_retail_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core retail sales performance metrics"
  source: "`automotive_ecm`.`dealer`.`retail_sale`"
  dimensions:
    - name: "sale_date"
      expr: sale_date
      comment: "Date of the retail sale"
    - name: "dealership_id"
      expr: dealership_id
      comment: "Identifier of the dealership"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle sold"
    - name: "vehicle_condition"
      expr: vehicle_condition
      comment: "Condition of the vehicle at sale"
  measures:
    - name: "total_sales_amount"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total dollar amount of retail sales"
    - name: "total_front_end_gross"
      expr: SUM(CAST(front_end_gross AS DOUBLE))
      comment: "Sum of front‑end gross profit for retail sales"
    - name: "total_back_end_gross"
      expr: SUM(CAST(back_end_gross AS DOUBLE))
      comment: "Sum of back‑end gross profit for retail sales"
    - name: "average_discount_pct"
      expr: AVG(CAST(discount_amount AS DOUBLE) / NULLIF(CAST(sale_price AS DOUBLE), 0) * 100)
      comment: "Average discount percentage applied to sales"
    - name: "average_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average sale price per transaction"
    - name: "count_sales"
      expr: COUNT(1)
      comment: "Number of retail sale transactions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic performance scorecard KPIs"
  source: "`automotive_ecm`.`dealer`.`performance_scorecard`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the scorecard"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the scorecard"
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification"
  measures:
    - name: "average_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across scorecards"
    - name: "average_inventory_turn_rate"
      expr: AVG(CAST(inventory_turn_rate AS DOUBLE))
      comment: "Average inventory turn rate"
    - name: "average_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "average_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage"
    - name: "average_warranty_claim_approval_rate_pct"
      expr: AVG(CAST(warranty_claim_approval_rate_pct AS DOUBLE))
      comment: "Average warranty claim approval rate percentage"
    - name: "count_scorecards"
      expr: COUNT(1)
      comment: "Number of scorecard records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_csi_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and service quality metrics"
  source: "`automotive_ecm`.`dealer`.`csi_survey`"
  dimensions:
    - name: "survey_date"
      expr: survey_date
      comment: "Date the survey was completed"
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier"
    - name: "market_code"
      expr: market_code
      comment: "Market code"
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (Promoter, Passive, Detractor)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (e.g., post‑sale, service)"
  measures:
    - name: "avg_overall_satisfaction"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall satisfaction score from CSI surveys"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score"
    - name: "avg_service_timeliness"
      expr: AVG(CAST(service_timeliness_score AS DOUBLE))
      comment: "Average service timeliness score"
    - name: "complaint_rate_pct"
      expr: AVG(CASE WHEN complaint_flag THEN 1 ELSE 0 END) * 100
      comment: "Percentage of surveys with a complaint flag"
    - name: "count_surveys"
      expr: COUNT(1)
      comment: "Number of CSI survey responses"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`dealer_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation and pricing metrics"
  source: "`automotive_ecm`.`dealer`.`dealer_inventory`"
  dimensions:
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of inventory (e.g., available, allocated)"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory (e.g., new, used)"
    - name: "body_style"
      expr: body_style
      comment: "Body style of the vehicle"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of inventory on hand"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of inventory"
    - name: "average_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price for inventory items"
    - name: "count_inventory"
      expr: COUNT(1)
      comment: "Number of inventory records"
$$;