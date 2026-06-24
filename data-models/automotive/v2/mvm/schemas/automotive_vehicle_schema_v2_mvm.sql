-- Schema for Domain: vehicle | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`vehicle` COMMENT 'SSOT for all vehicle master data across the enterprise. Owns VIN-level vehicle identity, model configurations, trim levels, MY (Model Year) lifecycle from SOP (Start of Production) to EOP (End of Production), powertrain variants (ICE, HEV, PHEV, EV), platform architectures, and ADAS feature sets. Serves as the authoritative reference for every downstream domain that needs to identify or describe a vehicle instance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` (
    `vin_registry_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT '',
    `build_date` DATE COMMENT '',
    `check_digit` STRING COMMENT '',
    `connected_diagnostics_enabled_flag` BOOLEAN COMMENT 'Whether connected diagnostics are enabled for this VIN',
    `created_timestamp` TIMESTAMP COMMENT '',
    `curb_weight_kg` DECIMAL(18,2) COMMENT '',
    `destination_market` STRING COMMENT '',
    `emission_standard` STRING COMMENT '',
    `eop_date` DATE COMMENT '',
    `epa_combined_mpg` DECIMAL(18,2) COMMENT '',
    `extended_warranty_active_flag` BOOLEAN COMMENT 'Whether an extended or third-party warranty is currently active',
    `fuel_tank_capacity_liters` DECIMAL(18,2) COMMENT '',
    `gvwr_kg` DECIMAL(18,2) COMMENT '',
    `homologation_market` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_off_timestamp` TIMESTAMP COMMENT '',
    `model_year_decoded` STRING COMMENT '',
    `msrp_currency_code` STRING COMMENT '',
    `obd_diagnostic_link_code` BIGINT COMMENT '',
    `obd_last_read_timestamp` TIMESTAMP COMMENT 'Timestamp of last OBD-II data read from vehicle',
    `obd_protocol` STRING COMMENT '',
    `plant_code` STRING COMMENT '',
    `production_sequence_number` STRING COMMENT '',
    `recall_flag` BOOLEAN COMMENT '',
    `safety_rating` STRING COMMENT '',
    `self_service_portal_registered_flag` BOOLEAN COMMENT 'Whether vehicle is registered on customer self-service portal',
    `sop_date` DATE COMMENT '',
    `telematics_enabled_flag` BOOLEAN COMMENT '',
    `vds` STRING COMMENT '',
    `vehicle_lifecycle_status` STRING COMMENT '',
    `vin` STRING COMMENT '',
    `vis` STRING COMMENT '',
    `warranty_end_date` DATE COMMENT '',
    `warranty_start_date` DATE COMMENT '',
    `wltp_combined_consumption` DECIMAL(18,2) COMMENT '',
    `wmi` STRING COMMENT '',
    CONSTRAINT pk_vin_registry PRIMARY KEY(`vin_registry_id`)
) COMMENT 'SSOT for every physical vehicle instance identified by its 17-character VIN per ISO 3779. Captures decoded VIN structure (WMI, VDS, VIS), manufacturing plant code, production sequence number, build date, model year (MY), line-off timestamp, homologation market, and current lifecycle status (pre-production, in-production, in-transit, in-service, end-of-life). This is the enterprise anchor record — the single identity key — that every downstream domain (sales, aftersales, logistics, mobility, finance) references to identify a specific vehicle unit.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`model` (
    `model_id` BIGINT COMMENT '',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Vehicle models have a base-level engineering BOM header representing the models standard component structure, used in product lifecycle management and engineering release processes. This model-level ',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: A model-level BOM defines the base vehicle structure before options and configurations. Engineering change impact analysis, standard cost rollup by model, and field service parts lookup require a dire',
    `platform_id` BIGINT COMMENT '',
    `segment_id` BIGINT COMMENT 'Foreign key linking to product.product_segment. Business justification: Vehicle models are classified into product segments for CAFE fleet compliance reporting, portfolio strategy, and competitive benchmarking. Automotive product planners require this link to aggregate mo',
    `vehicle_program_id` BIGINT COMMENT '',
    `adas_features` STRING COMMENT '',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT '',
    `body_style` STRING COMMENT '',
    `brand_name` STRING COMMENT '',
    `cargo_capacity_liters` DECIMAL(18,2) COMMENT '',
    `co2_emissions_g_per_km` DECIMAL(18,2) COMMENT '',
    `connectivity_features` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `curb_weight_kg` DECIMAL(18,2) COMMENT '',
    `model_description` STRING COMMENT '',
    `drive_configuration` STRING COMMENT '',
    `electric_range_miles` DECIMAL(18,2) COMMENT '',
    `emissions_standard` STRING COMMENT '',
    `end_of_production_model_year` STRING COMMENT '',
    `engine_code` STRING COMMENT '',
    `eop_date` DATE COMMENT '',
    `extended_warranty_eligible_flag` BOOLEAN COMMENT 'Whether model is eligible for extended warranty programs',
    `field_service_support_flag` BOOLEAN COMMENT '',
    `fuel_economy_city_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_economy_hwy_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_type` STRING COMMENT '',
    `height_mm` DECIMAL(18,2) COMMENT '',
    `homologation_status` STRING COMMENT '',
    `launch_model_year` STRING COMMENT '',
    `length_mm` DECIMAL(18,2) COMMENT '',
    `market_regions` STRING COMMENT '',
    `mes_model_code` STRING COMMENT 'Model code as registered in MES systems for production tracking.',
    `model_status` STRING COMMENT '',
    `msrp_usd` DECIMAL(18,2) COMMENT '',
    `model_name` STRING COMMENT '',
    `ncap_safety_rating` STRING COMMENT '',
    `obd_diagnostic_support_level` STRING COMMENT 'Level of OBD-II diagnostic support (basic, enhanced, full)',
    `ota_update_capable_flag` BOOLEAN COMMENT 'Whether model supports OTA software updates',
    `powertrain_type` STRING COMMENT '',
    `primary_market` STRING COMMENT '',
    `program_code` STRING COMMENT '',
    `safety_standard` STRING COMMENT '',
    `seating_capacity` STRING COMMENT '',
    `segment` STRING COMMENT '',
    `self_service_portal_eligible_flag` BOOLEAN COMMENT 'Whether model is eligible for self-service portal features',
    `sop_date` DATE COMMENT '',
    `transmission_gears` STRING COMMENT '',
    `transmission_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `variant_count` STRING COMMENT '',
    `vehicle_class` STRING COMMENT '',
    `wheelbase_mm` DECIMAL(18,2) COMMENT '',
    `width_mm` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_model PRIMARY KEY(`model_id`)
) COMMENT 'Defines the commercial vehicle model (nameplate) as a business entity — e.g., F-150, Camry, Model 3. Captures model name, brand/marque, vehicle segment (sedan, SUV, pickup, commercial), body style, drive configuration (FWD, RWD, AWD, 4WD), primary market, launch MY, EOP MY, and program code. Serves as the top-level classification anchor for all vehicle configurations and trim hierarchies.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`trim_level` (
    `trim_level_id` BIGINT COMMENT '',
    `catalog_version_id` BIGINT COMMENT 'Foreign key linking to product.catalog_version. Business justification: Trim levels are published within specific catalog versions for dealer ordering systems and consumer configurators. Automotive retail operations require this link to determine which trim levels are ord',
    `model_id` BIGINT COMMENT '',
    `base_msrp_amount` DECIMAL(18,2) COMMENT '',
    `base_msrp_usd` DECIMAL(18,2) COMMENT '',
    `connected_services_tier` STRING COMMENT 'Connected services tier included with trim (basic, premium, ultimate)',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `extended_warranty_default_months` STRING COMMENT 'Default extended warranty period in months for this trim',
    `is_active` BOOLEAN COMMENT '',
    `powertrain_options` STRING COMMENT '',
    `standard_features` STRING COMMENT '',
    `trim_code` STRING COMMENT '',
    `trim_description` STRING COMMENT '',
    `trim_name` STRING COMMENT '',
    `trim_tier` STRING COMMENT '',
    CONSTRAINT pk_trim_level PRIMARY KEY(`trim_level_id`)
) COMMENT 'Defines the ordered hierarchy of trim grades within a model-MY combination (e.g., Base, XL, XLT, Lariat, Platinum, Limited). Captures trim code, trim name, market positioning tier, MSRP base price, standard feature set description, target market region, and active/inactive status. Trim levels are the primary commercial differentiation unit used in sales, dealer ordering, and MSRP pricing. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` (
    `powertrain_variant_id` BIGINT COMMENT '',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Powertrain variants have dedicated assembly BOMs used in manufacturing planning, supplier sourcing, and warranty cost analysis. Automotive engineers maintain powertrain-specific BOM headers to track e',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Powertrain variants must be traceable to governing design specifications for EPA/CARB regulatory compliance, engineering change impact assessment, and homologation. Emissions certification and OBD com',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: powertrain_variant currently stores `vehicle_platform` as a STRING column, which is a denormalized reference to the platform entity. In automotive engineering, powertrain variants are designed and val',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Powertrain variants are developed and validated within a specific vehicle program. Engineering program managers track powertrain development cost, validation status, and emissions targets per program.',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT '',
    `charging_standard` STRING COMMENT '',
    `co2_emissions_g_per_km` STRING COMMENT '',
    `combined_system_power_kw` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `cylinder_count` STRING COMMENT '',
    `powertrain_variant_description` STRING COMMENT '',
    `drive_type` STRING COMMENT '',
    `electric_motor_power_kw` DECIMAL(18,2) COMMENT '',
    `end_of_production_date` DATE COMMENT '',
    `engine_displacement_cc` STRING COMMENT '',
    `epa_fuel_economy_combined_mpg` DECIMAL(18,2) COMMENT '',
    `epa_range_miles` STRING COMMENT '',
    `fuel_economy_city_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_economy_combined_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_economy_highway_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_type` STRING COMMENT '',
    `model_year` STRING COMMENT '',
    `obd_pid_set` STRING COMMENT 'Supported OBD-II PID set for this powertrain variant',
    `ota_ecu_count` STRING COMMENT 'Number of OTA-updatable ECUs in this powertrain variant',
    `powertrain_type` STRING COMMENT '',
    `powertrain_variant_status` STRING COMMENT '',
    `range_km` STRING COMMENT '',
    `record_audit_created` TIMESTAMP COMMENT '',
    `record_audit_updated` TIMESTAMP COMMENT '',
    `start_of_production_date` DATE COMMENT '',
    `subscription_available_flag` BOOLEAN COMMENT '',
    `transmission_type` STRING COMMENT '',
    `variant_code` STRING COMMENT '',
    `variant_name` STRING COMMENT '',
    `wltp_fuel_economy_combined_mpg` DECIMAL(18,2) COMMENT '',
    `wltp_range_km` STRING COMMENT '',
    CONSTRAINT pk_powertrain_variant PRIMARY KEY(`powertrain_variant_id`)
) COMMENT 'Authoritative catalog of all powertrain configurations available across the vehicle lineup. Captures powertrain type (ICE, HEV, PHEV, BEV, FCEV), engine displacement, cylinder count, fuel type, electric motor peak power (kW), combined system power, transmission type, drive type, EPA/WLTP fuel economy or range rating, CO2 emissions (g/km), battery capacity (kWh for EV/PHEV), and charging standard (CCS, CHAdeMO, NACS). Used for homologation, CAFE compliance, and consumer-facing specifications.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`platform` (
    `platform_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Platform architecture is governed by master design specifications covering structural requirements, dimensional envelopes, and weight targets. Homologation, safety certification, and platform reuse de',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Platform development is funded and governed under a vehicle program. Engineering program reporting, development cost allocation, and milestone tracking require knowing which vehicle program owns a pla',
    `adaptive_cruise_control` BOOLEAN COMMENT '',
    `adas_features` STRING COMMENT '',
    `architecture` STRING COMMENT '',
    `platform_code` STRING COMMENT '',
    `commodity_exposure_profile` STRING COMMENT '',
    `compatible_powertrain_families` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `platform_description` STRING COMMENT '',
    `development_cost_usd` DECIMAL(18,2) COMMENT '',
    `diagnostic_connector_type` STRING COMMENT 'Type of diagnostic connector (OBD-II Type A, Type B)',
    `emissions_class` STRING COMMENT '',
    `end_of_production_date` DATE COMMENT '',
    `family` STRING COMMENT '',
    `generation` DECIMAL(18,2) COMMENT '',
    `height_max_mm` STRING COMMENT '',
    `height_min_mm` STRING COMMENT '',
    `length_max_mm` STRING COMMENT '',
    `length_min_mm` STRING COMMENT '',
    `material_strategy` DECIMAL(18,2) COMMENT '',
    `max_gvw_kg` STRING COMMENT '',
    `modular_score` DECIMAL(18,2) COMMENT '',
    `platform_name` STRING COMMENT '',
    `obd_architecture_version` STRING COMMENT 'OBD architecture version supported by platform',
    `ota_capability` BOOLEAN COMMENT '',
    `ota_gateway_architecture` STRING COMMENT 'OTA gateway architecture for the platform',
    `owner_business_unit` STRING COMMENT '',
    `platform_status` STRING COMMENT '',
    `platform_type` STRING COMMENT '',
    `regulatory_compliance` STRING COMMENT '',
    `release_year` STRING COMMENT '',
    `start_of_production_date` DATE COMMENT '',
    `supplier_collaboration_tier` STRING COMMENT '',
    `track_width_max_mm` STRING COMMENT '',
    `track_width_min_mm` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `version` STRING COMMENT '',
    `weight_kg` STRING COMMENT '',
    `wheelbase_max_mm` STRING COMMENT '',
    `wheelbase_min_mm` STRING COMMENT '',
    `width_max_mm` STRING COMMENT '',
    `width_min_mm` STRING COMMENT '',
    CONSTRAINT pk_platform PRIMARY KEY(`platform_id`)
) COMMENT 'Defines the vehicle platform (architecture) that underpins one or more models. Captures platform code, platform name, architecture generation, wheelbase range, track width range, structural material strategy (steel, aluminum, mixed), compatible powertrain families, maximum GVW rating, and platform owner business unit. Platforms are shared across multiple nameplates and model years, making this a critical cross-model reference for engineering, manufacturing, and supply chain.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`configuration` (
    `configuration_id` BIGINT COMMENT '',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Vehicle configurations must be traceable to their governing APQP plan for production release authorization and PPAP approval. Configuration-level APQP compliance is required before a configuration can',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Vehicle configuration drives BOM header selection for production planning and standard costing. Manufacturing and engineering teams use this link to validate build feasibility and retrieve component l',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: A vehicle configuration maps directly to a specific engineering BOM for production planning, cost rollup, and engineering change impact assessment. Manufacturing execution systems require configuratio',
    `catalog_version_id` BIGINT COMMENT 'Foreign key linking to product.catalog_version. Business justification: Vehicle configurations are published in catalog versions to enable dealer ordering and online configurator availability. Automotive retail operations require this link to determine which configuration',
    `design_specification_id` BIGINT COMMENT '',
    `model_id` BIGINT COMMENT '',
    `platform_id` BIGINT COMMENT '',
    `powertrain_variant_id` BIGINT COMMENT '',
    `plant_id` BIGINT COMMENT '',
    `trim_level_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_trim_level. Business justification: configuration defines a fully specified, buildable vehicle combining model, MY, trim, powertrain, and market. It currently stores trim as a STRING column (`trim_level`), which is denormalized. vehicle',
    `adas_features` STRING COMMENT '',
    `body_style` STRING COMMENT '',
    `build_feasibility_status` STRING COMMENT '',
    `co2_emissions_g_per_km` STRING COMMENT '',
    `configuration_code` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `destination_charge` DECIMAL(18,2) COMMENT '',
    `drivetrain` STRING COMMENT '',
    `emissions_cert_status` STRING COMMENT '',
    `end_of_production_date` DATE COMMENT '',
    `ev_range_miles` STRING COMMENT '',
    `extended_warranty_eligible_flag` BOOLEAN COMMENT 'Whether this configuration is eligible for extended warranty',
    `exterior_color` STRING COMMENT '',
    `fuel_economy_city_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_economy_hwy_mpg` DECIMAL(18,2) COMMENT '',
    `fuel_type` STRING COMMENT '',
    `interior_material` STRING COMMENT '',
    `market_country_code` STRING COMMENT '',
    `market_region` STRING COMMENT '',
    `model_year` STRING COMMENT '',
    `msrp_amount` DECIMAL(18,2) COMMENT '',
    `obd_diagnostic_package` STRING COMMENT 'OBD diagnostic package level for this configuration',
    `optional_package_codes` STRING COMMENT '',
    `ota_update_tier` STRING COMMENT 'OTA update tier (safety_only, full, premium)',
    `record_status` STRING COMMENT '',
    `start_of_production_date` DATE COMMENT '',
    `subscription_eligible_flag` BOOLEAN COMMENT '',
    `total_price` DECIMAL(18,2) COMMENT '',
    `transmission_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vehicle_platform` STRING COMMENT '',
    `warranty_miles` STRING COMMENT '',
    `warranty_years` STRING COMMENT '',
    `wheel_size_inch` STRING COMMENT '',
    CONSTRAINT pk_configuration PRIMARY KEY(`configuration_id`)
) COMMENT 'The fully specified, buildable vehicle configuration combining model, MY, trim, powertrain, and market. Each record represents a unique orderable specification (analogous to a manufacturing SKU or dealer order code). Captures configuration code, market region, build feasibility status, MSRP, destination charge, fuel economy label values, emissions certification status, and production plant assignment. This is the master configuration record that bridges product planning to manufacturing BOM explosion and dealer order management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`option_package` (
    `option_package_id` BIGINT COMMENT '',
    `bom_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `connected_service_included_flag` BOOLEAN COMMENT 'Whether connected vehicle services are included in this package',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `included_features` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_available` BOOLEAN COMMENT '',
    `msrp_amount` DECIMAL(18,2) COMMENT '',
    `ota_feature_unlock_flag` BOOLEAN COMMENT 'Whether this package can be unlocked via OTA',
    `package_code` STRING COMMENT '',
    `package_description` STRING COMMENT '',
    `package_name` STRING COMMENT '',
    `package_price_usd` DECIMAL(18,2) COMMENT '',
    `package_type` STRING COMMENT '',
    CONSTRAINT pk_option_package PRIMARY KEY(`option_package_id`)
) COMMENT 'Defines factory-installed option packages, standalone options, exterior colors, and interior trim selections available for vehicle configurations. Captures option code, option name, option type (package, standalone, accessory, exterior color, interior trim), MSRP uplift, content description, availability constraints (trim/market/powertrain restrictions), mutually exclusive options, and required prerequisite options. Drives dealer order configuration, window sticker (Monroney label) generation, and BOM explosion in manufacturing. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` (
    `build_spec_id` BIGINT COMMENT '',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Build specs must be traceable to their governing APQP plan for production release authorization. APQP gate compliance requires confirming that all build specs are covered by an approved APQP plan. Pro',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Production traceability and recall management require knowing which exact engineering BOM revision was used to build a specific vehicle. Build spec is the physical build record; BOM is its engineering',
    `bom_header_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Each build spec is governed by a specific inspection plan that defines acceptance criteria for that build. Production quality control requires knowing which inspection plan applies to a given build sp',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: build_spec records which production line a vehicle was built on — essential for quality traceability, recall investigations, and line-level defect rate analysis. production_line is a denormalized plai',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: build_spec is the as-built specification record for a specific VIN. It currently stores the VIN as a raw STRING column, which is denormalized. Adding vin_registry_id as a FK to vin_registry.vin_regist',
    `build_date` DATE COMMENT '',
    `build_spec_status` STRING COMMENT '',
    `co2_emissions_g_per_km` STRING COMMENT '',
    `cpo_eligible_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `diagnostic_trouble_code_initial` STRING COMMENT '',
    `emissions_rating` STRING COMMENT '',
    `fleet_spec_flag` BOOLEAN COMMENT '',
    `fuel_efficiency_mpg` DECIMAL(18,2) COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `ncap_rating` STRING COMMENT '',
    `ota_updatable_flag` BOOLEAN COMMENT '',
    `plant_code` STRING COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `safety_feature_codes` STRING COMMENT '',
    `sequence_number` STRING COMMENT '',
    `software_version` STRING COMMENT '',
    `special_order_flag` BOOLEAN COMMENT '',
    `v2x_enabled_flag` BOOLEAN COMMENT '',
    `vehicle_weight_kg` DECIMAL(18,2) COMMENT '',
    `warranty_end_date` DATE COMMENT '',
    `warranty_mileage_limit` STRING COMMENT '',
    `warranty_start_date` DATE COMMENT '',
    CONSTRAINT pk_build_spec PRIMARY KEY(`build_spec_id`)
) COMMENT 'The as-built specification record for a specific VIN, capturing the exact combination of configuration, options, colors, powertrain, and features installed on that vehicle unit as it rolled off the production line. Captures VIN reference, configuration code, exterior color, interior trim selection, all installed option codes, actual build date, plant code, production sequence number, and any deviation from standard specification (e.g., special order, fleet spec, running change). This is the definitive as-built record used by aftersales, warranty, recall population identification, and residual value analytics.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` (
    `msrp_pricing_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `model_id` BIGINT COMMENT '',
    `msrp_price_book_id` BIGINT COMMENT 'Foreign key linking to product.msrp_price_book. Business justification: MSRP pricing records belong to a price book that governs pricing rules for a market/model year. Automotive pricing managers use price books to manage and publish pricing across dealer networks. This l',
    `option_package_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_option_package. Business justification: msrp_pricing stores `option_package_code` as a STRING column, which is a denormalized reference to the vehicle_option_package catalog. MSRP pricing includes pricing for factory-installed option packag',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: msrp_pricing stores `powertrain_type` as a STRING column, which is a denormalized reference to the powertrain catalog. MSRP pricing in automotive is frequently differentiated by powertrain variant (e.',
    `trim_level_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_trim_level. Business justification: msrp_pricing manages the MSRP schedule for vehicle configurations and trim levels. It currently stores `trim_level` as a STRING column, which is denormalized. vehicle_trim_level is the authoritative t',
    `connected_services_price_amount` DECIMAL(18,2) COMMENT 'Price of connected services subscription bundle',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `destination_charge_amount` DECIMAL(18,2) COMMENT '',
    `destination_charge_flag` BOOLEAN COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `ev_tax_credit_amount` DECIMAL(18,2) COMMENT '',
    `ev_tax_credit_eligibility_flag` DECIMAL(18,2) COMMENT '',
    `extended_warranty_price_amount` DECIMAL(18,2) COMMENT 'Price of extended warranty option',
    `gas_guzzler_tax_amount` DECIMAL(18,2) COMMENT '',
    `gas_guzzler_tax_flag` DECIMAL(18,2) COMMENT '',
    `market_country_code` STRING COMMENT '',
    `market_region` STRING COMMENT '',
    `model_year` STRING COMMENT '',
    `msrp_pricing_status` DECIMAL(18,2) COMMENT '',
    `online_price_flag` DECIMAL(18,2) COMMENT '',
    `price_amount` DECIMAL(18,2) COMMENT '',
    `price_key` DECIMAL(18,2) COMMENT '',
    `price_label` DECIMAL(18,2) COMMENT '',
    `price_notes` DECIMAL(18,2) COMMENT '',
    `price_source_system` DECIMAL(18,2) COMMENT '',
    `price_type` DECIMAL(18,2) COMMENT '',
    `price_uplift_amount` DECIMAL(18,2) COMMENT '',
    `price_uplift_reason` DECIMAL(18,2) COMMENT '',
    `price_version` DECIMAL(18,2) COMMENT '',
    `record_audit_created` TIMESTAMP COMMENT '',
    `record_audit_updated` TIMESTAMP COMMENT '',
    CONSTRAINT pk_msrp_pricing PRIMARY KEY(`msrp_pricing_id`)
) COMMENT 'Manages the MSRP (Manufacturer Suggested Retail Price) schedule for vehicle configurations, trim levels, and option packages by market and MY. Captures base MSRP, destination and delivery charge, gas guzzler tax (if applicable), federal EV tax credit eligibility, effective date, expiry date, currency, and market region. Provides the authoritative pricing reference for dealer ordering, window sticker generation, and sales analytics. Distinct from dealer invoice pricing (owned by billing domain).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT '',
    `compound_movement_id` BIGINT COMMENT 'Foreign key linking to logistics.compound_movement. Business justification: Lifecycle events of type compound_arrival, compound_departure, or yard_move directly correspond to a compound_movement record. Yard management and PDI workflow systems require this link to corre',
    `dealership_id` BIGINT COMMENT '',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Field service lifecycle events (warranty repair, recall remedy, roadside assistance) are triggered by or linked to specific defect records. Quality and warranty teams need to trace lifecycle events ba',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Customer journey analytics and service history reporting require knowing which customer party was involved in a lifecycle event (service visit, self-service portal action, recall acknowledgment). life',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall remedy completion is recorded as a vehicle lifecycle event. Service operations log when a specific VIN completed a recall remedy appointment. This link enables recall completion rate tracking p',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Vehicle lifecycle events of type vehicle_shipped or in_transit must reference the specific shipment record for OEM logistics traceability reporting and customer delivery status tracking. A domain ',
    `vehicle_handover_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_handover. Business justification: Lifecycle events of type delivery or customer_handover directly correspond to a vehicle_handover record. This link enables end-to-end delivery traceability, OTD (on-time delivery) reporting, and c',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Lifecycle events such as vehicle sold and vehicle delivered are directly triggered by vehicle_order completion. Linking lifecycle_event to vehicle_order enables end-to-end vehicle lifecycle tracea',
    `vin_registry_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `digital_channel_flag` BOOLEAN COMMENT '',
    `event_category` STRING COMMENT '',
    `event_description` STRING COMMENT '',
    `event_location_city` STRING COMMENT '',
    `event_location_country` STRING COMMENT '',
    `event_location_latitude` DOUBLE COMMENT '',
    `event_location_longitude` DOUBLE COMMENT '',
    `event_location_state` STRING COMMENT '',
    `event_notes` STRING COMMENT '',
    `event_sequence_number` STRING COMMENT '',
    `event_source_module` STRING COMMENT '',
    `event_source_reference` STRING COMMENT '',
    `event_source_system` STRING COMMENT '',
    `event_status` STRING COMMENT '',
    `event_subtype` STRING COMMENT '',
    `event_timestamp` TIMESTAMP COMMENT '',
    `event_type` STRING COMMENT '',
    `is_critical` BOOLEAN COMMENT '',
    `obd_triggered_flag` BOOLEAN COMMENT 'Whether this lifecycle event was triggered by OBD-II diagnostic data',
    `odometer_reading_km` BIGINT COMMENT '',
    `ota_related_flag` BOOLEAN COMMENT 'Whether this lifecycle event is related to an OTA deployment',
    `record_created_timestamp` TIMESTAMP COMMENT '',
    `record_updated_timestamp` TIMESTAMP COMMENT '',
    `self_service_initiated_flag` BOOLEAN COMMENT 'Whether this event was initiated through customer self-service portal',
    `triggering_system` STRING COMMENT '',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Transactional log of significant lifecycle state transitions for a specific VIN throughout its life. Captures event type (manufactured, PDI-completed, shipped-to-dealer, sold-retail, sold-fleet, exported, titled, re-acquired, scrapped, stolen, total-loss), event timestamp, event location, responsible party, odometer reading at event, and triggering system. Provides the complete lifecycle audit trail for a vehicle unit from production to end-of-life, supporting title history, recall tracking, and residual value analytics.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`ownership` (
    `ownership_id` BIGINT COMMENT '',
    `party_id` BIGINT COMMENT '',
    `vehicle_handover_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_handover. Business justification: Ownership transfer is legally initiated by the vehicle handover event. Linking ownership to vehicle_handover enables title/registration audit trails, warranty start date reconciliation, and regulatory',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Vehicle ownership records for new vehicle acquisitions must trace back to the originating vehicle_order for warranty registration, title processing, and OEM customer relationship establishment. This F',
    `vin_registry_id` BIGINT COMMENT '',
    `acquisition_channel` STRING COMMENT '',
    `acquisition_date` DATE COMMENT '',
    `connected_services_active_flag` BOOLEAN COMMENT 'Whether connected vehicle services are active for this ownership',
    `disposition_date` DATE COMMENT '',
    `disposition_reason` STRING COMMENT '',
    `is_current_owner` BOOLEAN COMMENT '',
    `lien_holder` STRING COMMENT '',
    `odometer_at_acquisition` STRING COMMENT '',
    `odometer_at_disposition` STRING COMMENT '',
    `ownership_number` STRING COMMENT '',
    `ownership_type` STRING COMMENT '',
    `self_service_portal_enrolled_flag` BOOLEAN COMMENT 'Whether owner is enrolled in self-service portal',
    `title_state` STRING COMMENT '',
    CONSTRAINT pk_ownership PRIMARY KEY(`ownership_id`)
) COMMENT 'This association product represents the ownership relationship between a vehicle (vin_registry) and a party (customer). It captures acquisition and disposition dates, ownership type, and ownership number, tracking the history of which parties own which vehicles.. Existence Justification: A vehicle can be owned by multiple parties over its lifecycle (e.g., resale), and a party can own multiple vehicles simultaneously. The business actively records each ownership event with dates, type, and ownership number, and users query ownership history for warranty, service, recall, and resale analytics.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` ADD CONSTRAINT `fk_vehicle_vin_registry_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`trim_level` ADD CONSTRAINT `fk_vehicle_trim_level_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ADD CONSTRAINT `fk_vehicle_powertrain_variant_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`option_package` ADD CONSTRAINT `fk_vehicle_option_package_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_option_package_id` FOREIGN KEY (`option_package_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`option_package`(`option_package_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_trim_level_id` FOREIGN KEY (`trim_level_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`trim_level`(`trim_level_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ADD CONSTRAINT `fk_vehicle_ownership_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`vehicle` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`vehicle` SET TAGS ('dbx_domain' = 'vehicle');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Segment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ALTER COLUMN `mes_model_code` SET TAGS ('dbx_business_glossary_term' = 'MES Model Code');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`trim_level` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`trim_level` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`trim_level` ALTER COLUMN `catalog_version_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `catalog_version_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Version Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Trim Level Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`option_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`option_package` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ALTER COLUMN `msrp_price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Msrp Price Book Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ALTER COLUMN `option_package_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Option Package Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ALTER COLUMN `trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Trim Level Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `compound_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Movement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `vehicle_handover_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Handover Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ALTER COLUMN `vehicle_handover_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Handover Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
