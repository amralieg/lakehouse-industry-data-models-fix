-- Schema for Domain: vehicle | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`vehicle` COMMENT 'SSOT for all vehicle master data across the enterprise. Owns VIN-level vehicle identity, model configurations, trim levels, MY (Model Year) lifecycle from SOP (Start of Production) to EOP (End of Production), powertrain variants (ICE, HEV, PHEV, EV), platform architectures, and ADAS feature sets. Serves as the authoritative reference for every downstream domain that needs to identify or describe a vehicle instance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` (
    `vin_registry_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `aftersales_nameplate_id` BIGINT COMMENT '',
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
    `aftersales_nameplate_id` BIGINT COMMENT '',
    `platform_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` (
    `vehicle_model_year_program_id` BIGINT COMMENT '',
    `model_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `eop_date` DATE COMMENT '',
    `launch_date` DATE COMMENT '',
    `market_regions` STRING COMMENT '',
    `model_year` STRING COMMENT '',
    `obd_compliance_standard` STRING COMMENT 'OBD compliance standard for this model year (OBD-II, EOBD, JOBD)',
    `ota_deployment_strategy` STRING COMMENT 'OTA deployment strategy for this model year program',
    `program_code` STRING COMMENT '',
    `program_name` STRING COMMENT '',
    `program_status` STRING COMMENT '',
    `sop_date` DATE COMMENT '',
    `target_volume` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_vehicle_model_year_program PRIMARY KEY(`vehicle_model_year_program_id`)
) COMMENT 'Governs the MY (Model Year) lifecycle for each model, from SOP (Start of Production) through EOP (End of Production). Tracks planned SOP date, actual SOP date, planned EOP date, actual EOP date, regulatory MY designation, CAFE compliance year, homologation status per market, and program phase (concept, development, launch, production, wind-down). Links model to its annual production program and drives downstream planning in manufacturing and supply chain. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` (
    `vehicle_trim_level_id` BIGINT COMMENT '',
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
    CONSTRAINT pk_vehicle_trim_level PRIMARY KEY(`vehicle_trim_level_id`)
) COMMENT 'Defines the ordered hierarchy of trim grades within a model-MY combination (e.g., Base, XL, XLT, Lariat, Platinum, Limited). Captures trim code, trim name, market positioning tier, MSRP base price, standard feature set description, target market region, and active/inactive status. Trim levels are the primary commercial differentiation unit used in sales, dealer ordering, and MSRP pricing. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` (
    `powertrain_variant_id` BIGINT COMMENT '',
    `powertrain_config_id` BIGINT COMMENT '',
    `powertrain_spec_id` BIGINT COMMENT '',
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
    `vehicle_platform` STRING COMMENT '',
    `wltp_fuel_economy_combined_mpg` DECIMAL(18,2) COMMENT '',
    `wltp_range_km` STRING COMMENT '',
    CONSTRAINT pk_powertrain_variant PRIMARY KEY(`powertrain_variant_id`)
) COMMENT 'Authoritative catalog of all powertrain configurations available across the vehicle lineup. Captures powertrain type (ICE, HEV, PHEV, BEV, FCEV), engine displacement, cylinder count, fuel type, electric motor peak power (kW), combined system power, transmission type, drive type, EPA/WLTP fuel economy or range rating, CO2 emissions (g/km), battery capacity (kWh for EV/PHEV), and charging standard (CCS, CHAdeMO, NACS). Used for homologation, CAFE compliance, and consumer-facing specifications.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`platform` (
    `platform_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` (
    `vehicle_adas_feature_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `adas_level` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `diagnostic_pid_codes` STRING COMMENT 'OBD-II PID codes used to diagnose this ADAS feature',
    `effective_date` DATE COMMENT '',
    `feature_code` STRING COMMENT '',
    `feature_name` STRING COMMENT '',
    `is_standard` BOOLEAN COMMENT '',
    `ota_updatable_flag` BOOLEAN COMMENT 'Whether this ADAS feature can be updated via OTA',
    `regulatory_approval_status` STRING COMMENT '',
    `sae_autonomy_level` STRING COMMENT '',
    `sensor_suite` STRING COMMENT '',
    `software_version` STRING COMMENT '',
    CONSTRAINT pk_vehicle_adas_feature PRIMARY KEY(`vehicle_adas_feature_id`)
) COMMENT 'Catalog of all ADAS (Advanced Driver Assistance Systems) and autonomous driving features offered across the vehicle lineup. Captures feature code, feature name, SAE automation level (L0–L5), sensor dependencies (camera, radar, lidar, ultrasonic), regulatory approval status per market, OTA-updatable flag, ECU host system, software version baseline, and availability by trim/market. Supports homologation, NCAP scoring, and connected mobility feature management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`configuration` (
    `configuration_id` BIGINT COMMENT '',
    `aftersales_body_style_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT '',
    `control_plan_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT '',
    `ecu_catalog_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `functional_location_id` BIGINT COMMENT '',
    `model_id` BIGINT COMMENT '',
    `aftersales_nameplate_id` BIGINT COMMENT '',
    `platform_id` BIGINT COMMENT '',
    `powertrain_variant_id` BIGINT COMMENT '',
    `procurement_supplier_id` BIGINT COMMENT '',
    `plant_id` BIGINT COMMENT '',
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
    `trim_level` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vehicle_platform` STRING COMMENT '',
    `warranty_miles` STRING COMMENT '',
    `warranty_years` STRING COMMENT '',
    `wheel_size_inch` STRING COMMENT '',
    CONSTRAINT pk_configuration PRIMARY KEY(`configuration_id`)
) COMMENT 'The fully specified, buildable vehicle configuration combining model, MY, trim, powertrain, and market. Each record represents a unique orderable specification (analogous to a manufacturing SKU or dealer order code). Captures configuration code, market region, build feasibility status, MSRP, destination charge, fuel economy label values, emissions certification status, and production plant assignment. This is the master configuration record that bridges product planning to manufacturing BOM explosion and dealer order management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` (
    `vehicle_option_package_id` BIGINT COMMENT '',
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
    CONSTRAINT pk_vehicle_option_package PRIMARY KEY(`vehicle_option_package_id`)
) COMMENT 'Defines factory-installed option packages, standalone options, exterior colors, and interior trim selections available for vehicle configurations. Captures option code, option name, option type (package, standalone, accessory, exterior color, interior trim), MSRP uplift, content description, availability constraints (trim/market/powertrain restrictions), mutually exclusive options, and required prerequisite options. Drives dealer order configuration, window sticker (Monroney label) generation, and BOM explosion in manufacturing. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` (
    `build_spec_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `bom_header_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
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
    `production_line` STRING COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `safety_feature_codes` STRING COMMENT '',
    `sequence_number` STRING COMMENT '',
    `software_version` STRING COMMENT '',
    `special_order_flag` BOOLEAN COMMENT '',
    `v2x_enabled_flag` BOOLEAN COMMENT '',
    `vehicle_weight_kg` DECIMAL(18,2) COMMENT '',
    `vin` STRING COMMENT '',
    `warranty_end_date` DATE COMMENT '',
    `warranty_mileage_limit` STRING COMMENT '',
    `warranty_start_date` DATE COMMENT '',
    CONSTRAINT pk_build_spec PRIMARY KEY(`build_spec_id`)
) COMMENT 'The as-built specification record for a specific VIN, capturing the exact combination of configuration, options, colors, powertrain, and features installed on that vehicle unit as it rolled off the production line. Captures VIN reference, configuration code, exterior color, interior trim selection, all installed option codes, actual build date, plant code, production sequence number, and any deviation from standard specification (e.g., special order, fleet spec, running change). This is the definitive as-built record used by aftersales, warranty, recall population identification, and residual value analytics.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`homologation` (
    `homologation_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `homologation_requirement_id` BIGINT COMMENT '',
    `homologation_variant_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT '',
    `approval_type` STRING COMMENT '',
    `authority_name` STRING COMMENT '',
    `homologation_category` STRING COMMENT '',
    `certificate_number` STRING COMMENT '',
    `certification_status_date` DATE COMMENT '',
    `compliance_document_url` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `digital_filing_flag` BOOLEAN COMMENT '',
    `effective_from` DATE COMMENT '',
    `effective_until` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_ota_updatable` BOOLEAN COMMENT '',
    `last_inspection_date` DATE COMMENT '',
    `lifecycle_status` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `next_renewal_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `obd_compliance_verified_flag` BOOLEAN COMMENT 'Whether OBD compliance has been verified for this homologation',
    `ota_regulatory_approval_flag` BOOLEAN COMMENT 'Whether OTA updates have regulatory approval under this homologation',
    `record_audit_created` TIMESTAMP COMMENT '',
    `record_audit_updated` TIMESTAMP COMMENT '',
    `regulatory_framework` STRING COMMENT '',
    `regulatory_version` STRING COMMENT '',
    `scope` STRING COMMENT '',
    `vehicle_identification_number` STRING COMMENT '',
    CONSTRAINT pk_homologation PRIMARY KEY(`homologation_id`)
) COMMENT 'Tracks the regulatory type-approval and homologation status of vehicle configurations for each target market. Captures homologation type (whole vehicle type approval, component approval), regulatory framework (FMVSS, ECE, NCAP, CARB, EPA), approval authority, certificate number, approval date, expiry date, applicable model/MY/market, emissions standard tier (e.g., EPA Tier 3, Euro 6d), and compliance status. Critical for market launch readiness and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` (
    `ecu_catalog_id` BIGINT COMMENT '',
    `ecu_specification_id` BIGINT COMMENT '',
    `procurement_supplier_id` BIGINT COMMENT '',
    `applicable_trim_levels` STRING COMMENT '',
    `applicable_vehicle_models` STRING COMMENT '',
    `communication_protocol` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `cybersecurity_certification` STRING COMMENT '',
    `ecu_catalog_description` STRING COMMENT '',
    `ecu_code` STRING COMMENT '',
    `ecu_function` STRING COMMENT '',
    `ecu_name` STRING COMMENT '',
    `end_of_life_date` DATE COMMENT '',
    `functional_safety_asil` STRING COMMENT '',
    `hardware_part_number` STRING COMMENT '',
    `is_deprecated` BOOLEAN COMMENT '',
    `lifecycle_status` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `obd_pid_support_list` STRING COMMENT 'List of OBD-II PIDs supported by this ECU',
    `ota_updatable_flag` BOOLEAN COMMENT '',
    `ota_update_priority` STRING COMMENT 'Priority order for OTA updates (lower = higher priority)',
    `power_consumption_watts` DECIMAL(18,2) COMMENT '',
    `regulatory_approval_date` DATE COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `remote_diagnostic_capable_flag` BOOLEAN COMMENT 'Whether ECU supports remote diagnostic sessions',
    `software_baseline_version` STRING COMMENT '',
    `subscription_feature_enabled` BOOLEAN COMMENT '',
    `supplier_name` STRING COMMENT '',
    `supplier_part_number` STRING COMMENT '',
    `v2x_communication_enabled` BOOLEAN COMMENT '',
    `voltage_volts` DECIMAL(18,2) COMMENT '',
    `warranty_period_months` STRING COMMENT '',
    `weight_kg` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_ecu_catalog PRIMARY KEY(`ecu_catalog_id`)
) COMMENT 'Catalog of all ECU (Electronic Control Unit) and embedded software modules installed across vehicle configurations. Captures ECU code, ECU name, ECU function (engine control, transmission control, ADAS domain controller, body control, infotainment, OBD gateway), supplier, hardware part number, software baseline version, OTA-updatable flag, communication protocol (CAN, LIN, Ethernet, AUTOSAR), and applicable vehicle configurations. Supports OTA update management, cybersecurity compliance, and aftersales diagnostics.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` (
    `msrp_pricing_id` BIGINT COMMENT '',
    `aftersales_option_package_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `model_id` BIGINT COMMENT '',
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
    `option_package_code` STRING COMMENT '',
    `powertrain_type` STRING COMMENT '',
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
    `trim_level` STRING COMMENT '',
    CONSTRAINT pk_msrp_pricing PRIMARY KEY(`msrp_pricing_id`)
) COMMENT 'Manages the MSRP (Manufacturer Suggested Retail Price) schedule for vehicle configurations, trim levels, and option packages by market and MY. Captures base MSRP, destination and delivery charge, gas guzzler tax (if applicable), federal EV tax credit eligibility, effective date, expiry date, currency, and market region. Provides the authoritative pricing reference for dealer ordering, window sticker generation, and sales analytics. Distinct from dealer invoice pricing (owned by billing domain).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT '',
    `dealership_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` (
    `vehicle_emissions_certification_id` BIGINT COMMENT '',
    `configuration_id` BIGINT COMMENT '',
    `certification_date` DATE COMMENT '',
    `certification_number` STRING COMMENT '',
    `certification_standard` STRING COMMENT '',
    `certification_status` STRING COMMENT '',
    `certifying_authority` STRING COMMENT '',
    `co2_emissions_g_per_km` DECIMAL(18,2) COMMENT '',
    `co2_g_per_km` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `emissions_standard` STRING COMMENT '',
    `expiry_date` DATE COMMENT '',
    `market_region` STRING COMMENT '',
    `nox_mg_per_km` DECIMAL(18,2) COMMENT '',
    `obd_readiness_monitors` STRING COMMENT 'OBD readiness monitor status required for emissions certification',
    `ota_recertification_required_flag` BOOLEAN COMMENT 'Whether OTA updates require emissions recertification',
    `particulate_mg_per_km` DECIMAL(18,2) COMMENT '',
    `test_cycle` STRING COMMENT '',
    `test_date` DATE COMMENT '',
    CONSTRAINT pk_vehicle_emissions_certification PRIMARY KEY(`vehicle_emissions_certification_id`)
) COMMENT 'Stores the official emissions test results and certification records for vehicle configurations submitted to regulatory bodies (EPA, CARB, Euro 6, WLTP). Captures test cycle type (FTP-75, HWFET, WLTP, RDE), CO2 g/km, NOx mg/km, PM mg/km, fuel economy (MPG/L/100km), electric range (km for EV/PHEV), combined CAFE contribution value, certification authority, certificate number, test date, and certification status. Directly supports CAFE compliance reporting and homologation.. SSOT: canonical source is compliance.compliance_emissions_certification This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` (
    `vehicle_ota_deployment_id` BIGINT COMMENT '',
    `service_id` BIGINT COMMENT '',
    `aftersales_repair_order_id` BIGINT COMMENT 'FK to repair order if OTA was triggered by service visit',
    `ota_campaign_id` BIGINT COMMENT '',
    `service_campaign_id` BIGINT COMMENT 'FK to service campaign if OTA is part of a campaign',
    `vin_registry_id` BIGINT COMMENT '',
    `consent_given` BOOLEAN COMMENT '',
    `customer_self_service_initiated_flag` BOOLEAN COMMENT 'Whether deployment was initiated via customer self-service portal',
    `deployment_initiated_timestamp` TIMESTAMP COMMENT '',
    `download_complete_timestamp` TIMESTAMP COMMENT '',
    `download_start_timestamp` TIMESTAMP COMMENT '',
    `ecu_target` STRING COMMENT '',
    `error_code` STRING COMMENT '',
    `install_complete_timestamp` TIMESTAMP COMMENT '',
    `install_start_timestamp` TIMESTAMP COMMENT '',
    `obd_dtc_resolved_codes` STRING COMMENT 'DTC codes resolved by this OTA deployment',
    `payload_size_bytes` BIGINT COMMENT '',
    `post_software_version` STRING COMMENT '',
    `pre_software_version` STRING COMMENT '',
    `rollback_flag` BOOLEAN COMMENT '',
    `vehicle_ota_deployment_status` STRING COMMENT '',
    CONSTRAINT pk_vehicle_ota_deployment PRIMARY KEY(`vehicle_ota_deployment_id`)
) COMMENT 'Association product representing the deployment of an OTA campaign to a specific vehicle. Each record captures the operational details of that deployment, linking one vin_registry record to one ota_campaign record.. Existence Justification: Each OTA campaign can be applied to many individual vehicles, and a single vehicle can receive multiple OTA campaigns over its lifecycle. The deployment of a campaign to a vehicle is recorded as a distinct operational event with its own status, timestamps, and version information, which is actively created and managed by the OTA management team.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`ownership` (
    `ownership_id` BIGINT COMMENT '',
    `extended_warranty_provider_id` BIGINT COMMENT 'FK to extended warranty provider if active',
    `party_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` (
    `campaign_enrollment_id` BIGINT COMMENT '',
    `service_campaign_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `digital_notification_flag` BOOLEAN COMMENT '',
    `labor_time_hours` DECIMAL(18,2) COMMENT '',
    `notification_date` DATE COMMENT '',
    `notification_status` STRING COMMENT '',
    `parts_consumed` BIGINT COMMENT '',
    `remedy_completion_date` DATE COMMENT '',
    `scheduled_service_date` DATE COMMENT '',
    `total_labor_cost_usd` DECIMAL(18,2) COMMENT '',
    `total_parts_cost_usd` DECIMAL(18,2) COMMENT '',
    `total_remedy_cost_usd` DECIMAL(18,2) COMMENT '',
    `warranty_covered` BOOLEAN COMMENT '',
    CONSTRAINT pk_campaign_enrollment PRIMARY KEY(`campaign_enrollment_id`)
) COMMENT 'Association representing the enrollment of a vehicle (identified by VIN) into a service campaign. Captures enrollment status, dates, remedy completion, parts and labor costs, and warranty coverage for each vehicle‑campaign pair.. Existence Justification: Vehicles are enrolled in service campaigns; each campaign can affect many vehicles and a single vehicle can participate in multiple campaigns over its lifecycle. The enrollment is actively managed by aftersales operations and carries its own data such as notification dates, status, remedy completion, parts and labor costs, and warranty coverage.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` (
    `regulatory_compliance_assignment_id` BIGINT COMMENT '',
    `model_id` BIGINT COMMENT '',
    `regulatory_requirement_id` BIGINT COMMENT '',
    `assigned_by` STRING COMMENT '',
    `compliance_category` STRING COMMENT '',
    `compliance_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `evidence_reference` STRING COMMENT '',
    `expiration_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `last_assessed_date` DATE COMMENT '',
    `last_review_date` DATE COMMENT '',
    `market_region` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `obd_compliance_category` STRING COMMENT 'OBD compliance category for this regulatory assignment',
    `ota_impact_assessment` STRING COMMENT 'Assessment of OTA update impact on regulatory compliance',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `verification_method` STRING COMMENT '',
    CONSTRAINT pk_regulatory_compliance_assignment PRIMARY KEY(`regulatory_compliance_assignment_id`)
) COMMENT 'This association captures the compliance relationship between a vehicle model and a regulatory requirement. It records the compliance status, the date the requirement became effective for the model, and any notes specific to that pairing.. Existence Justification: Each vehicle model must satisfy multiple regulatory requirements, and each regulatory requirement applies to many vehicle models. The compliance team actively maintains a matrix that records the compliance status, effective dates, and notes for every model‑requirement pair.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_color_option` (
    `aftersales_color_option_id` BIGINT COMMENT 'Primary key',
    `color_code` STRING COMMENT 'Manufacturer color code',
    `color_name` STRING COMMENT 'Display name of the color',
    `color_type` STRING COMMENT 'Type such as solid, metallic, pearl, matte',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `is_active` BOOLEAN COMMENT 'Whether this color option is currently available',
    CONSTRAINT pk_aftersales_color_option PRIMARY KEY(`aftersales_color_option_id`)
) COMMENT 'Color options available for vehicles, moved from aftersales to vehicle domain.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` (
    `aftersales_body_style_id` BIGINT COMMENT 'Unique identifier for the body style definition. Primary key for the body style reference catalog.',
    `aerodynamic_profile` STRING COMMENT 'Classification of the body styles aerodynamic characteristics. Influences fuel economy, NVH performance, and powertrain calibration. Used in CFD analysis and performance modeling.. Valid values are `low_drag|standard|high_profile|utility`',
    `bed_length_inches` DECIMAL(18,2) COMMENT 'Length of the cargo bed for pickup truck body styles, measured in inches. Critical specification for commercial and fleet customers. Null for non-pickup body styles.',
    `bed_type` STRING COMMENT 'Classification of pickup truck bed length category. Used in SKU construction and customer filtering. Set to not_applicable for non-pickup body styles.. Valid values are `short|standard|long|extra_long|not_applicable`',
    `body_structure_type` STRING COMMENT 'Fundamental structural architecture of the vehicle body (unibody vs body-on-frame). Determines manufacturing process, crash performance, NVH characteristics, and platform engineering decisions.. Valid values are `unibody|body_on_frame|space_frame|monocoque`',
    `body_style_category` STRING COMMENT 'High-level body style classification grouping similar configurations. Used for portfolio analysis, market segmentation, and regulatory reporting aggregation. [ENUM-REF-CANDIDATE: sedan|coupe|hatchback|wagon|suv|crossover|pickup|van|convertible|roadster — 10 candidates stripped; promote to reference product]',
    `body_style_code` STRING COMMENT 'Standardized alphanumeric code representing the body style (e.g., 2DR, 4DR, CREW, EXT, SUV3). Used in SKU construction, order management systems, and regulatory homologation documentation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `body_style_description` STRING COMMENT 'Detailed description of the body style including design characteristics, intended use case, and distinguishing features. Supports product marketing and customer education.',
    `body_style_name` STRING COMMENT 'Human-readable name of the body style (e.g., 2-Door Coupe, 4-Door Sedan, Crew Cab Pickup, Extended Cab, SUV 3-Row, Cargo Van). Used in marketing materials, dealer systems, and customer-facing documentation.',
    `body_style_status` STRING COMMENT 'Current lifecycle status of the body style definition. Active indicates current production availability. Used for SKU validation and order management system filtering.. Valid values are `active|discontinued|planned|concept|archived`',
    `cab_configuration` STRING COMMENT 'Pickup truck cab style classification (regular cab, extended cab, crew cab, mega cab). Determines seating capacity and interior space. Set to not_applicable for non-pickup body styles.. Valid values are `regular|extended|crew|mega|not_applicable`',
    `cargo_volume_cubic_feet` DECIMAL(18,2) COMMENT 'Total cargo volume capacity in cubic feet for North American market specifications. Derived from liters but maintained separately for regional marketing and regulatory requirements.',
    `cargo_volume_liters` DECIMAL(18,2) COMMENT 'Total cargo volume capacity in liters measured according to SAE standards. Critical specification for commercial vehicles, SUVs, and vans. Used in competitive analysis and customer decision-making.',
    `competitive_set` STRING COMMENT 'List of primary competitor vehicles that this body style competes against in the market. Used for benchmarking, feature parity analysis, and pricing strategy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this body style record was first created in the system. Used for audit trail and data lineage tracking.',
    `door_count` STRING COMMENT 'Number of passenger doors on the vehicle body style. Critical for regulatory classification, insurance rating, and customer preference filtering. Excludes trunk/hatch/tailgate.',
    `end_model_year` STRING COMMENT 'Final model year this body style was available. Null for current production body styles. Used for EOP planning and service parts forecasting.',
    `generation` STRING COMMENT 'Generation or version identifier for the body style design. Tracks major redesigns and facelifts. Used in parts interchangeability analysis and service documentation.. Valid values are `^[A-Z0-9]{1,6}$`',
    `ground_clearance_category` STRING COMMENT 'Classification of ride height and ground clearance relative to segment norms. Impacts off-road capability, entry/exit ergonomics, and suspension tuning.. Valid values are `low|standard|raised|high`',
    `homologation_class` STRING COMMENT 'Regulatory vehicle classification code used for type approval and homologation processes. Varies by jurisdiction (UNECE, EPA, CARB). Critical for compliance and market entry.',
    `is_commercial_vehicle` BOOLEAN COMMENT 'Indicates whether this body style is classified as a commercial vehicle for regulatory, tax, and fleet sales purposes. Impacts CAFE exemptions and depreciation schedules.',
    `is_light_truck` BOOLEAN COMMENT 'Indicates whether this body style is classified as a light truck for CAFE and EPA emissions standards. Impacts fuel economy requirements and regulatory compliance strategy.',
    `is_passenger_vehicle` BOOLEAN COMMENT 'Indicates whether this body style is classified as a passenger vehicle for regulatory and safety standard purposes. Determines applicable FMVSS requirements.',
    `manufacturing_complexity_score` STRING COMMENT 'Relative complexity rating (1-10 scale) for manufacturing this body style. Considers stamping complexity, welding operations, assembly sequence, and quality control requirements. Used in capacity planning and cost estimation.',
    `market_availability` STRING COMMENT 'Geographic market regions where this body style is available for sale. Supports regional product portfolio management and market-specific homologation tracking. [ENUM-REF-CANDIDATE: global|north_america|europe|asia_pacific|china|latin_america|middle_east|africa — 8 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this body style record. Supports audit requirements and change management tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this body style record was last modified. Used for change tracking and data synchronization across systems.',
    `msrp_base_usd` DECIMAL(18,2) COMMENT 'Base MSRP for this body style in US dollars, excluding options, packages, and destination charges. Used for pricing strategy, competitive analysis, and dealer quoting systems. Confidential business data.',
    `ncap_body_type` STRING COMMENT 'Body type classification used in NCAP safety testing and rating protocols. Determines applicable crash test procedures and rating methodology.',
    `obd_port_location` STRING COMMENT 'Location of the OBD-II port for this body style',
    `platform_code` STRING COMMENT 'Engineering platform identifier that this body style is built upon. Links to platform architecture, shared components, and engineering BOM. Critical for PLM integration and variant management.. Valid values are `^[A-Z0-9]{2,8}$`',
    `roof_type` STRING COMMENT 'Classification of the roof structure and configuration. Impacts aerodynamics, structural engineering, manufacturing complexity, and customer appeal. Critical for BOM planning and option package definition. [ENUM-REF-CANDIDATE: fixed|convertible|targa|t-top|removable_panel|sunroof|panoramic — 7 candidates stripped; promote to reference product]',
    `seating_capacity` STRING COMMENT 'Maximum number of passenger seating positions designed into the body style. Used for regulatory compliance (CAFE standards), safety rating (NCAP), and customer filtering in configurators.',
    `seating_row_count` STRING COMMENT 'Number of seating rows in the body style (e.g., 2-row, 3-row). Important for SUV and crossover segmentation and customer preference analysis.',
    `sku_prefix` STRING COMMENT 'Standard prefix used in SKU construction for vehicles with this body style. Ensures consistent SKU formatting across order management, inventory, and dealer systems.. Valid values are `^[A-Z0-9]{2,6}$`',
    `start_model_year` STRING COMMENT 'First model year this body style was introduced into production. Used for historical analysis, parts supersession, and product lifecycle tracking.',
    `target_customer_segment` STRING COMMENT 'Primary customer demographic or psychographic segment this body style is designed to appeal to. Used in marketing strategy, feature prioritization, and portfolio positioning.',
    `vehicle_segment` STRING COMMENT 'Market segment classification for the body style. Used for competitive benchmarking, CAFE compliance planning, pricing strategy, and portfolio management. Aligns with industry-standard segmentation. [ENUM-REF-CANDIDATE: subcompact|compact|midsize|fullsize|luxury|sports|suv_compact|suv_midsize|suv_fullsize|pickup_compact|pickup_fullsize|van_cargo|van_passenger|commercial — 14 candidates stripped; promote to reference product]',
    `wheelbase_category` STRING COMMENT 'Classification of wheelbase length relative to the nameplate family. Impacts ride quality, cargo capacity, and maneuverability. Used in platform engineering and variant planning.. Valid values are `short|standard|long|extended`',
    `created_by` STRING COMMENT 'User identifier or system account that created this body style record. Supports audit requirements and data stewardship accountability.',
    CONSTRAINT pk_aftersales_body_style PRIMARY KEY(`aftersales_body_style_id`)
) COMMENT 'Reference catalog of commercial body style definitions available across nameplates (e.g., 2-door coupe, 4-door sedan, crew cab pickup, extended cab, SUV 3-row, cargo van). Captures body style code, body style name, door count, seating capacity, cargo volume, roof type, body structure classification (unibody/body-on-frame), and applicable vehicle segment. Used in SKU construction, order management, and regulatory homologation classification.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` (
    `powertrain_config_id` BIGINT COMMENT 'Primary key for powertrain_config',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation time',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `powertrain_config_status` STRING COMMENT 'Current status',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update time',
    CONSTRAINT pk_powertrain_config PRIMARY KEY(`powertrain_config_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` ADD CONSTRAINT `fk_vehicle_vin_registry_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ADD CONSTRAINT `fk_vehicle_model_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` ADD CONSTRAINT `fk_vehicle_vehicle_model_year_program_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` ADD CONSTRAINT `fk_vehicle_vehicle_trim_level_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` ADD CONSTRAINT `fk_vehicle_powertrain_variant_powertrain_config_id` FOREIGN KEY (`powertrain_config_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_config`(`powertrain_config_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` ADD CONSTRAINT `fk_vehicle_vehicle_adas_feature_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_aftersales_body_style_id` FOREIGN KEY (`aftersales_body_style_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`aftersales_body_style`(`aftersales_body_style_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_ecu_catalog_id` FOREIGN KEY (`ecu_catalog_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`ecu_catalog`(`ecu_catalog_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`platform`(`platform_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ADD CONSTRAINT `fk_vehicle_configuration_powertrain_variant_id` FOREIGN KEY (`powertrain_variant_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`powertrain_variant`(`powertrain_variant_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` ADD CONSTRAINT `fk_vehicle_vehicle_option_package_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ADD CONSTRAINT `fk_vehicle_build_spec_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` ADD CONSTRAINT `fk_vehicle_homologation_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` ADD CONSTRAINT `fk_vehicle_msrp_pricing_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ADD CONSTRAINT `fk_vehicle_lifecycle_event_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` ADD CONSTRAINT `fk_vehicle_vehicle_emissions_certification_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`configuration`(`configuration_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` ADD CONSTRAINT `fk_vehicle_vehicle_ota_deployment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` ADD CONSTRAINT `fk_vehicle_ownership_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` ADD CONSTRAINT `fk_vehicle_campaign_enrollment_vin_registry_id` FOREIGN KEY (`vin_registry_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`vin_registry`(`vin_registry_id`);
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` ADD CONSTRAINT `fk_vehicle_regulatory_compliance_assignment_model_id` FOREIGN KEY (`model_id`) REFERENCES `vibe_automotive_v1`.`vehicle`.`model`(`model_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`vehicle` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`vehicle` SET TAGS ('dbx_domain' = 'vehicle');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vin_registry` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_platform' = 'Databricks');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_deliverables' = 'DDL schemas; metric views; sample data; DBML diagrams; RDF ontologies');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_metric_view_counts' = 'ECM=101/MVM=128');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_system_of_record' = 'PLM/CAD');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` SET TAGS ('dbx_review_status' = 'verified_coverage');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`model` ALTER COLUMN `mes_model_code` SET TAGS ('dbx_business_glossary_term' = 'MES Model Code');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_ssot_owner' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_trim_level` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_variant` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_platform' = 'Databricks');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_deliverables' = 'DDL schemas; metric views; sample data; DBML diagrams; RDF ontologies');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_metric_view_counts' = 'ECM=101/MVM=128');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`platform` SET TAGS ('dbx_commodity_exposure_tracked' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_ssot_owner' = 'product');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_ssot_concept' = 'option_package');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_option_package` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`build_spec` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`homologation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ecu_catalog` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`msrp_pricing` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_ssot_owner' = 'compliance');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_ssot_concept' = 'emissions_certification');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_ssot_reference' = 'compliance.compliance_emissions_certification');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_subdomain' = 'campaign_deployment');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_association_edges' = 'vehicle.vin_registry,mobility.ota_campaign');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_association_edges' = 'vehicle.vin_registry,customer.party');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`ownership` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_subdomain' = 'campaign_deployment');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_association_edges' = 'vehicle.vin_registry,aftersales.service_campaign');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`campaign_enrollment` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_association_edges' = 'vehicle.model,compliance.regulatory_requirement');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_system_of_record' = 'Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_SAP_CRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_color_option` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_color_option` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` SET TAGS ('dbx_subdomain' = 'vehicle_identity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` SET TAGS ('dbx_source_system' = 'DMS');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` SET TAGS ('dbx_SAP_CS' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `aftersales_body_style_id` SET TAGS ('dbx_business_glossary_term' = 'Body Style Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `aerodynamic_profile` SET TAGS ('dbx_business_glossary_term' = 'Aerodynamic Profile Classification');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `aerodynamic_profile` SET TAGS ('dbx_value_regex' = 'low_drag|standard|high_profile|utility');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `bed_length_inches` SET TAGS ('dbx_business_glossary_term' = 'Bed Length in Inches');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `bed_type` SET TAGS ('dbx_value_regex' = 'short|standard|long|extra_long|not_applicable');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Body Structure Type');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_structure_type` SET TAGS ('dbx_value_regex' = 'unibody|body_on_frame|space_frame|monocoque');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_category` SET TAGS ('dbx_business_glossary_term' = 'Body Style Category');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_code` SET TAGS ('dbx_business_glossary_term' = 'Body Style Code');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_description` SET TAGS ('dbx_business_glossary_term' = 'Body Style Description');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_name` SET TAGS ('dbx_business_glossary_term' = 'Body Style Name');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_status` SET TAGS ('dbx_business_glossary_term' = 'Body Style Status');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `body_style_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|planned|concept|archived');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `cab_configuration` SET TAGS ('dbx_business_glossary_term' = 'Cab Configuration');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `cab_configuration` SET TAGS ('dbx_value_regex' = 'regular|extended|crew|mega|not_applicable');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `cargo_volume_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume in Cubic Feet');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `cargo_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Cargo Volume in Liters');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `competitive_set` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `door_count` SET TAGS ('dbx_business_glossary_term' = 'Door Count');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `end_model_year` SET TAGS ('dbx_business_glossary_term' = 'End Model Year (MY)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `generation` SET TAGS ('dbx_business_glossary_term' = 'Body Style Generation Code');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `generation` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `ground_clearance_category` SET TAGS ('dbx_business_glossary_term' = 'Ground Clearance Category');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `ground_clearance_category` SET TAGS ('dbx_value_regex' = 'low|standard|raised|high');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `homologation_class` SET TAGS ('dbx_business_glossary_term' = 'Homologation Class');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `is_commercial_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Is Commercial Vehicle Flag');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `is_light_truck` SET TAGS ('dbx_business_glossary_term' = 'Is Light Truck Flag');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `is_passenger_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Is Passenger Vehicle Flag');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `manufacturing_complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Complexity Score');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `market_availability` SET TAGS ('dbx_business_glossary_term' = 'Market Availability Region');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `msrp_base_usd` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Base in United States Dollars (USD)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `msrp_base_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `ncap_body_type` SET TAGS ('dbx_business_glossary_term' = 'New Car Assessment Programme (NCAP) Body Type');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `obd_port_location` SET TAGS ('dbx_business_glossary_term' = 'OBD Port Location');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `platform_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `roof_type` SET TAGS ('dbx_business_glossary_term' = 'Roof Type');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `seating_row_count` SET TAGS ('dbx_business_glossary_term' = 'Seating Row Count');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `sku_prefix` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Prefix');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `sku_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `start_model_year` SET TAGS ('dbx_business_glossary_term' = 'Start Model Year (MY)');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `vehicle_segment` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Segment');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `wheelbase_category` SET TAGS ('dbx_business_glossary_term' = 'Wheelbase Category');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `wheelbase_category` SET TAGS ('dbx_value_regex' = 'short|standard|long|extended');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`aftersales_body_style` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` SET TAGS ('dbx_subdomain' = 'configuration_catalog');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` SET TAGS ('dbx_source_system' = 'DMS');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` SET TAGS ('dbx_SAP_CS' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` SET TAGS ('dbx_ssot_resolved' = 'true');
ALTER TABLE `vibe_automotive_v1`.`vehicle`.`powertrain_config` ALTER COLUMN `powertrain_config_id` SET TAGS ('dbx_business_glossary_term' = 'powertrain_config Identifier');
