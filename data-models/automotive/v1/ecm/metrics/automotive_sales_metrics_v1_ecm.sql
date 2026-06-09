-- Metric views for domain: sales | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key opportunity performance metrics for executive review"
  source: "`automotive_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the opportunity"
    - name: "region"
      expr: region
      comment: "Geographic region"
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current sales stage of the opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type/category of the opportunity"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the vehicle of interest"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
  measures:
    - name: "total_opportunity_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities"
    - name: "total_won_value"
      expr: SUM(CASE WHEN is_won THEN estimated_value ELSE 0 END)
      comment: "Total estimated value of won opportunities"
    - name: "count_total_opportunities"
      expr: COUNT(1)
      comment: "Number of opportunity records"
    - name: "count_won_opportunities"
      expr: SUM(CASE WHEN is_won THEN 1 ELSE 0 END)
      comment: "Count of opportunities that were won"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value across all opportunities"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote-level financial metrics to track pipeline health"
  source: "`automotive_ecm`.`sales`.`quote`"
  dimensions:
    - name: "sales_region"
      expr: sales_region
      comment: "Region associated with the quote"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel used for the quote"
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle quoted"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the vehicle quoted"
  measures:
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due across all quotes"
    - name: "avg_quote_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average total amount due per quote"
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Number of quote records"
    - name: "converted_to_order_count"
      expr: SUM(CASE WHEN converted_to_order THEN 1 ELSE 0 END)
      comment: "Count of quotes that were converted to orders"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of signed contracts"
  source: "`automotive_ecm`.`sales`.`contract`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the contract"
    - name: "region_code"
      expr: region_code
      comment: "Region code for the contract"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel used for the contract"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle under contract"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Sum of contract values"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of contracts"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across contracts"
    - name: "net_revenue"
      expr: SUM(total_contract_value - discount_amount - tax_amount)
      comment: "Net revenue after discounts and taxes"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational activity metrics for sales engagement monitoring"
  source: "`automotive_ecm`.`sales`.`activity`"
  dimensions:
    - name: "activity_date"
      expr: activity_date
      comment: "Date of the activity"
    - name: "activity_type"
      expr: activity_type
      comment: "Type of sales activity"
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity"
    - name: "region"
      expr: region
      comment: "Geographic region of the activity"
    - name: "sales_territory_id"
      expr: sales_territory_id
      comment: "Sales territory identifier"
    - name: "rep_id"
      expr: rep_id
      comment: "Sales representative identifier"
  measures:
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Number of sales activities recorded"
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Sum of estimated deal values from activities"
    - name: "demo_completed_count"
      expr: SUM(CASE WHEN demo_completed THEN 1 ELSE 0 END)
      comment: "Count of activities where a demo was completed"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and volume metrics at the order line level"
  source: "`automotive_ecm`.`sales`.`order_line`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the vehicle"
    - name: "rep_id"
      expr: rep_id
      comment: "Sales representative identifier"
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue from order lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items sold"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per line item"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied on order lines"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`sales_win_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win/loss performance metrics for strategic assessment"
  source: "`automotive_ecm`.`sales`.`win_loss`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the win/loss record"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the win/loss record"
    - name: "region_code"
      expr: region_code
      comment: "Region code"
    - name: "sales_territory_id"
      expr: sales_territory_id
      comment: "Sales territory identifier"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the deal (Win/Loss)"
  measures:
    - name: "win_count"
      expr: SUM(CASE WHEN outcome = 'Win' THEN 1 ELSE 0 END)
      comment: "Number of won deals"
    - name: "loss_count"
      expr: SUM(CASE WHEN outcome = 'Loss' THEN 1 ELSE 0 END)
      comment: "Number of lost deals"
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value AS DOUBLE))
      comment: "Total value of deals (win + loss)"
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value AS DOUBLE))
      comment: "Average deal value across all outcomes"
$$;