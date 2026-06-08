-- Metric views for domain: product | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order performance metrics tracking revenue, volume, and order characteristics for chemical product sales"
  source: "`chemical_mfg_ecm`.`product`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., pending, confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, contract, spot)"
    - name: "order_source"
      expr: order_source
      comment: "Channel or system where the order originated"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the order"
    - name: "sales_org"
      expr: sales_org
      comment: "Sales organization responsible for the order"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order is denominated"
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the order contains hazardous materials"
    - name: "order_year"
      expr: YEAR(order_timestamp)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month the order was placed"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_timestamp)
      comment: "Quarter the order was placed"
    - name: "requested_delivery_year_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Requested delivery month for demand planning"
  measures:
    - name: "total_order_count"
      expr: COUNT(DISTINCT order_id)
      comment: "Total number of unique orders placed"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross order value before discounts and taxes"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net order value after discounts but before taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "avg_order_value_gross"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross order value per order"
    - name: "avg_order_value_net"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net order value per order"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross revenue given as discounts"
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of all orders in kilograms"
    - name: "total_order_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of all orders in cubic meters"
    - name: "avg_order_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per order in kilograms"
    - name: "hazmat_order_count"
      expr: COUNT(DISTINCT CASE WHEN hazardous_material_flag = TRUE THEN order_id END)
      comment: "Number of orders containing hazardous materials"
    - name: "hazmat_order_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hazardous_material_flag = TRUE THEN order_id END) / NULLIF(COUNT(DISTINCT order_id), 0), 2)
      comment: "Percentage of orders that contain hazardous materials"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order metrics for detailed product mix, pricing, and fulfillment analysis"
  source: "`chemical_mfg_ecm`.`product`.`line_item`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the line item (e.g., open, confirmed, shipped, cancelled)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the line item pricing"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity"
    - name: "hazmat_class"
      expr: hazmat_class
      comment: "Hazardous material classification for the line item"
    - name: "is_gmp_compliant"
      expr: is_gmp_compliant
      comment: "Indicates whether the line item meets Good Manufacturing Practice standards"
    - name: "coa_required_flag"
      expr: coa_required_flag
      comment: "Indicates whether a Certificate of Analysis is required"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the line item meets regulatory compliance requirements"
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Indicates whether temperature-controlled shipping is required"
    - name: "requested_delivery_year_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Requested delivery month for demand planning"
    - name: "creation_year_month"
      expr: DATE_TRUNC('MONTH', creation_timestamp)
      comment: "Month the line item was created"
  measures:
    - name: "total_line_item_count"
      expr: COUNT(DISTINCT line_item_id)
      comment: "Total number of unique line items ordered"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all line items"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for fulfillment"
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from all line items"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to line items"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on line items"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per line item"
    - name: "avg_line_value"
      expr: AVG(CAST(line_total_amount AS DOUBLE))
      comment: "Average revenue per line item"
    - name: "order_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that was confirmed for fulfillment"
    - name: "gmp_compliant_line_count"
      expr: COUNT(DISTINCT CASE WHEN is_gmp_compliant = TRUE THEN line_item_id END)
      comment: "Number of line items that are GMP compliant"
    - name: "coa_required_line_count"
      expr: COUNT(DISTINCT CASE WHEN coa_required_flag = TRUE THEN line_item_id END)
      comment: "Number of line items requiring Certificate of Analysis"
    - name: "temp_controlled_line_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_control_flag = TRUE THEN line_item_id END)
      comment: "Number of line items requiring temperature-controlled shipping"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_outbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance metrics tracking on-time delivery, freight costs, and logistics efficiency"
  source: "`chemical_mfg_ecm`.`product`.`outbound_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the outbound delivery"
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., standard, expedited, direct)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (e.g., truck, rail, air, ocean)"
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Indicates whether the delivery contains hazardous materials"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the delivery requires temperature control"
    - name: "coa_attachment_status"
      expr: coa_attachment_status
      comment: "Status of Certificate of Analysis attachment"
    - name: "coc_attachment_status"
      expr: coc_attachment_status
      comment: "Status of Certificate of Compliance attachment"
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level of the delivery"
    - name: "goods_issue_year_month"
      expr: DATE_TRUNC('MONTH', goods_issue_timestamp)
      comment: "Month when goods were issued for delivery"
    - name: "actual_delivery_year_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month when delivery was actually completed"
  measures:
    - name: "total_delivery_count"
      expr: COUNT(DISTINCT outbound_delivery_id)
      comment: "Total number of unique outbound deliveries"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all deliveries"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per delivery"
    - name: "total_delivery_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of all deliveries in kilograms"
    - name: "total_delivery_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of all deliveries in cubic meters"
    - name: "avg_delivery_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per delivery in kilograms"
    - name: "freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_kg AS DOUBLE)), 0), 4)
      comment: "Average freight cost per kilogram shipped"
    - name: "on_time_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date <= required_delivery_date THEN outbound_delivery_id END)
      comment: "Number of deliveries completed on or before the required date"
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= required_delivery_date THEN outbound_delivery_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL THEN outbound_delivery_id END), 0), 2)
      comment: "Percentage of deliveries completed on or before the required date"
    - name: "hazmat_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN hazardous_material_indicator = TRUE THEN outbound_delivery_id END)
      comment: "Number of deliveries containing hazardous materials"
    - name: "temp_controlled_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN temperature_controlled = TRUE THEN outbound_delivery_id END)
      comment: "Number of deliveries requiring temperature control"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_chemical_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product portfolio metrics tracking product lifecycle, pricing, and regulatory compliance"
  source: "`chemical_mfg_ecm`.`product`.`chemical_product`"
  dimensions:
    - name: "lifecycle_state"
      expr: lifecycle_state
      comment: "Current lifecycle state of the product (e.g., active, discontinued, phase-out)"
    - name: "product_type"
      expr: product_type
      comment: "Type or category of chemical product"
    - name: "physical_form"
      expr: physical_form
      comment: "Physical form of the product (e.g., liquid, solid, gas)"
    - name: "hazard_class"
      expr: hazard_class
      comment: "Hazard classification of the product"
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "GHS (Globally Harmonized System) classification"
    - name: "reach_status"
      expr: reach_status
      comment: "REACH (Registration, Evaluation, Authorization of Chemicals) registration status"
    - name: "tsca_status"
      expr: tsca_status
      comment: "TSCA (Toxic Substances Control Act) inventory status"
    - name: "fda_approval_required"
      expr: fda_approval_required
      comment: "Indicates whether FDA approval is required for this product"
    - name: "base_unit_of_measure"
      expr: base_unit_of_measure
      comment: "Base unit of measure for the product"
    - name: "introduction_year"
      expr: YEAR(introduction_date)
      comment: "Year the product was introduced to the market"
    - name: "introduction_year_month"
      expr: DATE_TRUNC('MONTH', introduction_date)
      comment: "Month the product was introduced to the market"
  measures:
    - name: "total_product_count"
      expr: COUNT(DISTINCT chemical_product_id)
      comment: "Total number of unique chemical products in the portfolio"
    - name: "active_product_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_state = 'Active' THEN chemical_product_id END)
      comment: "Number of products in active lifecycle state"
    - name: "discontinued_product_count"
      expr: COUNT(DISTINCT CASE WHEN discontinuation_date IS NOT NULL THEN chemical_product_id END)
      comment: "Number of products that have been discontinued"
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price across all products in USD"
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost across all products in USD"
    - name: "avg_product_margin_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE) - CAST(standard_cost_usd AS DOUBLE))
      comment: "Average margin per product (list price minus standard cost) in USD"
    - name: "avg_density_kg_per_l"
      expr: AVG(CAST(density_kg_per_l AS DOUBLE))
      comment: "Average density of products in kilograms per liter"
    - name: "avg_voc_content_pct"
      expr: AVG(CAST(voc_content_percent AS DOUBLE))
      comment: "Average volatile organic compound content percentage"
    - name: "hazardous_product_count"
      expr: COUNT(DISTINCT CASE WHEN hazard_class IS NOT NULL THEN chemical_product_id END)
      comment: "Number of products classified as hazardous"
    - name: "reach_registered_product_count"
      expr: COUNT(DISTINCT CASE WHEN reach_status = 'Registered' THEN chemical_product_id END)
      comment: "Number of products with REACH registration"
    - name: "fda_approval_required_count"
      expr: COUNT(DISTINCT CASE WHEN fda_approval_required = TRUE THEN chemical_product_id END)
      comment: "Number of products requiring FDA approval"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_returns_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product returns metrics tracking return rates, reasons, and financial impact"
  source: "`chemical_mfg_ecm`.`product`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the return refund amounts"
  measures:
    - name: "total_return_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded on returns"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level metrics tracking product variants, packaging configurations, and regulatory attributes"
  source: "`chemical_mfg_ecm`.`product`.`sku`"
  dimensions:
    - name: "sku_status"
      expr: sku_status
      comment: "Current status of the SKU (e.g., active, inactive, discontinued)"
    - name: "application_area"
      expr: application_area
      comment: "Application area or industry segment for the SKU"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the SKU"
    - name: "hazard_class"
      expr: hazard_class
      comment: "Hazard classification of the SKU"
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "GHS classification for the SKU"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the SKU is classified as hazardous material"
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Indicates whether the SKU is a controlled substance"
    - name: "tsca_status"
      expr: tsca_status
      comment: "TSCA inventory status for the SKU"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month when the SKU became effective"
    - name: "discontinuation_year_month"
      expr: DATE_TRUNC('MONTH', discontinuation_date)
      comment: "Month when the SKU was discontinued"
  measures:
    - name: "total_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Total number of unique SKUs in the catalog"
    - name: "active_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Number of SKUs with active status"
    - name: "discontinued_sku_count"
      expr: COUNT(DISTINCT CASE WHEN discontinuation_date IS NOT NULL THEN sku_id END)
      comment: "Number of SKUs that have been discontinued"
    - name: "avg_pack_size"
      expr: AVG(CAST(pack_size AS DOUBLE))
      comment: "Average pack size across all SKUs"
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per SKU in kilograms"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per SKU in kilograms"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across SKUs"
    - name: "hazmat_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazmat = TRUE THEN sku_id END)
      comment: "Number of SKUs classified as hazardous materials"
    - name: "hazmat_sku_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_hazmat = TRUE THEN sku_id END) / NULLIF(COUNT(DISTINCT sku_id), 0), 2)
      comment: "Percentage of SKUs that are hazardous materials"
    - name: "controlled_substance_sku_count"
      expr: COUNT(DISTINCT CASE WHEN is_controlled_substance = TRUE THEN sku_id END)
      comment: "Number of SKUs that are controlled substances"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_grade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product grade metrics tracking quality tiers, certifications, and pricing by grade"
  source: "`chemical_mfg_ecm`.`product`.`grade`"
  dimensions:
    - name: "grade_status"
      expr: grade_status
      comment: "Current status of the product grade"
    - name: "grade_name"
      expr: grade_name
      comment: "Name of the product grade"
    - name: "application_sector"
      expr: application_sector
      comment: "Industry sector or application for the grade"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the grade"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier for the grade"
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "GHS classification for the grade"
    - name: "usp_grade_flag"
      expr: usp_grade_flag
      comment: "Indicates whether the grade meets USP (United States Pharmacopeia) standards"
    - name: "acs_reagent_flag"
      expr: acs_reagent_flag
      comment: "Indicates whether the grade meets ACS (American Chemical Society) reagent standards"
    - name: "fcc_grade_flag"
      expr: fcc_grade_flag
      comment: "Indicates whether the grade meets FCC (Food Chemicals Codex) standards"
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Indicates whether the grade is GMP (Good Manufacturing Practice) compliant"
    - name: "reach_registered_flag"
      expr: reach_registered_flag
      comment: "Indicates whether the grade has REACH registration"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when the grade became effective"
  measures:
    - name: "total_grade_count"
      expr: COUNT(DISTINCT grade_id)
      comment: "Total number of unique product grades"
    - name: "active_grade_count"
      expr: COUNT(DISTINCT CASE WHEN grade_status = 'Active' THEN grade_id END)
      comment: "Number of grades with active status"
    - name: "avg_base_price_per_kg"
      expr: AVG(CAST(base_price_per_kg AS DOUBLE))
      comment: "Average base price per kilogram across all grades"
    - name: "avg_minimum_purity_pct"
      expr: AVG(CAST(minimum_purity_percentage AS DOUBLE))
      comment: "Average minimum purity percentage across grades"
    - name: "avg_maximum_impurity_ppm"
      expr: AVG(CAST(maximum_impurity_ppm AS DOUBLE))
      comment: "Average maximum impurity level in parts per million"
    - name: "avg_minimum_order_quantity_kg"
      expr: AVG(CAST(minimum_order_quantity_kg AS DOUBLE))
      comment: "Average minimum order quantity in kilograms"
    - name: "usp_grade_count"
      expr: COUNT(DISTINCT CASE WHEN usp_grade_flag = TRUE THEN grade_id END)
      comment: "Number of grades meeting USP standards"
    - name: "acs_reagent_grade_count"
      expr: COUNT(DISTINCT CASE WHEN acs_reagent_flag = TRUE THEN grade_id END)
      comment: "Number of grades meeting ACS reagent standards"
    - name: "fcc_grade_count"
      expr: COUNT(DISTINCT CASE WHEN fcc_grade_flag = TRUE THEN grade_id END)
      comment: "Number of grades meeting FCC standards"
    - name: "gmp_compliant_grade_count"
      expr: COUNT(DISTINCT CASE WHEN gmp_compliant_flag = TRUE THEN grade_id END)
      comment: "Number of grades that are GMP compliant"
    - name: "reach_registered_grade_count"
      expr: COUNT(DISTINCT CASE WHEN reach_registered_flag = TRUE THEN grade_id END)
      comment: "Number of grades with REACH registration"
    - name: "coa_required_grade_count"
      expr: COUNT(DISTINCT CASE WHEN certificate_of_analysis_required_flag = TRUE THEN grade_id END)
      comment: "Number of grades requiring Certificate of Analysis"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`product_regulatory_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance metrics tracking registration status, approvals, and compliance across jurisdictions"
  source: "`chemical_mfg_ecm`.`product`.`regulatory_status`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or regulatory jurisdiction"
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (e.g., REACH, TSCA, ROHS)"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority or agency"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status"
    - name: "substance_role"
      expr: substance_role
      comment: "Role of the substance in the product (e.g., active ingredient, additive)"
    - name: "reach_registration_type"
      expr: reach_registration_type
      comment: "Type of REACH registration"
    - name: "tsca_inventory_status"
      expr: tsca_inventory_status
      comment: "Status on the TSCA inventory"
    - name: "ghs_classification"
      expr: ghs_classification
      comment: "GHS classification for regulatory purposes"
    - name: "pfas_flag"
      expr: pfas_flag
      comment: "Indicates whether the product contains PFAS (per- and polyfluoroalkyl substances)"
    - name: "prop_65_listing_flag"
      expr: prop_65_listing_flag
      comment: "Indicates whether the product is listed under California Proposition 65"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "Indicates whether the product is RoHS (Restriction of Hazardous Substances) compliant"
    - name: "sara_313_reportable_flag"
      expr: sara_313_reportable_flag
      comment: "Indicates whether the product is reportable under SARA Title III Section 313"
    - name: "svhc_candidate_list_flag"
      expr: svhc_candidate_list_flag
      comment: "Indicates whether the product is on the SVHC (Substance of Very High Concern) candidate list"
    - name: "registration_year_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month when the regulatory registration was completed"
    - name: "approval_year_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when regulatory approval was granted"
  measures:
    - name: "total_regulatory_record_count"
      expr: COUNT(DISTINCT regulatory_status_id)
      comment: "Total number of unique regulatory status records"
    - name: "compliant_record_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN regulatory_status_id END)
      comment: "Number of regulatory records with compliant status"
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN regulatory_status_id END) / NULLIF(COUNT(DISTINCT regulatory_status_id), 0), 2)
      comment: "Percentage of regulatory records that are compliant"
    - name: "pfas_product_count"
      expr: COUNT(DISTINCT CASE WHEN pfas_flag = TRUE THEN regulatory_status_id END)
      comment: "Number of products containing PFAS"
    - name: "prop_65_listed_count"
      expr: COUNT(DISTINCT CASE WHEN prop_65_listing_flag = TRUE THEN regulatory_status_id END)
      comment: "Number of products listed under California Proposition 65"
    - name: "rohs_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant_flag = TRUE THEN regulatory_status_id END)
      comment: "Number of products that are RoHS compliant"
    - name: "sara_313_reportable_count"
      expr: COUNT(DISTINCT CASE WHEN sara_313_reportable_flag = TRUE THEN regulatory_status_id END)
      comment: "Number of products reportable under SARA Title III Section 313"
    - name: "svhc_candidate_list_count"
      expr: COUNT(DISTINCT CASE WHEN svhc_candidate_list_flag = TRUE THEN regulatory_status_id END)
      comment: "Number of products on the SVHC candidate list"
    - name: "reach_registered_count"
      expr: COUNT(DISTINCT CASE WHEN reach_registration_type IS NOT NULL THEN regulatory_status_id END)
      comment: "Number of products with REACH registration"
    - name: "tsca_listed_count"
      expr: COUNT(DISTINCT CASE WHEN tsca_inventory_status = 'Listed' THEN regulatory_status_id END)
      comment: "Number of products listed on the TSCA inventory"
$$;