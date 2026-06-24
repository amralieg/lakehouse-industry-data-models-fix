-- Metric views for domain: product | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:40:43

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bom Line business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`bom_line`"
  dimensions:
    - name: "Alternative Item Group"
      expr: alternative_item_group
    - name: "Alternative Priority"
      expr: alternative_priority
    - name: "Bom Item Category"
      expr: bom_item_category
    - name: "Bulk Material Flag"
      expr: bulk_material_flag
    - name: "Change Number"
      expr: change_number
    - name: "Co Product Flag"
      expr: co_product_flag
    - name: "Component Description"
      expr: component_description
    - name: "Component Item Number"
      expr: component_item_number
    - name: "Component Type"
      expr: component_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fixed Quantity Flag"
      expr: fixed_quantity_flag
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Inci Name"
      expr: inci_name
    - name: "Is Alternative Item"
      expr: is_alternative_item
    - name: "Is Critical Component"
      expr: is_critical_component
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bom Line"
      expr: COUNT(DISTINCT bom_line_id)
    - name: "Total Component Cost Usd"
      expr: SUM(component_cost_usd)
    - name: "Average Component Cost Usd"
      expr: AVG(component_cost_usd)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Operation Number"
      expr: SUM(operation_number)
    - name: "Average Operation Number"
      expr: AVG(operation_number)
    - name: "Total Required Quantity"
      expr: SUM(required_quantity)
    - name: "Average Required Quantity"
      expr: AVG(required_quantity)
    - name: "Total Scrap Percentage"
      expr: SUM(scrap_percentage)
    - name: "Average Scrap Percentage"
      expr: AVG(scrap_percentage)
    - name: "Total Usage Probability Pct"
      expr: SUM(usage_probability_pct)
    - name: "Average Usage Probability Pct"
      expr: AVG(usage_probability_pct)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`category`"
  dimensions:
    - name: "Classification Type"
      expr: classification_type
    - name: "Category Code"
      expr: category_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Category Description"
      expr: category_description
    - name: "Display Order"
      expr: display_order
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Image Url"
      expr: image_url
    - name: "Is Leaf"
      expr: is_leaf
    - name: "Marketing Tag"
      expr: marketing_tag
    - name: "Category Name"
      expr: category_name
    - name: "Category Status"
      expr: category_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "V2 Added Flag"
      expr: v2_added_flag
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category"
      expr: COUNT(DISTINCT category_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`certification`"
  dimensions:
    - name: "Applicable Channels"
      expr: applicable_channels
    - name: "Applicable Markets"
      expr: applicable_markets
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Result"
      expr: audit_result
    - name: "Body"
      expr: body
    - name: "Certificate Document Reference"
      expr: certificate_document_reference
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Claim Text"
      expr: claim_text
    - name: "Consumer Facing Flag"
      expr: consumer_facing_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Issue Date"
      expr: issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certification"
      expr: COUNT(DISTINCT certification_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_freight_contract_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight Contract Assignment business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`freight_contract_assignment`"
  dimensions:
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "V2 Added Flag"
      expr: v2_added_flag
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
    - name: "Expiry Date Month"
      expr: DATE_TRUNC('MONTH', expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Freight Contract Assignment"
      expr: COUNT(DISTINCT freight_contract_assignment_id)
    - name: "Total Agreed Rate"
      expr: SUM(agreed_rate)
    - name: "Average Agreed Rate"
      expr: AVG(agreed_rate)
    - name: "Total Volume Commitment"
      expr: SUM(volume_commitment)
    - name: "Average Volume Commitment"
      expr: AVG(volume_commitment)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_gtin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gtin Registry business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`gtin_registry`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Barcode Symbology"
      expr: barcode_symbology
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Owner Gln"
      expr: brand_owner_gln
    - name: "Cases Per Pallet"
      expr: cases_per_pallet
    - name: "Check Digit"
      expr: check_digit
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Pool Publication Date"
      expr: data_pool_publication_date
    - name: "Data Pool Published"
      expr: data_pool_published
    - name: "Edi Eligible"
      expr: edi_eligible
    - name: "Gpc Brick Code"
      expr: gpc_brick_code
    - name: "Gs1 Company Prefix"
      expr: gs1_company_prefix
    - name: "Gs1 Member Org"
      expr: gs1_member_org
    - name: "Gs1 Registration Reference"
      expr: gs1_registration_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gtin Registry"
      expr: COUNT(DISTINCT gtin_registry_id)
    - name: "Total Ean Value"
      expr: SUM(ean_value)
    - name: "Average Ean Value"
      expr: AVG(ean_value)
    - name: "Total Gtin Value"
      expr: SUM(gtin_value)
    - name: "Average Gtin Value"
      expr: AVG(gtin_value)
    - name: "Total Net Content Value"
      expr: SUM(net_content_value)
    - name: "Average Net Content Value"
      expr: AVG(net_content_value)
    - name: "Total Upc Value"
      expr: SUM(upc_value)
    - name: "Average Upc Value"
      expr: AVG(upc_value)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hierarchy business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`hierarchy`"
  dimensions:
    - name: "Approved Date"
      expr: approved_date
    - name: "Brand Code"
      expr: brand_code
    - name: "Category Code"
      expr: category_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Consumer Segment"
      expr: consumer_segment
    - name: "Cpsc Regulated"
      expr: cpsc_regulated
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Division Code"
      expr: division_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Gmp Standard"
      expr: gmp_standard
    - name: "Gpc Brick Code"
      expr: gpc_brick_code
    - name: "Gpc Brick Name"
      expr: gpc_brick_name
    - name: "Ibp Planning Level"
      expr: ibp_planning_level
    - name: "Inci Applicable"
      expr: inci_applicable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hierarchy"
      expr: COUNT(DISTINCT hierarchy_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_label_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Label Spec business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`label_spec`"
  dimensions:
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Approval Status"
      expr: approval_status
    - name: "Artwork File Reference"
      expr: artwork_file_reference
    - name: "Barcode Placement"
      expr: barcode_placement
    - name: "Barcode Type"
      expr: barcode_type
    - name: "Certification Marks"
      expr: certification_marks
    - name: "Claim Text"
      expr: claim_text
    - name: "Color Profile"
      expr: color_profile
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Digital Watermark Enabled"
      expr: digital_watermark_enabled
    - name: "Distributor Name"
      expr: distributor_name
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gtin"
      expr: gtin
    - name: "Ingredient Declaration Text"
      expr: ingredient_declaration_text
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Label Spec"
      expr: COUNT(DISTINCT label_spec_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`material`"
  dimensions:
    - name: "Allergen Info"
      expr: allergen_info
    - name: "Base Uom"
      expr: base_uom
    - name: "Brand Name"
      expr: brand_name
    - name: "Material Code"
      expr: material_code
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Material Description"
      expr: material_description
    - name: "Ean"
      expr: ean
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Gtin"
      expr: gtin
    - name: "Hazardous Flag"
      expr: hazardous_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lifecycle Stage"
      expr: lifecycle_stage
    - name: "Material Group"
      expr: material_group
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material"
      expr: COUNT(DISTINCT material_id)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Storage Temperature C"
      expr: SUM(storage_temperature_c)
    - name: "Average Storage Temperature C"
      expr: AVG(storage_temperature_c)
    - name: "Total Unit Conversion Factor"
      expr: SUM(unit_conversion_factor)
    - name: "Average Unit Conversion Factor"
      expr: AVG(unit_conversion_factor)
    - name: "Total Volume L"
      expr: SUM(volume_l)
    - name: "Average Volume L"
      expr: AVG(volume_l)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_pack_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pack Hierarchy business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`pack_hierarchy`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cumulative Quantity"
      expr: cumulative_quantity
    - name: "Display Ready Flag"
      expr: display_ready_flag
    - name: "Ean"
      expr: ean
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gtin"
      expr: gtin
    - name: "Hi Count"
      expr: hi_count
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Max Stack Height"
      expr: max_stack_height
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Moq"
      expr: moq
    - name: "Orderable Flag"
      expr: orderable_flag
    - name: "Pack Hierarchy Status"
      expr: pack_hierarchy_status
    - name: "Packaging Material"
      expr: packaging_material
    - name: "Pallet Type"
      expr: pallet_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pack Hierarchy"
      expr: COUNT(DISTINCT pack_hierarchy_id)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Length Cm"
      expr: SUM(length_cm)
    - name: "Average Length Cm"
      expr: AVG(length_cm)
    - name: "Total Net Weight Kg"
      expr: SUM(net_weight_kg)
    - name: "Average Net Weight Kg"
      expr: AVG(net_weight_kg)
    - name: "Total Recycled Content Percentage"
      expr: SUM(recycled_content_percentage)
    - name: "Average Recycled Content Percentage"
      expr: AVG(recycled_content_percentage)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
    - name: "Total Volume Cubic Cm"
      expr: SUM(volume_cubic_cm)
    - name: "Average Volume Cubic Cm"
      expr: AVG(volume_cubic_cm)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_plm_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plm Transition business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`plm_transition`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Reference"
      expr: approval_reference
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "From Stage Code"
      expr: from_stage_code
    - name: "Gate Criteria Detail"
      expr: gate_criteria_detail
    - name: "Gate Criteria Validation Result"
      expr: gate_criteria_validation_result
    - name: "Gate Review Notes"
      expr: gate_review_notes
    - name: "Is Fast Track"
      expr: is_fast_track
    - name: "Product Category Code"
      expr: product_category_code
    - name: "Regulatory Submission Reference"
      expr: regulatory_submission_reference
    - name: "Regulatory Submission Required"
      expr: regulatory_submission_required
    - name: "Revised Launch Date"
      expr: revised_launch_date
    - name: "Source System Code"
      expr: source_system_code
    - name: "Source System Transition Code"
      expr: source_system_transition_code
    - name: "Stage Entry Date"
      expr: stage_entry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plm Transition"
      expr: COUNT(DISTINCT plm_transition_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Bom business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_bom`"
  dimensions:
    - name: "Alternative Bom"
      expr: alternative_bom
    - name: "Approved Date"
      expr: approved_date
    - name: "Base Uom"
      expr: base_uom
    - name: "Bom Category"
      expr: bom_category
    - name: "Bom Description"
      expr: bom_description
    - name: "Bom Level"
      expr: bom_level
    - name: "Bom Number"
      expr: bom_number
    - name: "Bom Type"
      expr: bom_type
    - name: "Change Number"
      expr: change_number
    - name: "Component Count"
      expr: component_count
    - name: "Costing Relevance"
      expr: costing_relevance
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deletion Flag"
      expr: deletion_flag
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Formulation Code"
      expr: formulation_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Bom"
      expr: COUNT(DISTINCT product_bom_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
    - name: "Total Lot Size From"
      expr: SUM(lot_size_from)
    - name: "Average Lot Size From"
      expr: AVG(lot_size_from)
    - name: "Total Lot Size To"
      expr: SUM(lot_size_to)
    - name: "Average Lot Size To"
      expr: AVG(lot_size_to)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Brand business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_brand`"
  dimensions:
    - name: "Architecture Type"
      expr: architecture_type
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Status"
      expr: brand_status
    - name: "Brand Tier"
      expr: brand_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Divestiture Date"
      expr: divestiture_date
    - name: "Ean Prefix"
      expr: ean_prefix
    - name: "Equity Methodology"
      expr: equity_methodology
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Gmp Certification Ref"
      expr: gmp_certification_ref
    - name: "Is Licensed Brand"
      expr: is_licensed_brand
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Launch Date"
      expr: launch_date
    - name: "Launch Year"
      expr: launch_year
    - name: "License Expiry Date"
      expr: license_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Brand"
      expr: COUNT(DISTINCT product_brand_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Category business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_category`"
  dimensions:
    - name: "Business Unit"
      expr: business_unit
    - name: "Category Code"
      expr: category_code
    - name: "Category Description"
      expr: category_description
    - name: "Category Name"
      expr: category_name
    - name: "Classification"
      expr: classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Leaf"
      expr: is_leaf
    - name: "Source System Code"
      expr: source_system_code
    - name: "Product Category Status"
      expr: product_category_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "V2 Added Flag"
      expr: v2_added_flag
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Category"
      expr: COUNT(DISTINCT product_category_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Claim business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_claim`"
  dimensions:
    - name: "Applicable Markets"
      expr: applicable_markets
    - name: "Approval Date"
      expr: approval_date
    - name: "Certification Body"
      expr: certification_body
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Certification Number"
      expr: certification_number
    - name: "Channel"
      expr: channel
    - name: "Claim Code"
      expr: claim_code
    - name: "Claim Scope"
      expr: claim_scope
    - name: "Claim Status"
      expr: claim_status
    - name: "Claim Text"
      expr: claim_text
    - name: "Claim Type"
      expr: claim_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Environmental Claim Standard"
      expr: environmental_claim_standard
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fda Reviewed"
      expr: fda_reviewed
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Claim"
      expr: COUNT(DISTINCT product_claim_id)
    - name: "Total Claim Value"
      expr: SUM(claim_value)
    - name: "Average Claim Value"
      expr: AVG(claim_value)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Formulation business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_formulation`"
  dimensions:
    - name: "Active Ingredient Name"
      expr: active_ingredient_name
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Approval Date"
      expr: approval_date
    - name: "Bom Reference Code"
      expr: bom_reference_code
    - name: "Color Description"
      expr: color_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Formulation Code"
      expr: formulation_code
    - name: "Formulation Name"
      expr: formulation_name
    - name: "Formulation Type"
      expr: formulation_type
    - name: "Fragrance Code"
      expr: fragrance_code
    - name: "Gmp Compliance Flag"
      expr: gmp_compliance_flag
    - name: "Inci Declaration"
      expr: inci_declaration
    - name: "Intended Use"
      expr: intended_use
    - name: "Is Cruelty Free"
      expr: is_cruelty_free
    - name: "Is Fragrance Free"
      expr: is_fragrance_free
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Formulation"
      expr: COUNT(DISTINCT product_formulation_id)
    - name: "Total Active Ingredient Pct"
      expr: SUM(active_ingredient_pct)
    - name: "Average Active Ingredient Pct"
      expr: AVG(active_ingredient_pct)
    - name: "Total Ph Max"
      expr: SUM(ph_max)
    - name: "Average Ph Max"
      expr: AVG(ph_max)
    - name: "Total Ph Min"
      expr: SUM(ph_min)
    - name: "Average Ph Min"
      expr: AVG(ph_min)
    - name: "Total Total Solid Content Pct"
      expr: SUM(total_solid_content_pct)
    - name: "Average Total Solid Content Pct"
      expr: AVG(total_solid_content_pct)
    - name: "Total Viscosity Max Cps"
      expr: SUM(viscosity_max_cps)
    - name: "Average Viscosity Max Cps"
      expr: AVG(viscosity_max_cps)
    - name: "Total Viscosity Min Cps"
      expr: SUM(viscosity_min_cps)
    - name: "Average Viscosity Min Cps"
      expr: AVG(viscosity_min_cps)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_formulation_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Formulation Ingredient business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_formulation_ingredient`"
  dimensions:
    - name: "Allergen Declaration"
      expr: allergen_declaration
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cas Number"
      expr: cas_number
    - name: "Concentration Uom"
      expr: concentration_uom
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ec Number"
      expr: ec_number
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fda Status"
      expr: fda_status
    - name: "Ghs Hazard Classification"
      expr: ghs_hazard_classification
    - name: "Grade Specification"
      expr: grade_specification
    - name: "Halal Status"
      expr: halal_status
    - name: "Ifra Compliance Status"
      expr: ifra_compliance_status
    - name: "Inci Name"
      expr: inci_name
    - name: "Ingredient Function"
      expr: ingredient_function
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Formulation Ingredient"
      expr: COUNT(DISTINCT product_formulation_ingredient_id)
    - name: "Total Concentration Max Pct"
      expr: SUM(concentration_max_pct)
    - name: "Average Concentration Max Pct"
      expr: AVG(concentration_max_pct)
    - name: "Total Concentration Min Pct"
      expr: SUM(concentration_min_pct)
    - name: "Average Concentration Min Pct"
      expr: AVG(concentration_min_pct)
    - name: "Total Concentration Nominal Pct"
      expr: SUM(concentration_nominal_pct)
    - name: "Average Concentration Nominal Pct"
      expr: AVG(concentration_nominal_pct)
    - name: "Total Natural Origin Index"
      expr: SUM(natural_origin_index)
    - name: "Average Natural Origin Index"
      expr: AVG(natural_origin_index)
    - name: "Total Regulatory Max Concentration Pct"
      expr: SUM(regulatory_max_concentration_pct)
    - name: "Average Regulatory Max Concentration Pct"
      expr: AVG(regulatory_max_concentration_pct)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Packaging Spec business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_packaging_spec`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Artwork Ref"
      expr: artwork_ref
    - name: "Color"
      expr: color
    - name: "Component Type"
      expr: component_type
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Ean"
      expr: ean
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Finish"
      expr: finish
    - name: "Gtin"
      expr: gtin
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Hi"
      expr: hi
    - name: "Is Fsc Certified"
      expr: is_fsc_certified
    - name: "Is Rspo Certified"
      expr: is_rspo_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Packaging Spec"
      expr: COUNT(DISTINCT product_packaging_spec_id)
    - name: "Total Gross Weight G"
      expr: SUM(gross_weight_g)
    - name: "Average Gross Weight G"
      expr: AVG(gross_weight_g)
    - name: "Total Height Mm"
      expr: SUM(height_mm)
    - name: "Average Height Mm"
      expr: AVG(height_mm)
    - name: "Total Length Mm"
      expr: SUM(length_mm)
    - name: "Average Length Mm"
      expr: AVG(length_mm)
    - name: "Total Pcr Content Pct"
      expr: SUM(pcr_content_pct)
    - name: "Average Pcr Content Pct"
      expr: AVG(pcr_content_pct)
    - name: "Total Tare Weight G"
      expr: SUM(tare_weight_g)
    - name: "Average Tare Weight G"
      expr: AVG(tare_weight_g)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Width Mm"
      expr: SUM(width_mm)
    - name: "Average Width Mm"
      expr: AVG(width_mm)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_product_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Registration business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`product_registration`"
  dimensions:
    - name: "Registration Date"
      expr: registration_date
    - name: "Registration Source"
      expr: registration_source
    - name: "V2 Added Flag"
      expr: v2_added_flag
    - name: "Warranty Status"
      expr: warranty_status
    - name: "Registration Date Month"
      expr: DATE_TRUNC('MONTH', registration_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Registration"
      expr: COUNT(DISTINCT product_registration_id)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`sku`"
  dimensions:
    - name: "Sku Code"
      expr: sku_code
    - name: "Color"
      expr: color
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
    - name: "Generated Flag"
      expr: generated_flag
    - name: "Gtin"
      expr: gtin
    - name: "Inci Declaration"
      expr: inci_declaration
    - name: "Is Hazardous"
      expr: is_hazardous
    - name: "Is Recyclable Packaging"
      expr: is_recyclable_packaging
    - name: "Is Regulated Product"
      expr: is_regulated_product
    - name: "Is Sustainable"
      expr: is_sustainable
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Launch Date"
      expr: launch_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku"
      expr: COUNT(DISTINCT sku_id)
    - name: "Total Fefo Threshold Pct"
      expr: SUM(fefo_threshold_pct)
    - name: "Average Fefo Threshold Pct"
      expr: AVG(fefo_threshold_pct)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
    - name: "Total Net Content"
      expr: SUM(net_content)
    - name: "Average Net Content"
      expr: AVG(net_content)
    - name: "Total Net Weight Kg"
      expr: SUM(net_weight_kg)
    - name: "Average Net Weight Kg"
      expr: AVG(net_weight_kg)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Volume Ml"
      expr: SUM(volume_ml)
    - name: "Average Volume Ml"
      expr: AVG(volume_ml)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku Group business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`sku_group`"
  dimensions:
    - name: "Sku Group Code"
      expr: sku_group_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Sku Group Description"
      expr: sku_group_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Is Default"
      expr: is_default
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Sku Group Name"
      expr: sku_group_name
    - name: "Notes"
      expr: notes
    - name: "Packaging Type"
      expr: packaging_type
    - name: "Product Count"
      expr: product_count
    - name: "Regulatory Status"
      expr: regulatory_status
    - name: "Sku Group Status"
      expr: sku_group_status
    - name: "Sku Group Type"
      expr: sku_group_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku Group"
      expr: COUNT(DISTINCT sku_group_id)
    - name: "Total Average Price"
      expr: SUM(average_price)
    - name: "Average Average Price"
      expr: AVG(average_price)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku_substitution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku Substitution business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`sku_substitution`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Atp Substitution Enabled"
      expr: atp_substitution_enabled
    - name: "Auto Substitution Allowed"
      expr: auto_substitution_allowed
    - name: "Channel Code"
      expr: channel_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Approval Required"
      expr: customer_approval_required
    - name: "Demand History Normalization"
      expr: demand_history_normalization
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Bidirectional"
      expr: is_bidirectional
    - name: "Market Code"
      expr: market_code
    - name: "Plm Change Order Ref"
      expr: plm_change_order_ref
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Reason Code"
      expr: reason_code
    - name: "Regulatory Change Ref"
      expr: regulatory_change_ref
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku Substitution"
      expr: COUNT(DISTINCT sku_substitution_id)
    - name: "Total Cogs Impact Pct"
      expr: SUM(cogs_impact_pct)
    - name: "Average Cogs Impact Pct"
      expr: AVG(cogs_impact_pct)
    - name: "Total Price Adjustment Pct"
      expr: SUM(price_adjustment_pct)
    - name: "Average Price Adjustment Pct"
      expr: AVG(price_adjustment_pct)
    - name: "Total Quantity Conversion Factor"
      expr: SUM(quantity_conversion_factor)
    - name: "Average Quantity Conversion Factor"
      expr: AVG(quantity_conversion_factor)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply Agreement business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`supply_agreement`"
  dimensions:
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Price Uom"
      expr: price_uom
    - name: "V2 Added Flag"
      expr: v2_added_flag
    - name: "Validity End Date"
      expr: validity_end_date
    - name: "Validity Start Date"
      expr: validity_start_date
    - name: "Validity End Date Month"
      expr: DATE_TRUNC('MONTH', validity_end_date)
    - name: "Validity Start Date Month"
      expr: DATE_TRUNC('MONTH', validity_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supply Agreement"
      expr: COUNT(DISTINCT supply_agreement_id)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_vmi_sku_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vmi Sku Assignment business metrics"
  source: "`vibe_consumer_goods_v1`.`product`.`vmi_sku_assignment`"
  dimensions:
    - name: "Forecast Sharing Cadence"
      expr: forecast_sharing_cadence
    - name: "Replenishment Frequency"
      expr: replenishment_frequency
    - name: "Replenishment Lead Time Days"
      expr: replenishment_lead_time_days
    - name: "V2 Added Flag"
      expr: v2_added_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vmi Sku Assignment"
      expr: COUNT(DISTINCT vmi_sku_assignment_id)
    - name: "Total Max Inventory Weeks Of Supply"
      expr: SUM(max_inventory_weeks_of_supply)
    - name: "Average Max Inventory Weeks Of Supply"
      expr: AVG(max_inventory_weeks_of_supply)
    - name: "Total Min Inventory Weeks Of Supply"
      expr: SUM(min_inventory_weeks_of_supply)
    - name: "Average Min Inventory Weeks Of Supply"
      expr: AVG(min_inventory_weeks_of_supply)
    - name: "Total Safety Stock Weeks"
      expr: SUM(safety_stock_weeks)
    - name: "Average Safety Stock Weeks"
      expr: AVG(safety_stock_weeks)
$$;