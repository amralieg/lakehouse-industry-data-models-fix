-- Metric views for domain: ingredient | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core ingredient raw material metrics tracking material portfolio composition, certification coverage, allergen exposure, and regulatory compliance across the ingredient supply base."
  source: "`food_beverage_ecm`.`ingredient`.`raw_material`"
  dimensions:
    - name: "material_code"
      expr: material_code
      comment: "Unique identifier code for the raw material SKU"
    - name: "material_name"
      expr: material_name
      comment: "Descriptive name of the raw material ingredient"
    - name: "category_l1"
      expr: category_l1
      comment: "Top-level ingredient category for portfolio segmentation"
    - name: "category_l2"
      expr: category_l2
      comment: "Second-level ingredient category for detailed classification"
    - name: "category_l3"
      expr: category_l3
      comment: "Third-level ingredient category for granular analysis"
    - name: "ingredient_class"
      expr: ingredient_class
      comment: "Functional classification of the ingredient (e.g., preservative, flavor, colorant)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle status of the raw material (active, phasing out, discontinued)"
    - name: "gmo_classification"
      expr: gmo_classification
      comment: "GMO status classification (GMO, Non-GMO, GMO-free)"
    - name: "origin_type"
      expr: origin_type
      comment: "Origin classification of the ingredient (plant-based, animal-derived, synthetic)"
    - name: "storage_conditions"
      expr: storage_conditions
      comment: "Required storage conditions for the raw material"
    - name: "regulatory_restriction_profile"
      expr: regulatory_restriction_profile
      comment: "Regulatory restriction classification for compliance tracking"
  measures:
    - name: "total_raw_materials"
      expr: COUNT(DISTINCT raw_material_id)
      comment: "Total count of unique raw material SKUs in the ingredient portfolio"
    - name: "organic_certified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN organic_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials with organic certification - key sustainability and premium positioning metric"
    - name: "non_gmo_verified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN non_gmo_project_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials with Non-GMO Project verification - critical for clean label positioning"
    - name: "halal_certified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN halal_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials with Halal certification - enables market access to Muslim-majority regions"
    - name: "kosher_certified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN kosher_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials with Kosher certification - enables market access and premium positioning"
    - name: "clean_label_eligible_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN clean_label_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials eligible for clean label claims - strategic metric for consumer health trends"
    - name: "plant_based_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN plant_based = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plant-based raw materials - tracks portfolio alignment with plant-forward consumer trends"
    - name: "vegan_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vegan = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vegan-compliant raw materials - critical for vegan product development and market positioning"
    - name: "gluten_free_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gluten_free = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gluten-free raw materials - enables celiac-safe product formulation"
    - name: "allergen_milk_exposure_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_milk = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials containing milk allergen - critical for allergen risk management"
    - name: "allergen_peanuts_exposure_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_peanuts = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials containing peanut allergen - high-risk allergen requiring strict controls"
    - name: "allergen_tree_nuts_exposure_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_tree_nuts = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials containing tree nut allergen - high-risk allergen requiring strict controls"
    - name: "allergen_wheat_exposure_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_wheat = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials containing wheat allergen - impacts gluten-free product development"
    - name: "allergen_soybeans_exposure_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_soybeans = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials containing soy allergen - common allergen requiring labeling and controls"
    - name: "no_artificial_colors_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_artificial_colors = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials free from artificial colors - clean label and natural positioning metric"
    - name: "no_artificial_flavors_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_artificial_flavors = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials free from artificial flavors - clean label and natural positioning metric"
    - name: "no_artificial_preservatives_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_artificial_preservatives = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials free from artificial preservatives - clean label and natural positioning metric"
    - name: "fair_trade_certified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fair_trade_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials with Fair Trade certification - ethical sourcing and sustainability metric"
    - name: "identity_preserved_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN identity_preserved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of raw materials with identity preservation - traceability and quality assurance metric"
    - name: "moisture_sensitive_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN moisture_sensitive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of moisture-sensitive raw materials - impacts storage cost and handling complexity"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_approved_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality and compliance metrics tracking approval status, audit performance, certification coverage, and lead time efficiency across the approved supplier base."
  source: "`food_beverage_ecm`.`ingredient`.`approved_supplier`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the supplier (approved, conditional, suspended, rejected)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the supplier sources or manufactures the ingredient"
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status classification for the supplier's ingredient"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for pricing with this supplier"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms defining delivery and risk transfer"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with the supplier"
    - name: "price_uom"
      expr: price_uom
      comment: "Unit of measure for pricing"
    - name: "moq_uom"
      expr: moq_uom
      comment: "Unit of measure for minimum order quantity"
    - name: "lead_time_days"
      expr: lead_time_days
      comment: "Lead time in days from order to delivery"
  measures:
    - name: "total_approved_suppliers"
      expr: COUNT(DISTINCT approved_supplier_id)
      comment: "Total count of approved supplier relationships - measures supply base breadth"
    - name: "active_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with active approved status - key supply chain risk metric"
    - name: "avg_audit_score"
      expr: AVG(CAST(last_audit_score AS DOUBLE))
      comment: "Average supplier audit score - measures overall supplier quality performance"
    - name: "preferred_supplier_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_supplier_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers designated as preferred - strategic sourcing concentration metric"
    - name: "organic_certified_supplier_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN organic_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with organic certification - enables organic product portfolio growth"
    - name: "halal_certified_supplier_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN halal_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with Halal certification - enables market access to Muslim-majority regions"
    - name: "kosher_certified_supplier_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN kosher_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with Kosher certification - enables market access and premium positioning"
    - name: "coa_required_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN coa_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers requiring Certificate of Analysis - quality control rigor metric"
    - name: "allergen_declaration_on_file_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_declaration_on_file = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with allergen declarations on file - allergen risk management compliance metric"
    - name: "avg_price_per_uom"
      expr: AVG(CAST(price_per_uom AS DOUBLE))
      comment: "Average price per unit of measure across approved suppliers - cost benchmarking metric"
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across suppliers - working capital and flexibility metric"
    - name: "total_approved_supplier_spend_capacity"
      expr: SUM(CAST(price_per_uom AS DOUBLE) * CAST(moq_quantity AS DOUBLE))
      comment: "Total minimum spend capacity across all approved suppliers - strategic sourcing planning metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient lot traceability and quality metrics tracking receipt volumes, quality disposition, quarantine rates, and certification compliance at the lot level for FSMA and recall readiness."
  source: "`food_beverage_ecm`.`ingredient`.`lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (available, quarantine, released, rejected, consumed)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome status for the lot"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the ingredient lot - critical for traceability and tariff management"
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the lot (GMO, Non-GMO, GMO-free)"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions for the lot (ambient, refrigerated, frozen)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for lot quantity"
    - name: "vendor_certification_status"
      expr: vendor_certification_status
      comment: "Vendor certification status for the lot"
    - name: "disposition_reason"
      expr: disposition_reason
      comment: "Reason for lot disposition (if rejected or held)"
    - name: "allergen_declaration"
      expr: allergen_declaration
      comment: "Allergen declaration statement for the lot"
  measures:
    - name: "total_lots_received"
      expr: COUNT(DISTINCT lot_id)
      comment: "Total count of ingredient lots received - measures inbound supply activity volume"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of ingredients received across all lots - measures inbound supply volume"
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity of ingredients currently available for use - measures usable inventory"
    - name: "quarantine_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots placed under quarantine - quality risk and supply disruption metric"
    - name: "lot_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots rejected after inspection - supplier quality and cost of quality metric"
    - name: "coa_received_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN coa_received_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots with Certificate of Analysis received - supplier compliance metric"
    - name: "organic_certified_lot_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN organic_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots with organic certification - organic supply chain integrity metric"
    - name: "halal_certified_lot_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN halal_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots with Halal certification - Halal supply chain integrity metric"
    - name: "kosher_certified_lot_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN kosher_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots with Kosher certification - Kosher supply chain integrity metric"
    - name: "avg_temperature_at_receipt"
      expr: AVG(CAST(temperature_at_receipt AS DOUBLE))
      comment: "Average temperature at receipt across lots - cold chain compliance and quality risk metric"
    - name: "inventory_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_available AS DOUBLE)) / NULLIF(SUM(CAST(quantity_received AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity still available - measures inventory turnover and waste"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_test_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient quality testing metrics tracking pass rates, deviation frequency, retest rates, and specification compliance to drive supplier quality improvement and cost of quality reduction."
  source: "`food_beverage_ecm`.`ingredient`.`test_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of quality test performed (microbiological, chemical, physical, sensory)"
    - name: "test_parameter"
      expr: test_parameter
      comment: "Specific parameter being tested (e.g., moisture, pH, pathogen, heavy metal)"
    - name: "test_method"
      expr: test_method
      comment: "Analytical method used for testing (e.g., HPLC, GC-MS, PCR)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Overall pass/fail outcome of the test"
    - name: "hold_release_status"
      expr: hold_release_status
      comment: "Hold or release decision based on test results"
    - name: "testing_laboratory"
      expr: testing_laboratory
      comment: "Laboratory that performed the test (internal or third-party)"
    - name: "laboratory_accreditation"
      expr: laboratory_accreditation
      comment: "Accreditation status of the testing laboratory (ISO 17025, etc.)"
    - name: "test_priority"
      expr: test_priority
      comment: "Priority level of the test (routine, urgent, regulatory)"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for test failure or lot rejection"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the test result value"
    - name: "test_cost_currency_code"
      expr: test_cost_currency_code
      comment: "Currency code for test cost"
  measures:
    - name: "total_tests_performed"
      expr: COUNT(DISTINCT test_result_id)
      comment: "Total count of quality tests performed - measures quality assurance activity volume"
    - name: "test_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that passed specification - key supplier quality and cost of quality metric"
    - name: "test_failure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'fail' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that failed specification - inverse of pass rate, drives corrective action"
    - name: "deviation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests with deviations from specification - quality risk and supplier performance metric"
    - name: "retest_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN retest_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests requiring retest - quality cost and process efficiency metric"
    - name: "regulatory_test_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests driven by regulatory requirements - compliance workload metric"
    - name: "total_test_cost"
      expr: SUM(CAST(test_cost AS DOUBLE))
      comment: "Total cost of quality testing - cost of quality metric for financial planning"
    - name: "avg_test_cost"
      expr: AVG(CAST(test_cost AS DOUBLE))
      comment: "Average cost per test - cost efficiency benchmark for quality operations"
    - name: "avg_test_result_value"
      expr: AVG(CAST(test_result_value AS DOUBLE))
      comment: "Average test result value across all tests - process capability and centering metric"
    - name: "avg_specification_target"
      expr: AVG(CAST(specification_target AS DOUBLE))
      comment: "Average specification target value - specification design metric"
    - name: "specification_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN test_result_value >= specification_min AND test_result_value <= specification_max THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test results within specification limits - process capability and supplier quality metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient cost and pricing metrics tracking standard cost, landed cost, price variance, and commodity index exposure to drive procurement savings and margin protection."
  source: "`food_beverage_ecm`.`ingredient`.`cost`"
  dimensions:
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost record (active, pending, expired, superseded)"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (standard, planned, spot, contract, moving average)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the cost is denominated"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms defining cost responsibility and risk transfer"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for the cost"
    - name: "commodity_index_reference"
      expr: commodity_index_reference
      comment: "Commodity index used for price indexation (e.g., CME, ICE)"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for cost pricing"
    - name: "purchasing_org_code"
      expr: purchasing_org_code
      comment: "Purchasing organization responsible for the cost"
    - name: "update_reason"
      expr: update_reason
      comment: "Reason for cost update (market change, contract renewal, supplier change)"
    - name: "version"
      expr: version
      comment: "Version of the cost record"
  measures:
    - name: "total_cost_records"
      expr: COUNT(DISTINCT cost_id)
      comment: "Total count of ingredient cost records - measures cost master data volume"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost across ingredients - cost baseline for margin analysis"
    - name: "avg_landed_cost_per_unit"
      expr: AVG(CAST(landed_cost_per_unit AS DOUBLE))
      comment: "Average landed cost per unit including freight and duty - true total cost of ownership metric"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price - reflects recent purchase price trends"
    - name: "avg_planned_price"
      expr: AVG(CAST(planned_price AS DOUBLE))
      comment: "Average planned price - budget and forecast baseline metric"
    - name: "avg_spot_price"
      expr: AVG(CAST(spot_price AS DOUBLE))
      comment: "Average spot market price - market volatility and hedging opportunity metric"
    - name: "avg_invoice_price"
      expr: AVG(CAST(invoice_price AS DOUBLE))
      comment: "Average invoice price - actual purchase price paid metric"
    - name: "avg_freight_cost_per_unit"
      expr: AVG(CAST(freight_cost_per_unit AS DOUBLE))
      comment: "Average freight cost per unit - logistics cost component for total cost analysis"
    - name: "avg_duty_cost_per_unit"
      expr: AVG(CAST(duty_cost_per_unit AS DOUBLE))
      comment: "Average duty cost per unit - tariff and customs cost component"
    - name: "avg_price_variance_percentage"
      expr: AVG(CAST(price_variance_percentage AS DOUBLE))
      comment: "Average price variance percentage - measures cost volatility and forecast accuracy"
    - name: "avg_variance_vs_standard"
      expr: AVG(CAST(variance_vs_standard AS DOUBLE))
      comment: "Average variance versus standard cost - cost control and margin impact metric"
    - name: "avg_price_variance_vs_prior_period"
      expr: AVG(CAST(price_variance_vs_prior_period AS DOUBLE))
      comment: "Average price variance versus prior period - inflation and deflation trend metric"
    - name: "current_cost_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_current_cost = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cost records marked as current - cost master data quality metric"
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost_per_unit AS DOUBLE) * CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total landed cost across all ingredients at minimum order quantities - working capital planning metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_formulation_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product formulation and bill of materials metrics tracking ingredient usage, cost per unit, allergen exposure, and certification compliance at the formulation line level for product development and cost optimization."
  source: "`food_beverage_ecm`.`ingredient`.`formulation_line`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Status of the bill of materials (active, pending, obsolete, superseded)"
    - name: "bom_version"
      expr: bom_version
      comment: "Version of the bill of materials"
    - name: "phase_of_addition"
      expr: phase_of_addition
      comment: "Manufacturing phase when ingredient is added (mixing, cooking, packaging)"
    - name: "addition_sequence"
      expr: addition_sequence
      comment: "Sequence order for ingredient addition in the process"
    - name: "allergen_type"
      expr: allergen_type
      comment: "Type of allergen present in the formulation line ingredient"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ingredient quantity"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for ingredient cost"
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for formulation change (cost reduction, quality improvement, regulatory)"
    - name: "line_item_sequence"
      expr: line_item_sequence
      comment: "Line item sequence number in the formulation"
  measures:
    - name: "total_formulation_lines"
      expr: COUNT(DISTINCT formulation_line_id)
      comment: "Total count of formulation line items - measures formulation complexity"
    - name: "total_quantity_per_batch"
      expr: SUM(CAST(quantity_per_batch AS DOUBLE))
      comment: "Total ingredient quantity per batch across all formulation lines - batch size and material usage metric"
    - name: "avg_quantity_per_batch"
      expr: AVG(CAST(quantity_per_batch AS DOUBLE))
      comment: "Average ingredient quantity per batch - formulation intensity metric"
    - name: "total_cost_per_unit"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Total ingredient cost per unit across formulation - product cost of goods sold metric"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average ingredient cost per unit - cost structure benchmark metric"
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage - manufacturing efficiency and waste metric"
    - name: "avg_yield_factor_percent"
      expr: AVG(CAST(yield_factor_percent AS DOUBLE))
      comment: "Average yield factor percentage - manufacturing efficiency and output metric"
    - name: "allergen_ingredient_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_allergen = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulation lines containing allergens - allergen risk and labeling complexity metric"
    - name: "critical_ingredient_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_ingredient = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulation lines designated as critical - supply risk and quality criticality metric"
    - name: "gmo_ingredient_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gmo = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulation lines containing GMO ingredients - non-GMO claim eligibility metric"
    - name: "organic_certified_ingredient_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_organic_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulation lines with organic certified ingredients - organic claim eligibility metric"
    - name: "halal_ingredient_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_halal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulation lines with Halal ingredients - Halal claim eligibility metric"
    - name: "kosher_ingredient_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_kosher = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of formulation lines with Kosher ingredients - Kosher claim eligibility metric"
    - name: "weighted_avg_cost_per_batch"
      expr: SUM(CAST(cost_per_unit AS DOUBLE) * CAST(quantity_per_batch AS DOUBLE)) / NULLIF(SUM(CAST(quantity_per_batch AS DOUBLE)), 0)
      comment: "Weighted average cost per batch based on quantity - true batch cost metric for margin analysis"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_nutritional_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient nutritional composition metrics tracking macronutrient content, micronutrient levels, and nutritional density to support product development, labeling compliance, and health positioning claims."
  source: "`food_beverage_ecm`.`ingredient`.`nutritional_profile`"
  dimensions:
    - name: "nutritional_profile_status"
      expr: nutritional_profile_status
      comment: "Status of the nutritional profile (active, pending, expired, superseded)"
    - name: "data_source"
      expr: data_source
      comment: "Source of nutritional data (laboratory analysis, supplier COA, USDA database)"
    - name: "analytical_method"
      expr: analytical_method
      comment: "Analytical method used for nutritional analysis"
    - name: "laboratory_name"
      expr: laboratory_name
      comment: "Laboratory that performed the nutritional analysis"
    - name: "serving_size_uom"
      expr: serving_size_uom
      comment: "Unit of measure for serving size"
    - name: "version_number"
      expr: version_number
      comment: "Version number of the nutritional profile"
    - name: "coa_reference_number"
      expr: coa_reference_number
      comment: "Certificate of Analysis reference number for the nutritional data"
  measures:
    - name: "total_nutritional_profiles"
      expr: COUNT(DISTINCT nutritional_profile_id)
      comment: "Total count of nutritional profiles - measures nutritional data coverage"
    - name: "avg_energy_kcal"
      expr: AVG(CAST(energy_kcal AS DOUBLE))
      comment: "Average energy content in kilocalories - caloric density metric for product positioning"
    - name: "avg_protein_g"
      expr: AVG(CAST(protein_g AS DOUBLE))
      comment: "Average protein content in grams - protein density metric for high-protein claims"
    - name: "avg_total_fat_g"
      expr: AVG(CAST(total_fat_g AS DOUBLE))
      comment: "Average total fat content in grams - fat density metric for low-fat claims"
    - name: "avg_saturated_fat_g"
      expr: AVG(CAST(saturated_fat_g AS DOUBLE))
      comment: "Average saturated fat content in grams - heart health and low-saturated-fat claim metric"
    - name: "avg_trans_fat_g"
      expr: AVG(CAST(trans_fat_g AS DOUBLE))
      comment: "Average trans fat content in grams - trans-fat-free claim eligibility metric"
    - name: "avg_total_carbohydrate_g"
      expr: AVG(CAST(total_carbohydrate_g AS DOUBLE))
      comment: "Average total carbohydrate content in grams - carbohydrate density metric"
    - name: "avg_dietary_fiber_g"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE))
      comment: "Average dietary fiber content in grams - high-fiber claim eligibility metric"
    - name: "avg_total_sugars_g"
      expr: AVG(CAST(total_sugars_g AS DOUBLE))
      comment: "Average total sugars content in grams - sugar reduction and low-sugar claim metric"
    - name: "avg_added_sugars_g"
      expr: AVG(CAST(added_sugars_g AS DOUBLE))
      comment: "Average added sugars content in grams - no-added-sugar claim eligibility metric"
    - name: "avg_sodium_mg"
      expr: AVG(CAST(sodium_mg AS DOUBLE))
      comment: "Average sodium content in milligrams - low-sodium and heart-health claim metric"
    - name: "avg_cholesterol_mg"
      expr: AVG(CAST(cholesterol_mg AS DOUBLE))
      comment: "Average cholesterol content in milligrams - cholesterol-free claim eligibility metric"
    - name: "avg_calcium_mg"
      expr: AVG(CAST(calcium_mg AS DOUBLE))
      comment: "Average calcium content in milligrams - bone health and calcium fortification metric"
    - name: "avg_iron_mg"
      expr: AVG(CAST(iron_mg AS DOUBLE))
      comment: "Average iron content in milligrams - iron fortification and nutritional adequacy metric"
    - name: "avg_potassium_mg"
      expr: AVG(CAST(potassium_mg AS DOUBLE))
      comment: "Average potassium content in milligrams - heart health and electrolyte balance metric"
    - name: "avg_vitamin_a_mcg"
      expr: AVG(CAST(vitamin_a_mcg AS DOUBLE))
      comment: "Average vitamin A content in micrograms - vitamin A fortification metric"
    - name: "avg_vitamin_c_mg"
      expr: AVG(CAST(vitamin_c_mg AS DOUBLE))
      comment: "Average vitamin C content in milligrams - vitamin C fortification and antioxidant metric"
    - name: "avg_vitamin_d_mcg"
      expr: AVG(CAST(vitamin_d_mcg AS DOUBLE))
      comment: "Average vitamin D content in micrograms - vitamin D fortification and bone health metric"
    - name: "protein_to_fat_ratio"
      expr: AVG(CAST(protein_g AS DOUBLE)) / NULLIF(AVG(CAST(total_fat_g AS DOUBLE)), 0)
      comment: "Average protein-to-fat ratio - nutritional quality and lean protein positioning metric"
    - name: "fiber_to_carb_ratio"
      expr: AVG(CAST(dietary_fiber_g AS DOUBLE)) / NULLIF(AVG(CAST(total_carbohydrate_g AS DOUBLE)), 0)
      comment: "Average fiber-to-carbohydrate ratio - whole grain and high-fiber positioning metric"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`ingredient_religious_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Religious and ethical certification metrics tracking Halal and Kosher certification coverage, compliance status, and audit frequency to enable market access and premium positioning in faith-based consumer segments."
  source: "`food_beverage_ecm`.`ingredient`.`religious_cert`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of religious certification (Halal, Kosher, both)"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, pending, suspended)"
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the religious certification"
    - name: "certifying_body_code"
      expr: certifying_body_code
      comment: "Code of the certifying body"
    - name: "certification_standard"
      expr: certification_standard
      comment: "Standard or regulation under which certification was granted"
    - name: "certified_scope"
      expr: certified_scope
      comment: "Scope of the certification (ingredient, process, facility)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the certified ingredient"
    - name: "production_region"
      expr: production_region
      comment: "Production region for the certified ingredient"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of certification renewal (current, due, overdue)"
    - name: "review_frequency_days"
      expr: review_frequency_days
      comment: "Frequency of certification review in days"
  measures:
    - name: "total_religious_certifications"
      expr: COUNT(DISTINCT religious_cert_id)
      comment: "Total count of religious certifications - measures certification portfolio breadth"
    - name: "active_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with active status - certification compliance and market access metric"
    - name: "approved_for_use_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approved_for_use_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications approved for use - operational readiness metric"
    - name: "non_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN non_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications with non-compliance issues - compliance risk and corrective action metric"
    - name: "certification_expiry_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN expiry_date < CURRENT_DATE() + INTERVAL 90 DAY THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications expiring within 90 days - renewal planning and supply continuity risk metric"
    - name: "avg_certification_age_days"
      expr: AVG(DATEDIFF(CURRENT_DATE(), issue_date))
      comment: "Average age of certifications in days - certification portfolio freshness metric"
$$;