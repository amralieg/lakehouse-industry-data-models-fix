-- Metric views for domain: product | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_catalog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core product catalog performance metrics tracking revenue, pricing, and lifecycle health across genomics product portfolio"
  source: "`genomics_biotech_ecm`.`product`.`catalog_item`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "Product category classification (sequencing, arrays, gene-editing, etc.)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current product lifecycle stage (launch, growth, mature, decline, EOL)"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification tier (IVD, RUO, CE-IVD, etc.)"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "Good Manufacturing Practice classification level"
    - name: "is_active"
      expr: is_active
      comment: "Whether product is currently active and orderable"
    - name: "is_bundle"
      expr: is_bundle
      comment: "Whether catalog item represents a product bundle"
    - name: "sequencing_chemistry"
      expr: sequencing_chemistry
      comment: "Sequencing chemistry type for sequencing products"
    - name: "instrument_platform_compatibility"
      expr: instrument_platform_compatibility
      comment: "Compatible instrument platforms for this product"
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Whether product requires cold chain logistics"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year product was launched to market"
    - name: "launch_quarter"
      expr: CONCAT('Q', QUARTER(launch_date), '-', YEAR(launch_date))
      comment: "Quarter and year product was launched"
  measures:
    - name: "active_product_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN catalog_item_id END)
      comment: "Count of active, orderable products in catalog"
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price across all catalog items"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per catalog item"
    - name: "total_avg_selling_price"
      expr: SUM(CAST(average_selling_price AS DOUBLE))
      comment: "Total average selling price realized across products"
    - name: "avg_selling_price_per_product"
      expr: AVG(CAST(average_selling_price AS DOUBLE))
      comment: "Average selling price per product (mean ASP)"
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across catalog"
    - name: "avg_cogs_per_product"
      expr: AVG(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Average cost of goods sold per product"
    - name: "gross_margin_dollars"
      expr: SUM((CAST(average_selling_price AS DOUBLE)) - (CAST(cost_of_goods_sold AS DOUBLE)))
      comment: "Total gross margin dollars (ASP minus COGS) across catalog"
    - name: "avg_bundle_discount_pct"
      expr: AVG(CAST(bundle_discount_percentage AS DOUBLE))
      comment: "Average bundle discount percentage offered"
    - name: "cold_chain_product_count"
      expr: COUNT(DISTINCT CASE WHEN requires_cold_chain = TRUE THEN catalog_item_id END)
      comment: "Count of products requiring cold chain logistics"
    - name: "eol_product_count"
      expr: COUNT(DISTINCT CASE WHEN end_of_life_date IS NOT NULL AND end_of_life_date <= CURRENT_DATE() THEN catalog_item_id END)
      comment: "Count of products that have reached end-of-life"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level operational metrics tracking inventory, pricing, and supply chain performance for genomics products"
  source: "`genomics_biotech_ecm`.`product`.`sku`"
  dimensions:
    - name: "sku_type"
      expr: sku_type
      comment: "SKU type classification (finished good, component, service, etc.)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of SKU"
    - name: "is_orderable"
      expr: is_orderable
      comment: "Whether SKU can currently be ordered"
    - name: "is_shippable"
      expr: is_shippable
      comment: "Whether SKU can be shipped directly"
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Whether SKU is classified as hazardous material"
    - name: "requires_cold_chain"
      expr: requires_cold_chain
      comment: "Whether SKU requires cold chain handling"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of SKU"
    - name: "country_availability"
      expr: country_availability
      comment: "Countries where SKU is available for sale"
    - name: "sales_channel_eligibility"
      expr: sales_channel_eligibility
      comment: "Sales channels eligible to sell this SKU"
    - name: "introduction_year"
      expr: YEAR(introduction_date)
      comment: "Year SKU was introduced"
  measures:
    - name: "orderable_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_orderable = TRUE THEN sku_id END)
      comment: "Count of SKUs currently available for ordering"
    - name: "total_list_price_usd"
      expr: SUM(CAST(list_price_usd AS DOUBLE))
      comment: "Total list price in USD across all SKUs"
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price per SKU in USD"
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost_usd AS DOUBLE))
      comment: "Total standard cost in USD across all SKUs"
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost per SKU in USD"
    - name: "total_asp_usd"
      expr: SUM(CAST(average_selling_price_usd AS DOUBLE))
      comment: "Total average selling price in USD across SKUs"
    - name: "avg_asp_usd"
      expr: AVG(CAST(average_selling_price_usd AS DOUBLE))
      comment: "Average selling price per SKU in USD"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all SKUs"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per SKU in kilograms"
    - name: "total_volume_liters"
      expr: SUM(CAST(volume_liters AS DOUBLE))
      comment: "Total volume in liters across all SKUs"
    - name: "hazmat_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazardous_material = TRUE THEN sku_id END)
      comment: "Count of SKUs classified as hazardous materials"
    - name: "cold_chain_sku_count"
      expr: COUNT(DISTINCT CASE WHEN requires_cold_chain = TRUE THEN sku_id END)
      comment: "Count of SKUs requiring cold chain logistics"
    - name: "discontinued_sku_count"
      expr: COUNT(DISTINCT CASE WHEN discontinuation_date IS NOT NULL AND discontinuation_date <= CURRENT_DATE() THEN sku_id END)
      comment: "Count of SKUs that have been discontinued"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing strategy and margin analysis metrics tracking price realization, discounting, and profitability across customer segments and channels"
  source: "`genomics_biotech_ecm`.`product`.`pricing`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of pricing (list, contract, promotional, volume tier)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment this pricing applies to"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for this pricing"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for pricing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for pricing"
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Whether this is promotional pricing"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of pricing record"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification affecting pricing"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year pricing became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter pricing became effective"
  measures:
    - name: "active_pricing_record_count"
      expr: COUNT(DISTINCT CASE WHEN effective_start_date <= CURRENT_DATE() AND (effective_end_date IS NULL OR effective_end_date >= CURRENT_DATE()) THEN pricing_id END)
      comment: "Count of currently active pricing records"
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price across all pricing records"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per pricing record"
    - name: "total_unit_price"
      expr: SUM(CAST(unit_price AS DOUBLE))
      comment: "Total unit price (actual selling price) across records"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per pricing record"
    - name: "total_asp"
      expr: SUM(CAST(asp AS DOUBLE))
      comment: "Total average selling price across pricing records"
    - name: "avg_asp"
      expr: AVG(CAST(asp AS DOUBLE))
      comment: "Average ASP per pricing record"
    - name: "total_cost_price"
      expr: SUM(CAST(cost_price AS DOUBLE))
      comment: "Total cost price across pricing records"
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price per pricing record"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered"
    - name: "avg_margin_percentage"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average margin percentage across pricing records"
    - name: "promotional_pricing_count"
      expr: COUNT(DISTINCT CASE WHEN promotional_flag = TRUE THEN pricing_id END)
      comment: "Count of promotional pricing records"
    - name: "total_transfer_price"
      expr: SUM(CAST(transfer_price AS DOUBLE))
      comment: "Total transfer price for inter-company transactions"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product family portfolio metrics tracking strategic positioning, lifecycle health, and cross-sell performance across genomics technology platforms"
  source: "`genomics_biotech_ecm`.`product`.`family`"
  dimensions:
    - name: "family_type"
      expr: family_type
      comment: "Type of product family (platform, consumable, software, service)"
    - name: "technology_platform"
      expr: technology_platform
      comment: "Underlying technology platform for this family"
    - name: "application_area"
      expr: application_area
      comment: "Primary application area (clinical, research, agricultural, etc.)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of product family"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning this product family"
    - name: "go_to_market_segment"
      expr: go_to_market_segment
      comment: "Target go-to-market segment"
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier (tier 1, 2, 3)"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of family"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether product family is currently active"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year family was launched"
  measures:
    - name: "active_family_count"
      expr: COUNT(DISTINCT CASE WHEN active_flag = TRUE THEN family_id END)
      comment: "Count of active product families"
    - name: "total_avg_selling_price_usd"
      expr: SUM(CAST(average_selling_price_usd AS DOUBLE))
      comment: "Total average selling price in USD across families"
    - name: "avg_selling_price_per_family"
      expr: AVG(CAST(average_selling_price_usd AS DOUBLE))
      comment: "Average selling price per product family"
    - name: "avg_target_margin_pct"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target margin percentage across families"
    - name: "avg_cross_sell_affinity_score"
      expr: AVG(CAST(cross_sell_affinity_score AS DOUBLE))
      comment: "Average cross-sell affinity score indicating bundle potential"
    - name: "eol_family_count"
      expr: COUNT(DISTINCT CASE WHEN end_of_life_date IS NOT NULL AND end_of_life_date <= CURRENT_DATE() THEN family_id END)
      comment: "Count of families that have reached end-of-life"
    - name: "tier1_priority_family_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_priority_tier = 'Tier 1' THEN family_id END)
      comment: "Count of tier 1 strategic priority families"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification and performance metrics tracking technical capabilities, quality thresholds, and regulatory compliance for genomics assays and instruments"
  source: "`genomics_biotech_ecm`.`product`.`specification`"
  dimensions:
    - name: "specification_status"
      expr: specification_status
      comment: "Current status of specification (draft, approved, obsolete)"
    - name: "product_category"
      expr: product_category
      comment: "Product category for this specification"
    - name: "product_lifecycle_stage"
      expr: product_lifecycle_stage
      comment: "Lifecycle stage of product this spec applies to"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification tier"
    - name: "instrument_compatibility"
      expr: instrument_compatibility
      comment: "Compatible instruments for this specification"
    - name: "flow_cell_type"
      expr: flow_cell_type
      comment: "Flow cell type for sequencing specifications"
    - name: "library_compatibility"
      expr: library_compatibility
      comment: "Compatible library prep methods"
    - name: "ce_marking_status"
      expr: ce_marking_status
      comment: "Whether product has CE marking"
    - name: "iso_13485_compliant_flag"
      expr: iso_13485_compliant_flag
      comment: "Whether specification meets ISO 13485 quality standard"
    - name: "clia_applicable_flag"
      expr: clia_applicable_flag
      comment: "Whether CLIA regulations apply"
  measures:
    - name: "approved_spec_count"
      expr: COUNT(DISTINCT CASE WHEN specification_status = 'Approved' THEN specification_id END)
      comment: "Count of approved specifications"
    - name: "avg_throughput_gb_per_run"
      expr: AVG(CAST(throughput_gb_per_run AS DOUBLE))
      comment: "Average throughput in gigabases per sequencing run"
    - name: "avg_q30_score_threshold_pct"
      expr: AVG(CAST(q30_score_threshold_percent AS DOUBLE))
      comment: "Average Q30 quality score threshold percentage"
    - name: "avg_cluster_density_k_per_mm2"
      expr: AVG(CAST(cluster_density_k_per_mm2 AS DOUBLE))
      comment: "Average cluster density in thousands per square millimeter"
    - name: "avg_reaction_volume_ul"
      expr: AVG(CAST(reaction_volume_ul AS DOUBLE))
      comment: "Average reaction volume in microliters"
    - name: "avg_lod_copies_per_ml"
      expr: AVG(CAST(lod_copies_per_ml AS DOUBLE))
      comment: "Average limit of detection in copies per milliliter"
    - name: "avg_cnv_resolution_kb"
      expr: AVG(CAST(cnv_resolution_kb AS DOUBLE))
      comment: "Average copy number variation resolution in kilobases"
    - name: "avg_crispr_target_specificity_pct"
      expr: AVG(CAST(crispr_target_specificity_percent AS DOUBLE))
      comment: "Average CRISPR target specificity percentage"
    - name: "avg_asp_usd"
      expr: AVG(CAST(average_selling_price_usd AS DOUBLE))
      comment: "Average selling price in USD for products meeting this spec"
    - name: "avg_cogs_usd"
      expr: AVG(CAST(cost_of_goods_sold_usd AS DOUBLE))
      comment: "Average cost of goods sold in USD for products meeting this spec"
    - name: "ce_marked_spec_count"
      expr: COUNT(DISTINCT CASE WHEN ce_marking_status = TRUE THEN specification_id END)
      comment: "Count of specifications with CE marking"
    - name: "iso_compliant_spec_count"
      expr: COUNT(DISTINCT CASE WHEN iso_13485_compliant_flag = TRUE THEN specification_id END)
      comment: "Count of ISO 13485 compliant specifications"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product bundle performance metrics tracking bundle pricing, discounting, and configuration effectiveness for genomics solution packages"
  source: "`genomics_biotech_ecm`.`product`.`bundle`"
  dimensions:
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of bundle (starter kit, complete solution, upgrade package)"
    - name: "bundle_category"
      expr: bundle_category
      comment: "Category classification of bundle"
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of bundle (active, discontinued, pending)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of bundle"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of bundle"
    - name: "target_market"
      expr: target_market
      comment: "Target market segment for bundle"
    - name: "is_customizable"
      expr: is_customizable
      comment: "Whether bundle can be customized by customer"
    - name: "support_level"
      expr: support_level
      comment: "Support level included in bundle"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year bundle was released"
  measures:
    - name: "active_bundle_count"
      expr: COUNT(DISTINCT CASE WHEN bundle_status = 'Active' THEN bundle_id END)
      comment: "Count of active bundles available for sale"
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price across all bundles"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per bundle"
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price (after discounts) across bundles"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per bundle"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage offered on bundles"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all bundles"
    - name: "avg_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per bundle in kilograms"
    - name: "customizable_bundle_count"
      expr: COUNT(DISTINCT CASE WHEN is_customizable = TRUE THEN bundle_id END)
      comment: "Count of bundles that can be customized"
    - name: "deprecated_bundle_count"
      expr: COUNT(DISTINCT CASE WHEN deprecation_date IS NOT NULL AND deprecation_date <= CURRENT_DATE() THEN bundle_id END)
      comment: "Count of bundles that have been deprecated"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_software_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software release quality and compliance metrics tracking release velocity, regulatory clearance, and deployment readiness for genomics bioinformatics platforms"
  source: "`genomics_biotech_ecm`.`product`.`software_release`"
  dimensions:
    - name: "release_type"
      expr: release_type
      comment: "Type of release (major, minor, patch, hotfix)"
    - name: "release_status"
      expr: release_status
      comment: "Current status of release (planned, in development, released, deprecated)"
    - name: "qa_approval_status"
      expr: qa_approval_status
      comment: "QA approval status for release"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of software"
    - name: "license_model"
      expr: license_model
      comment: "License model (perpetual, subscription, usage-based)"
    - name: "backward_compatible_flag"
      expr: backward_compatible_flag
      comment: "Whether release is backward compatible"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required for this release"
    - name: "supported_os_platforms"
      expr: supported_os_platforms
      comment: "Operating system platforms supported"
    - name: "supported_cloud_platforms"
      expr: supported_cloud_platforms
      comment: "Cloud platforms supported"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year of software release"
    - name: "release_quarter"
      expr: CONCAT('Q', QUARTER(release_date), '-', YEAR(release_date))
      comment: "Quarter of software release"
  measures:
    - name: "released_version_count"
      expr: COUNT(DISTINCT CASE WHEN release_status = 'Released' THEN software_release_id END)
      comment: "Count of released software versions"
    - name: "qa_approved_release_count"
      expr: COUNT(DISTINCT CASE WHEN qa_approval_status = 'Approved' THEN software_release_id END)
      comment: "Count of QA-approved releases"
    - name: "avg_package_size_mb"
      expr: AVG(CAST(package_size_mb AS DOUBLE))
      comment: "Average package size in megabytes"
    - name: "total_package_size_mb"
      expr: SUM(CAST(package_size_mb AS DOUBLE))
      comment: "Total package size across all releases in megabytes"
    - name: "backward_compatible_release_count"
      expr: COUNT(DISTINCT CASE WHEN backward_compatible_flag = TRUE THEN software_release_id END)
      comment: "Count of backward compatible releases"
    - name: "training_required_release_count"
      expr: COUNT(DISTINCT CASE WHEN training_required_flag = TRUE THEN software_release_id END)
      comment: "Count of releases requiring user training"
    - name: "fda_cleared_release_count"
      expr: COUNT(DISTINCT CASE WHEN fda_clearance_number IS NOT NULL THEN software_release_id END)
      comment: "Count of FDA-cleared software releases"
    - name: "ce_marked_release_count"
      expr: COUNT(DISTINCT CASE WHEN ce_mark_certificate_number IS NOT NULL THEN software_release_id END)
      comment: "Count of CE-marked software releases"
    - name: "eol_release_count"
      expr: COUNT(DISTINCT CASE WHEN end_of_life_date IS NOT NULL AND end_of_life_date <= CURRENT_DATE() THEN software_release_id END)
      comment: "Count of releases that have reached end-of-life"
    - name: "eos_release_count"
      expr: COUNT(DISTINCT CASE WHEN end_of_support_date IS NOT NULL AND end_of_support_date <= CURRENT_DATE() THEN software_release_id END)
      comment: "Count of releases that have reached end-of-support"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service offering performance metrics tracking service pricing, delivery capacity, and customer engagement for genomics professional services and support"
  source: "`genomics_biotech_ecm`.`product`.`service_offering`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "Category of service (training, consulting, support, assay development)"
    - name: "service_subcategory"
      expr: service_subcategory
      comment: "Subcategory classification of service"
    - name: "service_status"
      expr: service_status
      comment: "Current status of service offering"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery mode (on-site, remote, hybrid)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model (fixed, hourly, per-sample, subscription)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit offering the service"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of service"
    - name: "remote_delivery_capable_flag"
      expr: remote_delivery_capable_flag
      comment: "Whether service can be delivered remotely"
    - name: "materials_included_flag"
      expr: materials_included_flag
      comment: "Whether materials are included in service price"
    - name: "travel_expenses_included_flag"
      expr: travel_expenses_included_flag
      comment: "Whether travel expenses are included"
  measures:
    - name: "active_service_count"
      expr: COUNT(DISTINCT CASE WHEN service_status = 'Active' THEN service_offering_id END)
      comment: "Count of active service offerings"
    - name: "total_standard_price_usd"
      expr: SUM(CAST(standard_price_usd AS DOUBLE))
      comment: "Total standard price in USD across all services"
    - name: "avg_standard_price_usd"
      expr: AVG(CAST(standard_price_usd AS DOUBLE))
      comment: "Average standard price per service in USD"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total cost estimate in USD across services"
    - name: "avg_cost_estimate_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost estimate per service in USD"
    - name: "avg_standard_duration_hours"
      expr: AVG(CAST(standard_duration_hours AS DOUBLE))
      comment: "Average standard duration in hours per service"
    - name: "avg_standard_duration_days"
      expr: AVG(CAST(standard_duration_days AS DOUBLE))
      comment: "Average standard duration in days per service"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time in hours for service requests"
    - name: "remote_capable_service_count"
      expr: COUNT(DISTINCT CASE WHEN remote_delivery_capable_flag = TRUE THEN service_offering_id END)
      comment: "Count of services that can be delivered remotely"
    - name: "materials_included_service_count"
      expr: COUNT(DISTINCT CASE WHEN materials_included_flag = TRUE THEN service_offering_id END)
      comment: "Count of services that include materials in price"
    - name: "renewable_service_count"
      expr: COUNT(DISTINCT CASE WHEN renewal_eligible_flag = TRUE THEN service_offering_id END)
      comment: "Count of services eligible for renewal"
$$;