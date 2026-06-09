-- Metric views for domain: product | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:05:01

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom business metrics"
  source: "`apparel_fashion_ecm`.`product`.`bom`"
  dimensions:
    - name: "Bom Number"
      expr: bom_number
    - name: "Bom Status"
      expr: bom_status
    - name: "Bom Type"
      expr: bom_type
    - name: "Cost Approval Status"
      expr: cost_approval_status
    - name: "Cost Approved Date"
      expr: cost_approved_date
    - name: "Cost Version"
      expr: cost_version
    - name: "Costing Stage"
      expr: costing_stage
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fabric Content Percentage"
      expr: fabric_content_percentage
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom"
      expr: COUNT(DISTINCT bom_id)
    - name: "Total Cmt Cost"
      expr: SUM(cmt_cost)
    - name: "Average Cmt Cost"
      expr: AVG(cmt_cost)
    - name: "Total Cut Cost"
      expr: SUM(cut_cost)
    - name: "Average Cut Cost"
      expr: AVG(cut_cost)
    - name: "Total Duty Cost"
      expr: SUM(duty_cost)
    - name: "Average Duty Cost"
      expr: AVG(duty_cost)
    - name: "Total Duty Rate"
      expr: SUM(duty_rate)
    - name: "Average Duty Rate"
      expr: AVG(duty_rate)
    - name: "Total Fob Cost"
      expr: SUM(fob_cost)
    - name: "Average Fob Cost"
      expr: AVG(fob_cost)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Imu Percentage"
      expr: SUM(imu_percentage)
    - name: "Average Imu Percentage"
      expr: AVG(imu_percentage)
    - name: "Total Ldp Cost"
      expr: SUM(ldp_cost)
    - name: "Average Ldp Cost"
      expr: AVG(ldp_cost)
    - name: "Total Make Cost"
      expr: SUM(make_cost)
    - name: "Average Make Cost"
      expr: AVG(make_cost)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
    - name: "Total Target Cogs"
      expr: SUM(target_cogs)
    - name: "Average Target Cogs"
      expr: AVG(target_cogs)
    - name: "Total Total Material Cost"
      expr: SUM(total_material_cost)
    - name: "Average Total Material Cost"
      expr: AVG(total_material_cost)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Line business metrics"
  source: "`apparel_fashion_ecm`.`product`.`bom_line`"
  dimensions:
    - name: "Approved Date"
      expr: approved_date
    - name: "Bom Line Status"
      expr: bom_line_status
    - name: "Change Reason"
      expr: change_reason
    - name: "Color Specification"
      expr: color_specification
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hs Code"
      expr: hs_code
    - name: "Is Critical Path"
      expr: is_critical_path
    - name: "Is Sustainable"
      expr: is_sustainable
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Number"
      expr: line_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Line"
      expr: COUNT(DISTINCT bom_line_id)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total Quantity Per Unit"
      expr: SUM(quantity_per_unit)
    - name: "Average Quantity Per Unit"
      expr: AVG(quantity_per_unit)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Waste Percentage"
      expr: SUM(waste_percentage)
    - name: "Average Waste Percentage"
      expr: AVG(waste_percentage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand business metrics"
  source: "`apparel_fashion_ecm`.`product`.`brand`"
  dimensions:
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Description"
      expr: brand_description
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Status"
      expr: brand_status
    - name: "Classification"
      expr: classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Founding Year"
      expr: founding_year
    - name: "Launch Date"
      expr: launch_date
    - name: "License End Date"
      expr: license_end_date
    - name: "License Start Date"
      expr: license_start_date
    - name: "License Type"
      expr: license_type
    - name: "Licensor Name"
      expr: licensor_name
    - name: "Logo Url"
      expr: logo_url
    - name: "Manager Email"
      expr: manager_email
    - name: "Manager Name"
      expr: manager_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand"
      expr: COUNT(DISTINCT brand_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category business metrics"
  source: "`apparel_fashion_ecm`.`product`.`category`"
  dimensions:
    - name: "Age Group"
      expr: age_group
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
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Color Palette Strategy"
      expr: color_palette_strategy
    - name: "Country Of Origin Primary"
      expr: country_of_origin_primary
    - name: "Cpsc Regulated"
      expr: cpsc_regulated
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ecommerce Display Sequence"
      expr: ecommerce_display_sequence
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Ftc Labeling Required"
      expr: ftc_labeling_required
    - name: "Gender"
      expr: gender
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category"
      expr: COUNT(DISTINCT category_id)
    - name: "Total Duty Rate Percent"
      expr: SUM(duty_rate_percent)
    - name: "Average Duty Rate Percent"
      expr: AVG(duty_rate_percent)
    - name: "Total Margin Target Percent"
      expr: SUM(margin_target_percent)
    - name: "Average Margin Target Percent"
      expr: AVG(margin_target_percent)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection business metrics"
  source: "`apparel_fashion_ecm`.`product`.`collection`"
  dimensions:
    - name: "Actual Launch Date"
      expr: actual_launch_date
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Collaboration Partner"
      expr: collaboration_partner
    - name: "Collection Code"
      expr: collection_code
    - name: "Collection Name"
      expr: collection_name
    - name: "Collection Status"
      expr: collection_status
    - name: "Collection Type"
      expr: collection_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Direction Notes"
      expr: creative_direction_notes
    - name: "Currency Code"
      expr: currency_code
    - name: "End Of Life Date"
      expr: end_of_life_date
    - name: "Gender Target"
      expr: gender_target
    - name: "Geographic Market"
      expr: geographic_market
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collection"
      expr: COUNT(DISTINCT collection_id)
    - name: "Total Average Unit Retail"
      expr: SUM(average_unit_retail)
    - name: "Average Average Unit Retail"
      expr: AVG(average_unit_retail)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Target Margin Percent"
      expr: SUM(target_margin_percent)
    - name: "Average Target Margin Percent"
      expr: AVG(target_margin_percent)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_colorway`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Colorway business metrics"
  source: "`apparel_fashion_ecm`.`product`.`colorway`"
  dimensions:
    - name: "Age Group"
      expr: age_group
    - name: "Color Family"
      expr: color_family
    - name: "Color Standard"
      expr: color_standard
    - name: "Color Story"
      expr: color_story
    - name: "Colorway Code"
      expr: colorway_code
    - name: "Colorway Name"
      expr: colorway_name
    - name: "Colorway Status"
      expr: colorway_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Exclusivity Description"
      expr: exclusivity_description
    - name: "Finish Type"
      expr: finish_type
    - name: "Gender Target"
      expr: gender_target
    - name: "Hex Color Code"
      expr: hex_color_code
    - name: "Image Url"
      expr: image_url
    - name: "Is Exclusive"
      expr: is_exclusive
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Colorway"
      expr: COUNT(DISTINCT colorway_id)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_cost_sheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Sheet business metrics"
  source: "`apparel_fashion_ecm`.`product`.`cost_sheet`"
  dimensions:
    - name: "Approved Date"
      expr: approved_date
    - name: "Cost Sheet Number"
      expr: cost_sheet_number
    - name: "Cost Sheet Status"
      expr: cost_sheet_status
    - name: "Costing Stage"
      expr: costing_stage
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Country"
      expr: destination_country
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hs Code"
      expr: hs_code
    - name: "Incoterm"
      expr: incoterm
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Moq"
      expr: moq
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Sheet"
      expr: COUNT(DISTINCT cost_sheet_id)
    - name: "Total Actual Cogs"
      expr: SUM(actual_cogs)
    - name: "Average Actual Cogs"
      expr: AVG(actual_cogs)
    - name: "Total Cmt Cost"
      expr: SUM(cmt_cost)
    - name: "Average Cmt Cost"
      expr: AVG(cmt_cost)
    - name: "Total Fabric Cost"
      expr: SUM(fabric_cost)
    - name: "Average Fabric Cost"
      expr: AVG(fabric_cost)
    - name: "Total Fob Cost"
      expr: SUM(fob_cost)
    - name: "Average Fob Cost"
      expr: AVG(fob_cost)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Imu Percent"
      expr: SUM(imu_percent)
    - name: "Average Imu Percent"
      expr: AVG(imu_percent)
    - name: "Total Labor Cost"
      expr: SUM(labor_cost)
    - name: "Average Labor Cost"
      expr: AVG(labor_cost)
    - name: "Total Ldp Cost"
      expr: SUM(ldp_cost)
    - name: "Average Ldp Cost"
      expr: AVG(ldp_cost)
    - name: "Total Material Cost"
      expr: SUM(material_cost)
    - name: "Average Material Cost"
      expr: AVG(material_cost)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
    - name: "Total Overhead Cost"
      expr: SUM(overhead_cost)
    - name: "Average Overhead Cost"
      expr: AVG(overhead_cost)
    - name: "Total Packaging Cost"
      expr: SUM(packaging_cost)
    - name: "Average Packaging Cost"
      expr: AVG(packaging_cost)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material business metrics"
  source: "`apparel_fashion_ecm`.`product`.`material`"
  dimensions:
    - name: "Bci Certified"
      expr: bci_certified
    - name: "Care Instructions"
      expr: care_instructions
    - name: "Color Code"
      expr: color_code
    - name: "Color Name"
      expr: color_name
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Cost Unit Of Measure"
      expr: cost_unit_of_measure
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Date"
      expr: created_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiber Composition"
      expr: fiber_composition
    - name: "Finish Treatment"
      expr: finish_treatment
    - name: "Gots Certified"
      expr: gots_certified
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Material Category"
      expr: material_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material"
      expr: COUNT(DISTINCT material_id)
    - name: "Total Cotton Percentage"
      expr: SUM(cotton_percentage)
    - name: "Average Cotton Percentage"
      expr: AVG(cotton_percentage)
    - name: "Total Moq Quantity"
      expr: SUM(moq_quantity)
    - name: "Average Moq Quantity"
      expr: AVG(moq_quantity)
    - name: "Total Polyester Percentage"
      expr: SUM(polyester_percentage)
    - name: "Average Polyester Percentage"
      expr: AVG(polyester_percentage)
    - name: "Total Recycled Content Percentage"
      expr: SUM(recycled_content_percentage)
    - name: "Average Recycled Content Percentage"
      expr: AVG(recycled_content_percentage)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Weight Gsm"
      expr: SUM(weight_gsm)
    - name: "Average Weight Gsm"
      expr: AVG(weight_gsm)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_msrp_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Msrp Price business metrics"
  source: "`apparel_fashion_ecm`.`product`.`msrp_price`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Code"
      expr: market_code
    - name: "Notes"
      expr: notes
    - name: "Price Change Reason"
      expr: price_change_reason
    - name: "Price Point Strategy"
      expr: price_point_strategy
    - name: "Price Tier"
      expr: price_tier
    - name: "Price Zone"
      expr: price_zone
    - name: "Season Code"
      expr: season_code
    - name: "Source Record Reference"
      expr: source_record_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Msrp Price"
      expr: COUNT(DISTINCT msrp_price_id)
    - name: "Total Aur Target"
      expr: SUM(aur_target)
    - name: "Average Aur Target"
      expr: AVG(aur_target)
    - name: "Total Competitor Benchmark Price"
      expr: SUM(competitor_benchmark_price)
    - name: "Average Competitor Benchmark Price"
      expr: AVG(competitor_benchmark_price)
    - name: "Total Cost Basis"
      expr: SUM(cost_basis)
    - name: "Average Cost Basis"
      expr: AVG(cost_basis)
    - name: "Total Imu Percentage"
      expr: SUM(imu_percentage)
    - name: "Average Imu Percentage"
      expr: AVG(imu_percentage)
    - name: "Total Minimum Advertised Price"
      expr: SUM(minimum_advertised_price)
    - name: "Average Minimum Advertised Price"
      expr: AVG(minimum_advertised_price)
    - name: "Total Msrp Amount"
      expr: SUM(msrp_amount)
    - name: "Average Msrp Amount"
      expr: AVG(msrp_amount)
    - name: "Total Recommended Markdown Percentage"
      expr: SUM(recommended_markdown_percentage)
    - name: "Average Recommended Markdown Percentage"
      expr: AVG(recommended_markdown_percentage)
    - name: "Total Wholesale Price"
      expr: SUM(wholesale_price)
    - name: "Average Wholesale Price"
      expr: AVG(wholesale_price)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample business metrics"
  source: "`apparel_fashion_ecm`.`product`.`sample`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fit Comments"
      expr: fit_comments
    - name: "Fit Evaluation Result"
      expr: fit_evaluation_result
    - name: "Iteration Number"
      expr: iteration_number
    - name: "Location"
      expr: location
    - name: "Material Composition"
      expr: material_composition
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Photo Url"
      expr: photo_url
    - name: "Quality Defects"
      expr: quality_defects
    - name: "Quality Inspection Result"
      expr: quality_inspection_result
    - name: "Requested Date"
      expr: requested_date
    - name: "Sample Code"
      expr: sample_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sample"
      expr: COUNT(DISTINCT sample_id)
    - name: "Total Cost"
      expr: SUM(cost)
    - name: "Average Cost"
      expr: AVG(cost)
    - name: "Total Measurement Chest Cm"
      expr: SUM(measurement_chest_cm)
    - name: "Average Measurement Chest Cm"
      expr: AVG(measurement_chest_cm)
    - name: "Total Measurement Hip Cm"
      expr: SUM(measurement_hip_cm)
    - name: "Average Measurement Hip Cm"
      expr: AVG(measurement_hip_cm)
    - name: "Total Measurement Length Cm"
      expr: SUM(measurement_length_cm)
    - name: "Average Measurement Length Cm"
      expr: AVG(measurement_length_cm)
    - name: "Total Measurement Waist Cm"
      expr: SUM(measurement_waist_cm)
    - name: "Average Measurement Waist Cm"
      expr: AVG(measurement_waist_cm)
    - name: "Total Weight Grams"
      expr: SUM(weight_grams)
    - name: "Average Weight Grams"
      expr: AVG(weight_grams)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_size_scale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Size Scale business metrics"
  source: "`apparel_fashion_ecm`.`product`.`size_scale`"
  dimensions:
    - name: "Brand Applicability"
      expr: brand_applicability
    - name: "Conversion Table Reference"
      expr: conversion_table_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default For Category"
      expr: default_for_category
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Erp System Code"
      expr: erp_system_code
    - name: "Fit Model Reference"
      expr: fit_model_reference
    - name: "Gender Applicability"
      expr: gender_applicability
    - name: "Grading Rule Reference"
      expr: grading_rule_reference
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Measurement System"
      expr: measurement_system
    - name: "Measurement Unit"
      expr: measurement_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Size Scale"
      expr: COUNT(DISTINCT size_scale_id)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku business metrics"
  source: "`apparel_fashion_ecm`.`product`.`sku`"
  dimensions:
    - name: "Age Group"
      expr: age_group
    - name: "Ats Flag"
      expr: ats_flag
    - name: "Care Instructions"
      expr: care_instructions
    - name: "Color Code"
      expr: color_code
    - name: "Color Name"
      expr: color_name
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Ean"
      expr: ean
    - name: "Gender"
      expr: gender
    - name: "Gsp Eligible"
      expr: gsp_eligible
    - name: "Gtin"
      expr: gtin
    - name: "Launch Date"
      expr: launch_date
    - name: "Material Composition"
      expr: material_composition
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku"
      expr: COUNT(DISTINCT sku_id)
    - name: "Total Cost"
      expr: SUM(cost)
    - name: "Average Cost"
      expr: AVG(cost)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Imu Percent"
      expr: SUM(imu_percent)
    - name: "Average Imu Percent"
      expr: AVG(imu_percent)
    - name: "Total Length Cm"
      expr: SUM(length_cm)
    - name: "Average Length Cm"
      expr: AVG(length_cm)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
    - name: "Total Wholesale Price"
      expr: SUM(wholesale_price)
    - name: "Average Wholesale Price"
      expr: AVG(wholesale_price)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_style`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Style business metrics"
  source: "`apparel_fashion_ecm`.`product`.`style`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Care Instructions"
      expr: care_instructions
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Design Owner"
      expr: design_owner
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Division"
      expr: division
    - name: "Gender"
      expr: gender
    - name: "Is Core Style"
      expr: is_core_style
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Launch Date"
      expr: launch_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lifecycle Stage"
      expr: lifecycle_stage
    - name: "Material Composition"
      expr: material_composition
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Style"
      expr: COUNT(DISTINCT style_id)
    - name: "Total Cost Of Goods Sold"
      expr: SUM(cost_of_goods_sold)
    - name: "Average Cost Of Goods Sold"
      expr: AVG(cost_of_goods_sold)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
    - name: "Total Wholesale Price"
      expr: SUM(wholesale_price)
    - name: "Average Wholesale Price"
      expr: AVG(wholesale_price)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_tech_pack`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tech Pack business metrics"
  source: "`apparel_fashion_ecm`.`product`.`tech_pack`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Base Size"
      expr: base_size
    - name: "Care Instructions"
      expr: care_instructions
    - name: "Construction Description"
      expr: construction_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fit Evaluation Criteria"
      expr: fit_evaluation_criteria
    - name: "Fit Model Reference"
      expr: fit_model_reference
    - name: "Fit Type"
      expr: fit_type
    - name: "Gender"
      expr: gender
    - name: "Grade Rules"
      expr: grade_rules
    - name: "Is Active"
      expr: is_active
    - name: "Issued To Factory Date"
      expr: issued_to_factory_date
    - name: "Labeling Requirements"
      expr: labeling_requirements
    - name: "Material Composition"
      expr: material_composition
    - name: "Measurement Points"
      expr: measurement_points
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tech Pack"
      expr: COUNT(DISTINCT tech_pack_id)
    - name: "Total Fabric Weight Gsm"
      expr: SUM(fabric_weight_gsm)
    - name: "Average Fabric Weight Gsm"
      expr: AVG(fabric_weight_gsm)
    - name: "Total Seam Allowance Cm"
      expr: SUM(seam_allowance_cm)
    - name: "Average Seam Allowance Cm"
      expr: AVG(seam_allowance_cm)
$$;