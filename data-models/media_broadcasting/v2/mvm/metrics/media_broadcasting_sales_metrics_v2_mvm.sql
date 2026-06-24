-- Metric views for domain: sales | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for advertising orders — tracks contracted revenue, pricing efficiency, discount exposure, and audience delivery targets to steer sales performance and yield management."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order`"
  dimensions:
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle of the order (e.g. monthly, quarterly) — used to segment revenue by payment cadence."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix associated with the order — enables analysis of revenue concentration across time-of-day inventory."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the order — used to assess credit risk and cash-flow timing."
    - name: "political_ad_flag"
      expr: political_ad_flag
      comment: "Indicates whether the order is for political advertising — required for regulatory segmentation and compliance reporting."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target audience demographic for the order — used to evaluate audience-based pricing and yield."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the order flight begins — enables time-series trending of contracted revenue."
    - name: "flight_end_month"
      expr: DATE_TRUNC('MONTH', flight_end_date)
      comment: "Month the order flight ends — used to align revenue recognition periods."
    - name: "confirmed_month"
      expr: DATE_TRUNC('MONTH', confirmed_timestamp)
      comment: "Month the order was confirmed — tracks sales booking velocity over time."
    - name: "makegood_policy"
      expr: makegood_policy
      comment: "Makegood policy applied to the order — used to assess liability exposure from under-delivery commitments."
    - name: "affidavit_required_flag"
      expr: affidavit_required_flag
      comment: "Whether an affidavit of performance is required — relevant for political and compliance-sensitive orders."
  measures:
    - name: "total_contracted_revenue"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted advertising revenue across all orders — primary top-line revenue KPI for the sales domain."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order values after agency commissions and discounts — reflects actual net revenue booked."
    - name: "avg_contracted_cpm"
      expr: AVG(CAST(contracted_cpm AS DOUBLE))
      comment: "Average contracted CPM (cost per thousand impressions) across orders — key pricing efficiency indicator for yield management."
    - name: "avg_contracted_cprp"
      expr: AVG(CAST(contracted_cprp AS DOUBLE))
      comment: "Average contracted CPRP (cost per rating point) — measures audience-based pricing efficiency for broadcast inventory."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted on orders — tracks pricing discipline and discount leakage across the sales portfolio."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target Gross Rating Points committed across all orders — measures audience delivery obligations sold."
    - name: "total_target_trp"
      expr: SUM(CAST(target_trp AS DOUBLE))
      comment: "Total target Target Rating Points committed — measures demographic-specific audience delivery obligations."
    - name: "total_commission_value"
      expr: SUM(CAST(commission_rate AS DOUBLE) * CAST(total_contracted_value AS DOUBLE) / 100.0)
      comment: "Estimated total agency commission cost derived from commission rate and contracted value — informs net revenue and agency cost management."
    - name: "count_orders"
      expr: COUNT(1)
      comment: "Total number of advertising orders — baseline volume metric for sales pipeline and booking activity."
    - name: "count_political_orders"
      expr: COUNT(CASE WHEN political_ad_flag = TRUE THEN 1 END)
      comment: "Number of political advertising orders — tracks political revenue exposure and compliance obligations."
    - name: "count_distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers with active orders — measures client base breadth and concentration risk."
    - name: "count_distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns represented in orders — indicates campaign portfolio depth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level advertising order KPIs — tracks impression delivery performance, revenue per line, CPM/CPRP pricing, and under/over-delivery ratios to manage fulfillment quality and yield."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order_line`"
  dimensions:
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the line flight begins — enables time-series analysis of delivery and revenue by period."
    - name: "flight_end_month"
      expr: DATE_TRUNC('MONTH', flight_end_date)
      comment: "Month the line flight ends — used to align revenue recognition and delivery reporting."
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month revenue is recognized for the line — critical for financial close and period-accurate P&L reporting."
    - name: "competitive_separation_category"
      expr: competitive_separation_category
      comment: "Competitive separation category for the ad line — used to manage advertiser conflict and inventory quality."
    - name: "position_preference"
      expr: position_preference
      comment: "Preferred pod position for the spot — used to analyze premium positioning demand and pricing uplift."
    - name: "preemption_priority"
      expr: preemption_priority
      comment: "Preemption priority level of the line — used to assess revenue risk from higher-priority displacement."
    - name: "spot_length_seconds"
      expr: spot_length_seconds
      comment: "Length of the ad spot in seconds — enables revenue and delivery analysis by creative format."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total gross revenue across all order lines — primary line-level revenue KPI."
    - name: "total_net_line_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts and commissions at the line level — reflects actual net yield per line."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total impressions contracted across all order lines — measures total audience delivery commitment sold."
    - name: "total_actual_impressions_delivered"
      expr: SUM(CAST(actual_impressions_delivered AS DOUBLE))
      comment: "Total impressions actually delivered — measures fulfillment against contracted audience commitments."
    - name: "total_contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total contracted Gross Rating Points at line level — measures audience obligation depth."
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total actual GRPs delivered — measures audience delivery performance against contracted GRP obligations."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM at the order line level — tracks pricing efficiency and yield per thousand impressions."
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average CPRP at the order line level — measures cost efficiency per rating point for audience-guaranteed buys."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate per spot — used to benchmark pricing across dayparts, formats, and channels."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage at line level — monitors discount discipline and revenue leakage at granular level."
    - name: "count_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines — baseline volume metric for fulfillment workload and inventory utilization."
    - name: "count_distinct_orders"
      expr: COUNT(DISTINCT ad_order_id)
      comment: "Number of distinct parent orders represented — used to assess order complexity and line density."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spot-level execution KPIs — tracks actual airings, impression delivery, spot revenue, makegood rates, preemption rates, and DAI adoption to manage operational fulfillment and advertiser satisfaction."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_spot`"
  dimensions:
    - name: "scheduled_air_month"
      expr: DATE_TRUNC('MONTH', scheduled_air_date)
      comment: "Month the spot was scheduled to air — enables time-series analysis of spot volume and revenue by period."
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Platform on which the spot was delivered (e.g. linear, streaming, OTT) — critical for cross-platform revenue and delivery analysis."
    - name: "spot_length_seconds"
      expr: spot_length_seconds
      comment: "Length of the spot in seconds — used to analyze revenue and delivery by creative format."
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Indicates whether the spot is a makegood replacement — used to track under-delivery remediation volume."
    - name: "preempted_flag"
      expr: preempted_flag
      comment: "Indicates whether the spot was preempted — used to measure inventory displacement and revenue risk."
    - name: "dai_flag"
      expr: dai_flag
      comment: "Indicates whether dynamic ad insertion was used — tracks DAI adoption and its revenue contribution."
    - name: "bonus_spot_flag"
      expr: bonus_spot_flag
      comment: "Indicates whether the spot was a bonus (non-billed) unit — used to quantify value-added inventory given away."
    - name: "rotation_pattern"
      expr: rotation_pattern
      comment: "Rotation pattern applied to the spot — used to analyze creative distribution and frequency management."
    - name: "spot_rate_currency"
      expr: spot_rate_currency
      comment: "Currency of the spot rate — required for multi-currency revenue normalization."
    - name: "ad_pod_position"
      expr: ad_pod_position
      comment: "Position of the spot within the ad pod — used to analyze premium positioning demand and pricing."
  measures:
    - name: "total_spot_revenue"
      expr: SUM(CAST(spot_rate_amount AS DOUBLE))
      comment: "Total revenue from aired spots — primary spot-level revenue KPI reflecting actual billed airings."
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total impressions delivered across all spots — measures actual audience reach achieved for advertisers."
    - name: "total_grp_value"
      expr: SUM(CAST(grp_value AS DOUBLE))
      comment: "Total Gross Rating Points delivered across all spots — measures cumulative audience delivery performance."
    - name: "total_trp_value"
      expr: SUM(CAST(trp_value AS DOUBLE))
      comment: "Total Target Rating Points delivered — measures demographic-specific audience delivery at spot level."
    - name: "avg_cpm_amount"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average CPM realized per spot — tracks pricing yield and efficiency at the execution level."
    - name: "count_spots_aired"
      expr: COUNT(1)
      comment: "Total number of spots — baseline volume metric for inventory utilization and fulfillment throughput."
    - name: "count_makegood_spots"
      expr: COUNT(CASE WHEN makegood_flag = TRUE THEN 1 END)
      comment: "Number of makegood spots aired — measures under-delivery remediation volume and associated cost."
    - name: "count_preempted_spots"
      expr: COUNT(CASE WHEN preempted_flag = TRUE THEN 1 END)
      comment: "Number of preempted spots — tracks inventory displacement frequency and advertiser satisfaction risk."
    - name: "count_dai_spots"
      expr: COUNT(CASE WHEN dai_flag = TRUE THEN 1 END)
      comment: "Number of spots delivered via dynamic ad insertion — measures DAI adoption and addressable revenue contribution."
    - name: "count_bonus_spots"
      expr: COUNT(CASE WHEN bonus_spot_flag = TRUE THEN 1 END)
      comment: "Number of bonus (non-billed) spots — quantifies value-added inventory given away, informing yield management decisions."
    - name: "count_distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with spots aired — measures active client base breadth at execution level."
    - name: "count_distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns with spots aired — tracks active campaign execution volume."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level strategic KPIs — tracks total budget, audience targets, pricing goals, and campaign portfolio health to steer advertiser investment and sales strategy."
  source: "`vibe_media_broadcasting_v1`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign starts — enables time-series analysis of campaign launches and budget deployment."
    - name: "campaign_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the campaign ends — used to align budget and delivery reporting to campaign lifecycle."
    - name: "product_brand"
      expr: product_brand
      comment: "Brand or product being advertised — enables revenue and performance analysis by advertiser brand."
    - name: "makegood_eligible_flag"
      expr: makegood_eligible_flag
      comment: "Whether the campaign is eligible for makegood remediation — used to assess under-delivery liability exposure."
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Month the campaign was approved — tracks sales approval velocity and pipeline conversion timing."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total advertising budget committed across all campaigns — primary top-line demand KPI for the sales pipeline."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average campaign budget — benchmarks deal size and informs tiering of advertiser investment levels."
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS DOUBLE))
      comment: "Total impressions targeted across all campaigns — measures total audience delivery obligation in the pipeline."
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target GRPs across campaigns — measures aggregate audience rating point commitments sold."
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM across campaigns — tracks pricing ambition and yield expectations in the sales pipeline."
    - name: "avg_target_frequency"
      expr: AVG(CAST(target_frequency AS DOUBLE))
      comment: "Average target frequency per campaign — measures audience engagement depth commitments sold."
    - name: "avg_target_reach_percent"
      expr: AVG(CAST(target_reach_percent AS DOUBLE))
      comment: "Average target reach percentage across campaigns — tracks breadth of audience coverage commitments."
    - name: "count_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns — baseline volume metric for sales pipeline depth and advertiser activity."
    - name: "count_distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with active campaigns — measures client base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal pipeline KPIs — tracks proposal value, win probability, conversion funnel, pricing, and audience commitments to manage the pre-sales pipeline and forecast revenue."
  source: "`vibe_media_broadcasting_v1`.`sales`.`proposal`"
  dimensions:
    - name: "proposal_month"
      expr: DATE_TRUNC('MONTH', proposal_date)
      comment: "Month the proposal was created — enables time-series analysis of proposal volume and pipeline build."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month the proposal was submitted to the advertiser — tracks sales activity cadence."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the proposed flight begins — used to align pipeline value to future revenue periods."
    - name: "demographic_target"
      expr: demographic_target
      comment: "Target demographic for the proposal — enables pipeline analysis by audience segment."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix proposed — used to analyze inventory demand concentration by time-of-day."
    - name: "platform_mix"
      expr: platform_mix
      comment: "Platform mix proposed (linear, digital, OTT) — tracks cross-platform demand in the pipeline."
    - name: "audience_guarantee_flag"
      expr: audience_guarantee_flag
      comment: "Whether the proposal includes an audience guarantee — used to assess delivery risk and pricing premium."
    - name: "source"
      expr: source
      comment: "Source channel of the proposal (e.g. direct, agency, programmatic) — used to analyze pipeline by origination channel."
  measures:
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Total gross value of all proposals — primary pipeline revenue KPI for sales forecasting."
    - name: "total_net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Total net proposed value after discounts and commissions — reflects net revenue potential in the pipeline."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE) * CAST(win_probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value — the primary sales forecast KPI, weighting each proposal by its win likelihood."
    - name: "avg_win_probability_percent"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average win probability across proposals — tracks overall pipeline quality and sales confidence."
    - name: "total_proposed_impressions"
      expr: SUM(CAST(proposed_impressions AS DOUBLE))
      comment: "Total impressions proposed across all proposals — measures audience inventory demand in the pipeline."
    - name: "total_guaranteed_impressions"
      expr: SUM(CAST(guaranteed_impressions AS DOUBLE))
      comment: "Total guaranteed impressions committed in proposals — measures hard delivery obligations being offered."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average CPM proposed — tracks pricing levels in the pipeline and benchmarks against contracted rates."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered in proposals — monitors pre-sale pricing discipline and discount leakage."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value offered across proposals — quantifies revenue concessions in the pipeline."
    - name: "count_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals — baseline volume metric for sales activity and pipeline breadth."
    - name: "count_distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with active proposals — measures client engagement breadth in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_avail`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory availability KPIs — tracks available impressions, floor pricing, projected audience delivery, and inventory hold activity to optimize yield and inventory monetization."
  source: "`vibe_media_broadcasting_v1`.`sales`.`avail`"
  dimensions:
    - name: "air_month"
      expr: DATE_TRUNC('MONTH', air_date)
      comment: "Month the avail is scheduled to air — enables time-series analysis of inventory supply by period."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the avail — used to analyze inventory supply and pricing by market."
    - name: "genre"
      expr: genre
      comment: "Content genre of the avail — enables inventory and pricing analysis by content category."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic for the avail — used to segment inventory supply by audience profile."
    - name: "preemptible_flag"
      expr: preemptible_flag
      comment: "Whether the avail is preemptible — used to distinguish premium guaranteed inventory from preemptible supply."
    - name: "makegood_eligible_flag"
      expr: makegood_eligible_flag
      comment: "Whether the avail is eligible for makegood use — tracks remediation inventory supply."
    - name: "window_start_month"
      expr: DATE_TRUNC('MONTH', window_start_date)
      comment: "Month the avail window opens — used to align inventory supply to sales windows."
  measures:
    - name: "total_projected_impressions"
      expr: SUM(CAST(projected_impressions AS DOUBLE))
      comment: "Total projected impressions across all avails — measures total audience inventory supply available for sale."
    - name: "total_projected_grp"
      expr: SUM(CAST(projected_grp AS DOUBLE))
      comment: "Total projected GRPs across all avails — measures aggregate audience rating point supply available."
    - name: "avg_floor_cpm_usd"
      expr: AVG(CAST(floor_cpm_usd AS DOUBLE))
      comment: "Average floor CPM across avails — tracks minimum pricing thresholds and yield floor management."
    - name: "avg_floor_rate_usd"
      expr: AVG(CAST(floor_rate_usd AS DOUBLE))
      comment: "Average floor rate per unit across avails — benchmarks minimum acceptable pricing for inventory."
    - name: "count_avails"
      expr: COUNT(1)
      comment: "Total number of avails — baseline inventory supply volume metric."
    - name: "count_avails_on_hold"
      expr: COUNT(CASE WHEN hold_placed_timestamp IS NOT NULL AND hold_expiry_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of avails currently on hold — measures inventory locked in negotiation, indicating near-term conversion potential."
    - name: "count_preemptible_avails"
      expr: COUNT(CASE WHEN preemptible_flag = TRUE THEN 1 END)
      comment: "Number of preemptible avails — quantifies lower-priority inventory supply for yield tiering analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_pod`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad pod inventory KPIs — tracks pod-level audience estimates, CPM floor pricing, DAI enablement, and political/alcohol ad allowances to manage pod yield and compliance."
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_pod`"
  dimensions:
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_time)
      comment: "Month the pod is scheduled to start — enables time-series analysis of pod inventory by period."
    - name: "inventory_class"
      expr: inventory_class
      comment: "Class of inventory for the pod (e.g. premium, standard, remnant) — used to analyze yield by inventory tier."
    - name: "sales_market"
      expr: sales_market
      comment: "Sales market associated with the pod — enables geographic revenue and inventory analysis."
    - name: "audience_target_demo"
      expr: audience_target_demo
      comment: "Target demographic for the pod — used to segment pod inventory by audience profile."
    - name: "dai_enabled_flag"
      expr: dai_enabled_flag
      comment: "Whether dynamic ad insertion is enabled for the pod — tracks DAI-capable inventory supply."
    - name: "political_ad_allowed_flag"
      expr: political_ad_allowed_flag
      comment: "Whether political ads are permitted in the pod — used for compliance and political inventory management."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether the pod is subject to a blackout restriction — used to identify unavailable inventory."
    - name: "break_position"
      expr: break_position
      comment: "Position of the ad break within the program — used to analyze premium positioning demand and pricing."
  measures:
    - name: "total_estimated_grp"
      expr: SUM(CAST(estimated_grp AS DOUBLE))
      comment: "Total estimated GRPs across all ad pods — measures aggregate audience delivery potential of pod inventory."
    - name: "avg_pod_rate_card_cpm"
      expr: AVG(CAST(pod_rate_card_cpm AS DOUBLE))
      comment: "Average rate card CPM for ad pods — tracks published pricing levels and yield benchmarks for pod inventory."
    - name: "count_pods"
      expr: COUNT(1)
      comment: "Total number of ad pods — baseline inventory supply volume metric for pod-level planning."
    - name: "count_dai_enabled_pods"
      expr: COUNT(CASE WHEN dai_enabled_flag = TRUE THEN 1 END)
      comment: "Number of DAI-enabled pods — measures addressable inventory supply and DAI monetization potential."
    - name: "count_blacked_out_pods"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of blacked-out pods — quantifies inventory lost to blackout restrictions, informing rights and distribution decisions."
    - name: "count_political_allowed_pods"
      expr: COUNT(CASE WHEN political_ad_allowed_flag = TRUE THEN 1 END)
      comment: "Number of pods permitting political ads — measures political inventory supply for compliance and revenue planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_advertiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertiser master KPIs — tracks credit exposure, contract coverage, and client portfolio composition to manage advertiser risk and relationship health."
  source: "`vibe_media_broadcasting_v1`.`sales`.`advertiser`"
  dimensions:
    - name: "annual_spend_tier"
      expr: annual_spend_tier
      comment: "Annual spend tier of the advertiser (e.g. platinum, gold, silver) — used to segment clients by revenue contribution."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the advertiser — used to assess cash-flow risk and collections exposure."
    - name: "is_political_advertiser"
      expr: is_political_advertiser
      comment: "Whether the advertiser is classified as a political advertiser — required for regulatory compliance segmentation."
    - name: "requires_ad_clearance"
      expr: requires_ad_clearance
      comment: "Whether the advertiser requires ad clearance review — used to manage compliance workflow volume."
    - name: "billing_state_province"
      expr: billing_state_province
      comment: "State or province of the advertiser billing address — enables geographic analysis of client base."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month the advertiser contract begins — tracks new client onboarding and contract renewal cycles."
    - name: "contract_end_month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
      comment: "Month the advertiser contract expires — used to identify renewal risk and churn exposure."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all advertisers — measures aggregate credit exposure in the advertiser portfolio."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per advertiser — benchmarks credit exposure by client and informs credit policy decisions."
    - name: "count_advertisers"
      expr: COUNT(1)
      comment: "Total number of advertisers — baseline client portfolio size metric."
    - name: "count_political_advertisers"
      expr: COUNT(CASE WHEN is_political_advertiser = TRUE THEN 1 END)
      comment: "Number of political advertisers — tracks political client exposure for compliance and revenue planning."
    - name: "count_advertisers_requiring_clearance"
      expr: COUNT(CASE WHEN requires_ad_clearance = TRUE THEN 1 END)
      comment: "Number of advertisers requiring ad clearance — measures compliance review workload and operational overhead."
    - name: "count_distinct_agencies"
      expr: COUNT(DISTINCT sales_agency_id)
      comment: "Number of distinct sales agencies representing advertisers — measures agency channel breadth and dependency."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_agency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales agency KPIs — tracks commission rates, credit limits, accreditation status, and agency portfolio health to manage channel partner performance and financial exposure."
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_agency`"
  dimensions:
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model of the agency (e.g. gross, net) — used to segment agency revenue and commission structures."
    - name: "holding_company_group"
      expr: holding_company_group
      comment: "Holding company group the agency belongs to — enables analysis of revenue concentration by agency group."
    - name: "billing_state_province"
      expr: billing_state_province
      comment: "State or province of the agency billing address — enables geographic analysis of agency distribution."
    - name: "accreditation_expiry_month"
      expr: DATE_TRUNC('MONTH', accreditation_expiry_date)
      comment: "Month the agency accreditation expires — used to proactively manage accreditation renewal risk."
    - name: "onboarding_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month the agency was onboarded — tracks agency partner acquisition over time."
  measures:
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across sales agencies — tracks agency cost of sales and informs commission policy decisions."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all sales agencies — measures aggregate financial exposure to agency channel partners."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per agency — benchmarks credit exposure by partner and informs credit risk management."
    - name: "count_agencies"
      expr: COUNT(1)
      comment: "Total number of sales agencies — baseline channel partner portfolio size metric."
    - name: "count_agencies_expiring_accreditation"
      expr: COUNT(CASE WHEN accreditation_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND accreditation_expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of agencies with accreditation expiring within 90 days — operational risk metric for proactive renewal management."
$$;