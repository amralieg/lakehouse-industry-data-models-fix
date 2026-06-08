-- Schema for Domain: energy | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`energy` COMMENT 'Waste-to-Energy (WTE) facility operations converting MSW to electricity or steam. Manages combustion processes, energy generation output (MWh), emissions monitoring (CAA compliance), ash residue handling, boiler operations, turbine performance, and renewable energy credits (RECs). Includes landfill gas-to-energy (LFG-to-RNG) projects, SRF (Solid Recovered Fuel) production, and sustainability metrics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`wte_facility` (
    `wte_facility_id` BIGINT COMMENT 'Unique identifier for the Waste-to-Energy facility. Primary key and system of record identifier for WTE facility master data.',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: WTE facilities handling waste must register with EPA and obtain RCRA identification numbers for hazardous waste management compliance. Links energy facility to hazmat regulatory registration system. R',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: WTE facilities operate under primary environmental permits (air, waste, operating). Links facility to its governing permit for compliance tracking, renewal management, and regulatory reporting. Essent',
    `address_line_1` STRING COMMENT 'Primary street address of the WTE facility physical location. Used for regulatory filings, emergency response, and logistics coordination.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, suite, or complex identifier for the WTE facility.',
    `air_pollution_control_technology` STRING COMMENT 'Description of emissions control systems installed to meet Clean Air Act standards. Typically includes electrostatic precipitators, scrubbers, baghouses, selective catalytic reduction, and activated carbon injection. [ENUM-REF-CANDIDATE: esp|wet_scrubber|dry_scrubber|baghouse|scr|sncr|carbon_injection — promote to reference product]',
    `annual_operating_hours` STRING COMMENT 'Typical number of operating hours per year under normal conditions. Used for capacity factor calculations and maintenance planning. Maximum 8,760 hours (24x365).',
    `ash_residue_handling_method` STRING COMMENT 'Primary method for managing bottom ash and fly ash residue from combustion process. Landfill disposal is most common; beneficial reuse includes aggregate substitution; treatment/stabilization reduces leachability.. Valid values are `landfill_disposal|beneficial_reuse|offsite_treatment|onsite_stabilization`',
    `boiler_count` STRING COMMENT 'Number of waste combustion boilers or thermal conversion units at the facility. Relevant for capacity redundancy and maintenance scheduling.',
    `city` STRING COMMENT 'City or municipality where the WTE facility is located. Used for local regulatory jurisdiction determination and service area mapping.',
    `commissioning_date` DATE COMMENT 'Date when the WTE facility began commercial operations and started accepting waste for energy conversion. Marks the start of operational lifecycle.',
    `continuous_emissions_monitoring` BOOLEAN COMMENT 'Indicates whether the facility has continuous emissions monitoring systems installed for real-time tracking of air pollutants. Required for Title V major sources.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the WTE facility location. Determines national regulatory framework and reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system. Used for data lineage and audit trail purposes.',
    `decommissioning_date` DATE COMMENT 'Date when the WTE facility permanently ceased operations. Triggers closure and post-closure regulatory obligations.',
    `emergency_contact_phone` STRING COMMENT 'Primary emergency contact telephone number for the WTE facility. Used by first responders, regulatory agencies, and emergency management coordinators.',
    `energy_output_type` STRING COMMENT 'Primary form of energy produced by the facility. Electricity for grid export; steam for industrial/district heating; CHP for both; RNG for pipeline-quality biomethane from LFG or anaerobic digestion.. Valid values are `electricity|steam|combined_heat_power|renewable_natural_gas`',
    `environmental_compliance_officer` STRING COMMENT 'Name of the designated environmental compliance officer responsible for regulatory adherence and permit compliance at the facility.',
    `facility_code` STRING COMMENT 'Externally-known unique business identifier for the WTE facility. Used in operational systems, regulatory filings, and inter-system communication.. Valid values are `^WTE-[A-Z0-9]{6,12}$`',
    `facility_name` STRING COMMENT 'Official business name of the Waste-to-Energy facility as registered with regulatory authorities and used in public communications.',
    `facility_type` STRING COMMENT 'Primary technology classification for waste-to-energy conversion process. Mass-burn combusts unsorted MSW; RDF uses preprocessed fuel; gasification/pyrolysis are thermal conversion; anaerobic digestion produces biogas; LFG-to-energy captures landfill methane.. Valid values are `mass_burn|refuse_derived_fuel|gasification|pyrolysis|anaerobic_digestion|landfill_gas_to_energy`',
    `ghg_reporting_required` BOOLEAN COMMENT 'Indicates whether the facility is subject to EPA Greenhouse Gas Reporting Program (GHGRP) due to emissions exceeding 25,000 metric tons CO2e annually.',
    `grid_interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts at which the facility connects to the electrical grid. Determines transmission infrastructure requirements and interconnection agreements.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility has achieved ISO 14001 certification for environmental management systems. Demonstrates commitment to systematic environmental performance improvement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was most recently updated. Used for change tracking and data quality monitoring.',
    `last_permit_renewal_date` DATE COMMENT 'Date of the most recent environmental permit renewal or modification. Used to track permit compliance cycles and upcoming renewal deadlines.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the WTE facility in decimal degrees. Used for GIS mapping, proximity analysis, and emergency response coordination.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the WTE facility in decimal degrees. Used for GIS mapping, proximity analysis, and emergency response coordination.',
    `nameplate_electrical_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical power generation capacity in megawatts under optimal operating conditions. Used for grid interconnection agreements and renewable energy credit calculations.',
    `next_permit_expiration_date` DATE COMMENT 'Date when current environmental permits expire and require renewal. Critical for compliance planning and operational continuity.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the WTE facility. Operational indicates active energy generation; standby is ready but not producing; maintenance is temporary shutdown; decommissioned is permanently closed.. Valid values are `operational|standby|maintenance|decommissioned|under_construction|permitted_not_built`',
    `permitted_capacity_tpd` DECIMAL(18,2) COMMENT 'Maximum daily waste processing capacity in tons per day as authorized by environmental permits. Regulatory limit for waste intake volume.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the WTE facility location. Used for geographic analysis and service territory mapping.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `power_purchase_agreement_active` BOOLEAN COMMENT 'Indicates whether the facility operates under an active power purchase agreement with a utility or off-taker for electricity sales.',
    `rec_eligible` BOOLEAN COMMENT 'Indicates whether the facility qualifies for renewable energy credits under state or federal renewable portfolio standards. True if eligible for REC generation.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority governing the WTE facility. Federal for EPA-direct oversight; state for delegated programs; local for municipal authority; tribal for sovereign nation lands.. Valid values are `federal|state|local|tribal`',
    `state_province` STRING COMMENT 'Two-letter state or province code where the WTE facility is located. Determines state-level environmental regulations and reporting requirements.. Valid values are `^[A-Z]{2}$`',
    `steam_output_capacity_klb_per_hr` DECIMAL(18,2) COMMENT 'Maximum steam production capacity in thousand pounds per hour for facilities producing process steam or district heating. Relevant for combined heat and power (CHP) operations.',
    `turbine_generator_count` STRING COMMENT 'Number of steam turbine generators installed for electricity production. Relevant for power generation capacity and reliability analysis.',
    `waste_feedstock_types` STRING COMMENT 'Types of waste materials accepted as fuel for energy conversion. Common types include MSW, C&D, SRF, biosolids, medical waste, industrial waste. Comma-separated list.',
    CONSTRAINT pk_wte_facility PRIMARY KEY(`wte_facility_id`)
) COMMENT 'Master record for each Waste-to-Energy (WTE) facility operated by Waste Management. Captures facility identity, physical location, permitted capacity (TPD), technology type (mass-burn, RDF, gasification), operational status, EPA air permit number, state permit references, nameplate electrical capacity (MW), steam output capacity (klb/hr), commissioning date, and regulatory jurisdiction. SSOT for WTE facility identity across the energy domain.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`boiler_unit` (
    `boiler_unit_id` BIGINT COMMENT 'Unique identifier for the combustion boiler unit within the WTE facility. Primary key for the boiler unit master record.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Each boiler unit is a discrete emission source for GHG inventory and air quality compliance. EPA requires unit-level emission tracking for Part 75 and GHGRP reporting. Links combustion equipment to su',
    `facility_id` BIGINT COMMENT 'Reference to the WTE facility where this boiler unit is installed. Links to the facility master record.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Boilers are major capital assets requiring depreciation tracking, insurance valuation, warranty management, and maintenance scheduling in EAM systems. Financial reporting and capital project cost allo',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'Original purchase and installation cost of the boiler unit in US dollars. Used for capitalization, depreciation calculations, and ROI analysis. Confidential financial data.',
    `annual_operating_hours` DECIMAL(18,2) COMMENT 'Total operating hours per year for the boiler unit. Used for capacity factor calculations, maintenance scheduling, and regulatory reporting. Typical WTE facilities operate 8000+ hours annually.',
    `ash_handling_system` STRING COMMENT 'Type of ash removal and handling system. Wet systems use water sluicing, dry systems use conveyors, pneumatic uses air transport, mechanical uses augers or drag chains. Impacts residue management and disposal.. Valid values are `wet|dry|pneumatic|mechanical`',
    `asset_tag` STRING COMMENT 'Internal asset management tag or barcode identifier for the boiler unit. Used for fixed asset tracking, depreciation, and physical inventory audits.',
    `availability_status` STRING COMMENT 'Current availability status for dispatch and operations. Available means ready for full operation, unavailable means offline, limited means operating at reduced capacity, testing means undergoing performance or compliance testing.. Valid values are `available|unavailable|limited|testing`',
    `boiler_efficiency_percent` DECIMAL(18,2) COMMENT 'Thermal efficiency of the boiler unit expressed as a percentage. Calculated as energy output (steam) divided by energy input (waste fuel). Monitored for performance optimization and sustainability reporting.',
    `boiler_type` STRING COMMENT 'Classification of the boiler combustion technology. Mass burn processes unsorted MSW, RDF uses preprocessed fuel, modular is smaller capacity, fluidized bed uses sand bed, stoker uses mechanical grates.. Valid values are `mass_burn|refuse_derived_fuel|modular|fluidized_bed|stoker`',
    `combustion_control_system` STRING COMMENT 'Type or model of the automated combustion control system (e.g., DCS, PLC) used to optimize air-fuel ratio, temperature, and emissions. Critical for EPA compliance and efficiency.',
    `commissioning_date` DATE COMMENT 'Date when the boiler unit was officially placed into commercial operation after successful testing and acceptance. Marks the start of warranty and operational life.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this boiler unit record was first created in the system. Used for data lineage and audit trail purposes.',
    `cumulative_operating_hours` DECIMAL(18,2) COMMENT 'Total lifetime operating hours since commissioning. Critical for predictive maintenance, remaining useful life estimation, and major overhaul planning.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the boiler unit asset. Straight line spreads cost evenly, declining balance accelerates early depreciation, units of production bases on usage.. Valid values are `straight_line|declining_balance|units_of_production`',
    `design_capacity_tpd` DECIMAL(18,2) COMMENT 'Rated design capacity of the boiler unit measured in tons per day (TPD) of Municipal Solid Waste (MSW) that can be processed. Key metric for facility throughput planning.',
    `emissions_control_technology` STRING COMMENT 'Description of the air pollution control equipment installed (e.g., electrostatic precipitator, baghouse, scrubber, selective catalytic reduction). Required for CAA compliance reporting.',
    `grate_type` STRING COMMENT 'Type of mechanical grate system used for waste combustion. Reciprocating grates move back and forth, roller grates use rotating cylinders, vibrating grates shake waste, traveling grates move continuously.. Valid values are `reciprocating|roller|vibrating|traveling|stationary`',
    `greenhouse_gas_reporting_required` BOOLEAN COMMENT 'Indicates whether the boiler unit is subject to EPA Greenhouse Gas Reporting Program (GHGRP) requirements. Facilities emitting 25,000+ metric tons CO2e annually must report.',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Heat rate of the boiler-turbine system measured in BTU per kilowatt-hour. Lower values indicate higher efficiency. Key metric for energy conversion performance and benchmarking.',
    `installation_date` DATE COMMENT 'Date when the boiler unit was originally installed and commissioned at the facility. Used for age-based maintenance planning and depreciation calculations.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the boiler and machinery insurance coverage. Covers equipment breakdown, business interruption, and liability. Confidential business information.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or insurance inspection of the boiler unit. ASME and state boiler inspections are typically required annually or biennially.',
    `last_major_overhaul_date` DATE COMMENT 'Date of the most recent major overhaul or refurbishment of the boiler unit. Major overhauls typically include refractory replacement, tube bundle replacement, and grate system rebuild.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this boiler unit record was most recently updated. Tracks data currency and supports change auditing for regulatory compliance.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the boiler unit (e.g., Babcock & Wilcox, Covanta, Martin GmbH).',
    `maximum_continuous_rating_mw` DECIMAL(18,2) COMMENT 'Maximum continuous electrical output capacity in megawatts (MW) when the boiler operates at full design capacity. Used for grid interconnection and revenue calculations.',
    `model` STRING COMMENT 'Manufacturer model designation for the boiler unit. Used for parts procurement and technical documentation reference.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required regulatory or insurance inspection. Missing inspection deadlines can result in operating permit violations and forced shutdowns.',
    `next_scheduled_overhaul_date` DATE COMMENT 'Planned date for the next major overhaul based on manufacturer recommendations, operating hours, and regulatory inspection requirements.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or historical information about the boiler unit. Used for knowledge transfer and operational context.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating steam pressure of the boiler measured in pounds per square inch (psi). Critical safety and performance parameter monitored continuously.',
    `operating_temperature_f` DECIMAL(18,2) COMMENT 'Normal operating steam temperature of the boiler measured in degrees Fahrenheit. Monitored for efficiency and safety compliance.',
    `operational_status` STRING COMMENT 'Current operational state of the boiler unit. Operational means actively processing waste, standby is ready but not running, maintenance is planned downtime, outage is unplanned downtime, decommissioned is permanently retired, startup is initial commissioning phase.. Valid values are `operational|standby|maintenance|outage|decommissioned|startup`',
    `permit_expiration_date` DATE COMMENT 'Expiration date of the current air quality operating permit. Facilities must renew permits before expiration to maintain legal operation.',
    `permit_number` STRING COMMENT 'EPA or state-issued air quality operating permit number for the boiler unit. Required for CAA Title V compliance and emissions monitoring reporting.',
    `renewable_energy_credit_eligible` BOOLEAN COMMENT 'Indicates whether the boiler unit qualifies for Renewable Energy Credits (RECs) under state or federal renewable portfolio standards. Eligibility depends on fuel source classification and technology type.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the boiler unit. Unique identifier for warranty, service history, and regulatory tracking.',
    `steam_generation_rate_klb_per_hr` DECIMAL(18,2) COMMENT 'Rated steam generation capacity of the boiler measured in thousand pounds per hour (klb/hr). Critical for energy output calculations and turbine sizing.',
    `unit_number` STRING COMMENT 'Business identifier for the boiler unit, typically assigned by the facility (e.g., Boiler-1, Unit-A). Used for operational communication and work orders.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the boiler unit in years for depreciation and capital planning purposes. Typical WTE boilers have 25-30 year useful lives with major overhauls.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage expires. After expiration, all maintenance and repair costs are borne by the facility owner.',
    CONSTRAINT pk_boiler_unit PRIMARY KEY(`boiler_unit_id`)
) COMMENT 'Master record for each combustion boiler unit within a WTE facility. Tracks boiler unit number, manufacturer, model, design capacity (TPD MSW), steam generation rate (klb/hr), operating pressure (psi), operating temperature (°F), grate type (reciprocating, roller, vibrating), installation date, last major overhaul date, current operational status, and associated facility. Supports boiler performance trending and maintenance planning.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`turbine_generator` (
    `turbine_generator_id` BIGINT COMMENT 'Unique identifier for the turbine-generator set. Primary key for this master resource entity.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Turbine generators require air quality permits for emissions and grid interconnection permits. Links generator to air permit for emissions monitoring, permit compliance verification, and regulatory in',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Turbine generators are driven by steam from specific boiler units. This is a fundamental operational relationship in WTE facilities - each turbine receives steam from a specific boiler. The FK establi',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Turbine generators are high-value capital equipment requiring fixed asset tracking for depreciation calculations, insurance coverage, asset retirement planning, and capital expenditure reporting. Esse',
    `facility_id` BIGINT COMMENT 'Reference to the WTE (Waste-to-Energy) or LFG-to-energy facility where this turbine-generator set is installed.',
    `annual_operating_hours_target` STRING COMMENT 'Target number of operating hours per year for this turbine-generator set, used for capacity planning and performance benchmarking.',
    `asset_tag` STRING COMMENT 'Externally-known unique asset identification tag assigned to this turbine-generator set for tracking and maintenance purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `commissioning_date` DATE COMMENT 'Date when the turbine-generator set successfully completed commissioning tests and was placed into commercial operation.',
    `cooling_system_type` STRING COMMENT 'Type of cooling system used for the generator windings and bearings (air-cooled, water-cooled, hydrogen-cooled, or hybrid).. Valid values are `air_cooled|water_cooled|hydrogen_cooled|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbine-generator record was first created in the system.',
    `cumulative_operating_hours` BIGINT COMMENT 'Total accumulated operating hours since commissioning, used to track equipment lifecycle and schedule maintenance intervals.',
    `decommissioning_date` DATE COMMENT 'Date when the turbine-generator set was permanently taken out of service and decommissioned. Null if still in service.',
    `emissions_monitoring_required` BOOLEAN COMMENT 'Indicates whether this turbine-generator is subject to continuous emissions monitoring system (CEMS) requirements under EPA regulations.',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Electrical frequency of the generator output in hertz (Hz). Standard values are 60 Hz in North America and 50 Hz in most other regions.',
    `fuel_source_type` STRING COMMENT 'Primary fuel source driving this turbine-generator: MSW (Municipal Solid Waste) combustion, LFG (Landfill Gas), biogas, SRF (Solid Recovered Fuel), RNG (Renewable Natural Gas), or mixed sources.. Valid values are `msw|lfg|biogas|srf|rng|mixed`',
    `generator_voltage_kv` DECIMAL(18,2) COMMENT 'Rated output voltage of the generator in kilovolts (kV), typically the voltage at which power is delivered to the step-up transformer or grid interconnection point.',
    `grid_interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level at which this turbine-generator interconnects to the utility grid after step-up transformation, measured in kilovolts (kV).',
    `installation_date` DATE COMMENT 'Date when the turbine-generator set was originally installed and commissioned at the facility.',
    `interconnection_agreement_reference` STRING COMMENT 'Reference number or identifier for the utility interconnection agreement governing the connection of this generator to the electrical grid.',
    `last_major_inspection_date` DATE COMMENT 'Date of the most recent major inspection or overhaul of the turbine-generator set, typically involving disassembly and detailed component examination.',
    `maintenance_contract_reference` STRING COMMENT 'Reference number for the long-term service agreement (LTSA) or maintenance contract covering this turbine-generator set.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the turbine-generator set (e.g., General Electric, Siemens, Mitsubishi).',
    `model_number` STRING COMMENT 'Manufacturers model designation for this turbine-generator set, used for parts procurement and technical specifications.',
    `next_scheduled_inspection_date` DATE COMMENT 'Planned date for the next major inspection or overhaul based on manufacturer recommendations and operational hours.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special configurations, or historical information about this turbine-generator set.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the turbine-generator set indicating whether it is actively generating power, on standby, undergoing maintenance, or decommissioned.. Valid values are `operational|standby|maintenance|decommissioned|under_construction|testing`',
    `power_factor` DECIMAL(18,2) COMMENT 'Rated power factor of the generator, representing the ratio of real power to apparent power. Typically expressed as a decimal between 0 and 1 (e.g., 0.85 or 0.90).',
    `rated_capacity_mw` DECIMAL(18,2) COMMENT 'Nameplate electrical generation capacity of the turbine-generator set measured in megawatts (MW). This is the maximum continuous power output under design conditions.',
    `rec_tracking_system_code` STRING COMMENT 'Identifier for this generator in the regional REC tracking system (e.g., M-RETS, WREGIS, PJM-GATS) used to issue and track renewable energy credits.',
    `renewable_energy_credit_eligible` BOOLEAN COMMENT 'Indicates whether electricity generated by this turbine-generator set qualifies for Renewable Energy Credits (RECs) under applicable state or federal renewable energy programs.',
    `scada_system_tag` STRING COMMENT 'Tag identifier used in the facilitys SCADA system to monitor and control this turbine-generator set in real-time.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific turbine-generator unit.',
    `steam_inlet_pressure_psi` DECIMAL(18,2) COMMENT 'Design steam inlet pressure at the turbine inlet in pounds per square inch (PSI). Applicable to steam turbines in WTE facilities.',
    `steam_inlet_temperature_f` DECIMAL(18,2) COMMENT 'Design steam inlet temperature at the turbine inlet in degrees Fahrenheit. Applicable to steam turbines in WTE facilities.',
    `turbine_efficiency_percent` DECIMAL(18,2) COMMENT 'Design thermal efficiency of the turbine expressed as a percentage, representing the ratio of electrical output to thermal input energy.',
    `turbine_type` STRING COMMENT 'Classification of the turbine technology used in this generator set. Steam turbines are common in WTE facilities; gas turbines and biogas turbines are used in LFG-to-energy projects.. Valid values are `steam|gas|combined_cycle|landfill_gas|biogas|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbine-generator record was last modified in the system.',
    `utility_offtake_meter_number` STRING COMMENT 'Identifier for the revenue-grade meter that measures electrical energy delivered from this turbine-generator to the utility grid or internal distribution system.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage for this turbine-generator set expires.',
    CONSTRAINT pk_turbine_generator PRIMARY KEY(`turbine_generator_id`)
) COMMENT 'Master record for each steam turbine-generator set at a WTE or LFG-to-energy facility. Captures turbine manufacturer, model, rated capacity (MW), generator voltage (kV), power factor, installation date, last major inspection date, operational status, interconnection agreement reference, and utility offtake meter point ID. Enables turbine performance benchmarking and capacity reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` (
    `lfg_collection_system_id` BIGINT COMMENT 'Unique identifier for the landfill gas collection and control system (GCCS). Primary key for the LFG collection system master record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: LFG collection systems often operate under gas rights agreements with landfill owners or third-party energy developers. These contracts govern gas extraction rights, revenue sharing, and beneficial us',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: LFG collection systems are both fugitive emission sources (uncaptured methane) and emission reduction assets (captured methane avoids atmospheric release). Required for EPA Subpart HH reporting and ca',
    `capital_project_id` BIGINT COMMENT 'Reference to the associated waste-to-energy or LFG-to-energy project that utilizes gas from this collection system. Null if gas is flared only.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: LFG collection systems are major capital installations (wells, headers, blowers) requiring asset tracking for depreciation, capital cost allocation, and lifecycle management. Financial reporting and c',
    `site_id` BIGINT COMMENT 'Reference to the landfill site where this LFG collection system is installed. Links to the facility master record.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: LFG collection systems operate under NSPS Subpart WWW permits (explicitly referenced in attributes). Links system to permit for NSPS compliance tracking, permit condition monitoring, and regulatory re',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Estimated annual operating and maintenance cost in USD for the LFG collection system, including electricity, labor, and parts.',
    `beneficial_use_flag` BOOLEAN COMMENT 'Indicates whether the collected LFG is used for beneficial purposes such as electricity generation, renewable natural gas production, or direct thermal use (True) or is flared for destruction only (False).',
    `beneficial_use_type` STRING COMMENT 'Classification of how collected LFG is utilized: conversion to electricity (LFG-to-electricity), processing to renewable natural gas (LFG-to-RNG), direct thermal use, medium-BTU gas production, or flare-only destruction.. Valid values are `lfg_to_electricity|lfg_to_rng|direct_thermal|medium_btu|flare_only`',
    `blower_station_count` STRING COMMENT 'Number of blower stations that create negative pressure to extract landfill gas from the collection wells.',
    `capital_cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure in USD for the design, procurement, and installation of the LFG collection system.',
    `collection_area_acres` DECIMAL(18,2) COMMENT 'Total landfill area in acres covered by this LFG collection system. Used for system coverage and efficiency analysis.',
    `collection_efficiency_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of generated landfill gas that is captured by the collection system. Typical range is 75-95% for well-designed active systems.',
    `commissioning_date` DATE COMMENT 'Date when the LFG collection system was officially commissioned and began operational gas extraction.',
    `compliance_status` STRING COMMENT 'Current compliance status of the LFG collection system with EPA NSPS Subpart WWW and state/local air quality regulations.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LFG collection system record was first created in the system.',
    `decommissioning_date` DATE COMMENT 'Date when the LFG collection system was permanently decommissioned and removed from service. Null for active systems.',
    `design_engineer` STRING COMMENT 'Name of the engineering firm or professional engineer responsible for the system design and specifications.',
    `design_flow_capacity_scfm` DECIMAL(18,2) COMMENT 'Maximum design flow capacity of the LFG collection system measured in standard cubic feet per minute (scfm). Represents the engineered extraction capacity.',
    `estimated_methane_generation_rate_scfm` DECIMAL(18,2) COMMENT 'Estimated methane generation rate from the waste mass in the collection area, measured in standard cubic feet per minute. Based on EPA LandGEM or similar modeling.',
    `flare_station_count` STRING COMMENT 'Number of flare stations used to combust collected LFG when beneficial use is not available or during maintenance periods.',
    `header_pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Primary diameter of the header piping system in inches. Larger diameters support higher flow capacity.',
    `header_pipe_length_feet` DECIMAL(18,2) COMMENT 'Total length of header piping in feet that conveys collected gas from extraction wells to the blower or flare station.',
    `horizontal_well_count` STRING COMMENT 'Number of horizontal extraction wells in the collection system. Horizontal wells are typically installed during active filling operations.',
    `installation_date` DATE COMMENT 'Date when the LFG collection system was originally installed and commissioned at the landfill site.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or operational inspection of the LFG collection system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LFG collection system record was last updated or modified.',
    `monitoring_frequency_days` STRING COMMENT 'Required frequency in days for routine monitoring of the LFG collection system per regulatory requirements. Typically quarterly (90 days) or monthly (30 days).',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the LFG collection system based on regulatory monitoring frequency.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or historical information about the LFG collection system.',
    `operational_status` STRING COMMENT 'Current operational state of the LFG collection system in its lifecycle. Determines whether the system is actively collecting gas.. Valid values are `operational|startup|maintenance|shutdown|decommissioned`',
    `system_code` STRING COMMENT 'Business identifier for the LFG collection system. Used in operational reporting and regulatory filings.. Valid values are `^[A-Z0-9]{4,20}$`',
    `system_manufacturer` STRING COMMENT 'Name of the manufacturer or primary contractor that designed and installed the LFG collection system.',
    `system_name` STRING COMMENT 'Descriptive name of the landfill gas collection system for operational identification and reporting purposes.',
    `system_type` STRING COMMENT 'Classification of the gas collection system based on extraction method: active extraction (blower-driven), passive venting (natural pressure), or hybrid (combination).. Valid values are `active_extraction|passive_venting|hybrid`',
    `total_extraction_well_count` STRING COMMENT 'Total number of vertical and horizontal extraction wells installed in the LFG collection system. Used for system capacity and coverage analysis.',
    `vertical_well_count` STRING COMMENT 'Number of vertical extraction wells in the collection system. Vertical wells are typically installed in closed or capped landfill areas.',
    `waste_in_place_tons` DECIMAL(18,2) COMMENT 'Estimated total tons of municipal solid waste in place within the collection system coverage area. Used for gas generation potential modeling.',
    CONSTRAINT pk_lfg_collection_system PRIMARY KEY(`lfg_collection_system_id`)
) COMMENT 'Master record for each Landfill Gas (LFG) collection and control system (GCCS) at a landfill site. Stores system ID, associated landfill site, total extraction well count, blower/flare station count, design flow capacity (scfm), current operational status, NSPS Subpart WWW permit reference, installation date, and whether the system feeds a beneficial use project (LFG-to-RNG, LFG-to-electricity). SSOT for LFG infrastructure identity.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` (
    `rng_processing_unit_id` BIGINT COMMENT 'Unique identifier for the RNG processing and upgrading unit. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: RNG processing units inject gas under pipeline interconnection agreements that specify quality standards, delivery points, and operational protocols. These contracts are critical for RIN generation el',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: RNG processing units have process emissions (CO2 removal, flaring) that must be tracked in GHG inventory. Also generate carbon credits tracked in sustainability. Links energy production asset to emiss',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: RNG processing units are high-value capital equipment requiring fixed asset tracking for depreciation, warranty management, capital project cost allocation, and asset retirement planning. Essential fo',
    `lfg_collection_system_id` BIGINT COMMENT 'Reference to the associated LFG collection system that feeds raw landfill gas to this processing unit.',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility (landfill or WTE site) where this RNG processing unit is located.',
    `annual_capacity_mmbtu` DECIMAL(18,2) COMMENT 'Estimated annual production capacity of the RNG processing unit in million British thermal units (MMBtu).',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Lifecycle carbon intensity score of the RNG produced by this unit, measured in grams of CO2 equivalent per megajoule, used for LCFS and other carbon credit programs.',
    `co2_removal_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage efficiency of the CO2 removal process in the upgrading system, critical for achieving target methane purity.',
    `commissioning_date` DATE COMMENT 'Date when the RNG processing unit was commissioned and began commercial operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RNG processing unit record was first created in the system.',
    `design_throughput_scfm` DECIMAL(18,2) COMMENT 'Nameplate design capacity of the unit in standard cubic feet per minute (SCFM) of raw LFG input.',
    `gas_quality_spec_standard` STRING COMMENT 'The regulatory or contractual gas quality specification standard that the RNG must meet (e.g., FERC, state PUC, pipeline tariff).',
    `h2s_removal_system` BOOLEAN COMMENT 'Indicates whether the unit is equipped with a hydrogen sulfide (H2S) removal system to meet pipeline gas quality and safety standards.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'Total capital cost of installing the RNG processing unit, including equipment, construction, and commissioning expenses.',
    `interconnection_point` STRING COMMENT 'Physical location or identifier of the pipeline interconnection point where RNG is injected into the natural gas grid.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or unscheduled maintenance performed on the RNG processing unit.',
    `lcfs_credit_eligible` BOOLEAN COMMENT 'Indicates whether the RNG produced by this unit is eligible for generating Low Carbon Fuel Standard (LCFS) credits under California or other state programs.',
    `maintenance_schedule` STRING COMMENT 'Scheduled maintenance frequency for the RNG processing unit to ensure optimal performance and regulatory compliance.. Valid values are `daily|weekly|monthly|quarterly|annual|as_needed`',
    `manufacturer` STRING COMMENT 'Name of the equipment manufacturer or system integrator who supplied the RNG processing unit.',
    `methane_purity_target_percent` DECIMAL(18,2) COMMENT 'Target methane concentration percentage in the upgraded RNG output required to meet pipeline quality specifications.',
    `model_number` STRING COMMENT 'Manufacturer model or series number of the RNG processing unit.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity on the RNG processing unit.',
    `notes` STRING COMMENT 'Additional operational notes, special conditions, or remarks related to the RNG processing unit.',
    `operational_status` STRING COMMENT 'Current operational status of the RNG processing unit indicating its availability and readiness for production.. Valid values are `operational|standby|maintenance|offline|decommissioned`',
    `permit_expiration_date` DATE COMMENT 'Expiration date of the current operating permit for this RNG processing unit.',
    `permit_number` STRING COMMENT 'Environmental or operational permit number issued by regulatory authorities for the operation of this RNG processing unit.',
    `rin_generation_eligible` BOOLEAN COMMENT 'Indicates whether the RNG produced by this unit is eligible for generating Renewable Identification Numbers (RINs) under EPA Renewable Fuel Standard (RFS).',
    `scada_integration` BOOLEAN COMMENT 'Indicates whether the RNG processing unit is integrated with the facility SCADA system for real-time monitoring and control.',
    `siloxane_removal_system` BOOLEAN COMMENT 'Indicates whether the unit is equipped with a siloxane removal system to protect downstream equipment and meet gas quality specifications.',
    `technology_type` STRING COMMENT 'The upgrading technology used to purify raw LFG to pipeline-quality RNG (e.g., pressure swing adsorption, membrane separation, amine scrubbing).. Valid values are `pressure_swing_adsorption|membrane_separation|amine_scrubbing|cryogenic_separation|water_scrubbing|hybrid`',
    `unit_code` STRING COMMENT 'Business identifier code for the RNG processing unit, used in operational systems and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `unit_name` STRING COMMENT 'Descriptive name of the RNG processing unit for identification and reporting purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RNG processing unit record was last updated in the system.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the RNG processing unit expires.',
    CONSTRAINT pk_rng_processing_unit PRIMARY KEY(`rng_processing_unit_id`)
) COMMENT 'Master record for each Renewable Natural Gas (RNG) processing and upgrading unit that converts raw LFG to pipeline-quality RNG. Captures unit ID, associated LFG collection system, technology type (pressure swing adsorption, membrane, amine scrubbing), design throughput (scfm), methane purity target (%), interconnection pipeline operator, FERC/state gas quality specs, commissioning date, and operational status. Supports RNG production tracking and RIN/LCFS credit generation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`srf_production_line` (
    `srf_production_line_id` BIGINT COMMENT 'Unique identifier for the SRF production line. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: SRF production lines supply refuse-derived fuel to cement kilns, power plants, and industrial boilers under long-term fuel supply agreements. These contracts govern quality specifications, delivery sc',
    `facility_id` BIGINT COMMENT 'Reference to the WTE or MRF facility where this SRF production line is located.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: SRF production lines require environmental permits for waste processing and emissions. Links line to permit for compliance tracking, emissions monitoring, and regulatory inspections. Essential for per',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the primary shredder equipment asset used in this production line for waste size reduction.',
    `actual_throughput_tpd` DECIMAL(18,2) COMMENT 'Current average actual throughput of the production line measured in tons per day, based on recent operational performance.',
    `automation_level` STRING COMMENT 'Degree of automation in the production line operations and control systems.. Valid values are `manual|semi_automated|fully_automated`',
    `commissioning_date` DATE COMMENT 'Date when the SRF production line was officially commissioned and began operational service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the production line was or is planned to be decommissioned and taken out of service.',
    `design_throughput_tpd` DECIMAL(18,2) COMMENT 'Engineered design capacity of the production line measured in tons per day of input material.',
    `emissions_monitoring_required` BOOLEAN COMMENT 'Indicates whether continuous emissions monitoring is required for this production line under Clean Air Act (CAA) regulations.',
    `energy_consumption_kwh_per_ton` DECIMAL(18,2) COMMENT 'Average electrical energy consumption of the production line per ton of SRF produced.',
    `feedstock_type` STRING COMMENT 'Primary type of waste feedstock processed by this SRF production line.. Valid values are `msw|commercial_waste|industrial_waste|construction_demolition|mixed`',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether this production line operates under ISO 14001 certified environmental management system.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major equipment upgrade or capacity enhancement to the production line.',
    `line_code` STRING COMMENT 'Business identifier code for the SRF production line, used in operational systems and reporting.. Valid values are `^[A-Z0-9]{3,12}$`',
    `line_name` STRING COMMENT 'Human-readable name or designation of the SRF production line.',
    `line_type` STRING COMMENT 'Classification of the SRF production line based on processing technology and methodology.. Valid values are `mechanical_biological|thermal_drying|shredding_classification|pelletizing|integrated`',
    `maintenance_schedule_type` STRING COMMENT 'Primary maintenance strategy applied to this production line.. Valid values are `preventive|predictive|condition_based|run_to_failure`',
    `notes` STRING COMMENT 'Additional operational notes, special considerations, or historical information about the production line.',
    `operating_days_per_year` STRING COMMENT 'Typical number of operating days per year for this production line, accounting for planned maintenance and shutdowns.',
    `operating_hours_per_day` DECIMAL(18,2) COMMENT 'Typical number of operating hours per day for this production line under normal operations.',
    `operational_status` STRING COMMENT 'Current operational state of the SRF production line in its lifecycle.. Valid values are `operational|idle|maintenance|decommissioned|startup|shutdown`',
    `processing_stages` STRING COMMENT 'Description of the sequential processing stages in this production line (e.g., shredding, screening, air classification, drying, pelletizing).',
    `reject_rate_percent` DECIMAL(18,2) COMMENT 'Average percentage of input feedstock that is rejected or diverted to landfill due to quality or contamination issues.',
    `safety_certification_status` STRING COMMENT 'Current status of OSHA safety certification for the production line equipment and operations.. Valid values are `certified|pending|expired|not_required`',
    `srf_ash_content_percent` DECIMAL(18,2) COMMENT 'Target ash content specification of the SRF output, expressed as percentage by weight.',
    `srf_calorific_value_mj_kg` DECIMAL(18,2) COMMENT 'Target net calorific value specification of the SRF output from this production line, measured in megajoules per kilogram.',
    `srf_chlorine_content_percent` DECIMAL(18,2) COMMENT 'Target chlorine content specification of the SRF output, expressed as percentage by weight, critical for emissions control in end-use combustion.',
    `srf_moisture_content_percent` DECIMAL(18,2) COMMENT 'Target moisture content specification of the SRF output, expressed as percentage by weight.',
    `srf_quality_class` STRING COMMENT 'ISO 21640 quality classification of the SRF produced by this line, based on calorific value, chlorine content, and mercury content ranges.. Valid values are `class_1|class_2|class_3|class_4|class_5`',
    `target_end_use_market` STRING COMMENT 'Primary intended market or application for the SRF output from this production line.. Valid values are `cement_kiln|industrial_boiler|power_plant|waste_to_energy|district_heating`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line record was last modified in the system.',
    `yield_rate_percent` DECIMAL(18,2) COMMENT 'Average percentage of input feedstock that is converted to marketable SRF output, representing production efficiency.',
    CONSTRAINT pk_srf_production_line PRIMARY KEY(`srf_production_line_id`)
) COMMENT 'Master record for each Solid Recovered Fuel (SRF) production line at a WTE or MRF facility. Tracks line ID, associated facility, shredder/classifier equipment IDs, design throughput (TPD), SRF quality specification (calorific value MJ/kg, moisture %, chlorine %), target end-use market (cement kiln, industrial boiler), operational status, and commissioning date. Enables SRF yield and quality management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`generation_reading` (
    `generation_reading_id` BIGINT COMMENT 'Unique identifier for the energy generation reading record. Primary key for this transactional measurement entity.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Generation readings should track which boiler unit provided the steam that drove the turbine-generator. This enables analysis of boiler-to-generation efficiency and performance correlation. The FK wil',
    `employee_id` BIGINT COMMENT 'Identifier of the facility operator or control room technician responsible for monitoring and recording this reading. Used for accountability and training assessment.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy (WTE) facility or Landfill Gas-to-Energy (LFG) site where this reading was captured.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Generation readings provide activity data (fuel input tons, emissions lbs) that feed GHG emission calculations. EPA GHGRP requires linking operational data to emission records for verification. Enable',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Generation readings provide source data for EPA GHGRP, Title V, and state air quality reports. Links reading to submission for data traceability, audit support, and regulatory verification. Essential ',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the operational shift during which this reading was captured (e.g., day shift, night shift, weekend crew). Used for workforce performance analysis and operational accountability.',
    `turbine_generator_id` BIGINT COMMENT 'Identifier of the specific turbine-generator unit or LFG-to-electricity conversion unit that produced this energy output.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Outdoor ambient air temperature at the facility during this reading interval, measured in degrees Fahrenheit. Impacts turbine performance and thermal efficiency calculations.',
    `ash_residue_tons` DECIMAL(18,2) COMMENT 'Quantity of bottom ash and fly ash residue generated from combustion during this reading interval, measured in tons. Requires proper handling, testing (TCLP), and disposal per RCRA regulations.',
    `barometric_pressure_inhg` DECIMAL(18,2) COMMENT 'Atmospheric pressure at the facility during this reading interval, measured in inches of mercury (inHg). Affects combustion air density and turbine performance.',
    `boiler_efficiency_percent` DECIMAL(18,2) COMMENT 'Ratio of useful heat output to total fuel energy input for the boiler system, expressed as a percentage. Key indicator of combustion performance and thermal efficiency.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of actual energy output to maximum possible output over the reading interval, expressed as a percentage. Key performance indicator for turbine efficiency and operational availability.',
    `co2_emissions_tons` DECIMAL(18,2) COMMENT 'Quantity of carbon dioxide (CO2) emitted during this reading interval, measured in tons. Required for Clean Air Act (CAA) compliance and greenhouse gas (GHG) reporting.',
    `co_emissions_lbs` DECIMAL(18,2) COMMENT 'Quantity of carbon monoxide (CO) emitted during this reading interval, measured in pounds. Indicator of combustion efficiency and air quality compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this energy generation reading record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability and accuracy of this reading (valid, estimated, missing, suspect, calibration-required). Used for data validation, audit trails, and regulatory reporting confidence.. Valid values are `valid|estimated|missing|suspect|calibration-required`',
    `fuel_input_scfm_lfg` DECIMAL(18,2) COMMENT 'Flow rate of Landfill Gas (LFG) fed into the energy conversion system during this reading interval, measured in standard cubic feet per minute (scfm). Primary fuel input metric for LFG-to-energy projects.',
    `fuel_input_tons_msw` DECIMAL(18,2) COMMENT 'Quantity of Municipal Solid Waste (MSW) or Solid Recovered Fuel (SRF) combusted during this reading interval, measured in tons. Primary fuel input metric for WTE facilities.',
    `grid_export_mwh` DECIMAL(18,2) COMMENT 'Quantity of electrical energy exported to the utility grid during this reading interval, measured in megawatt-hours (MWh). Used for revenue calculation and grid interconnection reporting.',
    `gross_generation_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy generated by the turbine-generator unit before accounting for parasitic load or auxiliary consumption, measured in megawatt-hours (MWh).',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Thermal efficiency metric representing the amount of fuel energy (in BTU) required to generate one kilowatt-hour of electricity. Lower values indicate higher efficiency.',
    `meter_calibration_date` DATE COMMENT 'Date when the energy meter was last calibrated or verified for accuracy. Required for regulatory compliance and data quality assurance.',
    `meter_number` STRING COMMENT 'Unique identifier of the energy meter or monitoring device that captured this reading. Used for traceability and calibration tracking.',
    `methane_content_percent` DECIMAL(18,2) COMMENT 'Percentage of methane (CH4) in the landfill gas stream. Higher methane content indicates better fuel quality and energy yield. Typical range is 45-60% for LFG.',
    `net_generation_mwh` DECIMAL(18,2) COMMENT 'Net electrical energy available for sale or use after subtracting parasitic load and auxiliary consumption from gross generation, measured in megawatt-hours (MWh). Primary metric for utility settlement and revenue recognition.',
    `notes` STRING COMMENT 'Free-text field for operator comments, anomalies, or contextual information related to this reading (e.g., equipment issues, weather events, process adjustments).',
    `nox_emissions_lbs` DECIMAL(18,2) COMMENT 'Quantity of nitrogen oxides (NOx) emitted during this reading interval, measured in pounds. Regulated pollutant under Clean Air Act (CAA) requiring continuous emissions monitoring.',
    `on_site_consumption_mwh` DECIMAL(18,2) COMMENT 'Quantity of electrical energy consumed on-site by facility operations during this reading interval, measured in megawatt-hours (MWh). Reduces net export to grid.',
    `operational_status` STRING COMMENT 'Current operational state of the turbine-generator unit at the time of this reading (online, offline, startup, shutdown, maintenance, standby). Indicates availability and production capability.. Valid values are `online|offline|startup|shutdown|maintenance|standby`',
    `parasitic_load_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by auxiliary equipment and facility operations (pumps, fans, controls, lighting) during this reading interval, measured in megawatt-hours (MWh). Subtracted from gross generation to calculate net generation.',
    `particulate_matter_lbs` DECIMAL(18,2) COMMENT 'Quantity of particulate matter (PM10 and PM2.5) emitted during this reading interval, measured in pounds. Regulated pollutant under Clean Air Act (CAA) requiring continuous emissions monitoring.',
    `reading_interval_type` STRING COMMENT 'Frequency or interval at which this reading was captured (hourly, daily, shift-based, real-time, monthly). Determines aggregation and reporting granularity.. Valid values are `hourly|daily|shift|real-time|monthly`',
    `reading_timestamp` TIMESTAMP COMMENT 'Precise date and time when the energy generation measurement was captured. Primary business event timestamp for this transactional record.',
    `rec_certification_type` STRING COMMENT 'Type of renewable energy credit certification program under which this generation qualifies (Green-e, M-RETS, PJM-GATS, WREGIS, ERCOT, or none if not certified).. Valid values are `green-e|m-rets|pjm-gats|wregis|ercot|none`',
    `renewable_energy_credits_qty` DECIMAL(18,2) COMMENT 'Number of Renewable Energy Credits (RECs) or Renewable Identification Numbers (RINs) generated from this energy production, based on qualifying renewable fuel sources. Used for compliance and revenue recognition.',
    `so2_emissions_lbs` DECIMAL(18,2) COMMENT 'Quantity of sulfur dioxide (SO2) emitted during this reading interval, measured in pounds. Regulated pollutant under Clean Air Act (CAA) requiring continuous emissions monitoring.',
    `steam_output_klb` DECIMAL(18,2) COMMENT 'Quantity of steam produced by the boiler system during this reading interval, measured in thousand pounds (klb). Applicable for combined heat and power (CHP) or industrial steam sales.',
    `turbine_efficiency_percent` DECIMAL(18,2) COMMENT 'Ratio of electrical energy output to thermal energy input for the turbine-generator unit, expressed as a percentage. Indicates mechanical and electrical conversion efficiency.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this energy generation reading record was last modified. Used for audit trail and change tracking.',
    `utility_settlement_mwh` DECIMAL(18,2) COMMENT 'Net energy quantity submitted to the utility or grid operator for settlement and revenue calculation, measured in megawatt-hours (MWh). May differ from net generation due to contractual adjustments or metering reconciliation.',
    CONSTRAINT pk_generation_reading PRIMARY KEY(`generation_reading_id`)
) COMMENT 'Transactional record of energy output measurements captured at each turbine-generator or LFG-to-electricity unit at a defined interval (hourly, daily). Records gross generation (MWh), net generation (MWh after parasitic load), steam output (klb), capacity factor (%), heat rate (BTU/kWh), fuel input (tons MSW or scfm LFG), reading timestamp, meter ID, and data quality flag. Primary operational transaction for energy production reporting and utility settlement.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` (
    `lfg_flow_reading_id` BIGINT COMMENT 'Unique identifier for the landfill gas flow reading record.',
    `compliance_environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_environmental_monitoring. Business justification: LFG flow readings ARE environmental monitoring data required by landfill permits. Links reading to monitoring event for permit condition compliance, quarterly monitoring reports, and exceedance tracki',
    `employee_id` BIGINT COMMENT 'Identifier of the technician or operator who performed the reading or was on duty when the automated reading was captured.',
    `ghg_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.ghg_regulatory_submission. Business justification: LFG flow readings provide activity data for EPA GHGRP Subpart HH submissions (landfill methane). Links reading to GHG submission for methane emissions calculations, data traceability, and EPA verifica',
    `cems_instrument_id` BIGINT COMMENT 'Identifier of the monitoring instrument or sensor device used to capture this reading.',
    `lfg_capture_id` BIGINT COMMENT 'Foreign key linking to sustainability.lfg_capture. Business justification: Flow readings are source data for calculating LFG capture volumes and methane avoidance in sustainability reporting. Links operational measurements to aggregated capture records required for carbon cr',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG flow readings are captured from extraction wells that are part of a specific LFG collection system. This link enables rollup of flow readings to the system level and tracking of system-wide perfor',
    `lfg_extraction_well_id` BIGINT COMMENT 'Identifier of the LFG extraction well from which this reading was taken. Part of the Gas Collection and Control System (GCCS).',
    `site_id` BIGINT COMMENT 'Identifier of the landfill facility where this LFG reading was captured.',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Boolean indicator whether this reading triggered an alarm condition (e.g., high LEL, low methane concentration, high O2 intrusion).',
    `balance_gas_pct` DECIMAL(18,2) COMMENT 'Percentage of other gases (nitrogen, trace compounds) calculated as the remainder after accounting for CH4, CO2, and O2. Typically calculated as 100 - (CH4 + CO2 + O2).',
    `barometric_pressure_inhg` DECIMAL(18,2) COMMENT 'Atmospheric barometric pressure at the time of reading in inches of mercury. Affects gas flow dynamics and measurement accuracy.',
    `calibration_date` DATE COMMENT 'Date when the monitoring instrument was last calibrated prior to this reading. Ensures data quality and regulatory compliance.',
    `co2_concentration_pct` DECIMAL(18,2) COMMENT 'Percentage concentration of carbon dioxide (CO2) in the landfill gas sample.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether this reading was taken for regulatory compliance reporting purposes under NSPS Subpart WWW or other EPA requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reading record was first created in the system.',
    `data_source` STRING COMMENT 'Source system or method by which the reading was captured: manual field reading, SCADA system, portable gas analyzer, fixed sensor network, or laboratory analysis.. Valid values are `manual|scada|portable_analyzer|fixed_sensor|laboratory`',
    `flow_rate_scfm` DECIMAL(18,2) COMMENT 'Volumetric flow rate of landfill gas measured in standard cubic feet per minute (SCFM) at the extraction point.',
    `header_pipe_code` BIGINT COMMENT 'Identifier of the header pipe segment from which this reading was taken, if applicable. Header pipes collect gas from multiple wells.',
    `hydrogen_sulfide_ppm` DECIMAL(18,2) COMMENT 'Concentration of hydrogen sulfide (H2S) in parts per million. Corrosive gas that impacts equipment and requires monitoring for safety and operational reasons.',
    `lel_reading_pct` DECIMAL(18,2) COMMENT 'Lower Explosive Limit reading as a percentage of the LEL threshold. Safety metric indicating combustion risk. Values above 25% LEL trigger safety protocols.',
    `methane_concentration_pct` DECIMAL(18,2) COMMENT 'Percentage concentration of methane (CH4) in the landfill gas sample. Critical for energy yield calculations and compliance monitoring.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this reading record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or observations recorded by the technician during the reading event. May include operational context, anomalies, or corrective actions taken.',
    `oxygen_concentration_pct` DECIMAL(18,2) COMMENT 'Percentage concentration of oxygen (O2) in the landfill gas sample. Elevated O2 indicates air intrusion and potential combustion risk.',
    `reading_status` STRING COMMENT 'Quality status of the reading: valid for use, invalid due to instrument error, flagged for review, under investigation, calibration required, or instrument fault detected.. Valid values are `valid|invalid|flagged|under_review|calibration_required|instrument_fault`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the LFG flow and composition measurement was captured from the extraction well or header pipe.',
    `reading_type` STRING COMMENT 'Classification of the reading event: scheduled routine monitoring, spot check, alarm-triggered investigation, compliance reporting, or calibration verification.. Valid values are `scheduled|spot_check|alarm_triggered|compliance|calibration`',
    `static_pressure_inches_h2o` DECIMAL(18,2) COMMENT 'Static pressure measurement at the extraction point in inches of water column (H2O). Indicates vacuum applied by the GCCS blower.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the landfill gas at the measurement point in degrees Fahrenheit.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of reading. Weather impacts LFG generation rates and extraction efficiency. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|wind|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_lfg_flow_reading PRIMARY KEY(`lfg_flow_reading_id`)
) COMMENT 'Transactional record of LFG flow and composition measurements from extraction wells and header pipes within a GCCS. Captures reading timestamp, well or header ID, flow rate (scfm), methane concentration (% CH4), CO2 concentration (%), O2 concentration (%), static pressure (inches H2O), temperature (°F), LEL reading, and instrument ID. Supports NSPS Subpart WWW compliance reporting and LFG-to-energy yield optimization.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`emissions_reading` (
    `emissions_reading_id` BIGINT COMMENT 'Unique identifier for the emissions reading record. Primary key for the emissions_reading data product.',
    `air_emission_event_id` BIGINT COMMENT 'Foreign key linking to compliance.air_emission_event. Business justification: Emissions readings that exceed permit limits trigger air emission event records for deviation tracking. Links reading to event for agency notification, corrective action tracking, and compliance statu',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Emissions readings are measured at stacks associated with specific boiler units. While emissions_reading has stack_id (STRING), it needs a direct FK to boiler_unit to establish which boiler generated ',
    `cems_instrument_id` BIGINT COMMENT 'Identifier of the specific CEMS or monitoring equipment that captured this reading. Used for equipment maintenance tracking, calibration history, and data quality assurance.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility where the emissions reading was captured.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: CEMS emissions readings are direct measurements that populate GHG emission records for EPA GHGRP and ESG reporting. Links real-time monitoring data to inventory calculations, enabling verification and',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Emissions readings directly feed Title V reports, GHGRP submissions, and state air quality reports. Links reading to submission for data traceability, compliance verification, and audit defense. Essen',
    `stack_id` BIGINT COMMENT 'Identifier of the specific emissions stack or unit within the facility from which the reading was taken. May correspond to boiler, turbine, or combustion unit identifier.',
    `averaging_period` STRING COMMENT 'Time period over which the emissions measurement was averaged. Regulatory limits may apply to different averaging periods (e.g., 1-hour, 24-hour, annual).. Valid values are `1_hour|3_hour|24_hour|30_day|annual|instantaneous`',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration or quality assurance test performed on the monitoring equipment prior to this reading. EPA regulations require regular calibration and QA testing of CEMS equipment.',
    `comments` STRING COMMENT 'Free-text field for additional context, notes, or explanations related to this emissions reading. May include information about operational conditions, equipment issues, weather impacts, or other factors affecting emissions.',
    `compliance_status` STRING COMMENT 'Indicates whether this emissions reading is within permitted limits. Non-compliant or exceedance readings trigger regulatory reporting and corrective action requirements under the Clean Air Act (CAA).. Valid values are `compliant|non_compliant|exceedance|pending_review|exempt`',
    `concentration_unit` STRING COMMENT 'Unit of measure for the measured concentration. Common units include parts per million (ppm), milligrams per dry standard cubic meter (mg/dscm), nanograms per dry standard cubic meter (ng/dscm), micrograms per dry standard cubic meter (ug/dscm), or pounds per million British thermal units (lb/MMBtu).. Valid values are `ppm|mg_dscm|ng_dscm|ug_dscm|lb_MMBtu`',
    `control_device_status` STRING COMMENT 'Operational status of air pollution control equipment (e.g., scrubbers, baghouses, electrostatic precipitators, selective catalytic reduction systems) at the time of measurement. Control device malfunctions or bypass events may result in elevated emissions and compliance violations.. Valid values are `operating_normal|operating_degraded|bypassed|offline|maintenance`',
    `corrected_concentration` DECIMAL(18,2) COMMENT 'Pollutant concentration corrected to 7% oxygen (O2) reference basis as required by EPA regulations for combustion sources. This normalization allows for consistent comparison across different operating conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions reading record was first created in the system. Used for data lineage and audit trail purposes.',
    `data_source` STRING COMMENT 'Source of the emissions data. CEMS provides continuous monitoring; stack tests provide periodic verification; predictive models or engineering estimates may be used when direct measurement is not feasible; data substitution follows EPA protocols when CEMS data is unavailable.. Valid values are `CEMS|Stack_Test|Predictive_Model|Engineering_Estimate|Data_Substitution`',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether this reading represents a deviation from permit requirements, operating parameters, or monitoring requirements. Deviations must be reported to regulatory authorities and may trigger enforcement actions.',
    `flow_rate` DECIMAL(18,2) COMMENT 'Volumetric flow rate of stack gas at the time of measurement, typically measured in dry standard cubic feet per hour (dscfh) or dry standard cubic meters per hour (dscmh). Used to calculate mass emission rates.',
    `flow_rate_unit` STRING COMMENT 'Unit of measure for stack gas flow rate. Common units include dry standard cubic feet per hour (dscfh), dry standard cubic meters per hour (dscmh), actual cubic feet per minute (acfm), or actual cubic meters per hour (acmh).. Valid values are `dscfh|dscmh|acfm|acmh`',
    `fuel_type` STRING COMMENT 'Type of fuel being combusted at the time of measurement. Common fuel types in waste-to-energy operations include Municipal Solid Waste (MSW), Refuse-Derived Fuel (RDF), Solid Recovered Fuel (SRF), Landfill Gas (LFG), natural gas, biogas, and biomass. Fuel composition affects emissions profiles. [ENUM-REF-CANDIDATE: MSW|RDF|SRF|LFG|Natural_Gas|Biogas|Coal|Biomass|Mixed — 9 candidates stripped; promote to reference product]',
    `mass_emission_rate` DECIMAL(18,2) COMMENT 'Calculated mass emission rate of the pollutant, derived from concentration and flow rate. Typically expressed in pounds per hour (lb/hr) or kilograms per hour (kg/hr). Used for permit compliance and annual emission inventory reporting.',
    `mass_emission_rate_unit` STRING COMMENT 'Unit of measure for mass emission rate. Common units include pounds per hour (lb/hr), kilograms per hour (kg/hr), tons per year (ton/yr), or grams per second (g/sec).. Valid values are `lb_hr|kg_hr|ton_yr|g_sec`',
    `measured_concentration` DECIMAL(18,2) COMMENT 'Raw measured concentration of the pollutant as captured by the Continuous Emissions Monitoring System (CEMS) or stack test equipment. Units vary by pollutant (ppm, mg/dscm, ng/dscm).',
    `measurement_method` STRING COMMENT 'EPA-approved method used to capture this emissions reading. CEMS (Continuous Emissions Monitoring System) provides real-time data; EPA reference methods (e.g., Method 5 for particulates, Method 23 for dioxins/furans, Method 29 for metals) are used for periodic stack tests. [ENUM-REF-CANDIDATE: CEMS|Method_5|Method_23|Method_29|Method_26A|Method_3A|Method_7E|Manual_Stack_Test — 8 candidates stripped; promote to reference product]',
    `moisture_content` DECIMAL(18,2) COMMENT 'Moisture content of the stack gas expressed as a percentage by volume. Used to convert between wet and dry basis measurements.',
    `operating_load` DECIMAL(18,2) COMMENT 'Operating load of the combustion unit at the time of measurement, expressed as a percentage of maximum rated capacity. Emissions characteristics vary with load, and some permit limits are load-dependent.',
    `oxygen_percent` DECIMAL(18,2) COMMENT 'Measured oxygen (O2) percentage in the stack gas at the time of reading. Used to calculate corrected concentration values.',
    `permit_limit` DECIMAL(18,2) COMMENT 'Maximum allowable concentration or emission rate for this pollutant as specified in the facilitys air quality permit issued by the state or EPA. Used to determine compliance status.',
    `permit_limit_unit` STRING COMMENT 'Unit of measure for the permit limit. Must be compatible with concentration_unit for compliance comparison. May also include tons per year (tpy) for annual emission limits.. Valid values are `ppm|mg_dscm|ng_dscm|ug_dscm|lb_MMBtu|tpy`',
    `pollutant_type` STRING COMMENT 'Type of air pollutant measured in this emissions reading. Common pollutants include nitrogen oxides (NOx), sulfur dioxide (SO2), carbon monoxide (CO), hydrogen chloride (HCl), dioxins and furans, mercury (Hg), particulate matter (PM), volatile organic compounds (VOC), lead (Pb), and cadmium (Cd). [ENUM-REF-CANDIDATE: NOx|SO2|CO|HCl|Dioxins_Furans|Mercury|Particulates|VOC|Lead|Cadmium — 10 candidates stripped; promote to reference product]',
    `qa_qc_status` STRING COMMENT 'Quality assurance and quality control status of the emissions reading. Indicates whether the data has passed validation checks, failed QA procedures, or was affected by instrument issues. Data substitution may occur per EPA protocols when CEMS data is unavailable.. Valid values are `validated|pending_validation|failed_qa|calibration_error|instrument_malfunction|data_substituted`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the emissions measurement was captured. For CEMS data, this is the end of the averaging period (typically hourly). For stack tests, this is the midpoint of the test run.',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this emissions reading must be reported to regulatory agencies (EPA, state environmental quality departments). Exceedances, deviations, and certain periodic reports trigger mandatory reporting under Clean Air Act (CAA) requirements.',
    `stack_temperature` DECIMAL(18,2) COMMENT 'Temperature of the stack gas at the measurement point, typically in degrees Fahrenheit (°F) or Celsius (°C). Used for flow rate calculations and combustion efficiency analysis.',
    `stack_temperature_unit` STRING COMMENT 'Unit of measure for stack gas temperature: Fahrenheit (F) or Celsius (C).. Valid values are `F|C`',
    `test_company` STRING COMMENT 'Name of the third-party testing company that conducted the stack test. Applicable only to manual stack test readings. Testing companies must be accredited and follow EPA protocols.',
    `test_run_number` STRING COMMENT 'Identifier for the specific test run within a stack test event. EPA methods typically require multiple test runs (usually 3) to establish compliance. Applicable only to manual stack test readings, not CEMS data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions reading record was last modified. Used for data lineage, audit trail, and change tracking purposes.',
    CONSTRAINT pk_emissions_reading PRIMARY KEY(`emissions_reading_id`)
) COMMENT 'Transactional record of stack emissions measurements from WTE facility continuous emissions monitoring systems (CEMS) and periodic stack tests. Captures facility ID, stack/unit ID, pollutant type (NOx, SO2, CO, HCl, dioxins/furans, mercury, particulates), measured concentration (ppm or mg/dscm), corrected concentration at 7% O2, permit limit, compliance status flag, measurement method (CEMS, Method 29, Method 23), reading timestamp, and QA/QC status. Core CAA compliance record.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`ash_residue_record` (
    `ash_residue_record_id` BIGINT COMMENT 'Unique identifier for the ash residue record. Primary key for tracking individual ash generation events from WTE combustion processes.',
    `boiler_unit_id` BIGINT COMMENT 'Identifier of the specific boiler unit within the WTE facility that generated the ash residue.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Ash disposal transactions execute under disposal agreements that specify tipping fees, waste acceptance criteria, and liability terms. While receiving_facility_id identifies the destination, the speci',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Specialized hazmat disposal PO type enables manifest-to-PO matching, TSDF vendor performance tracking, regulatory compliance audit trail, and RCRA waste code reconciliation between disposal contract a',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Ash residue hauling from WTE facilities uses fleet vehicles. Environmental compliance and logistics teams need to track which vehicle transported each ash load for DOT compliance, vehicle contaminatio',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Ash residue from WTE combustion classified as hazardous waste requires manifest tracking for regulatory compliance under RCRA. Links energy facility ash generation to hazmat transportation and disposa',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy facility where the ash residue was generated.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Ash disposal is a purchased service requiring PO for cost reconciliation, three-way match with manifest/BOL, disposal cost analysis per waste stream, and vendor invoice verification against contracted',
    `receiving_facility_id` BIGINT COMMENT 'Identifier of the facility that received the ash residue for disposal, beneficial reuse, or further processing. May be a landfill, aggregate processing facility, or TSDF.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Ash generation and disposal data required in annual facility reports, waste manifests, and RCRA biennial reports. Links record to submission for data traceability, compliance verification, and regulat',
    `ash_sample_id` BIGINT COMMENT 'Unique identifier assigned to the ash residue sample submitted for laboratory testing. Used for tracking chain of custody and linking to detailed lab reports.',
    `spill_release_id` BIGINT COMMENT 'Foreign key linking to compliance.spill_release. Business justification: Ash handling incidents (spills during loading, transport, or storage) create spill_release records. Links ash record to spill for incident tracking, regulatory notification, and corrective action. Ess',
    `tclp_test_id` BIGINT COMMENT 'Foreign key linking to hazmat.tclp_test. Business justification: Ash residue TCLP testing determines hazardous waste classification under RCRA toxicity characteristic rules. Links energy facility ash generation to hazmat laboratory characterization results. Essenti',
    `transporter_registration_id` BIGINT COMMENT 'Identifier of the transportation company or fleet that hauled the ash residue from generation site to receiving facility.',
    `ash_generation_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of input MSW feedstock that resulted in ash residue (ash weight / feedstock weight * 100). Key performance indicator for combustion efficiency and waste reduction.',
    `ash_type` STRING COMMENT 'Classification of ash residue by combustion process output: bottom ash (heavy residue from combustion chamber floor), fly ash (fine particulate captured by air pollution control devices), or combined ash (mixture of both).. Valid values are `bottom_ash|fly_ash|combined_ash`',
    `beneficial_reuse_revenue_usd` DECIMAL(18,2) COMMENT 'Revenue generated in US dollars from selling ash residue for beneficial reuse applications such as aggregate substitute in construction. Null if ash was disposed rather than sold.',
    `bol_number` STRING COMMENT 'Bill of Lading number for the transportation of ash residue from the WTE facility to the receiving facility. Provides shipment tracking and legal documentation.',
    `combustion_temperature_celsius` DECIMAL(18,2) COMMENT 'Average combustion chamber temperature in degrees Celsius during the ash generation period. Influences ash characteristics and regulatory compliance with Clean Air Act emission standards.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance issues, regulatory exceptions, special handling requirements, or other relevant compliance information for this ash residue batch.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the ash residue record: compliant with all applicable regulations, non-compliant with violations noted, pending regulatory review, or exempt from certain requirements.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ash residue record was first created in the system. Used for audit trail and data lineage tracking.',
    `disposal_cost_usd` DECIMAL(18,2) COMMENT 'Total cost in US dollars for disposing or processing the ash residue, including tipping fees, transportation, and handling charges. Used for cost accounting and financial reporting.',
    `disposal_method` STRING COMMENT 'Method used for final disposition of ash residue: beneficial reuse as aggregate in construction materials, landfill disposal, recycling into products, or treatment before disposal. Critical for sustainability and diversion rate reporting.. Valid values are `beneficial_reuse_aggregate|landfill_disposal|recycling|treatment`',
    `diversion_from_landfill_flag` BOOLEAN COMMENT 'Boolean indicator of whether the ash residue was diverted from landfill disposal through beneficial reuse, recycling, or other alternative methods. True if diverted, false if landfilled. Critical for sustainability reporting and diversion rate calculations.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code assigned to the ash residue if classified as hazardous under RCRA (e.g., D004-D011 for characteristic wastes). Null for non-hazardous ash.',
    `generation_date` DATE COMMENT 'Date when the ash residue was generated from the combustion process. Critical for tracking production cycles and regulatory reporting timelines.',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total weight of ash residue generated, measured in tons. Used for calculating ash generation rates, disposal costs, and diversion metrics.',
    `heavy_metal_concentration_ppm` STRING COMMENT 'Concentration levels of heavy metals (lead, cadmium, mercury, chromium, etc.) detected in ash residue, measured in parts per million. Stored as JSON or delimited string with metal:value pairs. Critical for environmental compliance and beneficial reuse eligibility.',
    `lab_analysis_date` DATE COMMENT 'Date when laboratory analysis (TCLP and other tests) was performed on the ash residue sample. Used for tracking testing timelines and regulatory compliance with testing frequency requirements.',
    `lab_code` BIGINT COMMENT 'Identifier of the certified laboratory that performed the ash residue analysis. Links to laboratory vendor master data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ash residue record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the ash residue sample. Affects handling characteristics, transportation weight, and beneficial reuse suitability.',
    `msw_feedstock_tons` DECIMAL(18,2) COMMENT 'Total tons of MSW feedstock processed in the combustion cycle that generated this ash residue. Used to calculate ash generation rate and combustion efficiency metrics.',
    `particle_size_distribution` STRING COMMENT 'Distribution of particle sizes in the ash residue sample, typically expressed as percentage passing through standard sieve sizes. Affects beneficial reuse suitability and handling characteristics.',
    `ph_level` DECIMAL(18,2) COMMENT 'pH measurement of ash residue indicating acidity or alkalinity. Affects handling requirements, corrosivity classification, and beneficial reuse applications.',
    `receipt_date` DATE COMMENT 'Date when the receiving facility confirmed receipt of the ash residue shipment. Used for reconciliation and compliance verification.',
    `record_status` STRING COMMENT 'Current lifecycle status of the ash residue record: draft (being created), submitted (awaiting approval), approved (finalized), or archived (historical record).. Valid values are `draft|submitted|approved|archived`',
    `regulatory_classification` STRING COMMENT 'Classification of ash residue as non-hazardous or hazardous waste based on TCLP test results and RCRA criteria. Determines disposal requirements and handling protocols.. Valid values are `non_hazardous|hazardous`',
    `shipment_date` DATE COMMENT 'Date when the ash residue was shipped from the WTE facility to the receiving facility. Used for tracking transportation timelines and regulatory reporting.',
    `state_waste_code` STRING COMMENT 'State-specific waste classification code if the state has additional or more stringent waste classification requirements beyond federal RCRA standards.',
    `storage_duration_days` STRING COMMENT 'Number of days the ash residue was stored on-site at the WTE facility before shipment. Monitored for regulatory compliance with maximum storage time limits.',
    `storage_location` STRING COMMENT 'Physical location or bin identifier where ash residue was temporarily stored at the WTE facility before shipment. Used for inventory tracking and facility operations management.',
    CONSTRAINT pk_ash_residue_record PRIMARY KEY(`ash_residue_record_id`)
) COMMENT 'Transactional record tracking bottom ash and fly ash generated from WTE combustion processes. Captures facility ID, boiler unit ID, ash type (bottom ash, fly ash, combined ash), generation date, gross weight (tons), moisture content (%), TCLP test result reference, disposal method (beneficial reuse as aggregate, landfill disposal), receiving facility ID, manifest or BOL number, and regulatory classification (non-hazardous/hazardous per TCLP). Critical for RCRA compliance and ash diversion rate reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`rec_issuance` (
    `rec_issuance_id` BIGINT COMMENT 'Unique identifier for the REC issuance transaction. Primary key for the rec_issuance product.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: REC issuances are sold under REC purchase agreements or bundled PPA contracts that specify pricing, delivery schedules, and retirement obligations. Direct contract reference is required for revenue re',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Renewable Energy Credits are generated from specific emission sources tracked in the sustainability domain. This link enables accurate carbon accounting and ensures RECs are properly attributed to the',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility that generated the renewable energy qualifying for REC issuance.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: REC issuances may require state RPS compliance filings and verification reports. Links issuance to submission for RPS compliance tracking, state renewable energy reporting, and verification documentat',
    `renewable_energy_credit_id` BIGINT COMMENT 'Foreign key linking to sustainability.renewable_energy_credit. Business justification: REC issuances in energy domain are source records for renewable_energy_credit tracking in sustainability ESG reporting. Links generation certificates to corporate sustainability accounting for Scope 2',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Renewable Energy Credits are generated by specific turbine-generator units. This link enables tracking of REC generation by asset, which is critical for asset performance analysis and regulatory repor',
    `batch_number` STRING COMMENT 'Internal Waste Management batch identifier for grouping related REC issuances for accounting and tracking purposes.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `certificate_serial_number_end` STRING COMMENT 'Ending serial number in the range of REC certificates issued in this batch. Defines the upper bound of the certificate range.. Valid values are `^[A-Z0-9]{8,20}$`',
    `certificate_serial_number_start` STRING COMMENT 'Starting serial number in the range of REC certificates issued in this batch. Unique identifier assigned by the REC registry.. Valid values are `^[A-Z0-9]{8,20}$`',
    `compliance_year` STRING COMMENT 'Calendar year for which these RECs may be applied toward RPS compliance obligations. May differ from vintage year due to banking provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC issuance record was first created in the system. Used for audit trail and data lineage.',
    `eligibility_state` STRING COMMENT 'Comma-separated list of US state postal codes where these RECs are eligible for RPS compliance. Example: MA,CT,RI for New England states.. Valid values are `^[A-Z]{2}(,[A-Z]{2})*$`',
    `emissions_avoided_co2e_tons` DECIMAL(18,2) COMMENT 'Estimated tons of CO2 equivalent greenhouse gas emissions avoided by generating renewable energy instead of fossil fuel energy. Used for sustainability reporting.',
    `energy_quantity_mwh` DECIMAL(18,2) COMMENT 'Total quantity of renewable energy generated during the period, measured in megawatt-hours. One REC is typically issued per MWh of qualifying renewable energy.',
    `generation_period_end_date` DATE COMMENT 'End date of the energy generation period for which RECs are being issued. Defines the close of the generation measurement window.',
    `generation_period_start_date` DATE COMMENT 'Start date of the energy generation period for which RECs are being issued. Typically aligns with monthly or quarterly reporting periods.',
    `issuance_date` DATE COMMENT 'Date on which the REC certificates were officially issued by the registry. Typically occurs 30-60 days after the generation period ends to allow for verification.',
    `market_value_usd` DECIMAL(18,2) COMMENT 'Estimated or actual market value of the REC batch in US dollars at time of issuance. Used for revenue recognition and asset valuation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC issuance record was last modified. Used for audit trail and change tracking.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum rated electrical generation capacity of the facility in megawatts. Used to calculate capacity factors and performance metrics.',
    `notes` STRING COMMENT 'Free-text field for additional information about the REC issuance, such as special circumstances, adjustments, or operational notes.',
    `rec_quantity` STRING COMMENT 'Number of individual REC certificates issued in this transaction. Typically equals the MWh quantity rounded to whole units.',
    `registry_account_number` STRING COMMENT 'Waste Managements account identifier within the REC registry system. Used to track ownership and transfers of RECs.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `registry_name` STRING COMMENT 'Name of the regional or national REC tracking registry where the certificates are registered. NEPOOL GIS = New England, M-RETS = Midwest, WREGIS = Western, PJM-GATS = Mid-Atlantic.. Valid values are `NEPOOL-GIS|M-RETS|WREGIS|PJM-GATS|NAR|ERCOT`',
    `retirement_date` DATE COMMENT 'Date on which the RECs were retired for compliance purposes or voluntarily retired. Null if RECs remain active.',
    `retirement_purpose` STRING COMMENT 'Business reason for retiring the RECs. RPS Compliance = used to meet state renewable energy mandates, Voluntary = retired for corporate sustainability goals.. Valid values are `RPS Compliance|Voluntary|Carbon Offset|Corporate Sustainability|Resale`',
    `retirement_status` STRING COMMENT 'Current lifecycle status of the REC certificates. Active = available for trading, Retired = used for compliance and no longer tradeable, Transferred = moved to another account.. Valid values are `Active|Retired|Transferred|Expired|Cancelled`',
    `trading_restriction_flag` BOOLEAN COMMENT 'Indicates whether these RECs have trading restrictions imposed by the registry or regulatory authority. True = restricted, False = freely tradeable.',
    `trading_restriction_reason` STRING COMMENT 'Explanation of why trading restrictions are in place, if applicable. Examples: pending verification, compliance hold, legal dispute.',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'Market price per individual REC certificate in US dollars. Varies by vintage, fuel type, and state eligibility.',
    `verification_date` DATE COMMENT 'Date on which the generation data was verified and approved for REC issuance.',
    `verification_status` STRING COMMENT 'Status of third-party verification of generation data before REC issuance. Verified = data approved by registry, Pending = awaiting verification.. Valid values are `Pending|Verified|Rejected|Under Review`',
    `verifier_name` STRING COMMENT 'Name of the third-party organization or individual that verified the generation data for REC issuance eligibility.',
    `vintage_year` STRING COMMENT 'Calendar year in which the renewable energy was generated. Used for RPS compliance tracking and market valuation.',
    CONSTRAINT pk_rec_issuance PRIMARY KEY(`rec_issuance_id`)
) COMMENT 'Transactional record of Renewable Energy Credit (REC) issuances generated from WTE and LFG-to-electricity facilities. Captures facility ID, generation period (start/end date), MWh quantity, REC registry (NEPOOL GIS, M-RETS, WREGIS, PJM-GATS), certificate serial number range, fuel type classification (MSW, LFG), state RPS eligibility flags, issuance date, and retirement status. SSOT for REC inventory and renewable energy attribute tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`rin_generation` (
    `rin_generation_id` BIGINT COMMENT 'Unique identifier for the RIN generation event. Primary key for the RIN generation transaction.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: RIN generation volumes are sold under RIN purchase agreements or bundled RNG sales contracts. These contracts govern pricing (fixed or market-indexed), delivery terms, and buyer obligations. Direct re',
    `facility_id` BIGINT COMMENT 'Reference to the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility where the RNG was produced.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: RIN sales under EPA RFS program generate invoices to obligated parties. Business process: D3/D5 RIN monetization requires invoicing that ties EPA EMTS transactions to financial settlement, payment ter',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: RIN generation from renewable natural gas requires tracking the originating landfill site for EPA RFS2 compliance, carbon intensity pathway verification, and LCFS credit calculations. The feedstock so',
    `lfg_collection_system_id` BIGINT COMMENT 'Identifier for the landfill gas collection system that captured the raw biogas feedstock. Applicable for landfill-based RNG projects.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: RIN generation requires EPA EMTS submissions and quarterly RFS compliance reports. Links generation to submission for RFS compliance tracking, EMTS reporting verification, and EPA audit support. Essen',
    `rng_processing_unit_id` BIGINT COMMENT 'Identifier for the specific RNG processing unit or upgrading system that produced the renewable natural gas from landfill gas or other waste feedstock.',
    `batch_number` STRING COMMENT 'Internal batch or lot number assigned to the RNG production run. Used for traceability and quality control within the facility operations.',
    `btu_content_per_scf` DECIMAL(18,2) COMMENT 'Energy content of the RNG measured in BTU per standard cubic foot. Pipeline-quality natural gas typically ranges from 950-1,050 BTU/scf. Used to calculate total energy delivered.',
    `co2_removed_tons` DECIMAL(18,2) COMMENT 'Mass of carbon dioxide removed from the raw biogas during the upgrading process to achieve pipeline quality, measured in tons. CO2 is typically vented or used for other purposes.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this RIN generation record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RIN generation record was first created in the system. Used for audit trail and data lineage tracking.',
    `d_code` STRING COMMENT 'EPA Renewable Fuel Standard D-code classification. D3 represents cellulosic biofuel (landfill gas, MSW biogas), D5 represents advanced biofuel. Determines RIN value and compliance applicability.. Valid values are `D3|D5`',
    `emts_submission_date` DATE COMMENT 'Date when the RIN generation event was submitted to the EPA EMTS system for official registration and compliance tracking.',
    `emts_transaction_number` STRING COMMENT 'Unique transaction identifier assigned by the EPA EMTS system when the RIN generation event is registered. EMTS is the official EPA system for tracking RIN generation, transfer, and retirement.',
    `epa_company_registration_number` STRING COMMENT 'EPA-issued registration number for the company generating RINs under the Renewable Fuel Standard program. Required for all RIN generation and trading activities.',
    `epa_facility_registration_number` STRING COMMENT 'EPA-issued registration number for the specific facility producing renewable fuel. Each RNG production facility must be registered with EPA to generate valid RINs.',
    `equivalence_value` DECIMAL(18,2) COMMENT 'EPA-assigned equivalence value for the fuel pathway, used to adjust RIN generation based on the fuels energy content relative to ethanol. Compressed natural gas (CNG) and liquefied natural gas (LNG) have pathway-specific EVs.',
    `feedstock_type` STRING COMMENT 'Type of organic waste feedstock used to produce the biogas that was upgraded to RNG. Common types include MSW landfill gas, separated municipal solid waste biogas, and food waste digestate.. Valid values are `MSW Landfill Gas|Biogas from Separated MSW|Biogas from Wastewater Treatment|Agricultural Waste|Food Waste`',
    `generation_date` DATE COMMENT 'The date on which the RNG was injected into the natural gas pipeline and the RINs were generated. This is the principal business event timestamp for RFS2 compliance.',
    `generation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the RNG injection and RIN generation event occurred, used for detailed operational tracking and audit trails.',
    `ghg_reduction_percent` DECIMAL(18,2) COMMENT 'Lifecycle greenhouse gas emissions reduction percentage compared to baseline petroleum fuel, as determined by the EPA-approved fuel pathway. Cellulosic biofuels (D3) typically achieve 60%+ reduction.',
    `lcfs_credit_eligible` BOOLEAN COMMENT 'Indicates whether this RNG is eligible for California Low Carbon Fuel Standard (LCFS) credits or similar state-level low-carbon fuel programs. RNG from landfills typically qualifies for LCFS credits.',
    `market_value_per_rin` DECIMAL(18,2) COMMENT 'Market trading price per RIN at the time of generation, expressed in US dollars. D3 cellulosic RINs typically command premium prices due to scarcity and higher compliance value.',
    `methane_content_percent` DECIMAL(18,2) COMMENT 'Percentage of methane (CH4) in the upgraded RNG at the time of pipeline injection. Pipeline-quality RNG typically contains 95-99% methane. Used for energy content calculation and quality verification.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this RIN generation record. Used for accountability and audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RIN generation record was last updated or modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this RIN generation event. Used for operational context and audit trail documentation.',
    `pathway_code` STRING COMMENT 'EPA-approved fuel pathway code identifying the specific production process and feedstock combination used to produce the RNG. Each pathway has a unique lifecycle greenhouse gas emissions profile.',
    `pipeline_injection_point` STRING COMMENT 'Specific location or meter station where the RNG was injected into the natural gas pipeline system. Critical for custody transfer and RIN generation documentation.',
    `pipeline_operator` STRING COMMENT 'Name of the natural gas pipeline company or operator that received the RNG injection. Required for RFS2 chain of custody documentation.',
    `qa_qc_passed` BOOLEAN COMMENT 'Indicates whether the RIN generation event passed all internal quality assurance and quality control checks, including gas quality testing, metering verification, and documentation completeness.',
    `raw_lfg_volume_scfm` DECIMAL(18,2) COMMENT 'Volume of raw landfill gas collected and fed into the RNG upgrading system, measured in standard cubic feet per minute. Used for mass balance and efficiency calculations.',
    `renewable_energy_credit_eligible` BOOLEAN COMMENT 'Indicates whether this RNG generation event is eligible for Renewable Energy Credits (RECs) in addition to RINs. Some jurisdictions allow dual crediting for renewable gas projects.',
    `rin_quantity` DECIMAL(18,2) COMMENT 'Total number of RINs generated from this RNG injection event. Each gallon equivalent of renewable fuel generates one RIN under RFS2.',
    `rin_status` STRING COMMENT 'Current lifecycle status of the RIN. Generated = newly created; Assigned = attached to fuel batch; Separated = detached for trading; Retired = used for compliance; Invalidated = voided due to error or fraud.. Valid values are `Generated|Assigned|Separated|Retired|Invalidated`',
    `rin_year` STRING COMMENT 'Calendar year in which the RIN was generated. RINs are vintage-dated and can only be used for compliance in the year generated or the following year.',
    `rng_volume_gge` DECIMAL(18,2) COMMENT 'Volume of renewable natural gas expressed in gasoline gallon equivalents (GGE), used for RIN quantity calculation under RFS2. One GGE equals approximately 0.1147 MMBtu.',
    `rng_volume_mmbtu` DECIMAL(18,2) COMMENT 'Volume of renewable natural gas injected into the pipeline, measured in million British Thermal Units (MMBtu). This is the energy content basis for RIN generation.',
    `total_rin_value_usd` DECIMAL(18,2) COMMENT 'Total estimated market value of the RINs generated in this event, calculated as RIN quantity multiplied by market value per RIN. Used for revenue recognition and financial reporting.',
    `upgrading_efficiency_percent` DECIMAL(18,2) COMMENT 'Efficiency of the biogas upgrading system in converting raw landfill gas to pipeline-quality RNG, expressed as a percentage of methane recovery. Typical systems achieve 95-98% efficiency.',
    `verification_date` DATE COMMENT 'Date when the RIN generation event was verified by a third-party auditor or internal quality assurance process, confirming compliance with EPA RFS2 requirements.',
    `verification_status` STRING COMMENT 'Status of third-party verification or internal quality assurance review for this RIN generation event. Verified RINs are eligible for trading and compliance use.. Valid values are `Pending|Verified|Rejected|Under Review`',
    `verifier_name` STRING COMMENT 'Name of the independent third-party auditor or verification body that reviewed and validated the RIN generation event for RFS2 compliance.',
    CONSTRAINT pk_rin_generation PRIMARY KEY(`rin_generation_id`)
) COMMENT 'Transactional record of Renewable Identification Number (RIN) generation events for RNG injected into the natural gas pipeline under the EPA Renewable Fuel Standard (RFS2). Captures RNG processing unit ID, generation date, volume of RNG injected (MMBtu or GGE), D-code (D3 for cellulosic biogas), RIN quantity generated, EPA registration number, pathway code, feedstock type (MSW landfill gas), and verification status. SSOT for RFS2 compliance and RIN monetization.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`offtake_agreement` (
    `offtake_agreement_id` BIGINT COMMENT 'Unique identifier for the power purchase agreement or steam sales agreement. Primary key for the offtake agreement entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Energy offtake agreements (PPAs, steam sales) require billing accounts for monthly invoicing to utility/industrial counterparties. Distinct from waste collection customers; enables AR tracking, credit',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Energy offtake agreements (electricity, steam, RNG) are specialized schedules under master service contracts. Linking to the parent contract enables tracking of amendments, renewals, legal terms, and ',
    `energy_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to energy.energy_rate_schedule. Business justification: Offtake agreements are priced according to standardized rate schedules. Currently offtake_agreement embeds pricing fields (pricing_structure, base_price, price_currency, price_escalation_rate_percent,',
    `facility_id` BIGINT COMMENT 'Reference to the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility that generates the energy sold under this agreement.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Offtake agreements are long-term energy sales contracts requiring contract lifecycle management, pricing schedule tracking, renewal management, and counterparty vendor management when offtaker is also',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Power purchase agreements and steam sales agreements specify which turbine-generator unit will deliver the energy. This is essential for capacity planning, scheduling, and settlement. The interconnect',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the offtake agreement, typically including counterparty and facility reference.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the offtake agreement, used in contracts, invoices, and regulatory filings.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the offtake agreement: draft (under negotiation), pending approval (awaiting signatures or regulatory approval), active (in force), suspended (temporarily inactive), terminated (ended early), expired (reached end date), or amended (modified and superseded). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|amended — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the offtake agreement: Power Purchase Agreement (PPA) for electricity, steam sales for industrial heat, Renewable Natural Gas (RNG) sales, Renewable Energy Credit (REC) sales, capacity agreement, or hybrid multi-product agreement.. Valid values are `PPA|steam_sales|RNG_sales|REC_sales|capacity_agreement|hybrid`',
    `contract_end_date` DATE COMMENT 'Scheduled expiration date of the offtake agreement. Null for evergreen or indefinite-term agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date when the offtake agreement becomes binding and energy deliveries may commence.',
    `contract_term_years` STRING COMMENT 'Duration of the agreement in years, calculated from contract start date to end date. Null for indefinite-term agreements.',
    `contracted_volume_annual` DECIMAL(18,2) COMMENT 'Annual contracted volume of energy to be delivered under this agreement, measured in the unit specified by contracted_volume_unit.',
    `contracted_volume_unit` STRING COMMENT 'Unit of measure for contracted energy volume: MWh (megawatt-hours) for electricity, klb (thousand pounds) or MMBtu (million British thermal units) for steam, MMBtu for RNG, REC for renewable energy credits, MW for capacity.. Valid values are `MWh|klb|MMBtu|REC|MW`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake agreement record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `curtailment_provisions` STRING COMMENT 'Description of conditions under which the offtaker may curtail or reduce energy deliveries, including notice requirements and compensation terms.',
    `delivery_obligation_type` STRING COMMENT 'Nature of the delivery commitment: firm (guaranteed delivery), as-available (best-effort), interruptible (subject to curtailment), or must-take (buyer obligated to accept all output).. Valid values are `firm|as_available|interruptible|must_take`',
    `dispute_resolution_method` STRING COMMENT 'Primary method for resolving disputes arising under this agreement: litigation in courts, binding arbitration, mediation, or good-faith negotiation.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `energy_type` STRING COMMENT 'Primary energy product sold under this agreement: electricity (MWh), steam (klb or MMBtu), Renewable Natural Gas (RNG in MMBtu), Renewable Energy Credits (RECs), capacity rights, or bundled multi-product.. Valid values are `electricity|steam|RNG|REC|capacity|bundled`',
    `environmental_attributes_included` BOOLEAN COMMENT 'Indicates whether the agreement includes transfer of environmental attributes such as carbon offsets, emission reduction credits, or sustainability certifications (True) or not (False).',
    `force_majeure_clause` STRING COMMENT 'Summary of force majeure provisions that excuse non-performance due to events beyond the parties control (natural disasters, regulatory changes, grid failures).',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement (e.g., State of New York, Province of Ontario).',
    `interconnection_point` STRING COMMENT 'Physical or logical point where energy is delivered to the offtaker, such as substation name, grid node, or pipeline interconnect identifier.',
    `maximum_delivery_limit_percent` DECIMAL(18,2) COMMENT 'Maximum percentage of contracted annual volume that the buyer is obligated to accept, above which the seller may sell excess energy to third parties.',
    `minimum_delivery_commitment_percent` DECIMAL(18,2) COMMENT 'Minimum percentage of contracted annual volume that the seller is obligated to deliver, below which penalties or liquidated damages may apply.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special provisions, or contextual information about the offtake agreement not captured in structured fields.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the offtaker must remit payment for energy delivered.',
    `performance_guarantee_required` BOOLEAN COMMENT 'Indicates whether the seller is required to provide a performance bond, letter of credit, or other financial guarantee to secure delivery obligations (True) or not (False).',
    `rec_ownership_clause` STRING COMMENT 'Specifies which party retains ownership of Renewable Energy Credits (RECs) generated by the facility: seller retains, buyer receives, shared arrangement, or negotiated per delivery.. Valid values are `seller_retains|buyer_receives|shared|negotiated`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether the agreement requires approval from a public utility commission, energy regulatory authority, or other governing body (True) or not (False).',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval process for this agreement, if applicable.. Valid values are `pending|approved|denied|not_required|under_review`',
    `renewable_attribute_transfer` BOOLEAN COMMENT 'Indicates whether renewable energy attributes (RECs, carbon credits, green tags) are transferred to the buyer (True) or retained by the seller (False).',
    `renewal_option` STRING COMMENT 'Specifies whether and how the agreement may be renewed upon expiration: automatic renewal, mutual consent required, buyer option, seller option, or no renewal provision.. Valid values are `automatic|mutual_consent|buyer_option|seller_option|none`',
    `settlement_frequency` STRING COMMENT 'Frequency at which energy deliveries are invoiced and settled: monthly, quarterly, annual, or per individual delivery.. Valid values are `monthly|quarterly|annual|per_delivery`',
    `termination_clause` STRING COMMENT 'Summary of conditions under which either party may terminate the agreement early, including notice periods, termination fees, and triggering events.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake agreement record was last modified in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    CONSTRAINT pk_offtake_agreement PRIMARY KEY(`offtake_agreement_id`)
) COMMENT 'Master record for power purchase agreements (PPAs) and steam sales agreements between Waste Management WTE facilities and utility or industrial buyers. Captures agreement ID, counterparty name, facility ID, energy type (electricity MWh, steam klb, RNG MMBtu), contracted volume, pricing structure (fixed, indexed, tiered), contract term (start/end date), interconnection point, curtailment provisions, REC ownership clause, and agreement status. SSOT for energy revenue contract terms.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Unique identifier for the energy delivery transaction. Primary key.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility that generated and delivered the energy.',
    `invoice_id` BIGINT COMMENT 'Identifier of the utility invoice or settlement statement that includes this delivery transaction.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to energy.offtake_agreement. Business justification: Energy deliveries are made under specific offtake agreements (PPAs or steam sales agreements). This link enables tracking of delivery performance against contractual commitments. The contract_id can b',
    `party_id` BIGINT COMMENT 'Identifier of the utility, industrial customer, or other counterparty receiving the delivered energy under the PPA or sales agreement.',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Each energy delivery comes from a specific turbine-generator unit. This link enables tracking of actual deliveries by asset, which is critical for settlement, performance analysis, and capacity factor',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Revenue adjustment amount due to curtailment penalties, performance bonuses, settlement true-ups, or contractual adjustments.',
    `confirmation_number` STRING COMMENT 'Confirmation or reference number provided by the offtake counterparty or grid operator acknowledging receipt of the delivered energy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this delivery record.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `curtailment_quantity` DECIMAL(18,2) COMMENT 'Volume of energy curtailed or not delivered due to grid operator instruction, equipment failure, or contractual limitation.',
    `curtailment_reason` STRING COMMENT 'Reason for any curtailment of scheduled delivery (e.g., grid operator instruction, equipment outage, contractual limit, low demand).',
    `delivery_number` STRING COMMENT 'Business-facing unique identifier for the delivery transaction, used in invoicing and settlement reconciliation.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the energy delivery transaction.. Valid values are `scheduled|in_progress|completed|curtailed|cancelled|disputed`',
    `emissions_offset_quantity` DECIMAL(18,2) COMMENT 'Quantity of greenhouse gas emissions offsets (in metric tons CO2e) associated with this renewable energy delivery, used for sustainability reporting.',
    `energy_type` STRING COMMENT 'Type of energy delivered: electricity (MWh), steam (klb or MMBtu), Renewable Natural Gas (RNG), or thermal energy.. Valid values are `electricity|steam|rng|thermal`',
    `meter_read_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement meter reading was captured for this delivery period.',
    `metered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of energy delivered as measured by settlement meter, in units appropriate to energy type (MWh, klb, MMBtu, or dekatherms).',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue amount for this delivery after all adjustments, used for financial reporting and revenue recognition.',
    `notes` STRING COMMENT 'Free-text notes capturing operational details, exceptions, or special circumstances related to this energy delivery.',
    `period_end` TIMESTAMP COMMENT 'End timestamp of the delivery period during which energy was delivered to the offtake counterparty.',
    `period_start` TIMESTAMP COMMENT 'Start timestamp of the delivery period during which energy was delivered to the offtake counterparty.',
    `point` STRING COMMENT 'Physical or logical point at which energy was delivered to the offtake counterparty (e.g., grid interconnection point, steam header, pipeline custody transfer point).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Contracted price per unit of energy delivered (e.g., dollars per MWh, dollars per klb, dollars per MMBtu) as specified in the PPA or sales agreement.',
    `quality_certification_flag` BOOLEAN COMMENT 'Indicates whether the delivered energy met all quality specifications and certifications required by the PPA or sales agreement (e.g., renewable attributes, emissions standards).',
    `rec_quantity` DECIMAL(18,2) COMMENT 'Number of Renewable Energy Credits (RECs) generated and transferred with this energy delivery, typically one REC per MWh of renewable electricity.',
    `rec_serial_numbers` STRING COMMENT 'Comma-separated list of REC serial numbers issued by the regional tracking system (e.g., M-RETS, WREGIS, PJM-GATS) for this delivery.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue recognized for this delivery, calculated as metered quantity multiplied by delivery price per unit, before adjustments.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Planned or contracted quantity of energy scheduled for delivery during the period, in units appropriate to energy type.',
    `settlement_date` DATE COMMENT 'Date on which this delivery was financially settled and reconciled with the offtake counterparty.',
    `settlement_meter_number` STRING COMMENT 'Identifier of the revenue-grade meter used to measure the delivered energy quantity for settlement and invoicing purposes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the delivered energy quantity: MWh (megawatt-hours), kWh (kilowatt-hours), klb (thousand pounds of steam), MMBtu (million British thermal units), or dekatherm.. Valid values are `MWh|kWh|klb|MMBtu|dekatherm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery record was last modified, used for audit trail and data lineage tracking.',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Transactional record of energy deliveries made to offtake counterparties under PPAs or steam sales agreements. Captures delivery period, facility ID, agreement ID, energy type, metered quantity delivered (MWh, klb, MMBtu), scheduled quantity, curtailment volume, delivery point, settlement meter read, and delivery status. Drives utility invoice reconciliation and revenue recognition under Oracle Revenue Management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` (
    `tipping_fee_receipt_id` BIGINT COMMENT 'Unique identifier for the tipping fee receipt transaction. Primary key for this entity.',
    `contract_id` BIGINT COMMENT 'Identifier of the service contract or agreement under which this tipping fee transaction was executed, if applicable.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer or hauler account responsible for payment of the tipping fee. Links to the party bringing waste to the facility.',
    `employee_id` BIGINT COMMENT 'Identifier of the facility employee who operated the scale and processed the tipping fee receipt.',
    `facility_id` BIGINT COMMENT 'Identifier of the WTE facility where the waste was received and the tipping fee was charged.',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: When hazardous waste is delivered to WTE facility for combustion, tipping fee receipt must reference the hazmat manifest for chain of custody and regulatory tracking. Links energy facility waste accep',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tipping fee receipts document waste acceptance under facility operating permit conditions (waste type restrictions, capacity limits). Links receipt to permit for permit compliance verification and ann',
    `scale_equipment_id` BIGINT COMMENT 'Identifier of the scale equipment used to weigh the inbound loaded vehicle.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Tipping receipts for waste from specific service addresses enable address-level waste stream analysis, contamination tracking, diversion rate calculation, and municipal franchise reporting by service ',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Tipping receipts for contracted customers must link to service enrollment to reconcile contracted tipping rates vs actual charges, validate service delivery against enrollment terms, and support billi',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Base tipping fee charge calculated as net weight multiplied by the tipping fee rate, before any adjustments or surcharges.',
    `contamination_flag` BOOLEAN COMMENT 'Indicator of whether the waste load contained prohibited or contaminating materials that required special handling or rejection.',
    `contamination_type` STRING COMMENT 'Description of the type of contamination found in the load, such as hazardous materials, recyclables, or prohibited items.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tipping fee receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tipping fee transaction.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the base tipping fee based on contract terms, volume commitments, or promotional programs.',
    `driver_cdl_number` STRING COMMENT 'Commercial Driver License number of the driver who delivered the load, if applicable.',
    `driver_name` STRING COMMENT 'Name of the driver who delivered the waste load to the WTE facility.',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total weight of the vehicle and waste load combined as measured on the inbound scale, expressed in tons.',
    `hauler_name` STRING COMMENT 'Name of the hauling company or entity that delivered the waste load to the WTE facility.',
    `inbound_timestamp` TIMESTAMP COMMENT 'Date and time when the loaded vehicle was weighed on the inbound scale.',
    `invoice_number` STRING COMMENT 'Invoice number generated for this tipping fee receipt transaction, linking the receipt to the billing system.',
    `load_acceptance_status` STRING COMMENT 'Operational status indicating whether the waste load met acceptance criteria and was approved for combustion.. Valid values are `accepted|rejected|conditional|quarantined`',
    `net_weight_tons` DECIMAL(18,2) COMMENT 'Actual weight of the waste load calculated as gross weight minus tare weight, expressed in tons. This is the billable quantity.',
    `notes` STRING COMMENT 'Free-form notes or comments recorded by the scale operator regarding the load, acceptance conditions, or special circumstances.',
    `origin_location` STRING COMMENT 'Geographic location or municipality from which the waste load originated.',
    `outbound_timestamp` TIMESTAMP COMMENT 'Date and time when the empty vehicle was weighed on the outbound scale.',
    `payment_status` STRING COMMENT 'Current payment status of the tipping fee charge indicating whether payment has been received.. Valid values are `unpaid|paid|partial|overdue|written_off`',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this tipping fee transaction, such as net 30 days, net 60 days, or due on receipt.. Valid values are `net_30|net_60|due_on_receipt|prepaid|credit_hold`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the tipping fee receipt transaction indicating whether the load was accepted, rejected, or requires review.. Valid values are `accepted|rejected|pending_review|voided|adjusted`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the waste load was received at the WTE facility gate and the tipping fee receipt was generated. Principal business event timestamp.',
    `rejection_reason` STRING COMMENT 'Explanation for why a waste load was rejected or conditionally accepted, such as contamination, prohibited materials, or capacity constraints.',
    `scale_ticket_number` STRING COMMENT 'Unique scale ticket number issued at the weighbridge when the load was weighed. Serves as the externally-known business identifier for this receipt transaction.. Valid values are `^[A-Z0-9]{6,20}$`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharges applied to the base tipping fee for special handling, contamination, or other factors.',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle without waste load as measured on the outbound scale, expressed in tons.',
    `tipping_fee_rate_per_ton` DECIMAL(18,2) COMMENT 'Gate fee rate charged per ton of waste accepted for combustion at the WTE facility, expressed in dollars per ton.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Final total tipping fee charge after applying all surcharges and discounts. This is the amount invoiced to the customer.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tipping fee receipt record was last modified in the system.',
    `vehicle_license_plate` STRING COMMENT 'License plate number of the vehicle that delivered the waste load.',
    `waste_subtype` STRING COMMENT 'More granular classification or description of the waste material within the primary waste type category.',
    `waste_type` STRING COMMENT 'Classification of the waste material received: MSW (Municipal Solid Waste), C&D (Construction and Demolition), special waste, or other categories.. Valid values are `MSW|C&D|special_waste|industrial|commercial|residential`',
    CONSTRAINT pk_tipping_fee_receipt PRIMARY KEY(`tipping_fee_receipt_id`)
) COMMENT 'Transactional record of waste tipping fee receipts at WTE facilities — the gate fee charged per ton of MSW or C&D waste accepted for combustion. Captures receipt date, facility ID, hauler/customer account ID, waste type (MSW, C&D, special waste), gross weight (tons), tare weight, net weight, tipping fee rate ($/ton), total charge, scale ticket number, and load acceptance status. Supports WTE gate revenue tracking and waste throughput management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` (
    `combustion_operating_log_id` BIGINT COMMENT 'Unique identifier for the combustion operating log record. Primary key for daily boiler unit operational records.',
    `boiler_unit_id` BIGINT COMMENT 'Identifier of the specific boiler combustion unit being logged. Each WTE facility may have multiple boiler units.',
    `employee_id` BIGINT COMMENT 'Identifier of the certified boiler operator responsible for this operating period. Required for OSHA and operational accountability.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy facility where the boiler unit is located.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Daily operating logs provide activity data (MSW throughput, fuel consumption, emissions) required for GHG inventory calculations. EPA GHGRP requires linking operational records to emission calculation',
    `ghg_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.ghg_regulatory_submission. Business justification: Operating logs provide source data for annual GHGRP submissions (fuel consumption, operating hours). Links log to GHG submission for data traceability, emissions calculations, and audit support. Essen',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Operating logs provide source data for Title V reports, annual emissions inventories, and permit renewal applications. Links log to submission for data traceability, compliance verification, and regul',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the operator shift during which this log entry was recorded. Links to workforce shift schedule.',
    `auxiliary_fuel_consumption_gallons` DECIMAL(18,2) COMMENT 'Volume of auxiliary fuel (typically diesel or natural gas) consumed in gallons to support combustion startup, shutdown, or maintain minimum temperature. Tracked for cost and emissions accounting.',
    `availability_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of time the boiler unit was available for operation excluding planned outages. Key performance indicator for operational reliability. Calculated as (24 - forced_outage_hours) / 24 * 100.',
    `bottom_ash_tons` DECIMAL(18,2) COMMENT 'Total tons of bottom ash residue removed from the furnace grate during the operating date. Requires proper handling and disposal per RCRA regulations.',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Carbon intensity score representing grams of CO2 equivalent per megajoule of energy produced. Used for Low Carbon Fuel Standard (LCFS) credit calculations and sustainability reporting.',
    `cems_data_availability_percent` DECIMAL(18,2) COMMENT 'Percentage of time the Continuous Emissions Monitoring System was operational and providing valid data during the operating date. Required to meet 95% quarterly availability per EPA regulations.',
    `co_emissions_pounds` DECIMAL(18,2) COMMENT 'Total pounds of carbon monoxide emitted during the operating date. Indicator of combustion efficiency and air quality compliance.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether all emissions and operational parameters were within permitted limits during the operating date. False indicates an exceedance or deviation requiring reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this combustion operating log record was first created in the system. Audit trail for data lineage and regulatory compliance.',
    `deviation_reported_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any permit deviations or exceedances were formally reported to regulatory authorities for this operating date.',
    `dioxin_furan_emissions_ng_per_dscm` DECIMAL(18,2) COMMENT 'Concentration of dioxins and furans in stack emissions measured in nanograms per dry standard cubic meter. Highly regulated toxic compounds requiring continuous monitoring.',
    `energy_output_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy generated by the turbine-generator set in megawatt hours during the operating date. Primary revenue and performance metric for WTE operations.',
    `excess_air_percent` DECIMAL(18,2) COMMENT 'Percentage of excess air supplied to the combustion process beyond stoichiometric requirements. Affects combustion efficiency and emissions profile.',
    `fly_ash_tons` DECIMAL(18,2) COMMENT 'Total tons of fly ash captured by air pollution control equipment during the operating date. May require special handling as hazardous waste depending on TCLP test results.',
    `forced_outage_hours` DECIMAL(18,2) COMMENT 'Hours of unplanned downtime due to equipment failure, emergency shutdown, or unscheduled maintenance during the operating date. Impacts availability factor calculation.',
    `furnace_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Average furnace combustion chamber temperature in degrees Fahrenheit during the operating period. Critical parameter for combustion efficiency and emissions control.',
    `gross_heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Gross heat rate representing the thermal efficiency of the combustion and energy conversion process measured in BTU per kWh. Lower values indicate higher efficiency.',
    `hcl_emissions_pounds` DECIMAL(18,2) COMMENT 'Total pounds of hydrogen chloride emitted during the operating date. Acid gas requiring scrubber control and regulatory monitoring.',
    `mercury_emissions_pounds` DECIMAL(18,2) COMMENT 'Total pounds of mercury emitted during the operating date. Toxic metal requiring activated carbon injection and stringent monitoring per MACT standards.',
    `msw_throughput_tons` DECIMAL(18,2) COMMENT 'Total tons of Municipal Solid Waste fed into the boiler unit during the operating date. Primary input measurement for combustion process.',
    `notes` STRING COMMENT 'Free-text field for operator notes, observations, or explanations of unusual conditions, equipment issues, or operational decisions during the logged period.',
    `nox_emissions_pounds` DECIMAL(18,2) COMMENT 'Total pounds of nitrogen oxides emitted during the operating date. Monitored for Clean Air Act compliance and air quality permit requirements.',
    `opacity_percent` DECIMAL(18,2) COMMENT 'Average stack opacity percentage during the operating date. Visual indicator of particulate emissions and air pollution control system performance.',
    `operating_date` DATE COMMENT 'The calendar date for which this operating log entry records combustion activity. Primary business event timestamp for daily operational reporting.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total hours the boiler unit was in active combustion operation during the operating date. Used to calculate availability and utilization metrics.',
    `operational_status` STRING COMMENT 'Current operational status of the boiler unit during the logged period. Indicates the mode of operation for performance analysis and regulatory reporting.. Valid values are `normal_operation|startup|shutdown|standby|maintenance|emergency_shutdown`',
    `particulate_matter_emissions_pounds` DECIMAL(18,2) COMMENT 'Total pounds of particulate matter emitted during the operating date. Monitored for Clean Air Act compliance and public health protection.',
    `planned_outage_hours` DECIMAL(18,2) COMMENT 'Hours of scheduled downtime for preventive maintenance, inspections, or planned repairs during the operating date. Excluded from availability factor calculation.',
    `rec_credits_generated` DECIMAL(18,2) COMMENT 'Number of Renewable Energy Credits generated during the operating date based on qualifying renewable energy output. One REC typically equals one MWh of renewable electricity.',
    `so2_emissions_pounds` DECIMAL(18,2) COMMENT 'Total pounds of sulfur dioxide emitted during the operating date. Monitored for Clean Air Act compliance and acid rain program requirements.',
    `steam_flow_klb` DECIMAL(18,2) COMMENT 'Total steam flow generated by the boiler unit measured in thousand pounds. Key output metric for energy generation performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this combustion operating log record was last modified. Audit trail for data lineage and change tracking.',
    CONSTRAINT pk_combustion_operating_log PRIMARY KEY(`combustion_operating_log_id`)
) COMMENT 'Transactional daily operating log for each WTE boiler unit capturing combustion process parameters. Records operating date, boiler unit ID, MSW throughput (tons), operating hours, steam flow (klb), furnace temperature (°F), excess air percentage, auxiliary fuel consumption (gallons), forced outage hours, planned outage hours, availability factor (%), and operator shift ID. Primary operational record for boiler performance management and regulatory reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` (
    `air_pollution_control_unit_id` BIGINT COMMENT 'Unique identifier for the air pollution control device. Primary key for the APC unit master record.',
    `boiler_unit_id` BIGINT COMMENT 'Reference to the specific boiler or combustion unit that this APC device serves.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: APC units are inspected during facility compliance inspections for equipment condition and performance. Links unit to inspection for inspection preparation, finding resolution, and compliance verifica',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: APC units are part of emission source infrastructure; their operational status and removal efficiency affect emission calculations and compliance. Links control equipment to emission source registry f',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: APC units are capitalized equipment requiring asset management for depreciation, warranty tracking, capital project allocation, and retirement planning. Financial reporting and regulatory compliance a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Air pollution control units at WTE facilities operate under air quality permits managed in the compliance domain. This link enables tracking of permit conditions, compliance status, and renewal requir',
    `facility_id` BIGINT COMMENT 'Reference to the WTE facility where this APC unit is installed.',
    `stack_id` BIGINT COMMENT 'Reference to the emission stack where this APC unit is installed for exhaust gas treatment.',
    `actual_removal_efficiency_percent` DECIMAL(18,2) COMMENT 'Measured pollutant removal efficiency percentage based on continuous emissions monitoring system (CEMS) data or stack testing results.',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Estimated or actual annual operating cost for the APC unit, including reagent consumption, energy, maintenance, and labor.',
    `caa_compliance_status` STRING COMMENT 'Current compliance status of the APC unit with respect to Clean Air Act Title V permit requirements and emission limits.. Valid values are `compliant|non_compliant|pending_review|conditional`',
    `cems_integration_flag` BOOLEAN COMMENT 'Indicates whether this APC unit is integrated with a continuous emission monitoring system for real-time performance tracking and regulatory reporting.',
    `commissioning_date` DATE COMMENT 'Date when the APC unit was officially placed into operational service and began treating emissions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this APC unit record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the APC unit was permanently taken out of service and decommissioned. Null if the unit is still in service.',
    `design_capacity_scfm` DECIMAL(18,2) COMMENT 'Design gas flow capacity of the APC unit in standard cubic feet per minute. Represents the maximum exhaust gas volume the unit can treat under design conditions.',
    `design_removal_efficiency_percent` DECIMAL(18,2) COMMENT 'Manufacturer-specified pollutant removal efficiency percentage for this APC unit under design operating conditions. Critical for permit compliance calculations.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'Total capital cost of installing the APC unit, including equipment, labor, and commissioning expenses. Used for capital project tracking and asset valuation.',
    `installation_date` DATE COMMENT 'Date when the APC unit was installed and commissioned at the facility. Critical for tracking equipment age and depreciation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection of the APC unit. Required for CAA Title V permit compliance tracking.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the APC unit.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or original equipment manufacturer (OEM) of the APC unit.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the APC unit. Used for parts procurement and maintenance planning.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the APC unit per regulatory or internal maintenance schedules.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity on the APC unit.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, maintenance history, or special considerations related to the APC unit.',
    `operating_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Typical operating temperature of the APC unit in degrees Fahrenheit. Critical for performance monitoring and maintenance planning.',
    `operational_status` STRING COMMENT 'Current operational status of the APC unit. Operational indicates active use, standby indicates ready but not currently treating emissions, maintenance indicates undergoing scheduled or unscheduled maintenance, out of service indicates temporarily offline, and decommissioned indicates permanently retired.. Valid values are `operational|standby|maintenance|out_of_service|decommissioned`',
    `pollutant_target` STRING COMMENT 'Primary pollutant that this APC unit is designed to control. Common targets include NOx (nitrogen oxides), SOx (sulfur oxides), particulate matter (PM), mercury (Hg), dioxins/furans, HCl (hydrogen chloride), CO (carbon monoxide), and VOC (volatile organic compounds). [ENUM-REF-CANDIDATE: nox|sox|particulate_matter|mercury|dioxins_furans|hcl|co|voc — 8 candidates stripped; promote to reference product]',
    `pressure_drop_inches_h2o` DECIMAL(18,2) COMMENT 'Pressure drop across the APC unit measured in inches of water column. Indicates filter loading and system resistance.',
    `reagent_consumption_rate` DECIMAL(18,2) COMMENT 'Average reagent consumption rate in pounds per hour or tons per day, depending on operational scale. Used for inventory management and cost tracking.',
    `reagent_consumption_uom` STRING COMMENT 'Unit of measure for reagent consumption rate reporting.. Valid values are `lbs_per_hour|tons_per_day|gallons_per_hour|kg_per_hour`',
    `reagent_type` STRING COMMENT 'Type of chemical reagent used by the APC unit for pollutant removal. Common reagents include urea (for SNCR), ammonia (for SCR), lime or hydrated lime (for acid gas scrubbing), activated carbon (for mercury and dioxin removal), and sodium bicarbonate (for dry scrubbing). [ENUM-REF-CANDIDATE: urea|ammonia|lime|hydrated_lime|activated_carbon|sodium_bicarbonate|none — 7 candidates stripped; promote to reference product]',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this APC unit is integrated with the facility SCADA system for remote monitoring and control.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific APC unit.',
    `technology_type` STRING COMMENT 'Type of air pollution control technology employed by this unit. Common types include SNCR (Selective Non-Catalytic Reduction), SCR (Selective Catalytic Reduction), ACI (Activated Carbon Injection), fabric filter baghouse, electrostatic precipitator, and dry scrubber systems.. Valid values are `selective_non_catalytic_reduction|selective_catalytic_reduction|activated_carbon_injection|fabric_filter_baghouse|electrostatic_precipitator|dry_scrubber`',
    `unit_code` STRING COMMENT 'Business identifier code for the APC unit, typically used in operational systems and permit documentation.',
    `unit_name` STRING COMMENT 'Descriptive name of the APC unit for operational reference and reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this APC unit record was last modified in the system.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the APC unit expires. Important for maintenance planning and cost forecasting.',
    CONSTRAINT pk_air_pollution_control_unit PRIMARY KEY(`air_pollution_control_unit_id`)
) COMMENT 'Master record for each air pollution control (APC) device installed on WTE facility stacks. Captures unit ID, associated boiler/stack ID, APC technology type (selective non-catalytic reduction SNCR, activated carbon injection ACI, fabric filter baghouse, dry scrubber, wet scrubber), design removal efficiency (%), reagent type (urea, lime, activated carbon), installation date, last inspection date, and operational status. Required for CAA Title V permit compliance tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`cems_instrument` (
    `cems_instrument_id` BIGINT COMMENT 'Unique identifier for the CEMS instrument record. Primary key.',
    `air_pollution_control_unit_id` BIGINT COMMENT 'Reference to the air pollution control unit associated with this CEMS instrument for monitoring post-treatment emissions.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Continuous Emissions Monitoring System instruments monitor specific boiler units. While CEMS instruments are installed on stacks (already linked), they monitor the emissions from specific boiler units',
    `facility_id` BIGINT COMMENT 'Reference to the WTE facility where this CEMS instrument is installed.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: CEMS instruments are serialized capital assets requiring tracking for calibration schedules, warranty management, depreciation, and replacement planning. Asset management systems need this link for ma',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: CEMS instruments are installed to satisfy specific permit monitoring conditions (Part 75, Part 60). Links instrument to permit for monitoring requirement fulfillment, compliance verification, and regu',
    `stack_id` BIGINT COMMENT 'Reference to the specific emission stack where this CEMS instrument is mounted.',
    `accuracy_specification_percent` DECIMAL(18,2) COMMENT 'Manufacturer-specified accuracy of the CEMS instrument as a percentage of the measurement range.',
    `analyzer_principle` STRING COMMENT 'The analytical principle or technology used by the CEMS instrument (e.g., NDIR, UV, chemiluminescence, paramagnetic, electrochemical).',
    `calibration_frequency_days` STRING COMMENT 'Required frequency in days for routine calibration of this CEMS instrument per regulatory and manufacturer requirements.',
    `certification_date` DATE COMMENT 'Date when the CEMS instrument received initial certification from the regulatory authority (EPA or state agency) per 40 CFR Part 75.',
    `certification_status` STRING COMMENT 'Current certification status of the CEMS instrument with the regulatory authority.. Valid values are `Certified|Provisional|Expired|Pending|Decertified`',
    `commissioning_date` DATE COMMENT 'Date when the CEMS instrument was commissioned and began operational data collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CEMS instrument record was first created in the system.',
    `das_channel_number` STRING COMMENT 'Specific channel or input number on the DAS to which this CEMS instrument is connected.',
    `das_reference` STRING COMMENT 'Reference identifier or tag for the Data Acquisition System (DAS) that collects and processes data from this CEMS instrument.',
    `data_reporting_frequency_minutes` STRING COMMENT 'Frequency in minutes at which this CEMS instrument reports data to the DAS and regulatory reporting systems.',
    `decommission_date` DATE COMMENT 'Date when the CEMS instrument was decommissioned and removed from active service.',
    `epa_protocol_gas_required` BOOLEAN COMMENT 'Indicates whether EPA protocol gas is required for calibration and QA/QC testing of this CEMS instrument.',
    `installation_date` DATE COMMENT 'Date when the CEMS instrument was physically installed at the facility stack.',
    `instrument_code` STRING COMMENT 'Unique business identifier or tag code for the CEMS instrument, used for operational reference and reporting.',
    `instrument_name` STRING COMMENT 'Descriptive name of the CEMS instrument for operational identification.',
    `instrument_type` STRING COMMENT 'The technology type of the CEMS instrument (e.g., Extractive, Dilution, In-Situ, Ultrasonic Flow, Differential Pressure).. Valid values are `Extractive|Dilution|In-Situ|Ultrasonic Flow|Differential Pressure`',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration performed on the CEMS instrument.',
    `last_qa_qc_audit_date` DATE COMMENT 'Date of the most recent QA/QC audit performed on this CEMS instrument, including RATA (Relative Accuracy Test Audit), linearity checks, and calibration error tests.',
    `maintenance_contract_number` STRING COMMENT 'Reference number for the maintenance service contract covering this CEMS instrument.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer of the CEMS instrument.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Maximum value of the measurement range for this CEMS instrument, in the unit of measure specified.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Minimum value of the measurement range for this CEMS instrument, in the unit of measure specified.',
    `model_number` STRING COMMENT 'Manufacturer model number of the CEMS instrument.',
    `next_qa_qc_audit_due_date` DATE COMMENT 'Scheduled date for the next required QA/QC audit to maintain certification compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this CEMS instrument.',
    `operational_status` STRING COMMENT 'Current operational status of the CEMS instrument indicating whether it is actively monitoring, under maintenance, or decommissioned.. Valid values are `Operational|Out of Service|Under Maintenance|Calibration|Decommissioned`',
    `part_60_applicable` BOOLEAN COMMENT 'Indicates whether this CEMS instrument is subject to 40 CFR Part 60 New Source Performance Standards (NSPS) requirements.',
    `part_75_applicable` BOOLEAN COMMENT 'Indicates whether this CEMS instrument is subject to 40 CFR Part 75 acid rain program requirements.',
    `pollutant_monitored` STRING COMMENT 'The specific pollutant or parameter that this CEMS instrument is designed to monitor (e.g., NOx, SO2, CO, HCl, O2, Particulate Matter, Mercury, Flow). [ENUM-REF-CANDIDATE: NOx|SO2|CO|HCl|O2|Particulate Matter|Mercury|Flow — 8 candidates stripped; promote to reference product]',
    `rata_frequency_months` STRING COMMENT 'Required frequency in months for conducting RATA tests on this CEMS instrument per regulatory requirements.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether data from this CEMS instrument is required for regulatory reporting to EPA or state agencies.',
    `response_time_seconds` DECIMAL(18,2) COMMENT 'Time in seconds for the CEMS instrument to respond to a step change in the measured parameter.',
    `sampling_method` STRING COMMENT 'Description of the sampling method used by the CEMS instrument (e.g., extractive probe, dilution probe, in-situ optical path).',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific CEMS instrument unit.',
    `span_gas_concentration` DECIMAL(18,2) COMMENT 'Concentration value of the span gas used for calibration of this CEMS instrument, in the unit of measure specified.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the pollutant or parameter monitored by this CEMS instrument (e.g., ppm, ppb, mg/m3, lb/MMBtu, percent, scfm, acfm). [ENUM-REF-CANDIDATE: ppm|ppb|mg/m3|lb/MMBtu|percent|scfm|acfm — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CEMS instrument record was last updated in the system.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for this CEMS instrument expires.',
    `zero_gas_concentration` DECIMAL(18,2) COMMENT 'Concentration value of the zero gas used for calibration of this CEMS instrument, typically zero or near-zero.',
    CONSTRAINT pk_cems_instrument PRIMARY KEY(`cems_instrument_id`)
) COMMENT 'Master record for each Continuous Emissions Monitoring System (CEMS) instrument installed at a WTE facility stack. Captures instrument ID, associated stack and APC unit, pollutant monitored (NOx, SO2, CO, HCl, O2, flow), instrument manufacturer, model, serial number, certification date, last QA/QC audit date, data acquisition system (DAS) reference, and operational status. Required for 40 CFR Part 75 and Part 60 CEMS certification tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` (
    `ghg_emission_factor_id` BIGINT COMMENT 'Unique identifier for the greenhouse gas emission factor record.',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: Energy domain maintains WTE-specific emission factors; sustainability uses these for inventory calculations. Both domains should reference same factor library to ensure consistency in GHG calculations',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Emission factors are mandated by specific regulatory requirements (40 CFR Part 98, state rules). Links factor to requirement for emissions calculation methodology, regulatory compliance verification, ',
    `superseded_by_factor_ghg_emission_factor_id` BIGINT COMMENT 'Reference to the emission factor ID that supersedes this factor when it expires, enabling traceability of factor evolution.',
    `applicable_facility_types` STRING COMMENT 'Types of Waste-to-Energy (WTE) or landfill facilities for which this emission factor is applicable, such as mass burn WTE, modular WTE, landfill gas-to-energy (LFG-to-RNG), or flare systems.',
    `biogenic_flag` BOOLEAN COMMENT 'Indicates whether this emission factor applies to biogenic carbon emissions (from biomass or organic waste) which are reported separately from fossil carbon emissions in many GHG accounting frameworks.',
    `calculation_methodology` STRING COMMENT 'Description of the calculation methodology or approach used to derive this emission factor, including any assumptions, measurement techniques, or modeling approaches.',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Carbon intensity score in grams of CO2 equivalent per megajoule (gCO2e/MJ) associated with this emission source, used for Low Carbon Fuel Standard (LCFS) and similar programs.',
    `combustion_efficiency_percent` DECIMAL(18,2) COMMENT 'Assumed combustion efficiency percentage used in deriving this emission factor, representing the completeness of fuel combustion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission factor record was first created in the system.',
    `data_quality_tier` STRING COMMENT 'IPCC data quality tier classification indicating the level of detail and accuracy of the emission factor: Tier 1 (default factors), Tier 2 (country-specific), Tier 3 (facility-specific measurements), Tier 4 (continuous monitoring).. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `effective_date` DATE COMMENT 'Date from which this emission factor becomes valid and should be used for greenhouse gas calculations.',
    `emission_factor_value` DECIMAL(18,2) COMMENT 'Numeric value of the emission factor used to calculate greenhouse gas emissions from the specified source.',
    `emission_source_category` STRING COMMENT 'Category of the emission source for which this factor applies, such as Municipal Solid Waste (MSW) combustion, Landfill Gas (LFG) flaring, Renewable Natural Gas (RNG) combustion, or fossil fuel auxiliary use.. Valid values are `msw_combustion|lfg_flare|lfg_combustion|rng_combustion|fossil_fuel_auxiliary|diesel_combustion`',
    `expiry_date` DATE COMMENT 'Date after which this emission factor is no longer valid and should not be used for greenhouse gas calculations. Null indicates the factor is currently active with no planned expiration.',
    `factor_code` STRING COMMENT 'Business identifier code for the emission factor, used for external reference and reporting.',
    `factor_name` STRING COMMENT 'Descriptive name of the emission factor identifying the source and GHG type.',
    `fuel_feedstock_type` STRING COMMENT 'Type of fuel or feedstock material for which this emission factor is applicable, such as Municipal Solid Waste (MSW), Landfill Gas (LFG), Solid Recovered Fuel (SRF), diesel, or natural gas.',
    `geographic_applicability` STRING COMMENT 'Geographic region or jurisdiction where this emission factor is applicable, such as USA, specific state codes, or international regions.',
    `ghg_type` STRING COMMENT 'Type of greenhouse gas covered by this emission factor: Carbon Dioxide (CO2), Methane (CH4), Nitrous Oxide (N2O), or Carbon Dioxide Equivalent (CO2e).. Valid values are `co2|ch4|n2o|co2e`',
    `global_warming_potential` DECIMAL(18,2) COMMENT 'Global Warming Potential over a 100-year time horizon (GWP100) used to convert the GHG to CO2 equivalent. CO2 = 1, CH4 = 25-28, N2O = 265-298 depending on IPCC assessment report version.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions regarding the application, limitations, or context of this emission factor.',
    `oxidation_factor` DECIMAL(18,2) COMMENT 'Fraction of carbon in the fuel that is oxidized to CO2 during combustion, typically between 0.95 and 1.00.',
    `renewable_energy_credit_eligible` BOOLEAN COMMENT 'Indicates whether emissions calculated using this factor are eligible for renewable energy credit (REC) or renewable identification number (RIN) generation programs.',
    `scope_classification` STRING COMMENT 'GHG Protocol scope classification for emissions calculated using this factor: Scope 1 (direct emissions), Scope 2 (indirect emissions from purchased energy), or Scope 3 (other indirect emissions).. Valid values are `scope_1|scope_2|scope_3`',
    `source_document_reference` STRING COMMENT 'Specific document, section, or table reference within the source authority where this emission factor is published.',
    `technology_type` STRING COMMENT 'Specific technology or process type to which this emission factor applies, such as mass burn combustion, modular combustion, flare type, or engine type.',
    `uncertainty_percent` DECIMAL(18,2) COMMENT 'Estimated uncertainty or confidence interval percentage associated with this emission factor value, representing measurement and estimation variability.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the emission factor value, such as kilograms per ton (kg/ton), kilograms per million British thermal units (kg/MMBtu), kilograms per megawatt-hour (kg/MWh), kilograms per gallon, or kilograms per standard cubic foot (kg/scf).. Valid values are `kg_per_ton|kg_per_mmbtu|kg_per_mwh|kg_per_gallon|kg_per_scf`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission factor record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when this emission factor was last verified or validated by a third-party auditor or regulatory authority.',
    `verification_status` STRING COMMENT 'Status indicating whether this emission factor has been verified by a third-party auditor or regulatory authority for use in compliance reporting.. Valid values are `verified|unverified|pending_verification|third_party_verified`',
    `verifier_organization` STRING COMMENT 'Name of the third-party organization or regulatory body that verified or validated this emission factor.',
    `version_number` STRING COMMENT 'Version identifier for this emission factor, used to track updates and revisions over time as methodologies and scientific understanding evolve.',
    CONSTRAINT pk_ghg_emission_factor PRIMARY KEY(`ghg_emission_factor_id`)
) COMMENT 'Reference table of greenhouse gas (GHG) emission factors used to calculate CO2e emissions from WTE combustion, LFG flaring, and RNG combustion. Captures factor ID, emission source category (MSW combustion, LFG flare, fossil fuel auxiliary), GHG type (CO2, CH4, N2O), emission factor value, unit (kg/ton, kg/MMBtu), global warming potential (GWP100), source authority (EPA AP-42, IPCC AR6, state-specific), effective date, and expiry date. Supports GHG inventory and sustainability reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` (
    `energy_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the energy rate schedule. Primary key for this reference table.',
    `facility_id` BIGINT COMMENT 'Identifier of the WTE facility or LFG-to-energy site that generates energy sold under this rate schedule. Links to the facility master data.',
    `approval_date` DATE COMMENT 'Date on which this rate schedule was approved by internal management or regulatory authority. Null for draft schedules.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or authority who approved this rate schedule. Typically a senior finance or commercial officer.',
    `base_rate` DECIMAL(18,2) COMMENT 'The base price per unit of energy under this schedule, expressed in the currency and unit specified. For fixed schedules this is the contract rate; for indexed schedules this may be the floor or reference rate.',
    `capacity_payment_included` BOOLEAN COMMENT 'Indicates whether this rate schedule includes a separate capacity payment component in addition to energy payments. Relevant for electricity PPAs with capacity markets. True if capacity payments are included, false otherwise.',
    `contract_type` STRING COMMENT 'Type of commercial arrangement this rate schedule supports. PPA is Power Purchase Agreement for electricity, offtake is long-term gas sales agreement, spot is short-term market sales, utility tariff is regulated rate, and bilateral is negotiated contract.. Valid values are `ppa|offtake|spot|utility_tariff|bilateral`',
    `counterparty_name` STRING COMMENT 'Name of the buyer or off-taker organization that this rate schedule applies to. The entity purchasing energy under this pricing arrangement.',
    `counterparty_type` STRING COMMENT 'Classification of the energy buyer. Utility is investor-owned or public utility, industrial is large manufacturing customer, commercial is business customer, aggregator is energy broker/marketer, ISO market is wholesale market participation, and municipal is government entity.. Valid values are `utility|industrial|commercial|aggregator|iso_market|municipal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this rate schedule. Typically USD for U.S. operations.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date on which this rate schedule becomes active and applicable to energy sales transactions. Start of the rate schedule validity period.',
    `energy_type` STRING COMMENT 'Type of energy product covered by this rate schedule. Electricity refers to WTE electrical generation, steam to thermal energy sales, RNG to renewable natural gas from landfill gas processing, LFG to raw landfill gas, and thermal to combined heat products.. Valid values are `electricity|steam|rng|lfg|thermal`',
    `environmental_attribute_treatment` STRING COMMENT 'Specifies how environmental attributes such as RECs, carbon credits, LCFS credits, and RINs are allocated between buyer and seller under this rate schedule. Bundled means attributes transfer with energy, unbundled means sold separately, seller/buyer retains indicates which party keeps the attributes, and shared indicates negotiated split.. Valid values are `bundled|unbundled|seller_retains|buyer_retains|shared`',
    `escalation_mechanism` STRING COMMENT 'Method by which the rate schedule adjusts over time. CPI ties to Consumer Price Index, fixed percent applies a contractual annual increase, market indexed follows commodity or power market indices, negotiated annual requires bilateral agreement each period, and none indicates a flat rate for the contract term.. Valid values are `none|cpi|fixed_percent|market_indexed|negotiated_annual`',
    `escalation_rate_percent` DECIMAL(18,2) COMMENT 'Annual escalation percentage applied to the base rate when escalation mechanism is fixed percent. Null for non-fixed escalation types.',
    `expiration_date` DATE COMMENT 'The date on which this rate schedule ceases to be valid. Null for open-ended or evergreen rate schedules. End of the rate schedule validity period.',
    `index_reference` STRING COMMENT 'Specific market index or benchmark used for indexed pricing. Examples include ISO-NE Day-Ahead LMP Hub, Henry Hub Natural Gas Spot Price, or specific node/zone pricing points. Null for non-indexed schedules.',
    `market_iso` STRING COMMENT 'The Independent System Operator or Regional Transmission Organization market applicable to this rate schedule for electricity products. ISO-NE is ISO New England, PJM is PJM Interconnection, MISO is Midcontinent ISO, CAISO is California ISO, ERCOT is Electric Reliability Council of Texas, SPP is Southwest Power Pool, NYISO is New York ISO. None applies to non-electricity products or bilateral contracts outside ISO markets. [ENUM-REF-CANDIDATE: iso_ne|pjm|miso|caiso|ercot|spp|nyiso|none — 8 candidates stripped; promote to reference product]',
    `maximum_quantity` DECIMAL(18,2) COMMENT 'Maximum energy quantity allowed per period under this rate schedule, expressed in the unit specified by rate_unit. Null if no maximum applies.',
    `minimum_quantity` DECIMAL(18,2) COMMENT 'Minimum energy quantity commitment per period required under this rate schedule, expressed in the unit specified by rate_unit. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications regarding this rate schedule. Used for business context not captured in structured fields.',
    `pricing_basis` STRING COMMENT 'Fundamental pricing mechanism for the rate schedule. Fixed indicates a set dollar per unit rate, LMP-indexed ties to locational marginal pricing in wholesale electricity markets, Henry Hub-indexed follows natural gas commodity pricing for RNG, cost-plus adds margin to production costs, negotiated reflects bilateral contract terms, and tariff follows regulatory-approved rates.. Valid values are `fixed|lmp_indexed|henry_hub_indexed|cost_plus|negotiated|tariff`',
    `rate_unit` STRING COMMENT 'Unit of measure for the base rate. USD per MWh for electricity, USD per thousand pounds for steam, USD per million BTU or therm or dekatherm for gas products.. Valid values are `usd_per_mwh|usd_per_klb|usd_per_mmbtu|usd_per_therm|usd_per_dth`',
    `rec_bundled` BOOLEAN COMMENT 'Indicates whether Renewable Energy Credits are bundled with the energy sale under this rate schedule or sold separately. True if RECs are bundled with energy, false if unbundled or not applicable.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory body or jurisdiction that oversees this rate schedule, if applicable. Examples include state public utility commissions, FERC for wholesale markets, or none for unregulated bilateral contracts.',
    `schedule_code` STRING COMMENT 'Business identifier code for the rate schedule used in contracts and billing systems. Unique alphanumeric code assigned to each pricing schedule.. Valid values are `^[A-Z0-9]{4,12}$`',
    `schedule_name` STRING COMMENT 'Descriptive name of the energy rate schedule for business reference and reporting purposes.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule. Draft indicates under development, active means currently in use, suspended means temporarily inactive, expired means past expiration date, and superseded means replaced by a newer schedule.. Valid values are `draft|active|suspended|expired|superseded`',
    `settlement_frequency` STRING COMMENT 'Frequency at which energy deliveries and payments are settled under this rate schedule. Hourly for real-time markets, daily for day-ahead, monthly for typical utility billing, quarterly or annual for long-term contracts.. Valid values are `hourly|daily|monthly|quarterly|annual`',
    `tariff_reference` STRING COMMENT 'Reference to the regulatory tariff, docket number, or public utility commission filing that governs this rate schedule. Applicable for utility-regulated energy sales.',
    `time_of_use_applicable` BOOLEAN COMMENT 'Indicates whether this rate schedule includes time-of-use pricing with different rates for peak, off-peak, and shoulder periods. True if TOU pricing applies, false otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_energy_rate_schedule PRIMARY KEY(`energy_rate_schedule_id`)
) COMMENT 'Reference table of energy pricing rate schedules applicable to WTE electricity sales, steam sales, and RNG offtake agreements. Captures rate schedule ID, energy type, pricing basis (fixed $/MWh, LMP-indexed, Henry Hub-indexed), base rate, escalation mechanism (CPI, fixed %), applicable ISO/market (ISO-NE, PJM, MISO), effective date, expiry date, and associated regulatory tariff reference. Supports energy revenue forecasting and contract pricing validation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`planned_outage` (
    `planned_outage_id` BIGINT COMMENT 'Unique identifier for the planned maintenance outage record. Primary key for the planned outage entity.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Planned maintenance outages are often scheduled for specific boiler units. While planned_outage already links to fixed_asset (generic), adding a direct link to boiler_unit enables boiler-specific outa',
    `employee_id` BIGINT COMMENT 'Identifier of the internal supervisor or maintenance manager responsible for overseeing the planned outage execution and ensuring work completion.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility where the outage is planned.',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the specific asset (boiler, turbine-generator, or Renewable Natural Gas (RNG) unit) undergoing the planned outage.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Major outages involve significant parts/services procurement; direct PO link enables outage cost tracking, vendor performance correlation with downtime duration, capital project budget reconciliation,',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Planned outages may require advance notification to air quality agencies and inclusion in annual deviation reports. Links outage to submission for regulatory notification tracking, deviation reporting',
    `turbine_generator_id` BIGINT COMMENT 'Foreign key linking to energy.turbine_generator. Business justification: Planned maintenance outages are often scheduled for specific turbine-generator units. This link enables turbine-specific outage tracking, coordination with offtake agreements, and generation availabil',
    `vendor_id` BIGINT COMMENT 'Identifier of the external contractor or vendor responsible for performing the planned outage maintenance work, if applicable. References vendor master data.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order (WO) in the Enterprise Asset Management (EAM) system (e.g., Infor EAM) that governs the execution of the planned outage activities.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost incurred for the planned outage in United States Dollars (USD), captured after outage completion. Used for variance analysis and future cost estimation improvement.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration of the outage in hours, calculated from actual start and end dates. Used to measure schedule adherence and improve future planning accuracy.',
    `actual_end_date` DATE COMMENT 'Actual date when the planned outage work was completed and the asset was returned to service. Used to calculate actual outage duration and variance from plan.',
    `actual_lost_generation_mwh` DECIMAL(18,2) COMMENT 'Actual energy generation lost during the outage period in megawatt-hours (MWh), calculated from actual outage duration and asset capacity.',
    `actual_start_date` DATE COMMENT 'Actual date when the planned outage work commenced. May differ from planned start date due to operational or weather conditions.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the planned outage was cancelled, if applicable (e.g., asset failure requiring emergency repair, regulatory exemption granted, scope change).',
    `completion_notes` STRING COMMENT 'Summary notes documenting the outcome of the planned outage after completion, including work performed, issues encountered, deviations from plan, and recommendations for future outages.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the planned outage record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this planned outage is on the critical path for facility operations, meaning any delay would directly impact the facilitys ability to meet generation commitments or regulatory deadlines. True if critical path, False otherwise.',
    `environmental_impact_assessment_flag` BOOLEAN COMMENT 'Indicates whether an environmental impact assessment was conducted for the planned outage to evaluate potential emissions, waste generation, or environmental risks during maintenance activities. True if assessment performed, False otherwise.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost of the planned outage in United States Dollars (USD), including labor, materials, contractor fees, and lost revenue from generation downtime. Used for budget planning and cost-benefit analysis.',
    `estimated_lost_generation_mwh` DECIMAL(18,2) COMMENT 'Estimated energy generation lost during the planned outage period in megawatt-hours (MWh). Used for revenue impact analysis and utility settlement planning.',
    `outage_number` STRING COMMENT 'Business-assigned unique identifier or reference number for the planned outage, used for tracking and communication with utility operators and internal stakeholders.',
    `outage_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the planned outage (e.g., boiler tube inspection, turbine blade replacement, emissions testing, regulatory compliance). Aligns with NERC GADS cause codes where applicable.',
    `outage_reason_description` STRING COMMENT 'Detailed narrative description of the reason for the planned outage, including specific maintenance activities, inspections, or regulatory requirements driving the outage.',
    `outage_status` STRING COMMENT 'Current lifecycle status of the planned outage: planned (initial state), scheduled (confirmed with utility), in progress (work underway), completed (work finished and asset returned to service), cancelled, or postponed.. Valid values are `planned|scheduled|in progress|completed|cancelled|postponed`',
    `outage_type` STRING COMMENT 'Classification of the planned outage based on its purpose: annual overhaul (major maintenance), scheduled inspection, regulatory test (compliance-driven), preventive maintenance (PM), component replacement, or performance optimization.. Valid values are `annual overhaul|scheduled inspection|regulatory test|preventive maintenance|component replacement|performance optimization`',
    `permit_number` STRING COMMENT 'Environmental or operating permit number associated with the planned outage, if the outage is required to maintain permit compliance (e.g., air quality permit, operating permit).',
    `planned_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration of the planned outage in hours, calculated from planned start and end dates. Used for resource planning and generation availability forecasting.',
    `planned_end_date` DATE COMMENT 'Scheduled date when the planned outage is expected to be completed and the asset returned to operational service.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the planned outage is expected to begin. Used for generation availability planning and utility notification.',
    `postponement_reason` STRING COMMENT 'Explanation for why the planned outage was postponed or rescheduled, if applicable (e.g., weather conditions, parts unavailability, utility request, operational priority change).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the planned outage is driven by regulatory compliance requirements (e.g., Clean Air Act (CAA) emissions testing, boiler inspection mandated by state environmental agency). True if compliance-driven, False otherwise.',
    `safety_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal safety plan is required for the planned outage due to hazardous work conditions (e.g., confined space entry, hot work, high voltage). True if safety plan required, False otherwise.',
    `scope_of_work` STRING COMMENT 'Detailed description of the maintenance activities, inspections, tests, and component replacements to be performed during the planned outage. Defines the work scope for planning and execution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the planned outage record was last modified. Used for audit trail and tracking changes to outage schedule or status.',
    `utility_approval_date` DATE COMMENT 'Date when the utility operator or ISO formally approved the planned outage schedule.',
    `utility_approval_status` STRING COMMENT 'Status of utility or ISO approval for the planned outage: pending (awaiting response), approved (outage confirmed), conditional (approved with restrictions), or denied (outage must be rescheduled).. Valid values are `pending|approved|conditional|denied`',
    `utility_notification_date` DATE COMMENT 'Date when the utility operator or Independent System Operator (ISO) was formally notified of the planned outage, as required by interconnection agreements and grid reliability standards.',
    CONSTRAINT pk_planned_outage PRIMARY KEY(`planned_outage_id`)
) COMMENT 'Transactional record of planned maintenance outages for WTE boilers, turbine-generators, and LFG-to-energy units. Captures outage ID, asset ID (boiler, turbine, or RNG unit), facility ID, outage type (annual overhaul, scheduled inspection, regulatory test), planned start date, planned end date, actual start date, actual end date, estimated lost generation (MWh), outage reason code, responsible work order reference, and outage status. Supports generation availability planning and utility notification compliance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`reagent_consumption` (
    `reagent_consumption_id` BIGINT COMMENT 'Unique identifier for the reagent consumption transaction record.',
    `air_pollution_control_unit_id` BIGINT COMMENT 'Identifier of the specific Air Pollution Control unit that consumed the reagent.',
    `boiler_unit_id` BIGINT COMMENT 'Identifier of the boiler unit associated with this reagent consumption event.',
    `employee_id` BIGINT COMMENT 'Identifier of the facility operator or technician who recorded or supervised the reagent consumption.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste-to-Energy (WTE) facility where the reagent was consumed.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Reagent purchases are high-volume recurring procurement; direct PO link enables consumption-to-invoice three-way match, unit cost variance analysis, supplier performance tracking by consumption effici',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the operational shift during which the reagent was consumed.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier who provided the reagent.',
    `boiler_operating_hours` DECIMAL(18,2) COMMENT 'The number of hours the associated boiler unit operated during the consumption period, used to normalize reagent usage rates.',
    `co_emissions_lbs` DECIMAL(18,2) COMMENT 'The pounds of carbon monoxide emitted during the consumption period.',
    `consumption_date` DATE COMMENT 'The date on which the reagent was consumed in the APC system.',
    `consumption_method` STRING COMMENT 'The method by which the reagent was introduced into the APC system (e.g., automatic injection, manual feed, batch addition).. Valid values are `automatic_injection|manual_feed|batch_addition`',
    `consumption_rate_per_ton_msw` DECIMAL(18,2) COMMENT 'The reagent consumption rate normalized per ton of MSW processed, a key performance indicator for APC efficiency.',
    `consumption_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the reagent consumption was recorded, supporting real-time monitoring and compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reagent consumption record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality or reliability of the consumption data (e.g., verified, estimated, provisional, suspect).. Valid values are `verified|estimated|provisional|suspect`',
    `data_source` STRING COMMENT 'The source system or method from which the consumption data was captured (e.g., SCADA, manual entry, inventory system, CEMS).. Valid values are `scada|manual_entry|inventory_system|cems`',
    `emissions_compliance_flag` BOOLEAN COMMENT 'Indicates whether the reagent consumption achieved the required emissions compliance targets during the period (True = compliant, False = non-compliant).',
    `hcl_emissions_lbs` DECIMAL(18,2) COMMENT 'The pounds of hydrochloric acid emitted during the consumption period, tracked to assess reagent effectiveness in acid gas removal.',
    `inventory_transaction_number` STRING COMMENT 'The identifier of the inventory transaction in the ERP system that recorded the reagent withdrawal from stock.',
    `mercury_emissions_lbs` DECIMAL(18,2) COMMENT 'The pounds of mercury emitted during the consumption period, tracked to assess activated carbon effectiveness in heavy metal capture.',
    `msw_feedstock_tons` DECIMAL(18,2) COMMENT 'The tons of Municipal Solid Waste processed during the consumption period, used to calculate reagent consumption per ton of waste.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the reagent consumption event, including any operational anomalies or special circumstances.',
    `nox_emissions_lbs` DECIMAL(18,2) COMMENT 'The pounds of nitrogen oxides emitted during the consumption period, tracked to assess reagent effectiveness in NOx reduction.',
    `particulate_matter_lbs` DECIMAL(18,2) COMMENT 'The pounds of particulate matter emitted during the consumption period.',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'The quantity of reagent consumed during the specified period.',
    `reagent_lot_number` STRING COMMENT 'The lot or batch number of the reagent consumed, enabling traceability to supplier shipment and quality specifications.',
    `reagent_name` STRING COMMENT 'The commercial or chemical name of the reagent consumed.',
    `reagent_type` STRING COMMENT 'The type of Air Pollution Control reagent consumed (e.g., lime for acid gas removal, urea for NOx reduction, activated carbon for mercury and dioxin capture).. Valid values are `lime|urea|activated_carbon|sodium_bicarbonate|ammonia|other`',
    `record_status` STRING COMMENT 'The current status of the consumption record (e.g., active, voided, corrected, archived).. Valid values are `active|voided|corrected|archived`',
    `so2_emissions_lbs` DECIMAL(18,2) COMMENT 'The pounds of sulfur dioxide emitted during the consumption period, tracked to assess reagent effectiveness in acid gas removal.',
    `storage_location` STRING COMMENT 'The physical storage location or warehouse code from which the reagent was withdrawn.',
    `total_cost_usd` DECIMAL(18,2) COMMENT 'The total cost of the reagent consumed in this transaction, calculated as quantity consumed multiplied by unit cost, expressed in US dollars.',
    `unit_cost_usd` DECIMAL(18,2) COMMENT 'The cost per unit of measure for the reagent consumed, expressed in US dollars.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity consumed (e.g., tons, gallons, pounds).. Valid values are `tons|gallons|pounds|kilograms|liters`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this reagent consumption record was last modified.',
    CONSTRAINT pk_reagent_consumption PRIMARY KEY(`reagent_consumption_id`)
) COMMENT 'Transactional record of APC reagent consumption at WTE facilities, tracking usage of lime, urea, activated carbon, and other pollution control chemicals. Captures consumption date, facility ID, APC unit ID, reagent type, quantity consumed (tons or gallons), reagent lot number, supplier reference, unit cost ($/ton), and associated boiler operating hours. Supports emissions compliance cost tracking and reagent inventory management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`rec_transaction` (
    `rec_transaction_id` BIGINT COMMENT 'Unique identifier for the REC transaction record. Primary key for the rec_transaction data product.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: REC transactions execute under master trading agreements (for recurring trades) or spot sale contracts. These contracts govern pricing terms, settlement procedures, and dispute resolution. Direct refe',
    `facility_id` BIGINT COMMENT 'Reference to the Waste-to-Energy (WTE) or Landfill Gas-to-Energy (LFG) facility that generated the underlying renewable energy for these RECs.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: REC sales to compliance buyers generate formal invoices for financial settlement. Business process: environmental attribute monetization requires invoicing with payment terms, AR tracking, and ASC 606',
    `rec_issuance_id` BIGINT COMMENT 'Reference to the REC issuance batch from which these RECs originated. Links to the original generation and certification event.',
    `renewable_energy_credit_id` BIGINT COMMENT 'Foreign key linking to sustainability.renewable_energy_credit. Business justification: REC transactions (sales, retirements) in energy domain update status of renewable_energy_credit records in sustainability. Links trading activity to ESG accounting for Scope 2 market-based emissions a',
    `broker_fee_usd` DECIMAL(18,2) COMMENT 'The fee paid to a broker or intermediary for facilitating the REC transaction, in United States Dollars. Zero if transaction was direct without broker involvement.',
    `contract_reference_number` STRING COMMENT 'Reference to the master REC purchase agreement, power purchase agreement (PPA), or sales contract under which this transaction was executed. Used for contract compliance tracking and revenue allocation.',
    `counterparty_account_number` STRING COMMENT 'The registry account number or identifier of the counterparty receiving or purchasing the RECs. Used for registry transfer verification and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this REC transaction record was first created in the system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `eligibility_state` STRING COMMENT 'The U.S. state(s) for which these RECs are eligible for Renewable Portfolio Standard (RPS) compliance, using two-letter state abbreviations (e.g., CA, NY, MA). Multiple states may be comma-separated if RECs qualify in multiple jurisdictions.',
    `emissions_avoided_co2e_tons` DECIMAL(18,2) COMMENT 'The estimated greenhouse gas emissions avoided (in metric tons of CO2 equivalent) by the renewable energy generation represented by these RECs, compared to conventional fossil fuel generation. Used for sustainability reporting and carbon accounting.',
    `fuel_type` STRING COMMENT 'The renewable fuel source that generated the electricity for these RECs. MSW = Municipal Solid Waste (Waste-to-Energy combustion); LFG = Landfill Gas; biogas = anaerobic digestion gas; biomass = organic material combustion; solar = photovoltaic or thermal; wind = wind turbine; hydro = hydroelectric; geothermal = geothermal steam. [ENUM-REF-CANDIDATE: MSW|LFG|biogas|biomass|solar|wind|hydro|geothermal|other — 9 candidates stripped; promote to reference product]',
    `generation_period_end_date` DATE COMMENT 'The end date of the generation period for the renewable energy that created these RECs. Defines the end of the time window during which the underlying MWh were produced.',
    `generation_period_start_date` DATE COMMENT 'The start date of the generation period for the renewable energy that created these RECs. Defines the beginning of the time window during which the underlying MWh were produced.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, or operational notes related to this REC transaction. May include information about transaction amendments, dispute resolution, or unique circumstances.',
    `rec_quantity_mwh` DECIMAL(18,2) COMMENT 'The quantity of RECs transacted, measured in megawatt-hours (MWh). One REC typically represents one MWh of renewable electricity generation. This is the primary unit of measure for REC transactions.',
    `registry_name` STRING COMMENT 'The name of the renewable energy tracking registry system in which this REC transaction was recorded. M-RETS = Midwest Renewable Energy Tracking System; NAR = North American Renewables Registry; NEPOOL-GIS = New England Power Pool Generation Information System; WREGIS = Western Renewable Energy Generation Information System; PJM-GATS = PJM Generation Attribute Tracking System; ERCOT = Electric Reliability Council of Texas; NC-RETS = North Carolina Renewable Energy Tracking System; MIRECS = Michigan Renewable Energy Certification System. [ENUM-REF-CANDIDATE: M-RETS|NAR|NEPOOL-GIS|WREGIS|PJM-GATS|ERCOT|NC-RETS|MIRECS|other — 9 candidates stripped; promote to reference product]',
    `registry_transaction_number` STRING COMMENT 'The unique transaction identifier assigned by the REC tracking registry system (e.g., M-RETS, NAR, NEPOOL GIS, WREGIS) that recorded this transaction. Used for external audit and verification.',
    `retirement_date` DATE COMMENT 'The date on which the RECs were permanently retired in the tracking registry. Null if RECs have not been retired. Retirement is irreversible and removes RECs from tradable inventory.',
    `retirement_purpose` STRING COMMENT 'The stated purpose or beneficiary for which the RECs were retired (e.g., state RPS compliance, voluntary green power program, corporate sustainability commitment, carbon offset program). Null if not retired.',
    `retirement_status` STRING COMMENT 'Current lifecycle status of the RECs in this transaction. Active = available for trading; Retired = permanently retired for compliance or voluntary purposes; Transferred = moved to another account; Expired = past eligibility window; Cancelled = invalidated due to error or fraud.. Valid values are `active|retired|transferred|expired|cancelled`',
    `rps_compliance_period` STRING COMMENT 'The state RPS compliance period (typically a calendar year or program year) for which these RECs may be applied. Format varies by state program (e.g., 2024, 2023-2024, Q4-2023).',
    `settlement_date` DATE COMMENT 'The date on which the REC transaction was settled and payment/delivery completed. May differ from transaction date for forward contracts or delayed settlements.',
    `settlement_status` STRING COMMENT 'Current status of the financial and registry settlement for this transaction. Pending = awaiting completion; Settled = payment and registry transfer complete; Failed = settlement did not complete; Disputed = under review or contested; Reversed = transaction was reversed or unwound.. Valid values are `pending|settled|failed|disputed|reversed`',
    `technology_type` STRING COMMENT 'The specific renewable energy generation technology used (e.g., mass burn WTE, modular WTE, LFG-to-electricity, LFG-to-RNG, anaerobic digestion). Provides additional detail beyond fuel_type for technology-specific RPS tiers or market segmentation.',
    `total_transaction_value_usd` DECIMAL(18,2) COMMENT 'The total monetary value of the REC transaction in United States Dollars, calculated as rec_quantity_mwh multiplied by unit_price_usd. Represents gross revenue for sales or gross cost for purchases before any fees or adjustments.',
    `trading_restriction_flag` BOOLEAN COMMENT 'Boolean indicator of whether these RECs have trading restrictions imposed by state regulations, contract terms, or registry rules. True = restrictions apply; False = freely tradable.',
    `trading_restriction_reason` STRING COMMENT 'Description of the trading restriction if trading_restriction_flag is true. Examples include state geographic eligibility limits, vintage year restrictions, technology tier requirements, or contractual hold periods.',
    `transaction_date` DATE COMMENT 'The date on which the REC transaction was executed and legally binding. This is the business event date used for revenue recognition and compliance period assignment.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number assigned by Waste Management for tracking and reconciliation purposes. Used in financial reporting and customer communications.',
    `transaction_type` STRING COMMENT 'Classification of the REC transaction activity. Sale = monetization to third party; Retirement = voluntary or compliance retirement; Transfer = internal movement between accounts; Banking = holding for future compliance period; Forward_sale = pre-sold future vintage; Spot_sale = immediate delivery sale.. Valid values are `sale|retirement|transfer|banking|forward_sale|spot_sale`',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'The price per REC (per MWh) in United States Dollars. For sales, this is the selling price; for purchases, this is the acquisition cost. Zero for retirements and internal transfers.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this REC transaction record was last modified in the system. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verification_date` DATE COMMENT 'The date on which third-party verification or audit of this REC transaction was completed. Null if verification was not performed or is still pending.',
    `verification_status` STRING COMMENT 'Status of third-party verification or audit of the REC transaction for compliance or quality assurance purposes. Verified = passed independent review; Pending_verification = under review; Failed_verification = did not pass audit; Not_required = verification not mandated for this transaction type.. Valid values are `verified|pending_verification|failed_verification|not_required`',
    `verifier_name` STRING COMMENT 'Name of the independent third-party organization that verified or audited this REC transaction, if applicable. Null if verification was not performed or not required.',
    `vintage_year` STRING COMMENT 'The calendar year in which the underlying renewable energy was generated. RECs are typically organized and traded by vintage year for compliance and market segmentation purposes.',
    CONSTRAINT pk_rec_transaction PRIMARY KEY(`rec_transaction_id`)
) COMMENT 'Transactional record of REC sales, retirements, and transfers executed by Waste Management for WTE and LFG-to-electricity generation. Captures transaction ID, REC issuance reference, transaction type (sale, retirement, transfer, banking), counterparty, transaction date, quantity (MWh), price ($/REC), registry transaction ID, state RPS compliance period, and settlement status. SSOT for REC monetization and state renewable portfolio standard (RPS) compliance tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`lcfs_credit` (
    `lcfs_credit_id` BIGINT COMMENT 'Unique identifier for the LCFS credit transaction record.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: LCFS credits are sold under credit purchase agreements that specify pricing, delivery schedules, and CARB reporting obligations. Direct contract reference is required for revenue recognition, buyer in',
    `facility_id` BIGINT COMMENT 'Reference to the waste management facility where the RNG was produced.',
    `rng_processing_unit_id` BIGINT COMMENT 'Reference to the RNG processing unit that generated the fuel qualifying for LCFS credits.',
    `buyer_carb_account_number` STRING COMMENT 'CARB account number of the buyer organization in the LCFS credit trading system.',
    `carb_transaction_number` STRING COMMENT 'Official CARB system transaction identifier for credit generation or transfer.',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Carbon intensity score in grams of carbon dioxide equivalent per megajoule (gCO2e/MJ) for the RNG fuel pathway. Lower scores generate more credits.',
    `compliance_year` STRING COMMENT 'Calendar year for which the LCFS credits apply toward compliance obligations.',
    `contract_reference_number` STRING COMMENT 'Reference number of the sales or transfer contract associated with the LCFS credit transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the LCFS credit record was first created in the system.',
    `credit_serial_number` STRING COMMENT 'Unique serial number assigned by CARB to this LCFS credit issuance.',
    `credit_status` STRING COMMENT 'Current lifecycle status of the LCFS credit in the CARB tracking system.. Valid values are `generated|verified|transferred|retired|invalidated|pending`',
    `feedstock_type` STRING COMMENT 'Type of organic waste feedstock used to produce the RNG qualifying for LCFS credits.. Valid values are `landfill_gas|dairy_biogas|wastewater_biogas|agricultural_waste|food_waste`',
    `fuel_pathway_code` STRING COMMENT 'CARB-approved fuel pathway code identifying the specific production process and feedstock for the RNG. Determines the carbon intensity baseline for credit calculation.',
    `fuel_use_type` STRING COMMENT 'End-use application of the RNG fuel for LCFS credit eligibility.. Valid values are `transportation|stationary|blended`',
    `generation_date` DATE COMMENT 'Date when the LCFS credits were officially generated and issued by CARB.',
    `ghg_emissions_avoided_co2e_tons` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions avoided by using RNG instead of conventional fossil fuel, measured in metric tons of CO2 equivalent.',
    `invoice_number` STRING COMMENT 'Invoice number for the LCFS credit sale or transfer transaction.',
    `market_value_usd` DECIMAL(18,2) COMMENT 'Total market value of the LCFS credits at the time of generation or transfer.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the LCFS credit transaction, verification, or compliance status.',
    `oregon_cfp_credit_quantity` DECIMAL(18,2) COMMENT 'Quantity of Oregon CFP credits generated from the same RNG volume, if applicable.',
    `oregon_cfp_eligible_flag` BOOLEAN COMMENT 'Indicates whether the RNG fuel and credits are also eligible for Oregon Clean Fuels Program credits.',
    `quantity` DECIMAL(18,2) COMMENT 'Total quantity of LCFS credits generated from the RNG volume, calculated based on carbon intensity reduction and energy content.',
    `reporting_period_end_date` DATE COMMENT 'End date of the quarterly reporting period for which the LCFS credits were generated.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the quarterly reporting period for which the LCFS credits were generated.',
    `retirement_date` DATE COMMENT 'Date when the LCFS credits were retired to meet compliance obligations.',
    `retirement_purpose` STRING COMMENT 'Reason for retiring the LCFS credits from circulation.. Valid values are `compliance|voluntary|invalidation`',
    `rin_generation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the RNG fuel is also eligible for EPA Renewable Identification Number (RIN) generation under the Renewable Fuel Standard.',
    `rng_volume_dge` DECIMAL(18,2) COMMENT 'Volume of renewable natural gas expressed in diesel gallon equivalents for standardized energy content comparison.',
    `rng_volume_mmbtu` DECIMAL(18,2) COMMENT 'Volume of renewable natural gas produced and used as transportation fuel during the reporting period, measured in million British thermal units.',
    `transaction_type` STRING COMMENT 'Type of LCFS credit transaction recorded in this entry.. Valid values are `generation|transfer_sale|transfer_purchase|retirement|adjustment`',
    `transfer_date` DATE COMMENT 'Date when the LCFS credits were transferred to a buyer or trading partner.',
    `unit_price_usd` DECIMAL(18,2) COMMENT 'Price per LCFS credit unit in US dollars.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the LCFS credit record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date when the credit generation was verified by a CARB-approved third-party verifier.',
    `verifier_name` STRING COMMENT 'Name of the CARB-accredited third-party verification body that verified the credit generation.',
    `vintage_year` STRING COMMENT 'Year in which the RNG fuel was produced and the credits were generated.',
    CONSTRAINT pk_lcfs_credit PRIMARY KEY(`lcfs_credit_id`)
) COMMENT 'Transactional record of Low Carbon Fuel Standard (LCFS) credits generated from RNG produced at Waste Management LFG-to-RNG projects and used as transportation fuel. Captures credit ID, RNG processing unit ID, reporting period, fuel pathway code (CARB-approved), carbon intensity (CI) score (gCO2e/MJ), RNG volume (MMBtu), LCFS credit quantity, CARB transaction ID, credit status (generated, transferred, retired), and buyer reference. Supports California LCFS and Oregon CFP compliance and credit revenue.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`stack` (
    `stack_id` BIGINT COMMENT 'Primary key for stack',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Stacks are associated with specific boiler units - each boiler exhausts through a dedicated stack (or multiple boilers may share a common stack). This link enables tracking of which boilers emissions',
    `wte_facility_id` BIGINT COMMENT 'Reference to the Waste-to-Energy (WTE) facility where this stack is located. Links to the facility master data.',
    `linked_stack_id` BIGINT COMMENT 'Self-referencing FK on stack (linked_stack_id)',
    `air_pollution_control_device_type` STRING COMMENT 'Primary type of air pollution control equipment installed upstream of this stack to reduce emissions before discharge to atmosphere.',
    `cems_certification_date` DATE COMMENT 'Date when the CEMS was last certified or recertified by regulatory authorities, demonstrating compliance with accuracy and quality assurance requirements.',
    `cems_next_recertification_date` DATE COMMENT 'Scheduled date for the next required CEMS recertification to maintain regulatory compliance and measurement accuracy.',
    `continuous_emissions_monitoring_system_installed` BOOLEAN COMMENT 'Indicates whether a Continuous Emissions Monitoring System is installed on this stack for real-time pollutant measurement and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stack record was first created in the system, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `decommission_date` DATE COMMENT 'Date when the emission stack was permanently taken out of service and decommissioned. Marks the end of regulatory reporting obligations for this asset.',
    `design_flow_rate_cubic_meters_per_hour` DECIMAL(18,2) COMMENT 'Maximum designed volumetric flow rate of exhaust gases through the stack, measured in cubic meters per hour at standard conditions. Used for capacity planning and permit limits.',
    `emission_limit_co_pounds_per_hour` DECIMAL(18,2) COMMENT 'Maximum permitted emission rate for carbon monoxide from this stack, measured in pounds per hour. Indicator of combustion efficiency and regulatory compliance.',
    `emission_limit_dioxin_furan_nanograms_per_cubic_meter` DECIMAL(18,2) COMMENT 'Maximum permitted emission concentration for dioxins and furans from this stack, measured in nanograms per dry standard cubic meter. Stringent limit for toxic organic compounds.',
    `emission_limit_hcl_pounds_per_hour` DECIMAL(18,2) COMMENT 'Maximum permitted emission rate for hydrogen chloride from this stack, measured in pounds per hour. Acid gas control requirement for waste combustion.',
    `emission_limit_mercury_pounds_per_hour` DECIMAL(18,2) COMMENT 'Maximum permitted emission rate for mercury from this stack, measured in pounds per hour. Hazardous air pollutant limit under Clean Air Act.',
    `emission_limit_nox_pounds_per_hour` DECIMAL(18,2) COMMENT 'Maximum permitted emission rate for nitrogen oxides from this stack, measured in pounds per hour. Regulatory limit enforced under Clean Air Act.',
    `emission_limit_particulate_matter_pounds_per_hour` DECIMAL(18,2) COMMENT 'Maximum permitted emission rate for particulate matter from this stack, measured in pounds per hour. Critical for air quality compliance.',
    `emission_limit_so2_pounds_per_hour` DECIMAL(18,2) COMMENT 'Maximum permitted emission rate for sulfur dioxide from this stack, measured in pounds per hour. Regulatory limit enforced under Clean Air Act.',
    `exit_temperature_celsius` DECIMAL(18,2) COMMENT 'Average temperature of exhaust gases at the stack exit point, measured in degrees Celsius. Critical for buoyancy calculations in dispersion modeling.',
    `exit_velocity_meters_per_second` DECIMAL(18,2) COMMENT 'Average velocity of exhaust gases exiting the stack, measured in meters per second. Key parameter for dispersion modeling and regulatory compliance calculations.',
    `inspection_frequency_months` STRING COMMENT 'Required frequency for conducting structural and safety inspections of the emission stack, measured in months between inspections.',
    `installation_date` DATE COMMENT 'Date when the emission stack was originally installed and commissioned at the facility. Determines applicability of New Source Performance Standards.',
    `last_inspection_date` DATE COMMENT 'Date when the most recent structural or safety inspection of the emission stack was completed.',
    `last_modification_date` DATE COMMENT 'Date when the stack or associated air pollution control equipment underwent significant modification that may trigger new regulatory requirements.',
    `last_stack_test_date` DATE COMMENT 'Date when the most recent comprehensive stack emission test was conducted by certified third-party testing firm.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the stack location in decimal degrees. Used for air dispersion modeling and regulatory reporting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the stack location in decimal degrees. Used for air dispersion modeling and regulatory reporting.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured or constructed the emission stack and associated structural components.',
    `material_construction` STRING COMMENT 'Primary construction material of the emission stack, determining durability, corrosion resistance, and maintenance requirements.',
    `model_number` STRING COMMENT 'Manufacturer model or design specification number for the emission stack, used for maintenance and parts procurement.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required structural or safety inspection of the emission stack.',
    `next_stack_test_due_date` DATE COMMENT 'Scheduled date for the next required comprehensive stack emission test to maintain regulatory compliance.',
    `notes` STRING COMMENT 'Additional operational notes, special conditions, or historical information about the emission stack that may be relevant for operations or compliance.',
    `opacity_limit_percent` DECIMAL(18,2) COMMENT 'Maximum permitted visible opacity of stack emissions, measured as a percentage. Visual indicator of particulate emissions and combustion quality.',
    `operational_status` STRING COMMENT 'Current operational state of the emission stack in its lifecycle. Determines whether the stack is actively emitting, temporarily offline, or permanently retired.',
    `permit_expiration_date` DATE COMMENT 'Date when the current air permit expires, requiring renewal or modification to continue operations legally.',
    `permit_issue_date` DATE COMMENT 'Date when the current air permit was issued by the regulatory authority, establishing the effective start of permit conditions.',
    `permit_number` STRING COMMENT 'Regulatory air permit number issued by the environmental authority governing emissions from this stack. Links to permit compliance requirements and emission limits.',
    `stack_diameter_meters` DECIMAL(18,2) COMMENT 'Internal diameter of the emission stack at the discharge point, measured in meters. Used for calculating exit velocity and dispersion characteristics.',
    `stack_height_meters` DECIMAL(18,2) COMMENT 'Physical height of the emission stack measured in meters from ground level to the top of the discharge point. Critical parameter for dispersion modeling and regulatory compliance.',
    `stack_name` STRING COMMENT 'Human-readable name or designation for the emission stack, used for operational identification and communication.',
    `stack_number` STRING COMMENT 'Business identifier for the emission stack, typically assigned by facility operations or regulatory authorities. Used in operational documentation and compliance reporting.',
    `stack_testing_frequency_months` STRING COMMENT 'Required frequency for conducting comprehensive stack emission testing, measured in months between tests. Regulatory compliance requirement.',
    `stack_type` STRING COMMENT 'Classification of the emission stack based on its primary function within the WTE facility operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stack record was last modified in the system, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_stack PRIMARY KEY(`stack_id`)
) COMMENT 'Master reference table for stack. Referenced by stack_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`energy`.`ash_sample` (
    `ash_sample_id` BIGINT COMMENT 'Primary key for ash_sample',
    `facility_id` BIGINT COMMENT 'Reference to the WTE facility where the ash sample was collected.',
    `regulatory_submission_id` BIGINT COMMENT 'Reference to the regulatory compliance report that includes data from this ash sample.',
    `resample_ash_sample_id` BIGINT COMMENT 'Self-referencing FK on ash_sample (resample_ash_sample_id)',
    `analysis_complete_timestamp` TIMESTAMP COMMENT 'Date and time when all laboratory testing and analysis of the ash sample was completed.',
    `analysis_start_timestamp` TIMESTAMP COMMENT 'Date and time when laboratory testing and analysis of the ash sample commenced.',
    `archived_location` STRING COMMENT 'Physical storage location identifier where the retained ash sample is archived for future reference or re-testing.',
    `arsenic_concentration_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of arsenic detected in the ash sample leachate, measured in milligrams per liter.',
    `ash_type` STRING COMMENT 'Classification of ash based on collection point in the combustion process. Bottom ash is collected from furnace bottom, fly ash from flue gas, combined ash is mixed residue.',
    `beneficial_reuse_eligible` BOOLEAN COMMENT 'Indicator of whether the ash sample meets quality criteria for beneficial reuse applications such as aggregate substitute, cement additive, or road base material.',
    `cadmium_concentration_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of cadmium detected in the ash sample leachate, measured in milligrams per liter.',
    `carbon_content_percent` DECIMAL(18,2) COMMENT 'Percentage of unburned carbon remaining in the ash sample, indicating combustion efficiency.',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number documenting the chronological documentation of sample handling from collection through analysis to ensure sample integrity.',
    `chloride_content_mg_per_kg` DECIMAL(18,2) COMMENT 'Concentration of chloride ions in the ash sample, measured in milligrams per kilogram, relevant for corrosion assessment and beneficial reuse applications.',
    `chromium_concentration_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of chromium detected in the ash sample leachate, measured in milligrams per liter.',
    `collected_by` STRING COMMENT 'Name or identifier of the technician or operator who collected the ash sample.',
    `collection_point` STRING COMMENT 'Specific equipment location or system component where the ash sample was collected (e.g., Boiler 2 Bottom Hopper, ESP Unit 3, Baghouse Outlet).',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the ash sample was physically collected from the facility equipment.',
    `compliance_flag` BOOLEAN COMMENT 'Indicator of whether the ash sample test results meet all applicable environmental regulatory requirements and permit conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ash sample record was first created in the data system.',
    `disposal_method` STRING COMMENT 'Planned or actual method for final disposition of the ash material represented by this sample.',
    `heavy_metals_detected` BOOLEAN COMMENT 'Indicator of whether heavy metals (lead, cadmium, mercury, chromium, arsenic, etc.) were detected above regulatory thresholds in the ash sample.',
    `laboratory_code` BIGINT COMMENT 'Reference to the laboratory facility responsible for analyzing this ash sample.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ash sample record was most recently updated in the data system.',
    `lead_concentration_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of lead detected in the ash sample leachate, measured in milligrams per liter.',
    `mercury_concentration_mg_per_l` DECIMAL(18,2) COMMENT 'Concentration of mercury detected in the ash sample leachate, measured in milligrams per liter.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the ash sample at time of collection, measured as weight percent.',
    `non_compliance_reason` STRING COMMENT 'Detailed explanation of why the ash sample failed to meet regulatory compliance standards, if applicable.',
    `ph_level` DECIMAL(18,2) COMMENT 'Measure of acidity or alkalinity of the ash sample on a scale of 0-14, where 7 is neutral.',
    `quality_control_passed` BOOLEAN COMMENT 'Indicator of whether the laboratory analysis passed internal quality control checks including blanks, duplicates, and spike recoveries.',
    `received_at_lab_timestamp` TIMESTAMP COMMENT 'Date and time when the ash sample was received and logged into the laboratory information system.',
    `retention_expiry_date` DATE COMMENT 'Date when the archived ash sample may be disposed of per regulatory retention requirements.',
    `sample_notes` STRING COMMENT 'Free-text field for additional observations, special handling instructions, or contextual information about the ash sample.',
    `sample_number` STRING COMMENT 'Externally-known unique identifier or barcode for the ash sample used for tracking and laboratory reference.',
    `sample_status` STRING COMMENT 'Current state of the ash sample in its lifecycle from collection through final disposition.',
    `sample_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the ash sample collected, measured in kilograms.',
    `sulfate_content_mg_per_kg` DECIMAL(18,2) COMMENT 'Concentration of sulfate compounds in the ash sample, measured in milligrams per kilogram.',
    `test_method` STRING COMMENT 'Standard analytical method or protocol used for testing the ash sample (e.g., EPA Method 1311 TCLP, ASTM D3987).',
    `toxicity_characteristic` STRING COMMENT 'Classification indicating whether the ash sample exhibits hazardous waste characteristics based on Toxicity Characteristic Leaching Procedure (TCLP) testing per RCRA regulations.',
    CONSTRAINT pk_ash_sample PRIMARY KEY(`ash_sample_id`)
) COMMENT 'Master reference table for ash_sample. Referenced by sample_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ADD CONSTRAINT `fk_energy_turbine_generator_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ADD CONSTRAINT `fk_energy_rng_processing_unit_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ADD CONSTRAINT `fk_energy_generation_reading_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_cems_instrument_id` FOREIGN KEY (`cems_instrument_id`) REFERENCES `waste_management_ecm`.`energy`.`cems_instrument`(`cems_instrument_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ADD CONSTRAINT `fk_energy_lfg_flow_reading_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_cems_instrument_id` FOREIGN KEY (`cems_instrument_id`) REFERENCES `waste_management_ecm`.`energy`.`cems_instrument`(`cems_instrument_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ADD CONSTRAINT `fk_energy_emissions_reading_stack_id` FOREIGN KEY (`stack_id`) REFERENCES `waste_management_ecm`.`energy`.`stack`(`stack_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ADD CONSTRAINT `fk_energy_ash_residue_record_ash_sample_id` FOREIGN KEY (`ash_sample_id`) REFERENCES `waste_management_ecm`.`energy`.`ash_sample`(`ash_sample_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ADD CONSTRAINT `fk_energy_rec_issuance_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_lfg_collection_system_id` FOREIGN KEY (`lfg_collection_system_id`) REFERENCES `waste_management_ecm`.`energy`.`lfg_collection_system`(`lfg_collection_system_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ADD CONSTRAINT `fk_energy_rin_generation_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ADD CONSTRAINT `fk_energy_offtake_agreement_energy_rate_schedule_id` FOREIGN KEY (`energy_rate_schedule_id`) REFERENCES `waste_management_ecm`.`energy`.`energy_rate_schedule`(`energy_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ADD CONSTRAINT `fk_energy_offtake_agreement_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ADD CONSTRAINT `fk_energy_delivery_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `waste_management_ecm`.`energy`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ADD CONSTRAINT `fk_energy_delivery_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ADD CONSTRAINT `fk_energy_combustion_operating_log_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ADD CONSTRAINT `fk_energy_air_pollution_control_unit_stack_id` FOREIGN KEY (`stack_id`) REFERENCES `waste_management_ecm`.`energy`.`stack`(`stack_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ADD CONSTRAINT `fk_energy_cems_instrument_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ADD CONSTRAINT `fk_energy_cems_instrument_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ADD CONSTRAINT `fk_energy_cems_instrument_stack_id` FOREIGN KEY (`stack_id`) REFERENCES `waste_management_ecm`.`energy`.`stack`(`stack_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ADD CONSTRAINT `fk_energy_ghg_emission_factor_superseded_by_factor_ghg_emission_factor_id` FOREIGN KEY (`superseded_by_factor_ghg_emission_factor_id`) REFERENCES `waste_management_ecm`.`energy`.`ghg_emission_factor`(`ghg_emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ADD CONSTRAINT `fk_energy_planned_outage_turbine_generator_id` FOREIGN KEY (`turbine_generator_id`) REFERENCES `waste_management_ecm`.`energy`.`turbine_generator`(`turbine_generator_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_air_pollution_control_unit_id` FOREIGN KEY (`air_pollution_control_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`air_pollution_control_unit`(`air_pollution_control_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ADD CONSTRAINT `fk_energy_reagent_consumption_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ADD CONSTRAINT `fk_energy_rec_transaction_rec_issuance_id` FOREIGN KEY (`rec_issuance_id`) REFERENCES `waste_management_ecm`.`energy`.`rec_issuance`(`rec_issuance_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ADD CONSTRAINT `fk_energy_lcfs_credit_rng_processing_unit_id` FOREIGN KEY (`rng_processing_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`rng_processing_unit`(`rng_processing_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`stack` ADD CONSTRAINT `fk_energy_stack_boiler_unit_id` FOREIGN KEY (`boiler_unit_id`) REFERENCES `waste_management_ecm`.`energy`.`boiler_unit`(`boiler_unit_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`stack` ADD CONSTRAINT `fk_energy_stack_wte_facility_id` FOREIGN KEY (`wte_facility_id`) REFERENCES `waste_management_ecm`.`energy`.`wte_facility`(`wte_facility_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`stack` ADD CONSTRAINT `fk_energy_stack_linked_stack_id` FOREIGN KEY (`linked_stack_id`) REFERENCES `waste_management_ecm`.`energy`.`stack`(`stack_id`);
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` ADD CONSTRAINT `fk_energy_ash_sample_resample_ash_sample_id` FOREIGN KEY (`resample_ash_sample_id`) REFERENCES `waste_management_ecm`.`energy`.`ash_sample`(`ash_sample_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`energy` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`energy` SET TAGS ('dbx_domain' = 'energy');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Waste-to-Energy (WTE) Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Facility Address Line 1');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Facility Address Line 2');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `air_pollution_control_technology` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control Technology');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `annual_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `ash_residue_handling_method` SET TAGS ('dbx_business_glossary_term' = 'Ash Residue Handling Method');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `ash_residue_handling_method` SET TAGS ('dbx_value_regex' = 'landfill_disposal|beneficial_reuse|offsite_treatment|onsite_stabilization');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `boiler_count` SET TAGS ('dbx_business_glossary_term' = 'Boiler Count');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `continuous_emissions_monitoring` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Installed');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `energy_output_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Output Type');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `energy_output_type` SET TAGS ('dbx_value_regex' = 'electricity|steam|combined_heat_power|renewable_natural_gas');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `environmental_compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Officer Name');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^WTE-[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Technology Type');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'mass_burn|refuse_derived_fuel|gasification|pyrolysis|anaerobic_digestion|landfill_gas_to_energy');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `ghg_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reporting Required');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `grid_interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Grid Interconnection Voltage Kilovolts (kV)');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Management System Certified');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `last_permit_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Renewal Date');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `nameplate_electrical_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Electrical Capacity Megawatts (MW)');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `next_permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|standby|maintenance|decommissioned|under_construction|permitted_not_built');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `permitted_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `power_purchase_agreement_active` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Active');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `rec_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|local|tribal');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `steam_output_capacity_klb_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Steam Output Capacity Thousand Pounds Per Hour (klb/hr)');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `turbine_generator_count` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Count');
ALTER TABLE `waste_management_ecm`.`energy`.`wte_facility` ALTER COLUMN `waste_feedstock_types` SET TAGS ('dbx_business_glossary_term' = 'Waste Feedstock Types Accepted');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `annual_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `ash_handling_system` SET TAGS ('dbx_business_glossary_term' = 'Ash Handling System');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `ash_handling_system` SET TAGS ('dbx_value_regex' = 'wet|dry|pneumatic|mechanical');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|limited|testing');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `boiler_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Boiler Efficiency Percent');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `boiler_type` SET TAGS ('dbx_business_glossary_term' = 'Boiler Type');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `boiler_type` SET TAGS ('dbx_value_regex' = 'mass_burn|refuse_derived_fuel|modular|fluidized_bed|stoker');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `combustion_control_system` SET TAGS ('dbx_business_glossary_term' = 'Combustion Control System');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `cumulative_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Operating Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `design_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `emissions_control_technology` SET TAGS ('dbx_business_glossary_term' = 'Emissions Control Technology');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `grate_type` SET TAGS ('dbx_business_glossary_term' = 'Grate Type');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `grate_type` SET TAGS ('dbx_value_regex' = 'reciprocating|roller|vibrating|traveling|stationary');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `greenhouse_gas_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Reporting Required');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate British Thermal Units Per Kilowatt-Hour (BTU/kWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `last_major_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Overhaul Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Boiler Manufacturer');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `maximum_continuous_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Rating Megawatts (MW)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Boiler Model');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `next_scheduled_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Overhaul Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Pounds Per Square Inch (psi)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `operating_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Fahrenheit (°F)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|standby|maintenance|outage|decommissioned|startup');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Air Permit Number');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `renewable_energy_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Boiler Serial Number');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `steam_generation_rate_klb_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Steam Generation Rate Thousand Pounds Per Hour (klb/hr)');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Number');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `waste_management_ecm`.`energy`.`boiler_unit` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator ID');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Quality Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `annual_operating_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Hours Target');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling System Type');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_value_regex' = 'air_cooled|water_cooled|hydrogen_cooled|hybrid');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `cumulative_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Operating Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `emissions_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Emissions Monitoring Required');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency (Hz - Hertz)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `fuel_source_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Source Type');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `fuel_source_type` SET TAGS ('dbx_value_regex' = 'msw|lfg|biogas|srf|rng|mixed');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `generator_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Generator Voltage (kV - Kilovolts)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `grid_interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Grid Interconnection Voltage (kV - Kilovolts)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `interconnection_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Reference');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `last_major_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Inspection Date');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `maintenance_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Reference');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|standby|maintenance|decommissioned|under_construction|testing');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `rated_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity (MW - Megawatts)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'REC (Renewable Energy Credit) Tracking System ID');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `renewable_energy_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `scada_system_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) System Tag');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `steam_inlet_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Steam Inlet Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `steam_inlet_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Steam Inlet Temperature (°F - Degrees Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `turbine_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Turbine Efficiency Percent');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `turbine_type` SET TAGS ('dbx_business_glossary_term' = 'Turbine Type');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `turbine_type` SET TAGS ('dbx_value_regex' = 'steam|gas|combined_cycle|landfill_gas|biogas|other');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `utility_offtake_meter_number` SET TAGS ('dbx_business_glossary_term' = 'Utility Offtake Meter ID');
ALTER TABLE `waste_management_ecm`.`energy`.`turbine_generator` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Collection System Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Rights Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Project Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `beneficial_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Use Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `beneficial_use_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Use Type');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `beneficial_use_type` SET TAGS ('dbx_value_regex' = 'lfg_to_electricity|lfg_to_rng|direct_thermal|medium_btu|flare_only');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `blower_station_count` SET TAGS ('dbx_business_glossary_term' = 'Blower Station Count');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `capital_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `capital_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `collection_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Collection Area (Acres)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `collection_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Collection Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'System Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'System Decommissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `design_engineer` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `design_flow_capacity_scfm` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Capacity (Standard Cubic Feet per Minute)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `estimated_methane_generation_rate_scfm` SET TAGS ('dbx_business_glossary_term' = 'Estimated Methane Generation Rate (Standard Cubic Feet per Minute)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `flare_station_count` SET TAGS ('dbx_business_glossary_term' = 'Flare Station Count');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `header_pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Header Pipe Diameter (Inches)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `header_pipe_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Header Pipe Length (Feet)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `horizontal_well_count` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Extraction Well Count');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'System Installation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `monitoring_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (Days)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'System Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'System Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|startup|maintenance|shutdown|decommissioned');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'Gas Collection and Control System (GCCS) Code');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `system_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'System Manufacturer');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'LFG Collection System Name');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `system_type` SET TAGS ('dbx_business_glossary_term' = 'LFG Collection System Type');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `system_type` SET TAGS ('dbx_value_regex' = 'active_extraction|passive_venting|hybrid');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `total_extraction_well_count` SET TAGS ('dbx_business_glossary_term' = 'Total Extraction Well Count');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `vertical_well_count` SET TAGS ('dbx_business_glossary_term' = 'Vertical Extraction Well Count');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_collection_system` ALTER COLUMN `waste_in_place_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste in Place (Tons)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Processing Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Collection System ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `annual_capacity_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Annual Capacity (MMBtu)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Score (gCO2e/MJ)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `co2_removal_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Removal Efficiency (%)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `design_throughput_scfm` SET TAGS ('dbx_business_glossary_term' = 'Design Throughput (SCFM)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `gas_quality_spec_standard` SET TAGS ('dbx_business_glossary_term' = 'Gas Quality Specification Standard');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `h2s_removal_system` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Removal System');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `interconnection_point` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Point');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `lcfs_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Low Carbon Fuel Standard (LCFS) Credit Eligible');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `methane_purity_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane Purity Target (%)');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|standby|maintenance|offline|decommissioned');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `rin_generation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Generation Eligible');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `scada_integration` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `siloxane_removal_system` SET TAGS ('dbx_business_glossary_term' = 'Siloxane Removal System');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = 'pressure_swing_adsorption|membrane_separation|amine_scrubbing|cryogenic_separation|water_scrubbing|hybrid');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rng_processing_unit` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Production Line Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supply Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Shredder Equipment Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `actual_throughput_tpd` SET TAGS ('dbx_business_glossary_term' = 'Actual Throughput Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `design_throughput_tpd` SET TAGS ('dbx_business_glossary_term' = 'Design Throughput Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `emissions_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Emissions Monitoring Required Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `energy_consumption_kwh_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kilowatt-Hours (kWh) Per Ton');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_value_regex' = 'msw|commercial_waste|industrial_waste|construction_demolition|mixed');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Management System Certified Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Production Line Name');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'mechanical_biological|thermal_drying|shredding_classification|pelletizing|integrated');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `maintenance_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule Type');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `maintenance_schedule_type` SET TAGS ('dbx_value_regex' = 'preventive|predictive|condition_based|run_to_failure');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Line Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `operating_days_per_year` SET TAGS ('dbx_business_glossary_term' = 'Operating Days Per Year');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `operating_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Per Day');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|idle|maintenance|decommissioned|startup|shutdown');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `processing_stages` SET TAGS ('dbx_business_glossary_term' = 'Processing Stages Description');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `reject_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Reject Rate Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `safety_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Status');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `safety_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_required');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Ash Content Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_calorific_value_mj_kg` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Calorific Value Megajoules per Kilogram (MJ/kg)');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_chlorine_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Chlorine Content Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Moisture Content Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_quality_class` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Quality Classification');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `srf_quality_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4|class_5');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `target_end_use_market` SET TAGS ('dbx_business_glossary_term' = 'Target End-Use Market');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `target_end_use_market` SET TAGS ('dbx_value_regex' = 'cement_kiln|industrial_boiler|power_plant|waste_to_energy|district_heating');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`srf_production_line` ALTER COLUMN `yield_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `generation_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Generation Reading ID');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator ID');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature Fahrenheit');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `ash_residue_tons` SET TAGS ('dbx_business_glossary_term' = 'Ash Residue Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `barometric_pressure_inhg` SET TAGS ('dbx_business_glossary_term' = 'Barometric Pressure Inches of Mercury');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `boiler_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Boiler Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `co2_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Emissions Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `co_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Carbon Monoxide Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|missing|suspect|calibration-required');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `fuel_input_scfm_lfg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Input Standard Cubic Feet per Minute Landfill Gas (scfm LFG)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `fuel_input_tons_msw` SET TAGS ('dbx_business_glossary_term' = 'Fuel Input Tons Municipal Solid Waste (MSW)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `grid_export_mwh` SET TAGS ('dbx_business_glossary_term' = 'Grid Export Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate British Thermal Units per Kilowatt-Hour (BTU/kWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `meter_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Calibration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `methane_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane Content Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `net_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Net Generation Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `nox_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `on_site_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'On-Site Consumption Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'online|offline|startup|shutdown|maintenance|standby');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `parasitic_load_mwh` SET TAGS ('dbx_business_glossary_term' = 'Parasitic Load Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `particulate_matter_lbs` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `reading_interval_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Interval Type');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `reading_interval_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|shift|real-time|monthly');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `rec_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Certification Type');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `rec_certification_type` SET TAGS ('dbx_value_regex' = 'green-e|m-rets|pjm-gats|wregis|ercot|none');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `renewable_energy_credits_qty` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credits Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `so2_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `steam_output_klb` SET TAGS ('dbx_business_glossary_term' = 'Steam Output Thousand Pounds (klb)');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `turbine_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Turbine Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`generation_reading` ALTER COLUMN `utility_settlement_mwh` SET TAGS ('dbx_business_glossary_term' = 'Utility Settlement Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `lfg_flow_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Flow Reading ID');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `compliance_environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `ghg_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `cems_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `lfg_capture_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Capture Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `lfg_extraction_well_id` SET TAGS ('dbx_business_glossary_term' = 'Extraction Well ID');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill ID');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `balance_gas_pct` SET TAGS ('dbx_business_glossary_term' = 'Balance Gas Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `barometric_pressure_inhg` SET TAGS ('dbx_business_glossary_term' = 'Barometric Pressure Inches of Mercury (inHg)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `co2_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Concentration Percentage (CO2)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'manual|scada|portable_analyzer|fixed_sensor|laboratory');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `flow_rate_scfm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Standard Cubic Feet per Minute (SCFM)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `header_pipe_code` SET TAGS ('dbx_business_glossary_term' = 'Header Pipe ID');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `hydrogen_sulfide_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide Parts Per Million (H2S PPM)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `lel_reading_pct` SET TAGS ('dbx_business_glossary_term' = 'Lower Explosive Limit (LEL) Reading Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `methane_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Methane Concentration Percentage (CH4)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reading Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `oxygen_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Concentration Percentage (O2)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_business_glossary_term' = 'Reading Status');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|flagged|under_review|calibration_required|instrument_fault');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'scheduled|spot_check|alarm_triggered|compliance|calibration');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `static_pressure_inches_h2o` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure Inches of Water (H2O)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Fahrenheit (°F)');
ALTER TABLE `waste_management_ecm`.`energy`.`lfg_flow_reading` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `emissions_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Reading ID');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `air_emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Air Emission Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `cems_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Monitor Equipment ID');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `stack_id` SET TAGS ('dbx_business_glossary_term' = 'Stack ID');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `averaging_period` SET TAGS ('dbx_business_glossary_term' = 'Averaging Period');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `averaging_period` SET TAGS ('dbx_value_regex' = '1_hour|3_hour|24_hour|30_day|annual|instantaneous');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Emissions Reading Comments');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exceedance|pending_review|exempt');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg_dscm|ng_dscm|ug_dscm|lb_MMBtu');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `control_device_status` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control Device Status');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `control_device_status` SET TAGS ('dbx_value_regex' = 'operating_normal|operating_degraded|bypassed|offline|maintenance');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `corrected_concentration` SET TAGS ('dbx_business_glossary_term' = 'Corrected Concentration at 7% Oxygen');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'CEMS|Stack_Test|Predictive_Model|Engineering_Estimate|Data_Substitution');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Deviation Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Stack Gas Flow Rate');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_value_regex' = 'dscfh|dscmh|acfm|acmh');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `mass_emission_rate` SET TAGS ('dbx_business_glossary_term' = 'Mass Emission Rate');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `mass_emission_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Mass Emission Rate Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `mass_emission_rate_unit` SET TAGS ('dbx_value_regex' = 'lb_hr|kg_hr|ton_yr|g_sec');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `measured_concentration` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `moisture_content` SET TAGS ('dbx_business_glossary_term' = 'Stack Gas Moisture Content');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `operating_load` SET TAGS ('dbx_business_glossary_term' = 'Operating Load Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `oxygen_percent` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `permit_limit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `permit_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `permit_limit_unit` SET TAGS ('dbx_value_regex' = 'ppm|mg_dscm|ng_dscm|ug_dscm|lb_MMBtu|tpy');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Type');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `qa_qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Status');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `qa_qc_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|failed_qa|calibration_error|instrument_malfunction|data_substituted');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `stack_temperature` SET TAGS ('dbx_business_glossary_term' = 'Stack Gas Temperature');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `stack_temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Stack Temperature Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `stack_temperature_unit` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `test_company` SET TAGS ('dbx_business_glossary_term' = 'Stack Test Company Name');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `test_run_number` SET TAGS ('dbx_business_glossary_term' = 'Stack Test Run Number');
ALTER TABLE `waste_management_ecm`.`energy`.`emissions_reading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `ash_residue_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ash Residue Record ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `receiving_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `ash_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `spill_release_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Release Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `tclp_test_id` SET TAGS ('dbx_business_glossary_term' = 'Tclp Test Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `ash_generation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Generation Rate Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `ash_type` SET TAGS ('dbx_business_glossary_term' = 'Ash Type');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `ash_type` SET TAGS ('dbx_value_regex' = 'bottom_ash|fly_ash|combined_ash');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `beneficial_reuse_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Reuse Revenue (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `beneficial_reuse_revenue_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `combustion_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Combustion Temperature (Celsius)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'beneficial_reuse_aggregate|landfill_disposal|recycling|treatment');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `diversion_from_landfill_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversion from Landfill Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `generation_date` SET TAGS ('dbx_business_glossary_term' = 'Ash Generation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `heavy_metal_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metal Concentration (Parts Per Million)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `lab_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `lab_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `msw_feedstock_tons` SET TAGS ('dbx_business_glossary_term' = 'Municipal Solid Waste (MSW) Feedstock (Tons)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `particle_size_distribution` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Distribution');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH Level');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|archived');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'non_hazardous|hazardous');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `state_waste_code` SET TAGS ('dbx_business_glossary_term' = 'State Waste Code');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `storage_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Storage Duration (Days)');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_residue_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` SET TAGS ('dbx_subdomain' = 'credit_trading');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `rec_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Issuance ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `renewable_energy_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `certificate_serial_number_end` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number End');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `certificate_serial_number_end` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `certificate_serial_number_start` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number Start');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `certificate_serial_number_start` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `eligibility_state` SET TAGS ('dbx_business_glossary_term' = 'State Renewable Portfolio Standard (RPS) Eligibility');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `eligibility_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}(,[A-Z]{2})*$');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `emissions_avoided_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'Emissions Avoided Carbon Dioxide Equivalent (CO2e) Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `energy_quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Quantity Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `generation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Period End Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `generation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Period Start Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Market Value United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity Megawatts (MW)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Account Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Registry Name');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `registry_name` SET TAGS ('dbx_value_regex' = 'NEPOOL-GIS|M-RETS|WREGIS|PJM-GATS|NAR|ERCOT');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Retirement Purpose');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_value_regex' = 'RPS Compliance|Voluntary|Carbon Offset|Corporate Sustainability|Resale');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `retirement_status` SET TAGS ('dbx_business_glossary_term' = 'Retirement Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `retirement_status` SET TAGS ('dbx_value_regex' = 'Active|Retired|Transferred|Expired|Cancelled');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `trading_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `trading_restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction Reason');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Pending|Verified|Rejected|Under Review');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_issuance` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` SET TAGS ('dbx_subdomain' = 'credit_trading');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rin_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Generation ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Collection System ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Processing Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'RNG Production Batch Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `btu_content_per_scf` SET TAGS ('dbx_business_glossary_term' = 'British Thermal Unit (BTU) Content Per Standard Cubic Foot (SCF)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `co2_removed_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Removed in Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `d_code` SET TAGS ('dbx_business_glossary_term' = 'RFS2 D-Code Renewable Fuel Category');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `d_code` SET TAGS ('dbx_value_regex' = 'D3|D5');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `emts_submission_date` SET TAGS ('dbx_business_glossary_term' = 'EPA Moderated Transaction System (EMTS) Submission Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `emts_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'EPA Moderated Transaction System (EMTS) Transaction ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `epa_company_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Company Registration Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `epa_facility_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility Registration Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `equivalence_value` SET TAGS ('dbx_business_glossary_term' = 'RIN Equivalence Value (EV)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Feedstock Type');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_value_regex' = 'MSW Landfill Gas|Biogas from Separated MSW|Biogas from Wastewater Treatment|Agricultural Waste|Food Waste');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `generation_date` SET TAGS ('dbx_business_glossary_term' = 'RIN Generation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RIN Generation Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `ghg_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Reduction Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `lcfs_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Low Carbon Fuel Standard (LCFS) Credit Eligible Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `market_value_per_rin` SET TAGS ('dbx_business_glossary_term' = 'Market Value Per Renewable Identification Number (RIN)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `market_value_per_rin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `methane_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane Content Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RIN Generation Event Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `pathway_code` SET TAGS ('dbx_business_glossary_term' = 'RFS2 Fuel Pathway Code');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `pipeline_injection_point` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Pipeline Injection Point');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `pipeline_operator` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Pipeline Operator Name');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `qa_qc_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Passed Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `raw_lfg_volume_scfm` SET TAGS ('dbx_business_glossary_term' = 'Raw Landfill Gas (LFG) Volume in Standard Cubic Feet Per Minute (SCFM)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `renewable_energy_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rin_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Quantity Generated');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rin_status` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rin_status` SET TAGS ('dbx_value_regex' = 'Generated|Assigned|Separated|Retired|Invalidated');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rin_year` SET TAGS ('dbx_business_glossary_term' = 'RIN Vintage Year');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rng_volume_gge` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Volume in Gasoline Gallon Equivalents (GGE)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `rng_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Volume in Million British Thermal Units (MMBtu)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `total_rin_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Renewable Identification Number (RIN) Value in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `total_rin_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `upgrading_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'RNG Upgrading System Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'RIN Verification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'RIN Verification Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Pending|Verified|Rejected|Under Review');
ALTER TABLE `waste_management_ecm`.`energy`.`rin_generation` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verifier Name');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement ID');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `energy_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'PPA|steam_sales|RNG_sales|REC_sales|capacity_agreement|hybrid');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Years');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contracted_volume_annual` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume Annual');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contracted_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `contracted_volume_unit` SET TAGS ('dbx_value_regex' = 'MWh|klb|MMBtu|REC|MW');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `curtailment_provisions` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Provisions');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `delivery_obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Type');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `delivery_obligation_type` SET TAGS ('dbx_value_regex' = 'firm|as_available|interruptible|must_take');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'electricity|steam|RNG|REC|capacity|bundled');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `environmental_attributes_included` SET TAGS ('dbx_business_glossary_term' = 'Environmental Attributes Included');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `interconnection_point` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Point');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `maximum_delivery_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Delivery Limit Percent');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `minimum_delivery_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Delivery Commitment Percent');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `performance_guarantee_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Required');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `rec_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Ownership Clause');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `rec_ownership_clause` SET TAGS ('dbx_value_regex' = 'seller_retains|buyer_receives|shared|negotiated');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|not_required|under_review');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `renewable_attribute_transfer` SET TAGS ('dbx_business_glossary_term' = 'Renewable Attribute Transfer');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'automatic|mutual_consent|buyer_option|seller_option|none');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_delivery');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `waste_management_ecm`.`energy`.`offtake_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Counterparty ID');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Number');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `curtailment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `curtailment_reason` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|curtailed|cancelled|disputed');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `emissions_offset_quantity` SET TAGS ('dbx_business_glossary_term' = 'Emissions Offset Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'electricity|steam|rng|thermal');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `meter_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `metered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Metered Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period End');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period Start');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Delivery Price Per Unit');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `quality_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `rec_serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Serial Numbers');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Revenue Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `settlement_meter_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Meter ID');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|kWh|klb|MMBtu|dekatherm');
ALTER TABLE `waste_management_ecm`.`energy`.`delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `tipping_fee_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Receipt ID');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Operator ID');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Waste-to-Energy (WTE) Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `scale_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Scale Equipment ID');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `driver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `driver_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `hauler_name` SET TAGS ('dbx_business_glossary_term' = 'Hauler Name');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `inbound_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inbound Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `load_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Load Acceptance Status');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `load_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditional|quarantined');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `net_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `outbound_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outbound Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|overdue|written_off');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|due_on_receipt|prepaid|credit_hold');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending_review|voided|adjusted');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `scale_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Scale Ticket Number');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `scale_ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `tipping_fee_rate_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate (Per Ton)');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `vehicle_license_plate` SET TAGS ('dbx_business_glossary_term' = 'Vehicle License Plate Number');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `waste_subtype` SET TAGS ('dbx_business_glossary_term' = 'Waste Subtype');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Municipal Solid Waste (MSW) Type');
ALTER TABLE `waste_management_ecm`.`energy`.`tipping_fee_receipt` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'MSW|C&D|special_waste|industrial|commercial|residential');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `combustion_operating_log_id` SET TAGS ('dbx_business_glossary_term' = 'Combustion Operating Log ID');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `ghg_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `auxiliary_fuel_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Fuel Consumption Gallons');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `availability_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Factor Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `bottom_ash_tons` SET TAGS ('dbx_business_glossary_term' = 'Bottom Ash Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Score');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `cems_data_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Data Availability Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `co_emissions_pounds` SET TAGS ('dbx_business_glossary_term' = 'Carbon Monoxide (CO) Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `deviation_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Reported Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `dioxin_furan_emissions_ng_per_dscm` SET TAGS ('dbx_business_glossary_term' = 'Dioxin Furan Emissions Nanograms per Dry Standard Cubic Meter (ng/dscm)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `energy_output_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Output Megawatt Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `excess_air_percent` SET TAGS ('dbx_business_glossary_term' = 'Excess Air Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `fly_ash_tons` SET TAGS ('dbx_business_glossary_term' = 'Fly Ash Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `forced_outage_hours` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `furnace_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Furnace Temperature Fahrenheit');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `gross_heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Heat Rate British Thermal Units (BTU) per Kilowatt Hour (kWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `hcl_emissions_pounds` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Chloride (HCl) Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `mercury_emissions_pounds` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `msw_throughput_tons` SET TAGS ('dbx_business_glossary_term' = 'Municipal Solid Waste (MSW) Throughput Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operating Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `nox_emissions_pounds` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `opacity_percent` SET TAGS ('dbx_business_glossary_term' = 'Opacity Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `operating_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Date');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'normal_operation|startup|shutdown|standby|maintenance|emergency_shutdown');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `particulate_matter_emissions_pounds` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter (PM) Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `planned_outage_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `rec_credits_generated` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Credits Generated');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `so2_emissions_pounds` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions Pounds');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `steam_flow_klb` SET TAGS ('dbx_business_glossary_term' = 'Steam Flow Thousand Pounds (klb)');
ALTER TABLE `waste_management_ecm`.`energy`.`combustion_operating_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `air_pollution_control_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control (APC) Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Waste-to-Energy (WTE) Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `stack_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Stack ID');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `actual_removal_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Removal Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `caa_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Clean Air Act (CAA) Compliance Status');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `caa_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|conditional');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `cems_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emission Monitoring System (CEMS) Integration Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `design_capacity_scfm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Standard Cubic Feet per Minute (SCFM)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `design_removal_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Design Removal Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Manufacturer');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Number');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `operating_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Fahrenheit');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|standby|maintenance|out_of_service|decommissioned');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `pollutant_target` SET TAGS ('dbx_business_glossary_term' = 'Target Pollutant');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `pressure_drop_inches_h2o` SET TAGS ('dbx_business_glossary_term' = 'Pressure Drop Inches Water Column (H2O)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `reagent_consumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Reagent Consumption Rate');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `reagent_consumption_uom` SET TAGS ('dbx_business_glossary_term' = 'Reagent Consumption Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `reagent_consumption_uom` SET TAGS ('dbx_value_regex' = 'lbs_per_hour|tons_per_day|gallons_per_hour|kg_per_hour');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `reagent_type` SET TAGS ('dbx_business_glossary_term' = 'Reagent Type');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control (APC) Technology Type');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = 'selective_non_catalytic_reduction|selective_catalytic_reduction|activated_carbon_injection|fabric_filter_baghouse|electrostatic_precipitator|dry_scrubber');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control (APC) Unit Code');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control (APC) Unit Name');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`air_pollution_control_unit` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `cems_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Instrument ID');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `air_pollution_control_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control (APC) Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Waste-to-Energy (WTE) Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `stack_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Stack ID');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `accuracy_specification_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `analyzer_principle` SET TAGS ('dbx_business_glossary_term' = 'Analyzer Principle');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency in Days');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'CEMS Certification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'CEMS Certification Status');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Provisional|Expired|Pending|Decertified');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'CEMS Commissioning Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `das_channel_number` SET TAGS ('dbx_business_glossary_term' = 'Data Acquisition System (DAS) Channel Number');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `das_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Acquisition System (DAS) Reference');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `data_reporting_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Data Reporting Frequency in Minutes');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'CEMS Decommission Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `epa_protocol_gas_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Protocol Gas Required Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'CEMS Installation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'CEMS Instrument Code');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'CEMS Instrument Name');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'CEMS Instrument Type');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'Extractive|Dilution|In-Situ|Ultrasonic Flow|Differential Pressure');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `last_qa_qc_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Assurance / Quality Control (QA/QC) Audit Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `maintenance_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Number');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Instrument Manufacturer');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `measurement_range_max` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Maximum');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `measurement_range_min` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Minimum');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Number');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `next_qa_qc_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Quality Assurance / Quality Control (QA/QC) Audit Due Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CEMS Instrument Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'CEMS Operational Status');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Operational|Out of Service|Under Maintenance|Calibration|Decommissioned');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `part_60_applicable` SET TAGS ('dbx_business_glossary_term' = '40 CFR Part 60 Applicable Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `part_75_applicable` SET TAGS ('dbx_business_glossary_term' = '40 CFR Part 75 Applicable Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `pollutant_monitored` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Monitored');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `rata_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Relative Accuracy Test Audit (RATA) Frequency in Months');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Instrument Response Time in Seconds');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `span_gas_concentration` SET TAGS ('dbx_business_glossary_term' = 'Span Gas Concentration');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`cems_instrument` ALTER COLUMN `zero_gas_concentration` SET TAGS ('dbx_business_glossary_term' = 'Zero Gas Concentration');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` SET TAGS ('dbx_subdomain' = 'credit_trading');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `ghg_emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission Factor ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `superseded_by_factor_ghg_emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Factor ID');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `applicable_facility_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Types');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `biogenic_flag` SET TAGS ('dbx_business_glossary_term' = 'Biogenic Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (CI) Score');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `combustion_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Combustion Efficiency Percent');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `emission_factor_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Category');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_value_regex' = 'msw_combustion|lfg_flare|lfg_combustion|rng_combustion|fossil_fuel_auxiliary|diesel_combustion');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Code');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `factor_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Name');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `fuel_feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel or Feedstock Type');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `geographic_applicability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Applicability');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `ghg_type` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Type');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `ghg_type` SET TAGS ('dbx_value_regex' = 'co2|ch4|n2o|co2e');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `global_warming_potential` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP100)');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `oxidation_factor` SET TAGS ('dbx_business_glossary_term' = 'Oxidation Factor');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `renewable_energy_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `scope_classification` SET TAGS ('dbx_business_glossary_term' = 'Scope Classification');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `scope_classification` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `uncertainty_percent` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Percent');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg_per_ton|kg_per_mmbtu|kg_per_mwh|kg_per_gallon|kg_per_scf');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|third_party_verified');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `verifier_organization` SET TAGS ('dbx_business_glossary_term' = 'Verifier Organization');
ALTER TABLE `waste_management_ecm`.`energy`.`ghg_emission_factor` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` SET TAGS ('dbx_subdomain' = 'revenue_management');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `energy_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Rate Schedule ID');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `capacity_payment_included` SET TAGS ('dbx_business_glossary_term' = 'Capacity Payment Included Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'ppa|offtake|spot|utility_tariff|bilateral');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'utility|industrial|commercial|aggregator|iso_market|municipal');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'electricity|steam|rng|lfg|thermal');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `environmental_attribute_treatment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Attribute Treatment');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `environmental_attribute_treatment` SET TAGS ('dbx_value_regex' = 'bundled|unbundled|seller_retains|buyer_retains|shared');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `environmental_attribute_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `environmental_attribute_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `escalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Escalation Mechanism');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `escalation_mechanism` SET TAGS ('dbx_value_regex' = 'none|cpi|fixed_percent|market_indexed|negotiated_annual');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `escalation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate Percentage');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `index_reference` SET TAGS ('dbx_business_glossary_term' = 'Index Reference');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `market_iso` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) Market');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `maximum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `minimum_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'fixed|lmp_indexed|henry_hub_indexed|cost_plus|negotiated|tariff');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'usd_per_mwh|usd_per_klb|usd_per_mmbtu|usd_per_therm|usd_per_dth');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `rec_bundled` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Bundled Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|superseded');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|monthly|quarterly|annual');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `tariff_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tariff Reference');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `time_of_use_applicable` SET TAGS ('dbx_business_glossary_term' = 'Time of Use (TOU) Applicable Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`energy_rate_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `planned_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage ID');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Supervisor ID');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `turbine_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Turbine Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contractor ID');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `actual_lost_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Actual Lost Generation Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `environmental_impact_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `estimated_lost_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lost Generation Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Number');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Reason Code');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Reason Description');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'planned|scheduled|in progress|completed|cancelled|postponed');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'annual overhaul|scheduled inspection|regulatory test|preventive maintenance|component replacement|performance optimization');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `planned_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `postponement_reason` SET TAGS ('dbx_business_glossary_term' = 'Postponement Reason');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `safety_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan Required Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `utility_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Utility Approval Date');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `utility_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Utility Approval Status');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `utility_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|conditional|denied');
ALTER TABLE `waste_management_ecm`.`energy`.`planned_outage` ALTER COLUMN `utility_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Utility Notification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `reagent_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Consumption ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `air_pollution_control_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Pollution Control (APC) Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `boiler_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Boiler Operating Hours');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `co_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Carbon Monoxide (CO) Emissions (lbs)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Date');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `consumption_method` SET TAGS ('dbx_business_glossary_term' = 'Consumption Method');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `consumption_method` SET TAGS ('dbx_value_regex' = 'automatic_injection|manual_feed|batch_addition');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `consumption_rate_per_ton_msw` SET TAGS ('dbx_business_glossary_term' = 'Consumption Rate per Ton Municipal Solid Waste (MSW)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|suspect');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual_entry|inventory_system|cems');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `emissions_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Emissions Compliance Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `hcl_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Hydrochloric Acid (HCl) Emissions (lbs)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `inventory_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction ID');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `mercury_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Emissions (lbs)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `msw_feedstock_tons` SET TAGS ('dbx_business_glossary_term' = 'Municipal Solid Waste (MSW) Feedstock Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `nox_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions (lbs)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `particulate_matter_lbs` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter (PM) Emissions (lbs)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `reagent_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Number');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `reagent_name` SET TAGS ('dbx_business_glossary_term' = 'Reagent Name');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `reagent_type` SET TAGS ('dbx_business_glossary_term' = 'Reagent Type');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `reagent_type` SET TAGS ('dbx_value_regex' = 'lime|urea|activated_carbon|sodium_bicarbonate|ammonia|other');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|voided|corrected|archived');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `so2_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions (lbs)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `total_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|gallons|pounds|kilograms|liters');
ALTER TABLE `waste_management_ecm`.`energy`.`reagent_consumption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` SET TAGS ('dbx_subdomain' = 'credit_trading');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `rec_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Transaction ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `rec_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Issuance ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `renewable_energy_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `broker_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Broker Fee United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `broker_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Account Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `counterparty_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `eligibility_state` SET TAGS ('dbx_business_glossary_term' = 'Eligibility State');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `emissions_avoided_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'Emissions Avoided Carbon Dioxide Equivalent (CO2e) Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `generation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Period End Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `generation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Period Start Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `rec_quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Quantity Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `registry_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Transaction ID');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Retirement Purpose');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `retirement_status` SET TAGS ('dbx_business_glossary_term' = 'Retirement Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `retirement_status` SET TAGS ('dbx_value_regex' = 'active|retired|transferred|expired|cancelled');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `rps_compliance_period` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Period');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|disputed|reversed');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `total_transaction_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Value United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `total_transaction_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `trading_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `trading_restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction Reason');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'sale|retirement|transfer|banking|forward_sale|spot_sale');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_required');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`energy`.`rec_transaction` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` SET TAGS ('dbx_subdomain' = 'credit_trading');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `lcfs_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Low Carbon Fuel Standard (LCFS) Credit Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Processing Unit Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `buyer_carb_account_number` SET TAGS ('dbx_business_glossary_term' = 'Buyer California Air Resources Board (CARB) Account Number');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `buyer_carb_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `carb_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'California Air Resources Board (CARB) Transaction Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (CI) Score');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `credit_serial_number` SET TAGS ('dbx_business_glossary_term' = 'LCFS Credit Serial Number');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'generated|verified|transferred|retired|invalidated|pending');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_value_regex' = 'landfill_gas|dairy_biogas|wastewater_biogas|agricultural_waste|food_waste');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `fuel_pathway_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Pathway Code');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `fuel_use_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Use Type');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `fuel_use_type` SET TAGS ('dbx_value_regex' = 'transportation|stationary|blended');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `generation_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Generation Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `ghg_emissions_avoided_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Avoided in Carbon Dioxide Equivalent (CO2e) Tons');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `invoice_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Market Value in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `oregon_cfp_credit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Oregon Clean Fuels Program (CFP) Credit Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `oregon_cfp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Oregon Clean Fuels Program (CFP) Eligible Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Low Carbon Fuel Standard (LCFS) Credit Quantity');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Retirement Purpose');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_value_regex' = 'compliance|voluntary|invalidation');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `rin_generation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Generation Eligible Flag');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `rng_volume_dge` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Volume in Diesel Gallon Equivalents (DGE)');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `rng_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Volume in Million British Thermal Units (MMBtu)');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'generation|transfer_sale|transfer_purchase|retirement|adjustment');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Price in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `unit_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`energy`.`lcfs_credit` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `waste_management_ecm`.`energy`.`stack` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`stack` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `waste_management_ecm`.`energy`.`stack` ALTER COLUMN `stack_id` SET TAGS ('dbx_business_glossary_term' = 'Stack Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`stack` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`energy`.`stack` ALTER COLUMN `linked_stack_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` ALTER COLUMN `ash_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Ash Sample Identifier');
ALTER TABLE `waste_management_ecm`.`energy`.`ash_sample` ALTER COLUMN `resample_ash_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
