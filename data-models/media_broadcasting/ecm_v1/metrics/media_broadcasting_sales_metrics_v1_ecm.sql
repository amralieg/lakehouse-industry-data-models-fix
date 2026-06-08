-- Metric views for domain: sales | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core ad order financial performance"
  source: "`media_broadcasting_ecm`.`sales`.`ad_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the ad order"
    - name: "market_code"
      expr: market_code
      comment: "Geographic market identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the order"
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Start date of the flight period"
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "End date of the flight period"
    - name: "advertiser_id"
      expr: advertiser_id
      comment: "Advertiser foreign key"
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign foreign key"
  measures:
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value across all ad orders"
    - name: "average_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate applied to ad orders"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of ad orders"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and financials at the line level"
  source: "`media_broadcasting_ecm`.`sales`.`ad_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the order line"
    - name: "channel_id"
      expr: channel_id
      comment: "Channel where the line is scheduled"
    - name: "scheduling_daypart_id"
      expr: scheduling_daypart_id
      comment: "Daypart identifier for scheduling"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line amounts"
    - name: "flight_start_date"
      expr: flight_start_date
      comment: "Flight start date for the line"
    - name: "flight_end_date"
      expr: flight_end_date
      comment: "Flight end date for the line"
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Sum of line total amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts after discounts"
    - name: "contracted_impressions_total"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted impressions"
    - name: "actual_impressions_total"
      expr: SUM(CAST(actual_impressions_delivered AS DOUBLE))
      comment: "Total actual impressions delivered"
    - name: "ad_order_line_count"
      expr: COUNT(1)
      comment: "Number of ad order lines"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot‑level delivery and revenue metrics"
  source: "`media_broadcasting_ecm`.`sales`.`ad_spot`"
  dimensions:
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code where the spot aired"
    - name: "market_code"
      expr: market_code
      comment: "Market code for the spot"
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the spot"
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Platform (linear, streaming, etc.)"
    - name: "scheduled_air_date"
      expr: scheduled_air_date
      comment: "Scheduled air date of the spot"
    - name: "advertiser_id"
      expr: advertiser_id
      comment: "Advertiser foreign key"
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign foreign key"
  measures:
    - name: "total_cpm_amount"
      expr: SUM(CAST(cpm_amount AS DOUBLE))
      comment: "Sum of CPM amounts for all spots"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered across spots"
    - name: "total_grp_value"
      expr: SUM(CAST(grp_value AS DOUBLE))
      comment: "Sum of GRP values delivered"
    - name: "ad_spot_count"
      expr: COUNT(1)
      comment: "Number of ad spots"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue forecasting at the territory/rep level"
  source: "`media_broadcasting_ecm`.`sales`.`forecast`"
  dimensions:
    - name: "broadcast_year"
      expr: broadcast_year
      comment: "Fiscal year for the forecast"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the forecast period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the forecast period"
    - name: "sales_territory_id"
      expr: sales_territory_id
      comment: "Territory identifier"
    - name: "sales_rep_id"
      expr: sales_rep_id
      comment: "Sales rep identifier"
    - name: "sales_account_id"
      expr: sales_account_id
      comment: "Sales account identifier"
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue for the period"
    - name: "best_case_revenue"
      expr: SUM(CAST(best_case_revenue AS DOUBLE))
      comment: "Best‑case revenue scenario"
    - name: "closed_revenue"
      expr: SUM(CAST(closed_revenue AS DOUBLE))
      comment: "Revenue that has been closed"
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_impression_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impression delivery performance and revenue"
  source: "`media_broadcasting_ecm`.`sales`.`impression_delivery`"
  dimensions:
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the delivery"
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, etc.)"
    - name: "channel_name"
      expr: channel_name
      comment: "Channel name where the impression was delivered"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue"
    - name: "delivery_date"
      expr: delivery_date
      comment: "Date of the delivery"
  measures:
    - name: "total_impressions_served"
      expr: SUM(CAST(total_impressions_served AS DOUBLE))
      comment: "Total impressions served across deliveries"
    - name: "total_revenue_amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue generated from impression deliveries"
    - name: "impression_delivery_count"
      expr: COUNT(1)
      comment: "Number of impression delivery records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial summary of sales proposals"
  source: "`media_broadcasting_ecm`.`sales`.`sales_proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (new business, renewal, etc.)"
    - name: "market_type"
      expr: market_type
      comment: "Market classification for the proposal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the proposal"
    - name: "sales_agency_id"
      expr: sales_agency_id
      comment: "Sales agency responsible"
    - name: "advertiser_id"
      expr: advertiser_id
      comment: "Advertiser foreign key"
    - name: "created_date"
      expr: created_timestamp
      comment: "Timestamp when the proposal was created"
  measures:
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Sum of total proposed monetary value"
    - name: "net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Sum of net proposed value after discounts"
    - name: "sales_proposal_count"
      expr: COUNT(1)
      comment: "Number of sales proposals"
$$;