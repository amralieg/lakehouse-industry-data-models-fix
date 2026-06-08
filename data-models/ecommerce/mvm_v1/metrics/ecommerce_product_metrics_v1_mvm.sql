-- Metric views for domain: product | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core marketplace KPIs derived from product listings — covers pricing competitiveness, listing quality, buy-box eligibility, and fulfillment mix. Primary steering dashboard for Marketplace and Category Management teams."
  source: "`ecommerce_ecm`.`product`.`product_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the product listing (e.g. active, suppressed, inactive). Used to filter live vs. non-live inventory."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel through which the listing is published (e.g. web, mobile, marketplace). Enables channel-level performance analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment model for the listing (e.g. FBA, FBM, dropship). Critical for cost and delivery SLA analysis."
    - name: "condition_type"
      expr: condition_type
      comment: "Product condition (e.g. new, refurbished, used). Drives pricing strategy and return rate expectations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the listing price is denominated. Required for multi-currency normalization."
    - name: "buy_box_eligible_flag"
      expr: buy_box_eligible_flag
      comment: "Whether the listing is eligible to win the buy box. A key driver of conversion on marketplace platforms."
    - name: "featured_flag"
      expr: featured_flag
      comment: "Whether the listing is featured/promoted. Used to measure the incremental impact of featuring on sales velocity."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the listing is classified as hazardous material. Affects shipping eligibility and compliance reporting."
    - name: "listing_start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the listing went live. Used for cohort analysis of listing performance over time."
    - name: "listing_end_date"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the listing expired or was deactivated. Used to measure listing lifespan and churn."
  measures:
    - name: "total_active_listings"
      expr: COUNT(CASE WHEN listing_status = 'active' THEN product_listing_id END)
      comment: "Count of currently active listings. Baseline measure of live catalog breadth — a leading indicator of marketplace supply health."
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of listing records across all statuses. Used as the denominator for listing health rate calculations."
    - name: "buy_box_eligible_listing_count"
      expr: COUNT(CASE WHEN buy_box_eligible_flag = TRUE THEN product_listing_id END)
      comment: "Number of listings eligible for the buy box. Buy-box eligibility is the primary driver of conversion on marketplace platforms; executives track this to assess competitive positioning."
    - name: "avg_listing_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average listed selling price across all listings. Tracks pricing level trends and informs markdown and promotional strategy."
    - name: "avg_compare_at_price"
      expr: AVG(CAST(compare_at_price AS DOUBLE))
      comment: "Average reference/was price shown to customers. Used alongside avg_listing_price to measure average discount depth presented to shoppers."
    - name: "total_listing_price_value"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Sum of all listing prices — proxy for total catalog GMV potential. Used to size the addressable revenue pool of the live catalog."
    - name: "avg_listing_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average content and data quality score across listings. Low scores correlate with suppression and poor conversion; tracked by Catalog Ops to prioritize enrichment work."
    - name: "avg_listing_rating"
      expr: AVG(CAST(average_rating AS DOUBLE))
      comment: "Average customer rating across listings. A direct proxy for customer satisfaction and a key input to buy-box and search ranking algorithms."
    - name: "avg_shipping_weight_kg"
      expr: AVG(CAST(shipping_weight_kg AS DOUBLE))
      comment: "Average shipping weight of listed products in kilograms. Used by logistics and pricing teams to model fulfillment cost per listing."
    - name: "suppressed_listing_count"
      expr: COUNT(CASE WHEN listing_status = 'suppressed' THEN product_listing_id END)
      comment: "Number of suppressed listings. Suppression directly removes products from search and purchase flows, causing revenue loss; tracked as an operational health KPI."
    - name: "featured_listing_count"
      expr: COUNT(CASE WHEN featured_flag = TRUE THEN product_listing_id END)
      comment: "Number of featured/promoted listings. Used by merchandising teams to measure promotional catalog coverage and plan featuring budgets."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level product catalog health and compliance KPIs. Tracks variant coverage, compliance posture, fulfillment eligibility, and physical attribute completeness. Used by Catalog, Compliance, and Supply Chain teams."
  source: "`ecommerce_ecm`.`product`.`sku`"
  dimensions:
    - name: "sku_status"
      expr: sku_status
      comment: "Lifecycle status of the SKU (e.g. active, discontinued, pending). Primary filter for operational vs. retired inventory."
    - name: "variant_color"
      expr: variant_color
      comment: "Color variant of the SKU. Used for assortment planning and demand forecasting by color."
    - name: "variant_size"
      expr: variant_size
      comment: "Size variant of the SKU. Used for size-curve analysis and inventory allocation decisions."
    - name: "variant_material"
      expr: variant_material
      comment: "Material composition variant. Used for compliance, sustainability, and sourcing analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured. Critical for tariff, trade compliance, and supply chain risk reporting."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Type of packaging for the SKU. Affects shipping cost, sustainability scoring, and returns handling."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the SKU is classified as hazardous material. Drives fulfillment routing and regulatory compliance requirements."
    - name: "cpsc_compliant_flag"
      expr: cpsc_compliant_flag
      comment: "Whether the SKU meets CPSC safety compliance standards. Non-compliant SKUs cannot be sold in regulated markets."
    - name: "fba_eligible_flag"
      expr: fba_eligible_flag
      comment: "Whether the SKU is eligible for Fulfillment by Amazon or equivalent 3PL program. Affects fulfillment cost and Prime/fast-delivery eligibility."
    - name: "dtc_eligible_flag"
      expr: dtc_eligible_flag
      comment: "Whether the SKU is eligible for direct-to-consumer fulfillment. Used to measure DTC channel catalog coverage."
    - name: "bopis_eligible_flag"
      expr: bopis_eligible_flag
      comment: "Whether the SKU is eligible for Buy Online, Pick Up In Store. Used to measure omnichannel fulfillment coverage."
    - name: "perishable_flag"
      expr: perishable_flag
      comment: "Whether the SKU is perishable. Drives cold-chain logistics requirements and inventory expiry risk."
    - name: "sku_launch_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the SKU was launched. Used for new product introduction (NPI) velocity tracking."
    - name: "sku_discontinuation_month"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the SKU was discontinued. Used to measure catalog churn and end-of-life planning."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN sku_status = 'active' THEN sku_id END)
      comment: "Count of active SKUs in the catalog. Core measure of live assortment breadth — tracked by Category and Merchandising leadership."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total SKU count across all statuses. Used as denominator for compliance rate and eligibility rate calculations."
    - name: "cpsc_compliant_sku_count"
      expr: COUNT(CASE WHEN cpsc_compliant_flag = TRUE THEN sku_id END)
      comment: "Number of SKUs meeting CPSC safety compliance. Non-compliance exposes the business to regulatory fines and marketplace delisting; tracked by Legal and Compliance."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN sku_id END)
      comment: "Number of hazmat-classified SKUs. Used by Logistics and Compliance to size special handling requirements and associated cost."
    - name: "fba_eligible_sku_count"
      expr: COUNT(CASE WHEN fba_eligible_flag = TRUE THEN sku_id END)
      comment: "Number of SKUs eligible for FBA or equivalent 3PL fulfillment. Tracks the portion of catalog that can access fast-delivery programs, a key conversion driver."
    - name: "dtc_eligible_sku_count"
      expr: COUNT(CASE WHEN dtc_eligible_flag = TRUE THEN sku_id END)
      comment: "Number of SKUs eligible for direct-to-consumer fulfillment. Measures DTC channel catalog coverage for strategic channel mix decisions."
    - name: "bopis_eligible_sku_count"
      expr: COUNT(CASE WHEN bopis_eligible_flag = TRUE THEN sku_id END)
      comment: "Number of SKUs eligible for BOPIS. Measures omnichannel fulfillment readiness — a key metric for brick-and-mortar integration strategy."
    - name: "avg_sku_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average SKU weight in kilograms. Used by Supply Chain to model average shipping cost per unit and optimize packaging."
    - name: "total_sku_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all SKUs in kilograms. Used for bulk logistics planning and carrier contract negotiations."
    - name: "avg_sku_height_cm"
      expr: AVG(CAST(height_cm AS DOUBLE))
      comment: "Average SKU height in centimeters. Used alongside weight and other dimensions to model dimensional weight and warehouse slotting."
    - name: "avg_sku_width_cm"
      expr: AVG(CAST(width_cm AS DOUBLE))
      comment: "Average SKU width in centimeters. Used for warehouse slotting, packaging optimization, and carrier dimensional weight calculations."
    - name: "avg_sku_length_cm"
      expr: AVG(CAST(length_cm AS DOUBLE))
      comment: "Average SKU length in centimeters. Combined with height and width to compute volumetric weight for shipping cost modeling."
    - name: "distinct_country_of_origin_count"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin across the SKU catalog. Measures supply chain geographic concentration risk — high concentration in a single country increases tariff and disruption exposure."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_catalog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product catalog item KPIs covering assortment health, compliance posture, physical attribute completeness, and lifecycle management. Used by Catalog, Compliance, and Product Management teams."
  source: "`ecommerce_ecm`.`product`.`catalog_item`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the catalog item (e.g. active, end-of-life, discontinued). Primary filter for live vs. retired catalog."
    - name: "product_type"
      expr: product_type
      comment: "High-level product type classification. Used for assortment mix analysis and category strategy."
    - name: "product_subcategory"
      expr: product_subcategory
      comment: "Sub-category classification of the catalog item. Enables granular category performance analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is manufactured. Used for trade compliance, tariff analysis, and supply chain risk management."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Name of the product manufacturer. Used for vendor performance analysis and compliance tracking."
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Whether the catalog item is classified as hazardous. Drives special handling, shipping restrictions, and regulatory compliance."
    - name: "is_returnable"
      expr: is_returnable
      comment: "Whether the catalog item is eligible for return. Affects return rate modeling and customer satisfaction."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the catalog item is subject to sales tax. Required for tax liability reporting and pricing strategy."
    - name: "is_age_restricted"
      expr: is_age_restricted
      comment: "Whether the catalog item has age restrictions. Affects listing eligibility and compliance requirements by jurisdiction."
    - name: "cpsc_compliance_status"
      expr: cpsc_compliance_status
      comment: "CPSC compliance status of the catalog item. Non-compliant items cannot be listed in regulated markets; tracked by Legal and Compliance."
    - name: "pim_source_system"
      expr: pim_source_system
      comment: "Source PIM system that originated the catalog item record. Used for data lineage and integration quality monitoring."
    - name: "catalog_item_launch_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the catalog item was launched. Used for new product introduction (NPI) velocity and time-to-market analysis."
    - name: "catalog_item_end_of_life_month"
      expr: DATE_TRUNC('month', end_of_life_date)
      comment: "Month the catalog item reached end-of-life. Used for catalog churn analysis and lifecycle planning."
  measures:
    - name: "total_catalog_items"
      expr: COUNT(1)
      comment: "Total number of catalog items. Baseline measure of catalog breadth — a key input to assortment strategy and marketplace supply health."
    - name: "active_catalog_item_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN catalog_item_id END)
      comment: "Number of catalog items in active lifecycle status. Measures the live, sellable catalog size — a primary KPI for Catalog and Category leadership."
    - name: "hazmat_catalog_item_count"
      expr: COUNT(CASE WHEN is_hazardous_material = TRUE THEN catalog_item_id END)
      comment: "Number of hazardous material catalog items. Used by Logistics and Compliance to size special handling requirements and associated regulatory exposure."
    - name: "non_returnable_catalog_item_count"
      expr: COUNT(CASE WHEN is_returnable = FALSE THEN catalog_item_id END)
      comment: "Number of catalog items not eligible for return. Tracks the portion of catalog with no-return policy — relevant for customer satisfaction and dispute management."
    - name: "age_restricted_catalog_item_count"
      expr: COUNT(CASE WHEN is_age_restricted = TRUE THEN catalog_item_id END)
      comment: "Number of age-restricted catalog items. Used by Compliance and Legal to ensure proper age-gate controls are in place across the catalog."
    - name: "avg_catalog_item_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight of catalog items in kilograms. Used by Supply Chain and Logistics to model average fulfillment cost per item."
    - name: "avg_catalog_item_height_cm"
      expr: AVG(CAST(height_cm AS DOUBLE))
      comment: "Average height of catalog items in centimeters. Used for warehouse slotting and dimensional weight calculations."
    - name: "avg_catalog_item_width_cm"
      expr: AVG(CAST(width_cm AS DOUBLE))
      comment: "Average width of catalog items in centimeters. Used for packaging optimization and carrier dimensional weight modeling."
    - name: "avg_catalog_item_length_cm"
      expr: AVG(CAST(length_cm AS DOUBLE))
      comment: "Average length of catalog items in centimeters. Combined with height and width to compute volumetric weight for shipping cost modeling."
    - name: "distinct_manufacturer_count"
      expr: COUNT(DISTINCT manufacturer_name)
      comment: "Number of distinct manufacturers represented in the catalog. Measures supplier diversification — concentration risk is a key supply chain resilience metric."
    - name: "distinct_country_of_origin_count"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin in the catalog. Tracks geographic supply chain diversification — high concentration increases tariff and disruption risk."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio health and quality KPIs. Tracks brand verification, exclusivity, sustainability, customer satisfaction, and portfolio composition. Used by Brand Management, Merchandising, and Sustainability teams."
  source: "`ecommerce_ecm`.`product`.`brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g. active, suspended, pending). Used to filter the live brand portfolio."
    - name: "brand_tier"
      expr: tier
      comment: "Brand tier classification (e.g. premium, standard, economy). Used for tiered merchandising strategy and margin analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the brand is exclusive to this marketplace. Exclusive brands are a key competitive differentiator and margin driver."
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the brand has been verified/authenticated. Unverified brands carry counterfeit and compliance risk."
    - name: "owner_type"
      expr: owner_type
      comment: "Type of brand owner (e.g. first-party, third-party seller, licensed). Drives margin structure and compliance obligations."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the brand. Used for trade compliance and geographic market analysis."
    - name: "manufacturer_country"
      expr: manufacturer_country
      comment: "Country where brand products are manufactured. Used for supply chain risk and tariff analysis."
    - name: "brand_registration_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month the brand was registered on the platform. Used for brand onboarding velocity and cohort analysis."
    - name: "brand_approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the brand was approved. Used to measure brand onboarding cycle time and approval funnel efficiency."
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Total number of brands in the portfolio. Baseline measure of brand catalog breadth — tracked by Brand Management leadership."
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN brand_status = 'active' THEN brand_id END)
      comment: "Number of active brands. Measures the live, sellable brand portfolio size — a primary KPI for Merchandising and Category strategy."
    - name: "exclusive_brand_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN brand_id END)
      comment: "Number of exclusive brands. Exclusive brands drive differentiation and higher margins; tracked by executives as a competitive moat metric."
    - name: "verified_brand_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN brand_id END)
      comment: "Number of verified/authenticated brands. Brand verification reduces counterfeit risk and improves customer trust; tracked by Trust & Safety and Compliance."
    - name: "avg_brand_rating"
      expr: AVG(CAST(average_rating AS DOUBLE))
      comment: "Average customer rating across brands. A direct measure of brand-level customer satisfaction — low scores trigger brand review and potential delisting."
    - name: "avg_brand_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across brands. Tracked by ESG and Sustainability teams to measure progress toward sustainable sourcing commitments."
    - name: "total_brand_sustainability_score"
      expr: SUM(CAST(sustainability_score AS DOUBLE))
      comment: "Sum of sustainability scores across all brands. Used as a portfolio-level sustainability index for ESG reporting."
    - name: "distinct_country_of_origin_count"
      expr: COUNT(DISTINCT country_of_origin)
      comment: "Number of distinct countries of origin across the brand portfolio. Measures geographic diversification of the brand base — concentration risk indicator for supply chain resilience."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category taxonomy health and commercial configuration KPIs. Tracks category structure, commission rates, margin benchmarks, and compliance requirements. Used by Category Management, Finance, and Compliance teams."
  source: "`ecommerce_ecm`.`product`.`category`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Whether the category is currently active and navigable. Used to filter the live category taxonomy."
    - name: "is_featured"
      expr: is_featured
      comment: "Whether the category is featured on the homepage or navigation. Used to measure promotional category coverage."
    - name: "is_leaf"
      expr: is_leaf
      comment: "Whether the category is a leaf node (no children). Leaf categories are where products are actually assigned — used for taxonomy depth analysis."
    - name: "is_navigable"
      expr: is_navigable
      comment: "Whether the category is visible in site navigation. Non-navigable categories are hidden from customers — used for UX and SEO analysis."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Whether the category is indexed for search. Non-searchable categories are invisible to search — used for discoverability analysis."
    - name: "requires_age_verification"
      expr: requires_age_verification
      comment: "Whether the category requires age verification at purchase. Used by Compliance to ensure proper age-gate controls are implemented."
    - name: "requires_cpsc_compliance"
      expr: requires_cpsc_compliance
      comment: "Whether the category requires CPSC compliance for listed products. Used by Compliance to enforce safety standards at the category level."
    - name: "taxonomy_standard"
      expr: taxonomy_standard
      comment: "Taxonomy standard used for the category (e.g. GS1, Google Product Taxonomy). Used for cross-platform catalog interoperability analysis."
    - name: "default_shipping_class"
      expr: default_shipping_class
      comment: "Default shipping class assigned to products in this category. Used by Logistics to model category-level fulfillment cost."
    - name: "hazmat_classification"
      expr: hazmat_classification
      comment: "Hazmat classification for the category. Used by Logistics and Compliance to enforce special handling requirements."
    - name: "category_depth_level"
      expr: depth_level
      comment: "Depth level of the category in the taxonomy hierarchy. Used for taxonomy structure analysis and navigation UX optimization."
    - name: "category_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the category was created. Used to track taxonomy expansion velocity over time."
  measures:
    - name: "total_categories"
      expr: COUNT(1)
      comment: "Total number of categories in the taxonomy. Baseline measure of catalog taxonomy breadth — tracked by Category Management."
    - name: "active_category_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN category_id END)
      comment: "Number of active categories. Measures the live, navigable taxonomy size — a key input to site architecture and SEO strategy."
    - name: "leaf_category_count"
      expr: COUNT(CASE WHEN is_leaf = TRUE THEN category_id END)
      comment: "Number of leaf categories (where products are assigned). Measures the granularity of the product taxonomy — too few leaves indicate over-broad categorization."
    - name: "avg_category_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across categories. Tracks the blended take rate of the marketplace — a primary revenue lever for Finance and Strategy teams."
    - name: "avg_category_margin_pct"
      expr: AVG(CAST(average_margin_percent AS DOUBLE))
      comment: "Average margin percentage across categories. Tracks category-level profitability — used by Finance and Category Management to prioritize high-margin category investment."
    - name: "max_category_commission_rate_pct"
      expr: MAX(CAST(commission_rate_percent AS DOUBLE))
      comment: "Maximum commission rate across categories. Used to identify the highest take-rate categories for revenue concentration analysis."
    - name: "min_category_commission_rate_pct"
      expr: MIN(CAST(commission_rate_percent AS DOUBLE))
      comment: "Minimum commission rate across categories. Used alongside max to understand the commission rate spread and identify underpriced categories."
    - name: "cpsc_required_category_count"
      expr: COUNT(CASE WHEN requires_cpsc_compliance = TRUE THEN category_id END)
      comment: "Number of categories requiring CPSC compliance. Used by Compliance to size the regulatory compliance burden and prioritize enforcement resources."
    - name: "age_verification_required_category_count"
      expr: COUNT(CASE WHEN requires_age_verification = TRUE THEN category_id END)
      comment: "Number of categories requiring age verification. Used by Compliance and Legal to ensure age-gate controls are properly implemented across regulated categories."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundle product KPIs covering pricing strategy, discount depth, physical attributes, and catalog health. Used by Merchandising, Pricing, and Category Management teams to optimize bundle assortment and profitability."
  source: "`ecommerce_ecm`.`product`.`bundle`"
  dimensions:
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle (e.g. active, discontinued, draft). Used to filter the live bundle catalog."
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of bundle (e.g. fixed, configurable, subscription). Used for bundle strategy analysis and pricing model selection."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied to the bundle (e.g. fixed, dynamic, promotional). Used by Pricing teams to analyze strategy mix and effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the bundle is priced. Required for multi-currency normalization."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Whether the bundle allows customer configuration. Configurable bundles have higher engagement but more complex fulfillment."
    - name: "is_returnable"
      expr: is_returnable
      comment: "Whether the bundle is eligible for return. Affects return rate modeling and customer satisfaction."
    - name: "is_subscription_eligible"
      expr: is_subscription_eligible
      comment: "Whether the bundle is eligible for subscription purchase. Subscription eligibility drives recurring revenue — tracked by Growth and Retention teams."
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether the bundle is a virtual/digital product. Virtual bundles have zero fulfillment cost — used for margin analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the bundle. Used for trade compliance and tariff analysis."
    - name: "shipping_class"
      expr: shipping_class
      comment: "Shipping class assigned to the bundle. Used by Logistics to model fulfillment cost per bundle."
    - name: "bundle_effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the bundle became effective. Used for bundle launch cohort analysis."
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of bundle records. Baseline measure of bundle catalog size — tracked by Merchandising."
    - name: "active_bundle_count"
      expr: COUNT(CASE WHEN bundle_status = 'active' THEN bundle_id END)
      comment: "Number of active bundles. Measures the live bundle assortment — a key input to cross-sell and upsell strategy."
    - name: "subscription_eligible_bundle_count"
      expr: COUNT(CASE WHEN is_subscription_eligible = TRUE THEN bundle_id END)
      comment: "Number of bundles eligible for subscription. Subscription-eligible bundles drive recurring revenue — tracked by Growth and Retention leadership."
    - name: "avg_bundle_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average bundle selling price. Tracks bundle pricing level trends and informs promotional and markdown strategy."
    - name: "avg_bundle_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average bundle list (reference) price. Used alongside avg_bundle_price to measure average discount depth presented to customers."
    - name: "avg_bundle_discount_pct"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to bundles. Tracks the average promotional depth across the bundle catalog — a key input to margin and promotional strategy."
    - name: "total_bundle_price_value"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Sum of all bundle prices — proxy for total bundle catalog GMV potential. Used to size the addressable revenue pool of the bundle assortment."
    - name: "avg_bundle_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average total weight of bundles in kilograms. Used by Logistics to model average fulfillment cost per bundle shipment."
    - name: "max_bundle_discount_pct"
      expr: MAX(CAST(discount_percentage AS DOUBLE))
      comment: "Maximum discount percentage applied to any bundle. Used to identify outlier promotional bundles that may be margin-dilutive."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_relation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product relationship performance KPIs covering cross-sell, upsell, and recommendation effectiveness. Tracks click-through rates, conversion rates, and attributed revenue from product relations. Used by Merchandising, Personalization, and Revenue teams."
  source: "`ecommerce_ecm`.`product`.`relation`"
  dimensions:
    - name: "relation_type"
      expr: relation_type
      comment: "Type of product relationship (e.g. cross-sell, upsell, substitute, accessory). Used to analyze the effectiveness of each relation strategy."
    - name: "relation_source"
      expr: relation_source
      comment: "Source of the relation (e.g. manual, algorithmic, ML model). Used to compare human-curated vs. algorithm-generated relation performance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the relation (e.g. approved, pending, rejected). Used to filter live vs. pending relations."
    - name: "is_active"
      expr: is_active
      comment: "Whether the relation is currently active. Used to filter the live relation graph."
    - name: "relation_effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the relation became effective. Used for cohort analysis of relation performance over time."
    - name: "last_performance_update_month"
      expr: DATE_TRUNC('month', last_performance_update_timestamp)
      comment: "Month of the last performance data refresh. Used to identify stale relation performance data."
  measures:
    - name: "total_active_relations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN relation_id END)
      comment: "Number of active product relations. Measures the breadth of the product recommendation graph — a key input to cross-sell and upsell coverage."
    - name: "total_impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total impressions generated by product relations. Measures the reach of the recommendation engine — used to size the opportunity for conversion optimization."
    - name: "total_clicks"
      expr: SUM(CAST(total_clicks AS DOUBLE))
      comment: "Total clicks generated by product relations. Measures customer engagement with recommendations — a leading indicator of cross-sell and upsell effectiveness."
    - name: "total_conversions"
      expr: SUM(CAST(total_conversions AS DOUBLE))
      comment: "Total conversions attributed to product relations. Measures the direct revenue-generating impact of the recommendation graph."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to product relations. The primary financial KPI for the recommendation engine — used by Revenue and Merchandising leadership to justify investment."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate across product relations. Measures recommendation relevance — low CTR signals poor relation quality or placement issues."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across product relations. Measures how effectively recommendations drive purchases — the primary quality KPI for the recommendation engine."
    - name: "avg_relation_strength_score"
      expr: AVG(CAST(strength_score AS DOUBLE))
      comment: "Average strength score of product relations. Measures the algorithmic confidence in relation quality — used to benchmark and tune the recommendation model."
    - name: "avg_attributed_revenue_per_relation"
      expr: AVG(CAST(revenue_attributed AS DOUBLE))
      comment: "Average revenue attributed per product relation. Used to identify high-value relation types and prioritize curation effort on the most impactful relation categories."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_attribute_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product attribute data quality and enrichment KPIs. Tracks enrichment completeness, data quality scores, and attribute coverage across the catalog. Used by Catalog Operations, Data Quality, and PIM teams."
  source: "`ecommerce_ecm`.`product`.`attribute_value`"
  dimensions:
    - name: "enrichment_status"
      expr: enrichment_status
      comment: "Current enrichment status of the attribute value (e.g. enriched, pending, failed). Used to track enrichment pipeline health."
    - name: "is_active"
      expr: is_active
      comment: "Whether the attribute value is currently active. Used to filter live vs. deprecated attribute values."
    - name: "is_variant_defining"
      expr: is_variant_defining
      comment: "Whether the attribute value defines a product variant (e.g. color, size). Variant-defining attributes are critical for SKU differentiation."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Whether the attribute value is indexed for search. Non-searchable attributes are invisible to search — affects product discoverability."
    - name: "is_comparable"
      expr: is_comparable
      comment: "Whether the attribute value is used in product comparison. Comparable attributes drive purchase decision-making on PDPs."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale for which the attribute value is defined. Used for internationalization coverage analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system that provided the attribute value. Used for data lineage and integration quality monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag on the attribute value. Used by Compliance teams to identify attribute values with regulatory implications."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the attribute value. Used for data normalization and cross-product comparability."
    - name: "enrichment_month"
      expr: DATE_TRUNC('month', enrichment_timestamp)
      comment: "Month the attribute value was enriched. Used to track enrichment pipeline throughput over time."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the attribute value became effective. Used for attribute value lifecycle analysis."
  measures:
    - name: "total_attribute_values"
      expr: COUNT(1)
      comment: "Total number of attribute value records. Baseline measure of catalog attribute coverage breadth."
    - name: "enriched_attribute_value_count"
      expr: COUNT(CASE WHEN enrichment_status = 'enriched' THEN attribute_value_id END)
      comment: "Number of fully enriched attribute values. Measures enrichment pipeline completion — low enrichment rates correlate with poor search relevance and conversion."
    - name: "active_attribute_value_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN attribute_value_id END)
      comment: "Number of active attribute values. Measures the live attribute data coverage across the catalog."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across attribute values. The primary KPI for catalog data quality — low scores drive poor search ranking, conversion, and compliance failures."
    - name: "avg_raw_numeric_value"
      expr: AVG(CAST(raw_value AS DOUBLE))
      comment: "Average raw numeric attribute value. Used for attribute distribution analysis and outlier detection in numeric product specifications."
    - name: "distinct_locale_count"
      expr: COUNT(DISTINCT locale_code)
      comment: "Number of distinct locales with attribute value coverage. Measures internationalization completeness — gaps indicate markets with incomplete product data."
    - name: "variant_defining_attribute_count"
      expr: COUNT(CASE WHEN is_variant_defining = TRUE THEN attribute_value_id END)
      comment: "Number of variant-defining attribute values. Measures the richness of variant differentiation in the catalog — critical for accurate product display and inventory management."
$$;