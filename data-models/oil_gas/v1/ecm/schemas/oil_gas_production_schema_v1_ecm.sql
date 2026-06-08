-- Schema for Domain: production | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`production` COMMENT 'Manages real-time and historical production data including daily production allocation, well test analysis, BOPD/MCFD/MMCFD reporting, GOR/WOR tracking, artificial lift optimization, decline curve analysis, and facility performance. Serves as the SSOT for production volumes and field performance via OSIsoft PI System, Avocet Production Operations, and SCADA/DCS integration. Supports SEC reserves reporting and regulatory production filings to BSEE and state agencies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`production_well` (
    `production_well_id` BIGINT COMMENT 'Unique system identifier for the production well record. Primary key for the production well entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wells are fundamental cost objects in upstream operations. Every well accumulates LOE and capital costs tracked by cost center for financial reporting, JIB preparation, budget variance analysis, and S',
    `drilling_well_id` BIGINT COMMENT 'FK to drilling.drilling_well.drilling_well_id — MUST-HAVE: Enables tracing any producing well back to its drilling record for well integrity, completion design, and D&C cost analysis. Without this FK, production engineers cannot link production per',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Wells require groundwater monitoring (EPA UIC Class II compliance), air emissions monitoring (fugitive emissions), and soil sampling (spill detection). Critical for UIC permit compliance, mechanical i',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Wells transition from exploration to production phase. This link is essential for well lifecycle tracking, reserves booking (SEC/SPE requirements), regulatory reporting, and post-drill performance ana',
    `field_id` BIGINT COMMENT 'Foreign key reference to the oil or gas field where this well is located. Links to the field master data for geographic and operational grouping.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Wells are operated under Joint Operating Agreements; essential for cost allocation, AFE tracking, partner billing, and working interest calculations. Core operational relationship in oil-and-gas ventu',
    `norm_record_id` BIGINT COMMENT 'Foreign key linking to hse.norm_record. Business justification: Wells accumulate NORM in tubing, wellhead equipment, flowlines, and produced water systems. Critical for well-specific NORM survey tracking, decontamination planning, worker exposure monitoring, and d',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Wells require drilling permits, operating permits, and UIC permits for injection operations. Regulatory compliance tracking requires linking wells to their authorizing permits. Well has uic_permit_num',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Well workovers, completions, recompletions, and interventions require permits to work for isolation, gas testing, and hazard control. Critical for well intervention authorization workflow and SIMOPS m',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Wells are classified by primary product (oil well, gas well, condensate well) for regulatory reporting, reserves classification (proved developed producing), and economic limit calculations. Role-pref',
    `production_facility_id` BIGINT COMMENT 'Foreign key reference to the production facility or battery where this wells production is gathered and processed.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Wells in Production Sharing Contract regimes must link to PSA for cost recovery calculations, profit oil splits, and government entitlement reporting. Fundamental for PSC fiscal regime compliance.',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir or producing formation that this well targets. Links to reservoir master data for geological and engineering analysis.',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the operating company responsible for day-to-day operations of this well. May differ from working interest owners.',
    `well_asset_id` BIGINT COMMENT 'FK to asset.well_asset.well_asset_id — MUST-HAVE: Enables linking production wells to their asset management records for maintenance scheduling, integrity management, and P&A planning. Without this FK, asset managers cannot identify which ',
    `abandonment_date` DATE COMMENT 'Date when the well was permanently plugged and abandoned per regulatory requirements. Null for active wells.',
    `api_number` STRING COMMENT 'Unique 10-14 digit API well number assigned by regulatory authority. Standard format: state code (2 digits), county code (3 digits), unique well identifier (5 digits), and optional sidetrack code (2 digits). Serves as the regulatory identifier for BSEE and state agency filings.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `artificial_lift_type` STRING COMMENT 'Type of artificial lift system installed on the well: none (flowing naturally), rod_pump (sucker rod pump), ESP (electric submersible pump), gas_lift (gas injection lift), plunger_lift (plunger system), PCP (progressive cavity pump), or hydraulic_pump (hydraulic jet pump). Critical for production optimization and OPEX forecasting. [ENUM-REF-CANDIDATE: none|rod_pump|esp|gas_lift|plunger_lift|pcp|hydraulic_pump — 7 candidates stripped; promote to reference product]',
    `bottom_hole_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the wellbore bottom hole location in decimal degrees (WGS84 datum). Critical for horizontal and directional wells where bottom hole differs significantly from surface location.',
    `bottom_hole_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the wellbore bottom hole location in decimal degrees (WGS84 datum). Critical for horizontal and directional wells where bottom hole differs significantly from surface location.',
    `casing_size_inches` DECIMAL(18,2) COMMENT 'Outer diameter of the production casing string in inches (e.g., 4.5, 5.5, 7.0). Defines wellbore size and completion options.',
    `completion_date` DATE COMMENT 'Date when well completion operations were finished and the well was ready for production or injection. Used for reserves booking and depreciation calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this well record was first created in the system. Used for data lineage and audit trail.',
    `cumulative_gas_mcf` DECIMAL(18,2) COMMENT 'Total cumulative gas production from first production date to current date, measured in thousand cubic feet. Used for decline curve analysis and EUR comparison.',
    `cumulative_oil_bbls` DECIMAL(18,2) COMMENT 'Total cumulative oil production from first production date to current date, measured in barrels. Used for decline curve analysis and EUR comparison.',
    `current_production_bopd` DECIMAL(18,2) COMMENT 'Most recent daily oil production rate in barrels of oil per day, typically from the last well test or allocation. Used for real-time production monitoring and forecasting.',
    `current_production_mcfd` DECIMAL(18,2) COMMENT 'Most recent daily gas production rate in thousand cubic feet per day, typically from the last well test or allocation. Used for real-time production monitoring and forecasting.',
    `first_production_date` DATE COMMENT 'Date when the well first produced hydrocarbons to sales. Critical for decline curve analysis and EUR estimation.',
    `gor_scf_bbl` DECIMAL(18,2) COMMENT 'Current gas-oil ratio expressed as standard cubic feet of gas produced per barrel of oil. Key indicator of reservoir pressure and drive mechanism. Rising GOR may indicate gas breakthrough or pressure depletion.',
    `initial_production_bopd` DECIMAL(18,2) COMMENT 'Initial production rate of oil measured during the first 24-hour test period after completion, expressed in barrels of oil per day. Key metric for well performance evaluation and EUR estimation.',
    `initial_production_mcfd` DECIMAL(18,2) COMMENT 'Initial production rate of natural gas measured during the first 24-hour test period after completion, expressed in thousand cubic feet per day. Key metric for gas well performance evaluation.',
    `injection_rate_bpd` DECIMAL(18,2) COMMENT 'Current daily injection rate for water or liquid injection wells, measured in barrels per day. Used for reservoir pressure maintenance tracking and regulatory compliance. Null for production wells.',
    `injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Current daily injection rate for gas injection wells, measured in thousand cubic feet per day. Used for gas cycling and pressure maintenance tracking. Null for production wells.',
    `injection_type` STRING COMMENT 'Type of fluid being injected for wells classified as injectors: water (waterflood), gas (gas injection or cycling), CO2 (carbon dioxide EOR), steam (thermal EOR/SAGD), polymer (chemical EOR), surfactant (chemical EOR), or not_applicable (for production wells). Null for non-injection wells. [ENUM-REF-CANDIDATE: water|gas|co2|steam|polymer|surfactant|not_applicable — 7 candidates stripped; promote to reference product]',
    `lateral_length_ft` DECIMAL(18,2) COMMENT 'Length of the horizontal or lateral section of the wellbore in feet. Applicable to horizontal and extended-reach wells. Null for vertical wells.',
    `lease_name` STRING COMMENT 'Name of the oil and gas lease or unit where the well is located. Links well to land and lease management system.',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Total measured depth of the wellbore from surface to total depth, measured along the actual wellbore path in feet. Differs from TVD for deviated wells.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Companys net revenue interest percentage in this well after deducting royalties and overriding royalty interests from working interest. Represents actual share of production revenue.',
    `perforation_bottom_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth to the bottom of the perforated interval where hydrocarbons enter the wellbore. Used for production allocation and reservoir engineering.',
    `perforation_top_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth to the top of the perforated interval where hydrocarbons enter the wellbore. Used for production allocation and reservoir engineering.',
    `permitted_injection_rate_bpd` DECIMAL(18,2) COMMENT 'Maximum allowable injection rate specified in the UIC permit, measured in barrels per day. Regulatory limit that must not be exceeded. Null for production wells.',
    `regulatory_district` STRING COMMENT 'State or federal regulatory district code where the well is located (e.g., Texas Railroad Commission District 8, BSEE Gulf of Mexico Region). Used for regulatory filing and compliance tracking.',
    `spud_date` DATE COMMENT 'Date when drilling operations commenced (when the drill bit first penetrated the surface). Key milestone for AFE tracking and regulatory reporting.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the wellhead surface location in decimal degrees (WGS84 datum). Used for GIS mapping and regulatory filings.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the wellhead surface location in decimal degrees (WGS84 datum). Used for GIS mapping and regulatory filings.',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'True vertical depth from surface to the deepest point of the wellbore, measured perpendicular to the surface in feet. Used for subsurface mapping and pressure calculations.',
    `tubing_size_inches` DECIMAL(18,2) COMMENT 'Outer diameter of the production tubing string in inches (e.g., 2.375, 2.875, 3.5). Affects flow capacity and artificial lift design.',
    `uic_permit_number` STRING COMMENT 'EPA Underground Injection Control permit number for injection and disposal wells. Required for Class II injection wells under EPA UIC program. Null for production wells.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this well record was last modified in the system. Used for change tracking and data quality monitoring.',
    `uwi` STRING COMMENT 'Unique Well Identifier used for cross-system integration and data exchange. May follow provincial or regional standards (e.g., Canadian UWI format).',
    `water_cut_percent` DECIMAL(18,2) COMMENT 'Percentage of produced fluid that is water, calculated as (water production / total fluid production) * 100. Alternative representation of water production relative to total liquids.',
    `well_name` STRING COMMENT 'Common business name or designation for the well, typically including lease name and well number (e.g., Smith Unit 1H, Eagle Ford A-23).',
    `well_status` STRING COMMENT 'Current operational status of the well: producing (actively producing hydrocarbons), shut_in (temporarily not producing but capable), temporarily_abandoned (TA - inactive with intent to return), plugged_and_abandoned (P&A - permanently abandoned), drilling (well being drilled), completing (completion operations underway), testing (well test in progress), PDNP (Proved Developed Non-Producing - completed but not yet on production), or suspended (operations halted pending decision). [ENUM-REF-CANDIDATE: producing|shut_in|temporarily_abandoned|plugged_and_abandoned|drilling|completing|testing|pdnp|suspended — 9 candidates stripped; promote to reference product]',
    `wellbore_type` STRING COMMENT 'Classification of the well based on its primary operational function: oil producer (primarily produces crude oil), gas producer (primarily produces natural gas), water_injector (injects water for pressure maintenance or EOR), gas_injector (injects gas for pressure maintenance or EOR), disposal (disposes of produced water or waste fluids), observation (monitors reservoir conditions), or dual_producer (produces both oil and gas in significant quantities). [ENUM-REF-CANDIDATE: oil_producer|gas_producer|water_injector|gas_injector|disposal|observation|dual_producer — 7 candidates stripped; promote to reference product]',
    `wor_ratio` DECIMAL(18,2) COMMENT 'Current water-oil ratio expressed as barrels of water produced per barrel of oil. Key indicator of water breakthrough and reservoir sweep efficiency. Rising WOR indicates increasing water production.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Companys working interest ownership percentage in this well, representing the share of capital costs and operating expenses. Used for production allocation and joint interest billing.',
    CONSTRAINT pk_production_well PRIMARY KEY(`production_well_id`)
) COMMENT 'Master record for every well in the production domain, including producing, injection, observation, and disposal wells. Captures well identity, API number, wellbore type (oil producer, gas producer, water injector, gas injector, disposal, observation), current status (producing, shut-in, temporarily abandoned, P&A, PDNP), spud date, completion date, artificial lift type, field/reservoir assignment, surface and bottom-hole coordinates, measured depth (MD), true vertical depth (TVD), injection parameters (injection type, UIC permit number, permitted rate) where applicable, and regulatory identifiers for BSEE and state agency filings. Serves as the SSOT for well identity within the production domain and is the primary anchor entity for all production volumes, injection volumes, and well performance data.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`production_facility` (
    `production_facility_id` BIGINT COMMENT 'Unique identifier for the production facility. Primary key for the production facility master record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility asset record in the CMMS and asset management system. Links to maintenance history, work orders, and asset lifecycle data.',
    `block_id` BIGINT COMMENT 'FK to exploration.block',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Facilities require ISO certifications, SEMS certifications (offshore), and operator qualification certifications. Compliance management and audit workflows require linking facilities to their active c',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Offshore platforms and onshore facilities deliver production to terminals for storage, blending, and onward transportation. Essential for production scheduling, pipeline/tanker nominations, and logist',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Facilities require air quality monitoring (Title V, NESHAP), wastewater monitoring (NPDES), stormwater monitoring (MSGP), and soil/groundwater monitoring (SPCC, UST). Essential for permit compliance v',
    `facility_id` BIGINT COMMENT 'FK to asset.facility.facility_id — MUST-HAVE: Enables linking production facilities to their asset management records for work orders, inspections, and turnaround planning. Without this FK, maintenance planners cannot schedule work aga',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field that this facility serves. Links facility production to reservoir performance and reserves reporting.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Facility construction and major modifications are authorized through AFEs for capital project management, cost tracking, asset capitalization, and project closeout. Essential for tracking facility cap',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Facilities are operated under JOAs; critical for JIB billing, overhead allocation, partner cost sharing, and capital expenditure tracking. Essential for multi-partner operations.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Facilities require operating permits, environmental permits, air permits for legal operation. Compliance tracking and permit renewal workflows require linking facilities to their authorizing permits. ',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Facilities in PSC areas must link to PSA for cost recovery eligibility, depreciation calculations, and production sharing allocations. Required for PSC economic modeling.',
    `scada_system_id` BIGINT COMMENT 'Unique identifier for the facility within the SCADA and DCS systems. Used for real-time data integration with OSIsoft PI System.',
    `vendor_id` BIGINT COMMENT 'Reference to the operating company responsible for day-to-day operations of the facility. Determines operational authority and HSE accountability.',
    `address` STRING COMMENT 'Physical street address or location description of the facility. Used for emergency response, logistics, and regulatory correspondence.',
    `commissioning_date` DATE COMMENT 'Date when the facility was officially commissioned and began commercial operations. Used for depreciation calculations and asset lifecycle management.',
    `cost_center` STRING COMMENT 'Financial cost center code for OPEX and CAPEX allocation. Used for lease operating expense tracking and AFE management.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the facility is located. Determines regulatory jurisdiction, tax regime, and reporting requirements. [ENUM-REF-CANDIDATE: USA|CAN|MEX|BRA|GBR|NOR|SAU|ARE|QAT|KWT|IRQ|NGA|AGO|AUS|CHN|RUS|KAZ — 17 candidates stripped; promote to reference product]',
    `county_parish` STRING COMMENT 'County or parish jurisdiction where the facility is located. Required for local regulatory reporting and property tax assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system. Used for data lineage and audit trail.',
    `current_throughput_bopd` DECIMAL(18,2) COMMENT 'Most recent 24-hour average oil throughput in barrels of oil per day. Updated daily from PI System historian data and used for production allocation and performance monitoring.',
    `current_throughput_mmcfd` DECIMAL(18,2) COMMENT 'Most recent 24-hour average gas throughput in million cubic feet per day. Updated daily from PI System historian data and used for gas balancing and sales allocation.',
    `decommissioning_date` DATE COMMENT 'Planned or actual date when the facility was or will be decommissioned and removed from service. Used for asset retirement obligation calculations.',
    `design_capacity_bopd` DECIMAL(18,2) COMMENT 'Maximum rated oil processing capacity of the facility in barrels of oil per day as specified in the engineering design and regulatory permits. Used for capacity utilization analysis and bottleneck identification.',
    `design_capacity_bwpd` DECIMAL(18,2) COMMENT 'Maximum rated water handling capacity of the facility in barrels of water per day. Essential for produced water management and environmental compliance planning.',
    `design_capacity_mmcfd` DECIMAL(18,2) COMMENT 'Maximum rated natural gas processing capacity of the facility in million cubic feet per day as specified in the engineering design and regulatory permits. Critical for gas balancing and sales commitments.',
    `emergency_contact_phone` STRING COMMENT 'Primary emergency contact telephone number for the facility. Required for HSE incident response and regulatory compliance.',
    `facility_code` STRING COMMENT 'Unique alphanumeric business identifier for the facility used across operational systems including SCADA, PI System, and ERP. Serves as the external reference code for production reporting and regulatory filings.',
    `facility_name` STRING COMMENT 'Official business name of the production facility as registered with regulatory authorities and used in operational reporting.',
    `facility_type` STRING COMMENT 'Classification of the production facility based on its primary operational function within the production value chain. Determines applicable regulatory requirements and operational standards. [ENUM-REF-CANDIDATE: wellpad|gathering_station|gas_processing_plant|fpso|offshore_platform|compressor_station|metering_point|separation_facility|injection_facility — 9 candidates stripped; promote to reference product]',
    `flare_capacity_mmcfd` DECIMAL(18,2) COMMENT 'Maximum rated flare system capacity in million cubic feet per day. Critical for safety system design and environmental emissions reporting.',
    `h2s_present_flag` BOOLEAN COMMENT 'Indicates whether hydrogen sulfide gas is present in the production stream. Determines safety equipment requirements and HSE protocols.',
    `installation_type` STRING COMMENT 'Physical installation classification of the facility. Determines applicable safety standards, regulatory jurisdiction, and operational procedures.. Valid values are `onshore|offshore_fixed|offshore_floating|subsea`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal safety inspection. Tracked for BSEE compliance and HSE audit requirements.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees. Used for GIS mapping, emergency response planning, and regulatory jurisdiction determination.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees. Used for GIS mapping, emergency response planning, and regulatory jurisdiction determination.',
    `manager_name` STRING COMMENT 'Name of the facility manager or superintendent responsible for operations. Business reference for operational accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last modified. Used for data lineage and change tracking.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory regulatory or internal safety inspection. Used for compliance planning and maintenance scheduling.',
    `norm_present_flag` BOOLEAN COMMENT 'Indicates whether naturally occurring radioactive materials are present in production fluids or scale. Determines waste handling and disposal requirements.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the facility indicating its availability for production operations. Drives production allocation logic and regulatory reporting requirements.. Valid values are `operating|standby|maintenance|suspended|decommissioned|under_construction`',
    `ownership_interest_pct` DECIMAL(18,2) COMMENT 'Company working interest percentage in the facility. Used for production allocation and joint venture accounting.',
    `pi_system_tag_prefix` STRING COMMENT 'Standard tag prefix used for all PI System data points associated with this facility. Enables automated data historian queries and production reporting.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility location. Used for logistics planning and regulatory reporting.',
    `processing_train_count` STRING COMMENT 'Number of parallel processing trains or production units within the facility. Used for capacity planning and maintenance scheduling optimization.',
    `separator_count` STRING COMMENT 'Total number of oil-gas-water separators installed at the facility. Key equipment count for production allocation and maintenance planning.',
    `state_province` STRING COMMENT 'State or province where the facility is located. Used for state regulatory reporting and tax calculations.',
    `storage_capacity_bbl` DECIMAL(18,2) COMMENT 'Total crude oil and condensate storage capacity in barrels. Used for inventory management and logistics planning.',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Water depth in feet at the facility location for offshore installations. Null for onshore facilities. Used for engineering design classification and regulatory reporting.',
    CONSTRAINT pk_production_facility PRIMARY KEY(`production_facility_id`)
) COMMENT 'Master record for surface production facilities including wellpads, gathering stations, gas processing plants, FPSOs, offshore platforms, compressor stations, and metering points. Captures facility type, operational status, design capacity (BOPD/MMCFD), current throughput, geographic location, regulatory permit numbers, and associated field/block. Serves as the SSOT for facility identity within the production domain and anchors all facility-level production allocation and performance data.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`daily_production` (
    `daily_production_id` BIGINT COMMENT 'Unique identifier for the daily production record. Primary key for the daily production transaction.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Daily production volumes are allocated to term contracts for delivery obligation tracking, revenue recognition, and contract performance monitoring. Oil-and-gas operators routinely track which contrac',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Daily production data feeds state and federal production reports (Form 10, BSEE OGOR-A). Regulatory reporting workflows require tracing filed reports back to source production records for audit and re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Daily production volumes drive revenue recognition and must be attributed to cost centers for profitability analysis, netback calculations, and segment reporting. Essential for daily production accoun',
    `employee_id` BIGINT COMMENT 'User identifier of the production engineer or operator who approved this production record. Required for regulatory reporting and audit compliance.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Production data must trace to discovery well for reserves reconciliation, EUR validation, and geological model calibration. Required for PRMS compliance, play success analysis, and prospect maturation',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Daily production volumes drive JIB allocations, partner entitlements, lifting schedules, and cash call calculations. Core operational link for partner revenue and cost distribution.',
    `meter_station_id` BIGINT COMMENT 'Identifier of the production meter used to measure volumes. Links to meter calibration and maintenance records.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Daily production volumes must be classified by product type (crude grade, gas stream, NGL) for revenue accounting, regulatory reporting, and contract settlement. Essential for joint interest billing a',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility or battery where production is measured and allocated.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production volumes must be attributed to profit centers for segment reporting and profitability analysis. Business unit P&L, management reporting, and SEC segment disclosure all require daily producti',
    `reservoir_id` BIGINT COMMENT 'FK to reservoir.reservoir.reservoir_id — MUST-HAVE: Enables linking daily production volumes to reservoir properties (OOIP, drive mechanism, recovery factor) for decline curve analysis and reserves reconciliation. Without this FK, reservoir ',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Daily production volumes are allocated to specific crude/gas shipments for custody transfer and revenue accounting. Critical for reconciling metered production with transported volumes, detecting loss',
    `well_test_id` BIGINT COMMENT 'Identifier of the well test used as the basis for production allocation when allocation method is test-based.',
    `allocation_method` STRING COMMENT 'Method used to allocate production volumes to the well. Test-based uses well test data, meter-based uses direct measurement, proportional uses pro-rata allocation, estimated uses decline curves or historical patterns, manual indicates operator override.. Valid values are `test_based|meter_based|proportional|estimated|manual`',
    `artificial_lift_type` STRING COMMENT 'Type of artificial lift system in operation. None indicates natural flow, rod pump is sucker rod pumping, ESP is electric submersible pump, gas lift uses injected gas, plunger lift uses free-piston plunger, PCP is progressive cavity pump.. Valid values are `none|rod_pump|esp|gas_lift|plunger_lift|pcp`',
    `boe_volume` DECIMAL(18,2) COMMENT 'Total production expressed in barrels of oil equivalent. Converts gas and NGL volumes to oil equivalent using standard conversion factors (typically 6 MCF = 1 BOE).',
    `btu_content` DECIMAL(18,2) COMMENT 'Gross heating value of produced gas in BTU per cubic foot. Determines energy content and sales value of natural gas.',
    `casing_pressure_psi` DECIMAL(18,2) COMMENT 'Casing pressure measured at the wellhead in pounds per square inch. Monitored for well integrity and safety.',
    `choke_size_64ths` STRING COMMENT 'Production choke size in 64ths of an inch. Controls flow rate and wellhead pressure. Critical parameter for production optimization.',
    `co2_content_percent` DECIMAL(18,2) COMMENT 'Carbon dioxide concentration in produced gas as a percentage. Affects heating value and may require removal for pipeline specifications.',
    `condensate_volume_bbl` DECIMAL(18,2) COMMENT 'Condensate production volume in barrels. Light hydrocarbon liquid that condenses from the gas stream at surface conditions.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for production data. Validated indicates verified data, estimated indicates calculated values, suspect indicates data requiring review, missing indicates gaps in measurement, corrected indicates adjusted values.. Valid values are `validated|estimated|suspect|missing|corrected`',
    `data_source` STRING COMMENT 'Source system from which production data was captured. SCADA indicates real-time control system, PI Historian is OSIsoft time-series database, Avocet is production accounting system, manual entry indicates operator input, estimated indicates calculated values.. Valid values are `scada|pi_historian|avocet|manual_entry|estimated`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Number of hours the well was not producing during the 24-hour production period due to planned or unplanned outages.',
    `downtime_reason` STRING COMMENT 'Primary reason for production downtime. Used for root cause analysis and operational improvement initiatives.. Valid values are `maintenance|equipment_failure|weather|regulatory|testing|optimization`',
    `gas_lift_injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Rate of gas injection for gas lift operations in thousand cubic feet per day. Used for gas lift optimization and allocation.',
    `gas_specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of produced natural gas relative to air. Used for energy content calculation and pipeline quality specifications.',
    `gas_temperature_f` DECIMAL(18,2) COMMENT 'Temperature of produced gas at measurement point in degrees Fahrenheit. Used for volume correction to standard conditions.',
    `gor` DECIMAL(18,2) COMMENT 'Gas-oil ratio expressed as cubic feet of gas produced per barrel of oil (SCF/BBL). Key reservoir performance indicator.',
    `gross_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Total gross natural gas production volume in thousand cubic feet (MCF) for the production date before any deductions. Measured at standard conditions (60°F, 14.73 psia).',
    `gross_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Total gross oil production volume in barrels for the production date before any deductions for royalties, working interest, or shrinkage. Measured at standard conditions (60°F, 14.7 psia).',
    `gross_water_volume_bbl` DECIMAL(18,2) COMMENT 'Total gross water production volume in barrels for the production date. Includes produced formation water and any injected water returned to surface.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide concentration in produced gas measured in parts per million. Critical for safety and gas quality specifications.',
    `net_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Net natural gas production volume in thousand cubic feet after applying working interest, net revenue interest, and any applicable deductions. Represents the companys entitlement share.',
    `net_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Net oil production volume in barrels after applying working interest, net revenue interest, and any applicable deductions. Represents the companys entitlement share.',
    `ngl_volume_bbl` DECIMAL(18,2) COMMENT 'Natural gas liquids production volume in barrels extracted from the gas stream. Includes ethane, propane, butane, and natural gasoline.',
    `oil_gravity_api` DECIMAL(18,2) COMMENT 'API gravity of produced crude oil. Measure of oil density relative to water. Higher API gravity indicates lighter, more valuable crude.',
    `oil_temperature_f` DECIMAL(18,2) COMMENT 'Temperature of produced oil at measurement point in degrees Fahrenheit. Used for volume correction to standard conditions.',
    `production_date` DATE COMMENT 'Calendar date for which production volumes are reported. Represents the business event date of production activity.',
    `production_status` STRING COMMENT 'Operational status of the well on the production date. Indicates whether the well was actively producing, shut-in for maintenance, down due to equipment failure, undergoing testing, flowing naturally, or on artificial lift.. Valid values are `producing|shut_in|down|testing|flowing|artificial_lift`',
    `pump_stroke_rate_spm` DECIMAL(18,2) COMMENT 'Operating stroke rate of rod pump in strokes per minute. Key parameter for artificial lift optimization.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production record was first created in the system. Audit trail for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production record was last modified. Audit trail for data lineage and compliance.',
    `run_ticket_number` STRING COMMENT 'Reference number of the oil run ticket or sales ticket associated with this production. Links production to custody transfer and sales records.',
    `separator_pressure_psi` DECIMAL(18,2) COMMENT 'Operating pressure of the production separator in pounds per square inch. Affects gas-liquid separation efficiency and volume measurement.',
    `tubing_pressure_psi` DECIMAL(18,2) COMMENT 'Flowing tubing pressure measured at the wellhead in pounds per square inch. Key indicator of well performance and reservoir pressure.',
    `uptime_hours` DECIMAL(18,2) COMMENT 'Number of hours the well was actively producing during the 24-hour production period. Used to calculate production rates and identify downtime.',
    `water_cut_percent` DECIMAL(18,2) COMMENT 'Percentage of water in the total liquid production (water + oil). Calculated as (water volume / (water volume + oil volume)) * 100.',
    `wor` DECIMAL(18,2) COMMENT 'Water-oil ratio expressed as barrels of water produced per barrel of oil. Indicates reservoir water breakthrough and production efficiency.',
    CONSTRAINT pk_daily_production PRIMARY KEY(`daily_production_id`)
) COMMENT 'Core transactional record capturing daily allocated production volumes at the well level. Stores gross and net oil (BOPD), gas (MCFD/MMCFD), water (BWPD), and NGL volumes for each producing well per calendar day. Includes allocation method (test-based, meter-based, proportional), run ticket references, choke size, tubing and casing pressures, GOR, WOR, and uptime hours. Sourced from Avocet Production Operations and OSIsoft PI System historian. Serves as the SSOT for daily well-level production volumes and is the primary input for SEC reserves reporting and regulatory production filings to BSEE and state agencies.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`production_allocation` (
    `production_allocation_id` BIGINT COMMENT 'Unique identifier for the production allocation record. Primary key for the production allocation transaction.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Production allocation directly supports term contract volume commitments, enabling proper revenue distribution and JIB posting. Critical for joint venture operations where allocated production must be',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production allocation to working interest partners requires cost center assignment for proper revenue and expense matching in JIB preparation, partner settlement, regulatory reporting, and financial s',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Joint interest billing requires drilling AFE data to allocate costs to working interest partners. Production allocation uses API well number and lease data from drilling records for revenue distributi',
    `employee_id` BIGINT COMMENT 'The user ID of the production accountant or supervisor who approved this allocation for final posting. Used for accountability and audit trail.',
    `jib_batch_id` BIGINT COMMENT 'Reference to the JIB batch that includes this allocation record. Used for traceability between production allocation and partner billing in SAP Joint Venture Accounting.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Allocation results feed directly into JIB statements, partner settlements, and working interest distributions. Essential for multi-partner revenue and volume accounting.',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease or production unit under which this production is allocated. Links to land and lease management system for royalty calculations.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Joint interest billing requires product-level allocation (oil vs gas vs NGL) because revenue distribution and royalty calculations differ by product type. Essential for partner accounting and PSA cost',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility or battery where commingled production is measured before allocation. Links to facility master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production allocation to partners must be tracked by profit center for proper revenue recognition in JIB preparation, partner accounting, segment reporting, and business unit P&L. Critical for joint v',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Allocation under PSC regimes determines cost oil, profit oil splits, and government entitlements. Critical for PSC fiscal regime compliance and contractor entitlement calculations.',
    `vendor_id` BIGINT COMMENT 'Reference to the operating company responsible for this production allocation. Links to the operator master data for joint venture and partnership tracking.',
    `well_test_id` BIGINT COMMENT 'Reference to the well test record that drives the allocation factors for test-ratio allocation method. Links to well test analysis data.',
    `allocation_method` STRING COMMENT 'The methodology used to distribute facility-level production back to individual wells. Test-ratio uses well test results, meter-based uses individual well meters, volumetric proportional uses reservoir properties.. Valid values are `test_ratio|meter_based|volumetric_proportional|time_based|pressure_based|theoretical`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the production allocation record. Draft indicates initial calculation, preliminary is pending approval, final is approved for JIB, reconciled indicates variance resolution, adjusted indicates post-final correction, voided indicates cancelled allocation.. Valid values are `draft|preliminary|final|reconciled|adjusted|voided`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation was approved and moved to final status. Critical for audit trail and regulatory compliance.',
    `boe_conversion_factor` DECIMAL(18,2) COMMENT 'The conversion factor used to convert gas volumes to oil equivalent barrels. Typically 6.0 MCF equals 1 BOE, but may vary by operator or regulatory requirement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was first created in the system. Used for audit trail and data lineage tracking.',
    `facility_metered_gas_volume_mcf` DECIMAL(18,2) COMMENT 'The total gas volume measured at the facility level before allocation to individual wells. Used as the basis for allocation calculations and variance reconciliation.',
    `facility_metered_oil_volume_bbl` DECIMAL(18,2) COMMENT 'The total oil volume measured at the facility level before allocation to individual wells. Used as the basis for allocation calculations and variance reconciliation.',
    `factor` DECIMAL(18,2) COMMENT 'The calculated proportion or ratio used to allocate facility production to this well. Expressed as a decimal fraction (e.g., 0.235 represents 23.5% of facility production).',
    `gas_allocation_variance_mcf` DECIMAL(18,2) COMMENT 'The difference between facility metered gas volume and the sum of all allocated gas volumes to wells. Represents unallocated or over-allocated volumes requiring reconciliation.',
    `gas_oil_ratio` DECIMAL(18,2) COMMENT 'The ratio of gas production to oil production, expressed as cubic feet of gas per barrel of oil. Key reservoir performance indicator used for decline curve analysis and reservoir management.',
    `gross_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Total allocated natural gas production volume for the well before interest deductions, measured in thousand cubic feet. Represents 100% working interest volume.',
    `gross_ngl_volume_bbl` DECIMAL(18,2) COMMENT 'Total allocated natural gas liquids production volume for the well before interest deductions, measured in barrels. Includes condensate, propane, butane, and natural gasoline.',
    `gross_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Total allocated oil production volume for the well before interest deductions, measured in barrels. Represents 100% working interest volume.',
    `gross_water_volume_bbl` DECIMAL(18,2) COMMENT 'Total allocated water production volume for the well before interest deductions, measured in barrels. Used for water-oil ratio (WOR) analysis and disposal tracking.',
    `jib_posting_date` DATE COMMENT 'The date when this allocation was posted to the Joint Interest Billing system for partner invoicing. Links production volumes to revenue distribution and partner settlements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was last updated. Used for change tracking and audit trail. Updated whenever any field in the record changes.',
    `net_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Net allocated gas production volume after applying working interest decimal. Calculated as gross_gas_volume_mcf multiplied by working_interest_decimal. Used for partner revenue distribution.',
    `net_ngl_volume_bbl` DECIMAL(18,2) COMMENT 'Net allocated NGL production volume after applying working interest decimal. Calculated as gross_ngl_volume_bbl multiplied by working_interest_decimal. Used for partner revenue distribution.',
    `net_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Net allocated oil production volume after applying working interest decimal. Calculated as gross_oil_volume_bbl multiplied by working_interest_decimal. Used for partner revenue distribution.',
    `net_revenue_interest_decimal` DECIMAL(18,2) COMMENT 'The ownership percentage representing the net revenue interest share after royalty and overriding royalty deductions. Expressed as a decimal (e.g., 0.60 represents 60% NRI). Used for revenue distribution calculations.',
    `oil_allocation_variance_bbl` DECIMAL(18,2) COMMENT 'The difference between facility metered oil volume and the sum of all allocated oil volumes to wells. Represents unallocated or over-allocated volumes requiring reconciliation.',
    `period_end_date` DATE COMMENT 'The ending date of the production allocation period. Defines the time window for which volumes are allocated.',
    `period_start_date` DATE COMMENT 'The beginning date of the production allocation period. Typically daily or monthly allocation cycles.',
    `production_month` STRING COMMENT 'The calendar month for which production is allocated, expressed in YYYY-MM format. Used for monthly production reporting and trend analysis.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `reconciliation_date` DATE COMMENT 'The date when allocation variances were reconciled and the allocation was finalized. Used for audit trail and compliance reporting.',
    `reconciliation_notes` STRING COMMENT 'Free-text explanation of variance causes and reconciliation actions taken. Documents meter calibration issues, well downtime, measurement errors, or allocation method adjustments.',
    `reconciliation_status` STRING COMMENT 'Status of the variance reconciliation process. Indicates whether allocation variances have been investigated and resolved. Critical for audit trail and regulatory compliance.. Valid values are `not_required|pending|in_progress|completed|failed`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this allocation record must be included in regulatory production reports to BSEE, state agencies, or SEC reserves disclosure. True if regulatory reporting is required.',
    `run_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation calculation was executed. Used for audit trail and to track allocation process timing.',
    `source_system` STRING COMMENT 'The system of record that originated this allocation data. Avocet Production Operations for daily allocation, OSIsoft PI for real-time data, SCADA for facility meters, manual entry for adjustments, or third-party for operator-provided data.. Valid values are `avocet|osi_pi|scada|manual_entry|third_party`',
    `total_boe` DECIMAL(18,2) COMMENT 'Total production expressed in barrels of oil equivalent. Calculated by converting gas and NGL volumes to oil equivalent and summing with oil volumes. Used for standardized production reporting.',
    `water_oil_ratio` DECIMAL(18,2) COMMENT 'The ratio of water production to oil production, expressed as barrels of water per barrel of oil. Key indicator of reservoir water breakthrough and well performance decline.',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'The ownership percentage representing the working interest share for this allocation record. Expressed as a decimal (e.g., 0.75 represents 75% WI). Used to calculate net volumes from gross volumes.',
    CONSTRAINT pk_production_allocation PRIMARY KEY(`production_allocation_id`)
) COMMENT 'Transactional record that distributes facility-level or commingled production volumes back to individual wells and ownership interests. Captures allocation period (daily/monthly), allocation method (test-ratio, meter-based, volumetric proportional), reference well test driving allocation factors, gross allocated volumes by phase (oil, gas, water, NGL), net volumes by working interest (WI) and net revenue interest (NRI), variance to metered volumes, and reconciliation status. Supports JIB (Joint Interest Billing) and royalty calculations. Integrates with SAP Joint Venture Accounting for partner-level volume reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`monthly_production` (
    `monthly_production_id` BIGINT COMMENT 'Unique identifier for the monthly production record. Primary key for the monthly production entity.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Monthly production certification ties directly to term contract volume commitments for regulatory reporting, revenue recognition, and contract compliance verification. Standard oil-and-gas business pr',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Report identifier or confirmation number assigned by the state oil and gas commission upon submission of the monthly production report for onshore operations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Monthly production is the basis for revenue recognition and must tie to cost centers for financial statement preparation, monthly close process, reserves reconciliation, and SEC reporting. Fundamental',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Monthly regulatory reports (Form 3160, state production reports) require API well number and drilling permit data. Reserves engineers calculate finding & development costs, EUR, and NPV using drilling',
    `field_id` BIGINT COMMENT 'Identifier of the oil or gas field to which the well or facility belongs for geographic and reservoir aggregation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Monthly production is the basis for partner billing, regulatory reporting, royalty calculations, and JIB statement preparation under Joint Operating Agreements.',
    `lease_id` BIGINT COMMENT 'Identifier of the oil and gas lease under which the well or facility operates. Used for royalty calculation and land management.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Monthly regulatory reports to state agencies and BSEE require product-level classification of oil, gas, and NGL volumes. Mandatory for reserves booking and SEC financial reporting under ASC 932.',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility or battery where production is aggregated and measured.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Monthly production is the basis for profit center revenue recognition in monthly financial close, segment reporting, and performance evaluation. Essential for business unit profitability analysis and ',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Monthly regulatory production reports (BSEE, state agencies) must reconcile with shipment/sales records for compliance and revenue verification. Links reported production to actual custody transfers, ',
    `vendor_id` BIGINT COMMENT 'Identifier of the operating company responsible for the well or facility during the production month.',
    `allocation_method` STRING COMMENT 'Method used to allocate production volumes to the well or facility. Indicates whether volumes are directly measured or allocated from facility totals.. Valid values are `direct_measurement|proration|well_test|estimated`',
    `api_well_number` STRING COMMENT 'Standardized API well number assigned by regulatory authority for unique well identification in production reporting.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `artificial_lift_type` STRING COMMENT 'Type of artificial lift system used during the production month to enhance well productivity. Indicates the primary lift mechanism employed. [ENUM-REF-CANDIDATE: none|rod_pump|esp|gas_lift|plunger_lift|pcp|hydraulic_pump — 7 candidates stripped; promote to reference product]',
    `boe_total` DECIMAL(18,2) COMMENT 'Total production expressed in barrels of oil equivalent (BOE), converting gas and NGL volumes to oil-equivalent barrels using standard conversion factors (typically 6 MCF = 1 BOE).',
    `bsee_submission_reference` STRING COMMENT 'Reference number or confirmation code assigned by BSEE upon successful submission of the monthly production report for offshore operations.',
    `certification_date` DATE COMMENT 'Date on which the monthly production record was certified and approved for regulatory submission.',
    `certification_status` STRING COMMENT 'Status of the monthly production record in the certification and regulatory submission workflow. Indicates whether volumes have been validated and submitted.. Valid values are `draft|pending_review|certified|submitted|rejected|amended`',
    `certified_by` STRING COMMENT 'Name or identifier of the production engineer or authorized personnel who certified the monthly production volumes as accurate and complete.',
    `condensate_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of condensate produced during the month, measured in barrels (BBL). Condensate is liquid hydrocarbon recovered from gas wells.',
    `data_source` STRING COMMENT 'Source system or method from which the monthly production data was extracted. Indicates data lineage and quality assurance level.. Valid values are `pi_system|avocet|scada|manual_entry|third_party`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours of non-productive time (NPT) during the month due to equipment failure, maintenance, or operational issues.',
    `flared_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of natural gas flared during the month due to operational constraints or safety requirements, measured in thousand cubic feet (MCF).',
    `fuel_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of natural gas consumed as fuel for lease operations and equipment during the month, measured in thousand cubic feet (MCF).',
    `gas_mcfd_average` DECIMAL(18,2) COMMENT 'Average daily gas production rate for the month, calculated as total gas volume divided by the number of production days. Expressed in MCFD.',
    `gas_volume_mcf` DECIMAL(18,2) COMMENT 'Total volume of natural gas produced during the month, measured in thousand cubic feet (MCF). This is the certified volume submitted to regulatory agencies.',
    `gor` DECIMAL(18,2) COMMENT 'Gas-oil ratio for the month, calculated as the ratio of gas volume (MCF) to oil volume (BBL). Indicates reservoir performance and production characteristics.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest after deducting royalties and overriding royalty interests. Represents the operators share of production revenue.',
    `ngl_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of natural gas liquids (NGL) extracted during the month, measured in barrels (BBL). Includes ethane, propane, butane, and natural gasoline.',
    `oil_bopd_average` DECIMAL(18,2) COMMENT 'Average daily oil production rate for the month, calculated as total oil volume divided by the number of production days. Expressed in BOPD.',
    `oil_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of crude oil produced during the month, measured in barrels (BBL). This is the certified volume submitted to regulatory agencies.',
    `production_days` STRING COMMENT 'Number of days the well or facility was actively producing during the month. Used to calculate average daily rates and uptime.',
    `production_month` DATE COMMENT 'The calendar month for which production volumes are reported, typically the first day of the month (YYYY-MM-01 format).',
    `production_status` STRING COMMENT 'Current operational status of the well or facility during the production month. Indicates whether the asset was actively producing or offline.. Valid values are `producing|shut-in|suspended|abandoned|temporarily_abandoned|plugged`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monthly production record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the monthly production record was last modified. Used for audit trail and change tracking.',
    `regulatory_submission_date` DATE COMMENT 'Date on which the certified monthly production volumes were submitted to the regulatory agency (BSEE, state oil and gas commission).',
    `remarks` STRING COMMENT 'Free-text field for additional comments, explanations, or notes regarding the monthly production record, including operational issues or data quality concerns.',
    `reporting_jurisdiction` STRING COMMENT 'Regulatory jurisdiction to which the monthly production report is submitted. Determines the applicable reporting requirements and agency.. Valid values are `federal_offshore|state_onshore|tribal_lands`',
    `reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Average reservoir pressure during the production month, measured in pounds per square inch (PSI). Indicates reservoir energy and depletion status.',
    `royalty_volume_boe` DECIMAL(18,2) COMMENT 'Total production volume attributable to royalty interests, expressed in barrels of oil equivalent (BOE). Used for royalty payment calculation.',
    `sales_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of natural gas sold or delivered to market during the month, measured in thousand cubic feet (MCF). Excludes flared, vented, and fuel gas.',
    `vented_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of natural gas vented during the month, measured in thousand cubic feet (MCF). Reported for environmental compliance and emissions tracking.',
    `water_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of produced water during the month, measured in barrels (BBL). Includes formation water and injected water produced back.',
    `wellhead_pressure_psi` DECIMAL(18,2) COMMENT 'Average wellhead flowing pressure during the production month, measured in pounds per square inch (PSI). Used for production optimization and decline analysis.',
    `wor` DECIMAL(18,2) COMMENT 'Water-oil ratio for the month, calculated as the ratio of water volume (BBL) to oil volume (BBL). Indicates water breakthrough and reservoir depletion.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the operator in the well or facility for the production month. Used for revenue and cost allocation.',
    CONSTRAINT pk_monthly_production PRIMARY KEY(`monthly_production_id`)
) COMMENT 'Authoritative monthly production record aggregated and validated at the well and facility level for regulatory reporting. Stores certified monthly volumes of oil (BOPD average and total BBL), gas (MMCFD average and total MCF), water, and NGL by well and facility. Includes regulatory submission status, state agency report ID, BSEE submission reference, and certification sign-off. Distinct from daily_production in that monthly records are the legally certified volumes submitted to BSEE, state oil and gas commissions, and used for SEC reserves disclosure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`artificial_lift` (
    `artificial_lift_id` BIGINT COMMENT 'Unique identifier for the artificial lift installation record. Primary key for the artificial lift master data product.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Artificial lift design (ESP depth, pump stages, gas lift injection point) depends on wellbore geometry, casing/tubing design, and deviation survey from drilling. Operators track lift installation cost',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Artificial lift systems (ESPs, rod pumps, gas lift) are physical equipment assets requiring maintenance tracking, failure analysis, and lifecycle management. Links operational performance data to equi',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Artificial lift installations are capital projects authorized by AFEs for capital project tracking, equipment capitalization, ROI analysis, and cost control. Essential for tracking artificial lift cap',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Artificial lift installations are safety-critical well interventions requiring documented accountability for the installing technician. Oil & gas operations track installer identity for warranty claim',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Artificial lift equipment manufacturers are vendors for procurement tracking, warranty management, and vendor performance evaluation. Manufacturer field is denormalized string. Role prefix distinguish',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Artificial lift installations and repairs are capital/maintenance expenditures tracked via purchase orders. Links equipment to procurement for cost tracking, warranty management, and AFE reconciliatio',
    `scada_tag_id` BIGINT COMMENT 'Unique tag identifier in the OSIsoft PI System or SCADA system for real-time data integration. Links artificial lift record to live operational data streams.',
    `actual_rate_bopd` DECIMAL(18,2) COMMENT 'Current actual production rate in barrels of oil per day achieved by the artificial lift system. Updated from real-time production data via OSIsoft PI System integration.',
    `comments` STRING COMMENT 'Free-text field for operational notes, special conditions, or historical context about the artificial lift installation. Used by field engineers and production technicians.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this artificial lift record was first created in the system. Audit trail for data governance and compliance.',
    `design_rate_bopd` DECIMAL(18,2) COMMENT 'Target production rate in barrels of oil per day that the artificial lift system was designed to achieve. Used for performance monitoring and optimization.',
    `discharge_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at the pump discharge in pounds per square inch. Used to calculate total dynamic head and system efficiency.',
    `failure_date` DATE COMMENT 'Date when the artificial lift system failed. Nullable for operating systems. Used to calculate mean time between failures and reliability metrics.',
    `failure_mode` STRING COMMENT 'Description of the failure mode if the system has failed. Examples include motor failure, pump wear, electrical short, gas lock, rod parting. Used for failure analysis and MTBF tracking. [ENUM-REF-CANDIDATE: Motor Failure|Pump Wear|Electrical Short|Gas Lock|Rod Parting|Tubing Leak|Cable Damage|Bearing Failure|Seal Failure — promote to reference product]',
    `gas_injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Current gas injection rate for gas lift systems in thousand cubic feet per day. Null for non-gas-lift installations. Key optimization parameter for gas lift wells.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure for the artificial lift installation including equipment, labor, and services. Used for CAPEX tracking and economic analysis.',
    `installation_date` DATE COMMENT 'Date when the artificial lift system was installed and commissioned in the well. Marks the start of the run life tracking period.',
    `installation_number` STRING COMMENT 'Business identifier for the artificial lift installation. Externally-known unique code used in field operations and maintenance work orders.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed on the artificial lift system. Used for preventive maintenance scheduling via Maximo integration.',
    `lift_status` STRING COMMENT 'Current operational status of the artificial lift system. Tracks lifecycle state from installation through decommissioning.. Valid values are `Operating|Idle|Failed|Maintenance|Decommissioned|Standby`',
    `lift_type` STRING COMMENT 'Type of artificial lift system installed. ESP = Electric Submersible Pump, PCP = Progressive Cavity Pump. Determines the operating characteristics and optimization parameters.. Valid values are `ESP|Rod Pump|Gas Lift|PCP|Jet Pump|Plunger Lift`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this artificial lift record was last updated. Audit trail for data lineage and change tracking.',
    `motor_current_amps` DECIMAL(18,2) COMMENT 'Current draw of the ESP motor in amperes. Real-time parameter monitored via SCADA. Used for load analysis and efficiency calculations.',
    `motor_horsepower` DECIMAL(18,2) COMMENT 'Rated horsepower of the artificial lift motor. Applicable to ESP and rod pump systems. Determines power consumption and lifting capacity.',
    `motor_temperature_f` DECIMAL(18,2) COMMENT 'Current operating temperature of the ESP motor in degrees Fahrenheit. Monitored via downhole sensors. High temperature indicates potential motor failure risk.',
    `motor_voltage` STRING COMMENT 'Operating voltage of the ESP motor in volts. Standard values include 480V, 1000V, 2400V, 4160V. Critical for electrical system design and safety.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity. Calculated based on run life, operating conditions, and maintenance strategy.',
    `operating_cost_per_day_usd` DECIMAL(18,2) COMMENT 'Daily operating expense for the artificial lift system including power, maintenance, and monitoring. Used for lease operating expense tracking and economic optimization.',
    `operating_frequency_hz` DECIMAL(18,2) COMMENT 'Current operating frequency of the variable speed drive in Hertz. Used to control ESP pump speed and production rate. Typical range 30-70 Hz.',
    `optimization_target` STRING COMMENT 'Primary optimization objective for this artificial lift installation. Drives automated control strategies in artificial lift optimization workflows.. Valid values are `Maximize Production|Minimize Power|Extend Run Life|Balance`',
    `power_consumption_kwh` DECIMAL(18,2) COMMENT 'Total electrical power consumption in kilowatt-hours. Used for operating expense tracking and energy efficiency analysis.',
    `pump_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet at which the pump is set in the wellbore. Critical design parameter for ESP and rod pump installations.',
    `pump_intake_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at the pump intake in pounds per square inch. Critical operating parameter for ESP systems. Low intake pressure indicates potential gas lock or insufficient reservoir pressure.',
    `pump_stages` STRING COMMENT 'Number of stages in the ESP or PCP pump assembly. Determines total head capacity and lifting capability of the system.',
    `removal_date` DATE COMMENT 'Date when the artificial lift system was pulled from the well. Nullable for currently operating systems. Used to calculate run life duration.',
    `run_life_days` STRING COMMENT 'Number of days the artificial lift system has been operating since installation. Calculated as current date minus installation date for active systems, or removal date minus installation date for pulled systems. Key metric for reliability analysis.',
    `stroke_length_inches` DECIMAL(18,2) COMMENT 'Length of the pumping stroke in inches for rod pump systems. Typical values range from 30 to 300 inches. Determines displacement per stroke.',
    `strokes_per_minute` DECIMAL(18,2) COMMENT 'Current pumping speed in strokes per minute for rod pump systems. Used to calculate pump displacement and production rate.',
    `target_frequency_hz` DECIMAL(18,2) COMMENT 'Optimal target frequency for ESP operation based on reservoir conditions and production targets. Used in artificial lift optimization workflows.',
    `target_gas_injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Optimal target gas injection rate for gas lift optimization. Used in production enhancement programs and nodal analysis.',
    `work_order_number` STRING COMMENT 'Reference to the Maximo work order number for the installation or most recent maintenance activity. Links to CMMS for asset lifecycle management.',
    CONSTRAINT pk_artificial_lift PRIMARY KEY(`artificial_lift_id`)
) COMMENT 'Master record for artificial lift installations on producing wells. Captures lift type (ESP, rod pump, gas lift, PCP, jet pump, plunger lift), installation date, design parameters (pump depth, motor rating, frequency, gas injection rate), current operating parameters, run life history, and optimization targets. Tracks ESP run life (days), failure mode, and mean time between failures (MTBF). Supports artificial lift optimization workflows and production enhancement programs.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`downtime_event` (
    `downtime_event_id` BIGINT COMMENT 'Unique identifier for the downtime event record. Primary key for the downtime_event product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Downtime events have direct financial impact through deferred production (lost revenue) and must be tracked by cost center for variance analysis, production reporting, insurance claims, and performanc',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Production downtime root cause analysis often traces to drilling/completion issues (sand production from inadequate screen, casing leak, cement failure). Operators need drilling data to diagnose failu',
    `field_id` BIGINT COMMENT 'FK to production.field',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Downtime events may trigger insurance claims or loss recognition posted to specific GL accounts for loss accounting, insurance recovery, and variance analysis. Required when downtime results in financ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Downtime impacts partner entitlements, triggers force majeure clauses, affects AFE performance tracking, and may require partner notification under JOA terms.',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility experiencing downtime. Links to facility master data.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Downtime events can trigger regulatory violations when they breach permit conditions, emission limits, or safety requirements. Product has regulatory_reportable_flag and regulatory_report_number. Enfo',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about the downtime event. Used by operations staff to document special circumstances or lessons learned.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions implemented to resolve the downtime event and restore production. Documents repair activities, part replacements, or operational adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was first created in the lakehouse silver layer. Used for data lineage and audit trail.',
    `data_source` STRING COMMENT 'Source system from which the downtime event data was captured. Indicates whether the event was automatically detected by SCADA/PI or manually entered by operations staff.. Valid values are `scada|manual_entry|pi_system|avocet|maximo|enablon`',
    `deferred_boe` DECIMAL(18,2) COMMENT 'Total deferred production expressed in barrel of oil equivalent (BOE) units. Aggregates oil, gas, and NGL volumes using standard conversion factors for consolidated reporting.',
    `deferred_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of natural gas production lost due to the downtime event, measured in thousand cubic feet (MCF). Used for deferment reporting and reserves impact analysis.',
    `deferred_ngl_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of natural gas liquids (NGL) production lost due to the downtime event, measured in barrels (BBL). Used for deferment reporting.',
    `deferred_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of crude oil production lost due to the downtime event, measured in barrels (BBL). Used for deferment reporting and reserves impact analysis.',
    `downtime_category` STRING COMMENT 'Primary classification of the downtime event cause. Categorizes the root cause for NPT (Non-Productive Time) analysis and operational reporting.. Valid values are `planned_maintenance|equipment_failure|weather|regulatory|market_curtailment|pipeline_constraint`',
    `downtime_event_status` STRING COMMENT 'Current lifecycle status of the downtime event. Tracks the event from initial detection through resolution and closure.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `downtime_subcategory` STRING COMMENT 'Detailed sub-classification of the downtime cause within the primary category. Provides granular root cause analysis for equipment failure modes, weather types, or regulatory reasons.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the downtime event in hours. Calculated as the difference between end_timestamp and start_timestamp. Critical metric for NPT (Non-Productive Time) reporting.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when production was restored and the downtime event ended. Null for ongoing downtime events. Used to calculate total downtime duration.',
    `equipment_tag` STRING COMMENT 'Unique equipment tag or asset number of the failed or maintained equipment that caused the downtime. Links to asset master data in CMMS (Computerized Maintenance Management System).',
    `equipment_type` STRING COMMENT 'Classification of the equipment involved in the downtime event (e.g., pump, compressor, separator, valve, electrical system, instrumentation). Used for equipment reliability analysis.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in United States Dollars (USD) to resolve the downtime event, including labor, materials, equipment rental, and contractor services. Used for OPEX (Operating Expenditure) tracking.',
    `estimated_revenue_impact_usd` DECIMAL(18,2) COMMENT 'Estimated revenue loss in United States Dollars (USD) due to deferred production during the downtime event. Calculated using current commodity prices and net working interest.',
    `event_number` STRING COMMENT 'Business-facing unique identifier or ticket number for the downtime event, used for tracking and reporting purposes.',
    `hse_incident_flag` BOOLEAN COMMENT 'Boolean indicator whether the downtime event involved a health, safety, or environmental incident. True if HSE incident occurred, False otherwise. Triggers HSE reporting workflows.',
    `operator_name` STRING COMMENT 'Name of the operating company responsible for the well or facility. Critical for joint venture operations and regulatory compliance.',
    `preventive_action_recommended` STRING COMMENT 'Recommended preventive actions to avoid recurrence of similar downtime events. Used for continuous improvement and reliability engineering programs.',
    `priority` STRING COMMENT 'Business priority level assigned to the downtime event based on production impact, safety risk, and operational criticality. Drives response resource allocation.. Valid values are `critical|high|medium|low`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator whether the downtime event requires regulatory reporting to BSEE (Bureau of Safety and Environmental Enforcement), state agencies, or other regulatory authorities. True if reportable, False otherwise.',
    `reported_by` STRING COMMENT 'Name or identifier of the production operator or engineer who initially reported the downtime event. Used for audit trail and data quality tracking.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event was first reported or logged in the production operations system. Used for response time analysis.',
    `resolved_by` STRING COMMENT 'Name or identifier of the person or team who resolved the downtime event and restored production. Used for performance tracking and knowledge management.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event was marked as resolved in the system. May differ from end_timestamp if administrative closure lags operational restoration.',
    `responsible_organization` STRING COMMENT 'Name of the specific organization or contractor responsible for the downtime event. Used for vendor performance tracking and contract compliance.',
    `responsible_party` STRING COMMENT 'Entity responsible for the downtime event. Used for accountability tracking, cost allocation, and JIB (Joint Interest Billing) processing in joint venture operations. [ENUM-REF-CANDIDATE: operator|contractor|third_party|joint_venture_partner|pipeline_operator|regulatory_authority|force_majeure — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings for the downtime event. Documents the underlying technical or operational failure mode.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event began. Captured from SCADA/DCS systems or manually entered by production operators. Used to calculate total downtime duration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was last modified in the lakehouse silver layer. Used for data lineage and change tracking.',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'Working interest percentage held by the operator in the affected well or facility. Used to calculate net deferred production and financial impact for joint venture accounting.',
    CONSTRAINT pk_downtime_event PRIMARY KEY(`downtime_event_id`)
) COMMENT 'Transactional record capturing production downtime and deferment events at the well or facility level. Records downtime start and end timestamps, downtime category (planned maintenance, equipment failure, weather, regulatory, market curtailment, pipeline constraint), deferred volumes by phase (oil BBL, gas MCF, NGL BBL), responsible party, and corrective action taken. Integrates with Maximo work orders for maintenance-related downtime. Supports NPT (Non-Productive Time) analysis and production efficiency reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Unique identifier for the production forecast record. Primary key for the production forecast entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Production forecasts are tied to capital programs with AFE budgets for economic evaluation and investment decisions. Links forecast assumptions to authorized spending. Afe_number is string, need FK.',
    `approved_by_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production forecasts underpin reserves booking and SEC reporting (Rule 4-10 of Regulation S-X). Approver identity must be tracked for audit trail and professional accountability. Current approved_by',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Production forecasts inform term contract volume commitments, nomination planning, and commercial strategy. Oil-and-gas operators link forecasts to contracts for commitment planning, deficiency risk a',
    `compliance_sec_reserves_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.sec_reserves_disclosure. Business justification: Production forecasts (EUR, decline curves, reserves categories) feed SEC reserves disclosures in 10-K filings. Financial reporting workflows require linking forecasts to the SEC disclosures they suppo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production forecasts drive budget preparation and must align with cost center structure for annual budgeting, reserves booking, investment decision-making, and long-range planning. Critical for financ',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Decline curve analysis and type curve generation require drilling/completion parameters (lateral length, frac stages, proppant mass, drilling cost) to forecast production. Reserves engineers use drill',
    `employee_id` BIGINT COMMENT 'Reference to the operating company responsible for this forecast. Links to operator master data. Critical for Joint Operating Agreement (JOA) and joint venture forecasting.',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Production forecasts inherit initial resource estimates, EUR, and PRMS classification from discovery evaluation. Essential for reserves booking, FDP economics, and tracking forecast accuracy against o',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field for which this forecast applies. Links to field master data for aggregated field-level forecasting and reporting.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Forecasts drive AFE approvals, annual budget planning, partner investment decisions, and economic limit calculations under Joint Operating Agreements.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Production forecasts are product-specific (light sweet crude vs heavy sour, dry gas vs wet gas) because pricing, transportation costs, and market demand vary by product grade. Critical for economic mo',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility or field for which this forecast applies. Links to facility master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production forecasts must align with profit center structure for budgeting and planning. Strategic planning, reserves booking, investor guidance, and business unit planning all require forecast-to-pro',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Forecasts are essential for PSC economic modeling, cost recovery projections, government take calculations, and production bonus threshold planning.',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir or formation from which production is forecasted. Links to reservoir master data for geological and petrophysical context.',
    `approved_date` DATE COMMENT 'Date when this forecast was formally approved. Establishes the effective date for budget targets and reserves reporting.',
    `b_factor` DECIMAL(18,2) COMMENT 'Hyperbolic decline curve b-factor (exponent). Ranges from 0 (exponential decline) to 1 (harmonic decline). Defines the curvature of the decline trend. Critical parameter for unconventional well forecasting.',
    `basis` STRING COMMENT 'Description of the technical basis or methodology used to generate this forecast (e.g., Arps hyperbolic decline with b=0.8, Petrel reservoir simulation model XYZ, Analog type curve from Wolfcamp A offset wells). Provides transparency for forecast review and audit.',
    `boe_forecast_boepd` DECIMAL(18,2) COMMENT 'Forecasted total production in Barrel of Oil Equivalent Per Day (BOEPD). Converts all hydrocarbon phases (oil, gas, NGL) to a common unit using standard conversion factors (typically 6 MCF gas = 1 BOE).',
    `confidence_level` STRING COMMENT 'Probabilistic confidence level for the forecast. P90 = 90% probability of exceeding (conservative); P50 = 50% probability (best estimate); P10 = 10% probability (optimistic). Aligns with PRMS probabilistic reserves methodology.. Valid values are `P10|P50|P90|deterministic|not_specified`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system. Supports audit trail and data lineage tracking.',
    `decline_rate_effective` DECIMAL(18,2) COMMENT 'Effective decline rate expressed as a decimal fraction. Represents the actual year-over-year production decline. Related to nominal decline rate through the decline curve equation.',
    `decline_rate_nominal` DECIMAL(18,2) COMMENT 'Nominal decline rate expressed as a decimal fraction (e.g., 0.25 for 25% annual decline). Used in exponential or hyperbolic decline curve analysis to project future production.',
    `economic_limit_boepd` DECIMAL(18,2) COMMENT 'Economic limit production rate in BOEPD. The production rate at which operating costs equal revenue, defining the end of economic life. Used to determine EUR and reserves cutoff.',
    `eur_boe` DECIMAL(18,2) COMMENT 'Estimated Ultimate Recovery (EUR) in Barrel of Oil Equivalent (BOE). Total cumulative production expected over the economic life of the well or field. Critical input for reserves classification and SEC reporting.',
    `forecast_name` STRING COMMENT 'Business-friendly name or label for this forecast scenario (e.g., Q1 2024 Budget, 2024 Annual Plan, Type Curve - Wolfcamp A).',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast. Draft = work in progress; Submitted = under review; Approved = authorized for use in planning and reporting; Rejected = not approved; Superseded = replaced by newer version; Active = current operational forecast; Archived = historical record. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|superseded|active|archived — 7 candidates stripped; promote to reference product]',
    `forecast_type` STRING COMMENT 'Classification of the forecast methodology or purpose. Decline curve forecast uses historical production trends; type curve applies analog well performance; simulation-based uses reservoir simulation; budget target is the approved operational plan; stretch target is aspirational goal; minimum commitment is contractual obligation; reserves-based aligns with SEC reserves reporting; AFE forecast supports Authorization for Expenditure planning. [ENUM-REF-CANDIDATE: decline_curve|type_curve|simulation_based|budget_target|stretch_target|minimum_commitment|reserves_based|afe_forecast — 8 candidates stripped; promote to reference product]',
    `gas_forecast_mmcfd` DECIMAL(18,2) COMMENT 'Forecasted natural gas production volume in Million Cubic Feet per Day (MMCFD) for the specified period. Represents natural gas production rate.',
    `gor_forecast` DECIMAL(18,2) COMMENT 'Forecasted Gas-Oil Ratio (GOR) expressed as cubic feet of gas per barrel of oil. Key reservoir performance indicator used in decline curve analysis and reservoir management.',
    `granularity` STRING COMMENT 'Time granularity of the forecast period (daily, monthly, quarterly, or annual). Determines the level of detail for production volume projections.. Valid values are `daily|monthly|quarterly|annual`',
    `ip_rate_boepd` DECIMAL(18,2) COMMENT 'Initial Production (IP) rate in Barrel of Oil Equivalent Per Day (BOEPD). The production rate at the start of the forecast period, typically measured during the first 24 hours or 30 days of production.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this forecast record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last modified. Supports change tracking and audit trail.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Net Revenue Interest (NRI) percentage after deducting royalties and overriding royalty interests. Expressed as a decimal. Used to calculate net revenue from production.',
    `ngl_forecast_bopd` DECIMAL(18,2) COMMENT 'Forecasted Natural Gas Liquids (NGL) production volume in Barrels of Oil Per Day (BOPD) for the specified period. Includes ethane, propane, butane, and natural gasoline.',
    `oil_forecast_bopd` DECIMAL(18,2) COMMENT 'Forecasted oil production volume in Barrels of Oil Per Day (BOPD) for the specified period. Represents crude oil production rate.',
    `operating_cost_assumption` DECIMAL(18,2) COMMENT 'Assumed Lease Operating Expense (LOE) per BOE used in economic evaluation of this forecast. Expressed in USD per BOE. Used for NPV calculations and reserves economic limit determination.',
    `period_end_date` DATE COMMENT 'The last date of the period covered by this forecast record. Defines the end of the forecast interval.',
    `period_start_date` DATE COMMENT 'The first date of the period covered by this forecast record. Defines the beginning of the forecast interval (monthly, quarterly, or annual).',
    `price_deck_assumption` STRING COMMENT 'Reference to the commodity price assumptions used in economic evaluation of this forecast (e.g., FY2024 Corporate Price Deck, SEC 12-month average, WTI $75/bbl flat). Critical for NPV and reserves calculations.',
    `reserves_category` STRING COMMENT 'Reserves classification per SPE Petroleum Resources Management System (PRMS). 1P = Proved reserves (P90 confidence); 2P = Proved + Probable reserves (P50 confidence); 3P = Proved + Probable + Possible reserves (P10 confidence). Used for SEC reserves disclosure and financial reporting. [ENUM-REF-CANDIDATE: 1P|2P|3P|proved|probable|possible|not_classified — 7 candidates stripped; promote to reference product]',
    `reserves_subcategory` STRING COMMENT 'Detailed reserves subcategory. PDP = Proved Developed Producing; PDNP = Proved Developed Non-Producing; PUD = Proved Undeveloped. Used for granular reserves reporting and capital allocation decisions.. Valid values are `PDP|PDNP|PUD|probable|possible`',
    `scenario` STRING COMMENT 'Business scenario or sensitivity case for this forecast. Base case represents the most likely outcome; upside and downside represent optimistic and pessimistic cases; price scenarios reflect commodity price assumptions; development scenarios reflect timing of capital investment. [ENUM-REF-CANDIDATE: base_case|upside|downside|low_price|high_price|accelerated_development|deferred_development — 7 candidates stripped; promote to reference product]',
    `variance_to_actual_percent` DECIMAL(18,2) COMMENT 'Calculated variance between forecasted and actual production volumes, expressed as a percentage. Positive values indicate over-forecast; negative values indicate under-forecast. Used for forecast accuracy tracking and continuous improvement.',
    `version` STRING COMMENT 'Version identifier for this forecast (e.g., v1.0, v2.1, Final, Draft). Supports revision tracking and audit trail for forecast changes.',
    `water_forecast_bwpd` DECIMAL(18,2) COMMENT 'Forecasted water production volume in Barrels of Water Per Day (BWPD) for the specified period. Represents produced water that must be handled and disposed.',
    `wor_forecast` DECIMAL(18,2) COMMENT 'Forecasted Water-Oil Ratio (WOR) expressed as barrels of water per barrel of oil. Indicates water cut and reservoir maturity.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Working Interest (WI) percentage owned by the company in this well or facility. Expressed as a decimal (e.g., 0.7500 for 75%). Used to calculate net production volumes and revenue.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this forecast record. Supports audit trail and accountability.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Forward-looking production volume record at the well, facility, or field level covering both reserves-based forecasts and operational targets/budgets. Stores forecast period (monthly/annual), record type (decline curve forecast, type curve, simulation-based, budget target, stretch target, minimum commitment), forecast volumes by phase (oil BOPD, gas MMCFD, NGL BOPD), EUR (Estimated Ultimate Recovery), IP (Initial Production) rate, decline parameters (nominal/effective rate, b-factor), confidence classification (1P/2P/3P per PRMS for forecasts), approved-by and revision history for targets, and variance tracking against actuals. Supports SEC reserves disclosure input, CAPEX planning, reservoir management, and production performance management. Distinct from actual production records — this is the forward-looking plan and operational goal.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`injection_well` (
    `injection_well_id` BIGINT COMMENT 'Unique identifier for the injection well. Primary key for the injection well master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Injection wells (waterflood, EOR, disposal) are cost centers with operating expenses but no direct revenue. LOE tracking, waterflood project economics, cost allocation, and environmental compliance re',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Injection wells (waterflood, EOR, disposal) originate as drilled wells. UIC permit applications require drilling data (casing design, cement bond logs, mechanical integrity). Operators track drilling ',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field where the injection well is located. Links to field master for geographic and operational context.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Injection well drilling and conversion projects are AFE-authorized for waterflood project tracking, capital allocation, reserves booking, and project economics. Critical for managing waterflood and EO',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Injection wells require UIC Class II permits for legal operation. Compliance tracking, mechanical integrity testing, and permit renewal workflows require linking injection wells to their UIC permits. ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Injection wells are capital assets under JOAs; drilling, completion, and operating costs are allocated to partners via AFEs and JIB statements.',
    `injection_pattern_id` BIGINT COMMENT 'Reference to the injection pattern or flood unit this well belongs to. Links to pattern master for coordinated reservoir management.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Injection fluids (water, CO2, natural gas, nitrogen) must be tracked as products for EOR cost allocation, UIC permit compliance, and carbon credit accounting. Replaces denormalized injection_fluid tex',
    `production_facility_id` BIGINT COMMENT 'Reference to the injection facility or water plant supplying injection fluid. Links to facility master for operational integration.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Injection wells in PSC areas require PSA link for cost recovery eligibility, EOR cost classification, and depreciation calculations under fiscal terms.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Injection wells require EPA UIC Class II quarterly/annual reports, mechanical integrity test reports (pressure tests, radioactive tracer surveys), and permit renewal applications. Critical for UIC per',
    `reservoir_id` BIGINT COMMENT 'Reference to the target reservoir or formation receiving injection. Links to reservoir master for geological and engineering parameters.',
    `vendor_id` BIGINT COMMENT 'Reference to the operating company responsible for injection well operations. Links to operator master for regulatory and operational accountability.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Waterflood/EOR injection wells source water from terminals or storage facilities. Tracks water logistics supply chain, injection volume planning, and water sourcing costs. Role-prefixed to distinguish',
    `abandonment_date` DATE COMMENT 'Date the well was permanently abandoned and plugged. Marks the end of the wells operational life.',
    `actual_injection_rate_bwipd` DECIMAL(18,2) COMMENT 'Current or most recent daily injection rate in barrels of water per day. Measured value from production operations system.',
    `actual_injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Current or most recent daily injection rate in thousand cubic feet per day for gas injection wells. Measured value from production operations system.',
    `api_well_number` STRING COMMENT 'Unique 10-14 digit API well number assigned by regulatory authority. Standard format: state code (2) - county code (3) - unique well identifier (5) - optional sidetrack (2).. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `completion_date` DATE COMMENT 'Date the well was completed and ready for injection operations. Marks the end of drilling and completion activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection well record was first created in the system. Used for data lineage and audit trail.',
    `cumulative_injection_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of fluid injected since well startup in barrels. Used for reservoir management, material balance calculations, and regulatory reporting.',
    `cumulative_injection_volume_mcf` DECIMAL(18,2) COMMENT 'Total volume of gas injected since well startup in thousand cubic feet. Used for gas injection and reservoir pressure maintenance tracking.',
    `first_injection_date` DATE COMMENT 'Date injection operations commenced. Marks the start of the wells operational life as an injection well.',
    `injection_depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet from surface to the injection interval midpoint along the wellbore trajectory. Used for operational planning and regulatory reporting.',
    `injection_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth in feet from surface to the injection interval midpoint. Used for pressure calculations and reservoir engineering.',
    `injection_method` STRING COMMENT 'Operational method for injection: continuous injection, cyclic steam stimulation (CSS), water alternating gas (WAG), huff and puff, or steam-assisted gravity drainage (SAGD).. Valid values are `continuous|cyclic|wag|huff_and_puff|sagd`',
    `injection_pressure_psi` DECIMAL(18,2) COMMENT 'Current wellhead injection pressure in pounds per square inch. Critical parameter for reservoir pressure maintenance and regulatory compliance.',
    `injection_type` STRING COMMENT 'Classification of injection well by primary injection purpose: water flood for pressure maintenance, gas injection for reservoir pressure support, CO2 injection for enhanced oil recovery (EOR), steam injection for thermal recovery (SAGD/CSS), or disposal for produced water disposal.. Valid values are `water_flood|gas_injection|co2_injection|steam_injection|disposal`',
    `injection_zone` STRING COMMENT 'Geological formation or zone name where injection occurs. Identifies the specific stratigraphic interval receiving injected fluids.',
    `last_injection_date` DATE COMMENT 'Date of the most recent injection activity. Used to identify inactive or shut-in wells.',
    `last_mechanical_integrity_test_date` DATE COMMENT 'Date of the most recent mechanical integrity test demonstrating well integrity and absence of fluid migration. Required every 5 years for Class II wells.',
    `max_allowable_injection_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum injection pressure authorized by regulatory permit to prevent formation fracturing or fluid migration. Typically set at 90% of fracture pressure.',
    `mechanical_integrity_test_result` STRING COMMENT 'Result of the most recent mechanical integrity test: pass (well has mechanical integrity), fail (integrity issues identified), or pending (test in progress or under review).. Valid values are `pass|fail|pending`',
    `operational_status` STRING COMMENT 'Current operational state of the injection well: active (currently injecting), inactive (temporarily not injecting), suspended (regulatory or operational hold), shut in (closed but not abandoned), abandoned (permanently ceased), or plugged and abandoned (P&A completed).. Valid values are `active|inactive|suspended|shut_in|abandoned|plugged`',
    `permit_expiration_date` DATE COMMENT 'Date the UIC permit expires and must be renewed. Critical for compliance tracking and operational planning.',
    `permit_issue_date` DATE COMMENT 'Date the UIC permit was issued by the regulatory authority. Marks the start of authorized injection operations.',
    `permitted_injection_rate_bwipd` DECIMAL(18,2) COMMENT 'Maximum daily injection rate in barrels of water per day authorized by regulatory permit. Applies to water flood and disposal wells.',
    `permitted_injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Maximum daily injection rate in thousand cubic feet per day authorized by regulatory permit. Applies to gas injection wells.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status with UIC permit conditions and regulatory requirements: compliant (meeting all requirements), non-compliant (minor violations), under review (regulatory inspection or audit in progress), or violation (significant non-compliance).. Valid values are `compliant|non_compliant|under_review|violation`',
    `spud_date` DATE COMMENT 'Date drilling operations commenced for the injection well. Marks the beginning of well construction.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the wellhead surface location in decimal degrees. Used for GIS mapping and regulatory reporting.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the wellhead surface location in decimal degrees. Used for GIS mapping and regulatory reporting.',
    `uic_well_class` STRING COMMENT 'EPA classification of injection well: Class II for oil and gas related injection (enhanced recovery and disposal), Class VI for CO2 sequestration. Determines regulatory requirements.. Valid values are `class_i|class_ii|class_iii|class_iv|class_v|class_vi`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection well record was last modified. Used for change tracking and data quality monitoring.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage ownership of working interest in the injection well. Represents the share of capital and operating costs borne by the operator or partner.',
    CONSTRAINT pk_injection_well PRIMARY KEY(`injection_well_id`)
) COMMENT 'Master record for water injection, gas injection, CO2 injection, and disposal wells supporting reservoir pressure maintenance, EOR/IOR programs, and produced water disposal. Captures injection type (water flood, gas lift supply, WAG, CSS, SAGD steam), permitted injection rate, actual injection rate (BWIPD or MMCFD), injection pressure, cumulative injection volumes, UIC permit number, and regulatory compliance status. Distinct from the producing well master — injection wells have their own operational parameters, regulatory permits, and performance metrics.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`injection_record` (
    `injection_record_id` BIGINT COMMENT 'Unique identifier for the injection record. Primary key for the injection_record product.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Injection well monitoring for UIC compliance requires drilling data (casing/cement integrity, injection zone isolation). Operators track injection performance against drilling cost for EOR project eco',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the operating company or Joint Operating Agreement (JOA) operator responsible for the injection operation.',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: EOR injection records must link to specific EOR schemes for performance tracking, incremental recovery attribution, cost allocation, partner revenue sharing under PSAs, and SEC reserves booking. Curre',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Injection records must comply with UIC permit conditions (max pressure, volume limits). Product has uic_permit_number and uic_compliance_flag. Compliance monitoring workflows require linking injection',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Injection operations incur costs (water sourcing, treatment, disposal) billed through JIB; essential for EOR cost recovery and partner allocation.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Each injection record must specify the fluid product for EOR tracking, UIC regulatory reporting, and carbon sequestration verification. Replaces denormalized injection_fluid_type with FK to product sp',
    `production_facility_id` BIGINT COMMENT 'Foreign key reference to the injection facility or plant where the injection operation is managed.',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir receiving the injected fluid for pressure maintenance or Enhanced Oil Recovery (EOR).',
    `allocation_method` STRING COMMENT 'Method used to allocate injection volumes when multiple wells share a common injection facility. Direct for individually metered wells, prorated for allocation based on well capacity or historical performance, estimated for calculated volumes, metered for direct measurement.. Valid values are `direct|prorated|estimated|metered`',
    `bottomhole_injection_pressure` DECIMAL(18,2) COMMENT 'Calculated or measured injection pressure at the bottom of the well in the reservoir zone. Used for reservoir pressure maintenance tracking and fracture gradient monitoring.',
    `bottomhole_pressure_uom` STRING COMMENT 'Unit of measure for bottomhole injection pressure. Common units: PSI (pounds per square inch), KPA (kilopascals), BAR (bar), MPA (megapascals).. Valid values are `PSI|KPA|BAR|MPA`',
    `comments` STRING COMMENT 'Free-text field for operational notes, anomalies, maintenance activities, or other contextual information related to the injection activity on this date.',
    `cumulative_injection_volume` DECIMAL(18,2) COMMENT 'Total volume of fluid injected into the well from the start of injection operations through the injection date. Used for tracking total injection for reservoir management and Underground Injection Control (UIC) permit compliance.',
    `cumulative_volume_uom` STRING COMMENT 'Unit of measure for cumulative injection volume. Common units: BBL (barrels), MCF (thousand cubic feet), MSTB (thousand pounds steam), M3 (cubic meters), MSCF (thousand standard cubic feet), KG (kilograms).. Valid values are `BBL|MCF|MSTB|M3|MSCF|KG`',
    `daily_injection_volume` DECIMAL(18,2) COMMENT 'Total volume of fluid injected on the injection date. Measured in barrels for liquids (Barrels of Water Injected Per Day - BWIPD) or thousand cubic feet for gas (Thousand Cubic Feet per Day - MCFD) or thousand pounds for steam (MSTBD).',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability and quality of the injection record data. Good for validated data, suspect for data requiring review, estimated for calculated or interpolated values, missing for incomplete data, invalid for data failing validation rules.. Valid values are `good|suspect|estimated|missing|invalid`',
    `data_source` STRING COMMENT 'Source system or method from which the injection data was captured. SCADA for Supervisory Control and Data Acquisition systems, manual for operator-entered data, PI System for OSIsoft PI historian, estimated for engineering calculations, calculated for derived values.. Valid values are `scada|manual|pi_system|estimated|calculated`',
    `eor_method` STRING COMMENT 'Specific Enhanced Oil Recovery (EOR) or Improved Oil Recovery (IOR) method employed. CO2 flood for carbon dioxide injection, steam flood for thermal recovery, polymer flood for mobility control, chemical flood for surfactant/alkaline flooding, Water Alternating Gas (WAG), Cyclic Steam Stimulation (CSS), Steam-Assisted Gravity Drainage (SAGD), or not_applicable for non-EOR injection. [ENUM-REF-CANDIDATE: co2_flood|steam_flood|polymer_flood|chemical_flood|wag|css|sagd|not_applicable — 8 candidates stripped; promote to reference product]',
    `fluid_quality_indicator` STRING COMMENT 'Qualitative or quantitative indicator of injected fluid quality. May include salinity for water, purity percentage for CO2, steam quality for thermal injection, or polymer concentration for chemical flooding.',
    `fluid_source` STRING COMMENT 'Source of the injected fluid. Examples include produced water from separation facilities, seawater for offshore waterflooding, purchased CO2 from industrial sources, or steam generated from boilers.',
    `injection_date` DATE COMMENT 'The calendar date on which the injection activity occurred. Principal business event timestamp for daily injection reporting.',
    `injection_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours the well was actively injecting fluid during the injection date. Used to calculate uptime and injection efficiency.',
    `injection_program_type` STRING COMMENT 'Classification of the injection program purpose. Waterflood for secondary recovery, gas_injection for Gas-Oil Ratio (GOR) management, Enhanced Oil Recovery (EOR) for tertiary recovery (CO2, steam, polymer), disposal for produced water disposal, pressure_maintenance for reservoir pressure support, storage for gas storage operations.. Valid values are `waterflood|gas_injection|eor|disposal|pressure_maintenance|storage`',
    `injection_rate` DECIMAL(18,2) COMMENT 'Average injection rate during the injection period, typically measured in barrels per day (BPD) for liquids or thousand cubic feet per day (MCFD) for gas. Derived from daily volume and injection duration.',
    `injection_rate_uom` STRING COMMENT 'Unit of measure for injection rate. Common units: BPD (barrels per day), MCFD (thousand cubic feet per day), M3D (cubic meters per day), MSCFD (thousand standard cubic feet per day).. Valid values are `BPD|MCFD|M3D|MSCFD`',
    `injection_status` STRING COMMENT 'Current operational status of the injection well. Active indicates normal injection operations, suspended indicates temporary halt, shut_in indicates well is closed, maintenance indicates servicing, testing indicates well test in progress, planned indicates scheduled future injection.. Valid values are `active|suspended|shut_in|maintenance|testing|planned`',
    `injection_temperature` DECIMAL(18,2) COMMENT 'Temperature of the injected fluid at the wellhead, measured in degrees Fahrenheit or Celsius. Critical for steam injection and thermal Enhanced Oil Recovery (EOR) operations.',
    `injection_temperature_uom` STRING COMMENT 'Unit of measure for injection temperature. Common units: F (Fahrenheit), C (Celsius), K (Kelvin).. Valid values are `F|C|K`',
    `injection_volume_uom` STRING COMMENT 'Unit of measure for the daily injection volume. Common units: BBL (barrels), MCF (thousand cubic feet), MSTB (thousand pounds steam), M3 (cubic meters), MSCF (thousand standard cubic feet), KG (kilograms).. Valid values are `BBL|MCF|MSTB|M3|MSCF|KG`',
    `injection_zone_depth` DECIMAL(18,2) COMMENT 'True Vertical Depth (TVD) to the top of the injection zone in feet or meters. Critical for Underground Injection Control (UIC) permit compliance and reservoir management.',
    `injection_zone_depth_uom` STRING COMMENT 'Unit of measure for injection zone depth. Common units: FT (feet), M (meters).. Valid values are `FT|M`',
    `injection_zone_name` STRING COMMENT 'Name of the geological formation or reservoir zone receiving the injected fluid. Used for reservoir management and regulatory reporting.',
    `max_allowable_injection_pressure` DECIMAL(18,2) COMMENT 'Maximum injection pressure authorized by the Underground Injection Control (UIC) permit to prevent formation fracturing and ensure containment. Measured in PSI or kPa.',
    `max_pressure_uom` STRING COMMENT 'Unit of measure for maximum allowable injection pressure. Common units: PSI (pounds per square inch), KPA (kilopascals), BAR (bar), MPA (megapascals).. Valid values are `PSI|KPA|BAR|MPA`',
    `record_created_by` STRING COMMENT 'User identifier or system account that created this injection record. Used for audit trail and accountability.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_by` STRING COMMENT 'User identifier or system account that last modified this injection record. Used for audit trail and change management.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection record was last modified. Used for audit trail and change tracking.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this injection record must be included in regulatory filings to Bureau of Safety and Environmental Enforcement (BSEE), state oil and gas commissions, or Environmental Protection Agency (EPA). True indicates reportable, False indicates internal tracking only.',
    `surface_injection_pressure` DECIMAL(18,2) COMMENT 'Injection pressure measured at the wellhead surface in pounds per square inch (PSI) or kilopascals (kPa). Critical for monitoring injection performance and preventing formation fracturing.',
    `surface_pressure_uom` STRING COMMENT 'Unit of measure for surface injection pressure. Common units: PSI (pounds per square inch), KPA (kilopascals), BAR (bar), MPA (megapascals).. Valid values are `PSI|KPA|BAR|MPA`',
    `uic_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the injection activity is in compliance with Underground Injection Control (UIC) permit conditions. True indicates compliance, False indicates violation or non-compliance.',
    `working_interest_decimal` DECIMAL(18,2) COMMENT 'Decimal representation of the Working Interest (WI) ownership percentage for the injection well. Used for cost allocation and Joint Interest Billing (JIB) in joint venture operations.',
    CONSTRAINT pk_injection_record PRIMARY KEY(`injection_record_id`)
) COMMENT 'Transactional record capturing daily injection volumes for water, gas, CO2, and steam injection wells. Stores injection date, injected fluid type, daily injection volume (BWIPD, MMCFD, MSTBD for steam), injection pressure (surface and bottomhole), cumulative injection to date, and regulatory compliance flag. Supports UIC permit compliance reporting, reservoir pressure maintenance tracking, and EOR program performance monitoring.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`run_ticket` (
    `run_ticket_id` BIGINT COMMENT 'Unique identifier for the run ticket record. Primary key for custody transfer documentation.',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation company or carrier responsible for moving the crude oil or condensate from the custody transfer point.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the purchaser or buyer entity receiving the crude oil or condensate.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Run tickets document crude oil sales and support royalty reporting (ONRR Form 2014) and production tax filings. Regulatory audit trails require linking run tickets to the filings they support for reve',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Crude oil sales and revenue accounting require well identification (API number, lease name) from drilling records for joint interest billing and royalty payments.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Run tickets document crude oil sales and must post to revenue GL accounts for revenue recognition, accounts receivable, sales reconciliation, and financial statement preparation. Essential for oil sal',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Run tickets document custody transfer and sales; basis for revenue allocation to partners, royalty calculations, and lifting entitlement reconciliation under JOAs.',
    `meter_station_id` BIGINT COMMENT 'Reference to the metering point or device used for volume measurement during custody transfer.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Run tickets document custody transfer of specific crude grades; product specification determines pricing differential and contract terms. Replaces denormalized product_type and crude_grade with proper',
    `contract_id` BIGINT COMMENT 'Reference to the sales contract or offtake agreement governing the terms of this custody transfer and sale.',
    `tank_battery_id` BIGINT COMMENT 'Reference to the tank battery facility where the custody transfer measurement occurred.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the crude oil or condensate, indicating density and quality. Higher API gravity indicates lighter, more valuable crude oil.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this run ticket was approved by authorized personnel, marking it as ready for revenue accounting.',
    `bsw_percentage` DECIMAL(18,2) COMMENT 'Percentage of non-hydrocarbon content (sediment and water) in the crude oil or condensate sample. Used to calculate net standard volume.',
    `closing_gauge_feet` DECIMAL(18,2) COMMENT 'Tank gauge reading in feet at the end of the custody transfer measurement period. Used to calculate final tank volume.',
    `closing_gauge_inches` DECIMAL(18,2) COMMENT 'Tank gauge reading in inches at the end of the custody transfer measurement period. Provides fractional precision for closing volume calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this run ticket record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this run ticket (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this run ticket is under dispute between operator and purchaser. True indicates active dispute requiring resolution.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if dispute_flag is true. Documents the nature of the disagreement for resolution tracking.',
    `driver_name` STRING COMMENT 'Name of the truck driver or operator who performed the custody transfer pickup. Used for chain-of-custody documentation.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue amount calculated as Net Standard Volume (NSV) multiplied by unit price. Basis for royalty and revenue distribution calculations.',
    `gross_standard_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of crude oil or condensate measured at standard conditions (60°F, 14.696 psia) before deductions for Basic Sediment and Water (BS&W). Principal quantitative measurement for custody transfer.',
    `measurement_date` DATE COMMENT 'Calendar date when the custody transfer measurement was performed.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the custody transfer measurement was completed. Principal business event timestamp for the run ticket transaction.',
    `meter_ticket_reference` STRING COMMENT 'Reference number linking this run ticket to the corresponding meter ticket or LACT (Lease Automatic Custody Transfer) unit record.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this run ticket record was last modified. Audit trail for record lifecycle and change tracking.',
    `net_standard_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of crude oil or condensate after deducting Basic Sediment and Water (BS&W) from Gross Standard Volume (GSV). This is the legally transferable volume used for sales and royalty calculations.',
    `observed_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure of the crude oil or condensate at the time of measurement in pounds per square inch (PSI). Used for pressure correction calculations when applicable.',
    `observed_temperature_f` DECIMAL(18,2) COMMENT 'Temperature of the crude oil or condensate at the time of measurement in degrees Fahrenheit. Used to calculate temperature correction factor.',
    `opening_gauge_feet` DECIMAL(18,2) COMMENT 'Tank gauge reading in feet at the start of the custody transfer measurement period. Used to calculate initial tank volume.',
    `opening_gauge_inches` DECIMAL(18,2) COMMENT 'Tank gauge reading in inches at the start of the custody transfer measurement period. Provides fractional precision for opening volume calculation.',
    `operator_signature` STRING COMMENT 'Name or identifier of the operator representative who authorized and signed the run ticket for custody transfer.',
    `pricing_point` STRING COMMENT 'Geographic or contractual location where pricing is determined for this custody transfer (e.g., wellhead, pipeline inlet, refinery gate).',
    `purchaser_signature` STRING COMMENT 'Name or identifier of the purchaser representative who acknowledged and signed the run ticket for custody transfer acceptance.',
    `reconciliation_date` DATE COMMENT 'Date when the run ticket was reconciled and finalized for revenue accounting and royalty distribution.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, exceptions, or special conditions related to this custody transfer run ticket.',
    `run_ticket_number` STRING COMMENT 'Externally-known business identifier for the custody transfer run ticket. Used for legal documentation and audit trails.. Valid values are `^[A-Z0-9]{6,20}$`',
    `run_ticket_status` STRING COMMENT 'Current lifecycle status of the run ticket in the custody transfer and settlement workflow.. Valid values are `draft|submitted|approved|disputed|reconciled|cancelled`',
    `seal_number` STRING COMMENT 'Unique identifier of the tamper-evident seal applied to the transport vehicle or container to ensure custody transfer integrity.. Valid values are `^[A-Z0-9]{6,15}$`',
    `sulfur_content_percentage` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the crude oil or condensate. Determines sweet vs. sour classification and affects pricing and refining requirements.',
    `temperature_correction_factor` DECIMAL(18,2) COMMENT 'Correction factor applied to convert observed volume at measured temperature to standard volume at 60°F. Calculated per API MPMS Chapter 11.1.',
    `truck_number` STRING COMMENT 'Identification number of the transport truck or tanker used to haul the crude oil or condensate from the custody transfer point.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `unit_price_per_bbl` DECIMAL(18,2) COMMENT 'Price per barrel of crude oil or condensate for this custody transfer. Used to calculate gross revenue.',
    CONSTRAINT pk_run_ticket PRIMARY KEY(`run_ticket_id`)
) COMMENT 'Transactional record documenting crude oil and condensate custody transfer measurements at the tank battery or metering point. Captures run ticket number, measurement date and time, opening and closing gauge readings, gross standard volume (GSV), net standard volume (NSV), API gravity, BS&W (basic sediment and water) percentage, temperature correction factor, purchaser/transporter identity, and meter ticket reference. Run tickets are the legal basis for crude oil sales volumes and royalty calculations. Integrates with the revenue domain for invoice generation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`gas_measurement` (
    `gas_measurement_id` BIGINT COMMENT 'Unique identifier for the gas measurement record. Primary key for the gas measurement transaction.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier of the buyer, seller, or transporter involved in the custody transfer. Used for gas sales invoicing and royalty calculations.',
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the gas sales or transportation contract associated with this measurement. Links measurement to commercial terms for pricing and invoicing.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who validated and approved the measurement. Required for audit trail and SOX compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Gas measurements drive revenue postings to GL accounts for gas sales accounting, revenue recognition, and financial statement preparation. Essential for natural gas revenue accounting and custody tran',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Gas measurements at custody transfer points drive revenue allocation, royalty calculations, partner settlements, and regulatory reporting under Joint Operating Agreements.',
    `meter_station_id` BIGINT COMMENT 'Identifier of the meter station where the gas measurement was recorded. Links to the physical meter station asset.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Gas custody transfer measurements must identify the product (sales gas, fuel gas, NGL) for contract settlement and BTU-based pricing. Required for pipeline quality specifications and commercial counte',
    `aga_calculation_method` STRING COMMENT 'Standard calculation method used for gas flow measurement. AGA-3 for orifice meters, AGA-7 for turbine meters, AGA-9 for ultrasonic meters, AGA-11 for coriolis meters.. Valid values are `AGA-3|AGA-7|AGA-9|AGA-11|ISO-5167`',
    `allocation_method` STRING COMMENT 'Method used to allocate measured gas volumes among multiple wells or owners. Proportional allocation uses well test data; priority allocation follows contractual hierarchy; test-based uses recent well tests.. Valid values are `proportional|priority|equal|manual|test_based`',
    `atmospheric_pressure_psia` DECIMAL(18,2) COMMENT 'Atmospheric pressure at the meter location in pounds per square inch absolute. Used to convert gauge pressure to absolute pressure for flow calculations.',
    `base_pressure_psia` DECIMAL(18,2) COMMENT 'Standard reference pressure for volume correction, typically 14.73 psia. Contractually defined base condition for custody transfer calculations.',
    `base_temperature_f` DECIMAL(18,2) COMMENT 'Standard reference temperature for volume correction, typically 60°F. Contractually defined base condition for custody transfer calculations.',
    `co2_content_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of carbon dioxide in the gas stream. Important for heating value calculation, pipeline quality specifications, and greenhouse gas (GHG) emissions reporting.',
    `compressibility_factor` DECIMAL(18,2) COMMENT 'Dimensionless factor accounting for deviation of real gas behavior from ideal gas law. Calculated using AGA-8 or other methods based on gas composition, temperature, and pressure.',
    `corrected_volume_mcf` DECIMAL(18,2) COMMENT 'Gas volume corrected to standard base conditions (typically 14.73 psia and 60°F) in thousand cubic feet. This is the volume used for custody transfer and sales calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the gas measurement record was first created in the system. Audit trail field for data lineage and compliance.',
    `differential_pressure_inches_h2o` DECIMAL(18,2) COMMENT 'Pressure drop across the orifice plate in inches of water column. Used in AGA-3 orifice meter flow calculations. Higher differential indicates higher flow rate.',
    `energy_content_mmbtu` DECIMAL(18,2) COMMENT 'Total energy content of the measured gas volume in million British thermal units. Calculated by multiplying corrected volume by heating value. Used for gas sales invoicing and pipeline tariff billing.',
    `estimation_method` STRING COMMENT 'Description of the method used to estimate gas volume when meter data is unavailable or invalid. Examples include historical average, adjacent meter correlation, or well test extrapolation.',
    `flowing_pressure_psig` DECIMAL(18,2) COMMENT 'Pressure of the gas at the meter during measurement in pounds per square inch gauge. Used to correct volume to standard base conditions per AGA calculation methods.',
    `flowing_temperature_f` DECIMAL(18,2) COMMENT 'Temperature of the gas at the meter during measurement in degrees Fahrenheit. Used to correct volume to standard base conditions per AGA calculation methods.',
    `h2s_content_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of hydrogen sulfide in the gas stream. Critical for safety, corrosion management, and pipeline quality specifications. Sour gas typically contains >4 ppm H2S.',
    `heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'Gross heating value of the gas in BTU per standard cubic foot. Determined by gas chromatograph analysis or calculated from gas composition. Critical for energy-based sales contracts.',
    `measurement_date` DATE COMMENT 'Calendar date of the gas measurement for daily production reporting and allocation. Used for aggregating daily production volumes (MCFD/MMCFD).',
    `measurement_end_timestamp` TIMESTAMP COMMENT 'Date and time when the gas measurement period ended. Defines the end of the custody transfer or allocation interval.',
    `measurement_number` STRING COMMENT 'Business identifier for the gas measurement transaction. Externally-known reference number used in custody transfer documentation and regulatory filings.',
    `measurement_start_timestamp` TIMESTAMP COMMENT 'Date and time when the gas measurement period began. Defines the beginning of the custody transfer or allocation interval.',
    `measurement_status` STRING COMMENT 'Current lifecycle status of the gas measurement record. Validated measurements have passed quality checks; approved measurements are ready for billing; final measurements are locked for regulatory reporting.. Valid values are `draft|validated|approved|disputed|corrected|final`',
    `measurement_type` STRING COMMENT 'Classification of the gas measurement purpose. Custody transfer measurements are used for sales and royalty calculations; allocation measurements distribute production among wells or facilities; check measurements validate meter accuracy.. Valid values are `custody_transfer|allocation|check|verification|regulatory`',
    `meter_factor` DECIMAL(18,2) COMMENT 'Correction factor applied to raw meter readings to account for meter calibration and performance characteristics. Determined through meter proving or calibration. Typically near 1.0000.',
    `meter_tube_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the meter tube in inches. Used in AGA-3 flow calculations to determine beta ratio (orifice diameter / pipe diameter).',
    `methane_content_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of methane in the gas stream. Primary component of natural gas, typically 70-90%. Used in heating value calculation and compressibility factor determination.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the gas measurement record was last modified. Audit trail field for tracking corrections and adjustments.',
    `nitrogen_content_mol_percent` DECIMAL(18,2) COMMENT 'Mole percentage of nitrogen in the gas stream. Affects heating value and compressibility. High nitrogen content reduces energy content and may require contract adjustments.',
    `orifice_plate_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the orifice plate opening in inches. Used in AGA-3 flow calculations. Must be smaller than pipe diameter to create differential pressure.',
    `quality_flag` STRING COMMENT 'Data quality indicator for the measurement. Suspect measurements require review; estimated measurements use historical averages; failed measurements indicate meter malfunction.. Valid values are `valid|suspect|estimated|failed|manual_override`',
    `raw_volume_mcf` DECIMAL(18,2) COMMENT 'Uncorrected gas volume measured at the meter in thousand cubic feet. This is the raw meter reading before applying temperature, pressure, and compressibility corrections.',
    `remarks` STRING COMMENT 'Free-text notes regarding measurement conditions, anomalies, or adjustments. Used to document meter issues, estimation rationale, or custody transfer disputes.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Ratio of the density of the gas to the density of air at standard conditions. Used in flow calculation algorithms and compressibility factor determination. Typical range 0.55 to 0.75 for natural gas.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was validated and approved for billing and regulatory reporting. Marks transition from draft to validated status.',
    CONSTRAINT pk_gas_measurement PRIMARY KEY(`gas_measurement_id`)
) COMMENT 'Transactional record capturing natural gas measurement at custody transfer and allocation meter points. Stores measurement period, meter station ID, raw gas volume (MCF), energy content (MMBtu), heating value (BTU/SCF), specific gravity, CO2 and H2S content (mol%), temperature and pressure base conditions, meter factor, and AGA calculation method (AGA-3, AGA-7, AGA-9). Supports gas sales volume determination, royalty calculations, and pipeline tariff billing. Integrates with the revenue domain for gas sales invoicing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`sharing` (
    `sharing_id` BIGINT COMMENT 'Unique identifier for the production sharing transaction record.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: PSA cost recovery and profit oil calculations require drilling AFE cost data. Government audits trace production revenue back to drilling cost for cost oil entitlement verification.',
    `field_id` BIGINT COMMENT 'Reference to the oil or gas field where production occurred.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this production is operated.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner receiving this specific entitlement allocation.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement governing this entitlement split.',
    `allocation_method` STRING COMMENT 'The methodology used to calculate entitlement splits under the PSA (volumetric, value-based, R-factor, sliding scale).. Valid values are `volumetric|value_based|hybrid|r_factor|sliding_scale`',
    `contractor_entitlement_gas_mcf` DECIMAL(18,2) COMMENT 'Total gas volume entitled to the contractor group (cost gas plus contractor profit share), measured in thousand cubic feet.',
    `contractor_entitlement_oil_bbl` DECIMAL(18,2) COMMENT 'Total oil volume entitled to the contractor group (cost oil plus contractor profit share), measured in barrels.',
    `contractor_profit_share_pct` DECIMAL(18,2) COMMENT 'Contractor groups percentage share of profit oil and profit gas for this production period under the applicable PSA tier.',
    `cost_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of gas allocated for cost recovery under the PSA terms, measured in thousand cubic feet.',
    `cost_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of oil allocated for cost recovery under the PSA terms, measured in barrels.',
    `cost_recovery_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of gross production that can be allocated to cost recovery per PSA terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production sharing record was first created in the system.',
    `cumulative_cost_recovery_balance_usd` DECIMAL(18,2) COMMENT 'Running balance of unrecovered capital and operating expenditures under the PSA cost recovery mechanism, measured in US dollars.',
    `government_profit_share_gas_mcf` DECIMAL(18,2) COMMENT 'Governments share of profit gas under the PSA split terms, measured in thousand cubic feet.',
    `government_profit_share_oil_bbl` DECIMAL(18,2) COMMENT 'Governments share of profit oil under the PSA split terms, measured in barrels.',
    `government_profit_share_pct` DECIMAL(18,2) COMMENT 'Governments percentage share of profit oil and profit gas for this production period under the applicable PSA tier.',
    `government_reporting_period` STRING COMMENT 'The regulatory reporting period (quarterly or annual) for which this production sharing data must be submitted to government authorities.. Valid values are `^d{4}-Q[1-4]$|^d{4}$`',
    `government_royalty_gas_mcf` DECIMAL(18,2) COMMENT 'Volume of gas allocated to government as royalty-in-kind under the PSA, measured in thousand cubic feet.',
    `government_royalty_oil_bbl` DECIMAL(18,2) COMMENT 'Volume of oil allocated to government as royalty-in-kind under the PSA, measured in barrels.',
    `gross_gas_production_mcf` DECIMAL(18,2) COMMENT 'Total gross natural gas production volume in thousand cubic feet (MCF) before any entitlement splits or deductions.',
    `gross_ngl_production_bbl` DECIMAL(18,2) COMMENT 'Total gross natural gas liquids production volume in barrels before any entitlement splits or deductions.',
    `gross_oil_production_bbl` DECIMAL(18,2) COMMENT 'Total gross oil production volume in barrels before any entitlement splits or deductions.',
    `jib_reference_number` STRING COMMENT 'Reference number linking this production sharing record to the corresponding joint interest billing statement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production sharing record was last updated or modified.',
    `partner_entitlement_gas_mcf` DECIMAL(18,2) COMMENT 'Gas volume entitled to this specific partner based on their working interest and NRI, measured in thousand cubic feet.',
    `partner_entitlement_oil_bbl` DECIMAL(18,2) COMMENT 'Oil volume entitled to this specific partner based on their working interest and NRI, measured in barrels.',
    `partner_net_revenue_interest_pct` DECIMAL(18,2) COMMENT 'The partners net revenue interest percentage after deducting royalties and overriding royalty interests.',
    `partner_working_interest_pct` DECIMAL(18,2) COMMENT 'The partners working interest percentage in the joint venture, used to calculate individual entitlements.',
    `period_cost_recovery_amount_usd` DECIMAL(18,2) COMMENT 'Amount of costs recovered through cost oil and cost gas in this production period, measured in US dollars.',
    `production_month` STRING COMMENT 'The calendar month of production in YYYY-MM format for reporting and aggregation purposes.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `production_period_end_date` DATE COMMENT 'The end date of the production period for which entitlements are calculated.',
    `production_period_start_date` DATE COMMENT 'The start date of the production period for which entitlements are calculated.',
    `profit_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of gas remaining after cost recovery, to be split between government and contractor per PSA terms, measured in thousand cubic feet.',
    `profit_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of oil remaining after cost recovery, to be split between government and contractor per PSA terms, measured in barrels.',
    `profit_split_tier` STRING COMMENT 'The applicable profit sharing tier based on production volume or cumulative production thresholds defined in the PSA.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|tier_6`',
    `r_factor` DECIMAL(18,2) COMMENT 'Ratio of cumulative revenue to cumulative costs used in R-factor based PSA profit sharing calculations.',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'Government royalty rate applied to gross production before cost recovery and profit split calculations.',
    `settlement_status` STRING COMMENT 'Current status of the production sharing settlement in the joint interest billing and partner reporting workflow.. Valid values are `draft|calculated|approved|settled|disputed|adjusted`',
    `valuation_price_gas_usd_per_mcf` DECIMAL(18,2) COMMENT 'Reference price used to value gas production for cost recovery and profit sharing calculations, measured in US dollars per thousand cubic feet.',
    `valuation_price_oil_usd_per_bbl` DECIMAL(18,2) COMMENT 'Reference price used to value oil production for cost recovery and profit sharing calculations, measured in US dollars per barrel.',
    CONSTRAINT pk_sharing PRIMARY KEY(`sharing_id`)
) COMMENT 'Transactional record capturing production entitlement splits under Production Sharing Agreements (PSAs) and Joint Operating Agreements (JOAs). Records production period, agreement reference, cost oil/cost gas volumes (for cost recovery), profit oil/profit gas volumes, government take (royalty-in-kind or royalty-in-value), contractor entitlement by partner, and cumulative cost recovery balance. Integrates with SAP Joint Venture Accounting for JIB processing and partner reporting. Supports PSA compliance and government reporting obligations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the production event record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Production events are authorized and tracked against AFE budgets for capital and operating expenditure control. Essential for budget variance analysis and financial reporting. Afe_number is string, ne',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production events (workovers, stimulations, treatments) are capital or operating expenses charged to cost centers. AFE tracking, actual-vs-budget reporting, capitalization decisions, and cost control ',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Workover planning (recompletion, stimulation, sidetrack) requires drilling data (casing design, cement tops, perforation intervals). Operators track event cost against original drilling AFE for lifecy',
    `field_id` BIGINT COMMENT 'Identifier of the oil or gas field where the event occurred. Links to field master data for geographic and reservoir context.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Production events (workovers, recompletions) are often AFE-authorized capital projects. Capital vs. expense classification, AFE closeout, project economics tracking, and cost control require this link',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Production events (stimulations, workovers, recompletions) are AFE-driven capital or operating expenses; costs allocated to partners via JIB statements.',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility where the event occurred. Links to facility master data.',
    `reservoir_id` BIGINT COMMENT 'Identifier of the reservoir or producing formation affected by the event. Links to reservoir master data.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Production events (stimulations, workovers, recompletions) are executed via work orders with AFE tracking. Links operational intervention to maintenance system for cost capture, schedule tracking, and',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the production event, measured in US dollars. Includes labor, materials, equipment, and contractor costs.',
    `budgeted_cost_usd` DECIMAL(18,2) COMMENT 'Planned or budgeted cost for the production event, measured in US dollars. Used for cost variance analysis.',
    `choke_bean_size_64ths` DECIMAL(18,2) COMMENT 'Size of the choke bean in 64ths of an inch for choke change events. Critical parameter for flow rate control and production optimization.',
    `comments` STRING COMMENT 'Additional free-text comments or notes about the event. Provides supplementary context not captured in structured fields.',
    `corrective_action` STRING COMMENT 'Description of corrective actions taken during or after the event to address the root cause and prevent recurrence.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the event data. Used for data governance and analytics confidence assessment.. Valid values are `verified|estimated|provisional|suspect`',
    `data_source` STRING COMMENT 'Source system or method from which the event data was captured (e.g., OSIsoft PI System, Avocet Production Operations, manual entry, SCADA).',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total production downtime caused by the event, measured in hours. Represents Non-Productive Time (NPT) for production accounting.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the production event measured in hours. Calculated from start to end timestamp or manually recorded.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the production event concluded. Used for detailed event duration analysis.',
    `event_category` STRING COMMENT 'High-level categorization of the event for reporting and analytics. Groups events by operational intent.. Valid values are `planned_maintenance|unplanned_maintenance|optimization|regulatory_compliance|emergency_response`',
    `event_date` DATE COMMENT 'The calendar date when the production event occurred or was initiated. Primary business event timestamp for the event.',
    `event_description` STRING COMMENT 'Detailed narrative description of the production event, including operational context, actions taken, and observations.',
    `event_number` STRING COMMENT 'Business-assigned unique event number or code for tracking and reference purposes.',
    `event_status` STRING COMMENT 'Current lifecycle status of the production event. Tracks the event from planning through completion.. Valid values are `planned|in_progress|completed|cancelled|deferred`',
    `event_type` STRING COMMENT 'Classification of the production event. Indicates the nature of the operational event affecting production performance. [ENUM-REF-CANDIDATE: well_workover|stimulation|recompletion|chemical_treatment|choke_change|pigging|simops_restriction|regulatory_shut_in|force_majeure|equipment_failure — 10 candidates stripped; promote to reference product]',
    `hse_incident_flag` BOOLEAN COMMENT 'Indicates whether the event involved or resulted in a Health, Safety, or Environmental incident (True) or not (False).',
    `hse_incident_number` STRING COMMENT 'Reference number of the associated HSE incident record. Links to HSE incident management system in Enablon.',
    `impacted_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Estimated gas production volume impact (positive or negative) resulting from the event, measured in thousand cubic feet. Used for production variance analysis.',
    `impacted_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Estimated oil production volume impact (positive or negative) resulting from the event, measured in barrels. Used for production variance analysis.',
    `outcome` STRING COMMENT 'Assessment of the production event outcome. Indicates whether the event achieved its intended operational objectives.. Valid values are `successful|partially_successful|unsuccessful|pending_evaluation`',
    `permit_number` STRING COMMENT 'Regulatory permit or authorization number associated with the event. Links to permit master data for compliance tracking.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this production event record was first created in the data platform. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this production event record was last modified. Used for audit trail and change tracking.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency that mandated or oversees the event (e.g., BSEE, state oil and gas commission). Applicable when regulatory_requirement_flag is True.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the event was mandated by regulatory requirements (True) or was operationally driven (False).',
    `root_cause` STRING COMMENT 'Identified root cause of the event requiring intervention. Used for failure analysis and continuous improvement.',
    `service_provider` STRING COMMENT 'Name of the third-party service company or contractor that performed the event work (e.g., Schlumberger, Halliburton, Baker Hughes).',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the production event started. Used for detailed event duration analysis.',
    `treatment_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum pressure applied during treatment operations, measured in pounds per square inch. Applicable to stimulation and workover events.',
    `treatment_type` STRING COMMENT 'Specific type of chemical or operational treatment applied during the event (e.g., acid stimulation, scale inhibitor, corrosion inhibitor, hydraulic fracturing).',
    `treatment_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of chemical or fluid treatment applied during the event, measured in barrels. Applicable to chemical treatment, stimulation, and workover events.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Transactional record capturing significant operational events affecting production at the well or facility level, including events previously tracked as standalone records (e.g., choke changes). Records event type (well workover, stimulation, recompletion, chemical treatment, choke change, pigging, SIMOPS restriction, regulatory shut-in, force majeure), event date and duration, event-specific parameters (e.g., choke bean size for choke changes, treatment volume for chemical treatments), impacted volumes, event description, and outcome. Provides an operational event log that contextualizes production performance changes and supports root cause analysis for production variance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` (
    `reservoir_pressure_id` BIGINT COMMENT 'Unique identifier for the reservoir pressure measurement record. Primary key for the reservoir pressure data product.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Pressure transient analysis and reservoir simulation require wellbore geometry (MD, TVD, deviation) and completion interval data from drilling records. Reservoir engineers use drilling data to history',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the operating company responsible for the well and pressure measurement. Used for operator-level reporting and JIB (Joint Interest Billing) allocation.',
    `field_id` BIGINT COMMENT 'Foreign key reference to the oil and gas field where the reservoir pressure measurement was recorded. Used for field-level pressure surveillance and aggregation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Pressure surveys are AFE line items; costs shared among JOA partners. Data supports reservoir management decisions and partner investment planning.',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir being monitored. Critical for reservoir-level pressure analysis and decline curve modeling.',
    `previous_reservoir_pressure_id` BIGINT COMMENT 'Self-referencing FK on reservoir_pressure (previous_reservoir_pressure_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the pressure measurement was approved. Used for audit trail and data governance.',
    `approved_by` STRING COMMENT 'Name or identifier of the engineer or supervisor who approved the pressure measurement for use in production surveillance and reserves calculations.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about the pressure measurement. May include information about test conditions, equipment issues, or interpretation notes.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for the pressure measurement. Good data has passed all validation checks; suspect data may have anomalies; estimated data is interpolated; failed data did not meet quality criteria.. Valid values are `good|suspect|estimated|failed|uncalibrated`',
    `data_source` STRING COMMENT 'Source system or method from which the pressure measurement was captured. SCADA (Supervisory Control and Data Acquisition) and PI System indicate automated real-time data; manual entry and wireline log indicate periodic measurements. [ENUM-REF-CANDIDATE: scada|pi_system|manual_entry|wireline_log|permanent_gauge|well_test|dcs — 7 candidates stripped; promote to reference product]',
    `datum_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet at which the pressure measurement was taken. Critical for converting between bottomhole and surface pressures and for reservoir engineering calculations.',
    `datum_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth in feet at which the pressure measurement was taken. Used for pressure gradient calculations and subsurface mapping. Critical for deviated and horizontal wells.',
    `flowing_pressure_psi` DECIMAL(18,2) COMMENT 'Bottomhole flowing pressure in PSI measured while the well is producing. Used to calculate productivity index and assess well performance.',
    `gauge_accuracy_rating` DECIMAL(18,2) COMMENT 'Manufacturer-specified accuracy rating of the pressure gauge as a percentage of full scale. Typical values range from 0.1% to 1.0%. Used to assess measurement uncertainty.',
    `gauge_calibration_date` DATE COMMENT 'Date when the pressure gauge was last calibrated. Critical for data quality assurance and regulatory compliance. Measurements taken with expired calibrations may be flagged for review.',
    `gauge_manufacturer` STRING COMMENT 'Name of the manufacturer of the pressure gauge instrument. Used for equipment tracking, calibration scheduling, and quality assurance.',
    `gauge_model_number` STRING COMMENT 'Model number or designation of the pressure gauge instrument. Critical for understanding gauge specifications, accuracy ratings, and calibration requirements.',
    `gauge_serial_number` STRING COMMENT 'Unique serial number of the specific pressure gauge instrument used. Enables traceability to calibration records and maintenance history.',
    `gauge_type` STRING COMMENT 'Type of pressure gauge instrument used for the measurement. Mechanical gauges are traditional analog devices; electronic and memory gauges provide digital recording; permanent downhole gauges enable continuous monitoring.. Valid values are `mechanical|electronic|memory|permanent_downhole|surface_readout|wireline`',
    `initial_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Original reservoir pressure in PSI before production began. Used as a baseline for calculating pressure depletion and recovery efficiency. Typically established from discovery well measurements.',
    `measurement_date` DATE COMMENT 'Calendar date when the reservoir pressure measurement was taken. Used for time-series analysis and decline curve modeling.',
    `measurement_number` STRING COMMENT 'Business identifier for the pressure measurement event. Externally-known reference number used in production surveillance reports and regulatory filings.',
    `measurement_status` STRING COMMENT 'Current lifecycle status of the pressure measurement record. Indicates whether the data has been quality-checked and approved for use in reserves calculations and production forecasting.. Valid values are `preliminary|validated|approved|rejected|under_review`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the reservoir pressure measurement was recorded. Captures the exact moment of the pressure reading for high-resolution surveillance.',
    `measurement_type` STRING COMMENT 'Classification of the pressure measurement method. Static measurements are taken when the well is shut-in; flowing measurements are taken during production; buildup and drawdown are transient test types.. Valid values are `static|flowing|buildup|drawdown|falloff|injection`',
    `permeability_md` DECIMAL(18,2) COMMENT 'Calculated or interpreted reservoir permeability in millidarcies derived from pressure transient analysis. Indicates the ease with which fluids flow through the reservoir rock.',
    `pressure_depletion_percent` DECIMAL(18,2) COMMENT 'Percentage of initial reservoir pressure that has been depleted. Calculated as (initial pressure - current pressure) / initial pressure * 100. Used to assess reservoir maturity and remaining reserves.',
    `pressure_depletion_psi` DECIMAL(18,2) COMMENT 'Calculated pressure decline from initial reservoir pressure to current measured pressure in PSI. Key indicator of reservoir energy depletion and recovery efficiency.',
    `pressure_gradient_psi_per_ft` DECIMAL(18,2) COMMENT 'Calculated pressure gradient in PSI per foot of depth. Derived from pressure and depth measurements. Used to identify fluid contacts, reservoir compartmentalization, and depletion patterns.',
    `pressure_value_psi` DECIMAL(18,2) COMMENT 'Measured reservoir pressure value in pounds per square inch. This is the primary quantitative result of the measurement and is used for production surveillance, decline analysis, and reserves estimation.',
    `production_rate_bopd` DECIMAL(18,2) COMMENT 'Oil production rate in BOPD (Barrels of Oil Per Day) at the time of the pressure measurement. Used to calculate productivity index and assess well performance.',
    `production_rate_mcfd` DECIMAL(18,2) COMMENT 'Gas production rate in MCFD (Thousand Cubic Feet per Day) at the time of the pressure measurement. Used for gas well performance analysis.',
    `productivity_index` DECIMAL(18,2) COMMENT 'Calculated productivity index representing the production rate per unit of pressure drawdown. Expressed as barrels per day per PSI. Key indicator of well deliverability and reservoir connectivity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this reservoir pressure record was first created in the system. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this reservoir pressure record was last modified. Used for change tracking and data governance.',
    `recorded_by` STRING COMMENT 'Name or identifier of the person or system that recorded the pressure measurement. Used for accountability and data lineage tracking.',
    `regulatory_report_number` STRING COMMENT 'Reference number of the regulatory report or filing that includes this pressure measurement. Used for audit trail and compliance verification.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this pressure measurement is required for regulatory reporting to BSEE (Bureau of Safety and Environmental Enforcement), state agencies, or SEC (Securities and Exchange Commission) reserves disclosure.',
    `service_company` STRING COMMENT 'Name of the oilfield service company that performed the pressure measurement. Used for vendor performance tracking and quality assurance.',
    `shut_in_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours that the well was shut-in prior to the pressure measurement. Critical for static pressure measurements and pressure buildup tests. Longer shut-in times allow pressure to stabilize.',
    `skin_factor` DECIMAL(18,2) COMMENT 'Dimensionless skin factor calculated from pressure transient analysis. Represents near-wellbore damage (positive skin) or stimulation (negative skin). Critical for well performance assessment.',
    `static_pressure_psi` DECIMAL(18,2) COMMENT 'Bottomhole static pressure in PSI measured when the well is shut-in and pressure has stabilized. Represents the true reservoir pressure and is used for reserves calculations and material balance analysis.',
    `temperature_f` DECIMAL(18,2) COMMENT 'Reservoir temperature in degrees Fahrenheit measured at the datum depth. Used for PVT (Pressure Volume Temperature) analysis and fluid property calculations.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the pressure test in hours. For buildup and drawdown tests, this represents the length of the transient test period.',
    `validation_method` STRING COMMENT 'Description of the quality control method applied to validate the pressure measurement. May include comparison to offset wells, trend analysis, or engineering review.',
    CONSTRAINT pk_reservoir_pressure PRIMARY KEY(`reservoir_pressure_id`)
) COMMENT 'Periodic reservoir pressure measurement records at the well or field level used for production surveillance and decline analysis, capturing gauge type, datum depth, and pressure values';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`choke_setting` (
    `choke_setting_id` BIGINT COMMENT 'Unique identifier for the choke setting record. Primary key for the choke setting entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Choke adjustments are well control operations requiring authorization by qualified production engineer or operations supervisor per API RP 14C. Regulatory compliance (BSEE, state agencies) mandates do',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Choke management and well testing require wellbore configuration (tubing size, completion type) from drilling records. Production engineers use drilling data to calculate nodal analysis and optimize f',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility associated with this choke setting. Links to the facility master data.',
    `scada_tag_id` BIGINT COMMENT 'The SCADA or PI System tag identifier for the choke position sensor. Enables integration with real-time production monitoring systems.',
    `well_test_id` BIGINT COMMENT 'Reference to the well test that informed or validated this choke setting. Links choke adjustments to production testing data.',
    `previous_choke_setting_id` BIGINT COMMENT 'Self-referencing FK on choke_setting (previous_choke_setting_id)',
    `actual_gas_rate_mcfd` DECIMAL(18,2) COMMENT 'The measured gas production rate in MCFD achieved after implementing this choke setting. Used to evaluate the effectiveness of the choke adjustment.',
    `actual_oil_rate_bopd` DECIMAL(18,2) COMMENT 'The measured oil production rate in BOPD achieved after implementing this choke setting. Used to evaluate the effectiveness of the choke adjustment.',
    `authorization_date` DATE COMMENT 'Date when the choke setting change was formally authorized by the responsible engineer or supervisor.',
    `authorization_number` STRING COMMENT 'The AFE or work order number authorizing this choke setting change. Links operational activities to capital and operating expenditure tracking.',
    `casing_pressure_psi` DECIMAL(18,2) COMMENT 'Wellhead casing pressure in PSI at the time of choke setting. Used for well integrity monitoring and gas lift optimization.',
    `change_description` STRING COMMENT 'Detailed narrative explanation of why the choke setting was changed, including operational context, reservoir conditions, and expected outcomes.',
    `change_reason` STRING COMMENT 'Business reason for the choke setting adjustment. Critical for understanding production optimization strategies and reservoir management decisions. [ENUM-REF-CANDIDATE: optimization|reservoir_pressure_decline|gas_oil_ratio_control|water_cut_management|equipment_protection|regulatory_compliance|well_test|artificial_lift_optimization|facility_constraint|other — 10 candidates stripped; promote to reference product]',
    `choke_position_percent` DECIMAL(18,2) COMMENT 'For adjustable chokes, the percentage of valve opening from fully closed (0%) to fully open (100%). Used for variable choke control in automated production systems.',
    `choke_size_64ths` DECIMAL(18,2) COMMENT 'The physical choke bean size measured in 64ths of an inch. Standard industry measurement for wellhead choke orifice diameter used to control production flow rates.',
    `choke_type` STRING COMMENT 'Classification of the choke mechanism. Fixed chokes use replaceable beans; adjustable chokes allow continuous flow control without replacement.. Valid values are `fixed|adjustable|positive|variable`',
    `comments` STRING COMMENT 'Free-text field for additional operational notes, observations, or context related to the choke setting change.',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability and validation status of this choke setting record. Used for production reporting and regulatory compliance.. Valid values are `verified|estimated|provisional|suspect|rejected`',
    `data_source` STRING COMMENT 'The system or method by which this choke setting record was captured. Critical for data quality assessment and audit trails. [ENUM-REF-CANDIDATE: manual_entry|scada|pi_system|avocet|field_report|well_test|other — 7 candidates stripped; promote to reference product]',
    `differential_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure drop across the choke in PSI. Key parameter for flow rate calculations and choke performance analysis.',
    `effective_date` DATE COMMENT 'The date when this choke setting became effective and began controlling production flow. Critical for production allocation and decline curve analysis.',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the choke setting change was implemented. Used for real-time production monitoring and SCADA integration.',
    `end_date` DATE COMMENT 'The date when this choke setting was superseded by a new setting or the well was shut in. Null if the setting is currently active.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this choke setting was changed or discontinued. Used for calculating duration of each setting period.',
    `gor_scf_bbl` DECIMAL(18,2) COMMENT 'The gas-oil ratio in SCF/BBL observed with this choke setting. Critical for reservoir management and gas handling capacity planning.',
    `implemented_by` STRING COMMENT 'Name or identifier of the field operator or technician who physically implemented the choke setting change at the wellsite.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this choke setting record was first created in the database. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this choke setting record was last modified. Used for audit trail and change tracking.',
    `setting_number` STRING COMMENT 'Business identifier for the choke setting event. Used for tracking and referencing specific choke adjustments in operational logs and reports.',
    `setting_status` STRING COMMENT 'Current lifecycle status of the choke setting. Active indicates the setting is currently controlling production; superseded indicates it has been replaced by a newer setting.. Valid values are `active|superseded|planned|cancelled`',
    `target_gas_rate_mcfd` DECIMAL(18,2) COMMENT 'The desired gas production rate in MCFD that this choke setting is intended to achieve. Critical for gas contract management and flaring minimization.',
    `target_oil_rate_bopd` DECIMAL(18,2) COMMENT 'The desired oil production rate in BOPD that this choke setting is intended to achieve. Used for production optimization and reservoir management.',
    `tubing_pressure_psi` DECIMAL(18,2) COMMENT 'Wellhead tubing pressure in PSI at the time of choke setting. Critical for understanding flow dynamics and reservoir pressure response.',
    `water_cut_percent` DECIMAL(18,2) COMMENT 'The percentage of produced fluid that is water at this choke setting. Critical for production optimization and water disposal planning.',
    `wor_ratio` DECIMAL(18,2) COMMENT 'The water-oil ratio observed with this choke setting. Used for water handling optimization and reservoir performance monitoring.',
    CONSTRAINT pk_choke_setting PRIMARY KEY(`choke_setting_id`)
) COMMENT 'Records wellhead choke size and setting changes over time for production rate management, capturing choke size (64ths inch), effective date, flow rate impact, and authorization';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`chemical` (
    `chemical_id` BIGINT COMMENT 'Unique identifier for the production chemical treatment record. Primary key for the production chemical master data.',
    `contract_id` BIGINT COMMENT 'Reference to the supply contract governing the procurement and pricing of this chemical product. Links to contract master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Chemical treatment costs are significant LOE components tracked by cost center for monthly LOE reporting, chemical optimization programs, vendor payment processing, and cost analysis. Essential for pr',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Chemical treatment programs (scale inhibitor, corrosion inhibitor) are designed based on wellbore metallurgy and completion fluids from drilling. Operators track chemical cost against drilling AFE for',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field where this chemical treatment program is applied. Links to field master data.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Chemical costs post to specific LOE GL accounts for expense recognition, LOE reporting, and cost analysis. Essential for production chemical expense accounting and ensuring proper GL account classific',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Chemical treatments (corrosion inhibitors, scale inhibitors, demulsifiers) are operating costs allocated to partners via JIB; essential for cost recovery and partner billing.',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where this chemical treatment program is applied. Links to production facility master data.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Chemical treatment programs (scale inhibitors, corrosion control, paraffin treatment) are reservoir-specific based on fluid chemistry, pressure/temperature conditions, and produced water composition. ',
    `storage_tank_id` BIGINT COMMENT 'Equipment tag or identifier for the storage tank or tote containing the chemical product at the well site or facility.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier providing the chemical product. Links to supplier or vendor master data.',
    `previous_chemical_program_id` BIGINT COMMENT 'Self-referencing FK on chemical (previous_chemical_program_id)',
    `actual_effectiveness_percent` DECIMAL(18,2) COMMENT 'Measured or observed effectiveness percentage of the chemical treatment program based on field testing and monitoring results.',
    `annual_cost_usd` DECIMAL(18,2) COMMENT 'Total annual cost in United States Dollars for the chemical treatment program including product cost, application, and monitoring.',
    `application_point` STRING COMMENT 'Specific location or equipment tag where the chemical is injected or applied (e.g., wellhead, flowline, separator inlet, storage tank).',
    `biodegradable_flag` BOOLEAN COMMENT 'Indicates whether the chemical product is biodegradable according to environmental standards (True/False). Important for offshore and environmentally sensitive operations.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to identify the chemical substance for regulatory and safety tracking.',
    `chemical_code` STRING COMMENT 'Internal or supplier-assigned unique code for the chemical product used for inventory and procurement tracking.',
    `chemical_name` STRING COMMENT 'Commercial or trade name of the chemical product used in production operations (e.g., corrosion inhibitor brand name, demulsifier product name).',
    `chemical_type` STRING COMMENT 'Classification of the chemical treatment program by primary function in production operations. [ENUM-REF-CANDIDATE: corrosion_inhibitor|scale_inhibitor|demulsifier|h2s_scavenger|paraffin_inhibitor|asphaltene_inhibitor|biocide|oxygen_scavenger|foam_control|hydrate_inhibitor — 10 candidates stripped; promote to reference product]',
    `current_inventory_gallons` DECIMAL(18,2) COMMENT 'Current on-hand inventory volume of the chemical product in gallons at the storage location.',
    `dosage_rate` DECIMAL(18,2) COMMENT 'Target dosage rate for chemical injection expressed in the unit specified by dosage_rate_uom (e.g., parts per million, gallons per day, pounds per barrel).',
    `dosage_rate_uom` STRING COMMENT 'Unit of measure for the chemical dosage rate (parts per million, gallons per day, pounds per barrel, milliliters per barrel, gallons per thousand barrels, kilograms per cubic meter).. Valid values are `ppm|gal_per_day|lb_per_bbl|ml_per_bbl|gal_per_1000_bbl|kg_per_m3`',
    `environmental_permit_number` STRING COMMENT 'Permit number or regulatory approval reference for the use or discharge of this chemical product if required by EPA, state agencies, or BSEE.',
    `environmental_permit_required_flag` BOOLEAN COMMENT 'Indicates whether an environmental permit or regulatory approval is required for the use or discharge of this chemical product (True/False).',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide content in the production stream being treated, measured in parts per million. Critical for H2S scavenger dosage calculations and HSE compliance.',
    `hazard_classification` STRING COMMENT 'Primary hazard classification of the chemical product based on GHS (Globally Harmonized System) or OSHA standards for safety and handling requirements. [ENUM-REF-CANDIDATE: non_hazardous|flammable|corrosive|toxic|oxidizer|environmental_hazard|health_hazard — 7 candidates stripped; promote to reference product]',
    `injection_method` STRING COMMENT 'Method or equipment used to inject or apply the chemical into the production system (chemical injection pump, capillary string, batch treatment, squeeze treatment, umbilical line).. Valid values are `chemical_pump|capillary_string|batch_treatment|squeeze_treatment|umbilical_line`',
    `injection_pressure_psi` DECIMAL(18,2) COMMENT 'Operating pressure at which the chemical is injected into the production system, measured in pounds per square inch.',
    `last_performance_test_date` DATE COMMENT 'Date of the most recent performance test or effectiveness evaluation for the chemical treatment program.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures the chemical product, which may differ from the supplier.',
    `monthly_usage_volume` DECIMAL(18,2) COMMENT 'Average or actual monthly consumption volume of the chemical product in the unit specified by dosage_rate_uom.',
    `next_performance_test_date` DATE COMMENT 'Scheduled date for the next performance test or effectiveness evaluation of the chemical treatment program.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production chemical treatment record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this production chemical treatment record was last modified or updated in the system.',
    `reorder_point_gallons` DECIMAL(18,2) COMMENT 'Minimum inventory threshold in gallons that triggers a reorder or replenishment of the chemical product.',
    `sds_reference_number` STRING COMMENT 'Reference number or document identifier for the Safety Data Sheet (formerly MSDS) associated with this chemical product.',
    `storage_capacity_gallons` DECIMAL(18,2) COMMENT 'Total storage capacity in gallons for the chemical product at the application point or facility.',
    `target_effectiveness_percent` DECIMAL(18,2) COMMENT 'Target effectiveness or efficiency percentage for the chemical treatment program (e.g., 95% corrosion inhibition, 90% H2S removal).',
    `treatment_end_date` DATE COMMENT 'Date when the chemical treatment program was discontinued or suspended. Null for active ongoing treatments.',
    `treatment_frequency` STRING COMMENT 'Frequency or schedule for chemical treatment application (continuous injection, batch treatment, periodic schedule, or on-demand basis). [ENUM-REF-CANDIDATE: continuous|batch|daily|weekly|monthly|as_needed|on_demand — 7 candidates stripped; promote to reference product]',
    `treatment_optimization_notes` STRING COMMENT 'Free-text field for documenting treatment optimization recommendations, performance observations, or operational notes from chemical engineers or production technicians.',
    `treatment_start_date` DATE COMMENT 'Date when the chemical treatment program was initiated at the well or facility.',
    `treatment_status` STRING COMMENT 'Current operational status of the chemical treatment program indicating whether it is actively being applied to wells or facilities.. Valid values are `active|inactive|suspended|discontinued|trial`',
    `unit_cost_usd` DECIMAL(18,2) COMMENT 'Cost per unit (gallon, pound, or liter) of the chemical product in United States Dollars for cost tracking and economic analysis.',
    CONSTRAINT pk_chemical PRIMARY KEY(`chemical_id`)
) COMMENT 'Master record for chemical treatment programs applied to producing wells and facilities including corrosion inhibitors, scale inhibitors, demulsifiers, and H2S scavengers with dosage rates and treatment schedules';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`sand_management` (
    `sand_management_id` BIGINT COMMENT 'Unique identifier for the sand management record. Primary key for the sand management product.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Sand control failure analysis requires drilling/completion data (screen type, gravel pack quality, perforation design). Operators use drilling records to diagnose sand production and plan remedial wor',
    `employee_id` BIGINT COMMENT 'Identifier of the company operating the well and responsible for sand management.',
    `field_id` BIGINT COMMENT 'Identifier of the oil and gas field where the well is located.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Sand control interventions (gravel packs, screens) are AFE items; costs shared under JOA. Monitoring data supports partner investment decisions.',
    `reservoir_id` BIGINT COMMENT 'Identifier of the reservoir from which the well is producing, as sand production characteristics vary by reservoir.',
    `previous_sand_management_id` BIGINT COMMENT 'Self-referencing FK on sand_management (previous_sand_management_id)',
    `api_well_number` STRING COMMENT 'Standardized API well number for regulatory identification and tracking.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `choke_size_64ths` STRING COMMENT 'Production choke size in 64ths of an inch at the time of sand monitoring, as choke size affects flow velocity and sand production.',
    `comments` STRING COMMENT 'Additional notes, observations, or context regarding the sand monitoring event or sand management activities.',
    `critical_sand_rate` DECIMAL(18,2) COMMENT 'Threshold sand production rate above which operational intervention or production curtailment is required to prevent equipment damage or safety hazards.',
    `critical_sand_rate_uom` STRING COMMENT 'Unit of measure for critical sand rate threshold.. Valid values are `lb_per_day|kg_per_day|lb_per_1000bbl|kg_per_m3`',
    `cumulative_sand_volume` DECIMAL(18,2) COMMENT 'Total cumulative volume of sand produced from the well since first production or since sand control installation.',
    `cumulative_sand_volume_uom` STRING COMMENT 'Unit of measure for cumulative sand volume (pounds, kilograms, barrels, or cubic meters).. Valid values are `lb|kg|bbl|m3`',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the sand monitoring data.. Valid values are `verified|estimated|suspect|failed|not_available`',
    `data_source` STRING COMMENT 'Source system or method from which the sand monitoring data was obtained.. Valid values are `scada|manual_reading|lab_analysis|acoustic_sensor|production_test|estimated`',
    `equipment_damage_description` STRING COMMENT 'Detailed description of equipment damage caused by sand production, including affected components and severity.',
    `equipment_damage_flag` BOOLEAN COMMENT 'Indicator of whether sand production has caused or is suspected to have caused damage to downhole or surface equipment.',
    `flowing_pressure_psi` DECIMAL(18,2) COMMENT 'Wellhead or tubing flowing pressure at the time of sand monitoring, as pressure drawdown influences sand production.',
    `gravel_pack_quality` STRING COMMENT 'Assessment of the gravel pack integrity and effectiveness based on installation logs, production performance, and diagnostic tests.. Valid values are `excellent|good|fair|poor|failed|not_applicable`',
    `gravel_pack_size_mesh` STRING COMMENT 'Mesh size designation of the gravel pack material used in the completion (e.g., 20/40, 12/20), indicating the range of particle sizes.. Valid values are `^[0-9]{1,3}/[0-9]{1,3}$`',
    `installation_date` DATE COMMENT 'Date when the sand control equipment or completion was installed in the well.',
    `intervention_action` STRING COMMENT 'Description of corrective or preventive action taken in response to sand production issues (e.g., choke adjustment, production curtailment, workover, chemical treatment).',
    `intervention_date` DATE COMMENT 'Date when intervention action was performed to address sand production issues.',
    `monitoring_date` DATE COMMENT 'Date when the sand production monitoring or measurement was performed.',
    `monitoring_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the sand production monitoring event occurred, including time of day.',
    `production_rate_bopd` DECIMAL(18,2) COMMENT 'Oil production rate at the time of sand monitoring, used to correlate sand production with flow rates.',
    `production_rate_mcfd` DECIMAL(18,2) COMMENT 'Gas production rate at the time of sand monitoring, used to correlate sand production with flow rates.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sand management record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sand management record was last modified in the system.',
    `sand_control_method` STRING COMMENT 'Type of sand control completion method installed in the well to manage sand production.. Valid values are `gravel_pack|frac_pack|standalone_screen|expandable_screen|chemical_consolidation|none`',
    `sand_detector_reading` DECIMAL(18,2) COMMENT 'Quantitative reading from the sand detector indicating sand production intensity or concentration.',
    `sand_detector_type` STRING COMMENT 'Type of sand detection equipment or method used for monitoring sand production.. Valid values are `acoustic|erosion|ultrasonic|clamp_on|intrusive|visual`',
    `sand_detector_uom` STRING COMMENT 'Unit of measure for the sand detector reading (parts per million, milligrams per liter, pounds per thousand barrels, kilograms per cubic meter, or acoustic counts per second).. Valid values are `ppm|mg_per_l|lb_per_1000bbl|kg_per_m3|counts_per_second`',
    `sand_management_status` STRING COMMENT 'Current operational status of sand management for the well based on monitoring results and threshold comparisons.. Valid values are `normal|warning|critical|intervention_required|offline`',
    `sand_production_rate` DECIMAL(18,2) COMMENT 'Measured rate of sand production from the well during the monitoring period.',
    `sand_production_rate_uom` STRING COMMENT 'Unit of measure for sand production rate (pounds per day, kilograms per day, pounds per thousand barrels, or kilograms per cubic meter).. Valid values are `lb_per_day|kg_per_day|lb_per_1000bbl|kg_per_m3`',
    `sand_screen_type` STRING COMMENT 'Type of sand screen installed in the well completion for mechanical sand exclusion.. Valid values are `wire_wrapped|premium_mesh|slotted_liner|prepacked|expandable|none`',
    `screen_slot_size_microns` STRING COMMENT 'Opening size of the sand screen slots measured in microns, determining the minimum particle size that will be retained.',
    CONSTRAINT pk_sand_management PRIMARY KEY(`sand_management_id`)
) COMMENT 'Records sand production monitoring and management activities for wells including sand detector readings, sand screen specifications, gravel pack details, and critical sand rate thresholds';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`flare_record` (
    `flare_record_id` BIGINT COMMENT 'Unique identifier for the flare record. Primary key for the flare_record product.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Flare events require regulatory reporting to EPA (GHGRP), state agencies, and BSEE. Product has regulatory_report_number and regulatory_submission_date fields. Compliance workflows require linking fla',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Flared gas represents economic loss and environmental liability tracked by cost center for carbon tax calculations, regulatory penalty assessment, loss reporting, and environmental compliance. Critica',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Flare reporting for GHG compliance and royalty valuation requires well identification (API number) from drilling records. Operators track flared gas against well economics and drilling cost for projec',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Flares are permitted emission sources with capacity limits, monitoring requirements (flow meters, gas composition), and emission factors. Critical for Title V permit compliance, emission inventory, an',
    `employee_id` BIGINT COMMENT 'Reference to the operating company responsible for the facility where flaring occurred.',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field where the flaring event occurred.',
    `flare_system_id` BIGINT COMMENT 'Unique identifier for the specific flare system or stack at the facility. May include multiple flare points per facility.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: When flaring is avoided through gas capture, gas is routed to terminals for processing/sales. Tracks gas conservation initiatives, monetization opportunities, and environmental compliance. Supports fl',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to hse.ghg_emission. Business justification: Flaring is a direct GHG emission source requiring quantification for EPA GHGRP Subpart W (petroleum and natural gas systems). Essential for annual GHG inventory, EPA e-GGRT submission, and ESG disclos',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Flared gas losses and environmental penalties post to specific GL accounts for loss recognition, environmental liability accounting, and regulatory reporting. Required for carbon tax accruals and envi',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Flaring impacts partner entitlements (lost revenue), regulatory compliance obligations, environmental liabilities, and may trigger JOA reporting requirements or penalties.',
    `meter_station_id` BIGINT COMMENT 'Identifier of the flow meter or measurement device used to quantify flared gas volume, if direct measurement was used.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Flared gas composition (sales gas, associated gas, sour gas) determines GHG emissions factors for EPA GHGRP reporting and carbon tax calculations. Product linkage provides heating value and emission f',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where the flaring event occurred.',
    `reservoir_id` BIGINT COMMENT 'Reference to the specific reservoir from which the flared gas originated, if applicable.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Excessive flaring or unpermitted flaring triggers regulatory violations and NOVs. Enforcement tracking requires linking flare events to resulting violations for corrective action management and penalt',
    `previous_flare_record_id` BIGINT COMMENT 'Self-referencing FK on flare_record (previous_flare_record_id)',
    `allocation_method` STRING COMMENT 'Method used to allocate flared gas volumes to specific wells or production streams when direct measurement is not available.. Valid values are `direct_measurement|estimated|prorated|well_test_based`',
    `combustion_efficiency_pct` DECIMAL(18,2) COMMENT 'Percentage of gas that is fully combusted in the flare. Typically 98% or higher for properly designed flares. Used for emissions calculations.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about the flaring event not captured in structured fields.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the flare volume data. Verified indicates direct measurement and validation, estimated indicates calculated values.. Valid values are `verified|estimated|provisional|suspect`',
    `data_source` STRING COMMENT 'Source system or method from which the flare record data was captured. Examples include OSIsoft PI System, SCADA, manual entry, or third-party measurement.',
    `economic_loss_usd` DECIMAL(18,2) COMMENT 'Estimated revenue loss from flaring the gas instead of selling it, calculated using current gas price and flared volume. Expressed in US dollars.',
    `flare_date` DATE COMMENT 'Calendar date of the flaring event for daily aggregation and reporting. Format yyyy-MM-dd.',
    `flare_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the flaring event in hours. Calculated from start and end timestamps.',
    `flare_end_timestamp` TIMESTAMP COMMENT 'Date and time when the flaring event ended. Null for ongoing flaring events. Recorded in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `flare_event_number` STRING COMMENT 'Business identifier for the flaring event. Used for tracking and regulatory reporting purposes.',
    `flare_reason_code` STRING COMMENT 'Standardized code indicating the reason for the flaring event. Used for root cause analysis and regulatory reporting. [ENUM-REF-CANDIDATE: planned_maintenance|unplanned_maintenance|startup|shutdown|emergency_relief|process_upset|equipment_failure|gas_quality|no_sales_outlet|well_testing|production_optimization|regulatory_compliance — 12 candidates stripped; promote to reference product]',
    `flare_reason_description` STRING COMMENT 'Detailed narrative description of the reason for flaring, including specific equipment, process conditions, or operational circumstances.',
    `flare_start_timestamp` TIMESTAMP COMMENT 'Date and time when the flaring event began. Recorded in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `flare_status` STRING COMMENT 'Current lifecycle status of the flare record. Active indicates ongoing flaring, completed indicates event has ended and data is finalized.. Valid values are `active|completed|cancelled|under_review`',
    `flare_type` STRING COMMENT 'Classification of the flaring event by operational pattern. Continuous flaring is ongoing, intermittent is periodic, emergency is unplanned safety relief, routine is planned operational flaring.. Valid values are `continuous|intermittent|emergency|routine`',
    `flare_volume_boe` DECIMAL(18,2) COMMENT 'Flared gas volume converted to barrel of oil equivalent using standard conversion factor (typically 6 MCF = 1 BOE). Used for economic impact analysis.',
    `flare_volume_mcf` DECIMAL(18,2) COMMENT 'Total volume of gas flared during the event measured in thousand cubic feet. Alternative unit for internal reporting.',
    `flare_volume_mscf` DECIMAL(18,2) COMMENT 'Total volume of gas flared during the event measured in thousand standard cubic feet. Primary metric for regulatory reporting and emissions calculations.',
    `gas_composition_co2_pct` DECIMAL(18,2) COMMENT 'Percentage of carbon dioxide in the flared gas stream. Critical for emissions reporting.',
    `gas_composition_ethane_pct` DECIMAL(18,2) COMMENT 'Percentage of ethane (C2H6) in the flared gas stream.',
    `gas_composition_h2s_ppm` DECIMAL(18,2) COMMENT 'Concentration of hydrogen sulfide in the flared gas measured in parts per million. Critical for safety and environmental compliance.',
    `gas_composition_methane_pct` DECIMAL(18,2) COMMENT 'Percentage of methane (CH4) in the flared gas stream. Used for greenhouse gas emissions calculations.',
    `gas_composition_propane_pct` DECIMAL(18,2) COMMENT 'Percentage of propane (C3H8) in the flared gas stream.',
    `gas_price_usd_per_mcf` DECIMAL(18,2) COMMENT 'Market price of natural gas at the time of flaring, used for economic loss calculations. Expressed in US dollars per thousand cubic feet.',
    `ghg_emissions_co2e_tonnes` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions from the flaring event expressed as carbon dioxide equivalent in metric tonnes. Calculated using EPA or IPCC methodologies.',
    `heating_value_btu_per_scf` DECIMAL(18,2) COMMENT 'Energy content of the flared gas measured in British Thermal Units per standard cubic foot. Used for economic loss calculations.',
    `measurement_method` STRING COMMENT 'Method used to measure or estimate the volume of flared gas. Direct measurement is preferred for regulatory compliance.. Valid values are `flow_meter|orifice_plate|ultrasonic|estimation|engineering_calculation`',
    `permit_number` STRING COMMENT 'Permit or authorization number issued by regulatory agency allowing the flaring activity. Required for planned flaring in many jurisdictions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this flare record was first created in the system. Format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this flare record was last modified. Format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this flaring event must be reported to regulatory agencies such as BSEE, EPA, or state oil and gas commissions.',
    `regulatory_submission_date` DATE COMMENT 'Date when the flaring event was reported to the regulatory agency. Format yyyy-MM-dd.',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the flared gas relative to air. Used for volume and emissions calculations.',
    `vented_volume_mscf` DECIMAL(18,2) COMMENT 'Volume of gas vented (released without combustion) during the event in thousand standard cubic feet. Tracked separately from flared volume for environmental compliance.',
    CONSTRAINT pk_flare_record PRIMARY KEY(`flare_record_id`)
) COMMENT 'Transactional record of gas flaring and venting volumes at production facilities, capturing flare system identifier, flare volume (MSCF), flare reason code, duration, and regulatory reporting flags';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`water_management` (
    `water_management_id` BIGINT COMMENT 'Unique identifier for the water management record. Primary key for the water management data product.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the production facility where water handling and treatment occurs. Links to the facility managing water operations.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Produced water disposal planning requires drilling data (wellbore integrity, casing design) for UIC permit applications. Operators track water handling cost against drilling AFE for total well cost an',
    `employee_id` BIGINT COMMENT 'Identifier of the company or entity responsible for water management operations. Links to the operator managing produced water handling, treatment, and disposal.',
    `field_id` BIGINT COMMENT 'Identifier of the oil and gas field where water management activities occur. Links to the geographic and operational field context.',
    `injection_well_id` BIGINT COMMENT 'Identifier of the disposal well used for water injection. Links to the injection well receiving produced water for disposal.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Water disposal costs (treatment, injection, trucking) are operating expenses allocated to partners via JIB; critical for environmental compliance and cost recovery.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Water disposal requires UIC permits for injection and NPDES permits for discharge. Compliance tracking and permit condition monitoring require linking water management records to authorizing permits. ',
    `previous_water_management_id` BIGINT COMMENT 'Self-referencing FK on water_management (previous_water_management_id)',
    `chloride_content_ppm` DECIMAL(18,2) COMMENT 'Concentration of chloride ions in the produced water measured in parts per million (PPM). High chloride levels contribute to corrosion and limit disposal and reuse options.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or explanations related to water management activities. Used to document operational issues, treatment anomalies, or regulatory communications.',
    `cumulative_disposal_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of water injected into the disposal well since the start of injection operations. Measured in barrels and tracked for regulatory reporting and reservoir monitoring.',
    `data_quality_flag` STRING COMMENT 'Indicator of the reliability and validation status of the water management data. Used to identify records requiring review or correction before regulatory reporting.. Valid values are `verified|estimated|provisional|suspect|rejected`',
    `data_source` STRING COMMENT 'Origin or system from which the water management data was captured. Indicates whether data came from automated SCADA systems, manual field entry, laboratory analysis, or other sources.. Valid values are `scada|manual_entry|pi_system|lab_analysis|third_party|estimated`',
    `discharge_water_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of treated water discharged to surface water bodies under NPDES permit authorization. Measured in barrels and subject to strict water quality standards.',
    `disposal_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for disposing of produced water during the reporting period. Measured in United States Dollars and includes injection fees, transportation, and regulatory compliance costs.',
    `disposal_method` STRING COMMENT 'Primary method used for final disposition of produced water. Indicates whether water is injected into disposal wells, discharged to surface water, recycled, or managed through other approved methods.. Valid values are `injection|discharge|evaporation|recycling|offsite_disposal|beneficial_reuse`',
    `disposed_water_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of water injected into disposal wells for permanent subsurface disposal. Measured in barrels and must comply with UIC permit limits.',
    `injection_pressure_psi` DECIMAL(18,2) COMMENT 'Surface injection pressure at the disposal well measured in pounds per square inch (PSI). Must remain below maximum allowable injection pressure to maintain mechanical integrity and prevent fracturing.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection of water management facilities and operations. Inspections verify compliance with permit conditions and environmental standards.',
    `max_allowable_injection_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum permitted surface injection pressure for the disposal well as specified in the UIC permit. Calculated to prevent formation fracturing and ensure containment.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next regulatory inspection of water management operations. Based on permit requirements and regulatory agency inspection cycles.',
    `oil_content_ppm` DECIMAL(18,2) COMMENT 'Concentration of oil and grease in the produced water measured in parts per million (PPM). Critical parameter for assessing treatment effectiveness and regulatory compliance.',
    `operational_status` STRING COMMENT 'Current operational state of the water management system. Indicates whether water handling operations are actively processing produced water.. Valid values are `active|inactive|suspended|maintenance|shutdown|testing`',
    `permit_expiration_date` DATE COMMENT 'Date on which the current water management permit expires and must be renewed. Critical for ensuring continuous authorization for disposal, discharge, or recycling operations.',
    `ph_level` DECIMAL(18,2) COMMENT 'Measure of acidity or alkalinity of the produced water on a scale of 0 to 14. Critical parameter for corrosion control, treatment process optimization, and regulatory compliance.',
    `produced_water_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of water produced from the well measured in barrels. Represents gross water production before any treatment or disposal.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when the water management record was first created in the system. Audit field for data lineage and compliance tracking.',
    `record_date` DATE COMMENT 'The calendar date for which water management activities are recorded. Primary business event date for water handling operations.',
    `record_number` STRING COMMENT 'Unique business identifier for the water management record. External reference number used for tracking and reporting water handling activities.. Valid values are `^WM-[0-9]{8}-[0-9]{4}$`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the water management record was last modified. Audit field for tracking data changes and ensuring data integrity.',
    `recycled_water_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of produced water that has been treated and reused for beneficial purposes such as hydraulic fracturing, enhanced oil recovery (EOR), or irrigation. Measured in barrels.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance state with respect to water management permits and environmental regulations. Indicates whether operations meet all applicable UIC, NPDES, and state water quality requirements.. Valid values are `compliant|non_compliant|under_review|conditional|suspended`',
    `salinity_ppm` DECIMAL(18,2) COMMENT 'Total salt concentration in the produced water measured in parts per million (PPM). Indicates the level of dissolved salts that affect treatment options and disposal methods.',
    `total_dissolved_solids_ppm` DECIMAL(18,2) COMMENT 'Concentration of dissolved minerals and salts in the water measured in parts per million (PPM). High TDS levels indicate saline or brackish water requiring specialized treatment.',
    `total_suspended_solids_ppm` DECIMAL(18,2) COMMENT 'Concentration of suspended solid particles in the water measured in parts per million (PPM). Indicates the level of particulate matter that must be removed before disposal or reuse.',
    `treated_water_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of produced water that has undergone treatment processes to remove oil, solids, and contaminants. Measured in barrels after treatment facility processing.',
    `treatment_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for treating produced water during the reporting period. Measured in United States Dollars and includes chemical costs, energy consumption, and labor.',
    `treatment_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage of contaminants removed by the water treatment process. Calculated as the reduction in contaminant concentration from influent to effluent divided by influent concentration.',
    `treatment_method` STRING COMMENT 'Primary technology or process used to treat produced water. Indicates the treatment approach employed to remove contaminants and prepare water for disposal, recycling, or discharge. [ENUM-REF-CANDIDATE: mechanical_separation|chemical_treatment|filtration|membrane_separation|thermal_treatment|biological_treatment|electrocoagulation — 7 candidates stripped; promote to reference product]',
    `water_cut_percent` DECIMAL(18,2) COMMENT 'Percentage of water in the total fluid production stream. Calculated as water volume divided by total liquid volume (oil plus water) multiplied by 100. Critical metric for reservoir performance and artificial lift optimization.',
    `water_source_type` STRING COMMENT 'Classification of the origin or type of water being managed. Distinguishes between produced water from ongoing operations, flowback from hydraulic fracturing, and other water sources.. Valid values are `produced_water|flowback_water|drilling_fluid|completion_fluid|formation_water`',
    CONSTRAINT pk_water_management PRIMARY KEY(`water_management_id`)
) COMMENT 'Records produced water handling and disposal activities including water cut tracking, water treatment volumes, disposal well injection volumes, and water recycling metrics';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`separator` (
    `separator_id` BIGINT COMMENT 'Unique identifier for the production separator equipment. Primary key for the separator master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Separators are capital assets with depreciation and maintenance costs tracked by cost center for fixed asset accounting, maintenance budget tracking, and asset retirement obligation (ARO) calculations',
    `employee_id` BIGINT COMMENT 'Reference to the operating company responsible for this separator equipment and associated production operations.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Separators are pressure vessels requiring API 510 inspection programs, integrity management, and maintenance tracking. Links operational separator to equipment registry for inspection scheduling, fitn',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Separators are facility assets; capital costs (installation, replacement) and operating costs (maintenance, inspection) are allocated to partners under JOA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Separator manufacturers are vendors for procurement, warranty claims, spare parts sourcing, and vendor qualification. Manufacturer field is denormalized string. Role prefix distinguishes from facility',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where this separator is installed. Links to production_facility master record.',
    `parent_separator_id` BIGINT COMMENT 'Self-referencing FK on separator (parent_separator_id)',
    `asset_code` BIGINT COMMENT 'Reference to the enterprise asset management system record for this separator. Links to CMMS for maintenance work orders, preventive maintenance schedules, and asset lifecycle tracking.',
    `calibration_status` STRING COMMENT 'Current calibration status of separator instrumentation including level transmitters, pressure gauges, and temperature sensors. Critical for accurate production measurement and allocation.. Valid values are `current|due|overdue|not_applicable`',
    `commissioning_date` DATE COMMENT 'Date the separator was placed into active production service after successful testing and certification.',
    `control_system_type` STRING COMMENT 'Type of control system managing separator operations including level control, pressure control, and safety shutdown systems.. Valid values are `pneumatic|electronic|plc|dcs|scada_integrated|manual`',
    `corrosion_allowance_inches` DECIMAL(18,2) COMMENT 'Additional wall thickness provided in the vessel design to account for corrosion over the equipment design life, measured in inches.',
    `design_capacity_bopd` DECIMAL(18,2) COMMENT 'Maximum rated oil throughput capacity of the separator in barrels of oil per day as specified by the manufacturer and engineering design.',
    `design_capacity_bwpd` DECIMAL(18,2) COMMENT 'Maximum rated water throughput capacity of the separator in barrels of water per day. Applicable to three-phase separators and free water knockout units.',
    `design_capacity_mmcfd` DECIMAL(18,2) COMMENT 'Maximum rated gas throughput capacity of the separator in million cubic feet per day as specified by the manufacturer and engineering design.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum allowable working pressure for which the separator vessel was designed and fabricated, measured in pounds per square inch.',
    `design_temperature_f` DECIMAL(18,2) COMMENT 'Maximum design temperature rating for the separator vessel in degrees Fahrenheit, determining material selection and pressure rating.',
    `fabrication_year` STRING COMMENT 'Year the separator vessel was fabricated and pressure tested by the manufacturer.',
    `h2s_service_flag` BOOLEAN COMMENT 'Indicates whether the separator handles fluids containing hydrogen sulfide, requiring special metallurgy and safety protocols per NACE standards.',
    `inspection_interval_months` STRING COMMENT 'Required interval in months between inspections based on regulatory requirements, risk assessment, and operating conditions.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure for separator procurement, installation, and commissioning in United States dollars. Used for depreciation calculations and AFE tracking.',
    `installation_date` DATE COMMENT 'Date the separator was installed and commissioned at the production facility.',
    `internals_type` STRING COMMENT 'Type of internal components installed in the separator for phase separation enhancement. Inlet diverters reduce inlet momentum; mist extractors remove liquid droplets from gas; weirs control liquid levels. [ENUM-REF-CANDIDATE: inlet_diverter|mist_extractor|vane_pack|weir|bucket_and_weir|centrifugal|none — 7 candidates stripped; promote to reference product]',
    `last_calibration_date` DATE COMMENT 'Date when separator instrumentation was last calibrated and certified for measurement accuracy.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection of the separator vessel and safety systems.',
    `material_specification` STRING COMMENT 'Material specification for the separator vessel construction, typically carbon steel or corrosion-resistant alloy per ASTM standards.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for next required calibration of separator measurement instrumentation.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the separator per regulatory requirements and risk-based inspection program.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure of the separator during production operations, measured in pounds per square inch. Must be below design pressure with appropriate safety margin.',
    `operating_temperature_f` DECIMAL(18,2) COMMENT 'Normal operating temperature of the separator during production operations in degrees Fahrenheit.',
    `operational_status` STRING COMMENT 'Current operational status of the separator equipment in the production system lifecycle.. Valid values are `operating|standby|maintenance|out_of_service|decommissioned`',
    `ownership_interest_pct` DECIMAL(18,2) COMMENT 'Percentage ownership interest in the separator equipment, relevant for joint venture operations and capital cost allocation.',
    `pi_system_tag` STRING COMMENT 'OSIsoft PI System tag identifier for this separator equipment, enabling real-time production data historian integration and process monitoring.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this separator master record was first created in the data system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this separator master record was last modified in the data system.',
    `replacement_value_usd` DECIMAL(18,2) COMMENT 'Current estimated cost to replace the separator with equivalent new equipment, used for insurance valuation and asset management planning.',
    `safety_relief_valve_set_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure setting at which the safety relief valve will open to protect the separator from overpressure conditions, measured in pounds per square inch.',
    `scada_tag_prefix` STRING COMMENT 'SCADA system tag prefix for all instrumentation points associated with this separator. Used for real-time data integration with OSIsoft PI System or equivalent historian.',
    `separator_name` STRING COMMENT 'Descriptive name of the separator equipment for operational reference and reporting.',
    `separator_type` STRING COMMENT 'Classification of separator based on phase separation capability. Two-phase separates gas and liquid; three-phase separates gas, oil, and water; test separator used for well testing; FWKO removes free water upstream of main separation.. Valid values are `two_phase|three_phase|test_separator|high_pressure|low_pressure|free_water_knockout`',
    `tag_number` STRING COMMENT 'Unique equipment tag number assigned to the separator per facility asset numbering convention. Used for maintenance tracking and SCADA integration.. Valid values are `^[A-Z0-9]{3,20}$`',
    `vessel_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the separator vessel in inches, key dimension for capacity and separation efficiency calculations.',
    `vessel_length_feet` DECIMAL(18,2) COMMENT 'Seam-to-seam length of the separator vessel in feet. Applicable to horizontal and vertical separators.',
    `vessel_orientation` STRING COMMENT 'Physical orientation of the separator vessel. Horizontal separators provide larger gas-liquid interface area; vertical separators have smaller footprint; spherical used for high-pressure applications.. Valid values are `horizontal|vertical|spherical`',
    CONSTRAINT pk_separator PRIMARY KEY(`separator_id`)
) COMMENT 'Master record for production separators and test separators at facilities, capturing separator type (2-phase, 3-phase), design capacity, operating pressure/temperature, and calibration status';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`meter_station` (
    `meter_station_id` BIGINT COMMENT 'Unique identifier for the meter station. Primary key for the meter station master record.',
    `employee_id` BIGINT COMMENT 'Reference to the operating company responsible for this meter station.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Meter stations contain custody transfer equipment requiring calibration, proving, and regulatory compliance (API MPMS). Links measurement system to equipment registry for calibration scheduling, audit',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field served by this meter station.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Meter stations are custody transfer points; critical for partner allocation, revenue distribution, royalty calculations, and fiscal measurement under Joint Operating Agreements.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Meter manufacturers are vendors for procurement, calibration services, spare parts, and vendor performance tracking. Manufacturer field is denormalized string. Role prefix distinguishes from operator.',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where this meter station is located.',
    `parent_meter_station_id` BIGINT COMMENT 'Self-referencing FK on meter_station (parent_meter_station_id)',
    `asset_code` BIGINT COMMENT 'Reference to the asset management system record for this meter station, used for maintenance and lifecycle tracking.',
    `calibration_frequency_days` STRING COMMENT 'Required interval in days between calibration events as specified by regulatory requirements or manufacturer recommendations.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the design capacity value, aligned with the fluid type being measured.. Valid values are `bbl_per_day|mcf_per_day|mmcf_per_day|boe_per_day`',
    `comments` STRING COMMENT 'Free-form text field for additional notes, operational remarks, or special conditions related to the meter station.',
    `commissioning_date` DATE COMMENT 'Date when the meter station was officially commissioned and approved for fiscal or allocation measurement.',
    `cost_center` STRING COMMENT 'Financial cost center code to which operating expenses and capital costs for this meter station are allocated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the meter station is located.. Valid values are `^[A-Z]{3}$`',
    `county_parish` STRING COMMENT 'County or parish jurisdiction where the meter station is located.',
    `custody_transfer_flag` BOOLEAN COMMENT 'Indicates whether this meter station serves as a custody transfer point where ownership of hydrocarbons changes hands.',
    `decommissioning_date` DATE COMMENT 'Date when the meter station was taken out of service and decommissioned.',
    `design_capacity` DECIMAL(18,2) COMMENT 'Maximum rated throughput capacity of the meter station as designed and certified by the manufacturer.',
    `fiscal_measurement_flag` BOOLEAN COMMENT 'Indicates whether this meter station is used for fiscal measurement purposes that determine revenue and royalty calculations.',
    `installation_date` DATE COMMENT 'Date when the meter station was installed and commissioned for operational use.',
    `last_calibration_date` DATE COMMENT 'Date when the meter station was most recently calibrated and certified for accuracy.',
    `last_proving_date` DATE COMMENT 'Date when the meter station was last proven using a certified prover system to establish meter factor.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the meter station location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the meter station location in decimal degrees.',
    `measurement_accuracy_class` STRING COMMENT 'Accuracy classification of the meter station per API MPMS standards, indicating the precision level for fiscal or allocation purposes.. Valid values are `class_1|class_2|class_3|class_4`',
    `measurement_fluid` STRING COMMENT 'Type of fluid being measured at this meter station.. Valid values are `crude_oil|natural_gas|ngl|condensate|water|multiphase`',
    `measurement_uncertainty_percent` DECIMAL(18,2) COMMENT 'Quantified measurement uncertainty expressed as a percentage, representing the potential variance in measured values under normal operating conditions.',
    `meter_factor` DECIMAL(18,2) COMMENT 'Correction factor derived from proving runs that adjusts raw meter readings to true volume, accounting for meter performance characteristics.',
    `meter_type` STRING COMMENT 'Technology type of the primary metering device installed at the station.. Valid values are `orifice|turbine|coriolis|ultrasonic|positive_displacement|vortex`',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration event to maintain compliance and measurement accuracy.',
    `operational_status` STRING COMMENT 'Current operational state of the meter station in its lifecycle.. Valid values are `active|inactive|maintenance|decommissioned|suspended|testing`',
    `ownership_interest_pct` DECIMAL(18,2) COMMENT 'Percentage ownership interest of the operator in this meter station, relevant for joint venture operations.',
    `pi_system_tag` STRING COMMENT 'OSIsoft PI System tag identifier for real-time data integration and historian storage of meter station measurements.',
    `proving_method` STRING COMMENT 'Method used to prove the meter and establish the meter factor, per API MPMS Chapter 4 standards.. Valid values are `pipe_prover|tank_prover|master_meter|small_volume_prover`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter station record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter station record was most recently updated in the system.',
    `regulatory_permit_number` STRING COMMENT 'Permit or authorization number issued by regulatory agencies for operation of this meter station.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether measurements from this meter station must be included in regulatory production reports to BSEE, state agencies, or other governing bodies.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this meter station is integrated with SCADA systems for real-time monitoring and data acquisition.',
    `state_province` STRING COMMENT 'State or province jurisdiction where the meter station is located, relevant for regulatory reporting.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the meter station for identification in operational systems and regulatory filings.',
    `station_name` STRING COMMENT 'Business name or designation of the meter station for operational reference and reporting.',
    `station_type` STRING COMMENT 'Classification of the meter station based on its primary business function: fiscal (revenue measurement), allocation (production distribution), custody transfer (ownership change point), check (verification), proving (calibration), or test (well testing).. Valid values are `fiscal|allocation|custody_transfer|check|proving|test`',
    CONSTRAINT pk_meter_station PRIMARY KEY(`meter_station_id`)
) COMMENT 'Master record for fiscal and allocation metering stations at production facilities, capturing meter type, calibration schedule, proving records, and measurement uncertainty';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`esp_performance` (
    `esp_performance_id` BIGINT COMMENT 'Unique identifier for the ESP performance record. Primary key for the ESP performance transactional data product.',
    `artificial_lift_id` BIGINT COMMENT 'Foreign key reference to the artificial lift equipment master record for this specific ESP installation.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: ESP design and troubleshooting require wellbore geometry (deviation, dogleg severity) and completion data from drilling. Operators use drilling records to diagnose pump failures and optimize run life.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the operating company responsible for the ESP installation and well operations.',
    `field_id` BIGINT COMMENT 'Foreign key reference to the oil and gas field where the ESP is operating. Used for field-level performance aggregation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: ESP installations and replacements are AFE line items; operating costs (power, maintenance) are allocated via JIB. Performance data supports partner investment decisions.',
    `production_facility_id` BIGINT COMMENT 'Foreign key reference to the production facility managing this ESP installation.',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the producing reservoir. Links ESP performance to reservoir characteristics and depletion analysis.',
    `scada_tag_id` BIGINT COMMENT 'Unique identifier for the SCADA or PI System tag associated with this ESP measurement point. Enables traceability to real-time data historian.',
    `previous_esp_performance_id` BIGINT COMMENT 'Self-referencing FK on esp_performance (previous_esp_performance_id)',
    `alarm_code` STRING COMMENT 'System-generated alarm or fault code indicating abnormal operating conditions. Used for automated diagnostics and maintenance triggering.',
    `alarm_description` STRING COMMENT 'Human-readable description of the alarm or fault condition. Provides operational context for troubleshooting and incident response.',
    `casing_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure measured at the wellhead casing in pounds per square inch. Used for well integrity monitoring and intake pressure calculation.',
    `comments` STRING COMMENT 'Free-text field for operational notes, observations, or contextual information about the ESP performance measurement.',
    `data_quality_flag` STRING COMMENT 'Indicator of measurement data quality and reliability. Used for data validation and regulatory reporting compliance.. Valid values are `good|suspect|bad|estimated|manual`',
    `data_source` STRING COMMENT 'System or method used to capture the ESP performance measurement. Typically OSIsoft PI System, SCADA, DCS, or manual entry.. Valid values are `pi_system|scada|dcs|manual|avocet|historian`',
    `differential_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure difference between discharge and intake in pounds per square inch. Represents the total head developed by the pump.',
    `discharge_pressure_psi` DECIMAL(18,2) COMMENT 'Fluid pressure at the ESP pump discharge in pounds per square inch. Used to calculate pump head and efficiency.',
    `fluid_level_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth to the fluid level in the annulus in feet. Used to calculate pump intake pressure and submergence.',
    `fluid_rate_bfpd` DECIMAL(18,2) COMMENT 'Total fluid production rate including oil and water in barrels of fluid per day (BFPD). Used for pump sizing and performance validation.',
    `intake_pressure_psi` DECIMAL(18,2) COMMENT 'Fluid pressure at the ESP pump intake in pounds per square inch. Critical parameter for pump performance analysis and gas lock detection.',
    `measurement_date` DATE COMMENT 'Calendar date of the ESP performance measurement for daily aggregation and reporting purposes.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the ESP performance measurement was recorded. Primary business event timestamp for real-time monitoring via OSIsoft PI System or SCADA integration.',
    `motor_current_amps` DECIMAL(18,2) COMMENT 'Electric current drawn by the ESP motor in amperes. Key indicator of motor load and pump performance. Monitored continuously via SCADA for artificial lift optimization.',
    `motor_temperature_f` DECIMAL(18,2) COMMENT 'Operating temperature of the ESP motor in degrees Fahrenheit. High temperatures indicate potential failure risk and trigger maintenance alerts.',
    `motor_voltage_volts` DECIMAL(18,2) COMMENT 'Operating voltage supplied to the ESP motor in volts. Critical for power quality monitoring and equipment protection.',
    `operating_frequency_hz` DECIMAL(18,2) COMMENT 'Current operating frequency of the variable speed drive controlling the ESP motor in hertz. Used for production rate optimization.',
    `operational_status` STRING COMMENT 'Current operational state of the ESP system at the time of measurement. Critical for production optimization and downtime tracking. [ENUM-REF-CANDIDATE: running|stopped|starting|shutdown|alarm|fault|maintenance — 7 candidates stripped; promote to reference product]',
    `power_consumption_kwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by the ESP system in kilowatt-hours during the measurement period. Used for operating expense calculation and energy optimization.',
    `production_rate_bopd` DECIMAL(18,2) COMMENT 'Fluid production rate in barrels of oil per day (BOPD) during the measurement period. Correlates ESP performance with well productivity.',
    `pump_efficiency_percent` DECIMAL(18,2) COMMENT 'Calculated hydraulic efficiency of the ESP as a percentage. Key performance indicator for artificial lift optimization and energy management.',
    `pump_setting_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the ESP is set in the wellbore in feet. Critical for calculating bottomhole pressure and pump performance.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this ESP performance record was first created in the data product. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this ESP performance record was last modified. Supports change tracking and data governance requirements.',
    `run_life_days` STRING COMMENT 'Number of days the ESP has been operating since installation or last restart. Key metric for reliability analysis and Mean Time Between Failures (MTBF) calculation.',
    `submergence_ft` DECIMAL(18,2) COMMENT 'Vertical distance in feet between the fluid level and the pump intake. Adequate submergence prevents gas lock and ensures stable pump operation.',
    `target_frequency_hz` DECIMAL(18,2) COMMENT 'Desired operating frequency setpoint for the ESP variable speed drive in hertz. Used for automated control and optimization.',
    `tubing_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure measured at the wellhead tubing in pounds per square inch. Indicates flowing conditions and surface equipment backpressure.',
    `vibration_mils` DECIMAL(18,2) COMMENT 'Vibration amplitude measured in mils (thousandths of an inch). Excessive vibration indicates mechanical issues such as bearing wear, shaft misalignment, or pump damage.',
    `work_order_number` STRING COMMENT 'Reference to the maintenance work order if this measurement was taken during or after maintenance activity. Links to CMMS system such as Maximo.',
    CONSTRAINT pk_esp_performance PRIMARY KEY(`esp_performance_id`)
) COMMENT 'Transactional record tracking Electric Submersible Pump (ESP) performance parameters including motor current, intake pressure, discharge pressure, vibration, and pump efficiency for artificial lift optimization';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`production_working_interest` (
    `production_working_interest_id` BIGINT COMMENT 'Primary key for production_working_interest',
    `joa_id` BIGINT COMMENT 'Foreign key reference to the Joint Operating Agreement that governs this working interest. Links to the contract that defines operational rights, voting procedures, and cost allocation rules.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to the production well in which the partner holds working interest. Enables aggregation of partner interests across wells and well-level revenue/cost allocation.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the venture partner who holds the working interest. Enables partner-level reporting of portfolio interests and revenue entitlements.',
    `working_interest_id` BIGINT COMMENT 'Unique system identifier for this working interest record. Primary key for the association.',
    `acquisition_date` DATE COMMENT 'Date when the partner acquired this working interest through purchase, farm-in, or assignment. Used for asset tracking and regulatory change-of-operator reporting.',
    `carried_interest_flag` BOOLEAN COMMENT 'Boolean indicator of whether this partners interest is carried (costs paid by other partners) under a farm-in or carry agreement. Carried partners receive revenue but do not pay proportionate costs until payout conditions are met.',
    `created_date` TIMESTAMP COMMENT 'System timestamp when this working interest record was created in the system.',
    `disposition_date` DATE COMMENT 'Date when the partner disposed of this working interest through sale, farm-out, or assignment. Null for currently held interests.',
    `effective_date` DATE COMMENT 'Date when this working interest ownership became effective. Critical for time-based revenue and cost allocation. Typically corresponds to JOA execution date, farm-in effective date, or acquisition closing date.',
    `expiry_date` DATE COMMENT 'Date when this working interest ownership expires or was terminated. Null for active interests. Used for historical interest tracking and revenue allocation cutoff.',
    `interest_type` STRING COMMENT 'Classification of the economic interest type. Working-interest = cost-bearing operating interest; Royalty-interest = landowner non-cost-bearing interest; Overriding-royalty = carved-out non-cost-bearing interest; Production-payment = limited-term revenue interest; Net-profits-interest = revenue after costs.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The partners percentage entitlement to revenue from production after deducting royalties, overriding royalties, and other burdens. NRI is typically less than WI due to royalty burdens. Used for revenue distribution and production accounting.',
    `non_consent_status` STRING COMMENT 'Status of the partners participation election for this well. Consenting = partner approved AFE and pays costs; Non-consent = partner declined to participate and forfeits revenue until penalty recovered; Forced-pooled = regulatory pooling order; Pending = AFE vote outstanding.',
    `operator_flag` BOOLEAN COMMENT 'Boolean indicator of whether this partner is the designated operator for this well under the JOA. Only one partner per well should have operator_flag = true. Operator has day-to-day operational control and submits AFEs.',
    `payout_status` STRING COMMENT 'Indicator of whether the well has reached payout for this partner under carry or reversionary interest terms. Pre-payout = costs still being recovered; Post-payout = cost recovery complete, interest may revert; Not-applicable = no payout provisions.',
    `percentage` DECIMAL(18,2) COMMENT 'The partners percentage ownership of capital costs and operating expenses for this well. Expressed as a decimal percentage (e.g., 25.5000 for 25.5%). Sum of all WI percentages for a well typically equals 100%. Used for AFE cost allocation and joint interest billing.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Boolean flag indicating whether this working interest requires regulatory filing with state or federal agencies (e.g., BSEE Form APD, state change-of-operator notice). Used to trigger compliance workflows.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this working interest record.',
    `updated_date` TIMESTAMP COMMENT 'System timestamp when this working interest record was last modified.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this working interest record.',
    CONSTRAINT pk_production_working_interest PRIMARY KEY(`production_working_interest_id`)
) COMMENT 'This association product represents the ownership and operational participation relationship between a production well and a venture partner. It captures the partners economic interest, revenue entitlement, and operational role in a specific well. Each record links one production well to one partner with attributes that define the partners financial stake, operational responsibilities, and participation terms in that well. This is the foundational SSOT for joint venture accounting, revenue distribution, AFE cost allocation, and regulatory ownership reporting.. Existence Justification: In oil and gas joint venture operations, a production well has multiple partners who each hold distinct working interest and net revenue interest percentages, and a partner holds interests in multiple wells across their portfolio. The business actively manages these working interest relationships as operational records with specific percentages, effective dates, operator designations, carried interest terms, and non-consent elections. This is the foundational relationship for joint venture accounting, AFE cost allocation, revenue distribution, and regulatory ownership reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` (
    `facility_plant_supply_id` BIGINT COMMENT 'Unique identifier for the facility-to-plant supply contract record. Primary key.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the downstream petrochemical plant that receives hydrocarbon feedstock',
    `pipeline_connection_id` BIGINT COMMENT 'Unique identifier for the physical pipeline or transportation infrastructure connecting the production facility to the petrochemical plant. References midstream pipeline network assets.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to the upstream production facility that supplies hydrocarbon feedstock',
    `contract_capacity_bopd` DECIMAL(18,2) COMMENT 'Contracted liquid hydrocarbon delivery capacity in barrels of oil per day (BOPD) from the production facility to the petrochemical plant. Represents the committed supply volume for NGLs, condensate, or crude feedstock.',
    `contract_capacity_mmcfd` DECIMAL(18,2) COMMENT 'Contracted natural gas delivery capacity in million cubic feet per day (MMCFD) from the production facility to the petrochemical plant. Represents the committed supply volume for gas feedstock to steam crackers or GTL units.',
    `contract_status` STRING COMMENT 'Current operational status of the facility-to-plant supply contract. Indicates whether feedstock delivery is active, temporarily suspended, or contract is under renegotiation.',
    `contract_type` STRING COMMENT 'Commercial structure of the supply contract. Firm contracts guarantee delivery, interruptible contracts allow curtailment, take-or-pay requires minimum offtake regardless of actual consumption.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this facility-to-plant supply contract record was created in the system.',
    `effective_date` DATE COMMENT 'Date when the facility-to-plant supply contract becomes active and feedstock delivery commitments begin. Used for contract lifecycle management and supply planning.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this facility-to-plant supply contract record was last updated.',
    `primary_feedstock_type` STRING COMMENT 'Main hydrocarbon product type delivered under this supply contract (e.g., Natural Gas, Ethane, Propane, Butane, Condensate, Crude Oil). Determines compatibility with petrochemical plant feedstock requirements.',
    `termination_date` DATE COMMENT 'Date when the facility-to-plant supply contract expires or is terminated. Null for evergreen contracts. Used for contract renewal planning and feedstock sourcing strategy.',
    `transportation_tariff` DECIMAL(18,2) COMMENT 'Transportation fee or tariff rate charged for moving hydrocarbon feedstock from the production facility to the petrochemical plant. Typically expressed in USD per barrel or USD per MMBTU. Critical for integrated margin optimization and transfer pricing.',
    CONSTRAINT pk_facility_plant_supply PRIMARY KEY(`facility_plant_supply_id`)
) COMMENT 'This association product represents the supply contract between production facilities and petrochemical plants. It captures the commercial and operational arrangements for hydrocarbon feedstock delivery from upstream production facilities (gas plants, CPFs, wellpads) to downstream petrochemical manufacturing plants. Each record links one production facility to one petrochemical plant with contract capacity commitments, transportation arrangements, tariff rates, and effective dates that exist only in the context of this supply relationship.. Existence Justification: In integrated oil and gas operations, production facilities (gas plants, central processing facilities, wellpads) supply hydrocarbon feedstock to multiple downstream petrochemical plants through pipeline networks and gathering systems. Conversely, petrochemical plants source feedstock from multiple upstream production facilities to ensure supply reliability, optimize feedstock quality blending, and manage operational flexibility. The business actively manages these supply relationships as commercial contracts with capacity commitments, transportation arrangements, tariff rates, and effective dates.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` (
    `facility_offtake_allocation_id` BIGINT COMMENT 'Unique identifier for this facility-offtake allocation record. Primary key.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to the offtake agreement receiving allocated capacity',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to the production facility providing capacity under this allocation',
    `allocated_capacity_bopd` DECIMAL(18,2) COMMENT 'Oil production capacity allocated from this facility to this offtake agreement, measured in barrels of oil per day. Represents the contractual entitlement for this buyer from this specific facility.',
    `allocated_capacity_mmcfd` DECIMAL(18,2) COMMENT 'Natural gas production capacity allocated from this facility to this offtake agreement, measured in million cubic feet per day. Used when the offtake agreement covers gas production.',
    `allocation_end_date` DATE COMMENT 'Date when this facility stops supplying production to this offtake agreement. Nullable for open-ended allocations. Used to manage facility transitions and contract amendments.',
    `allocation_start_date` DATE COMMENT 'Date when this facility begins supplying production to this offtake agreement. May differ from the offtake agreement effective date if the agreement sources from multiple facilities with staggered start dates.',
    `allocation_status` STRING COMMENT 'Current operational status of this facility-offtake allocation. ACTIVE = currently supplying, SUSPENDED = temporarily halted (force majeure, maintenance), EXPIRED = allocation period ended, AMENDED = superseded by new allocation terms.',
    `blending_allowed_flag` BOOLEAN COMMENT 'Indicates whether production from this facility can be blended with production from other facilities to fulfill this offtake agreement. False when buyer requires segregated production for quality specifications or regulatory tracking.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system. Used for audit trail of commercial contract amendments.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this allocation record. Tracks changes to capacity allocations, priority rankings, or nomination rights.',
    `nomination_rights` STRING COMMENT 'Type of nomination rights the buyer holds for this facility allocation. FIRM = guaranteed capacity, INTERRUPTIBLE = subject to curtailment, CONDITIONAL = requires advance notice, SWING = flexible within range. Determines operational priority during capacity constraints.',
    `priority_rank` STRING COMMENT 'Priority ranking of this offtake agreement relative to other agreements drawing from the same facility. Lower numbers indicate higher priority. Used to resolve competing claims when facility throughput is constrained. Critical for take-or-pay dispute resolution.',
    CONSTRAINT pk_facility_offtake_allocation PRIMARY KEY(`facility_offtake_allocation_id`)
) COMMENT 'This association product represents the capacity allocation contract between production facilities and offtake agreements. It captures the specific volume commitments, time periods, and nomination rights that govern how production capacity from a facility is allocated to fulfill offtake obligations. Each record links one production facility to one offtake agreement with attributes that exist only in the context of this allocation relationship. Critical for production planning, revenue assurance, and managing competing offtake obligations across shared infrastructure.. Existence Justification: In oil-and-gas commercial operations, production facilities commonly supply multiple offtake agreements simultaneously (different buyers, different products, or time-shared capacity allocation), and offtake agreements routinely source from multiple facilities to ensure supply security, enable blending for quality specifications, and manage production variability. The allocation relationship is actively managed by commercial teams who track capacity commitments, priority rankings, and nomination rights for each facility-agreement pairing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`facility_working_interest` (
    `facility_working_interest_id` BIGINT COMMENT 'Unique identifier for this facility working interest record. Primary key.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement or Production Sharing Agreement that governs this partners interest in the facility. Links to contract management system.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to the production facility in which the partner holds an interest',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner holding the interest',
    `billing_entity_code` STRING COMMENT 'Code identifying the legal entity to which joint interest bills should be sent for this partners share of facility costs. May differ from the partners primary entity due to subsidiary structures.',
    `carried_interest_flag` BOOLEAN COMMENT 'Indicates whether this partners interest is carried (costs paid by other partners) until a specified payout threshold. Common in farm-in agreements where the farmor carries the farmee through drilling and completion.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate facility operating costs to this partner. WORKING_INTEREST = costs allocated per working interest percentage, REVENUE_INTEREST = costs allocated per revenue share, CUSTOM = special allocation per agreement, FIXED_FEE = partner pays fixed monthly fee.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this partners interest in the facility became effective. Used for production allocation and cost recovery calculations. Typically the closing date of the farm-in, acquisition, or JOA execution.',
    `expiry_date` DATE COMMENT 'Date when this partners interest in the facility expires or was divested. Null for active interests. Used to track historical ownership for audit and regulatory reporting.',
    `interest_status` STRING COMMENT 'Current lifecycle status of this working interest. ACTIVE = partner is receiving production and paying costs, SUSPENDED = temporarily inactive, DIVESTED = interest sold or transferred, PENDING_TRANSFER = awaiting regulatory approval for transfer.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was last modified.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether this partner is designated as the operator for this facility. Only one partner per facility should have this flag set to true. The operator is responsible for day-to-day operations and submits joint interest billings to non-operators.',
    `ownership_interest_percentage` DECIMAL(18,2) COMMENT 'The partners ownership interest percentage in the production facility. Represents the partners share of reserves and production entitlement. Must sum to 100% across all partners for a given facility.',
    `payout_status` STRING COMMENT 'Current payout status for carried or back-in interests. NOT_APPLICABLE = no carry arrangement, PRE_PAYOUT = costs still being carried, POST_PAYOUT = payout achieved and partner now paying costs, PARTIAL_PAYOUT = some cost categories paid.',
    `regulatory_approval_number` STRING COMMENT 'Government or regulatory body approval number for this partners interest in the facility. Required in jurisdictions where ownership transfers must be approved by mineral rights authorities.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners working interest percentage in the production facility. Represents the partners share of operating costs and capital expenditures. May differ from ownership interest due to carried interests or back-in provisions.',
    CONSTRAINT pk_facility_working_interest PRIMARY KEY(`facility_working_interest_id`)
) COMMENT 'This association product represents the ownership and operational interest relationship between production facilities and joint venture partners. It captures the legal and financial participation of each partner in a production facility, including ownership percentages, operator designation, and cost allocation methods. Each record links one production facility to one partner with attributes that define the partners specific interest in that facility.. Existence Justification: In oil and gas joint venture operations, production facilities are routinely co-owned by multiple partners under Joint Operating Agreements (JOAs) or Production Sharing Agreements (PSAs). A single processing plant, FPSO, or gathering station can have 2-10+ partners each holding different ownership and working interest percentages. Conversely, a single partner (e.g., Shell, ExxonMobil, or a national oil company) participates in dozens or hundreds of facilities across multiple fields and basins. The business actively manages these working interests for production allocation, joint interest billing, revenue distribution, and regulatory reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` (
    `well_contract_allocation_id` BIGINT COMMENT 'Unique system identifier for this well-to-contract allocation record. Primary key.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to the term contract receiving allocated production from this well',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to the production well whose output is being allocated to this term contract',
    `allocated_volume_bbl` DECIMAL(18,2) COMMENT 'Specific volume of oil production in barrels allocated from this well to this term contract for the allocation period. Used for fixed-volume allocations and contract fulfillment tracking.',
    `allocated_volume_mcf` DECIMAL(18,2) COMMENT 'Specific volume of natural gas production in thousand cubic feet allocated from this well to this term contract for the allocation period. Used for gas contract fulfillment.',
    `allocation_end_date` DATE COMMENT 'Date when this well-to-contract allocation ceases. Nullable for ongoing allocations. Used to track historical allocations and contract transitions.',
    `allocation_method` STRING COMMENT 'Methodology used to calculate allocation from this well to this contract: percentage (fixed percentage split), fixed_volume (specific volume commitment), priority_waterfall (sequential priority-based), pro_rata (proportional based on contract commitments).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the wells total production allocated to this term contract. Used for proportional allocation models where multiple contracts share well output. Must be between 0.00 and 100.00.',
    `allocation_start_date` DATE COMMENT 'Date when this well-to-contract allocation becomes effective and production begins flowing to this contract. Critical for time-based allocation changes and contract transitions.',
    `allocation_status` STRING COMMENT 'Current operational status of this allocation: active (currently allocating production), suspended (temporarily halted), expired (allocation period ended), pending (scheduled future allocation).',
    `contract_priority` STRING COMMENT 'Priority ranking for this contract allocation when multiple contracts compete for the same well production. Lower numbers indicate higher priority (1 = highest). Used in allocation waterfall logic and take-or-pay contract fulfillment.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system. Used for audit trail and allocation history tracking.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record. Used for change tracking and reconciliation.',
    `notes` STRING COMMENT 'Free-text field for business context, special instructions, or allocation-specific comments (e.g., joint venture agreements, regulatory requirements, temporary allocation adjustments).',
    `created_by` STRING COMMENT 'User or system identifier that created this allocation record. Used for audit and accountability.',
    CONSTRAINT pk_well_contract_allocation PRIMARY KEY(`well_contract_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between production wells and term contracts in oil and gas commercial operations. It captures the assignment of well production volumes to specific term contracts, enabling split allocations across multiple buyers, contract periods, and priority hierarchies. Each record links one production well to one term contract with allocation-specific attributes including volume splits, time periods, percentages, and delivery priorities that exist only in the context of this commercial allocation relationship.. Existence Justification: In oil and gas commercial operations, production from a single well is routinely allocated across multiple term contracts to fulfill obligations to different buyers, contract periods, or joint venture partners. Conversely, a single term contract typically receives production from multiple wells to meet volume commitments. This allocation relationship is actively managed by commercial operations teams who track volume splits, allocation percentages, time periods, and contract priorities for each well-contract pairing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` (
    `well_afe_assignment_id` BIGINT COMMENT 'Unique system identifier for this well-AFE assignment record. Primary key.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to the AFE that authorizes and funds the work on this well',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to the production well that is the subject of the AFE expenditure',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cumulative costs incurred for this specific well under this AFE, representing the well-level slice of total AFE expenditures. Critical for well-level economic analysis and for reconciling multi-well AFE performance.',
    `afe_phase` STRING COMMENT 'The phase or type of work that this AFE covers for this specific well: drilling (initial wellbore construction), completion (well completion and stimulation), workover (remedial work on producing well), facility (surface equipment and infrastructure), abandonment (plugging and abandonment), or other project types. Critical for understanding which lifecycle stage the costs apply to.',
    `assignment_status` STRING COMMENT 'Current status of this well-AFE assignment: planned (AFE approved but work not yet started), active (work in progress), completed (work finished and costs reconciled), cancelled (AFE assignment cancelled before completion). Supports operational tracking and reporting.',
    `budget_variance` DECIMAL(18,2) COMMENT 'The budget variance (allocated budget minus actual cost) for this specific well under this AFE. Negative values indicate cost overruns at the well level. Enables well-level budget performance tracking even when the overall AFE may be on budget.',
    `completion_date` DATE COMMENT 'The date when the work covered by this AFE for this specific well was completed and the AFE assignment was closed out. Enables calculation of project duration and supports cost reconciliation at the well-AFE level.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total AFE budget allocated to this specific well, used when a single AFE covers multiple wells (e.g., pad drilling program where one AFE covers 8 wells, each well might be allocated 12.5% of costs). Enables proportional cost tracking and variance analysis at the well level.',
    `cost_center` STRING COMMENT 'The accounting cost center code used for tracking costs for this well-AFE assignment, enabling integration with financial systems and supporting cost allocation across organizational units.',
    `effective_date` DATE COMMENT 'The date when this well-AFE assignment became effective, typically the date when work commenced or the AFE was formally assigned to the well. Used for temporal tracking of which AFE was active for which well during which time period.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context about this well-AFE assignment, such as special circumstances, scope changes, or operational considerations that affect cost allocation or project execution.',
    `primary_well_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary well for this AFE (true) or a secondary well in a multi-well AFE (false). For single-well AFEs, this is always true. For multi-well AFEs (e.g., pad drilling), one well is designated as primary for reporting purposes.',
    CONSTRAINT pk_well_afe_assignment PRIMARY KEY(`well_afe_assignment_id`)
) COMMENT 'This association product represents the formal linkage between a production well and an Authorization for Expenditure (AFE) that funds specific work on that well. It captures the phase-specific cost allocation, timing, and budget performance for each well-AFE pairing. Each record links one production well to one AFE with attributes that track the financial relationship across the well lifecycle (drilling, completion, workover, abandonment). This enables tracking of multi-well AFEs (pad drilling programs covering 6-10 wells) and multi-AFE wells (a single well accumulating costs across 5+ AFEs over 20+ years).. Existence Justification: In oil and gas operations, wells accumulate costs across multiple AFEs throughout their lifecycle (initial drilling AFE, completion AFE, multiple workover AFEs over 20+ years, eventual abandonment AFE), and AFEs frequently cover multiple wells simultaneously (pad drilling programs authorize 6-10 wells under a single AFE, field-wide projects span dozens of wells). The business actively manages these well-AFE assignments to track phase-specific costs, allocate multi-well AFE budgets proportionally, and analyze well-level economic performance across the asset lifecycle.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`scada_tag` (
    `scada_tag_id` BIGINT COMMENT 'Primary key for scada_tag',
    `equipment_id` BIGINT COMMENT 'Identifier of the equipment to which the tag is attached.',
    `parent_scada_tag_id` BIGINT COMMENT 'Self-referencing FK on scada_tag (parent_scada_tag_id)',
    `alarm_enabled` BOOLEAN COMMENT 'Indicates whether alarm monitoring is active for this tag.',
    `alarm_message` STRING COMMENT 'Custom message displayed when an alarm condition is triggered.',
    `alarm_severity` STRING COMMENT 'Severity level assigned to the alarm when limits are breached.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration of the tag.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the tag record was first created in the data lake.',
    `data_type` STRING COMMENT 'Underlying data type of the tag value as stored in the historian.',
    `decommission_date` DATE COMMENT 'Date on which the tag was retired from active use.',
    `scada_tag_description` STRING COMMENT 'Free‑form description of the tag purpose and context.',
    `display_precision` STRING COMMENT 'Number of decimal places to display for the tag value.',
    `engineering_range_max` DECIMAL(18,2) COMMENT 'Maximum valid engineering value for the tag.',
    `engineering_range_min` DECIMAL(18,2) COMMENT 'Minimum valid engineering value for the tag.',
    `facility` STRING COMMENT 'Name of the facility or plant where the tag is located.',
    `high_limit` DECIMAL(18,2) COMMENT 'Upper threshold that triggers a high alarm condition.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the tag has been archived and is no longer actively collected.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the tag is considered critical for safety or production.',
    `last_calibrated_timestamp` TIMESTAMP COMMENT 'Date‑time when the tag was last calibrated.',
    `low_limit` DECIMAL(18,2) COMMENT 'Lower threshold that triggers a low alarm condition.',
    `offset` DECIMAL(18,2) COMMENT 'Additive offset applied after scaling to calibrate the measurement.',
    `retention_policy` STRING COMMENT 'Data retention rule applied to the tags historical values.',
    `sampling_rate_hz` DECIMAL(18,2) COMMENT 'Frequency at which the tag value is sampled, expressed in Hertz.',
    `scaling_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor applied to raw sensor value to obtain engineering units.',
    `source_system` STRING COMMENT 'Originating system that provides the tag data.',
    `scada_tag_status` STRING COMMENT 'Current operational status of the tag.',
    `tag_address` STRING COMMENT 'System address or path (e.g., OPC node ID) that uniquely locates the tag in the source system.',
    `tag_category` STRING COMMENT 'High‑level grouping of the tag based on its functional area.',
    `tag_code` STRING COMMENT 'Unique business code or identifier assigned to the tag by the control system.',
    `tag_comments` STRING COMMENT 'Additional free‑form notes about the tag.',
    `tag_group` STRING COMMENT 'Logical group name used to organize related tags.',
    `tag_interface` STRING COMMENT 'Communication interface used to acquire the tag value.',
    `tag_name` STRING COMMENT 'Human‑readable name of the tag used in reports and dashboards.',
    `tag_owner` STRING COMMENT 'Department or team responsible for the tag.',
    `tag_source` STRING COMMENT 'Origin of the tag data (e.g., sensor, instrument, derived calculation).',
    `tag_subsystem` STRING COMMENT 'Name of the subsystem or module that the tag belongs to.',
    `tag_type` STRING COMMENT 'Category of the tag indicating the nature of the measurement (e.g., analog, digital, status, derived).',
    `unit_of_measure` STRING COMMENT 'Physical unit associated with the tag value (e.g., psi, bbl/day, °C).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the tag record.',
    CONSTRAINT pk_scada_tag PRIMARY KEY(`scada_tag_id`)
) COMMENT 'Master reference table for scada_tag. Referenced by scada_tag_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`field` (
    `field_id` BIGINT COMMENT 'Primary key for field',
    `operator_id` BIGINT COMMENT 'Identifier of the operating company responsible for the field.',
    `basin_name` STRING COMMENT 'Geological basin in which the field resides.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the field is located.',
    `county` STRING COMMENT 'County or district containing the field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the field record was first created in the system.',
    `cumulative_gas_produced` DECIMAL(18,2) COMMENT 'Total gas produced to date, measured in thousand standard cubic feet (Mscf).',
    `cumulative_oil_produced` DECIMAL(18,2) COMMENT 'Total oil produced to date, measured in barrels.',
    `current_production_bopd` DECIMAL(18,2) COMMENT 'Current oil production rate in barrels of oil per day.',
    `field_description` STRING COMMENT 'Free‑form description of the fields characteristics and history.',
    `discovery_date` DATE COMMENT 'Date the field was first discovered.',
    `field_classification` STRING COMMENT 'Current operational classification of the field.',
    `field_code` STRING COMMENT 'Unique alphanumeric code assigned to the field by the company.',
    `field_depth_ft` STRING COMMENT 'Average true vertical depth of the field in feet.',
    `field_name` STRING COMMENT 'Human‑readable name of the oil or gas field.',
    `field_type` STRING COMMENT 'Geological/operational classification of the field.',
    `first_production_date` DATE COMMENT 'Date the field produced its first oil or gas.',
    `gas_oil_ratio` DECIMAL(18,2) COMMENT 'Ratio of gas produced to oil produced, measured in standard cubic feet per barrel.',
    `joint_venture_share_percent` DECIMAL(18,2) COMMENT 'Percentage ownership interest held by joint‑venture partners.',
    `last_production_date` DATE COMMENT 'Date of the most recent production reporting.',
    `last_report_date` DATE COMMENT 'Date the most recent regulatory report was filed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the fields central point.',
    `lease_name` STRING COMMENT 'Name of the lease or concession covering the field.',
    `lease_number` STRING COMMENT 'Official lease number assigned by the regulatory authority.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the fields central point.',
    `notes` STRING COMMENT 'Additional remarks, operational notes, or exceptions related to the field.',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable regulatory bodies.',
    `reporting_status` STRING COMMENT 'Status of the fields required regulatory reporting.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate applied to production, expressed as a percent.',
    `state_province` STRING COMMENT 'State or province of the field location.',
    `field_status` STRING COMMENT 'Current lifecycle status of the field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the field record.',
    `water_cut_percent` DECIMAL(18,2) COMMENT 'Percentage of water in the produced fluid stream.',
    CONSTRAINT pk_field PRIMARY KEY(`field_id`)
) COMMENT 'Master reference table for field. Referenced by field_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`flare_system` (
    `flare_system_id` BIGINT COMMENT 'Primary key for flare_system',
    `parent_flare_system_id` BIGINT COMMENT 'Self-referencing FK on flare_system (parent_flare_system_id)',
    `bsee_reportable_flag` BOOLEAN COMMENT 'Indicates if the flare system is subject to BSEE reporting requirements.',
    `capacity_mmbtu_per_day` DECIMAL(18,2) COMMENT 'Maximum thermal capacity of the flare system measured in million British thermal units per day.',
    `control_method` STRING COMMENT 'Method used to control combustion and emissions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the flare system record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the flare system was permanently taken out of service, if applicable.',
    `emission_rate_kg_per_hour` DECIMAL(18,2) COMMENT 'Measured average emission rate during operation in kilograms per hour.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.',
    `installation_date` DATE COMMENT 'Date the flare system was installed and became operational.',
    `is_remote_monitored` BOOLEAN COMMENT 'Indicates whether the flare system is monitored remotely via SCADA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or internal inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the flare system location.',
    `location` STRING COMMENT 'Identifier of the physical location or facility where the flare system is installed.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the flare system location.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the flare system.',
    `model_number` STRING COMMENT 'Model designation assigned by the manufacturer.',
    `flare_system_name` STRING COMMENT 'Human readable name of the flare system.',
    `reporting_status` STRING COMMENT 'Regulatory reporting status for the flare system.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer.',
    `flare_system_status` STRING COMMENT 'Current lifecycle status of the flare system.',
    `system_code` STRING COMMENT 'External code used to reference the flare system in operational systems.',
    `flare_system_type` STRING COMMENT 'Classification of the flare system based on the type of fluid handled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the flare system record.',
    CONSTRAINT pk_flare_system PRIMARY KEY(`flare_system_id`)
) COMMENT 'Master reference table for flare_system. Referenced by flare_system_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`injection_pattern` (
    `injection_pattern_id` BIGINT COMMENT 'Primary key for injection_pattern',
    `parent_injection_pattern_id` BIGINT COMMENT 'Self-referencing FK on injection_pattern (parent_injection_pattern_id)',
    `compliance_flag` STRING COMMENT 'Regulatory domain(s) for which the pattern is approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pattern record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) representing confidence in the patterns data quality.',
    `injection_pattern_description` STRING COMMENT 'Free‑text description providing context, purpose, and operational notes for the pattern.',
    `effective_from` TIMESTAMP COMMENT 'Exact moment the injection pattern becomes operationally active.',
    `effective_until` TIMESTAMP COMMENT 'Exact moment the injection pattern ceases to be operationally active (nullable).',
    `end_date` DATE COMMENT 'Date when the injection pattern is retired or expires.',
    `fluid_type` STRING COMMENT 'Primary fluid used in the injection pattern.',
    `injection_rate` DECIMAL(18,2) COMMENT 'Nominal injection rate value for the pattern.',
    `injection_rate_unit` STRING COMMENT 'Unit of measure for the injection rate.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this pattern is the default selection for new wells.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the pattern record.',
    `notes` STRING COMMENT 'Additional remarks or comments from engineers or regulators.',
    `pattern_code` STRING COMMENT 'Short alphanumeric code used to reference the pattern in operational systems.',
    `pattern_name` STRING COMMENT 'Human‑readable name describing the injection pattern.',
    `pattern_type` STRING COMMENT 'Category of injection pattern based on fluid or method.',
    `regulatory_approval_date` DATE COMMENT 'Date when the pattern received formal regulatory approval.',
    `regulatory_approval_number` STRING COMMENT 'Identifier of the regulatory approval document.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the pattern definition.',
    `start_date` DATE COMMENT 'Date when the injection pattern becomes effective.',
    `injection_pattern_status` STRING COMMENT 'Current lifecycle status of the injection pattern.',
    `target_pressure` DECIMAL(18,2) COMMENT 'Target pressure to be maintained during injection.',
    `target_pressure_unit` STRING COMMENT 'Unit of measure for the target pressure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pattern record.',
    `version_number` STRING COMMENT 'Sequential version of the pattern definition for change control.',
    CONSTRAINT pk_injection_pattern PRIMARY KEY(`injection_pattern_id`)
) COMMENT 'Master reference table for injection_pattern. Referenced by pattern_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`storage_tank` (
    `storage_tank_id` BIGINT COMMENT 'Primary key for storage_tank',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or site where the tank is located.',
    `parent_storage_tank_id` BIGINT COMMENT 'Self-referencing FK on storage_tank (parent_storage_tank_id)',
    `capacity_volume` DECIMAL(18,2) COMMENT 'Maximum volume the tank can hold as designed, expressed in the unit defined by volume_unit.',
    `commissioning_date` DATE COMMENT 'Date the tank entered operational service.',
    `compliance_certification` STRING COMMENT 'Most recent certification type held by the tank.',
    `corrosion_monitoring_method` STRING COMMENT 'Technique used to monitor corrosion on the tank.',
    `corrosion_rate_mm_per_year` DECIMAL(18,2) COMMENT 'Measured average corrosion loss per year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `current_volume` DECIMAL(18,2) COMMENT 'Present amount of product stored in the tank, expressed in volume_unit.',
    `decommission_date` DATE COMMENT 'Date the tank was retired or removed from service, if applicable.',
    `elevation_m` DOUBLE COMMENT 'Elevation of the tank above mean sea level, expressed in meters.',
    `installation_date` DATE COMMENT 'Date the tank was installed at the site.',
    `last_certification_date` DATE COMMENT 'Date when the most recent certification was issued.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance was performed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the tanks central point in decimal degrees.',
    `leak_detection_system` STRING COMMENT 'System employed to detect leaks from the tank.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the tanks central point in decimal degrees.',
    `maintenance_interval_days` STRING COMMENT 'Standard interval between routine maintenance activities.',
    `material` STRING COMMENT 'Construction material of the tank shell.',
    `storage_tank_name` STRING COMMENT 'Human‑readable name or label for the storage tank.',
    `next_certification_due` DATE COMMENT 'Scheduled date for the next required certification.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the tank.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Current operating pressure of the tank.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Current operating temperature of the tank.',
    `operator_company` STRING COMMENT 'Company responsible for day‑to‑day operation of the tank.',
    `owner_company` STRING COMMENT 'Legal entity that owns the tank.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum allowable internal pressure, expressed in pounds per square inch.',
    `product_type` STRING COMMENT 'Primary commodity stored in the tank.',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable regulations.',
    `safety_class` STRING COMMENT 'Regulatory safety class assigned to the tank.',
    `storage_tank_status` STRING COMMENT 'Current operational status of the tank.',
    `tank_number` STRING COMMENT 'Official alphanumeric identifier assigned to the tank by the organization.',
    `temperature_rating_c` DECIMAL(18,2) COMMENT 'Maximum allowable operating temperature in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `volume_unit` STRING COMMENT 'Unit of measure for capacity and current volume (e.g., barrels, cubic meters, gallons).',
    CONSTRAINT pk_storage_tank PRIMARY KEY(`storage_tank_id`)
) COMMENT 'Master reference table for storage_tank. Referenced by storage_tank_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`scada_system` (
    `scada_system_id` BIGINT COMMENT 'Primary key for scada_system',
    `parent_scada_system_id` BIGINT COMMENT 'Self-referencing FK on scada_system (parent_scada_system_id)',
    `communication_protocol` STRING COMMENT 'Primary industrial communication protocol used by the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCADA system record was first created in the data lake.',
    `data_rate_hz` DECIMAL(18,2) COMMENT 'Maximum sampling frequency of the SCADA system in hertz.',
    `decommission_date` DATE COMMENT 'Date the SCADA system was retired or taken out of service (null if still active).',
    `scada_system_description` STRING COMMENT 'Free‑form description of the system’s purpose, scope, and key characteristics.',
    `hardware_model` STRING COMMENT 'Model identifier for the SCADA hardware platform.',
    `installation_date` DATE COMMENT 'Date the SCADA system was installed and commissioned.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the SCADA system.',
    `is_licensed` BOOLEAN COMMENT 'True if the system currently holds a valid software license.',
    `is_remote_accessible` BOOLEAN COMMENT 'True if the system can be accessed remotely for monitoring or control.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which preventive maintenance was performed.',
    `license_expiration_date` DATE COMMENT 'Date on which the software license for the SCADA system expires.',
    `mac_address` STRING COMMENT 'Hardware MAC address of the SCADA system’s network interface.',
    `maintenance_interval_days` STRING COMMENT 'Planned number of days between scheduled maintenance activities.',
    `scada_system_name` STRING COMMENT 'Human‑readable name of the SCADA system as used in operations.',
    `site_location` STRING COMMENT 'Identifier of the physical site or facility where the SCADA system is deployed.',
    `scada_system_status` STRING COMMENT 'Current operational state of the SCADA system.',
    `supported_data_formats` STRING COMMENT 'Enumerated list of data serialization formats the system can produce.',
    `system_code` STRING COMMENT 'External code or tag that uniquely identifies the SCADA system within the enterprise (e.g., vendor‑assigned model number).',
    `system_type` STRING COMMENT 'Category of SCADA system functionality.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SCADA system record.',
    `vendor_name` STRING COMMENT 'Name of the company that supplied the SCADA system.',
    `version` STRING COMMENT 'Version string of the SCADA software release installed.',
    CONSTRAINT pk_scada_system PRIMARY KEY(`scada_system_id`)
) COMMENT 'Master reference table for scada_system. Referenced by scada_system_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`tank_battery` (
    `tank_battery_id` BIGINT COMMENT 'Primary key for tank_battery',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the tank battery is located.',
    `parent_tank_battery_id` BIGINT COMMENT 'Self-referencing FK on tank_battery (parent_tank_battery_id)',
    `capacity_barrels` DECIMAL(18,2) COMMENT 'Design capacity of the tank battery in barrels.',
    `tank_battery_code` STRING COMMENT 'Unique alphanumeric code assigned to the tank battery.',
    `corrosion_rate_mm_per_year` DECIMAL(18,2) COMMENT 'Measured corrosion rate in millimeters per year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tank battery record was created in the system.',
    `current_volume_barrels` DECIMAL(18,2) COMMENT 'Current volume of product stored in the tank battery (barrels).',
    `decommission_date` DATE COMMENT 'Date the tank battery was decommissioned or removed from service.',
    `tank_battery_description` STRING COMMENT 'Free‑text description of the tank battery, including any special notes.',
    `external_code` STRING COMMENT 'Identifier used in external asset management system.',
    `installation_date` DATE COMMENT 'Date the tank battery was installed and became operational.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the tank battery is classified as critical for production continuity.',
    `last_corrosion_inspection_date` DATE COMMENT 'Date of the most recent corrosion inspection.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the tank battery.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the tank battery location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the tank battery location.',
    `maintenance_status` STRING COMMENT 'Current maintenance status of the tank battery.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer of the tank battery.',
    `material` STRING COMMENT 'Material construction of the tank battery.',
    `max_flow_rate_bpd` DECIMAL(18,2) COMMENT 'Maximum flow rate in barrels per day.',
    `model_number` STRING COMMENT 'Manufacturer model number for the tank battery.',
    `tank_battery_name` STRING COMMENT 'Human readable name of the tank battery.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next inspection.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Current operating pressure measured in psi.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Current operating temperature measured in Celsius.',
    `owner_department` STRING COMMENT 'Internal department responsible for the tank battery.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum allowable pressure rating in psi.',
    `product_type` STRING COMMENT 'Primary product type stored in the tank battery.',
    `safety_valve_present` BOOLEAN COMMENT 'Indicates if a safety valve is installed on the tank battery.',
    `serial_number` STRING COMMENT 'Serial number assigned by the manufacturer.',
    `tank_battery_status` STRING COMMENT 'Current operational lifecycle status of the tank battery.',
    `temperature_rating_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature rating in Celsius.',
    `tank_battery_type` STRING COMMENT 'Physical configuration type of the tank battery.',
    `unit_of_measure` STRING COMMENT 'Unit of measure used for volume attributes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tank battery record.',
    CONSTRAINT pk_tank_battery PRIMARY KEY(`tank_battery_id`)
) COMMENT 'Master reference table for tank_battery. Referenced by tank_battery_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`working_interest` (
    `working_interest_id` BIGINT COMMENT 'Primary key for working_interest',
    `lease_id` BIGINT COMMENT 'Identifier of the lease or field to which this interest applies.',
    `party_id` BIGINT COMMENT 'Identifier of the party (company or individual) that holds the interest.',
    `parent_working_interest_id` BIGINT COMMENT 'Self-referencing FK on working_interest (parent_working_interest_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interest record was first created in the system.',
    `working_interest_description` STRING COMMENT 'Free‑text description providing additional context about the interest.',
    `effective_from` DATE COMMENT 'Date when the interest becomes legally effective.',
    `effective_until` DATE COMMENT 'Date when the interest expires or is terminated; null if open‑ended.',
    `interest_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the interest type within the enterprise.',
    `interest_name` STRING COMMENT 'Human‑readable name of the interest (e.g., Working Interest, Net Revenue Interest).',
    `interest_type` STRING COMMENT 'Classification of the interest category governing rights and obligations.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this interest is the primary interest for the associated lease or asset.',
    `last_review_date` DATE COMMENT 'Date when the interest record was last reviewed for accuracy or compliance.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments about the interest.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage share of ownership or entitlement represented by this interest.',
    `reporting_category` STRING COMMENT 'Regulatory reporting domain for the interest (e.g., SEC, BSEE, state agency).',
    `source_system` STRING COMMENT 'Name of the upstream operational system that supplied the interest data (e.g., OSIsoft_PI, Avocet).',
    `working_interest_status` STRING COMMENT 'Current lifecycle status of the interest record.',
    `tax_classification` STRING COMMENT 'Tax treatment applicable to the interest for reporting purposes.',
    `unit_of_measure` STRING COMMENT 'Unit used for the ownership percentage, typically percent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the interest record.',
    CONSTRAINT pk_working_interest PRIMARY KEY(`working_interest_id`)
) COMMENT 'Master reference table for working_interest. Referenced by working_interest_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`pipeline_connection` (
    `pipeline_connection_id` BIGINT COMMENT 'Primary key for pipeline_connection',
    `contract_id` BIGINT COMMENT 'Identifier of the contract governing the connection.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or terminal at the connection end.',
    `parent_pipeline_connection_id` BIGINT COMMENT 'Self-referencing FK on pipeline_connection (parent_pipeline_connection_id)',
    `capacity_m3_per_day` DECIMAL(18,2) COMMENT 'Maximum designed flow capacity of the connection.',
    `compliance_status` STRING COMMENT 'Current compliance standing with applicable regulations.',
    `connection_code` STRING COMMENT 'External code or tag used by operations to reference the connection.',
    `connection_name` STRING COMMENT 'Human‑readable name describing the pipeline connection.',
    `connection_type` STRING COMMENT 'Category of the connection based on its purpose or origin.',
    `construction_year` STRING COMMENT 'Calendar year the connection was constructed.',
    `corrosion_rate_mm_per_year` DECIMAL(18,2) COMMENT 'Estimated annual corrosion loss for the pipeline segment.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated capital cost of the connection in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the connection was officially taken out of service.',
    `pipeline_connection_description` STRING COMMENT 'Free‑form text describing the connection, its purpose, and any special notes.',
    `diameter_inch` DECIMAL(18,2) COMMENT 'Nominal internal diameter of the pipeline segment.',
    `end_date` DATE COMMENT 'Planned or actual date when the connection ceased operation (nullable).',
    `end_latitude` DOUBLE COMMENT 'Geographic latitude of the connection end point.',
    `end_longitude` DOUBLE COMMENT 'Geographic longitude of the connection end point.',
    `external_reference_code` STRING COMMENT 'Identifier used in external asset management systems.',
    `flow_direction` STRING COMMENT 'Designated direction of fluid flow through the connection.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `is_critical` BOOLEAN COMMENT 'True if the connection is deemed critical to production continuity.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the connection.',
    `leak_detection_system` STRING COMMENT 'System used to detect leaks on the connection.',
    `maintenance_schedule` STRING COMMENT 'Planned frequency of maintenance activities.',
    `material` STRING COMMENT 'Material composition of the pipeline (e.g., steel, composite).',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature the connection is rated for.',
    `monitoring_status` STRING COMMENT 'Current status of continuous monitoring equipment.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Design operating pressure for the connection.',
    `operator_company` STRING COMMENT 'Company responsible for day‑to‑day operation.',
    `owner_company` STRING COMMENT 'Legal owner of the pipeline connection.',
    `pipeline_id` BIGINT COMMENT 'Identifier of the parent pipeline.',
    `regulatory_reporting_required` STRING COMMENT 'Indicates whether the connection must be reported to regulatory bodies.',
    `risk_category` STRING COMMENT 'Risk classification based on criticality, age, and condition.',
    `start_date` DATE COMMENT 'Date when the connection became operational.',
    `start_latitude` DOUBLE COMMENT 'Geographic latitude of the connection start point.',
    `start_longitude` DOUBLE COMMENT 'Geographic longitude of the connection start point.',
    `pipeline_connection_status` STRING COMMENT 'Current operational status of the connection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer warranty expires.',
    CONSTRAINT pk_pipeline_connection PRIMARY KEY(`pipeline_connection_id`)
) COMMENT 'Master reference table for pipeline_connection. Referenced by pipeline_connection_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `address_line1` STRING COMMENT 'Primary street address of the facility.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `bsee_permit_number` STRING COMMENT 'Permit identifier issued by the Bureau of Safety and Environmental Enforcement.',
    `capacity_bopd` DECIMAL(18,2) COMMENT 'Maximum oil production capacity expressed in barrels of oil per day.',
    `capacity_mcfpd` DECIMAL(18,2) COMMENT 'Maximum gas production capacity expressed in thousand cubic feet per day.',
    `city` STRING COMMENT 'City where the facility is located.',
    `commissioning_date` DATE COMMENT 'Date the facility entered commercial operation.',
    `compliance_status` STRING COMMENT 'Regulatory compliance standing of the facility.',
    `country` STRING COMMENT 'Three‑letter country code of the facility location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was first created.',
    `decommission_date` DATE COMMENT 'Date the facility was permanently shut down or removed from service.',
    `facility_description` STRING COMMENT 'Narrative description of the facilitys purpose and characteristics.',
    `environmental_status` STRING COMMENT 'Current environmental compliance status.',
    `facility_category` STRING COMMENT 'High‑level classification of the facility within the oil‑and‑gas value chain.',
    `facility_code` STRING COMMENT 'External business identifier or code assigned to the facility.',
    `facility_type` STRING COMMENT 'Category of the facility based on its primary function.',
    `installation_date` DATE COMMENT 'Date the facility was initially installed or constructed.',
    `is_active` BOOLEAN COMMENT 'True if the facility is currently active in the system.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the facility is deemed critical to operations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which maintenance was performed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the facility location.',
    `lifecycle_status` STRING COMMENT 'Lifecycle phase of the facility from construction to retirement.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the facility location.',
    `maintenance_interval_days` STRING COMMENT 'Scheduled interval between routine maintenance activities.',
    `max_pressure_psi` DECIMAL(18,2) COMMENT 'Design pressure limit of the facility in pounds per square inch.',
    `max_temperature_f` DECIMAL(18,2) COMMENT 'Design temperature limit of the facility in degrees Fahrenheit.',
    `facility_name` STRING COMMENT 'Human‑readable name of the facility.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the upcoming inspection.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the facility.',
    `operational_status` STRING COMMENT 'Current operating condition of the facility.',
    `operator_name` STRING COMMENT 'Name of the company or entity operating the facility.',
    `owner_name` STRING COMMENT 'Legal owner of the facility.',
    `region` STRING COMMENT 'Geological basin or operational region where the facility resides.',
    `safety_status` STRING COMMENT 'Safety condition of the facility based on recent incidents.',
    `state` STRING COMMENT 'State or province code (3‑letter) of the facility location.',
    `state_permit_number` STRING COMMENT 'State‑issued permit identifier for the facility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the facility record.',
    `zip_code` STRING COMMENT 'Postal or ZIP code for the facility address.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by facility_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `oil_gas_ecm`.`production`.`facility`(`facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `oil_gas_ecm`.`production`.`scada_system`(`scada_system_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `oil_gas_ecm`.`production`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_injection_pattern_id` FOREIGN KEY (`injection_pattern_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_pattern`(`injection_pattern_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_tank_battery_id` FOREIGN KEY (`tank_battery_id`) REFERENCES `oil_gas_ecm`.`production`.`tank_battery`(`tank_battery_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ADD CONSTRAINT `fk_production_reservoir_pressure_previous_reservoir_pressure_id` FOREIGN KEY (`previous_reservoir_pressure_id`) REFERENCES `oil_gas_ecm`.`production`.`reservoir_pressure`(`reservoir_pressure_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ADD CONSTRAINT `fk_production_choke_setting_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ADD CONSTRAINT `fk_production_choke_setting_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `oil_gas_ecm`.`production`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ADD CONSTRAINT `fk_production_choke_setting_previous_choke_setting_id` FOREIGN KEY (`previous_choke_setting_id`) REFERENCES `oil_gas_ecm`.`production`.`choke_setting`(`choke_setting_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `oil_gas_ecm`.`production`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_previous_chemical_program_id` FOREIGN KEY (`previous_chemical_program_id`) REFERENCES `oil_gas_ecm`.`production`.`chemical`(`chemical_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ADD CONSTRAINT `fk_production_sand_management_previous_sand_management_id` FOREIGN KEY (`previous_sand_management_id`) REFERENCES `oil_gas_ecm`.`production`.`sand_management`(`sand_management_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_flare_system_id` FOREIGN KEY (`flare_system_id`) REFERENCES `oil_gas_ecm`.`production`.`flare_system`(`flare_system_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_previous_flare_record_id` FOREIGN KEY (`previous_flare_record_id`) REFERENCES `oil_gas_ecm`.`production`.`flare_record`(`flare_record_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_previous_water_management_id` FOREIGN KEY (`previous_water_management_id`) REFERENCES `oil_gas_ecm`.`production`.`water_management`(`water_management_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_parent_separator_id` FOREIGN KEY (`parent_separator_id`) REFERENCES `oil_gas_ecm`.`production`.`separator`(`separator_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_parent_meter_station_id` FOREIGN KEY (`parent_meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_artificial_lift_id` FOREIGN KEY (`artificial_lift_id`) REFERENCES `oil_gas_ecm`.`production`.`artificial_lift`(`artificial_lift_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `oil_gas_ecm`.`production`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_previous_esp_performance_id` FOREIGN KEY (`previous_esp_performance_id`) REFERENCES `oil_gas_ecm`.`production`.`esp_performance`(`esp_performance_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ADD CONSTRAINT `fk_production_production_working_interest_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ADD CONSTRAINT `fk_production_production_working_interest_working_interest_id` FOREIGN KEY (`working_interest_id`) REFERENCES `oil_gas_ecm`.`production`.`working_interest`(`working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ADD CONSTRAINT `fk_production_facility_plant_supply_pipeline_connection_id` FOREIGN KEY (`pipeline_connection_id`) REFERENCES `oil_gas_ecm`.`production`.`pipeline_connection`(`pipeline_connection_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ADD CONSTRAINT `fk_production_facility_plant_supply_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ADD CONSTRAINT `fk_production_facility_offtake_allocation_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ADD CONSTRAINT `fk_production_facility_working_interest_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ADD CONSTRAINT `fk_production_well_contract_allocation_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ADD CONSTRAINT `fk_production_well_afe_assignment_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`scada_tag` ADD CONSTRAINT `fk_production_scada_tag_parent_scada_tag_id` FOREIGN KEY (`parent_scada_tag_id`) REFERENCES `oil_gas_ecm`.`production`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_system` ADD CONSTRAINT `fk_production_flare_system_parent_flare_system_id` FOREIGN KEY (`parent_flare_system_id`) REFERENCES `oil_gas_ecm`.`production`.`flare_system`(`flare_system_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_pattern` ADD CONSTRAINT `fk_production_injection_pattern_parent_injection_pattern_id` FOREIGN KEY (`parent_injection_pattern_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_pattern`(`injection_pattern_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`storage_tank` ADD CONSTRAINT `fk_production_storage_tank_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `oil_gas_ecm`.`production`.`facility`(`facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`storage_tank` ADD CONSTRAINT `fk_production_storage_tank_parent_storage_tank_id` FOREIGN KEY (`parent_storage_tank_id`) REFERENCES `oil_gas_ecm`.`production`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ADD CONSTRAINT `fk_production_scada_system_parent_scada_system_id` FOREIGN KEY (`parent_scada_system_id`) REFERENCES `oil_gas_ecm`.`production`.`scada_system`(`scada_system_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`tank_battery` ADD CONSTRAINT `fk_production_tank_battery_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `oil_gas_ecm`.`production`.`facility`(`facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`tank_battery` ADD CONSTRAINT `fk_production_tank_battery_parent_tank_battery_id` FOREIGN KEY (`parent_tank_battery_id`) REFERENCES `oil_gas_ecm`.`production`.`tank_battery`(`tank_battery_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` ADD CONSTRAINT `fk_production_working_interest_parent_working_interest_id` FOREIGN KEY (`parent_working_interest_id`) REFERENCES `oil_gas_ecm`.`production`.`working_interest`(`working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` ADD CONSTRAINT `fk_production_pipeline_connection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `oil_gas_ecm`.`production`.`facility`(`facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` ADD CONSTRAINT `fk_production_pipeline_connection_parent_pipeline_connection_id` FOREIGN KEY (`parent_pipeline_connection_id`) REFERENCES `oil_gas_ecm`.`production`.`pipeline_connection`(`pipeline_connection_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility` ADD CONSTRAINT `fk_production_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`facility`(`facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` SET TAGS ('dbx_subdomain' = 'well_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `norm_record_id` SET TAGS ('dbx_business_glossary_term' = 'Norm Record Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Well Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Plugging and Abandonment (P&A) Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `api_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `artificial_lift_type` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Latitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Longitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `casing_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Production Casing Size in Inches');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `cumulative_gas_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Gas Production in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `cumulative_oil_bbls` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Oil Production in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `current_production_bopd` SET TAGS ('dbx_business_glossary_term' = 'Current Production Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `current_production_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Current Production Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `gor_scf_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Barrel (SCF/BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `initial_production_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `initial_production_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `injection_rate_bpd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate in Barrels Per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `injection_type` SET TAGS ('dbx_business_glossary_term' = 'Injection Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `lateral_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Lateral Length in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `lease_name` SET TAGS ('dbx_business_glossary_term' = 'Lease Name');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `perforation_bottom_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforation Bottom Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `perforation_top_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforation Top Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `permitted_injection_rate_bpd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Injection Rate in Barrels Per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `regulatory_district` SET TAGS ('dbx_business_glossary_term' = 'Regulatory District');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `tubing_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Production Tubing Size in Inches');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `uic_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Underground Injection Control (UIC) Permit Number');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `uwi` SET TAGS ('dbx_business_glossary_term' = 'Unique Well Identifier (UWI)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `water_cut_percent` SET TAGS ('dbx_business_glossary_term' = 'Water Cut Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `well_status` SET TAGS ('dbx_business_glossary_term' = 'Well Status');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `wellbore_type` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `wor_ratio` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `block_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Facility Address');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `county_parish` SET TAGS ('dbx_business_glossary_term' = 'County or Parish');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `current_throughput_bopd` SET TAGS ('dbx_business_glossary_term' = 'Current Throughput Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `current_throughput_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Current Throughput Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `design_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `design_capacity_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `design_capacity_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `flare_capacity_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Flare Capacity Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `h2s_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Present Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `installation_type` SET TAGS ('dbx_value_regex' = 'onshore|offshore_fixed|offshore_floating|subsea');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Name');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `norm_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Present Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operating|standby|maintenance|suspended|decommissioned|under_construction');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `ownership_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `pi_system_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Plant Information (PI) System Tag Prefix');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `processing_train_count` SET TAGS ('dbx_business_glossary_term' = 'Processing Train Count');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `separator_count` SET TAGS ('dbx_business_glossary_term' = 'Separator Count');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `storage_capacity_bbl` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `daily_production_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Production ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'test_based|meter_based|proportional|estimated|manual');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `artificial_lift_type` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Type');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `artificial_lift_type` SET TAGS ('dbx_value_regex' = 'none|rod_pump|esp|gas_lift|plunger_lift|pcp');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `boe_volume` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Volume');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `btu_content` SET TAGS ('dbx_business_glossary_term' = 'British Thermal Unit (BTU) Content');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `casing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Casing Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `choke_size_64ths` SET TAGS ('dbx_business_glossary_term' = 'Choke Size (64ths of an Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `co2_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `condensate_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Condensate Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'validated|estimated|suspect|missing|corrected');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|pi_historian|avocet|manual_entry|estimated');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_value_regex' = 'maintenance|equipment_failure|weather|regulatory|testing|optimization');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gas_lift_injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Gas Lift Injection Rate (Thousand Cubic Feet per Day - MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gas_specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gas_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Gas Temperature (Degrees Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gor` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gross_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gross Gas Volume (Thousand Cubic Feet per Day - MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gross_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Oil Volume (Barrels of Oil Per Day - BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `gross_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Water Volume (Barrels of Water Per Day - BWPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content (Parts Per Million - PPM)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `net_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Net Gas Volume (Thousand Cubic Feet - MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `net_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Oil Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `oil_gravity_api` SET TAGS ('dbx_business_glossary_term' = 'Oil Gravity (American Petroleum Institute - API Degrees)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `oil_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Oil Temperature (Degrees Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'producing|shut_in|down|testing|flowing|artificial_lift');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `pump_stroke_rate_spm` SET TAGS ('dbx_business_glossary_term' = 'Pump Stroke Rate (Strokes Per Minute - SPM)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `run_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Number');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `separator_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Separator Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `tubing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Tubing Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Uptime Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `water_cut_percent` SET TAGS ('dbx_business_glossary_term' = 'Water Cut Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `wor` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Allocation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `jib_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Batch Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'test_ratio|meter_based|volumetric_proportional|time_based|pressure_based|theoretical');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|reconciled|adjusted|voided');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `boe_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Conversion Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `facility_metered_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Facility Metered Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `facility_metered_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Facility Metered Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `factor` SET TAGS ('dbx_business_glossary_term' = 'Allocation Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gas_allocation_variance_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Allocation Variance in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gas_oil_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gross_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gross Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gross_ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Natural Gas Liquids (NGL) Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gross_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gross_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Water Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `jib_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Posting Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `net_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Net Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `net_ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Natural Gas Liquids (NGL) Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `net_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `net_revenue_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Decimal');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `oil_allocation_variance_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Allocation Variance in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_month` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|failed');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'avocet|osi_pi|scada|manual_entry|third_party');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `total_boe` SET TAGS ('dbx_business_glossary_term' = 'Total Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `water_oil_ratio` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `monthly_production_id` SET TAGS ('dbx_business_glossary_term' = 'Monthly Production ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'State Agency Report ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_measurement|proration|well_test|estimated');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `artificial_lift_type` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Type');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `boe_total` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Total');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `bsee_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Submission Reference');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|certified|submitted|rejected|amended');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `certified_by` SET TAGS ('dbx_business_glossary_term' = 'Certified By');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `condensate_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Condensate Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'pi_system|avocet|scada|manual_entry|third_party');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `flared_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Flared Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `fuel_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `gas_mcfd_average` SET TAGS ('dbx_business_glossary_term' = 'Gas Thousand Cubic Feet per Day (MCFD) Average');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `gor` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percent');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `oil_bopd_average` SET TAGS ('dbx_business_glossary_term' = 'Oil Barrels of Oil Per Day (BOPD) Average');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_days` SET TAGS ('dbx_business_glossary_term' = 'Production Days');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_status` SET TAGS ('dbx_business_glossary_term' = 'Production Status');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_status` SET TAGS ('dbx_value_regex' = 'producing|shut-in|suspended|abandoned|temporarily_abandoned|plugged');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Production Remarks');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal_offshore|state_onshore|tribal_lands');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `royalty_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Royalty Volume in Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `sales_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Sales Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `vented_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Vented Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Water Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `wellhead_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Wellhead Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `wor` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percent');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` SET TAGS ('dbx_subdomain' = 'well_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `artificial_lift_id` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Installation ID');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Tag ID');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `actual_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Rate (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Operational Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `design_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Design Production Rate (BOPD - Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `discharge_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Discharge Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `failure_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Date');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `gas_injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Gas Injection Rate (MCFD - Thousand Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Installation Date');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `installation_number` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Installation Number');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `lift_status` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Status');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `lift_status` SET TAGS ('dbx_value_regex' = 'Operating|Idle|Failed|Maintenance|Decommissioned|Standby');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `lift_type` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Type');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `lift_type` SET TAGS ('dbx_value_regex' = 'ESP|Rod Pump|Gas Lift|PCP|Jet Pump|Plunger Lift');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `motor_current_amps` SET TAGS ('dbx_business_glossary_term' = 'Motor Current (Amperes)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `motor_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Motor Horsepower (HP)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `motor_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Motor Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `motor_voltage` SET TAGS ('dbx_business_glossary_term' = 'Motor Voltage (Volts)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `operating_cost_per_day_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Per Day (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `operating_cost_per_day_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `operating_frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency (Hertz)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `optimization_target` SET TAGS ('dbx_business_glossary_term' = 'Optimization Target');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `optimization_target` SET TAGS ('dbx_value_regex' = 'Maximize Production|Minimize Power|Extend Run Life|Balance');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `power_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (Kilowatt-Hours)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `pump_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Pump Setting Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `pump_intake_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pump Intake Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `pump_stages` SET TAGS ('dbx_business_glossary_term' = 'Pump Stage Count');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Removal Date');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `run_life_days` SET TAGS ('dbx_business_glossary_term' = 'Run Life (Days)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `stroke_length_inches` SET TAGS ('dbx_business_glossary_term' = 'Stroke Length (Inches)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `strokes_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Strokes Per Minute (SPM)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `target_frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Target Operating Frequency (Hertz)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `target_gas_injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Target Gas Injection Rate (MCFD - Thousand Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event ID');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `field_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual_entry|pi_system|avocet|maximo|enablon');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `deferred_boe` SET TAGS ('dbx_business_glossary_term' = 'Deferred Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `deferred_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Deferred Gas Volume Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `deferred_ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Deferred Natural Gas Liquids (NGL) Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `deferred_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Deferred Oil Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'planned_maintenance|equipment_failure|weather|regulatory|market_curtailment|pipeline_constraint');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_event_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Status');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Downtime Subcategory');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag Number');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `preventive_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Recommended');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Priority');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By User Name');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `resolved_by` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User Name');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `responsible_organization` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organization Name');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `compliance_sec_reserves_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Sec Reserves Disclosure Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `b_factor` SET TAGS ('dbx_business_glossary_term' = 'Hyperbolic Decline B-Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Forecast Basis');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `boe_forecast_boepd` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Forecast Per Day (BOEPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'P10|P50|P90|deterministic|not_specified');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `decline_rate_effective` SET TAGS ('dbx_business_glossary_term' = 'Decline Rate Effective');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `decline_rate_nominal` SET TAGS ('dbx_business_glossary_term' = 'Decline Rate Nominal');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `economic_limit_boepd` SET TAGS ('dbx_business_glossary_term' = 'Economic Limit in Barrel of Oil Equivalent Per Day (BOEPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `eur_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `gas_forecast_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Gas Forecast Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `gor_forecast` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) Forecast');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `granularity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Granularity');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `granularity` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annual');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `ip_rate_boepd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate in Barrel of Oil Equivalent Per Day (BOEPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `ngl_forecast_bopd` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Forecast Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `oil_forecast_bopd` SET TAGS ('dbx_business_glossary_term' = 'Oil Forecast Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `operating_cost_assumption` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Assumption (Lease Operating Expense - LOE)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `operating_cost_assumption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `price_deck_assumption` SET TAGS ('dbx_business_glossary_term' = 'Price Deck Assumption');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category per Petroleum Resources Management System (PRMS)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `reserves_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Reserves Subcategory');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `reserves_subcategory` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD|probable|possible');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `variance_to_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance to Actual Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `water_forecast_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Water Forecast Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `wor_forecast` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR) Forecast');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` SET TAGS ('dbx_subdomain' = 'well_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Pattern Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `actual_injection_rate_bwipd` SET TAGS ('dbx_business_glossary_term' = 'Actual Injection Rate in Barrels of Water Injected Per Day (BWIPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `actual_injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Actual Injection Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `cumulative_injection_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `cumulative_injection_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `first_injection_date` SET TAGS ('dbx_business_glossary_term' = 'First Injection Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Injection Depth Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Injection Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_method` SET TAGS ('dbx_business_glossary_term' = 'Injection Method');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_method` SET TAGS ('dbx_value_regex' = 'continuous|cyclic|wag|huff_and_puff|sagd');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Injection Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_type` SET TAGS ('dbx_business_glossary_term' = 'Injection Type');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_type` SET TAGS ('dbx_value_regex' = 'water_flood|gas_injection|co2_injection|steam_injection|disposal');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_zone` SET TAGS ('dbx_business_glossary_term' = 'Injection Zone Formation Name');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `last_injection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Injection Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `last_mechanical_integrity_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Mechanical Integrity Test (MIT) Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `max_allowable_injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Injection Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `mechanical_integrity_test_result` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Integrity Test (MIT) Result');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `mechanical_integrity_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|shut_in|abandoned|plugged');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `permitted_injection_rate_bwipd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Injection Rate in Barrels of Water Injected Per Day (BWIPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `permitted_injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Injection Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|violation');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `uic_well_class` SET TAGS ('dbx_business_glossary_term' = 'Underground Injection Control (UIC) Well Class');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `uic_well_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|class_iv|class_v|class_vi');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Injection Volume Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|prorated|estimated|metered');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `bottomhole_injection_pressure` SET TAGS ('dbx_business_glossary_term' = 'Bottomhole Injection Pressure (BHP)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `bottomhole_pressure_uom` SET TAGS ('dbx_business_glossary_term' = 'Bottomhole Pressure Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `bottomhole_pressure_uom` SET TAGS ('dbx_value_regex' = 'PSI|KPA|BAR|MPA');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Injection Record Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `cumulative_injection_volume` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume to Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `cumulative_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `cumulative_volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MCF|MSTB|M3|MSCF|KG');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `daily_injection_volume` SET TAGS ('dbx_business_glossary_term' = 'Daily Injection Volume');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|suspect|estimated|missing|invalid');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Injection Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual|pi_system|estimated|calculated');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `eor_method` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Method');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `fluid_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Quality Indicator');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `fluid_source` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Source');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_date` SET TAGS ('dbx_business_glossary_term' = 'Injection Date');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Injection Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_program_type` SET TAGS ('dbx_business_glossary_term' = 'Injection Program Type');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_program_type` SET TAGS ('dbx_value_regex' = 'waterflood|gas_injection|eor|disposal|pressure_maintenance|storage');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_rate` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_rate_uom` SET TAGS ('dbx_value_regex' = 'BPD|MCFD|M3D|MSCFD');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_status` SET TAGS ('dbx_business_glossary_term' = 'Injection Status');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_status` SET TAGS ('dbx_value_regex' = 'active|suspended|shut_in|maintenance|testing|planned');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_temperature` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Temperature');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Injection Temperature Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_temperature_uom` SET TAGS ('dbx_value_regex' = 'F|C|K');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Injection Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MCF|MSTB|M3|MSCF|KG');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_zone_depth` SET TAGS ('dbx_business_glossary_term' = 'Injection Zone Depth');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_zone_depth_uom` SET TAGS ('dbx_business_glossary_term' = 'Injection Zone Depth Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_zone_depth_uom` SET TAGS ('dbx_value_regex' = 'FT|M');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_zone_name` SET TAGS ('dbx_business_glossary_term' = 'Injection Zone Name');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `max_allowable_injection_pressure` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Injection Pressure (MAIP)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `max_pressure_uom` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pressure Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `max_pressure_uom` SET TAGS ('dbx_value_regex' = 'PSI|KPA|BAR|MPA');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `surface_injection_pressure` SET TAGS ('dbx_business_glossary_term' = 'Surface Injection Pressure');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `surface_pressure_uom` SET TAGS ('dbx_business_glossary_term' = 'Surface Pressure Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `surface_pressure_uom` SET TAGS ('dbx_value_regex' = 'PSI|KPA|BAR|MPA');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `uic_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Underground Injection Control (UIC) Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `working_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Decimal');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `run_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Purchaser Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `tank_battery_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Battery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `bsw_percentage` SET TAGS ('dbx_business_glossary_term' = 'Basic Sediment and Water (BS&W) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `closing_gauge_feet` SET TAGS ('dbx_business_glossary_term' = 'Closing Gauge (Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `closing_gauge_inches` SET TAGS ('dbx_business_glossary_term' = 'Closing Gauge (Inches)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `driver_name` SET TAGS ('dbx_business_glossary_term' = 'Driver Name');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `driver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `gross_standard_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Standard Volume (GSV) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `meter_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Meter Ticket Reference Number');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `meter_ticket_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `net_standard_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Net Standard Volume (NSV) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `observed_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Observed Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `observed_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Observed Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `opening_gauge_feet` SET TAGS ('dbx_business_glossary_term' = 'Opening Gauge (Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `opening_gauge_inches` SET TAGS ('dbx_business_glossary_term' = 'Opening Gauge (Inches)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `operator_signature` SET TAGS ('dbx_business_glossary_term' = 'Operator Signature');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `operator_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `pricing_point` SET TAGS ('dbx_business_glossary_term' = 'Pricing Point');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `purchaser_signature` SET TAGS ('dbx_business_glossary_term' = 'Purchaser Signature');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `purchaser_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `run_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Number');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `run_ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `run_ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Status');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `run_ticket_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|disputed|reconciled|cancelled');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `sulfur_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `temperature_correction_factor` SET TAGS ('dbx_business_glossary_term' = 'Temperature Correction Factor (CTL)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `truck_number` SET TAGS ('dbx_business_glossary_term' = 'Truck Number');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `truck_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `unit_price_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Unit Price per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `unit_price_per_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `gas_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Measurement ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Station ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `aga_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'American Gas Association (AGA) Calculation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `aga_calculation_method` SET TAGS ('dbx_value_regex' = 'AGA-3|AGA-7|AGA-9|AGA-11|ISO-5167');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|priority|equal|manual|test_based');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `atmospheric_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Atmospheric Pressure (PSIA - Pounds per Square Inch Absolute)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `base_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Base Pressure (PSIA - Pounds per Square Inch Absolute)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `base_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Base Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `co2_content_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content (Mol Percent)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `compressibility_factor` SET TAGS ('dbx_business_glossary_term' = 'Compressibility Factor (Z-Factor)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `corrected_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Corrected Volume (MCF - Thousand Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `differential_pressure_inches_h2o` SET TAGS ('dbx_business_glossary_term' = 'Differential Pressure (Inches of Water)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `energy_content_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Energy Content (MMBtu - Million British Thermal Units)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `flowing_pressure_psig` SET TAGS ('dbx_business_glossary_term' = 'Flowing Pressure (PSIG - Pounds per Square Inch Gauge)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `flowing_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Flowing Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `h2s_content_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content (Mol Percent)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Heating Value (BTU per SCF - British Thermal Units per Standard Cubic Foot)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Number');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|disputed|corrected|final');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'custody_transfer|allocation|check|verification|regulatory');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `meter_factor` SET TAGS ('dbx_business_glossary_term' = 'Meter Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `meter_tube_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Meter Tube Diameter (Inches)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `methane_content_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane (CH4) Content (Mol Percent)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `nitrogen_content_mol_percent` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen (N2) Content (Mol Percent)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `orifice_plate_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Orifice Plate Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|estimated|failed|manual_override');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `raw_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Raw Volume (MCF - Thousand Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `sharing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'volumetric|value_based|hybrid|r_factor|sliding_scale');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `contractor_entitlement_gas_mcf` SET TAGS ('dbx_business_glossary_term' = 'Contractor Entitlement Gas (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `contractor_entitlement_oil_bbl` SET TAGS ('dbx_business_glossary_term' = 'Contractor Entitlement Oil (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `contractor_profit_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Contractor Profit Share Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `cost_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cost Gas Volume (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `cost_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cost Oil Volume (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `cost_recovery_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `cumulative_cost_recovery_balance_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Cost Recovery Balance (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `cumulative_cost_recovery_balance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_profit_share_gas_mcf` SET TAGS ('dbx_business_glossary_term' = 'Government Profit Share Gas (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_profit_share_oil_bbl` SET TAGS ('dbx_business_glossary_term' = 'Government Profit Share Oil (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_profit_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Government Profit Share Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Government Reporting Period');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_reporting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$|^d{4}$');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_royalty_gas_mcf` SET TAGS ('dbx_business_glossary_term' = 'Government Royalty Gas (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `government_royalty_oil_bbl` SET TAGS ('dbx_business_glossary_term' = 'Government Royalty Oil (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `gross_gas_production_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gross Gas Production (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `gross_ngl_production_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Natural Gas Liquids (NGL) Production (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `gross_oil_production_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Oil Production (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `jib_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Reference Number');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `partner_entitlement_gas_mcf` SET TAGS ('dbx_business_glossary_term' = 'Partner Entitlement Gas (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `partner_entitlement_oil_bbl` SET TAGS ('dbx_business_glossary_term' = 'Partner Entitlement Oil (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `partner_net_revenue_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Partner Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `partner_working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Partner Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `period_cost_recovery_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Period Cost Recovery Amount (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `period_cost_recovery_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `production_month` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `production_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production Period End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `production_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Period Start Date');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `profit_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Profit Gas Volume (MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `profit_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Volume (BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `profit_split_tier` SET TAGS ('dbx_business_glossary_term' = 'Profit Split Tier');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `profit_split_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|tier_6');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `r_factor` SET TAGS ('dbx_business_glossary_term' = 'R-Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|settled|disputed|adjusted');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `valuation_price_gas_usd_per_mcf` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price Gas (USD per MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ALTER COLUMN `valuation_price_oil_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price Oil (USD per BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`event` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Production Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (United States Dollars - USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `budgeted_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost (United States Dollars - USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `budgeted_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `choke_bean_size_64ths` SET TAGS ('dbx_business_glossary_term' = 'Choke Bean Size (64ths of an Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|suspect');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'planned_maintenance|unplanned_maintenance|optimization|regulatory_compliance|emergency_response');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `hse_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Number');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `impacted_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Impacted Gas Volume (Thousand Cubic Feet - MCF)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `impacted_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Impacted Oil Volume (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Event Outcome');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|pending_evaluation');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `service_provider` SET TAGS ('dbx_business_glossary_term' = 'Service Provider');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Treatment Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_pressure_psi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_pressure_psi` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Type');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Treatment Volume (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_volume_bbl` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`event` ALTER COLUMN `treatment_volume_bbl` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `reservoir_pressure_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `previous_reservoir_pressure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|suspect|estimated|failed|uncalibrated');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `datum_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Datum Depth in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `datum_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Datum Depth True Vertical Depth (TVD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `flowing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Flowing Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_accuracy_rating` SET TAGS ('dbx_business_glossary_term' = 'Gauge Accuracy Rating');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Gauge Calibration Date');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Gauge Manufacturer');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_model_number` SET TAGS ('dbx_business_glossary_term' = 'Gauge Model Number');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Gauge Serial Number');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_type` SET TAGS ('dbx_business_glossary_term' = 'Gauge Type');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `gauge_type` SET TAGS ('dbx_value_regex' = 'mechanical|electronic|memory|permanent_downhole|surface_readout|wireline');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `initial_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Number');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'preliminary|validated|approved|rejected|under_review');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'static|flowing|buildup|drawdown|falloff|injection');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Permeability in Millidarcies (md)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `pressure_depletion_percent` SET TAGS ('dbx_business_glossary_term' = 'Pressure Depletion Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `pressure_depletion_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Depletion in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `pressure_gradient_psi_per_ft` SET TAGS ('dbx_business_glossary_term' = 'Pressure Gradient in Pounds per Square Inch per Foot (PSI/ft)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `pressure_value_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Value in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `production_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `production_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `productivity_index` SET TAGS ('dbx_business_glossary_term' = 'Productivity Index (PI)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Recorded By');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `service_company` SET TAGS ('dbx_business_glossary_term' = 'Service Company');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `shut_in_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Time in Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `skin_factor` SET TAGS ('dbx_business_glossary_term' = 'Skin Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `static_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `choke_setting_id` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `previous_choke_setting_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `actual_gas_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Actual Gas Production Rate (Thousand Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `actual_oil_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Actual Oil Production Rate (Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `casing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Casing Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Choke Change Description');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Choke Change Reason');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `choke_position_percent` SET TAGS ('dbx_business_glossary_term' = 'Choke Position Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `choke_size_64ths` SET TAGS ('dbx_business_glossary_term' = 'Choke Size (64ths of Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `choke_type` SET TAGS ('dbx_business_glossary_term' = 'Choke Type');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `choke_type` SET TAGS ('dbx_value_regex' = 'fixed|adjustable|positive|variable');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Operational Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|suspect|rejected');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `differential_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Differential Pressure Across Choke (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting Effective Date');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting Effective Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting End Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `gor_scf_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (Standard Cubic Feet per Barrel)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `implemented_by` SET TAGS ('dbx_business_glossary_term' = 'Implemented By Operator');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `setting_number` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting Number');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `setting_status` SET TAGS ('dbx_business_glossary_term' = 'Choke Setting Status');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `setting_status` SET TAGS ('dbx_value_regex' = 'active|superseded|planned|cancelled');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `target_gas_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Target Gas Production Rate (Thousand Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `target_oil_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Target Oil Production Rate (Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `tubing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Tubing Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `water_cut_percent` SET TAGS ('dbx_business_glossary_term' = 'Water Cut Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ALTER COLUMN `wor_ratio` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Production Chemical Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Supply Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Oil and Gas Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Storage Tank Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Supplier Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `previous_chemical_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `actual_effectiveness_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Treatment Effectiveness Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `annual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Chemical Treatment Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `annual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `application_point` SET TAGS ('dbx_business_glossary_term' = 'Chemical Application Point');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `biodegradable_flag` SET TAGS ('dbx_business_glossary_term' = 'Biodegradable Chemical Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `chemical_code` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Code');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Name');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `chemical_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Treatment Type');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `current_inventory_gallons` SET TAGS ('dbx_business_glossary_term' = 'Current Chemical Inventory Gallons');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `dosage_rate` SET TAGS ('dbx_business_glossary_term' = 'Chemical Dosage Rate');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `dosage_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Dosage Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `dosage_rate_uom` SET TAGS ('dbx_value_regex' = 'ppm|gal_per_day|lb_per_bbl|ml_per_bbl|gal_per_1000_bbl|kg_per_m3');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `environmental_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Required Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Chemical Hazard Classification');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `injection_method` SET TAGS ('dbx_business_glossary_term' = 'Chemical Injection Method');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `injection_method` SET TAGS ('dbx_value_regex' = 'chemical_pump|capillary_string|batch_treatment|squeeze_treatment|umbilical_line');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Chemical Injection Pressure Pounds Per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `last_performance_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Test Date');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Manufacturer Name');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `monthly_usage_volume` SET TAGS ('dbx_business_glossary_term' = 'Monthly Chemical Usage Volume');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `next_performance_test_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Test Date');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `reorder_point_gallons` SET TAGS ('dbx_business_glossary_term' = 'Chemical Reorder Point Gallons');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `storage_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Chemical Storage Capacity Gallons');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `target_effectiveness_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Treatment Effectiveness Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Program End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_end_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_end_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Treatment Application Frequency');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_frequency` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_optimization_notes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Optimization Notes');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_optimization_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_optimization_notes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Program Start Date');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_start_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_start_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Program Status');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|trial');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Chemical Unit Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ALTER COLUMN `unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_management_id` SET TAGS ('dbx_business_glossary_term' = 'Sand Management ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir ID');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `previous_sand_management_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `choke_size_64ths` SET TAGS ('dbx_business_glossary_term' = 'Choke Size (64ths of an Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Sand Management Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `critical_sand_rate` SET TAGS ('dbx_business_glossary_term' = 'Critical Sand Rate');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `critical_sand_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Critical Sand Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `critical_sand_rate_uom` SET TAGS ('dbx_value_regex' = 'lb_per_day|kg_per_day|lb_per_1000bbl|kg_per_m3');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `cumulative_sand_volume` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Sand Volume');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `cumulative_sand_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Sand Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `cumulative_sand_volume_uom` SET TAGS ('dbx_value_regex' = 'lb|kg|bbl|m3');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|suspect|failed|not_available');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual_reading|lab_analysis|acoustic_sensor|production_test|estimated');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `equipment_damage_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Damage Description');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `equipment_damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Damage Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `flowing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Flowing Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `gravel_pack_quality` SET TAGS ('dbx_business_glossary_term' = 'Gravel Pack Quality');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `gravel_pack_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed|not_applicable');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `gravel_pack_size_mesh` SET TAGS ('dbx_business_glossary_term' = 'Gravel Pack Size (Mesh)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `gravel_pack_size_mesh` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}/[0-9]{1,3}$');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Sand Control Installation Date');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `intervention_action` SET TAGS ('dbx_business_glossary_term' = 'Sand Management Intervention Action');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `intervention_date` SET TAGS ('dbx_business_glossary_term' = 'Intervention Date');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Sand Monitoring Date');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `monitoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sand Monitoring Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `production_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `production_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_control_method` SET TAGS ('dbx_business_glossary_term' = 'Sand Control Method');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_control_method` SET TAGS ('dbx_value_regex' = 'gravel_pack|frac_pack|standalone_screen|expandable_screen|chemical_consolidation|none');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_detector_reading` SET TAGS ('dbx_business_glossary_term' = 'Sand Detector Reading');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_detector_type` SET TAGS ('dbx_business_glossary_term' = 'Sand Detector Type');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_detector_type` SET TAGS ('dbx_value_regex' = 'acoustic|erosion|ultrasonic|clamp_on|intrusive|visual');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_detector_uom` SET TAGS ('dbx_business_glossary_term' = 'Sand Detector Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_detector_uom` SET TAGS ('dbx_value_regex' = 'ppm|mg_per_l|lb_per_1000bbl|kg_per_m3|counts_per_second');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_management_status` SET TAGS ('dbx_business_glossary_term' = 'Sand Management Status');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_management_status` SET TAGS ('dbx_value_regex' = 'normal|warning|critical|intervention_required|offline');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_production_rate` SET TAGS ('dbx_business_glossary_term' = 'Sand Production Rate');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_production_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Sand Production Rate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_production_rate_uom` SET TAGS ('dbx_value_regex' = 'lb_per_day|kg_per_day|lb_per_1000bbl|kg_per_m3');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_screen_type` SET TAGS ('dbx_business_glossary_term' = 'Sand Screen Type');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `sand_screen_type` SET TAGS ('dbx_value_regex' = 'wire_wrapped|premium_mesh|slotted_liner|prepacked|expandable|none');
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ALTER COLUMN `screen_slot_size_microns` SET TAGS ('dbx_business_glossary_term' = 'Screen Slot Size (Microns)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_record_id` SET TAGS ('dbx_business_glossary_term' = 'Flare Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_system_id` SET TAGS ('dbx_business_glossary_term' = 'Flare System Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Destination Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `previous_flare_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_measurement|estimated|prorated|well_test_based');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `combustion_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Combustion Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|suspect');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `economic_loss_usd` SET TAGS ('dbx_business_glossary_term' = 'Economic Loss (USD - United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `economic_loss_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_date` SET TAGS ('dbx_business_glossary_term' = 'Flare Date');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Flare Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flare End Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_event_number` SET TAGS ('dbx_business_glossary_term' = 'Flare Event Number');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Flare Reason Code');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Flare Reason Description');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flare Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_status` SET TAGS ('dbx_business_glossary_term' = 'Flare Status');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_status` SET TAGS ('dbx_value_regex' = 'active|completed|cancelled|under_review');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_type` SET TAGS ('dbx_business_glossary_term' = 'Flare Type');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|emergency|routine');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Flare Volume (BOE - Barrel of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Flare Volume (MCF - Thousand Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_volume_mscf` SET TAGS ('dbx_business_glossary_term' = 'Flare Volume (MSCF - Thousand Standard Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_composition_co2_pct` SET TAGS ('dbx_business_glossary_term' = 'Gas Composition Carbon Dioxide (CO2) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_composition_ethane_pct` SET TAGS ('dbx_business_glossary_term' = 'Gas Composition Ethane Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_composition_h2s_ppm` SET TAGS ('dbx_business_glossary_term' = 'Gas Composition Hydrogen Sulfide (H2S) Content (PPM - Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_composition_methane_pct` SET TAGS ('dbx_business_glossary_term' = 'Gas Composition Methane Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_composition_propane_pct` SET TAGS ('dbx_business_glossary_term' = 'Gas Composition Propane Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_price_usd_per_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Price (USD per MCF - United States Dollars per Thousand Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gas_price_usd_per_mcf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `ghg_emissions_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions (CO2e Tonnes)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `heating_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Heating Value (BTU per SCF - British Thermal Units per Standard Cubic Foot)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'flow_meter|orifice_plate|ultrasonic|estimation|engineering_calculation');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Flaring Permit Number');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `vented_volume_mscf` SET TAGS ('dbx_business_glossary_term' = 'Vented Volume (MSCF - Thousand Standard Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `water_management_id` SET TAGS ('dbx_business_glossary_term' = 'Water Management ID');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Well ID');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Water Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `previous_water_management_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `chloride_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Chloride Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `cumulative_disposal_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Disposal Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|suspect|rejected');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual_entry|pi_system|lab_analysis|third_party|estimated');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `discharge_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Discharge Water Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Water Disposal Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Water Disposal Method');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'injection|discharge|evaporation|recycling|offsite_disposal|beneficial_reuse');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `disposed_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Disposed Water Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Disposal Injection Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `max_allowable_injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Injection Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `oil_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Oil Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Water Management Operational Status');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|maintenance|shutdown|testing');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH Level');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `produced_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Produced Water Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Water Management Record Date');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Water Management Record Number');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `record_number` SET TAGS ('dbx_value_regex' = '^WM-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `recycled_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Recycled Water Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|conditional|suspended');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `salinity_ppm` SET TAGS ('dbx_business_glossary_term' = 'Salinity (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `total_dissolved_solids_ppm` SET TAGS ('dbx_business_glossary_term' = 'Total Dissolved Solids (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `total_suspended_solids_ppm` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treated_water_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Treated Water Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Treatment Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_efficiency_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_efficiency_percent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_method` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Method');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `treatment_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `water_cut_percent` SET TAGS ('dbx_business_glossary_term' = 'Water Cut Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'produced_water|flowback_water|drilling_fluid|completion_fluid|formation_water');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `separator_id` SET TAGS ('dbx_business_glossary_term' = 'Separator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `parent_separator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Separator Calibration Status');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'current|due|overdue|not_applicable');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Separator Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `control_system_type` SET TAGS ('dbx_business_glossary_term' = 'Separator Control System Type');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `control_system_type` SET TAGS ('dbx_value_regex' = 'pneumatic|electronic|plc|dcs|scada_integrated|manual');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `corrosion_allowance_inches` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Allowance Inches');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `design_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `design_capacity_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `design_capacity_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `design_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `fabrication_year` SET TAGS ('dbx_business_glossary_term' = 'Separator Fabrication Year');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `h2s_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Service Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `inspection_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval Months');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Separator Installation Date');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `internals_type` SET TAGS ('dbx_business_glossary_term' = 'Separator Internals Type');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `material_specification` SET TAGS ('dbx_business_glossary_term' = 'Separator Material Specification');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `operating_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Separator Operational Status');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operating|standby|maintenance|out_of_service|decommissioned');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `ownership_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `pi_system_tag` SET TAGS ('dbx_business_glossary_term' = 'Plant Information (PI) System Tag');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `replacement_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `replacement_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `safety_relief_valve_set_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Safety Relief Valve Set Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `separator_name` SET TAGS ('dbx_business_glossary_term' = 'Separator Name');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `separator_type` SET TAGS ('dbx_business_glossary_term' = 'Separator Type Classification');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `separator_type` SET TAGS ('dbx_value_regex' = 'two_phase|three_phase|test_separator|high_pressure|low_pressure|free_water_knockout');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Separator Equipment Tag Number');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `vessel_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Vessel Diameter Inches');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `vessel_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Vessel Length Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `vessel_orientation` SET TAGS ('dbx_business_glossary_term' = 'Separator Vessel Orientation');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `vessel_orientation` SET TAGS ('dbx_value_regex' = 'horizontal|vertical|spherical');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `parent_meter_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency in Days');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_value_regex' = 'bbl_per_day|mcf_per_day|mmcf_per_day|boe_per_day');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `county_parish` SET TAGS ('dbx_business_glossary_term' = 'County or Parish');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `custody_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `fiscal_measurement_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Measurement Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `last_proving_date` SET TAGS ('dbx_business_glossary_term' = 'Last Proving Date');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `measurement_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Class');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `measurement_accuracy_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `measurement_fluid` SET TAGS ('dbx_business_glossary_term' = 'Measurement Fluid Type');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `measurement_fluid` SET TAGS ('dbx_value_regex' = 'crude_oil|natural_gas|ngl|condensate|water|multiphase');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `measurement_uncertainty_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `meter_factor` SET TAGS ('dbx_business_glossary_term' = 'Meter Factor');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'orifice|turbine|coriolis|ultrasonic|positive_displacement|vortex');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|suspended|testing');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `ownership_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `pi_system_tag` SET TAGS ('dbx_business_glossary_term' = 'Plant Information (PI) System Tag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `proving_method` SET TAGS ('dbx_business_glossary_term' = 'Proving Method');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `proving_method` SET TAGS ('dbx_value_regex' = 'pipe_prover|tank_prover|master_meter|small_volume_prover');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `regulatory_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Code');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Name');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Type');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'fiscal|allocation|custody_transfer|check|proving|test');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` SET TAGS ('dbx_subdomain' = 'production_accounting');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `esp_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Electric Submersible Pump (ESP) Performance ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `artificial_lift_id` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Equipment ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag ID');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `previous_esp_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Alarm Code');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `alarm_description` SET TAGS ('dbx_business_glossary_term' = 'Alarm Description');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `casing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Casing Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|suspect|bad|estimated|manual');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'pi_system|scada|dcs|manual|avocet|historian');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `differential_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Differential Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `discharge_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pump Discharge Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `fluid_level_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Fluid Level Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `fluid_rate_bfpd` SET TAGS ('dbx_business_glossary_term' = 'Fluid Rate (Barrels of Fluid Per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `intake_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pump Intake Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `motor_current_amps` SET TAGS ('dbx_business_glossary_term' = 'Motor Current (Amps)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `motor_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Motor Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `motor_voltage_volts` SET TAGS ('dbx_business_glossary_term' = 'Motor Voltage (Volts)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `operating_frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency (Hertz)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `power_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (Kilowatt-Hours)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `production_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate (Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `pump_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Pump Efficiency (Percent)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `pump_setting_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Pump Setting Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `run_life_days` SET TAGS ('dbx_business_glossary_term' = 'Run Life (Days)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `submergence_ft` SET TAGS ('dbx_business_glossary_term' = 'Pump Submergence (Feet)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `target_frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency (Hertz)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `tubing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Tubing Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `vibration_mils` SET TAGS ('dbx_business_glossary_term' = 'Vibration (Mils)');
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` SET TAGS ('dbx_subdomain' = 'well_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` SET TAGS ('dbx_association_edges' = 'production.production_well,venture.partner');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `production_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'production_working_interest Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'JOA Agreement ID');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest - Production Well Id');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest ID');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `carried_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `interest_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `non_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Status');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Updated Date');
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` SET TAGS ('dbx_association_edges' = 'production.production_facility,petrochemical.plant');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `facility_plant_supply_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Plant Supply Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Plant Supply - Petchem Plant Id');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `pipeline_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Connection Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Plant Supply - Production Facility Id');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `contract_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Contract Capacity Barrels Oil Per Day');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `contract_capacity_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Contract Capacity Million Cubic Feet Per Day');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `primary_feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ALTER COLUMN `transportation_tariff` SET TAGS ('dbx_business_glossary_term' = 'Transportation Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` SET TAGS ('dbx_association_edges' = 'production.production_facility,commercial.offtake_agreement');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `facility_offtake_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Offtake Allocation ID');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Offtake Allocation - Offtake Agreement Id');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Offtake Allocation - Production Facility Id');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `allocated_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity BOPD');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `allocated_capacity_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity MMCFD');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `blending_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Blending Allowed Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `nomination_rights` SET TAGS ('dbx_business_glossary_term' = 'Nomination Rights');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` SET TAGS ('dbx_association_edges' = 'production.production_facility,venture.partner');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `facility_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Working Interest ID');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'JOA Agreement ID');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Working Interest - Production Facility Id');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Working Interest - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `billing_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Code');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `carried_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Status');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `ownership_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` SET TAGS ('dbx_subdomain' = 'well_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` SET TAGS ('dbx_association_edges' = 'production.production_well,commercial.term_contract');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `well_contract_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Well Contract Allocation Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Well Contract Allocation - Term Contract Id');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Contract Allocation - Production Well Id');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocated_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume Barrels');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocated_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume MCF');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `contract_priority` SET TAGS ('dbx_business_glossary_term' = 'Contract Priority');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Date');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created By');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` SET TAGS ('dbx_subdomain' = 'well_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` SET TAGS ('dbx_association_edges' = 'production.production_well,finance.finance_afe');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `well_afe_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Well AFE Assignment Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Well Afe Assignment - Finance Afe Id');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Afe Assignment - Production Well Id');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost for Well');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `afe_phase` SET TAGS ('dbx_business_glossary_term' = 'AFE Phase');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `budget_variance` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance for Well');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Completion Date');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ALTER COLUMN `primary_well_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Well Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_tag` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_tag` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Scada Tag Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_tag` ALTER COLUMN `parent_scada_tag_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`field` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`field` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_system` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_system` ALTER COLUMN `flare_system_id` SET TAGS ('dbx_business_glossary_term' = 'Flare System Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_system` ALTER COLUMN `parent_flare_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_pattern` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_pattern` ALTER COLUMN `injection_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Pattern Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_pattern` ALTER COLUMN `parent_injection_pattern_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`storage_tank` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`storage_tank` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`storage_tank` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`storage_tank` ALTER COLUMN `parent_storage_tank_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ALTER COLUMN `parent_scada_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`scada_system` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`tank_battery` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`tank_battery` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`tank_battery` ALTER COLUMN `tank_battery_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Battery Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`tank_battery` ALTER COLUMN `parent_tank_battery_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` ALTER COLUMN `working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` ALTER COLUMN `parent_working_interest_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` SET TAGS ('dbx_subdomain' = 'infrastructure_monitoring');
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` ALTER COLUMN `pipeline_connection_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Connection Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` ALTER COLUMN `parent_pipeline_connection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`production`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`production`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
