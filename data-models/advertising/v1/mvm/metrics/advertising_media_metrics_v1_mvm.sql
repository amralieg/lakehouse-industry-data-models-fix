-- Metric views for domain: media | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic media plan KPIs covering budget sizing, audience targeting ambition, and delivery efficiency targets. Used by media directors and CMOs to evaluate plan scope, investment scale, and reach/frequency strategy across campaigns."
  source: "`advertising_ecm`.`media`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the media plan (e.g. Draft, Approved, Executed, Cancelled) — used to filter active vs. historical plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Classification of the plan (e.g. Upfront, Scatter, Digital, Cross-Channel) — enables channel-mix and buying-approach analysis."
    - name: "buying_approach"
      expr: buying_approach
      comment: "Buying methodology (e.g. Direct, Programmatic, Hybrid) — key dimension for evaluating procurement strategy."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Boolean flag indicating whether the plan is programmatic — supports programmatic vs. direct investment split analysis."
    - name: "is_addressable"
      expr: is_addressable
      comment: "Boolean flag indicating whether the plan uses addressable targeting — supports audience precision investment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the plan budget is denominated — required for multi-currency normalization."
    - name: "primary_kpi"
      expr: primary_kpi
      comment: "The primary KPI the plan is optimized toward (e.g. Reach, Impressions, Conversions, GRP) — aligns plan investment to outcome objective."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic footprint of the plan (e.g. National, Regional, Local) — supports geo-level budget allocation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the plan — used to track plans pending authorization vs. approved for execution."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month-truncated flight start date — enables time-series trending of plan launches."
    - name: "channel_mix"
      expr: channel_mix
      comment: "Descriptive channel mix strategy for the plan — supports cross-channel investment analysis."
  measures:
    - name: "total_planned_budget"
      expr: SUM(CAST(total_planned_budget AS DOUBLE))
      comment: "Total gross planned budget across all media plans. Primary investment sizing KPI used by finance and media leadership to track committed spend."
    - name: "total_net_budget"
      expr: SUM(CAST(net_budget AS DOUBLE))
      comment: "Total net budget after agency commissions across all plans. Represents the actual media value delivered to the client."
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across plans. Tracks agency fee efficiency and negotiation outcomes."
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Sum of GRP (Gross Rating Point) targets across plans. Measures aggregate audience delivery ambition for broadcast/video campaigns."
    - name: "avg_reach_target_pct"
      expr: AVG(CAST(reach_target_pct AS DOUBLE))
      comment: "Average planned reach percentage across plans. Indicates the breadth of audience coverage being targeted."
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM (Cost Per Thousand Impressions) across plans. Benchmarks pricing efficiency expectations set at planning stage."
    - name: "avg_planned_frequency"
      expr: AVG(CAST(frequency_target AS DOUBLE))
      comment: "Average planned frequency target across plans. Measures intended message repetition per audience member — key for brand recall strategy."
    - name: "plan_count"
      expr: COUNT(DISTINCT plan_id)
      comment: "Count of distinct media plans. Baseline volume metric for plan pipeline and workload management."
    - name: "approved_plan_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN plan_id END)
      comment: "Count of plans that have received formal approval. Tracks plan authorization throughput and pipeline readiness."
    - name: "programmatic_plan_budget"
      expr: SUM(CASE WHEN is_programmatic = TRUE THEN CAST(total_planned_budget AS DOUBLE) ELSE 0 END)
      comment: "Total planned budget allocated to programmatic plans. Measures the scale of automated buying investment vs. direct."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular media plan line KPIs covering channel-level spend, impression delivery, CPM efficiency, and audience reach. The primary operational planning layer used by media planners and buyers to evaluate line-level investment performance."
  source: "`advertising_ecm`.`media`.`plan_line`"
  dimensions:
    - name: "media_type"
      expr: media_type
      comment: "High-level media type (e.g. Digital, TV, OOH, Radio, Print) — primary dimension for cross-channel investment analysis."
    - name: "media_subtype"
      expr: media_subtype
      comment: "Sub-classification of media type (e.g. Display, Video, Streaming, Podcast) — enables granular channel mix reporting."
    - name: "buying_type"
      expr: buying_type
      comment: "Buying mechanism for the line (e.g. CPM, CPC, CPA, Flat Fee) — used to analyze pricing model mix and efficiency."
    - name: "buying_status"
      expr: buying_status
      comment: "Current buying workflow status of the plan line — tracks lines through the buying lifecycle."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the plan line — identifies lines pending authorization before buying can proceed."
    - name: "market"
      expr: market
      comment: "Geographic market for the plan line (e.g. New York, Los Angeles, National) — supports market-level budget allocation analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code for the plan line — enables international investment breakdown."
    - name: "daypart"
      expr: daypart
      comment: "Daypart targeting for the line (e.g. Prime, Late Night, Morning Drive) — key for broadcast and streaming scheduling analysis."
    - name: "is_makegood"
      expr: is_makegood
      comment: "Boolean flag indicating whether the line is a makegood (compensatory placement) — used to track delivery shortfall remediation."
    - name: "is_bonus"
      expr: is_bonus
      comment: "Boolean flag indicating whether the line is a bonus placement — tracks added-value inventory received from publishers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the plan line — required for multi-currency budget consolidation."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month-truncated flight start date — enables monthly spend and impression pacing analysis."
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total gross planned spend across all plan lines. Primary investment volume KPI for media planning."
    - name: "total_planned_net_spend"
      expr: SUM(CAST(planned_net_spend AS DOUBLE))
      comment: "Total net planned spend after agency commissions. Represents actual media value committed to publishers."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions across all lines. Core audience delivery volume KPI for digital and programmatic campaigns."
    - name: "total_planned_grps"
      expr: SUM(CAST(planned_grps AS DOUBLE))
      comment: "Total planned GRPs (Gross Rating Points) across lines. Measures aggregate broadcast audience delivery weight."
    - name: "total_planned_trps"
      expr: SUM(CAST(planned_trps AS DOUBLE))
      comment: "Total planned TRPs (Target Rating Points) across lines. Measures audience delivery weight against the specific target demographic."
    - name: "avg_planned_cpm"
      expr: AVG(CAST(planned_cpm AS DOUBLE))
      comment: "Average planned CPM across plan lines. Benchmarks cost efficiency of media buys at the planning stage."
    - name: "avg_planned_cpc"
      expr: AVG(CAST(planned_cpc AS DOUBLE))
      comment: "Average planned CPC (Cost Per Click) across plan lines. Tracks performance-based pricing efficiency for click-optimized campaigns."
    - name: "avg_planned_cpa"
      expr: AVG(CAST(planned_cpa AS DOUBLE))
      comment: "Average planned CPA (Cost Per Acquisition) across plan lines. Tracks conversion efficiency expectations set at planning stage."
    - name: "avg_planned_reach_pct"
      expr: AVG(CAST(planned_reach_pct AS DOUBLE))
      comment: "Average planned reach percentage across lines. Measures breadth of audience coverage targeted per line."
    - name: "avg_planned_frequency"
      expr: AVG(CAST(planned_frequency AS DOUBLE))
      comment: "Average planned frequency across lines. Measures intended message repetition per audience member."
    - name: "plan_line_count"
      expr: COUNT(DISTINCT plan_line_id)
      comment: "Count of distinct plan lines. Baseline volume metric for plan complexity and buying workload."
    - name: "makegood_line_count"
      expr: COUNT(DISTINCT CASE WHEN is_makegood = TRUE THEN plan_line_id END)
      comment: "Count of makegood plan lines. Tracks the volume of compensatory placements required due to delivery shortfalls."
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across plan lines. Monitors fee efficiency at the line level."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media buy execution KPIs covering committed spend, negotiated rates, delivery status, and financial reconciliation. Used by media buyers, finance, and operations to track buy-level investment, rate efficiency, and reconciliation health."
  source: "`advertising_ecm`.`media`.`buy`"
  dimensions:
    - name: "buy_type"
      expr: buy_type
      comment: "Type of media buy (e.g. Upfront, Scatter, Programmatic, Direct) — primary dimension for buy strategy analysis."
    - name: "buy_status"
      expr: buy_status
      comment: "Current lifecycle status of the buy (e.g. Active, Cancelled, Completed, Pending) — used to filter active vs. historical buys."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery execution status of the buy — tracks whether inventory is delivering as contracted."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Financial reconciliation state of the buy — identifies buys with outstanding billing or discrepancy issues."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Pricing basis for the buy (e.g. CPM, CPC, Flat, GRP) — enables rate model mix analysis."
    - name: "market_type"
      expr: market_type
      comment: "Market classification for the buy (e.g. National, Local, DMA) — supports geographic investment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the buy — required for multi-currency financial consolidation."
    - name: "added_value_flag"
      expr: added_value_flag
      comment: "Boolean flag indicating whether the buy includes added-value inventory — tracks bonus media received from publishers."
    - name: "makegood_flag"
      expr: makegood_flag
      comment: "Boolean flag indicating whether the buy is a makegood — tracks compensatory buys issued for delivery shortfalls."
    - name: "buy_date_month"
      expr: DATE_TRUNC('month', buy_date)
      comment: "Month-truncated buy date — enables monthly buy volume and spend trend analysis."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month-truncated flight start date — supports campaign pacing and seasonal spend analysis."
  measures:
    - name: "total_gross_buy_amount"
      expr: SUM(CAST(gross_buy_amount AS DOUBLE))
      comment: "Total gross buy amount across all buys. Primary financial commitment KPI representing total media investment before commissions."
    - name: "total_net_buy_amount"
      expr: SUM(CAST(net_buy_amount AS DOUBLE))
      comment: "Total net buy amount after agency commissions. Represents actual media value delivered to publishers."
    - name: "total_agency_commission_amount"
      expr: SUM(CAST(agency_commission_amount AS DOUBLE))
      comment: "Total agency commission dollars earned across buys. Tracks agency revenue and fee efficiency."
    - name: "total_authorized_spend_ceiling"
      expr: SUM(CAST(authorized_spend_ceiling AS DOUBLE))
      comment: "Total authorized spend ceiling across buys. Measures the maximum approved investment exposure for financial risk management."
    - name: "total_booked_units"
      expr: SUM(CAST(booked_units AS DOUBLE))
      comment: "Total booked units (impressions, spots, etc.) across buys. Measures contracted inventory volume."
    - name: "avg_negotiated_rate"
      expr: AVG(CAST(negotiated_rate AS DOUBLE))
      comment: "Average negotiated rate across buys. Benchmarks buying efficiency and rate negotiation outcomes vs. rate card."
    - name: "buy_count"
      expr: COUNT(DISTINCT buy_id)
      comment: "Count of distinct media buys. Baseline volume metric for buying activity and operational workload."
    - name: "cancelled_buy_count"
      expr: COUNT(DISTINCT CASE WHEN buy_status = 'Cancelled' THEN buy_id END)
      comment: "Count of cancelled buys. Tracks cancellation volume which may indicate campaign changes, budget cuts, or publisher issues."
    - name: "unreconciled_buy_count"
      expr: COUNT(DISTINCT CASE WHEN reconciliation_status != 'Reconciled' THEN buy_id END)
      comment: "Count of buys not yet financially reconciled. Tracks outstanding billing exposure and finance operations backlog."
    - name: "makegood_buy_amount"
      expr: SUM(CASE WHEN makegood_flag = TRUE THEN CAST(gross_buy_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross buy amount for makegood buys. Quantifies the financial scale of compensatory inventory issued for delivery failures."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_insertion_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insertion order KPIs covering authorized spend, guaranteed impressions, pricing model mix, and IO lifecycle management. Used by media operations, finance, and account teams to track contractual commitments with publishers."
  source: "`advertising_ecm`.`media`.`media_insertion_order`"
  dimensions:
    - name: "io_status"
      expr: io_status
      comment: "Current lifecycle status of the insertion order (e.g. Draft, Executed, Cancelled, Completed) — primary filter for active IO portfolio."
    - name: "io_type"
      expr: io_type
      comment: "Type of insertion order (e.g. Standard, Programmatic, Upfront) — enables IO strategy mix analysis."
    - name: "buying_method"
      expr: buying_method
      comment: "Buying method for the IO (e.g. Direct, Programmatic Guaranteed, PMP) — tracks procurement approach distribution."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the IO (e.g. CPM, CPC, Flat Fee, GRP) — enables rate model mix and efficiency analysis."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Boolean flag indicating whether the IO is programmatic — supports programmatic vs. direct investment split."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the IO — required for multi-currency financial consolidation."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency for the IO (e.g. Monthly, Weekly, End of Flight) — supports cash flow and accounts payable planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the publisher — tracks financial obligation timing."
    - name: "execution_date_month"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Month-truncated IO execution date — enables monthly IO commitment trend analysis."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month-truncated flight start date — supports campaign pacing and seasonal IO analysis."
  measures:
    - name: "total_authorized_spend"
      expr: SUM(CAST(authorized_spend_amount AS DOUBLE))
      comment: "Total authorized spend amount across all insertion orders. Primary financial commitment KPI for publisher contractual obligations."
    - name: "total_net_spend"
      expr: SUM(CAST(net_spend_amount AS DOUBLE))
      comment: "Total net spend amount across IOs after commissions. Represents actual media value committed to publishers."
    - name: "total_agency_commission_amount"
      expr: SUM(CAST(agency_commission_amount AS DOUBLE))
      comment: "Total agency commission dollars across IOs. Tracks agency revenue from IO-level media transactions."
    - name: "total_guaranteed_impressions"
      expr: SUM(CAST(guaranteed_impressions AS DOUBLE))
      comment: "Total guaranteed impressions contracted across IOs. Measures the volume of inventory contractually committed by publishers."
    - name: "io_count"
      expr: COUNT(DISTINCT media_insertion_order_id)
      comment: "Count of distinct insertion orders. Baseline volume metric for publisher relationship and contract management workload."
    - name: "active_io_count"
      expr: COUNT(DISTINCT CASE WHEN io_status = 'Active' THEN media_insertion_order_id END)
      comment: "Count of currently active insertion orders. Tracks live publisher commitments requiring operational management."
    - name: "programmatic_io_spend"
      expr: SUM(CASE WHEN is_programmatic = TRUE THEN CAST(authorized_spend_amount AS DOUBLE) ELSE 0 END)
      comment: "Total authorized spend on programmatic insertion orders. Measures the scale of automated buying commitments vs. direct."
    - name: "avg_authorized_spend_per_io"
      expr: AVG(CAST(authorized_spend_amount AS DOUBLE))
      comment: "Average authorized spend per insertion order. Benchmarks IO deal size and publisher investment concentration."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media placement KPIs covering contracted value, CPM pricing, viewability targets, impression commitments, and inventory quality. Used by media planners, buyers, and ad operations to evaluate placement-level efficiency, pricing, and delivery expectations."
  source: "`advertising_ecm`.`media`.`media_placement`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Current lifecycle status of the placement (e.g. Active, Paused, Cancelled, Completed) — primary filter for active placement portfolio."
    - name: "placement_type"
      expr: placement_type
      comment: "Type of placement (e.g. Display, Video, Native, Audio) — primary dimension for format-level investment analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type for the placement (e.g. Digital, Social, CTV, OOH) — enables cross-channel placement analysis."
    - name: "buying_method"
      expr: buying_method
      comment: "Buying method for the placement (e.g. Direct, PMP, Open Auction) — tracks procurement approach distribution."
    - name: "environment_type"
      expr: environment_type
      comment: "Environment where the placement runs (e.g. Desktop, Mobile, CTV, In-App) — supports device-level performance analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type for the placement (e.g. CPM, CPC, CPCV, Flat) — enables pricing model efficiency comparison."
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety classification tier for the placement — tracks inventory quality and brand risk exposure."
    - name: "is_guaranteed_inventory"
      expr: is_guaranteed_inventory
      comment: "Boolean flag indicating guaranteed vs. non-guaranteed inventory — key dimension for delivery certainty analysis."
    - name: "is_programmatic_eligible"
      expr: is_programmatic_eligible
      comment: "Boolean flag indicating whether the placement is eligible for programmatic buying — supports automation strategy analysis."
    - name: "trafficking_status"
      expr: trafficking_status
      comment: "Ad trafficking status of the placement — tracks operational readiness for delivery."
    - name: "geo_targeting_scope"
      expr: geo_targeting_scope
      comment: "Geographic targeting scope for the placement — supports market-level placement analysis."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month-truncated flight start date — enables monthly placement volume and spend trend analysis."
  measures:
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value AS DOUBLE))
      comment: "Total gross contracted value across all placements. Primary financial commitment KPI for placement-level publisher obligations."
    - name: "total_net_contracted_value"
      expr: SUM(CAST(net_contracted_value AS DOUBLE))
      comment: "Total net contracted value after commissions. Represents actual media value committed at the placement level."
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS DOUBLE))
      comment: "Total contracted impressions across placements. Measures the volume of inventory contractually committed."
    - name: "total_contracted_units"
      expr: SUM(CAST(contracted_units AS DOUBLE))
      comment: "Total contracted units (spots, clicks, etc.) across placements. Tracks non-impression-based inventory commitments."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate across placements. Benchmarks negotiated pricing efficiency vs. list price."
    - name: "avg_cpm_list_price"
      expr: AVG(CAST(cpm_list_price AS DOUBLE))
      comment: "Average CPM list price across placements. Establishes the rate card baseline for discount and negotiation analysis."
    - name: "avg_cpm_floor_price"
      expr: AVG(CAST(cpm_floor_price AS DOUBLE))
      comment: "Average CPM floor price across placements. Tracks minimum acceptable pricing thresholds for programmatic inventory."
    - name: "avg_viewability_target_pct"
      expr: AVG(CAST(viewability_target_pct AS DOUBLE))
      comment: "Average viewability target percentage across placements. Measures the quality standard being demanded from publishers."
    - name: "avg_viewability_rate_benchmark_pct"
      expr: AVG(CAST(viewability_rate_benchmark_pct AS DOUBLE))
      comment: "Average viewability rate benchmark percentage across placements. Tracks historical viewability performance expectations."
    - name: "total_estimated_monthly_impressions"
      expr: SUM(CAST(estimated_monthly_impressions AS DOUBLE))
      comment: "Total estimated monthly impressions across placements. Measures projected audience delivery scale for capacity planning."
    - name: "placement_count"
      expr: COUNT(DISTINCT media_placement_id)
      comment: "Count of distinct media placements. Baseline volume metric for placement portfolio size and trafficking workload."
    - name: "guaranteed_placement_count"
      expr: COUNT(DISTINCT CASE WHEN is_guaranteed_inventory = TRUE THEN media_placement_id END)
      comment: "Count of guaranteed inventory placements. Tracks the portion of the placement portfolio with contractual delivery certainty."
    - name: "avg_estimated_reach_pct"
      expr: AVG(CAST(estimated_reach_pct AS DOUBLE))
      comment: "Average estimated reach percentage across placements. Measures expected audience breadth per placement."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_programmatic_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programmatic deal KPIs covering deal budget, floor CPM pricing, impression commitments, viewability standards, and deal health. Used by programmatic traders, media directors, and technology teams to evaluate deal performance, pricing efficiency, and inventory quality."
  source: "`advertising_ecm`.`media`.`programmatic_deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of programmatic deal (e.g. PMP, PG, Open Auction, Preferred Deal) — primary dimension for deal structure analysis."
    - name: "deal_status"
      expr: deal_status
      comment: "Current lifecycle status of the deal (e.g. Active, Paused, Expired, Pending) — used to filter active deal portfolio."
    - name: "environment_type"
      expr: environment_type
      comment: "Environment where the deal runs (e.g. Desktop, Mobile, CTV, In-App) — supports device-level deal analysis."
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety classification tier for the deal — tracks inventory quality and brand risk exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the deal — required for multi-currency financial consolidation."
    - name: "rtb_bid_strategy"
      expr: rtb_bid_strategy
      comment: "RTB bidding strategy for the deal (e.g. Target CPA, Target ROAS, Max Impressions) — tracks algorithmic buying approach."
    - name: "shopper_data_enabled"
      expr: shopper_data_enabled
      comment: "Boolean flag indicating whether shopper/retail data is activated on the deal — tracks data-driven targeting investment."
    - name: "closed_loop_measurement"
      expr: closed_loop_measurement
      comment: "Boolean flag indicating whether closed-loop measurement is enabled — tracks deals with full attribution capability."
    - name: "deal_source_system"
      expr: deal_source_system
      comment: "Source system where the deal was originated (e.g. DSP, SSP, Direct) — tracks deal provenance and technology stack usage."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month-truncated deal start date — enables monthly deal launch trend analysis."
  measures:
    - name: "total_deal_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget committed across programmatic deals. Primary financial KPI for programmatic investment scale."
    - name: "total_impression_commitment"
      expr: SUM(CAST(impression_commitment AS DOUBLE))
      comment: "Total impression commitments across programmatic deals. Measures contracted audience delivery volume for guaranteed programmatic."
    - name: "avg_floor_cpm"
      expr: AVG(CAST(floor_cpm AS DOUBLE))
      comment: "Average floor CPM across programmatic deals. Benchmarks minimum pricing thresholds and inventory quality expectations."
    - name: "avg_viewability_threshold_pct"
      expr: AVG(CAST(viewability_threshold_pct AS DOUBLE))
      comment: "Average viewability threshold percentage across deals. Measures the quality standard being enforced in programmatic buying."
    - name: "deal_count"
      expr: COUNT(DISTINCT programmatic_deal_id)
      comment: "Count of distinct programmatic deals. Baseline volume metric for programmatic deal portfolio size."
    - name: "active_deal_count"
      expr: COUNT(DISTINCT CASE WHEN deal_status = 'Active' THEN programmatic_deal_id END)
      comment: "Count of currently active programmatic deals. Tracks live deal portfolio requiring ongoing management and optimization."
    - name: "shopper_data_deal_budget"
      expr: SUM(CASE WHEN shopper_data_enabled = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget on deals with shopper data activated. Measures investment in data-driven audience targeting via retail signals."
    - name: "closed_loop_deal_count"
      expr: COUNT(DISTINCT CASE WHEN closed_loop_measurement = TRUE THEN programmatic_deal_id END)
      comment: "Count of deals with closed-loop measurement enabled. Tracks the portion of programmatic investment with full attribution capability."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media schedule KPIs covering scheduled cost, impression delivery, GRP/TRP delivery, CPM rates, and trafficking status. Used by media operations, broadcast buyers, and ad ops teams to track scheduled inventory delivery and cost efficiency."
  source: "`advertising_ecm`.`media`.`schedule`"
  dimensions:
    - name: "buying_type"
      expr: buying_type
      comment: "Buying type for the scheduled unit (e.g. CPM, GRP, Flat, Spot) — primary dimension for pricing model analysis."
    - name: "trafficking_status"
      expr: trafficking_status
      comment: "Ad trafficking status of the schedule (e.g. Trafficked, Pending, Error) — tracks operational readiness for delivery."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for the scheduled unit (e.g. Prime, Late Night, Morning Drive) — key for broadcast scheduling and audience analysis."
    - name: "market_name"
      expr: market_name
      comment: "Market name for the scheduled unit — supports geographic delivery analysis."
    - name: "dma_code"
      expr: dma_code
      comment: "DMA (Designated Market Area) code for the schedule — enables local market delivery analysis."
    - name: "vehicle_name"
      expr: vehicle_name
      comment: "Media vehicle (program, publication, site) where the unit is scheduled — tracks inventory source performance."
    - name: "is_makegood"
      expr: is_makegood
      comment: "Boolean flag indicating whether the scheduled unit is a makegood — tracks compensatory delivery volume."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the schedule — required for multi-currency cost consolidation."
    - name: "creative_rotation_type"
      expr: creative_rotation_type
      comment: "Creative rotation strategy for the schedule (e.g. Even, Weighted, Sequential) — tracks creative delivery approach."
    - name: "flight_start_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month-truncated flight start date — enables monthly schedule volume and cost trend analysis."
  measures:
    - name: "total_gross_cost"
      expr: SUM(CAST(gross_cost AS DOUBLE))
      comment: "Total gross cost across all scheduled units. Primary financial KPI for scheduled media investment."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost across scheduled units after commissions. Represents actual media cost paid to publishers."
    - name: "total_scheduled_impressions"
      expr: SUM(CAST(scheduled_impressions AS DOUBLE))
      comment: "Total scheduled impressions across all schedule records. Measures contracted audience delivery volume."
    - name: "total_scheduled_grp"
      expr: SUM(CAST(scheduled_grp AS DOUBLE))
      comment: "Total scheduled GRPs across schedule records. Measures aggregate broadcast audience delivery weight."
    - name: "total_scheduled_trp"
      expr: SUM(CAST(scheduled_trp AS DOUBLE))
      comment: "Total scheduled TRPs across schedule records. Measures audience delivery weight against the target demographic."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across scheduled units. Benchmarks cost efficiency of scheduled inventory."
    - name: "schedule_count"
      expr: COUNT(DISTINCT schedule_id)
      comment: "Count of distinct schedule records. Baseline volume metric for scheduling activity and ad ops workload."
    - name: "makegood_gross_cost"
      expr: SUM(CASE WHEN is_makegood = TRUE THEN CAST(gross_cost AS DOUBLE) ELSE 0 END)
      comment: "Total gross cost of makegood scheduled units. Quantifies the financial scale of compensatory inventory delivered."
    - name: "untrafficked_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN trafficking_status != 'Trafficked' THEN schedule_id END)
      comment: "Count of schedule records not yet trafficked. Tracks ad ops backlog and delivery risk from untrafficked inventory."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_publisher_property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Publisher property KPIs covering inventory scale, CPM pricing, viewability benchmarks, fraud risk, and audience reach. Used by media planners, programmatic traders, and brand safety teams to evaluate publisher quality, pricing, and inventory suitability."
  source: "`advertising_ecm`.`media`.`publisher_property`"
  dimensions:
    - name: "property_type"
      expr: property_type
      comment: "Type of publisher property (e.g. Website, App, CTV Channel, Podcast) — primary dimension for inventory type analysis."
    - name: "property_status"
      expr: property_status
      comment: "Current status of the publisher property (e.g. Active, Inactive, Suspended) — used to filter active inventory sources."
    - name: "content_vertical"
      expr: content_vertical
      comment: "Content vertical of the property (e.g. News, Sports, Entertainment, Finance) — enables contextual targeting analysis."
    - name: "brand_safety_classification"
      expr: brand_safety_classification
      comment: "Brand safety classification of the property — tracks inventory quality and brand risk exposure."
    - name: "country_code"
      expr: country_code
      comment: "Country where the property operates — supports geographic inventory analysis."
    - name: "language_code"
      expr: language_code
      comment: "Primary language of the property — enables language-targeted inventory analysis."
    - name: "programmatic_enabled"
      expr: programmatic_enabled
      comment: "Boolean flag indicating whether the property supports programmatic buying — tracks automation-eligible inventory."
    - name: "rtb_enabled"
      expr: rtb_enabled
      comment: "Boolean flag indicating whether the property supports RTB — tracks real-time bidding eligible inventory."
    - name: "pmp_deals_available"
      expr: pmp_deals_available
      comment: "Boolean flag indicating whether PMP deals are available on the property — tracks premium programmatic inventory access."
    - name: "mrc_accredited"
      expr: mrc_accredited
      comment: "Boolean flag indicating MRC (Media Rating Council) accreditation — tracks measurement quality and industry certification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination for the property — required for multi-currency pricing analysis."
  measures:
    - name: "total_monthly_impressions"
      expr: SUM(CAST(monthly_impressions AS DOUBLE))
      comment: "Total monthly impressions available across publisher properties. Measures aggregate inventory scale for media planning."
    - name: "total_monthly_unique_visitors"
      expr: SUM(CAST(monthly_unique_visitors AS DOUBLE))
      comment: "Total monthly unique visitors across publisher properties. Measures aggregate audience reach available for targeting."
    - name: "avg_cpm"
      expr: AVG(CAST(average_cpm AS DOUBLE))
      comment: "Average CPM across publisher properties. Benchmarks inventory pricing and cost efficiency across the publisher portfolio."
    - name: "avg_floor_cpm"
      expr: AVG(CAST(floor_cpm AS DOUBLE))
      comment: "Average floor CPM across publisher properties. Tracks minimum pricing thresholds for programmatic inventory access."
    - name: "avg_viewability_benchmark_pct"
      expr: AVG(CAST(viewability_benchmark_pct AS DOUBLE))
      comment: "Average viewability benchmark percentage across properties. Measures expected viewability quality of the publisher portfolio."
    - name: "avg_ad_fraud_risk_score"
      expr: AVG(CAST(ad_fraud_risk_score AS DOUBLE))
      comment: "Average ad fraud risk score across publisher properties. Tracks inventory quality and IVT (Invalid Traffic) exposure across the portfolio."
    - name: "publisher_property_count"
      expr: COUNT(DISTINCT publisher_property_id)
      comment: "Count of distinct publisher properties. Baseline volume metric for publisher portfolio breadth."
    - name: "programmatic_enabled_property_count"
      expr: COUNT(DISTINCT CASE WHEN programmatic_enabled = TRUE THEN publisher_property_id END)
      comment: "Count of publisher properties with programmatic buying enabled. Tracks automation-eligible inventory breadth."
    - name: "mrc_accredited_property_count"
      expr: COUNT(DISTINCT CASE WHEN mrc_accredited = TRUE THEN publisher_property_id END)
      comment: "Count of MRC-accredited publisher properties. Tracks the portion of the portfolio meeting industry measurement standards."
$$;