-- Metric views for domain: pricing | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_sku_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU-level retail pricing metrics covering margin health, markup, markdown depth, and price competitiveness. Primary KPI layer for pricing analysts and category managers to evaluate current price positioning and profitability."
  source: "`vibe_retail_v1`.`pricing`.`sku_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel (e.g. in-store, ecommerce, wholesale) enabling channel-specific price analysis."
    - name: "price_type"
      expr: price_type
      comment: "Classification of the price record (e.g. regular, promotional, clearance) for segmented margin analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the SKU price, used to filter approved vs. pending prices in reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which prices are denominated, enabling multi-currency reporting."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of price effectivity, enabling trend analysis of pricing changes over time."
    - name: "is_dynamic_pricing_enabled"
      expr: is_dynamic_pricing_enabled
      comment: "Flag indicating whether dynamic pricing is active for the SKU, enabling comparison of dynamic vs. static pricing performance."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Flag indicating whether the price is locked from automated changes, useful for governance reporting."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason driving the price, enabling root-cause analysis of margin movements."
  measures:
    - name: "total_sku_prices"
      expr: COUNT(1)
      comment: "Total number of active SKU price records. Baseline volume metric for pricing coverage reporting."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail selling price across SKUs. Tracks overall price level trends and supports pricing strategy reviews."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage across SKU prices. Core profitability KPI used by category managers and finance to assess pricing health."
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average initial markup percentage at time of price setting. Measures how aggressively SKUs are marked up from cost before markdowns."
    - name: "avg_markdown_pct"
      expr: AVG(CAST(markdown_pct AS DOUBLE))
      comment: "Average markdown percentage applied to SKU prices. Indicates depth of discounting and its potential margin impact."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total dollar value of markdowns applied across all SKU prices. Directly quantifies revenue given up through discounting decisions."
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average minimum allowable price floor across SKUs. Used to assess how much pricing headroom exists before floor constraints are hit."
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average maximum allowable price ceiling across SKUs. Indicates the upper bound of pricing flexibility available to the business."
    - name: "avg_competitive_price_ref"
      expr: AVG(CAST(competitive_price_ref AS DOUBLE))
      comment: "Average competitor reference price used in pricing decisions. Enables benchmarking of own prices against market to assess competitive positioning."
    - name: "avg_channel_price_variance"
      expr: AVG(CAST(channel_price_variance AS DOUBLE))
      comment: "Average price variance across channels for the same SKU. Highlights channel pricing inconsistencies that may erode margin or create arbitrage risk."
    - name: "distinct_priced_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with an active price record. Measures pricing coverage breadth across the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking the volume, magnitude, and financial impact of retail price changes. Enables leadership to monitor pricing velocity, margin impact of cost pass-throughs, and competitive response effectiveness."
  source: "`vibe_retail_v1`.`pricing`.`price_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g. regular, promotional, competitive response) for segmented impact analysis."
    - name: "change_category"
      expr: change_category
      comment: "Business category driving the price change (e.g. cost-driven, competitive, strategic) for root-cause reporting."
    - name: "channel"
      expr: channel
      comment: "Sales channel affected by the price change, enabling channel-level pricing velocity tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the price change, used to distinguish approved, pending, and rejected changes."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the price change, enabling structured root-cause analysis of pricing actions."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied (e.g. EDLP, Hi-Lo, competitive match) for strategy-level performance comparison."
    - name: "trigger_signal"
      expr: trigger_signal
      comment: "Signal that triggered the price change (e.g. cost increase, competitor move, demand shift) for causal analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of price change effectivity, enabling trend analysis of pricing activity over time."
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Flag indicating whether the price change caused a margin breach, critical for financial risk monitoring."
    - name: "is_cost_change"
      expr: is_cost_change
      comment: "Flag indicating whether the price change was driven by a cost change, enabling cost pass-through analysis."
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events. Baseline metric for pricing velocity and operational workload tracking."
    - name: "distinct_skus_repriced"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that received a price change. Measures breadth of repricing activity across the assortment."
    - name: "avg_retail_price_change_pct"
      expr: AVG(CAST(retail_price_change_pct AS DOUBLE))
      comment: "Average percentage change in retail price per event. Indicates the typical magnitude of pricing adjustments and aggressiveness of repricing strategy."
    - name: "total_retail_price_change_amount"
      expr: SUM(CAST(retail_price_change_amount AS DOUBLE))
      comment: "Total dollar value of retail price changes. Quantifies the aggregate financial impact of all repricing activity in the period."
    - name: "avg_new_margin_pct"
      expr: AVG(CAST(new_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage after price change. Key profitability outcome metric for evaluating whether repricing decisions preserved margin targets."
    - name: "avg_prior_margin_pct"
      expr: AVG(CAST(prior_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage before price change. Baseline for measuring margin impact of repricing decisions."
    - name: "margin_breach_count"
      expr: SUM(CAST(is_margin_breach AS INT))
      comment: "Number of price changes that resulted in a margin breach. Critical risk metric for finance and pricing governance teams."
    - name: "cost_driven_change_count"
      expr: SUM(CAST(is_cost_change AS INT))
      comment: "Number of price changes driven by cost changes. Measures how frequently cost increases are being passed through to retail prices."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average cost change percentage associated with price change events. Enables analysis of cost pass-through rates and pricing responsiveness to cost movements."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_competitive_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive pricing intelligence metrics measuring price gaps, price index, and competitive positioning relative to market. Used by pricing strategy teams to assess competitiveness and prioritize response actions."
  source: "`vibe_retail_v1`.`pricing`.`competitive_price`"
  dimensions:
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked against, enabling competitor-specific gap analysis."
    - name: "competitor_channel"
      expr: competitor_channel
      comment: "Channel (e.g. online, in-store) of the competitor observation, enabling channel-level competitive benchmarking."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the competitive observation, enabling regional competitive positioning analysis."
    - name: "category_code"
      expr: category_code
      comment: "Product category of the observed competitive price, enabling category-level competitive index tracking."
    - name: "department_code"
      expr: department_code
      comment: "Department associated with the competitive observation for department-level competitive reporting."
    - name: "price_gap_trend"
      expr: price_gap_trend
      comment: "Trend direction of the price gap (widening, narrowing, stable) for competitive momentum analysis."
    - name: "response_status"
      expr: response_status
      comment: "Status of the competitive response action (e.g. actioned, pending, no action) for response effectiveness tracking."
    - name: "match_type"
      expr: match_type
      comment: "Type of product match between own SKU and competitor product (exact, similar, substitute) for data quality segmentation."
    - name: "competitor_promo_flag"
      expr: competitor_promo_flag
      comment: "Flag indicating whether the competitor price is a promotional price, enabling like-for-like vs. promo gap analysis."
    - name: "observation_date_month"
      expr: DATE_TRUNC('month', observation_date)
      comment: "Month of competitive price observation, enabling trend analysis of competitive positioning over time."
  measures:
    - name: "total_competitive_observations"
      expr: COUNT(1)
      comment: "Total number of competitive price observations. Baseline metric for competitive intelligence coverage and data collection activity."
    - name: "avg_price_gap"
      expr: AVG(CAST(price_gap AS DOUBLE))
      comment: "Average absolute price gap between own price and competitor price. Core competitive positioning metric used to assess pricing parity or premium/discount stance."
    - name: "avg_price_gap_pct"
      expr: AVG(CAST(price_gap_pct AS DOUBLE))
      comment: "Average percentage price gap relative to competitor. Enables normalized comparison of competitive positioning across categories and price points."
    - name: "avg_price_index"
      expr: AVG(CAST(price_index AS DOUBLE))
      comment: "Average price index (own price / competitor price). A price index above 1.0 indicates a price premium; below 1.0 indicates a discount position. Key strategic KPI for pricing executives."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average observed competitor price. Market benchmark used to calibrate own pricing strategy."
    - name: "avg_normalized_unit_price"
      expr: AVG(CAST(normalized_unit_price AS DOUBLE))
      comment: "Average normalized unit price of competitor observations. Enables apples-to-apples comparison across different pack sizes and units of measure."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of product matching between own SKU and competitor product. Data quality KPI ensuring competitive intelligence is based on reliable matches."
    - name: "distinct_competitors_tracked"
      expr: COUNT(DISTINCT competitor_name)
      comment: "Number of distinct competitors being monitored. Measures breadth of competitive intelligence coverage."
    - name: "distinct_skus_benchmarked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct own SKUs with competitive price observations. Measures depth of competitive coverage across the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor cost and landed cost metrics enabling margin management, cost change monitoring, and sourcing cost analysis. Used by finance, buying, and pricing teams to manage cost inputs and protect margin targets."
  source: "`vibe_retail_v1`.`pricing`.`cost_price`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost record (e.g. standard, actual, contract) for segmented cost analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Approval and lifecycle status of the cost record (e.g. approved, pending, expired)."
    - name: "cost_change_reason"
      expr: cost_change_reason
      comment: "Business reason for the cost change, enabling root-cause analysis of cost movements."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is sourced from, enabling origin-based cost and duty analysis."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the cost record, enabling multi-currency cost analysis and FX impact assessment."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial term governing cost responsibility (e.g. FOB, CIF, DDP), used for landed cost analysis."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating whether this is the current active cost record for the SKU, used to filter to live cost data."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of cost effectivity, enabling trend analysis of cost movements over time."
  measures:
    - name: "total_cost_records"
      expr: COUNT(1)
      comment: "Total number of cost price records. Baseline metric for cost data coverage and vendor cost management activity."
    - name: "avg_base_cost"
      expr: AVG(CAST(base_cost AS DOUBLE))
      comment: "Average base cost across SKUs. Core input to margin calculations and pricing decisions."
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average fully-loaded landed cost including freight, duty, and handling. The true cost basis for margin and pricing decisions."
    - name: "avg_landed_cost_local"
      expr: AVG(CAST(landed_cost_local AS DOUBLE))
      comment: "Average landed cost in local currency. Enables domestic margin analysis without FX distortion."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average percentage change in cost versus prior period. Key metric for monitoring cost inflation and its potential margin impact."
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_pct AS DOUBLE))
      comment: "Average duty rate applied to imported goods. Enables analysis of tariff exposure and its contribution to landed cost."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all cost records. Quantifies logistics cost burden and supports freight optimization decisions."
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty and tariff amounts across all cost records. Measures total tariff exposure for trade compliance and sourcing strategy decisions."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost records. Enables FX impact analysis on cost and margin."
    - name: "distinct_skus_costed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with an active cost record. Measures cost data coverage across the product assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown management metrics tracking clearance effectiveness, sell-through performance, and markdown depth. Used by merchandising and planning teams to manage inventory liquidation and minimize margin loss."
  source: "`vibe_retail_v1`.`pricing`.`markdown`"
  dimensions:
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. clearance, promotional, competitive) for segmented markdown analysis."
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current lifecycle status of the markdown (e.g. active, completed, cancelled) for pipeline reporting."
    - name: "clearance_stage"
      expr: clearance_stage
      comment: "Stage of the clearance process (e.g. initial, secondary, final) enabling stage-level sell-through analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the markdown is applied, enabling channel-level markdown effectiveness comparison."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the markdown (e.g. slow seller, end of season, competitive) for root-cause analysis."
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method used to dispose of marked-down inventory (e.g. in-store sale, liquidation, donation) for recovery rate analysis."
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Flag indicating whether the markdown was triggered by a competitive price action, enabling competitive markdown tracking."
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating whether the markdown is applied to dead stock, enabling dead stock liquidation performance tracking."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the markdown became effective, enabling trend analysis of markdown activity over time."
  measures:
    - name: "total_markdowns"
      expr: COUNT(1)
      comment: "Total number of markdown events. Baseline metric for markdown activity volume and clearance pipeline size."
    - name: "avg_markdown_pct"
      expr: AVG(CAST(percent AS DOUBLE))
      comment: "Average markdown depth as a percentage of original retail price. Measures how aggressively inventory is being discounted to drive sell-through."
    - name: "total_markdown_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of markdowns taken. Directly quantifies the revenue sacrifice made to liquidate inventory."
    - name: "avg_sell_through_actual_pct"
      expr: AVG(CAST(sell_through_actual_pct AS DOUBLE))
      comment: "Average actual sell-through percentage achieved on marked-down items. Core clearance effectiveness KPI used by merchandising to evaluate markdown success."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average target sell-through percentage set for marked-down items. Baseline for measuring clearance performance against plan."
    - name: "avg_original_retail_price"
      expr: AVG(CAST(original_retail_price AS DOUBLE))
      comment: "Average original retail price of marked-down items. Indicates the price tier of inventory entering clearance."
    - name: "avg_marked_down_price"
      expr: AVG(CAST(marked_down_price AS DOUBLE))
      comment: "Average final marked-down selling price. Used alongside original retail price to quantify average price reduction depth."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply at time of markdown initiation. Indicates inventory overhang severity driving markdown decisions."
    - name: "competitive_response_markdown_count"
      expr: SUM(CAST(is_competitive_response AS INT))
      comment: "Number of markdowns triggered by competitive price actions. Measures the business cost of competitive pricing pressure in terms of margin sacrifice."
    - name: "distinct_skus_marked_down"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs currently under markdown. Measures breadth of clearance activity across the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price approval workflow metrics tracking approval rates, escalation frequency, and governance compliance. Used by pricing governance teams and finance to ensure pricing decisions meet margin guardrails and approval SLAs."
  source: "`vibe_retail_v1`.`pricing`.`price_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the price approval (e.g. approved, rejected, pending, escalated) for workflow pipeline reporting."
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval required (e.g. margin breach, competitive response, new item) for governance segmentation."
    - name: "approval_tier"
      expr: approval_tier
      comment: "Organizational tier required to approve the price change (e.g. category manager, VP, CFO) for escalation analysis."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy associated with the approval request, enabling strategy-level approval rate analysis."
    - name: "is_auto_approved"
      expr: is_auto_approved
      comment: "Flag indicating whether the price was auto-approved by system rules, enabling automation rate tracking."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Flag indicating whether the approval was escalated to a higher tier, enabling escalation rate monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price approval, enabling multi-currency governance reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the approved price becomes effective, enabling trend analysis of approval activity over time."
  measures:
    - name: "total_approval_requests"
      expr: COUNT(1)
      comment: "Total number of price approval requests submitted. Baseline metric for pricing governance workload and process volume."
    - name: "auto_approved_count"
      expr: SUM(CAST(is_auto_approved AS INT))
      comment: "Number of price approvals processed automatically by system rules. Measures automation effectiveness in the pricing governance process."
    - name: "escalated_approval_count"
      expr: SUM(CAST(is_escalated AS INT))
      comment: "Number of price approvals escalated to a higher approval tier. High escalation rates signal pricing rule gaps or excessive margin breach frequency."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage of prices submitted for approval. Enables finance to monitor whether approved prices meet margin targets."
    - name: "avg_proposed_price"
      expr: AVG(CAST(proposed_price AS DOUBLE))
      comment: "Average proposed price across all approval requests. Provides a view of the price level being submitted for governance review."
    - name: "avg_current_price"
      expr: AVG(CAST(current_price AS DOUBLE))
      comment: "Average current price at time of approval request. Baseline for measuring the magnitude of proposed price changes."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average percentage price change requested in approval submissions. Indicates the typical magnitude of pricing adjustments requiring governance review."
    - name: "distinct_skus_in_approval"
      expr: COUNT(DISTINCT promo_offer_id)
      comment: "Number of distinct promotional offers associated with approval requests. Measures the breadth of promotional pricing activity under governance review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price zone configuration and competitive positioning metrics. Used by pricing strategy and operations teams to manage zone-level pricing parameters, competitive intensity, and margin guardrails across geographic markets."
  source: "`vibe_retail_v1`.`pricing`.`price_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of price zone (e.g. national, regional, local) for hierarchical pricing analysis."
    - name: "zone_status"
      expr: zone_status
      comment: "Operational status of the price zone (e.g. active, inactive, under review) for zone management reporting."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the zone (e.g. EDLP, Hi-Lo, competitive match) for strategy-level performance comparison."
    - name: "market_tier"
      expr: market_tier
      comment: "Market tier classification (e.g. tier 1, tier 2, rural) enabling tiered pricing strategy analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the price zone for international pricing governance reporting."
    - name: "region_code"
      expr: region_code
      comment: "Regional code of the price zone enabling regional pricing performance comparison."
    - name: "is_competitive_zone"
      expr: is_competitive_zone
      comment: "Flag indicating whether the zone is designated as a competitive pricing zone, enabling competitive vs. standard zone analysis."
    - name: "is_ecommerce_enabled"
      expr: is_ecommerce_enabled
      comment: "Flag indicating whether ecommerce pricing is enabled in the zone, for omnichannel pricing coverage analysis."
  measures:
    - name: "total_price_zones"
      expr: COUNT(1)
      comment: "Total number of price zones configured. Baseline metric for pricing zone coverage and operational complexity."
    - name: "avg_base_price_multiplier"
      expr: AVG(CAST(base_price_multiplier AS DOUBLE))
      comment: "Average base price multiplier applied across zones. Indicates the typical price premium or discount applied relative to the base price list."
    - name: "avg_competitive_index"
      expr: AVG(CAST(competitive_index AS DOUBLE))
      comment: "Average competitive price index across zones. Measures how competitively priced each zone is relative to the market benchmark."
    - name: "avg_min_margin_pct"
      expr: AVG(CAST(min_margin_pct AS DOUBLE))
      comment: "Average minimum margin percentage guardrail set across price zones. Ensures pricing decisions respect margin floor requirements."
    - name: "avg_max_markdown_pct"
      expr: AVG(CAST(max_markdown_pct AS DOUBLE))
      comment: "Average maximum markdown percentage allowed per zone. Measures the depth of discounting permitted under zone-level pricing governance."
    - name: "competitive_zones_count"
      expr: SUM(CAST(is_competitive_zone AS INT))
      comment: "Number of zones designated as competitive pricing zones. Indicates the geographic scope of competitive pricing strategy deployment."
    - name: "ecommerce_enabled_zones_count"
      expr: SUM(CAST(is_ecommerce_enabled AS INT))
      comment: "Number of zones with ecommerce pricing enabled. Measures omnichannel pricing coverage across the zone network."
$$;