-- Metric views for domain: marketing | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for marketing campaigns covering spend efficiency, budget adherence, and production cost management. Enables CMO and brand teams to evaluate campaign investment and execution quality."
  source: "`consumer_goods_ecm`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign (e.g. brand, trade, digital, shopper) for cross-type performance comparison."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (e.g. planned, active, completed, cancelled)."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Media channel mix used in the campaign, enabling channel-level investment analysis."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the campaign (e.g. national, regional, local) for geographic investment analysis."
    - name: "objective"
      expr: objective
      comment: "Primary marketing objective of the campaign (e.g. awareness, conversion, retention)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which campaign spend amounts are denominated."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of the planned campaign start date for time-series trending."
    - name: "actual_start_date"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month bucket of the actual campaign start date for execution timing analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the campaign is currently active."
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Total number of distinct campaigns. Baseline volume metric for portfolio sizing and workload assessment."
    - name: "total_actual_media_spend"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Total actual media spend across all campaigns. Core investment metric for budget accountability and CMO reporting."
    - name: "total_planned_media_spend"
      expr: SUM(CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Total planned media spend across all campaigns. Used as denominator for budget variance analysis."
    - name: "total_actual_production_cost"
      expr: SUM(CAST(actual_production_cost_amount AS DOUBLE))
      comment: "Total actual production cost across campaigns. Tracks non-working spend efficiency and creative investment."
    - name: "total_planned_production_cost"
      expr: SUM(CAST(planned_production_cost_amount AS DOUBLE))
      comment: "Total planned production cost. Used alongside actual to compute production cost variance."
    - name: "total_campaign_investment"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE) + CAST(actual_production_cost_amount AS DOUBLE))
      comment: "Total campaign investment combining media spend and production cost. Represents full campaign cost for ROI and budget stewardship decisions."
    - name: "avg_actual_media_spend_per_campaign"
      expr: AVG(CAST(actual_media_spend_amount AS DOUBLE))
      comment: "Average actual media spend per campaign. Benchmarks campaign investment levels and flags outliers requiring executive review."
    - name: "media_spend_variance"
      expr: SUM(CAST(actual_media_spend_amount AS DOUBLE) - CAST(planned_media_spend_amount AS DOUBLE))
      comment: "Aggregate variance between actual and planned media spend. Negative values indicate underspend; positive values indicate overspend. Critical for budget control and finance reconciliation."
    - name: "production_cost_variance"
      expr: SUM(CAST(actual_production_cost_amount AS DOUBLE) - CAST(planned_production_cost_amount AS DOUBLE))
      comment: "Aggregate variance between actual and planned production costs. Signals creative production efficiency and agency cost management."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_campaign_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution-level media performance KPIs for campaign flights. Enables media planners, brand managers, and CMOs to evaluate delivery efficiency, audience reach, engagement, and conversion performance across channels and platforms."
  source: "`consumer_goods_ecm`.`marketing`.`campaign_flight`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Media channel of the flight (e.g. TV, digital, OOH, social) for channel-level performance benchmarking."
    - name: "platform"
      expr: platform
      comment: "Specific platform within the channel (e.g. YouTube, Meta, TikTok) for granular media mix analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of media placement (e.g. pre-roll, banner, sponsored post) for creative format performance analysis."
    - name: "flight_status"
      expr: flight_status
      comment: "Current status of the flight (e.g. active, completed, paused) for portfolio health monitoring."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model applied to conversions (e.g. last-click, data-driven) for methodology-consistent reporting."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market of the flight for regional performance comparison."
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the flight for category-level media investment analysis."
    - name: "measurement_date"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month bucket of the flight measurement date for time-series performance trending."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the scheduled flight start date for planning vs. actuals timing analysis."
  measures:
    - name: "total_flights"
      expr: COUNT(DISTINCT campaign_flight_id)
      comment: "Total number of distinct campaign flights. Baseline volume metric for media execution portfolio sizing."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total media budget spent across all flights. Primary investment accountability metric for media controllers and CMOs."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total media budget allocated to flights. Used as denominator for budget utilisation rate calculation."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered across flights. Core reach metric for brand awareness campaign evaluation."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total target impressions planned for flights. Used as denominator for impression delivery rate."
    - name: "total_clicks"
      expr: SUM(CAST(clicks AS DOUBLE))
      comment: "Total clicks delivered across flights. Engagement volume metric for digital performance assessment."
    - name: "total_conversions"
      expr: SUM(CAST(conversions AS DOUBLE))
      comment: "Total conversions attributed to campaign flights. Directly links media investment to business outcomes (sales, sign-ups, leads)."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views delivered. Key metric for video-first campaigns measuring content consumption and brand storytelling reach."
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total unique audience reach across flights. Measures breadth of campaign exposure for brand-building investment decisions."
    - name: "avg_ctr"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate across flights. Measures creative and audience relevance; low CTR triggers creative or targeting review."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across flights. Directly measures media-to-outcome efficiency; drives budget reallocation decisions."
    - name: "avg_roas"
      expr: AVG(CAST(roas AS DOUBLE))
      comment: "Average return on ad spend across flights. Primary efficiency KPI for media investment decisions at executive and brand level."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa AS DOUBLE))
      comment: "Average cost per acquisition across flights. Measures media efficiency in driving conversions; high CPA triggers channel or creative optimisation."
    - name: "avg_cpc"
      expr: AVG(CAST(cpc AS DOUBLE))
      comment: "Average cost per click across flights. Benchmarks digital media buying efficiency across platforms and placements."
    - name: "avg_video_completion_rate"
      expr: AVG(CAST(video_completion_rate AS DOUBLE))
      comment: "Average video completion rate across flights. Measures content engagement quality; low completion rates signal creative or placement issues."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average ad frequency (exposures per unique person). Monitors over-exposure risk and media plan efficiency."
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total gross rating points delivered. Standard broadcast media currency for measuring campaign weight and reach x frequency."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_media_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial media spend KPIs tracking working vs. non-working spend, invoice reconciliation, delivery efficiency, and cost-per-metric performance. Enables finance, media controllers, and CMOs to govern media investment and agency accountability."
  source: "`consumer_goods_ecm`.`marketing`.`media_spend`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel of the spend record (e.g. TV, digital, OOH, print) for channel-level investment governance."
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Sub-channel within the media channel for granular spend analysis."
    - name: "media_owner_name"
      expr: media_owner_name
      comment: "Name of the media owner/publisher for vendor spend concentration analysis."
    - name: "buy_type"
      expr: buy_type
      comment: "Media buying type (e.g. programmatic, direct, reserved) for procurement efficiency analysis."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of media placement for format-level spend and performance analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the spend record (e.g. paid, pending, disputed) for cash flow and liability management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the spend record for financial close and audit compliance."
    - name: "country_code"
      expr: country_code
      comment: "Country of the media spend for geographic investment governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend record for multi-currency financial reporting."
    - name: "spend_date"
      expr: DATE_TRUNC('month', spend_date)
      comment: "Month bucket of the spend date for time-series media investment trending."
    - name: "spend_period"
      expr: spend_period
      comment: "Fiscal or calendar spend period label for period-over-period budget tracking."
  measures:
    - name: "total_working_spend"
      expr: SUM(CAST(working_spend_amount AS DOUBLE))
      comment: "Total working media spend (spend that directly reaches consumers). Core efficiency metric — higher working spend ratio signals better media investment quality."
    - name: "total_non_working_spend"
      expr: SUM(CAST(non_working_spend_amount AS DOUBLE))
      comment: "Total non-working spend (production, agency fees, overhead). Monitored to ensure working media ratio targets are met."
    - name: "total_invoiced_spend"
      expr: SUM(CAST(invoiced_spend_amount AS DOUBLE))
      comment: "Total invoiced media spend. Used for accounts payable, financial close, and agency billing reconciliation."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend. Denominator for spend delivery rate and variance analysis."
    - name: "total_agency_fees"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fees incurred. Tracks agency cost as a proportion of total media investment for contract governance."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production costs within media spend records. Contributes to non-working spend ratio and creative cost governance."
    - name: "total_spend_variance_to_plan"
      expr: SUM(CAST(variance_to_plan_amount AS DOUBLE))
      comment: "Total variance between actual and planned spend. Negative = underspend; positive = overspend. Critical for budget control and finance reconciliation."
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered as reported in spend records. Validates media delivery against invoiced amounts."
    - name: "total_clicks_delivered"
      expr: SUM(CAST(clicks_delivered AS DOUBLE))
      comment: "Total clicks delivered as reported in spend records. Validates digital engagement delivery against invoiced performance."
    - name: "total_video_views_delivered"
      expr: SUM(CAST(video_views_delivered AS DOUBLE))
      comment: "Total video views delivered as reported in spend records. Validates video campaign delivery against invoiced performance."
    - name: "avg_cpm_actual"
      expr: AVG(CAST(cpm_actual AS DOUBLE))
      comment: "Average actual cost per thousand impressions. Benchmarks media buying efficiency; high CPM triggers renegotiation or channel reallocation."
    - name: "avg_cpc_actual"
      expr: AVG(CAST(cpc_actual AS DOUBLE))
      comment: "Average actual cost per click. Measures digital media buying efficiency across channels and vendors."
    - name: "avg_cpv_actual"
      expr: AVG(CAST(cpv_actual AS DOUBLE))
      comment: "Average actual cost per video view. Measures video media buying efficiency; drives video channel investment decisions."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget governance KPIs for marketing investment tracking across brands, channels, and geographies. Enables CFO, CMO, and brand finance teams to monitor budget utilisation, variance, and working media efficiency."
  source: "`consumer_goods_ecm`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of marketing budget (e.g. brand, trade, digital, shopper) for investment mix analysis."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Campaign type associated with the budget allocation for campaign-level investment governance."
    - name: "channel"
      expr: channel
      comment: "Media channel associated with the budget for channel investment mix analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual investment planning and year-over-year comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the budget for quarterly business review reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget for monthly budget tracking and financial close."
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and execution status of the budget (e.g. approved, draft, closed)."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the budget allocation for regional investment governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency financial reporting."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month bucket of the budget effective start date for time-series budget planning analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the budget record is currently active."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved marketing budget. Primary investment envelope metric for CMO and CFO budget governance."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual marketing spend against budget. Core accountability metric for budget stewardship and financial close."
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet invoiced) spend. Critical for cash flow forecasting and remaining budget availability."
    - name: "total_working_media_budget"
      expr: SUM(CAST(working_media_budget_amount AS DOUBLE))
      comment: "Total working media budget (consumer-facing spend). Tracks the proportion of investment reaching consumers vs. overhead."
    - name: "total_non_working_budget"
      expr: SUM(CAST(non_working_budget_amount AS DOUBLE))
      comment: "Total non-working budget (production, agency fees, research). Monitored to protect working media ratio targets."
    - name: "total_production_budget"
      expr: SUM(CAST(production_budget_amount AS DOUBLE))
      comment: "Total production budget allocation. Tracks creative production investment as a component of total marketing spend."
    - name: "total_agency_fee_budget"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fee budget. Monitors agency cost as a proportion of total marketing investment for contract governance."
    - name: "total_research_budget"
      expr: SUM(CAST(research_budget_amount AS DOUBLE))
      comment: "Total research and insights budget. Tracks investment in consumer and market intelligence."
    - name: "total_contingency_budget"
      expr: SUM(CAST(contingency_budget_amount AS DOUBLE))
      comment: "Total contingency budget reserved. Monitors financial risk buffer availability for unplanned marketing activities."
    - name: "total_budget_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. plan). Negative = underspend; positive = overspend. Primary budget control metric for finance and marketing leadership."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across budget records. Normalised efficiency metric for cross-brand and cross-channel budget performance comparison."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_brand_health_tracker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand equity and consumer perception KPIs tracking awareness, consideration, preference, sentiment, share of voice, and market share. Enables CMOs and brand teams to monitor brand health trajectory and competitive positioning."
  source: "`consumer_goods_ecm`.`marketing`.`brand_health_tracker`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type associated with the brand health measurement (e.g. retail, e-commerce, foodservice)."
    - name: "market_geography"
      expr: market_geography
      comment: "Geographic market of the brand health measurement for regional brand performance comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of spend amounts in the brand health record."
    - name: "data_source"
      expr: data_source
      comment: "Source of the brand health data (e.g. Nielsen, Kantar, proprietary survey) for methodology-consistent analysis."
    - name: "tracking_period_start_date"
      expr: DATE_TRUNC('month', tracking_period_start_date)
      comment: "Month bucket of the tracking period start date for time-series brand health trending."
    - name: "measurement_timestamp"
      expr: DATE_TRUNC('month', CAST(measurement_timestamp AS DATE))
      comment: "Month bucket of the measurement timestamp for longitudinal brand health analysis."
  measures:
    - name: "avg_aided_awareness_pct"
      expr: AVG(CAST(aided_awareness_pct AS DOUBLE))
      comment: "Average aided brand awareness percentage. Foundational brand health KPI — low awareness triggers media investment and reach strategy review."
    - name: "avg_spontaneous_awareness_pct"
      expr: AVG(CAST(spontaneous_awareness_pct AS DOUBLE))
      comment: "Average spontaneous (unaided) brand awareness percentage. Stronger indicator of brand salience than aided awareness; drives brand-building investment decisions."
    - name: "avg_consideration_pct"
      expr: AVG(CAST(consideration_pct AS DOUBLE))
      comment: "Average brand consideration percentage. Measures consumer intent to purchase; low consideration triggers messaging and positioning review."
    - name: "avg_preference_pct"
      expr: AVG(CAST(preference_pct AS DOUBLE))
      comment: "Average brand preference percentage. Measures competitive differentiation; declining preference triggers innovation or value proposition review."
    - name: "avg_purchase_intent_pct"
      expr: AVG(CAST(purchase_intent_pct AS DOUBLE))
      comment: "Average purchase intent percentage. Leading indicator of near-term sales performance; directly informs demand planning and media investment."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score. Measures consumer loyalty and advocacy; low NPS triggers product quality and consumer experience review."
    - name: "avg_brand_equity_index"
      expr: AVG(CAST(brand_equity_index AS DOUBLE))
      comment: "Average brand equity index. Composite brand strength metric used in brand valuation, M&A, and strategic portfolio decisions."
    - name: "avg_net_sentiment_score"
      expr: AVG(CAST(net_sentiment_score AS DOUBLE))
      comment: "Average net social sentiment score. Monitors brand reputation in real time; negative sentiment triggers crisis communications response."
    - name: "avg_sov_total_pct"
      expr: AVG(CAST(sov_total_pct AS DOUBLE))
      comment: "Average total share of voice percentage. Measures brand's advertising presence relative to category; below SOM triggers media investment increase."
    - name: "avg_som_value_pct"
      expr: AVG(CAST(som_value_pct AS DOUBLE))
      comment: "Average value share of market percentage. Primary market competitiveness KPI for brand and category management decisions."
    - name: "avg_som_volume_pct"
      expr: AVG(CAST(som_volume_pct AS DOUBLE))
      comment: "Average volume share of market percentage. Complements value SOM to detect premiumisation or trade-down dynamics."
    - name: "total_social_mention_volume"
      expr: SUM(CAST(social_mention_volume AS DOUBLE))
      comment: "Total social media mention volume. Measures brand conversation scale; used alongside sentiment to assess brand health in digital channels."
    - name: "avg_social_sentiment_positive_pct"
      expr: AVG(CAST(social_sentiment_positive_pct AS DOUBLE))
      comment: "Average positive social sentiment percentage. Tracks brand reputation quality in social channels; informs content and community management strategy."
    - name: "total_brand_spend_amount"
      expr: SUM(CAST(brand_spend_amount AS DOUBLE))
      comment: "Total brand marketing spend recorded in health tracker. Enables correlation of spend investment with brand health metric movements."
    - name: "avg_quality_perception_score"
      expr: AVG(CAST(quality_perception_score AS DOUBLE))
      comment: "Average quality perception score. Measures consumer perception of product quality; declining scores trigger product and packaging review."
    - name: "avg_innovation_perception_score"
      expr: AVG(CAST(innovation_perception_score AS DOUBLE))
      comment: "Average innovation perception score. Measures brand's perceived innovativeness; low scores trigger NPD pipeline and communication strategy review."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_market_share_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market share and competitive position KPIs tracking value share, volume share, share point changes, and category dynamics. Enables CMOs, category managers, and strategy teams to monitor competitive standing and growth trajectory."
  source: "`consumer_goods_ecm`.`marketing`.`market_share_record`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Retail or distribution channel of the market share measurement (e.g. grocery, drug, e-commerce)."
    - name: "geography_level"
      expr: geography_level
      comment: "Geographic aggregation level (e.g. national, regional, account) for hierarchical market share analysis."
    - name: "geography_name"
      expr: geography_name
      comment: "Name of the geographic market for regional competitive benchmarking."
    - name: "geography_code"
      expr: geography_code
      comment: "Code of the geographic market for consistent geographic filtering."
    - name: "period_type"
      expr: period_type
      comment: "Measurement period type (e.g. 4-week, 12-week, 52-week) for consistent period-over-period comparison."
    - name: "market_definition"
      expr: market_definition
      comment: "Definition of the competitive market used for share calculation (e.g. total category, defined segment)."
    - name: "data_source"
      expr: data_source
      comment: "Source of market share data (e.g. Nielsen, IRI, Circana) for methodology-consistent reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of value-based market share amounts."
    - name: "is_projected"
      expr: is_projected
      comment: "Flag indicating whether the market share record is projected vs. actual for forecast vs. actuals analysis."
    - name: "measurement_date"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month bucket of the market share measurement date for time-series share trending."
  measures:
    - name: "avg_value_share_percent"
      expr: AVG(CAST(value_share_percent AS DOUBLE))
      comment: "Average value market share percentage. Primary competitive KPI for brand and category management; declining share triggers strategic intervention."
    - name: "avg_volume_share_percent"
      expr: AVG(CAST(volume_share_percent AS DOUBLE))
      comment: "Average volume market share percentage. Complements value share to detect premiumisation or trade-down dynamics in the category."
    - name: "avg_acv_percent"
      expr: AVG(CAST(acv_percent AS DOUBLE))
      comment: "Average all-commodity volume (ACV) weighted distribution percentage. Measures product availability in the market; low ACV triggers distribution expansion strategy."
    - name: "total_brand_value_amount"
      expr: SUM(CAST(brand_value_amount AS DOUBLE))
      comment: "Total brand value sales amount. Absolute revenue scale metric for brand portfolio prioritisation and investment allocation."
    - name: "total_brand_volume_quantity"
      expr: SUM(CAST(brand_volume_quantity AS DOUBLE))
      comment: "Total brand volume sold. Absolute volume scale metric for supply chain planning and category management."
    - name: "total_category_value_amount"
      expr: SUM(CAST(category_total_value_amount AS DOUBLE))
      comment: "Total category value sales amount. Provides market size context for share calculations and category growth assessment."
    - name: "total_category_volume_quantity"
      expr: SUM(CAST(category_total_volume_quantity AS DOUBLE))
      comment: "Total category volume. Provides volume market size context for share and growth analysis."
    - name: "avg_share_point_change"
      expr: AVG(CAST(share_point_change AS DOUBLE))
      comment: "Average share point change vs. prior period. Momentum metric — negative change triggers immediate competitive response and investment review."
    - name: "avg_year_over_year_change_percent"
      expr: AVG(CAST(year_over_year_change_percent AS DOUBLE))
      comment: "Average year-over-year market share change percentage. Annual growth trajectory metric for strategic planning and investor reporting."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media planning efficiency KPIs covering planned reach, frequency, GRP delivery, CPM, and spend allocation. Enables media planners and CMOs to evaluate plan quality, channel mix efficiency, and investment targeting before and during execution."
  source: "`consumer_goods_ecm`.`marketing`.`media_plan`"
  dimensions:
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel of the plan (e.g. TV, digital, OOH, radio) for channel investment mix analysis."
    - name: "media_subchannel"
      expr: media_subchannel
      comment: "Sub-channel within the media channel for granular planning analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Approval and execution status of the media plan (e.g. draft, approved, live, completed)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of media plan (e.g. brand, trade, digital) for plan portfolio analysis."
    - name: "objective"
      expr: objective
      comment: "Marketing objective of the media plan (e.g. awareness, consideration, conversion) for objective-based performance analysis."
    - name: "market"
      expr: market
      comment: "Geographic market of the media plan for regional investment planning analysis."
    - name: "creative_format"
      expr: creative_format
      comment: "Creative format planned (e.g. 30s TVC, display banner, sponsored content) for format efficiency analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart targeting of the media plan (e.g. prime time, daytime) for broadcast planning analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the media plan spend amounts."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month bucket of the planned flight start date for time-series media planning analysis."
  measures:
    - name: "total_plans"
      expr: COUNT(DISTINCT media_plan_id)
      comment: "Total number of distinct media plans. Baseline volume metric for media planning portfolio sizing."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend across all plans. Primary investment commitment metric for budget governance and agency briefing."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions across media plans. Measures planned audience reach scale for brand awareness investment decisions."
    - name: "avg_planned_reach_percent"
      expr: AVG(CAST(planned_reach_percent AS DOUBLE))
      comment: "Average planned reach percentage of target audience. Measures breadth of planned campaign exposure; low reach triggers media mix review."
    - name: "avg_planned_frequency"
      expr: AVG(CAST(planned_frequency AS DOUBLE))
      comment: "Average planned ad frequency. Monitors planned exposure intensity; excessive frequency signals waste and budget reallocation opportunity."
    - name: "total_planned_grp"
      expr: SUM(CAST(planned_grp AS DOUBLE))
      comment: "Total planned gross rating points. Standard broadcast media weight metric for campaign pressure planning and competitive SOV analysis."
    - name: "avg_planned_cpm"
      expr: AVG(CAST(planned_cpm AS DOUBLE))
      comment: "Average planned cost per thousand impressions. Benchmarks planned media buying efficiency; high CPM triggers negotiation or channel substitution."
    - name: "avg_planned_cpp"
      expr: AVG(CAST(planned_cpp AS DOUBLE))
      comment: "Average planned cost per rating point. Standard broadcast media efficiency metric for TV and radio investment decisions."
    - name: "avg_budget_allocation_percent"
      expr: AVG(CAST(budget_allocation_percent AS DOUBLE))
      comment: "Average budget allocation percentage per plan. Monitors concentration of investment across plans and channels for portfolio balance."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio KPIs covering equity, awareness, consideration, preference, market share targets, and investment budgets. Enables CMOs and brand strategy teams to manage brand portfolio health, prioritise investment, and track brand-building progress."
  source: "`consumer_goods_ecm`.`marketing`.`marketing_brand`"
  dimensions:
    - name: "brand_category"
      expr: brand_category
      comment: "Category the brand competes in for category-level brand portfolio analysis."
    - name: "architecture_tier"
      expr: architecture_tier
      comment: "Brand architecture tier (e.g. masterbrand, sub-brand, endorsed) for portfolio investment prioritisation."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Brand lifecycle stage (e.g. launch, growth, mature, decline) for stage-appropriate investment strategy."
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g. active, discontinued, under review) for active portfolio management."
    - name: "primary_distribution_channel"
      expr: primary_distribution_channel
      comment: "Primary distribution channel of the brand for channel-specific brand investment analysis."
    - name: "geographic_market_scope"
      expr: geographic_market_scope
      comment: "Geographic scope of the brand (e.g. global, regional, local) for market-level portfolio analysis."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Flag indicating whether the brand is a private label for own-brand vs. manufacturer brand analysis."
    - name: "is_licensed_brand"
      expr: is_licensed_brand
      comment: "Flag indicating whether the brand is licensed for licensing cost and risk management."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year bucket of the brand launch date for brand age cohort analysis."
  measures:
    - name: "total_brands"
      expr: COUNT(DISTINCT marketing_brand_id)
      comment: "Total number of distinct brands in the portfolio. Baseline metric for portfolio complexity and management overhead assessment."
    - name: "total_annual_marketing_budget"
      expr: SUM(CAST(annual_marketing_budget AS DOUBLE))
      comment: "Total annual marketing budget across all brands. Primary investment envelope metric for CMO and CFO portfolio budget governance."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all brands. Aggregated commercial ambition metric for portfolio performance target-setting."
    - name: "total_brand_valuation"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total brand portfolio valuation. Strategic asset value metric used in M&A, investor reporting, and portfolio prioritisation."
    - name: "avg_brand_equity_score"
      expr: AVG(CAST(equity_score AS DOUBLE))
      comment: "Average brand equity score across the portfolio. Composite brand strength metric; declining equity triggers brand investment and positioning review."
    - name: "avg_awareness_percent"
      expr: AVG(CAST(awareness_percent AS DOUBLE))
      comment: "Average brand awareness percentage across the portfolio. Foundational brand health KPI for media investment and reach strategy decisions."
    - name: "avg_consideration_percent"
      expr: AVG(CAST(consideration_percent AS DOUBLE))
      comment: "Average brand consideration percentage. Measures consumer purchase intent pipeline; low consideration triggers messaging and activation review."
    - name: "avg_preference_percent"
      expr: AVG(CAST(preference_percent AS DOUBLE))
      comment: "Average brand preference percentage. Measures competitive differentiation strength; declining preference triggers innovation and value proposition review."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across brands. Measures consumer loyalty and advocacy; low NPS triggers product quality and consumer experience investment."
    - name: "avg_som_percent"
      expr: AVG(CAST(som_percent AS DOUBLE))
      comment: "Average actual share of market percentage across brands. Primary competitive position metric for brand and category management decisions."
    - name: "avg_target_som_percent"
      expr: AVG(CAST(target_som_percent AS DOUBLE))
      comment: "Average target share of market percentage. Used alongside actual SOM to measure gap to ambition and prioritise investment."
    - name: "avg_sov_percent"
      expr: AVG(CAST(sov_percent AS DOUBLE))
      comment: "Average share of voice percentage across brands. Measures advertising presence relative to category; SOV below SOM triggers media investment increase."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`marketing_market_research_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer and market research investment and insight KPIs covering brand awareness, consideration, preference, household penetration, and purchase behaviour. Enables CMOs and insights teams to govern research investment and extract strategic consumer intelligence."
  source: "`consumer_goods_ecm`.`marketing`.`market_research_study`"
  dimensions:
    - name: "research_type"
      expr: research_type
      comment: "Type of research study (e.g. brand tracking, usage & attitude, concept test) for research portfolio analysis."
    - name: "methodology"
      expr: methodology
      comment: "Research methodology (e.g. online survey, focus group, ethnography) for methodology-consistent analysis."
    - name: "study_status"
      expr: study_status
      comment: "Current status of the research study (e.g. planned, in-field, completed) for research pipeline management."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of research subscription (e.g. syndicated, custom, continuous) for research investment model analysis."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit commissioning the research for investment allocation and insights governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the study investment amount."
    - name: "fieldwork_start_date"
      expr: DATE_TRUNC('month', fieldwork_start_date)
      comment: "Month bucket of the fieldwork start date for research activity timeline analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the research study is currently active."
  measures:
    - name: "total_studies"
      expr: COUNT(DISTINCT market_research_study_id)
      comment: "Total number of distinct research studies. Baseline metric for research portfolio volume and insights investment governance."
    - name: "total_study_investment"
      expr: SUM(CAST(study_investment_amount AS DOUBLE))
      comment: "Total investment in market research studies. Governs research spend as a proportion of total marketing investment; informs insights budget allocation."
    - name: "avg_brand_awareness_pct"
      expr: AVG(CAST(brand_awareness_pct AS DOUBLE))
      comment: "Average brand awareness percentage from research studies. Tracks brand salience over time; declining awareness triggers media investment review."
    - name: "avg_brand_consideration_pct"
      expr: AVG(CAST(brand_consideration_pct AS DOUBLE))
      comment: "Average brand consideration percentage from research. Measures consumer purchase intent pipeline; informs activation and messaging strategy."
    - name: "avg_brand_preference_pct"
      expr: AVG(CAST(brand_preference_pct AS DOUBLE))
      comment: "Average brand preference percentage from research. Measures competitive differentiation; declining preference triggers innovation and positioning review."
    - name: "avg_household_penetration_pct"
      expr: AVG(CAST(household_penetration_pct AS DOUBLE))
      comment: "Average household penetration percentage. Measures brand reach in households; low penetration triggers distribution and trial-driving investment."
    - name: "avg_repeat_rate_pct"
      expr: AVG(CAST(repeat_rate_pct AS DOUBLE))
      comment: "Average repeat purchase rate percentage. Measures consumer loyalty and product satisfaction; low repeat rate triggers product quality and loyalty programme review."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency from research studies. Measures consumer engagement intensity; low frequency triggers usage occasion and activation strategy review."
    - name: "avg_average_basket_size"
      expr: AVG(CAST(average_basket_size AS DOUBLE))
      comment: "Average basket size from research studies. Measures transaction value per shopping occasion; informs pack size, pricing, and bundling strategy."
    - name: "avg_switching_behavior_index"
      expr: AVG(CAST(switching_behavior_index AS DOUBLE))
      comment: "Average consumer switching behaviour index. Measures brand loyalty vulnerability; high switching index triggers retention and loyalty investment."
$$;