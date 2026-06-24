-- Metric views for domain: promotion | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for promotional campaigns — budget utilization, revenue targeting, and campaign portfolio composition. Used by VP Merchandising and CMO to steer promotional investment and evaluate campaign effectiveness."
  source: "`vibe_retail_v1`.`promotion`.`promo_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of promotional campaign (e.g. seasonal, clearance, loyalty) for portfolio segmentation."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel(s) targeted by the campaign (e.g. in-store, digital, omni) for channel-mix analysis."
    - name: "promo_campaign_status"
      expr: promo_campaign_status
      comment: "Current lifecycle status of the campaign (e.g. planned, active, closed) for pipeline visibility."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status to track campaigns pending sign-off vs. approved."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the campaign is vendor-funded, enabling vendor vs. retailer cost split analysis."
    - name: "loyalty_exclusive_flag"
      expr: loyalty_exclusive_flag
      comment: "Flags campaigns exclusive to loyalty members for loyalty program ROI analysis."
    - name: "digital_promotion_flag"
      expr: digital_promotion_flag
      comment: "Distinguishes digital-only promotions for digital channel performance benchmarking."
    - name: "event_classification"
      expr: event_classification
      comment: "Business event classification (e.g. holiday, back-to-school) for seasonal planning."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic market scope of the campaign for regional performance comparison."
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date for time-series trending and calendar alignment."
    - name: "end_date"
      expr: end_date
      comment: "Campaign end date for duration and scheduling analysis."
    - name: "discount_strategy"
      expr: discount_strategy
      comment: "Discount approach used (e.g. percent-off, BOGO, fixed-amount) for strategy effectiveness comparison."
    - name: "priority_level"
      expr: priority_level
      comment: "Campaign priority tier for resource allocation and conflict resolution context."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of promotional campaigns. Baseline volume metric for portfolio sizing."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total promotional budget committed across campaigns. Core investment metric for CMO and finance review."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign. Benchmarks investment intensity and identifies over/under-funded campaigns."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue AS DOUBLE))
      comment: "Sum of revenue targets across all campaigns. Measures the revenue ambition of the promotional portfolio."
    - name: "avg_target_revenue_per_campaign"
      expr: AVG(CAST(target_revenue AS DOUBLE))
      comment: "Average revenue target per campaign. Used to benchmark campaign ambition and identify outliers."
    - name: "vendor_funded_campaign_count"
      expr: COUNT(CASE WHEN vendor_funded_flag = TRUE THEN 1 END)
      comment: "Number of vendor-funded campaigns. Tracks vendor co-investment in the promotional calendar."
    - name: "loyalty_exclusive_campaign_count"
      expr: COUNT(CASE WHEN loyalty_exclusive_flag = TRUE THEN 1 END)
      comment: "Number of loyalty-exclusive campaigns. Measures loyalty program promotional investment."
    - name: "digital_campaign_count"
      expr: COUNT(CASE WHEN digital_promotion_flag = TRUE THEN 1 END)
      comment: "Number of digital-only campaigns. Tracks digital channel promotional intensity."
    - name: "pending_approval_campaign_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Campaigns awaiting approval. Operational metric to prevent launch delays from approval bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core promotional effectiveness KPIs — revenue, margin, ROI, and sell-through by campaign, offer, SKU, and location. Primary dashboard for VP Merchandising, CMO, and category managers to evaluate promotional outcomes."
  source: "`vibe_retail_v1`.`promotion`.`promo_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g. in-store, online, mobile) for cross-channel performance comparison."
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (e.g. final, preliminary) for data quality filtering."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial measures for multi-currency reporting."
    - name: "performance_week_start_date"
      expr: performance_week_start_date
      comment: "Start of the measurement week for weekly trend analysis."
    - name: "performance_week_end_date"
      expr: performance_week_end_date
      comment: "End of the measurement week for weekly trend analysis."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that produced the performance record for lineage and reconciliation."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Total gross revenue generated during promotional periods. Primary top-line metric for promotional ROI assessment."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after discounts. Measures true promotional revenue contribution."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars given. Quantifies the cost of promotional activity to the P&L."
    - name: "total_cogs"
      expr: SUM(CAST(cogs AS DOUBLE))
      comment: "Total cost of goods sold during promotions. Required for gross margin calculation."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin AS DOUBLE))
      comment: "Total gross margin dollars earned during promotional periods. Core profitability metric."
    - name: "avg_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across promotional records. Benchmarks promotional profitability vs. baseline."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold during promotions. Volume metric for sell-through and inventory planning."
    - name: "total_incremental_units"
      expr: SUM(CAST(incremental_units AS DOUBLE))
      comment: "Incremental units sold above baseline. Measures true promotional lift, excluding cannibalization."
    - name: "total_baseline_units"
      expr: SUM(CAST(baseline_units AS DOUBLE))
      comment: "Baseline units expected without promotion. Used to compute incremental lift ratio."
    - name: "avg_promotional_roi"
      expr: AVG(CAST(promotional_roi AS DOUBLE))
      comment: "Average return on promotional investment. Key executive metric for evaluating promotional efficiency."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate during promotions. Measures inventory clearance effectiveness."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total vendor co-funding received. Tracks vendor investment contribution to promotional costs."
    - name: "total_retailer_funded_amount"
      expr: SUM(CAST(retailer_funded_amount AS DOUBLE))
      comment: "Total retailer-funded promotional spend. Measures own-funded promotional cost exposure."
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy for promotional periods. Measures planning quality and drives forecast model improvement."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(units_per_transaction AS DOUBLE))
      comment: "Average units per transaction during promotions. Indicates basket-building effectiveness of promotional mechanics."
    - name: "avg_transaction_value"
      expr: AVG(CAST(average_transaction_value AS DOUBLE))
      comment: "Average transaction value during promotional periods. Tracks whether promotions drive basket size or just traffic."
    - name: "total_cannibalization_estimate"
      expr: SUM(CAST(cannibalization_estimate AS DOUBLE))
      comment: "Estimated cannibalization of non-promoted sales. Critical for net incrementality assessment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional redemption KPIs — discount value, fraud risk, and channel mix of redemptions. Used by promotion operations, finance, and loss prevention to monitor redemption health and cost."
  source: "`vibe_retail_v1`.`promotion`.`promo_redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel where the redemption occurred (e.g. in-store, online) for channel-mix analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption (e.g. approved, rejected, reversed) for operational monitoring."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g. percent-off, fixed-amount, BOGO) for mechanic effectiveness analysis."
    - name: "redemption_mechanism"
      expr: redemption_mechanism
      comment: "How the promotion was redeemed (e.g. coupon, loyalty, auto-apply) for mechanic attribution."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Whether the redemption was vendor-funded for cost allocation between retailer and vendor."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Chargeback status for vendor-funded redemptions to track recovery of promotional costs."
    - name: "promotion_tier"
      expr: promotion_tier
      comment: "Tier of the promotion applied for tiered discount analysis."
    - name: "redemption_timestamp"
      expr: redemption_timestamp
      comment: "Timestamp of redemption for time-series trending and peak-period analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial measures for multi-currency reporting."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promotional redemptions. Baseline volume metric for redemption rate calculations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars redeemed. Measures the financial cost of promotional redemptions to the P&L."
    - name: "avg_discount_per_redemption"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount value per redemption. Benchmarks discount depth and identifies outlier redemptions."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total original price before discounts. Used to compute effective discount rate across the portfolio."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total final price paid after discounts. Measures net revenue from promoted transactions."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount claimed from vendors. Tracks vendor cost recovery on co-funded promotions."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across redemptions. Elevated scores trigger loss prevention investigation."
    - name: "high_fraud_risk_redemption_count"
      expr: COUNT(CASE WHEN fraud_score > 0.7 THEN 1 END)
      comment: "Count of redemptions with fraud score above 0.7. Operational metric for loss prevention prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional budget utilization and variance KPIs. Used by finance, VP Merchandising, and CMO to track spend against plan, identify over/under-spend, and manage channel allocation."
  source: "`vibe_retail_v1`.`promotion`.`promo_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of promotional budget (e.g. vendor-funded, retailer-funded, co-op) for funding source analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g. draft, approved, closed) for pipeline visibility."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for budget governance tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for in-period budget monitoring."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of budget amounts for multi-currency reporting."
    - name: "budget_owner_type"
      expr: budget_owner_type
      comment: "Type of budget owner (e.g. category, channel, brand) for accountability reporting."
    - name: "otb_integration_flag"
      expr: otb_integration_flag
      comment: "Whether the budget is integrated with open-to-buy planning for inventory-budget alignment."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Budget effective start date for time-period filtering."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Budget effective end date for time-period filtering."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total promotional budget allocated. Primary investment metric for executive budget review."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned promotional spend. Measures committed spend against total budget."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual promotional spend incurred. Core metric for budget vs. actuals variance reporting."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet spent) promotional budget. Measures encumbrance for cash flow planning."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent budget. Operational metric for identifying reallocation opportunities."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total vendor-funded portion of promotional budgets. Tracks vendor co-investment contribution."
    - name: "total_circular_ad_allocation"
      expr: SUM(CAST(circular_ad_allocation AS DOUBLE))
      comment: "Total budget allocated to circular advertising. Measures print/digital circular investment."
    - name: "total_ecommerce_channel_allocation"
      expr: SUM(CAST(ecommerce_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to e-commerce channel promotions. Tracks digital promotional investment."
    - name: "total_mobile_channel_allocation"
      expr: SUM(CAST(mobile_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to mobile channel promotions. Measures mobile-first promotional investment."
    - name: "total_pos_channel_allocation"
      expr: SUM(CAST(pos_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to POS channel promotions. Measures in-store promotional investment."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of promotional budget records. Used for average budget size and portfolio breadth analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional demand forecast accuracy and financial projection KPIs. Used by supply chain, merchandising, and finance to validate forecast quality and size inventory and funding commitments."
  source: "`vibe_retail_v1`.`promotion`.`promo_forecast`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for the forecast for channel-level demand planning."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g. draft, approved, actuals-loaded) for pipeline management."
    - name: "forecast_scenario"
      expr: forecast_scenario
      comment: "Forecast scenario (e.g. base, upside, downside) for scenario planning analysis."
    - name: "forecast_confidence_level"
      expr: forecast_confidence_level
      comment: "Qualitative confidence tier (e.g. high, medium, low) for forecast reliability segmentation."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion being forecast for mechanic-level demand analysis."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Whether the forecasted promotion is vendor-funded for cost allocation planning."
    - name: "replenishment_triggered_flag"
      expr: replenishment_triggered_flag
      comment: "Whether the forecast triggered a replenishment order for supply chain coordination."
    - name: "forecast_week_start_date"
      expr: forecast_week_start_date
      comment: "Start of the forecast week for weekly demand planning alignment."
    - name: "forecast_week_end_date"
      expr: forecast_week_end_date
      comment: "End of the forecast week for weekly demand planning alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial forecast measures."
    - name: "forecast_model_version"
      expr: forecast_model_version
      comment: "Version of the forecast model used for model performance tracking and A/B comparison."
  measures:
    - name: "total_forecasted_units"
      expr: SUM(CAST(total_forecasted_units AS DOUBLE))
      comment: "Total units forecasted to sell during promotional periods. Primary demand signal for inventory and supply chain planning."
    - name: "total_baseline_sales_forecast_units"
      expr: SUM(CAST(baseline_sales_forecast_units AS DOUBLE))
      comment: "Total baseline (non-promotional) units forecasted. Used to compute incremental lift from promotions."
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total incremental units expected from promotional activity above baseline. Core promotional lift metric."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue_amount AS DOUBLE))
      comment: "Total forecasted revenue from promotional periods. Used for financial planning and budget alignment."
    - name: "total_forecasted_discount_cost"
      expr: SUM(CAST(forecasted_discount_cost_amount AS DOUBLE))
      comment: "Total forecasted discount cost. Measures expected P&L impact of promotional discounting."
    - name: "total_vendor_funding_amount"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor funding expected for forecasted promotions. Tracks anticipated vendor co-investment."
    - name: "total_open_to_buy_impact"
      expr: SUM(CAST(open_to_buy_impact_amount AS DOUBLE))
      comment: "Total open-to-buy impact from promotional forecasts. Critical for inventory investment planning."
    - name: "avg_forecast_confidence_score"
      expr: AVG(CAST(forecast_confidence_score AS DOUBLE))
      comment: "Average forecast confidence score. Measures overall reliability of the promotional forecast portfolio."
    - name: "avg_forecast_error_percentage"
      expr: AVG(CAST(forecast_error_percentage AS DOUBLE))
      comment: "Average forecast error percentage. Key model quality metric — high error drives safety stock and margin risk."
    - name: "avg_forecast_adjustment_factor"
      expr: AVG(CAST(forecast_adjustment_factor AS DOUBLE))
      comment: "Average manual adjustment factor applied to model forecasts. Large values indicate model bias requiring recalibration."
    - name: "replenishment_triggered_count"
      expr: COUNT(CASE WHEN replenishment_triggered_flag = TRUE THEN 1 END)
      comment: "Number of forecast records that triggered replenishment orders. Measures promotional supply chain activation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional offer portfolio KPIs — offer composition, discount depth, and redemption ceiling analysis. Used by category managers and promotion planners to design and govern the offer portfolio."
  source: "`vibe_retail_v1`.`promotion`.`promo_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of promotional offer (e.g. percent-off, BOGO, bundle) for mechanic mix analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (e.g. draft, active, expired) for portfolio lifecycle management."
    - name: "discount_method"
      expr: discount_method
      comment: "Discount calculation method (e.g. percentage, fixed-amount) for financial modeling."
    - name: "channel_eligibility"
      expr: channel_eligibility
      comment: "Channels where the offer is valid for cross-channel offer distribution analysis."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Whether the offer is vendor-funded for cost allocation between retailer and vendor."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the offer can be stacked with other promotions for conflict and margin risk analysis."
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Whether the offer is personalized to individual customers for personalization program measurement."
    - name: "digital_delivery_flag"
      expr: digital_delivery_flag
      comment: "Whether the offer is delivered digitally for digital engagement tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for governance and compliance tracking."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Offer effective start date for calendar and seasonality analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Offer effective end date for duration and expiry analysis."
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of promotional offers in the portfolio. Baseline for offer density and complexity analysis."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Sum of discount values across all offers. Measures total discount depth in the offer portfolio."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer. Benchmarks discount depth and identifies outlier offers."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Sum of minimum purchase thresholds. Measures basket-size requirements built into the offer portfolio."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold per offer. Indicates how aggressively offers drive basket size."
    - name: "total_maximum_redemption_total"
      expr: SUM(CAST(maximum_redemption_total AS DOUBLE))
      comment: "Total maximum redemption cap across all offers. Measures total financial exposure ceiling of the offer portfolio."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average vendor cost-share percentage across offers. Tracks vendor funding contribution to offer costs."
    - name: "stackable_offer_count"
      expr: COUNT(CASE WHEN stackable_flag = TRUE THEN 1 END)
      comment: "Number of stackable offers. High counts increase margin risk from stacking — monitored by finance."
    - name: "personalized_offer_count"
      expr: COUNT(CASE WHEN personalization_flag = TRUE THEN 1 END)
      comment: "Number of personalized offers. Measures investment in 1:1 promotional targeting."
    - name: "vendor_funded_offer_count"
      expr: COUNT(CASE WHEN vendor_funded_flag = TRUE THEN 1 END)
      comment: "Number of vendor-funded offers. Tracks vendor co-investment in the offer portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_coupon_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon distribution effectiveness KPIs — reach, redemption rate, and cost efficiency. Used by marketing and promotion teams to evaluate coupon program ROI and optimize distribution channels."
  source: "`vibe_retail_v1`.`promotion`.`coupon_distribution`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which coupons were distributed (e.g. email, in-store, app) for channel effectiveness comparison."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Status of the distribution event (e.g. sent, delivered, failed) for operational monitoring."
    - name: "distribution_date"
      expr: distribution_date
      comment: "Date coupons were distributed for time-series trending and campaign calendar alignment."
  measures:
    - name: "total_distributions"
      expr: COUNT(1)
      comment: "Total number of coupon distribution events. Baseline volume metric for distribution program scale."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS BIGINT))
      comment: "Total coupons distributed. Measures promotional reach volume across all distribution events."
    - name: "total_redemption_count"
      expr: SUM(CAST(redemption_count AS BIGINT))
      comment: "Total coupons redeemed. Core metric for coupon program effectiveness."
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach AS BIGINT))
      comment: "Total actual audience reached by coupon distributions. Measures true promotional reach vs. target."
    - name: "total_target_reach"
      expr: SUM(CAST(target_reach AS BIGINT))
      comment: "Total targeted audience for coupon distributions. Used to compute reach attainment rate."
    - name: "total_distribution_cost"
      expr: SUM(CAST(distribution_cost AS DOUBLE))
      comment: "Total cost of coupon distribution. Used to compute cost-per-redemption and distribution ROI."
    - name: "avg_redemption_rate_percent"
      expr: AVG(CAST(redemption_rate_percent AS DOUBLE))
      comment: "Average coupon redemption rate. Primary effectiveness metric for coupon program optimization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate program portfolio KPIs — budget, discount depth, and vendor funding. Used by finance and merchandising to manage rebate liability, vendor co-funding, and program profitability."
  source: "`vibe_retail_v1`.`promotion`.`rebate`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. mail-in, instant, vendor) for program mix analysis."
    - name: "rebate_status"
      expr: rebate_status
      comment: "Current status of the rebate program (e.g. active, expired, suspended) for portfolio management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for governance tracking."
    - name: "channel_eligibility"
      expr: channel_eligibility
      comment: "Channels where the rebate is valid for cross-channel program analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of rebate financial measures."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Rebate program start date for calendar and seasonality analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Rebate program end date for duration and expiry analysis."
    - name: "requires_proof_of_purchase"
      expr: requires_proof_of_purchase
      comment: "Whether proof of purchase is required for redemption — affects redemption friction and fraud risk."
  measures:
    - name: "total_rebate_programs"
      expr: COUNT(1)
      comment: "Total number of rebate programs. Baseline for portfolio complexity and liability exposure."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across rebate programs. Measures total rebate liability ceiling."
    - name: "total_rebate_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of rebate face values. Measures total discount depth in the rebate portfolio."
    - name: "avg_rebate_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average rebate face value. Benchmarks rebate depth and identifies outlier programs."
    - name: "total_maximum_rebate_amount"
      expr: SUM(CAST(maximum_rebate_amount AS DOUBLE))
      comment: "Total maximum rebate payout cap. Measures maximum financial exposure from rebate programs."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Sum of minimum purchase thresholds across rebate programs. Measures basket-size requirements."
    - name: "avg_vendor_funding_percentage"
      expr: AVG(CAST(vendor_funding_percentage AS DOUBLE))
      comment: "Average vendor funding percentage across rebate programs. Tracks vendor co-investment in rebate costs."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average rebate percentage offered. Benchmarks rebate generosity across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_rebate_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate claim processing KPIs — approval rates, payout amounts, fraud flags, and processing efficiency. Used by finance and operations to manage rebate liability, vendor chargebacks, and fraud exposure."
  source: "`vibe_retail_v1`.`promotion`.`rebate_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the rebate claim (e.g. submitted, approved, rejected, paid) for pipeline management."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (e.g. consumer, retailer, vendor) for claim portfolio segmentation."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the claim was submitted (e.g. online, mail, in-store) for channel efficiency analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for approved rebates (e.g. check, ACH, gift card) for payment mix analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the claim was flagged for fraud for loss prevention monitoring."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of required documentation for the claim for processing bottleneck analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of claim financial measures."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the claim was submitted for time-series trending and SLA monitoring."
    - name: "vendor_chargeback_status"
      expr: vendor_chargeback_status
      comment: "Status of vendor chargeback for co-funded rebate cost recovery tracking."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of rebate claims submitted. Baseline volume metric for claim processing capacity planning."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed across all rebate claims. Measures gross rebate liability submitted."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for payment. Measures actual rebate payout liability."
    - name: "total_purchase_amount"
      expr: SUM(CAST(purchase_amount AS DOUBLE))
      comment: "Total purchase amount supporting rebate claims. Validates claim legitimacy and measures qualifying sales volume."
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved rebate amount per claim. Benchmarks payout size and identifies outlier claims."
    - name: "fraud_flagged_claim_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of claims flagged for fraud. Key loss prevention metric for rebate program integrity."
    - name: "approved_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'approved' THEN 1 END)
      comment: "Number of approved claims. Used to compute approval rate and measure processing efficiency."
    - name: "rejected_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'rejected' THEN 1 END)
      comment: "Number of rejected claims. High rejection rates indicate program design issues or fraud."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_vendor_promo_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor promotional agreement KPIs — funding commitments, accruals, settlement status, and compliance. Used by merchandising, finance, and vendor management to track vendor co-investment and settlement health."
  source: "`vibe_retail_v1`.`promotion`.`vendor_promo_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of vendor promotional agreement (e.g. co-op, MDF, scan-down) for program mix analysis."
    - name: "vendor_promo_agreement_status"
      expr: vendor_promo_agreement_status
      comment: "Current status of the agreement (e.g. active, expired, terminated) for portfolio management."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue vendor funding (e.g. scan-based, invoice-based) for accounting treatment."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "How often vendor funding is settled (e.g. monthly, quarterly) for cash flow planning."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Whether the agreement allows chargebacks for non-compliance for risk and recovery analysis."
    - name: "ad_placement_required"
      expr: ad_placement_required
      comment: "Whether ad placement is a performance obligation for compliance monitoring."
    - name: "display_compliance_required"
      expr: display_compliance_required
      comment: "Whether display compliance is required for funding eligibility."
    - name: "funding_currency_code"
      expr: funding_currency_code
      comment: "Currency of funding amounts for multi-currency vendor management."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Agreement effective start date for active portfolio filtering."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Agreement effective end date for expiry and renewal management."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of vendor promotional agreements. Baseline for vendor co-investment portfolio scale."
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total vendor funding committed across all agreements. Primary metric for vendor co-investment tracking."
    - name: "avg_funding_amount"
      expr: AVG(CAST(funding_amount AS DOUBLE))
      comment: "Average vendor funding per agreement. Benchmarks vendor investment intensity."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total vendor funding accrued to date. Measures earned but not yet settled vendor co-investment."
    - name: "total_settled_amount"
      expr: SUM(CAST(total_settled_amount AS DOUBLE))
      comment: "Total vendor funding settled (paid). Measures actual cash received from vendor co-investment."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding vendor funding balance (accrued but not settled). Key AR metric for finance."
    - name: "total_chargeback_penalty_amount"
      expr: SUM(CAST(chargeback_penalty_amount AS DOUBLE))
      comment: "Total chargeback penalties assessed for vendor non-compliance. Measures vendor compliance enforcement."
    - name: "avg_funding_percentage"
      expr: AVG(CAST(funding_percentage AS DOUBLE))
      comment: "Average vendor funding percentage across agreements. Benchmarks vendor cost-share rates."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase commitments across vendor agreements. Measures buying obligation tied to vendor funding."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_vendor_promo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor promotional claim settlement KPIs — claim amounts, dispute rates, and settlement efficiency. Used by finance and vendor management to track vendor funding recovery and dispute resolution."
  source: "`vibe_retail_v1`.`promotion`.`vendor_promo_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the vendor claim (e.g. submitted, approved, disputed, settled) for pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of vendor promotional claim (e.g. co-op, scan-down, MDF) for program mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of claim financial measures."
    - name: "is_automated_claim"
      expr: is_automated_claim
      comment: "Whether the claim was generated automatically vs. manually for process efficiency analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for settled claims for cash flow and payment mix analysis."
    - name: "claim_source_system"
      expr: claim_source_system
      comment: "Source system that generated the claim for lineage and reconciliation."
    - name: "claim_date"
      expr: claim_date
      comment: "Date the claim was submitted for time-series trending and aging analysis."
    - name: "claim_period_start_date"
      expr: claim_period_start_date
      comment: "Start of the claim period for period-level aggregation."
    - name: "claim_period_end_date"
      expr: claim_period_end_date
      comment: "End of the claim period for period-level aggregation."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of vendor promotional claims. Baseline volume metric for claim processing scale."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed from vendors. Measures gross vendor funding recovery demand."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for settlement. Measures confirmed vendor funding recovery."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount actually settled (paid by vendor). Core cash recovery metric for finance."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute. Measures at-risk vendor funding and dispute resolution workload."
    - name: "total_sales_revenue"
      expr: SUM(CAST(sales_revenue AS DOUBLE))
      comment: "Total sales revenue supporting vendor claims. Validates claim legitimacy and measures qualifying sales."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold supporting vendor promotional claims. Volume basis for scan-down and performance claims."
    - name: "disputed_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'disputed' THEN 1 END)
      comment: "Number of disputed vendor claims. High counts indicate vendor relationship or documentation issues."
    - name: "automated_claim_count"
      expr: COUNT(CASE WHEN is_automated_claim = TRUE THEN 1 END)
      comment: "Number of automatically generated claims. Measures automation adoption in vendor claim processing."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_circular_ad`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular advertising investment and production KPIs. Used by marketing and finance to track circular production costs, vendor funding, and publication pipeline."
  source: "`vibe_retail_v1`.`promotion`.`circular_ad`"
  dimensions:
    - name: "circular_type"
      expr: circular_type
      comment: "Type of circular (e.g. weekly, seasonal, digital-only) for format mix analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the circular (e.g. print, digital, email) for channel investment analysis."
    - name: "production_status"
      expr: production_status
      comment: "Current production status (e.g. in-design, approved, printed) for pipeline management."
    - name: "is_vendor_funded"
      expr: is_vendor_funded
      comment: "Whether the circular is vendor-funded for cost allocation analysis."
    - name: "compliance_review_flag"
      expr: compliance_review_flag
      comment: "Whether the circular requires compliance review for regulatory risk monitoring."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market for the circular for regional investment analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the circular for multilingual market coverage analysis."
    - name: "publication_date"
      expr: publication_date
      comment: "Publication date for time-series and calendar alignment."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Circular effective start date for promotional period alignment."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Circular effective end date for promotional period alignment."
  measures:
    - name: "total_circulars"
      expr: COUNT(1)
      comment: "Total number of circular ads produced. Baseline for circular program scale and production capacity."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total circular production cost. Core investment metric for marketing budget management."
    - name: "avg_production_cost"
      expr: AVG(CAST(production_cost_amount AS DOUBLE))
      comment: "Average production cost per circular. Benchmarks production efficiency and identifies cost outliers."
    - name: "total_vendor_funding_amount"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor co-funding received for circular production. Measures vendor investment in circular advertising."
    - name: "vendor_funded_circular_count"
      expr: COUNT(CASE WHEN is_vendor_funded = TRUE THEN 1 END)
      comment: "Number of vendor-funded circulars. Tracks vendor participation in circular advertising program."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_circular_ad_category_feature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular ad category feature performance KPIs — space allocation, sales lift, and vendor co-op. Used by category managers to evaluate circular feature effectiveness and optimize space allocation."
  source: "`vibe_retail_v1`.`promotion`.`circular_ad_category_feature`"
  dimensions:
    - name: "feature_prominence"
      expr: feature_prominence
      comment: "Prominence level of the category feature (e.g. cover, full-page, quarter-page) for placement value analysis."
    - name: "creative_theme"
      expr: creative_theme
      comment: "Creative theme of the feature for thematic performance comparison."
    - name: "vendor_co_op_flag"
      expr: vendor_co_op_flag
      comment: "Whether the feature is vendor co-op funded for cost allocation analysis."
    - name: "target_currency_code"
      expr: target_currency_code
      comment: "Currency of financial measures for multi-currency reporting."
  measures:
    - name: "total_actual_sales"
      expr: SUM(CAST(actual_sales_amount AS DOUBLE))
      comment: "Total actual sales generated by circular category features. Primary revenue outcome metric."
    - name: "total_category_sales_target"
      expr: SUM(CAST(category_sales_target AS DOUBLE))
      comment: "Total sales targets for circular category features. Used to compute attainment rate."
    - name: "total_allocated_space_sqin"
      expr: SUM(CAST(allocated_space_sqin AS DOUBLE))
      comment: "Total circular space allocated to category features in square inches. Measures space investment."
    - name: "avg_sales_lift_percent"
      expr: AVG(CAST(sales_lift_percent AS DOUBLE))
      comment: "Average sales lift percentage from circular features. Key effectiveness metric for circular ROI."
    - name: "avg_traffic_attribution_percent"
      expr: AVG(CAST(traffic_attribution_percent AS DOUBLE))
      comment: "Average traffic attribution percentage to circular features. Measures circular contribution to store traffic."
    - name: "total_vendor_co_op_amount"
      expr: SUM(CAST(vendor_co_op_amount AS DOUBLE))
      comment: "Total vendor co-op funding for circular features. Tracks vendor investment in category feature placement."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional inventory allocation efficiency KPIs — allocation accuracy, sell-through, and shortage risk. Used by supply chain and merchandising to ensure promotional inventory is correctly positioned and minimize stockouts."
  source: "`vibe_retail_v1`.`promotion`.`promo_inventory_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g. planned, confirmed, released) for pipeline management."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g. pre-allocation, replenishment, safety-stock) for allocation strategy analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate inventory (e.g. proportional, rank-based, forecast-driven) for methodology comparison."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allocation for governance tracking."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel for which inventory is allocated for cross-channel inventory balance analysis."
    - name: "shortage_flag"
      expr: shortage_flag
      comment: "Whether a shortage exists for this allocation for stockout risk monitoring."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Whether the allocation is on hold for operational exception management."
    - name: "reallocation_flag"
      expr: reallocation_flag
      comment: "Whether this is a reallocation event for rebalancing frequency analysis."
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date of the allocation for time-series and promotional calendar alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial measures."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of promotional inventory allocation records. Baseline for allocation program scale."
    - name: "total_allocated_cost"
      expr: SUM(CAST(allocated_cost_amount AS DOUBLE))
      comment: "Total cost of allocated promotional inventory. Measures inventory investment tied to promotions."
    - name: "total_allocation_cost"
      expr: SUM(CAST(total_allocation_cost_amount AS DOUBLE))
      comment: "Total allocation cost including all components. Comprehensive inventory cost metric for promotional planning."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage of available inventory. Measures how aggressively inventory is committed to promotions."
    - name: "avg_allocation_confidence_score"
      expr: AVG(CAST(allocation_confidence_score AS DOUBLE))
      comment: "Average confidence score of allocation decisions. Low scores indicate high uncertainty in promotional demand."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate for allocated promotional inventory. Measures allocation accuracy and demand fulfillment."
    - name: "shortage_allocation_count"
      expr: COUNT(CASE WHEN shortage_flag = TRUE THEN 1 END)
      comment: "Number of allocations with active shortages. Operational metric for stockout risk management."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost_amount AS DOUBLE))
      comment: "Total unit cost of allocated promotional inventory. Used for margin and cost-of-promotion analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_stack`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion stacking configuration KPIs — budget allocation, discount caps, and stacking complexity. Used by promotion planners and finance to manage margin risk from stacked promotions."
  source: "`vibe_retail_v1`.`promotion`.`promotion_stack`"
  dimensions:
    - name: "stack_type"
      expr: stack_type
      comment: "Type of promotion stack (e.g. loyalty+coupon, clearance+markdown) for stacking pattern analysis."
    - name: "stack_status"
      expr: stack_status
      comment: "Current status of the stack (e.g. active, expired, suspended) for portfolio management."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels where the stack is applicable for cross-channel margin risk analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the stack is currently active for live portfolio monitoring."
    - name: "requires_coupon"
      expr: requires_coupon
      comment: "Whether a coupon is required to activate the stack for coupon dependency analysis."
    - name: "combinable_with_clearance"
      expr: combinable_with_clearance
      comment: "Whether the stack can combine with clearance pricing — high margin risk flag."
    - name: "exclude_sale_items"
      expr: exclude_sale_items
      comment: "Whether sale items are excluded from the stack for margin protection analysis."
    - name: "auto_apply"
      expr: auto_apply
      comment: "Whether the stack is automatically applied at checkout for friction and conversion analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the stack (e.g. retailer, vendor, shared) for cost allocation."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Stack effective start date for calendar alignment."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Stack effective end date for expiry management."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of budget measures."
  measures:
    - name: "total_stacks"
      expr: COUNT(1)
      comment: "Total number of promotion stacks. Baseline for stacking complexity and margin risk exposure."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to promotion stacks. Measures financial commitment to stacked promotions."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget per promotion stack. Benchmarks investment intensity per stacking configuration."
    - name: "total_maximum_discount_amount"
      expr: SUM(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Total maximum discount cap across all stacks. Measures maximum discount liability from stacking."
    - name: "avg_maximum_discount_amount"
      expr: AVG(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Average maximum discount cap per stack. Benchmarks discount ceiling and margin protection."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase thresholds across stacks. Measures basket-size requirements for stack activation."
    - name: "clearance_combinable_stack_count"
      expr: COUNT(CASE WHEN combinable_with_clearance = TRUE THEN 1 END)
      comment: "Number of stacks combinable with clearance pricing. High counts represent elevated margin risk."
    - name: "active_stack_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active promotion stacks. Operational metric for live promotional complexity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon business metrics"
  source: "`vibe_retail_v1`.`promotion`.`coupon`"
  dimensions:
    - name: "Barcode"
      expr: barcode
    - name: "Coupon Code"
      expr: coupon_code
    - name: "Coupon Status"
      expr: coupon_status
    - name: "Coupon Type"
      expr: coupon_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Digital Distribution Quantity"
      expr: digital_distribution_quantity
    - name: "Digital Wallet Enabled Flag"
      expr: digital_wallet_enabled_flag
    - name: "Discount Type"
      expr: discount_type
    - name: "Eligible Channel"
      expr: eligible_channel
    - name: "Eligible Product Scope"
      expr: eligible_product_scope
    - name: "Exclusion List"
      expr: exclusion_list
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Issue Channel"
      expr: issue_channel
    - name: "Issue Date"
      expr: issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coupon"
      expr: COUNT(DISTINCT coupon_id)
    - name: "Total Face Value"
      expr: SUM(face_value)
    - name: "Average Face Value"
      expr: AVG(face_value)
    - name: "Total Maximum Discount Amount"
      expr: SUM(maximum_discount_amount)
    - name: "Average Maximum Discount Amount"
      expr: AVG(maximum_discount_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Calendar business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_calendar`"
  dimensions:
    - name: "Applicable Banner Codes"
      expr: applicable_banner_codes
    - name: "Applicable Market Codes"
      expr: applicable_market_codes
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Banner Applicability"
      expr: banner_applicability
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Circular Production Deadline"
      expr: circular_production_deadline
    - name: "Competitive Response Flag"
      expr: competitive_response_flag
    - name: "Competitive Trigger Description"
      expr: competitive_trigger_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Month"
      expr: fiscal_month
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Calendar"
      expr: COUNT(DISTINCT promo_calendar_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Expected Sales Lift Pct"
      expr: SUM(expected_sales_lift_pct)
    - name: "Average Expected Sales Lift Pct"
      expr: AVG(expected_sales_lift_pct)
    - name: "Total Expected Traffic Lift Pct"
      expr: SUM(expected_traffic_lift_pct)
    - name: "Average Expected Traffic Lift Pct"
      expr: AVG(expected_traffic_lift_pct)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_conflict_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Conflict Rule business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_conflict_rule`"
  dimensions:
    - name: "Applies To Scope"
      expr: applies_to_scope
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audit Log Required Flag"
      expr: audit_log_required_flag
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment Restriction"
      expr: customer_segment_restriction
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Stack Count"
      expr: max_stack_count
    - name: "Notes"
      expr: notes
    - name: "Oms System Flag"
      expr: oms_system_flag
    - name: "Override Allowed Flag"
      expr: override_allowed_flag
    - name: "Override Authorization Level"
      expr: override_authorization_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Conflict Rule"
      expr: COUNT(DISTINCT promo_conflict_rule_id)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Max Discount Percentage"
      expr: SUM(max_discount_percentage)
    - name: "Average Max Discount Percentage"
      expr: AVG(max_discount_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Group business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_group`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Business Owner"
      expr: business_owner
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Conflict Resolution Rule"
      expr: conflict_resolution_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Applicability"
      expr: customer_segment_applicability
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Scope"
      expr: exclusion_scope
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Group Code"
      expr: group_code
    - name: "Group Description"
      expr: group_description
    - name: "Group Name"
      expr: group_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Group"
      expr: COUNT(DISTINCT promo_group_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promotion_stack`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Stack business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promotion_stack`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Apply"
      expr: auto_apply
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Combinable With Clearance"
      expr: combinable_with_clearance
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclude Sale Items"
      expr: exclude_sale_items
    - name: "Funding Source"
      expr: funding_source
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Stack"
      expr: COUNT(DISTINCT promotion_stack_id)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Maximum Discount Amount"
      expr: SUM(maximum_discount_amount)
    - name: "Average Maximum Discount Amount"
      expr: AVG(maximum_discount_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;