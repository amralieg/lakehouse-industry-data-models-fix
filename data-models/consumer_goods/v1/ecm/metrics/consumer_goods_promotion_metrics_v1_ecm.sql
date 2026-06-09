-- Metric views for domain: promotion | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial and performance KPIs for promotion events"
  source: "`consumer_goods_ecm`.`promotion`.`promotion_event`"
  dimensions:
    - name: "promotion_event_id"
      expr: promotion_event_id
      comment: "Unique identifier for the promotion event"
    - name: "event_name"
      expr: event_name
      comment: "Descriptive name of the promotion event"
    - name: "event_type"
      expr: event_type
      comment: "Type/category of the promotion event"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of promotion start date"
    - name: "end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month of promotion end date"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account linked to the event"
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic region code for the event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for monetary values"
  measures:
    - name: "total_actual_trade_spend_amount"
      expr: SUM(CAST(actual_trade_spend_amount AS DOUBLE))
      comment: "Total actual trade spend for the promotion event"
    - name: "total_planned_trade_spend_amount"
      expr: SUM(CAST(planned_trade_spend_amount AS DOUBLE))
      comment: "Total planned trade spend for the promotion event"
    - name: "average_promotional_lift_percentage"
      expr: AVG(CAST(promotional_lift_percentage AS DOUBLE))
      comment: "Average promotional lift percentage across events"
    - name: "average_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average ROI percentage for the promotion event"
    - name: "average_gmroi_ratio"
      expr: AVG(CAST(gmroi_ratio AS DOUBLE))
      comment: "Average GMROI ratio for the promotion event"
    - name: "total_baseline_volume_units"
      expr: SUM(CAST(baseline_volume_units AS DOUBLE))
      comment: "Sum of baseline volume units for the promotion event"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of promotion events"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_trade_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and volume targets for trade promotions"
  source: "`consumer_goods_ecm`.`promotion`.`trade_promotion`"
  dimensions:
    - name: "trade_promotion_id"
      expr: trade_promotion_id
      comment: "Unique identifier for the trade promotion"
    - name: "promotion_name"
      expr: promotion_name
      comment: "Name of the trade promotion"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of trade promotion"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month when promotion starts"
    - name: "end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month when promotion ends"
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Marketing brand linked to promotion"
    - name: "category_id"
      expr: category_id
      comment: "Product category for promotion"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account responsible for promotion"
    - name: "country_code"
      expr: country_code
      comment: "Country where promotion is executed"
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrual amount for the trade promotion"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deduction amount for the trade promotion"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered"
    - name: "total_target_volume_units"
      expr: SUM(CAST(target_volume_units AS DOUBLE))
      comment: "Total target volume units for the promotion"
    - name: "average_expected_roi_percentage"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage"
    - name: "promotion_count"
      expr: COUNT(1)
      comment: "Number of trade promotions"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_lift_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lift measurement KPIs for promotional effectiveness"
  source: "`consumer_goods_ecm`.`promotion`.`lift_measurement`"
  dimensions:
    - name: "lift_measurement_id"
      expr: lift_measurement_id
      comment: "Unique identifier for the lift measurement"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the lift measurement"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account linked to measurement"
    - name: "trade_promotion_id"
      expr: trade_promotion_id
      comment: "Trade promotion tied to the measurement"
    - name: "measurement_week_start"
      expr: DATE_TRUNC('week', measurement_week_start_date)
      comment: "Start of measurement week"
    - name: "measurement_week_end"
      expr: DATE_TRUNC('week', measurement_week_end_date)
      comment: "End of measurement week"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary values"
  measures:
    - name: "total_actual_promoted_volume_units"
      expr: SUM(CAST(actual_promoted_volume_units AS DOUBLE))
      comment: "Total actual promoted volume units measured"
    - name: "average_incremental_lift_percentage"
      expr: AVG(CAST(incremental_lift_percentage AS DOUBLE))
      comment: "Average incremental lift percentage across measurements"
    - name: "average_incremental_lift_units"
      expr: AVG(CAST(incremental_lift_units AS DOUBLE))
      comment: "Average incremental lift units"
    - name: "average_incremental_revenue"
      expr: AVG(CAST(incremental_revenue AS DOUBLE))
      comment: "Average incremental revenue attributed to lift"
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Number of lift measurement records"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_pos_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS redemption performance metrics"
  source: "`consumer_goods_ecm`.`promotion`.`pos_redemption`"
  dimensions:
    - name: "pos_redemption_id"
      expr: pos_redemption_id
      comment: "Unique identifier for the POS redemption record"
    - name: "redemption_date"
      expr: DATE_TRUNC('day', redemption_date)
      comment: "Date of redemption"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU redeemed"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account associated with redemption"
    - name: "promotion_event_id"
      expr: promotion_event_id
      comment: "Promotion event driving the redemption"
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which redemption occurred"
    - name: "country_code"
      expr: country_code
      comment: "Country of redemption"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of redemption values"
  measures:
    - name: "total_redemption_quantity"
      expr: SUM(CAST(redemption_quantity AS DOUBLE))
      comment: "Total quantity of items redeemed at POS"
    - name: "total_redemption_value_amount"
      expr: SUM(CAST(redemption_value_amount AS DOUBLE))
      comment: "Total monetary value of POS redemptions"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied at redemption"
    - name: "redemption_count"
      expr: COUNT(1)
      comment: "Number of POS redemption transactions"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_funding_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial commitment and target metrics for funding agreements"
  source: "`consumer_goods_ecm`.`promotion`.`funding_agreement`"
  dimensions:
    - name: "funding_agreement_id"
      expr: funding_agreement_id
      comment: "Unique identifier for the funding agreement"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account linked to the agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the agreement"
    - name: "funding_start_month"
      expr: DATE_TRUNC('month', funding_period_start_date)
      comment: "Funding period start month"
    - name: "funding_end_month"
      expr: DATE_TRUNC('month', funding_period_end_date)
      comment: "Funding period end month"
  measures:
    - name: "total_accrued_to_date_amount"
      expr: SUM(CAST(accrued_to_date_amount AS DOUBLE))
      comment: "Total amount accrued to date under the funding agreement"
    - name: "total_paid_to_date_amount"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total amount paid to date under the funding agreement"
    - name: "average_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average GMROI target set in the agreement"
    - name: "average_roi_target_percentage"
      expr: AVG(CAST(roi_target_percentage AS DOUBLE))
      comment: "Average ROI target percentage"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of funding agreements"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`promotion_baseline_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baseline volume and revenue reference metrics for promotions"
  source: "`consumer_goods_ecm`.`promotion`.`baseline_volume`"
  dimensions:
    - name: "baseline_volume_id"
      expr: baseline_volume_id
      comment: "Unique identifier for the baseline volume record"
    - name: "category_id"
      expr: category_id
      comment: "Product category for baseline"
    - name: "channel_classification_id"
      expr: channel_classification_id
      comment: "Channel classification for baseline"
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Marketing brand associated with baseline"
    - name: "trade_account_id"
      expr: trade_account_id
      comment: "Trade account linked to baseline"
    - name: "baseline_start_month"
      expr: DATE_TRUNC('month', baseline_period_start_date)
      comment: "Baseline period start month"
    - name: "baseline_end_month"
      expr: DATE_TRUNC('month', baseline_period_end_date)
      comment: "Baseline period end month"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of baseline amounts"
  measures:
    - name: "total_baseline_revenue_amount"
      expr: SUM(CAST(baseline_revenue_amount AS DOUBLE))
      comment: "Total baseline revenue amount"
    - name: "total_cases"
      expr: SUM(CAST(cases AS DOUBLE))
      comment: "Total baseline cases"
    - name: "total_units"
      expr: SUM(CAST(units AS DOUBLE))
      comment: "Total baseline units"
    - name: "average_seasonality_adjustment_factor"
      expr: AVG(CAST(seasonality_adjustment_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor applied"
    - name: "average_trend_adjustment_factor"
      expr: AVG(CAST(trend_adjustment_factor AS DOUBLE))
      comment: "Average trend adjustment factor applied"
    - name: "baseline_record_count"
      expr: COUNT(1)
      comment: "Number of baseline volume records"
$$;