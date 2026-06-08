-- Metric views for domain: product | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_saleable_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core product portfolio performance metrics tracking revenue potential, market positioning, and product lifecycle health for saleable mining products"
  source: "`mining_ecm`.`product`.`saleable_product`"
  dimensions:
    - name: "product_code"
      expr: product_code
      comment: "Unique identifier code for the saleable product"
    - name: "product_name"
      expr: product_name
      comment: "Commercial name of the saleable product"
    - name: "commodity_type"
      expr: commodity_id
      comment: "Type of commodity (iron ore, copper, coal, lithium, nickel)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the product (active, discontinued, development)"
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Primary market segment targeted by this product"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product is sourced or produced"
    - name: "processing_route"
      expr: processing_route
      comment: "Processing method or route used to produce the product"
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (lump, fines, concentrate, pellets)"
    - name: "grade_specification"
      expr: grade_specification
      comment: "Quality grade specification of the product"
    - name: "available_for_sale_flag"
      expr: available_for_sale_flag
      comment: "Whether the product is currently available for sale"
    - name: "export_license_required_flag"
      expr: export_license_required_flag
      comment: "Whether export licensing is required for this product"
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification status or type"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the product became effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the product became effective"
  measures:
    - name: "total_products"
      expr: COUNT(1)
      comment: "Total count of saleable products in the portfolio"
    - name: "active_products"
      expr: COUNT(CASE WHEN available_for_sale_flag = TRUE THEN 1 END)
      comment: "Count of products currently available for sale"
    - name: "avg_carbon_footprint_kg_co2e_per_tonne"
      expr: AVG(CAST(carbon_footprint_kg_co2e_per_tonne AS DOUBLE))
      comment: "Average carbon footprint across products in kg CO2e per tonne"
    - name: "avg_minimum_order_quantity_tonnes"
      expr: AVG(CAST(minimum_order_quantity_tonnes AS DOUBLE))
      comment: "Average minimum order quantity across products in tonnes"
    - name: "avg_moisture_content_max_pct"
      expr: AVG(CAST(moisture_content_max_pct AS DOUBLE))
      comment: "Average maximum moisture content specification across products"
    - name: "products_requiring_export_license"
      expr: COUNT(CASE WHEN export_license_required_flag = TRUE THEN 1 END)
      comment: "Count of products requiring export licenses"
    - name: "products_with_quality_certificate_required"
      expr: COUNT(CASE WHEN quality_certificate_required_flag = TRUE THEN 1 END)
      comment: "Count of products requiring quality certificates"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_blend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product blending optimization and quality control metrics tracking blend performance, complexity, and specification adherence for multi-component mining products"
  source: "`mining_ecm`.`product`.`blend`"
  dimensions:
    - name: "blend_code"
      expr: blend_code
      comment: "Unique code identifying the blend configuration"
    - name: "blend_name"
      expr: blend_name
      comment: "Descriptive name of the blend"
    - name: "blend_status"
      expr: blend_status
      comment: "Current operational status of the blend (active, inactive, under review)"
    - name: "blend_type"
      expr: blend_type
      comment: "Classification type of the blend"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity being blended"
    - name: "blending_location_type"
      expr: blending_location_type
      comment: "Type of facility or location where blending occurs"
    - name: "complexity_rating"
      expr: complexity_rating
      comment: "Complexity rating of the blend configuration"
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Primary objective for blend optimization (cost, quality, consistency)"
    - name: "environmental_classification"
      expr: environmental_classification
      comment: "Environmental classification or risk category of the blend"
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority or role that approved the blend"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the blend was approved"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the blend became effective"
  measures:
    - name: "total_blends"
      expr: COUNT(1)
      comment: "Total count of blend configurations"
    - name: "active_blends"
      expr: COUNT(CASE WHEN blend_status = 'Active' THEN 1 END)
      comment: "Count of currently active blend configurations"
    - name: "avg_target_fe_grade_percent"
      expr: AVG(CAST(target_fe_grade_percent AS DOUBLE))
      comment: "Average target iron grade across blends"
    - name: "avg_target_silica_percent"
      expr: AVG(CAST(target_silica_percent AS DOUBLE))
      comment: "Average target silica content across blends"
    - name: "avg_target_alumina_percent"
      expr: AVG(CAST(target_alumina_percent AS DOUBLE))
      comment: "Average target alumina content across blends"
    - name: "avg_target_phosphorus_percent"
      expr: AVG(CAST(target_phosphorus_percent AS DOUBLE))
      comment: "Average target phosphorus content across blends"
    - name: "avg_target_moisture_percent"
      expr: AVG(CAST(target_moisture_percent AS DOUBLE))
      comment: "Average target moisture content across blends"
    - name: "avg_tolerance_range_percent"
      expr: AVG(CAST(tolerance_range_percent AS DOUBLE))
      comment: "Average quality tolerance range across blends"
    - name: "avg_target_ash_percent"
      expr: AVG(CAST(target_ash_percent AS DOUBLE))
      comment: "Average target ash content across blends (coal products)"
    - name: "avg_target_energy_content_kcal_kg"
      expr: AVG(CAST(target_energy_content_kcal_kg AS DOUBLE))
      comment: "Average target energy content across blends in kcal per kg"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_blend_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blend component optimization metrics tracking component ratios, quality contributions, and substitution flexibility for multi-source product blending"
  source: "`mining_ecm`.`product`.`blend_component`"
  dimensions:
    - name: "component_stockpile_code"
      expr: component_stockpile_code
      comment: "Stockpile code identifying the source of the blend component"
    - name: "component_status"
      expr: component_status
      comment: "Current operational status of the component"
    - name: "component_availability_status"
      expr: component_availability_status
      comment: "Availability status of the component for blending"
    - name: "component_source_location"
      expr: component_source_location
      comment: "Physical location or source of the component"
    - name: "component_size_fraction"
      expr: component_size_fraction
      comment: "Size fraction classification of the component"
    - name: "blending_priority"
      expr: blending_priority
      comment: "Priority ranking for using this component in blends"
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Whether this component is critical to the blend"
    - name: "substitution_allowed"
      expr: substitution_allowed
      comment: "Whether substitution of this component is permitted"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the component configuration became effective"
  measures:
    - name: "total_blend_components"
      expr: COUNT(1)
      comment: "Total count of blend components configured"
    - name: "critical_components"
      expr: COUNT(CASE WHEN is_critical_component = TRUE THEN 1 END)
      comment: "Count of components marked as critical to blends"
    - name: "substitutable_components"
      expr: COUNT(CASE WHEN substitution_allowed = TRUE THEN 1 END)
      comment: "Count of components that allow substitution"
    - name: "avg_target_blend_ratio_pct"
      expr: AVG(CAST(target_blend_ratio_pct AS DOUBLE))
      comment: "Average target blend ratio across components"
    - name: "avg_minimum_blend_ratio_pct"
      expr: AVG(CAST(minimum_blend_ratio_pct AS DOUBLE))
      comment: "Average minimum blend ratio constraint across components"
    - name: "avg_maximum_blend_ratio_pct"
      expr: AVG(CAST(maximum_blend_ratio_pct AS DOUBLE))
      comment: "Average maximum blend ratio constraint across components"
    - name: "avg_component_grade_fe_pct"
      expr: AVG(CAST(component_grade_fe_pct AS DOUBLE))
      comment: "Average iron grade across blend components"
    - name: "avg_component_grade_sio2_pct"
      expr: AVG(CAST(component_grade_sio2_pct AS DOUBLE))
      comment: "Average silica grade across blend components"
    - name: "avg_component_grade_al2o3_pct"
      expr: AVG(CAST(component_grade_al2o3_pct AS DOUBLE))
      comment: "Average alumina grade across blend components"
    - name: "avg_component_moisture_pct"
      expr: AVG(CAST(component_moisture_pct AS DOUBLE))
      comment: "Average moisture content across blend components"
    - name: "avg_component_cost_per_tonne"
      expr: AVG(CAST(component_cost_per_tonne AS DOUBLE))
      comment: "Average cost per tonne across blend components"
    - name: "avg_quality_variance_tolerance_pct"
      expr: AVG(CAST(quality_variance_tolerance_pct AS DOUBLE))
      comment: "Average quality variance tolerance across components"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product quality specification compliance metrics tracking guaranteed grades, contractual limits, and specification adherence for customer and regulatory requirements"
  source: "`mining_ecm`.`product`.`specification`"
  dimensions:
    - name: "specification_code"
      expr: specification_code
      comment: "Unique code identifying the product specification"
    - name: "specification_name"
      expr: specification_name
      comment: "Descriptive name of the specification"
    - name: "specification_status"
      expr: specification_status
      comment: "Current status of the specification (active, superseded, draft)"
    - name: "specification_type"
      expr: specification_type
      comment: "Type or category of specification"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity covered by the specification"
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (lump, fines, concentrate)"
    - name: "grade_basis"
      expr: grade_basis
      comment: "Basis for grade measurement (dry, as-received, wet)"
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Whether the specification is customer-specific"
    - name: "is_export_specification"
      expr: is_export_specification
      comment: "Whether the specification is for export products"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the specification was approved"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the specification became effective"
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total count of product specifications"
    - name: "active_specifications"
      expr: COUNT(CASE WHEN specification_status = 'Active' THEN 1 END)
      comment: "Count of currently active specifications"
    - name: "customer_specific_specifications"
      expr: COUNT(CASE WHEN is_customer_specific = TRUE THEN 1 END)
      comment: "Count of customer-specific specifications"
    - name: "export_specifications"
      expr: COUNT(CASE WHEN is_export_specification = TRUE THEN 1 END)
      comment: "Count of export product specifications"
    - name: "avg_guaranteed_fe_percent_min"
      expr: AVG(CAST(guaranteed_fe_percent_min AS DOUBLE))
      comment: "Average guaranteed minimum iron grade across specifications"
    - name: "avg_guaranteed_sio2_percent_max"
      expr: AVG(CAST(guaranteed_sio2_percent_max AS DOUBLE))
      comment: "Average guaranteed maximum silica content across specifications"
    - name: "avg_guaranteed_al2o3_percent_max"
      expr: AVG(CAST(guaranteed_al2o3_percent_max AS DOUBLE))
      comment: "Average guaranteed maximum alumina content across specifications"
    - name: "avg_guaranteed_moisture_percent_max"
      expr: AVG(CAST(guaranteed_moisture_percent_max AS DOUBLE))
      comment: "Average guaranteed maximum moisture content across specifications"
    - name: "avg_typical_fe_percent"
      expr: AVG(CAST(typical_fe_percent AS DOUBLE))
      comment: "Average typical iron grade across specifications"
    - name: "avg_tml_percent"
      expr: AVG(CAST(tml_percent AS DOUBLE))
      comment: "Average transportable moisture limit across specifications"
    - name: "avg_bulk_density_t_per_m3"
      expr: AVG(CAST(bulk_density_t_per_m3 AS DOUBLE))
      comment: "Average bulk density across specifications in tonnes per cubic meter"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_pricing_basis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product pricing mechanism and index linkage metrics tracking pricing structures, adjustment formulas, and market index references for revenue optimization"
  source: "`mining_ecm`.`product`.`pricing_basis`"
  dimensions:
    - name: "pricing_basis_code"
      expr: pricing_basis_code
      comment: "Unique code identifying the pricing basis"
    - name: "pricing_basis_name"
      expr: pricing_basis_name
      comment: "Descriptive name of the pricing basis"
    - name: "pricing_basis_status"
      expr: pricing_basis_status
      comment: "Current status of the pricing basis (active, superseded, draft)"
    - name: "pricing_currency_code"
      expr: pricing_currency_code
      comment: "Currency in which pricing is denominated"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing delivery and risk transfer"
    - name: "delivery_location"
      expr: delivery_location
      comment: "Delivery location for pricing basis"
    - name: "price_index_reference"
      expr: price_index_reference
      comment: "Market index used for price reference"
    - name: "index_provider"
      expr: index_provider
      comment: "Provider of the pricing index"
    - name: "final_pricing_trigger"
      expr: final_pricing_trigger
      comment: "Event or condition that triggers final pricing"
    - name: "freight_component_included"
      expr: freight_component_included
      comment: "Whether freight costs are included in the pricing basis"
    - name: "insurance_component_included"
      expr: insurance_component_included
      comment: "Whether insurance costs are included in the pricing basis"
    - name: "treatment_charge_applicable"
      expr: treatment_charge_applicable
      comment: "Whether treatment charges apply to this pricing basis"
    - name: "refining_charge_applicable"
      expr: refining_charge_applicable
      comment: "Whether refining charges apply to this pricing basis"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the pricing basis became effective"
  measures:
    - name: "total_pricing_bases"
      expr: COUNT(1)
      comment: "Total count of pricing basis configurations"
    - name: "active_pricing_bases"
      expr: COUNT(CASE WHEN pricing_basis_status = 'Active' THEN 1 END)
      comment: "Count of currently active pricing bases"
    - name: "pricing_bases_with_freight_included"
      expr: COUNT(CASE WHEN freight_component_included = TRUE THEN 1 END)
      comment: "Count of pricing bases including freight component"
    - name: "pricing_bases_with_treatment_charge"
      expr: COUNT(CASE WHEN treatment_charge_applicable = TRUE THEN 1 END)
      comment: "Count of pricing bases with treatment charges"
    - name: "avg_provisional_pricing_percentage"
      expr: AVG(CAST(provisional_pricing_percentage AS DOUBLE))
      comment: "Average provisional pricing percentage across pricing bases"
    - name: "avg_price_floor"
      expr: AVG(CAST(price_floor AS DOUBLE))
      comment: "Average price floor across pricing bases"
    - name: "avg_price_ceiling"
      expr: AVG(CAST(price_ceiling AS DOUBLE))
      comment: "Average price ceiling across pricing bases"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification compliance and renewal metrics tracking certification status, expiry management, and regulatory compliance for market access"
  source: "`mining_ecm`.`product`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type or category of certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (valid, expired, pending)"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard or framework for the certification"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority or body that issued the certification"
    - name: "applicable_jurisdiction"
      expr: applicable_jurisdiction
      comment: "Legal jurisdiction where the certification applies"
    - name: "applicable_market"
      expr: applicable_market
      comment: "Market or region where the certification is applicable"
    - name: "certification_scope"
      expr: certification_scope
      comment: "Scope or coverage of the certification"
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether periodic renewal is required"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification assigned by the certification"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total count of product certifications"
    - name: "valid_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Valid' THEN 1 END)
      comment: "Count of currently valid certifications"
    - name: "certifications_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Count of certifications requiring periodic renewal"
    - name: "total_certification_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of certifications"
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per certification"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_grade_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product quality limit and penalty structure metrics tracking bonus thresholds, penalty rates, and rejection limits for contractual quality management"
  source: "`mining_ecm`.`product`.`grade_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of quality limit (minimum, maximum, target, rejection)"
    - name: "limit_status"
      expr: limit_status
      comment: "Current status of the grade limit (active, superseded)"
    - name: "parameter_category"
      expr: parameter_category
      comment: "Category of the quality parameter being limited"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the grade limit"
    - name: "test_method_code"
      expr: test_method_code
      comment: "Test method code used to measure the parameter"
    - name: "sampling_frequency"
      expr: sampling_frequency
      comment: "Frequency of sampling for this parameter"
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority that approved the grade limit"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the grade limit became effective"
  measures:
    - name: "total_grade_limits"
      expr: COUNT(1)
      comment: "Total count of grade limit specifications"
    - name: "active_grade_limits"
      expr: COUNT(CASE WHEN limit_status = 'Active' THEN 1 END)
      comment: "Count of currently active grade limits"
    - name: "avg_minimum_limit"
      expr: AVG(CAST(minimum_limit AS DOUBLE))
      comment: "Average minimum quality limit across parameters"
    - name: "avg_maximum_limit"
      expr: AVG(CAST(maximum_limit AS DOUBLE))
      comment: "Average maximum quality limit across parameters"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across quality parameters"
    - name: "avg_guaranteed_value"
      expr: AVG(CAST(guaranteed_value AS DOUBLE))
      comment: "Average guaranteed value across quality parameters"
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate for quality deviations"
    - name: "avg_bonus_rate"
      expr: AVG(CAST(bonus_rate AS DOUBLE))
      comment: "Average bonus rate for quality premiums"
    - name: "avg_compliance_tolerance"
      expr: AVG(CAST(compliance_tolerance AS DOUBLE))
      comment: "Average compliance tolerance across quality parameters"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_moisture_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Moisture control and transportable moisture limit (TML) compliance metrics tracking moisture specifications, penalties, and IMSBC safety requirements"
  source: "`mining_ecm`.`product`.`specification`"
  dimensions:
    - name: "specification_code"
      expr: specification_code
      comment: "Unique code identifying the moisture specification"
    - name: "specification_name"
      expr: specification_name
      comment: "Descriptive name of the moisture specification"
    - name: "specification_type"
      expr: specification_type
      comment: "Type or category of moisture specification"
    - name: "moisture_measurement_method"
      expr: moisture_measurement_method
      comment: "Method used to measure moisture content"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the moisture specification was approved"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the moisture specification became effective"
  measures:
    - name: "total_moisture_specifications"
      expr: COUNT(1)
      comment: "Total count of moisture specifications"
$$;