-- Metric views for domain: pricing | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_sku_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU-level pricing metrics covering retail price positioning, margin health, markup performance, and competitive price gaps. Primary KPI layer for pricing analysts and merchandising leadership to evaluate price integrity and margin delivery across the assortment."
  source: "`retail_ecm`.`pricing`.`sku_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel (e.g. in-store, e-commerce, wholesale) enabling channel-specific price and margin analysis."
    - name: "price_type"
      expr: price_type
      comment: "Classification of the price record (e.g. regular, promotional, clearance) for segmented pricing performance review."
    - name: "approval_status"
      expr: approval_status
      comment: "Workflow approval state of the SKU price record, used to filter approved vs. pending prices in governance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the price is denominated, enabling multi-currency margin and price analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of price effectivity, enabling trend analysis of pricing changes over time."
    - name: "is_dynamic_pricing_enabled"
      expr: is_dynamic_pricing_enabled
      comment: "Flag indicating whether dynamic pricing is active for the SKU, used to compare dynamic vs. static pricing outcomes."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Flag indicating the price is locked and cannot be changed, used to identify constrained SKUs in pricing reviews."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason driving the price change, enabling root-cause analysis of margin movements."
  measures:
    - name: "total_sku_price_records"
      expr: COUNT(1)
      comment: "Total number of active SKU price records. Baseline volume metric for assortment pricing coverage."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail selling price across SKUs. Key indicator of price positioning and average selling price (ASP) trends."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage across SKU price records. Core profitability KPI used in margin health reviews and buyer scorecards."
    - name: "avg_initial_markup_pct"
      expr: AVG(CAST(initial_markup_pct AS DOUBLE))
      comment: "Average initial markup percentage at time of price setting. Measures pricing aggressiveness and headroom for markdowns."
    - name: "avg_markdown_pct"
      expr: AVG(CAST(markdown_pct AS DOUBLE))
      comment: "Average markdown percentage applied to SKU prices. Tracks promotional depth and clearance intensity across the assortment."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total dollar value of markdowns applied. Critical financial KPI for markdown budget tracking and profitability impact assessment."
    - name: "avg_competitive_price_ref"
      expr: AVG(CAST(competitive_price_ref AS DOUBLE))
      comment: "Average competitor reference price for benchmarked SKUs. Used to assess competitive price positioning and index."
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average price ceiling across SKUs. Indicates the upper bound of pricing authority and headroom above current retail."
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average price floor across SKUs. Indicates the minimum allowable price, critical for margin protection governance."
    - name: "avg_channel_price_variance"
      expr: AVG(CAST(channel_price_variance AS DOUBLE))
      comment: "Average price variance across channels for the same SKU. Highlights channel pricing inconsistencies that may erode margin or customer trust."
    - name: "count_dynamic_pricing_skus"
      expr: COUNT(CASE WHEN is_dynamic_pricing_enabled = TRUE THEN 1 END)
      comment: "Number of SKUs with dynamic pricing enabled. Tracks adoption of algorithmic pricing across the assortment."
    - name: "count_price_locked_skus"
      expr: COUNT(CASE WHEN is_price_locked = TRUE THEN 1 END)
      comment: "Number of SKUs with locked prices. Identifies pricing rigidity that may prevent margin optimization responses."
    - name: "distinct_skus_priced"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with active price records. Measures pricing coverage breadth across the assortment."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor cost and landed cost metrics enabling cost management, duty and freight analysis, and cost change tracking. Used by merchants, finance, and supply chain teams to manage cost of goods and protect margin."
  source: "`retail_ecm`.`pricing`.`cost_price`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Classification of the cost record (e.g. standard, negotiated, promotional) for segmented cost analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Approval and lifecycle status of the cost record, used to filter active vs. pending costs in financial reporting."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the cost record, enabling multi-currency cost and exchange rate impact analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product was manufactured. Used to analyze cost and duty exposure by sourcing geography."
    - name: "incoterm"
      expr: incoterm
      comment: "International trade term governing cost and risk transfer. Drives freight and duty cost allocation analysis."
    - name: "is_current"
      expr: is_current
      comment: "Flag indicating whether this is the current active cost record for the SKU-vendor combination."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of cost effectivity, enabling trend analysis of cost changes over time."
    - name: "cost_change_reason"
      expr: cost_change_reason
      comment: "Business reason for the cost change, enabling root-cause analysis of cost inflation or deflation events."
  measures:
    - name: "avg_base_cost"
      expr: AVG(CAST(base_cost AS DOUBLE))
      comment: "Average base cost per SKU-vendor record. Baseline cost KPI for vendor negotiation benchmarking and cost trend analysis."
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average fully landed cost including freight, duty, and handling. The true cost of goods used in margin calculations and sourcing decisions."
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost across all cost records. Aggregate cost exposure metric used in financial planning and budget variance analysis."
    - name: "avg_duty_amount"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per cost record. Tracks tariff and import duty burden, critical for sourcing strategy and trade compliance decisions."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per cost record. Measures logistics cost component of landed cost, used in supply chain cost optimization."
    - name: "avg_handling_cost"
      expr: AVG(CAST(handling_cost AS DOUBLE))
      comment: "Average handling cost per cost record. Tracks warehouse and distribution handling expense as a component of total landed cost."
    - name: "avg_duty_rate_pct"
      expr: AVG(CAST(duty_rate_pct AS DOUBLE))
      comment: "Average duty rate percentage. Used to assess tariff exposure by country of origin and inform sourcing diversification decisions."
    - name: "avg_cost_change_pct"
      expr: AVG(CAST(cost_change_pct AS DOUBLE))
      comment: "Average cost change percentage across records. Key signal for cost inflation trends that require pricing or margin response."
    - name: "avg_landed_cost_vs_prior"
      expr: AVG(CAST(landed_cost AS DOUBLE) - CAST(prior_landed_cost AS DOUBLE))
      comment: "Average change in landed cost versus prior period. Directly measures cost inflation or deflation impact on margin per SKU."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost records. Used to monitor FX exposure and its impact on imported goods cost."
    - name: "distinct_vendors_with_costs"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active cost records. Measures vendor base breadth and concentration risk in sourcing."
    - name: "distinct_skus_costed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with cost records. Measures cost data coverage across the product assortment."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change event metrics tracking the frequency, magnitude, and margin impact of retail price adjustments. Used by pricing managers and finance to govern price change velocity, detect margin breaches, and evaluate competitive responsiveness."
  source: "`retail_ecm`.`pricing`.`price_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change event (e.g. regular, promotional, competitive response) for segmented change analysis."
    - name: "change_category"
      expr: change_category
      comment: "Business category of the price change (e.g. cost-driven, competitive, strategic) enabling root-cause classification."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the price change applies, enabling channel-specific pricing velocity and margin impact analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the price change, used to track governance compliance and pending change backlog."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy driving the change (e.g. EDLP, Hi-Lo, competitive match), enabling strategy-level performance comparison."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the price change, enabling structured root-cause analysis of price movement drivers."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the price change became effective, enabling trend analysis of pricing activity over time."
    - name: "is_margin_breach"
      expr: is_margin_breach
      comment: "Flag indicating the price change resulted in a margin floor breach. Critical governance dimension for margin protection reviews."
    - name: "is_cost_change"
      expr: is_cost_change
      comment: "Flag indicating the price change was triggered by a cost change, enabling cost-pass-through analysis."
    - name: "trigger_signal"
      expr: trigger_signal
      comment: "Signal that triggered the price change (e.g. competitor price drop, cost increase, demand signal) for causal analysis."
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events. Baseline metric for pricing velocity and change management workload."
    - name: "avg_retail_price_change_pct"
      expr: AVG(CAST(retail_price_change_pct AS DOUBLE))
      comment: "Average percentage change in retail price per event. Measures the typical magnitude of price adjustments across the assortment."
    - name: "avg_retail_price_change_amount"
      expr: AVG(CAST(retail_price_change_amount AS DOUBLE))
      comment: "Average absolute dollar change in retail price per event. Complements the percentage measure for absolute price impact assessment."
    - name: "avg_new_margin_pct"
      expr: AVG(CAST(new_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage after the price change. Tracks post-change margin health across all pricing events."
    - name: "avg_prior_margin_pct"
      expr: AVG(CAST(prior_margin_pct AS DOUBLE))
      comment: "Average gross margin percentage before the price change. Baseline for measuring margin impact of pricing decisions."
    - name: "avg_margin_impact"
      expr: AVG(CAST(new_margin_pct AS DOUBLE) - CAST(prior_margin_pct AS DOUBLE))
      comment: "Average margin percentage point change per price change event. Direct measure of whether pricing decisions are improving or eroding margin."
    - name: "count_margin_breach_events"
      expr: COUNT(CASE WHEN is_margin_breach = TRUE THEN 1 END)
      comment: "Number of price change events that resulted in a margin floor breach. Critical governance KPI for pricing compliance and risk management."
    - name: "margin_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_margin_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of price changes that breached the margin floor. Executive KPI for pricing governance health — high rates signal systemic margin risk."
    - name: "count_competitive_response_changes"
      expr: COUNT(CASE WHEN is_cost_change = FALSE THEN 1 END)
      comment: "Number of price changes not driven by cost changes, approximating competitive or strategic responses. Measures competitive pricing agility."
    - name: "avg_competitive_reference_price"
      expr: AVG(CAST(competitive_reference_price AS DOUBLE))
      comment: "Average competitor reference price at time of price change. Used to assess how closely pricing tracks competitive benchmarks."
    - name: "distinct_skus_repriced"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that received a price change. Measures breadth of pricing activity and assortment repricing coverage."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown management metrics covering markdown depth, clearance performance, sell-through achievement, and budget utilization. Used by merchants, planners, and finance to manage inventory liquidation, margin impact, and clearance strategy effectiveness."
  source: "`retail_ecm`.`pricing`.`markdown`"
  dimensions:
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. promotional, clearance, competitive) enabling segmented markdown performance analysis."
    - name: "markdown_status"
      expr: markdown_status
      comment: "Current lifecycle status of the markdown event, used to filter active vs. completed markdowns in operational reviews."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the markdown applies, enabling channel-specific markdown depth and sell-through analysis."
    - name: "clearance_stage"
      expr: clearance_stage
      comment: "Stage of the clearance process (e.g. initial, final, last chance) for tracking clearance progression and exit timing."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the markdown (e.g. slow seller, end of season, competitive) enabling root-cause analysis of markdown drivers."
    - name: "is_competitive_response"
      expr: is_competitive_response
      comment: "Flag indicating the markdown was triggered by a competitive price action, used to measure competitive markdown exposure."
    - name: "is_dead_stock"
      expr: is_dead_stock
      comment: "Flag indicating the markdown is applied to dead stock inventory, used to track write-down risk and liquidation urgency."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the markdown became effective, enabling trend analysis of markdown activity and seasonality."
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method used to dispose of marked-down inventory (e.g. in-store sale, online, donation, destruction) for liquidation strategy analysis."
  measures:
    - name: "total_markdowns"
      expr: COUNT(1)
      comment: "Total number of markdown records. Baseline volume metric for markdown activity and clearance workload."
    - name: "avg_markdown_percent"
      expr: AVG(CAST(percent AS DOUBLE))
      comment: "Average markdown depth as a percentage of original retail price. Core KPI for measuring promotional and clearance aggressiveness."
    - name: "total_markdown_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of markdowns taken. Critical financial KPI for markdown budget tracking and P&L impact assessment."
    - name: "avg_original_retail_price"
      expr: AVG(CAST(original_retail_price AS DOUBLE))
      comment: "Average original retail price before markdown. Provides context for markdown depth and price positioning analysis."
    - name: "avg_marked_down_price"
      expr: AVG(CAST(marked_down_price AS DOUBLE))
      comment: "Average price after markdown is applied. Used to assess exit price levels and their adequacy for inventory liquidation."
    - name: "avg_sell_through_actual_pct"
      expr: AVG(CAST(sell_through_actual_pct AS DOUBLE))
      comment: "Average actual sell-through rate achieved on marked-down items. Key effectiveness KPI for clearance strategy — low rates signal need for deeper markdowns."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average targeted sell-through rate for markdown events. Baseline for measuring sell-through achievement vs. plan."
    - name: "avg_sell_through_gap"
      expr: AVG(CAST(sell_through_actual_pct AS DOUBLE) - CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average gap between actual and target sell-through rate. Negative values indicate underperforming clearance events requiring intervention."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply remaining on marked-down items. High values signal slow-moving inventory requiring more aggressive markdown action."
    - name: "count_dead_stock_markdowns"
      expr: COUNT(CASE WHEN is_dead_stock = TRUE THEN 1 END)
      comment: "Number of markdowns applied to dead stock. Tracks the scale of write-down risk and inventory health issues in the assortment."
    - name: "count_competitive_response_markdowns"
      expr: COUNT(CASE WHEN is_competitive_response = TRUE THEN 1 END)
      comment: "Number of markdowns triggered by competitive price actions. Measures competitive pricing pressure and reactive markdown exposure."
    - name: "distinct_skus_marked_down"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs receiving markdowns. Measures breadth of markdown activity and assortment health risk."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_margin_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Margin target planning and budget utilization metrics used by merchants, buyers, and finance to track margin goal-setting, markdown budget consumption, and sell-through planning. Enables variance analysis between planned and actual margin performance."
  source: "`retail_ecm`.`pricing`.`margin_target`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for which the margin target is set, enabling channel-specific margin planning and performance comparison."
    - name: "target_status"
      expr: target_status
      comment: "Lifecycle status of the margin target (e.g. draft, approved, locked), used to filter active targets in planning reviews."
    - name: "brand_classification"
      expr: brand_classification
      comment: "Brand tier classification (e.g. national, private label, exclusive) enabling margin target analysis by brand strategy."
    - name: "markdown_optimization_strategy"
      expr: markdown_optimization_strategy
      comment: "Strategy applied to optimize markdowns within the margin target (e.g. velocity-based, age-based), for strategy effectiveness comparison."
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating the margin target is locked and cannot be revised, used to identify finalized vs. in-flight plans."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the margin target period begins, enabling trend analysis of margin planning across financial periods."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the margin target, enabling multi-currency planning analysis."
  measures:
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average targeted gross margin percentage across all margin targets. Primary planning KPI for margin ambition and financial goal-setting."
    - name: "avg_minimum_margin_floor_pct"
      expr: AVG(CAST(minimum_margin_floor_pct AS DOUBLE))
      comment: "Average minimum margin floor percentage. Defines the lower bound of acceptable margin, critical for pricing governance and markdown approval thresholds."
    - name: "avg_cogs_rate_pct"
      expr: AVG(CAST(cogs_rate_pct AS DOUBLE))
      comment: "Average cost of goods sold rate percentage. Measures cost burden relative to revenue in the margin plan, informing vendor negotiation priorities."
    - name: "total_markdown_budget_total"
      expr: SUM(CAST(markdown_budget_total AS DOUBLE))
      comment: "Total markdown budget allocated across all margin targets. Aggregate financial commitment to markdown activity for budget governance."
    - name: "total_markdown_budget_consumed"
      expr: SUM(CAST(markdown_budget_consumed AS DOUBLE))
      comment: "Total markdown budget consumed to date. Tracks actual markdown spend against allocation for budget compliance monitoring."
    - name: "total_markdown_budget_remaining"
      expr: SUM(CAST(markdown_budget_remaining AS DOUBLE))
      comment: "Total markdown budget remaining. Indicates available markdown capacity for the remainder of the planning period."
    - name: "avg_markdown_budget_utilization_pct"
      expr: AVG(CAST(budget_utilization_pct AS DOUBLE))
      comment: "Average markdown budget utilization percentage. Measures how efficiently markdown budgets are being deployed — low utilization may signal missed clearance opportunities."
    - name: "avg_target_sell_through_rate_pct"
      expr: AVG(CAST(target_sell_through_rate_pct AS DOUBLE))
      comment: "Average targeted sell-through rate across margin plans. Baseline for measuring inventory liquidation ambition and clearance planning effectiveness."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target AS DOUBLE))
      comment: "Average Gross Margin Return on Inventory Investment (GMROI) target. Strategic KPI linking margin performance to inventory productivity for capital allocation decisions."
    - name: "avg_private_label_margin_premium_pct"
      expr: AVG(CAST(private_label_margin_premium_pct AS DOUBLE))
      comment: "Average margin premium targeted for private label products. Measures the strategic margin advantage of own-brand vs. national brand, informing assortment investment decisions."
    - name: "avg_target_weeks_of_supply"
      expr: AVG(CAST(target_weeks_of_supply AS DOUBLE))
      comment: "Average targeted weeks of supply in the margin plan. Links inventory planning to margin targets, used to balance stock levels with sell-through goals."
    - name: "distinct_categories_targeted"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of distinct categories with margin targets. Measures breadth of margin planning coverage across the merchandise hierarchy."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price override governance metrics tracking the frequency, magnitude, and financial impact of point-of-sale and manual price overrides. Used by loss prevention, store operations, and pricing governance teams to detect override abuse, measure financial exposure, and enforce pricing controls."
  source: "`retail_ecm`.`pricing`.`price_override`"
  dimensions:
    - name: "override_type"
      expr: override_type
      comment: "Type of price override (e.g. manager override, competitive match, loyalty discount) for segmented override analysis."
    - name: "override_status"
      expr: override_status
      comment: "Current status of the override (e.g. approved, voided, pending) for governance and compliance filtering."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the override occurred, enabling channel-specific override frequency and impact analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the override, enabling structured analysis of override drivers and policy compliance."
    - name: "approval_required"
      expr: approval_required
      comment: "Flag indicating whether the override required management approval, used to assess governance adherence."
    - name: "exceeds_threshold"
      expr: exceeds_threshold
      comment: "Flag indicating the override exceeded the authorized threshold, critical for loss prevention and pricing control monitoring."
    - name: "shrinkage_related"
      expr: shrinkage_related
      comment: "Flag indicating the override is related to shrinkage, used to separate legitimate overrides from potential loss events."
    - name: "override_timestamp"
      expr: DATE_TRUNC('month', override_timestamp)
      comment: "Month the override was applied, enabling trend analysis of override activity and seasonal patterns."
  measures:
    - name: "total_price_overrides"
      expr: COUNT(1)
      comment: "Total number of price override events. Baseline volume metric for override activity monitoring and loss prevention alerting."
    - name: "total_override_impact"
      expr: SUM(CAST(total_override_impact AS DOUBLE))
      comment: "Total financial impact of all price overrides. Critical KPI for quantifying revenue leakage and pricing control effectiveness."
    - name: "avg_override_amount"
      expr: AVG(CAST(override_amount AS DOUBLE))
      comment: "Average dollar amount of price overrides. Measures typical override magnitude for threshold calibration and anomaly detection."
    - name: "avg_override_percentage"
      expr: AVG(CAST(override_percentage AS DOUBLE))
      comment: "Average percentage discount applied via overrides. Tracks override depth to identify excessive discounting patterns."
    - name: "count_threshold_exceeded_overrides"
      expr: COUNT(CASE WHEN exceeds_threshold = TRUE THEN 1 END)
      comment: "Number of overrides that exceeded the authorized price override threshold. Key loss prevention KPI for identifying policy violations."
    - name: "threshold_exceeded_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceeds_threshold = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of overrides that exceeded the authorized threshold. Executive governance KPI — high rates indicate pricing control failures requiring intervention."
    - name: "count_shrinkage_related_overrides"
      expr: COUNT(CASE WHEN shrinkage_related = TRUE THEN 1 END)
      comment: "Number of overrides flagged as shrinkage-related. Used by loss prevention to quantify override-driven shrinkage exposure."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price cited in competitive match overrides. Used to validate competitive price matching legitimacy and market positioning."
    - name: "distinct_locations_with_overrides"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of distinct store locations generating price overrides. Identifies high-override locations for targeted governance intervention."
    - name: "distinct_skus_overridden"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs subject to price overrides. Measures breadth of override activity across the assortment."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price zone configuration and competitive positioning metrics used by pricing strategy and regional management teams to evaluate zone structure, competitive intensity, and margin floor governance across geographic pricing tiers."
  source: "`retail_ecm`.`pricing`.`price_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of price zone (e.g. national, regional, local) enabling zone-level pricing strategy analysis."
    - name: "zone_status"
      expr: zone_status
      comment: "Operational status of the price zone (e.g. active, inactive, under review) for filtering active zones in pricing governance."
    - name: "market_tier"
      expr: market_tier
      comment: "Market tier classification (e.g. tier 1, tier 2, rural) enabling pricing strategy differentiation analysis by market type."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied in the zone (e.g. EDLP, Hi-Lo, competitive) for strategy-level performance comparison."
    - name: "country_code"
      expr: country_code
      comment: "Country code for the price zone, enabling cross-country pricing structure and margin analysis."
    - name: "is_competitive_zone"
      expr: is_competitive_zone
      comment: "Flag indicating the zone is designated as a competitive pricing zone, used to compare competitive vs. standard zone performance."
    - name: "is_ecommerce_enabled"
      expr: is_ecommerce_enabled
      comment: "Flag indicating e-commerce pricing is enabled in the zone, used to analyze omnichannel pricing coverage."
    - name: "zone_hierarchy_level"
      expr: zone_hierarchy_level
      comment: "Hierarchical level of the zone in the pricing zone structure, enabling analysis by zone granularity."
  measures:
    - name: "total_price_zones"
      expr: COUNT(1)
      comment: "Total number of price zones. Baseline metric for pricing zone structure complexity and geographic coverage."
    - name: "avg_base_price_multiplier"
      expr: AVG(CAST(base_price_multiplier AS DOUBLE))
      comment: "Average base price multiplier across zones. Measures the typical price premium or discount applied by zone relative to the base price list."
    - name: "avg_competitive_index"
      expr: AVG(CAST(competitive_index AS DOUBLE))
      comment: "Average competitive price index across zones. Tracks how zone prices compare to competitive benchmarks — values above 1.0 indicate price premium positioning."
    - name: "avg_min_margin_pct"
      expr: AVG(CAST(min_margin_pct AS DOUBLE))
      comment: "Average minimum margin percentage floor across price zones. Measures the margin protection level built into zone pricing governance."
    - name: "avg_max_markdown_pct"
      expr: AVG(CAST(max_markdown_pct AS DOUBLE))
      comment: "Average maximum markdown percentage permitted in each zone. Tracks markdown authority limits and their variation across the zone structure."
    - name: "count_competitive_zones"
      expr: COUNT(CASE WHEN is_competitive_zone = TRUE THEN 1 END)
      comment: "Number of zones designated as competitive pricing zones. Measures the scale of competitive pricing exposure across the store network."
    - name: "count_ecommerce_enabled_zones"
      expr: COUNT(CASE WHEN is_ecommerce_enabled = TRUE THEN 1 END)
      comment: "Number of zones with e-commerce pricing enabled. Tracks omnichannel pricing coverage and digital pricing strategy deployment."
    - name: "count_override_allowed_zones"
      expr: COUNT(CASE WHEN override_allowed = TRUE THEN 1 END)
      comment: "Number of zones where price overrides are permitted. Measures the scope of override authority granted across the zone structure."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing rule configuration and governance metrics used by pricing architects and category managers to evaluate rule coverage, markdown authority, margin protection settings, and rule complexity across the pricing engine."
  source: "`retail_ecm`.`pricing`.`rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of pricing rule (e.g. cost-plus, competitive, promotional, loyalty) enabling rule portfolio analysis by strategy type."
    - name: "rule_status"
      expr: rule_status
      comment: "Operational status of the rule (e.g. active, inactive, pending approval) for filtering the active rule set."
    - name: "channel"
      expr: channel
      comment: "Sales channel the rule applies to, enabling channel-specific rule coverage and conflict analysis."
    - name: "adjustment_method"
      expr: adjustment_method
      comment: "Method used to calculate the price adjustment (e.g. fixed amount, percentage, index) for rule mechanics analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "Event or condition that triggers the rule (e.g. cost change, competitor price, demand signal) for rule activation analysis."
    - name: "execution_mode"
      expr: execution_mode
      comment: "Mode of rule execution (e.g. automatic, manual, approval-required) for governance and automation coverage analysis."
    - name: "stackable"
      expr: stackable
      comment: "Flag indicating whether the rule can be combined with other rules, used to analyze promotional stacking risk and margin exposure."
    - name: "loyalty_exclusive"
      expr: loyalty_exclusive
      comment: "Flag indicating the rule applies exclusively to loyalty members, enabling loyalty pricing strategy analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rule became effective, enabling trend analysis of rule deployment and pricing strategy evolution."
  measures:
    - name: "total_pricing_rules"
      expr: COUNT(1)
      comment: "Total number of pricing rules. Baseline metric for pricing engine complexity and rule governance workload."
    - name: "avg_cost_plus_margin_pct"
      expr: AVG(CAST(cost_plus_margin_pct AS DOUBLE))
      comment: "Average cost-plus margin percentage across cost-plus pricing rules. Measures the margin target embedded in cost-based pricing rules."
    - name: "avg_markdown_depth_pct"
      expr: AVG(CAST(markdown_depth_pct AS DOUBLE))
      comment: "Average markdown depth percentage authorized by pricing rules. Tracks the typical markdown authority granted and its margin implications."
    - name: "avg_competitor_price_index"
      expr: AVG(CAST(competitor_price_index AS DOUBLE))
      comment: "Average competitor price index target in competitive pricing rules. Measures how aggressively rules are set to match or undercut competition."
    - name: "avg_sell_through_target_pct"
      expr: AVG(CAST(sell_through_target_pct AS DOUBLE))
      comment: "Average sell-through target percentage embedded in pricing rules. Links pricing rule design to inventory liquidation goals."
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average price adjustment value across all rules. Measures the typical magnitude of rule-driven price changes."
    - name: "count_stackable_rules"
      expr: COUNT(CASE WHEN stackable = TRUE THEN 1 END)
      comment: "Number of rules that can be stacked with other rules. High counts indicate promotional stacking risk and potential for unintended deep discounting."
    - name: "count_loyalty_exclusive_rules"
      expr: COUNT(CASE WHEN loyalty_exclusive = TRUE THEN 1 END)
      comment: "Number of rules exclusively available to loyalty members. Measures the scale of loyalty-differentiated pricing as a retention and engagement lever."
    - name: "count_override_approval_required_rules"
      expr: COUNT(CASE WHEN override_approval_required = TRUE THEN 1 END)
      comment: "Number of rules requiring approval before override. Measures the governance rigor built into the pricing rule framework."
    - name: "distinct_categories_covered"
      expr: COUNT(DISTINCT category_id)
      comment: "Number of distinct categories covered by pricing rules. Measures the breadth of rule-based pricing governance across the merchandise hierarchy."
$$;