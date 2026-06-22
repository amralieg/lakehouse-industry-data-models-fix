-- Metric views for domain: marketing | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign performance metrics tracking budget utilization, sales lift, and ROI across all marketing campaigns. Used by CMO and VP Marketing to steer campaign investment decisions."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign (e.g., LTO, brand, promotional) for performance segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, completed, paused) for pipeline visibility."
    - name: "owning_brand"
      expr: owning_brand
      comment: "Brand that owns the campaign, enabling cross-brand performance comparison."
    - name: "target_market"
      expr: target_market
      comment: "Geographic or demographic market targeted by the campaign."
    - name: "target_daypart"
      expr: target_daypart
      comment: "Daypart targeted by the campaign (breakfast, lunch, dinner, late night)."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the campaign supports a Limited Time Offer."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the campaign was planned to start, for temporal trend analysis."
    - name: "objective"
      expr: objective
      comment: "Primary business objective of the campaign (traffic, awareness, trial, loyalty)."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline measure for campaign portfolio sizing."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total planned marketing budget across all campaigns. Core investment tracking KPI."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across all campaigns. Compared against budget to assess spend discipline."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget allocated per campaign. Helps benchmark investment levels across campaign types."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget actually spent. Measures spend execution efficiency; under/over-spend signals planning accuracy."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_pct AS DOUBLE))
      comment: "Average expected comparable sales lift percentage across campaigns. Sets the performance bar for campaign planning."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE))
      comment: "Average actual comparable sales lift percentage achieved. Core outcome KPI for campaign effectiveness."
    - name: "comp_sales_lift_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_comp_sales_lift_pct AS DOUBLE)) / NULLIF(SUM(CAST(expected_comp_sales_lift_pct AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to expected comp sales lift, expressed as a percentage. Measures how well campaigns deliver against their sales lift targets."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_pct AS DOUBLE))
      comment: "Average actual Average Daily Transaction lift percentage. Measures campaign-driven traffic impact."
    - name: "lto_campaign_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Number of campaigns tied to Limited Time Offers. Tracks LTO campaign pipeline volume."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics at the unit and channel level. Used by field marketing and operations teams to track execution quality, spend efficiency, and sales lift delivery."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_channel"
      expr: execution_channel
      comment: "Channel through which the campaign was executed (digital, print, radio, OOH)."
    - name: "campaign_execution_status"
      expr: campaign_execution_status
      comment: "Current status of the execution (launched, completed, cancelled) for pipeline tracking."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for the execution, enabling geographic performance analysis."
    - name: "launch_date"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of campaign launch for temporal trend analysis."
    - name: "target_segment"
      expr: target_segment
      comment: "Guest segment targeted by this execution for audience effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which spend and financial metrics are denominated."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of campaign executions. Baseline measure for execution volume."
    - name: "total_channel_spend"
      expr: SUM(CAST(channel_spend_amount AS DOUBLE))
      comment: "Total spend across all campaign executions. Core financial accountability metric."
    - name: "avg_channel_spend_per_execution"
      expr: AVG(CAST(channel_spend_amount AS DOUBLE))
      comment: "Average spend per campaign execution. Benchmarks cost efficiency across channels and markets."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comparable sales lift delivered by executions. Primary outcome KPI for field marketing."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comparable sales lift for executions. Baseline for attainment calculation."
    - name: "comp_sales_lift_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_comp_sales_lift_percent AS DOUBLE)) / NULLIF(SUM(CAST(expected_comp_sales_lift_percent AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to expected comp sales lift at execution level. Identifies over/under-performing executions."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average return on investment percentage across executions. Drives channel mix and budget reallocation decisions."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click across digital executions. Efficiency KPI for digital channel investment."
    - name: "avg_cost_per_impression"
      expr: AVG(CAST(cost_per_impression AS DOUBLE))
      comment: "Average cost per impression. Measures media buying efficiency for awareness campaigns."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual Average Daily Transaction lift delivered. Measures traffic-driving effectiveness of executions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_roi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign return on investment metrics for post-campaign financial analysis. Used by CFO, CMO, and Finance to evaluate marketing investment effectiveness and guide future budget allocation."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_roi`"
  dimensions:
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Attribution model used (last-touch, multi-touch, incrementality) — affects how ROI is interpreted."
    - name: "channel"
      expr: channel
      comment: "Marketing channel for which ROI is measured, enabling channel-level investment decisions."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic ROI comparison."
    - name: "measurement_period_start"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month the measurement period started, for temporal ROI trend analysis."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Statistical confidence level of the ROI measurement (high, medium, low) for result reliability assessment."
    - name: "campaign_roi_status"
      expr: campaign_roi_status
      comment: "Status of the ROI record (final, preliminary, revised) for data quality filtering."
  measures:
    - name: "total_roi_records"
      expr: COUNT(1)
      comment: "Total number of ROI measurement records. Baseline for coverage analysis."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend measured across all ROI records. Core investment accountability metric."
    - name: "total_incremental_revenue"
      expr: SUM(CAST(incremental_revenue AS DOUBLE))
      comment: "Total incremental revenue attributed to marketing campaigns. Primary revenue impact KPI."
    - name: "total_net_incremental_profit"
      expr: SUM(CAST(net_incremental_profit AS DOUBLE))
      comment: "Total net incremental profit after deducting COGS impact. True profitability measure of marketing investment."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total cost of goods sold impact from campaign-driven volume. Required for accurate profit calculation."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage across all measured campaigns. Primary executive KPI for marketing effectiveness."
    - name: "revenue_to_spend_ratio"
      expr: ROUND(SUM(CAST(incremental_revenue AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of incremental revenue to marketing spend. Measures revenue multiplier effect of marketing investment."
    - name: "profit_to_spend_ratio"
      expr: ROUND(SUM(CAST(net_incremental_profit AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of net incremental profit to spend. True profitability return per dollar of marketing investment."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_campaign_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing spend tracking and budget management metrics. Used by Finance and Marketing Operations to monitor spend pacing, variance, and payment status across campaigns."
  source: "`vibe_restaurants_v1`.`marketing`.`campaign_spend`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing channel for spend categorization (TV, digital, OOH, print)."
    - name: "media_type"
      expr: media_type
      comment: "Type of media for the spend record, enabling media mix analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend for annual budget tracking."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the spend for quarterly budget pacing."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the spend record (approved, pending, rejected) for financial control."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the spend for multi-currency reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice for spend timing analysis."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total gross marketing spend. Primary budget consumption metric."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend after discounts. Actual financial obligation metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on marketing spend. Required for accurate financial reporting and tax compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts received on marketing spend. Measures vendor negotiation effectiveness."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual spend. Signals budget management discipline."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average spend variance percentage. Measures budget forecasting accuracy across spend categories."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate on marketing spend. Used for tax planning and cost modeling."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_digital_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital marketing performance metrics covering impressions, clicks, conversions, and ROI. Used by Digital Marketing and CMO to optimize digital channel investment and creative performance."
  source: "`vibe_restaurants_v1`.`marketing`.`digital_campaign_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Digital channel (paid search, social, display, video) for channel-level performance analysis."
    - name: "platform"
      expr: platform
      comment: "Specific platform (Google, Meta, TikTok, YouTube) for platform-level investment decisions."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (video, banner, carousel, story) for creative format effectiveness analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level optimization."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional digital performance comparison."
    - name: "event_date"
      expr: DATE_TRUNC('week', event_date)
      comment: "Week of the performance event for trend analysis."
    - name: "audience_segment"
      expr: audience_segment
      comment: "Audience segment targeted for segment-level performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of ad delivery for time-of-day optimization."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the digital campaign supports an LTO for LTO-specific performance tracking."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total ad impressions delivered. Measures campaign reach and awareness scale."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks on digital ads. Measures audience engagement and intent."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed to digital campaigns. Primary outcome metric for performance marketing."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual digital spend. Core financial accountability metric."
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to digital campaigns. Measures direct revenue impact of digital investment."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views across digital campaigns. Measures video content engagement."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate across digital placements. Measures creative and targeting relevance."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate from click to action. Measures landing page and offer effectiveness."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click. Measures digital media buying efficiency."
    - name: "avg_cost_per_acquisition"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost to acquire one converting customer. Key efficiency metric for performance marketing."
    - name: "avg_cost_per_mille"
      expr: AVG(CAST(cost_per_mille AS DOUBLE))
      comment: "Average cost per thousand impressions. Measures awareness campaign cost efficiency."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percentage for digital campaigns. Drives digital channel budget allocation decisions."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency_average AS DOUBLE))
      comment: "Average ad frequency per user. Monitors ad fatigue risk and reach/frequency balance."
    - name: "avg_view_through_rate"
      expr: AVG(CAST(view_through_rate AS DOUBLE))
      comment: "Average view-through rate for video ads. Measures video creative effectiveness."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated unique reach across digital campaigns. Measures audience coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion redemption metrics tracking discount utilization, financial impact, and guest engagement. Used by Marketing and Finance to evaluate promotion effectiveness and cost."
  source: "`vibe_restaurants_v1`.`marketing`.`promotion_redemption`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Channel through which the promotion was redeemed (in-store, app, web, drive-thru)."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of redemption for time-of-day promotion effectiveness analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, fixed amount, BOGO) for promotion structure analysis."
    - name: "promotion_redemption_status"
      expr: promotion_redemption_status
      comment: "Status of the redemption (successful, voided, failed) for data quality filtering."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Flag indicating whether the redemption was by a loyalty member. Measures loyalty program overlap with promotions."
    - name: "redemption_timestamp"
      expr: DATE_TRUNC('week', redemption_timestamp)
      comment: "Week of redemption for temporal trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of promotion redemptions. Baseline measure for promotion uptake."
    - name: "unique_guests_redeeming"
      expr: COUNT(DISTINCT promotion_guest_profile_id)
      comment: "Number of unique guests who redeemed a promotion. Measures promotion reach among guest base."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value given to guests. Measures the financial cost of promotions."
    - name: "total_order_value_before_discount"
      expr: SUM(CAST(order_value_before_discount AS DOUBLE))
      comment: "Total order value before discount application. Measures gross revenue associated with promoted transactions."
    - name: "total_order_value_after_discount"
      expr: SUM(CAST(order_value_after_discount AS DOUBLE))
      comment: "Total order value after discount. Measures net revenue from promoted transactions."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Benchmarks promotion generosity and cost per transaction."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied. Measures depth of promotional discounting."
    - name: "discount_to_revenue_ratio"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(order_value_before_discount AS DOUBLE)), 0), 2)
      comment: "Discount cost as a percentage of pre-discount order value. Measures promotion cost efficiency."
    - name: "loyalty_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions by loyalty members. Measures loyalty program engagement with promotions."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_fund_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing fund contribution metrics tracking franchisee contributions, compliance, and fund health. Used by Finance and Franchise Operations to monitor fund collection and reconciliation."
  source: "`vibe_restaurants_v1`.`marketing`.`fund_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (mandatory, voluntary, co-op) for fund composition analysis."
    - name: "contribution_period_type"
      expr: contribution_period_type
      comment: "Period type (weekly, monthly, quarterly) for contribution cadence analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the contribution (reconciled, pending, disputed) for financial close tracking."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the contribution record for pipeline management."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the contribution period for temporal trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contribution for multi-currency fund reporting."
  measures:
    - name: "total_contributions"
      expr: COUNT(1)
      comment: "Total number of contribution records. Baseline for contribution volume tracking."
    - name: "total_contribution_amount"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total marketing fund contributions collected. Primary fund health metric."
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales on which contributions are based. Measures the revenue base driving fund contributions."
    - name: "avg_contribution_rate"
      expr: AVG(CAST(contribution_rate AS DOUBLE))
      comment: "Average contribution rate applied. Monitors rate consistency and compliance with fund agreements."
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average contribution per record. Benchmarks contribution levels across franchisees."
    - name: "unique_contributing_franchisees"
      expr: COUNT(DISTINCT franchisee_id)
      comment: "Number of unique franchisees contributing to the fund. Measures fund participation breadth."
    - name: "pending_reconciliation_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'pending' THEN 1 END)
      comment: "Number of contributions pending reconciliation. Operational metric for finance close process management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media buying efficiency and delivery metrics. Used by Media Planning and CMO to evaluate media investment performance, delivery against contracted impressions, and cost efficiency."
  source: "`vibe_restaurants_v1`.`marketing`.`media_buy`"
  dimensions:
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (video, display, audio, OOH) for format-level performance analysis."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic media performance analysis."
    - name: "media_buy_status"
      expr: media_buy_status
      comment: "Status of the media buy (active, completed, cancelled) for portfolio management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the media buy for financial close tracking."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Flag indicating programmatic vs. direct media buying for channel strategy analysis."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month the media flight started for temporal spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the media buy for multi-currency reporting."
  measures:
    - name: "total_media_buys"
      expr: COUNT(1)
      comment: "Total number of media buys. Baseline for media portfolio sizing."
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted media spend. Measures committed media investment."
    - name: "total_net_spend"
      expr: SUM(CAST(net_spend AS DOUBLE))
      comment: "Total net media spend after adjustments. Actual financial obligation metric."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total actual impressions delivered. Measures media delivery against contracted volume."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted impressions. Baseline for delivery attainment calculation."
    - name: "impression_delivery_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions AS DOUBLE)) / NULLIF(SUM(CAST(contracted_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted impressions actually delivered. Measures media vendor delivery performance."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across media buys. Benchmarks media buying cost efficiency."
    - name: "avg_actual_cpm"
      expr: AVG(CAST(actual_cpm AS DOUBLE))
      comment: "Average actual CPM achieved. Compared against contracted CPM to assess negotiation effectiveness."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to media buys. Monitors make-good and billing correction volume."
    - name: "total_contracted_grps"
      expr: SUM(CAST(contracted_grps AS DOUBLE))
      comment: "Total contracted Gross Rating Points for broadcast media. Measures planned audience weight."
    - name: "total_actual_grps"
      expr: SUM(CAST(actual_grps AS DOUBLE))
      comment: "Total actual GRPs delivered. Measures broadcast audience delivery against plan."
    - name: "grp_delivery_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_grps AS DOUBLE)) / NULLIF(SUM(CAST(contracted_grps AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted GRPs actually delivered. Broadcast media delivery KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_influencer_activation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing activation performance metrics. Used by Social Media and Brand teams to evaluate influencer ROI, engagement delivery, and compliance."
  source: "`vibe_restaurants_v1`.`marketing`.`influencer_activation`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform (Instagram, TikTok, YouTube) for platform-level influencer performance analysis."
    - name: "influencer_category"
      expr: influencer_category
      comment: "Category of influencer (food, lifestyle, family) for content strategy analysis."
    - name: "activation_type"
      expr: activation_type
      comment: "Type of activation (sponsored post, story, reel, live) for format effectiveness analysis."
    - name: "influencer_activation_status"
      expr: influencer_activation_status
      comment: "Status of the activation (live, completed, cancelled) for pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "FTC and brand compliance status of the activation. Critical for legal risk management."
    - name: "content_go_live_date"
      expr: DATE_TRUNC('month', content_go_live_date)
      comment: "Month content went live for temporal performance analysis."
    - name: "influencer_region"
      expr: influencer_region
      comment: "Geographic region of the influencer for regional reach analysis."
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of influencer activations. Baseline for influencer program scale."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments to influencers. Core financial accountability metric for influencer spend."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions generated by influencer content. Measures awareness reach."
    - name: "total_actual_likes"
      expr: SUM(CAST(actual_likes AS DOUBLE))
      comment: "Total likes across influencer activations. Measures positive audience engagement."
    - name: "total_actual_comments"
      expr: SUM(CAST(actual_comments AS DOUBLE))
      comment: "Total comments across influencer activations. Measures deep engagement and conversation."
    - name: "total_actual_shares"
      expr: SUM(CAST(actual_shares AS DOUBLE))
      comment: "Total shares across influencer activations. Measures organic amplification."
    - name: "total_earned_media_value"
      expr: SUM(CAST(earned_media_value AS DOUBLE))
      comment: "Total earned media value generated by influencer activations. Measures ROI beyond paid reach."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(influencer_engagement_rate AS DOUBLE))
      comment: "Average engagement rate across activations. Primary influencer quality and effectiveness KPI."
    - name: "avg_total_engagement"
      expr: AVG(CAST(total_engagement AS DOUBLE))
      comment: "Average total engagement per activation. Benchmarks influencer content performance."
    - name: "cost_per_engagement"
      expr: ROUND(SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_engagement AS DOUBLE)), 0), 4)
      comment: "Cost per unit of engagement across influencer activations. Measures influencer investment efficiency."
    - name: "ftc_disclosure_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ftc_disclosure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activations with FTC disclosure. Critical legal compliance metric for influencer marketing."
    - name: "unique_influencers_activated"
      expr: COUNT(DISTINCT influencer_id)
      comment: "Number of unique influencers activated. Measures influencer roster breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_local_store_marketing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local store marketing initiative performance metrics. Used by Field Marketing and Franchise Operations to track LSM spend efficiency, sales lift delivery, and LMF fund utilization."
  source: "`vibe_restaurants_v1`.`marketing`.`local_store_marketing`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of LSM initiative (sponsorship, community event, local media) for initiative mix analysis."
    - name: "channel"
      expr: channel
      comment: "Channel used for the LSM initiative for channel effectiveness analysis."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area for geographic LSM performance comparison."
    - name: "local_store_marketing_status"
      expr: local_store_marketing_status
      comment: "Status of the LSM initiative (active, completed, cancelled) for pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the LSM initiative for compliance and governance tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the LSM initiative is compliant with brand standards."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the LSM initiative started for temporal trend analysis."
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total number of LSM initiatives. Baseline for local marketing activity volume."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend on LSM initiatives. Core financial accountability metric."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned spend on LSM initiatives. Budget baseline for variance analysis."
    - name: "total_lmf_fund_used"
      expr: SUM(CAST(lmf_fund_used AS DOUBLE))
      comment: "Total Local Marketing Fund amount utilized. Measures fund utilization efficiency."
    - name: "total_lmf_fund_amount"
      expr: SUM(CAST(lmf_fund_amount AS DOUBLE))
      comment: "Total LMF amount allocated to LSM initiatives. Measures fund deployment."
    - name: "lmf_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(lmf_fund_used AS DOUBLE)) / NULLIF(SUM(CAST(lmf_fund_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated LMF funds actually utilized. Measures fund deployment effectiveness."
    - name: "spend_variance_amount"
      expr: SUM((CAST(actual_spend AS DOUBLE)) - (CAST(planned_spend AS DOUBLE)))
      comment: "Difference between actual and planned LSM spend. Measures budget execution accuracy."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comparable sales lift from LSM initiatives. Primary outcome KPI for local marketing."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average expected comp sales lift. Baseline for LSM attainment calculation."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LSM initiatives that are brand-compliant. Measures brand standards adherence in local marketing."
    - name: "unique_units_with_lsm"
      expr: COUNT(DISTINCT local_unit_id)
      comment: "Number of unique restaurant units running LSM initiatives. Measures local marketing program penetration."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_lto`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limited Time Offer marketing performance metrics. Used by Brand Marketing and Menu Strategy teams to evaluate LTO revenue performance, sales lift, and promotional pricing effectiveness."
  source: "`vibe_restaurants_v1`.`marketing`.`marketing_lto`"
  dimensions:
    - name: "lto_status"
      expr: lto_status
      comment: "Status of the LTO (active, expired, upcoming) for pipeline management."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the LTO is currently active."
    - name: "target_segment"
      expr: target_segment
      comment: "Guest segment targeted by the LTO for audience effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of LTO financial metrics."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the LTO started for temporal performance analysis."
  measures:
    - name: "total_ltos"
      expr: COUNT(1)
      comment: "Total number of LTO records. Baseline for LTO portfolio sizing."
    - name: "total_actual_sales_amount"
      expr: SUM(CAST(actual_sales_amount AS DOUBLE))
      comment: "Total actual sales revenue generated by LTOs. Primary revenue outcome metric."
    - name: "total_projected_revenue"
      expr: SUM(CAST(projected_revenue AS DOUBLE))
      comment: "Total projected revenue from LTOs. Baseline for revenue attainment calculation."
    - name: "total_target_revenue"
      expr: SUM(CAST(target_revenue AS DOUBLE))
      comment: "Total target revenue for LTOs. Strategic goal baseline."
    - name: "revenue_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_sales_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_revenue AS DOUBLE)), 0), 2)
      comment: "Percentage of target revenue achieved by LTOs. Measures LTO commercial success."
    - name: "avg_promo_price"
      expr: AVG(CAST(promo_price AS DOUBLE))
      comment: "Average promotional price point across LTOs. Informs pricing strategy for future LTOs."
    - name: "avg_actual_sales"
      expr: AVG(CAST(actual_sales AS DOUBLE))
      comment: "Average actual sales per LTO record. Benchmarks LTO performance."
    - name: "avg_expected_lift_pct"
      expr: AVG(CAST(expected_lift_pct AS DOUBLE))
      comment: "Average expected sales lift percentage for LTOs. Planning baseline metric."
    - name: "avg_projected_lift_pct"
      expr: AVG(CAST(projected_lift_pct AS DOUBLE))
      comment: "Average projected sales lift percentage. Measures LTO lift forecasting."
    - name: "total_target_sales_lift"
      expr: SUM(CAST(target_sales_lift AS DOUBLE))
      comment: "Total target sales lift across all LTOs. Aggregate goal for LTO program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon program metrics tracking discount depth, redemption patterns, and financial impact. Used by Marketing and Finance to optimize coupon strategy and manage promotional cost."
  source: "`vibe_restaurants_v1`.`marketing`.`coupon`"
  dimensions:
    - name: "coupon_type"
      expr: coupon_type
      comment: "Type of coupon (digital, print, in-app) for channel distribution analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed, BOGO) for promotion structure analysis."
    - name: "coupon_status"
      expr: coupon_status
      comment: "Current status of the coupon (active, expired, redeemed) for portfolio management."
    - name: "eligible_item_category"
      expr: eligible_item_category
      comment: "Menu item category eligible for the coupon for category-level promotion analysis."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether the coupon can be stacked with other offers. Affects financial risk modeling."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the coupon was issued for temporal distribution analysis."
  measures:
    - name: "total_coupons"
      expr: COUNT(1)
      comment: "Total number of coupons issued. Baseline for coupon program scale."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total fixed discount value across all coupons. Measures maximum financial exposure from coupon program."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per coupon. Benchmarks coupon generosity."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across percentage-based coupons. Measures depth of promotional discounting."
    - name: "unique_menu_items_promoted"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of unique menu items promoted via coupons. Measures breadth of coupon program across menu."
    - name: "exclusive_coupon_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN 1 END)
      comment: "Number of exclusive coupons issued. Measures targeted vs. mass coupon strategy."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`marketing_ad_creative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad creative portfolio metrics tracking production investment, creative performance, and compliance. Used by Creative and Brand teams to manage creative assets and optimize production spend."
  source: "`vibe_restaurants_v1`.`marketing`.`ad_creative`"
  dimensions:
    - name: "creative_type"
      expr: creative_type
      comment: "Type of creative asset (video, static, animated, audio) for format mix analysis."
    - name: "creative_category"
      expr: creative_category
      comment: "Business category of the creative (LTO, brand, seasonal) for portfolio analysis."
    - name: "ad_creative_status"
      expr: ad_creative_status
      comment: "Current status of the creative (active, archived, in-review) for asset lifecycle management."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the creative. Critical for brand standards enforcement."
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal approval status of the creative. Required for risk management."
    - name: "language"
      expr: language
      comment: "Language of the creative for multilingual market analysis."
    - name: "channel_suitability"
      expr: channel_suitability
      comment: "Channels for which the creative is suitable for channel deployment planning."
    - name: "approved_timestamp"
      expr: DATE_TRUNC('month', approved_timestamp)
      comment: "Month the creative was approved for production pipeline analysis."
  measures:
    - name: "total_creatives"
      expr: COUNT(1)
      comment: "Total number of creative assets. Baseline for creative portfolio sizing."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost AS DOUBLE))
      comment: "Total production cost across all creative assets. Core creative investment metric."
    - name: "avg_production_cost"
      expr: AVG(CAST(production_cost AS DOUBLE))
      comment: "Average production cost per creative. Benchmarks creative production efficiency."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to creative assets. Measures creative investment commitment."
    - name: "avg_roi_estimate"
      expr: AVG(CAST(roi_estimate AS DOUBLE))
      comment: "Average estimated ROI per creative asset. Guides creative investment prioritization."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of video/audio creatives in seconds. Informs media buying and format strategy."
    - name: "brand_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of creatives with approved brand compliance status. Measures brand standards adherence in creative production."
    - name: "archived_creative_count"
      expr: COUNT(CASE WHEN is_archived = TRUE THEN 1 END)
      comment: "Number of archived creative assets. Measures creative library lifecycle management."
$$;