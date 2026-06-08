-- Metric views for domain: product | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_ic_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core integrated circuit catalog metrics tracking product lifecycle, design characteristics, and compliance status for semiconductor products"
  source: "`semiconductors_ecm`.`product`.`ic_catalog`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the IC product (NPI, production, EOL, etc.)"
    - name: "product_type"
      expr: product_type
      comment: "Type classification of the semiconductor product"
    - name: "target_market"
      expr: target_market
      comment: "Target market segment for the IC product"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Operating temperature grade classification"
    - name: "automotive_qualified"
      expr: automotive_qualified
      comment: "Whether the product is qualified for automotive applications"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the product is subject to ITAR export controls"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulations"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status for chemical substance regulations"
    - name: "npi_phase"
      expr: npi_phase
      comment: "New product introduction phase"
    - name: "design_type"
      expr: design_type
      comment: "Design architecture type of the IC"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing country of origin"
    - name: "is_active"
      expr: is_active
      comment: "Whether the product is currently active in the catalog"
  measures:
    - name: "total_ic_products"
      expr: COUNT(1)
      comment: "Total count of IC catalog products"
    - name: "active_ic_products"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN ic_catalog_id END)
      comment: "Count of active IC products available for sale"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters across products"
    - name: "avg_power_typical_mw"
      expr: AVG(CAST(power_typical_mw AS DOUBLE))
      comment: "Average typical power consumption in milliwatts"
    - name: "avg_operating_frequency_max_mhz"
      expr: AVG(CAST(operating_frequency_max_mhz AS DOUBLE))
      comment: "Average maximum operating frequency in megahertz"
    - name: "total_transistor_count"
      expr: SUM(CAST(transistor_count AS DOUBLE))
      comment: "Total transistor count across all IC products"
    - name: "automotive_qualified_products"
      expr: COUNT(DISTINCT CASE WHEN automotive_qualified = TRUE THEN ic_catalog_id END)
      comment: "Count of products qualified for automotive applications"
    - name: "itar_controlled_products"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled = TRUE THEN ic_catalog_id END)
      comment: "Count of products subject to ITAR export controls"
    - name: "rohs_compliant_products"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant = TRUE THEN ic_catalog_id END)
      comment: "Count of RoHS compliant products for environmental compliance"
    - name: "products_approaching_eol"
      expr: COUNT(DISTINCT CASE WHEN eol_announcement_date IS NOT NULL THEN ic_catalog_id END)
      comment: "Count of products with announced end-of-life dates"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level metrics tracking orderable product configurations, pricing, lifecycle transitions, and compliance for revenue and inventory planning"
  source: "`semiconductors_ecm`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the SKU"
    - name: "orderable_flag"
      expr: orderable_flag
      comment: "Whether the SKU is currently orderable"
    - name: "shippable_flag"
      expr: shippable_flag
      comment: "Whether the SKU is currently shippable"
    - name: "temperature_range"
      expr: temperature_range
      comment: "Operating temperature range classification"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Performance speed grade of the SKU"
    - name: "voltage_variant"
      expr: voltage_variant
      comment: "Operating voltage variant"
    - name: "qualification_level"
      expr: qualification_level
      comment: "Quality and reliability qualification level"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS environmental compliance status"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH chemical substance compliance status"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control status"
    - name: "halogen_free"
      expr: halogen_free
      comment: "Whether the SKU is halogen-free"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing country of origin"
    - name: "pcn_required_flag"
      expr: pcn_required_flag
      comment: "Whether product change notifications are required"
  measures:
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total count of SKUs in the catalog"
    - name: "orderable_skus"
      expr: COUNT(DISTINCT CASE WHEN orderable_flag = TRUE THEN sku_id END)
      comment: "Count of SKUs currently available for ordering"
    - name: "shippable_skus"
      expr: COUNT(DISTINCT CASE WHEN shippable_flag = TRUE THEN sku_id END)
      comment: "Count of SKUs currently available for shipment"
    - name: "total_list_price_usd"
      expr: SUM(CAST(list_price_usd AS DOUBLE))
      comment: "Total list price value across all SKUs in USD"
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price per SKU in USD"
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost_usd AS DOUBLE))
      comment: "Total standard cost across all SKUs in USD"
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost per SKU in USD"
    - name: "avg_unit_weight_grams"
      expr: AVG(CAST(unit_weight_grams AS DOUBLE))
      comment: "Average unit weight in grams for logistics planning"
    - name: "skus_approaching_eol"
      expr: COUNT(DISTINCT CASE WHEN eol_announcement_date IS NOT NULL THEN sku_id END)
      comment: "Count of SKUs with announced end-of-life dates"
    - name: "skus_in_ltb_window"
      expr: COUNT(DISTINCT CASE WHEN last_time_buy_date IS NOT NULL THEN sku_id END)
      comment: "Count of SKUs in last-time-buy window requiring urgent action"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_pcn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Change Notification metrics tracking engineering changes, customer approvals, compliance impact, and implementation timelines for risk management"
  source: "`semiconductors_ecm`.`product`.`pcn`"
  dimensions:
    - name: "pcn_status"
      expr: pcn_status
      comment: "Current status of the product change notification"
    - name: "pcn_type"
      expr: pcn_type
      comment: "Type classification of the product change"
    - name: "change_category"
      expr: change_category
      comment: "Category of the engineering change"
    - name: "form_fit_function_impact"
      expr: form_fit_function_impact
      comment: "Impact assessment on form, fit, and function"
    - name: "customer_approval_required_flag"
      expr: customer_approval_required_flag
      comment: "Whether customer approval is required for this change"
    - name: "automotive_qualification_required_flag"
      expr: automotive_qualification_required_flag
      comment: "Whether automotive re-qualification is required"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Status of qualification testing for the change"
    - name: "jedec_compliance_status"
      expr: jedec_compliance_status
      comment: "JEDEC standards compliance status"
    - name: "environmental_compliance_impact"
      expr: environmental_compliance_impact
      comment: "Impact on environmental compliance (RoHS, REACH)"
  measures:
    - name: "total_pcns"
      expr: COUNT(1)
      comment: "Total count of product change notifications"
    - name: "active_pcns"
      expr: COUNT(DISTINCT CASE WHEN pcn_status IN ('Active', 'Pending', 'In Progress') THEN pcn_id END)
      comment: "Count of PCNs currently active or in progress"
    - name: "pcns_requiring_customer_approval"
      expr: COUNT(DISTINCT CASE WHEN customer_approval_required_flag = TRUE THEN pcn_id END)
      comment: "Count of PCNs requiring customer approval"
    - name: "pcns_requiring_auto_qualification"
      expr: COUNT(DISTINCT CASE WHEN automotive_qualification_required_flag = TRUE THEN pcn_id END)
      comment: "Count of PCNs requiring automotive re-qualification"
    - name: "avg_customer_approval_rate"
      expr: AVG(CAST(REGEXP_REPLACE(customer_approval_count, '[^0-9]', '') AS DOUBLE))
      comment: "Average number of customer approvals received per PCN"
    - name: "avg_customer_objection_rate"
      expr: AVG(CAST(REGEXP_REPLACE(customer_objection_count, '[^0-9]', '') AS DOUBLE))
      comment: "Average number of customer objections per PCN"
    - name: "avg_affected_customer_count"
      expr: AVG(CAST(REGEXP_REPLACE(affected_customer_count, '[^0-9]', '') AS DOUBLE))
      comment: "Average number of customers affected per PCN"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials metrics tracking component costs, material compliance, engineering changes, and supply chain risk for cost management and sourcing decisions"
  source: "`semiconductors_ecm`.`product`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the bill of materials"
    - name: "bom_type"
      expr: bom_type
      comment: "Type classification of the BOM (engineering, manufacturing, etc.)"
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion type for multi-level structures"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code"
    - name: "conflict_minerals_compliant_flag"
      expr: conflict_minerals_compliant_flag
      comment: "Conflict minerals compliance status"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS environmental compliance status"
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH chemical substance compliance status"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control status"
    - name: "critical_material_flag"
      expr: critical_material_flag
      comment: "Whether BOM contains critical or constrained materials"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for cost calculations"
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total count of bill of materials records"
    - name: "total_material_cost"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Total material cost across all BOMs"
    - name: "avg_material_cost_per_bom"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average material cost per BOM for cost benchmarking"
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average production lot size"
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage for yield planning"
    - name: "boms_with_critical_materials"
      expr: COUNT(DISTINCT CASE WHEN critical_material_flag = TRUE THEN bom_id END)
      comment: "Count of BOMs containing critical or constrained materials"
    - name: "conflict_minerals_compliant_boms"
      expr: COUNT(DISTINCT CASE WHEN conflict_minerals_compliant_flag = TRUE THEN bom_id END)
      comment: "Count of BOMs compliant with conflict minerals regulations"
    - name: "rohs_compliant_boms"
      expr: COUNT(DISTINCT CASE WHEN rohs_compliant_flag = TRUE THEN bom_id END)
      comment: "Count of RoHS compliant BOMs"
    - name: "itar_controlled_boms"
      expr: COUNT(DISTINCT CASE WHEN itar_controlled_flag = TRUE THEN bom_id END)
      comment: "Count of BOMs subject to ITAR export controls"
    - name: "boms_approaching_eol"
      expr: COUNT(DISTINCT CASE WHEN eol_date IS NOT NULL THEN bom_id END)
      comment: "Count of BOMs with announced end-of-life dates"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_process_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process node metrics tracking semiconductor manufacturing technology performance, cost, yield, and lifecycle for technology roadmap and capacity planning decisions"
  source: "`semiconductors_ecm`.`product`.`process_node`"
  dimensions:
    - name: "node_generation"
      expr: node_generation
      comment: "Technology generation of the process node"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the process technology"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology type (EUV, DUV, etc.)"
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture type (FinFET, GAA, etc.)"
    - name: "foundry_source"
      expr: foundry_source
      comment: "Foundry partner or source"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the process node"
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "Technology readiness level (TRL) assessment"
    - name: "environmental_compliance_status"
      expr: environmental_compliance_status
      comment: "Environmental compliance status"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification"
  measures:
    - name: "total_process_nodes"
      expr: COUNT(1)
      comment: "Total count of process node technologies"
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size in nanometers"
    - name: "avg_baseline_yield_percent"
      expr: AVG(CAST(baseline_yield_percent AS DOUBLE))
      comment: "Average baseline manufacturing yield percentage"
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer in USD for cost modeling"
    - name: "total_cost_per_wafer_usd"
      expr: SUM(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Total wafer cost across all process nodes"
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average manufacturing cycle time in days"
    - name: "nodes_approaching_eol"
      expr: COUNT(DISTINCT CASE WHEN eol_announcement_date IS NOT NULL THEN process_node_id END)
      comment: "Count of process nodes with announced end-of-life dates"
    - name: "nodes_in_ltb_window"
      expr: COUNT(DISTINCT CASE WHEN ltb_deadline_date IS NOT NULL THEN process_node_id END)
      comment: "Count of process nodes in last-time-buy window"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product family metrics tracking portfolio performance, design quality, compliance, and lifecycle transitions for strategic product line management"
  source: "`semiconductors_ecm`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the product family"
    - name: "family_type"
      expr: family_type
      comment: "Type classification of the product family"
    - name: "application_domain"
      expr: application_domain
      comment: "Target application domain"
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment"
    - name: "business_unit"
      expr: business_unit
      comment: "Owning business unit"
    - name: "package_type"
      expr: package_type
      comment: "Package type for the family"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology type"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status"
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance status"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control status"
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Quality qualification standard"
  measures:
    - name: "total_product_families"
      expr: COUNT(1)
      comment: "Total count of product families"
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturability score"
    - name: "avg_dft_coverage_percent"
      expr: AVG(CAST(dft_coverage_percent AS DOUBLE))
      comment: "Average design-for-test coverage percentage"
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target manufacturing yield percentage"
    - name: "avg_target_power_mw"
      expr: AVG(CAST(target_power_mw AS DOUBLE))
      comment: "Average target power consumption in milliwatts"
    - name: "avg_typical_die_size_mm2"
      expr: AVG(CAST(typical_die_size_mm2 AS DOUBLE))
      comment: "Average typical die size in square millimeters"
    - name: "families_approaching_eol"
      expr: COUNT(DISTINCT CASE WHEN eol_announcement_date IS NOT NULL THEN family_id END)
      comment: "Count of product families with announced end-of-life dates"
    - name: "families_in_ltb_window"
      expr: COUNT(DISTINCT CASE WHEN ltb_date IS NOT NULL THEN family_id END)
      comment: "Count of product families in last-time-buy window"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_errata`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product errata metrics tracking silicon defects, customer impact, resolution status, and workaround availability for quality and risk management"
  source: "`semiconductors_ecm`.`product`.`errata`"
  dimensions:
    - name: "errata_status"
      expr: errata_status
      comment: "Current status of the errata"
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect"
    - name: "functional_block"
      expr: functional_block
      comment: "Affected functional block of the IC"
    - name: "customer_disclosure_status"
      expr: customer_disclosure_status
      comment: "Status of customer disclosure"
    - name: "workaround_available"
      expr: workaround_available
      comment: "Whether a workaround is available"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the fix"
    - name: "business_impact"
      expr: business_impact
      comment: "Business impact assessment"
    - name: "regulatory_impact"
      expr: regulatory_impact
      comment: "Regulatory impact assessment"
  measures:
    - name: "total_errata"
      expr: COUNT(1)
      comment: "Total count of product errata records"
    - name: "open_errata"
      expr: COUNT(DISTINCT CASE WHEN errata_status IN ('Open', 'Active', 'In Progress') THEN errata_id END)
      comment: "Count of open or active errata requiring attention"
    - name: "critical_severity_errata"
      expr: COUNT(DISTINCT CASE WHEN severity IN ('Critical', 'High') THEN errata_id END)
      comment: "Count of critical or high-severity errata"
    - name: "errata_with_workaround"
      expr: COUNT(DISTINCT CASE WHEN workaround_available = TRUE THEN errata_id END)
      comment: "Count of errata with available workarounds"
    - name: "errata_pending_disclosure"
      expr: COUNT(DISTINCT CASE WHEN customer_disclosure_status IN ('Pending', 'Not Disclosed') THEN errata_id END)
      comment: "Count of errata pending customer disclosure"
    - name: "avg_to_revision"
      expr: AVG(CAST(to_revision AS DOUBLE))
      comment: "Average target revision number for fixes"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_qualification_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product qualification program metrics tracking test completion, reliability standards, automotive compliance, and deviation management for quality assurance"
  source: "`semiconductors_ecm`.`product`.`product_qualification_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the qualification program"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification program"
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Qualification standard being followed (AEC-Q100, JEDEC, etc.)"
    - name: "htol_enabled"
      expr: htol_enabled
      comment: "Whether high-temperature operating life testing is enabled"
    - name: "tc_enabled"
      expr: tc_enabled
      comment: "Whether temperature cycling testing is enabled"
    - name: "hast_enabled"
      expr: hast_enabled
      comment: "Whether highly accelerated stress testing is enabled"
    - name: "esd_hbm_enabled"
      expr: esd_hbm_enabled
      comment: "Whether ESD human body model testing is enabled"
    - name: "esd_cdm_enabled"
      expr: esd_cdm_enabled
      comment: "Whether ESD charged device model testing is enabled"
    - name: "latchup_enabled"
      expr: latchup_enabled
      comment: "Whether latchup testing is enabled"
    - name: "deviation_granted"
      expr: deviation_granted
      comment: "Whether a deviation from standard was granted"
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Whether a waiver was granted"
  measures:
    - name: "total_qualification_programs"
      expr: COUNT(1)
      comment: "Total count of product qualification programs"
    - name: "active_qualification_programs"
      expr: COUNT(DISTINCT CASE WHEN program_status IN ('Active', 'In Progress') THEN product_qualification_program_id END)
      comment: "Count of active qualification programs in progress"
    - name: "completed_qualification_programs"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Completed' THEN product_qualification_program_id END)
      comment: "Count of completed qualification programs"
    - name: "programs_with_deviations"
      expr: COUNT(DISTINCT CASE WHEN deviation_granted = TRUE THEN product_qualification_program_id END)
      comment: "Count of programs with granted deviations from standard"
    - name: "programs_with_waivers"
      expr: COUNT(DISTINCT CASE WHEN waiver_granted = TRUE THEN product_qualification_program_id END)
      comment: "Count of programs with granted waivers"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`product_ltb_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-time-buy notification metrics tracking discontinuance revenue, customer response, regulatory approval, and replacement product readiness for EOL transition management"
  source: "`semiconductors_ecm`.`product`.`ltb_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the LTB notification"
    - name: "notification_type"
      expr: notification_type
      comment: "Type of last-time-buy notification"
    - name: "discontinuance_reason_code"
      expr: discontinuance_reason_code
      comment: "Reason code for product discontinuance"
    - name: "customer_acknowledgment_required"
      expr: customer_acknowledgment_required
      comment: "Whether customer acknowledgment is required"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Whether regulatory approval is required"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Status of regulatory approval"
    - name: "replacement_product_qualification_required"
      expr: replacement_product_qualification_required
      comment: "Whether replacement product qualification is required"
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used for notification delivery"
  measures:
    - name: "total_ltb_notifications"
      expr: COUNT(1)
      comment: "Total count of last-time-buy notifications"
    - name: "active_ltb_notifications"
      expr: COUNT(DISTINCT CASE WHEN notification_status IN ('Active', 'Issued', 'Pending') THEN ltb_notification_id END)
      comment: "Count of active LTB notifications requiring action"
    - name: "total_estimated_ltb_revenue"
      expr: SUM(CAST(estimated_ltb_revenue AS DOUBLE))
      comment: "Total estimated last-time-buy revenue"
    - name: "total_actual_ltb_revenue"
      expr: SUM(CAST(actual_ltb_revenue AS DOUBLE))
      comment: "Total actual last-time-buy revenue realized"
    - name: "avg_estimated_ltb_revenue"
      expr: AVG(CAST(estimated_ltb_revenue AS DOUBLE))
      comment: "Average estimated LTB revenue per notification"
    - name: "avg_actual_ltb_revenue"
      expr: AVG(CAST(actual_ltb_revenue AS DOUBLE))
      comment: "Average actual LTB revenue per notification"
    - name: "ltb_requiring_regulatory_approval"
      expr: COUNT(DISTINCT CASE WHEN regulatory_approval_required = TRUE THEN ltb_notification_id END)
      comment: "Count of LTB notifications requiring regulatory approval"
    - name: "ltb_requiring_replacement_qual"
      expr: COUNT(DISTINCT CASE WHEN replacement_product_qualification_required = TRUE THEN ltb_notification_id END)
      comment: "Count of LTB notifications requiring replacement product qualification"
$$;