-- Metric views for domain: sales | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertising order metrics tracking contracted value, spot counts, and pricing performance across campaigns, advertisers, and channels"
  source: "`media_broadcasting_ecm`.`sales`.`ad_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the advertising order (e.g., confirmed, pending, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of advertising order (e.g., upfront, scatter, programmatic)"
    - name: "product_category"
      expr: product_category
      comment: "Product category being advertised"
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic segment for the advertising campaign"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order values"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the order (e.g., monthly, quarterly)"
    - name: "political_ad_flag"
      expr: political_ad_flag
      comment: "Indicates whether this is a political advertising order"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year when the advertising flight begins"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the advertising flight begins"
    - name: "order_created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date when the order was created"
  measures:
    - name: "total_contracted_value"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted value across all advertising orders"
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value after discounts and commissions"
    - name: "avg_contracted_cpm"
      expr: AVG(CAST(contracted_cpm AS DOUBLE))
      comment: "Average contracted cost per thousand impressions"
    - name: "avg_contracted_cprp"
      expr: AVG(CAST(contracted_cprp AS DOUBLE))
      comment: "Average contracted cost per rating point"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to orders"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate for sales agencies"
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target gross rating points across all orders"
    - name: "order_count"
      expr: COUNT(DISTINCT ad_order_id)
      comment: "Distinct count of advertising orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_contracted_value AS DOUBLE))
      comment: "Average contracted value per advertising order"
    - name: "discount_impact"
      expr: SUM(CAST(total_contracted_value AS DOUBLE) * CAST(discount_percentage AS DOUBLE) / 100.0)
      comment: "Total dollar impact of discounts on contracted value"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising spot delivery and performance metrics tracking impressions, GRPs, revenue, and fulfillment across scheduled and actual airings"
  source: "`media_broadcasting_ecm`.`sales`.`ad_spot`"
  dimensions:
    - name: "spot_status"
      expr: spot_status
      comment: "Current status of the advertising spot (e.g., aired, scheduled, preempted)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the spot (e.g., billed, pending, disputed)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the spot aired or was scheduled (e.g., prime, daytime, late night)"
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code where the spot aired"
    - name: "market_code"
      expr: market_code
      comment: "Market code for the spot placement"
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Indicates whether this spot is a makegood for a previously missed or underdelivered spot"
    - name: "preempted_flag"
      expr: preempted_flag
      comment: "Indicates whether the spot was preempted"
    - name: "bonus_spot_flag"
      expr: bonus_spot_flag
      comment: "Indicates whether this is a bonus spot provided at no charge"
    - name: "dai_flag"
      expr: dai_flag
      comment: "Indicates whether dynamic ad insertion was used"
    - name: "scheduled_air_month"
      expr: DATE_TRUNC('MONTH', scheduled_air_date)
      comment: "Month when the spot was scheduled to air"
    - name: "actual_air_month"
      expr: DATE_TRUNC('MONTH', actual_air_time)
      comment: "Month when the spot actually aired"
  measures:
    - name: "total_spot_revenue"
      expr: SUM(CAST(spot_rate_amount AS DOUBLE))
      comment: "Total revenue from spot rates across all aired spots"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total impressions delivered across all spots"
    - name: "total_grp_value"
      expr: SUM(CAST(grp_value AS DOUBLE))
      comment: "Total gross rating points delivered"
    - name: "total_trp_value"
      expr: SUM(CAST(trp_value AS DOUBLE))
      comment: "Total target rating points delivered"
    - name: "avg_cpm_amount"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average cost per thousand impressions across spots"
    - name: "spot_count"
      expr: COUNT(DISTINCT ad_spot_id)
      comment: "Distinct count of advertising spots"
    - name: "preemption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preempted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spots that were preempted"
    - name: "makegood_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN makegood_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spots that are makegoods"
    - name: "avg_spot_rate"
      expr: AVG(CAST(spot_rate_amount AS DOUBLE))
      comment: "Average spot rate amount per spot"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN spot_status = 'aired' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled spots that successfully aired"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising campaign performance metrics tracking budget, target audience reach, and campaign effectiveness across advertisers and market types"
  source: "`media_broadcasting_ecm`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g., active, completed, paused)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand awareness, direct response, product launch)"
    - name: "market_type"
      expr: market_type
      comment: "Market type for the campaign (e.g., national, local, regional)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the campaign was sold"
    - name: "product_brand"
      expr: product_brand
      comment: "Product brand being advertised in the campaign"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the campaign"
    - name: "makegood_eligible_flag"
      expr: makegood_eligible_flag
      comment: "Indicates whether the campaign is eligible for makegoods"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for campaign budget"
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year when the campaign starts"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the campaign starts"
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all campaigns"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total target impressions across all campaigns"
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target gross rating points across campaigns"
    - name: "total_target_trp"
      expr: SUM(CAST(target_trp AS DOUBLE))
      comment: "Total target rating points across campaigns"
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target cost per thousand impressions"
    - name: "avg_target_cprp"
      expr: AVG(CAST(target_cprp AS DOUBLE))
      comment: "Average target cost per rating point"
    - name: "avg_target_frequency"
      expr: AVG(CAST(target_frequency AS DOUBLE))
      comment: "Average target frequency (number of times target audience sees the ad)"
    - name: "avg_target_reach_percent"
      expr: AVG(CAST(target_reach_percent AS DOUBLE))
      comment: "Average target reach percentage of the target audience"
    - name: "campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Distinct count of advertising campaigns"
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_impression_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital advertising impression delivery and engagement metrics tracking served impressions, viewability, completion rates, and realized revenue"
  source: "`media_broadcasting_ecm`.`sales`.`impression_delivery`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status
      comment: "Status of the ad insertion (e.g., delivered, failed, skipped)"
    - name: "insertion_type"
      expr: insertion_type
      comment: "Type of ad insertion (e.g., pre-roll, mid-roll, post-roll)"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform where the impression was delivered (e.g., web, mobile, CTV)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the impression was delivered"
    - name: "browser_type"
      expr: browser_type
      comment: "Browser type used by the viewer"
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of the viewing device"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the impression"
    - name: "cdn_delivery_confirmed_flag"
      expr: cdn_delivery_confirmed_flag
      comment: "Indicates whether CDN delivery was confirmed"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for revenue amounts"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month when impressions were delivered"
    - name: "delivery_date_day"
      expr: DATE_TRUNC('DAY', delivery_date)
      comment: "Day when impressions were delivered"
  measures:
    - name: "total_impressions_served"
      expr: SUM(CAST(total_impressions_served AS BIGINT))
      comment: "Total impressions served across all deliveries"
    - name: "total_viewable_impressions"
      expr: SUM(CAST(viewable_impressions AS BIGINT))
      comment: "Total viewable impressions (met viewability standards)"
    - name: "total_completed_views"
      expr: SUM(CAST(completed_views AS BIGINT))
      comment: "Total number of ads viewed to completion"
    - name: "total_click_throughs"
      expr: SUM(CAST(click_throughs AS BIGINT))
      comment: "Total number of click-throughs on ads"
    - name: "total_impression_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue generated from impression deliveries"
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate_percent AS DOUBLE))
      comment: "Average viewability rate percentage across impressions"
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average completion rate percentage for video ads"
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate_percent AS DOUBLE))
      comment: "Average click-through rate percentage"
    - name: "avg_cpm_realized"
      expr: AVG(CAST(cpm_realized AS DOUBLE))
      comment: "Average realized cost per thousand impressions"
    - name: "viewability_rate_aggregate"
      expr: ROUND(100.0 * SUM(CAST(viewable_impressions AS BIGINT)) / NULLIF(SUM(CAST(total_impressions_served AS BIGINT)), 0), 2)
      comment: "Aggregate viewability rate across all impressions"
    - name: "completion_rate_aggregate"
      expr: ROUND(100.0 * SUM(CAST(completed_views AS BIGINT)) / NULLIF(SUM(CAST(total_impressions_served AS BIGINT)), 0), 2)
      comment: "Aggregate completion rate across all impressions"
    - name: "effective_cpm"
      expr: ROUND(1000.0 * SUM(CAST(revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_impressions_served AS BIGINT)), 0), 2)
      comment: "Effective CPM calculated from actual revenue and impressions"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast and pipeline metrics tracking revenue projections, quota attainment, and forecast accuracy across territories and deal types"
  source: "`media_broadcasting_ecm`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., draft, submitted, approved)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Category of forecast (e.g., commit, best case, pipeline)"
    - name: "period_type"
      expr: period_type
      comment: "Type of forecast period (e.g., monthly, quarterly, annual)"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the forecast"
    - name: "broadcast_year"
      expr: broadcast_year
      comment: "Broadcast year for the forecast"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (e.g., upfront, scatter, programmatic)"
    - name: "account_segment"
      expr: account_segment
      comment: "Account segment for the forecast"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for forecast amounts"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month when the forecast period starts"
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecasts"
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota amount across all forecasts"
    - name: "total_closed_revenue"
      expr: SUM(CAST(closed_revenue AS DOUBLE))
      comment: "Total closed (won) revenue"
    - name: "total_commit_revenue"
      expr: SUM(CAST(commit_revenue AS DOUBLE))
      comment: "Total committed revenue in the forecast"
    - name: "total_pipeline_revenue"
      expr: SUM(CAST(pipeline_revenue AS DOUBLE))
      comment: "Total pipeline revenue"
    - name: "total_upfront_revenue"
      expr: SUM(CAST(upfront_revenue AS DOUBLE))
      comment: "Total upfront deal revenue"
    - name: "total_scatter_revenue"
      expr: SUM(CAST(scatter_revenue AS DOUBLE))
      comment: "Total scatter market revenue"
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average quota attainment percentage"
    - name: "forecast_count"
      expr: COUNT(DISTINCT forecast_id)
      comment: "Distinct count of forecasts"
    - name: "quota_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(closed_revenue AS DOUBLE)) / NULLIF(SUM(CAST(quota_amount AS DOUBLE)), 0), 2)
      comment: "Aggregate quota attainment rate (closed revenue vs quota)"
    - name: "forecast_accuracy"
      expr: ROUND(100.0 * SUM(CAST(closed_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_forecasted_revenue AS DOUBLE)), 0), 2)
      comment: "Forecast accuracy (closed revenue vs forecasted revenue)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales opportunity pipeline metrics tracking deal value, win probability, and conversion across stages and product categories"
  source: "`media_broadcasting_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current stage of the sales opportunity (e.g., prospecting, proposal, negotiation, closed won)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category for the opportunity (e.g., pipeline, best case, commit)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (e.g., upfront, scatter, sponsorship)"
    - name: "product_category"
      expr: product_category
      comment: "Product category for the opportunity"
    - name: "daypart"
      expr: daypart
      comment: "Daypart for the opportunity"
    - name: "demographic_target"
      expr: demographic_target
      comment: "Target demographic for the opportunity"
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the lead (e.g., inbound, referral, outbound)"
    - name: "is_upfront"
      expr: is_upfront
      comment: "Indicates whether this is an upfront deal opportunity"
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for opportunity loss (if applicable)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for opportunity value"
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month when the opportunity is expected to close"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total target impressions across opportunities"
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target gross rating points across opportunities"
    - name: "avg_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across opportunities"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across opportunities"
    - name: "avg_cprp_rate"
      expr: AVG(CAST(cprp_rate AS DOUBLE))
      comment: "Average CPRP rate across opportunities"
    - name: "opportunity_count"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Distinct count of sales opportunities"
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE) * CAST(probability AS DOUBLE) / 100.0)
      comment: "Weighted pipeline value (estimated value × win probability)"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per opportunity"
    - name: "win_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN stage = 'Closed Won' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Win rate percentage (closed won opportunities / total opportunities)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_upfront_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront deal commitment and pricing metrics tracking annual commitments, audience guarantees, and negotiated rates for advance advertising purchases"
  source: "`media_broadcasting_ecm`.`sales`.`upfront_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the upfront deal (e.g., proposed, committed, executed)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of upfront deal (e.g., volume, audience guarantee, hybrid)"
    - name: "deal_year"
      expr: deal_year
      comment: "Broadcast year for the upfront deal"
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis for the deal (e.g., CPM, CPRP, fixed rate)"
    - name: "channel_mix"
      expr: channel_mix
      comment: "Mix of channels included in the upfront deal"
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Mix of dayparts included in the upfront deal"
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Indicates whether makegood provisions are included"
    - name: "scatter_conversion_rights"
      expr: scatter_conversion_rights
      comment: "Indicates whether the deal includes rights to convert to scatter market"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for deal amounts"
    - name: "commitment_month"
      expr: DATE_TRUNC('MONTH', commitment_date)
      comment: "Month when the deal was committed"
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed spend across all upfront deals"
    - name: "total_proposed_spend"
      expr: SUM(CAST(total_proposed_spend AS DOUBLE))
      comment: "Total proposed spend across all upfront deals"
    - name: "total_audience_guarantee_impressions"
      expr: SUM(CAST(audience_guarantee_impressions AS BIGINT))
      comment: "Total guaranteed impressions across upfront deals"
    - name: "total_audience_guarantee_grp"
      expr: SUM(CAST(audience_guarantee_grp AS DOUBLE))
      comment: "Total guaranteed gross rating points across upfront deals"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate negotiated in upfront deals"
    - name: "avg_cprp_rate"
      expr: AVG(CAST(cprp_rate AS DOUBLE))
      comment: "Average CPRP rate negotiated in upfront deals"
    - name: "upfront_deal_count"
      expr: COUNT(DISTINCT upfront_deal_id)
      comment: "Distinct count of upfront deals"
    - name: "avg_deal_size"
      expr: AVG(CAST(total_committed_spend AS DOUBLE))
      comment: "Average committed spend per upfront deal"
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_committed_spend AS DOUBLE)) / NULLIF(SUM(CAST(total_proposed_spend AS DOUBLE)), 0), 2)
      comment: "Commitment rate (committed spend vs proposed spend)"
    - name: "effective_cpm"
      expr: ROUND(1000.0 * SUM(CAST(total_committed_spend AS DOUBLE)) / NULLIF(SUM(CAST(audience_guarantee_impressions AS BIGINT)), 0), 2)
      comment: "Effective CPM based on committed spend and guaranteed impressions"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales proposal performance metrics tracking proposal value, win rates, and conversion across advertisers and campaign types"
  source: "`media_broadcasting_ecm`.`sales`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., draft, submitted, accepted, rejected)"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g., upfront, scatter, sponsorship)"
    - name: "proposal_source"
      expr: proposal_source
      comment: "Source of the proposal (e.g., RFP, proactive, renewal)"
    - name: "market_type"
      expr: market_type
      comment: "Market type for the proposal (e.g., national, local, regional)"
    - name: "demographic_target"
      expr: demographic_target
      comment: "Target demographic for the proposal"
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Indicates whether the proposal includes audience guarantees"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for proposal values"
    - name: "proposal_month"
      expr: DATE_TRUNC('MONTH', proposal_date)
      comment: "Month when the proposal was created"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month when the proposal was submitted"
  measures:
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Total proposed value across all proposals"
    - name: "total_net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Total net proposed value after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across proposals"
    - name: "total_proposed_impressions"
      expr: SUM(CAST(proposed_impressions AS BIGINT))
      comment: "Total proposed impressions across proposals"
    - name: "total_proposed_grp"
      expr: SUM(CAST(proposed_grp AS DOUBLE))
      comment: "Total proposed gross rating points"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM across proposals"
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average CPRP across proposals"
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average win probability percentage across proposals"
    - name: "proposal_count"
      expr: COUNT(DISTINCT proposal_id)
      comment: "Distinct count of proposals"
    - name: "avg_proposal_value"
      expr: AVG(CAST(total_proposed_value AS DOUBLE))
      comment: "Average proposed value per proposal"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN proposal_status = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proposal acceptance rate percentage"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to proposals"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_advertiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertiser account health and credit metrics tracking account status, credit limits, and advertiser segmentation"
  source: "`media_broadcasting_ecm`.`sales`.`advertiser`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the advertiser account (e.g., active, inactive, suspended)"
    - name: "credit_status"
      expr: credit_status
      comment: "Credit status of the advertiser (e.g., approved, under review, restricted)"
    - name: "annual_spend_tier"
      expr: annual_spend_tier
      comment: "Annual spend tier classification (e.g., platinum, gold, silver, bronze)"
    - name: "industry_category"
      expr: industry_category
      comment: "Industry category of the advertiser"
    - name: "is_political_advertiser"
      expr: is_political_advertiser
      comment: "Indicates whether this is a political advertiser"
    - name: "requires_ad_clearance"
      expr: requires_ad_clearance
      comment: "Indicates whether the advertiser requires ad clearance"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code for billing address"
    - name: "preferred_currency_code"
      expr: preferred_currency_code
      comment: "Preferred currency code for the advertiser"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the advertiser"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit across all advertisers"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per advertiser"
    - name: "advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Distinct count of advertisers"
    - name: "active_advertiser_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN advertiser_id END)
      comment: "Count of active advertisers"
    - name: "political_advertiser_count"
      expr: COUNT(DISTINCT CASE WHEN is_political_advertiser = TRUE THEN advertiser_id END)
      comment: "Count of political advertisers"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_makegood`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Makegood fulfillment and resolution metrics tracking underdelivery remediation, approval rates, and makegood value across campaigns"
  source: "`media_broadcasting_ecm`.`sales`.`makegood`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the makegood (e.g., pending, approved, rejected)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the makegood (e.g., scheduled, aired, cancelled)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the makegood (e.g., preemption, underdelivery, technical issue)"
    - name: "affidavit_generated_flag"
      expr: affidavit_generated_flag
      comment: "Indicates whether an affidavit was generated for the makegood"
    - name: "original_daypart"
      expr: original_daypart
      comment: "Daypart of the original spot that required a makegood"
    - name: "proposed_daypart"
      expr: proposed_daypart
      comment: "Proposed daypart for the makegood spot"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the makegood was created"
    - name: "actual_air_month"
      expr: DATE_TRUNC('MONTH', actual_air_date)
      comment: "Month when the makegood spot actually aired"
  measures:
    - name: "total_original_spot_value"
      expr: SUM(CAST(original_spot_rate AS DOUBLE))
      comment: "Total value of original spots that required makegoods"
    - name: "total_original_contracted_grp"
      expr: SUM(CAST(original_contracted_grp AS DOUBLE))
      comment: "Total contracted GRP of original spots"
    - name: "total_original_actual_grp"
      expr: SUM(CAST(original_actual_grp AS DOUBLE))
      comment: "Total actual GRP delivered by original spots"
    - name: "total_proposed_estimated_grp"
      expr: SUM(CAST(proposed_estimated_grp AS DOUBLE))
      comment: "Total estimated GRP for proposed makegood spots"
    - name: "makegood_count"
      expr: COUNT(DISTINCT makegood_id)
      comment: "Distinct count of makegoods"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Makegood approval rate percentage"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'aired' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Makegood resolution rate (successfully aired)"
    - name: "avg_grp_underdelivery"
      expr: AVG(CAST(original_contracted_grp AS DOUBLE) - CAST(original_actual_grp AS DOUBLE))
      comment: "Average GRP underdelivery that triggered makegoods"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and quota metrics tracking rep productivity, quota attainment, and territory coverage"
  source: "`media_broadcasting_ecm`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Current status of the sales rep (e.g., active, inactive, on leave)"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (e.g., top performer, meets expectations, needs improvement)"
    - name: "account_portfolio_segment"
      expr: account_portfolio_segment
      comment: "Account portfolio segment assigned to the rep"
    - name: "deal_type_specialization"
      expr: deal_type_specialization
      comment: "Deal type specialization of the rep (e.g., upfront, scatter, digital)"
    - name: "territory_assignment"
      expr: territory_assignment
      comment: "Territory assignment for the rep"
    - name: "commission_plan_type"
      expr: commission_plan_type
      comment: "Commission plan type for the rep"
    - name: "digital_certified_flag"
      expr: digital_certified_flag
      comment: "Indicates whether the rep is certified for digital sales"
    - name: "upfront_certified_flag"
      expr: upfront_certified_flag
      comment: "Indicates whether the rep is certified for upfront sales"
    - name: "office_location"
      expr: office_location
      comment: "Office location of the sales rep"
  measures:
    - name: "total_annual_quota"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota across all sales reps"
    - name: "avg_annual_quota"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average annual quota per sales rep"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate percentage across reps"
    - name: "rep_count"
      expr: COUNT(DISTINCT rep_id)
      comment: "Distinct count of sales reps"
    - name: "active_rep_count"
      expr: COUNT(DISTINCT CASE WHEN rep_status = 'active' THEN rep_id END)
      comment: "Count of active sales reps"
    - name: "digital_certified_rep_count"
      expr: COUNT(DISTINCT CASE WHEN digital_certified_flag = TRUE THEN rep_id END)
      comment: "Count of digital-certified sales reps"
    - name: "upfront_certified_rep_count"
      expr: COUNT(DISTINCT CASE WHEN upfront_certified_flag = TRUE THEN rep_id END)
      comment: "Count of upfront-certified sales reps"
$$;