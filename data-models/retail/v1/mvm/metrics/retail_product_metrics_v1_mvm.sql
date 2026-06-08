-- Metric views for domain: product | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU catalogue health and physical product metrics. Tracks active assortable SKU counts, weight/volume profiles, and lifecycle distribution to support assortment planning, logistics costing, and product rationalisation decisions."
  source: "`retail_ecm`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (e.g. Active, Discontinued, Pending). Used to segment KPIs between live and retiring products."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is manufactured or sourced. Supports supply-chain risk and tariff analysis."
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Storage temperature band (e.g. Ambient, Chilled, Frozen). Drives logistics cost segmentation."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the SKU is classified as hazardous material, affecting shipping and compliance costs."
    - name: "age_restriction_flag"
      expr: age_restriction_flag
      comment: "Flags SKUs that require age verification at point of sale, relevant for compliance reporting."
    - name: "dimension_unit_of_measure"
      expr: dimension_unit_of_measure
      comment: "Unit of measure used for physical dimensions (length, width, height). Needed for logistics cube calculations."
    - name: "weight_unit_of_measure"
      expr: weight_unit_of_measure
      comment: "Unit of measure for gross and net weight fields. Required for freight cost normalisation."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SKU became effective, used to track new product introduction cadence over time."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the SKU was discontinued. Used to measure product exit velocity and rationalisation pace."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_id END)
      comment: "Count of SKUs currently in Active lifecycle status. Core assortment breadth KPI used by category managers and merchandising leadership."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total SKU count across all lifecycle statuses. Baseline catalogue size metric for assortment planning and vendor negotiations."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Discontinued' THEN sku_id END)
      comment: "Number of discontinued SKUs. Tracks product rationalisation progress and catalogue hygiene."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN sku_id END)
      comment: "Count of SKUs classified as hazardous materials. Drives compliance cost budgeting and logistics planning."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight per SKU. Used to estimate freight costs and warehouse slot sizing across the catalogue."
    - name: "avg_net_weight"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight per SKU. Supports product content and labelling compliance checks."
    - name: "avg_cube"
      expr: AVG(CAST(cube AS DOUBLE))
      comment: "Average cubic volume per SKU. Key input for warehouse slotting efficiency and transport load planning."
    - name: "avg_volume"
      expr: AVG(CAST(volume AS DOUBLE))
      comment: "Average volumetric measure per SKU. Supports shelf-space allocation and planogram design decisions."
    - name: "active_sku_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the total catalogue that is actively available for sale. A declining ratio signals catalogue bloat or poor rationalisation discipline."
    - name: "hazmat_sku_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_flag = TRUE THEN sku_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of SKUs classified as hazardous. Elevated ratios increase compliance and logistics cost exposure."
    - name: "age_restricted_sku_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN age_restriction_flag = TRUE THEN sku_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of SKUs requiring age verification. Informs store operations training and checkout compliance investment."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio performance and health metrics. Supports brand investment decisions, private-label strategy, exclusivity management, and vendor quality governance."
  source: "`retail_ecm`.`product`.`brand`"
  dimensions:
    - name: "brand_tier"
      expr: brand_tier
      comment: "Tier classification of the brand (e.g. Premium, Value, Economy). Used to segment margin and quality KPIs by brand positioning."
    - name: "brand_type"
      expr: brand_type
      comment: "Type of brand (e.g. National, Private Label, Licensed). Core dimension for own-brand vs. third-party brand analysis."
    - name: "brand_status"
      expr: brand_status
      comment: "Operational status of the brand (e.g. Active, Discontinued). Filters KPIs to live vs. retiring brand portfolio."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the brand is a retailer-owned private label. Critical dimension for own-brand penetration and margin strategy."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flags brands sold exclusively by this retailer. Exclusivity drives differentiation and competitive moat analysis."
    - name: "is_licensed"
      expr: is_licensed
      comment: "Indicates a licensed brand with contractual obligations. Relevant for license renewal risk and royalty cost tracking."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country where the brand originates. Supports import risk, tariff exposure, and sustainability sourcing analysis."
    - name: "portfolio_group"
      expr: portfolio_group
      comment: "Strategic portfolio grouping for the brand. Enables P&L analysis at the brand portfolio level."
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Primary customer segment the brand targets. Aligns brand investment with customer demographic strategy."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification held by the brand. Supports ESG reporting and sustainable sourcing commitments."
    - name: "launch_date_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the brand was launched. Tracks new brand introduction cadence and time-to-market performance."
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brands in the portfolio. Baseline metric for brand portfolio breadth and vendor diversity."
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN brand_status = 'Active' THEN brand_id END)
      comment: "Number of currently active brands. Tracks live portfolio size for assortment and vendor management decisions."
    - name: "private_label_brand_count"
      expr: COUNT(CASE WHEN is_private_label = TRUE THEN brand_id END)
      comment: "Count of private-label brands. Directly measures own-brand portfolio depth, a key strategic lever for margin improvement."
    - name: "exclusive_brand_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN brand_id END)
      comment: "Number of exclusively held brands. Exclusivity is a competitive differentiator; tracking this informs negotiation and partnership strategy."
    - name: "licensed_brand_count"
      expr: COUNT(CASE WHEN is_licensed = TRUE THEN brand_id END)
      comment: "Count of licensed brands. Tracks royalty and renewal risk exposure across the brand portfolio."
    - name: "avg_brand_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across brands. A declining average signals supplier quality degradation requiring vendor intervention."
    - name: "avg_return_rate_pct"
      expr: AVG(CAST(return_rate_percent AS DOUBLE))
      comment: "Average product return rate across brands. High return rates indicate quality or expectation-mismatch issues driving cost and customer dissatisfaction."
    - name: "private_label_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_private_label = TRUE THEN brand_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the brand portfolio that is private label. A core strategic KPI for own-brand growth targets and margin improvement programmes."
    - name: "exclusive_brand_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exclusive = TRUE THEN brand_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of brands held exclusively. Measures competitive differentiation depth in the brand portfolio."
    - name: "brands_with_sustainability_cert_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification <> '' THEN brand_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of brands holding a sustainability certification. Tracks ESG portfolio progress against sustainability commitments."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product regulatory compliance health metrics. Tracks compliance pass rates, recall exposure, audit currency, and certification coverage to manage regulatory risk and avoid costly enforcement actions."
  source: "`retail_ecm`.`product`.`compliance`"
  dimensions:
    - name: "compliance_type"
      expr: compliance_type
      comment: "Category of compliance requirement (e.g. Food Safety, Hazmat, Import). Segments risk exposure by regulatory domain."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g. Compliant, Non-Compliant, Under Review). Primary dimension for compliance risk dashboards."
    - name: "country_code"
      expr: country_code
      comment: "Country jurisdiction for the compliance record. Enables market-level regulatory risk analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional jurisdiction. Supports aggregated compliance reporting across multi-country regions."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status of the SKU-compliance record. Active recalls are the highest-severity compliance risk."
    - name: "recall_severity_level"
      expr: recall_severity_level
      comment: "Severity classification of a product recall (e.g. Class I, II, III). Drives prioritisation of recall response resources."
    - name: "prop_65_warning_required"
      expr: prop_65_warning_required
      comment: "Indicates whether a California Prop 65 warning is required. Non-compliance carries significant legal and reputational risk."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the compliance record became effective. Tracks compliance certification renewal cadence."
    - name: "last_audit_date_month"
      expr: DATE_TRUNC('month', last_audit_date)
      comment: "Month of the most recent compliance audit. Used to identify overdue audit populations."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total number of compliance records. Baseline for compliance coverage analysis across the product catalogue."
    - name: "compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN compliance_id END)
      comment: "Number of compliance records in a Compliant state. Core KPI for regulatory health reporting to legal and compliance leadership."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN compliance_id END)
      comment: "Count of non-compliant records. Directly measures regulatory risk exposure requiring immediate remediation action."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status = 'Active' THEN compliance_id END)
      comment: "Number of SKUs with an active recall. The most critical compliance KPI — active recalls trigger immediate operational and reputational response."
    - name: "compliance_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records in a Compliant state. The headline regulatory health KPI reported to the board and regulators."
    - name: "nutrition_labeling_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nutrition_labeling_compliant = TRUE THEN compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of records with compliant nutrition labelling. Non-compliance risks FDA enforcement and consumer trust damage."
    - name: "allergen_declaration_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN allergen_declaration_compliant = TRUE THEN compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records with compliant allergen declarations. Critical food safety KPI — failures can cause consumer harm and class-action liability."
    - name: "country_of_origin_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN country_of_origin_compliant = TRUE THEN compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of records compliant with country-of-origin labelling requirements. Non-compliance triggers customs and trade enforcement risk."
    - name: "prop_65_exposure_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prop_65_warning_required = TRUE THEN compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records requiring a Prop 65 warning. Measures California regulatory exposure across the product range."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_attribute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product attribute data quality and certification metrics. Governs the completeness, accuracy, and regulatory coverage of product content, which directly impacts search discoverability, regulatory compliance, and customer conversion."
  source: "`retail_ecm`.`product`.`attribute`"
  dimensions:
    - name: "attribute_group"
      expr: attribute_group
      comment: "Logical grouping of attributes (e.g. Nutritional, Physical, Regulatory). Enables quality analysis by attribute category."
    - name: "attribute_name"
      expr: attribute_name
      comment: "Name of the specific product attribute. Allows drill-down to identify which attributes have quality or coverage gaps."
    - name: "attribute_status"
      expr: attribute_status
      comment: "Current status of the attribute record (e.g. Active, Pending, Rejected). Filters KPIs to approved vs. in-flight content."
    - name: "is_certified"
      expr: is_certified
      comment: "Indicates whether the attribute value has been certified by an external body. Certified attributes carry higher trust and regulatory weight."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flags attributes mandated by regulation. Non-coverage of regulatory-required attributes is a compliance risk."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Indicates whether the attribute is indexed for product search. Directly impacts e-commerce discoverability and conversion."
    - name: "locale"
      expr: locale
      comment: "Language/locale of the attribute value. Supports multi-market content completeness analysis."
    - name: "source_system"
      expr: source_system
      comment: "Origin system of the attribute data. Identifies which upstream systems are contributing low-quality content."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the attribute became effective. Tracks content enrichment velocity over time."
  measures:
    - name: "total_attribute_records"
      expr: COUNT(1)
      comment: "Total number of product attribute records. Baseline for content coverage and enrichment tracking."
    - name: "certified_attribute_count"
      expr: COUNT(CASE WHEN is_certified = TRUE THEN attribute_id END)
      comment: "Number of attributes with external certification. Certified attributes reduce regulatory risk and increase buyer trust."
    - name: "regulatory_required_attribute_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN attribute_id END)
      comment: "Count of attributes flagged as regulatory requirements. Gaps in this population represent direct compliance exposure."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all attribute records. The headline product content quality KPI — a declining score signals upstream data governance failures."
    - name: "avg_attribute_value"
      expr: AVG(CAST(attribute_value AS DOUBLE))
      comment: "Average numeric attribute value across records. Useful for benchmarking physical or nutritional attribute profiles across the catalogue."
    - name: "certified_attribute_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_certified = TRUE THEN attribute_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attributes that are externally certified. Tracks progress against product content certification targets."
    - name: "regulatory_attribute_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_required = TRUE AND attribute_status = 'Active' THEN attribute_id END) / NULLIF(COUNT(CASE WHEN is_regulatory_required = TRUE THEN attribute_id END), 0), 2)
      comment: "Percentage of regulatory-required attributes that are actively populated. A sub-100% score represents direct regulatory non-compliance risk."
    - name: "searchable_attribute_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_searchable = TRUE THEN attribute_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of attributes enabled for product search. Higher searchable coverage improves e-commerce discoverability and conversion rates."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment planning and stocking health metrics. Tracks active assortment coverage, replenishment lead times, and stocking status distribution to support category management and supply chain planning decisions."
  source: "`retail_ecm`.`product`.`assortment`"
  dimensions:
    - name: "stocking_status"
      expr: stocking_status
      comment: "Current stocking status of the assortment record (e.g. In Stock, Out of Stock, Discontinued). Primary dimension for availability analysis."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority tier for inventory allocation. Used to segment KPIs by strategic importance of the assortment slot."
    - name: "assignment_effective_date_month"
      expr: DATE_TRUNC('month', assignment_effective_date)
      comment: "Month the assortment assignment became effective. Tracks new assortment introduction cadence."
    - name: "assignment_end_date_month"
      expr: DATE_TRUNC('month', assignment_end_date)
      comment: "Month the assortment assignment ends. Used to forecast upcoming assortment exits and plan replacements."
    - name: "last_received_date_month"
      expr: DATE_TRUNC('month', last_received_date)
      comment: "Month stock was last received for this assortment slot. Identifies stale or unreplenished assortment positions."
  measures:
    - name: "total_assortment_slots"
      expr: COUNT(1)
      comment: "Total number of assortment slot records. Baseline for assortment breadth and coverage analysis."
    - name: "active_assortment_count"
      expr: COUNT(CASE WHEN stocking_status = 'Active' THEN assortment_id END)
      comment: "Number of assortment slots in Active stocking status. Core assortment health KPI for category managers."
    - name: "out_of_stock_assortment_count"
      expr: COUNT(CASE WHEN stocking_status = 'Out of Stock' THEN assortment_id END)
      comment: "Count of assortment slots currently out of stock. Directly measures lost sales exposure and customer satisfaction risk."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs represented in the assortment. Measures assortment breadth — a key input to category range review decisions."
    - name: "out_of_stock_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stocking_status = 'Out of Stock' THEN assortment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assortment slots that are out of stock. The headline availability KPI — elevated rates directly correlate with lost revenue and customer churn."
    - name: "active_assortment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stocking_status = 'Active' THEN assortment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of assortment slots that are actively stocked. Measures the health and completeness of the live product range."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GTIN registry quality and publication metrics. Tracks barcode registration completeness, GDSN synchronisation status, and packaging hierarchy coverage — critical for supply chain interoperability, retailer-supplier data exchange, and e-commerce product discoverability."
  source: "`retail_ecm`.`product`.`gtin_registry`"
  dimensions:
    - name: "gtin_type"
      expr: gtin_type
      comment: "Type of GTIN barcode (e.g. GTIN-8, GTIN-12, GTIN-13, GTIN-14). Segments registry quality by barcode standard."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status of the GTIN (e.g. Active, Discontinued, Pending). Primary dimension for registry health analysis."
    - name: "gdsn_publication_status"
      expr: gdsn_publication_status
      comment: "Status of GDSN data pool publication (e.g. Published, Pending, Rejected). Tracks supplier data synchronisation health."
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (e.g. Each, Inner Pack, Case, Pallet). Enables analysis of GTIN coverage across the packaging hierarchy."
    - name: "is_base_unit"
      expr: is_base_unit
      comment: "Indicates whether this GTIN represents the consumer base unit. Base unit coverage is the minimum requirement for retail scanning."
    - name: "is_consumer_unit"
      expr: is_consumer_unit
      comment: "Flags GTINs representing consumer-facing units. Consumer unit completeness directly impacts POS and e-commerce operations."
    - name: "is_orderable_unit"
      expr: is_orderable_unit
      comment: "Indicates whether the GTIN is used for ordering. Orderable unit coverage is required for EDI and automated replenishment."
    - name: "country_of_sale"
      expr: country_of_sale
      comment: "Country where the GTIN is registered for sale. Supports market-level GTIN compliance analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the GTIN became effective. Tracks new product registration velocity."
  measures:
    - name: "total_gtin_records"
      expr: COUNT(1)
      comment: "Total GTIN registry records. Baseline for barcode coverage analysis across the product catalogue."
    - name: "active_gtin_count"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN gtin_registry_id END)
      comment: "Number of actively registered GTINs. Measures live barcode coverage — gaps indicate products that cannot be scanned or traded electronically."
    - name: "gdsn_published_count"
      expr: COUNT(CASE WHEN gdsn_publication_status = 'Published' THEN gtin_registry_id END)
      comment: "Number of GTINs successfully published to the GDSN data pool. GDSN publication is required for major retailer-supplier data exchange programmes."
    - name: "distinct_sku_gtin_coverage"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with at least one GTIN record. Measures barcode coverage breadth across the product catalogue."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight_value AS DOUBLE))
      comment: "Average gross weight value from GTIN registry. Used to validate consistency between GTIN registry and SKU master weight data."
    - name: "avg_net_content"
      expr: AVG(CAST(net_content_value AS DOUBLE))
      comment: "Average net content value registered in the GTIN. Supports product content accuracy audits and labelling compliance."
    - name: "gdsn_publication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdsn_publication_status = 'Published' THEN gtin_registry_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GTINs published to GDSN. Low publication rates block supplier data synchronisation and delay new product launches."
    - name: "base_unit_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_base_unit = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of GTIN records representing base consumer units. Base unit coverage is the minimum requirement for retail POS and e-commerce operations."
    - name: "orderable_unit_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_orderable_unit = TRUE THEN gtin_registry_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GTINs flagged as orderable units. Orderable unit completeness is required for automated replenishment and EDI ordering."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product category hierarchy governance and strategic planning metrics. Tracks hierarchy completeness, private-label penetration targets, safety stock coverage, and omnichannel enablement across the merchandise taxonomy."
  source: "`retail_ecm`.`product`.`item_hierarchy`"
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the merchandise hierarchy (e.g. Department, Category, Sub-Category). Enables drill-down analysis from division to leaf-node."
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of hierarchy (e.g. Merchandise, Financial, Logistics). Segments KPIs by the purpose of the hierarchy structure."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Operational status of the hierarchy node (e.g. Active, Inactive). Filters KPIs to live vs. retired category nodes."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic role of the category (e.g. Destination, Routine, Convenience). Core dimension for category investment prioritisation."
    - name: "seasonality_indicator"
      expr: seasonality_indicator
      comment: "Indicates whether the category is seasonal. Drives planning cycle and inventory investment decisions."
    - name: "omnichannel_enabled"
      expr: omnichannel_enabled
      comment: "Flags categories enabled for omnichannel fulfilment. Tracks omnichannel expansion progress across the merchandise taxonomy."
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Indicates whether the node is a leaf (lowest level) in the hierarchy. Leaf nodes are where SKUs are directly assigned."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the category (e.g. EDLP, Hi-Lo, Competitive). Enables margin and pricing strategy analysis by category."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment approach for the category (e.g. Vendor Managed, Auto-Replenishment). Supports supply chain efficiency analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the hierarchy node became effective. Tracks category structure evolution over time."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(1)
      comment: "Total number of hierarchy nodes. Baseline for merchandise taxonomy completeness and governance."
    - name: "active_node_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN item_hierarchy_id END)
      comment: "Number of active hierarchy nodes. Tracks the live merchandise taxonomy size for category management planning."
    - name: "leaf_node_count"
      expr: COUNT(CASE WHEN is_leaf_node = TRUE THEN item_hierarchy_id END)
      comment: "Count of leaf-level hierarchy nodes where SKUs are assigned. Measures the granularity and depth of the merchandise taxonomy."
    - name: "omnichannel_enabled_count"
      expr: COUNT(CASE WHEN omnichannel_enabled = TRUE THEN item_hierarchy_id END)
      comment: "Number of hierarchy nodes enabled for omnichannel. Tracks omnichannel category expansion progress against strategic targets."
    - name: "avg_private_label_penetration_target_pct"
      expr: AVG(CAST(private_label_penetration_target_percent AS DOUBLE))
      comment: "Average private-label penetration target across hierarchy nodes. Benchmarks own-brand ambition across the category portfolio — a key margin strategy KPI."
    - name: "avg_safety_stock_weeks"
      expr: AVG(CAST(safety_stock_weeks AS DOUBLE))
      comment: "Average safety stock weeks target across categories. Elevated averages indicate conservative inventory policies that tie up working capital."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across hierarchy nodes. Low scores indicate taxonomy governance gaps that impair reporting and planning accuracy."
    - name: "omnichannel_enablement_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN omnichannel_enabled = TRUE THEN item_hierarchy_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hierarchy nodes enabled for omnichannel fulfilment. Tracks progress against the omnichannel expansion strategy."
    - name: "active_node_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lifecycle_status = 'Active' THEN item_hierarchy_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of hierarchy nodes that are active. A declining ratio signals taxonomy bloat or poor governance of retired categories."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product bundle commercial performance and configuration metrics. Tracks bundle pricing, discount depth, loyalty eligibility, and channel availability to support promotional strategy and bundle portfolio management decisions."
  source: "`retail_ecm`.`product`.`item_bundle`"
  dimensions:
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of bundle (e.g. Fixed, Configurable, Gift Set). Segments bundle KPIs by commercial structure."
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle (e.g. Active, Expired, Draft). Filters KPIs to live vs. inactive bundle offers."
    - name: "channel_availability"
      expr: channel_availability
      comment: "Sales channels where the bundle is available (e.g. In-Store, Online, Both). Enables channel-level bundle performance analysis."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Method used to price the bundle (e.g. Fixed Price, Component Sum Minus Discount). Supports pricing strategy analysis."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Indicates whether the bundle earns loyalty points. Loyalty-eligible bundles drive repeat purchase and programme engagement."
    - name: "promotion_eligible"
      expr: promotion_eligible
      comment: "Flags bundles that can be included in promotional campaigns. Supports promotional planning and offer design."
    - name: "returnable"
      expr: returnable
      comment: "Indicates whether the bundle can be returned. Non-returnable bundles reduce reverse logistics cost but may impact customer satisfaction."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bundle price. Required for multi-currency bundle portfolio analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the bundle became effective. Tracks new bundle introduction cadence and promotional calendar alignment."
    - name: "effective_end_date_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the bundle expires. Used to forecast upcoming bundle expirations and plan replacements."
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of bundle records. Baseline for bundle portfolio size and promotional offer coverage."
    - name: "active_bundle_count"
      expr: COUNT(CASE WHEN bundle_status = 'Active' THEN item_bundle_id END)
      comment: "Number of currently active bundles. Tracks live promotional bundle inventory available to customers."
    - name: "loyalty_eligible_bundle_count"
      expr: COUNT(CASE WHEN loyalty_points_eligible = TRUE THEN item_bundle_id END)
      comment: "Count of bundles eligible for loyalty points. Measures the overlap between bundle and loyalty programme strategy."
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price_amount AS DOUBLE))
      comment: "Average bundle selling price. Tracks bundle price positioning and monitors for price drift across the bundle portfolio."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average absolute discount per bundle. Measures the average value incentive offered to customers through bundling."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across bundles. Tracks the depth of bundle discounting — excessive averages erode margin."
    - name: "total_bundle_price_value"
      expr: SUM(CAST(bundle_price_amount AS DOUBLE))
      comment: "Sum of all bundle prices. Represents the total potential revenue value of the active bundle portfolio."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value across all bundles. Measures the aggregate margin investment in the bundle promotional programme."
    - name: "loyalty_eligible_bundle_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_points_eligible = TRUE THEN item_bundle_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bundles eligible for loyalty points. Tracks alignment between bundle strategy and loyalty programme engagement goals."
    - name: "promotion_eligible_bundle_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_eligible = TRUE THEN item_bundle_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of bundles that can be included in promotions. Measures the promotional flexibility of the bundle portfolio."
$$;