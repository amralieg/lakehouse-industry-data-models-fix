-- Metric views for domain: sales | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPIs for advertising order pipeline: contracted revenue, CPM/GRP targets, discount leakage, and political-ad exposure. Used in quarterly revenue reviews and upfront/scatter planning."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order`"
  dimensions:
    - name: "order_status"
      expr: order_status_id
      comment: "Order lifecycle status (FK to sales_order_status) — segments pipeline by booked, confirmed, cancelled."
    - name: "order_type"
      expr: order_type_id
      comment: "Order type (FK to sales_order_type) — distinguishes upfront, scatter, programmatic, political."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the flight begins — enables monthly revenue trend analysis."
    - name: "flight_end_month"
      expr: DATE_TRUNC('MONTH', flight_end_date)
      comment: "Month the flight ends — used for revenue recognition period bucketing."
    - name: "political_ad_flag"
      expr: political_ad_flag
      comment: "Boolean flag identifying political advertising orders — required for FCC disclosure and revenue segmentation."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix description on the order — enables revenue analysis by daypart composition."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle cadence (weekly, monthly, etc.) — used for cash-flow forecasting."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month the order was created — tracks order intake velocity over time."
  measures:
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted advertising revenue across all orders. Primary top-line revenue KPI for the sales domain."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Net order value after discounts and commissions. Reflects actual recognized revenue potential."
    - name: "avg_contracted_cpm"
      expr: AVG(CAST(contracted_cpm AS DOUBLE))
      comment: "Average contracted CPM across orders. Benchmarks pricing efficiency vs. rate card and market norms."
    - name: "avg_contracted_cprp"
      expr: AVG(CAST(contracted_cprp AS DOUBLE))
      comment: "Average contracted cost-per-rating-point. Key metric for upfront and scatter pricing negotiations."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount granted on orders. Tracks pricing discipline and discount leakage across the sales team."
    - name: "total_commission_cost"
      expr: SUM(CAST(commission_rate AS DOUBLE) * CAST(total_contracted_value AS DOUBLE) / 100.0)
      comment: "Estimated total agency commission cost. Informs net revenue after agency fees."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Sum of contracted GRP targets across all orders. Measures total audience delivery commitment."
    - name: "total_target_trp"
      expr: SUM(CAST(target_trp AS DOUBLE))
      comment: "Sum of contracted TRP targets. Tracks total target-demographic rating point commitments."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of advertising orders. Baseline volume metric for pipeline and capacity planning."
    - name: "political_ad_order_count"
      expr: COUNT(CASE WHEN political_ad_flag = TRUE THEN 1 END)
      comment: "Count of political advertising orders. Required for FCC compliance reporting and revenue segmentation."
    - name: "political_ad_revenue"
      expr: SUM(CASE WHEN political_ad_flag = TRUE THEN total_contracted_value ELSE 0 END)
      comment: "Total contracted revenue from political advertising. Tracks political revenue exposure and compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level advertising delivery KPIs: impression and GRP delivery performance, CPM realization, and makegood exposure. Core operational metric view for traffic and yield management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status_id
      comment: "Line item status (FK to sales_line_status) — segments delivered, pending, cancelled lines."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the line flight begins — enables monthly delivery trend analysis."
    - name: "flight_end_month"
      expr: DATE_TRUNC('MONTH', flight_end_date)
      comment: "Month the line flight ends — used for delivery completion tracking."
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month revenue is recognized for this line — aligns delivery with financial close."
    - name: "inventory_type"
      expr: inventory_type_id
      comment: "Inventory type (FK to sales_inventory_type) — distinguishes linear, digital, programmatic, DAI inventory."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month the line was created — tracks order intake and booking velocity."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total gross revenue across all order lines. Primary line-level revenue KPI."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts. Reflects actual recognized line-level revenue."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total impressions contracted across all lines. Measures total audience delivery commitment."
    - name: "total_actual_impressions_delivered"
      expr: SUM(CAST(actual_impressions_delivered AS DOUBLE))
      comment: "Total impressions actually delivered. Core delivery fulfillment KPI."
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_impressions_delivered AS DOUBLE)) / NULLIF(SUM(CAST(contracted_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted impressions delivered. Key fulfillment quality metric — underdelivery triggers makegoods."
    - name: "total_contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total contracted GRP across all lines. Measures audience rating point commitment."
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total GRP actually delivered. Tracks audience delivery against guarantee."
    - name: "grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_grp_delivered AS DOUBLE)) / NULLIF(SUM(CAST(contracted_grp AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted GRP delivered. Drives makegood obligations and upfront guarantee reconciliation."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM across order lines. Benchmarks yield and pricing efficiency."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount applied at line level. Tracks pricing discipline and discount leakage."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate per spot/impression. Used for rate card compliance and yield analysis."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of order lines. Baseline volume metric for trafficking workload and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level performance and budget KPIs: total budget, CPM/GRP targets, and campaign pipeline health. Used by sales leadership for advertiser relationship management and revenue forecasting."
  source: "`vibe_media_broadcasting_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status_id
      comment: "Campaign lifecycle status (FK to campaign_status) — active, completed, cancelled, paused."
    - name: "campaign_type"
      expr: campaign_type_id
      comment: "Campaign type (FK to campaign_type) — upfront, scatter, programmatic, sponsorship, political."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign starts — enables monthly campaign launch trend analysis."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the campaign ends — used for revenue completion tracking."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (linear, digital, OTT, etc.) — segments revenue by distribution channel."
    - name: "makegood_eligible_flag"
      expr: makegood_eligible_flag
      comment: "Whether the campaign is eligible for makegoods — identifies campaigns with delivery risk exposure."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month the campaign was created — tracks new business intake velocity."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all campaigns. Primary top-line revenue pipeline KPI for sales leadership."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average campaign budget size. Benchmarks deal size and informs sales team capacity planning."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total impressions targeted across all campaigns. Measures total audience delivery commitment in the pipeline."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total GRP targeted across campaigns. Tracks aggregate audience rating point commitments."
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM across campaigns. Benchmarks pricing strategy and yield expectations."
    - name: "avg_target_frequency"
      expr: AVG(CAST(target_frequency AS DOUBLE))
      comment: "Average target frequency per campaign. Informs inventory allocation and audience saturation risk."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for pipeline health and sales team workload."
    - name: "makegood_eligible_campaign_count"
      expr: COUNT(CASE WHEN makegood_eligible_flag = TRUE THEN 1 END)
      comment: "Count of campaigns eligible for makegoods. Quantifies delivery risk exposure requiring operational attention."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot-level delivery and revenue KPIs: impression delivery, CPM realization, preemption rates, and DAI performance. Core operational metric for traffic, yield, and affidavit reconciliation."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_spot`"
  dimensions:
    - name: "spot_status"
      expr: spot_status_id
      comment: "Spot status (FK to spot_status) — aired, preempted, cancelled, makegood."
    - name: "billing_status"
      expr: billing_status_id
      comment: "Billing status (FK to billing_status) — billed, unbilled, disputed, reconciled."
    - name: "scheduled_air_month"
      expr: DATE_TRUNC('MONTH', scheduled_air_date)
      comment: "Month the spot was scheduled to air — enables monthly delivery trend analysis."
    - name: "actual_air_month"
      expr: DATE_TRUNC('MONTH', actual_air_time)
      comment: "Month the spot actually aired — used for revenue recognition and affidavit reconciliation."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the spot aired in — segments revenue and delivery by time-of-day inventory class."
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Platform the spot was delivered on (linear, OTT, CTV, etc.) — enables cross-platform yield analysis."
    - name: "dai_flag"
      expr: dai_flag
      comment: "Whether the spot was dynamically inserted — segments traditional vs. DAI delivery performance."
    - name: "preempted_flag"
      expr: preempted_flag
      comment: "Whether the spot was preempted — identifies preemption exposure requiring makegood resolution."
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Whether the spot is a makegood — tracks makegood fulfillment volume."
    - name: "bonus_spot_flag"
      expr: bonus_spot_flag
      comment: "Whether the spot is a bonus (value-add) — quantifies bonus inventory given away."
  measures:
    - name: "total_spot_revenue"
      expr: SUM(CAST(spot_rate_amount AS DOUBLE))
      comment: "Total spot-level revenue. Primary line-item revenue KPI for traffic and billing reconciliation."
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered across all spots. Core audience delivery fulfillment KPI."
    - name: "avg_cpm_realized"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average CPM realized at spot level. Measures yield efficiency vs. contracted CPM."
    - name: "total_grp_value"
      expr: SUM(CAST(grp_value AS DOUBLE))
      comment: "Total GRP value delivered across spots. Tracks aggregate audience rating point delivery."
    - name: "total_trp_value"
      expr: SUM(CAST(trp_value AS DOUBLE))
      comment: "Total TRP value delivered. Tracks target-demographic rating point delivery for guarantee reconciliation."
    - name: "spot_count"
      expr: COUNT(1)
      comment: "Total number of spots. Baseline volume metric for trafficking workload and inventory utilization."
    - name: "preempted_spot_count"
      expr: COUNT(CASE WHEN preempted_flag = TRUE THEN 1 END)
      comment: "Count of preempted spots. Quantifies preemption exposure requiring makegood resolution."
    - name: "preemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preempted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spots preempted. High preemption rates signal inventory oversell or scheduling conflicts."
    - name: "dai_spot_count"
      expr: COUNT(CASE WHEN dai_flag = TRUE THEN 1 END)
      comment: "Count of dynamically inserted spots. Tracks DAI adoption and FAST/AVOD monetization volume."
    - name: "dai_revenue"
      expr: SUM(CASE WHEN dai_flag = TRUE THEN spot_rate_amount ELSE 0 END)
      comment: "Revenue from dynamically inserted spots. Measures DAI monetization contribution to total spot revenue."
    - name: "makegood_spot_count"
      expr: COUNT(CASE WHEN makegood_flag = TRUE THEN 1 END)
      comment: "Count of makegood spots aired. Tracks makegood fulfillment volume and associated liability clearance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_impression_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital impression delivery KPIs: viewability, completion rates, click-through performance, and CPM realization. Core metric view for programmatic and digital advertising yield management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`impression_delivery`"
  dimensions:
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month impressions were delivered — enables monthly digital revenue trend analysis."
    - name: "platform_type"
      expr: platform_type_id
      comment: "Platform type (FK to sales_platform_type) — CTV, mobile, desktop, OTT — segments yield by platform."
    - name: "device_type"
      expr: device_type_id
      comment: "Device type (FK to distribution_device_type) — enables device-level yield and viewability analysis."
    - name: "insertion_status"
      expr: insertion_status_id
      comment: "Insertion status (FK to insertion_status) — delivered, failed, blocked — tracks delivery quality."
    - name: "insertion_type"
      expr: insertion_type_id
      comment: "Insertion type (FK to insertion_type) — direct, programmatic, DAI — segments by monetization method."
    - name: "verification_status"
      expr: verification_status_id
      comment: "Third-party verification status — identifies verified vs. unverified impressions for guarantee reconciliation."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of delivery — segments digital yield by time-of-day inventory class."
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre adjacent to the impression — enables contextual targeting performance analysis."
  measures:
    - name: "total_impressions_served"
      expr: SUM(CAST(total_impressions_served AS DOUBLE))
      comment: "Total impressions served. Primary digital delivery volume KPI for campaign fulfillment tracking."
    - name: "total_viewable_impressions"
      expr: SUM(CAST(viewable_impressions AS DOUBLE))
      comment: "Total MRC-viewable impressions. Core quality metric for upfront guarantee reconciliation and advertiser trust."
    - name: "total_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total digital advertising revenue from impression delivery. Primary digital revenue KPI."
    - name: "avg_cpm_realized"
      expr: AVG(CAST(cpm_realized AS DOUBLE))
      comment: "Average CPM realized on delivered impressions. Measures digital yield efficiency vs. contracted rates."
    - name: "total_completed_views"
      expr: SUM(CAST(completed_views AS DOUBLE))
      comment: "Total video completions. Measures full-view engagement quality for video advertising campaigns."
    - name: "total_click_throughs"
      expr: SUM(CAST(click_throughs AS DOUBLE))
      comment: "Total click-through events. Measures direct response performance for performance-based campaigns."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate_percent AS DOUBLE))
      comment: "Average viewability rate across impressions. Key quality metric for premium inventory pricing and guarantee compliance."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average video completion rate. Measures creative effectiveness and audience engagement quality."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate_percent AS DOUBLE))
      comment: "Average click-through rate. Benchmarks direct response performance across campaigns and creatives."
    - name: "cdn_confirmed_impression_count"
      expr: COUNT(CASE WHEN cdn_delivery_confirmed_flag = TRUE THEN 1 END)
      comment: "Count of CDN-confirmed impressions. Validates delivery infrastructure reliability for SLA compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_dai_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic Ad Insertion event KPIs: insertion success rates, revenue per insertion, completion rates, and privacy signal compliance. Critical for FAST/AVOD monetization and programmatic DAI reporting."
  source: "`vibe_media_broadcasting_v1`.`sales`.`dai_event`"
  dimensions:
    - name: "insertion_status"
      expr: insertion_status_id
      comment: "DAI insertion status (FK to insertion_status) — inserted, failed, fallback — tracks insertion quality."
    - name: "platform_type"
      expr: platform_type_id
      comment: "Platform type (FK to sales_platform_type) — CTV, mobile, OTT — segments DAI yield by platform."
    - name: "device_type"
      expr: device_type_id
      comment: "Device type (FK to distribution_device_type) — enables device-level DAI performance analysis."
    - name: "viewability_status"
      expr: viewability_status_id
      comment: "Viewability status of the DAI event — segments viewable vs. non-viewable insertions."
    - name: "user_consent_status"
      expr: user_consent_status_id
      comment: "User consent status (GDPR/CCPA) — required for privacy-compliant DAI revenue reporting."
    - name: "ad_decision_month"
      expr: DATE_TRUNC('MONTH', ad_decision_timestamp)
      comment: "Month of ad decision — enables monthly DAI revenue trend analysis."
    - name: "dai_platform_name"
      expr: dai_platform_name
      comment: "DAI platform name (e.g., Google DAI, FreeWheel) — segments performance by insertion technology vendor."
    - name: "delivery_confirmed_flag"
      expr: delivery_confirmed_flag
      comment: "Whether delivery was confirmed — identifies confirmed vs. unconfirmed DAI revenue."
    - name: "impression_fired_flag"
      expr: impression_fired_flag
      comment: "Whether the impression beacon fired — tracks impression tracking reliability."
  measures:
    - name: "total_dai_revenue"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue from DAI events. Primary FAST/AVOD monetization KPI for streaming revenue reporting."
    - name: "avg_bid_price_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average bid price CPM for DAI events. Benchmarks programmatic clearing prices vs. floor rates."
    - name: "total_dai_events"
      expr: COUNT(1)
      comment: "Total DAI insertion events. Baseline volume metric for DAI infrastructure capacity and monetization scale."
    - name: "confirmed_delivery_count"
      expr: COUNT(CASE WHEN delivery_confirmed_flag = TRUE THEN 1 END)
      comment: "Count of confirmed DAI deliveries. Measures insertion success rate for SLA and billing reconciliation."
    - name: "impression_fired_count"
      expr: COUNT(CASE WHEN impression_fired_flag = TRUE THEN 1 END)
      comment: "Count of events where impression beacon fired. Validates impression tracking reliability for billing."
    - name: "delivery_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_confirmed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DAI events with confirmed delivery. Key SLA metric — low rates indicate insertion infrastructure issues."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate_percent AS DOUBLE))
      comment: "Average video completion rate for DAI ads. Measures creative and placement quality for programmatic inventory."
    - name: "fallback_event_count"
      expr: COUNT(CASE WHEN fallback_reason IS NOT NULL THEN 1 END)
      comment: "Count of DAI events that fell back to default/house ads. Quantifies lost programmatic revenue from insertion failures."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_advertising_audience_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience guarantee delivery KPIs: GRP/impression delivery rates, makegood obligations, and underdelivery exposure. Critical for upfront deal reconciliation and advertiser liability management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee`"
  dimensions:
    - name: "guarantee_status"
      expr: guarantee_status_id
      comment: "Guarantee status (FK to sales_guarantee_status) — on-track, underdelivered, fulfilled, makegood-required."
    - name: "guarantee_period_start_month"
      expr: DATE_TRUNC('MONTH', guarantee_period_start_date)
      comment: "Month the guarantee period starts — enables quarterly guarantee performance trend analysis."
    - name: "guarantee_period_end_month"
      expr: DATE_TRUNC('MONTH', guarantee_period_end_date)
      comment: "Month the guarantee period ends — used for reconciliation period bucketing."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the guarantee — segments delivery performance by time-of-day inventory class."
    - name: "measurement_source"
      expr: measurement_source
      comment: "Measurement source (Nielsen, Comscore, etc.) — segments guarantee performance by measurement methodology."
    - name: "makegood_required_flag"
      expr: makegood_required_flag
      comment: "Whether a makegood is required — identifies guarantees with active liability requiring resolution."
    - name: "last_measurement_month"
      expr: DATE_TRUNC('MONTH', last_measurement_date)
      comment: "Month of last measurement update — tracks recency of guarantee performance data."
  measures:
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total impressions contracted under audience guarantees. Measures total upfront delivery commitment."
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total impressions delivered against guarantees. Core fulfillment KPI for upfront reconciliation."
    - name: "impression_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_impressions AS DOUBLE)) / NULLIF(SUM(CAST(contracted_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of guaranteed impressions delivered. Primary upfront fulfillment KPI — underdelivery triggers makegood obligations."
    - name: "total_contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total GRP contracted under audience guarantees. Measures aggregate rating point commitment."
    - name: "total_delivered_grp"
      expr: SUM(CAST(delivered_grp AS DOUBLE))
      comment: "Total GRP delivered against guarantees. Tracks audience rating point fulfillment."
    - name: "grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_grp AS DOUBLE)) / NULLIF(SUM(CAST(contracted_grp AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted GRP delivered. Drives makegood obligations and upfront deal reconciliation."
    - name: "total_makegood_grp_owed"
      expr: SUM(CAST(makegood_grp_owed AS DOUBLE))
      comment: "Total GRP owed as makegoods. Quantifies outstanding delivery liability requiring resolution."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit issued for underdelivery. Measures financial liability from guarantee shortfalls."
    - name: "avg_delivery_percentage"
      expr: AVG(CAST(delivery_percentage AS DOUBLE))
      comment: "Average delivery percentage across all guarantees. Executive summary metric for upfront fulfillment health."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegood_required_flag = TRUE THEN 1 END)
      comment: "Count of guarantees requiring makegoods. Quantifies active delivery liability requiring operational resolution."
    - name: "guarantee_count"
      expr: COUNT(1)
      comment: "Total number of audience guarantees. Baseline volume metric for upfront commitment tracking."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront commitment KPIs: total committed spend, fulfillment rates, allocation by platform, and cancellation exposure. Core metric for upfront season planning and revenue lock-in tracking."
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status_id
      comment: "Commitment status (FK to commitment_status) — active, exercised, cancelled, expired."
    - name: "upfront_year"
      expr: upfront_year
      comment: "Upfront broadcast year (e.g., 2025-26) — primary segmentation for upfront season performance analysis."
    - name: "commitment_month"
      expr: DATE_TRUNC('MONTH', commitment_date)
      comment: "Month the commitment was made — tracks upfront booking velocity by month."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the commitment period begins — enables seasonal revenue distribution analysis."
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Whether the commitment carries an audience guarantee — segments guaranteed vs. non-guaranteed upfront revenue."
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Whether the commitment includes makegood provisions — identifies commitments with delivery liability exposure."
    - name: "daypart_allocation"
      expr: daypart_allocation
      comment: "Daypart allocation description — segments committed spend by daypart mix."
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total upfront spend committed by advertisers. Primary upfront revenue lock-in KPI for annual planning."
    - name: "total_exercised_amount"
      expr: SUM(CAST(total_exercised_amount AS DOUBLE))
      comment: "Total amount exercised from upfront commitments. Measures conversion of commitments to actual orders."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(total_cancelled_amount AS DOUBLE))
      comment: "Total amount cancelled from upfront commitments. Tracks cancellation exposure and revenue at risk."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_commitment_balance AS DOUBLE))
      comment: "Total remaining uncommitted balance. Measures unexercised upfront revenue still available for conversion."
    - name: "avg_fulfillment_percentage"
      expr: AVG(CAST(fulfillment_percentage AS DOUBLE))
      comment: "Average fulfillment percentage across commitments. Executive KPI for upfront conversion health."
    - name: "total_linear_allocation"
      expr: SUM(CAST(linear_allocation_amount AS DOUBLE))
      comment: "Total upfront spend allocated to linear TV. Tracks linear vs. digital revenue mix in upfront deals."
    - name: "total_digital_allocation"
      expr: SUM(CAST(digital_allocation_amount AS DOUBLE))
      comment: "Total upfront spend allocated to digital/streaming. Measures digital upfront growth trajectory."
    - name: "total_streaming_allocation"
      expr: SUM(CAST(streaming_allocation_amount AS DOUBLE))
      comment: "Total upfront spend allocated to streaming platforms. Tracks streaming monetization in upfront deals."
    - name: "total_delivered_spend"
      expr: SUM(CAST(delivered_spend_to_date AS DOUBLE))
      comment: "Total spend delivered to date against commitments. Tracks in-flight upfront execution progress."
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Total number of upfront commitments. Baseline volume metric for upfront deal pipeline."
    - name: "guaranteed_impression_volume"
      expr: SUM(CAST(committed_impression_volume AS DOUBLE))
      comment: "Total impression volume committed under upfront deals. Measures total audience delivery obligation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales forecast KPIs: pipeline revenue, quota attainment, forecast accuracy, and revenue mix by type. Core metric for sales leadership quarterly business reviews and annual planning."
  source: "`vibe_media_broadcasting_v1`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status_id
      comment: "Forecast status (FK to forecast_status) — draft, submitted, approved, final."
    - name: "forecast_category"
      expr: forecast_category_id
      comment: "Forecast category (FK to forecast_category) — pipeline, commit, best-case, closed."
    - name: "period_type"
      expr: period_type_id
      comment: "Period type (FK to sales_period_type) — weekly, monthly, quarterly, annual."
    - name: "deal_type"
      expr: deal_type_id
      comment: "Deal type (FK to sales_deal_type) — upfront, scatter, programmatic, syndication, carriage."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month the forecast period starts — enables monthly forecast trend analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the forecast — primary segmentation for quarterly business reviews."
    - name: "broadcast_year"
      expr: broadcast_year
      comment: "Broadcast year of the forecast — enables annual revenue planning and year-over-year comparison."
    - name: "account_segment"
      expr: account_segment
      comment: "Account segment (national, local, digital, etc.) — segments forecast by sales channel type."
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(total_forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue across all forecast records. Primary top-line revenue forecast KPI for QBRs."
    - name: "total_pipeline_revenue"
      expr: SUM(CAST(pipeline_revenue AS DOUBLE))
      comment: "Total pipeline revenue (all stages). Measures total revenue opportunity in the sales funnel."
    - name: "total_commit_revenue"
      expr: SUM(CAST(commit_revenue AS DOUBLE))
      comment: "Total committed revenue (high-confidence pipeline). Measures revenue likely to close in the period."
    - name: "total_closed_revenue"
      expr: SUM(CAST(closed_revenue AS DOUBLE))
      comment: "Total closed/booked revenue. Tracks actual revenue converted from pipeline."
    - name: "total_quota_amount"
      expr: SUM(CAST(quota_amount AS DOUBLE))
      comment: "Total quota assigned across all forecast records. Baseline for quota attainment calculation."
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average quota attainment percentage. Primary sales performance KPI for rep and team evaluation."
    - name: "total_upfront_revenue"
      expr: SUM(CAST(upfront_revenue AS DOUBLE))
      comment: "Total upfront revenue in forecast. Tracks upfront season contribution to total revenue forecast."
    - name: "total_scatter_revenue"
      expr: SUM(CAST(scatter_revenue AS DOUBLE))
      comment: "Total scatter revenue in forecast. Measures scatter market contribution and pricing premium opportunity."
    - name: "total_carriage_revenue"
      expr: SUM(CAST(carriage_revenue AS DOUBLE))
      comment: "Total carriage fee revenue in forecast. Tracks affiliate/MVPD carriage revenue contribution."
    - name: "total_syndication_revenue"
      expr: SUM(CAST(syndication_revenue AS DOUBLE))
      comment: "Total syndication revenue in forecast. Measures content syndication monetization pipeline."
    - name: "total_variance_to_quota"
      expr: SUM(CAST(variance_to_quota AS DOUBLE))
      comment: "Total variance between forecast and quota. Identifies aggregate over/under-performance vs. plan."
    - name: "total_weighted_pipeline"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Total probability-weighted pipeline value. More accurate revenue predictor than raw pipeline for planning."
    - name: "total_manager_override_amount"
      expr: SUM(CAST(manager_override_amount AS DOUBLE))
      comment: "Total manager override adjustments to forecasts. Tracks management judgment adjustments to bottom-up forecasts."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales opportunity pipeline KPIs: estimated value, win probability, conversion rates, and pipeline velocity. Core CRM metric view for sales leadership pipeline management and revenue forecasting."
  source: "`vibe_media_broadcasting_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "deal_type"
      expr: deal_type_id
      comment: "Deal type (FK to sales_deal_type) — upfront, scatter, programmatic, carriage, syndication."
    - name: "forecast_category"
      expr: forecast_category_id
      comment: "Forecast category (FK to forecast_category) — pipeline, commit, best-case, closed-won, closed-lost."
    - name: "stage"
      expr: stage
      comment: "Opportunity stage (prospecting, proposal, negotiation, closed) — tracks pipeline progression."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Expected close month — enables monthly pipeline maturity and revenue timing analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month the opportunity was created — tracks new business generation velocity."
    - name: "is_upfront"
      expr: is_upfront
      comment: "Whether the opportunity is an upfront deal — segments upfront vs. scatter pipeline."
    - name: "daypart"
      expr: daypart
      comment: "Target daypart — segments pipeline by inventory class."
    - name: "lead_source"
      expr: lead_source
      comment: "Lead source (inbound, outbound, referral, renewal) — tracks pipeline generation by channel."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities. Primary pipeline value KPI for revenue forecasting."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average opportunity value. Benchmarks deal size and informs sales team capacity planning."
    - name: "avg_win_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across opportunities. Weighted pipeline quality indicator for forecast accuracy."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total impression volume targeted in pipeline opportunities. Measures audience delivery commitment in the pipeline."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total GRP targeted in pipeline. Tracks aggregate audience rating point commitments in the funnel."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities. Baseline pipeline volume metric for sales team activity tracking."
    - name: "requires_makegood_count"
      expr: COUNT(CASE WHEN requires_makegood = TRUE THEN 1 END)
      comment: "Count of opportunities requiring makegoods. Identifies pipeline with delivery risk obligations."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate on opportunities. Benchmarks pricing strategy in the pipeline vs. rate card."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline KPIs: proposed value, win rates, discount levels, and conversion velocity. Used by sales leadership to manage proposal quality, pricing discipline, and pipeline conversion."
  source: "`vibe_media_broadcasting_v1`.`sales`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status_id
      comment: "Proposal status (FK to proposal_status) — draft, submitted, accepted, rejected, expired."
    - name: "proposal_type"
      expr: proposal_type_id
      comment: "Proposal type (FK to proposal_type) — upfront, scatter, programmatic, sponsorship, syndication."
    - name: "proposal_month"
      expr: DATE_TRUNC('MONTH', proposal_date)
      comment: "Month the proposal was created — tracks proposal generation velocity."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the proposal was submitted — measures time-to-submission pipeline velocity."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the proposed flight starts — enables revenue timing analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (linear, digital, OTT) — segments proposal pipeline by distribution channel."
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Whether the proposal includes an audience guarantee — segments guaranteed vs. non-guaranteed proposals."
    - name: "is_political"
      expr: is_political
      comment: "Whether the proposal is for political advertising — segments political vs. commercial pipeline."
    - name: "guarantee_type"
      expr: guarantee_type_id
      comment: "Guarantee type (FK to guarantee_type) — GRP, impression, reach — segments by guarantee structure."
  measures:
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Total proposed revenue value across all proposals. Primary proposal pipeline KPI for revenue forecasting."
    - name: "total_net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Total net proposed value after discounts. Reflects actual revenue potential in the proposal pipeline."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross proposed amount before discounts. Used to calculate discount leakage at proposal stage."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net proposed amount after discounts and commissions. Measures net revenue in the proposal pipeline."
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability AS DOUBLE))
      comment: "Average win probability across proposals. Weighted pipeline quality indicator for forecast accuracy."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage on proposals. Tracks pricing discipline and discount leakage at proposal stage."
    - name: "avg_proposed_cpm"
      expr: AVG(CAST(proposed_cpm AS DOUBLE))
      comment: "Average proposed CPM. Benchmarks pricing strategy vs. rate card and competitive market rates."
    - name: "total_proposed_impressions"
      expr: SUM(CAST(proposed_impressions AS DOUBLE))
      comment: "Total impressions proposed across all proposals. Measures audience delivery commitment in the proposal pipeline."
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Total estimated GRP across proposals. Tracks aggregate audience rating point commitments in the pipeline."
    - name: "proposal_count"
      expr: COUNT(1)
      comment: "Total number of proposals. Baseline volume metric for sales team activity and pipeline health."
    - name: "total_budget_proposed"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget proposed across all proposals. Measures total revenue opportunity being pursued."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_agency_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency commission KPIs: total commission cost, commission rates, reconciliation status, and override exposure. Used by finance and sales operations to manage agency cost and billing accuracy."
  source: "`vibe_media_broadcasting_v1`.`sales`.`agency_commission`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status_id
      comment: "Reconciliation status (FK to sales_reconciliation_status) — reconciled, disputed, pending, written-off."
    - name: "commission_type"
      expr: commission_type
      comment: "Commission type (standard, override, bonus) — segments commission cost by type."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (gross, net, etc.) — segments by commission calculation methodology."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the commission period starts — enables monthly commission cost trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month commission was paid — aligns commission cost with cash flow timing."
    - name: "override_flag"
      expr: override_flag
      comment: "Whether the commission was an override — identifies non-standard commission approvals."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the commission — enables period-level commission cost reporting."
  measures:
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total agency commission paid. Primary cost KPI for agency relationship management and margin analysis."
    - name: "total_order_gross_amount"
      expr: SUM(CAST(order_gross_amount AS DOUBLE))
      comment: "Total gross order value on which commissions are calculated. Baseline for commission rate validation."
    - name: "total_order_net_amount"
      expr: SUM(CAST(order_net_amount AS DOUBLE))
      comment: "Total net order value after commissions. Measures net revenue retained after agency fees."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all agency commissions. Benchmarks agency cost efficiency vs. standard rates."
    - name: "effective_commission_rate"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(order_gross_amount AS DOUBLE)), 0), 2)
      comment: "Effective commission rate (total commission / total gross). Measures actual vs. contracted commission cost."
    - name: "override_commission_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Count of commission overrides. Tracks non-standard commission approvals requiring management review."
    - name: "override_commission_amount"
      expr: SUM(CASE WHEN override_flag = TRUE THEN commission_amount ELSE 0 END)
      comment: "Total commission amount from overrides. Quantifies financial impact of non-standard commission approvals."
    - name: "commission_record_count"
      expr: COUNT(1)
      comment: "Total number of commission records. Baseline volume metric for commission processing workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_bid_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programmatic bidding KPIs: win rates, clearing prices, bid efficiency, and PMP performance. Core metric for programmatic revenue optimization and exchange relationship management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`bid_response`"
  dimensions:
    - name: "is_win_flag"
      expr: is_win_flag
      comment: "Whether the bid was won — primary segmentation for win/loss analysis."
    - name: "is_pmp_flag"
      expr: is_pmp_flag
      comment: "Whether the bid was on a private marketplace deal — segments PMP vs. open exchange performance."
    - name: "is_sampled_flag"
      expr: is_sampled_flag
      comment: "Whether the record is a sampled bid — required for extrapolation and statistical validity."
    - name: "responded_month"
      expr: DATE_TRUNC('MONTH', responded_at)
      comment: "Month the bid response was made — enables monthly programmatic revenue trend analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the bid — segments programmatic revenue by currency for multi-market analysis."
  measures:
    - name: "total_bid_responses"
      expr: COUNT(1)
      comment: "Total bid responses. Baseline volume metric for programmatic auction participation scale."
    - name: "total_wins"
      expr: COUNT(CASE WHEN is_win_flag = TRUE THEN 1 END)
      comment: "Total bid wins. Measures programmatic inventory monetization success."
    - name: "win_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_win_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids won. Primary programmatic efficiency KPI — low win rates indicate floor price or targeting misalignment."
    - name: "avg_bid_price_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average bid price CPM. Benchmarks demand-side pricing vs. floor rates for yield optimization."
    - name: "avg_clearing_price_cpm"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Average clearing price CPM. Measures actual programmatic yield vs. bid price for auction efficiency analysis."
    - name: "total_clearing_revenue"
      expr: SUM(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Sum of clearing price CPMs across all won bids. Proxy for total programmatic revenue from sampled auctions."
    - name: "pmp_win_count"
      expr: COUNT(CASE WHEN is_pmp_flag = TRUE AND is_win_flag = TRUE THEN 1 END)
      comment: "Count of PMP bid wins. Measures private marketplace monetization effectiveness vs. open exchange."
    - name: "avg_win_rate_per_dsp"
      expr: AVG(CAST(win_rate AS DOUBLE))
      comment: "Average win rate field from bid response records. Tracks DSP-reported win rate for demand partner performance management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_makegood`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Makegood resolution KPIs: makegood volume, GRP recovery rates, resolution timeliness, and financial exposure. Used by traffic and sales operations to manage delivery liability and advertiser satisfaction."
  source: "`vibe_media_broadcasting_v1`.`sales`.`makegood`"
  dimensions:
    - name: "approval_status"
      expr: approval_status_id
      comment: "Makegood approval status (FK to sales_approval_status) — pending, approved, rejected."
    - name: "resolution_status"
      expr: resolution_status_id
      comment: "Makegood resolution status (FK to sales_resolution_status) — open, resolved, escalated."
    - name: "reason_code"
      expr: reason_code_id
      comment: "Reason for makegood (FK to sales_reason_code) — preemption, underdelivery, technical failure."
    - name: "original_daypart"
      expr: original_daypart
      comment: "Daypart of the original spot — segments makegood exposure by inventory class."
    - name: "proposed_daypart"
      expr: proposed_daypart
      comment: "Daypart of the proposed replacement — tracks daypart migration in makegood resolution."
    - name: "original_scheduled_month"
      expr: DATE_TRUNC('MONTH', original_scheduled_date)
      comment: "Month the original spot was scheduled — enables monthly makegood exposure trend analysis."
    - name: "affidavit_generated_flag"
      expr: affidavit_generated_flag
      comment: "Whether an affidavit was generated for the makegood — tracks documentation compliance."
  measures:
    - name: "total_original_spot_rate"
      expr: SUM(CAST(original_spot_rate AS DOUBLE))
      comment: "Total original spot rate value of makegoods. Measures total financial exposure from delivery failures."
    - name: "total_original_contracted_grp"
      expr: SUM(CAST(original_contracted_grp AS DOUBLE))
      comment: "Total contracted GRP from original spots requiring makegoods. Measures audience delivery liability."
    - name: "total_original_actual_grp"
      expr: SUM(CAST(original_actual_grp AS DOUBLE))
      comment: "Total actual GRP delivered on original spots. Measures how much of the contracted GRP was actually delivered."
    - name: "total_proposed_estimated_grp"
      expr: SUM(CAST(proposed_estimated_grp AS DOUBLE))
      comment: "Total estimated GRP from proposed makegood replacements. Measures expected recovery of delivery shortfall."
    - name: "grp_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(proposed_estimated_grp AS DOUBLE)) / NULLIF(SUM(CAST(original_contracted_grp AS DOUBLE)) - SUM(CAST(original_actual_grp AS DOUBLE)), 0), 2)
      comment: "Percentage of GRP shortfall recovered through proposed makegoods. Measures makegood resolution effectiveness."
    - name: "makegood_count"
      expr: COUNT(1)
      comment: "Total number of makegoods. Baseline volume metric for delivery quality and operational workload."
    - name: "approved_makegood_count"
      expr: COUNT(CASE WHEN approval_status_id IS NOT NULL THEN 1 END)
      comment: "Count of makegoods with an approval status set. Tracks makegood processing throughput."
    - name: "affidavit_generated_count"
      expr: COUNT(CASE WHEN affidavit_generated_flag = TRUE THEN 1 END)
      comment: "Count of makegoods with affidavits generated. Tracks documentation compliance for billing reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_affidavit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Affidavit reconciliation KPIs: billing accuracy, discrepancy rates, compliance flags, and makegood obligations. Used by traffic, billing, and compliance teams for post-air reconciliation and FCC compliance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`affidavit`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status_id
      comment: "Reconciliation status (FK to sales_reconciliation_status) — reconciled, disputed, pending."
    - name: "discrepancy_type"
      expr: discrepancy_type_id
      comment: "Discrepancy type (FK to discrepancy_type) — length, time, content, missing — categorizes billing discrepancies."
    - name: "actual_air_month"
      expr: DATE_TRUNC('MONTH', actual_air_date)
      comment: "Month the spot actually aired — enables monthly affidavit reconciliation trend analysis."
    - name: "scheduled_air_month"
      expr: DATE_TRUNC('MONTH', scheduled_air_date)
      comment: "Month the spot was scheduled — used to identify scheduling vs. actual air discrepancies."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a discrepancy was identified — primary filter for billing dispute analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the affidavit passed compliance review — tracks FCC/regulatory compliance rate."
    - name: "makegood_required_flag"
      expr: makegood_required_flag
      comment: "Whether a makegood is required based on affidavit — quantifies post-air delivery liability."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the aired spot — segments affidavit discrepancies by inventory class."
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total billing amount across all affidavits. Primary revenue reconciliation KPI for post-air billing accuracy."
    - name: "affidavit_count"
      expr: COUNT(1)
      comment: "Total number of affidavits. Baseline volume metric for post-air reconciliation workload."
    - name: "discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Count of affidavits with discrepancies. Measures billing accuracy and traffic quality."
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of affidavits with discrepancies. Key quality metric — high rates indicate trafficking or playout system issues."
    - name: "compliance_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of affidavits passing compliance review. Tracks FCC/regulatory compliance rate for broadcast operations."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegood_required_flag = TRUE THEN 1 END)
      comment: "Count of affidavits requiring makegoods. Quantifies post-air delivery liability requiring resolution."
    - name: "makegood_required_billing_amount"
      expr: SUM(CASE WHEN makegood_required_flag = TRUE THEN billing_amount ELSE 0 END)
      comment: "Total billing amount on affidavits requiring makegoods. Measures financial exposure from post-air delivery failures."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_scatter_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scatter market order KPIs: scatter revenue, CPM premiums, delivery rates, and preemption exposure. Used by sales leadership to manage scatter market pricing strategy and inventory yield."
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order`"
  dimensions:
    - name: "order_status"
      expr: order_status_id
      comment: "Order status (FK to sales_order_status) — booked, confirmed, cancelled, delivered."
    - name: "fulfillment_status"
      expr: fulfillment_status_id
      comment: "Fulfillment status (FK to sales_fulfillment_status) — pending, in-flight, fulfilled, underdelivered."
    - name: "market_type"
      expr: market_type_id
      comment: "Market type (FK to sales_market_type) — national, local, regional — segments scatter revenue by market."
    - name: "inventory_type"
      expr: inventory_type_id
      comment: "Inventory type (FK to sales_inventory_type) — linear, digital, programmatic — segments by channel."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the scatter flight starts — enables monthly scatter revenue trend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the scatter order was placed — tracks scatter booking velocity and lead time."
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Whether the scatter order carries an audience guarantee — segments guaranteed vs. non-guaranteed scatter."
    - name: "political_ad_flag"
      expr: political_ad_flag
      comment: "Whether the scatter order is for political advertising — segments political scatter revenue."
    - name: "preemption_risk_flag"
      expr: preemption_risk_flag
      comment: "Whether the order has preemption risk — identifies scatter inventory with displacement exposure."
  measures:
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net scatter order value. Primary scatter revenue KPI for yield management and pricing strategy."
    - name: "total_order_amount"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total gross scatter order amount. Measures total scatter market revenue before discounts."
    - name: "avg_scatter_cpm"
      expr: AVG(CAST(scatter_cpm_amount AS DOUBLE))
      comment: "Average scatter CPM. Benchmarks scatter pricing premium vs. upfront rates — key yield optimization metric."
    - name: "avg_negotiated_cpm"
      expr: AVG(CAST(negotiated_cpm AS DOUBLE))
      comment: "Average negotiated CPM on scatter orders. Tracks actual vs. rate card pricing in the scatter market."
    - name: "total_requested_impressions"
      expr: SUM(CAST(requested_impressions AS DOUBLE))
      comment: "Total impressions requested in scatter orders. Measures scatter demand volume for inventory planning."
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total impressions delivered on scatter orders. Tracks scatter fulfillment performance."
    - name: "scatter_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_impressions AS DOUBLE)) / NULLIF(SUM(CAST(requested_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of requested scatter impressions delivered. Measures scatter fulfillment quality."
    - name: "total_requested_grps"
      expr: SUM(CAST(requested_grps AS DOUBLE))
      comment: "Total GRPs requested in scatter orders. Tracks scatter audience demand for capacity planning."
    - name: "total_delivered_grps"
      expr: SUM(CAST(delivered_grps AS DOUBLE))
      comment: "Total GRPs delivered on scatter orders. Measures scatter audience delivery performance."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount on scatter orders. Tracks pricing discipline in the scatter market."
    - name: "scatter_order_count"
      expr: COUNT(1)
      comment: "Total number of scatter orders. Baseline volume metric for scatter market activity and inventory utilization."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront deal KPIs: total committed spend, audience guarantee volumes, CPM/CPRP rates, and deal pipeline health. Core metric for upfront season management and annual revenue planning."
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status_id
      comment: "Deal status (FK to sales_deal_status) — negotiating, executed, cancelled, expired."
    - name: "deal_type"
      expr: deal_type_id
      comment: "Deal type (FK to sales_deal_type) — upfront, multi-year, digital-only, cross-platform."
    - name: "deal_year"
      expr: deal_year
      comment: "Upfront broadcast year — primary segmentation for year-over-year upfront performance comparison."
    - name: "commitment_month"
      expr: DATE_TRUNC('MONTH', commitment_date)
      comment: "Month the deal was committed — tracks upfront booking velocity during the upfront selling season."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the deal was executed — measures time from commitment to execution."
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Whether the deal includes makegood provisions — segments deals with delivery liability exposure."
    - name: "scatter_conversion_rights"
      expr: scatter_conversion_rights
      comment: "Whether the deal includes scatter conversion rights — tracks flexibility provisions in upfront deals."
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis (CPM, CPRP, flat) — segments upfront deals by pricing structure."
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total spend committed in upfront deals. Primary upfront revenue lock-in KPI for annual planning."
    - name: "total_proposed_spend"
      expr: SUM(CAST(total_proposed_spend AS DOUBLE))
      comment: "Total spend proposed in upfront deals. Measures total upfront revenue opportunity being negotiated."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across upfront deals. Benchmarks upfront pricing vs. scatter market and prior year."
    - name: "avg_cprp_rate"
      expr: AVG(CAST(cprp_rate AS DOUBLE))
      comment: "Average CPRP rate across upfront deals. Tracks cost-per-rating-point pricing in upfront negotiations."
    - name: "total_audience_guarantee_grp"
      expr: SUM(CAST(audience_guarantee_grp AS DOUBLE))
      comment: "Total GRP guaranteed in upfront deals. Measures aggregate audience delivery commitment for the upfront season."
    - name: "total_audience_guarantee_impressions"
      expr: SUM(CAST(audience_guarantee_impressions AS DOUBLE))
      comment: "Total impressions guaranteed in upfront deals. Tracks total impression delivery obligation for the upfront season."
    - name: "upfront_deal_count"
      expr: COUNT(1)
      comment: "Total number of upfront deals. Baseline volume metric for upfront season deal pipeline."
    - name: "avg_negotiation_rounds"
      expr: AVG(CAST(negotiation_round_count AS DOUBLE))
      comment: "Average number of negotiation rounds per deal. Measures deal complexity and sales cycle efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_private_marketplace_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Private marketplace (PMP) deal KPIs: deal volume, floor pricing, and activation status. Used by programmatic sales and yield management teams to optimize PMP deal performance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`private_marketplace_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "PMP deal status (active, paused, expired) — segments active vs. inactive PMP inventory."
    - name: "deal_type"
      expr: deal_type
      comment: "PMP deal type (preferred, guaranteed, first-look) — segments by deal structure and priority."
    - name: "auction_type"
      expr: auction_type
      comment: "Auction type (first-price, second-price) — segments PMP deals by auction mechanics."
    - name: "is_active_flag"
      expr: is_active_flag
      comment: "Whether the PMP deal is currently active — filters active vs. inactive deal inventory."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the PMP deal starts — enables monthly PMP deal activation trend analysis."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the PMP deal ends — tracks deal expiration pipeline."
    - name: "currency"
      expr: currency
      comment: "Currency of the PMP deal — segments programmatic revenue by currency for multi-market analysis."
  measures:
    - name: "total_floor_price_cpm"
      expr: SUM(CAST(floor_price_cpm AS DOUBLE))
      comment: "Sum of floor price CPMs across all PMP deals. Measures total minimum revenue floor in the PMP portfolio."
    - name: "avg_floor_price_cpm"
      expr: AVG(CAST(floor_price_cpm AS DOUBLE))
      comment: "Average floor price CPM across PMP deals. Benchmarks PMP pricing strategy vs. open exchange rates."
    - name: "active_deal_count"
      expr: COUNT(CASE WHEN is_active_flag = TRUE THEN 1 END)
      comment: "Count of active PMP deals. Measures the scale of active programmatic direct relationships."
    - name: "total_deal_count"
      expr: COUNT(1)
      comment: "Total number of PMP deals. Baseline volume metric for programmatic direct deal pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_syndication_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content syndication deal KPIs: license fee revenue, barter splits, clearance rates, and deal pipeline health. Used by syndication sales teams to manage content distribution revenue."
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status_id
      comment: "Deal status (FK to sales_deal_status) — negotiating, executed, active, expired, cancelled."
    - name: "syndication_type"
      expr: syndication_type_id
      comment: "Syndication type (FK to sales_syndication_type) — cash, barter, cash-plus-barter, digital."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the syndication deal starts — enables monthly syndication revenue trend analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the syndication deal ends — tracks deal expiration and renewal pipeline."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal is exclusive — segments exclusive vs. non-exclusive syndication revenue."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal has a renewal option — identifies deals with renewal revenue potential."
    - name: "territory"
      expr: territory
      comment: "Territory of the syndication deal — segments revenue by geographic market."
  measures:
    - name: "total_cash_license_fee"
      expr: SUM(CAST(cash_license_fee_amount AS DOUBLE))
      comment: "Total cash license fee revenue from syndication deals. Primary syndication revenue KPI."
    - name: "avg_barter_split_percentage"
      expr: AVG(CAST(barter_split_percentage AS DOUBLE))
      comment: "Average barter split percentage across syndication deals. Tracks cash vs. barter revenue mix in syndication."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percentage AS DOUBLE))
      comment: "Average commission rate on syndication deals. Benchmarks agency cost in syndication revenue."
    - name: "avg_clearance_target"
      expr: AVG(CAST(clearance_percentage_target AS DOUBLE))
      comment: "Average clearance percentage target across deals. Measures expected station clearance for syndicated content."
    - name: "syndication_deal_count"
      expr: COUNT(1)
      comment: "Total number of syndication deals. Baseline volume metric for syndication pipeline health."
    - name: "exclusive_deal_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Count of exclusive syndication deals. Measures premium exclusive content distribution relationships."
    - name: "renewal_eligible_count"
      expr: COUNT(CASE WHEN renewal_option_flag = TRUE THEN 1 END)
      comment: "Count of deals with renewal options. Identifies renewal revenue pipeline for proactive sales management."
$$;