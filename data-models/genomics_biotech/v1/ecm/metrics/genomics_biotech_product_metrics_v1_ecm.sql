-- Metric views for domain: product | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing KPIs for product catalog items, supporting revenue and margin analysis"
  source: "`genomics_biotech_ecm`.`product`.`pricing`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., list, promotional)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel associated with the price"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the price becomes effective"
    - name: "effective_end_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month when the price expires"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of pricing records"
    - name: "total_list_price_usd"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price across all pricing records (USD)"
    - name: "average_list_price_usd"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per pricing record (USD)"
    - name: "average_margin_percent"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average margin percentage across pricing records"
    - name: "average_discount_percent"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials KPIs for cost and waste management"
  source: "`genomics_biotech_ecm`.`product`.`product_bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., active, retired)"
    - name: "bom_type"
      expr: bom_type
      comment: "Classification of the BOM (e.g., engineering, production)"
    - name: "bom_version"
      expr: version
      comment: "Version identifier of the BOM"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the BOM was created"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of BOM records"
    - name: "total_component_quantity"
      expr: SUM(CAST(component_quantity AS DOUBLE))
      comment: "Total quantity of components across all BOMs"
    - name: "average_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOMs"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_catalog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core catalog item metrics for product portfolio performance"
  source: "`genomics_biotech_ecm`.`product`.`catalog_item`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "High‑level product category"
    - name: "product_name"
      expr: product_name
      comment: "Descriptive product name"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the product"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if the item is currently active"
    - name: "launch_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the product was launched"
    - name: "eol_month"
      expr: DATE_TRUNC('month', end_of_life_date)
      comment: "Month the product reached end‑of‑life"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of catalog items"
    - name: "average_list_price_usd"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across catalog items (USD)"
    - name: "average_average_selling_price_usd"
      expr: AVG(CAST(average_selling_price AS DOUBLE))
      comment: "Average selling price across catalog items (USD)"
    - name: "active_item_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of active catalog items"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_launch_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Launch plan KPIs to monitor investment effectiveness and readiness"
  source: "`genomics_biotech_ecm`.`product`.`launch_plan`"
  dimensions:
    - name: "launch_status"
      expr: launch_status
      comment: "Current status of the launch (e.g., planned, completed)"
    - name: "launch_type"
      expr: launch_type
      comment: "Type of launch (e.g., new product, upgrade)"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the launch"
    - name: "planned_launch_month"
      expr: DATE_TRUNC('month', planned_launch_date)
      comment: "Planned launch month"
    - name: "actual_launch_month"
      expr: DATE_TRUNC('month', actual_launch_date)
      comment: "Actual launch month"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of launch plans"
    - name: "total_launch_spend_usd"
      expr: SUM(CAST(launch_actual_spend_usd AS DOUBLE))
      comment: "Total actual spend for product launches (USD)"
    - name: "average_launch_readiness_score"
      expr: AVG(CAST(launch_readiness_score AS DOUBLE))
      comment: "Average readiness score across launch plans"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service offering metrics for cost and service level monitoring"
  source: "`genomics_biotech_ecm`.`product`.`service_offering`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "Broad category of the service"
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service offering"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit delivering the service"
    - name: "launch_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the service was launched"
    - name: "geographic_availability"
      expr: geographic_availability
      comment: "Geographic regions where the service is available"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of service offering records"
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total cost estimate for service offerings (USD)"
    - name: "average_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time commitment (hours)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technical specification KPIs for product performance and quality"
  source: "`genomics_biotech_ecm`.`product`.`specification`"
  dimensions:
    - name: "product_category"
      expr: product_category
      comment: "Category of the product the specification applies to"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the product"
    - name: "instrument_compatibility"
      expr: instrument_compatibility
      comment: "Instrument compatibility description"
    - name: "spec_version"
      expr: version
      comment: "Version identifier of the specification"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the specification became effective"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the specification expires"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of specification records"
    - name: "average_cost_of_goods_sold_usd"
      expr: AVG(CAST(cost_of_goods_sold_usd AS DOUBLE))
      comment: "Average COGS per specification (USD)"
    - name: "average_crispr_target_specificity_percent"
      expr: AVG(CAST(crispr_target_specificity_percent AS DOUBLE))
      comment: "Average CRISPR target specificity percentage"
    - name: "average_q30_score_threshold_percent"
      expr: AVG(CAST(q30_score_threshold_percent AS DOUBLE))
      comment: "Average Q30 quality score threshold percentage"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`product_software_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software release metrics for delivery size and schedule tracking"
  source: "`genomics_biotech_ecm`.`product`.`software_release`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Current status of the release (e.g., released, deprecated)"
    - name: "release_type"
      expr: release_type
      comment: "Type of release (e.g., major, minor, patch)"
    - name: "supported_cloud_platforms"
      expr: supported_cloud_platforms
      comment: "Cloud platforms supported by the release"
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month the release was made available"
    - name: "eol_month"
      expr: DATE_TRUNC('month', end_of_life_date)
      comment: "Month the release reached end‑of‑life"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of software releases"
    - name: "average_package_size_mb"
      expr: AVG(CAST(package_size_mb AS DOUBLE))
      comment: "Average package size of releases (MB)"
$$;