-- Metric views for domain: sales | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core booking performance metrics"
  source: "`semiconductors_ecm`.`sales`.`booking`"
  dimensions:
    - name: "booking_year"
      expr: DATE_TRUNC('year', booking_timestamp)
      comment: "Calendar year of the booking"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for the booking"
    - name: "product_family"
      expr: product_family
      comment: "Product family associated with the booking"
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, pending)"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(booked_revenue_gross AS DOUBLE))
      comment: "Sum of gross booked revenue for the booking period"
    - name: "total_net_revenue"
      expr: SUM(CAST(booked_revenue_net AS DOUBLE))
      comment: "Sum of net booked revenue after discounts and taxes"
    - name: "total_booked_quantity"
      expr: SUM(CAST(booked_quantity AS DOUBLE))
      comment: "Total quantity of items booked"
    - name: "average_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per booking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on bookings"
    - name: "booking_count"
      expr: COUNT(1)
      comment: "Number of booking records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline health and revenue potential metrics"
  source: "`semiconductors_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the opportunity is pursued"
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity"
    - name: "stage"
      expr: stage
      comment: "Current sales stage of the opportunity"
    - name: "opportunity_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the opportunity was created"
  measures:
    - name: "total_expected_gross"
      expr: SUM(CAST(expected_gross_amount AS DOUBLE))
      comment: "Sum of expected gross amount across opportunities"
    - name: "total_expected_net"
      expr: SUM(CAST(expected_net_amount AS DOUBLE))
      comment: "Sum of expected net amount across opportunities"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non‑recurring engineering (NRE) amount in the pipeline"
    - name: "average_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across opportunities"
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Number of opportunity records"
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_date IS NOT NULL THEN 1 END)
      comment: "Count of opportunities that have been won (win_loss_date populated)"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic forecast performance metrics"
  source: "`semiconductors_ecm`.`sales`.`sales_forecast`"
  dimensions:
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period identifier (e.g., Q1-2025)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Category of forecast (e.g., demand, supply)"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., short‑term, long‑term)"
    - name: "geography"
      expr: geography
      comment: "Geographic scope of the forecast"
    - name: "forecast_year"
      expr: DATE_TRUNC('year', effective_start)
      comment: "Year of the forecast effective start date"
  measures:
    - name: "total_forecast_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total forecasted quantity across all forecasts"
    - name: "total_forecast_revenue"
      expr: SUM(CAST(revenue AS DOUBLE))
      comment: "Total forecasted revenue"
    - name: "average_bias"
      expr: AVG(CAST(bias AS DOUBLE))
      comment: "Average bias applied to forecasts"
    - name: "average_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Mean absolute percentage error across forecasts"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and volume impact of design wins"
  source: "`semiconductors_ecm`.`sales`.`sales_design_win`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region of the design win"
    - name: "sales_territory"
      expr: sales_territory
      comment: "Territory associated with the win"
    - name: "win_status"
      expr: sales_design_win_status
      comment: "Current status of the design win"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the win"
    - name: "win_year"
      expr: DATE_TRUNC('year', win_timestamp)
      comment: "Year the win was recorded"
  measures:
    - name: "total_estimated_gross_revenue"
      expr: SUM(CAST(estimated_annual_revenue_gross AS DOUBLE))
      comment: "Sum of estimated annual gross revenue from design wins"
    - name: "total_estimated_net_revenue"
      expr: SUM(CAST(estimated_annual_revenue_net AS DOUBLE))
      comment: "Sum of estimated annual net revenue from design wins"
    - name: "total_estimated_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Sum of estimated annual unit volume"
    - name: "average_forecast_accuracy"
      expr: AVG(CAST(forecast_accuracy AS DOUBLE))
      comment: "Average forecast accuracy percentage for design wins"
    - name: "design_win_count"
      expr: COUNT(1)
      comment: "Number of design win records"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and potential revenue metrics"
  source: "`semiconductors_ecm`.`sales`.`lead`"
  dimensions:
    - name: "lead_source"
      expr: lead_source
      comment: "Origin source of the lead (e.g., web, trade show)"
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead"
    - name: "region"
      expr: region
      comment: "Geographic region of the lead"
    - name: "country"
      expr: country
      comment: "Country of the lead organization"
    - name: "lead_year"
      expr: DATE_TRUNC('year', creation_timestamp)
      comment: "Year the lead was created"
  measures:
    - name: "total_estimated_quantity"
      expr: SUM(CAST(estimated_quantity AS DOUBLE))
      comment: "Sum of estimated quantities from leads"
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Sum of estimated revenue from leads"
    - name: "lead_count"
      expr: COUNT(1)
      comment: "Number of lead records"
    - name: "nre_lead_count"
      expr: COUNT(CASE WHEN is_nre THEN 1 END)
      comment: "Count of leads flagged as NRE"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign effectiveness metrics"
  source: "`semiconductors_ecm`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_channel"
      expr: channel
      comment: "Marketing channel used for the campaign"
    - name: "campaign_region"
      expr: region
      comment: "Geographic region targeted by the campaign"
    - name: "campaign_status"
      expr: status
      comment: "Current status of the campaign"
    - name: "campaign_type"
      expr: type
      comment: "Type/category of the campaign"
    - name: "campaign_start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year the campaign started"
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across campaigns"
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to campaigns"
    - name: "average_roi_estimate"
      expr: AVG(CAST(roi_estimate AS DOUBLE))
      comment: "Average estimated ROI for campaigns"
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaign records"
$$;