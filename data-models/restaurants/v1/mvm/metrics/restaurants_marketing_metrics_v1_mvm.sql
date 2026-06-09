-- Metric views for domain: marketing | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the campaign master table. Tracks campaign investment, performance lift, and budget efficiency to inform marketing spend allocation and campaign effectiveness decisions."
  source: "`restaurants_ecm`.`marketing`.`campaign`"
  filter: is_test_campaign = False
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., national, local, digital, LTO) used to segment performance by campaign category."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (e.g., active, completed, cancelled) for filtering and trend analysis."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Media channel mix used in the campaign (e.g., TV+Digital, Radio+OOH) to evaluate channel strategy effectiveness."
    - name: "objective"
      expr: objective
      comment: "Primary business objective of the campaign (e.g., traffic, awareness, trial) for goal-based performance grouping."
    - name: "target_daypart"
      expr: target_daypart
      comment: "Daypart targeted by the campaign (e.g., breakfast, lunch, dinner) to assess daypart-level marketing ROI."
    - name: "target_market"
      expr: target_market
      comment: "Geographic market targeted by the campaign for regional performance benchmarking."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the campaign supports a Limited Time Offer, enabling LTO vs. evergreen campaign comparison."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the campaign is compliant with brand and regulatory standards, used for compliance reporting."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the campaign was planned to start, used for time-series trending of campaign launches."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the campaign actually started, used to measure launch timing accuracy vs. plan."
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual marketing spend across campaigns. Core investment metric for budget stewardship and ROI analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total planned budget allocated across campaigns. Used to assess budget utilization and over/under-spend."
    - name: "avg_actual_spend_per_campaign"
      expr: AVG(CAST(actual_spend AS DOUBLE))
      comment: "Average actual spend per campaign. Benchmarks campaign investment levels and identifies outliers."
    - name: "avg_actual_adt_lift_pct"
      expr: AVG(CAST(actual_adt_lift_pct AS DOUBLE))
      comment: "Average actual Average Daily Transaction (ADT) lift percentage across campaigns. Key traffic effectiveness KPI for marketing leadership."
    - name: "avg_actual_comp_sales_lift_pct"
      expr: AVG(CAST(actual_comp_sales_lift_pct AS DOUBLE))
      comment: "Average actual comparable sales lift percentage across campaigns. Primary revenue impact KPI used in QBRs and board decks."
    - name: "avg_expected_comp_sales_lift_pct"
      expr: AVG(CAST(expected_comp_sales_lift_pct AS DOUBLE))
      comment: "Average expected comparable sales lift percentage at campaign planning. Used as the baseline for lift variance analysis."
    - name: "avg_expected_adt_lift_pct"
      expr: AVG(CAST(expected_adt_lift_pct AS DOUBLE))
      comment: "Average expected ADT lift percentage at campaign planning. Paired with actual ADT lift to evaluate forecast accuracy."
    - name: "total_spend_over_budget"
      expr: SUM(CAST(actual_spend AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total spend variance (actual minus budget) across campaigns. Positive values indicate overspend; drives budget governance actions."
    - name: "count_active_campaigns"
      expr: COUNT(CASE WHEN campaign_status = 'Active' THEN campaign_id END)
      comment: "Number of currently active campaigns. Operational capacity metric used to manage marketing pipeline and resource load."
    - name: "count_lto_campaigns"
      expr: COUNT(CASE WHEN is_lto = True THEN campaign_id END)
      comment: "Number of Limited Time Offer campaigns. Tracks LTO pipeline depth, a key driver of traffic and trial in QSR."
    - name: "count_non_compliant_campaigns"
      expr: COUNT(CASE WHEN compliance_flag = False THEN campaign_id END)
      comment: "Number of campaigns flagged as non-compliant. Risk metric for brand standards and regulatory exposure."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and performance KPI layer over campaign execution records. Measures channel-level spend efficiency, lift delivery, and execution quality to guide in-flight campaign optimization."
  source: "`restaurants_ecm`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "execution_channel"
      expr: execution_channel
      comment: "Media or marketing channel through which the campaign was executed (e.g., TV, digital, social). Primary dimension for channel ROI analysis."
    - name: "campaign_execution_status"
      expr: campaign_execution_status
      comment: "Current status of the execution record (e.g., live, completed, paused) for operational monitoring."
    - name: "market_dma"
      expr: market_dma
      comment: "Designated Market Area (DMA) for the execution. Enables geographic performance benchmarking across markets."
    - name: "media_vendor"
      expr: media_vendor
      comment: "Media vendor or agency executing the campaign. Used for vendor performance evaluation and contract negotiations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which spend is denominated. Required for multi-currency normalization in global reporting."
    - name: "target_audience"
      expr: target_audience
      comment: "Audience segment targeted by the execution. Enables audience-level effectiveness analysis."
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the execution launched. Used for time-series trending of campaign execution activity."
    - name: "actual_launch_month"
      expr: DATE_TRUNC('MONTH', actual_launch_date)
      comment: "Month the execution actually launched. Compared against planned launch to measure execution timeliness."
    - name: "creative_version"
      expr: creative_version
      comment: "Version of the creative asset used in the execution. Enables A/B creative performance comparison."
  measures:
    - name: "total_channel_spend"
      expr: SUM(CAST(channel_spend_amount AS DOUBLE))
      comment: "Total spend across all campaign executions by channel. Core investment metric for channel budget allocation decisions."
    - name: "avg_channel_spend"
      expr: AVG(CAST(channel_spend_amount AS DOUBLE))
      comment: "Average spend per campaign execution record. Benchmarks typical execution investment levels by channel or market."
    - name: "avg_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average return on investment percentage across executions. Primary efficiency KPI for marketing investment decisions."
    - name: "avg_cost_per_click"
      expr: AVG(CAST(cost_per_click AS DOUBLE))
      comment: "Average cost per click across digital executions. Key digital efficiency metric for media buying optimization."
    - name: "avg_cost_per_impression"
      expr: AVG(CAST(cost_per_impression AS DOUBLE))
      comment: "Average cost per impression across executions. Used to evaluate media efficiency and negotiate vendor rates."
    - name: "avg_actual_adt_lift_percent"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE))
      comment: "Average actual ADT lift percentage delivered by executions. Measures traffic impact of marketing activity at execution level."
    - name: "avg_actual_comp_sales_lift_percent"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE))
      comment: "Average actual comparable sales lift percentage at execution level. Revenue impact KPI for in-flight optimization and post-campaign review."
    - name: "avg_comp_sales_lift_variance"
      expr: AVG(CAST(actual_comp_sales_lift_percent AS DOUBLE) - CAST(expected_comp_sales_lift_percent AS DOUBLE))
      comment: "Average variance between actual and expected comp sales lift. Measures forecast accuracy and execution quality; negative values trigger corrective action."
    - name: "avg_adt_lift_variance"
      expr: AVG(CAST(actual_adt_lift_percent AS DOUBLE) - CAST(expected_adt_lift_percent AS DOUBLE))
      comment: "Average variance between actual and expected ADT lift. Identifies executions underperforming traffic targets, driving optimization decisions."
    - name: "count_executions_by_channel"
      expr: COUNT(campaign_execution_id)
      comment: "Total number of campaign executions. Used to measure marketing activity volume and channel coverage breadth."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the promotion master table. Tracks promotion investment, discount depth, and redemption pipeline to inform promotional strategy and margin management."
  source: "`restaurants_ecm`.`marketing`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., BOGO, discount, bundle) for segmenting performance by promotional mechanic."
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current lifecycle status of the promotion (e.g., active, expired, draft) for pipeline and performance monitoring."
    - name: "promo_category"
      expr: promo_category
      comment: "Business category of the promotion (e.g., LTO, value, loyalty) for strategic portfolio analysis."
    - name: "applicable_channels"
      expr: applicable_channels
      comment: "Channels where the promotion is valid (e.g., in-store, digital, drive-thru). Enables channel-level promotional effectiveness analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the promotion is exclusive (e.g., loyalty-only). Used to measure exclusivity impact on redemption and margin."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Indicates whether the promotion can be stacked with other offers. Relevant for margin risk assessment."
    - name: "promo_source"
      expr: promo_source
      comment: "Origin of the promotion (e.g., national, local, franchisee). Enables governance and performance comparison by promotion source."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the promotion started. Used for time-series trending of promotional activity and seasonality analysis."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the promotion ended. Used to analyze promotional duration and expiry patterns."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value offered across promotions. Core margin impact metric for promotional investment governance."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per promotion. Benchmarks discount depth and informs value proposition calibration."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across promotions. Key margin management metric; high values trigger pricing strategy review."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase threshold required to redeem a promotion. Measures basket-building effectiveness of promotional design."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Sum of minimum purchase thresholds across promotions. Proxy for total basket-lift potential embedded in the promotional portfolio."
    - name: "count_active_promotions"
      expr: COUNT(CASE WHEN promotion_status = 'Active' THEN promotion_id END)
      comment: "Number of currently active promotions. Operational metric for managing promotional load and avoiding offer fatigue."
    - name: "count_exclusive_promotions"
      expr: COUNT(CASE WHEN is_exclusive = True THEN promotion_id END)
      comment: "Number of exclusive promotions (e.g., loyalty-only). Tracks exclusivity strategy depth in the promotional portfolio."
    - name: "count_stackable_promotions"
      expr: COUNT(CASE WHEN is_stackable = True THEN promotion_id END)
      comment: "Number of stackable promotions. Risk metric for margin erosion from combined offer redemptions."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-value KPI layer over promotion redemption events. Measures redemption volume, discount delivered, loyalty engagement, and channel mix to drive promotional effectiveness and guest engagement decisions."
  source: "`restaurants_ecm`.`marketing`.`promotion_redemption`"
  filter: is_test_redemption = False
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied at redemption (e.g., percentage, flat amount, BOGO). Enables mechanic-level performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the redemption occurred (e.g., breakfast, lunch, dinner). Identifies peak promotional engagement windows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction. Required for multi-currency normalization in global reporting."
    - name: "promotion_redemption_status"
      expr: promotion_redemption_status
      comment: "Status of the redemption event (e.g., successful, voided, failed). Used to filter valid redemptions and track failure rates."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Indicates whether the redemption was made by a loyalty program member. Key dimension for loyalty vs. non-loyalty promotional ROI comparison."
    - name: "source_system"
      expr: source_system
      comment: "Source system that recorded the redemption (e.g., POS, mobile app, kiosk). Used for channel attribution and data quality monitoring."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of the redemption event. Primary time dimension for redemption trend analysis and seasonality reporting."
    - name: "device_code"
      expr: device_code
      comment: "Device type used for the redemption (e.g., mobile, kiosk, POS terminal). Informs digital channel investment decisions."
  measures:
    - name: "total_discount_amount_redeemed"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value redeemed across all promotion redemption events. Primary margin impact metric for promotional spend governance."
    - name: "avg_discount_amount_per_redemption"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption event. Measures per-transaction promotional cost; used to calibrate offer depth."
    - name: "avg_discount_percent_redeemed"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied at redemption. Tracks actual discount depth delivered vs. planned, informing margin management."
    - name: "total_redemption_events"
      expr: COUNT(promotion_redemption_id)
      comment: "Total number of valid promotion redemption events. Baseline volume metric for promotional reach and engagement measurement."
    - name: "count_distinct_guests_redeeming"
      expr: COUNT(DISTINCT primary_promotion_guest_profile_id)
      comment: "Number of unique guests who redeemed a promotion. Measures promotional reach breadth and guest engagement depth."
    - name: "count_distinct_loyalty_redemptions"
      expr: COUNT(CASE WHEN loyalty_member_flag = True THEN promotion_redemption_id END)
      comment: "Number of redemptions by loyalty program members. Measures loyalty program engagement with promotional offers; key loyalty ROI input."
    - name: "count_distinct_restaurants_with_redemptions"
      expr: COUNT(DISTINCT primary_promotion_restaurant_unit_id)
      comment: "Number of unique restaurant units with at least one redemption. Measures promotional geographic and unit-level penetration."
    - name: "loyalty_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_flag = True THEN promotion_redemption_id END) / NULLIF(COUNT(promotion_redemption_id), 0), 2)
      comment: "Percentage of redemptions made by loyalty members. Strategic KPI for loyalty program effectiveness and promotional targeting quality."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over media plans. Tracks planned media investment by channel, reach targets, and plan lifecycle to inform media mix optimization and agency performance management."
  source: "`restaurants_ecm`.`marketing`.`media_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of media plan (e.g., national, local, co-op) for segmenting media investment by planning tier."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the media plan (e.g., approved, pending, rejected). Used for governance and pipeline management."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the media plan (e.g., draft, active, completed). Enables pipeline and execution tracking."
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the media agency managing the plan. Used for agency performance benchmarking and contract management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the media plan spend. Required for multi-currency normalization in global media reporting."
    - name: "target_dma"
      expr: target_dma
      comment: "Designated Market Area targeted by the media plan. Enables geographic media investment analysis."
    - name: "daypart_target"
      expr: daypart_target
      comment: "Daypart targeted by the media plan (e.g., breakfast, dinner). Aligns media investment with traffic-driving daypart strategy."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the media plan is currently active. Used to filter live plans for operational monitoring."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the media plan became effective. Used for time-series trending of media investment activation."
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(total_planned_spend AS DOUBLE))
      comment: "Total planned media spend across all media plans. Primary investment metric for media budget governance and allocation decisions."
    - name: "total_tv_spend"
      expr: SUM(CAST(tv_spend AS DOUBLE))
      comment: "Total planned TV spend. Tracks the largest traditional media channel investment for mix optimization."
    - name: "total_digital_spend"
      expr: SUM(CAST(digital_spend AS DOUBLE))
      comment: "Total planned digital media spend. Tracks digital channel investment growth, a key strategic priority in QSR marketing."
    - name: "total_social_spend"
      expr: SUM(CAST(social_spend AS DOUBLE))
      comment: "Total planned social media spend. Measures investment in social channels, critical for brand engagement and younger demographics."
    - name: "total_ooh_spend"
      expr: SUM(CAST(ooh_spend AS DOUBLE))
      comment: "Total planned out-of-home (OOH) spend. Tracks investment in proximity-based media, important for drive-to-store campaigns."
    - name: "total_radio_spend"
      expr: SUM(CAST(radio_spend AS DOUBLE))
      comment: "Total planned radio spend. Tracks investment in audio channels for daypart and commuter audience targeting."
    - name: "total_print_spend"
      expr: SUM(CAST(print_spend AS DOUBLE))
      comment: "Total planned print spend. Monitors declining traditional channel investment as part of media mix shift analysis."
    - name: "total_reach_target"
      expr: SUM(CAST(reach_target AS BIGINT))
      comment: "Total planned audience reach across media plans. Measures the scale of marketing exposure targeted, a key brand awareness input."
    - name: "avg_reach_target_per_plan"
      expr: AVG(CAST(reach_target AS DOUBLE))
      comment: "Average planned reach per media plan. Benchmarks the scale of individual media plans for investment efficiency comparison."
    - name: "digital_spend_share"
      expr: ROUND(100.0 * SUM(CAST(digital_spend AS DOUBLE)) / NULLIF(SUM(CAST(total_planned_spend AS DOUBLE)), 0), 2)
      comment: "Digital spend as a percentage of total planned media spend. Strategic KPI for tracking digital transformation of the media mix."
    - name: "count_approved_plans"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN media_plan_id END)
      comment: "Number of approved media plans. Governance metric for tracking plan approval pipeline and readiness for execution."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`marketing_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the coupon master table. Tracks coupon portfolio depth, discount value, and structural risk (stackability, fraud) to inform coupon strategy and margin protection decisions."
  source: "`restaurants_ecm`.`marketing`.`coupon`"
  dimensions:
    - name: "coupon_type"
      expr: coupon_type
      comment: "Type of coupon (e.g., percentage off, flat discount, free item) for segmenting portfolio by promotional mechanic."
    - name: "coupon_status"
      expr: coupon_status
      comment: "Current status of the coupon (e.g., active, expired, redeemed) for pipeline and lifecycle management."
    - name: "discount_type"
      expr: discount_type
      comment: "Discount mechanism of the coupon (e.g., percentage, fixed amount). Used to analyze discount structure and margin impact."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the coupon is exclusive to a specific channel or segment. Measures exclusivity strategy in coupon design."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Indicates whether the coupon can be combined with other offers. Key risk dimension for margin erosion analysis."
    - name: "fraud_prevention_flag"
      expr: fraud_prevention_flag
      comment: "Indicates whether fraud prevention controls are active on the coupon. Used for coupon fraud risk monitoring."
    - name: "eligible_item_category"
      expr: eligible_item_category
      comment: "Menu item category eligible for the coupon. Enables category-level promotional effectiveness analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the coupon was issued. Used for time-series trending of coupon issuance volume and promotional cadence."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the coupon expires. Used to manage coupon expiry cliffs and redemption urgency patterns."
  measures:
    - name: "total_discount_amount_offered"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value offered across all coupons in the portfolio. Core margin exposure metric for coupon program governance."
    - name: "avg_discount_amount_per_coupon"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per coupon. Benchmarks offer depth and informs coupon value calibration decisions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across coupons. Tracks discount depth trends; high averages trigger margin review."
    - name: "count_active_coupons"
      expr: COUNT(CASE WHEN coupon_status = 'Active' THEN coupon_id END)
      comment: "Number of currently active coupons. Measures live promotional offer load and risk of offer fatigue."
    - name: "count_stackable_coupons"
      expr: COUNT(CASE WHEN is_stackable = True THEN coupon_id END)
      comment: "Number of stackable coupons in the portfolio. Margin risk metric; high counts indicate elevated combined-discount exposure."
    - name: "count_fraud_protected_coupons"
      expr: COUNT(CASE WHEN fraud_prevention_flag = True THEN coupon_id END)
      comment: "Number of coupons with active fraud prevention controls. Measures fraud risk coverage across the coupon portfolio."
    - name: "fraud_protection_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_prevention_flag = True THEN coupon_id END) / NULLIF(COUNT(coupon_id), 0), 2)
      comment: "Percentage of coupons with fraud prevention controls active. Strategic risk KPI for coupon program integrity management."
$$;