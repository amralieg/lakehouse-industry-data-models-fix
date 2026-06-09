-- Metric views for domain: marketing | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial performance indicators for marketing campaigns"
  source: "`food_beverage_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Unique identifier of the campaign"
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the campaign"
    - name: "campaign_name"
      expr: campaign_name
      comment: "Descriptive name of the campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., digital, TV, print)"
    - name: "channel"
      expr: channel
      comment: "Primary media channel used"
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date"
    - name: "end_date"
      expr: end_date
      comment: "Campaign end date"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the campaign"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign"
  measures:
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaigns in the selected scope"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend in USD for the campaign"
    - name: "total_planned_budget_usd"
      expr: SUM(CAST(planned_budget_usd AS DOUBLE))
      comment: "Total planned budget in USD for the campaign"
    - name: "spend_vs_budget_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_usd AS DOUBLE)) / NULLIF(SUM(CAST(planned_budget_usd AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of planned budget"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial efficiency and reach metrics for media spend"
  source: "`food_beverage_ecm`.`marketing`.`media_spend`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the spend"
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier"
    - name: "market_id"
      expr: market_id
      comment: "Market identifier"
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel (e.g., TV, Digital)"
    - name: "media_type"
      expr: media_type
      comment: "Media type (e.g., Video, Display)"
    - name: "spend_date"
      expr: spend_date
      comment: "Date of the spend"
  measures:
    - name: "spend_record_count"
      expr: COUNT(1)
      comment: "Number of media spend records"
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual media spend amount"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions delivered"
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks generated"
    - name: "cpm"
      expr: ROUND(1000.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(impressions AS DOUBLE)), 0), 2)
      comment: "Cost per thousand impressions (CPM)"
    - name: "cpc"
      expr: ROUND(SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(clicks AS DOUBLE)), 0), 2)
      comment: "Cost per click (CPC)"
    - name: "avg_roi_index"
      expr: AVG(CAST(roi_index AS DOUBLE))
      comment: "Average ROI index for media spend"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`marketing_consumer_insight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actionable consumer insight performance metrics"
  source: "`food_beverage_ecm`.`marketing`.`consumer_insight`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand linked to the insight"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the insight"
    - name: "insight_category"
      expr: insight_category
      comment: "Category of the insight (e.g., NPS, Sensory)"
    - name: "insight_priority"
      expr: insight_priority
      comment: "Priority level of the insight"
    - name: "deliverable_date"
      expr: deliverable_date
      comment: "Date the insight was delivered"
  measures:
    - name: "insight_record_count"
      expr: COUNT(1)
      comment: "Number of consumer insight records"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total spend on consumer insight projects"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS from consumer insights"
    - name: "avg_concept_test_score"
      expr: AVG(CAST(concept_test_score AS DOUBLE))
      comment: "Average concept test score"
    - name: "avg_sensory_score"
      expr: AVG(CAST(sensory_score AS DOUBLE))
      comment: "Average sensory score"
$$;