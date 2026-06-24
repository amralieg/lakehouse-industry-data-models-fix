-- Metric views for domain: product | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the product Bill of Materials header — tracks BOM portfolio health, cost baselines, sustainability posture, and configurability across model years, nameplates, and powertrain types. Used by Product Engineering, Finance, and Program Management to steer BOM governance and cost targets."
  source: "`vibe_automotive_v1`.`product`.`bom_header`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the BOM, used to trend cost and weight evolution across annual product cycles."
    - name: "nameplate_code"
      expr: nameplate_code
      comment: "Vehicle nameplate (e.g., brand/model line) for cross-nameplate BOM comparison."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain category (ICE, BEV, PHEV, HEV) enabling electrification cost and weight analysis."
    - name: "bom_type"
      expr: bom_type
      comment: "BOM type classification (engineering, manufacturing, sales) for lifecycle stage analysis."
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (draft, released, obsolete) for governance tracking."
    - name: "market_region"
      expr: market_region
      comment: "Target market region for regional cost and compliance analysis."
    - name: "emissions_standard"
      expr: emissions_standard
      comment: "Emissions standard the BOM is designed to meet (Euro 6, CARB, etc.) for regulatory portfolio view."
    - name: "homologation_status"
      expr: homologation_status
      comment: "Homologation approval status, critical for launch readiness tracking."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Whether the BOM supports configurable variants, relevant for order-to-delivery complexity analysis."
    - name: "online_configurator_linked_flag"
      expr: online_configurator_linked_flag
      comment: "Indicates whether the BOM is linked to the online vehicle configurator, supporting digital sales channel readiness."
    - name: "bom_usage"
      expr: bom_usage
      comment: "BOM usage context (production, prototype, spare parts) for portfolio segmentation."
    - name: "safety_certification_level"
      expr: safety_certification_level
      comment: "Safety certification tier associated with the BOM for compliance portfolio analysis."
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of active BOM headers. Baseline measure for BOM portfolio size; executives use this to assess product complexity and governance workload."
    - name: "avg_standard_cost_amount"
      expr: AVG(CAST(standard_cost_amount AS DOUBLE))
      comment: "Average standard cost per BOM header. Directly informs cost target setting and variance analysis across nameplates and model years — a core Finance and Program Management KPI."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost across all BOM headers in scope. Used to assess aggregate cost exposure by powertrain type, region, or model year in portfolio reviews."
    - name: "avg_msrp_base_amount"
      expr: AVG(CAST(msrp_base_amount AS DOUBLE))
      comment: "Average MSRP base price across BOMs. Tracks pricing positioning by nameplate and powertrain; used in pricing strategy and competitive benchmarking."
    - name: "total_msrp_base_amount"
      expr: SUM(CAST(msrp_base_amount AS DOUBLE))
      comment: "Total MSRP base value across the BOM portfolio. Provides a revenue potential baseline for the product lineup in scope."
    - name: "avg_total_assembly_weight_kg"
      expr: AVG(CAST(total_assembly_weight_kg AS DOUBLE))
      comment: "Average vehicle assembly weight in kg. Critical for fuel economy, emissions compliance, and lightweighting program tracking — a key engineering and sustainability KPI."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across BOMs. Tracks ESG posture of the product portfolio; used in CSRD and EU Taxonomy reporting and executive sustainability dashboards."
    - name: "max_sustainability_score"
      expr: MAX(sustainability_score)
      comment: "Highest sustainability score in the portfolio. Identifies best-in-class BOM designs for benchmarking and sustainability target-setting."
    - name: "min_sustainability_score"
      expr: MIN(sustainability_score)
      comment: "Lowest sustainability score in the portfolio. Flags BOMs requiring sustainability improvement, driving prioritization of redesign efforts."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Number of BOMs that support configurable variants. Measures product flexibility and order-to-delivery complexity; high configurability drives supply chain and manufacturing complexity costs."
    - name: "online_configurator_linked_bom_count"
      expr: COUNT(CASE WHEN online_configurator_linked_flag = TRUE THEN 1 END)
      comment: "Number of BOMs linked to the online vehicle configurator. Tracks digital sales channel readiness — a strategic KPI for direct-to-consumer and e-commerce initiatives."
    - name: "released_bom_count"
      expr: COUNT(CASE WHEN bom_status = 'Released' THEN 1 END)
      comment: "Number of BOMs in Released status. Measures engineering release throughput and launch readiness; used in program milestone reviews."
    - name: "avg_cost_to_msrp_ratio"
      expr: AVG(standard_cost_amount / NULLIF(msrp_base_amount, 0))
      comment: "Average ratio of standard cost to MSRP base price. Approximates gross margin structure at the BOM level; a key profitability indicator for product line management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component-level BOM analytics — tracks part usage, quantity patterns, optional vs. critical component mix, and scrap rates across the product BOM. Used by Engineering, Supply Chain, and Finance to manage BOM complexity, cost, and quality."
  source: "`vibe_automotive_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BOM line item (raw material, purchased part, assembly, etc.) for cost and sourcing segmentation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the component quantity, used for material planning and procurement analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags safety-critical or program-critical components, enabling risk-focused supply chain monitoring."
    - name: "is_optional_flag"
      expr: is_optional_flag
      comment: "Indicates whether the component is optional (e.g., an option package part), used to separate base vs. optional content cost."
    - name: "option_code"
      expr: option_code
      comment: "Option code associated with the BOM line, enabling option-level cost and availability analysis."
  measures:
    - name: "total_bom_line_count"
      expr: COUNT(1)
      comment: "Total number of BOM lines. Baseline measure for BOM complexity; high line counts drive procurement, manufacturing, and quality management costs."
    - name: "avg_component_quantity"
      expr: AVG(CAST(component_quantity AS DOUBLE))
      comment: "Average quantity per BOM line. Used in material requirements planning and to identify outlier usage rates that may indicate BOM errors."
    - name: "total_component_quantity"
      expr: SUM(CAST(component_quantity AS DOUBLE))
      comment: "Total component quantity across all BOM lines in scope. Supports aggregate material demand forecasting."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average quantity per assembly across BOM lines. Key input for production planning and cost rollup calculations."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM lines. Directly impacts material cost and sustainability; high scrap rates trigger engineering and process improvement actions."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical BOM lines. Measures supply chain risk exposure; executives use this to prioritize dual-sourcing and safety stock decisions."
    - name: "optional_component_count"
      expr: COUNT(CASE WHEN is_optional_flag = TRUE THEN 1 END)
      comment: "Number of optional BOM lines. Tracks option content complexity, which drives configurator and manufacturing variant management costs."
    - name: "distinct_part_count"
      expr: COUNT(DISTINCT part_number)
      comment: "Number of distinct part numbers in the BOM. Measures parts proliferation — a key driver of procurement, inventory, and quality management costs."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all BOM lines. Supports aggregate material volume analysis for procurement negotiations and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_catalog_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product catalog publication performance and governance metrics — tracks publication cycle times, distribution success rates, regulatory filing compliance, and digital channel readiness. Used by Product Marketing, Compliance, and Digital teams to manage catalog operations and regulatory obligations."
  source: "`vibe_automotive_v1`.`product`.`catalog_publication`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Current status of the catalog publication (draft, approved, distributed, recalled) for pipeline monitoring."
    - name: "publication_type"
      expr: publication_type
      comment: "Type of catalog publication (full catalog, supplement, recall notice) for workload and compliance analysis."
    - name: "publication_format"
      expr: publication_format
      comment: "Format of the publication (PDF, XML, API feed) for channel and distribution analysis."
    - name: "target_channel"
      expr: target_channel
      comment: "Distribution channel (dealer, consumer, regulatory body) for channel-specific performance tracking."
    - name: "target_region"
      expr: target_region
      comment: "Target geographic region for regional catalog coverage and compliance analysis."
    - name: "target_country_code"
      expr: target_country_code
      comment: "Target country for country-level regulatory filing and distribution tracking."
    - name: "model_year"
      expr: model_year
      comment: "Model year covered by the publication for annual product cycle analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the catalog publication for localization coverage analysis."
    - name: "digital_storefront_flag"
      expr: digital_storefront_flag
      comment: "Indicates whether the publication is linked to a digital storefront, tracking e-commerce catalog readiness."
    - name: "regulatory_filing_required_flag"
      expr: regulatory_filing_required_flag
      comment: "Flags publications requiring regulatory filing, enabling compliance workload prioritization."
    - name: "esg_disclosure_included_flag"
      expr: esg_disclosure_included_flag
      comment: "Indicates whether ESG disclosures are included in the publication, supporting CSRD and sustainability reporting compliance."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the publication (passed, failed, warnings) for quality gate monitoring."
  measures:
    - name: "total_publication_count"
      expr: COUNT(1)
      comment: "Total number of catalog publications. Baseline measure for catalog operations volume and team workload."
    - name: "distributed_publication_count"
      expr: COUNT(CASE WHEN distribution_confirmation_flag = TRUE THEN 1 END)
      comment: "Number of publications successfully distributed. Measures catalog distribution effectiveness — a key operational KPI for product launch readiness."
    - name: "distribution_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN distribution_confirmation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of publications successfully distributed. Tracks catalog operations reliability; low rates indicate distribution infrastructure or data quality issues requiring intervention."
    - name: "regulatory_filing_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_filing_required_flag = TRUE AND regulatory_filing_reference IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_filing_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of publications requiring regulatory filing that have a filing reference recorded. Measures regulatory compliance posture — a mandatory KPI for legal and compliance teams."
    - name: "digital_storefront_publication_count"
      expr: COUNT(CASE WHEN digital_storefront_flag = TRUE THEN 1 END)
      comment: "Number of publications linked to digital storefronts. Tracks e-commerce catalog coverage — a strategic KPI for online/direct-to-consumer sales channel development."
    - name: "esg_disclosure_publication_count"
      expr: COUNT(CASE WHEN esg_disclosure_included_flag = TRUE THEN 1 END)
      comment: "Number of publications including ESG disclosures. Measures ESG transparency compliance across the product catalog — increasingly mandatory under CSRD."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size of catalog publications in bytes. Monitors catalog data volume trends; large files may indicate distribution performance issues."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all catalog publications. Tracks storage and distribution infrastructure requirements for catalog operations planning."
    - name: "recalled_publication_count"
      expr: COUNT(CASE WHEN recall_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of publications that have been recalled. A quality and compliance risk indicator — recalled publications may expose the company to regulatory or customer-facing errors."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_catalog_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog version lifecycle and governance metrics — tracks version approval rates, e-commerce readiness, currency coverage, and catalog evolution velocity. Used by Product Management and Digital teams to govern the product catalog lifecycle."
  source: "`vibe_automotive_v1`.`product`.`catalog_version`"
  dimensions:
    - name: "catalog_type"
      expr: catalog_type
      comment: "Type of catalog (consumer, dealer, regulatory) for portfolio segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the catalog version (pending, approved, rejected) for governance pipeline monitoring."
    - name: "catalog_version_status"
      expr: catalog_version_status
      comment: "Lifecycle status of the catalog version (active, superseded, archived) for version management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the catalog version for multi-currency pricing analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment targeted by the catalog version for segment-level coverage analysis."
    - name: "region_coverage"
      expr: region_coverage
      comment: "Geographic region coverage of the catalog version for regional completeness tracking."
    - name: "ecommerce_version_flag"
      expr: ecommerce_version_flag
      comment: "Indicates whether this catalog version is published to e-commerce channels, tracking digital sales readiness."
    - name: "is_current"
      expr: is_current
      comment: "Flags the currently active catalog version, used to isolate current-state metrics from historical analysis."
  measures:
    - name: "total_catalog_version_count"
      expr: COUNT(1)
      comment: "Total number of catalog versions. Baseline measure for catalog governance workload and version proliferation."
    - name: "approved_version_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved catalog versions. Measures catalog governance throughput — a key KPI for product launch readiness and time-to-market."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog versions that have been approved. Tracks governance efficiency; low approval rates indicate bottlenecks in the product release process."
    - name: "ecommerce_version_count"
      expr: COUNT(CASE WHEN ecommerce_version_flag = TRUE THEN 1 END)
      comment: "Number of catalog versions published to e-commerce channels. Tracks digital channel catalog coverage — a strategic KPI for online sales initiatives."
    - name: "current_version_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Number of currently active catalog versions. Should ideally be 1 per market/segment; multiple active versions indicate governance issues requiring resolution."
    - name: "avg_sku_structure_code"
      expr: AVG(CAST(sku_structure_code AS DOUBLE))
      comment: "Average SKU structure code value across catalog versions. Tracks SKU architecture evolution; significant changes signal product portfolio restructuring events."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product segment portfolio and strategic positioning metrics — tracks segment coverage, pricing range spread, market share targets, and electrification/connectivity readiness across the product portfolio. Used by Strategy, Product Planning, and Marketing leadership for portfolio steering."
  source: "`vibe_automotive_v1`.`product`.`product_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the product segment (e.g., compact SUV, full-size truck) for portfolio-level analysis."
    - name: "powertrain_category"
      expr: powertrain_category
      comment: "Powertrain category (ICE, BEV, PHEV) for electrification portfolio analysis."
    - name: "body_style_category"
      expr: body_style_category
      comment: "Body style category (sedan, SUV, pickup) for product portfolio segmentation."
    - name: "market_positioning_tier"
      expr: market_positioning_tier
      comment: "Market positioning tier (entry, mid, premium, luxury) for competitive and pricing strategy analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the segment (growth, mature, declining) for portfolio investment prioritization."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification for executive resource allocation decisions."
    - name: "adas_level_range"
      expr: adas_level_range
      comment: "ADAS capability range for the segment, tracking autonomous driving technology portfolio coverage."
    - name: "emissions_standard_target"
      expr: emissions_standard_target
      comment: "Target emissions standard for the segment, used in regulatory compliance portfolio planning."
    - name: "connectivity_capability"
      expr: connectivity_capability
      comment: "Whether the segment supports connected vehicle features, tracking digital product portfolio readiness."
    - name: "subscription_eligible_flag"
      expr: subscription_eligible_flag
      comment: "Indicates whether vehicles in this segment are eligible for subscription/mobility-as-a-service models — a strategic KPI for new revenue stream development."
    - name: "ota_update_capability"
      expr: ota_update_capability
      comment: "Whether the segment supports over-the-air software updates, a key differentiator in modern vehicle product strategy."
    - name: "esg_segment_classification"
      expr: esg_segment_classification
      comment: "ESG classification of the segment for sustainability portfolio reporting and EU Taxonomy alignment."
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment is currently active, used to filter current portfolio from historical analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the product segment hierarchy for drill-down analysis from portfolio to sub-segment."
  measures:
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of product segments. Baseline measure for portfolio breadth; executives use this to assess product line complexity and coverage."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active product segments. Tracks the live product portfolio size — a key input for resource allocation and go-to-market planning."
    - name: "avg_market_share_target_pct"
      expr: AVG(CAST(market_share_target_pct AS DOUBLE))
      comment: "Average market share target across segments. Tracks ambition level of the product portfolio; used in strategy reviews to assess competitiveness of market share goals."
    - name: "total_market_share_target_pct"
      expr: SUM(CAST(market_share_target_pct AS DOUBLE))
      comment: "Sum of market share targets across segments. Provides a portfolio-level view of total market share ambition for executive strategy alignment."
    - name: "avg_price_range_max_usd"
      expr: AVG(CAST(price_range_max_usd AS DOUBLE))
      comment: "Average upper price boundary across segments. Tracks the premium positioning of the portfolio; used in pricing strategy and competitive benchmarking."
    - name: "avg_price_range_min_usd"
      expr: AVG(CAST(price_range_min_usd AS DOUBLE))
      comment: "Average lower price boundary across segments. Tracks entry-level accessibility of the portfolio for volume and market penetration strategy."
    - name: "avg_price_range_spread_usd"
      expr: AVG(CAST(price_range_max_usd AS DOUBLE) - CAST(price_range_min_usd AS DOUBLE))
      comment: "Average price range spread (max minus min) per segment. Measures pricing flexibility and variant richness within each segment — wide spreads indicate high configurability and option content."
    - name: "subscription_eligible_segment_count"
      expr: COUNT(CASE WHEN subscription_eligible_flag = TRUE THEN 1 END)
      comment: "Number of segments eligible for subscription/mobility-as-a-service models. Tracks the addressable portfolio for new mobility revenue streams — a strategic KPI for vehicle-as-a-service initiatives."
    - name: "ota_capable_segment_count"
      expr: COUNT(CASE WHEN ota_update_capability = TRUE THEN 1 END)
      comment: "Number of segments with OTA update capability. Measures software-defined vehicle portfolio coverage — a key technology differentiation and recurring revenue enabler."
    - name: "connected_segment_count"
      expr: COUNT(CASE WHEN connectivity_capability = TRUE THEN 1 END)
      comment: "Number of segments with connected vehicle capability. Tracks digital product portfolio readiness for connected services revenue and data monetization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_package_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Option package availability and orderability metrics — tracks package launch readiness, market availability, and allocation status across dealerships and regions. Used by Product Marketing, Sales Operations, and Supply Chain to manage option package go-to-market execution."
  source: "`vibe_automotive_v1`.`product`.`package_availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the package (available, constrained, discontinued) for supply and demand alignment."
    - name: "market_region"
      expr: market_region
      comment: "Market region for the package availability record, enabling regional availability gap analysis."
    - name: "is_orderable"
      expr: is_orderable
      comment: "Whether the package is currently orderable, directly impacting sales order fulfillment and customer satisfaction."
    - name: "order_constraint"
      expr: order_constraint
      comment: "Any ordering constraints on the package (e.g., requires another option, market restriction) for order management analysis."
  measures:
    - name: "total_availability_record_count"
      expr: COUNT(1)
      comment: "Total number of package availability records. Baseline measure for option package portfolio coverage across markets and dealerships."
    - name: "orderable_package_count"
      expr: COUNT(CASE WHEN is_orderable = TRUE THEN 1 END)
      comment: "Number of package availability records where the package is currently orderable. Measures active sales portfolio breadth — a key metric for sales operations and revenue planning."
    - name: "orderability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_orderable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of package availability records where the package is orderable. Tracks portfolio availability health; low rates indicate supply constraints or launch delays impacting revenue."
    - name: "distinct_orderable_package_count"
      expr: COUNT(DISTINCT CASE WHEN is_orderable = TRUE THEN aftersales_option_package_id END)
      comment: "Number of distinct option packages currently orderable. Measures the breadth of the active option portfolio available to customers and dealers."
    - name: "distinct_market_region_count"
      expr: COUNT(DISTINCT market_region)
      comment: "Number of distinct market regions covered by package availability records. Tracks geographic portfolio coverage — gaps indicate markets without full option availability."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_pricing_condition_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing condition assignment analytics — tracks pricing condition coverage, value distribution, and active pricing posture across the product catalog. Used by Pricing, Finance, and Product Management to govern pricing strategy and condition lifecycle."
  source: "`vibe_automotive_v1`.`product`.`pricing_condition_assignment`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of pricing condition (base price, discount, surcharge, freight) for pricing structure analysis."
    - name: "condition_status"
      expr: condition_status
      comment: "Status of the pricing condition (active, expired, pending) for pricing governance monitoring."
    - name: "calculation_type"
      expr: calculation_type
      comment: "Calculation method (percentage, fixed amount, formula) for pricing condition type analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing condition for multi-currency pricing analysis."
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority rank of the condition in pricing determination, used to analyze pricing condition hierarchy and conflict resolution."
  measures:
    - name: "total_condition_assignment_count"
      expr: COUNT(1)
      comment: "Total number of pricing condition assignments. Baseline measure for pricing complexity; high counts indicate complex pricing structures requiring governance attention."
    - name: "active_condition_count"
      expr: COUNT(CASE WHEN condition_status = 'Active' THEN 1 END)
      comment: "Number of currently active pricing conditions. Measures the live pricing rule set size — a key input for pricing governance and revenue management."
    - name: "avg_condition_value"
      expr: AVG(CAST(condition_value AS DOUBLE))
      comment: "Average pricing condition value across all assignments. Tracks the typical magnitude of pricing adjustments; significant shifts indicate pricing strategy changes requiring executive review."
    - name: "total_condition_value"
      expr: SUM(CAST(condition_value AS DOUBLE))
      comment: "Total value of all pricing conditions in scope. Provides aggregate pricing adjustment exposure for financial planning and revenue impact analysis."
    - name: "max_condition_value"
      expr: MAX(condition_value)
      comment: "Maximum pricing condition value. Identifies the largest pricing adjustments in the portfolio — outliers may indicate pricing errors or exceptional commercial arrangements requiring review."
    - name: "distinct_sku_priced_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one pricing condition assigned. Measures pricing coverage of the product catalog — SKUs without conditions may be unpriced and unsellable."
$$;