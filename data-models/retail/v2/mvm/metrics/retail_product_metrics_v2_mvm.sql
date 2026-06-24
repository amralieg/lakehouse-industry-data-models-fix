-- Metric views for domain: product | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU catalog health and physical attribute metrics. Tracks active product portfolio composition, lifecycle distribution, and physical characteristics to support assortment planning, supply chain sizing, and product lifecycle management decisions."
  source: "`vibe_retail_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (e.g., Active, Discontinued, Pending). Primary filter for active portfolio analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced. Used for trade compliance, tariff analysis, and supply chain risk segmentation."
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Storage temperature requirement (e.g., Ambient, Refrigerated, Frozen). Drives logistics cost segmentation and fulfillment routing decisions."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the SKU is a private-label product. Enables margin and portfolio mix analysis between national brands and own-brand."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the SKU is classified as hazardous material. Required for regulatory compliance reporting and logistics cost allocation."
    - name: "age_restriction_flag"
      expr: age_restriction_flag
      comment: "Indicates whether the SKU has an age restriction. Used for compliance monitoring and point-of-sale control reporting."
    - name: "dimension_unit_of_measure"
      expr: dimension_unit_of_measure
      comment: "Unit of measure used for physical dimensions (length, width, height). Supports warehouse slotting and logistics planning."
    - name: "weight_unit_of_measure"
      expr: weight_unit_of_measure
      comment: "Unit of measure for weight attributes. Required for freight cost calculation and carrier compliance."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SKU became effective. Used to track new product introduction cadence over time."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the SKU was discontinued. Used to track product exit cadence and lifecycle duration analysis."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_id END)
      comment: "Count of SKUs currently in Active lifecycle status. Core portfolio size KPI used in assortment breadth reporting and category management reviews."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total count of all SKUs in the catalog regardless of status. Baseline denominator for portfolio composition ratios."
    - name: "private_label_sku_count"
      expr: COUNT(CASE WHEN private_label_flag = TRUE THEN sku_id END)
      comment: "Count of private-label SKUs. Tracks own-brand portfolio penetration, a key strategic lever for margin improvement."
    - name: "private_label_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN private_label_flag = TRUE THEN sku_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total SKUs that are private label. Directly informs brand strategy and margin mix decisions at executive level."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN sku_id END)
      comment: "Count of hazardous material SKUs. Drives logistics compliance cost allocation and regulatory exposure quantification."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight across SKUs. Used for freight cost modeling, carrier rate negotiation, and warehouse capacity planning."
    - name: "avg_net_weight"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight across SKUs. Supports product content compliance and nutritional labeling accuracy monitoring."
    - name: "avg_cube"
      expr: AVG(CAST(cube AS DOUBLE))
      comment: "Average cubic volume per SKU. Key input for warehouse slotting efficiency, truck utilization, and DC capacity planning."
    - name: "avg_volume"
      expr: AVG(CAST(volume AS DOUBLE))
      comment: "Average volumetric measure per SKU. Supports packaging optimization and logistics density analysis."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Discontinued' THEN sku_id END)
      comment: "Count of discontinued SKUs. Tracks product exit velocity and supports catalog rationalization decisions."
    - name: "age_restricted_sku_count"
      expr: COUNT(CASE WHEN age_restriction_flag = TRUE THEN sku_id END)
      comment: "Count of SKUs with age restrictions. Quantifies compliance exposure at point-of-sale and informs staff training investment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio performance and strategic positioning metrics. Tracks margin contribution, quality ratings, return rates, and brand mix to support vendor negotiations, brand investment decisions, and portfolio strategy reviews."
  source: "`vibe_retail_v1`.`product`.`brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current operational status of the brand (e.g., Active, Inactive, Pending). Primary filter for active brand portfolio analysis."
    - name: "brand_type"
      expr: brand_type
      comment: "Classification of the brand (e.g., National, Private Label, Licensed). Enables brand mix and margin strategy segmentation."
    - name: "tier"
      expr: tier
      comment: "Brand tier designation (e.g., Premium, Value, Standard). Drives pricing strategy and assortment positioning decisions."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the brand is a private-label brand. Core dimension for own-brand vs. national brand portfolio analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the brand is sold exclusively by this retailer. Tracks competitive differentiation through exclusive brand partnerships."
    - name: "is_licensed"
      expr: is_licensed
      comment: "Indicates whether the brand operates under a license agreement. Flags license expiration risk and royalty cost exposure."
    - name: "country_of_origin_code"
      expr: country_of_origin_code
      comment: "Country where the brand originates. Used for trade policy risk analysis and country-of-origin marketing compliance."
    - name: "target_customer_segment"
      expr: target_customer_segment
      comment: "Intended customer segment for the brand. Enables brand-to-customer alignment analysis and assortment targeting."
    - name: "portfolio_group"
      expr: portfolio_group
      comment: "Portfolio grouping for the brand. Supports brand portfolio rationalization and category management reviews."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification held by the brand. Tracks ESG-aligned brand penetration for sustainability reporting."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year the brand was launched. Used to analyze brand portfolio age distribution and new brand introduction trends."
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brands in the portfolio. Baseline KPI for brand portfolio breadth and rationalization tracking."
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN brand_status = 'Active' THEN brand_id END)
      comment: "Count of currently active brands. Core portfolio health metric used in category management and vendor strategy reviews."
    - name: "avg_margin_percent"
      expr: AVG(CAST(average_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across brands. Primary financial KPI for brand portfolio profitability assessment and vendor negotiation leverage."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across brands. Tracks supplier quality performance and informs brand investment and delisting decisions."
    - name: "avg_return_rate_percent"
      expr: AVG(CAST(return_rate_percent AS DOUBLE))
      comment: "Average product return rate percentage across brands. High return rates signal quality or expectation-setting issues requiring brand-level intervention."
    - name: "private_label_brand_count"
      expr: COUNT(CASE WHEN is_private_label = TRUE THEN brand_id END)
      comment: "Count of private-label brands. Tracks own-brand portfolio depth as a strategic margin lever."
    - name: "exclusive_brand_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN brand_id END)
      comment: "Count of exclusive brands. Quantifies competitive differentiation through exclusivity agreements."
    - name: "licensed_brand_count"
      expr: COUNT(CASE WHEN is_licensed = TRUE THEN brand_id END)
      comment: "Count of licensed brands. Tracks license agreement exposure and associated royalty cost obligations."
    - name: "max_margin_percent"
      expr: MAX(CAST(average_margin_percent AS DOUBLE))
      comment: "Highest average margin percentage among all brands. Identifies top-performing brands for investment prioritization."
    - name: "min_margin_percent"
      expr: MIN(CAST(average_margin_percent AS DOUBLE))
      comment: "Lowest average margin percentage among all brands. Identifies underperforming brands for renegotiation or delisting consideration."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product regulatory compliance health metrics. Tracks compliance status, recall exposure, certification coverage, and audit readiness across the SKU portfolio to support regulatory risk management, audit preparation, and recall response decisions."
  source: "`vibe_retail_v1`.`product`.`compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the record (e.g., Compliant, Non-Compliant, Pending Review). Primary dimension for regulatory risk segmentation."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance requirement (e.g., FDA, CPSC, REACH). Enables compliance coverage analysis by regulatory framework."
    - name: "country_code"
      expr: country_code
      comment: "Country for which the compliance record applies. Supports market-specific regulatory reporting and cross-border compliance gap analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional jurisdiction for the compliance record. Enables regional regulatory risk aggregation."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall status of the SKU compliance record. Critical dimension for active recall monitoring and response prioritization."
    - name: "recall_severity_level"
      expr: recall_severity_level
      comment: "Severity classification of a product recall. Drives escalation priority and consumer safety response decisions."
    - name: "prop_65_warning_required"
      expr: prop_65_warning_required
      comment: "Indicates whether a California Prop 65 warning is required. Tracks legal labeling compliance exposure in California markets."
    - name: "age_restriction_required"
      expr: age_restriction_required
      comment: "Indicates whether an age restriction applies to the product. Supports point-of-sale compliance control monitoring."
    - name: "nutrition_labeling_compliant"
      expr: nutrition_labeling_compliant
      comment: "Indicates whether the product meets nutrition labeling requirements. Tracks FDA food labeling compliance across the portfolio."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the compliance record became effective. Used to track compliance certification renewal cadence."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the compliance certification expires. Used to identify upcoming compliance expiration risk."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total number of compliance records. Baseline measure for compliance coverage breadth across the SKU portfolio."
    - name: "compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN compliance_id END)
      comment: "Count of compliance records in Compliant status. Core regulatory health KPI used in audit readiness and board-level risk reporting."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN compliance_id END)
      comment: "Count of non-compliant records. Directly quantifies regulatory risk exposure requiring immediate remediation action."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN compliance_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records in Compliant status. Primary regulatory health KPI for executive dashboards and regulatory body reporting."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status IS NOT NULL AND recall_status != '' AND recall_status != 'Closed' THEN compliance_id END)
      comment: "Count of SKUs with an active recall status. Critical safety KPI that triggers immediate executive and operational response when elevated."
    - name: "prop_65_exposure_count"
      expr: COUNT(CASE WHEN prop_65_warning_required = TRUE THEN compliance_id END)
      comment: "Count of products requiring California Prop 65 warnings. Quantifies legal labeling compliance exposure in California, a major retail market."
    - name: "distinct_skus_with_compliance"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with at least one compliance record. Measures compliance documentation coverage across the active product portfolio."
    - name: "nutrition_labeling_compliant_count"
      expr: COUNT(CASE WHEN nutrition_labeling_compliant = TRUE THEN compliance_id END)
      comment: "Count of products with compliant nutrition labeling. Tracks FDA food labeling compliance, a mandatory regulatory requirement for food retailers."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product category hierarchy performance and strategic planning metrics. Tracks margin targets, private label penetration goals, safety stock positioning, and category lifecycle health to support category management, merchandise planning, and strategic assortment decisions."
  source: "`vibe_retail_v1`.`product`.`item_hierarchy`"
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the merchandise hierarchy (e.g., Department, Category, Sub-Category). Enables drill-down analysis from enterprise to category level."
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of hierarchy structure (e.g., Merchandise, Planning, Reporting). Supports multi-hierarchy analysis for different business functions."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the hierarchy node. Filters active vs. retired categories for planning and reporting."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic role of the category (e.g., Destination, Routine, Convenience). Core dimension for category investment prioritization."
    - name: "seasonality_indicator"
      expr: seasonality_indicator
      comment: "Seasonality pattern for the category. Drives inventory planning, promotional timing, and markdown cadence decisions."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the category (e.g., EDLP, Hi-Lo, Competitive). Supports pricing governance and margin management."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment approach for the category (e.g., Vendor Managed, Auto-Replenishment). Informs supply chain efficiency and inventory investment decisions."
    - name: "omnichannel_enabled"
      expr: omnichannel_enabled
      comment: "Indicates whether the category is enabled for omnichannel fulfillment. Tracks digital commerce readiness across the merchandise hierarchy."
    - name: "is_leaf_node"
      expr: is_leaf_node
      comment: "Indicates whether the hierarchy node is a leaf (lowest level). Used to filter to actionable planning nodes vs. rollup nodes."
    - name: "markdown_cadence"
      expr: markdown_cadence
      comment: "Frequency of markdown events for the category. Supports margin management and promotional planning governance."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(1)
      comment: "Total count of hierarchy nodes. Baseline measure for merchandise hierarchy complexity and governance scope."
    - name: "active_category_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN item_hierarchy_id END)
      comment: "Count of active hierarchy nodes. Tracks the size of the active merchandise structure for assortment planning and category management."
    - name: "avg_target_gross_margin_percent"
      expr: AVG(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across categories. Primary financial planning KPI used in merchandise financial planning and category investment reviews."
    - name: "avg_private_label_penetration_target"
      expr: AVG(CAST(private_label_penetration_target_percent AS DOUBLE))
      comment: "Average private label penetration target across categories. Tracks strategic own-brand ambition level for margin improvement planning."
    - name: "avg_safety_stock_weeks"
      expr: AVG(CAST(safety_stock_weeks AS DOUBLE))
      comment: "Average safety stock weeks target across categories. Informs working capital investment in inventory buffers and supply chain resilience planning."
    - name: "max_target_gross_margin_percent"
      expr: MAX(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Highest target gross margin percentage among all categories. Identifies highest-margin categories for investment prioritization."
    - name: "min_target_gross_margin_percent"
      expr: MIN(CAST(target_gross_margin_percent AS DOUBLE))
      comment: "Lowest target gross margin percentage among all categories. Identifies margin-challenged categories requiring strategic review or exit."
    - name: "omnichannel_enabled_category_count"
      expr: COUNT(CASE WHEN omnichannel_enabled = TRUE THEN item_hierarchy_id END)
      comment: "Count of categories enabled for omnichannel fulfillment. Tracks digital commerce readiness and omnichannel expansion progress."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across hierarchy nodes. Tracks master data integrity, which directly impacts planning accuracy and downstream system reliability."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product assortment planning and stocking health metrics. Tracks assortment coverage, stocking status distribution, and replenishment lead time across fulfillment nodes and locations to support inventory planning, assortment optimization, and supply chain decisions."
  source: "`vibe_retail_v1`.`product`.`assortment`"
  dimensions:
    - name: "stocking_status"
      expr: stocking_status
      comment: "Current stocking status of the assortment record (e.g., In Stock, Out of Stock, Discontinued). Primary dimension for availability and assortment health analysis."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority level for inventory allocation to this assortment record. Supports allocation strategy analysis and fulfillment prioritization decisions."
    - name: "assignment_effective_date"
      expr: DATE_TRUNC('month', assignment_effective_date)
      comment: "Month the assortment assignment became effective. Tracks assortment change cadence and new product introduction timing."
    - name: "assignment_end_date"
      expr: DATE_TRUNC('month', assignment_end_date)
      comment: "Month the assortment assignment ends. Used to identify upcoming assortment exits and plan transition inventory."
    - name: "last_received_date"
      expr: DATE_TRUNC('month', last_received_date)
      comment: "Month inventory was last received for this assortment record. Tracks replenishment recency and identifies stale assortment positions."
  measures:
    - name: "total_assortment_records"
      expr: COUNT(1)
      comment: "Total number of assortment records. Baseline measure for assortment breadth across all locations and fulfillment nodes."
    - name: "active_assortment_count"
      expr: COUNT(CASE WHEN stocking_status = 'Active' THEN assortment_id END)
      comment: "Count of actively stocked assortment positions. Core assortment health KPI used in category management and store operations reviews."
    - name: "distinct_sku_count_in_assortment"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs included in the assortment. Measures assortment breadth — a key lever for customer satisfaction and sales conversion."
    - name: "distinct_location_count"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of distinct store locations covered by the assortment. Tracks assortment distribution reach across the store network."
    - name: "distinct_fulfillment_node_count"
      expr: COUNT(DISTINCT fulfillment_node_id)
      comment: "Count of distinct fulfillment nodes serving the assortment. Supports fulfillment network coverage and capacity planning decisions."
    - name: "out_of_stock_assortment_count"
      expr: COUNT(CASE WHEN stocking_status = 'Out of Stock' THEN assortment_id END)
      comment: "Count of assortment positions currently out of stock. Directly quantifies lost sales exposure and triggers replenishment or allocation intervention."
    - name: "out_of_stock_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN stocking_status = 'Out of Stock' THEN assortment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assortment positions that are out of stock. Critical availability KPI that directly impacts revenue and customer satisfaction scores."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_item_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product bundle pricing, discount, and channel availability metrics. Tracks bundle portfolio composition, discount depth, pricing methods, and promotional eligibility to support bundle strategy, pricing governance, and promotional planning decisions."
  source: "`vibe_retail_v1`.`product`.`item_bundle`"
  dimensions:
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle (e.g., Active, Inactive, Pending). Primary filter for active bundle portfolio analysis."
    - name: "bundle_type"
      expr: bundle_type
      comment: "Classification of the bundle (e.g., Fixed, Dynamic, Kit). Enables bundle strategy analysis by bundle construction method."
    - name: "channel_availability"
      expr: channel_availability
      comment: "Sales channels where the bundle is available (e.g., In-Store, Online, Both). Supports omnichannel bundle strategy and channel mix analysis."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Method used to price the bundle (e.g., Fixed Price, Component Sum Less Discount). Informs pricing governance and margin impact analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the bundle is priced. Required for multi-currency financial reporting and FX impact analysis."
    - name: "promotion_eligible"
      expr: promotion_eligible
      comment: "Indicates whether the bundle is eligible for promotional pricing. Tracks promotional exposure and discount liability."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Indicates whether the bundle earns loyalty points. Supports loyalty program cost analysis and customer engagement strategy."
    - name: "returnable"
      expr: returnable
      comment: "Indicates whether the bundle can be returned. Tracks return policy exposure and reverse logistics cost risk."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the bundle became effective. Tracks new bundle introduction cadence and seasonal bundle launch patterns."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the bundle expires. Used to identify upcoming bundle expirations and plan assortment transitions."
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of bundle records. Baseline measure for bundle portfolio size and complexity."
    - name: "active_bundle_count"
      expr: COUNT(CASE WHEN bundle_status = 'Active' THEN item_bundle_id END)
      comment: "Count of currently active bundles. Core bundle portfolio health KPI used in pricing and promotional strategy reviews."
    - name: "avg_bundle_price"
      expr: AVG(CAST(bundle_price_amount AS DOUBLE))
      comment: "Average bundle selling price. Tracks bundle price positioning and supports pricing strategy governance."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average absolute discount amount per bundle. Quantifies average discount depth to inform margin impact and promotional investment decisions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across bundles. Primary pricing governance KPI for monitoring discount depth and protecting margin."
    - name: "total_bundle_price_value"
      expr: SUM(CAST(bundle_price_amount AS DOUBLE))
      comment: "Total sum of bundle prices across all active bundle records. Represents the gross price value of the bundle portfolio for financial planning."
    - name: "promotion_eligible_bundle_count"
      expr: COUNT(CASE WHEN promotion_eligible = TRUE THEN item_bundle_id END)
      comment: "Count of bundles eligible for promotional pricing. Quantifies promotional discount liability exposure in the bundle portfolio."
    - name: "promotion_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN promotion_eligible = TRUE THEN item_bundle_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bundles eligible for promotional pricing. Tracks promotional exposure concentration and discount liability risk."
    - name: "avg_component_quantity"
      expr: AVG(CAST(component_quantity AS DOUBLE))
      comment: "Average number of component units per bundle. Informs bundle complexity, inventory deduction planning, and fulfillment cost estimation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`product_attribute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product attribute data quality and certification metrics. Tracks attribute completeness, data quality scores, certification coverage, and regulatory compliance of product attributes to support master data governance, regulatory readiness, and searchability optimization."
  source: "`vibe_retail_v1`.`product`.`attribute`"
  dimensions:
    - name: "attribute_status"
      expr: attribute_status
      comment: "Current status of the attribute record (e.g., Active, Pending, Rejected). Primary filter for active attribute governance analysis."
    - name: "attribute_group"
      expr: attribute_group
      comment: "Logical grouping of the attribute (e.g., Physical, Nutritional, Regulatory). Enables attribute completeness analysis by business domain."
    - name: "is_certified"
      expr: is_certified
      comment: "Indicates whether the attribute value has been certified. Tracks certification coverage across the product attribute portfolio."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Indicates whether the attribute is required for regulatory compliance. Prioritizes data quality investment on mandatory regulatory attributes."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Indicates whether the attribute is used in product search. Tracks search-enabling attribute completeness, which directly impacts digital conversion."
    - name: "is_required"
      expr: is_required
      comment: "Indicates whether the attribute is a required field. Supports data completeness monitoring for mandatory product attributes."
    - name: "is_comparable"
      expr: is_comparable
      comment: "Indicates whether the attribute is used for product comparison. Tracks comparison-enabling attribute coverage for e-commerce product discovery."
    - name: "locale"
      expr: locale
      comment: "Locale for which the attribute value applies. Enables multi-locale attribute completeness analysis for international market readiness."
    - name: "data_type"
      expr: data_type
      comment: "Data type of the attribute value (e.g., String, Numeric, Boolean). Supports data governance and validation rule analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the attribute became effective. Tracks attribute enrichment cadence and new attribute introduction trends."
  measures:
    - name: "total_attributes"
      expr: COUNT(1)
      comment: "Total number of attribute records. Baseline measure for product attribute portfolio size and enrichment scope."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all product attributes. Primary master data governance KPI — low scores directly impact search relevance, compliance, and planning accuracy."
    - name: "certified_attribute_count"
      expr: COUNT(CASE WHEN is_certified = TRUE THEN attribute_id END)
      comment: "Count of certified attribute records. Tracks attribute certification coverage, which is required for regulatory submissions and trading partner data exchange."
    - name: "certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_certified = TRUE THEN attribute_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attributes that are certified. Core data governance KPI for regulatory readiness and trading partner compliance."
    - name: "regulatory_required_attribute_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN attribute_id END)
      comment: "Count of attributes flagged as regulatory requirements. Quantifies mandatory compliance attribute scope for regulatory audit preparation."
    - name: "searchable_attribute_count"
      expr: COUNT(CASE WHEN is_searchable = TRUE THEN attribute_id END)
      comment: "Count of attributes enabled for product search. Tracks search-enabling attribute coverage, which directly impacts e-commerce discoverability and conversion rates."
    - name: "distinct_skus_with_attributes"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with at least one attribute record. Measures product content enrichment coverage across the SKU portfolio."
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average unit of measure conversion factor across attributes. Supports UOM standardization governance and cross-system data consistency monitoring."
$$;