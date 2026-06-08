-- Metric views for domain: service | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core service offering performance metrics tracking revenue potential, sustainability targets, and operational compliance across waste management service lines"
  source: "`waste_management_ecm`.`service`.`offering`"
  dimensions:
    - name: "service_name"
      expr: service_name
      comment: "Name of the service offering"
    - name: "service_type"
      expr: service_type
      comment: "Type classification of the service"
    - name: "service_category"
      expr: service_category
      comment: "Business category grouping for the service"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the offering (active, deprecated, planned)"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification governing service delivery"
    - name: "pricing_unit"
      expr: pricing_unit
      comment: "Unit of measure for pricing (per ton, per pickup, per month)"
    - name: "sustainability_program_flag"
      expr: sustainability_program_flag
      comment: "Indicates if offering is part of sustainability program"
    - name: "carbon_offset_eligible"
      expr: carbon_offset_eligible
      comment: "Indicates if service qualifies for carbon offset credits"
    - name: "requires_special_permit"
      expr: requires_special_permit
      comment: "Indicates if service requires special regulatory permits"
    - name: "requires_manifest"
      expr: requires_manifest
      comment: "Indicates if service requires hazardous waste manifest documentation"
    - name: "service_year"
      expr: YEAR(effective_start_date)
      comment: "Year the service offering became effective"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the service offering became effective"
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total count of service offerings"
    - name: "total_base_price_revenue_potential"
      expr: SUM(CAST(base_price_amount AS DOUBLE))
      comment: "Sum of base price amounts across all offerings representing revenue potential"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price_amount AS DOUBLE))
      comment: "Average base price per service offering"
    - name: "avg_diversion_rate_target"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average waste diversion rate target percentage across offerings driving sustainability goals"
    - name: "sustainability_program_offerings"
      expr: SUM(CASE WHEN sustainability_program_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of offerings enrolled in sustainability programs"
    - name: "carbon_offset_eligible_offerings"
      expr: SUM(CASE WHEN carbon_offset_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of offerings eligible for carbon offset credits"
    - name: "high_compliance_offerings"
      expr: SUM(CASE WHEN requires_special_permit = TRUE OR requires_manifest = TRUE THEN 1 ELSE 0 END)
      comment: "Count of offerings requiring elevated regulatory compliance"
    - name: "avg_minimum_contract_term_months"
      expr: AVG(CAST(minimum_contract_term_months AS DOUBLE))
      comment: "Average minimum contract commitment period in months"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service pricing and rate schedule metrics tracking revenue rates, surcharges, and cost recovery mechanisms across service areas and customer segments"
  source: "`waste_management_ecm`.`service`.`service_rate_schedule`"
  dimensions:
    - name: "rate_schedule_name"
      expr: rate_schedule_name
      comment: "Name of the rate schedule"
    - name: "rate_schedule_status"
      expr: rate_schedule_status
      comment: "Current status of the rate schedule (active, pending, expired)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment this rate schedule applies to (residential, commercial, industrial)"
    - name: "base_rate_unit"
      expr: base_rate_unit
      comment: "Unit of measure for base rate (per ton, per cubic yard, per pickup)"
    - name: "fuel_surcharge_method"
      expr: fuel_surcharge_method
      comment: "Method used to calculate fuel surcharge"
    - name: "environmental_fee_method"
      expr: environmental_fee_method
      comment: "Method used to calculate environmental recovery fees"
    - name: "tipping_fee_method"
      expr: tipping_fee_method
      comment: "Method used to calculate tipping fee passthrough"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for rate amounts"
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Indicates if rates include sales tax"
    - name: "rate_effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the rate schedule became effective"
    - name: "rate_effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rate schedule became effective"
  measures:
    - name: "total_rate_schedules"
      expr: COUNT(1)
      comment: "Total count of service rate schedules"
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Sum of base rate amounts representing core service revenue"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate per schedule"
    - name: "total_fuel_surcharge_revenue"
      expr: SUM(CAST(fuel_surcharge_base_amount AS DOUBLE))
      comment: "Sum of fuel surcharge base amounts representing fuel cost recovery"
    - name: "avg_fuel_surcharge_percentage"
      expr: AVG(CAST(fuel_surcharge_percentage AS DOUBLE))
      comment: "Average fuel surcharge percentage applied to base rates"
    - name: "total_environmental_recovery_fees"
      expr: SUM(CAST(environmental_recovery_fee AS DOUBLE))
      comment: "Sum of environmental recovery fees supporting compliance and sustainability programs"
    - name: "total_regulatory_compliance_fees"
      expr: SUM(CAST(regulatory_compliance_fee AS DOUBLE))
      comment: "Sum of regulatory compliance fees covering permit and reporting costs"
    - name: "total_contamination_surcharges"
      expr: SUM(CAST(contamination_surcharge AS DOUBLE))
      comment: "Sum of contamination surcharges penalizing improper waste sorting"
    - name: "avg_contamination_threshold"
      expr: AVG(CAST(contamination_threshold_percentage AS DOUBLE))
      comment: "Average contamination threshold percentage before surcharges apply"
    - name: "total_overweight_fees"
      expr: SUM(CAST(overweight_fee AS DOUBLE))
      comment: "Sum of overweight fees for loads exceeding standard weight limits"
    - name: "avg_standard_weight_limit"
      expr: AVG(CAST(standard_weight_limit AS DOUBLE))
      comment: "Average standard weight limit before overweight fees apply"
    - name: "total_minimum_service_charges"
      expr: SUM(CAST(minimum_service_charge AS DOUBLE))
      comment: "Sum of minimum service charges ensuring baseline revenue per account"
    - name: "avg_sales_tax_rate"
      expr: AVG(CAST(sales_tax_rate AS DOUBLE))
      comment: "Average sales tax rate applied to service charges"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service territory operational metrics tracking coverage area, household density, program availability, and sustainability targets across geographic regions"
  source: "`waste_management_ecm`.`service`.`territory`"
  dimensions:
    - name: "territory_name"
      expr: territory_name
      comment: "Name of the service territory"
    - name: "territory_type"
      expr: territory_type
      comment: "Type classification of the territory (urban, suburban, rural)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the territory"
    - name: "state_code"
      expr: state_code
      comment: "State code for the territory"
    - name: "county_name"
      expr: county_name
      comment: "County name for the territory"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the territory"
    - name: "recycling_program_available"
      expr: recycling_program_available
      comment: "Indicates if recycling program is available in territory"
    - name: "organics_program_available"
      expr: organics_program_available
      comment: "Indicates if organics/composting program is available"
    - name: "hazmat_collection_available"
      expr: hazmat_collection_available
      comment: "Indicates if hazardous materials collection is available"
    - name: "route_optimization_enabled"
      expr: route_optimization_enabled
      comment: "Indicates if route optimization technology is deployed"
    - name: "gps_tracking_required"
      expr: gps_tracking_required
      comment: "Indicates if GPS tracking is required for fleet in territory"
    - name: "service_frequency_residential"
      expr: service_frequency_residential
      comment: "Standard residential service frequency in territory"
    - name: "territory_year"
      expr: YEAR(effective_start_date)
      comment: "Year the territory became effective"
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total count of service territories"
    - name: "total_coverage_area_sq_miles"
      expr: SUM(CAST(area_square_miles AS DOUBLE))
      comment: "Total geographic coverage area in square miles"
    - name: "avg_territory_size_sq_miles"
      expr: AVG(CAST(area_square_miles AS DOUBLE))
      comment: "Average territory size in square miles"
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Total estimated population served across territories"
    - name: "total_household_estimate"
      expr: SUM(CAST(household_count_estimate AS DOUBLE))
      comment: "Total estimated household count across territories"
    - name: "total_commercial_accounts"
      expr: SUM(CAST(commercial_account_count AS DOUBLE))
      comment: "Total commercial account count across territories"
    - name: "avg_diversion_rate_target"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average waste diversion rate target percentage driving sustainability performance"
    - name: "recycling_program_coverage"
      expr: SUM(CASE WHEN recycling_program_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of territories with recycling program availability"
    - name: "organics_program_coverage"
      expr: SUM(CASE WHEN organics_program_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of territories with organics/composting program availability"
    - name: "hazmat_collection_coverage"
      expr: SUM(CASE WHEN hazmat_collection_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of territories with hazardous materials collection capability"
    - name: "route_optimized_territories"
      expr: SUM(CASE WHEN route_optimization_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of territories with route optimization technology deployed"
    - name: "gps_tracked_territories"
      expr: SUM(CASE WHEN gps_tracking_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of territories requiring GPS fleet tracking"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_waste_stream`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste stream classification metrics tracking diversion potential, environmental impact, regulatory compliance, and material recovery opportunities across waste categories"
  source: "`waste_management_ecm`.`service`.`waste_stream`"
  dimensions:
    - name: "waste_stream_name"
      expr: waste_stream_name
      comment: "Name of the waste stream"
    - name: "waste_stream_category"
      expr: waste_stream_category
      comment: "High-level category of the waste stream (MSW, C&D, hazardous, recyclable)"
    - name: "subcategory"
      expr: subcategory
      comment: "Subcategory classification within the waste stream"
    - name: "waste_stream_status"
      expr: waste_stream_status
      comment: "Current status of the waste stream definition"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification governing handling and disposal"
    - name: "hazard_class"
      expr: hazard_class
      comment: "DOT hazard class if applicable"
    - name: "disposal_pathway"
      expr: disposal_pathway
      comment: "Primary disposal or processing pathway (landfill, recycling, composting, WTE)"
    - name: "recyclable_flag"
      expr: recyclable_flag
      comment: "Indicates if waste stream is recyclable"
    - name: "compostable_flag"
      expr: compostable_flag
      comment: "Indicates if waste stream is compostable"
    - name: "diversion_eligible_flag"
      expr: diversion_eligible_flag
      comment: "Indicates if waste stream qualifies for diversion credit"
    - name: "wte_feedstock_flag"
      expr: wte_feedstock_flag
      comment: "Indicates if waste stream is suitable for waste-to-energy conversion"
    - name: "commodity_value_flag"
      expr: commodity_value_flag
      comment: "Indicates if waste stream has commodity resale value"
    - name: "manifest_required_flag"
      expr: manifest_required_flag
      comment: "Indicates if waste stream requires manifest documentation"
    - name: "special_handling_required_flag"
      expr: special_handling_required_flag
      comment: "Indicates if waste stream requires special handling procedures"
  measures:
    - name: "total_waste_streams"
      expr: COUNT(1)
      comment: "Total count of defined waste streams"
    - name: "avg_diversion_credit_percentage"
      expr: AVG(CAST(diversion_credit_percentage AS DOUBLE))
      comment: "Average diversion credit percentage across waste streams driving sustainability metrics"
    - name: "avg_ghg_emission_factor"
      expr: AVG(CAST(ghg_emission_factor_co2e_per_ton AS DOUBLE))
      comment: "Average greenhouse gas emission factor in CO2e per ton for environmental impact assessment"
    - name: "avg_density_lbs_per_cubic_yard"
      expr: AVG(CAST(density_lbs_per_cubic_yard AS DOUBLE))
      comment: "Average density in pounds per cubic yard for capacity planning"
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio_avg AS DOUBLE))
      comment: "Average compaction ratio for volume optimization"
    - name: "avg_contamination_threshold"
      expr: AVG(CAST(contamination_threshold_percentage AS DOUBLE))
      comment: "Average contamination threshold percentage before material is rejected"
    - name: "recyclable_waste_streams"
      expr: SUM(CASE WHEN recyclable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recyclable waste streams supporting material recovery"
    - name: "compostable_waste_streams"
      expr: SUM(CASE WHEN compostable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compostable waste streams supporting organics diversion"
    - name: "diversion_eligible_waste_streams"
      expr: SUM(CASE WHEN diversion_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste streams eligible for diversion credit"
    - name: "wte_feedstock_waste_streams"
      expr: SUM(CASE WHEN wte_feedstock_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste streams suitable for waste-to-energy conversion"
    - name: "commodity_value_waste_streams"
      expr: SUM(CASE WHEN commodity_value_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste streams with commodity resale value driving revenue recovery"
    - name: "manifest_required_waste_streams"
      expr: SUM(CASE WHEN manifest_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste streams requiring manifest documentation for regulatory compliance"
    - name: "special_handling_waste_streams"
      expr: SUM(CASE WHEN special_handling_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of waste streams requiring special handling procedures"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_sla_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance metrics tracking response times, resolution commitments, penalty structures, and customer satisfaction targets"
  source: "`waste_management_ecm`.`service`.`sla_definition`"
  dimensions:
    - name: "sla_name"
      expr: sla_name
      comment: "Name of the service level agreement"
    - name: "sla_type"
      expr: sla_type
      comment: "Type classification of the SLA (response, resolution, delivery)"
    - name: "sla_definition_status"
      expr: sla_definition_status
      comment: "Current status of the SLA definition"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure SLA compliance"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of SLA performance reporting"
    - name: "auto_credit_enabled_flag"
      expr: auto_credit_enabled_flag
      comment: "Indicates if automatic customer credits are enabled for SLA breaches"
    - name: "notification_enabled_flag"
      expr: notification_enabled_flag
      comment: "Indicates if automated notifications are enabled for SLA events"
    - name: "sla_year"
      expr: YEAR(effective_start_date)
      comment: "Year the SLA definition became effective"
  measures:
    - name: "total_sla_definitions"
      expr: COUNT(1)
      comment: "Total count of SLA definitions"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average committed response time in hours for customer service requests"
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average committed resolution time in hours for service issues"
    - name: "avg_escalation_threshold_hours"
      expr: AVG(CAST(escalation_threshold_hours AS DOUBLE))
      comment: "Average escalation threshold in hours before management intervention"
    - name: "avg_complaint_resolution_window_hours"
      expr: AVG(CAST(complaint_resolution_window_hours AS DOUBLE))
      comment: "Average complaint resolution window in hours for customer satisfaction"
    - name: "avg_on_time_service_rate_target"
      expr: AVG(CAST(on_time_service_rate_target_pct AS DOUBLE))
      comment: "Average on-time service rate target percentage driving operational excellence"
    - name: "avg_missed_pickup_credit_amount"
      expr: AVG(CAST(missed_pickup_credit_amount AS DOUBLE))
      comment: "Average customer credit amount for missed pickups"
    - name: "avg_missed_pickup_credit_pct"
      expr: AVG(CAST(missed_pickup_credit_pct AS DOUBLE))
      comment: "Average customer credit percentage for missed pickups"
    - name: "avg_late_delivery_penalty_amount"
      expr: AVG(CAST(late_delivery_penalty_amount AS DOUBLE))
      comment: "Average penalty amount for late container deliveries"
    - name: "avg_late_delivery_penalty_pct"
      expr: AVG(CAST(late_delivery_penalty_pct AS DOUBLE))
      comment: "Average penalty percentage for late container deliveries"
    - name: "auto_credit_enabled_slas"
      expr: SUM(CASE WHEN auto_credit_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SLAs with automatic customer credit enabled"
    - name: "notification_enabled_slas"
      expr: SUM(CASE WHEN notification_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SLAs with automated notification enabled"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service bundle performance metrics tracking bundled offering pricing, discounts, sustainability targets, and contract terms for multi-service packages"
  source: "`waste_management_ecm`.`service`.`bundle`"
  dimensions:
    - name: "bundle_name"
      expr: bundle_name
      comment: "Name of the service bundle"
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type classification of the bundle"
    - name: "bundle_category"
      expr: bundle_category
      comment: "Business category of the bundle"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the bundle"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the bundle"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model used for the bundle"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which bundle is offered"
    - name: "geographic_availability"
      expr: geographic_availability
      comment: "Geographic regions where bundle is available"
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates if bundle is part of a promotional campaign"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates if bundle automatically renews at term end"
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Indicates if bundle is sustainability certified"
    - name: "bundle_year"
      expr: YEAR(effective_start_date)
      comment: "Year the bundle became effective"
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total count of service bundles"
    - name: "total_base_price_revenue_potential"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base prices across bundles representing revenue potential"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price per bundle"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Sum of discount amounts offered across bundles"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered on bundles"
    - name: "avg_diversion_rate_target"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average waste diversion rate target percentage for bundles driving sustainability"
    - name: "avg_ghg_reduction_co2e_tons"
      expr: AVG(CAST(ghg_reduction_co2e_tons AS DOUBLE))
      comment: "Average greenhouse gas reduction in CO2e tons per bundle for environmental impact"
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Sum of early termination fees protecting contract revenue"
    - name: "promotional_bundles"
      expr: SUM(CASE WHEN promotional_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bundles in promotional campaigns"
    - name: "auto_renewal_bundles"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bundles with automatic renewal enabled"
    - name: "sustainability_certified_bundles"
      expr: SUM(CASE WHEN sustainability_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sustainability-certified bundles supporting green initiatives"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_container_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container type asset metrics tracking capacity specifications, material construction, lifecycle costs, and operational compatibility across waste collection equipment"
  source: "`waste_management_ecm`.`service`.`container_type`"
  dimensions:
    - name: "container_type_name"
      expr: container_type_name
      comment: "Name of the container type"
    - name: "container_category"
      expr: container_category
      comment: "Category classification of the container"
    - name: "container_type_status"
      expr: container_type_status
      comment: "Current status of the container type definition"
    - name: "material_construction"
      expr: material_construction
      comment: "Material used in container construction (plastic, metal, composite)"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer of the container type"
    - name: "lift_mechanism_compatibility"
      expr: lift_mechanism_compatibility
      comment: "Compatible lift mechanisms for the container"
    - name: "wheel_configuration"
      expr: wheel_configuration
      comment: "Wheel configuration of the container"
    - name: "lid_type"
      expr: lid_type
      comment: "Type of lid on the container"
    - name: "residential_use_flag"
      expr: residential_use_flag
      comment: "Indicates if container is suitable for residential use"
    - name: "commercial_use_flag"
      expr: commercial_use_flag
      comment: "Indicates if container is suitable for commercial use"
    - name: "industrial_use_flag"
      expr: industrial_use_flag
      comment: "Indicates if container is suitable for industrial use"
    - name: "compaction_capable_flag"
      expr: compaction_capable_flag
      comment: "Indicates if container supports compaction"
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates if container is certified for hazardous materials"
    - name: "rfid_compatible_flag"
      expr: rfid_compatible_flag
      comment: "Indicates if container is compatible with RFID tracking"
    - name: "gps_tracking_compatible_flag"
      expr: gps_tracking_compatible_flag
      comment: "Indicates if container is compatible with GPS tracking"
  measures:
    - name: "total_container_types"
      expr: COUNT(1)
      comment: "Total count of defined container types"
    - name: "avg_capacity_cubic_yards"
      expr: AVG(CAST(capacity_cubic_yards AS DOUBLE))
      comment: "Average container capacity in cubic yards for volume planning"
    - name: "avg_capacity_gallons"
      expr: AVG(CAST(capacity_gallons AS DOUBLE))
      comment: "Average container capacity in gallons for volume planning"
    - name: "avg_weight_capacity_lbs"
      expr: AVG(CAST(weight_capacity_lbs AS DOUBLE))
      comment: "Average weight capacity in pounds for load planning"
    - name: "avg_tare_weight_lbs"
      expr: AVG(CAST(tare_weight_lbs AS DOUBLE))
      comment: "Average tare weight in pounds for net weight calculations"
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio AS DOUBLE))
      comment: "Average compaction ratio for volume optimization"
    - name: "avg_standard_unit_cost"
      expr: AVG(CAST(standard_unit_cost AS DOUBLE))
      comment: "Average standard unit cost per container for capital planning"
    - name: "avg_estimated_useful_life_years"
      expr: AVG(CAST(estimated_useful_life_years AS DOUBLE))
      comment: "Average estimated useful life in years for asset lifecycle management"
    - name: "residential_use_containers"
      expr: SUM(CASE WHEN residential_use_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types suitable for residential use"
    - name: "commercial_use_containers"
      expr: SUM(CASE WHEN commercial_use_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types suitable for commercial use"
    - name: "industrial_use_containers"
      expr: SUM(CASE WHEN industrial_use_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types suitable for industrial use"
    - name: "compaction_capable_containers"
      expr: SUM(CASE WHEN compaction_capable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types supporting compaction for volume efficiency"
    - name: "hazmat_certified_containers"
      expr: SUM(CASE WHEN hazmat_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types certified for hazardous materials"
    - name: "rfid_compatible_containers"
      expr: SUM(CASE WHEN rfid_compatible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types compatible with RFID tracking technology"
    - name: "gps_tracking_compatible_containers"
      expr: SUM(CASE WHEN gps_tracking_compatible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of container types compatible with GPS tracking technology"
$$;