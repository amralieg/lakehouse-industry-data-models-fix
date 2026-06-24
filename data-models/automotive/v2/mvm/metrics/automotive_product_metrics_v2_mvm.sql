-- Metric views for domain: product | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the Bill of Materials header entity. Tracks product cost, sustainability, weight, and configurability across model years, powertrains, and market regions — enabling product portfolio steering, cost governance, and sustainability target tracking."
  source: "`vibe_automotive_v1`.`product`.`bom_header`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle variant, used to trend cost and sustainability metrics across annual product cycles."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain classification (e.g. BEV, PHEV, ICE) enabling cost and weight comparison across electrification strategies."
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region for the BOM, supporting regional cost and compliance analysis."
    - name: "bom_status"
      expr: bom_status
      comment: "Lifecycle status of the BOM (e.g. Active, Obsolete, Draft) for filtering production-relevant records."
    - name: "bom_type"
      expr: bom_type
      comment: "Classification of the BOM type (e.g. Engineering, Manufacturing) to segment cost and weight analysis."
    - name: "emissions_standard"
      expr: emissions_standard
      comment: "Regulatory emissions standard the BOM is designed to meet, enabling compliance-driven portfolio analysis."
    - name: "nameplate_code"
      expr: nameplate_code
      comment: "Vehicle nameplate identifier for grouping KPIs by product line or model family."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates whether the BOM supports customer configuration, used to segment configurable vs. fixed product offerings."
    - name: "safety_certification_level"
      expr: safety_certification_level
      comment: "Safety certification tier of the product, enabling safety-stratified cost and weight analysis."
    - name: "adas_level"
      expr: adas_level
      comment: "Autonomous driving assistance level (SAE 0–5) for segmenting advanced technology content in cost and weight metrics."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month-truncated effective start date of the BOM, used for time-series trending of cost and sustainability KPIs."
    - name: "sop_date_month"
      expr: DATE_TRUNC('month', sop_date)
      comment: "Month-truncated Start of Production date, enabling launch-cohort analysis of cost and weight at SOP."
  measures:
    - name: "total_bom_count"
      expr: COUNT(1)
      comment: "Total number of active BOM headers. Baseline volume metric for portfolio breadth and governance coverage."
    - name: "avg_standard_cost_amount"
      expr: AVG(CAST(standard_cost_amount AS DOUBLE))
      comment: "Average standard manufacturing cost per BOM. A primary cost governance KPI used by Finance and Product leadership to track cost targets by model year and powertrain."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost across all BOMs in the selected slice. Used for portfolio-level cost exposure and budget planning."
    - name: "avg_msrp_base_amount"
      expr: AVG(CAST(msrp_base_amount AS DOUBLE))
      comment: "Average base MSRP across BOMs. Tracks pricing positioning by segment, powertrain, and model year for revenue strategy decisions."
    - name: "total_msrp_base_amount"
      expr: SUM(CAST(msrp_base_amount AS DOUBLE))
      comment: "Total MSRP base value across the BOM portfolio. Indicates aggregate revenue potential of the product lineup."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across BOMs. A strategic ESG KPI used by executives to track product portfolio alignment with sustainability commitments."
    - name: "avg_total_assembly_weight_kg"
      expr: AVG(CAST(total_assembly_weight_kg AS DOUBLE))
      comment: "Average total assembly weight in kilograms. Tracks lightweighting progress across model years and powertrain types — a key engineering and fuel-economy KPI."
    - name: "total_assembly_weight_kg_sum"
      expr: SUM(CAST(total_assembly_weight_kg AS DOUBLE))
      comment: "Total assembly weight across all BOMs in the slice. Used for fleet-level weight compliance and logistics planning."
    - name: "gross_margin_proxy_per_bom"
      expr: AVG(CAST(msrp_base_amount AS DOUBLE) - CAST(standard_cost_amount AS DOUBLE))
      comment: "Average per-BOM gross margin proxy (MSRP minus standard cost). A critical profitability KPI for product portfolio steering and pricing decisions."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN 1 END)
      comment: "Count of BOMs flagged as customer-configurable. Tracks the breadth of the configurable product offering, a key driver of dealer and e-commerce revenue."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Component-level KPIs derived from BOM line items. Enables analysis of component quantity, scrap, criticality, and optional content — supporting cost reduction, quality, and supply chain decisions."
  source: "`vibe_automotive_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BOM line item (e.g. Structural, Electrical, Powertrain) for component-level cost and scrap analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the component quantity, used to ensure consistent aggregation within categories."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags components designated as critical to vehicle function or safety, enabling risk-weighted supply chain analysis."
    - name: "is_optional_flag"
      expr: is_optional_flag
      comment: "Indicates whether the component is an optional feature, used to separate standard vs. optional content cost analysis."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month-truncated effective start date of the BOM line, used for time-series trending of component usage and scrap."
    - name: "option_code"
      expr: option_code
      comment: "Option code associated with the BOM line, enabling analysis of optional content penetration and cost contribution."
  measures:
    - name: "total_bom_line_count"
      expr: COUNT(1)
      comment: "Total number of BOM line items. Baseline measure of product complexity — higher counts indicate more complex assemblies with greater supply chain exposure."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of BOM lines flagged as critical. A supply chain risk KPI — a high count of critical components signals vulnerability to disruption."
    - name: "optional_component_count"
      expr: COUNT(CASE WHEN is_optional_flag = TRUE THEN 1 END)
      comment: "Count of optional BOM line items. Tracks the breadth of the options portfolio, informing revenue-per-unit and configurability strategy."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM lines. A manufacturing quality and cost KPI — elevated scrap rates directly increase production cost and waste."
    - name: "total_component_quantity"
      expr: SUM(CAST(component_quantity AS DOUBLE))
      comment: "Total component quantity across BOM lines. Used for procurement volume planning and supply chain capacity analysis."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average quantity of each component per assembly. Tracks component density and complexity trends across product generations."
    - name: "distinct_part_count"
      expr: COUNT(DISTINCT part_number)
      comment: "Count of distinct part numbers across BOM lines. A product complexity and supplier diversity KPI — high part counts increase procurement and logistics cost."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_catalog_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over catalog publication events. Tracks publication health, distribution success, validation quality, and digital channel readiness — enabling product-to-market speed and compliance governance."
  source: "`vibe_automotive_v1`.`product`.`catalog_publication`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Current status of the catalog publication (e.g. Published, Pending, Recalled) for pipeline health monitoring."
    - name: "publication_type"
      expr: publication_type
      comment: "Type of catalog publication (e.g. Full, Delta, Regulatory) for segmenting distribution and validation KPIs."
    - name: "publication_format"
      expr: publication_format
      comment: "Format of the published catalog (e.g. PDF, XML, JSON) for channel-specific distribution analysis."
    - name: "target_channel"
      expr: target_channel
      comment: "Distribution channel targeted by the publication (e.g. Dealer, Digital, OEM) for channel-level performance tracking."
    - name: "target_region"
      expr: target_region
      comment: "Geographic region targeted by the publication, enabling regional go-to-market and compliance analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year covered by the catalog publication, used to trend publication activity across product cycles."
    - name: "language_code"
      expr: language_code
      comment: "Language of the catalog publication, used to track localization coverage across markets."
    - name: "validation_status"
      expr: validation_status
      comment: "Outcome of the catalog validation process (e.g. Passed, Failed, Warning) for quality gate monitoring."
    - name: "digital_storefront_flag"
      expr: digital_storefront_flag
      comment: "Indicates whether the publication is linked to a digital storefront, enabling e-commerce readiness tracking."
    - name: "publication_date_month"
      expr: DATE_TRUNC('month', publication_date)
      comment: "Month-truncated publication date for time-series trending of catalog release cadence."
    - name: "esg_disclosure_included_flag"
      expr: esg_disclosure_included_flag
      comment: "Indicates whether ESG disclosure content is included in the publication, supporting sustainability reporting governance."
  measures:
    - name: "total_publications"
      expr: COUNT(1)
      comment: "Total number of catalog publications. Baseline volume metric for go-to-market cadence and publication pipeline throughput."
    - name: "distributed_publication_count"
      expr: COUNT(CASE WHEN distribution_confirmation_flag = TRUE THEN 1 END)
      comment: "Count of publications with confirmed distribution. Tracks successful catalog delivery to downstream channels — a key go-to-market execution KPI."
    - name: "digital_storefront_publication_count"
      expr: COUNT(CASE WHEN digital_storefront_flag = TRUE THEN 1 END)
      comment: "Count of publications linked to a digital storefront. Tracks e-commerce catalog coverage, a strategic digital retail KPI."
    - name: "recalled_publication_count"
      expr: COUNT(CASE WHEN recall_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of publications that have been recalled. A quality and compliance risk KPI — recalls indicate data integrity or regulatory issues in the catalog pipeline."
    - name: "esg_disclosure_publication_count"
      expr: COUNT(CASE WHEN esg_disclosure_included_flag = TRUE THEN 1 END)
      comment: "Count of publications that include ESG disclosure content. Tracks regulatory and sustainability reporting compliance across catalog releases."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size of catalog publications in bytes. Tracks catalog complexity and distribution infrastructure load over time."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all catalog publications. Used for storage capacity planning and distribution bandwidth governance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_catalog_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over catalog version lifecycle. Tracks catalog currency, approval governance, e-commerce readiness, and version proliferation — enabling product information management and go-to-market governance."
  source: "`vibe_automotive_v1`.`product`.`catalog_version`"
  dimensions:
    - name: "catalog_version_status"
      expr: catalog_version_status
      comment: "Lifecycle status of the catalog version (e.g. Active, Archived, Draft) for pipeline health and governance monitoring."
    - name: "catalog_type"
      expr: catalog_type
      comment: "Type of catalog (e.g. Retail, Fleet, Regulatory) for segmenting version KPIs by business channel."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the catalog version, used to track governance compliance and release readiness."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment targeted by the catalog version (e.g. Mass Market, Luxury, Fleet) for segment-level version analysis."
    - name: "region_coverage"
      expr: region_coverage
      comment: "Geographic region coverage of the catalog version, enabling regional go-to-market readiness tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the catalog version is denominated, used for multi-currency pricing governance."
    - name: "is_current"
      expr: is_current
      comment: "Flags the catalog version as the current active version, used to isolate live vs. historical version KPIs."
    - name: "ecommerce_version_flag"
      expr: ecommerce_version_flag
      comment: "Indicates whether the catalog version is published to e-commerce channels, tracking digital retail readiness."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date of the catalog version for time-series trending of version releases."
  measures:
    - name: "total_catalog_versions"
      expr: COUNT(1)
      comment: "Total number of catalog versions. Baseline measure of catalog version proliferation and release cadence."
    - name: "current_version_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Count of catalog versions flagged as current. Should ideally be 1 per market/segment — deviations indicate governance issues."
    - name: "ecommerce_enabled_version_count"
      expr: COUNT(CASE WHEN ecommerce_version_flag = TRUE THEN 1 END)
      comment: "Count of catalog versions enabled for e-commerce. Tracks digital channel readiness of the product catalog — a strategic digital retail KPI."
    - name: "approved_version_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of catalog versions with approved status. Tracks governance compliance and release pipeline health."
    - name: "avg_sku_structure_code"
      expr: AVG(CAST(sku_structure_code AS DOUBLE))
      comment: "Average SKU structure code value across catalog versions. Used to detect structural drift in catalog architecture across version generations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the product segment master. Tracks market share targets, price range positioning, segment lifecycle health, and ESG classification — enabling portfolio strategy, competitive positioning, and sustainability governance."
  source: "`vibe_automotive_v1`.`product`.`segment`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the segment (e.g. Active, Sunset, Emerging) for portfolio health monitoring."
    - name: "powertrain_category"
      expr: powertrain_category
      comment: "Powertrain category of the segment (e.g. BEV, ICE, Hybrid) for electrification strategy analysis."
    - name: "market_positioning_tier"
      expr: market_positioning_tier
      comment: "Market positioning tier (e.g. Entry, Mid, Premium, Luxury) for competitive and pricing strategy analysis."
    - name: "esg_segment_classification"
      expr: esg_segment_classification
      comment: "ESG classification of the segment, used to track sustainability portfolio composition and ESG target alignment."
    - name: "body_style_category"
      expr: body_style_category
      comment: "Body style category (e.g. SUV, Sedan, Truck) for product mix and demand analysis."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority designation of the segment (e.g. Core, Growth, Harvest) for resource allocation decisions."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the segment hierarchy, used to filter analysis to the appropriate granularity (e.g. top-level vs. sub-segment)."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the segment is currently active, used to filter KPIs to live portfolio segments."
    - name: "subscription_eligible_flag"
      expr: subscription_eligible_flag
      comment: "Flags segments eligible for subscription-based ownership models, tracking the subscription revenue opportunity in the portfolio."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date of the segment, used for time-series analysis of segment portfolio evolution."
  measures:
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of product segments. Baseline measure of portfolio breadth and segmentation complexity."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active segments. Tracks the live portfolio size — a key input to resource allocation and go-to-market planning."
    - name: "avg_market_share_target_pct"
      expr: AVG(CAST(market_share_target_pct AS DOUBLE))
      comment: "Average market share target percentage across segments. A strategic KPI used by executives to assess ambition level and portfolio competitiveness."
    - name: "avg_price_range_max_usd"
      expr: AVG(CAST(price_range_max_usd AS DOUBLE))
      comment: "Average upper price range boundary across segments. Tracks the premium positioning of the portfolio and pricing strategy evolution."
    - name: "avg_price_range_min_usd"
      expr: AVG(CAST(price_range_min_usd AS DOUBLE))
      comment: "Average lower price range boundary across segments. Tracks entry-level accessibility of the portfolio and affordability strategy."
    - name: "subscription_eligible_segment_count"
      expr: COUNT(CASE WHEN subscription_eligible_flag = TRUE THEN 1 END)
      comment: "Count of segments eligible for subscription ownership models. Tracks the addressable portfolio for recurring revenue strategies — a key new business model KPI."
    - name: "connectivity_capable_segment_count"
      expr: COUNT(CASE WHEN connectivity_capability = TRUE THEN 1 END)
      comment: "Count of segments with connectivity capability. Tracks the connected vehicle portfolio breadth, a strategic technology and services revenue KPI."
    - name: "ota_capable_segment_count"
      expr: COUNT(CASE WHEN ota_update_capability = TRUE THEN 1 END)
      comment: "Count of segments with over-the-air update capability. Tracks software-defined vehicle readiness across the portfolio — a key digital transformation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`product_package_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over package availability records. Tracks orderable package coverage, regional availability, and launch readiness — enabling dealer operations, allocation governance, and go-to-market execution decisions."
  source: "`vibe_automotive_v1`.`product`.`package_availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the package (e.g. Available, Discontinued, Pending) for inventory and order management analysis."
    - name: "market_region"
      expr: market_region
      comment: "Market region for the package availability record, enabling regional launch and allocation analysis."
    - name: "is_orderable"
      expr: is_orderable
      comment: "Indicates whether the package is currently orderable, used to track active order pipeline coverage."
    - name: "launch_date_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month-truncated launch date of the package, used for time-series analysis of product launch cadence."
    - name: "discontinuation_date_month"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month-truncated discontinuation date, used to track end-of-life package transitions and portfolio pruning cadence."
  measures:
    - name: "total_package_availability_records"
      expr: COUNT(1)
      comment: "Total number of package availability records. Baseline measure of package-dealer coverage breadth."
    - name: "orderable_package_count"
      expr: COUNT(CASE WHEN is_orderable = TRUE THEN 1 END)
      comment: "Count of packages currently flagged as orderable. Tracks the active order-eligible portfolio — a key dealer operations and revenue pipeline KPI."
    - name: "discontinued_package_count"
      expr: COUNT(CASE WHEN discontinuation_date IS NOT NULL THEN 1 END)
      comment: "Count of packages with a discontinuation date set. Tracks portfolio end-of-life activity and product lifecycle management execution."
    - name: "distinct_market_region_count"
      expr: COUNT(DISTINCT market_region)
      comment: "Count of distinct market regions with package availability records. Tracks geographic coverage breadth of the product portfolio — a go-to-market reach KPI."
$$;