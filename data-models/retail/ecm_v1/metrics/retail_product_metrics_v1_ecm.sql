-- Metric views for domain: product | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:05:34

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment business metrics"
  source: "`retail_ecm`.`product`.`assortment`"
  dimensions:
    - name: "Allocation Priority"
      expr: allocation_priority
    - name: "Assignment Effective Date"
      expr: assignment_effective_date
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Received Date"
      expr: last_received_date
    - name: "Max Stock Quantity"
      expr: max_stock_quantity
    - name: "Min Stock Quantity"
      expr: min_stock_quantity
    - name: "Replenishment Lead Time Days"
      expr: replenishment_lead_time_days
    - name: "Stocking Status"
      expr: stocking_status
    - name: "Assignment Effective Date Month"
      expr: DATE_TRUNC('MONTH', assignment_effective_date)
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assortment"
      expr: COUNT(DISTINCT assortment_id)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_attribute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attribute business metrics"
  source: "`retail_ecm`.`product`.`attribute`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Attribute Group"
      expr: attribute_group
    - name: "Attribute Name"
      expr: attribute_name
    - name: "Attribute Status"
      expr: attribute_status
    - name: "Certification Body"
      expr: certification_body
    - name: "Certification Date"
      expr: certification_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Type"
      expr: data_type
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Certified"
      expr: is_certified
    - name: "Is Comparable"
      expr: is_comparable
    - name: "Is Regulatory Required"
      expr: is_regulatory_required
    - name: "Is Required"
      expr: is_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Attribute"
      expr: COUNT(DISTINCT attribute_id)
    - name: "Total Attribute Value"
      expr: SUM(attribute_value)
    - name: "Average Attribute Value"
      expr: AVG(attribute_value)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_category_campaign_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Campaign Plan business metrics"
  source: "`retail_ecm`.`product`.`category_campaign_plan`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Performance Priority Rank"
      expr: performance_priority_rank
    - name: "Plan Status"
      expr: plan_status
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Campaign Plan"
      expr: COUNT(DISTINCT category_campaign_plan_id)
    - name: "Total Actual Revenue Amount"
      expr: SUM(actual_revenue_amount)
    - name: "Average Actual Revenue Amount"
      expr: AVG(actual_revenue_amount)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Actual Units Sold"
      expr: SUM(actual_units_sold)
    - name: "Average Actual Units Sold"
      expr: AVG(actual_units_sold)
    - name: "Total Budget Allocated Amount"
      expr: SUM(budget_allocated_amount)
    - name: "Average Budget Allocated Amount"
      expr: AVG(budget_allocated_amount)
    - name: "Total Media Weight Percent"
      expr: SUM(media_weight_percent)
    - name: "Average Media Weight Percent"
      expr: AVG(media_weight_percent)
    - name: "Total Promotional Depth Percent"
      expr: SUM(promotional_depth_percent)
    - name: "Average Promotional Depth Percent"
      expr: AVG(promotional_depth_percent)
    - name: "Total Target Revenue Goal"
      expr: SUM(target_revenue_goal)
    - name: "Average Target Revenue Goal"
      expr: AVG(target_revenue_goal)
    - name: "Total Target Units Goal"
      expr: SUM(target_units_goal)
    - name: "Average Target Units Goal"
      expr: AVG(target_units_goal)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_category_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Kpi Target business metrics"
  source: "`retail_ecm`.`product`.`category_kpi_target`"
  dimensions:
    - name: "Configuration Notes"
      expr: configuration_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Frequency"
      expr: measurement_frequency
    - name: "Responsible Role"
      expr: responsible_role
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Kpi Target"
      expr: COUNT(DISTINCT category_kpi_target_id)
    - name: "Total Alert Threshold"
      expr: SUM(alert_threshold)
    - name: "Average Alert Threshold"
      expr: AVG(alert_threshold)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gtin Registry business metrics"
  source: "`retail_ecm`.`product`.`gtin_registry`"
  dimensions:
    - name: "Barcode Image Url"
      expr: barcode_image_url
    - name: "Barcode Symbology"
      expr: barcode_symbology
    - name: "Check Digit"
      expr: check_digit
    - name: "Child Gtin Quantity"
      expr: child_gtin_quantity
    - name: "Country Of Sale"
      expr: country_of_sale
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Gdsn Last Sync Timestamp"
      expr: gdsn_last_sync_timestamp
    - name: "Gdsn Publication Status"
      expr: gdsn_publication_status
    - name: "Gross Weight Unit"
      expr: gross_weight_unit
    - name: "Gs1 Company Prefix"
      expr: gs1_company_prefix
    - name: "Gtin"
      expr: gtin
    - name: "Gtin Type"
      expr: gtin_type
    - name: "Is Base Unit"
      expr: is_base_unit
    - name: "Is Consumer Unit"
      expr: is_consumer_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gtin Registry"
      expr: COUNT(DISTINCT gtin_registry_id)
    - name: "Total Gross Weight Value"
      expr: SUM(gross_weight_value)
    - name: "Average Gross Weight Value"
      expr: AVG(gross_weight_value)
    - name: "Total Net Content Value"
      expr: SUM(net_content_value)
    - name: "Average Net Content Value"
      expr: AVG(net_content_value)
    - name: "Total Package Depth Value"
      expr: SUM(package_depth_value)
    - name: "Average Package Depth Value"
      expr: AVG(package_depth_value)
    - name: "Total Package Height Value"
      expr: SUM(package_height_value)
    - name: "Average Package Height Value"
      expr: AVG(package_height_value)
    - name: "Total Package Width Value"
      expr: SUM(package_width_value)
    - name: "Average Package Width Value"
      expr: AVG(package_width_value)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_image`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Image business metrics"
  source: "`retail_ecm`.`product`.`image`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Background Color"
      expr: background_color
    - name: "Caption"
      expr: caption
    - name: "Cdn Asset Reference"
      expr: cdn_asset_reference
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Color Profile"
      expr: color_profile
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Dpi"
      expr: dpi
    - name: "Expiration Date"
      expr: expiration_date
    - name: "File Format"
      expr: file_format
    - name: "Has Transparency"
      expr: has_transparency
    - name: "Image Type"
      expr: image_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Image"
      expr: COUNT(DISTINCT image_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Bundle business metrics"
  source: "`retail_ecm`.`product`.`item_bundle`"
  dimensions:
    - name: "Assortment Category"
      expr: assortment_category
    - name: "Bundle Description"
      expr: bundle_description
    - name: "Bundle Name"
      expr: bundle_name
    - name: "Bundle Status"
      expr: bundle_status
    - name: "Bundle Type"
      expr: bundle_type
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Component Sequence"
      expr: component_sequence
    - name: "Component Sku"
      expr: component_sku
    - name: "Component Substitution Allowed"
      expr: component_substitution_allowed
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inventory Deduction Method"
      expr: inventory_deduction_method
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Points Eligible"
      expr: loyalty_points_eligible
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Bundle"
      expr: COUNT(DISTINCT item_bundle_id)
    - name: "Total Bundle Price Amount"
      expr: SUM(bundle_price_amount)
    - name: "Average Bundle Price Amount"
      expr: AVG(bundle_price_amount)
    - name: "Total Component Quantity"
      expr: SUM(component_quantity)
    - name: "Average Component Quantity"
      expr: AVG(component_quantity)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_cross_reference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Cross Reference business metrics"
  source: "`retail_ecm`.`product`.`item_cross_reference`"
  dimensions:
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Reference Status"
      expr: cross_reference_status
    - name: "Cross Reference Type"
      expr: cross_reference_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Item Description"
      expr: external_item_description
    - name: "External Item Number"
      expr: external_item_number
    - name: "External System Instance"
      expr: external_system_instance
    - name: "External System Name"
      expr: external_system_name
    - name: "External Unit Of Measure"
      expr: external_unit_of_measure
    - name: "Internal Unit Of Measure"
      expr: internal_unit_of_measure
    - name: "Is Primary Reference"
      expr: is_primary_reference
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Used Date"
      expr: last_used_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Cross Reference"
      expr: COUNT(DISTINCT item_cross_reference_id)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
    - name: "Total Mapping Confidence Score"
      expr: SUM(mapping_confidence_score)
    - name: "Average Mapping Confidence Score"
      expr: AVG(mapping_confidence_score)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Hierarchy business metrics"
  source: "`retail_ecm`.`product`.`item_hierarchy`"
  dimensions:
    - name: "Allows Direct Sku Assignment"
      expr: allows_direct_sku_assignment
    - name: "Assortment Breadth Target"
      expr: assortment_breadth_target
    - name: "Assortment Depth Target"
      expr: assortment_depth_target
    - name: "Category Manager Name"
      expr: category_manager_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Hierarchy Description"
      expr: hierarchy_description
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Node Code"
      expr: hierarchy_node_code
    - name: "Hierarchy Node Name"
      expr: hierarchy_node_name
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Hierarchy Type"
      expr: hierarchy_type
    - name: "Is Leaf Node"
      expr: is_leaf_node
    - name: "Last Modified By"
      expr: last_modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Hierarchy"
      expr: COUNT(DISTINCT item_hierarchy_id)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Private Label Penetration Target Percent"
      expr: SUM(private_label_penetration_target_percent)
    - name: "Average Private Label Penetration Target Percent"
      expr: AVG(private_label_penetration_target_percent)
    - name: "Total Safety Stock Weeks"
      expr: SUM(safety_stock_weeks)
    - name: "Average Safety Stock Weeks"
      expr: AVG(safety_stock_weeks)
    - name: "Total Target Gross Margin Percent"
      expr: SUM(target_gross_margin_percent)
    - name: "Average Target Gross Margin Percent"
      expr: AVG(target_gross_margin_percent)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Lifecycle Event business metrics"
  source: "`retail_ecm`.`product`.`item_lifecycle_event`"
  dimensions:
    - name: "Actual Launch Date"
      expr: actual_launch_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Compliance Reference Number"
      expr: compliance_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "New Status"
      expr: new_status
    - name: "Prior Status"
      expr: prior_status
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Regulatory Compliance Flag"
      expr: regulatory_compliance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Lifecycle Event"
      expr: COUNT(DISTINCT item_lifecycle_event_id)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_nutritional`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Nutritional business metrics"
  source: "`retail_ecm`.`product`.`item_nutritional`"
  dimensions:
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Calories From Fat"
      expr: calories_from_fat
    - name: "Calories Per Serving"
      expr: calories_per_serving
    - name: "Contains Eggs"
      expr: contains_eggs
    - name: "Contains Fish"
      expr: contains_fish
    - name: "Contains Milk"
      expr: contains_milk
    - name: "Contains Peanuts"
      expr: contains_peanuts
    - name: "Contains Shellfish"
      expr: contains_shellfish
    - name: "Contains Soybeans"
      expr: contains_soybeans
    - name: "Contains Tree Nuts"
      expr: contains_tree_nuts
    - name: "Contains Wheat"
      expr: contains_wheat
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ingredient Statement"
      expr: ingredient_statement
    - name: "Is Gluten Free"
      expr: is_gluten_free
    - name: "Is Halal Certified"
      expr: is_halal_certified
    - name: "Is Kosher Certified"
      expr: is_kosher_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Nutritional"
      expr: COUNT(DISTINCT item_nutritional_id)
    - name: "Total Added Sugars G"
      expr: SUM(added_sugars_g)
    - name: "Average Added Sugars G"
      expr: AVG(added_sugars_g)
    - name: "Total Calcium Mg"
      expr: SUM(calcium_mg)
    - name: "Average Calcium Mg"
      expr: AVG(calcium_mg)
    - name: "Total Cholesterol Mg"
      expr: SUM(cholesterol_mg)
    - name: "Average Cholesterol Mg"
      expr: AVG(cholesterol_mg)
    - name: "Total Dietary Fiber G"
      expr: SUM(dietary_fiber_g)
    - name: "Average Dietary Fiber G"
      expr: AVG(dietary_fiber_g)
    - name: "Total Iron Mg"
      expr: SUM(iron_mg)
    - name: "Average Iron Mg"
      expr: AVG(iron_mg)
    - name: "Total Monounsaturated Fat G"
      expr: SUM(monounsaturated_fat_g)
    - name: "Average Monounsaturated Fat G"
      expr: AVG(monounsaturated_fat_g)
    - name: "Total Polyunsaturated Fat G"
      expr: SUM(polyunsaturated_fat_g)
    - name: "Average Polyunsaturated Fat G"
      expr: AVG(polyunsaturated_fat_g)
    - name: "Total Potassium Mg"
      expr: SUM(potassium_mg)
    - name: "Average Potassium Mg"
      expr: AVG(potassium_mg)
    - name: "Total Protein G"
      expr: SUM(protein_g)
    - name: "Average Protein G"
      expr: AVG(protein_g)
    - name: "Total Saturated Fat G"
      expr: SUM(saturated_fat_g)
    - name: "Average Saturated Fat G"
      expr: AVG(saturated_fat_g)
    - name: "Total Serving Size Value"
      expr: SUM(serving_size_value)
    - name: "Average Serving Size Value"
      expr: AVG(serving_size_value)
    - name: "Total Servings Per Container"
      expr: SUM(servings_per_container)
    - name: "Average Servings Per Container"
      expr: AVG(servings_per_container)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_item_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item Variant business metrics"
  source: "`retail_ecm`.`product`.`item_variant`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Auto Substitute Flag"
      expr: auto_substitute_flag
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Consent Required Flag"
      expr: customer_consent_required_flag
    - name: "Display Sequence"
      expr: display_sequence
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inventory Interchangeable Flag"
      expr: inventory_interchangeable_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Relationship Status"
      expr: relationship_status
    - name: "Relationship Type"
      expr: relationship_type
    - name: "Source System Code"
      expr: source_system_code
    - name: "Substitution Priority Rank"
      expr: substitution_priority_rank
    - name: "Substitution Type"
      expr: substitution_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Item Variant"
      expr: COUNT(DISTINCT item_variant_id)
    - name: "Total Price Differential Amount"
      expr: SUM(price_differential_amount)
    - name: "Average Price Differential Amount"
      expr: AVG(price_differential_amount)
    - name: "Total Variant Dimension Value"
      expr: SUM(variant_dimension_value)
    - name: "Average Variant Dimension Value"
      expr: AVG(variant_dimension_value)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Brand business metrics"
  source: "`retail_ecm`.`product`.`product_brand`"
  dimensions:
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Description"
      expr: brand_description
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Status"
      expr: brand_status
    - name: "Brand Tier"
      expr: brand_tier
    - name: "Brand Type"
      expr: brand_type
    - name: "Country Of Origin Code"
      expr: country_of_origin_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Is Licensed"
      expr: is_licensed
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Launch Date"
      expr: launch_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "License Expiration Date"
      expr: license_expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Brand"
      expr: COUNT(DISTINCT product_brand_id)
    - name: "Total Average Margin Percent"
      expr: SUM(average_margin_percent)
    - name: "Average Average Margin Percent"
      expr: AVG(average_margin_percent)
    - name: "Total Quality Rating"
      expr: SUM(quality_rating)
    - name: "Average Quality Rating"
      expr: AVG(quality_rating)
    - name: "Total Return Rate Percent"
      expr: SUM(return_rate_percent)
    - name: "Average Return Rate Percent"
      expr: AVG(return_rate_percent)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_product_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Compliance business metrics"
  source: "`retail_ecm`.`product`.`product_compliance`"
  dimensions:
    - name: "Age Restriction Required"
      expr: age_restriction_required
    - name: "Allergen Declaration Compliant"
      expr: allergen_declaration_compliant
    - name: "Certification Number"
      expr: certification_number
    - name: "Certifying Body"
      expr: certifying_body
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Compliance Type"
      expr: compliance_type
    - name: "Country Code"
      expr: country_code
    - name: "Country Of Origin Compliant"
      expr: country_of_origin_compliant
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fda Food Facility Registration"
      expr: fda_food_facility_registration
    - name: "Hazmat Classification"
      expr: hazmat_classification
    - name: "Import License Number"
      expr: import_license_number
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Compliance"
      expr: COUNT(DISTINCT product_compliance_id)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall business metrics"
  source: "`retail_ecm`.`product`.`recall`"
  dimensions:
    - name: "Affected Date Range End"
      expr: affected_date_range_end
    - name: "Affected Date Range Start"
      expr: affected_date_range_start
    - name: "Affected Lot Numbers"
      expr: affected_lot_numbers
    - name: "Completion Date"
      expr: completion_date
    - name: "Coordinator Email"
      expr: coordinator_email
    - name: "Coordinator Phone"
      expr: coordinator_phone
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Country Of Origin Code"
      expr: country_of_origin_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Method"
      expr: customer_notification_method
    - name: "Hazard Description"
      expr: hazard_description
    - name: "Initiation Date"
      expr: initiation_date
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manufacturer Name"
      expr: manufacturer_name
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recall"
      expr: COUNT(DISTINCT recall_id)
    - name: "Total Chargeback Amount"
      expr: SUM(chargeback_amount)
    - name: "Average Chargeback Amount"
      expr: AVG(chargeback_amount)
    - name: "Total Estimated Financial Impact Amount"
      expr: SUM(estimated_financial_impact_amount)
    - name: "Average Estimated Financial Impact Amount"
      expr: AVG(estimated_financial_impact_amount)
    - name: "Total Recovery Rate Percent"
      expr: SUM(recovery_rate_percent)
    - name: "Average Recovery Rate Percent"
      expr: AVG(recovery_rate_percent)
    - name: "Total Units Affected"
      expr: SUM(units_affected)
    - name: "Average Units Affected"
      expr: AVG(units_affected)
    - name: "Total Units In Customer Hands"
      expr: SUM(units_in_customer_hands)
    - name: "Average Units In Customer Hands"
      expr: AVG(units_in_customer_hands)
    - name: "Total Units Recovered"
      expr: SUM(units_recovered)
    - name: "Average Units Recovered"
      expr: AVG(units_recovered)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku business metrics"
  source: "`retail_ecm`.`product`.`sku`"
  dimensions:
    - name: "Age Restriction Flag"
      expr: age_restriction_flag
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dimension Unit Of Measure"
      expr: dimension_unit_of_measure
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Ean"
      expr: ean
    - name: "Effective Date"
      expr: effective_date
    - name: "Gtin"
      expr: gtin
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Hi"
      expr: hi
    - name: "Image Url"
      expr: image_url
    - name: "Internal Item Number"
      expr: internal_item_number
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Minimum Age Requirement"
      expr: minimum_age_requirement
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Pack Size"
      expr: pack_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku"
      expr: COUNT(DISTINCT sku_id)
    - name: "Total Cube"
      expr: SUM(cube)
    - name: "Average Cube"
      expr: AVG(cube)
    - name: "Total Gross Weight"
      expr: SUM(gross_weight)
    - name: "Average Gross Weight"
      expr: AVG(gross_weight)
    - name: "Total Height"
      expr: SUM(height)
    - name: "Average Height"
      expr: AVG(height)
    - name: "Total Length"
      expr: SUM(length)
    - name: "Average Length"
      expr: AVG(length)
    - name: "Total Net Weight"
      expr: SUM(net_weight)
    - name: "Average Net Weight"
      expr: AVG(net_weight)
    - name: "Total Volume"
      expr: SUM(volume)
    - name: "Average Volume"
      expr: AVG(volume)
    - name: "Total Width"
      expr: SUM(width)
    - name: "Average Width"
      expr: AVG(width)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`product_uom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Uom business metrics"
  source: "`retail_ecm`.`product`.`uom`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gs1 Uom Code"
      expr: gs1_uom_code
    - name: "Is Base Unit"
      expr: is_base_unit
    - name: "Is Consumer Unit"
      expr: is_consumer_unit
    - name: "Is Fractional Allowed"
      expr: is_fractional_allowed
    - name: "Is Inventory Tracked"
      expr: is_inventory_tracked
    - name: "Is Orderable"
      expr: is_orderable
    - name: "Is Variable Measure"
      expr: is_variable_measure
    - name: "Iso Uom Code"
      expr: iso_uom_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Precision Decimal Places"
      expr: precision_decimal_places
    - name: "Sort Order"
      expr: sort_order
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Uom"
      expr: COUNT(DISTINCT uom_id)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Inverse Conversion Factor"
      expr: SUM(inverse_conversion_factor)
    - name: "Average Inverse Conversion Factor"
      expr: AVG(inverse_conversion_factor)
$$;