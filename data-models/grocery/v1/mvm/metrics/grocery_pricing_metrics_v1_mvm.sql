-- Metric views for domain: pricing | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_retail_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the retail price master. Tracks current shelf pricing health, margin posture, loyalty and multi-buy pricing coverage, and price optimisation adoption across SKUs and zones — core inputs for pricing strategy reviews and margin governance."
  source: "`grocery_ecm`.`pricing`.`retail_price`"
  dimensions:
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone identifier — enables zone-level pricing analysis and competitive benchmarking."
    - name: "price_status"
      expr: price_status
      comment: "Current lifecycle status of the retail price record (e.g. Active, Pending, Expired) — used to filter to live prices."
    - name: "price_tier"
      expr: price_tier
      comment: "Pricing tier classification (e.g. Premium, Value, Standard) — supports tier-level margin and revenue analysis."
    - name: "price_type_code"
      expr: price_type_code
      comment: "Type of price (e.g. Regular, Promotional, Clearance) — key segmentation for pricing mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the price is denominated — required for multi-currency reporting."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Indicates whether the SKU is eligible for SNAP/EBT — supports compliance and accessibility reporting."
    - name: "wic_eligible_flag"
      expr: wic_eligible_flag
      comment: "Indicates whether the SKU is WIC-eligible — supports regulatory and social-programme reporting."
    - name: "price_lock_flag"
      expr: price_lock_flag
      comment: "Indicates whether the price is locked and cannot be changed — flags items requiring manual governance review."
    - name: "price_optimization_flag"
      expr: price_optimization_flag
      comment: "Indicates whether algorithmic price optimisation is active for this SKU — tracks optimisation adoption."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the price became effective — enables trend analysis of price changes over time."
    - name: "category_id"
      expr: category_id
      comment: "Category identifier — supports category-level pricing strategy analysis."
    - name: "price_change_reason_code"
      expr: price_change_reason_code
      comment: "Reason code for the most recent price change — supports root-cause analysis of pricing movements."
  measures:
    - name: "active_sku_price_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with a retail price record — baseline coverage metric for pricing completeness."
    - name: "avg_srp_amount"
      expr: AVG(CAST(srp_amount AS DOUBLE))
      comment: "Average suggested retail price across all priced SKUs — tracks overall price level and inflation exposure."
    - name: "avg_margin_percentage"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage across priced SKUs — primary profitability health indicator for pricing decisions."
    - name: "avg_loyalty_member_price"
      expr: AVG(CAST(loyalty_member_price AS DOUBLE))
      comment: "Average loyalty member price — measures the depth of loyalty pricing investment and its gap to SRP."
    - name: "avg_competitor_price_reference"
      expr: AVG(CAST(competitor_price_reference AS DOUBLE))
      comment: "Average competitor reference price used in pricing decisions — tracks competitive price positioning."
    - name: "avg_minimum_advertised_price"
      expr: AVG(CAST(minimum_advertised_price AS DOUBLE))
      comment: "Average MAP across SKUs — monitors compliance floor and vendor agreement adherence."
    - name: "avg_multi_buy_price"
      expr: AVG(CAST(multi_buy_price AS DOUBLE))
      comment: "Average multi-buy promotional price — tracks bundle pricing strategy depth."
    - name: "price_optimisation_enabled_count"
      expr: COUNT(CASE WHEN price_optimization_flag = TRUE THEN retail_price_id END)
      comment: "Number of SKU prices with algorithmic optimisation enabled — measures optimisation adoption breadth."
    - name: "price_locked_count"
      expr: COUNT(CASE WHEN price_lock_flag = TRUE THEN retail_price_id END)
      comment: "Number of prices currently locked — flags governance exposure and manual override risk."
    - name: "snap_eligible_sku_count"
      expr: COUNT(DISTINCT CASE WHEN snap_eligible_flag = TRUE THEN sku_id END)
      comment: "Number of SNAP/EBT-eligible SKUs with active pricing — supports accessibility and compliance reporting."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over supplier cost pricing. Tracks landed cost structure, margin impact exposure, freight and allowance economics, and cost change governance — essential for buy-side margin management and vendor negotiation strategy."
  source: "`grocery_ecm`.`pricing`.`cost_price`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Classification of the cost record (e.g. Standard, Promotional, Contract) — enables cost-type segmentation."
    - name: "cost_category"
      expr: cost_category
      comment: "Business category of the cost (e.g. COGS, Freight, Allowance) — supports cost structure analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Lifecycle status of the cost record (e.g. Active, Pending, Expired) — filters to current cost basis."
    - name: "cost_change_approval_status"
      expr: cost_change_approval_status
      comment: "Approval workflow status for cost changes — tracks governance compliance and pending cost exposures."
    - name: "cost_change_reason"
      expr: cost_change_reason
      comment: "Reason for the cost change — supports root-cause analysis of cost inflation or deflation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost record — required for multi-currency cost normalisation."
    - name: "is_freight_included"
      expr: is_freight_included
      comment: "Whether freight is included in the cost — distinguishes ex-works from landed cost records."
    - name: "is_tax_included"
      expr: is_tax_included
      comment: "Whether tax is included in the cost — ensures correct gross-vs-net cost comparisons."
    - name: "margin_impact_flag"
      expr: margin_impact_flag
      comment: "Flags cost records with a material margin impact — prioritises cost changes requiring pricing action."
    - name: "price_optimization_flag"
      expr: price_optimization_flag
      comment: "Indicates whether this cost record feeds into price optimisation — tracks optimisation data coverage."
    - name: "cost_change_effective_date"
      expr: DATE_TRUNC('month', cost_change_effective_date)
      comment: "Month the cost change became effective — enables trend analysis of cost movements."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier — supports supplier-level cost benchmarking and negotiation analytics."
  measures:
    - name: "avg_base_cost"
      expr: AVG(CAST(base_cost AS DOUBLE))
      comment: "Average base cost per SKU-supplier record — primary buy-side cost benchmark for margin modelling."
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average fully-landed cost including freight and allowances — true cost basis for margin calculation."
    - name: "avg_total_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per record — comprehensive cost view used in P&L and pricing decisions."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all cost records — tracks logistics cost burden and inbound supply chain efficiency."
    - name: "total_allowance_cost"
      expr: SUM(CAST(allowance_cost AS DOUBLE))
      comment: "Total vendor allowance value — measures trade funding received and its contribution to margin."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to cost records — monitors FX exposure in the cost base."
    - name: "margin_impact_cost_record_count"
      expr: COUNT(CASE WHEN margin_impact_flag = TRUE THEN cost_price_id END)
      comment: "Number of cost records flagged as having a material margin impact — quantifies pricing action backlog."
    - name: "pending_approval_cost_count"
      expr: COUNT(CASE WHEN cost_change_approval_status = 'Pending' THEN cost_price_id END)
      comment: "Number of cost changes awaiting approval — tracks governance bottlenecks in cost change workflow."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active cost records — measures supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over price change events. Tracks the volume, magnitude, financial impact, and governance compliance of price changes — critical for pricing velocity, margin impact monitoring, and regulatory compliance oversight."
  source: "`grocery_ecm`.`pricing`.`price_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g. Cost-Driven, Competitive, Promotional) — segments change drivers for strategic analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Workflow approval status of the price change — tracks governance compliance and pending exposure."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Coded reason for the price change — enables root-cause analysis of pricing movements."
    - name: "channel"
      expr: channel
      comment: "Sales channel affected by the price change (e.g. In-Store, Online, Pickup) — supports omnichannel pricing analysis."
    - name: "price_optimization_flag"
      expr: price_optimization_flag
      comment: "Indicates whether the change was driven by algorithmic optimisation — measures optimisation-driven pricing activity."
    - name: "compliance_review_flag"
      expr: compliance_review_flag
      comment: "Flags price changes requiring compliance review — tracks regulatory risk exposure."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the price change took effect — enables trend analysis of pricing activity over time."
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone where the change applies — supports zone-level pricing velocity analysis."
    - name: "category_id"
      expr: category_id
      comment: "Category affected by the price change — enables category-level pricing strategy review."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Competitor whose pricing triggered this change — tracks competitive response patterns."
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events — baseline measure of pricing velocity and activity level."
    - name: "avg_price_change_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average absolute price change amount — measures the typical magnitude of pricing adjustments."
    - name: "avg_price_change_percent"
      expr: AVG(CAST(percent AS DOUBLE))
      comment: "Average percentage price change — tracks the relative intensity of pricing movements."
    - name: "total_forecasted_revenue_impact"
      expr: SUM(CAST(forecasted_revenue_impact AS DOUBLE))
      comment: "Total forecasted revenue impact of all price changes — primary financial KPI for pricing decision governance."
    - name: "avg_margin_impact_percent"
      expr: AVG(CAST(margin_impact_percent AS DOUBLE))
      comment: "Average margin impact percentage per price change — tracks whether pricing moves improve or erode profitability."
    - name: "total_forecasted_volume_impact"
      expr: SUM(CAST(forecasted_volume_impact AS DOUBLE))
      comment: "Total forecasted unit volume impact of price changes — measures demand elasticity exposure in the pricing pipeline."
    - name: "avg_elasticity_coefficient"
      expr: AVG(CAST(elasticity_coefficient AS DOUBLE))
      comment: "Average price elasticity coefficient across change events — informs demand sensitivity and optimal pricing strategy."
    - name: "compliance_review_required_count"
      expr: COUNT(CASE WHEN compliance_review_flag = TRUE THEN price_change_id END)
      comment: "Number of price changes flagged for compliance review — tracks regulatory risk backlog."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN price_change_id END)
      comment: "Number of price changes awaiting approval — measures governance bottleneck and time-to-activation risk."
    - name: "optimisation_driven_change_count"
      expr: COUNT(CASE WHEN price_optimization_flag = TRUE THEN price_change_id END)
      comment: "Number of price changes driven by algorithmic optimisation — tracks AI/ML pricing adoption and impact."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_competitive_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over competitive price observations. Tracks price gap to competitors, observation confidence, and competitive positioning — essential for competitive pricing strategy, zone-level response decisions, and market share defence."
  source: "`grocery_ecm`.`pricing`.`competitive_price`"
  dimensions:
    - name: "competitor_name"
      expr: competitor_name
      comment: "Name of the competitor being benchmarked — primary segmentation for competitive price gap analysis."
    - name: "price_type"
      expr: price_type
      comment: "Type of competitive price observed (e.g. Regular, Promotional) — ensures like-for-like price comparisons."
    - name: "competitive_price_status"
      expr: competitive_price_status
      comment: "Status of the competitive price record (e.g. Active, Stale) — filters to current and reliable observations."
    - name: "observation_method"
      expr: observation_method
      comment: "Method used to observe the competitor price (e.g. Manual, Web Scrape, Third-Party) — tracks data quality by source."
    - name: "data_source"
      expr: data_source
      comment: "Source system or provider of the competitive price data — supports data lineage and quality governance."
    - name: "price_change_flag"
      expr: price_change_flag
      comment: "Indicates whether the competitor price changed since last observation — flags items requiring pricing response."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the observed competitive price — required for cross-market comparisons."
    - name: "observation_timestamp"
      expr: DATE_TRUNC('week', observation_timestamp)
      comment: "Week of the competitive price observation — enables freshness and trend analysis of competitive intelligence."
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone where the competitive observation applies — supports zone-level competitive response strategy."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the competitive observation — enables store-level competitive benchmarking."
  measures:
    - name: "total_competitive_observations"
      expr: COUNT(1)
      comment: "Total number of competitive price observations — measures competitive intelligence coverage and freshness."
    - name: "avg_price_gap"
      expr: AVG(CAST(price_gap AS DOUBLE))
      comment: "Average absolute price gap between our price and the competitor — primary competitive positioning KPI."
    - name: "avg_price_gap_percentage"
      expr: AVG(CAST(price_gap_percentage AS DOUBLE))
      comment: "Average percentage price gap to competitors — normalised competitive index for cross-category comparison."
    - name: "avg_observed_price"
      expr: AVG(CAST(observed_price AS DOUBLE))
      comment: "Average observed competitor price — baseline for competitive price benchmarking."
    - name: "avg_our_price"
      expr: AVG(CAST(our_price AS DOUBLE))
      comment: "Average our own price at time of competitive observation — paired with avg_observed_price for gap analysis."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of competitive price observations — tracks data quality of competitive intelligence."
    - name: "price_change_detected_count"
      expr: COUNT(CASE WHEN price_change_flag = TRUE THEN competitive_price_id END)
      comment: "Number of observations where a competitor price change was detected — quantifies competitive pricing activity requiring response."
    - name: "distinct_competitor_count"
      expr: COUNT(DISTINCT competitor_name)
      comment: "Number of distinct competitors monitored — measures competitive intelligence breadth and market coverage."
    - name: "distinct_sku_monitored_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with competitive price observations — tracks competitive monitoring coverage."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over markdown events. Tracks markdown depth, financial impact, clearance effectiveness, and vendor funding — critical for inventory clearance strategy, margin recovery, and promotional planning."
  source: "`grocery_ecm`.`pricing`.`markdown`"
  dimensions:
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (e.g. Clearance, Seasonal, Competitive) — primary segmentation for markdown strategy analysis."
    - name: "markdown_status"
      expr: markdown_status
      comment: "Lifecycle status of the markdown (e.g. Active, Cancelled, Completed) — filters to actionable markdown records."
    - name: "triggering_condition"
      expr: triggering_condition
      comment: "Business condition that triggered the markdown (e.g. Days on Shelf, Inventory Threshold) — supports rule effectiveness analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the markdown was system-generated or manually created — tracks automation adoption in markdown management."
    - name: "ad_circular_featured"
      expr: ad_circular_featured
      comment: "Whether the markdown was featured in an ad circular — measures marketing amplification of markdown events."
    - name: "pos_signage_required"
      expr: pos_signage_required
      comment: "Whether POS signage is required for this markdown — tracks operational execution requirements."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the markdown became effective — enables trend analysis of markdown activity over time."
    - name: "category_id"
      expr: category_id
      comment: "Category of the marked-down SKU — supports category-level clearance and margin analysis."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store where the markdown applies — enables store-level clearance performance analysis."
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone of the markdown — supports zone-level markdown strategy review."
  measures:
    - name: "total_markdown_events"
      expr: COUNT(1)
      comment: "Total number of markdown events — baseline measure of markdown activity volume."
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average markdown depth as a percentage — measures the typical discount intensity applied to clearance items."
    - name: "avg_markdown_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average absolute markdown amount per event — tracks the typical price reduction in dollar terms."
    - name: "total_actual_revenue_impact"
      expr: SUM(CAST(actual_revenue_impact AS DOUBLE))
      comment: "Total actual revenue impact of all markdowns — primary financial KPI for markdown programme evaluation."
    - name: "total_actual_margin_impact"
      expr: SUM(CAST(actual_margin_impact AS DOUBLE))
      comment: "Total actual margin impact of all markdowns — measures the true profitability cost of clearance activity."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Total estimated revenue impact at time of markdown planning — used to compare forecast vs actual performance."
    - name: "total_estimated_margin_impact"
      expr: SUM(CAST(estimated_margin_impact AS DOUBLE))
      comment: "Total estimated margin impact at planning — paired with actual for forecast accuracy assessment."
    - name: "avg_sell_through_rate_threshold"
      expr: AVG(CAST(sell_through_rate_threshold AS DOUBLE))
      comment: "Average sell-through rate threshold set for markdown triggers — benchmarks clearance target-setting rigour."
    - name: "automated_markdown_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN markdown_id END)
      comment: "Number of system-automated markdowns — tracks automation adoption and its share of total markdown activity."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_tpr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over Temporary Price Reductions (TPR). Tracks promotional discount depth, vendor funding, and TPR programme economics — essential for trade promotion ROI, vendor negotiation, and promotional pricing governance."
  source: "`grocery_ecm`.`pricing`.`tpr`"
  dimensions:
    - name: "tpr_status"
      expr: tpr_status
      comment: "Lifecycle status of the TPR (e.g. Active, Expired, Cancelled) — filters to current promotional pricing."
    - name: "price_type"
      expr: price_type
      comment: "Type of TPR price (e.g. Multi-Buy, Single Unit, BOGO) — segments promotional mechanics for effectiveness analysis."
    - name: "price_source"
      expr: price_source
      comment: "Source of the TPR price (e.g. Vendor-Funded, Internal) — tracks trade funding vs self-funded promotions."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the TPR is funded by the vendor — critical for trade promotion ROI and vendor deal analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the TPR — supports root-cause analysis of promotional pricing decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the TPR price — required for multi-currency promotional reporting."
    - name: "start_timestamp"
      expr: DATE_TRUNC('week', start_timestamp)
      comment: "Week the TPR started — enables weekly promotional cadence and seasonality analysis."
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone where the TPR applies — supports zone-level promotional strategy analysis."
    - name: "category_id"
      expr: category_id
      comment: "Category of the TPR SKU — enables category-level promotional depth and frequency analysis."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store where the TPR is active — supports store-level promotional performance analysis."
  measures:
    - name: "total_tpr_events"
      expr: COUNT(1)
      comment: "Total number of TPR events — baseline measure of promotional pricing activity volume."
    - name: "avg_tpr_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average TPR promotional price — tracks the typical promotional price point offered to shoppers."
    - name: "avg_regular_price"
      expr: AVG(CAST(regular_price AS DOUBLE))
      comment: "Average regular price for TPR items — baseline for calculating promotional discount depth."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average absolute discount amount per TPR — measures the typical dollar value of promotional investment."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average TPR discount percentage — primary KPI for promotional depth and trade investment intensity."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional discount investment across all TPR events — measures total trade spend and promotional cost."
    - name: "vendor_funded_tpr_count"
      expr: COUNT(CASE WHEN vendor_funded_flag = TRUE THEN tpr_id END)
      comment: "Number of vendor-funded TPR events — tracks trade funding coverage and vendor promotional partnership depth."
    - name: "distinct_sku_on_tpr_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs on TPR — measures promotional assortment breadth and coverage."
    - name: "distinct_supplier_on_tpr_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active TPR events — tracks vendor participation in promotional programmes."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_price_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over price override events at point of sale. Tracks override frequency, financial exposure, compliance risk, and associate behaviour — critical for shrink control, pricing integrity, and loss prevention governance."
  source: "`grocery_ecm`.`pricing`.`price_override`"
  dimensions:
    - name: "override_type"
      expr: override_type
      comment: "Type of price override (e.g. Manager Override, Competitive Match, Error Correction) — segments override drivers."
    - name: "price_override_status"
      expr: price_override_status
      comment: "Status of the override record (e.g. Approved, Pending, Rejected) — tracks governance compliance."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the override — enables root-cause analysis of pricing integrity exceptions."
    - name: "associate_role"
      expr: associate_role
      comment: "Role of the associate who performed the override — supports loss prevention and authorisation analysis."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Indicates whether the override was manually entered — distinguishes system-driven from human-initiated overrides."
    - name: "ftc_compliance_flag"
      expr: ftc_compliance_flag
      comment: "Indicates FTC compliance status of the override — tracks regulatory risk in pricing exceptions."
    - name: "shrink_indicator"
      expr: shrink_indicator
      comment: "Flags overrides associated with shrink events — critical for loss prevention and inventory integrity."
    - name: "override_timestamp"
      expr: DATE_TRUNC('week', override_timestamp)
      comment: "Week the override occurred — enables trend analysis of override frequency and seasonality."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store where the override occurred — enables store-level pricing integrity and loss prevention analysis."
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone of the override — supports zone-level override pattern analysis."
  measures:
    - name: "total_price_overrides"
      expr: COUNT(1)
      comment: "Total number of price override events — baseline measure of pricing exception frequency and integrity risk."
    - name: "total_price_difference"
      expr: SUM(CAST(price_difference AS DOUBLE))
      comment: "Total cumulative price difference from overrides — measures the total financial exposure from pricing exceptions."
    - name: "avg_price_difference"
      expr: AVG(CAST(price_difference AS DOUBLE))
      comment: "Average price difference per override event — tracks the typical magnitude of pricing exceptions."
    - name: "avg_override_price"
      expr: AVG(CAST(override_price AS DOUBLE))
      comment: "Average override price applied — benchmarks override pricing levels against standard retail prices."
    - name: "avg_original_price"
      expr: AVG(CAST(original_price AS DOUBLE))
      comment: "Average original price before override — paired with avg_override_price to quantify discount depth."
    - name: "manual_override_count"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN price_override_id END)
      comment: "Number of manually entered overrides — tracks human-initiated pricing exceptions requiring governance attention."
    - name: "shrink_related_override_count"
      expr: COUNT(CASE WHEN shrink_indicator = TRUE THEN price_override_id END)
      comment: "Number of overrides flagged as shrink-related — primary loss prevention KPI for pricing integrity."
    - name: "ftc_non_compliant_override_count"
      expr: COUNT(CASE WHEN ftc_compliance_flag = FALSE THEN price_override_id END)
      comment: "Number of overrides failing FTC compliance — tracks regulatory risk exposure in pricing exceptions."
    - name: "distinct_store_override_count"
      expr: COUNT(DISTINCT store_location_id)
      comment: "Number of distinct stores with price override activity — measures geographic spread of pricing exception risk."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_price_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over pricing rules and guardrails. Tracks rule coverage, margin floor and ceiling governance, competitive index caps, and GMROI thresholds — essential for pricing policy compliance and automated pricing governance."
  source: "`grocery_ecm`.`pricing`.`price_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of pricing rule (e.g. Margin Floor, Competitive Cap, Promotional) — segments rule portfolio by governance function."
    - name: "price_rule_status"
      expr: price_rule_status
      comment: "Lifecycle status of the rule (e.g. Active, Inactive, Draft) — filters to rules currently governing pricing decisions."
    - name: "is_system_rule"
      expr: is_system_rule
      comment: "Indicates whether the rule is system-generated or manually configured — tracks automation vs manual governance."
    - name: "priority"
      expr: priority
      comment: "Rule priority level — supports conflict resolution analysis and rule hierarchy governance."
    - name: "price_ending_convention"
      expr: price_ending_convention
      comment: "Price ending convention enforced by the rule (e.g. .99, .00) — tracks psychological pricing policy compliance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rule became effective — enables trend analysis of rule portfolio evolution."
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone governed by the rule — supports zone-level rule coverage analysis."
    - name: "category_id"
      expr: category_id
      comment: "Category governed by the rule — enables category-level pricing policy analysis."
  measures:
    - name: "active_rule_count"
      expr: COUNT(CASE WHEN price_rule_status = 'Active' THEN price_rule_id END)
      comment: "Number of currently active pricing rules — measures the breadth of automated pricing governance in place."
    - name: "avg_margin_floor_percent"
      expr: AVG(CAST(margin_floor_percent AS DOUBLE))
      comment: "Average margin floor percentage across active rules — tracks the minimum profitability guardrail enforced by pricing policy."
    - name: "avg_competitive_index_cap"
      expr: AVG(CAST(competitive_index_cap AS DOUBLE))
      comment: "Average competitive index cap across rules — measures how aggressively the business caps competitive price matching."
    - name: "avg_gmroi_threshold"
      expr: AVG(CAST(gmroi_threshold AS DOUBLE))
      comment: "Average GMROI threshold set in pricing rules — tracks the return-on-inventory investment floor enforced by pricing policy."
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average absolute price floor across rules — measures the minimum price guardrail protecting margin and brand equity."
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average absolute price ceiling across rules — tracks the maximum price cap enforced for consumer fairness and compliance."
    - name: "system_rule_count"
      expr: COUNT(CASE WHEN is_system_rule = TRUE THEN price_rule_id END)
      comment: "Number of system-generated pricing rules — measures the degree of algorithmic governance in the pricing framework."
    - name: "distinct_zone_rule_coverage"
      expr: COUNT(DISTINCT price_zone_id)
      comment: "Number of distinct price zones covered by rules — measures geographic completeness of pricing governance."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_channel_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over channel-specific pricing. Tracks price differentials across channels, override rates, and channel pricing governance — essential for omnichannel pricing consistency, margin management, and channel strategy decisions."
  source: "`grocery_ecm`.`pricing`.`channel_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel for which the price is set (e.g. In-Store, Online, Pickup, Delivery) — primary segmentation for omnichannel pricing analysis."
    - name: "price_status"
      expr: price_status
      comment: "Lifecycle status of the channel price (e.g. Active, Expired) — filters to currently effective channel prices."
    - name: "price_change_type"
      expr: price_change_type
      comment: "Type of price change that created this channel price record — segments channel pricing by change driver."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Business reason for the channel price — supports root-cause analysis of channel price differentiation."
    - name: "is_price_override"
      expr: is_price_override
      comment: "Indicates whether this channel price is an override of the standard price — tracks channel pricing exceptions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the channel price — required for multi-currency channel pricing analysis."
    - name: "price_source_system"
      expr: price_source_system
      comment: "Source system that generated the channel price — supports data lineage and pricing system governance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the channel price became effective — enables trend analysis of channel pricing changes."
    - name: "store_cluster_id"
      expr: store_cluster_id
      comment: "Store cluster for which the channel price applies — supports cluster-level channel pricing analysis."
  measures:
    - name: "total_channel_price_records"
      expr: COUNT(1)
      comment: "Total number of channel price records — baseline measure of channel pricing coverage."
    - name: "avg_channel_price"
      expr: AVG(CAST(channel_price AS DOUBLE))
      comment: "Average channel-specific price — tracks the typical price level offered per channel for competitive and margin analysis."
    - name: "avg_price_differential"
      expr: AVG(CAST(price_differential AS DOUBLE))
      comment: "Average price differential between channel price and base price — measures the degree of channel price differentiation."
    - name: "total_price_differential"
      expr: SUM(CAST(price_differential AS DOUBLE))
      comment: "Total cumulative price differential across all channel price records — measures the aggregate financial impact of channel pricing strategy."
    - name: "channel_price_override_count"
      expr: COUNT(CASE WHEN is_price_override = TRUE THEN channel_price_id END)
      comment: "Number of channel prices that are manual overrides — tracks channel pricing exception frequency and governance risk."
    - name: "distinct_channel_count"
      expr: COUNT(DISTINCT channel_type)
      comment: "Number of distinct channels with active pricing records — measures omnichannel pricing coverage breadth."
    - name: "distinct_sku_channel_priced_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with channel-specific pricing — tracks channel pricing assortment coverage."
$$;