-- Metric views for domain: product | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory availability and allocation metrics per SKU and storage location."
  source: "`food_beverage_ecm`.`product`.`inventory_allocation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Warehouse storage location identifier"
    - name: "best_before_date"
      expr: best_before_date
      comment: "Date indicating best before for inventory"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of inventory allocation records"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available across locations"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand"
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for orders"
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity in transit"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard cost components and overall cost per SKU."
  source: "`food_beverage_ecm`.`product`.`product_standard_cost`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the cost"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center responsible for the cost"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost values"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of standard cost records"
    - name: "avg_total_standard_cost_per_unit"
      expr: AVG(CAST(total_standard_cost_per_unit AS DOUBLE))
      comment: "Average total standard cost per unit"
    - name: "avg_total_standard_cost_per_case"
      expr: AVG(CAST(total_standard_cost_per_case AS DOUBLE))
      comment: "Average total standard cost per case"
    - name: "sum_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Sum of raw material cost across records"
    - name: "sum_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Sum of freight-in cost"
    - name: "sum_manufacturing_overhead_cost"
      expr: SUM(CAST(manufacturing_overhead_cost AS DOUBLE))
      comment: "Sum of manufacturing overhead cost"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_bom_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials cost and yield metrics per SKU."
  source: "`food_beverage_ecm`.`product`.`bill_of_materials`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM"
    - name: "bom_type"
      expr: bom_type
      comment: "Type/category of the BOM"
    - name: "clean_label_flag"
      expr: clean_label_flag
      comment: "Indicates if the BOM is clean label compliant"
    - name: "contains_gmo_flag"
      expr: contains_gmo_flag
      comment: "Indicates presence of GMO ingredients"
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates organic certification"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of Bill of Materials records"
    - name: "avg_cost_estimate_amount"
      expr: AVG(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Average cost estimate amount per BOM"
    - name: "sum_cost_estimate_amount"
      expr: SUM(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Total cost estimate amount across BOMs"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across BOMs"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_npd_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New product development financial and market metrics."
  source: "`food_beverage_ecm`.`product`.`npd_project`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center overseeing the project"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center overseeing the project"
    - name: "target_market_geography"
      expr: target_market_geography
      comment: "Geographic target market for the new product"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the NPD project"
    - name: "target_launch_date"
      expr: target_launch_date
      comment: "Planned launch date"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of NPD project records"
    - name: "sum_capital_investment_required"
      expr: SUM(CAST(capital_investment_required AS DOUBLE))
      comment: "Total capital investment required for NPD projects"
    - name: "avg_consumer_acceptance_score"
      expr: AVG(CAST(consumer_acceptance_score AS DOUBLE))
      comment: "Average consumer acceptance score"
    - name: "sum_estimated_incremental_revenue"
      expr: SUM(CAST(estimated_incremental_revenue AS DOUBLE))
      comment: "Total estimated incremental revenue from NPD projects"
    - name: "avg_estimated_cogs_impact"
      expr: AVG(CAST(estimated_cogs_impact AS DOUBLE))
      comment: "Average estimated COGS impact"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging specifications and cost metrics per SKU."
  source: "`food_beverage_ecm`.`product`.`packaging_spec`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the packaging"
    - name: "material_type"
      expr: material_type
      comment: "Material used for packaging"
    - name: "compostable_certified_flag"
      expr: compostable_certified_flag
      comment: "Indicates if packaging is compostable certified"
    - name: "bpa_free_flag"
      expr: bpa_free_flag
      comment: "Indicates if packaging is BPA free"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of packaging specification records"
    - name: "avg_gross_weight_g"
      expr: AVG(CAST(gross_weight_g AS DOUBLE))
      comment: "Average gross weight (g) of packaging"
    - name: "avg_net_weight_g"
      expr: AVG(CAST(net_weight_g AS DOUBLE))
      comment: "Average net weight (g) of packaging"
    - name: "sum_cost_per_unit"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Total cost per unit across packaging specs"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation batch and quality metrics per SKU."
  source: "`food_beverage_ecm`.`product`.`formulation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Stock Keeping Unit identifier"
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type/category of formulation"
    - name: "clean_label_compliant_flag"
      expr: clean_label_compliant_flag
      comment: "Indicates clean label compliance"
    - name: "gluten_free_flag"
      expr: gluten_free_flag
      comment: "Indicates gluten free formulation"
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates organic certification"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of formulation records"
    - name: "avg_batch_size"
      expr: AVG(CAST(batch_size AS DOUBLE))
      comment: "Average batch size for formulations"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage of formulations"
    - name: "avg_target_ph_max"
      expr: AVG(CAST(target_ph_max AS DOUBLE))
      comment: "Average maximum target pH"
    - name: "avg_target_ph_min"
      expr: AVG(CAST(target_ph_min AS DOUBLE))
      comment: "Average minimum target pH"
$$;