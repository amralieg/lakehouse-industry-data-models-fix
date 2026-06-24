-- Metric views for domain: customer | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`customer_channel_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic channel performance and classification metrics for trade account segmentation, distribution model analysis, and channel profitability assessment. Supports executive decisions on channel investment, pricing strategy optimization, and market segment prioritization."
  source: "`vibe_consumer_goods_v1`.`customer`.`channel_classification`"
  dimensions:
    - name: "channel_name"
      expr: channel_name
      comment: "Primary channel identifier for grouping trade accounts and analyzing channel-specific performance"
    - name: "channel_code"
      expr: channel_code
      comment: "Standardized channel code for cross-system reporting and integration"
    - name: "distribution_model"
      expr: distribution_model
      comment: "Distribution model type (direct, distributor, hybrid) for supply chain strategy analysis"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification for strategic positioning and competitive analysis"
    - name: "primary_tier"
      expr: primary_tier
      comment: "Primary tier classification for account prioritization and resource allocation decisions"
    - name: "secondary_tier"
      expr: secondary_tier
      comment: "Secondary tier classification for granular segmentation and targeted strategy development"
    - name: "tertiary_tier"
      expr: tertiary_tier
      comment: "Tertiary tier classification for detailed account stratification and micro-segmentation"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy type for margin analysis and pricing optimization decisions"
    - name: "channel_format"
      expr: channel_format
      comment: "Channel format classification (retail, wholesale, e-commerce) for format-specific performance tracking"
    - name: "applicable_region"
      expr: applicable_region
      comment: "Geographic region for regional performance analysis and market expansion planning"
    - name: "active_status"
      expr: active_status
      comment: "Active status indicator for filtering current vs historical channel classifications"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "EDI capability flag for operational efficiency analysis and automation opportunity identification"
    - name: "pos_data_available_flag"
      expr: pos_data_available_flag
      comment: "POS data availability flag for demand sensing capability and sell-through visibility assessment"
    - name: "planogram_required_flag"
      expr: planogram_required_flag
      comment: "Planogram requirement flag for merchandising complexity and compliance cost analysis"
    - name: "trade_promotion_eligible_flag"
      expr: trade_promotion_eligible_flag
      comment: "Trade promotion eligibility flag for promotional spend allocation and ROI optimization"
    - name: "acv_eligible_flag"
      expr: acv_eligible_flag
      comment: "ACV (All Commodity Volume) eligibility flag for distribution coverage and market penetration analysis"
    - name: "tdp_eligible_flag"
      expr: tdp_eligible_flag
      comment: "TDP (Total Distribution Points) eligibility flag for distribution strategy and coverage optimization"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Effective year for trend analysis and year-over-year channel evolution tracking"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Effective quarter for quarterly business review and seasonal pattern analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Effective month for monthly performance tracking and short-term trend identification"
  measures:
    - name: "total_channel_classifications"
      expr: COUNT(1)
      comment: "Total number of channel classifications for portfolio complexity assessment and governance oversight"
    - name: "active_channel_classifications"
      expr: COUNT(CASE WHEN active_status = 'Active' THEN 1 END)
      comment: "Count of active channel classifications for current operational scope and active portfolio size"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT channel_code)
      comment: "Number of unique channel codes for channel diversity assessment and market coverage breadth"
    - name: "distinct_market_segments"
      expr: COUNT(DISTINCT market_segment)
      comment: "Number of unique market segments served for market diversification and strategic positioning analysis"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across channels for working capital planning and order efficiency optimization"
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitment across all channels for capacity planning and demand forecasting"
    - name: "avg_otif_target"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average OTIF (On-Time In-Full) target percentage for service level benchmarking and logistics performance standards"
    - name: "weighted_otif_target"
      expr: SUM(CAST(otif_target_percentage AS DOUBLE))
      comment: "Sum of OTIF targets for aggregate service commitment assessment and operational excellence tracking"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for supply chain responsiveness assessment and inventory positioning strategy"
    - name: "edi_capable_channel_count"
      expr: COUNT(CASE WHEN edi_capable_flag = true THEN 1 END)
      comment: "Count of EDI-capable channels for automation penetration and digital integration maturity assessment"
    - name: "edi_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_capable_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with EDI capability for digital transformation progress and operational efficiency potential"
    - name: "pos_data_available_count"
      expr: COUNT(CASE WHEN pos_data_available_flag = true THEN 1 END)
      comment: "Count of channels providing POS data for demand visibility coverage and sell-through analytics capability"
    - name: "pos_visibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pos_data_available_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with POS data availability for demand sensing maturity and market intelligence coverage"
    - name: "trade_promotion_eligible_count"
      expr: COUNT(CASE WHEN trade_promotion_eligible_flag = true THEN 1 END)
      comment: "Count of trade promotion eligible channels for promotional investment scope and trade spend allocation planning"
    - name: "trade_promotion_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trade_promotion_eligible_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels eligible for trade promotions for promotional reach and revenue growth opportunity assessment"
    - name: "acv_eligible_channel_count"
      expr: COUNT(CASE WHEN acv_eligible_flag = true THEN 1 END)
      comment: "Count of ACV-eligible channels for distribution coverage measurement and market penetration tracking"
    - name: "acv_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acv_eligible_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels eligible for ACV measurement for distribution effectiveness and market access assessment"
    - name: "planogram_required_count"
      expr: COUNT(CASE WHEN planogram_required_flag = true THEN 1 END)
      comment: "Count of channels requiring planograms for merchandising complexity and field execution resource planning"
    - name: "planogram_complexity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN planogram_required_flag = true THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels requiring planograms for merchandising cost assessment and retail execution complexity"
    - name: "hierarchical_channel_count"
      expr: COUNT(CASE WHEN parent_channel_classification_id IS NOT NULL THEN 1 END)
      comment: "Count of channels with parent relationships for organizational complexity and hierarchical structure depth"
    - name: "top_level_channel_count"
      expr: COUNT(CASE WHEN parent_channel_classification_id IS NULL THEN 1 END)
      comment: "Count of top-level channels without parent for primary channel portfolio size and strategic account segmentation"
$$;