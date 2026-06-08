-- Metric views for domain: product | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:14:27

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_bill_of_materials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill Of Materials business metrics"
  source: "`food_beverage_ecm`.`product`.`bill_of_materials`"
  dimensions:
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Approved By"
      expr: approved_by
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Bom Number"
      expr: bom_number
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Clean Label Flag"
      expr: clean_label_flag
    - name: "Contains Gmo Flag"
      expr: contains_gmo_flag
    - name: "Cost Estimate Currency"
      expr: cost_estimate_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Haccp Critical Flag"
      expr: haccp_critical_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bill Of Materials"
      expr: COUNT(DISTINCT bill_of_materials_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
    - name: "Total Batch Size Maximum"
      expr: SUM(batch_size_maximum)
    - name: "Average Batch Size Maximum"
      expr: AVG(batch_size_maximum)
    - name: "Total Batch Size Minimum"
      expr: SUM(batch_size_minimum)
    - name: "Average Batch Size Minimum"
      expr: AVG(batch_size_minimum)
    - name: "Total Cost Estimate Amount"
      expr: SUM(cost_estimate_amount)
    - name: "Average Cost Estimate Amount"
      expr: AVG(cost_estimate_amount)
    - name: "Total Yield Percentage"
      expr: SUM(yield_percentage)
    - name: "Average Yield Percentage"
      expr: AVG(yield_percentage)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Line business metrics"
  source: "`food_beverage_ecm`.`product`.`bom_line`"
  dimensions:
    - name: "Allergen Type"
      expr: allergen_type
    - name: "Base Uom"
      expr: base_uom
    - name: "Bom Line Status"
      expr: bom_line_status
    - name: "Change Number"
      expr: change_number
    - name: "Component Category"
      expr: component_category
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Allergen Flag"
      expr: critical_allergen_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gluten Free Flag"
      expr: gluten_free_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Line"
      expr: COUNT(DISTINCT bom_line_id)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
    - name: "Total Lot Size Multiple"
      expr: SUM(lot_size_multiple)
    - name: "Average Lot Size Multiple"
      expr: AVG(lot_size_multiple)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Quantity Per Base Uom"
      expr: SUM(quantity_per_base_uom)
    - name: "Average Quantity Per Base Uom"
      expr: AVG(quantity_per_base_uom)
    - name: "Total Scrap Factor Percent"
      expr: SUM(scrap_factor_percent)
    - name: "Average Scrap Factor Percent"
      expr: AVG(scrap_factor_percent)
    - name: "Total Yield Factor Percent"
      expr: SUM(yield_factor_percent)
    - name: "Average Yield Factor Percent"
      expr: AVG(yield_factor_percent)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category business metrics"
  source: "`food_beverage_ecm`.`product`.`category`"
  dimensions:
    - name: "Allergen Info"
      expr: allergen_info
    - name: "Category Code"
      expr: category_code
    - name: "Category Description"
      expr: category_description
    - name: "Category Name"
      expr: category_name
    - name: "Category Status"
      expr: category_status
    - name: "Category Type"
      expr: category_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Is Perishable"
      expr: is_perishable
    - name: "Marketing Description"
      expr: marketing_description
    - name: "Nutritional Profile"
      expr: nutritional_profile
    - name: "Packaging Type"
      expr: packaging_type
    - name: "Regulatory Classification"
      expr: regulatory_classification
    - name: "Shelf Life Days"
      expr: shelf_life_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category"
      expr: COUNT(DISTINCT category_id)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formulation business metrics"
  source: "`food_beverage_ecm`.`product`.`formulation`"
  dimensions:
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Batch Size Unit"
      expr: batch_size_unit
    - name: "Clean Label Compliant Flag"
      expr: clean_label_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Formulation Code"
      expr: formulation_code
    - name: "Formulation Name"
      expr: formulation_name
    - name: "Formulation Status"
      expr: formulation_status
    - name: "Formulation Type"
      expr: formulation_type
    - name: "Gluten Free Flag"
      expr: gluten_free_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Formulation"
      expr: COUNT(DISTINCT formulation_id)
    - name: "Total Batch Size"
      expr: SUM(batch_size)
    - name: "Average Batch Size"
      expr: AVG(batch_size)
    - name: "Total Cooling Temperature"
      expr: SUM(cooling_temperature)
    - name: "Average Cooling Temperature"
      expr: AVG(cooling_temperature)
    - name: "Total Holding Time"
      expr: SUM(holding_time)
    - name: "Average Holding Time"
      expr: AVG(holding_time)
    - name: "Total Homogenization Pressure"
      expr: SUM(homogenization_pressure)
    - name: "Average Homogenization Pressure"
      expr: AVG(homogenization_pressure)
    - name: "Total Mixing Speed"
      expr: SUM(mixing_speed)
    - name: "Average Mixing Speed"
      expr: AVG(mixing_speed)
    - name: "Total Mixing Time"
      expr: SUM(mixing_time)
    - name: "Average Mixing Time"
      expr: AVG(mixing_time)
    - name: "Total Moisture Content Target"
      expr: SUM(moisture_content_target)
    - name: "Average Moisture Content Target"
      expr: AVG(moisture_content_target)
    - name: "Total Pasteurization Temperature"
      expr: SUM(pasteurization_temperature)
    - name: "Average Pasteurization Temperature"
      expr: AVG(pasteurization_temperature)
    - name: "Total Pasteurization Time"
      expr: SUM(pasteurization_time)
    - name: "Average Pasteurization Time"
      expr: AVG(pasteurization_time)
    - name: "Total Target Brix"
      expr: SUM(target_brix)
    - name: "Average Target Brix"
      expr: AVG(target_brix)
    - name: "Total Target Ph Max"
      expr: SUM(target_ph_max)
    - name: "Average Target Ph Max"
      expr: AVG(target_ph_max)
    - name: "Total Target Ph Min"
      expr: SUM(target_ph_min)
    - name: "Average Target Ph Min"
      expr: AVG(target_ph_min)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hierarchy business metrics"
  source: "`food_beverage_ecm`.`product`.`hierarchy`"
  dimensions:
    - name: "Allergen Category"
      expr: allergen_category
    - name: "Brand Owner"
      expr: brand_owner
    - name: "Category Captain Flag"
      expr: category_captain_flag
    - name: "Channel Strategy"
      expr: channel_strategy
    - name: "Clean Label Flag"
      expr: clean_label_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Depth"
      expr: depth
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hierarchy Status"
      expr: hierarchy_status
    - name: "Innovation Platform Flag"
      expr: innovation_platform_flag
    - name: "Iri Category Code"
      expr: iri_category_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Level Code"
      expr: level_code
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hierarchy"
      expr: COUNT(DISTINCT hierarchy_id)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_label_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Label Spec business metrics"
  source: "`food_beverage_ecm`.`product`.`label_spec`"
  dimensions:
    - name: "Adhesive Type"
      expr: adhesive_type
    - name: "Allergen Warning Text"
      expr: allergen_warning_text
    - name: "Artwork Approval Date"
      expr: artwork_approval_date
    - name: "Artwork Approval Status"
      expr: artwork_approval_status
    - name: "Artwork File Path"
      expr: artwork_file_path
    - name: "Barcode Type"
      expr: barcode_type
    - name: "Clean Label Flag"
      expr: clean_label_flag
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gluten Free Flag"
      expr: gluten_free_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Label Type"
      expr: label_type
    - name: "Label Version"
      expr: label_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Label Spec"
      expr: COUNT(DISTINCT label_spec_id)
    - name: "Total Barcode Value"
      expr: SUM(barcode_value)
    - name: "Average Barcode Value"
      expr: AVG(barcode_value)
    - name: "Total Label Height Mm"
      expr: SUM(label_height_mm)
    - name: "Average Label Height Mm"
      expr: AVG(label_height_mm)
    - name: "Total Label Width Mm"
      expr: SUM(label_width_mm)
    - name: "Average Label Width Mm"
      expr: AVG(label_width_mm)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_nutritional_panel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutritional Panel business metrics"
  source: "`food_beverage_ecm`.`product`.`nutritional_panel`"
  dimensions:
    - name: "Allergen Statement"
      expr: allergen_statement
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fda Submission Reference"
      expr: fda_submission_reference
    - name: "Ingredient Statement"
      expr: ingredient_statement
    - name: "Lab Analysis Reference"
      expr: lab_analysis_reference
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Panel Format Standard"
      expr: panel_format_standard
    - name: "Panel Status"
      expr: panel_status
    - name: "Panel Version"
      expr: panel_version
    - name: "Regulatory Jurisdiction"
      expr: regulatory_jurisdiction
    - name: "Rounding Method"
      expr: rounding_method
    - name: "Serving Size"
      expr: serving_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nutritional Panel"
      expr: COUNT(DISTINCT nutritional_panel_id)
    - name: "Total Added Sugars Dv Percent"
      expr: SUM(added_sugars_dv_percent)
    - name: "Average Added Sugars Dv Percent"
      expr: AVG(added_sugars_dv_percent)
    - name: "Total Added Sugars Grams"
      expr: SUM(added_sugars_grams)
    - name: "Average Added Sugars Grams"
      expr: AVG(added_sugars_grams)
    - name: "Total Calcium Dv Percent"
      expr: SUM(calcium_dv_percent)
    - name: "Average Calcium Dv Percent"
      expr: AVG(calcium_dv_percent)
    - name: "Total Calcium Milligrams"
      expr: SUM(calcium_milligrams)
    - name: "Average Calcium Milligrams"
      expr: AVG(calcium_milligrams)
    - name: "Total Calories From Fat"
      expr: SUM(calories_from_fat)
    - name: "Average Calories From Fat"
      expr: AVG(calories_from_fat)
    - name: "Total Calories Per Serving"
      expr: SUM(calories_per_serving)
    - name: "Average Calories Per Serving"
      expr: AVG(calories_per_serving)
    - name: "Total Cholesterol Dv Percent"
      expr: SUM(cholesterol_dv_percent)
    - name: "Average Cholesterol Dv Percent"
      expr: AVG(cholesterol_dv_percent)
    - name: "Total Cholesterol Milligrams"
      expr: SUM(cholesterol_milligrams)
    - name: "Average Cholesterol Milligrams"
      expr: AVG(cholesterol_milligrams)
    - name: "Total Dietary Fiber Dv Percent"
      expr: SUM(dietary_fiber_dv_percent)
    - name: "Average Dietary Fiber Dv Percent"
      expr: AVG(dietary_fiber_dv_percent)
    - name: "Total Dietary Fiber Grams"
      expr: SUM(dietary_fiber_grams)
    - name: "Average Dietary Fiber Grams"
      expr: AVG(dietary_fiber_grams)
    - name: "Total Iron Dv Percent"
      expr: SUM(iron_dv_percent)
    - name: "Average Iron Dv Percent"
      expr: AVG(iron_dv_percent)
    - name: "Total Iron Milligrams"
      expr: SUM(iron_milligrams)
    - name: "Average Iron Milligrams"
      expr: AVG(iron_milligrams)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging Spec business metrics"
  source: "`food_beverage_ecm`.`product`.`packaging_spec`"
  dimensions:
    - name: "Barrier Properties"
      expr: barrier_properties
    - name: "Bpa Free Flag"
      expr: bpa_free_flag
    - name: "Cases Per Layer"
      expr: cases_per_layer
    - name: "Child Resistant Flag"
      expr: child_resistant_flag
    - name: "Closure Type"
      expr: closure_type
    - name: "Compostable Certified Flag"
      expr: compostable_certified_flag
    - name: "Container Type"
      expr: container_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Food Contact Approved Flag"
      expr: food_contact_approved_flag
    - name: "Freezer Safe Flag"
      expr: freezer_safe_flag
    - name: "Label Panel Count"
      expr: label_panel_count
    - name: "Layers Per Pallet"
      expr: layers_per_pallet
    - name: "Material Type"
      expr: material_type
    - name: "Microwave Safe Flag"
      expr: microwave_safe_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Packaging Spec"
      expr: COUNT(DISTINCT packaging_spec_id)
    - name: "Total Bio Based Content Percent"
      expr: SUM(bio_based_content_percent)
    - name: "Average Bio Based Content Percent"
      expr: AVG(bio_based_content_percent)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
    - name: "Total Depth Mm"
      expr: SUM(depth_mm)
    - name: "Average Depth Mm"
      expr: AVG(depth_mm)
    - name: "Total Diameter Mm"
      expr: SUM(diameter_mm)
    - name: "Average Diameter Mm"
      expr: AVG(diameter_mm)
    - name: "Total Fill Volume Ml"
      expr: SUM(fill_volume_ml)
    - name: "Average Fill Volume Ml"
      expr: AVG(fill_volume_ml)
    - name: "Total Gross Weight G"
      expr: SUM(gross_weight_g)
    - name: "Average Gross Weight G"
      expr: AVG(gross_weight_g)
    - name: "Total Height Mm"
      expr: SUM(height_mm)
    - name: "Average Height Mm"
      expr: AVG(height_mm)
    - name: "Total Net Weight G"
      expr: SUM(net_weight_g)
    - name: "Average Net Weight G"
      expr: AVG(net_weight_g)
    - name: "Total Pcr Content Percent"
      expr: SUM(pcr_content_percent)
    - name: "Average Pcr Content Percent"
      expr: AVG(pcr_content_percent)
    - name: "Total Tare Weight G"
      expr: SUM(tare_weight_g)
    - name: "Average Tare Weight G"
      expr: AVG(tare_weight_g)
    - name: "Total Width Mm"
      expr: SUM(width_mm)
    - name: "Average Width Mm"
      expr: AVG(width_mm)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_product_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Standard Cost business metrics"
  source: "`food_beverage_ecm`.`product`.`product_standard_cost`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Cost Estimate Number"
      expr: cost_estimate_number
    - name: "Cost Status"
      expr: cost_status
    - name: "Cost Version"
      expr: cost_version
    - name: "Costing Method"
      expr: costing_method
    - name: "Costing Run Date"
      expr: costing_run_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Price Control Indicator"
      expr: price_control_indicator
    - name: "Units Per Case"
      expr: units_per_case
    - name: "Valuation Class"
      expr: valuation_class
    - name: "Approval Date Month"
      expr: DATE_TRUNC('MONTH', approval_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Standard Cost"
      expr: COUNT(DISTINCT product_standard_cost_id)
    - name: "Total Copacker Toll Fee"
      expr: SUM(copacker_toll_fee)
    - name: "Average Copacker Toll Fee"
      expr: AVG(copacker_toll_fee)
    - name: "Total Cost Variance Per Unit"
      expr: SUM(cost_variance_per_unit)
    - name: "Average Cost Variance Per Unit"
      expr: AVG(cost_variance_per_unit)
    - name: "Total Cost Variance Percentage"
      expr: SUM(cost_variance_percentage)
    - name: "Average Cost Variance Percentage"
      expr: AVG(cost_variance_percentage)
    - name: "Total Costing Lot Size"
      expr: SUM(costing_lot_size)
    - name: "Average Costing Lot Size"
      expr: AVG(costing_lot_size)
    - name: "Total Direct Labor Cost"
      expr: SUM(direct_labor_cost)
    - name: "Average Direct Labor Cost"
      expr: AVG(direct_labor_cost)
    - name: "Total Freight In Cost"
      expr: SUM(freight_in_cost)
    - name: "Average Freight In Cost"
      expr: AVG(freight_in_cost)
    - name: "Total Manufacturing Overhead Cost"
      expr: SUM(manufacturing_overhead_cost)
    - name: "Average Manufacturing Overhead Cost"
      expr: AVG(manufacturing_overhead_cost)
    - name: "Total Packaging Cost"
      expr: SUM(packaging_cost)
    - name: "Average Packaging Cost"
      expr: AVG(packaging_cost)
    - name: "Total Prior Period Cost Per Unit"
      expr: SUM(prior_period_cost_per_unit)
    - name: "Average Prior Period Cost Per Unit"
      expr: AVG(prior_period_cost_per_unit)
    - name: "Total Raw Material Cost"
      expr: SUM(raw_material_cost)
    - name: "Average Raw Material Cost"
      expr: AVG(raw_material_cost)
    - name: "Total Total Standard Cost Per Case"
      expr: SUM(total_standard_cost_per_case)
    - name: "Average Total Standard Cost Per Case"
      expr: AVG(total_standard_cost_per_case)
    - name: "Total Total Standard Cost Per Unit"
      expr: SUM(total_standard_cost_per_unit)
    - name: "Average Total Standard Cost Per Unit"
      expr: AVG(total_standard_cost_per_unit)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_shelf_life_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shelf Life Spec business metrics"
  source: "`food_beverage_ecm`.`product`.`shelf_life_spec`"
  dimensions:
    - name: "Accelerated Testing Flag"
      expr: accelerated_testing_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Cold Chain Required Flag"
      expr: cold_chain_required_flag
    - name: "Consumer Date Format"
      expr: consumer_date_format
    - name: "Consumer Date Label Type"
      expr: consumer_date_label_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Calculation Method"
      expr: date_calculation_method
    - name: "Dc Receiving Standard"
      expr: dc_receiving_standard
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frozen Shelf Life Days"
      expr: frozen_shelf_life_days
    - name: "Fsma 204 Traceability Flag"
      expr: fsma_204_traceability_flag
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Light Sensitivity Flag"
      expr: light_sensitivity_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Mrsl Days"
      expr: mrsl_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shelf Life Spec"
      expr: COUNT(DISTINCT shelf_life_spec_id)
    - name: "Total Storage Humidity Max Percent"
      expr: SUM(storage_humidity_max_percent)
    - name: "Average Storage Humidity Max Percent"
      expr: AVG(storage_humidity_max_percent)
    - name: "Total Storage Humidity Min Percent"
      expr: SUM(storage_humidity_min_percent)
    - name: "Average Storage Humidity Min Percent"
      expr: AVG(storage_humidity_min_percent)
    - name: "Total Storage Temperature Max Celsius"
      expr: SUM(storage_temperature_max_celsius)
    - name: "Average Storage Temperature Max Celsius"
      expr: AVG(storage_temperature_max_celsius)
    - name: "Total Storage Temperature Min Celsius"
      expr: SUM(storage_temperature_min_celsius)
    - name: "Average Storage Temperature Min Celsius"
      expr: AVG(storage_temperature_min_celsius)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku business metrics"
  source: "`food_beverage_ecm`.`product`.`sku`"
  dimensions:
    - name: "Allergen Matrix"
      expr: allergen_matrix
    - name: "Calories Per Serving"
      expr: calories_per_serving
    - name: "Clean Label Flag"
      expr: clean_label_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Ean"
      expr: ean
    - name: "Flavor Variety"
      expr: flavor_variety
    - name: "Form Factor"
      expr: form_factor
    - name: "Gluten Free Flag"
      expr: gluten_free_flag
    - name: "Gtin"
      expr: gtin
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Launch Date"
      expr: launch_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Non Gmo Flag"
      expr: non_gmo_flag
    - name: "Organic Certified Flag"
      expr: organic_certified_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku"
      expr: COUNT(DISTINCT sku_id)
    - name: "Total Abv"
      expr: SUM(abv)
    - name: "Average Abv"
      expr: AVG(abv)
    - name: "Total Brix Target"
      expr: SUM(brix_target)
    - name: "Average Brix Target"
      expr: AVG(brix_target)
    - name: "Total Net Volume"
      expr: SUM(net_volume)
    - name: "Average Net Volume"
      expr: AVG(net_volume)
    - name: "Total Net Weight"
      expr: SUM(net_weight)
    - name: "Average Net Weight"
      expr: AVG(net_weight)
    - name: "Total Ph Max"
      expr: SUM(ph_max)
    - name: "Average Ph Max"
      expr: AVG(ph_max)
    - name: "Total Ph Min"
      expr: SUM(ph_min)
    - name: "Average Ph Min"
      expr: AVG(ph_min)
    - name: "Total Servings Per Container"
      expr: SUM(servings_per_container)
    - name: "Average Servings Per Container"
      expr: AVG(servings_per_container)
    - name: "Total Storage Temperature Max"
      expr: SUM(storage_temperature_max)
    - name: "Average Storage Temperature Max"
      expr: AVG(storage_temperature_max)
    - name: "Total Storage Temperature Min"
      expr: SUM(storage_temperature_min)
    - name: "Average Storage Temperature Min"
      expr: AVG(storage_temperature_min)
$$;