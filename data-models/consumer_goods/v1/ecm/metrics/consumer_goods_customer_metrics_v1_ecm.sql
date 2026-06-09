-- Metric views for domain: customer | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`customer_channel_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and eligibility metrics for channel classifications used by commercial and supply chain leadership."
  source: "`consumer_goods_ecm`.`customer`.`channel_classification`"
  dimensions:
    - name: "channel_format"
      expr: channel_format
      comment: "Format of the channel (e.g., online, brick‑and‑mortar)"
  measures:
    - name: "total_channel_count"
      expr: COUNT(1)
      comment: "Total number of channel classification records"
    - name: "active_channel_count"
      expr: SUM(CASE WHEN active_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of channels currently marked as active"
    - name: "acv_eligible_channel_count"
      expr: SUM(CASE WHEN acv_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of channels eligible for ACV (Annual Contract Value) programs"
    - name: "tdp_eligible_channel_count"
      expr: SUM(CASE WHEN tdp_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of channels eligible for Trade Development Programs"
    - name: "trade_promotion_eligible_channel_count"
      expr: SUM(CASE WHEN trade_promotion_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of channels eligible for trade promotions"
    - name: "average_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across channels"
    - name: "average_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average OTIF (On-Time In-Full) target percentage across channels"
$$;