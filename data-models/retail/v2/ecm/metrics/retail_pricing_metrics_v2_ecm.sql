-- Metric views for domain: pricing | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_sku_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU-level retail pricing metrics covering margin health, price positioning, and markdown depth across channels and price zones. Primary KPI surface for pricing analysts and category managers."
  source: "`vibe_retail_v1`.`pricing`.`sku_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel (e.g. store, ecommerce, wholesale) for channel-specific price analysis."
    - name: "price_type"
      expr: price_type
      comment: "Classification of the price record (e.g. regular, promotional, clearance) for price-tier segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Workflow approval state of the price record, used to filter approved vs pending prices."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of price effectivity for trend analysis of pricing changes over time."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of price expiry for identifying upcoming price expirations."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax classification applied to the SKU price, relevant for net margin calculations."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason driving the price change, used to categorize pricing actions."
    - name: "is_dynamic_pricing_enabled"
      expr: is_dynamic_pricing_enabled
      comment: "Flag indicating whether dynamic pricing is active for this SKU-zone combination."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Flag indicating the price is locked and cannot be automatically changed."
  measures:
    - name: "total_retail_price"
      expr: SUM(CAST(retail_price AS DOUBLE))
      comment: "Sum of retail prices across all SKU-price records; used as a baseline for average price calculations."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price per SKU-price record; key indicator of price positioning across the assortment."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage across priced SKUs; primary profitability KPI for pricing decisions."
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average initial markup percentage; measures how aggressively SKUs are marked up from cost at introduction."
    - name: "avg_markdown_pct"
      expr: AVG(CAST(markdown_pct AS DOUBLE))
      comment: "Average markdown percentage applied to SKU prices; indicates depth of price reductions across the assortment."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total dollar value of markdowns applied; directly measures margin erosion from price reductions."
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average minimum allowable price floor; used to assess how much pricing headroom exists below current retail."
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average maximum allowable price ceiling; used to assess upward pricing flexibility."
    - name: "avg_min_advertised_price"
      expr: AVG(CAST(min_advertised_price AS DOUBLE))
      comment: "Average MAP (Minimum Advertised Price) across SKUs; compliance metric for vendor MAP enforcement."
    - name: "avg_competitive_price_ref"
      expr: AVG(CAST(competitive_price_ref AS DOUBLE))
      comment: "Average competitive reference price used in pricing decisions; measures alignment with market pricing."
    - name: "avg_channel_price_variance"
      expr: AVG(CAST(channel_price_variance AS DOUBLE))
      comment: "Average price variance across channels for the same SKU; identifies channel pricing inconsistencies."
    - name: "count_dynamic_pricing_skus"
      expr: COUNT(DISTINCT CASE WHEN is_dynamic_pricing_enabled = TRUE THEN sku_price_id END)
      comment: "Number of SKU-price records with dynamic pricing enabled; measures adoption of algorithmic pricing."
    - name: "count_price_locked_skus"
      expr: COUNT(DISTINCT CASE WHEN is_price_locked = TRUE THEN sku_price_id END)
      comment: "Number of SKU-price records with locked prices; indicates manual pricing overrides constraining automation."
    - name: "count_approved_prices"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'approved' THEN sku_price_id END)
      comment: "Count of approved price records; measures pricing workflow throughput and readiness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the volume, magnitude, and margin impact of retail price changes. Enables leadership to monitor pricing velocity, competitive responsiveness, and margin risk from price movements."
  source: "`vibe_retail_v1`.`pricing`.`price_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g. regular, promotional, competitive response) for categorizing pricing actions."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the price change (e.g. cost-driven, competitive, seasonal) for root-cause analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the price change applies, enabling channel-specific pricing analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the price change, used to track pending vs executed changes."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the price change, enabling systematic analysis of pricing drivers."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy governing this change (e.g. EDLP, Hi-Lo, competitive) for strategy-level analysis."
    - name: "execution_mode"
      expr: execution_mode
      comment: "How the price change was executed (e.g. manual, automated, batch) for process efficiency analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the price change became effective, for trend analysis of pricing activity over time."
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Flag indicating the price change breached margin thresholds; critical risk indicator for pricing governance."
    - name: "is_cost_change"
      expr: is_cost_change
      comment: "Flag indicating the price change was triggered by a cost change, for cost-pass-through analysis."
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events; measures pricing activity volume and operational throughput."
    - name: "avg_retail_price_change_pct"
      expr: AVG(CAST(retail_price_change_pct AS DOUBLE))
      comment: "Average percentage change in retail price; measures the typical magnitude of pricing adjustments."
    - name: "total_retail_price_change_amount"
      expr: SUM(CAST(retail_price_change_amount AS DOUBLE))
      comment: "Total dollar amount of retail price changes; quantifies the aggregate pricing movement across the assortment."
    - name: "avg_new_margin_pct"
      expr: AVG(CAST(new_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage after price change; measures post-change profitability."
    - name: "avg_prior_margin_pct"
      expr: AVG(CAST(prior_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage before price change; baseline for measuring margin impact of pricing actions."
    - name: "avg_new_retail_price"
      expr: AVG(CAST(new_retail_price AS DOUBLE))
      comment: "Average new retail price after change; tracks price level movement across the assortment."
    - name: "avg_prior_retail_price"
      expr: AVG(CAST(prior_retail_price AS DOUBLE))
      comment: "Average prior retail price before change; baseline for measuring price movement magnitude."
    - name: "count_margin_breach_changes"
      expr: COUNT(DISTINCT CASE WHEN is_margin_breach = TRUE THEN price_change_id END)
      comment: "Number of price changes that breached margin thresholds; key risk metric for pricing governance and compliance."
    - name: "count_competitive_response_changes"
      expr: COUNT(DISTINCT CASE WHEN trigger_signal = 'competitive' THEN price_change_id END)
      comment: "Number of price changes triggered by competitive signals; measures competitive pricing responsiveness."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average cost change percentage associated with price changes; measures cost-pass-through rate to retail prices."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown performance metrics covering clearance effectiveness, sell-through rates, and margin erosion from markdowns. Critical for inventory liquidation decisions and seasonal exit strategies."
  source: "`vibe_retail_v1`.`pricing`.`markdown`"
  dimensions:
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. clearance, promotional, competitive) for categorizing markdown actions."
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current status of the markdown (e.g. active, completed, cancelled) for pipeline management."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the markdown applies, enabling channel-specific markdown analysis."
    - name: "clearance_stage"
      expr: clearance_stage
      comment: "Stage of the clearance process (e.g. initial, secondary, final) for tracking clearance progression."
    - name: "reason_code"
      expr: reason_code
      comment: "Business reason for the markdown (e.g. slow-moving, seasonal, competitive) for root-cause analysis."
    - name: "disposition_method"
      expr: disposition_method
      comment: "How marked-down inventory will be disposed (e.g. sell-through, donate, liquidate) for exit strategy analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the markdown became effective, for seasonal and trend analysis of markdown activity."
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Flag indicating the markdown was triggered by competitive pricing pressure."
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating the markdown applies to dead stock inventory requiring urgent liquidation."
  measures:
    - name: "total_markdown_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of markdowns taken; primary measure of margin erosion from price reductions."
    - name: "avg_markdown_pct"
      expr: AVG(CAST(percent AS DOUBLE))
      comment: "Average markdown percentage applied; measures the typical depth of price reductions across the assortment."
    - name: "avg_sell_through_actual_pct"
      expr: AVG(CAST(sell_through_actual_pct AS DOUBLE))
      comment: "Average actual sell-through rate achieved under markdown; measures clearance effectiveness."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average targeted sell-through rate for markdowns; baseline for measuring clearance performance vs plan."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply remaining at markdown initiation; measures inventory urgency driving markdown decisions."
    - name: "avg_original_retail_price"
      expr: AVG(CAST(original_retail_price AS DOUBLE))
      comment: "Average original retail price before markdown; baseline for measuring markdown depth in dollar terms."
    - name: "avg_marked_down_price"
      expr: AVG(CAST(marked_down_price AS DOUBLE))
      comment: "Average price after markdown is applied; measures the effective selling price during clearance."
    - name: "count_active_markdowns"
      expr: COUNT(DISTINCT CASE WHEN markdown_status = 'active' THEN markdown_id END)
      comment: "Number of currently active markdowns; measures the breadth of active clearance activity."
    - name: "count_dead_stock_markdowns"
      expr: COUNT(DISTINCT CASE WHEN is_dead_stock = TRUE THEN markdown_id END)
      comment: "Number of markdowns on dead stock; critical inventory health metric indicating stranded capital."
    - name: "count_competitive_response_markdowns"
      expr: COUNT(DISTINCT CASE WHEN is_competitive_response = TRUE THEN markdown_id END)
      comment: "Number of markdowns driven by competitive pricing; measures competitive pricing pressure on the assortment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_competitive_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive price intelligence metrics measuring price gaps, index positioning, and competitive response effectiveness. Enables pricing teams and executives to monitor market competitiveness and response velocity."
  source: "`vibe_retail_v1`.`pricing`.`competitive_price`"
  dimensions:
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked for competitor-specific price gap analysis."
    - name: "competitor_channel"
      expr: competitor_channel
      comment: "Channel (e.g. store, online) where competitor price was observed for channel-parity analysis."
    - name: "category_code"
      expr: category_code
      comment: "Product category code for category-level competitive price positioning analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department code for department-level competitive benchmarking."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market where the competitive observation was made for regional price gap analysis."
    - name: "match_type"
      expr: match_type
      comment: "Type of product match (e.g. exact, equivalent, comparable) indicating confidence in the competitive comparison."
    - name: "price_gap_trend"
      expr: price_gap_trend
      comment: "Direction of price gap movement (e.g. widening, narrowing, stable) for trend-based competitive monitoring."
    - name: "response_status"
      expr: response_status
      comment: "Status of the competitive response action (e.g. pending, implemented, declined) for response tracking."
    - name: "observation_date"
      expr: DATE_TRUNC('month', observation_date)
      comment: "Month of competitive price observation for trend analysis of competitive positioning over time."
    - name: "competitor_promo_flag"
      expr: competitor_promo_flag
      comment: "Flag indicating the competitor price is a promotional price, for like-for-like price gap analysis."
    - name: "competitor_in_stock_flag"
      expr: competitor_in_stock_flag
      comment: "Flag indicating the competitor item was in stock at time of observation, for valid comparison filtering."
  measures:
    - name: "avg_price_gap"
      expr: AVG(CAST(price_gap AS DOUBLE))
      comment: "Average absolute price gap vs competitors; primary measure of price competitiveness in dollar terms."
    - name: "avg_price_gap_pct"
      expr: AVG(CAST(price_gap_pct AS DOUBLE))
      comment: "Average percentage price gap vs competitors; normalized measure of price competitiveness across price points."
    - name: "avg_price_index"
      expr: AVG(CAST(price_index AS DOUBLE))
      comment: "Average price index vs competitors (own price / competitor price); values above 1.0 indicate premium positioning."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average observed competitor price; market price benchmark for pricing decisions."
    - name: "avg_normalized_unit_price"
      expr: AVG(CAST(normalized_unit_price AS DOUBLE))
      comment: "Average normalized unit price for like-for-like comparison across different pack sizes."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of product matching; measures reliability of competitive price intelligence data."
    - name: "count_competitive_observations"
      expr: COUNT(1)
      comment: "Total number of competitive price observations; measures breadth and freshness of competitive intelligence coverage."
    - name: "count_price_disadvantaged_skus"
      expr: COUNT(DISTINCT CASE WHEN price_gap_pct > 0 THEN sku_id END)
      comment: "Number of distinct SKUs where own price exceeds competitor price; measures competitive price exposure breadth."
    - name: "count_responses_implemented"
      expr: COUNT(DISTINCT CASE WHEN response_status = 'implemented' THEN competitive_price_id END)
      comment: "Number of competitive price observations where a response was implemented; measures competitive response execution rate."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landed cost and cost structure metrics for SKUs across vendors and cost zones. Enables margin management, cost negotiation tracking, and duty/freight cost analysis for buyers and finance teams."
  source: "`vibe_retail_v1`.`pricing`.`cost_price`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost record (e.g. standard, actual, negotiated) for cost basis analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record (e.g. active, pending, expired) for filtering current vs historical costs."
    - name: "cost_change_reason"
      expr: cost_change_reason
      comment: "Business reason for the cost change (e.g. vendor negotiation, tariff, FX) for cost driver analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is sourced; key dimension for tariff and duty cost analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial term (e.g. FOB, CIF, DDP) governing cost responsibility allocation."
    - name: "cost_uom"
      expr: cost_uom
      comment: "Unit of measure for the cost record, enabling normalized cost comparisons."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the cost became effective, for trend analysis of cost movements over time."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating this is the current active cost record for the SKU-vendor combination."
  measures:
    - name: "avg_base_cost"
      expr: AVG(CAST(base_cost AS DOUBLE))
      comment: "Average base cost before duties and freight; baseline for measuring total landed cost build-up."
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average total landed cost including duties, freight, and handling; primary cost basis for margin calculations."
    - name: "avg_landed_cost_local"
      expr: AVG(CAST(landed_cost_local AS DOUBLE))
      comment: "Average landed cost in local currency; used for domestic margin calculations net of FX effects."
    - name: "avg_duty_amount"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per cost record; measures tariff burden on sourced products."
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_pct AS DOUBLE))
      comment: "Average duty rate percentage; key metric for tariff exposure analysis and sourcing decisions."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per cost record; measures logistics cost component of landed cost."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average percentage change in cost vs prior period; measures cost inflation/deflation trends from vendors."
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost across all cost records; aggregate cost exposure measure for portfolio analysis."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost records; measures FX exposure in the cost base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_margin_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Margin target planning metrics tracking gross margin goals, markdown budgets, and sell-through targets by category, channel, and season. Primary KPI surface for category management and financial planning."
  source: "`vibe_retail_v1`.`pricing`.`margin_target`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for which the margin target is set, enabling channel-specific margin planning."
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g. season, quarter, annual) for time-horizon analysis of margin targets."
    - name: "planning_period_label"
      expr: planning_period_label
      comment: "Label of the planning period (e.g. Spring 2025, Q1 FY26) for human-readable period identification."
    - name: "brand_classification"
      expr: brand_classification
      comment: "Brand tier classification (e.g. national, private label, exclusive) for brand-level margin analysis."
    - name: "target_status"
      expr: target_status
      comment: "Status of the margin target (e.g. draft, approved, locked) for planning workflow management."
    - name: "markdown_optimization_strategy"
      expr: markdown_optimization_strategy
      comment: "Strategy governing markdown optimization (e.g. sell-through, margin-floor) for strategy-level analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the margin target becomes effective, for planning cycle trend analysis."
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating the margin target is locked and cannot be modified, for plan finalization tracking."
  measures:
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average targeted gross margin percentage; primary profitability planning KPI for category and channel management."
    - name: "avg_minimum_margin_floor_pct"
      expr: AVG(CAST(minimum_margin_floor_pct AS DOUBLE))
      comment: "Average minimum margin floor percentage; measures the lowest acceptable margin threshold across the portfolio."
    - name: "avg_target_sell_through_rate_pct"
      expr: AVG(CAST(target_sell_through_rate_pct AS DOUBLE))
      comment: "Average targeted sell-through rate; measures planned inventory liquidation efficiency."
    - name: "total_markdown_budget_total"
      expr: SUM(CAST(markdown_budget_total AS DOUBLE))
      comment: "Total markdown budget allocated across all margin targets; measures total planned margin investment in markdowns."
    - name: "total_markdown_budget_consumed"
      expr: SUM(CAST(markdown_budget_consumed AS DOUBLE))
      comment: "Total markdown budget consumed to date; measures actual markdown spend against plan."
    - name: "total_markdown_budget_remaining"
      expr: SUM(CAST(markdown_budget_remaining AS DOUBLE))
      comment: "Total markdown budget remaining; measures available markdown capacity for the planning period."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average targeted GMROI (Gross Margin Return on Inventory Investment); key retail productivity metric linking margin to inventory turns."
    - name: "avg_private_label_margin_premium_pct"
      expr: AVG(CAST(private_label_margin_premium_pct AS DOUBLE))
      comment: "Average margin premium targeted for private label vs national brands; measures private label profitability strategy."
    - name: "avg_budget_utilization_pct"
      expr: AVG(CAST(budget_utilization_pct AS DOUBLE))
      comment: "Average markdown budget utilization percentage; measures how efficiently markdown budgets are being deployed."
    - name: "avg_target_weeks_of_supply"
      expr: AVG(CAST(target_weeks_of_supply AS DOUBLE))
      comment: "Average targeted weeks of supply; measures planned inventory efficiency aligned to margin targets."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price approval workflow metrics tracking approval velocity, escalation rates, and margin compliance. Enables pricing governance teams to monitor approval bottlenecks and policy adherence."
  source: "`vibe_retail_v1`.`pricing`.`price_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the price approval (e.g. pending, approved, rejected, escalated) for workflow pipeline analysis."
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval required (e.g. margin-breach, competitive-response, override) for categorizing approval workload."
    - name: "approval_tier"
      expr: approval_tier
      comment: "Organizational tier required to approve (e.g. manager, director, VP) for escalation analysis."
    - name: "approval_channel"
      expr: approval_channel
      comment: "Channel through which the approval was submitted (e.g. system, email, manual) for process efficiency analysis."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy associated with the approval request for strategy-level governance analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the approved price becomes effective, for approval activity trend analysis."
    - name: "is_auto_approved"
      expr: is_auto_approved
      comment: "Flag indicating the approval was granted automatically by system rules vs manual review."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Flag indicating the approval was escalated to a higher tier, measuring governance friction."
  measures:
    - name: "total_approval_requests"
      expr: COUNT(1)
      comment: "Total number of price approval requests; measures pricing governance workload volume."
    - name: "count_approved"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'approved' THEN price_approval_id END)
      comment: "Number of approved price requests; measures approval throughput in the pricing workflow."
    - name: "count_rejected"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'rejected' THEN price_approval_id END)
      comment: "Number of rejected price requests; measures pricing proposal quality and policy compliance."
    - name: "count_escalated"
      expr: COUNT(DISTINCT CASE WHEN is_escalated = TRUE THEN price_approval_id END)
      comment: "Number of escalated approvals; measures governance friction and exception volume in pricing decisions."
    - name: "count_auto_approved"
      expr: COUNT(DISTINCT CASE WHEN is_auto_approved = TRUE THEN price_approval_id END)
      comment: "Number of automatically approved price requests; measures automation effectiveness in pricing governance."
    - name: "avg_proposed_price"
      expr: AVG(CAST(proposed_price AS DOUBLE))
      comment: "Average proposed price in approval requests; measures the price level of changes going through governance."
    - name: "avg_current_price"
      expr: AVG(CAST(current_price AS DOUBLE))
      comment: "Average current price at time of approval request; baseline for measuring magnitude of proposed changes."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average percentage price change in approval requests; measures the typical magnitude of pricing proposals."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage at time of approval; measures margin health of prices going through governance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_sensitivity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price elasticity and demand sensitivity metrics enabling data-driven pricing optimization. Provides executives and pricing scientists with elasticity benchmarks, optimal price points, and revenue/profit maximization insights."
  source: "`vibe_retail_v1`.`pricing`.`price_sensitivity`"
  dimensions:
    - name: "elasticity_classification"
      expr: elasticity_classification
      comment: "Classification of price elasticity (e.g. elastic, inelastic, unit-elastic) for demand sensitivity segmentation."
    - name: "model_type"
      expr: model_type
      comment: "Type of elasticity model used (e.g. log-log, linear, semi-log) for model methodology analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel for which elasticity was estimated, enabling channel-specific pricing optimization."
    - name: "analysis_status"
      expr: analysis_status
      comment: "Status of the elasticity analysis (e.g. active, superseded, draft) for filtering current models."
    - name: "analysis_period_start_date"
      expr: DATE_TRUNC('month', analysis_period_start_date)
      comment: "Month the analysis period started, for tracking elasticity model vintage and recency."
  measures:
    - name: "avg_elasticity_coefficient"
      expr: AVG(CAST(elasticity_coefficient AS DOUBLE))
      comment: "Average price elasticity coefficient; core measure of demand sensitivity to price changes across the assortment."
    - name: "avg_cross_price_elasticity"
      expr: AVG(CAST(cross_price_elasticity AS DOUBLE))
      comment: "Average cross-price elasticity between SKUs; measures substitution and complementarity effects for portfolio pricing."
    - name: "avg_promotional_elasticity"
      expr: AVG(CAST(promotional_elasticity AS DOUBLE))
      comment: "Average promotional price elasticity; measures demand lift sensitivity to promotional price reductions."
    - name: "avg_optimal_price_point"
      expr: AVG(CAST(optimal_price_point AS DOUBLE))
      comment: "Average model-recommended optimal price point; primary output of price optimization for pricing decisions."
    - name: "avg_revenue_maximizing_price"
      expr: AVG(CAST(revenue_maximizing_price AS DOUBLE))
      comment: "Average revenue-maximizing price from elasticity models; enables revenue vs margin trade-off analysis."
    - name: "avg_profit_maximizing_price"
      expr: AVG(CAST(profit_maximizing_price AS DOUBLE))
      comment: "Average profit-maximizing price from elasticity models; primary input for margin-optimized pricing decisions."
    - name: "avg_markdown_sensitivity_score"
      expr: AVG(CAST(markdown_sensitivity_score AS DOUBLE))
      comment: "Average markdown sensitivity score; measures how responsive demand is to markdown depth for clearance planning."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of elasticity estimates; measures reliability of pricing model outputs."
    - name: "avg_r_squared"
      expr: AVG(CAST(r_squared AS DOUBLE))
      comment: "Average R-squared of elasticity models; measures goodness-of-fit and model quality for pricing science governance."
    - name: "avg_seasonality_adjustment_factor"
      expr: AVG(CAST(seasonality_adjustment_factor AS DOUBLE))
      comment: "Average seasonality adjustment factor applied to elasticity models; measures seasonal demand variation in pricing."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_audit_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing audit trail metrics for compliance, governance, and anomaly detection. Enables compliance officers and pricing governance teams to monitor override rates, margin breaches, and pricing policy adherence."
  source: "`vibe_retail_v1`.`pricing`.`price_audit_log`"
  dimensions:
    - name: "audit_action"
      expr: audit_action
      comment: "Type of audit action recorded (e.g. create, update, override, approve) for categorizing pricing events."
    - name: "audit_event_type"
      expr: audit_event_type
      comment: "Business event type that triggered the audit record for event-level compliance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit record (e.g. open, resolved, escalated) for compliance workflow management."
    - name: "actor_type"
      expr: actor_type
      comment: "Type of actor who performed the action (e.g. user, system, batch) for human vs automated change analysis."
    - name: "actor_role"
      expr: actor_role
      comment: "Business role of the actor performing the pricing action for role-based compliance analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the audited pricing action occurred for channel-specific compliance monitoring."
    - name: "pricing_strategy_type"
      expr: pricing_strategy_type
      comment: "Pricing strategy type associated with the audited action for strategy-level compliance analysis."
    - name: "event_timestamp"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the audit event for trend analysis of pricing activity and compliance over time."
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Flag indicating the audited action resulted in a margin breach; critical compliance risk indicator."
    - name: "is_override"
      expr: is_override
      comment: "Flag indicating the audited action was a manual price override; key governance metric."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Flag indicating the action was escalated for higher-level review; measures governance exception volume."
    - name: "is_auto_approved"
      expr: is_auto_approved
      comment: "Flag indicating the action was auto-approved by system rules vs manual review."
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of pricing audit events; measures overall pricing activity volume for compliance monitoring."
    - name: "count_margin_breach_events"
      expr: COUNT(DISTINCT CASE WHEN is_margin_breach = TRUE THEN price_audit_log_id END)
      comment: "Number of audit events involving margin breaches; primary compliance risk metric for pricing governance."
    - name: "count_override_events"
      expr: COUNT(DISTINCT CASE WHEN is_override = TRUE THEN price_audit_log_id END)
      comment: "Number of manual price override events; measures exception volume and potential policy circumvention."
    - name: "count_escalated_events"
      expr: COUNT(DISTINCT CASE WHEN is_escalated = TRUE THEN price_audit_log_id END)
      comment: "Number of escalated pricing events; measures governance friction and exception severity."
    - name: "avg_new_retail_price"
      expr: AVG(CAST(new_retail_price AS DOUBLE))
      comment: "Average new retail price recorded in audit events; tracks price level changes across audited actions."
    - name: "avg_price_change_amount"
      expr: AVG(CAST(price_change_amount AS DOUBLE))
      comment: "Average dollar amount of price changes in audit events; measures typical magnitude of audited pricing actions."
    - name: "avg_price_change_percent"
      expr: AVG(CAST(price_change_percent AS DOUBLE))
      comment: "Average percentage price change in audit events; normalized measure of pricing action magnitude."
    - name: "avg_margin_impact"
      expr: AVG(CAST(margin_impact AS DOUBLE))
      comment: "Average margin impact of audited pricing actions; measures the financial consequence of pricing decisions."
    - name: "avg_new_margin_percent"
      expr: AVG(CAST(new_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage after audited price changes; measures post-action profitability."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price override metrics tracking frequency, magnitude, and financial impact of manual price overrides at POS and in digital channels. Enables loss prevention, compliance, and pricing governance teams to monitor override risk."
  source: "`vibe_retail_v1`.`pricing`.`price_override`"
  dimensions:
    - name: "override_type"
      expr: override_type
      comment: "Type of price override (e.g. competitive match, customer accommodation, error correction) for categorizing override reasons."
    - name: "override_status"
      expr: override_status
      comment: "Status of the override (e.g. approved, pending, voided) for workflow and compliance monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the override for systematic analysis of override drivers."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the override occurred for channel-specific override risk analysis."
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating whether manager approval was required for this override level."
    - name: "exceeds_threshold"
      expr: exceeds_threshold
      comment: "Flag indicating the override exceeded the authorized threshold; key risk indicator for loss prevention."
    - name: "shrinkage_related"
      expr: shrinkage_related
      comment: "Flag indicating the override is associated with a shrinkage event; loss prevention risk metric."
    - name: "override_timestamp"
      expr: DATE_TRUNC('month', override_timestamp)
      comment: "Month of the override for trend analysis of override activity over time."
  measures:
    - name: "total_overrides"
      expr: COUNT(1)
      comment: "Total number of price overrides; primary volume metric for override activity monitoring."
    - name: "total_override_impact"
      expr: SUM(CAST(total_override_impact AS DOUBLE))
      comment: "Total financial impact of price overrides; measures aggregate revenue and margin loss from override activity."
    - name: "avg_override_amount"
      expr: AVG(CAST(override_amount AS DOUBLE))
      comment: "Average dollar amount of price overrides; measures typical override magnitude for threshold calibration."
    - name: "avg_override_percentage"
      expr: AVG(CAST(override_percentage AS DOUBLE))
      comment: "Average percentage price reduction from overrides; measures typical depth of override discounting."
    - name: "avg_original_price"
      expr: AVG(CAST(original_price AS DOUBLE))
      comment: "Average original price before override; baseline for measuring override depth in dollar terms."
    - name: "avg_override_price"
      expr: AVG(CAST(override_price AS DOUBLE))
      comment: "Average price after override is applied; measures the effective selling price resulting from overrides."
    - name: "count_threshold_exceeded_overrides"
      expr: COUNT(DISTINCT CASE WHEN exceeds_threshold = TRUE THEN price_override_id END)
      comment: "Number of overrides exceeding authorized thresholds; critical loss prevention and compliance metric."
    - name: "count_shrinkage_related_overrides"
      expr: COUNT(DISTINCT CASE WHEN shrinkage_related = TRUE THEN price_override_id END)
      comment: "Number of overrides flagged as shrinkage-related; measures potential fraudulent override activity."
    - name: "count_competitor_price_matches"
      expr: COUNT(DISTINCT CASE WHEN override_type = 'competitive_match' THEN price_override_id END)
      comment: "Number of overrides executed as competitive price matches; measures competitive response activity at POS."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing strategy configuration and target metrics enabling executives to monitor strategy coverage, margin targets, and competitive positioning goals across categories and channels."
  source: "`vibe_retail_v1`.`pricing`.`price_strategy`"
  dimensions:
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of pricing strategy (e.g. EDLP, Hi-Lo, competitive, value) for strategy portfolio analysis."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope of the strategy (e.g. all, store-only, ecommerce-only) for channel coverage analysis."
    - name: "price_strategy_status"
      expr: price_strategy_status
      comment: "Status of the pricing strategy (e.g. active, draft, archived) for strategy lifecycle management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the strategy applies to for annual planning cycle analysis."
    - name: "dynamic_pricing_enabled"
      expr: dynamic_pricing_enabled
      comment: "Flag indicating whether dynamic/algorithmic pricing is enabled under this strategy."
    - name: "map_enforcement_enabled"
      expr: map_enforcement_enabled
      comment: "Flag indicating whether MAP (Minimum Advertised Price) enforcement is active under this strategy."
    - name: "markdown_optimization_enabled"
      expr: markdown_optimization_enabled
      comment: "Flag indicating whether automated markdown optimization is enabled under this strategy."
    - name: "price_change_approval_required"
      expr: price_change_approval_required
      comment: "Flag indicating whether price changes under this strategy require explicit approval."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the pricing strategy became effective for strategy lifecycle trend analysis."
  measures:
    - name: "total_active_strategies"
      expr: COUNT(DISTINCT CASE WHEN price_strategy_status = 'active' THEN price_strategy_id END)
      comment: "Number of active pricing strategies; measures strategy portfolio breadth and governance complexity."
    - name: "avg_target_margin_min_pct"
      expr: AVG(CAST(target_margin_min_pct AS DOUBLE))
      comment: "Average minimum target margin percentage across strategies; measures the floor of margin ambition in pricing strategy."
    - name: "avg_target_margin_max_pct"
      expr: AVG(CAST(target_margin_max_pct AS DOUBLE))
      comment: "Average maximum target margin percentage across strategies; measures the ceiling of margin ambition in pricing strategy."
    - name: "avg_competitive_index_target"
      expr: AVG(CAST(competitive_index_target AS DOUBLE))
      comment: "Average targeted competitive price index; measures how aggressively strategies target competitive price parity."
    - name: "avg_sell_through_rate_target_pct"
      expr: AVG(CAST(sell_through_rate_target_pct AS DOUBLE))
      comment: "Average targeted sell-through rate across strategies; measures planned inventory efficiency goals."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average targeted GMROI across pricing strategies; measures the return on inventory investment ambition."
    - name: "avg_hilo_promo_depth_pct"
      expr: AVG(CAST(hilo_promo_depth_pct AS DOUBLE))
      comment: "Average Hi-Lo promotional depth percentage; measures the typical promotional discount depth planned under Hi-Lo strategies."
    - name: "count_dynamic_pricing_strategies"
      expr: COUNT(DISTINCT CASE WHEN dynamic_pricing_enabled = TRUE THEN price_strategy_id END)
      comment: "Number of strategies with dynamic pricing enabled; measures adoption of algorithmic pricing across the strategy portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price zone configuration and margin governance metrics. Enables pricing operations teams to monitor zone coverage, margin floors, and competitive zone designations across the store network."
  source: "`vibe_retail_v1`.`pricing`.`price_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of price zone (e.g. standard, competitive, ecommerce, outlet) for zone portfolio analysis."
    - name: "zone_status"
      expr: zone_status
      comment: "Status of the price zone (e.g. active, inactive, pending) for zone lifecycle management."
    - name: "market_tier"
      expr: market_tier
      comment: "Market tier classification (e.g. tier-1, tier-2, rural) for market-level pricing analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for regional price zone analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code for international price zone analysis."
    - name: "zone_hierarchy_level"
      expr: zone_hierarchy_level
      comment: "Hierarchical level of the zone (e.g. national, regional, local) for zone structure analysis."
    - name: "is_competitive_zone"
      expr: is_competitive_zone
      comment: "Flag indicating the zone is designated as a competitive pricing zone requiring active monitoring."
    - name: "is_ecommerce_enabled"
      expr: is_ecommerce_enabled
      comment: "Flag indicating the zone applies to ecommerce channel pricing."
    - name: "price_approval_required"
      expr: price_approval_required
      comment: "Flag indicating price changes in this zone require explicit approval."
    - name: "override_allowed"
      expr: override_allowed
      comment: "Flag indicating price overrides are permitted within this zone."
  measures:
    - name: "total_active_zones"
      expr: COUNT(DISTINCT CASE WHEN zone_status = 'active' THEN price_zone_id END)
      comment: "Number of active price zones; measures pricing zone portfolio breadth and operational complexity."
    - name: "avg_min_margin_pct"
      expr: AVG(CAST(min_margin_pct AS DOUBLE))
      comment: "Average minimum margin percentage floor across price zones; measures the margin protection level built into zone governance."
    - name: "avg_max_markdown_pct"
      expr: AVG(CAST(max_markdown_pct AS DOUBLE))
      comment: "Average maximum markdown percentage allowed per zone; measures the markdown depth ceiling across the zone portfolio."
    - name: "avg_competitive_index"
      expr: AVG(CAST(competitive_index AS DOUBLE))
      comment: "Average competitive price index across zones; measures overall price positioning vs competition by zone."
    - name: "avg_base_price_multiplier"
      expr: AVG(CAST(base_price_multiplier AS DOUBLE))
      comment: "Average base price multiplier applied in each zone; measures the price premium or discount applied relative to the base price list."
    - name: "count_competitive_zones"
      expr: COUNT(DISTINCT CASE WHEN is_competitive_zone = TRUE THEN price_zone_id END)
      comment: "Number of zones designated as competitive; measures the breadth of competitive pricing exposure across the store network."
    - name: "count_approval_required_zones"
      expr: COUNT(DISTINCT CASE WHEN price_approval_required = TRUE THEN price_zone_id END)
      comment: "Number of zones requiring price change approval; measures governance overhead in the zone portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_rule_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing rule application metrics tracking rule execution frequency, adjustment values, and override rates. Enables pricing operations teams to monitor rule effectiveness and identify rules requiring recalibration."
  source: "`vibe_retail_v1`.`pricing`.`rule_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Status of the rule application (e.g. applied, overridden, failed) for execution quality analysis."
    - name: "adjustment_method"
      expr: adjustment_method
      comment: "Method used to apply the adjustment (e.g. percentage, fixed-amount, formula) for rule mechanics analysis."
    - name: "override_permitted"
      expr: override_permitted
      comment: "Flag indicating whether the rule application can be overridden by a user."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Flag indicating whether this rule application can be stacked with other rules."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rule application became effective for trend analysis of rule activity."
  measures:
    - name: "total_rule_applications"
      expr: COUNT(1)
      comment: "Total number of pricing rule applications; measures rule engine execution volume and throughput."
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average adjustment value applied by pricing rules; measures the typical price impact of rule execution."
    - name: "total_adjustment_value"
      expr: SUM(CAST(adjustment_value AS DOUBLE))
      comment: "Total adjustment value applied across all rule applications; measures aggregate pricing impact of the rule engine."
    - name: "count_applied_rules"
      expr: COUNT(DISTINCT CASE WHEN application_status = 'applied' THEN rule_application_id END)
      comment: "Number of successfully applied rule applications; measures rule engine effectiveness and execution success rate."
    - name: "count_overridden_rules"
      expr: COUNT(DISTINCT CASE WHEN application_status = 'overridden' THEN rule_application_id END)
      comment: "Number of rule applications that were overridden; measures how often automated pricing rules are manually superseded."
    - name: "count_distinct_rules_applied"
      expr: COUNT(DISTINCT rule_id)
      comment: "Number of distinct pricing rules that have been applied; measures active rule portfolio utilization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price List business metrics"
  source: "`vibe_retail_v1`.`pricing`.`price_list`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Division Code"
      expr: division_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Default"
      expr: is_default
    - name: "Is Taxable"
      expr: is_taxable
    - name: "List Type"
      expr: list_type
    - name: "Loyalty Tier Code"
      expr: loyalty_tier_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price List"
      expr: COUNT(DISTINCT price_list_id)
    - name: "Total Base Margin Pct"
      expr: SUM(base_margin_pct)
    - name: "Average Base Margin Pct"
      expr: AVG(base_margin_pct)
    - name: "Total Competitive Index"
      expr: SUM(competitive_index)
    - name: "Average Competitive Index"
      expr: AVG(competitive_index)
    - name: "Total Markdown Pct"
      expr: SUM(markdown_pct)
    - name: "Average Markdown Pct"
      expr: AVG(markdown_pct)
    - name: "Total Max Selling Price"
      expr: SUM(max_selling_price)
    - name: "Average Max Selling Price"
      expr: AVG(max_selling_price)
    - name: "Total Min Selling Price"
      expr: SUM(min_selling_price)
    - name: "Average Min Selling Price"
      expr: AVG(min_selling_price)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rule business metrics"
  source: "`vibe_retail_v1`.`pricing`.`rule`"
  dimensions:
    - name: "Adjustment Method"
      expr: adjustment_method
    - name: "Algorithm Version"
      expr: algorithm_version
    - name: "Applicable Days Of Week"
      expr: applicable_days_of_week
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Mode"
      expr: execution_mode
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Loyalty Exclusive"
      expr: loyalty_exclusive
    - name: "Override Approval Required"
      expr: override_approval_required
    - name: "Override Permitted"
      expr: override_permitted
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rule"
      expr: COUNT(DISTINCT rule_id)
    - name: "Total Adjustment Value"
      expr: SUM(adjustment_value)
    - name: "Average Adjustment Value"
      expr: AVG(adjustment_value)
    - name: "Total Competitor Price Index"
      expr: SUM(competitor_price_index)
    - name: "Average Competitor Price Index"
      expr: AVG(competitor_price_index)
    - name: "Total Cost Plus Margin Pct"
      expr: SUM(cost_plus_margin_pct)
    - name: "Average Cost Plus Margin Pct"
      expr: AVG(cost_plus_margin_pct)
    - name: "Total Markdown Depth Pct"
      expr: SUM(markdown_depth_pct)
    - name: "Average Markdown Depth Pct"
      expr: AVG(markdown_depth_pct)
    - name: "Total Max Price"
      expr: SUM(max_price)
    - name: "Average Max Price"
      expr: AVG(max_price)
    - name: "Total Min Price"
      expr: SUM(min_price)
    - name: "Average Min Price"
      expr: AVG(min_price)
    - name: "Total Sell Through Target Pct"
      expr: SUM(sell_through_target_pct)
    - name: "Average Sell Through Target Pct"
      expr: AVG(sell_through_target_pct)
    - name: "Total Trigger Threshold Value"
      expr: SUM(trigger_threshold_value)
    - name: "Average Trigger Threshold Value"
      expr: AVG(trigger_threshold_value)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`pricing_zone_price_list_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zone Price List Assignment business metrics"
  source: "`vibe_retail_v1`.`pricing`.`zone_price_list_assignment`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Active"
      expr: is_active
    - name: "Override Rules"
      expr: override_rules
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Source System Code"
      expr: source_system_code
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
    - name: "Assigned Timestamp Month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Zone Price List Assignment"
      expr: COUNT(DISTINCT zone_price_list_assignment_id)
    - name: "Total Currency Conversion Rate"
      expr: SUM(currency_conversion_rate)
    - name: "Average Currency Conversion Rate"
      expr: AVG(currency_conversion_rate)
$$;