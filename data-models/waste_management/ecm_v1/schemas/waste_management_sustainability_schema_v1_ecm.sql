-- Schema for Domain: sustainability | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`sustainability` COMMENT 'Corporate sustainability program management including greenhouse gas (GHG) emissions tracking (CO2e), carbon reduction initiatives, renewable energy adoption (CNG, RNG fleets), waste diversion metrics, circular economy programs, ESG reporting, LFG-to-RNG conversion data, SRF production records, carbon offset programs, and sustainability KPIs. Supports EPA GHG reporting, Clean Air Act compliance, and voluntary frameworks (GRI, TCFD, CDP). Integrates with Enviance EHS and SAP CO.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` (
    `ghg_emission_id` BIGINT COMMENT 'Unique identifier for the greenhouse gas emission record. Primary key for the emission tracking system.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Scope 3 emissions from service delivery must be attributed to customer accounts for EPA GHGRP reporting and customer-specific carbon footprint calculations. Essential for ESG disclosure and customer s',
    `emission_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_factor. Business justification: GHG emissions calculations use specific emission factors. One emission record uses one emission factor (1:N). New FK needed. Removes redundant emission_factor value and source strings that can be retr',
    `emission_source_id` BIGINT COMMENT 'Identifier of the specific emission source asset (vehicle, equipment, landfill cell, combustion unit).',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Emissions result from material consumption (fuels, chemicals, refrigerants). Linking emission records to material master enables activity-based costing, material-specific emission factor management, a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: GHG emissions are regulated under air quality permits. This link enables tracking of permit limits, compliance status, and reporting requirements for greenhouse gas emissions from waste management ope',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the emission occurred (landfill, MRF, transfer station, WTE plant, fleet depot).',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: GHG emissions are tracked within defined reporting periods. One emission record belongs to one reporting period (1:N). New FK needed. Removes redundant date columns that can be retrieved from report_p',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EPA GHG reporting requires audit trails showing which employee collected and verified emission data. Critical for GHGRP compliance and third-party assurance of Scope 1/2/3 inventories.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Site-level emission tracking required for location-based carbon accounting, municipal reporting requirements, and customer facility-specific sustainability metrics. Collection events and on-site servi',
    `activity_data_unit` STRING COMMENT 'Unit of measure for the activity data (e.g., gallons, kWh, metric tons, miles, hours). Must align with emission factor units.',
    `activity_data_value` DECIMAL(18,2) COMMENT 'Quantity of activity data used in emission calculation (e.g., gallons of fuel consumed, kWh of electricity purchased, tons of waste processed, vehicle miles traveled).',
    `biogenic_co2_quantity` DECIMAL(18,2) COMMENT 'Quantity of biogenic CO2 emissions (from biomass, biogas, RNG, biodiesel). Reported separately per GHG Protocol and EPA guidance; not included in Scope 1 totals.',
    `calculation_method` STRING COMMENT 'Methodology used to calculate or measure the emission quantity. Determines data quality tier and regulatory acceptability.. Valid values are `Direct Measurement|Mass Balance|Emission Factor|Engineering Estimate|Continuous Monitoring|Default Factor`',
    `carbon_offset_applied_flag` BOOLEAN COMMENT 'Indicates whether carbon offsets or renewable energy certificates (RECs) have been applied to neutralize this emission for net carbon accounting. True if offset applied.',
    `carbon_offset_quantity` DECIMAL(18,2) COMMENT 'Quantity of carbon offsets or RECs applied to this emission record in metric tons CO2e. Used for net carbon footprint calculation.',
    `co2e_quantity` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions converted to carbon dioxide equivalent using global warming potential (GWP) factors. Primary metric for regulatory reporting and sustainability KPIs.',
    `co2e_unit_of_measure` STRING COMMENT 'Unit of measure for CO2 equivalent emissions. Standardized to metric tons CO2e for EPA reporting and voluntary frameworks.. Valid values are `metric tons CO2e|kilograms CO2e|pounds CO2e`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission record was first created in the system. Part of audit trail for data lineage and compliance.',
    `data_quality_tier` STRING COMMENT 'EPA data quality tier classification. Tier 4 (highest) uses continuous monitoring; Tier 1 (lowest) uses default factors. Determines regulatory compliance and audit risk.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `emission_event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the emission event occurred or was measured. Used for real-time monitoring and continuous emissions tracking.',
    `emission_quantity` DECIMAL(18,2) COMMENT 'Quantity of the specific greenhouse gas emitted in native units (metric tons of CO2, CH4, N2O, etc.) before conversion to CO2 equivalent.',
    `emission_source_category` STRING COMMENT 'Detailed category of the emission source specific to waste management operations. Used for internal tracking and operational analysis. [ENUM-REF-CANDIDATE: Fleet Vehicle|Landfill Gas|Stationary Equipment|Electricity Consumption|Natural Gas Combustion|Diesel Combustion|Refrigerant Leakage|Waste-to-Energy Plant — 8 candidates stripped; promote to reference product]',
    `emission_source_type` STRING COMMENT 'Classification of the emission source type per GHG Protocol categories. Determines calculation methodology and reporting requirements. [ENUM-REF-CANDIDATE: Stationary Combustion|Mobile Combustion|Fugitive Emissions|Process Emissions|Purchased Electricity|Purchased Steam|Upstream Transportation|Downstream Transportation|Waste Disposal|Employee Commuting — 10 candidates stripped; promote to reference product]',
    `emission_status` STRING COMMENT 'Current lifecycle status of the emission record. Tracks workflow from data entry through regulatory submission and archival.. Valid values are `Draft|Submitted|Approved|Reported|Archived|Disputed`',
    `emission_unit_of_measure` STRING COMMENT 'Unit of measure for the emission quantity. Typically metric tons for regulatory reporting, but may vary by source and measurement method.. Valid values are `metric tons|kilograms|pounds|cubic meters|standard cubic feet`',
    `epa_subpart_code` STRING COMMENT 'EPA GHG Reporting Rule subpart code applicable to this emission source (e.g., Subpart C for stationary combustion, Subpart HH for landfills, Subpart TT for waste-to-energy).',
    `ghg_type` STRING COMMENT 'Type of greenhouse gas emitted: Carbon Dioxide (CO2), Methane (CH4), Nitrous Oxide (N2O), Hydrofluorocarbons (HFCs), Perfluorocarbons (PFCs), Sulfur Hexafluoride (SF6), Nitrogen Trifluoride (NF3). [ENUM-REF-CANDIDATE: CO2|CH4|N2O|HFCs|PFCs|SF6|NF3 — 7 candidates stripped; promote to reference product]',
    `gwp_factor` DECIMAL(18,2) COMMENT 'Global warming potential factor used to convert the specific GHG to CO2 equivalent. Based on IPCC assessment reports (AR4, AR5, or AR6) as specified by reporting framework.',
    `gwp_reference_standard` STRING COMMENT 'IPCC assessment report used for GWP factors. EPA requires AR4 for mandatory reporting; voluntary frameworks may use AR5 or AR6.. Valid values are `IPCC AR4|IPCC AR5|IPCC AR6`',
    `measurement_method` STRING COMMENT 'Method used to obtain activity data or direct emission measurement. CEMS (Continuous Emissions Monitoring System) is highest quality; manual readings and estimates are lower quality. [ENUM-REF-CANDIDATE: CEMS|Fuel Flow Meter|Utility Bill|Telematics|Manual Reading|Engineering Calculation|Vendor Data — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this emission record. Required for audit trail and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission record was last modified. Tracks data changes for audit and compliance purposes.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, assumptions, data quality issues, or explanations for the emission calculation. Used for audit trail and transparency.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this emission record is subject to mandatory regulatory reporting (EPA GHG Reporting Rule, state programs, Clean Air Act). True if reportable to government agency.',
    `scope_category` STRING COMMENT 'GHG Protocol scope classification: Scope 1 (direct emissions from owned/controlled sources), Scope 2 (indirect emissions from purchased electricity/steam/heating/cooling), Scope 3 (all other indirect emissions in value chain).. Valid values are `Scope 1|Scope 2|Scope 3`',
    `verification_date` DATE COMMENT 'Date when the emission data was verified or audited by internal or third-party verifier.',
    `verification_status` STRING COMMENT 'Verification status of the emission data. Third-party verification required for voluntary frameworks (CDP, GRI, TCFD) and some regulatory programs.. Valid values are `Unverified|Internally Verified|Third-Party Verified|Audited|Certified`',
    `verifier_name` STRING COMMENT 'Name of the organization or individual who verified the emission data (e.g., third-party auditor, internal EHS team).',
    `voluntary_reporting_flag` BOOLEAN COMMENT 'Indicates whether this emission record is included in voluntary sustainability reporting frameworks (CDP, GRI, TCFD, SASB). True if disclosed in ESG reports.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this emission record. Required for audit trail and data governance.',
    CONSTRAINT pk_ghg_emission PRIMARY KEY(`ghg_emission_id`)
) COMMENT 'Master record of greenhouse gas (GHG) emissions data by source, facility, and reporting period. Captures CO2e quantities across Scope 1 (direct combustion, fleet, landfill gas), Scope 2 (purchased electricity), and Scope 3 (value chain) emissions. Supports EPA GHG Mandatory Reporting Rule (40 CFR Part 98), Clean Air Act compliance, and voluntary frameworks including GRI 305, TCFD, and CDP Climate. Integrates with Enviance EHS for permit-level emission tracking and SAP CO for cost allocation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`emission_source` (
    `emission_source_id` BIGINT COMMENT 'Unique identifier for the greenhouse gas emission source. Primary key for the emission source registry.',
    `facility_id` BIGINT COMMENT 'Reference to the facility where this emission source is located or operated. Links to the facility master registry.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to the physical asset (vehicle, equipment, infrastructure) that constitutes this emission source. Links to fixed asset or fleet asset registry.',
    `jha_id` BIGINT COMMENT 'Foreign key linking to safety.jha. Business justification: Each emission source type requires job hazard analysis for maintenance and operation tasks. Real business process: JHA development mandatory before work on LFG collection systems, flare maintenance, c',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Emission sources consume specific materials (fuel types, process chemicals, refrigerants). Linking to material master enables inventory management, procurement planning, standardized material-level em',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Landfill gas collection systems, flares, and stationary combustion sources require designated certified operators for daily monitoring, compliance reporting, and maintenance responsibility tracking pe',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Emission sources (LFG wells, flares, compressors) require specific safety programs per OSHA/EPA regulations (confined space, LOTO, hot work). Real business process: safety program assignment to emissi',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Customer service locations with stationary equipment (compactors, balers, on-site processing) are emission sources requiring EPA reporting. Site-level emission inventory and customer facility carbon f',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Emission sources (equipment, vehicles, control devices) are manufactured/supplied by vendors. Tracking vendor_id enables warranty management, parts sourcing, maintenance contract tracking, and vendor ',
    `carbon_offset_eligible` BOOLEAN COMMENT 'Indicates whether emission reductions from this source are eligible for carbon offset credit generation under voluntary or compliance carbon markets.',
    `commissioning_date` DATE COMMENT 'Date when the emission source was placed into service and began operational emissions. Establishes baseline for historical emission tracking.',
    `control_device_type` STRING COMMENT 'Type of emission control technology installed on this source (e.g., enclosed_flare, catalytic_converter, scrubber, none). Impacts emission factor adjustments and compliance.',
    `control_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in emissions achieved by the control device. Used to adjust gross emissions to net emissions for regulatory reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the emission source location. Supports multinational emission inventory consolidation.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission source record was first created in the system. Used for data lineage and audit trails.',
    `decommissioning_date` DATE COMMENT 'Date when the emission source was permanently taken out of service. Nullable for active sources. Used to calculate emission duration and lifecycle totals.',
    `emission_factor_methodology` STRING COMMENT 'The calculation methodology and tier used to quantify emissions from this source. Higher tiers indicate greater measurement precision and site-specific data. [ENUM-REF-CANDIDATE: epa_tier_1|epa_tier_2|epa_tier_3|epa_tier_4|ipcc_default|custom_site_specific|cems — 7 candidates stripped; promote to reference product]',
    `emission_factor_unit` STRING COMMENT 'Unit of measure for the emission factor (e.g., kg_co2e_per_gallon, kg_co2e_per_kwh, kg_co2e_per_mile). Must align with activity data units.',
    `emission_factor_value` DECIMAL(18,2) COMMENT 'Numeric emission factor applied to activity data to calculate GHG emissions. Units vary by source type (e.g., kg CO2e per gallon, kg CO2e per kWh).',
    `epa_source_code` STRING COMMENT 'Official EPA-assigned identifier for the emission source used in regulatory reporting and compliance tracking.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the emission source location in decimal degrees. Used for spatial analysis, proximity reporting, and environmental justice assessments.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the emission source location in decimal degrees. Used for spatial analysis, proximity reporting, and environmental justice assessments.',
    `ghg_protocol_category` STRING COMMENT 'Detailed GHG Protocol emission category within the assigned scope. Used for inventory segmentation and reporting granularity. [ENUM-REF-CANDIDATE: stationary_combustion|mobile_combustion|fugitive_emissions|process_emissions|purchased_electricity|purchased_heat_steam|upstream_transportation|waste_disposal|business_travel — 9 candidates stripped; promote to reference product]',
    `ghg_protocol_scope` STRING COMMENT 'GHG Protocol categorization: Scope 1 (direct emissions from owned/controlled sources), Scope 2 (indirect emissions from purchased energy), Scope 3 (other indirect emissions in value chain).. Valid values are `scope_1|scope_2|scope_3`',
    `is_subject_to_caa` BOOLEAN COMMENT 'Indicates whether this emission source is regulated under Clean Air Act provisions including Title V operating permits, NSPS, or NESHAP standards.',
    `is_subject_to_ghgrp` BOOLEAN COMMENT 'Indicates whether this emission source is subject to mandatory EPA Greenhouse Gas Reporting Program requirements. True if emissions exceed regulatory thresholds.',
    `lfg_to_rng_conversion` BOOLEAN COMMENT 'Indicates whether this source is part of a landfill gas to renewable natural gas conversion project. Supports circular economy and sustainability reporting.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the emission source equipment. Used for technical specifications lookup and emission factor assignment.',
    `monitoring_method` STRING COMMENT 'Method used to measure or estimate activity data for this source. Continuous Emission Monitoring Systems (CEMS) provide highest accuracy; manual logs and estimates are lower tier. [ENUM-REF-CANDIDATE: cems|fuel_meter|odometer|engine_hours|manual_log|telematics|estimated — 7 candidates stripped; promote to reference product]',
    `naics_code` STRING COMMENT 'Six-digit NAICS code classifying the industrial activity associated with this emission source. Used for sector-based emission reporting and benchmarking.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes about the emission source. Used for audit trails and compliance documentation.',
    `operational_status` STRING COMMENT 'Current operational state of the emission source. Only active sources contribute to current emission inventories.. Valid values are `active|inactive|decommissioned|under_construction|temporarily_offline|retired`',
    `permit_number` STRING COMMENT 'State or federal air quality permit number authorizing operation of this emission source. Required for sources subject to Title V or state air permits.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Maximum design capacity of the emission source (e.g., engine horsepower, boiler MMBtu/hr, compactor tons per hour). Used for capacity-based emission estimates.',
    `rated_capacity_unit` STRING COMMENT 'Unit of measure for the rated capacity (e.g., horsepower, mmbtu_per_hour, tons_per_hour). Must align with capacity value.',
    `renewable_energy_flag` BOOLEAN COMMENT 'Indicates whether this source uses renewable energy (e.g., RNG, biogas, solar, wind). True for sources contributing to renewable energy adoption KPIs.',
    `reporting_threshold_tpy` DECIMAL(18,2) COMMENT 'Annual emission threshold in metric tons CO2e that triggers mandatory EPA GHGRP reporting for this source. Typically 25,000 TPY for facilities.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific emission source unit. Used for asset tracking and maintenance history.',
    `sic_code` STRING COMMENT 'Four-digit SIC code for legacy classification of the emission source activity. Maintained for historical reporting and cross-reference with older datasets.',
    `source_name` STRING COMMENT 'Human-readable name or designation of the emission source (e.g., Fleet Truck 1234, Landfill Flare Station A, WTE Boiler Unit 2).',
    `source_type` STRING COMMENT 'Classification of the emission source by operational category. Determines applicable emission factor methodology and reporting requirements. [ENUM-REF-CANDIDATE: fleet_vehicle|landfill_gas_vent|landfill_gas_flare|wte_combustion_unit|mrf_equipment|transfer_station_compactor|stationary_combustion|mobile_combustion|fugitive_emission|process_emission — 10 candidates stripped; promote to reference product]',
    `state_province_code` STRING COMMENT 'Two-letter state or province code where the emission source is located. Used for state-level emission inventory rollups and compliance with state regulations.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the person who last updated this emission source record. Supports audit trails and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission source record was last modified. Used for change tracking and data quality monitoring.',
    `waste_to_energy_flag` BOOLEAN COMMENT 'Indicates whether this source is a waste-to-energy combustion unit generating electricity or heat from waste. Supports WTE program tracking and energy recovery metrics.',
    CONSTRAINT pk_emission_source PRIMARY KEY(`emission_source_id`)
) COMMENT 'Master catalog of all GHG emission sources operated by Waste Management including fleet vehicles (diesel, CNG, RNG), landfill gas (LFG) vents and flares, WTE combustion units, MRF equipment, transfer station compactors, and stationary combustion sources. Each source is classified by source type, GHG protocol category, EPA source ID, facility association, and applicable emission factor methodology. Serves as the authoritative registry for emission inventory compilation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` (
    `carbon_initiative_id` BIGINT COMMENT 'Unique identifier for the carbon reduction initiative or sustainability program.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Large commercial and municipal customers co-sponsor carbon initiatives (joint fleet electrification, waste-to-energy partnerships, circular economy programs). Required for partnership tracking, cost a',
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for this initiative-to-procurement allocation record. Primary key.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to the purchase requisition supporting the carbon initiative',
    `reduction_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.reduction_target. Business justification: Carbon initiatives are designed to achieve specific reduction targets. One initiative supports one primary target (1:N). New FK needed to link initiatives to their target commitments.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Carbon initiatives often have associated vendor contracts (renewable energy PPAs, carbon offset purchase agreements, emissions monitoring service contracts, technology implementation contracts). Linki',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Carbon reduction initiatives requiring capital investment need executive sponsorship for budget approval, board reporting, and strategic alignment. Distinct from program_manager role which handles exe',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Carbon reduction initiatives often involve primary vendor partnerships (renewable energy providers, carbon offset developers, emissions monitoring technology vendors). Tracking vendor_id enables contr',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Carbon reduction initiatives target specific WTE facilities for emission reduction projects (boiler efficiency upgrades, fuel switching, APC improvements). Links strategic sustainability programs to o',
    `actual_completion_date` DATE COMMENT 'Actual date when the carbon initiative was fully implemented and became operational. Null if not yet completed.',
    `actual_start_date` DATE COMMENT 'Actual date when implementation of the carbon initiative commenced. Null if not yet started.',
    `allocation_justification` STRING COMMENT 'Business justification explaining why this purchase requisition is allocated to this carbon initiative. Captures the operational or strategic rationale for the procurement-to-initiative linkage, supporting audit trails and budget variance analysis.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the purchase requisition cost allocated to this specific carbon initiative. Enables split allocation when a single PR supports multiple initiatives (e.g., shared equipment, facility upgrades benefiting multiple programs). Sum of allocation_percentage across all initiatives for a given PR should equal 100.',
    `baseline_co2e_tons` DECIMAL(18,2) COMMENT 'Annual greenhouse gas emissions in metric tons of CO2 equivalent measured in the baseline year, representing the starting point for reduction calculations.',
    `baseline_year` STRING COMMENT 'Reference year used to establish the emissions baseline against which CO2e reduction targets are measured (e.g., 2020).',
    `budget_impact_category` STRING COMMENT 'Classification of how this procurement impacts the carbon initiative budget: capital_investment (CAPEX for initiative implementation), operating_cost (ongoing OPEX), maintenance (recurring maintenance), consulting_services (external advisory), equipment (machinery/vehicles), materials (consumables), other.',
    `capital_investment_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure budgeted or committed for implementing this carbon initiative, measured in USD.',
    `carbon_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether this initiative is eligible to generate carbon credits or offsets that can be traded or used for compliance purposes (True) or not (False).',
    `carbon_initiative_description` STRING COMMENT 'Detailed narrative description of the carbon reduction initiative including scope, objectives, and expected environmental benefits.',
    `carbon_initiative_status` STRING COMMENT 'Current lifecycle status of the carbon initiative: planning (under development), approved (authorized for execution), in_progress (actively being implemented), on_hold (temporarily suspended), completed (fully implemented), or cancelled (terminated before completion).. Valid values are `planning|approved|in_progress|on_hold|completed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this carbon initiative record was first created in the system.',
    `esg_reporting_framework` STRING COMMENT 'Primary ESG reporting framework(s) that this initiative supports, such as GRI (Global Reporting Initiative), TCFD (Task Force on Climate-related Financial Disclosures), CDP (Carbon Disclosure Project), SASB (Sustainability Accounting Standards Board), or internal corporate sustainability goals. [ENUM-REF-CANDIDATE: GRI|TCFD|CDP|SASB|DJSI|MSCI|FTSE4Good|Internal — promote to reference product]',
    `facility_count` STRING COMMENT 'Number of facilities or sites included in this initiative (applicable to solar installations, methane capture expansions, and facility-based programs).',
    `funding_source` STRING COMMENT 'Primary source of funding for this initiative: internal capital (corporate capital budget), green bond (proceeds from sustainability-linked bonds), government grant (federal or state grant programs), utility incentive (rebates or incentives from energy utilities), tax credit (federal or state tax incentives), partnership (co-funded with external partner), or mixed (multiple funding sources). [ENUM-REF-CANDIDATE: internal_capital|green_bond|government_grant|utility_incentive|tax_credit|partnership|mixed — 7 candidates stripped; promote to reference product]',
    `initiative_code` STRING COMMENT 'Unique business identifier code for the initiative used in project tracking and financial systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `initiative_name` STRING COMMENT 'Business name of the carbon reduction initiative or sustainability program (e.g., Fleet CNG Conversion 2024, Solar Installation Phase 2).',
    `initiative_phase` STRING COMMENT 'Lifecycle phase of the carbon initiative when this procurement was requested: planning (pre-implementation), implementation (active deployment), operational (post-go-live support), closeout (final expenses). Enables phase-based cost analysis.',
    `initiative_type` STRING COMMENT 'Category of carbon reduction initiative: fleet electrification (electric vehicle adoption), CNG conversion (Compressed Natural Gas vehicle conversion), RNG conversion (Renewable Natural Gas vehicle conversion), LFG-to-RNG (Landfill Gas to Renewable Natural Gas conversion), solar installation (photovoltaic systems at facilities), methane capture (landfill methane capture expansion), operational efficiency (process optimization programs), renewable energy (general renewable energy adoption), or waste diversion (circular economy and recycling programs). [ENUM-REF-CANDIDATE: fleet_electrification|cng_conversion|rng_conversion|lfg_to_rng|solar_installation|methane_capture|operational_efficiency|renewable_energy|waste_diversion — 9 candidates stripped; promote to reference product]',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this procurement is on the critical path for initiative delivery. True if delays in this PR would directly impact the initiatives planned_completion_date. Used for procurement prioritization and risk management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this carbon initiative record was most recently modified.',
    `linked_date` DATE COMMENT 'Date when this purchase requisition was linked to the carbon initiative for cost tracking purposes. May differ from requisition_date if allocation occurs retroactively during budget reconciliation.',
    `operating_cost_impact_annual` DECIMAL(18,2) COMMENT 'Estimated annual change in operating costs resulting from this initiative, measured in USD. Negative values indicate cost savings; positive values indicate cost increases.',
    `payback_period_years` DECIMAL(18,2) COMMENT 'Estimated number of years required to recover the capital investment through cost savings or revenue generation from the initiative.',
    `planned_completion_date` DATE COMMENT 'Target date by which the carbon initiative is scheduled to be fully implemented and operational.',
    `planned_start_date` DATE COMMENT 'Scheduled date when implementation of the carbon initiative is planned to begin.',
    `priority_level` STRING COMMENT 'Strategic priority ranking of this initiative within the corporate sustainability portfolio: critical (highest priority, regulatory or strategic imperative), high (important for near-term goals), medium (standard priority), or low (opportunistic or long-term).. Valid values are `critical|high|medium|low`',
    `program_manager` STRING COMMENT 'Name of the individual responsible for overall program management and delivery of the carbon initiative.',
    `projected_roi_percent` DECIMAL(18,2) COMMENT 'Expected financial return on investment expressed as a percentage, calculated based on capital investment and projected cost savings or revenue generation over the initiative lifecycle.',
    `regulatory_driver` STRING COMMENT 'Primary regulatory requirement or compliance mandate driving this initiative (e.g., EPA GHG Reporting Rule, Clean Air Act Title V, State RNG Mandate, Corporate Climate Commitment). Null if initiative is voluntary.',
    `renewable_energy_capacity_mw` DECIMAL(18,2) COMMENT 'Total renewable energy generation capacity in megawatts (MW) that will be added through this initiative (applicable to solar, LFG-to-RNG, and other renewable energy projects).',
    `responsible_business_unit` STRING COMMENT 'Name of the business unit, division, or department accountable for executing and managing this carbon initiative (e.g., Fleet Operations, Landfill Operations, Facilities Management).',
    `risk_level` STRING COMMENT 'Overall risk assessment for successful implementation of this initiative considering technical, financial, regulatory, and operational factors: high (significant implementation challenges or uncertainties), medium (moderate risks with mitigation plans), or low (well-understood with minimal risk).. Valid values are `high|medium|low`',
    `scope_1_reduction_tons` DECIMAL(18,2) COMMENT 'Projected annual reduction in Scope 1 direct GHG emissions (from owned or controlled sources such as fleet vehicles and landfill operations) measured in metric tons of CO2e.',
    `scope_2_reduction_tons` DECIMAL(18,2) COMMENT 'Projected annual reduction in Scope 2 indirect GHG emissions (from purchased electricity, steam, heating, and cooling) measured in metric tons of CO2e.',
    `scope_3_reduction_tons` DECIMAL(18,2) COMMENT 'Projected annual reduction in Scope 3 indirect GHG emissions (from value chain activities including upstream and downstream emissions) measured in metric tons of CO2e.',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goals that this initiative contributes to (e.g., SDG 7: Affordable and Clean Energy, SDG 13: Climate Action, SDG 12: Responsible Consumption and Production).',
    `target_co2e_reduction_tons` DECIMAL(18,2) COMMENT 'Projected annual reduction in greenhouse gas emissions measured in metric tons of CO2 equivalent (CO2e) that this initiative is expected to achieve once fully implemented.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this carbon initiative record.',
    `vehicle_count` STRING COMMENT 'Number of fleet vehicles included in this initiative (applicable to fleet electrification, CNG conversion, and RNG conversion programs).',
    `verification_standard` STRING COMMENT 'Third-party verification or certification standard applied to validate emissions reductions from this initiative (e.g., ISO 14064-3, Verified Carbon Standard, Climate Action Reserve Protocol). Null if not third-party verified.',
    CONSTRAINT pk_carbon_initiative PRIMARY KEY(`carbon_initiative_id`)
) COMMENT 'Master record of corporate carbon reduction initiatives and sustainability programs including fleet electrification projects, CNG/RNG vehicle conversion programs, LFG-to-RNG conversion projects, solar installations at facilities, landfill methane capture expansions, and operational efficiency programs. Tracks initiative name, type, target CO2e reduction, baseline year, implementation timeline, responsible business unit, capital investment, and projected ROI. Supports TCFD scenario analysis and CDP climate strategy reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` (
    `initiative_milestone_id` BIGINT COMMENT 'Unique identifier for the sustainability initiative milestone record. Primary key.',
    `boiler_unit_id` BIGINT COMMENT 'Foreign key linking to energy.boiler_unit. Business justification: Milestones track progress on asset-specific emission reduction projects (boiler efficiency improvements, combustion optimization). Links sustainability initiative progress to specific equipment for pe',
    `carbon_initiative_id` BIGINT COMMENT 'Reference to the parent carbon reduction or sustainability initiative to which this milestone belongs. Links milestone progress to the overarching initiative.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Initiative milestones may relate to specific emission sources being modified, upgraded, or decommissioned. One milestone can target one emission source (1:N). New FK needed to link milestones to speci',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual accountable for delivering this milestone. Links to workforce management system for accountability tracking.',
    `quaternary_initiative_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the individual who last modified this milestone record. Used for audit trail and accountability.',
    `tertiary_initiative_employee_id` BIGINT COMMENT 'User identifier of the individual who created this milestone record. Used for audit trail and accountability.',
    `actual_completion_date` DATE COMMENT 'Actual date when the milestone was completed and verified. Nullable until milestone is finished. Used for performance reporting and lessons learned.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual expenditure incurred for this milestone to date in US dollars. Nullable until costs are incurred. Used for budget variance analysis and cost-per-ton-CO2e metrics.',
    `actual_start_date` DATE COMMENT 'Actual date when milestone work commenced. Nullable until milestone begins. Used for schedule variance analysis.',
    `budget_allocated_usd` DECIMAL(18,2) COMMENT 'Total budget allocated to this milestone in US dollars. Used for financial tracking and return on investment (ROI) analysis of carbon reduction initiatives.',
    `co2e_reduction_achieved_tons` DECIMAL(18,2) COMMENT 'Cumulative greenhouse gas emissions reduction achieved by this milestone to date, measured in metric tons of CO2 equivalent. Supports EPA GHG reporting and voluntary disclosure frameworks (CDP, GRI, TCFD).',
    `co2e_reduction_target_tons` DECIMAL(18,2) COMMENT 'Target greenhouse gas emissions reduction committed for this milestone, measured in metric tons of CO2 equivalent. Used to track progress against initiative commitments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was first created in the system. Used for audit trail and data lineage.',
    `dependencies` STRING COMMENT 'Description of upstream dependencies or prerequisites required before this milestone can be completed (e.g., Requires completion of vendor selection milestone, Dependent on EPA permit approval, Awaiting budget approval).',
    `esg_framework_alignment` STRING COMMENT 'Comma-separated list of voluntary ESG disclosure frameworks to which this milestone contributes (e.g., GRI 305, TCFD, CDP Climate Change, SASB). Used for multi-framework reporting and stakeholder communication.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this milestone record is currently active (true) or has been logically deleted or archived (false). Used for soft-delete pattern and historical record retention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was last updated. Used for audit trail and change tracking.',
    `milestone_description` STRING COMMENT 'Detailed description of the milestone scope, deliverables, and success criteria. Provides context for program managers and ESG stakeholders.',
    `milestone_name` STRING COMMENT 'Business name of the milestone or deliverable within the initiative (e.g., Fleet CNG Conversion Phase 1, LFG Capture System Installation, Renewable Natural Gas Procurement Agreement).',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone: not_started (planned but not yet begun), in_progress (active execution), on_hold (temporarily paused), completed (delivered and verified), cancelled (discontinued), delayed (behind schedule).. Valid values are `not_started|in_progress|on_hold|completed|cancelled|delayed`',
    `milestone_type` STRING COMMENT 'Classification of the milestone by phase in the initiative lifecycle: planning (design and approval), procurement (vendor selection and contracting), implementation (execution and deployment), verification (measurement and validation), reporting (disclosure and communication), closure (final assessment and handover).. Valid values are `planning|procurement|implementation|verification|reporting|closure`',
    `notes` STRING COMMENT 'Free-text field for additional context, lessons learned, or commentary on milestone execution. Used for knowledge management and continuous improvement.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Estimated percentage of milestone work completed (0.00 to 100.00). Used for earned value management and progress reporting to ESG stakeholders.',
    `planned_completion_date` DATE COMMENT 'Target date by which the milestone is scheduled to be completed. Used for commitment tracking and ESG reporting timelines.',
    `planned_start_date` DATE COMMENT 'Scheduled date when milestone work is planned to begin. Used for baseline schedule tracking and resource planning.',
    `reporting_period` STRING COMMENT 'Fiscal or calendar period to which this milestone is attributed for ESG reporting purposes (e.g., Q1 2024, FY2024, 2024). Aligns with voluntary disclosure framework reporting cycles (CDP, GRI, TCFD).',
    `responsible_department` STRING COMMENT 'Business unit or department accountable for milestone execution (e.g., Fleet Operations, Landfill Engineering, Environmental Compliance, Sustainability Office).',
    `risk_description` STRING COMMENT 'Description of identified risks, issues, or impediments affecting milestone delivery. Used for risk management and escalation to program governance.',
    `risk_level` STRING COMMENT 'Current risk assessment level for milestone delivery: low (on track, no significant issues), medium (minor issues or risks identified), high (significant risks to schedule or deliverables), critical (major impediments, escalation required).. Valid values are `low|medium|high|critical`',
    `verification_date` DATE COMMENT 'Date when milestone completion and emissions reduction were formally verified and approved. Nullable until verification is complete.',
    `verification_evidence_reference` STRING COMMENT 'Reference to supporting documentation or evidence that validates milestone completion and emissions reduction (e.g., audit report ID, EPA submission confirmation number, measurement report file path, third-party certificate number).',
    `verification_method` STRING COMMENT 'Method used to verify and validate milestone completion and emissions reduction claims: internal_audit (internal review process), third_party_verification (independent auditor), epa_reporting (EPA GHG reporting submission), meter_data (direct measurement from telemetry), engineering_calculation (engineering estimate), vendor_certification (supplier attestation).. Valid values are `internal_audit|third_party_verification|epa_reporting|meter_data|engineering_calculation|vendor_certification`',
    CONSTRAINT pk_initiative_milestone PRIMARY KEY(`initiative_milestone_id`)
) COMMENT 'Transactional record tracking progress milestones and deliverables for each carbon reduction initiative. Captures milestone name, planned and actual completion dates, CO2e reduction achieved to date, milestone status, responsible owner, and verification evidence. Enables program managers to monitor initiative execution against committed targets and report progress to ESG stakeholders and voluntary disclosure frameworks (CDP, GRI, TCFD).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` (
    `lfg_capture_id` BIGINT COMMENT 'Unique identifier for the landfill gas capture record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: LFG collection systems require regular safety audits (LEL monitoring, confined space compliance, equipment integrity checks). Real business process: quarterly safety audits of LFG infrastructure manda',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: LFG capture systems are emission sources that need to be tracked in the emission source catalog. One LFG capture system is one emission source (1:N). New FK needed to link capture data to emission sou',
    `facility_id` BIGINT COMMENT 'Reference to the landfill facility where LFG was captured.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: LFG collection system incidents (well failures, blower malfunctions, flare issues) impact capture volumes and create safety events. Real business process: incident investigation for LFG system failure',
    `lfg_collection_system_id` BIGINT COMMENT 'Foreign key linking to energy.lfg_collection_system. Business justification: LFG capture records aggregate data from specific collection systems for sustainability reporting and carbon credit quantification. Links operational collection infrastructure to sustainability metrics',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Landfill gas capture operations require certified operators for daily LEL monitoring, blower station adjustments, flare operations, and compliance reporting to EPA and state regulators.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Landfill gas capture systems operate under air quality permits (Title V, synthetic minor, NSPS Subpart WWW). The permit authorizes the collection system, sets operational requirements, and mandates mo',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: LFG capture data is tracked within reporting periods. One capture record belongs to one reporting period (1:N). New FK needed. Removes redundant date columns.',
    `blower_station_count` STRING COMMENT 'Number of active blower stations used to extract LFG from the landfill during the reporting period.',
    `capture_timestamp` TIMESTAMP COMMENT 'Date and time when the LFG capture measurement was recorded.',
    `carbon_credits_generated` DECIMAL(18,2) COMMENT 'Number of carbon credits or offsets generated from LFG capture and utilization activities during the reporting period.',
    `co2e_emissions_avoided_metric_tons` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions avoided through LFG capture and utilization, expressed in metric tons of carbon dioxide equivalent (CO2e). Calculated based on methane capture and conversion.',
    `collection_system_efficiency_percent` DECIMAL(18,2) COMMENT 'Efficiency of the landfill gas collection system, calculated as the percentage of generated LFG that is successfully captured. Typical values range from 75% to 95%.',
    `collection_system_status` STRING COMMENT 'Current operational status of the LFG collection system at the facility.. Valid values are `operational|maintenance|offline|startup|shutdown|degraded`',
    `collection_well_count` STRING COMMENT 'Number of active LFG collection wells at the facility during the reporting period.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status for LFG capture activities during the reporting period.. Valid values are `compliant|non_compliant|pending_review|exempted`',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions taken to address non-compliance or operational issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this LFG capture record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and verification status of the LFG capture data.. Valid values are `verified|estimated|provisional|incomplete`',
    `electricity_generated_mwh` DECIMAL(18,2) COMMENT 'Total electricity generated from landfill gas during the reporting period, measured in megawatt-hours (MWh).',
    `epa_permit_number` STRING COMMENT 'EPA permit number authorizing LFG collection and utilization activities at the facility.',
    `flare_station_count` STRING COMMENT 'Number of active flare stations used to combust excess LFG during the reporting period.',
    `lel_monitoring_reading_percent` DECIMAL(18,2) COMMENT 'Lower explosive limit monitoring reading as a percentage, used to ensure safe operation of LFG collection systems. Readings above 25% LEL trigger safety protocols.',
    `lfg_flared_volume_mmbtu` DECIMAL(18,2) COMMENT 'Volume of landfill gas that was flared (combusted without energy recovery) during the reporting period, measured in MMBtu.',
    `lfg_flared_volume_mmscf` DECIMAL(18,2) COMMENT 'Volume of landfill gas that was flared (combusted without energy recovery) during the reporting period, measured in MMSCF.',
    `lfg_utilized_rng_volume_mmbtu` DECIMAL(18,2) COMMENT 'Volume of landfill gas utilized for renewable natural gas (RNG) production during the reporting period, measured in MMBtu.',
    `lfg_utilized_rng_volume_mmscf` DECIMAL(18,2) COMMENT 'Volume of landfill gas utilized for renewable natural gas (RNG) production during the reporting period, measured in MMSCF.',
    `lfg_utilized_wte_volume_mmbtu` DECIMAL(18,2) COMMENT 'Volume of landfill gas utilized for waste-to-energy conversion (electricity or heat generation) during the reporting period, measured in MMBtu.',
    `lfg_utilized_wte_volume_mmscf` DECIMAL(18,2) COMMENT 'Volume of landfill gas utilized for waste-to-energy conversion (electricity or heat generation) during the reporting period, measured in MMSCF.',
    `measurement_method` STRING COMMENT 'Method used to measure and record LFG capture volumes and concentrations.. Valid values are `continuous_monitoring|periodic_sampling|calculated_estimate|direct_measurement`',
    `methane_concentration_percent` DECIMAL(18,2) COMMENT 'Percentage of methane (CH4) in the collected landfill gas, typically ranging from 40% to 60%.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this LFG capture record was last modified in the system.',
    `non_compliance_reason` STRING COMMENT 'Explanation of any non-compliance issues identified during the reporting period.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the LFG capture record, including operational anomalies or special circumstances.',
    `total_lfg_volume_collected_mmbtu` DECIMAL(18,2) COMMENT 'Total volume of landfill gas collected during the reporting period, measured in million British thermal units (MMBtu).',
    `total_lfg_volume_collected_mmscf` DECIMAL(18,2) COMMENT 'Total volume of landfill gas collected during the reporting period, measured in million standard cubic feet (MMSCF).',
    CONSTRAINT pk_lfg_capture PRIMARY KEY(`lfg_capture_id`)
) COMMENT 'Transactional record of landfill gas (LFG) collection and utilization data by landfill site and reporting period. Captures total LFG volume collected (MMBtu or MMSCF), methane concentration (%), LFG flared volume, LFG utilized for RNG production or WTE, LEL monitoring readings, and collection system efficiency. Supports EPA Subpart HH (Municipal Solid Waste Landfills) GHG reporting and Clean Air Act NSPS compliance. Integrates with Enviance EHS for permit-level LFG monitoring.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`rng_production` (
    `rng_production_id` BIGINT COMMENT 'Unique identifier for the RNG production record. Primary key for the RNG production transaction.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: RNG production facilities are emission sources that need to be tracked. One RNG production facility is one emission source (1:N). New FK needed to link production data to emission source catalog.',
    `employee_id` BIGINT COMMENT 'Identifier of the certified operator who supervised this RNG production run.',
    `facility_id` BIGINT COMMENT 'Identifier of the LFG-to-RNG conversion facility where production occurred.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: RNG production facilities have process safety risks (high pressure gas, flammable materials, equipment failures). Real business process: incident tracking for RNG operations, PSM compliance reporting,',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: RNG production facilities require air quality permits for upgrading equipment (compressors, dryers, flares) and potential emissions. Permit compliance is mandatory for operations. Links RNG production',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: RNG production is tracked within reporting periods. One production record belongs to one reporting period (1:N). New FK needed. Removes redundant epa_reporting_period string that can be retrieved from',
    `rng_processing_unit_id` BIGINT COMMENT 'Foreign key linking to energy.rng_processing_unit. Business justification: RNG production records track output from specific processing units for carbon credit generation and ESG reporting. Links operational production data to sustainability accounting for RINs, LCFS credits',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: RNG facilities require comprehensive safety programs (PSM, confined space, LOTO, emergency response) per OSHA PSM standards. Real business process: facility-specific safety program development and mai',
    `carbon_credit_registry` STRING COMMENT 'Name of the voluntary carbon credit registry where carbon offset credits for this RNG production are registered and tracked.. Valid values are `verra_vcs|gold_standard|climate_action_reserve|american_carbon_registry|none`',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Lifecycle greenhouse gas emissions intensity of the RNG produced, measured in grams of CO2 equivalent per megajoule (gCO2e/MJ). Lower scores indicate cleaner fuel.',
    `co2e_avoided_metric_tons` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions avoided by converting landfill methane to RNG instead of flaring or venting, measured in metric tons of CO2 equivalent.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RNG production record was first created in the system.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Number of hours the RNG production facility was offline or non-operational during this production period due to maintenance, repairs, or other issues.',
    `downtime_reason` STRING COMMENT 'Primary reason for facility downtime during this production period. Used for root cause analysis and maintenance planning.. Valid values are `scheduled_maintenance|unscheduled_maintenance|equipment_failure|weather|regulatory_inspection|other`',
    `lcfs_credits_generated` DECIMAL(18,2) COMMENT 'Number of California Low Carbon Fuel Standard (LCFS) credits generated for this RNG production batch. LCFS credits are tradable compliance instruments.',
    `lfg_input_volume_scf` DECIMAL(18,2) COMMENT 'Total volume of raw landfill gas fed into the conversion facility during this production run, measured in standard cubic feet (SCF).',
    `lfg_methane_content_percent` DECIMAL(18,2) COMMENT 'Percentage of methane (CH4) in the raw landfill gas input stream. Typical range is 45-60% for landfill gas.',
    `notes` STRING COMMENT 'Free-text field for operational notes, observations, or special circumstances related to this RNG production batch.',
    `pipeline_injection_volume_scf` DECIMAL(18,2) COMMENT 'Volume of RNG injected into the natural gas pipeline distribution system during this production period, measured in standard cubic feet (SCF).',
    `production_batch_number` STRING COMMENT 'Unique batch identifier assigned to this RNG production run for traceability and quality control purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `production_date` DATE COMMENT 'Calendar date when the RNG production occurred. Used for daily production reporting and trend analysis.',
    `production_efficiency_percent` DECIMAL(18,2) COMMENT 'Ratio of RNG energy output to LFG energy input, expressed as a percentage. Measures the conversion efficiency of the LFG-to-RNG facility.',
    `production_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the RNG production batch processing completed.',
    `production_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the RNG production batch processing began.',
    `production_status` STRING COMMENT 'Current lifecycle status of this RNG production batch. Tracks the batch from initiation through quality certification and final disposition.. Valid values are `completed|in_progress|aborted|quality_hold|pending_certification`',
    `quality_test_date` DATE COMMENT 'Date when quality testing and certification of the RNG output was performed.',
    `quality_test_passed_flag` BOOLEAN COMMENT 'Indicates whether the RNG output met all pipeline quality specifications and purity requirements. True = passed, False = failed.',
    `renewable_fuel_pathway_code` STRING COMMENT 'EPA-assigned pathway code identifying the specific renewable fuel production process and feedstock combination used for this RNG production.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rin_credits_generated` DECIMAL(18,2) COMMENT 'Number of Renewable Identification Number (RIN) credits generated under EPA Renewable Fuel Standard (RFS2) for this production batch. RINs are tradable compliance credits.',
    `rin_d_code` STRING COMMENT 'EPA RIN D-code classification for the renewable fuel pathway. D3 = cellulosic biofuel (landfill gas), D5 = advanced biofuel.. Valid values are `D3|D5`',
    `rng_methane_purity_percent` DECIMAL(18,2) COMMENT 'Percentage of methane (CH4) in the purified RNG output. Pipeline-quality RNG typically requires 95-98% methane purity.',
    `rng_output_energy_mmbtu` DECIMAL(18,2) COMMENT 'Energy content of the RNG produced, measured in million British thermal units (MMBtu). Used for energy accounting and RIN credit calculation.',
    `rng_output_volume_scf` DECIMAL(18,2) COMMENT 'Total volume of purified renewable natural gas produced during this production run, measured in standard cubic feet (SCF).',
    `shift_type` STRING COMMENT 'Work shift during which this RNG production occurred. Used for operational scheduling and performance analysis by shift.. Valid values are `day|night|swing`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this RNG production record was last modified in the system.',
    `uptime_hours` DECIMAL(18,2) COMMENT 'Number of hours the RNG production facility was operational during this production period. Used for availability and reliability metrics.',
    `vehicle_fuel_dispensed_gge` DECIMAL(18,2) COMMENT 'Volume of RNG dispensed as vehicle fuel (CNG/RNG) during this production period, measured in gasoline gallon equivalents (GGE) for energy comparison purposes.',
    `voluntary_carbon_credits_issued` DECIMAL(18,2) COMMENT 'Number of voluntary carbon offset credits issued for this RNG production under voluntary carbon market programs (e.g., Verra VCS, Gold Standard).',
    CONSTRAINT pk_rng_production PRIMARY KEY(`rng_production_id`)
) COMMENT 'Transactional record of Renewable Natural Gas (RNG) production from LFG-to-RNG conversion facilities. Captures raw LFG input volume, RNG output volume (MMBtu), methane purity percentage, pipeline injection quantity, vehicle fuel dispensed (GGE), RIN (Renewable Identification Number) credits generated, and production efficiency metrics. Supports EPA Renewable Fuel Standard (RFS2) RIN generation reporting and voluntary carbon market credit issuance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`srf_production` (
    `srf_production_id` BIGINT COMMENT 'Unique identifier for the SRF production record. Primary key for tracking individual production batches at MRF and processing facilities.',
    `employee_id` BIGINT COMMENT 'Identifier of the facility operator or supervisor responsible for the SRF production batch. Used for quality accountability and training needs analysis.',
    `facility_id` BIGINT COMMENT 'Identifier of the MRF or processing facility where SRF production occurred. Links to the facility master data.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: SRF production involves industrial equipment with injury risks (conveyors, shredders, fires). Real business process: incident tracking for production line injuries, equipment failures, fire events aff',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: SRF production output should be tracked as a material in the material master for inventory management, sales order processing, and revenue recognition. When SRF is sold to end-use customers (cement ki',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: SRF production facilities require air quality permits for processing equipment and potential emissions (particulate matter, VOCs from waste handling). Permit authorization is required for operations. ',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: SRF production is tracked within reporting periods. One production record belongs to one reporting period (1:N). New FK needed. Removes redundant esg_reporting_period string.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: SRF production lines require machine guarding, LOTO, fire prevention programs per OSHA standards. Real business process: OSHA compliance program assignment for material recovery and processing operati',
    `srf_production_line_id` BIGINT COMMENT 'Identifier of the specific processing line or equipment used for SRF production. Enables equipment performance analysis and maintenance correlation.',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Percentage of ash residue remaining after SRF combustion. Lower ash content indicates higher fuel quality and reduced disposal requirements.',
    `bill_of_lading_number` STRING COMMENT 'Unique shipping document identifier for the SRF transport. Required for logistics tracking and chain of custody documentation.. Valid values are `^BOL-[A-Z0-9]{8,15}$`',
    `bulk_density_kg_m3` DECIMAL(18,2) COMMENT 'Bulk density of the SRF in kilograms per cubic meter. Important for transportation planning and storage capacity calculations.',
    `calorific_value_mj_kg` DECIMAL(18,2) COMMENT 'Net calorific value of the SRF in megajoules per kilogram. Critical quality parameter determining suitability for energy recovery applications per EN 15359 standard.',
    `chlorine_content_percent` DECIMAL(18,2) COMMENT 'Percentage of chlorine content in the SRF batch. Critical parameter for Clean Air Act compliance as high chlorine can produce harmful emissions during combustion.',
    `co2e_emissions_avoided_tons` DECIMAL(18,2) COMMENT 'Estimated tons of CO2 equivalent greenhouse gas emissions avoided by using SRF instead of fossil fuels. Critical for carbon offset program reporting and ESG disclosures.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the SRF batch has received all required environmental and quality certifications for legal sale and use.',
    `contamination_level` STRING COMMENT 'Assessment of non-combustible or hazardous material contamination in the SRF batch. Impacts quality classification and end-user acceptance.. Valid values are `low|medium|high|acceptable`',
    `conversion_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage of input waste successfully converted to SRF, calculated as (SRF output / input volume) * 100. Key performance indicator for production optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SRF production record was first created in the system. Used for data lineage and audit trail purposes.',
    `destination_facility_name` STRING COMMENT 'Name of the specific facility or customer receiving the SRF for energy recovery purposes. Used for supply chain tracking and revenue allocation.',
    `diversion_rate_contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill through this SRF production batch. Key sustainability metric for GRI 306 waste diversion reporting.',
    `end_use_destination_type` STRING COMMENT 'Category of facility where the SRF will be utilized for energy recovery. WTE = Waste-to-Energy facility. Critical for circular economy tracking.. Valid values are `cement_kiln|industrial_boiler|wte_facility|power_plant|other`',
    `heavy_metals_ppm` DECIMAL(18,2) COMMENT 'Concentration of heavy metals (mercury, cadmium, lead) in parts per million. Critical for environmental compliance and end-user acceptance criteria.',
    `input_volume_tons` DECIMAL(18,2) COMMENT 'Total weight in tons of input waste material processed to produce the SRF batch. Critical for diversion rate calculations.',
    `input_waste_stream_type` STRING COMMENT 'Classification of the waste stream used as feedstock for SRF production. MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste.. Valid values are `MSW|C&D|commercial|industrial|mixed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SRF production record was last updated. Supports change tracking and data quality monitoring.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the SRF batch. Lower moisture content improves combustion efficiency and energy output.',
    `particle_size_mm` DECIMAL(18,2) COMMENT 'Average particle size of the SRF material in millimeters. Affects combustion efficiency and handling characteristics at end-use facilities.',
    `production_batch_number` STRING COMMENT 'Externally-known unique batch identifier assigned to the SRF production run for traceability and quality control purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `production_cost_per_ton` DECIMAL(18,2) COMMENT 'Total cost per ton to produce the SRF including labor, energy, and processing costs. Used for margin analysis and EBITDA calculations.',
    `production_date` DATE COMMENT 'Date when the SRF production batch was completed. Used for production tracking and compliance reporting.',
    `production_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the SRF production batch processing was completed. Used to calculate production duration and throughput rates.',
    `production_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the SRF production batch processing began. Enables production cycle time analysis.',
    `production_status` STRING COMMENT 'Current lifecycle status of the SRF production batch. Tracks progression from production through quality testing to shipment.. Valid values are `completed|in_progress|quality_hold|rejected|shipped`',
    `quality_certification_number` STRING COMMENT 'Unique certification identifier issued by the testing laboratory confirming SRF quality parameters meet specified standards.. Valid values are `^QC-[0-9]{8,12}$`',
    `quality_classification` STRING COMMENT 'SRF quality grade per EN 15359 standard based on calorific value, chlorine content, and mercury content. Class 1 represents highest quality. [ENUM-REF-CANDIDATE: class_1|class_2|class_3|class_4|class_5|non_compliant|pending_analysis — promote to reference product]. Valid values are `class_1|class_2|class_3|class_4|class_5|non_compliant`',
    `quality_test_date` DATE COMMENT 'Date when laboratory quality testing was completed for the SRF batch. Required for certification and customer acceptance.',
    `rejection_reason` STRING COMMENT 'Explanation for why the SRF batch failed quality standards or was rejected by the end-user. Used for continuous improvement and process optimization.',
    `renewable_energy_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether this SRF batch qualifies for renewable energy credits or carbon offset programs based on feedstock composition and quality standards.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from the sale of this SRF batch in USD. Used for financial reporting and profitability analysis.',
    `shipment_date` DATE COMMENT 'Date when the SRF batch was shipped to the end-use destination. Used for inventory management and revenue recognition timing.',
    `srf_output_tonnage` DECIMAL(18,2) COMMENT 'Total weight in tons of SRF produced from the input waste stream. Used for yield calculations and revenue reporting.',
    `storage_location` STRING COMMENT 'Physical location or bin identifier where the SRF batch is stored at the production facility prior to shipment. Used for inventory management.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the SRF batch. Monitored for EPA emissions compliance and air quality standards.',
    `unit_price_per_ton` DECIMAL(18,2) COMMENT 'Price per ton charged for the SRF batch in USD. Varies based on quality classification and market conditions.',
    CONSTRAINT pk_srf_production PRIMARY KEY(`srf_production_id`)
) COMMENT 'Transactional record of Solid Recovered Fuel (SRF) production at MRF and processing facilities. Captures input waste stream volume (tons), SRF output tonnage, calorific value (MJ/kg), moisture content, chlorine content, ash content, quality classification per EN 15359 standard, and end-use destination (cement kiln, industrial boiler, WTE). Supports diversion rate calculations and circular economy reporting under GRI 306 Waste disclosures.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`diversion_record` (
    `diversion_record_id` BIGINT COMMENT 'Unique identifier for the diversion record. Primary key.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_economy_program. Business justification: Diversion records can be attributed to specific circular economy programs. One diversion record can be part of one program (1:N). New FK needed to link diversion performance to programs.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Account-level diversion aggregation for customer sustainability reports, contract performance verification (SLA diversion targets), and customer-facing ESG dashboards. Supports billing for performance',
    `contract_id` BIGINT COMMENT 'Identifier of the customer contract or municipal agreement under which diversion performance is tracked and reported. Links to contractual SLA commitments.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (MRF, transfer station, landfill, WTE plant) where the diversion activity occurred.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Incidents at diversion facilities (MRF injuries, equipment failures) impact diversion rates and operations. Real business process: incident impact assessment on facility performance metrics, ESG repor',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that submitted the diversion record for approval.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: Diversion records are tracked within reporting periods. One diversion record belongs to one reporting period (1:N). New FK needed. Removes redundant date columns.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Diversion rates calculated per service location for customer reporting, regulatory compliance (municipal franchise agreements), and site-specific sustainability performance tracking. Essential for zer',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Specific service enrollments (recycling, composting, organics) generate measurable diversion outcomes. Required for service-level performance measurement, billing verification, and enrollment-specific',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the diversion record was approved and finalized for reporting, in ISO 8601 format.',
    `audit_verification_date` DATE COMMENT 'Date when the diversion record was verified by third-party auditor or internal compliance team for accuracy and regulatory compliance.',
    `certification_standard` STRING COMMENT 'Environmental certification or sustainability standard applicable to this diversion activity: ISO 14001 (Environmental Management), LEED (green building), TRUE (zero waste facility certification), Zero Waste certification, or none.. Valid values are `iso_14001|leed|true_certification|zero_waste|none`',
    `contamination_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of received recyclable material that was contaminated and could not be processed for diversion. Indicates quality of incoming waste stream.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the diversion record was first created in the system, in ISO 8601 format.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this diversion record was sourced (e.g., Enviance EHS, AMCS Platform, SAP EHS module, facility scale system).',
    `diversion_pathway` STRING COMMENT 'Primary pathway through which waste was diverted from landfill: recycling, composting, RNG (Renewable Natural Gas) conversion, SRF (Solid Recovered Fuel) production, WTE (Waste-to-Energy), or beneficial reuse.. Valid values are `recycling|composting|rng_conversion|srf_production|wte|beneficial_reuse`',
    `diversion_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of total waste received that was diverted from landfill. Calculated as (waste_diverted_tons / total_waste_received_tons) * 100.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this diversion record is included in corporate ESG reporting and sustainability disclosures (GRI, TCFD, CDP). True if included, False otherwise.',
    `ghg_emissions_avoided_co2e_tons` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions avoided through diversion activities, measured in metric tons of carbon dioxide equivalent (CO2e). Supports EPA GHG reporting and ESG disclosures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the diversion record was last updated or modified, in ISO 8601 format.',
    `material_type` STRING COMMENT 'Type of waste material received. MSW (Municipal Solid Waste), C&D (Construction and Demolition Waste), organics, e-waste, metals, plastics, paper/cardboard. [ENUM-REF-CANDIDATE: msw|c_and_d|organics|e_waste|metals|plastics|paper_cardboard — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional context, explanations, or operational notes related to the diversion record (e.g., equipment downtime, unusual waste composition, data quality issues).',
    `processing_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred to process and divert waste during the reporting period, including labor, equipment, and facility operating costs, in US dollars.',
    `record_status` STRING COMMENT 'Current lifecycle status of the diversion record: draft (in preparation), submitted (sent for review), approved (validated and finalized), audited (third-party verified), archived (historical record).. Valid values are `draft|submitted|approved|audited|archived`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this diversion record is required for regulatory reporting to state solid waste authorities (SWIS), EPA, or other environmental agencies. True if required, False otherwise.',
    `revenue_generated_usd` DECIMAL(18,2) COMMENT 'Revenue generated from the sale of diverted materials (recyclables, compost, RNG, SRF) during the reporting period, in US dollars.',
    `service_line` STRING COMMENT 'Business service line or customer segment generating the waste stream (residential, commercial, industrial, municipal, special waste, hazardous).. Valid values are `residential|commercial|industrial|municipal|special_waste|hazardous`',
    `total_waste_received_tons` DECIMAL(18,2) COMMENT 'Total tonnage of waste received at the facility during the reporting period, measured in tons.',
    `waste_diverted_tons` DECIMAL(18,2) COMMENT 'Tonnage of waste diverted from landfill disposal through recycling, composting, energy recovery, or other beneficial use pathways, measured in tons.',
    `waste_to_landfill_tons` DECIMAL(18,2) COMMENT 'Tonnage of waste sent to landfill disposal during the reporting period, measured in tons.',
    CONSTRAINT pk_diversion_record PRIMARY KEY(`diversion_record_id`)
) COMMENT 'Transactional record capturing waste diversion performance by facility, service line, and reporting period. Tracks total waste received (tons), waste diverted from landfill (tons), diversion rate percentage, diversion pathway (recycling, composting, RNG, SRF, WTE), and material type (MSW, C&D, organics, e-waste). Serves as the authoritative source for diversion rate KPIs reported to municipal clients, state solid waste authorities (SWIS), and ESG frameworks (GRI 306).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` (
    `carbon_offset_id` BIGINT COMMENT 'Unique identifier for the carbon offset credit record. Primary key for the carbon offset master data.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Carbon offsets can be purchased to support specific carbon reduction initiatives. One offset supports one initiative (1:N). New FK needed to link offset purchases to the initiatives they fund.',
    `carbon_registry_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_registry. Business justification: Carbon offsets are registered in carbon credit registries. One offset is registered in one registry (1:N). New FK needed. Removes redundant registry_name string that can be retrieved from carbon_regis',
    `carbon_project_id` BIGINT COMMENT 'Unique project identifier assigned by the carbon registry (e.g., VCS project ID, Gold Standard GS number, ACR project code).',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Carbon offset purchases should flow through procurement. Linking to purchase order enables proper procurement controls, three-way match, payment processing, and audit compliance. Procurement governanc',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: Carbon offsets are purchased and retired within specific reporting periods. One offset transaction belongs to one reporting period (1:N). New FK needed. Removes redundant ghg_inventory_period string.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Carbon offsets are purchased from vendors/brokers. Vendor linkage is fundamental to procurement controls, payment processing (AP three-way match), vendor performance evaluation, and ongoing offset cre',
    `additionality_verified` BOOLEAN COMMENT 'Indicates whether the offset project has been verified to meet additionality criteria (i.e., emission reductions would not have occurred without the carbon finance incentive). True if verified, False otherwise.',
    `carbon_offset_status` STRING COMMENT 'Current lifecycle status of the carbon offset credit. Active: available for retirement; Retired: permanently claimed; Cancelled: invalidated; Expired: past eligibility window.. Valid values are `Active|Retired|Cancelled|Expired`',
    `co_benefits` STRING COMMENT 'Additional environmental or social benefits delivered by the offset project beyond carbon reduction (e.g., Biodiversity conservation, Community employment, Water quality improvement, UN SDG alignment).',
    `cost_center_code` STRING COMMENT 'SAP FI/CO cost center code to which the carbon offset purchase expense is allocated (typically sustainability or environmental compliance cost center).',
    `created_by_user` STRING COMMENT 'Username or employee identifier of the person who created this carbon offset record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon offset record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_type` STRING COMMENT 'Classification of the carbon offset mechanism: Avoidance (preventing emissions that would have occurred), Removal (sequestering CO2 from atmosphere), or Reduction (decreasing emissions from baseline).. Valid values are `Avoidance|Removal|Reduction`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase transaction (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'General ledger account code in SAP FI for booking the carbon offset purchase expense or asset.',
    `internal_notes` STRING COMMENT 'Free-text field for internal comments, procurement notes, or strategic rationale for the carbon offset purchase.',
    `permanence_risk_rating` STRING COMMENT 'Assessment of the risk that the carbon sequestration or emission reduction may be reversed (e.g., forest fire, project failure). Particularly relevant for forestry and land-use projects.. Valid values are `Low|Medium|High`',
    `project_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the carbon offset project is located (e.g., USA, BRA, KEN).. Valid values are `^[A-Z]{3}$`',
    `project_name` STRING COMMENT 'Full name of the carbon offset project from which credits were purchased or generated (e.g., Amazon Rainforest Conservation REDD+, Iowa Wind Farm Renewable Energy).',
    `project_region` STRING COMMENT 'Geographic region or state/province where the offset project is located (e.g., California, Amazon Basin, Sub-Saharan Africa).',
    `project_type` STRING COMMENT 'Category of carbon offset project methodology (e.g., Renewable Energy, Forestry and Land Use, Methane Capture, Energy Efficiency, Landfill Gas to Renewable Natural Gas (LFG-to-RNG)).',
    `purchase_date` DATE COMMENT 'Date on which the carbon offset credits were purchased or acquired by Waste Management.',
    `purchase_price_per_tco2e` DECIMAL(18,2) COMMENT 'Unit price paid per metric ton of CO2 equivalent for the carbon offset credits. Used for carbon pricing disclosure and internal carbon accounting.',
    `quantity_tco2e` DECIMAL(18,2) COMMENT 'Total quantity of carbon offset credits in metric tons of CO2 equivalent (tCO2e). Represents the verified greenhouse gas emission reductions or removals.',
    `reporting_framework` STRING COMMENT 'Comma-separated list of voluntary or mandatory reporting frameworks for which this offset credit is used (e.g., CDP Climate Change, GRI 305, TCFD, SEC Climate Disclosure, EPA GHG Reporting Program).',
    `retirement_date` DATE COMMENT 'Date on which the carbon offset credits were retired (permanently removed from circulation) to claim the emission reduction benefit. Nullable for credits not yet retired.',
    `retirement_reason` STRING COMMENT 'Business purpose or program for which the credits were retired (e.g., FY2023 Scope 1 Emissions Offset, Net-Zero Commitment 2030, Voluntary CDP Disclosure).',
    `retirement_serial_number` STRING COMMENT 'Unique serial number or certificate identifier issued by the carbon registry upon retirement of the credits. Provides proof of retirement for reporting and verification.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goals (SDGs) that the offset project contributes to (e.g., SDG 7: Affordable and Clean Energy, SDG 13: Climate Action, SDG 15: Life on Land).',
    `total_purchase_amount` DECIMAL(18,2) COMMENT 'Total monetary amount paid for the carbon offset credit purchase (quantity × unit price). Denominated in USD unless otherwise specified.',
    `updated_by_user` STRING COMMENT 'Username or employee identifier of the person who last modified this carbon offset record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon offset record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verification_body` STRING COMMENT 'Name of the independent third-party organization that verified the emission reductions for the offset project (e.g., SCS Global Services, DNV, Bureau Veritas).',
    `verification_standard` STRING COMMENT 'The third-party verification standard or methodology under which the offset project was validated and verified (e.g., VCS v4.0, Gold Standard for the Global Goals, ACR Standard v6.0).',
    `vintage_year` STRING COMMENT 'The calendar year in which the greenhouse gas emission reductions or removals occurred. Vintage year affects credit value and eligibility for certain compliance programs.',
    CONSTRAINT pk_carbon_offset PRIMARY KEY(`carbon_offset_id`)
) COMMENT 'Master record of carbon offset credits purchased, generated, and retired by Waste Management. Captures offset project name, registry (Gold Standard, VCS/Verra, ACR, CAR), credit type (avoidance, removal), vintage year, quantity (tCO2e), purchase price, retirement date, retirement serial number, and associated GHG inventory period. Supports net-zero commitment tracking, voluntary carbon market participation, and CDP carbon pricing disclosures.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` (
    `offset_transaction_id` BIGINT COMMENT 'Unique identifier for the carbon offset transaction record. Primary key for the offset transaction entity.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key reference to the internal corporate carbon reduction initiative or program that this transaction supports.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: offset_transaction is a transactional record of individual carbon offset credit purchase, transfer, and retirement events. It currently duplicates master data from carbon_offset (project_id, project_n',
    `carbon_registry_id` BIGINT COMMENT 'FK to sustainability.carbon_registry',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Each offset transaction should reference its procurement document for financial controls. Linking to purchase order enables three-way match (PO-transaction confirmation-invoice), payment processing, p',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: Offset transactions occur within specific reporting periods. One transaction belongs to one reporting period (1:N). New FK needed. Removes redundant reporting_period string.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Each offset transaction involves a counterparty vendor. While counterparty_name exists (denormalized), linking to vendor master enables proper vendor management, payment processing via AP, consolidate',
    `additionality_verified` BOOLEAN COMMENT 'Indicates whether the offset project has been verified to meet additionality criteria (i.e., reductions would not have occurred without the carbon finance incentive).',
    `approval_date` DATE COMMENT 'Date when this offset transaction was approved by authorized personnel.',
    `approved_by_user` STRING COMMENT 'Username or employee ID of the person who approved this offset transaction for execution.',
    `compliance_program` STRING COMMENT 'Name of regulatory or voluntary compliance program for which these offsets are eligible (e.g., California Cap-and-Trade, RGGI, voluntary CDP commitment).',
    `cost_center_code` STRING COMMENT 'SAP Controlling (CO) cost center code to which this offset transaction cost is allocated for financial reporting.',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty organization involved in the transaction. [ENUM-REF-CANDIDATE: broker|registry|project_developer|corporate_buyer|government_entity|ngo|exchange — 7 candidates stripped; promote to reference product]',
    `created_by_user` STRING COMMENT 'Username or employee ID of the person who created this transaction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offset transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction monetary values.. Valid values are `^[A-Z]{3}$`',
    `general_ledger_account` STRING COMMENT 'General ledger account code in SAP FI for posting the carbon offset asset or expense.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offset transaction record was last updated.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net transaction amount after deducting fees (total cost minus transaction fee).',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or audit notes related to this offset transaction.',
    `permanence_risk_rating` STRING COMMENT 'Assessment of the risk that carbon reductions from this project could be reversed (particularly relevant for forestry and soil carbon projects).. Valid values are `low|medium|high|not_applicable`',
    `quantity_tco2e` DECIMAL(18,2) COMMENT 'Number of carbon offset credits involved in the transaction, measured in metric tons of carbon dioxide equivalent. This is the principal quantitative measure for the transaction.',
    `registry_confirmation_number` STRING COMMENT 'Unique confirmation or serial number issued by the carbon offset registry to verify and track this transaction. Critical for third-party audit trails.',
    `retirement_reason` STRING COMMENT 'Business justification or purpose for retiring carbon offset credits (e.g., offsetting Scope 1 emissions, voluntary commitment, regulatory compliance, customer carbon-neutral claim).',
    `scope_allocation` STRING COMMENT 'GHG Protocol emissions scope that this offset transaction is intended to address (Scope 1 direct emissions, Scope 2 indirect energy, Scope 3 value chain, or voluntary beyond compliance).. Valid values are `scope_1|scope_2|scope_3|voluntary`',
    `settlement_date` DATE COMMENT 'Date when the transaction was fully settled and credits were transferred in the registry system.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary value of the transaction (quantity × unit price), representing the gross transaction amount before fees or adjustments.',
    `transaction_date` DATE COMMENT 'Date when the carbon offset transaction was executed or initiated. This is the business event date used for financial and compliance reporting.',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Registry or broker fees charged for processing the offset transaction.',
    `transaction_number` STRING COMMENT 'Externally-visible unique business identifier for the offset transaction, used in registry confirmations and audit trails.. Valid values are `^OT-[0-9]{8}-[A-Z0-9]{6}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the offset transaction in the settlement workflow.. Valid values are `pending|confirmed|settled|cancelled|failed|under_review`',
    `transaction_type` STRING COMMENT 'Type of carbon offset transaction: purchase (acquiring credits), transfer (moving credits between accounts), retirement (permanently removing credits from circulation), cancellation (voiding credits), issuance (initial credit creation), or reversal (correcting erroneous transaction).. Valid values are `purchase|transfer|retirement|cancellation|issuance|reversal`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per metric ton of CO2e for the offset credits in this transaction.',
    `verification_date` DATE COMMENT 'Date when third-party verification of this transaction was completed.',
    `verification_status` STRING COMMENT 'Status of third-party verification for this offset transaction, required for external ESG reporting and assurance.. Valid values are `verified|pending_verification|failed_verification|not_required`',
    `verifier_name` STRING COMMENT 'Name of the third-party verification body or auditor that validated this offset transaction.',
    CONSTRAINT pk_offset_transaction PRIMARY KEY(`offset_transaction_id`)
) COMMENT 'Transactional record of individual carbon offset credit purchase, transfer, and retirement events. Captures transaction date, transaction type (purchase, transfer, retirement, cancellation), quantity (tCO2e), counterparty broker or registry, unit price, total cost, associated carbon initiative, and registry confirmation number. Provides the audit trail required for third-party GHG verification and financial reporting of carbon asset positions.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` (
    `renewable_energy_credit_id` BIGINT COMMENT 'Unique identifier for the renewable energy credit record. Primary key.',
    `carbon_registry_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_registry. Business justification: RECs are tracked in carbon credit registries. One REC is registered in one registry (1:N). New FK needed. Removes redundant registry_name and account_number strings that can be retrieved from carbon_r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REC portfolio management requires designated staff for acquisition strategy, retirement timing, compliance program tracking (RPS, voluntary), and ESG disclosure coordination.',
    `facility_id` BIGINT COMMENT 'Reference to the facility that generated the renewable energy. Links to the facility master record (landfill, WTE plant, solar installation, etc.).',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REC purchases flow through procurement. Linking RECs to originating purchase orders enables three-way match (PO-GR-Invoice), payment processing, procurement compliance, and audit trail. AP requires PO',
    `reduction_target_id` BIGINT COMMENT 'Reference to the corporate sustainability target or goal that this certificate was applied to upon retirement. Links to sustainability target master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Renewable energy credits are acquired from vendors/brokers. Tracking vendor_id enables procurement management, payment processing, vendor performance evaluation, and contract compliance. Procurement a',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'Total cost in US dollars paid to acquire this certificate. Zero for self-generated certificates. Used for financial accounting and ROI analysis.',
    `acquisition_date` DATE COMMENT 'Date on which Waste Management acquired ownership of this certificate, either through generation at owned facilities or through purchase.',
    `acquisition_method` STRING COMMENT 'Method by which Waste Management acquired this certificate. Self-Generated = produced at WM-owned facility, Purchased = bought from external party, Transferred In = received from partner or subsidiary.. Valid values are `Self-Generated|Purchased|Transferred In|Allocated|Other`',
    `certificate_serial_number` STRING COMMENT 'Unique serial number assigned by the issuing registry to this renewable energy certificate. This is the externally-known business identifier used for tracking and verification across registries.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the renewable energy certificate. Active = available for use, Retired = applied to sustainability target, Transferred = sold or moved to another entity.. Valid values are `Active|Retired|Transferred|Expired|Cancelled|Pending`',
    `certificate_type` STRING COMMENT 'Type of renewable energy certificate. REC = Renewable Energy Certificate, RIN = Renewable Identification Number, LCFS = Low Carbon Fuel Standard credit.. Valid values are `REC|RIN|LCFS|Carbon Offset|Green-e|Other`',
    `co2e_offset_metric_tons` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions offset by this renewable energy certificate, measured in metric tons of CO2 equivalent. Calculated using EPA emission factors.',
    `compliance_program` STRING COMMENT 'Regulatory or voluntary program for which this certificate is eligible. EPA RFS = EPA Renewable Fuel Standard, California LCFS = California Low Carbon Fuel Standard, State RPS = State Renewable Portfolio Standard.. Valid values are `EPA RFS|California LCFS|State RPS|Voluntary|None|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the system. Used for audit trail and data lineage.',
    `eia_plant_code` STRING COMMENT 'EIA-assigned plant code for the generating facility. Used for federal energy reporting and cross-referencing with EIA databases.',
    `eligibility_flags` STRING COMMENT 'Comma-separated list of eligibility attributes for this certificate (e.g., Green-e Certified, EPA Verified, California Eligible). Used for compliance matching and customer claims.',
    `energy_source` STRING COMMENT 'Type of renewable energy source. LFG = Landfill Gas, RNG = Renewable Natural Gas, WTE = Waste-to-Energy. [ENUM-REF-CANDIDATE: LFG|RNG|WTE|Solar|Wind|Biomass|Biogas|Other — 8 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'Date on which the certificate expires and can no longer be used for compliance or voluntary claims. Null if the certificate does not expire.',
    `facility_state` STRING COMMENT 'Two-letter US state code where the generating facility is located. Used for state-level compliance and reporting.',
    `generation_end_date` DATE COMMENT 'End date of the generation period for this certificate. Defines the end of the time window during which the renewable energy was produced.',
    `generation_start_date` DATE COMMENT 'Start date of the generation period for this certificate. Defines the beginning of the time window during which the renewable energy was produced.',
    `issuance_date` DATE COMMENT 'Date on which the certificate was officially issued by the registry. Represents when the certificate became active and available for trading or retirement.',
    `market_value_usd` DECIMAL(18,2) COMMENT 'Estimated current market value of this certificate in US dollars based on prevailing market prices for the certificate type and vintage. Updated periodically for asset valuation.',
    `notes` STRING COMMENT 'Free-text notes and comments about this certificate, including special conditions, restrictions, or transaction details.',
    `quantity_gge` DECIMAL(18,2) COMMENT 'Quantity of renewable fuel represented by this certificate, measured in gasoline gallon equivalents. Used for RIN certificates from RNG and biofuel production.',
    `quantity_mmbtu` DECIMAL(18,2) COMMENT 'Quantity of renewable thermal energy represented by this certificate, measured in million British thermal units. Used for thermal energy credits and RNG certificates.',
    `quantity_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable electricity represented by this certificate, measured in megawatt-hours. Used for REC certificates from solar, wind, and WTE facilities.',
    `retirement_date` DATE COMMENT 'Date on which the certificate was retired (applied to a sustainability target or compliance obligation). Null if the certificate has not been retired.',
    `retirement_reason` STRING COMMENT 'Business reason for retiring the certificate. Compliance = used to meet regulatory requirement, Voluntary = used for voluntary sustainability commitment, ESG Reporting = applied to ESG disclosure target.. Valid values are `Compliance|Voluntary|ESG Reporting|Customer Claim|Internal Target|Other`',
    `transfer_date` DATE COMMENT 'Date on which the certificate was transferred to another entity. Null if the certificate has not been transferred.',
    `transfer_recipient` STRING COMMENT 'Name of the entity to which the certificate was transferred. Used for audit trail and transaction history.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified. Used for audit trail and change tracking.',
    `vintage_month` STRING COMMENT 'Month (1-12) in which the renewable energy was generated. Provides granular tracking for quarterly and monthly reporting.',
    `vintage_year` STRING COMMENT 'Calendar year in which the renewable energy was generated. Used for compliance period matching and market valuation.',
    CONSTRAINT pk_renewable_energy_credit PRIMARY KEY(`renewable_energy_credit_id`)
) COMMENT 'Master record of Renewable Energy Certificates (RECs) and RINs held by Waste Management from solar, wind, RNG, and WTE generation. Captures certificate type (REC, RIN, LCFS credit), generating facility, energy source, vintage period, quantity (MWh or GGE), registry (WREGIS, EPA EMTS), certificate serial number, status (active, retired, transferred), and associated sustainability target. Supports Clean Air Act compliance and voluntary renewable energy procurement reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`reduction_target` (
    `reduction_target_id` BIGINT COMMENT 'Unique identifier for the sustainability reduction target record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corporate GHG reduction targets require C-suite sponsorship for board approval, SBTi validation, public disclosure commitments, and investor relations communications.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Segment-specific sustainability targets (e.g., commercial segment 50% diversion by 2030, residential segment 30% contamination reduction) drive strategic planning, service design, and performance mana',
    `achievement_date` DATE COMMENT 'Date when the target was officially achieved and verified. Null if not yet achieved.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The quantitative baseline measurement in the baseline year. Represents the starting point from which reduction is calculated.',
    `baseline_year` STRING COMMENT 'The reference year against which progress toward the target is measured. Typically the starting point for reduction calculations.',
    `board_approval_date` DATE COMMENT 'Date when the target was formally approved by the Board of Directors or equivalent governance body. Critical for demonstrating executive commitment.',
    `business_unit_scope` STRING COMMENT 'Identifies which business units or divisions this target applies to (e.g., Fleet Operations, Landfill Operations, Corporate-wide). May be hierarchical or multi-select.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the target commitment. Tracks progression from draft through achievement or cancellation. [ENUM-REF-CANDIDATE: draft|committed|approved|active|achieved|revised|cancelled — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this target record was first created in the system. Audit trail field.',
    `exclusions_notes` STRING COMMENT 'Documents any exclusions from the target scope (e.g., specific facilities, acquired entities, divested operations). Required for transparency and comparability.',
    `framework_alignment` STRING COMMENT 'Indicates alignment with external sustainability frameworks and standards (e.g., SBTi, GRI, TCFD, CDP, RE100). Multiple frameworks may be listed. [ENUM-REF-CANDIDATE: sbti|gri|tcfd|cdp|re100|ungc|sasb|iso14001 — promote to reference product]',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the target (e.g., USA, North America, Global). Uses ISO 3166-1 alpha-3 country codes where applicable.',
    `interim_milestone_value` DECIMAL(18,2) COMMENT 'Quantitative goal for the interim milestone year. Enables tracking of progress toward the final target.',
    `interim_milestone_year` STRING COMMENT 'Optional intermediate year for progress checkpoints between baseline and target year (e.g., 2025 milestone for a 2030 target).',
    `linked_initiative_ids` STRING COMMENT 'Comma-separated list of initiative or project IDs that contribute to achieving this target (e.g., fleet electrification projects, renewable energy installations, waste diversion programs).',
    `methodology_description` STRING COMMENT 'Detailed description of the calculation methodology, assumptions, and data sources used to establish baseline and target values. Critical for audit and verification.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this target record was last modified. Audit trail field for change tracking.',
    `notes` STRING COMMENT 'Additional context, assumptions, or commentary about the target. Free-text field for supplementary information not captured elsewhere.',
    `owner_department` STRING COMMENT 'Department or functional area responsible for target execution and reporting (e.g., Sustainability, Fleet Management, Operations).',
    `owner_name` STRING COMMENT 'Name of the executive or business leader accountable for achieving this target (e.g., Chief Sustainability Officer, VP Fleet Operations).',
    `public_announcement_date` DATE COMMENT 'Date when the target was publicly announced or disclosed in sustainability reports, press releases, or regulatory filings.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this target has been publicly disclosed in sustainability reports, investor communications, or regulatory filings.',
    `reduction_percentage` DECIMAL(18,2) COMMENT 'The percentage reduction from baseline to target (calculated as ((baseline_value - target_value) / baseline_value) * 100). Used for reporting and tracking progress.',
    `regulatory_driver` STRING COMMENT 'Identifies any regulatory requirements or mandates that drive this target (e.g., Clean Air Act, State RPS Requirements, EPA GHG Reporting). Null if voluntary.',
    `reporting_frequency` STRING COMMENT 'Cadence at which progress toward this target is measured and reported internally and externally.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `revision_date` DATE COMMENT 'Date when the target was last revised or updated. Null if never revised. Revisions may occur due to methodology changes, acquisitions, or strategic shifts.',
    `revision_reason` STRING COMMENT 'Explanation for why the target was revised, including business rationale and methodology changes. Required for transparency and stakeholder communication.',
    `sbti_validated_flag` BOOLEAN COMMENT 'Indicates whether this target has been validated and approved by the Science Based Targets initiative as aligned with climate science.',
    `scope` STRING COMMENT 'For GHG reduction targets, indicates the emissions scope covered (Scope 1: direct emissions, Scope 2: purchased energy, Scope 3: value chain). May be combined (e.g., Scope 1+2). Null for non-GHG targets.',
    `target_category` STRING COMMENT 'Classification of the sustainability target type. Aligns with corporate sustainability pillars and ESG reporting frameworks.. Valid values are `ghg_reduction|diversion_rate|renewable_energy|fleet_electrification|waste_to_energy|circular_economy`',
    `target_code` STRING COMMENT 'Unique business identifier or code for the target used in external reporting and internal tracking systems.',
    `target_name` STRING COMMENT 'Business-friendly name of the sustainability target (e.g., 2030 Net Zero Commitment, Fleet Electrification Goal).',
    `target_type` STRING COMMENT 'Indicates whether the target is measured as an absolute reduction (total emissions/waste) or intensity-based (per unit of activity, e.g., CO2e per ton processed).. Valid values are `absolute|intensity`',
    `target_value` DECIMAL(18,2) COMMENT 'The quantitative goal to be achieved by the target year. May represent absolute reduction or intensity metric depending on target_type.',
    `target_year` STRING COMMENT 'The year by which the target is committed to be achieved (e.g., 2030, 2050 for net-zero commitments).',
    `unit_of_measure` STRING COMMENT 'The unit in which baseline and target values are expressed (e.g., metric tons CO2e, percentage, MWh, tons per day). [ENUM-REF-CANDIDATE: metric_tons_co2e|percentage|mwh|tpd|gallons|therms|kwh|cubic_meters — promote to reference product]',
    `verification_date` DATE COMMENT 'Date when third-party verification or audit of the target was completed. Null if not yet verified.',
    `verification_status` STRING COMMENT 'Indicates the level of external assurance or verification applied to the target and its underlying data.. Valid values are `not_verified|internal_review|third_party_verified|audited`',
    `verifier_organization` STRING COMMENT 'Name of the third-party organization that verified or audited the target (e.g., Deloitte, ERM, Bureau Veritas). Null if not externally verified.',
    CONSTRAINT pk_reduction_target PRIMARY KEY(`reduction_target_id`)
) COMMENT 'Master record of corporate sustainability targets and commitments including Science Based Targets (SBTi), net-zero pledges, diversion rate goals, renewable energy adoption targets, and fleet electrification milestones. Captures target name, target category (GHG reduction, diversion, renewable energy, fleet), baseline year, baseline value, target year, target value, unit of measure, target type (absolute, intensity), and alignment to external framework (SBTi, GRI, TCFD, CDP). Serves as the authoritative registry of all public sustainability commitments.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`target_progress` (
    `target_progress_id` BIGINT COMMENT 'Unique identifier for the target progress record. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the specific facility if progress is tracked at facility level. Links to the facility product in the asset domain. Null for enterprise-wide or aggregated targets.',
    `reduction_target_id` BIGINT COMMENT 'Reference to the parent sustainability target being tracked. Links to the sustainability_target product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Target progress reporting requires designated analysts for data aggregation across facilities, verification against baselines, variance analysis, and ESG framework alignment (CDP, GRI, TCFD).',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Target progress tracking requires facility-level performance data for corporate reduction target achievement reporting. Links sustainability goals to operational assets for ESG disclosure and SBTi ver',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual measured performance value achieved during the reporting period. Represents raw metric value before percentage calculation (e.g., tons CO2e emitted, percentage waste diverted, gallons RNG produced).',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustments or restatements made to previously reported progress values. Required for transparency when historical data is revised due to methodology changes, data corrections, or acquisitions/divestitures.',
    `baseline_comparison_value` DECIMAL(18,2) COMMENT 'The baseline value against which progress is measured. Typically the performance value from the baseline year (e.g., 2020 emissions for a 2030 reduction target). Enables percentage reduction calculation.',
    `commentary` STRING COMMENT 'Narrative commentary explaining the progress results, including context for variances, operational factors affecting performance, corrective actions taken, and qualitative insights. Used in CDP, GRI, and TCFD narrative disclosures.',
    `contributing_initiative_ids` STRING COMMENT 'Comma-separated list of sustainability initiative IDs that contributed to this progress result. Enables attribution of performance to specific programs (e.g., CNG fleet conversion, LFG-to-RNG project, MRF efficiency upgrade).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this target progress record was first created in the system. Audit trail field.',
    `cumulative_progress_to_date` DECIMAL(18,2) COMMENT 'Cumulative progress value from target baseline date through the end of this reporting period. Provides year-over-year trend visibility for multi-year targets (e.g., 2030 carbon neutrality goal).',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score from 0.00 to 1.00 representing completeness, accuracy, and timeliness of the source data. Scores below 0.70 may require data quality improvement actions. Used in assurance readiness assessment.',
    `data_source_system` STRING COMMENT 'System of record from which the actual performance data was sourced. Critical for data lineage and audit trail. Common sources include Enviance EHS for emissions data, SAP CO for cost data, Geotab for fleet fuel consumption, and AMCS for waste diversion metrics. [ENUM-REF-CANDIDATE: enviance_ehs|sap_co|geotab_fleet|amcs_platform|manual_entry|third_party_audit|landfill_gas_monitoring|mrf_sortation_system — 8 candidates stripped; promote to reference product]',
    `emission_category` STRING COMMENT 'EPA emission category classification for GHG targets. Aligns with 40 CFR Part 98 subpart categories. Not applicable for non-emissions targets. [ENUM-REF-CANDIDATE: stationary_combustion|mobile_combustion|fugitive_emissions|purchased_electricity|waste_disposal|transportation|not_applicable — 7 candidates stripped; promote to reference product]',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter to which this reporting period belongs. Enables quarterly ESG reporting and board-level KPI tracking.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this reporting period belongs. Enables fiscal year roll-up and year-over-year trend analysis. Format: YYYY (e.g., 2024).',
    `ghg_scope` STRING COMMENT 'GHG Protocol scope classification for emissions-related targets. Scope 1 = direct emissions from owned sources, Scope 2 = indirect emissions from purchased energy, Scope 3 = value chain emissions. Not applicable for non-emissions targets.. Valid values are `scope_1|scope_2|scope_3|scope_1_2|scope_1_2_3|not_applicable`',
    `is_restated` BOOLEAN COMMENT 'Flag indicating whether this progress record represents a restatement of previously reported data. True if restated, False if original reporting.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this target progress record. Audit trail field for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this target progress record was last modified. Audit trail field.',
    `previous_reported_value` DECIMAL(18,2) COMMENT 'The previously reported actual value before restatement. Populated only when is_restated is True. Enables transparency in year-over-year comparisons when historical data is revised.',
    `publication_date` DATE COMMENT 'Date on which this progress data was published in an external report. Null if not yet published. Used for version control and public disclosure tracking.',
    `published_in_report` BOOLEAN COMMENT 'Flag indicating whether this progress data has been published in an external sustainability report (annual ESG report, CDP submission, TCFD disclosure). True if published, False if internal only.',
    `reporting_framework` STRING COMMENT 'Primary sustainability reporting framework for which this progress data is prepared. Multiple frameworks may use the same underlying data with different presentation requirements. [ENUM-REF-CANDIDATE: gri|tcfd|cdp|sasb|epa_ghg|internal|integrated — 7 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period for which progress is measured. Defines the boundary for performance calculation.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period for which progress is measured. Typically aligns with fiscal quarters or calendar months for GRI, TCFD, and CDP reporting cycles.',
    `reporting_scope` STRING COMMENT 'Organizational scope for which this progress is reported. Enables roll-up from facility-level to enterprise-level reporting for consolidated ESG disclosures. [ENUM-REF-CANDIDATE: enterprise_wide|business_unit|facility|fleet|landfill|mrf|region|division — 8 candidates stripped; promote to reference product]',
    `target_achievement_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target achieved during this reporting period, calculated as (actual_value / target_value) * 100. Values over 100% indicate target exceeded. Critical KPI for ESG dashboards and executive reporting.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the actual performance value. Common units include metric tons CO2e for GHG emissions, tons for waste diversion, gallons for RNG production, and percentage for diversion rates. [ENUM-REF-CANDIDATE: metric_tons_co2e|tons|gallons|kwh|mwh|percentage|count|cubic_yards|therms|gge|dge — 11 candidates stripped; promote to reference product]',
    `variance_from_trajectory` DECIMAL(18,2) COMMENT 'Variance between actual performance and the planned trajectory for this period. Positive values indicate ahead of plan, negative values indicate behind plan. Enables early identification of off-track targets requiring corrective action.',
    `verification_date` DATE COMMENT 'Date on which the data verification was completed. Required for audit trail and assurance documentation.',
    `verification_status` STRING COMMENT 'Status of data verification and assurance. Third-party verification is required for EPA GHG reporting and recommended for CDP and TCFD disclosures. Internally verified data is acceptable for preliminary reporting.. Valid values are `unverified|internally_verified|third_party_verified|audited|pending_verification`',
    `verifier_name` STRING COMMENT 'Name of the individual or organization that verified the data. Required for third-party verified and audited records. Typically an accredited environmental auditor or internal EHS manager.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this target progress record. Audit trail field for accountability.',
    CONSTRAINT pk_target_progress PRIMARY KEY(`target_progress_id`)
) COMMENT 'Transactional record tracking periodic progress against each sustainability target. Captures reporting period, actual performance value, unit of measure, percentage of target achieved, variance from trajectory, data source system, verification status, and narrative commentary. Enables year-over-year trend analysis and supports CDP, GRI, and TCFD annual disclosure preparation. Links to ghg_emission, diversion_record, and rng_production as source data.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` (
    `esg_disclosure_id` BIGINT COMMENT 'Unique identifier for the ESG disclosure submission record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Major customer relationships (Fortune 500 partnerships, municipal contracts) are material topics in ESG disclosures. Required for stakeholder materiality assessment, CDP reporting, and investor relati',
    `ghg_inventory_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_inventory. Business justification: ESG disclosures reference specific GHG inventory compilations as authoritative source data. One disclosure references one inventory period (1:N). New FK needed to link disclosure to underlying invento',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ESG disclosure preparation for CDP, GRI, TCFD requires designated staff for data compilation, assurance coordination, and submission. Replaces denormalized disclosure_preparer_name with proper FK.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: ESG disclosures are prepared for specific reporting periods. One disclosure for one reporting period (1:N). New FK needed. Removes redundant date columns that can be retrieved from report_period via J',
    `approval_date` DATE COMMENT 'The date on which this ESG disclosure was formally approved by the designated approver for external submission.',
    `assurance_completion_date` DATE COMMENT 'The date on which the external assurance engagement was completed and the assurance opinion was issued.',
    `assurance_level` STRING COMMENT 'The level of external assurance obtained for this ESG disclosure. None = no third-party assurance, Limited = limited assurance engagement, Reasonable = reasonable assurance engagement (highest level).. Valid values are `none|limited|reasonable`',
    `assurance_provider` STRING COMMENT 'The name of the third-party assurance provider or auditor who verified the ESG disclosure data and statements.',
    `board_diversity_percentage` DECIMAL(18,2) COMMENT 'Percentage of board members representing diverse backgrounds (gender, ethnicity, age, experience). Key governance metric for ESG disclosure.',
    `carbon_offset_credits_purchased_metric_tons` DECIMAL(18,2) COMMENT 'Total volume of carbon offset credits purchased during the reporting period to compensate for residual GHG emissions, measured in metric tons of CO2 equivalent.',
    `community_investment_amount_usd` DECIMAL(18,2) COMMENT 'Total monetary value of community investments, charitable contributions, and social programs funded during the reporting period, measured in US dollars. Key social performance metric.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ESG disclosure record was first created in the system.',
    `disclosure_approver_name` STRING COMMENT 'Full name of the executive or officer who formally approved this ESG disclosure for submission.',
    `disclosure_document_reference` STRING COMMENT 'Reference identifier or URI to the formal ESG disclosure document, report, or filing submitted to the external framework body.',
    `disclosure_number` STRING COMMENT 'Externally-known unique reference number assigned to this ESG disclosure submission for tracking and audit purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `employee_safety_incident_rate` DECIMAL(18,2) COMMENT 'Total Recordable Incident Rate (TRIR) for employee safety during the reporting period, calculated per OSHA standards as incidents per 100 full-time employees. Key social performance metric.',
    `esg_score` DECIMAL(18,2) COMMENT 'Composite ESG performance score assigned by external rating agencies or internal assessment frameworks. Typically scaled 0-100, with higher scores indicating stronger ESG performance.',
    `framework_type` STRING COMMENT 'The ESG disclosure framework or standard to which this submission conforms. GRI = Global Reporting Initiative, TCFD = Task Force on Climate-related Financial Disclosures, CDP = Carbon Disclosure Project, SASB = Sustainability Accounting Standards Board, SEC_CLIMATE = SEC Climate Rule, ISSB = International Sustainability Standards Board.. Valid values are `GRI|TCFD|CDP|SASB|SEC_CLIMATE|ISSB`',
    `hazardous_waste_managed_metric_tons` DECIMAL(18,2) COMMENT 'Total volume of hazardous waste managed during the reporting period, measured in metric tons. Includes RCRA-regulated hazardous waste handled, treated, stored, and disposed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ESG disclosure record was last modified or updated in the system.',
    `lfg_to_rng_conversion_volume_mmbtu` DECIMAL(18,2) COMMENT 'Total volume of landfill gas converted to renewable natural gas during the reporting period, measured in million British thermal units. Represents circular economy and waste-to-energy performance.',
    `material_topics_covered` STRING COMMENT 'Comma-separated list or summary of the material ESG topics addressed in this disclosure (e.g., GHG emissions, waste diversion, water usage, employee safety, community engagement).',
    `notes` STRING COMMENT 'Free-text field for additional notes, commentary, or context related to this ESG disclosure submission that do not fit in structured fields.',
    `publication_url` STRING COMMENT 'The public URL where this ESG disclosure report or filing is published and accessible to stakeholders.',
    `renewable_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total renewable energy consumed during the reporting period, measured in megawatt hours. Includes energy from CNG, RNG, solar, wind, and other renewable sources.',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption derived from renewable sources. Key sustainability KPI for tracking progress toward renewable energy adoption goals.',
    `restatement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this disclosure includes restated data from prior reporting periods due to corrections, methodology changes, or improved data quality.',
    `restatement_reason` STRING COMMENT 'Detailed explanation of the reason for any data restatements included in this disclosure, including methodology changes, data corrections, or scope adjustments.',
    `scope_1_emissions_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total Scope 1 direct GHG emissions reported in this disclosure, measured in metric tons of CO2 equivalent. Includes emissions from owned or controlled sources such as fleet vehicles and landfill gas.',
    `scope_2_emissions_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total Scope 2 indirect GHG emissions from purchased electricity, steam, heating, and cooling reported in this disclosure, measured in metric tons of CO2 equivalent.',
    `scope_3_emissions_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total Scope 3 indirect GHG emissions from value chain activities reported in this disclosure, measured in metric tons of CO2 equivalent. Includes upstream and downstream emissions outside direct control.',
    `submission_date` DATE COMMENT 'The date on which this ESG disclosure was formally submitted to the external framework body or regulatory authority.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the ESG disclosure submission. Tracks progression from draft through final publication or rejection.. Valid values are `draft|submitted|under_review|accepted|published|rejected`',
    `total_waste_diverted_metric_tons` DECIMAL(18,2) COMMENT 'Total volume of waste diverted from landfill disposal through recycling, composting, waste-to-energy, and other recovery methods during the reporting period, measured in metric tons.',
    `waste_diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of total waste diverted from landfill disposal, calculated as diverted waste divided by total waste managed. Key sustainability KPI.',
    `water_consumption_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume of water consumed by operations during the reporting period, measured in cubic meters. Includes water used in facilities, fleet maintenance, and operational processes.',
    CONSTRAINT pk_esg_disclosure PRIMARY KEY(`esg_disclosure_id`)
) COMMENT 'Master record of formal ESG disclosure submissions made by Waste Management to external frameworks and regulatory bodies. Captures disclosure framework (GRI, TCFD, CDP, SASB, SEC Climate Rule), reporting year, submission date, submission status, assurance level (limited, reasonable), assurance provider, disclosure document reference, and material topics covered. Serves as the authoritative registry of all external sustainability reporting commitments and submissions.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`emission_factor` (
    `emission_factor_id` BIGINT COMMENT 'Unique identifier for the emission factor record. Primary key.',
    `superseded_by_factor_emission_factor_id` BIGINT COMMENT 'Reference to the emission_factor_id that replaces this factor when status is superseded. Null if not superseded. Maintains version lineage for audit and compliance.',
    `approval_date` DATE COMMENT 'Date on which the emission factor was approved for use. Null if not yet approved. Supports audit trail and version control.',
    `approval_status` STRING COMMENT 'Internal approval status for use in corporate GHG accounting: approved (validated and authorized for use), pending_approval (under review by sustainability or compliance team), rejected (not approved for use).. Valid values are `approved|pending_approval|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this emission factor for use in corporate GHG accounting. Null if not yet approved. Supports governance and accountability.',
    `biogenic_flag` BOOLEAN COMMENT 'Indicates whether the emission factor accounts for biogenic carbon (carbon from recently living biomass such as RNG, biofuels, or organic waste). True if biogenic; False if fossil-based. Biogenic emissions are often reported separately under GHG protocols.',
    `calculation_methodology` STRING COMMENT 'Description of the methodology or formula used to derive the emission factor (e.g., mass balance, direct measurement, engineering estimation, IPCC Tier 2 approach). Supports transparency and reproducibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission factor record was first created in the system. Supports audit trail and data lineage.',
    `data_quality_tier` STRING COMMENT 'IPCC data quality tier classification: Tier 1 (default IPCC factors), Tier 2 (country-specific factors), Tier 3 (facility-specific measurements), Tier 4 (continuous monitoring). Higher tiers indicate greater accuracy and specificity.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `effective_date` DATE COMMENT 'Date from which this emission factor becomes valid and should be used in CO2e calculations. Supports temporal accuracy in emissions reporting.',
    `emission_factor_status` STRING COMMENT 'Current lifecycle status of the emission factor: active (currently in use), superseded (replaced by newer version), deprecated (no longer recommended), draft (pending approval), or under_review (being validated).. Valid values are `active|superseded|deprecated|draft|under_review`',
    `emission_scope` STRING COMMENT 'GHG Protocol emission scope classification: Scope 1 (direct emissions from owned/controlled sources), Scope 2 (indirect emissions from purchased energy), or Scope 3 (other indirect emissions in value chain).. Valid values are `scope_1|scope_2|scope_3`',
    `expiry_date` DATE COMMENT 'Date after which this emission factor is no longer valid and should not be used in new calculations. Null if the factor remains current indefinitely. Supports version control and regulatory compliance.',
    `factor_code` STRING COMMENT 'Standardized code or identifier for the emission factor used for system integration and reporting automation.',
    `factor_name` STRING COMMENT 'Descriptive name of the emission factor (e.g., Diesel Combustion - Mobile Sources, Natural Gas Stationary Combustion, Landfill Gas Fugitive Emissions).',
    `factor_source` STRING COMMENT 'Authoritative source or organization that published the emission factor (e.g., EPA, IPCC, CARB, EIA, DEFRA, GHG Protocol). Ensures traceability and regulatory compliance.',
    `factor_source_document` STRING COMMENT 'Specific document, publication, or database from which the emission factor was obtained (e.g., EPA Emission Factors for Greenhouse Gas Inventories 2023, IPCC 2006 Guidelines Volume 2 Chapter 3). Supports audit trail and version control.',
    `factor_source_url` STRING COMMENT 'Web URL or digital reference to the source document for verification and audit purposes. Null if no digital reference is available.',
    `factor_unit` STRING COMMENT 'Unit of measure for the emission factor (e.g., kg CO2e per gallon, kg CO2e per kWh, kg CO2e per ton, kg CO2e per mile, kg CO2e per MMBtu). Defines the denominator for emission calculations.',
    `factor_value` DECIMAL(18,2) COMMENT 'Numeric value of the emission factor used in CO2e calculations. Precision to six decimal places to support accurate scientific calculations.',
    `fuel_type` STRING COMMENT 'Specific fuel type or activity associated with the emission factor (e.g., Diesel, Gasoline, CNG, RNG, Natural Gas, Propane, Electricity, Waste-in-Place). Null if not applicable to the source category.',
    `geographic_scope` STRING COMMENT 'Geographic region or jurisdiction for which the emission factor is applicable (e.g., USA, California, European Union, Global). Some factors vary by region due to grid mix, fuel composition, or regulatory requirements.',
    `ghg_type` STRING COMMENT 'Type of greenhouse gas covered by this emission factor: Carbon Dioxide (CO2), Methane (CH4), Nitrous Oxide (N2O), Hydrofluorocarbons (HFC), Perfluorocarbons (PFC), or Sulfur Hexafluoride (SF6).. Valid values are `CO2|CH4|N2O|HFC|PFC|SF6`',
    `gwp_basis` STRING COMMENT 'IPCC Assessment Report used for Global Warming Potential values: Second Assessment Report (SAR), Fourth Assessment Report (AR4), Fifth Assessment Report (AR5), or Sixth Assessment Report (AR6). Determines the conversion factors for non-CO2 gases to CO2 equivalents.. Valid values are `AR4|AR5|AR6|SAR`',
    `gwp_timeframe_years` STRING COMMENT 'Time horizon in years over which the Global Warming Potential is calculated (typically 20, 100, or 500 years). Most regulatory frameworks use 100-year GWP.',
    `industry_sector` STRING COMMENT 'Industry sector or business activity for which the emission factor is most applicable (e.g., Waste Management, Transportation, Energy, Manufacturing). Null if the factor is universally applicable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emission factor record was last modified. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional notes, context, or special instructions for applying this emission factor. May include assumptions, limitations, or guidance for specific use cases.',
    `regulatory_framework` STRING COMMENT 'Regulatory or voluntary reporting framework for which this emission factor is approved or recommended (e.g., EPA GHGRP, CARB MRR, EU ETS, GRI, TCFD, CDP, SBTi). Supports multi-framework compliance.',
    `source_category` STRING COMMENT 'Category of emission source: mobile combustion (fleet vehicles), stationary combustion (boilers, generators), fugitive emissions (leaks, venting), process emissions (chemical reactions), waste disposal (landfill decomposition), or purchased electricity (grid consumption).. Valid values are `mobile_combustion|stationary_combustion|fugitive|process|waste_disposal|purchased_electricity`',
    `uncertainty_percentage` DECIMAL(18,2) COMMENT 'Estimated uncertainty or margin of error associated with the emission factor, expressed as a percentage. Used for sensitivity analysis and data quality assessment in GHG inventories.',
    CONSTRAINT pk_emission_factor PRIMARY KEY(`emission_factor_id`)
) COMMENT 'Reference table of GHG emission factors used in CO2e calculations across all emission sources. Captures factor name, GHG type (CO2, CH4, N2O, HFCs), source category (mobile combustion, stationary combustion, fugitive, process), fuel or activity type, emission factor value, unit (kg CO2e per unit), global warming potential (GWP) basis (AR4, AR5, AR6), factor source (EPA, IPCC, CARB), effective date, and expiry date. Ensures consistent and auditable emission calculations across all reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` (
    `circular_economy_program_id` BIGINT COMMENT 'Unique identifier for the circular economy program record. Primary key.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Circular economy programs can be part of broader carbon reduction initiatives. One program supports one initiative (1:N). New FK needed to link programs to parent initiatives.',
    `facility_id` BIGINT COMMENT 'Reference to the primary Waste Management facility (MRF, composting facility, TSDF, or transfer station) that operates or coordinates this circular economy program.',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who created this program record. Used for audit trail and accountability.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Circular economy programs (organics composting, advanced recycling, reuse initiatives) require tailored safety programs for new service lines. Real business process: safety protocol development for em',
    `srf_production_line_id` BIGINT COMMENT 'Foreign key linking to energy.srf_production_line. Business justification: Circular economy programs include SRF production as key waste diversion pathway. Links sustainability programs to operational production assets for tracking diversion targets, GHG avoidance, and circu',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Circular economy programs involve vendor partnerships (recycling processors, material recovery facilities, technology providers). While partner_organization_name exists (denormalized), formal vendor l',
    `annual_diversion_target_tons` DECIMAL(18,2) COMMENT 'The target volume of material to be diverted from landfill annually through this program, measured in tons. Key performance indicator for program success and GRI 306 reporting.',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'The estimated or actual annual operating cost for the program in US dollars, including labor, equipment, facility, and administrative costs. Used for ROI and EBITDA analysis.',
    `annual_revenue_target_usd` DECIMAL(18,2) COMMENT 'The target annual revenue for the program in US dollars. Used for financial performance tracking and ROI analysis.',
    `certification_standards` STRING COMMENT 'Comma-separated list of third-party certifications or standards that the program adheres to (e.g., ISO 14001, Zero Waste Certified, Cradle to Cradle, LEED Material Credits). Supports marketing and customer contract requirements.',
    `circular_economy_principle_alignment` STRING COMMENT 'Comma-separated list of Ellen MacArthur Foundation circular economy principles that this program supports (e.g., design out waste and pollution, keep products and materials in use, regenerate natural systems). Used for ESG narrative reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this program record was first created in the system. Used for audit trail and data lineage.',
    `cumulative_diversion_actual_tons` DECIMAL(18,2) COMMENT 'The total volume of material actually diverted from landfill since program inception, measured in tons. Updated periodically based on operational data.',
    `data_source_system` STRING COMMENT 'The primary operational system of record that provides data for this program (e.g., Enviance EHS, SAP EHS, AMCS Platform, Waste Logics). Used for data lineage and quality assessment.',
    `esg_reporting_framework_alignment` STRING COMMENT 'Comma-separated list of ESG reporting frameworks that this program supports (e.g., GRI 306, TCFD, CDP Climate, SASB Waste Management Standard). Ensures data collection meets disclosure requirements.',
    `geographic_scope` STRING COMMENT 'Description of the geographic coverage area for the program (e.g., Northeast Region, California Statewide, Metro Chicago Area, National). Supports regional sustainability reporting.',
    `ghg_emissions_avoided_co2e_tons_annual` DECIMAL(18,2) COMMENT 'Estimated annual greenhouse gas emissions avoided through material diversion and circular economy activities, measured in metric tons of CO2 equivalent. Supports EPA GHG reporting and Clean Air Act compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this program record was most recently updated. Used for audit trail and data freshness assessment.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance review of the program against its targets and KPIs. Used for governance and continuous improvement tracking.',
    `marketing_description` STRING COMMENT 'Customer-facing description of the program used in marketing materials, customer portals, and sustainability reports. Communicates program value proposition and participation instructions.',
    `notes` STRING COMMENT 'Free-text field for additional context, special considerations, or operational notes about the program that do not fit structured fields.',
    `participating_customer_segments` STRING COMMENT 'Comma-separated list of customer segments eligible to participate in the program (e.g., residential, commercial, industrial, municipal, institutional). Defines program scope and market reach.',
    `participation_eligibility_criteria` STRING COMMENT 'Detailed description of the requirements for customers or partners to participate in the program (e.g., minimum volume commitments, material quality standards, geographic location, contract terms).',
    `partnership_model` STRING COMMENT 'The business and operational structure of the program indicating ownership and partnership arrangements. Critical for financial and legal reporting.. Valid values are `wholly_owned|joint_venture|third_party_contract|municipal_partnership|oem_stewardship`',
    `program_code` STRING COMMENT 'Unique alphanumeric business identifier for the program used in operational systems and reporting (e.g., CE-EWASTE-001, CE-ORG-COMP-02).. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_end_date` DATE COMMENT 'The planned or actual date when the program concluded or is scheduled to conclude. Null for ongoing programs.',
    `program_name` STRING COMMENT 'The official business name of the circular economy program (e.g., Electronics Take-Back Initiative, Organics Composting Partnership, C&D Material Reuse Program).',
    `program_start_date` DATE COMMENT 'The date when the circular economy program officially commenced operations. Used for program maturity analysis and performance trending.',
    `program_status` STRING COMMENT 'Current lifecycle status of the circular economy program indicating operational state.. Valid values are `planning|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the circular economy program based on its operational model and material focus. Aligns with Ellen MacArthur Foundation circular economy strategies.. Valid values are `material_takeback|industrial_symbiosis|organics_composting|ewaste_recycling|construction_material_reuse|product_stewardship`',
    `program_website_url` STRING COMMENT 'The public-facing website URL for the program where customers and stakeholders can learn more and access participation information.. Valid values are `^https?://.*$`',
    `record_status` STRING COMMENT 'Indicates whether this program record is currently active in the system, inactive but retained for historical reference, or archived for long-term storage.. Valid values are `active|inactive|archived`',
    `regulatory_compliance_requirements` STRING COMMENT 'Comma-separated list of regulatory requirements that the program must comply with (e.g., RCRA Subtitle D, State EPR Law, Local Organics Diversion Mandate). Ensures program design meets legal obligations.',
    `revenue_model` STRING COMMENT 'The primary revenue generation mechanism for the program. Used for financial planning and program sustainability assessment.. Valid values are `commodity_sales|tipping_fees|service_fees|grant_funded|cost_recovery|hybrid`',
    `target_material_streams` STRING COMMENT 'Comma-separated list of material types targeted by this program (e.g., electronics, batteries, appliances or food waste, yard waste, biosolids or concrete, asphalt, wood, metal). Supports GRI 306 waste disclosure requirements.',
    CONSTRAINT pk_circular_economy_program PRIMARY KEY(`circular_economy_program_id`)
) COMMENT 'Master record of circular economy programs operated by Waste Management including material take-back programs, industrial symbiosis partnerships, organics composting programs, e-waste recycling programs, and construction material reuse initiatives. Captures program name, program type, target material streams, participating customer segments, geographic scope, diversion volume targets, and alignment to Ellen MacArthur Foundation circular economy principles and GRI 306 waste disclosures.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` (
    `sustainability_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the program enrollment record. Primary key for the program enrollment entity.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.circular_economy_program. Business justification: Enrollments are for specific circular economy programs. One enrollment is for one program (1:N). New FK needed. Removes redundant program_name and program_type strings that can be retrieved from circu',
    `contract_id` BIGINT COMMENT 'Reference to the master contract under which this program enrollment is established. Links to commercial or municipal service agreements.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer enrolled in the sustainability program. Links to residential, commercial, or municipal customer accounts.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created the enrollment record. Supports audit trail and accountability requirements.',
    `facility_id` BIGINT COMMENT 'Reference to the facility enrolled in the sustainability program. Applicable when the enrolled entity is a Materials Recovery Facility (MRF), landfill, or Waste-to-Energy (WTE) facility.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Customer facility incidents during circular economy program participation may affect enrollment status or service delivery. Real business process: incident tracking at enrolled customer sites for liab',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified the enrollment record. Supports audit trail and change management.',
    `primary_sustainability_employee_id` BIGINT COMMENT 'Reference to the employee serving as the primary account manager or program coordinator for this enrollment. Responsible for customer relationship and program performance.',
    `sla_term_id` BIGINT COMMENT 'Reference to the Service Level Agreement (SLA) governing the program enrollment terms, performance commitments, and service standards.',
    `certification_standard` STRING COMMENT 'External certification or verification standard applicable to this program enrollment. Examples include ISO 14001 Environmental Management Systems, LEED certification, Zero Waste certification, and Carbon Neutral certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score for this enrollment record, ranging from 0 to 100. Based on completeness, accuracy, and timeliness of enrollment data.',
    `effective_end_date` DATE COMMENT 'Date when the program participation ends or is scheduled to end. Null for open-ended enrollments without a predetermined end date.',
    `effective_start_date` DATE COMMENT 'Date when the program benefits and obligations become effective for the enrolled entity. May differ from enrollment date due to processing or setup requirements.',
    `enrolled_entity_type` STRING COMMENT 'Classification of the entity enrolled in the sustainability program. Distinguishes between customer types and facility types for program participation tracking.. Valid values are `residential_customer|commercial_account|municipal_client|mrf_facility|landfill_facility|wte_facility`',
    `enrollment_channel` STRING COMMENT 'Channel through which the entity enrolled in the sustainability program. Supports marketing effectiveness analysis and customer acquisition tracking.. Valid values are `customer_portal|sales_representative|call_center|municipal_partnership|facility_direct|marketing_campaign`',
    `enrollment_date` DATE COMMENT 'Date when the entity was officially enrolled in the sustainability program. Represents the start of program participation for tracking and reporting purposes.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment number assigned to the program enrollment for external reference and tracking.. Valid values are `^ENR-[0-9]{8}$`',
    `enrollment_source_system` STRING COMMENT 'Source system from which the enrollment record originated. Supports data lineage tracking and system integration management.. Valid values are `salesforce_crm|waste_logics|amcs_platform|enviance_ehs|manual_entry`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the program enrollment. Tracks the enrollment from initial application through active participation to program exit.. Valid values are `pending|active|suspended|completed|cancelled`',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this enrollment should be included in corporate Environmental, Social, and Governance (ESG) reporting and sustainability disclosures. Supports Task Force on Climate-related Financial Disclosures (TCFD), Carbon Disclosure Project (CDP), and Global Reporting Initiative (GRI) reporting requirements.',
    `estimated_annual_co2e_reduction_tons` DECIMAL(18,2) COMMENT 'Projected annual reduction in Greenhouse Gas (GHG) emissions measured in Carbon Dioxide Equivalent (CO2e) metric tons resulting from this program enrollment. Supports Clean Air Act compliance and voluntary carbon reporting frameworks.',
    `estimated_annual_diversion_volume_tons` DECIMAL(18,2) COMMENT 'Projected annual volume of waste diverted from landfill through this program enrollment, measured in tons. Used for program planning and Environmental, Social, and Governance (ESG) impact forecasting.',
    `exit_reason` STRING COMMENT 'Reason for the entity exiting the sustainability program. Supports analysis of program retention and customer satisfaction.. Valid values are `program_completion|voluntary_withdrawal|non_compliance|service_termination|facility_closure|contract_expiration`',
    `incentive_type` STRING COMMENT 'Type of incentive offered to the enrolled entity for program participation. Supports program economics and customer engagement strategies.. Valid values are `rate_discount|rebate|carbon_credit|recognition|none`',
    `incentive_value_usd` DECIMAL(18,2) COMMENT 'Monetary value of the incentive provided to the enrolled entity, expressed in United States Dollars (USD). Used for program cost tracking and Return on Investment (ROI) analysis.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the enrollment record is currently active and should be included in operational reporting and program management. Supports soft-delete and historical record retention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was last updated. Supports change tracking and data currency monitoring.',
    `material_streams_included` STRING COMMENT 'Comma-separated list of waste material streams included in the program enrollment. Examples include paper, cardboard, plastics, metals, glass, organics, Municipal Solid Waste (MSW), Construction and Demolition (C&D) waste, and hazardous materials.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the program enrollment. Supports operational coordination and customer service.',
    `participation_tier` STRING COMMENT 'Tiered classification of program participation level based on volume, performance, or commitment. Supports differentiated service levels and recognition programs.. Valid values are `bronze|silver|gold|platinum`',
    `program_exit_date` DATE COMMENT 'Actual date when the entity exited or withdrew from the sustainability program. Populated when enrollment status transitions to completed or cancelled.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this enrollment must be included in mandatory regulatory reporting to the U.S. Environmental Protection Agency (EPA), state environmental agencies, or local enforcement authorities.',
    `responsible_department` STRING COMMENT 'Business department or division responsible for managing this program enrollment. Examples include Sustainability Operations, Commercial Services, Municipal Services, and Environmental Compliance.',
    `verification_date` DATE COMMENT 'Date when the enrollment was verified and approved for program participation.',
    `verification_status` STRING COMMENT 'Status of enrollment verification and validation process. Ensures program eligibility and data accuracy before activation.. Valid values are `pending|verified|rejected|requires_review`',
    CONSTRAINT pk_sustainability_program_enrollment PRIMARY KEY(`sustainability_program_enrollment_id`)
) COMMENT 'Transactional record of customer or facility enrollments in circular economy and sustainability programs. Captures enrollment date, enrolled entity type (residential customer, commercial account, municipal client, facility), program enrolled, enrollment status, material streams included, estimated annual diversion volume, and program exit date. Enables measurement of program participation rates and customer-level sustainability impact reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` (
    `fleet_fuel_consumption_id` BIGINT COMMENT 'Unique identifier for the fleet fuel consumption record. Primary key for this transactional record.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver operating the vehicle during the consumption period. Supports driver behavior analysis and fuel efficiency training programs.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or station where the vehicle was fueled. Links to facility master for geographic emissions allocation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fleet fuel transactions require linking to fuel card holders for cost allocation, carbon accounting, and fraud prevention. Distinct from driver_id which tracks route assignment.',
    `fuel_purchase_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_purchase. Business justification: Direct linkage between fuel consumption records and procurement transactions enables reconciliation, variance analysis, fraud detection, and cost control. Finance reconciles fuel consumption against f',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Vehicle incidents affect fuel consumption records (accidents, breakdowns, fires). Real business process: incident investigation includes fuel system analysis, emissions impact assessment for carbon ac',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Fleet fuel is a procured material. Linking fuel_type to material master enables procurement optimization, inventory management, standardized material-level emission factors, and spend analysis. Procur',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: Fleet fuel consumption is tracked within reporting periods. One consumption record belongs to one reporting period (1:N). New FK needed. Removes redundant date and string columns.',
    `route_id` BIGINT COMMENT 'Identifier of the collection or hauling route the vehicle was servicing during the consumption period. Links fuel consumption to operational activity.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the fleet vehicle that consumed the fuel. Links to the vehicle asset master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Fuel purchases are made from vendors (fuel suppliers, fueling stations). Linking consumption records to vendor enables vendor performance analysis, contract compliance verification, spend management, ',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Carbon intensity of the fuel in grams of CO2 equivalent per megajoule (gCO2e/MJ). Used for Low Carbon Fuel Standard (LCFS) compliance and renewable fuel pathway verification.',
    `co2e_emissions_metric_tons` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions in metric tons of CO2 equivalent calculated from fuel consumption using EPA emission factors. Primary metric for Scope 1 mobile combustion emissions inventory.',
    `consumption_record_number` STRING COMMENT 'Business identifier for the fuel consumption transaction, typically generated by the telematics system or fuel management system.',
    `consumption_timestamp` TIMESTAMP COMMENT 'Precise date and time when the fuel consumption event occurred or was recorded by the telematics system. Principal business event timestamp for this transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel consumption record was first created in the system. Audit trail for data lineage.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the consumption record. Used to filter data for regulatory reporting and identify records requiring validation.. Valid values are `verified|estimated|incomplete|anomaly|pending_review`',
    `data_source_system` STRING COMMENT 'System or method from which the fuel consumption data was captured. Critical for data quality assessment and audit trail.. Valid values are `geotab|amcs|manual_entry|fuel_card|other`',
    `distance_traveled_miles` DECIMAL(18,2) COMMENT 'Total distance traveled by the vehicle during the consumption period in miles. Captured from GPS telematics for fuel efficiency calculations.',
    `emission_factor_kg_co2e_per_unit` DECIMAL(18,2) COMMENT 'Emission factor applied to calculate CO2e emissions, expressed in kilograms of CO2 equivalent per fuel unit (gallon, GGE, kWh, or MMBtu). Source-specific factor based on fuel type.',
    `energy_quantity_kwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed in kilowatt-hours. Applicable to electric and hybrid electric vehicles.',
    `energy_quantity_mmbtu` DECIMAL(18,2) COMMENT 'Total energy content consumed in Million British Thermal Units. Normalized energy measure across all fuel types for consistent emissions calculations.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this consumption record is included in external ESG reporting frameworks (GRI, TCFD, CDP). True if included in ESG disclosures.',
    `fuel_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of fuel consumed in US dollars. Used for fleet operating cost analysis and sustainability ROI calculations.',
    `fuel_efficiency_mpg` DECIMAL(18,2) COMMENT 'Fuel efficiency in miles per gallon for liquid fuels. Calculated as distance traveled divided by fuel quantity in gallons.',
    `fuel_efficiency_mpge` DECIMAL(18,2) COMMENT 'Fuel efficiency in miles per gallon equivalent for gaseous and electric fuels. Enables efficiency comparison across fuel types.',
    `fuel_quantity_gallons` DECIMAL(18,2) COMMENT 'Volume of liquid fuel consumed in gallons. Applicable to diesel, gasoline, and biodiesel. Null for gaseous and electric fuels.',
    `fuel_quantity_gge` DECIMAL(18,2) COMMENT 'Volume of gaseous fuel consumed in Gasoline Gallon Equivalent units. Used for CNG and RNG to normalize energy content comparisons.',
    `fueling_location_city` STRING COMMENT 'City where the fueling event occurred. Used for geographic emissions reporting and regional sustainability analysis.',
    `fueling_location_country` STRING COMMENT 'Country where the fueling event occurred, using ISO 3166-1 alpha-3 country codes. Supports multinational fleet emissions reporting.. Valid values are `USA|CAN|MEX`',
    `fueling_location_state` STRING COMMENT 'State or province where the fueling event occurred. Required for state-level GHG reporting and Clean Air Act compliance.',
    `ghg_inventory_category` STRING COMMENT 'GHG Protocol inventory category to which this consumption record is allocated. Primarily Scope 1 mobile combustion for direct vehicle fuel use.. Valid values are `scope_1_mobile_combustion|scope_2_purchased_electricity|scope_3_upstream_fuel`',
    `idle_time_hours` DECIMAL(18,2) COMMENT 'Total hours the vehicle engine was idling during the consumption period. Key metric for fuel waste reduction and emissions optimization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel consumption record was last updated. Supports change tracking and data quality audits.',
    `lcfs_credits_generated` DECIMAL(18,2) COMMENT 'Number of LCFS credits generated from low-carbon fuel consumption. Applicable in California and other jurisdictions with carbon credit programs.',
    `notes` STRING COMMENT 'Free-text field for additional context, anomalies, or operational notes related to the fuel consumption record. Supports audit trail and data quality investigations.',
    `renewable_fuel_flag` BOOLEAN COMMENT 'Indicates whether the fuel consumed is renewable (RNG, biodiesel, renewable electricity). True for renewable fuels, false for fossil fuels. Critical for tracking renewable energy adoption KPIs.',
    `rin_credits_generated` DECIMAL(18,2) COMMENT 'Number of Renewable Identification Number credits generated from renewable fuel consumption. Applicable to RNG and biodiesel usage under EPA Renewable Fuel Standard.',
    `service_line` STRING COMMENT 'Business service line to which the vehicle is assigned. Enables emissions allocation by business unit for sustainability reporting. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|recycling|landfill|transfer_station|hauling|support — 7 candidates stripped; promote to reference product]',
    `vehicle_type` STRING COMMENT 'Classification of the vehicle consuming fuel (e.g., ASL, FEL, REL, haul truck, service vehicle). Enables fleet composition analysis for decarbonization planning.',
    CONSTRAINT pk_fleet_fuel_consumption PRIMARY KEY(`fleet_fuel_consumption_id`)
) COMMENT 'Transactional record of fuel consumption by fleet vehicle and reporting period, capturing diesel, CNG, RNG, and electric energy consumption. Records vehicle ID, fuel type, quantity consumed (gallons, GGE, kWh), distance traveled (miles), fuel efficiency (MPG or MPGe), associated CO2e emissions calculated, fueling location, and data source (Geotab telematics integration). Serves as the primary source for Scope 1 mobile combustion emissions in the GHG inventory and fleet decarbonization tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`tracked_site` (
    `tracked_site_id` BIGINT COMMENT 'Unique identifier for the tracked site within the sustainability program. Primary key. Role: MASTER_RESOURCE.',
    `facility_id` BIGINT COMMENT 'Unique facility identifier assigned by the U.S. Environmental Protection Agency for regulatory tracking and compliance reporting.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this tracked site record.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Each tracked sustainability site requires applicable safety programs based on operations (landfill, transfer station, MRF). Real business process: site-level safety program assignment for facilities w',
    `address_line_1` STRING COMMENT 'Primary street address of the site including street number and name. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number. Organizational contact data classified as confidential.',
    `annual_waste_capacity_tons` DECIMAL(18,2) COMMENT 'Maximum annual waste processing or disposal capacity of the site measured in tons per year. Applicable to landfills, MRFs, WTE plants, and transfer stations.',
    `business_unit` STRING COMMENT 'Name or code of the business unit or division that owns or operates this site within the corporate organizational structure.',
    `carbon_offset_project_flag` BOOLEAN COMMENT 'Indicates whether this site participates in carbon offset or carbon credit generation projects (e.g., landfill methane capture for carbon credits).',
    `certification_standards` STRING COMMENT 'Comma-separated list of environmental or sustainability certifications held by the site (e.g., ISO 14001, ISO 45001, LEED, TRUE Zero Waste).',
    `city` STRING COMMENT 'City or municipality where the site is located. Organizational contact data classified as confidential.',
    `cost_center_code` STRING COMMENT 'Financial cost center code assigned to this site for budgeting, expense tracking, and financial reporting purposes.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the site is located.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tracked site record was first created in the system.',
    `daily_waste_capacity_tpd` DECIMAL(18,2) COMMENT 'Maximum daily waste processing or disposal capacity measured in tons per day. TPD = Tons Per Day, a standard industry metric.',
    `data_quality_tier` STRING COMMENT 'Classification of the data quality and measurement methodology used for sustainability metrics at this site, aligned with GHG Protocol data quality tiers.. Valid values are `tier_1_measured|tier_2_calculated|tier_3_estimated|tier_4_proxy`',
    `emission_source_categories` STRING COMMENT 'Comma-separated list of applicable emission source categories present at this site (e.g., stationary_combustion, landfill_gas, mobile_combustion, fugitive_emissions, purchased_electricity). [ENUM-REF-CANDIDATE: stationary_combustion|landfill_gas|mobile_combustion|fugitive_emissions|purchased_electricity|wastewater_treatment|refrigerants — promote to reference product]',
    `esg_reporting_flag` BOOLEAN COMMENT 'Indicates whether this site is included in corporate ESG reporting frameworks such as GRI, TCFD, or CDP disclosures.',
    `ghg_scope_1_source_flag` BOOLEAN COMMENT 'Indicates whether this site contains direct GHG emission sources owned or controlled by the organization (e.g., landfill methane, on-site combustion).',
    `ghg_scope_2_source_flag` BOOLEAN COMMENT 'Indicates whether this site has indirect GHG emissions from purchased electricity, steam, heating, or cooling.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this tracked site record is currently active in the sustainability program (True = active, False = archived or inactive).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tracked site record was most recently updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the site in decimal degrees format, used for spatial analysis and mapping.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the site in decimal degrees format, used for spatial analysis and mapping.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special considerations, or contextual information about the site relevant to sustainability tracking.',
    `operational_status` STRING COMMENT 'Current operational state of the site indicating whether it is actively operating, temporarily suspended, permanently closed, or in another lifecycle stage.. Valid values are `active|inactive|under_construction|closed|decommissioned|suspended`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site location. Organizational contact data classified as confidential.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary site contact for sustainability program coordination and reporting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary site manager or sustainability coordinator responsible for this site.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary site contact. Organizational contact data classified as confidential.',
    `renewable_energy_generation_flag` BOOLEAN COMMENT 'Indicates whether this site generates renewable energy through LFG-to-RNG conversion, WTE operations, or other renewable energy systems.',
    `reporting_boundary_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this site is included within the organizational boundary for corporate sustainability and greenhouse gas emissions reporting (True = included, False = excluded).',
    `site_activation_date` DATE COMMENT 'Date when the site was first activated or commissioned for operations.',
    `site_closure_date` DATE COMMENT 'Date when the site was permanently closed or decommissioned. Null if the site is still active.',
    `site_code` STRING COMMENT 'Internal business identifier or code assigned to the site for operational tracking and reporting purposes.',
    `site_name` STRING COMMENT 'Official business name of the facility or site tracked in the sustainability program (e.g., Apex Regional Landfill, Metro MRF East).',
    `site_type` STRING COMMENT 'Classification of the site based on its primary operational function. MRF = Materials Recovery Facility, WTE = Waste-to-Energy, LFG = Landfill Gas, RNG = Renewable Natural Gas, TSDF = Treatment Storage and Disposal Facility. [ENUM-REF-CANDIDATE: landfill|mrf|wte_plant|transfer_station|lfg_to_rng_facility|fleet_maintenance_yard|composting_facility|hazmat_tsdf|administrative_office|other — 10 candidates stripped; promote to reference product]',
    `state_permit_number` STRING COMMENT 'State-issued environmental permit or license number authorizing the site to operate under state environmental regulations.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code where the site is located (e.g., CA, TX, ON).',
    `sustainability_program_enrollment_date` DATE COMMENT 'Date when the site was formally enrolled in the corporate sustainability tracking and reporting program.',
    CONSTRAINT pk_tracked_site PRIMARY KEY(`tracked_site_id`)
) COMMENT 'Master record of all physical sites and facilities tracked within the sustainability program including landfills, MRFs, WTE plants, transfer stations, LFG-to-RNG facilities, and fleet maintenance yards. Captures site name, site type, geographic coordinates, regulatory facility ID (EPA ID, state permit number), operational status, reporting boundary inclusion flag, and applicable emission source categories. Serves as the geographic and organizational anchor for all sustainability data products in this domain.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` (
    `ghg_inventory_id` BIGINT COMMENT 'Unique identifier for the GHG inventory record. Primary key.',
    `facility_id` BIGINT COMMENT 'EPA-assigned facility identifier for the reporting entity under the GHG Reporting Rule, if applicable.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to sustainability.report_period. Business justification: GHG inventories are compiled for specific reporting periods. One inventory for one reporting period (1:N). New FK needed. Removes redundant date columns that can be retrieved from report_period.',
    `approval_date` DATE COMMENT 'Date on which this GHG inventory was formally approved by management.',
    `approver_name` STRING COMMENT 'Name of the executive or manager who approved this GHG inventory for submission or publication.',
    `base_year` STRING COMMENT 'Historical year against which the organizations GHG emissions are tracked and reduction targets are measured (e.g., 2020).',
    `base_year_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total GHG emissions in the base year, used as the reference point for tracking emissions reductions over time, expressed in metric tons of CO2 equivalent.',
    `biogenic_co2_metric_tons` DECIMAL(18,2) COMMENT 'Total CO2 emissions from combustion or decomposition of biomass (e.g., landfill gas methane oxidation, biofuel combustion), reported separately from fossil-based emissions per GHG Protocol guidance, expressed in metric tons.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GHG inventory record was first created in the system.',
    `data_quality_assessment` STRING COMMENT 'Overall assessment of the quality, completeness, and reliability of the data used to compile this GHG inventory: high (primary data, direct measurement, high confidence), medium (mix of primary and secondary data, some estimation), low (significant use of estimates, proxies, or incomplete data).. Valid values are `high|medium|low`',
    `emissions_intensity_ratio` DECIMAL(18,2) COMMENT 'GHG emissions per unit of business activity (e.g., metric tons CO2e per ton of waste processed, per million USD revenue, per employee), used to normalize emissions for comparison across time periods or peer organizations.',
    `epa_submission_date` DATE COMMENT 'Date on which this GHG inventory was submitted to the U.S. EPA under the GHG Reporting Rule (40 CFR Part 98), if applicable.',
    `esg_framework_alignment` STRING COMMENT 'Comma-separated list of voluntary ESG reporting frameworks and standards to which this GHG inventory aligns (e.g., GRI 305, TCFD, CDP Climate Change, SASB, ISSB).',
    `intensity_metric` STRING COMMENT 'Unit of business activity used to calculate the emissions intensity ratio (e.g., tons_waste_processed, revenue_usd, employee_count, vehicle_miles_traveled).',
    `inventory_number` STRING COMMENT 'Business-facing unique identifier or reference number for the GHG inventory compilation (e.g., INV-2023-001).',
    `inventory_status` STRING COMMENT 'Current lifecycle status of the GHG inventory: draft (under preparation), in_review (undergoing internal or external review), approved (finalized and approved by management), submitted (submitted to regulatory or voluntary reporting body), published (publicly disclosed in ESG report).. Valid values are `draft|in_review|approved|submitted|published`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this GHG inventory record was last updated or modified.',
    `notes` STRING COMMENT 'Additional comments, assumptions, limitations, or contextual information relevant to this GHG inventory.',
    `organizational_boundary_approach` STRING COMMENT 'Method used to define organizational boundaries for GHG accounting: operational control (company has full authority over operations), financial control (company directs financial and operating policies), or equity share (proportional to ownership percentage).. Valid values are `operational_control|financial_control|equity_share`',
    `preparer_name` STRING COMMENT 'Name of the individual or team responsible for compiling and preparing this GHG inventory.',
    `restatement_flag` BOOLEAN COMMENT 'Indicates whether this inventory includes a restatement of previously reported emissions due to changes in calculation methodology, organizational boundary, data corrections, or other material changes (True if restated, False otherwise).',
    `restatement_reason` STRING COMMENT 'Explanation of the reason for restating previously reported emissions (e.g., methodology change, data correction, organizational boundary change, acquisition or divestiture).',
    `scope_1_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total direct GHG emissions from sources owned or controlled by the organization (e.g., fleet fuel combustion, landfill gas emissions, stationary combustion), expressed in metric tons of CO2 equivalent.',
    `scope_2_location_based_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total indirect GHG emissions from purchased electricity, steam, heating, and cooling, calculated using average emission factors for the regional grid, expressed in metric tons of CO2 equivalent.',
    `scope_2_market_based_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total indirect GHG emissions from purchased electricity, steam, heating, and cooling, calculated using emission factors from contractual instruments (e.g., renewable energy certificates, power purchase agreements), expressed in metric tons of CO2 equivalent.',
    `scope_3_category_12_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from waste disposal and treatment of products sold by the organization at the end of their life, expressed in metric tons of CO2 equivalent.',
    `scope_3_category_1_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from extraction, production, and transportation of goods and services purchased by the organization, expressed in metric tons of CO2 equivalent.',
    `scope_3_category_2_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from extraction, production, and transportation of capital goods purchased by the organization (e.g., equipment, vehicles, buildings), expressed in metric tons of CO2 equivalent.',
    `scope_3_category_3_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from extraction, production, and transportation of fuels and energy purchased by the organization, not included in Scope 1 or Scope 2 (e.g., upstream emissions of purchased fuels, transmission and distribution losses), expressed in metric tons of CO2 equivalent.',
    `scope_3_category_4_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation and distribution of products purchased by the organization between tier 1 suppliers and the organizations facilities, expressed in metric tons of CO2 equivalent.',
    `scope_3_category_5_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from third-party disposal and treatment of waste generated in the organizations owned or controlled operations, expressed in metric tons of CO2 equivalent.',
    `scope_3_category_6_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation of employees for business-related activities in vehicles not owned or operated by the organization, expressed in metric tons of CO2 equivalent.',
    `scope_3_category_7_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation of employees between their homes and worksites, expressed in metric tons of CO2 equivalent.',
    `scope_3_category_9_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Scope 3 emissions from transportation and distribution of products sold by the organization between the organizations operations and the end consumer, expressed in metric tons of CO2 equivalent.',
    `scope_3_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Total indirect GHG emissions from value chain activities not owned or controlled by the organization (e.g., purchased goods and services, business travel, employee commuting, waste disposal, downstream transportation), expressed in metric tons of CO2 equivalent.',
    `total_co2e_metric_tons` DECIMAL(18,2) COMMENT 'Sum of Scope 1, Scope 2 (location-based or market-based as selected), and Scope 3 emissions, representing the organizations total GHG footprint for the reporting period, expressed in metric tons of CO2 equivalent.',
    `verification_completion_date` DATE COMMENT 'Date on which the third-party verification or assurance process was completed and the verification statement was issued.',
    `verification_statement_reference` STRING COMMENT 'Document reference, file path, or URL to the verification statement or assurance report issued by the third-party verifier.',
    `verification_status` STRING COMMENT 'Level of third-party verification or assurance obtained for this GHG inventory: not_verified (no external verification), limited_assurance (moderate level of assurance per ISO 14064-3), reasonable_assurance (high level of assurance per ISO 14064-3).. Valid values are `not_verified|limited_assurance|reasonable_assurance`',
    `verifier_name` STRING COMMENT 'Name of the third-party verification body or assurance provider that verified this GHG inventory (e.g., accredited certification body, independent auditor).',
    CONSTRAINT pk_ghg_inventory PRIMARY KEY(`ghg_inventory_id`)
) COMMENT 'Master record representing a complete annual or periodic GHG inventory compilation for a defined organizational boundary and reporting year. Captures inventory year, organizational boundary approach (operational control, equity share, financial control), total Scope 1 CO2e, total Scope 2 CO2e (location-based and market-based), total Scope 3 CO2e by category, biogenic emissions, data quality assessment, verification status, and verifier identity. Serves as the authoritative GHG inventory record submitted to EPA and disclosed in ESG reports.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`report_period` (
    `report_period_id` BIGINT COMMENT 'Unique identifier for the sustainability reporting period. Primary key for this reference entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this reporting period record.',
    `actual_submission_date` DATE COMMENT 'The actual date when the sustainability report or disclosure was submitted for this period.',
    `assurance_level` STRING COMMENT 'Level of third-party assurance obtained for this reporting period: limited (review-level), reasonable (audit-level), or none.. Valid values are `limited|reasonable|none`',
    `baseline_period_flag` BOOLEAN COMMENT 'Indicates whether this period serves as a baseline year for carbon reduction targets or sustainability goals.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) if this is a monthly reporting period, otherwise null.',
    `calendar_quarter` STRING COMMENT 'The calendar quarter number (1-4) if this is a quarterly reporting period, otherwise null.',
    `calendar_year` STRING COMMENT 'The calendar year to which this reporting period belongs (e.g., 2024).',
    `cdp_reporting_applicable` BOOLEAN COMMENT 'Indicates whether this period is used for voluntary CDP climate change disclosure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reporting period record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_freeze_date` DATE COMMENT 'The date after which no further data changes are allowed for this reporting period. Used to ensure data integrity for regulatory and ESG reporting.',
    `end_date` DATE COMMENT 'The last day of the reporting period (inclusive). Format: yyyy-MM-dd.',
    `epa_ghg_reporting_applicable` BOOLEAN COMMENT 'Indicates whether this period is used for EPA GHG mandatory reporting under 40 CFR Part 98.',
    `fiscal_month` STRING COMMENT 'The fiscal month number (1-12) if this is a monthly reporting period, otherwise null.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter number (1-4) if this is a quarterly reporting period, otherwise null.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reporting period belongs (e.g., 2024).',
    `gri_reporting_applicable` BOOLEAN COMMENT 'Indicates whether this period is used for GRI sustainability reporting standards.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this reporting period is currently active and available for use in sustainability data collection and reporting processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this reporting period record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about this reporting period, including any special circumstances or data quality considerations.',
    `period_code` STRING COMMENT 'Standardized short code for the reporting period used across systems (e.g., 2024Q1, FY24, 202401).',
    `period_name` STRING COMMENT 'Human-readable name for the reporting period (e.g., FY2024 Q1, 2024 Annual Report, January 2024).',
    `period_status` STRING COMMENT 'Current lifecycle status of the reporting period: open (data collection in progress), closed (data collection complete), verified (third-party assurance complete), draft (period defined but not yet active), archived (historical period).. Valid values are `open|closed|verified|draft|archived`',
    `period_type` STRING COMMENT 'Classification of the reporting period frequency (annual, quarterly, monthly, semi-annual, or custom).. Valid values are `annual|quarterly|monthly|semi-annual|custom`',
    `restatement_flag` BOOLEAN COMMENT 'Indicates whether data for this reporting period has been restated due to methodology changes, data corrections, or acquisitions/divestitures.',
    `restatement_reason` STRING COMMENT 'Explanation of why data for this reporting period was restated (e.g., methodology change, data error correction, structural change).',
    `sasb_reporting_applicable` BOOLEAN COMMENT 'Indicates whether this period is used for SASB industry-specific sustainability accounting standards.',
    `start_date` DATE COMMENT 'The first day of the reporting period (inclusive). Format: yyyy-MM-dd.',
    `submission_deadline_date` DATE COMMENT 'The regulatory or voluntary framework deadline by which reporting must be submitted for this period.',
    `tcfd_reporting_applicable` BOOLEAN COMMENT 'Indicates whether this period is used for TCFD climate-related financial disclosures.',
    `verification_completion_date` DATE COMMENT 'Date when third-party verification or assurance was completed for this reporting period.',
    `verification_provider` STRING COMMENT 'Name of the third-party organization providing assurance or verification services for this period.',
    `verification_status` STRING COMMENT 'Status of third-party assurance or verification for this reporting period.. Valid values are `not_started|in_progress|completed|not_required`',
    CONSTRAINT pk_report_period PRIMARY KEY(`report_period_id`)
) COMMENT 'Reference record defining the official sustainability reporting periods used across all data products in this domain. Captures period name, period type (annual, quarterly, monthly), start date, end date, fiscal year alignment, calendar year alignment, reporting framework applicability (EPA GHG, CDP, GRI, TCFD), period status (open, closed, verified), and data freeze date. Ensures consistent temporal alignment across GHG inventory, diversion records, and ESG disclosures.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` (
    `carbon_registry_id` BIGINT COMMENT 'Unique identifier for the carbon credit registry record.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this carbon registry record.',
    `parent_carbon_registry_id` BIGINT COMMENT 'Self-referencing FK on carbon_registry (parent_carbon_registry_id)',
    `account_activation_date` DATE COMMENT 'Date when Waste Managements account with this carbon credit registry was activated.',
    `account_closure_date` DATE COMMENT 'Date when Waste Managements account with this carbon credit registry was closed or deactivated.',
    `accreditation_body` STRING COMMENT 'Organization that accredits or recognizes the carbon credit registry (e.g., UNFCCC, ICROA, IETA).',
    `accreditation_date` DATE COMMENT 'Date when the carbon credit registry received its accreditation or recognition.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the registrys accreditation expires and requires renewal.',
    `additionality_requirement` STRING COMMENT 'Description of the additionality criteria that projects must meet to qualify for carbon credits in this registry.',
    `co_benefits_tracked_flag` BOOLEAN COMMENT 'Indicates whether the registry tracks and reports co-benefits beyond carbon reduction (e.g., biodiversity, community development, water quality).',
    `contact_email` STRING COMMENT 'Email address of the primary contact at the carbon credit registry.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Primary contact person at the carbon credit registry for Waste Management account inquiries.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact at the carbon credit registry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon registry record was first created in the system.',
    `credit_serial_number_format` STRING COMMENT 'Description or pattern of the serial number format used by this registry to uniquely identify carbon credits.',
    `data_quality_tier` STRING COMMENT 'Assessment of the data quality and verification rigor of this carbon credit registry according to GHG Protocol data quality tiers.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `double_counting_prevention_mechanism` STRING COMMENT 'Description of the registrys mechanism to prevent double counting or double claiming of carbon credits.',
    `esg_framework_alignment` STRING COMMENT 'ESG reporting frameworks that recognize or accept credits from this registry (e.g., GRI, TCFD, CDP, SASB).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this carbon registry record is currently active and in use for carbon credit transactions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon registry record was last updated or modified.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction (issuance, transfer, or retirement) in Waste Managements account with this registry.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations regarding this carbon credit registry.',
    `permanence_requirement` STRING COMMENT 'Description of permanence or reversal risk management requirements for carbon credits issued by this registry.',
    `public_registry_access_flag` BOOLEAN COMMENT 'Indicates whether the registry provides public online access to credit issuance and retirement records.',
    `registry_account_holder_name` STRING COMMENT 'Legal name of the account holder registered with the carbon credit registry.',
    `registry_account_number` STRING COMMENT 'Waste Managements account number or identifier within this carbon credit registry system.',
    `registry_code` STRING COMMENT 'Short code or abbreviation for the carbon credit registry (e.g., VCS, GS, ACR, CAR).',
    `registry_established_date` DATE COMMENT 'Date when the carbon credit registry was originally established or founded.',
    `registry_fee_structure` STRING COMMENT 'Description of fees charged by the registry for account maintenance, credit issuance, transfers, and retirements.',
    `registry_jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction under which the carbon credit registry operates (e.g., USA, EU, Global).',
    `registry_name` STRING COMMENT 'Name of the carbon credit registry organization that issues and tracks carbon offset credits. [ENUM-REF-CANDIDATE: Verra VCS|Gold Standard|American Carbon Registry|Climate Action Reserve|CDM|JI|Other — promote to reference product]',
    `registry_status` STRING COMMENT 'Current operational status of the carbon credit registry.. Valid values are `active|inactive|suspended|merged|retired`',
    `registry_type` STRING COMMENT 'Classification of the registry as voluntary market, compliance market, or hybrid.. Valid values are `voluntary|compliance|hybrid`',
    `registry_website_url` STRING COMMENT 'Official website URL for the carbon credit registry where credit information can be verified.',
    `retirement_process_description` STRING COMMENT 'Description of the process and requirements for retiring carbon credits in this registry.',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goals that projects in this registry typically support.',
    `supported_methodologies` STRING COMMENT 'List of carbon accounting methodologies or protocols accepted by this registry (e.g., VCS VM0024, ACM0001, CDM methodologies).',
    `supported_project_types` STRING COMMENT 'Comma-separated list of carbon offset project types supported by this registry (e.g., renewable energy, forestry, LFG-to-RNG, methane capture, waste-to-energy).',
    `transparency_level` STRING COMMENT 'Assessment of the registrys transparency in publicly disclosing project information, credit issuance, and retirement data.. Valid values are `high|medium|low`',
    `verification_standard` STRING COMMENT 'Third-party verification standard required by this registry for carbon credit issuance (e.g., ISO 14064-3, VVB accreditation).',
    `vintage_year_range_end` STRING COMMENT 'Latest vintage year of carbon credits available in this registry.',
    `vintage_year_range_start` STRING COMMENT 'Earliest vintage year of carbon credits available in this registry.',
    CONSTRAINT pk_carbon_registry PRIMARY KEY(`carbon_registry_id`)
) COMMENT 'Master record for carbon credit registries (Verra VCS, Gold Standard, American Carbon Registry, Climate Action Reserve) used to verify and track carbon offset credits and their serial numbers.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` (
    `initiative_safety_analysis_id` BIGINT COMMENT 'Unique identifier for this initiative-JHA association record',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically initiative project manager or safety coordinator) who assigned this JHA to the initiative',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to the carbon reduction initiative requiring safety analysis',
    `jha_id` BIGINT COMMENT 'Foreign key linking to the Job Hazard Analysis applicable to this initiative',
    `assignment_date` DATE COMMENT 'Date when this JHA was assigned to the initiative for safety planning purposes',
    `crew_size_assigned` STRING COMMENT 'Number of crew members assigned to perform this JHA-covered task for this specific initiative (may differ from standard JHA crew size based on initiative scope)',
    `effective_end_date` DATE COMMENT 'Date when this JHA is no longer applicable to the initiative (aligned with project phase completion or initiative completion)',
    `effective_start_date` DATE COMMENT 'Date when this JHA becomes applicable to the initiative (aligned with project phase start)',
    `initiative_specific_controls` STRING COMMENT 'Additional safety controls or modifications to standard JHA procedures required for this specific initiative (e.g., enhanced PPE for RNG facility work, additional monitoring for methane capture expansion)',
    `jha_applicability_phase` STRING COMMENT 'Project phase during which this JHA applies to the initiative (e.g., construction phase for RNG facility build requires excavation JHA, electrical work JHA; operations phase requires different JHAs)',
    `jha_review_status` STRING COMMENT 'Status of JHA review and approval specific to this initiative (JHA may require initiative-specific review even if generally approved)',
    `last_revision_date` DATE COMMENT 'Date when this initiative-JHA association was last reviewed or revised (tracks initiative-specific updates separate from master JHA revisions)',
    `task_frequency_during_initiative` STRING COMMENT 'How often this JHA-covered task is performed during the initiative implementation (frequency varies by initiative phase and type)',
    `training_completion_required_date` DATE COMMENT 'Deadline by which all crew members must complete JHA-specific training before performing tasks on this initiative',
    CONSTRAINT pk_initiative_safety_analysis PRIMARY KEY(`initiative_safety_analysis_id`)
) COMMENT 'This association product represents the safety planning relationship between carbon reduction initiatives and Job Hazard Analyses. It captures which JHAs apply to which initiatives during specific project phases, tracking task frequency, crew assignments, training requirements, and initiative-specific safety controls. Each record links one carbon initiative to one JHA with attributes that exist only in the context of this initiative-safety relationship.. Existence Justification: In waste management sustainability initiatives, a single carbon initiative (e.g., RNG facility construction, fleet electrification) requires multiple Job Hazard Analyses covering different tasks (excavation, electrical work, confined space entry, vehicle maintenance), and each JHA can apply to multiple initiatives across the organization. The business actively manages these associations by tracking which JHAs apply during which project phases, monitoring training completion, and documenting initiative-specific safety controls that supplement standard JHA procedures.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` (
    `program_task_safety_requirement_id` BIGINT COMMENT 'Unique identifier for this program-JHA association record. Primary key.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to the circular economy program that requires this job task safety analysis',
    `employee_id` BIGINT COMMENT 'Reference to the employee who created this program-JHA association, typically a program manager or safety coordinator.',
    `jha_id` BIGINT COMMENT 'Foreign key linking to the Job Hazard Analysis that applies to tasks performed within this program',
    `applicability_start_date` DATE COMMENT 'The date when this JHA became applicable to this specific circular economy program. Tracks when the safety requirement was activated for program operations.',
    `created_date` DATE COMMENT 'Date when this program-JHA association record was created in the system.',
    `crew_size_required` STRING COMMENT 'The number of workers required to safely perform this job task within this program. May be program-specific based on operational scale or material handling requirements.',
    `last_review_date` DATE COMMENT 'The date when this JHA was last reviewed for applicability and accuracy within the context of this specific program. Program managers review JHAs to ensure they reflect current program operations.',
    `program_phase_applicability` STRING COMMENT 'The operational phase(s) of the circular economy program during which this JHA applies (e.g., collection, sorting, processing, distribution). A single JHA may apply to multiple phases or be phase-specific.',
    `program_specific_ppe_requirements` STRING COMMENT 'Additional or modified Personal Protective Equipment requirements specific to this program beyond the base JHA requirements. May include specialized PPE for handling specific material streams (e.g., chemical-resistant gloves for e-waste battery handling).',
    `record_status` STRING COMMENT 'Indicates whether this program-JHA association is currently active, inactive, or has been superseded by an updated JHA version.',
    `task_frequency_in_program` STRING COMMENT 'How often this job task is performed within the context of this specific program. May differ from the general JHA frequency based on program operational intensity.',
    `training_completion_status` STRING COMMENT 'Current status of required safety training completion for program staff performing this job task. Tracks program-level training compliance.',
    CONSTRAINT pk_program_task_safety_requirement PRIMARY KEY(`program_task_safety_requirement_id`)
) COMMENT 'This association product represents the safety requirements and hazard controls that apply when specific job tasks are performed within the context of circular economy programs. It captures program-specific task execution parameters including frequency, crew sizing, PPE requirements, and training status. Each record links one circular economy program to one JHA with attributes that exist only in the context of this program-task relationship.. Existence Justification: Circular economy programs involve multiple distinct job tasks (organics collection, composting operations, MRF sorting, e-waste disassembly, hazmat handling), each requiring its own Job Hazard Analysis. Conversely, a single JHA (e.g., Forklift Operation in Enclosed Spaces) applies across multiple circular economy programs (composting, MRF, transfer station operations). The business actively manages program-specific safety parameters including task frequency within each program, crew sizing based on program scale, program-specific PPE requirements for specialized material streams, and training completion tracking per program-task combination.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`program_assignment` (
    `program_assignment_id` BIGINT COMMENT 'Unique identifier for the program assignment record. Primary key.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key linking to the circular economy program to which the employee is assigned',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the circular economy program',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employees time allocated to this program. Used for labor cost allocation and capacity planning. Sum across all programs for an employee should not exceed 100%.',
    `assignment_date` DATE COMMENT 'The date when the employee was assigned to this circular economy program. Used for tracking assignment history and tenure.',
    `assignment_end_date` DATE COMMENT 'The date when the employee assignment to this program ended or is scheduled to end. Null for active assignments.',
    `assignment_status` STRING COMMENT 'Current status of the employee assignment to this program. Used for workforce planning and program staffing management.',
    `certification_required` STRING COMMENT 'Comma-separated list of certifications or qualifications required for the employee to perform this role in this program (e.g., Hazmat certification, Organic waste handling, E-waste specialist).',
    `notes` STRING COMMENT 'Free-text field for additional context about this specific assignment, special arrangements, or operational notes.',
    `performance_target` STRING COMMENT 'The specific performance target or KPI assigned to this employee for this program (e.g., diversion volume, customer acquisition, revenue target). Used for incentive compensation and performance reviews.',
    `role_type` STRING COMMENT 'The specific role or function the employee performs within this circular economy program assignment. Determines responsibilities and performance expectations.',
    `territory_assignment` STRING COMMENT 'The specific geographic territory or customer segment the employee is responsible for within this program. Used for sales territory management and customer coverage.',
    CONSTRAINT pk_program_assignment PRIMARY KEY(`program_assignment_id`)
) COMMENT 'This association product represents the Assignment between circular_economy_program and employee. It captures the operational assignment of employees to circular economy programs with specific roles, territories, and performance targets. Each record links one circular_economy_program to one employee with attributes that exist only in the context of this assignment relationship.. Existence Justification: In Waste Management operations, circular economy programs (e.g., electronics take-back, organics composting, industrial symbiosis) require cross-functional teams with multiple employees in different roles (sales, operations, customer service, compliance). Employees routinely support multiple programs across different territories and customer segments. The business actively manages these assignments with specific roles, territories, performance targets for incentive compensation, and required certifications.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`sustainability`.`carbon_project` (
    `carbon_project_id` BIGINT COMMENT 'Primary key for carbon_project',
    `facility_id` BIGINT COMMENT 'Reference to the primary facility or site where the carbon project is implemented (e.g., landfill, transfer station, fleet depot).',
    `parent_carbon_project_id` BIGINT COMMENT 'Self-referencing FK on carbon_project (parent_carbon_project_id)',
    `actual_co2e_reduction_mt` DECIMAL(18,2) COMMENT 'Verified annual reduction in greenhouse gas emissions measured in metric tons of carbon dioxide equivalent (CO2e) achieved by the project.',
    `actual_completion_date` DATE COMMENT 'Actual date when the carbon project was completed or terminated. Null if project is still active.',
    `additionality_justification` STRING COMMENT 'Explanation of how the project demonstrates additionality (i.e., reductions would not have occurred without the project) as required for carbon credit certification.',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Estimated or actual annual operating and maintenance cost in US dollars for sustaining the carbon project.',
    `baseline_methodology` STRING COMMENT 'Methodology used to establish the baseline emissions scenario against which project reductions are measured.',
    `carbon_credit_eligible` BOOLEAN COMMENT 'Indicates whether the project is eligible to generate tradable carbon credits or offsets under a recognized standard.',
    `circular_economy_indicator` BOOLEAN COMMENT 'Indicates whether the project supports circular economy principles by recovering materials or energy from waste streams.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carbon project record was first created in the system.',
    `credits_issued_count` STRING COMMENT 'Total number of carbon credits or offsets issued to date for this project by the verification body.',
    `credits_retired_count` STRING COMMENT 'Total number of carbon credits or offsets retired (used) to date from this project to claim emission reductions.',
    `energy_output_mwh` DECIMAL(18,2) COMMENT 'Annual energy output in megawatt hours generated by the project for landfill gas-to-energy or other renewable energy projects.',
    `esg_reporting_framework` STRING COMMENT 'Voluntary ESG reporting framework(s) that the project supports (e.g., Global Reporting Initiative, Task Force on Climate-related Financial Disclosures, Carbon Disclosure Project).',
    `funding_source` STRING COMMENT 'Primary source of funding for the carbon project implementation and operations.',
    `last_verification_date` DATE COMMENT 'Date of the most recent third-party verification or audit of the projects carbon reduction performance.',
    `lifecycle_status` STRING COMMENT 'Current state of the carbon project in its lifecycle from planning through completion or cancellation.',
    `next_verification_date` DATE COMMENT 'Scheduled date for the next third-party verification or audit of the projects carbon reduction performance.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the carbon project for internal reference.',
    `partner_organization` STRING COMMENT 'Name of external partner organization or vendor involved in the carbon project implementation or verification (e.g., technology provider, verification body).',
    `planned_completion_date` DATE COMMENT 'Target date for project completion or end of the project commitment period.',
    `project_category` STRING COMMENT 'High-level categorization of the project based on its carbon impact mechanism: reduction (lowering emissions), removal (sequestration), avoidance (preventing emissions), or offset (purchasing credits).',
    `project_code` STRING COMMENT 'Business identifier for the carbon project following the format: three-letter category code, four-digit sequence number, and two-letter region code (e.g., LFG-0001-US for landfill gas project).',
    `project_investment_usd` DECIMAL(18,2) COMMENT 'Total capital investment in US dollars allocated to the carbon project including equipment, infrastructure, and implementation costs.',
    `project_manager_email` STRING COMMENT 'Email address of the project manager for communication and coordination.',
    `project_manager_name` STRING COMMENT 'Name of the individual responsible for managing and overseeing the carbon project implementation and performance.',
    `project_name` STRING COMMENT 'Full descriptive name of the carbon reduction or offset project.',
    `project_type` STRING COMMENT 'Classification of the carbon project by its primary emission reduction or offset mechanism.',
    `region` STRING COMMENT 'Geographic region or country where the carbon project is located using ISO 3166-1 alpha-3 country codes.',
    `regulatory_program` STRING COMMENT 'Specific regulatory program or framework the project supports (e.g., EPA GHG Reporting Program, California Cap-and-Trade, Clean Air Act Title V). [ENUM-REF-CANDIDATE: epa_ghg_reporting|california_cap_and_trade|rggi|clean_air_act_title_v|voluntary_cdp|voluntary_gri|voluntary_tcfd — promote to reference product]',
    `renewable_energy_type` STRING COMMENT 'Type of renewable energy generated or utilized by the project, if applicable.',
    `scope_classification` STRING COMMENT 'GHG Protocol scope classification indicating whether the project addresses direct emissions (Scope 1), indirect energy emissions (Scope 2), or other indirect emissions (Scope 3).',
    `start_date` DATE COMMENT 'Date when the carbon project officially commenced or is scheduled to commence operations.',
    `state_province` STRING COMMENT 'State or province where the carbon project is located.',
    `target_co2e_reduction_mt` DECIMAL(18,2) COMMENT 'Planned annual reduction in greenhouse gas emissions measured in metric tons of carbon dioxide equivalent (CO2e) that the project aims to achieve.',
    `technology_description` STRING COMMENT 'Detailed description of the technology, equipment, or methodology used in the carbon project (e.g., landfill gas collection system, CNG vehicle conversion, anaerobic digestion).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the carbon project record was last modified in the system.',
    `verification_standard` STRING COMMENT 'Third-party verification or certification standard used to validate the carbon reduction claims of the project (e.g., Verified Carbon Standard, Gold Standard, Climate Action Reserve).',
    `verification_status` STRING COMMENT 'Current status of third-party verification for the carbon project emissions reductions.',
    `waste_diversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill through recycling, composting, or waste-to-energy as a result of the project.',
    CONSTRAINT pk_carbon_project PRIMARY KEY(`carbon_project_id`)
) COMMENT 'Master reference table for carbon_project. Referenced by project_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ADD CONSTRAINT `fk_sustainability_carbon_initiative_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ADD CONSTRAINT `fk_sustainability_initiative_milestone_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ADD CONSTRAINT `fk_sustainability_initiative_milestone_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ADD CONSTRAINT `fk_sustainability_lfg_capture_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_source`(`emission_source_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ADD CONSTRAINT `fk_sustainability_rng_production_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ADD CONSTRAINT `fk_sustainability_srf_production_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ADD CONSTRAINT `fk_sustainability_diversion_record_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_carbon_registry_id` FOREIGN KEY (`carbon_registry_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_registry`(`carbon_registry_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_carbon_project_id` FOREIGN KEY (`carbon_project_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_project`(`carbon_project_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ADD CONSTRAINT `fk_sustainability_carbon_offset_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ADD CONSTRAINT `fk_sustainability_offset_transaction_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ADD CONSTRAINT `fk_sustainability_offset_transaction_carbon_offset_id` FOREIGN KEY (`carbon_offset_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_offset`(`carbon_offset_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ADD CONSTRAINT `fk_sustainability_offset_transaction_carbon_registry_id` FOREIGN KEY (`carbon_registry_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_registry`(`carbon_registry_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ADD CONSTRAINT `fk_sustainability_offset_transaction_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ADD CONSTRAINT `fk_sustainability_renewable_energy_credit_carbon_registry_id` FOREIGN KEY (`carbon_registry_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_registry`(`carbon_registry_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ADD CONSTRAINT `fk_sustainability_renewable_energy_credit_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_reduction_target_id` FOREIGN KEY (`reduction_target_id`) REFERENCES `waste_management_ecm`.`sustainability`.`reduction_target`(`reduction_target_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_ghg_inventory_id` FOREIGN KEY (`ghg_inventory_id`) REFERENCES `waste_management_ecm`.`sustainability`.`ghg_inventory`(`ghg_inventory_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ADD CONSTRAINT `fk_sustainability_esg_disclosure_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ADD CONSTRAINT `fk_sustainability_emission_factor_superseded_by_factor_emission_factor_id` FOREIGN KEY (`superseded_by_factor_emission_factor_id`) REFERENCES `waste_management_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ADD CONSTRAINT `fk_sustainability_circular_economy_program_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ADD CONSTRAINT `fk_sustainability_sustainability_program_enrollment_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ADD CONSTRAINT `fk_sustainability_fleet_fuel_consumption_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ADD CONSTRAINT `fk_sustainability_ghg_inventory_report_period_id` FOREIGN KEY (`report_period_id`) REFERENCES `waste_management_ecm`.`sustainability`.`report_period`(`report_period_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ADD CONSTRAINT `fk_sustainability_carbon_registry_parent_carbon_registry_id` FOREIGN KEY (`parent_carbon_registry_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_registry`(`carbon_registry_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ADD CONSTRAINT `fk_sustainability_initiative_safety_analysis_carbon_initiative_id` FOREIGN KEY (`carbon_initiative_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_initiative`(`carbon_initiative_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ADD CONSTRAINT `fk_sustainability_program_task_safety_requirement_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ADD CONSTRAINT `fk_sustainability_program_assignment_circular_economy_program_id` FOREIGN KEY (`circular_economy_program_id`) REFERENCES `waste_management_ecm`.`sustainability`.`circular_economy_program`(`circular_economy_program_id`);
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ADD CONSTRAINT `fk_sustainability_carbon_project_parent_carbon_project_id` FOREIGN KEY (`parent_carbon_project_id`) REFERENCES `waste_management_ecm`.`sustainability`.`carbon_project`(`carbon_project_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`sustainability` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `waste_management_ecm`.`sustainability` SET TAGS ('dbx_domain' = 'sustainability');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `activity_data_unit` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Unit of Measure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `activity_data_value` SET TAGS ('dbx_business_glossary_term' = 'Activity Data Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `biogenic_co2_quantity` SET TAGS ('dbx_business_glossary_term' = 'Biogenic Carbon Dioxide (CO2) Quantity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Emission Calculation Method');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'Direct Measurement|Mass Balance|Emission Factor|Engineering Estimate|Continuous Monitoring|Default Factor');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `carbon_offset_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Applied Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `carbon_offset_quantity` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Quantity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `co2e_quantity` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Quantity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `co2e_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Unit of Measure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `co2e_unit_of_measure` SET TAGS ('dbx_value_regex' = 'metric tons CO2e|kilograms CO2e|pounds CO2e');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_quantity` SET TAGS ('dbx_business_glossary_term' = 'Emission Quantity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_status` SET TAGS ('dbx_business_glossary_term' = 'Emission Record Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_status` SET TAGS ('dbx_value_regex' = 'Draft|Submitted|Approved|Reported|Archived|Disputed');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Emission Unit of Measure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `emission_unit_of_measure` SET TAGS ('dbx_value_regex' = 'metric tons|kilograms|pounds|cubic meters|standard cubic feet');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `epa_subpart_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Subpart Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `ghg_type` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `gwp_factor` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Factor');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `gwp_reference_standard` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Reference Standard');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `gwp_reference_standard` SET TAGS ('dbx_value_regex' = 'IPCC AR4|IPCC AR5|IPCC AR6');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Emission Record Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `scope_category` SET TAGS ('dbx_business_glossary_term' = 'GHG Scope Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `scope_category` SET TAGS ('dbx_value_regex' = 'Scope 1|Scope 2|Scope 3');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Unverified|Internally Verified|Third-Party Verified|Audited|Certified');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `voluntary_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_emission` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Jha Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `carbon_offset_eligible` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Eligible Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `control_device_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Control Device Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `control_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Control Device Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `emission_factor_methodology` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Methodology');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `emission_factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit of Measure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `emission_factor_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `epa_source_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Source Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `ghg_protocol_category` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Protocol Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `ghg_protocol_scope` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Protocol Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `ghg_protocol_scope` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `is_subject_to_caa` SET TAGS ('dbx_business_glossary_term' = 'Subject to Clean Air Act (CAA) Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `is_subject_to_ghgrp` SET TAGS ('dbx_business_glossary_term' = 'Subject to Greenhouse Gas Reporting Program (GHGRP) Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `lfg_to_rng_conversion` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) to Renewable Natural Gas (RNG) Conversion Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_construction|temporarily_offline|retired');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Air Quality Permit Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `rated_capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity Unit of Measure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `renewable_energy_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Source Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `reporting_threshold_tpy` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Tons Per Year (TPY)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_source` ALTER COLUMN `waste_to_energy_flag` SET TAGS ('dbx_business_glossary_term' = 'Waste-to-Energy (WTE) Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Procurement Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Procurement - Purchase Requisition Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Reduction Target Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `allocation_justification` SET TAGS ('dbx_business_glossary_term' = 'Allocation Justification');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `baseline_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'Baseline Carbon Dioxide Equivalent (CO2e) Emissions (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `budget_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `capital_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Amount');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `capital_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `carbon_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Credit Eligible Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `carbon_initiative_description` SET TAGS ('dbx_business_glossary_term' = 'Initiative Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `carbon_initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `carbon_initiative_status` SET TAGS ('dbx_value_regex' = 'planning|approved|in_progress|on_hold|completed|cancelled');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `esg_reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Framework');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `facility_count` SET TAGS ('dbx_business_glossary_term' = 'Facility Count');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `funding_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Initiative Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `initiative_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Initiative Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `initiative_phase` SET TAGS ('dbx_business_glossary_term' = 'Initiative Phase at Procurement');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_business_glossary_term' = 'Initiative Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `linked_date` SET TAGS ('dbx_business_glossary_term' = 'Initiative Link Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `operating_cost_impact_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost Impact');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `operating_cost_impact_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Years)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `payback_period_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `program_manager` SET TAGS ('dbx_business_glossary_term' = 'Program Manager');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `projected_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Return on Investment (ROI) Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `projected_roi_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `renewable_energy_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Capacity (Megawatts)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `scope_1_reduction_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Greenhouse Gas (GHG) Reduction (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `scope_2_reduction_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Greenhouse Gas (GHG) Reduction (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `scope_3_reduction_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Greenhouse Gas (GHG) Reduction (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goals (SDG) Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `target_co2e_reduction_tons` SET TAGS ('dbx_business_glossary_term' = 'Target Carbon Dioxide Equivalent (CO2e) Reduction (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `vehicle_count` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Count');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_initiative` ALTER COLUMN `verification_standard` SET TAGS ('dbx_business_glossary_term' = 'Verification Standard');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `initiative_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Milestone Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `boiler_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Boiler Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `quaternary_initiative_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `quaternary_initiative_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `quaternary_initiative_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `tertiary_initiative_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `tertiary_initiative_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `tertiary_initiative_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `co2e_reduction_achieved_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Reduction Achieved (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `co2e_reduction_target_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Reduction Target (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `dependencies` SET TAGS ('dbx_business_glossary_term' = 'Dependencies');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `esg_framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Framework Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|cancelled|delayed');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'planning|procurement|implementation|verification|reporting|closure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `verification_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Verification Evidence Reference');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_milestone` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'internal_audit|third_party_verification|epa_reporting|meter_data|engineering_calculation|vendor_certification');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_capture_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Capture ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_collection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Lfg Collection System Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `blower_station_count` SET TAGS ('dbx_business_glossary_term' = 'Blower Station Count');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capture Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `carbon_credits_generated` SET TAGS ('dbx_business_glossary_term' = 'Carbon Credits Generated');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `co2e_emissions_avoided_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions Avoided (Metric Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `collection_system_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Collection System Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `collection_system_status` SET TAGS ('dbx_business_glossary_term' = 'Collection System Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `collection_system_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|offline|startup|shutdown|degraded');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `collection_well_count` SET TAGS ('dbx_business_glossary_term' = 'Collection Well Count');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempted');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|incomplete');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `electricity_generated_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electricity Generated (MWh)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `epa_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Permit Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `flare_station_count` SET TAGS ('dbx_business_glossary_term' = 'Flare Station Count');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lel_monitoring_reading_percent` SET TAGS ('dbx_business_glossary_term' = 'Lower Explosive Limit (LEL) Monitoring Reading Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_flared_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Flared Volume (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_flared_volume_mmscf` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Flared Volume (MMSCF)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_utilized_rng_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Utilized for Renewable Natural Gas (RNG) Production Volume (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_utilized_rng_volume_mmscf` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Utilized for Renewable Natural Gas (RNG) Production Volume (MMSCF)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_utilized_wte_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Utilized for Waste-to-Energy (WTE) Volume (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `lfg_utilized_wte_volume_mmscf` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Utilized for Waste-to-Energy (WTE) Volume (MMSCF)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'continuous_monitoring|periodic_sampling|calculated_estimate|direct_measurement');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `methane_concentration_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane Concentration Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `total_lfg_volume_collected_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Total Landfill Gas (LFG) Volume Collected (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`lfg_capture` ALTER COLUMN `total_lfg_volume_collected_mmscf` SET TAGS ('dbx_business_glossary_term' = 'Total Landfill Gas (LFG) Volume Collected (MMSCF)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rng_production_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Production ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rng_processing_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Rng Processing Unit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `carbon_credit_registry` SET TAGS ('dbx_business_glossary_term' = 'Carbon Credit Registry');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `carbon_credit_registry` SET TAGS ('dbx_value_regex' = 'verra_vcs|gold_standard|climate_action_reserve|american_carbon_registry|none');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (CI) Score');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `co2e_avoided_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Avoided (Metric Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Facility Downtime Hours');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_value_regex' = 'scheduled_maintenance|unscheduled_maintenance|equipment_failure|weather|regulatory_inspection|other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `lcfs_credits_generated` SET TAGS ('dbx_business_glossary_term' = 'Low Carbon Fuel Standard (LCFS) Credits Generated');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `lfg_input_volume_scf` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Input Volume (Standard Cubic Feet)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `lfg_methane_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) Methane Content Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `pipeline_injection_volume_scf` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Injection Volume (Standard Cubic Feet)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Production Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production End Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production Start Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|aborted|quality_hold|pending_certification');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `quality_test_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `quality_test_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Passed Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `renewable_fuel_pathway_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Pathway Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `renewable_fuel_pathway_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rin_credits_generated` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Credits Generated');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rin_d_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) D-Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rin_d_code` SET TAGS ('dbx_value_regex' = 'D3|D5');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rng_methane_purity_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Methane Purity Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rng_output_energy_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Output Energy (Million British Thermal Units)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `rng_output_volume_scf` SET TAGS ('dbx_business_glossary_term' = 'Renewable Natural Gas (RNG) Output Volume (Standard Cubic Feet)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Facility Uptime Hours');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `vehicle_fuel_dispensed_gge` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Fuel Dispensed (Gasoline Gallon Equivalent)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`rng_production` ALTER COLUMN `voluntary_carbon_credits_issued` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Carbon Credits Issued');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `srf_production_id` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Production ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^BOL-[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `bulk_density_kg_m3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (kg/m³)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `calorific_value_mj_kg` SET TAGS ('dbx_business_glossary_term' = 'Calorific Value (MJ/kg)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `chlorine_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Chlorine Content Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `co2e_emissions_avoided_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions Avoided (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `contamination_level` SET TAGS ('dbx_business_glossary_term' = 'Contamination Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `contamination_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|acceptable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `conversion_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Efficiency Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `destination_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `diversion_rate_contribution_percent` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Contribution Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `end_use_destination_type` SET TAGS ('dbx_business_glossary_term' = 'End-Use Destination Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `end_use_destination_type` SET TAGS ('dbx_value_regex' = 'cement_kiln|industrial_boiler|wte_facility|power_plant|other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `heavy_metals_ppm` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metals Content (PPM)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `input_volume_tons` SET TAGS ('dbx_business_glossary_term' = 'Input Volume (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `input_waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Input Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `input_waste_stream_type` SET TAGS ('dbx_value_regex' = 'MSW|C&D|commercial|industrial|mixed');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `particle_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Particle Size (mm)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_cost_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Per Ton');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_cost_per_ton` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production End Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production Start Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|quality_hold|rejected|shipped');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `quality_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `quality_certification_number` SET TAGS ('dbx_value_regex' = '^QC-[0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `quality_classification` SET TAGS ('dbx_business_glossary_term' = 'Quality Classification');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `quality_classification` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4|class_5|non_compliant');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `quality_test_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `renewable_energy_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `srf_output_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Solid Recovered Fuel (SRF) Output Tonnage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `unit_price_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Per Ton');
ALTER TABLE `waste_management_ecm`.`sustainability`.`srf_production` ALTER COLUMN `unit_price_per_ton` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `diversion_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Record ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `audit_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `certification_standard` SET TAGS ('dbx_value_regex' = 'iso_14001|leed|true_certification|zero_waste|none');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `contamination_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contamination Rate Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `diversion_pathway` SET TAGS ('dbx_business_glossary_term' = 'Diversion Pathway');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `diversion_pathway` SET TAGS ('dbx_value_regex' = 'recycling|composting|rng_conversion|srf_production|wte|beneficial_reuse');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `diversion_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `ghg_emissions_avoided_co2e_tons` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Avoided (CO2e Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `processing_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Processing Cost (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `processing_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|audited|archived');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `revenue_generated_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `revenue_generated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `service_line` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|special_waste|hazardous');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `total_waste_received_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Received (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `waste_diverted_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Diverted (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`diversion_record` ALTER COLUMN `waste_to_landfill_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste to Landfill (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Registry Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_project_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `additionality_verified` SET TAGS ('dbx_business_glossary_term' = 'Additionality Verified Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `carbon_offset_status` SET TAGS ('dbx_value_regex' = 'Active|Retired|Cancelled|Expired');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `co_benefits` SET TAGS ('dbx_business_glossary_term' = 'Co-Benefits');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Carbon Credit Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'Avoidance|Removal|Reduction');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Permanence Risk Rating');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_country_code` SET TAGS ('dbx_business_glossary_term' = 'Project Country Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_region` SET TAGS ('dbx_business_glossary_term' = 'Project Region');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_price_per_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Per Metric Ton Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `purchase_price_per_tco2e` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Quantity in Metric Tons Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `retirement_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Retirement Serial Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goals (SDG) Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Amount');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `verification_standard` SET TAGS ('dbx_business_glossary_term' = 'Verification Standard');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_offset` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Credit Vintage Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Transaction ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `carbon_registry_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `additionality_verified` SET TAGS ('dbx_business_glossary_term' = 'Additionality Verified');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Permanence Risk Rating');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|not_applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Quantity Tons Carbon Dioxide Equivalent (tCO2e)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `registry_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Confirmation Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `scope_allocation` SET TAGS ('dbx_business_glossary_term' = 'Scope Allocation');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `scope_allocation` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|voluntary');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^OT-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed|under_review');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|transfer|retirement|cancellation|issuance|reversal');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_required');
ALTER TABLE `waste_management_ecm`.`sustainability`.`offset_transaction` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `renewable_energy_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `carbon_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Registry Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'Self-Generated|Purchased|Transferred In|Allocated|Other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'Active|Retired|Transferred|Expired|Cancelled|Pending');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'REC|RIN|LCFS|Carbon Offset|Green-e|Other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `co2e_offset_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Offset Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `compliance_program` SET TAGS ('dbx_value_regex' = 'EPA RFS|California LCFS|State RPS|Voluntary|None|Other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `eia_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Plant Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `eligibility_flags` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flags');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `facility_state` SET TAGS ('dbx_business_glossary_term' = 'Facility State');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `generation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `generation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Market Value United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `quantity_gge` SET TAGS ('dbx_business_glossary_term' = 'Quantity Gasoline Gallon Equivalent (GGE)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `quantity_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Quantity Million British Thermal Units (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Quantity Megawatt-Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'Compliance|Voluntary|ESG Reporting|Customer Claim|Internal Target|Other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `transfer_recipient` SET TAGS ('dbx_business_glossary_term' = 'Transfer Recipient');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `transfer_recipient` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `vintage_month` SET TAGS ('dbx_business_glossary_term' = 'Vintage Month');
ALTER TABLE `waste_management_ecm`.`sustainability`.`renewable_energy_credit` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Reduction Target ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `achievement_date` SET TAGS ('dbx_business_glossary_term' = 'Achievement Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `business_unit_scope` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `exclusions_notes` SET TAGS ('dbx_business_glossary_term' = 'Exclusions Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'External Framework Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `interim_milestone_value` SET TAGS ('dbx_business_glossary_term' = 'Interim Milestone Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `interim_milestone_year` SET TAGS ('dbx_business_glossary_term' = 'Interim Milestone Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `linked_initiative_ids` SET TAGS ('dbx_business_glossary_term' = 'Linked Initiative IDs');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Methodology Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `public_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reduction Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `sbti_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Science Based Targets initiative (SBTi) Validated Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_category` SET TAGS ('dbx_business_glossary_term' = 'Target Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_category` SET TAGS ('dbx_value_regex' = 'ghg_reduction|diversion_rate|renewable_energy|fleet_electrification|waste_to_energy|circular_economy');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'absolute|intensity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `target_year` SET TAGS ('dbx_business_glossary_term' = 'Target Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|internal_review|third_party_verified|audited');
ALTER TABLE `waste_management_ecm`.`sustainability`.`reduction_target` ALTER COLUMN `verifier_organization` SET TAGS ('dbx_business_glossary_term' = 'Verifier Organization');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Target Progress ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Analyst Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Performance Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `baseline_comparison_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Comparison Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'Progress Commentary');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `contributing_initiative_ids` SET TAGS ('dbx_business_glossary_term' = 'Contributing Initiative IDs');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `cumulative_progress_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Progress to Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `emission_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `ghg_scope` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `ghg_scope` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3|scope_1_2|scope_1_2_3|not_applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `is_restated` SET TAGS ('dbx_business_glossary_term' = 'Is Restated Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `previous_reported_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Reported Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `published_in_report` SET TAGS ('dbx_business_glossary_term' = 'Published in Report Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `reporting_scope` SET TAGS ('dbx_business_glossary_term' = 'Reporting Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `target_achievement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Achievement Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `variance_from_trajectory` SET TAGS ('dbx_business_glossary_term' = 'Variance from Planned Trajectory');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|internally_verified|third_party_verified|audited|pending_verification');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`target_progress` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Disclosure Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Inventory Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Approval Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assurance Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'External Assurance Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'none|limited|reasonable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `assurance_provider` SET TAGS ('dbx_business_glossary_term' = 'External Assurance Provider Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `board_diversity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Board of Directors Diversity Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `carbon_offset_credits_purchased_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Credits Purchased in Metric Tons CO2e');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `community_investment_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Community Investment Amount in United States Dollars (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `community_investment_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Approver Full Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Document Reference');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Reference Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `employee_safety_incident_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Safety Total Recordable Incident Rate (TRIR)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `esg_score` SET TAGS ('dbx_business_glossary_term' = 'Overall ESG Performance Score');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `framework_type` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Framework Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `framework_type` SET TAGS ('dbx_value_regex' = 'GRI|TCFD|CDP|SASB|SEC_CLIMATE|ISSB');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `hazardous_waste_managed_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Managed in Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `lfg_to_rng_conversion_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Landfill Gas (LFG) to Renewable Natural Gas (RNG) Conversion Volume in Million British Thermal Units (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `material_topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Material ESG Topics Covered');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes and Commentary');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `publication_url` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Publication Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `renewable_energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Consumption in Megawatt Hours (MWh)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage of Total Energy Consumption');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Indicator Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope_1_emissions_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Greenhouse Gas (GHG) Emissions in Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope_2_emissions_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Greenhouse Gas (GHG) Emissions in Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `scope_3_emissions_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Greenhouse Gas (GHG) Emissions in Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Submission Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Submission Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|accepted|published|rejected');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `total_waste_diverted_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Diverted from Landfill in Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `waste_diversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Waste Diversion Rate Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`esg_disclosure` ALTER COLUMN `water_consumption_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Water Consumption in Cubic Meters');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `superseded_by_factor_emission_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Emission Factor ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `biogenic_flag` SET TAGS ('dbx_business_glossary_term' = 'Biogenic Carbon Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `emission_factor_status` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `emission_factor_status` SET TAGS ('dbx_value_regex' = 'active|superseded|deprecated|draft|under_review');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `emission_scope` SET TAGS ('dbx_business_glossary_term' = 'GHG Protocol Emission Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `emission_scope` SET TAGS ('dbx_value_regex' = 'scope_1|scope_2|scope_3');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry or End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_name` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Source Authority');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_source_document` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Document URL');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Unit of Measure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `factor_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Value');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel or Activity Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `ghg_type` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `ghg_type` SET TAGS ('dbx_value_regex' = 'CO2|CH4|N2O|HFC|PFC|SF6');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `gwp_basis` SET TAGS ('dbx_business_glossary_term' = 'Global Warming Potential (GWP) Basis');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `gwp_basis` SET TAGS ('dbx_value_regex' = 'AR4|AR5|AR6|SAR');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `gwp_timeframe_years` SET TAGS ('dbx_business_glossary_term' = 'GWP Timeframe in Years');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `source_category` SET TAGS ('dbx_value_regex' = 'mobile_combustion|stationary_combustion|fugitive|process|waste_disposal|purchased_electricity');
ALTER TABLE `waste_management_ecm`.`sustainability`.`emission_factor` ALTER COLUMN `uncertainty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `srf_production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Srf Production Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `annual_diversion_target_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Diversion Target (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `certification_standards` SET TAGS ('dbx_business_glossary_term' = 'Certification Standards');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `circular_economy_principle_alignment` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Principle Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `cumulative_diversion_actual_tons` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Diversion Actual (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `esg_reporting_framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'ESG (Environmental Social Governance) Reporting Framework Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `ghg_emissions_avoided_co2e_tons_annual` SET TAGS ('dbx_business_glossary_term' = 'GHG (Greenhouse Gas) Emissions Avoided CO2e (Carbon Dioxide Equivalent) Tons Annual');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `participating_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Participating Customer Segments');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `participation_eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Participation Eligibility Criteria');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `partnership_model` SET TAGS ('dbx_business_glossary_term' = 'Partnership Model');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `partnership_model` SET TAGS ('dbx_value_regex' = 'wholly_owned|joint_venture|third_party_contract|municipal_partnership|oem_stewardship');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'planning|active|suspended|completed|cancelled');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'material_takeback|industrial_symbiosis|organics_composting|ewaste_recycling|construction_material_reuse|product_stewardship');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website URL (Uniform Resource Locator)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `regulatory_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `revenue_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Model');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `revenue_model` SET TAGS ('dbx_value_regex' = 'commodity_sales|tipping_fees|service_fees|grant_funded|cost_recovery|hybrid');
ALTER TABLE `waste_management_ecm`.`sustainability`.`circular_economy_program` ALTER COLUMN `target_material_streams` SET TAGS ('dbx_business_glossary_term' = 'Target Material Streams');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `sustainability_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `primary_sustainability_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Account Manager Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `primary_sustainability_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `primary_sustainability_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrolled_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Entity Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrolled_entity_type` SET TAGS ('dbx_value_regex' = 'residential_customer|commercial_account|municipal_client|mrf_facility|landfill_facility|wte_facility');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'customer_portal|sales_representative|call_center|municipal_partnership|facility_direct|marketing_campaign');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source System');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|waste_logics|amcs_platform|enviance_ehs|manual_entry');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|completed|cancelled');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `estimated_annual_co2e_reduction_tons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Carbon Dioxide Equivalent (CO2e) Reduction (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `estimated_annual_diversion_volume_tons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Diversion Volume (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Program Exit Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_value_regex' = 'program_completion|voluntary_withdrawal|non_compliance|service_termination|facility_closure|contract_expiration');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rate_discount|rebate|carbon_credit|recognition|none');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `incentive_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Incentive Value (United States Dollars)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `incentive_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `material_streams_included` SET TAGS ('dbx_business_glossary_term' = 'Material Streams Included');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `participation_tier` SET TAGS ('dbx_business_glossary_term' = 'Participation Tier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `participation_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `program_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Program Exit Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`sustainability_program_enrollment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|requires_review');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fleet_fuel_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Fuel Consumption ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fueling Location ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Card Holder Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity Score');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `co2e_emissions_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions (Metric Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `consumption_record_number` SET TAGS ('dbx_business_glossary_term' = 'Consumption Record Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|incomplete|anomaly|pending_review');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'geotab|amcs|manual_entry|fuel_card|other');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `distance_traveled_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance Traveled (Miles)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `emission_factor_kg_co2e_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor (kg CO2e per Unit)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `energy_quantity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Quantity (kWh)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `energy_quantity_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Energy Quantity (MMBtu)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost (USD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_efficiency_mpg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency Miles Per Gallon (MPG)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_efficiency_mpge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Efficiency Miles Per Gallon Equivalent (MPGe)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_quantity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity (Gallons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fuel_quantity_gge` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity Gasoline Gallon Equivalent (GGE)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fueling_location_city` SET TAGS ('dbx_business_glossary_term' = 'Fueling Location City');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fueling_location_country` SET TAGS ('dbx_business_glossary_term' = 'Fueling Location Country');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fueling_location_country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `fueling_location_state` SET TAGS ('dbx_business_glossary_term' = 'Fueling Location State');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `ghg_inventory_category` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Inventory Category');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `ghg_inventory_category` SET TAGS ('dbx_value_regex' = 'scope_1_mobile_combustion|scope_2_purchased_electricity|scope_3_upstream_fuel');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `idle_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Time (Hours)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `lcfs_credits_generated` SET TAGS ('dbx_business_glossary_term' = 'Low Carbon Fuel Standard (LCFS) Credits Generated');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `renewable_fuel_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `rin_credits_generated` SET TAGS ('dbx_business_glossary_term' = 'Renewable Identification Number (RIN) Credits Generated');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `waste_management_ecm`.`sustainability`.`fleet_fuel_consumption` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `tracked_site_id` SET TAGS ('dbx_business_glossary_term' = 'Tracked Site ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `annual_waste_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Waste Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `carbon_offset_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `certification_standards` SET TAGS ('dbx_business_glossary_term' = 'Certification Standards');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `daily_waste_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Daily Waste Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1_measured|tier_2_calculated|tier_3_estimated|tier_4_proxy');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `emission_source_categories` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Categories');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `ghg_scope_1_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope 1 Source Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `ghg_scope_2_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Scope 2 Source Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|closed|decommissioned|suspended');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `renewable_energy_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Generation Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `reporting_boundary_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Boundary Inclusion Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `site_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `site_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `state_permit_number` SET TAGS ('dbx_business_glossary_term' = 'State Permit Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`tracked_site` ALTER COLUMN `sustainability_program_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Program Enrollment Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `ghg_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Inventory ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `base_year` SET TAGS ('dbx_business_glossary_term' = 'Base Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `base_year_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Base Year Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `biogenic_co2_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Biogenic Carbon Dioxide (CO2) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `data_quality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `data_quality_assessment` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `emissions_intensity_ratio` SET TAGS ('dbx_business_glossary_term' = 'Emissions Intensity Ratio');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `epa_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Submission Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `esg_framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Framework Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `intensity_metric` SET TAGS ('dbx_business_glossary_term' = 'Intensity Metric');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `inventory_number` SET TAGS ('dbx_business_glossary_term' = 'Inventory Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|submitted|published');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `organizational_boundary_approach` SET TAGS ('dbx_business_glossary_term' = 'Organizational Boundary Approach');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `organizational_boundary_approach` SET TAGS ('dbx_value_regex' = 'operational_control|financial_control|equity_share');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_1_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 1 Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_2_location_based_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Location-Based Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_2_market_based_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 2 Market-Based Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_12_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 12 End-of-Life Treatment of Sold Products CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_1_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 1 Purchased Goods and Services CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_2_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 2 Capital Goods CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_3_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 3 Fuel and Energy Related Activities CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_4_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 4 Upstream Transportation and Distribution CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_5_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 5 Waste Generated in Operations CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_6_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 6 Business Travel CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_7_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 7 Employee Commuting CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_category_9_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Category 9 Downstream Transportation and Distribution CO2e Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `scope_3_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Scope 3 Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `total_co2e_metric_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Dioxide Equivalent (CO2e) Metric Tons');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Verification Statement Reference');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|limited_assurance|reasonable_assurance');
ALTER TABLE `waste_management_ecm`.`sustainability`.`ghg_inventory` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Submission Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'limited|reasonable|none');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `baseline_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Period Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `calendar_quarter` SET TAGS ('dbx_business_glossary_term' = 'Calendar Quarter');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `cdp_reporting_applicable` SET TAGS ('dbx_business_glossary_term' = 'Carbon Disclosure Project (CDP) Reporting Applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `data_freeze_date` SET TAGS ('dbx_business_glossary_term' = 'Data Freeze Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `epa_ghg_reporting_applicable` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Greenhouse Gas (GHG) Reporting Applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `gri_reporting_applicable` SET TAGS ('dbx_business_glossary_term' = 'Global Reporting Initiative (GRI) Reporting Applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'open|closed|verified|draft|archived');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|semi-annual|custom');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `restatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `sasb_reporting_applicable` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Accounting Standards Board (SASB) Reporting Applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `submission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `tcfd_reporting_applicable` SET TAGS ('dbx_business_glossary_term' = 'Task Force on Climate-related Financial Disclosures (TCFD) Reporting Applicable');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `verification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `verification_provider` SET TAGS ('dbx_business_glossary_term' = 'Verification Provider');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`report_period` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_required');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `carbon_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Registry ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `parent_carbon_registry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `account_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Account Activation Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `account_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `additionality_requirement` SET TAGS ('dbx_business_glossary_term' = 'Additionality Requirement');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `co_benefits_tracked_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Benefits Tracked Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `credit_serial_number_format` SET TAGS ('dbx_business_glossary_term' = 'Credit Serial Number Format');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `double_counting_prevention_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Double Counting Prevention Mechanism');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `esg_framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Framework Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `permanence_requirement` SET TAGS ('dbx_business_glossary_term' = 'Permanence Requirement');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `public_registry_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Registry Access Flag');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Account Holder Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_account_holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_business_glossary_term' = 'Registry Account Number');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_code` SET TAGS ('dbx_business_glossary_term' = 'Registry Code');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_established_date` SET TAGS ('dbx_business_glossary_term' = 'Registry Established Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Registry Fee Structure');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_fee_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Registry Jurisdiction');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Registry Name');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_status` SET TAGS ('dbx_business_glossary_term' = 'Registry Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|merged|retired');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_type` SET TAGS ('dbx_business_glossary_term' = 'Registry Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_type` SET TAGS ('dbx_value_regex' = 'voluntary|compliance|hybrid');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `registry_website_url` SET TAGS ('dbx_business_glossary_term' = 'Registry Website Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `retirement_process_description` SET TAGS ('dbx_business_glossary_term' = 'Retirement Process Description');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goals (SDG) Alignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `supported_methodologies` SET TAGS ('dbx_business_glossary_term' = 'Supported Methodologies');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `supported_project_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Project Types');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `transparency_level` SET TAGS ('dbx_business_glossary_term' = 'Transparency Level');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `transparency_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `verification_standard` SET TAGS ('dbx_business_glossary_term' = 'Verification Standard');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `vintage_year_range_end` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year Range End');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_registry` ALTER COLUMN `vintage_year_range_start` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year Range Start');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` SET TAGS ('dbx_association_edges' = 'sustainability.carbon_initiative,safety.jha');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `initiative_safety_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Safety Analysis ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Safety Analysis - Carbon Initiative Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Safety Analysis - Jha Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `crew_size_assigned` SET TAGS ('dbx_business_glossary_term' = 'Crew Size Assigned');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `initiative_specific_controls` SET TAGS ('dbx_business_glossary_term' = 'Initiative Specific Controls');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `jha_applicability_phase` SET TAGS ('dbx_business_glossary_term' = 'JHA Applicability Phase');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `jha_review_status` SET TAGS ('dbx_business_glossary_term' = 'JHA Review Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `task_frequency_during_initiative` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency During Initiative');
ALTER TABLE `waste_management_ecm`.`sustainability`.`initiative_safety_analysis` ALTER COLUMN `training_completion_required_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Required Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` SET TAGS ('dbx_association_edges' = 'sustainability.circular_economy_program,safety.jha');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `program_task_safety_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Program Task Safety Requirement ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Task Safety Requirement - Circular Economy Program Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `jha_id` SET TAGS ('dbx_business_glossary_term' = 'Program Task Safety Requirement - Jha Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `applicability_start_date` SET TAGS ('dbx_business_glossary_term' = 'JHA Applicability Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `crew_size_required` SET TAGS ('dbx_business_glossary_term' = 'Crew Size Required');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last JHA Review Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `program_phase_applicability` SET TAGS ('dbx_business_glossary_term' = 'Program Phase Applicability');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `program_specific_ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Program Specific PPE Requirements');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `task_frequency_in_program` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency in Program');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_task_safety_requirement` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` SET TAGS ('dbx_subdomain' = 'resource_recovery');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` SET TAGS ('dbx_association_edges' = 'sustainability.circular_economy_program,workforce.employee');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment - Circular Economy Program Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Assignment - Employee Id');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Allocation Percentage');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certification');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `performance_target` SET TAGS ('dbx_business_glossary_term' = 'Performance Target');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role Type');
ALTER TABLE `waste_management_ecm`.`sustainability`.`program_assignment` ALTER COLUMN `territory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` SET TAGS ('dbx_subdomain' = 'emission_management');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ALTER COLUMN `carbon_project_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Project Identifier');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ALTER COLUMN `parent_carbon_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ALTER COLUMN `project_investment_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`sustainability`.`carbon_project` ALTER COLUMN `project_manager_email` SET TAGS ('dbx_pii_email' = 'true');
