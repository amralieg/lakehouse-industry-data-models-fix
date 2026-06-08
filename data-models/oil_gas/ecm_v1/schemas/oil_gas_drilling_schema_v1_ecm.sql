-- Schema for Domain: drilling | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`drilling` COMMENT 'Owns all drilling and well completion lifecycle data from spud to TD, including rig scheduling, well planning, directional drilling, BHA configuration, MWD/LWD logs, ROP tracking, NPT analysis, BOP certification, torque and drag analysis, drill stem testing, and P&A records. Manages AFE-level drilling cost tracking and well status across D&C programs. Aligns with API well classification standards and BSEE offshore drilling regulations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`drilling_well` (
    `drilling_well_id` BIGINT COMMENT 'Primary key for well',
    `block_id` BIGINT COMMENT 'FK to exploration.block',
    `company_code_id` BIGINT COMMENT 'Reference to the operating company responsible for drilling and operating this wellbore. The operator holds the drilling permit and manages day-to-day operations on behalf of all working interest owners.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Wells produce specific crude grades with distinct API gravity, sulfur content, and pricing differentials. Critical for crude marketing, pricing (benchmark + differential), custody transfer quality spe',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Well-specific ERPs are required for high-risk wells (HPHT, H2S, deepwater). Plans must reference the covered well for worst-case discharge scenarios and response procedures.',
    `field_id` BIGINT COMMENT 'Reference to the oil or gas field where this wellbore is located. Fields represent geographic areas containing one or more reservoirs under the same structural feature. Used for reserves aggregation and field-level production reporting.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Completed wells are capitalized as fixed assets for depletion and impairment testing. New attribute needed; no existing candidate. Mandatory SEC and GAAP accounting requirement.',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Well-specific risk assessments (HAZOP, HAZID, well control risk assessment) are conducted pre-spud. Assessments must reference the well for risk register and barrier management.',
    `norm_record_id` BIGINT COMMENT 'Foreign key linking to hse.norm_record. Business justification: NORM accumulates in drilling tubulars and equipment at certain wells. Records must identify the source well for disposal tracking, regulatory reporting, and worker exposure assessment.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Wells are drilled to meet specific offtake obligations under PSAs and joint operating agreements. Real business process: production planning where well development is directly tied to contractual volu',
    `parent_wellbore_drilling_well_id` BIGINT COMMENT 'Reference to the original wellbore from which this well was sidetracked or from which a multilateral branch originates. Null for original wellbores. Used to track wellbore family relationships and API number hierarchies.',
    `permit_id` BIGINT COMMENT 'FK to compliance.permit',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Wells produce specific petroleum products (crude oil, natural gas, condensate). This link is essential for production accounting, reserves booking, custody transfer allocation, SEC reserves reporting,',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Wells are drilled to access specific reservoirs. Core operational link for production allocation, reserves booking, field development planning, and regulatory reporting. Every producing well must be m',
    `rig_id` BIGINT COMMENT 'FK to drilling.rig',
    `api_well_number` STRING COMMENT 'Standardized 14-digit API well identifier assigned by regulatory authority. Format: state code (2) - county code (3) - unique well number (5) - optional sidetrack suffix (2). Serves as the industry-standard unique identifier for wellbores in the United States.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `authorized_afe_amount_usd` DECIMAL(18,2) COMMENT 'Total budget authorized in the Authorization for Expenditure (AFE) for drilling and completion operations, expressed in USD. Used to track cost variance and trigger supplemental AFE approvals when exceeded.',
    `bop_test_date` DATE COMMENT 'Date of the most recent Blowout Preventer (BOP) pressure test and function test. BOP testing is required before drilling ahead and at regular intervals per API Specification 53 and BSEE regulations to ensure well control equipment integrity.',
    `bottom_hole_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the wellbore bottom hole location in decimal degrees (WGS84 datum). For deviated and horizontal wells, differs from surface location. Critical for reservoir drainage area calculations and spacing unit compliance.',
    `bottom_hole_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the wellbore bottom hole location in decimal degrees (WGS84 datum). For deviated and horizontal wells, differs from surface location. Critical for reservoir drainage area calculations and spacing unit compliance.',
    `casing_program_design` STRING COMMENT 'Summary description of the casing string design including conductor, surface casing, intermediate casing, and production casing depths and sizes. Example: 20-inch conductor to 100 ft, 13-3/8-inch surface to 3000 ft, 9-5/8-inch intermediate to 10000 ft, 7-inch production to TD.',
    `completion_date` DATE COMMENT 'Date when well completion operations finished and the well was ready for production or injection. Marks the transition from drilling and completion (D&C) phase to production operations.',
    `directional_drilling_flag` BOOLEAN COMMENT 'Boolean indicator of whether directional drilling services were used. True indicates the well was intentionally deviated using Rotary Steerable System (RSS), mud motor, or other directional tools. Used for cost allocation and drilling performance benchmarking.',
    `drilling_days_actual` DECIMAL(18,2) COMMENT 'Total calendar days from spud date to rig release date, including productive time and Non-Productive Time (NPT). Used for drilling performance analysis and Authorization for Expenditure (AFE) variance reporting.',
    `drilling_days_planned` DECIMAL(18,2) COMMENT 'Estimated drilling duration from Authorization for Expenditure (AFE) or well plan. Used to calculate drilling performance variance and identify wells exceeding planned duration.',
    `dst_performed_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Drill Stem Test (DST) was performed during drilling operations. DST provides critical reservoir pressure, permeability, and fluid sample data used for reserves estimation and completion design.',
    `initial_production_bopd` DECIMAL(18,2) COMMENT 'Initial production rate measured during the first 24-hour flow test after completion, expressed in Barrels of Oil Per Day (BOPD). Critical metric for well performance evaluation, reserves estimation, and completion effectiveness assessment.',
    `initial_production_mcfd` DECIMAL(18,2) COMMENT 'Initial gas production rate measured during the first 24-hour flow test after completion, expressed in Thousand Cubic Feet per Day (MCFD). Used for gas well performance evaluation and reserves estimation.',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Total length of the wellbore measured along the actual drilled path from surface to bottom, expressed in feet. For deviated or horizontal wells, Measured Depth (MD) exceeds True Vertical Depth (TVD). Critical for drilling cost estimation and tubular design.',
    `mud_system_type` STRING COMMENT 'Classification of the primary drilling fluid system used. Water-based muds are environmentally preferred, oil-based and synthetic-based muds provide superior performance in challenging formations, and air or foam systems are used in underbalanced drilling.. Valid values are `water_based|oil_based|synthetic_based|foam|air`',
    `mwd_lwd_vendor` STRING COMMENT 'Name of the service company that provided Measurement While Drilling (MWD) and Logging While Drilling (LWD) services. MWD provides real-time directional and drilling parameter data, while LWD provides real-time formation evaluation logs.',
    `plugged_abandoned_date` DATE COMMENT 'Date when the wellbore was permanently plugged and abandoned according to regulatory requirements. Marks the end of the wells operational lifecycle and triggers asset retirement obligation (ARO) accounting.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wellbore record was first created in the system. Used for data lineage tracking and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this wellbore record was last modified. Used for change tracking and data quality monitoring.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority governing drilling and production operations for this wellbore. Federal offshore wells fall under Bureau of Safety and Environmental Enforcement (BSEE) jurisdiction, while state wells are governed by state oil and gas commissions.. Valid values are `federal_offshore|state_onshore|state_offshore|tribal|private`',
    `rig_release_date` DATE COMMENT 'Date when the drilling rig was released from the wellbore after reaching Total Depth (TD) or completing drilling operations. Used to calculate drilling duration and rig utilization metrics.',
    `spud_date` DATE COMMENT 'Date when drilling operations officially commenced (when the drill bit first penetrated the surface). Marks the beginning of the drilling phase and is used for Authorization for Expenditure (AFE) tracking and regulatory reporting.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the wellbore surface location in decimal degrees (WGS84 datum). Used for Geographic Information System (GIS) mapping, lease boundary verification, and regulatory reporting.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the wellbore surface location in decimal degrees (WGS84 datum). Used for Geographic Information System (GIS) mapping, lease boundary verification, and regulatory reporting.',
    `target_formation` STRING COMMENT 'Name of the primary geological formation or reservoir interval targeted by this wellbore. Used for geological analysis, reserves booking, and production allocation. Examples include Permian Wolfcamp, Eagle Ford Shale, or Niobrara Formation.',
    `total_depth_ft` DECIMAL(18,2) COMMENT 'Final measured depth reached by the wellbore before drilling operations ceased, expressed in feet. Represents the deepest point drilled and is used for AFE reconciliation and geological target confirmation.',
    `total_drilling_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost incurred for drilling operations from spud to rig release, expressed in USD. Includes rig dayrate, directional drilling services, Measurement While Drilling (MWD) and Logging While Drilling (LWD) services, mud and chemicals, casing and cementing, and Non-Productive Time (NPT) costs. Used for Capital Expenditure (CAPEX) tracking and AFE reconciliation.',
    `trajectory_type` STRING COMMENT 'Classification of the wellbore path geometry. Vertical wells have minimal deviation, directional wells are intentionally deviated, horizontal wells have lateral sections parallel to reservoir bedding, and multilateral wells have multiple branches from a common parent.. Valid values are `vertical|directional|horizontal|multilateral|extended_reach`',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'Vertical distance from the surface reference point to the bottom of the wellbore, expressed in feet. Used for reservoir pressure calculations, subsurface mapping, and regulatory reporting. Always less than or equal to Measured Depth (MD).',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Depth of water at the wellbore surface location for offshore wells, measured in feet from mean sea level to seafloor. Null for onshore wells. Critical for rig selection, riser design, and Blowout Preventer (BOP) stack configuration.',
    `well_class` STRING COMMENT 'Classification of the well based on primary hydrocarbon production or outcome. Oil wells primarily produce crude oil, gas wells produce natural gas, gas condensate wells produce both, and dry holes found no commercial hydrocarbons.. Valid values are `oil|gas|gas_condensate|dry_hole|suspended|unknown`',
    `well_name` STRING COMMENT 'Human-readable name assigned to the wellbore, typically following operator naming conventions (e.g., lease name + well number). Used for operational communication and reporting.',
    `well_status` STRING COMMENT 'Current operational status of the wellbore in its lifecycle. Tracks progression from planning through drilling, completion, production, and eventual plug and abandonment (P&A). Critical for operational reporting and regulatory compliance. [ENUM-REF-CANDIDATE: planned|permitted|drilling|completed|producing|shut_in|suspended|plugged_abandoned|cancelled — 9 candidates stripped; promote to reference product]',
    `well_type` STRING COMMENT 'Primary classification of the well based on its business purpose. Exploratory wells test unproven reserves, development wells produce from proven reserves, injection wells support Enhanced Oil Recovery (EOR) or disposal, and observation wells monitor reservoir conditions. [ENUM-REF-CANDIDATE: exploratory|development|appraisal|injection|disposal|observation|stratigraphic_test — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_drilling_well PRIMARY KEY(`drilling_well_id`)
) COMMENT 'Master record for every wellbore drilled or planned by Oil Gas, serving as the SSOT for well identity across the drilling domain. Captures API well number, well name, well type (exploratory, development, injection, disposal), well class, spud date, total depth (TD), measured depth (MD), true vertical depth (TVD), surface location coordinates (lat/long and UTM), bottom-hole location, field/block assignment, regulatory jurisdiction, BSEE/state permit number, well status (planned, drilling, completed, suspended, P&A), operator of record, and parent wellbore reference for sidetracks and multi-laterals. Aligns with API Bulletin D12A well classification standards and supports SEC reserves disclosure requirements. Every transactional record in the drilling domain references this product.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_program` (
    `well_program_id` BIGINT COMMENT 'Primary key for well_program',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Well programs are funded by AFE budgets. Critical for capital planning, budget allocation, and tracking estimated vs. actual costs. Standard oil-and-gas financial control process.',
    `dc_program_id` BIGINT COMMENT 'Foreign key reference to the parent drilling and completion program that this well program belongs to.',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key reference to the AFE that authorizes the capital expenditure for this well program.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well entity for which this program is designed.',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Risk assessments are conducted during well program design (pre-spud HAZOP). Assessments should reference the program for design risk mitigation and operational risk management.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Well programs must respect lease terms: depth rights, formation restrictions, expiry dates, and development obligations. Program approval requires lease verification. Critical for lease management and',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Well programs require designated program engineer for technical authority, design approval, and real-time decision support during drilling. Critical for MOC approvals, technical query resolution, and ',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Well programs are designed to develop specific reservoirs. Program economics, target selection, drilling strategy, and AFE justification all require explicit reservoir linkage. Essential for developme',
    `approval_date` DATE COMMENT 'Date when the well program was formally approved for execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or authority who approved the well program.',
    `bop_configuration` STRING COMMENT 'Description of the BOP stack configuration including ram types and annular preventers.',
    `bop_rating_psi` STRING COMMENT 'Pressure rating of the blowout preventer equipment required for the well, in pounds per square inch.',
    `casing_design_summary` STRING COMMENT 'High-level summary of the casing program including string types, sizes, and setting depths.',
    `cementing_program_summary` STRING COMMENT 'High-level summary of the cementing program including cement types, volumes, and placement strategy.',
    `co2_present` BOOLEAN COMMENT 'Indicator of whether carbon dioxide gas is expected to be encountered in the well.',
    `completion_strategy` STRING COMMENT 'Planned completion method for the well to enable production from the target formation.. Valid values are `openhole|cased_hole|liner|gravel_pack|frac_pack|intelligent_completion`',
    `created_date` DATE COMMENT 'Date when the well program record was first created in the system.',
    `depth_uom` STRING COMMENT 'Unit of measure for all depth measurements in the well program (feet or meters).. Valid values are `ft|m`',
    `drilling_method` STRING COMMENT 'Primary drilling method or technique planned for the well.. Valid values are `rotary|top_drive|coiled_tubing|underbalanced|managed_pressure`',
    `dst_planned` BOOLEAN COMMENT 'Indicator of whether a drill stem test is planned as part of the well program.',
    `environmental_disposal_classification` STRING COMMENT 'Classification of drilling waste and fluid disposal requirements based on environmental regulations.. Valid values are `non_hazardous|hazardous|special_waste|offshore_discharge_permitted`',
    `estimated_completion_days` STRING COMMENT 'Planned duration for completion operations after reaching total depth, measured in days.',
    `estimated_drilling_days` STRING COMMENT 'Planned duration for drilling operations from spud to total depth, measured in days.',
    `h2s_concentration_ppm` DECIMAL(18,2) COMMENT 'Expected concentration of hydrogen sulfide in parts per million if H2S is present.',
    `h2s_present` BOOLEAN COMMENT 'Indicator of whether hydrogen sulfide gas is expected to be encountered in the well.',
    `hpht_classification` STRING COMMENT 'Classification of the well based on expected downhole pressure and temperature conditions.. Valid values are `standard|hpht|extreme_hpht|not_applicable`',
    `last_modified_date` DATE COMMENT 'Date when the well program record was last updated in the system.',
    `max_anticipated_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum expected formation pressure to be encountered during drilling, in pounds per square inch.',
    `max_anticipated_temperature_f` DECIMAL(18,2) COMMENT 'Maximum expected downhole temperature to be encountered during drilling, in degrees Fahrenheit.',
    `max_dogleg_severity` DECIMAL(18,2) COMMENT 'Maximum allowable rate of change in wellbore direction, measured in degrees per 100 feet or 30 meters.',
    `max_inclination_angle` DECIMAL(18,2) COMMENT 'Maximum planned deviation angle from vertical in the well trajectory, measured in degrees.',
    `mud_system_type` STRING COMMENT 'Primary drilling fluid system type planned for the well program.. Valid values are `water_based|oil_based|synthetic_based|pneumatic`',
    `mud_weight_max` DECIMAL(18,2) COMMENT 'Maximum planned drilling fluid density across all hole sections, in pounds per gallon (ppg) or specific gravity.',
    `mud_weight_min` DECIMAL(18,2) COMMENT 'Minimum planned drilling fluid density across all hole sections, in pounds per gallon (ppg) or specific gravity.',
    `mud_weight_uom` STRING COMMENT 'Unit of measure for drilling fluid density (pounds per gallon, specific gravity, or kilograms per cubic meter).. Valid values are `ppg|sg|kg_m3`',
    `mwd_lwd_program` STRING COMMENT 'Summary of the planned MWD and LWD services including directional surveys, formation evaluation, and real-time data acquisition.',
    `planned_td_md` DECIMAL(18,2) COMMENT 'Planned total depth of the well measured along the wellbore path, in feet or meters.',
    `planned_td_tvd` DECIMAL(18,2) COMMENT 'Planned total depth of the well measured vertically from surface to target, in feet or meters.',
    `program_name` STRING COMMENT 'Descriptive name of the well program, often including well name and program type.',
    `program_number` STRING COMMENT 'Business identifier for the well program document, typically assigned by engineering or operations.',
    `program_status` STRING COMMENT 'Current lifecycle status of the well program document. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `program_type` STRING COMMENT 'Classification of the well program based on the type of operation planned.. Valid values are `drilling|completion|workover|sidetrack|plug_and_abandonment|recompletion`',
    `revision_date` DATE COMMENT 'Date when the current revision of the well program was created.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking changes to the well program document.',
    `rig_type_required` STRING COMMENT 'Type of drilling rig required to execute the well program based on location and well design.. Valid values are `land|jackup|semisubmersible|drillship|platform`',
    `target_formation` STRING COMMENT 'Primary geological formation or reservoir zone that the well is designed to reach and produce from.',
    `well_trajectory_type` STRING COMMENT 'Classification of the planned wellbore trajectory design.. Valid values are `vertical|directional|horizontal|extended_reach|multilateral`',
    CONSTRAINT pk_well_program PRIMARY KEY(`well_program_id`)
) COMMENT 'Approved drilling and completion program document for a well, capturing the full engineering design basis including target formation, planned trajectory, casing design, mud program (fluid type, weight range, viscosity targets per hole section, HPHT requirements, environmental disposal classification), cementing program, completion strategy, and AFE reference. Tracks program revision history, approval status, and the D&C program it belongs to. Links to the AFE for cost authorization and serves as the governing technical document for all drilling operations on the well. Includes hole-section-level mud system specifications with actual vs planned property tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`rig` (
    `rig_id` BIGINT COMMENT 'Primary key for rig',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Rigs require safety certifications (API, classification society, BSEE SEMS) to operate legally. Certification tracking is mandatory for rig mobilization and contract compliance in oil-and-gas operatio',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Rigs operate under procurement contracts specifying day rates, mobilization fees, and terms. Essential for contract compliance, rate validation, and invoice reconciliation. Standard rig contract manag',
    `contractor_id` BIGINT COMMENT 'FK to workforce.contractor',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rigs are assigned to cost centers for overhead allocation and rig-specific cost tracking. New attribute needed; no existing candidate. Real business process for rig cost management.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Rigs are capital equipment assets requiring maintenance planning, work orders, failure tracking, inspection scheduling, depreciation accounting, and asset hierarchy management. Enables preventive main',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Owned rigs are fixed assets requiring depreciation tracking and asset accounting. New attribute needed; no existing candidate. Mandatory accounting requirement for owned rig assets.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Rig mobilization and demobilization require specialized heavy-haul or marine carriers. Tracking the carrier enables logistics coordination, demurrage management, and mobilization cost reconciliation a',
    `accommodation_capacity` STRING COMMENT 'Maximum number of personnel that can be accommodated on the rig at one time, including crew quarters and living facilities.',
    `active_heave_compensation` BOOLEAN COMMENT 'Indicates whether the rig is equipped with active heave compensation technology to mitigate vertical motion during offshore drilling operations.',
    `api_rig_number` STRING COMMENT 'API-assigned unique identifier for the drilling rig used in industry-standard reporting and data exchange.',
    `bop_pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum working pressure rating of the BOP stack in pounds per square inch, critical for well control operations.',
    `bop_stack_configuration` STRING COMMENT 'Description of the BOP stack configuration installed on the rig, including type (annular, ram), pressure rating, and number of preventers.',
    `bsee_rig_code` STRING COMMENT 'Unique identifier assigned by BSEE for offshore rigs operating in U.S. federal waters, used for regulatory reporting and compliance tracking.',
    `build_year` STRING COMMENT 'Year in which the rig was originally constructed or commissioned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rig record was first created in the system.',
    `current_location` STRING COMMENT 'Current geographic location or field where the rig is operating or stationed, including basin, block, or lease name.',
    `demobilization_date` DATE COMMENT 'Date when the rig completed demobilization from its most recent drilling location.',
    `derrick_height_ft` DECIMAL(18,2) COMMENT 'Height of the drilling derrick or mast in feet, measured from the rig floor to the crown block.',
    `drawworks_horsepower` DECIMAL(18,2) COMMENT 'Total horsepower rating of the rigs drawworks, indicating the power available for hoisting and drilling operations.',
    `dynamic_positioning_class` STRING COMMENT 'Dynamic positioning system classification for offshore rigs, indicating the level of redundancy and station-keeping capability (DP1, DP2, DP3, or not applicable for moored/jackup rigs).. Valid values are `DP0|DP1|DP2|DP3|not_applicable`',
    `hook_load_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum weight in pounds that the rigs hoisting system can safely lift, critical for BHA and casing operations.',
    `hse_rating` STRING COMMENT 'Current HSE performance rating or classification assigned to the rig based on safety record, incident history, and compliance audits.',
    `imo_number` STRING COMMENT 'Unique seven-digit IMO ship identification number assigned to offshore mobile drilling units for maritime tracking and safety.. Valid values are `^IMO[0-9]{7}$`',
    `last_certification_date` DATE COMMENT 'Date of the most recent safety or regulatory certification inspection completed for the rig.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the rigs current or last known position in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the rigs current or last known position in decimal degrees.',
    `max_drilling_depth_ft` DECIMAL(18,2) COMMENT 'Maximum measured depth (MD) in feet that the rig is capable of drilling based on its equipment and configuration.',
    `mobilization_date` DATE COMMENT 'Date when the rig began mobilization to its current or most recent drilling location.',
    `mud_pump_capacity_hp` DECIMAL(18,2) COMMENT 'Total horsepower capacity of the rigs mud pumps used for circulating drilling fluid.',
    `next_certification_due_date` DATE COMMENT 'Date when the next mandatory safety or regulatory certification inspection is due for the rig.',
    `operating_region` STRING COMMENT 'Geographic region or basin where the rig is currently deployed or primarily operates (e.g., Gulf of Mexico, Permian Basin, North Sea).',
    `operational_status` STRING COMMENT 'Current operational state of the rig indicating its availability and activity level. [ENUM-REF-CANDIDATE: active|idle|mobilizing|demobilizing|maintenance|stacked|retired — 7 candidates stripped; promote to reference product]',
    `ownership_type` STRING COMMENT 'Indicates whether the rig is owned by Oil Gas, contracted from a third party, leased, or part of a joint venture arrangement.. Valid values are `owned|contracted|leased|joint_venture`',
    `rated_water_depth_ft` DECIMAL(18,2) COMMENT 'Maximum water depth in feet at which the rig is rated to operate safely, applicable to offshore rigs.',
    `registration_flag` STRING COMMENT 'Three-letter ISO country code representing the country under which the rig is registered or flagged.. Valid values are `^[A-Z]{3}$`',
    `rig_class` STRING COMMENT 'Detailed classification or subtype of the rig within its type category, indicating specific design features or capabilities (e.g., ultra-deepwater drillship, heavy-duty land rig).',
    `rig_name` STRING COMMENT 'Official name or designation of the drilling rig as registered with the operator or contractor.',
    `rig_number` STRING COMMENT 'Contractor-assigned rig number or fleet identifier used for operational tracking and scheduling.',
    `rig_type` STRING COMMENT 'Classification of the drilling rig based on its operational environment and mobility characteristics.. Valid values are `land|jackup|semi-submersible|drillship|platform|barge`',
    `rotary_table_size_in` DECIMAL(18,2) COMMENT 'Diameter of the rotary table opening in inches, determining the maximum size of drill pipe and casing that can pass through.',
    `top_drive_capacity_tons` DECIMAL(18,2) COMMENT 'Weight capacity in tons of the rigs top drive system, if equipped, used for rotating the drill string.',
    `total_recordable_incident_rate` DECIMAL(18,2) COMMENT 'TRIR metric for the rig, calculated as the number of recordable incidents per 200,000 work hours, used to measure safety performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rig record was last modified or updated in the system.',
    `variable_deck_load_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum variable deck load capacity in pounds that the rig can safely support, critical for offshore platform rigs and equipment storage.',
    CONSTRAINT pk_rig PRIMARY KEY(`rig_id`)
) COMMENT 'Master record for drilling rigs contracted or owned by Oil Gas, capturing rig name, rig type (jackup, semi-submersible, drillship, land rig), rig class, contractor name, rated water depth, hook load capacity, derrick height, BOP stack configuration, rig registration flag, BSEE rig ID, current operational status, and mobilization/demobilization dates. Serves as the SSOT for rig identity within the drilling domain, supporting rig scheduling and NPT tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` (
    `rig_schedule_id` BIGINT COMMENT 'Unique identifier for the rig schedule record. Primary key for the rig schedule entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Rig schedules execute specific contract terms including day rates, standby rates, and mobilization fees. Required for accurate cost accrual, contract performance tracking, and billing validation.',
    `dc_program_id` BIGINT COMMENT 'Identifier of the drilling and completion program under which this rig schedule falls. Links to the D&C program master data.',
    `drilling_afe_id` BIGINT COMMENT 'Identifier of the AFE authorizing the drilling expenditure for this rig schedule. Links to the AFE master data.',
    `drilling_well_id` BIGINT COMMENT 'Identifier of the well to which the rig is scheduled. Links to the well master data.',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig assigned to this schedule. Links to the rig master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rig schedules require designated rig superintendent for execution accountability, crew coordination, and operational authority. Essential for SIMOPS coordination, schedule variance analysis, and HSE i',
    `well_program_id` BIGINT COMMENT 'Foreign key linking to drilling.well_program. Business justification: Rig schedule executes a specific well program. The schedule should reference the program being executed to link operational scheduling with engineering design. Note that rig_schedule already has drill',
    `actual_completion_days` DECIMAL(18,2) COMMENT 'Actual number of days for well completion activities after reaching TD. Captured for schedule variance analysis and completion performance assessment.',
    `actual_drilling_days` DECIMAL(18,2) COMMENT 'Actual number of days for drilling operations from spud to TD. Captured for schedule variance analysis and drilling performance benchmarking.',
    `actual_rig_move_end_date` DATE COMMENT 'Actual date when the rig move to the current well location was completed and the rig was ready for spud. Captured for rig move duration analysis and NPT assessment.',
    `actual_rig_move_start_date` DATE COMMENT 'Actual date when the rig move from the previous location to the current well location began. Captured for rig move duration analysis.',
    `actual_rig_release_date` DATE COMMENT 'Actual date when the rig was released from the well. Captured for rig utilization analysis and schedule variance tracking.',
    `actual_spud_date` DATE COMMENT 'Actual date when drilling operations commenced (spud). Captured for schedule variance analysis and Non-Productive Time (NPT) assessment.',
    `actual_td_date` DATE COMMENT 'Actual date when the well reached Total Depth (TD). Captured for schedule variance analysis and drilling performance assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rig schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `npt_days` DECIMAL(18,2) COMMENT 'Total number of Non-Productive Time (NPT) days during this schedule period. NPT includes time lost due to equipment failures, stuck pipe, wellbore instability, and other unplanned events. Used for drilling efficiency analysis and cost impact assessment.',
    `offshore_flag` BOOLEAN COMMENT 'Indicates whether this rig schedule is for offshore drilling operations. True for offshore, False for onshore. Used for regulatory compliance tracking and operational planning.',
    `permit_delay_days` DECIMAL(18,2) COMMENT 'Number of days the schedule was delayed due to permitting or regulatory approval delays. Used for schedule variance analysis and regulatory compliance tracking.',
    `planned_completion_days` DECIMAL(18,2) COMMENT 'Planned number of days for well completion activities after reaching TD. Used for total well cycle time planning and rig release scheduling.',
    `planned_drilling_days` DECIMAL(18,2) COMMENT 'Planned number of days for drilling operations from spud to TD. Used for AFE cost estimation and rig utilization planning.',
    `planned_rig_move_end_date` DATE COMMENT 'Planned date when the rig move to the current well location is scheduled to be completed and the rig is ready for spud. Used for spud date planning.',
    `planned_rig_move_start_date` DATE COMMENT 'Planned date when the rig move from the previous location to the current well location is scheduled to begin. Used for logistics planning and rig availability forecasting.',
    `planned_rig_release_date` DATE COMMENT 'Planned date when the rig is scheduled to be released from the well after completion of drilling and well completion activities. Used for rig move planning and next well scheduling.',
    `planned_spud_date` DATE COMMENT 'Planned date when drilling operations are scheduled to commence (spud). Used for rig utilization planning and AFE timing alignment.',
    `planned_td_date` DATE COMMENT 'Planned date when the well is scheduled to reach Total Depth (TD). Used for drilling duration planning and rig release scheduling.',
    `rig_move_duration_days` DECIMAL(18,2) COMMENT 'Actual duration in days for the rig move from the previous location to the current well location. Calculated as the difference between actual rig move end date and actual rig move start date. Used for rig move efficiency analysis and future planning.',
    `schedule_notes` STRING COMMENT 'Free-text notes capturing additional schedule details, constraints, special requirements, or explanations for schedule changes. Used for operational communication and audit trail.',
    `schedule_number` STRING COMMENT 'Business identifier for the rig schedule record. Human-readable schedule reference number used in operational communications and reporting.',
    `schedule_priority` STRING COMMENT 'Business priority level assigned to this rig schedule. Used for resource allocation decisions and schedule conflict resolution when multiple wells compete for limited rig availability.. Valid values are `critical|high|medium|low`',
    `schedule_revision_number` STRING COMMENT 'Version number of the schedule. Incremented each time the schedule is revised due to changes in dates, rig assignment, or other material changes. Supports schedule change tracking and audit trail.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the rig schedule. Indicates whether the schedule is in planning, confirmed, actively executing, completed, cancelled, suspended, or delayed. [ENUM-REF-CANDIDATE: planned|confirmed|active|completed|cancelled|suspended|delayed — 7 candidates stripped; promote to reference product]',
    `schedule_variance_days` DECIMAL(18,2) COMMENT 'Total schedule variance in days, calculated as the difference between actual and planned rig release dates. Positive values indicate delays, negative values indicate early completion. Used for drilling performance analysis.',
    `simops_coordination_notes` STRING COMMENT 'Free-text notes describing SIMOPS coordination requirements, proximity to other operations, and special safety protocols. Populated when simops_flag is True.',
    `simops_flag` BOOLEAN COMMENT 'Indicates whether this rig schedule involves Simultaneous Operations (SIMOPS) with other rigs or facilities operating in proximity. True if SIMOPS coordination is required, False otherwise. Used for HSE risk assessment and operational coordination.',
    `standby_days` DECIMAL(18,2) COMMENT 'Number of days the rig was on standby during this schedule period. Standby occurs when the rig is available but not actively drilling due to weather, permitting delays, or other external factors. Used for NPT analysis and cost tracking.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated this rig schedule record. Used for audit trail and change accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rig schedule record was last updated in the system. Used for audit trail and change tracking.',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Water depth in feet at the drilling location for offshore operations. Null for onshore operations. Used for rig capability matching and regulatory reporting.',
    `weather_delay_days` DECIMAL(18,2) COMMENT 'Number of days the schedule was delayed due to adverse weather conditions. Subset of standby days. Used for schedule variance analysis and risk assessment.',
    `created_by` STRING COMMENT 'User identifier of the person who created this rig schedule record. Used for audit trail and accountability.',
    CONSTRAINT pk_rig_schedule PRIMARY KEY(`rig_schedule_id`)
) COMMENT 'Time-phased scheduling record assigning a rig to a specific well or sequence of wells within a D&C program. Captures planned spud date, planned TD date, planned rig release date, actual dates, rig move duration, standby days, and schedule revision number. Enables rig utilization planning, AFE timing alignment, and NPT impact assessment across the drilling portfolio. Supports SIMOPS coordination when multiple rigs operate in proximity.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` (
    `drilling_afe_id` BIGINT COMMENT 'Primary key for afe',
    `incident_id` BIGINT COMMENT 'Unique identifier for the Authorization for Expenditure record. Primary key for the AFE entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: drilling.afe tracks operational AFE execution; procurement.afe_budget holds financial authorization and budget control. Link enables budget variance analysis, commitment tracking, and financial report',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: AFE data feeds SEC reserve disclosures and cost reporting for proved undeveloped reserves. Financial authorization data links to regulatory submissions for capital expenditure and reserves booking com',
    `cost_center_id` BIGINT COMMENT 'SAP cost center code to which AFE expenditures are charged for internal financial reporting and cost allocation. Links drilling costs to organizational units.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well entity for which this AFE authorizes expenditure. Links the AFE to the specific wellbore being drilled, completed, or worked over.',
    `joint_venture_id` BIGINT COMMENT 'Foreign key reference to the joint venture entity under which this AFE is executed. Links the AFE to the partnership agreement and working interest structure.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: AFEs track joint venture partners and their working interest shares for cost allocation. Required for: JV billing runs, partner approval workflows, non-consent tracking, joint interest billing stateme',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: AFEs authorize capital expenditure on specific leases. Essential for JIB billing, working interest cost allocation, lease development obligation tracking, and operator vs non-operator accounting. Stan',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Drilling programs are authorized to develop production capacity for specific offtake commitments. Real business process: capital authorization for wells drilled to meet contractual volume obligations ',
    `operator_id` BIGINT COMMENT 'Foreign key reference to the operator entity responsible for executing the AFE work program. In joint ventures, this is the designated operator who manages day-to-day operations.',
    `rig_id` BIGINT COMMENT 'FK to drilling.rig',
    `wbs_element_id` BIGINT COMMENT 'SAP Project Systems WBS element code representing the hierarchical project structure for this AFE. Used for project-based cost tracking and capital project management.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: AFEs authorize capital work including major asset modifications and integrity projects. Work orders reference AFE numbers for cost authorization. Enables capital work order tracking, budget variance a',
    `actual_completion_date` DATE COMMENT 'Actual date on which all AFE-authorized work was completed and the rig was released. Populated when operations are finished. Used for schedule and cost variance analysis.',
    `actual_drilling_days` STRING COMMENT 'Actual number of days from spud to rig release. Populated upon well completion. Used for performance analysis and lessons learned.',
    `actual_spud_date` DATE COMMENT 'Actual date on which drilling operations commenced. Populated once the well is spudded. Used for schedule variance analysis.',
    `actual_total_depth_ft` DECIMAL(18,2) COMMENT 'Actual total measured depth reached during drilling operations, in feet. Populated upon reaching TD. Used for technical and cost variance analysis.',
    `afe_number` STRING COMMENT 'Business identifier for the AFE, typically a formatted alphanumeric code used across joint venture partners and in financial systems. This is the externally-known AFE reference number.',
    `afe_status` STRING COMMENT 'Current lifecycle status of the AFE: draft (being prepared), submitted (awaiting approval), approved (authorized for execution), active (work in progress), suspended (temporarily halted), closed (work completed and final costs reconciled), or cancelled (authorization revoked). [ENUM-REF-CANDIDATE: draft|submitted|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `afe_type` STRING COMMENT 'Classification of the AFE by the type of operation being authorized: drilling (new well), workover (remedial work on existing well), completion (initial well completion), recompletion (re-entering existing wellbore), sidetrack (drilling from existing wellbore), or plug and abandonment (P&A operations).. Valid values are `drilling|workover|completion|recompletion|sidetrack|plug_and_abandonment`',
    `approval_date` DATE COMMENT 'Date on which the AFE was formally approved by the authorized approver or approval committee, marking the transition from submitted to approved status.',
    `approver_name` STRING COMMENT 'Full name of the individual or committee that approved the AFE. Typically a senior operations manager, drilling manager, or capital allocation committee.',
    `approver_title` STRING COMMENT 'Job title or role of the AFE approver, such as Drilling Manager, VP Operations, or Capital Committee Chair. Provides context for approval authority level.',
    `authorization_basis` STRING COMMENT 'Reference to the governing document or decision that authorized this AFE, such as Board Resolution number, Capital Committee meeting minutes, or JOA clause reference.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between approved budget (approved CAPEX plus supplemental AFE amounts) and cumulative actual cost. Positive values indicate under-budget, negative values indicate over-budget.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'Budget variance expressed as a percentage of the approved budget. Used for performance dashboards and variance reporting. Calculated as (budget_variance_amount / approved_capex_amount) * 100.',
    `closed_date` DATE COMMENT 'Date on which the AFE was formally closed after final cost reconciliation and all invoices were processed. Marks the end of the AFE lifecycle.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Percentage of the approved CAPEX amount allocated as contingency reserve for unforeseen costs or operational challenges. Typically ranges from 5% to 20% based on risk category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AFE record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `cumulative_actual_cost` DECIMAL(18,2) COMMENT 'Running total of all actual costs incurred against this AFE to date, aggregated from AFE line-item detail records. Updated as invoices are processed and costs are posted.',
    `drilling_program_description` STRING COMMENT 'Narrative description of the drilling program, including well objectives, target formations, planned casing program, and completion strategy. Provides technical context for the AFE.',
    `estimated_completion_date` DATE COMMENT 'Planned date for completing all work authorized under this AFE, including drilling to total depth, running casing, cementing, and initial completion activities.',
    `estimated_drilling_days` STRING COMMENT 'Planned number of days from spud to rig release as estimated in the AFE. Used for rig day rate cost calculations and schedule planning.',
    `estimated_spud_date` DATE COMMENT 'Planned date for spudding (commencing drilling operations) on the well covered by this AFE. Used for rig scheduling and operational planning.',
    `estimated_total_depth_ft` DECIMAL(18,2) COMMENT 'Planned total measured depth of the well in feet as specified in the AFE drilling program. Used for cost estimation and rig contract planning.',
    `jib_billing_code` STRING COMMENT 'COPAS-compliant billing code used for joint interest billing to non-operating partners. Determines how costs are categorized and allocated in JIB statements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this AFE record. Used for audit trail and change tracking.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The companys net revenue interest percentage after deducting royalties and overriding royalty interests. Used for economic evaluation of the AFE investment. Expressed as a percentage.',
    `non_consent_flag` BOOLEAN COMMENT 'Boolean indicator set to True if one or more joint venture partners elected not to participate in this AFE, triggering non-consent penalty provisions per the JOA.',
    `over_budget_flag` BOOLEAN COMMENT 'Boolean indicator set to True when cumulative actual cost exceeds the approved budget (approved CAPEX plus supplemental AFE amounts), triggering alerts and supplemental AFE requirements.',
    `rig_contractor_name` STRING COMMENT 'Name of the drilling contractor providing the rig for this AFE. Key vendor for the largest cost component of the AFE.',
    `rig_day_rate` DECIMAL(18,2) COMMENT 'Contracted daily rate for the drilling rig in the AFE currency. The largest single cost driver in most drilling AFEs. Used for cost estimation and variance analysis.',
    `risk_category` STRING COMMENT 'Overall risk classification for the AFE based on technical complexity, geological uncertainty, HSE hazards, and cost exposure. Used for approval routing and contingency planning.. Valid values are `low|medium|high|critical`',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The companys working interest percentage in the well for which this AFE is issued. Determines the companys share of AFE costs. Expressed as a percentage (e.g., 35.50 for 35.5%).',
    CONSTRAINT pk_drilling_afe PRIMARY KEY(`drilling_afe_id`)
) COMMENT 'Authorization for Expenditure record governing the approved capital budget and actual cost tracking for drilling and completion operations. Header captures AFE number, AFE type (drilling, workover, P&A, sidetrack), approved CAPEX amount, supplemental AFE amounts, cost center, WBS element, approval date, approver hierarchy, joint venture partner split percentages, and AFE status (draft, approved, closed). Line-item detail captures cost date, cost category (rig day rate, mud and chemicals, bits, casing and tubing, cementing, directional services, logging, completion services, fuel, catering), vendor name, invoice reference, actual amount, cumulative spend vs budget, and variance flag. Serves as the financial control document linking drilling operations to SAP PS/CO cost tracking and JIB processing per COPAS standards.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` (
    `daily_drilling_report_id` BIGINT COMMENT 'Unique identifier for the daily drilling report record.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Daily drilling costs roll up to AFE budgets for real-time variance tracking and budget burn rate analysis. Essential for daily cost control and early warning of budget overruns.',
    `bit_run_id` BIGINT COMMENT 'Foreign key linking to drilling.bit_run. Business justification: Daily drilling report captures 24-hour activity for a specific bit run. The report has bit_run_number but should formally link to bit_run master record for referential integrity and to enable joining ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Daily drilling reports require drilling supervisor accountability for operational decisions, HSE compliance, and regulatory reporting. Standard industry practice tracks the on-site supervisor responsi',
    `drilling_well_id` BIGINT COMMENT 'Identifier of the well being drilled during this 24-hour reporting period.',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig performing operations during this reporting period.',
    `afe_variance_usd` DECIMAL(18,2) COMMENT 'Variance between cumulative cost and AFE budget (cumulative_cost_usd minus afe_budget_usd), measured in US dollars. Positive indicates over budget.',
    `bit_depth_in_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the current bit was run into the hole, in feet.',
    `bit_depth_out_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the current bit was pulled out of the hole, in feet. Null if bit is still in hole.',
    `bop_test_date` DATE COMMENT 'Date of the most recent BOP pressure test conducted prior to or during the reporting period.',
    `bop_test_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at which the BOP was tested during the most recent test, measured in pounds per square inch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily drilling report record was first created in the system.',
    `crew_on_board_count` STRING COMMENT 'Total number of personnel on the rig during the reporting period.',
    `cumulative_cost_usd` DECIMAL(18,2) COMMENT 'Total cumulative drilling cost from spud to the end of the reporting period, measured in US dollars.',
    `daily_cost_usd` DECIMAL(18,2) COMMENT 'Total drilling cost incurred during the 24-hour reporting period, measured in US dollars.',
    `depth_drilled_ft` DECIMAL(18,2) COMMENT 'Total footage drilled during the 24-hour reporting period, measured in feet.',
    `equivalent_circulating_density_ppg` DECIMAL(18,2) COMMENT 'Calculated equivalent circulating density at the bottom of the hole during circulation, measured in pounds per gallon.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Drilling mud circulation flow rate, measured in gallons per minute.',
    `formation_top_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the formation top was encountered, in feet.',
    `formation_top_encountered` STRING COMMENT 'Name of the geological formation top encountered during the reporting period, if any.',
    `hookload_klbs` DECIMAL(18,2) COMMENT 'Average hookload during operations, measured in thousands of pounds.',
    `hse_incidents_count` STRING COMMENT 'Number of HSE incidents (injuries, near-misses, environmental releases) reported during the 24-hour period.',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Current measured depth of the wellbore at the end of the reporting period, measured along the wellbore trajectory in feet.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this daily drilling report record was last modified in the system.',
    `mud_type` STRING COMMENT 'Type of drilling fluid system in use during the reporting period.. Valid values are `water_based|oil_based|synthetic_based|foam|air`',
    `mud_viscosity_seconds` DECIMAL(18,2) COMMENT 'Funnel viscosity of the drilling mud, measured in seconds using a Marsh funnel.',
    `mud_weight_ppg` DECIMAL(18,2) COMMENT 'Drilling mud weight (density) in use during the reporting period, measured in pounds per gallon.',
    `non_productive_time_hours` DECIMAL(18,2) COMMENT 'Total hours of non-productive time during the 24-hour reporting period due to equipment failure, waiting on weather, or other unplanned delays.',
    `npt_category` STRING COMMENT 'Primary category or reason code for non-productive time (e.g., equipment failure, weather, stuck pipe, well control).',
    `operation_status` STRING COMMENT 'Primary operational activity status during the reporting period. [ENUM-REF-CANDIDATE: drilling|tripping|circulating|logging|casing|cementing|testing|waiting_on_weather|npt|completed|suspended — 11 candidates stripped; promote to reference product]',
    `operations_summary` STRING COMMENT 'Narrative summary of drilling operations, activities, and significant events during the 24-hour reporting period.',
    `productive_time_hours` DECIMAL(18,2) COMMENT 'Total hours of productive drilling operations during the 24-hour reporting period.',
    `rate_of_penetration_ft_per_hr` DECIMAL(18,2) COMMENT 'Average rate of penetration during drilling operations for the reporting period, measured in feet per hour.',
    `report_date` DATE COMMENT 'The calendar date for which this daily drilling report covers 24-hour operations (typically 0600 to 0600 or 0000 to 2400 depending on operator convention).',
    `report_number` STRING COMMENT 'Sequential report number or identifier assigned by the operator for tracking and audit purposes.',
    `rotary_speed_rpm` DECIMAL(18,2) COMMENT 'Average rotary speed of the drill string during drilling operations, measured in revolutions per minute.',
    `standpipe_pressure_psi` DECIMAL(18,2) COMMENT 'Average standpipe pressure during circulation, measured in pounds per square inch.',
    `torque_ft_lbs` DECIMAL(18,2) COMMENT 'Average rotary torque during drilling operations, measured in foot-pounds.',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'Current true vertical depth of the wellbore at the end of the reporting period, measured vertically from the surface reference point in feet.',
    `weight_on_bit_klbs` DECIMAL(18,2) COMMENT 'Average weight on bit during drilling operations, measured in thousands of pounds (klbs).',
    CONSTRAINT pk_daily_drilling_report PRIMARY KEY(`daily_drilling_report_id`)
) COMMENT 'Daily operational report (DDR) capturing 24-hour drilling activity for a well-rig combination. Records depth drilled, formation tops encountered, mud weight, mud type, bit size, bit run details, ROP (Rate of Penetration), WOB (Weight on Bit), RPM, flow rate, standpipe pressure, ECD (Equivalent Circulating Density), daily cost, cumulative cost vs AFE, crew on board, and a narrative summary of operations. Sourced from the Avocet Production Operations and PI System integration. Critical for NPT tracking and daily cost surveillance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`npt_event` (
    `npt_event_id` BIGINT COMMENT 'Unique identifier for the non-productive time or well control event record.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: NPT events have cost impacts tracked against AFE budgets. Required for budget variance analysis, contingency drawdown tracking, and post-well cost reviews. Standard drilling cost management.',
    `drilling_afe_id` BIGINT COMMENT 'Identifier of the AFE under which the drilling operation and NPT event are tracked.',
    `drilling_well_id` BIGINT COMMENT 'Identifier of the well where the NPT event occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who reported or logged the NPT event.',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig on which the NPT event occurred.',
    `bsee_incident_notification_status` STRING COMMENT 'Status of regulatory incident notification to BSEE for offshore well control events and other reportable incidents.. Valid values are `not_required|pending|submitted|acknowledged|under_investigation`',
    `bsee_incident_number` STRING COMMENT 'Official incident number assigned by BSEE for reportable well control or safety incidents.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions and remedial measures taken to resolve the NPT event and resume drilling operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the NPT event record was first created in the system.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the NPT event in hours, calculated from start to end timestamp.',
    `estimated_cost_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the NPT event in US dollars, including rig time, materials, and services.',
    `event_category` STRING COMMENT 'Primary classification of the NPT event type. [ENUM-REF-CANDIDATE: equipment_failure|weather|stuck_pipe|well_control_kick|well_control_influx|waiting_on_cement|waiting_on_orders|logistics_delay|fishing_operations|hole_problems|bop_testing|rig_repair|supply_delay|personnel_issue|regulatory_delay|other — promote to reference product]',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the non-productive time or well control event ended.',
    `event_number` STRING COMMENT 'Business identifier or sequence number assigned to the NPT event for tracking and reporting purposes.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the non-productive time or well control event began.',
    `event_subcategory` STRING COMMENT 'Detailed subcategory or specific cause within the primary event category for granular root cause analysis.',
    `iadc_npt_code` STRING COMMENT 'Standardized IADC code for classifying the NPT event type for industry benchmarking and reporting.',
    `kill_method` STRING COMMENT 'Well control kill method employed to regain control of the well during a well control event.. Valid values are `drillers_method|wait_and_weight|concurrent|volumetric|bullheading|dynamic_kill`',
    `kill_mud_weight_ppg` DECIMAL(18,2) COMMENT 'Density of the kill mud in pounds per gallon used to control the well and prevent further influx during a well control event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the NPT event record was last updated or modified.',
    `lessons_learned` STRING COMMENT 'Key lessons learned and best practices identified from the NPT event for future drilling operations improvement.',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet along the wellbore at which the NPT event occurred.',
    `operator_npt_code` STRING COMMENT 'Internal operator-specific code for classifying and tracking NPT events within the companys drilling performance system.',
    `pit_gain_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of fluid gain in barrels observed in the mud pits during a well control event, indicating influx from the formation.',
    `preventability_flag` BOOLEAN COMMENT 'Indicates whether the NPT event was preventable through better planning, execution, or equipment maintenance.',
    `reporting_status` STRING COMMENT 'Current status of the NPT event record in the reporting and approval workflow.. Valid values are `draft|submitted|approved|closed`',
    `responsible_party` STRING COMMENT 'Entity responsible for the NPT event, used for cost allocation and performance tracking.. Valid values are `operator|drilling_contractor|service_provider|third_party|force_majeure`',
    `rig_system_involved` STRING COMMENT 'Specific rig system or equipment component involved in the NPT event (e.g., top drive, mud pumps, BOP, drawworks).',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis has been completed for this NPT event.',
    `root_cause_summary` STRING COMMENT 'Summary of the root cause analysis findings identifying the underlying cause of the NPT event.',
    `sicp_psi` DECIMAL(18,2) COMMENT 'Shut-in casing pressure in PSI recorded during a well control event, indicating annular pressure and potential formation influx.',
    `sidpp_psi` DECIMAL(18,2) COMMENT 'Shut-in drill pipe pressure in PSI recorded during a well control event, used to calculate formation pressure and kill mud weight.',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'True vertical depth in feet at which the NPT event occurred.',
    `well_control_event_flag` BOOLEAN COMMENT 'Indicates whether this NPT event involved a well control incident such as a kick or influx requiring well control procedures.',
    CONSTRAINT pk_npt_event PRIMARY KEY(`npt_event_id`)
) COMMENT 'Non-Productive Time (NPT) and well control event record capturing every instance of unplanned downtime or well control incident during drilling operations. Records event start and end timestamps, duration in hours, event category (equipment failure, weather, stuck pipe, well control kick/influx, waiting on cement, waiting on orders, logistics delay), responsible party (operator vs contractor), rig system involved, estimated cost impact, corrective action taken, preventability flag, and for well control events: pit gain volume, shut-in drill pipe pressure (SIDPP), shut-in casing pressure (SICP), kill method, kill mud weight, and BSEE incident notification status. Feeds NPT benchmarking, D&C performance improvement programs, and BSEE well control incident reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` (
    `bha_configuration_id` BIGINT COMMENT 'Unique identifier for the BHA configuration record. Primary key.',
    `bit_run_id` BIGINT COMMENT 'Foreign key reference to the specific bit run during which this BHA configuration was used.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: BHA configurations require engineer accountability for design integrity, torque-drag analysis, and performance optimization. Replaces denormalized design_engineer text field. Essential for competency ',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well for which this BHA configuration was designed and deployed.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: BHA components (bits, motors, RSS tools) are sourced from vendors. Link enables vendor performance tracking, warranty management, and procurement analytics. Standard drilling equipment supply chain.',
    `bha_number` STRING COMMENT 'Sequential or coded identifier for the BHA configuration within the well program, used for operational tracking and reporting.',
    `bha_purpose` STRING COMMENT 'Intended operational purpose of the BHA: vertical drilling, directional drilling, horizontal drilling, sidetrack, reaming, or coring operations.. Valid values are `vertical|directional|horizontal|sidetrack|reaming|coring`',
    `bha_type` STRING COMMENT 'Classification of the BHA configuration based on drilling method: rotary (conventional rotary drilling), motor (mud motor driven), RSS (Rotary Steerable System), conventional, hybrid, or steerable assembly.. Valid values are `rotary|motor|rss|conventional|hybrid|steerable`',
    `bit_iadc_code` STRING COMMENT 'IADC classification code for the drill bit, standardizing bit type, bearing type, and cutting structure for industry-wide comparison.',
    `bit_serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to the specific drill bit, used for tracking, warranty, and performance analysis.',
    `bit_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the drill bit in inches, defining the hole size being drilled.',
    `bit_type` STRING COMMENT 'Type of drill bit used in this BHA configuration: PDC (Polycrystalline Diamond Compact), tricone (roller cone), diamond, hybrid, natural diamond, or TSP (Thermally Stable Polycrystalline).. Valid values are `pdc|tricone|diamond|hybrid|natural_diamond|tsp`',
    `collar_inner_diameter_inches` DECIMAL(18,2) COMMENT 'Inner diameter of the drill collars used in the BHA, measured in inches. Affects hydraulic flow and pressure drop.',
    `collar_outer_diameter_inches` DECIMAL(18,2) COMMENT 'Outer diameter of the drill collars used in the BHA, measured in inches. Provides weight and stiffness to the assembly.',
    `collar_weight_per_foot_lbs` DECIMAL(18,2) COMMENT 'Weight per linear foot of the drill collars in pounds, used to calculate total BHA weight and weight on bit (WOB).',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the BHA configuration, including lessons learned or operational adjustments.',
    `configuration_status` STRING COMMENT 'Current lifecycle status of the BHA configuration: planned (designed but not yet deployed), active (currently in use), completed (run finished), modified (changed during operations), or retired (no longer in use).. Valid values are `planned|active|completed|modified|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BHA configuration record was first created in the system, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deployment_date` DATE COMMENT 'Date when the BHA configuration was physically deployed and run into the wellbore, following the format yyyy-MM-dd.',
    `design_date` DATE COMMENT 'Date when the BHA configuration was designed and approved for use, following the format yyyy-MM-dd.',
    `float_sub_included_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a float sub (one-way valve) is included in the BHA to prevent backflow of drilling fluid and cuttings.',
    `jar_position_from_bit_feet` DECIMAL(18,2) COMMENT 'Distance in feet from the drill bit to the jar tool, defining the jars position within the BHA string.',
    `jar_type` STRING COMMENT 'Type of drilling jar included in the BHA: hydraulic jar, mechanical jar, or none if not applicable. Jars provide impact force to free stuck pipe.. Valid values are `hydraulic|mechanical|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BHA configuration record was last updated or modified in the system, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `makeup_torque_ft_lbs` DECIMAL(18,2) COMMENT 'Specified torque value in foot-pounds applied when making up (connecting) the BHA components, ensuring proper connection integrity per API standards.',
    `max_allowable_torque_ft_lbs` DECIMAL(18,2) COMMENT 'Maximum torque in foot-pounds that the BHA configuration can safely withstand during drilling operations, based on T&D analysis and component ratings.',
    `max_allowable_weight_on_bit_lbs` DECIMAL(18,2) COMMENT 'Maximum weight on bit in pounds that can be safely applied with this BHA configuration, based on component strength and buckling analysis.',
    `motor_bend_angle_degrees` DECIMAL(18,2) COMMENT 'Bend angle of the downhole motor housing in degrees, controlling the build rate and directional capability of the motor assembly.',
    `motor_type` STRING COMMENT 'Type of downhole motor used in the BHA: positive displacement motor (PDM), turbine motor, or none if not applicable.. Valid values are `positive_displacement|turbine|none`',
    `mwd_lwd_tool_string` STRING COMMENT 'Comma-separated or structured list of MWD and LWD tools included in the BHA configuration, capturing real-time drilling parameters and formation evaluation data.',
    `number_of_stabilizers` STRING COMMENT 'Total count of stabilizers included in the BHA configuration.',
    `reamer_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the reamer or hole opener in inches, defining the enlarged hole size.',
    `reamer_type` STRING COMMENT 'Type or model of hole opener or reamer included in the BHA, if applicable, used to enlarge the wellbore diameter.',
    `retrieval_date` DATE COMMENT 'Date when the BHA configuration was pulled out of the wellbore after completing its run, following the format yyyy-MM-dd.',
    `rss_type` STRING COMMENT 'Type or model of Rotary Steerable System used in the BHA, if applicable. Enables continuous rotation while steering the wellbore trajectory.',
    `shock_sub_included_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a shock sub (vibration dampening tool) is included in the BHA configuration to reduce axial and torsional vibration.',
    `stabilizer_placement` STRING COMMENT 'Description or schematic of stabilizer placement along the BHA string, defining the positions and types of stabilizers used to control hole deviation and vibration.',
    `torque_drag_analysis_performed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a torque and drag analysis was performed for this BHA configuration to assess mechanical loads and operational limits.',
    `total_bha_length_feet` DECIMAL(18,2) COMMENT 'Total measured length of the BHA from bit to the top of the assembly in feet, used for torque and drag analysis and wellbore clearance calculations.',
    `total_bha_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of the BHA in air, measured in pounds. Critical for calculating weight on bit and managing drill string loads.',
    CONSTRAINT pk_bha_configuration PRIMARY KEY(`bha_configuration_id`)
) COMMENT 'Bottom Hole Assembly (BHA) configuration record defining the string of downhole tools assembled for a specific bit run. Captures BHA number, bit type (PDC, tricone, diamond), bit size, bit serial number, MWD/LWD tool string, RSS (Rotary Steerable System) type, motor specifications, stabilizer placement, collar weights, total BHA length, and make-up torque specifications. Supports T&D (Torque and Drag) analysis and directional drilling planning. Linked to the specific bit run and well program.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`bit_run` (
    `bit_run_id` BIGINT COMMENT 'Unique identifier for each individual bit run within a well drilling operation. Primary key for the bit run transactional record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Bit runs require drilling engineer oversight for ROP analysis, dull grading interpretation, and bit selection optimization. Essential for cost-per-foot performance tracking, IADC code validation, and ',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well in which this bit run occurred. Links the bit run to the parent well entity.',
    `equipment_id` BIGINT COMMENT 'Foreign key reference to the drill bit master record. Links to the bit inventory and specification details including manufacturer, model, and serial number.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Bit performance varies significantly by reservoir zone lithology and properties. ROP analysis, bit selection for offset wells, and drilling performance optimization require zone-level tracking. Essent',
    `wellbore_id` BIGINT COMMENT 'Foreign key reference to the specific wellbore within the well where this bit run was executed. A well may have multiple wellbores (original, sidetracks).',
    `average_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average drilling fluid circulation rate in gallons per minute during this bit run. Critical for bit cooling and cuttings removal.',
    `average_rop_ft_per_hr` DECIMAL(18,2) COMMENT 'Average drilling rate achieved during this bit run, calculated as footage drilled divided by rotating hours. Critical performance metric for bit selection and optimization.',
    `average_rpm` DECIMAL(18,2) COMMENT 'Average rotational speed of the drill string and bit during drilling operations. Measured in revolutions per minute.',
    `average_standpipe_pressure_psi` DECIMAL(18,2) COMMENT 'Average pressure at the standpipe during drilling, measured in pounds per square inch. Indicates hydraulic efficiency and bit nozzle performance.',
    `average_torque_ft_lbs` DECIMAL(18,2) COMMENT 'Average rotational torque applied to the drill string during this bit run, measured in foot-pounds. Indicates drilling resistance and bit efficiency.',
    `average_wob_klbs` DECIMAL(18,2) COMMENT 'Average downward force applied to the bit during drilling, measured in thousands of pounds. Critical parameter for bit performance and wear management.',
    `bearing_seal_condition` STRING COMMENT 'IADC dull grade code for bearing and seal condition. E=Effective (seals intact), F=Failed (seal failure), N=Not applicable (PDC bit), X=Severe wear.. Valid values are `E|F|N|X`',
    `bit_cost_usd` DECIMAL(18,2) COMMENT 'Purchase or rental cost of the drill bit for this run in US dollars. Used for cost per foot analysis and bit selection economics.',
    `bit_hydraulic_horsepower` DECIMAL(18,2) COMMENT 'Hydraulic horsepower delivered to the bit through drilling fluid circulation. Calculated from flow rate and pressure drop across bit nozzles. Critical for bit cleaning and cooling.',
    `bit_manufacturer` STRING COMMENT 'Name of the company that manufactured the drill bit (e.g., Baker Hughes, Halliburton, Schlumberger, National Oilwell Varco).',
    `bit_model` STRING COMMENT 'Manufacturer-specific model designation for the drill bit. Identifies the bit design, cutter configuration, and intended application.',
    `bit_refurbished_flag` BOOLEAN COMMENT 'Indicates whether this bit was refurbished before this run. True if bit was reconditioned or rebuilt, False if new or used without refurbishment.',
    `bit_serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to track the individual bit unit through its lifecycle and multiple runs.',
    `bit_size_inches` DECIMAL(18,2) COMMENT 'Diameter of the drill bit in inches. Common sizes include 8.5, 12.25, 17.5, and 26 inches depending on hole section requirements.',
    `bit_type` STRING COMMENT 'Classification of the drill bit technology used in this run. PDC (Polycrystalline Diamond Compact) bits use synthetic diamond cutters, tricone/roller cone bits use rotating cones with teeth or inserts, natural diamond bits use industrial diamonds, and hybrid bits combine technologies.. Valid values are `PDC|tricone|roller_cone|diamond|hybrid|other`',
    `comments` STRING COMMENT 'Free-text field for additional observations, operational notes, or special circumstances related to this bit run. May include details on bit performance, formation characteristics, or operational challenges.',
    `cost_per_foot_usd` DECIMAL(18,2) COMMENT 'Drilling cost per foot for this bit run, calculated as bit cost divided by footage drilled. Key economic metric for bit performance benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bit run record was first created in the system. Audit field for data lineage and record tracking.',
    `drilling_fluid_type` STRING COMMENT 'Type of drilling fluid used during this bit run. Fluid type significantly impacts bit performance, cooling, and cuttings removal.. Valid values are `water_based|oil_based|synthetic_based|air|foam|other`',
    `footage_drilled_ft` DECIMAL(18,2) COMMENT 'Total linear footage drilled during this bit run, calculated as pull-out depth minus run-in depth. Key metric for bit performance evaluation.',
    `formation_bottom_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet where the primary formation was exited during this bit run.',
    `formation_drilled` STRING COMMENT 'Primary geological formation or formations encountered and drilled during this bit run. May include multiple formation names if the run crossed formation boundaries.',
    `formation_top_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet where the primary formation was first encountered during this bit run.',
    `gauge_wear_sixteenths` STRING COMMENT 'Amount of gauge wear measured in sixteenths of an inch. Indicates how much the bit diameter has been reduced due to wear on the gauge pads or outer cutting structure.',
    `hours_on_bottom` DECIMAL(18,2) COMMENT 'Total hours the bit was on bottom, including both rotating and non-rotating time (e.g., circulation, reaming). Represents total downhole exposure time.',
    `iadc_dull_grade` STRING COMMENT 'Standardized IADC dull grading code describing bit condition at pull-out. Eight-character code documenting wear on cutting structure, bearings, and gauge. Format: Inner/Outer/Dull/Location/Bearing/Gauge/Other/Reason.',
    `inner_cutting_structure_wear` STRING COMMENT 'IADC dull grade assessment of wear on the inner third of the bit cutting structure. Scale 0-8 where 0 is no wear and 8 is completely worn. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8 — 9 candidates stripped; promote to reference product]',
    `jet_impact_force_lbs` DECIMAL(18,2) COMMENT 'Calculated impact force of drilling fluid jets at the bit face, measured in pounds. Indicates effectiveness of bottom-hole cleaning.',
    `maximum_rop_ft_per_hr` DECIMAL(18,2) COMMENT 'Peak drilling rate achieved during this bit run. Indicates optimal bit performance under ideal conditions.',
    `maximum_rpm` DECIMAL(18,2) COMMENT 'Peak rotational speed achieved during this bit run. Used to verify operation within bit design limits.',
    `maximum_torque_ft_lbs` DECIMAL(18,2) COMMENT 'Peak torque experienced during this bit run. High torque may indicate bit balling, formation changes, or mechanical issues.',
    `maximum_wob_klbs` DECIMAL(18,2) COMMENT 'Peak weight on bit applied during this run. Used to assess whether bit was operated within manufacturer specifications.',
    `minimum_rop_ft_per_hr` DECIMAL(18,2) COMMENT 'Lowest drilling rate recorded during this bit run, excluding zero values during connections. May indicate formation changes or bit wear.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this bit run record was last updated in the system. Audit field for change tracking and data quality management.',
    `mud_weight_ppg` DECIMAL(18,2) COMMENT 'Average drilling fluid density during this bit run, measured in pounds per gallon. Affects bottom-hole pressure and bit hydraulics.',
    `nozzle_configuration` STRING COMMENT 'Configuration of bit nozzles describing size and arrangement (e.g., 3x14, 4x12, 5x13). Determines hydraulic performance and cuttings removal efficiency.',
    `outer_cutting_structure_wear` STRING COMMENT 'IADC dull grade assessment of wear on the outer two-thirds of the bit cutting structure. Scale 0-8 where 0 is no wear and 8 is completely worn. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8 — 9 candidates stripped; promote to reference product]',
    `pull_out_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet at which the bit was pulled out of the wellbore, ending this run. Represents the final depth achieved by this bit.',
    `reason_pulled` STRING COMMENT 'Primary reason the bit was pulled from the wellbore. Common reasons include: dulled, total depth reached, footage target met, formation change, mechanical failure, lost cone, gauge wear, ROP decline, or planned bit change.',
    `reason_pulled_code` STRING COMMENT 'IADC standardized code for reason pulled. TD=Total Depth, DMF=Downhole Motor Failure, BHA=BHA Change, CM=Condition Mud, CP=Core Point, DST=Drill Stem Test, DTF=Downhole Tool Failure, FM=Formation Change, HP=Hours/Footage, HR=High Risk, LCM=Lost Circulation, LOG=Logging, PP=Pump Pressure, PR=Penetration Rate, RIG=Rig Repair, TQ=Torque, TW=Twist Off, WC=Weather Conditions. [ENUM-REF-CANDIDATE: TD|DMF|BHA|CM|CP|DST|DTF|FM|HP|HR|LCM|LOG|PP|PR|RIG|TQ|TW|WC — 18 candidates stripped; promote to reference product]',
    `rerun_number` STRING COMMENT 'Number of times this specific bit (by serial number) has been used. Value of 1 indicates first run, 2 indicates second run after refurbishment, etc.',
    `rotating_hours` DECIMAL(18,2) COMMENT 'Total hours the bit was rotating on bottom during drilling operations. Excludes non-rotating time such as connections, surveys, and circulation.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the bit run ended (bit pulled off bottom). Recorded in ISO 8601 format with timezone.',
    `run_in_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth in feet at which the bit was run into the wellbore and drilling commenced for this run. Represents the starting depth for this bit run.',
    `run_number` STRING COMMENT 'Sequential run number for this bit within the wellbore drilling program. Indicates the order of bit runs (1st run, 2nd run, etc.).',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the bit run commenced (bit tagged bottom and drilling started). Recorded in ISO 8601 format with timezone.',
    `total_nozzle_area_sq_in` DECIMAL(18,2) COMMENT 'Total flow area of all bit nozzles combined, measured in square inches. Critical for hydraulics calculations and bit performance optimization.',
    CONSTRAINT pk_bit_run PRIMARY KEY(`bit_run_id`)
) COMMENT 'Transactional record for each individual bit run within a well, capturing run-in depth, pull-out depth, footage drilled, hours on bottom, average ROP, maximum WOB, RPM range, bit grading (IADC dull grading), reason pulled, formation drilled, and cumulative bit cost. Enables bit performance benchmarking, ROP optimization, and PDC vs tricone selection analysis across the drilling portfolio.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`directional_survey` (
    `directional_survey_id` BIGINT COMMENT 'Unique identifier for the directional survey record. Primary key for the directional survey entity.',
    `bit_run_id` BIGINT COMMENT 'Foreign key linking to drilling.bit_run. Business justification: Directional surveys are taken during specific bit runs to measure wellbore trajectory. The survey_run_number should link to bit_run for operational context and to associate survey stations with the dr',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well for which this directional survey was conducted. Links survey data to the parent wellbore.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Directional surveys track wellbore trajectory through reservoir zones. Geosteering decisions, zone penetration length calculation, and horizontal well placement optimization require explicit zone iden',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Directional surveys require qualified surveyor accountability for measurement accuracy, quality code assignment, and anti-collision analysis. Critical for wellbore positioning certification, regulator',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Survey data defines wellbore trajectory required for anti-collision monitoring, offset well planning, subsurface asset mapping, and lease line compliance. Required for: collision avoidance in developm',
    `anti_collision_zone_status` STRING COMMENT 'Status indicating whether this survey station is within safe separation distance from offset wells. Critical for offshore platform drilling and pad drilling operations.. Valid values are `clear|warning|violation|not_evaluated`',
    `azimuth` DECIMAL(18,2) COMMENT 'Compass direction of the wellbore at this survey station, measured in degrees from true north (0-360). Indicates the horizontal direction of drilling.',
    `bsee_reportable_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this survey record is required for BSEE offshore well reporting compliance. Mandatory for federal offshore operations.',
    `closure_azimuth` DECIMAL(18,2) COMMENT 'Compass direction from the wellhead to the survey station, measured in degrees from true north. Represents the overall horizontal direction of the wellbore at this depth.',
    `closure_distance` DECIMAL(18,2) COMMENT 'Horizontal distance from the wellhead to the survey station, calculated from northing and easting coordinates. Represents the total horizontal displacement.',
    `coordinate_reference_system` STRING COMMENT 'Spatial coordinate reference system used for northing and easting coordinates. Examples include UTM Zone 14N, State Plane Texas South Central, or WGS84.',
    `coordinate_uom` STRING COMMENT 'Unit of measure for northing and easting coordinates. Standard units are feet or meters.. Valid values are `ft|m`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this directional survey record was first created in the data management system. Used for data lineage and audit trail.',
    `dls` DECIMAL(18,2) COMMENT 'Rate of change in wellbore direction between this survey station and the previous station, measured in degrees per 100 feet or 30 meters. Critical for torque and drag analysis and BHA design.',
    `dls_uom` STRING COMMENT 'Unit of measure for dogleg severity. Standard units are degrees per 100 feet or degrees per 30 meters.. Valid values are `deg/100ft|deg/30m`',
    `easting` DECIMAL(18,2) COMMENT 'East-west coordinate offset from the wellhead reference point to the survey station, measured in feet or meters. Positive values indicate east displacement.',
    `gravity_field_strength` DECIMAL(18,2) COMMENT 'Gravitational field strength measured at the survey station, in gals or meters per second squared. Used for gyroscopic and inertial survey calculations.',
    `grid_convergence_angle` DECIMAL(18,2) COMMENT 'Angle between true north and grid north at the survey location, measured in degrees. Used to convert between true azimuth and grid azimuth for coordinate calculations.',
    `inclination` DECIMAL(18,2) COMMENT 'Angle of the wellbore from vertical at this survey station, measured in degrees. Zero degrees is vertical, 90 degrees is horizontal.',
    `magnetic_declination` DECIMAL(18,2) COMMENT 'Angle between magnetic north and true north at the survey location and time, measured in degrees. Used to convert magnetic azimuth to true azimuth for magnetic surveys.',
    `magnetic_dip_angle` DECIMAL(18,2) COMMENT 'Angle of the Earths magnetic field from horizontal at the survey location, measured in degrees. Used for magnetic survey correction and quality control.',
    `magnetic_field_strength` DECIMAL(18,2) COMMENT 'Total magnetic field strength measured at the survey station, in nanoteslas or gauss. Used to assess magnetic interference and survey quality for magnetic-based survey tools.',
    `md` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore from the surface reference point to the survey station, measured in feet or meters. Represents the actual drilled length of the wellbore.',
    `md_uom` STRING COMMENT 'Unit of measure for measured depth. Standard units are feet or meters.. Valid values are `ft|m`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this directional survey record was last modified. Used for change tracking and data quality monitoring.',
    `northing` DECIMAL(18,2) COMMENT 'North-south coordinate offset from the wellhead reference point to the survey station, measured in feet or meters. Positive values indicate north displacement.',
    `reference_datum` STRING COMMENT 'Vertical reference datum for depth measurements. Common datums include Kelly Bushing (KB), Rotary Table (RT), Derrick Floor (DF), Mean Sea Level (MSL), or Ground Level (GL).',
    `reference_datum_elevation` DECIMAL(18,2) COMMENT 'Elevation of the reference datum above mean sea level, measured in feet or meters. Used to convert between different depth reference systems.',
    `survey_calculation_method` STRING COMMENT 'Mathematical method used to calculate position coordinates from inclination and azimuth measurements. Minimum curvature is the industry-standard method providing highest accuracy.. Valid values are `minimum_curvature|balanced_tangential|average_angle|radius_of_curvature|tangential`',
    `survey_correction_applied` BOOLEAN COMMENT 'Boolean flag indicating whether magnetic interference corrections, multi-station analysis, or other quality adjustments have been applied to this survey measurement.',
    `survey_method` STRING COMMENT 'Method or tool type used to acquire this directional survey. Common methods include Measurement While Drilling (MWD), Logging While Drilling (LWD), gyroscopic, magnetic, inertial, or wireline surveys.. Valid values are `MWD|LWD|gyroscopic|magnetic|inertial|wireline`',
    `survey_quality_code` STRING COMMENT 'Quality classification of the survey measurement indicating confidence level and method. Definitive surveys are the highest quality, while interpolated or projected surveys are lower confidence.. Valid values are `definitive|check|tie-in|interpolated|projected|estimated`',
    `survey_remarks` STRING COMMENT 'Free-text field for additional notes, observations, or quality comments related to this survey measurement. May include tool performance issues, magnetic interference notes, or operational context.',
    `survey_station_number` STRING COMMENT 'Sequential station number for this survey point along the wellbore trajectory. Used for ordering survey points from surface to total depth.',
    `survey_status` STRING COMMENT 'Current status of this survey record in the data lifecycle. Active surveys are the current best representation; superseded surveys have been replaced by higher-quality measurements.. Valid values are `active|superseded|rejected|pending_review|approved`',
    `survey_timestamp` TIMESTAMP COMMENT 'Date and time when this directional survey measurement was acquired downhole. Critical for correlating survey data with drilling operations and formation evaluation.',
    `survey_tool_type` STRING COMMENT 'Specific make and model of the survey tool used to acquire this measurement. Examples include Schlumberger PowerDrive, Halliburton iCruise, Baker Hughes AutoTrak.',
    `target_hit_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this survey station is within the planned reservoir target zone. True indicates successful target penetration.',
    `tvd` DECIMAL(18,2) COMMENT 'True vertical depth from the surface reference point to the survey station, measured in feet or meters. Represents the straight-line vertical distance regardless of wellbore trajectory.',
    `tvd_uom` STRING COMMENT 'Unit of measure for true vertical depth. Standard units are feet or meters.. Valid values are `ft|m`',
    `vertical_section` DECIMAL(18,2) COMMENT 'Distance along a vertical plane from the wellhead to the survey station, projected along the planned well trajectory azimuth. Used for well planning and anti-collision analysis.',
    `wellbore_code` BIGINT COMMENT 'Foreign key reference to the specific wellbore section for this survey. A well may have multiple wellbores (original, sidetracks).',
    CONSTRAINT pk_directional_survey PRIMARY KEY(`directional_survey_id`)
) COMMENT 'Wellbore directional survey record capturing the measured depth (MD), inclination, azimuth, true vertical depth (TVD), northing, easting, and dogleg severity (DLS) at each survey station. Supports 3D wellbore trajectory visualization, anti-collision analysis, and reservoir target hit confirmation. Sourced from MWD/LWD tools and integrated with Schlumberger Petrel for 3D reservoir model alignment. Mandatory for BSEE offshore well reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` (
    `mwd_lwd_log_id` BIGINT COMMENT 'Unique identifier for the MWD/LWD log record. Primary key for real-time downhole measurement data captured during drilling operations.',
    `bit_run_id` BIGINT COMMENT 'Foreign key linking to drilling.bit_run. Business justification: MWD/LWD logs are captured during a specific bit run. The run_number in mwd_lwd_log should formally reference bit_run for data lineage and to associate real-time downhole measurements with the bit run ',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well being drilled. Links this MWD/LWD log entry to the specific wellbore where measurements were captured.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Real-time MWD/LWD logs identify reservoir zones during drilling. Formation evaluation, geosteering decisions, and landing point selection depend on zone identification. Critical for horizontal well pl',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Logging data provides formation evaluation used in reserves booking, completion optimization, and production forecasting. Required for: initial reserves estimation, net pay determination, hydrocarbon ',
    `annular_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure in the annular space between drill string and wellbore wall, expressed in pounds per square inch. Monitored for well control and hydraulics optimization.',
    `azimuth_deg` DECIMAL(18,2) COMMENT 'Wellbore azimuth direction measured clockwise from true north, expressed in degrees (0-360). Indicates the compass direction of the wellbore at this measurement point.',
    `bulk_density_g_cm3` DECIMAL(18,2) COMMENT 'Formation bulk density measurement in grams per cubic centimeter. Used to calculate porosity and identify lithology; lower density may indicate porous or gas-bearing formations.',
    `caliper_in` DECIMAL(18,2) COMMENT 'Wellbore diameter measurement in inches. Indicates hole size, washouts, and formation stability; used for cement volume calculations.',
    `correction_applied_flag` BOOLEAN COMMENT 'Boolean flag indicating whether environmental or tool corrections have been applied to the raw sensor readings (e.g., temperature correction, borehole effect correction).',
    `data_quality_flag` STRING COMMENT 'Quality assessment flag for this measurement record. Indicates whether the data passed validation checks and is suitable for interpretation and geosteering decisions.. Valid values are `good|suspect|bad|unchecked`',
    `data_source_system` STRING COMMENT 'Source system or platform from which this MWD/LWD log data was ingested (e.g., OSIsoft PI System, Landmark DecisionSpace, Schlumberger Petrel).',
    `equivalent_circulating_density_ppg` DECIMAL(18,2) COMMENT 'Effective density of the drilling fluid column while circulating, expressed in pounds per gallon. Accounts for annular friction pressure and is critical for well control and formation integrity.',
    `formation_name` STRING COMMENT 'Geological formation or stratigraphic unit identified at this measurement depth. Used for correlation, reservoir characterization, and well planning.',
    `formation_pressure_psi` DECIMAL(18,2) COMMENT 'Formation pore pressure measurement in pounds per square inch. Critical for well control, geosteering decisions, and reservoir characterization.',
    `gamma_ray_api` DECIMAL(18,2) COMMENT 'Natural gamma radiation measurement in API units. Used to identify lithology and correlate formations; shales typically exhibit high gamma ray readings.',
    `geosteering_decision` STRING COMMENT 'Real-time geosteering decision or recommendation made based on this measurement. Documents steering actions taken to optimize wellbore placement in the target reservoir.',
    `hydrocarbon_indicator` STRING COMMENT 'Preliminary hydrocarbon presence indicator based on real-time log interpretation. Identifies potential oil, gas, or water zones for immediate drilling decisions.. Valid values are `oil|gas|water|unknown`',
    `inclination_deg` DECIMAL(18,2) COMMENT 'Wellbore inclination angle from vertical at this measurement point, expressed in degrees. Zero degrees is vertical; 90 degrees is horizontal.',
    `lithology_code` STRING COMMENT 'Primary rock type or lithology identified at this measurement point based on log responses. Used for formation evaluation and reservoir modeling. [ENUM-REF-CANDIDATE: sandstone|shale|limestone|dolomite|coal|salt|anhydrite|granite|basalt|mixed — 10 candidates stripped; promote to reference product]',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore path from surface to the measurement point, expressed in feet. Represents the actual drilled length of the hole.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when this downhole measurement was captured by the MWD/LWD tool. Represents the real-world event time of the sensor reading.',
    `mud_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Drilling fluid circulation rate in gallons per minute. Critical for hole cleaning, hydraulics, and MWD/LWD tool power and telemetry.',
    `mud_weight_ppg` DECIMAL(18,2) COMMENT 'Drilling fluid density in pounds per gallon at the time of measurement. Critical for well control, formation pressure management, and wellbore stability.',
    `neutron_porosity_pct` DECIMAL(18,2) COMMENT 'Neutron porosity measurement expressed as a percentage. Indicates hydrogen content in the formation, used to estimate porosity and identify gas zones.',
    `rate_of_penetration_ft_hr` DECIMAL(18,2) COMMENT 'Drilling rate of penetration at this measurement point, expressed in feet per hour. Indicates drilling efficiency and formation characteristics.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MWD/LWD log record was first created in the data platform. Audit field for data lineage and compliance tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this MWD/LWD log record was last modified in the data platform. Audit field for change tracking and data governance.',
    `resistivity_ohmm` DECIMAL(18,2) COMMENT 'Formation electrical resistivity measurement in ohm-meters. High resistivity indicates hydrocarbon-bearing zones; low resistivity indicates water or conductive formations.',
    `rotary_speed_rpm` DECIMAL(18,2) COMMENT 'Drill string rotational speed in revolutions per minute. Key drilling parameter affecting ROP, hole quality, and tool performance.',
    `service_company` STRING COMMENT 'Name of the oilfield service company providing the MWD/LWD equipment and services (e.g., Schlumberger, Halliburton, Baker Hughes).',
    `sonic_transit_time_us_ft` DECIMAL(18,2) COMMENT 'Acoustic wave travel time through the formation, expressed in microseconds per foot. Used to calculate porosity and identify formation mechanical properties.',
    `telemetry_type` STRING COMMENT 'Method used to transmit MWD/LWD data from downhole to surface. Mud pulse is most common; electromagnetic and wired drill pipe offer higher data rates.. Valid values are `mud_pulse|electromagnetic|wired_drill_pipe|acoustic`',
    `temperature_degf` DECIMAL(18,2) COMMENT 'Downhole temperature at the measurement point, expressed in degrees Fahrenheit. Used for formation evaluation, tool calibration, and reservoir characterization.',
    `tool_string_configuration` STRING COMMENT 'Description of the MWD/LWD tool string configuration and sensor suite deployed for this logging run. Identifies which sensors and tools were active.',
    `toolface_deg` DECIMAL(18,2) COMMENT 'Orientation of the bent sub or steering mechanism relative to the high side of the hole, expressed in degrees. Used for directional drilling control and geosteering.',
    `torque_ft_lbs` DECIMAL(18,2) COMMENT 'Rotational torque applied to the drill string at this measurement point, expressed in foot-pounds. Monitored for drilling optimization and stuck pipe prevention.',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'True vertical depth from surface to the measurement point, expressed in feet. Represents the straight-line vertical distance regardless of wellbore trajectory.',
    `weight_on_bit_klbs` DECIMAL(18,2) COMMENT 'Downhole weight applied to the drill bit, expressed in thousand pounds. Key drilling parameter affecting ROP and bit performance.',
    CONSTRAINT pk_mwd_lwd_log PRIMARY KEY(`mwd_lwd_log_id`)
) COMMENT 'Measurement While Drilling (MWD) and Logging While Drilling (LWD) log record capturing real-time downhole measurements transmitted via mud pulse or electromagnetic telemetry. Stores depth, gamma ray, resistivity, neutron porosity, bulk density, sonic, formation pressure, annular pressure, ECD, toolface, inclination, and azimuth readings at each depth increment. Feeds real-time geosteering decisions and post-well petrophysical evaluation. Integrated with Landmark DecisionSpace and Schlumberger Petrel.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`casing_design` (
    `casing_design_id` BIGINT COMMENT 'Unique identifier for the casing design record. Primary key for this entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Casing programs are major AFE line items (tubulars budget). Link enables tracking casing costs against AFE tubulars budget allocation. Critical for capital expenditure control.',
    `drilling_afe_id` BIGINT COMMENT 'Identifier of the AFE under which this casing design and installation was authorized and budgeted.',
    `drilling_well_id` BIGINT COMMENT 'Identifier of the well to which this casing design applies. Links to the well master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the petroleum engineer who designed this casing string. Links to personnel master data for accountability and expertise tracking.',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig used for this casing run. Links to rig master data.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Casing design specifications are required for well integrity management. Corrosion monitoring programs, pressure testing, fitness-for-service assessments, and barrier verification all reference origin',
    `bsee_approval_date` DATE COMMENT 'Date on which BSEE approved the casing design for offshore operations. Required for regulatory compliance tracking.',
    `bsee_approval_status` STRING COMMENT 'Regulatory approval status from BSEE for offshore wells. Required for casing and cementing programs under 30 CFR 250.. Valid values are `approved|pending|not_required|rejected`',
    `burst_design_factor` DECIMAL(18,2) COMMENT 'Safety factor applied to burst rating in design calculations. Ratio of burst rating to maximum anticipated pressure. Typically 1.1 to 1.25 per API RP 96.',
    `burst_rating_psi` DECIMAL(18,2) COMMENT 'Maximum internal pressure the casing can withstand before failure, in PSI. Critical for well control and pressure containment design.',
    `casing_grade` STRING COMMENT 'API steel grade designation for the casing material (e.g., J-55, K-55, N-80, L-80, P-110, Q-125). Defines minimum yield strength and material properties.',
    `casing_string_number` STRING COMMENT 'Sequential number of this casing string within the well (1 for conductor, 2 for surface, etc.). Defines the order of casing runs.',
    `casing_string_type` STRING COMMENT 'Classification of the casing string based on its function in the well architecture. Conductor is the outermost, production is the innermost for hydrocarbon production.. Valid values are `conductor|surface|intermediate|production|liner|tieback`',
    `cement_bond_log_result` STRING COMMENT 'Overall quality assessment from the cement bond log evaluation. Measures acoustic bond between casing, cement, and formation. Critical for well integrity verification.. Valid values are `excellent|good|fair|poor|not_run`',
    `cement_job_type` STRING COMMENT 'Classification of the cementing operation. Primary is the initial cement job for a casing string, squeeze is remedial injection, plug is for abandonment or zonal isolation.. Valid values are `primary|squeeze|plug|remedial`',
    `cement_slurry_design` STRING COMMENT 'Detailed formulation of the cement slurry including cement type, additives, water ratio, and density. Defines the engineered properties of the cement system.',
    `collapse_design_factor` DECIMAL(18,2) COMMENT 'Safety factor applied to collapse rating in design calculations. Ratio of collapse rating to maximum anticipated external pressure. Typically 1.0 to 1.125 per API RP 96.',
    `collapse_rating_psi` DECIMAL(18,2) COMMENT 'Maximum external pressure the casing can withstand before collapse failure, in PSI. Critical for deep wells and cementing operations.',
    `connection_type` STRING COMMENT 'Type of threaded connection used to join casing joints (e.g., STC, LTC, BTC, premium connections like VAM, Hydril). Affects seal integrity and torque requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this casing design record was first created in the system. Audit trail for data governance.',
    `design_status` STRING COMMENT 'Current lifecycle status of the casing design. Tracks progression from planning through installation and verification.. Valid values are `planned|approved|installed|verified|failed`',
    `displacement_fluid_type` STRING COMMENT 'Type of fluid used to displace cement from the casing into the annulus (e.g., drilling mud, spacer fluid, water). Critical for cement placement efficiency.',
    `displacement_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of displacement fluid pumped to move cement from casing interior to annulus, in barrels. Calculated based on casing internal capacity.',
    `final_circulating_pressure_psi` DECIMAL(18,2) COMMENT 'Surface pressure at the end of cement displacement, in PSI. Used to verify cement placement and detect potential problems.',
    `installation_end_timestamp` TIMESTAMP COMMENT 'Date and time when casing running and cementing operations were completed. Marks the end of the casing installation lifecycle event.',
    `installation_start_timestamp` TIMESTAMP COMMENT 'Date and time when casing running operations began. Marks the start of the casing installation lifecycle event.',
    `job_quality_assessment` STRING COMMENT 'Overall engineering assessment of the cementing job quality based on all available data including CBL, pressure tests, and operational parameters.. Valid values are `successful|marginal|failed|pending_evaluation`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this casing design record was last updated. Audit trail for change tracking and data governance.',
    `lead_cement_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of the lead cement slurry pumped, in barrels. Lead slurry typically has different properties than tail slurry for optimal placement.',
    `outer_diameter_in` DECIMAL(18,2) COMMENT 'Outside diameter of the casing pipe in inches. Standard sizes include 7, 9-5/8, 13-3/8, 20 inches per API specifications.',
    `pressure_test_duration_min` STRING COMMENT 'Duration for which the casing pressure test was held, in minutes. Regulatory requirements typically specify minimum hold times.',
    `pressure_test_result_psi` DECIMAL(18,2) COMMENT 'Maximum pressure achieved during casing pressure test, in PSI. Verifies casing and cement integrity before drilling ahead.',
    `pump_rate_bpm` DECIMAL(18,2) COMMENT 'Rate at which cement slurry was pumped during the job, in barrels per minute. Affects cement placement quality and formation fracture risk.',
    `setting_depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore at which the casing shoe is set, in feet. Represents the actual drilled path length.',
    `setting_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth at which the casing shoe is set, in feet. Represents the straight-line vertical distance from surface.',
    `tail_cement_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of the tail cement slurry pumped, in barrels. Tail slurry is typically higher density and placed across critical zones.',
    `tension_design_factor` DECIMAL(18,2) COMMENT 'Safety factor applied to tension rating in design calculations. Ratio of tension rating to maximum anticipated axial load. Typically 1.3 to 1.8 per API RP 96.',
    `tension_rating_lb` DECIMAL(18,2) COMMENT 'Maximum axial tensile load the casing can support, in pounds. Critical for deep wells where casing weight creates significant tension at the top.',
    `top_of_casing_md_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the top of the casing string is located, typically at surface or wellhead for most strings, or at the liner hanger for liners.',
    `top_of_cement_md_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the top of cement column is located in the annulus, in feet. Verified by temperature surveys or cement bond logs. Critical for zonal isolation verification.',
    `weight_per_foot_lb` DECIMAL(18,2) COMMENT 'Nominal weight of the casing pipe per linear foot, in pounds. Determines wall thickness and strength characteristics.',
    `zonal_isolation_verified_flag` BOOLEAN COMMENT 'Boolean indicator whether adequate zonal isolation has been verified through testing. Critical for BSEE compliance and well integrity management.',
    CONSTRAINT pk_casing_design PRIMARY KEY(`casing_design_id`)
) COMMENT 'Casing string and cementing record for each casing/liner run in a well, capturing both the design basis and cement job execution. For casing: string type (conductor, surface, intermediate, production, liner), setting depth, OD, weight per foot, grade, connection type, burst/collapse/tension ratings, and design safety factors. For cementing: job type (primary, squeeze, plug), cement slurry design, lead/tail volumes, displacement fluid, pump rate, final circulating pressure, top of cement (TOC) depth, cement bond log (CBL) result, and job quality assessment. Supports well integrity management, BSEE casing and cementing regulatory compliance under 30 CFR 250, and zonal isolation verification. Linked to well program and daily drilling report.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`cementing_job` (
    `cementing_job_id` BIGINT COMMENT 'Unique identifier for the cementing job record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Cementing jobs are AFE cost centers tracked against drilling services budget. Required for cost accrual, budget variance tracking, and service invoice validation. Standard AFE cost control.',
    `casing_design_id` BIGINT COMMENT 'Foreign key linking to drilling.casing_design. Business justification: Cementing job executes a specific casing design plan. The job should reference the design it implements for traceability between plan and execution. Removing casing_string_cemented, casing_outer_diame',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE under which this cementing job was authorized and costs are tracked.',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well on which this cementing job was performed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cementing jobs require on-site supervisor for quality control, zonal isolation verification, and HSE compliance. Critical for well integrity management, cement bond log interpretation, and regulatory ',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig that executed the cementing job.',
    `vendor_id` BIGINT COMMENT 'FK to procurement.vendor',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Cement job quality affects well integrity throughout asset life. Integrity assessments, barrier verification, annular pressure management, and P&A planning all reference cement bond quality, top of ce',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the cementing job including materials, services, and equipment, measured in US dollars.',
    `bsee_report_submitted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the required BSEE regulatory report for this cementing job has been submitted.',
    `bsee_reporting_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this cementing job requires regulatory reporting to BSEE for offshore operations.',
    `casing_shoe_depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth of the casing shoe (bottom of casing string) in feet, representing the target depth for cement placement.',
    `casing_shoe_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth of the casing shoe in feet, used for pressure calculations and regulatory reporting.',
    `cement_bond_log_run_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a cement bond log was run to evaluate cement quality and bonding to casing and formation.',
    `cement_bond_quality` STRING COMMENT 'Qualitative assessment of cement bond quality based on cement bond log interpretation: excellent, good, fair, poor, or failed.. Valid values are `excellent|good|fair|poor|failed`',
    `cement_compressive_strength_psi` DECIMAL(18,2) COMMENT 'Measured or calculated compressive strength of the cured cement in pounds per square inch, critical for well integrity and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cementing job record was first created in the system, recorded in ISO 8601 format.',
    `displacement_fluid_type` STRING COMMENT 'Type of fluid used to displace the cement slurry into position: drilling mud, chemical spacer, fresh water, or brine.. Valid values are `drilling_mud|spacer|water|brine`',
    `displacement_fluid_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of displacement fluid pumped to move cement slurry from casing into the annulus, measured in barrels.',
    `final_circulating_pressure_psi` DECIMAL(18,2) COMMENT 'Final circulating pressure at the end of displacement, measured in pounds per square inch. Indicates successful cement placement and plug bump.',
    `job_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the cementing job from start to completion, measured in hours.',
    `job_end_timestamp` TIMESTAMP COMMENT 'Date and time when the cementing job operations were completed, recorded in ISO 8601 format.',
    `job_number` STRING COMMENT 'Externally-known unique job number assigned by the cementing service provider or operator for tracking and billing purposes.',
    `job_quality_assessment` STRING COMMENT 'Overall quality assessment of the cementing job: successful (met all objectives), marginal (partial success), unsuccessful (failed objectives), or requires remediation.. Valid values are `successful|marginal|unsuccessful|requires_remediation`',
    `job_start_timestamp` TIMESTAMP COMMENT 'Date and time when the cementing job operations commenced, recorded in ISO 8601 format.',
    `job_status` STRING COMMENT 'Current lifecycle status of the cementing job: planned, in progress, completed successfully, failed, or suspended.. Valid values are `planned|in_progress|completed|failed|suspended`',
    `job_type` STRING COMMENT 'Classification of the cementing operation: primary (initial casing cement), squeeze (remedial pressure injection), plug (abandonment or kick-off), remedial (repair), liner (liner cementing), or stage (multi-stage cementing).. Valid values are `primary|squeeze|plug|remedial|liner|stage`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cementing job record was last updated in the system, recorded in ISO 8601 format.',
    `lead_slurry_density_ppg` DECIMAL(18,2) COMMENT 'Density of the lead cement slurry in pounds per gallon, critical for hydrostatic pressure management and zonal isolation.',
    `lead_slurry_type` STRING COMMENT 'Type or classification of the lead cement slurry pumped first (e.g., Class A, Class G, lightweight, foamed). Lead slurry typically has different properties than tail slurry.',
    `lead_slurry_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of lead cement slurry pumped, measured in barrels. Lead slurry is typically lower density and pumped ahead of tail slurry.',
    `max_pump_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum surface pump pressure recorded during cement job execution, measured in pounds per square inch. Used to assess formation integrity and job quality.',
    `plug_bump_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure spike observed when the displacement plug lands on the float collar, confirming complete displacement of cement from the casing.',
    `pump_rate_bpm` DECIMAL(18,2) COMMENT 'Average pump rate during cement slurry placement, measured in barrels per minute. Critical for controlling cement placement and preventing formation breakdown.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, lessons learned, or special circumstances related to the cementing job execution.',
    `spacer_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of chemical spacer fluid pumped ahead of cement to clean the wellbore and improve cement bonding, measured in barrels.',
    `tail_slurry_density_ppg` DECIMAL(18,2) COMMENT 'Density of the tail cement slurry in pounds per gallon, designed to provide adequate compressive strength and zonal isolation.',
    `tail_slurry_type` STRING COMMENT 'Type or classification of the tail cement slurry pumped last (e.g., Class G, high-strength, thixotropic). Tail slurry typically provides the primary zonal isolation.',
    `tail_slurry_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of tail cement slurry pumped, measured in barrels. Tail slurry is typically higher density and provides the primary seal.',
    `top_of_cement_actual_md_ft` DECIMAL(18,2) COMMENT 'Actual measured depth of the top of cement column in the annulus, determined by cement bond log or temperature survey after job completion.',
    `top_of_cement_planned_md_ft` DECIMAL(18,2) COMMENT 'Planned measured depth for the top of cement column in the annulus, based on slurry design and displacement calculations.',
    `wait_on_cement_hours` DECIMAL(18,2) COMMENT 'Duration in hours that operations were suspended to allow cement to cure and achieve required compressive strength before resuming drilling or testing.',
    `zonal_isolation_achieved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the cementing job successfully achieved zonal isolation between formations, preventing fluid migration.',
    CONSTRAINT pk_cementing_job PRIMARY KEY(`cementing_job_id`)
) COMMENT 'Cementing job record capturing the execution details of each primary or remedial cement job on a well. Records job type (primary, squeeze, plug), casing string cemented, cement slurry design, lead/tail slurry volumes, displacement fluid, pump rate, final circulating pressure, top of cement (TOC) depth, cement bond log result, and job quality assessment. Critical for well integrity compliance and BSEE regulatory reporting. Linked to casing design and daily drilling report.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`bop_certification` (
    `bop_certification_id` BIGINT COMMENT 'Unique identifier for the BOP certification record. Primary key.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: BOP certifications are regulatory certifications required by BSEE. Linking to master certification record enables unified compliance tracking and audit trail for safety-critical equipment certificatio',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: BOP test results must be submitted to BSEE (offshore) or state agencies. Certification data feeds regulatory submissions for safety equipment verification and SEMS compliance documentation.',
    `drilling_well_id` BIGINT COMMENT 'Identifier of the well for which this BOP certification applies, if the test is well-specific.',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig on which this BOP stack is installed and tested.',
    `accumulator_capacity_gallons` DECIMAL(18,2) COMMENT 'Total fluid capacity of the BOP accumulator system, measured in gallons. Must be sufficient to close all BOP components without pump assistance.',
    `accumulator_precharge_psi` STRING COMMENT 'Precharge pressure of the BOP accumulator system, measured in PSI. Must meet minimum requirements for rapid BOP closure.',
    `annular_preventer_type` STRING COMMENT 'Type and model of the annular preventer installed in the BOP stack (e.g., Hydril GK, Cameron Type U, Shaffer Spherical).',
    `blind_shear_ram_count` STRING COMMENT 'Number of blind shear rams capable of cutting drill pipe and sealing the wellbore.',
    `bop_stack_configuration` STRING COMMENT 'Detailed configuration of the BOP stack including ram types (blind, shear, pipe), annular preventer specifications, choke and kill manifold arrangement, and accumulator capacity.',
    `bop_stack_serial_number` STRING COMMENT 'Manufacturer serial number of the BOP stack assembly being certified.',
    `bsee_form_reference` STRING COMMENT 'Reference number of the BSEE Form MMS-0123 or equivalent regulatory form submitted for this BOP test.',
    `certification_expiry_date` DATE COMMENT 'Date on which this BOP certification expires and a new test is required, based on regulatory intervals or operational policies.',
    `certifying_authority` STRING COMMENT 'Name of the certifying authority or third-party inspector who witnessed and certified the BOP test (e.g., BSEE inspector, ABS, DNV, company representative).',
    `certifying_person_license_number` STRING COMMENT 'Professional license or certification number of the individual who certified the BOP test.',
    `certifying_person_name` STRING COMMENT 'Full name of the individual who performed or witnessed the BOP test and signed the certification.',
    `choke_manifold_test_psi` STRING COMMENT 'Pressure applied during the choke manifold pressure test, measured in PSI.',
    `corrective_actions_taken` STRING COMMENT 'Description of corrective actions taken to address deficiencies, including repairs, component replacements, or adjustments made.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOP certification record was first created in the system.',
    `deficiencies_noted` STRING COMMENT 'Detailed description of any deficiencies, leaks, or issues identified during the BOP test, including component locations and severity.',
    `function_test_completed_flag` BOOLEAN COMMENT 'Indicates whether a full function test of all BOP components (rams, annular, choke/kill valves) was completed. True if completed, False if not.',
    `high_pressure_test_psi` STRING COMMENT 'Pressure applied during the high-pressure BOP test, measured in pounds per square inch (PSI). Must meet or exceed maximum anticipated surface pressure (MASP).',
    `kill_manifold_test_psi` STRING COMMENT 'Pressure applied during the kill manifold pressure test, measured in PSI.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this BOP certification record was last modified or updated.',
    `low_pressure_test_psi` STRING COMMENT 'Pressure applied during the low-pressure BOP test, measured in pounds per square inch (PSI). Typically 200-500 PSI to verify seal integrity.',
    `next_scheduled_test_date` DATE COMMENT 'Date on which the next BOP pressure test is scheduled, based on regulatory intervals (14-day or 30-day) or operational requirements.',
    `pipe_ram_count` STRING COMMENT 'Number of pipe rams designed to seal around drill pipe of specific diameters.',
    `pressure_drop_psi` STRING COMMENT 'Amount of pressure drop observed during the test hold period, measured in PSI. Zero or minimal drop indicates a successful test.',
    `ram_preventer_count` STRING COMMENT 'Total number of ram preventers in the BOP stack.',
    `regulatory_compliance_status` STRING COMMENT 'Overall regulatory compliance status of this BOP certification: compliant (meets all BSEE and API requirements), non-compliant (deficiencies not resolved), or pending review (awaiting regulatory approval).. Valid values are `compliant|non_compliant|pending_review`',
    `remarks` STRING COMMENT 'Additional remarks, observations, or notes related to the BOP test, including weather conditions, operational context, or special circumstances.',
    `retest_date` DATE COMMENT 'Date on which the BOP retest was conducted following corrective actions, if applicable.',
    `retest_required_flag` BOOLEAN COMMENT 'Indicates whether a retest is required following corrective actions. True if retest is mandatory, False if not required.',
    `retest_result` STRING COMMENT 'Outcome of the BOP retest following corrective actions: pass, fail, or not applicable if no retest was required.. Valid values are `pass|fail|not_applicable`',
    `test_date` DATE COMMENT 'Date on which the BOP pressure test was conducted.',
    `test_duration_minutes` STRING COMMENT 'Duration for which the test pressure was held, measured in minutes. Typically 5-15 minutes per API and BSEE requirements.',
    `test_location` STRING COMMENT 'Location category where the BOP test was conducted: onshore, offshore shallow water, or offshore deepwater. Determines applicable regulatory requirements.. Valid values are `onshore|offshore_shallow|offshore_deepwater`',
    `test_report_document_code` STRING COMMENT 'Identifier of the detailed BOP test report document stored in the document management system.',
    `test_result` STRING COMMENT 'Outcome of the BOP pressure test: pass (no leaks, pressure held), fail (leaks detected, pressure drop), or conditional pass (minor issues noted but acceptable).. Valid values are `pass|fail|conditional_pass`',
    `test_type` STRING COMMENT 'Type of BOP test conducted: initial installation test, 14-day interval test, 30-day interval test, post-repair test, pre-spud test, or annual recertification.. Valid values are `initial|14-day|30-day|post-repair|pre-spud|annual`',
    `test_witnessed_by_bsee_flag` BOOLEAN COMMENT 'Indicates whether the BOP test was witnessed by a BSEE inspector. True if witnessed, False if not. Required for certain offshore operations.',
    `water_depth_ft` STRING COMMENT 'Water depth at the test location, measured in feet. Relevant for offshore BOP tests to determine pressure requirements.',
    CONSTRAINT pk_bop_certification PRIMARY KEY(`bop_certification_id`)
) COMMENT 'Blowout Preventer (BOP) certification and pressure test record tracking regulatory compliance of BOP equipment on each rig. Captures BOP stack configuration (ram types, annular preventer specs, choke/kill manifold), test date, test pressure (low and high), test duration, test result (pass/fail), certifying authority, BSEE Form MMS-0123 reference, next scheduled test date, deficiencies noted, and corrective actions. Mandatory for BSEE offshore drilling compliance under 30 CFR 250 Subpart D, including 14-day and 30-day BOP test intervals. Linked to rig master record.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_control_event` (
    `well_control_event_id` BIGINT COMMENT 'Unique identifier for the well control event record. Primary key for the well control event entity.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Well control events require immediate regulatory notification (BSEE within 15 minutes, state agencies per jurisdiction). Event data feeds incident reports and loss-of-well-control filings for regulato',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE under which drilling operations and the well control event are tracked for cost allocation.',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well where the control event occurred. Links to the well master data entity.',
    `employee_id` BIGINT COMMENT 'Reference to the person who initially reported or documented the well control event. Links to personnel master data.',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig on which the well control event occurred. Links to rig master data.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Well control events often trigger regulatory violations and NOVs from BSEE or state agencies. BSEE reportable events must link to violation records for penalty tracking and corrective action managemen',
    `bop_activation_method` STRING COMMENT 'Method by which the blowout preventer was activated to shut in the well during the control event.. Valid values are `manual|automatic|remote|emergency`',
    `bop_configuration` STRING COMMENT 'Configuration and stack arrangement of the blowout preventer equipment at the time of the well control event.',
    `bsee_incident_number` STRING COMMENT 'Official incident number assigned by BSEE for reportable well control events on offshore operations.',
    `bsee_notification_timestamp` TIMESTAMP COMMENT 'Date and time when BSEE was notified of the well control event, as required by regulatory reporting timelines.',
    `bsee_reportable_flag` BOOLEAN COMMENT 'Indicates whether the well control event meets BSEE reporting thresholds and requires regulatory notification.',
    `choke_manifold_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure maintained at the choke manifold during circulation of the kick, measured in PSI.',
    `corrective_action_taken` STRING COMMENT 'Description of the immediate corrective actions taken to regain well control and mitigate the event.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the well control event record was first created in the system.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the well control event from detection to resolution, measured in hours.',
    `environmental_release_flag` BOOLEAN COMMENT 'Indicates whether the well control event resulted in an uncontrolled release of hydrocarbons or drilling fluids to the environment.',
    `estimated_cost_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the well control event including non-productive time, materials, services, and remediation costs, measured in USD.',
    `event_category` STRING COMMENT 'Broader operational category of the well control event for grouping and trend analysis.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the well control event was resolved and normal operations resumed.',
    `event_number` STRING COMMENT 'Business identifier or sequence number assigned to the well control event for external reference and reporting.',
    `event_severity` STRING COMMENT 'Classification of the well control event severity based on operational impact, safety risk, and regulatory thresholds.. Valid values are `minor|moderate|major|critical`',
    `event_status` STRING COMMENT 'Current lifecycle status of the well control event record and associated investigation or remediation activities.. Valid values are `active|resolved|under_investigation|closed`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the well control event was first detected or initiated. Primary business event timestamp for the incident.',
    `event_type` STRING COMMENT 'Primary classification of the well control event type indicating the nature of the control incident.. Valid values are `kick|influx|underground_blowout|surface_blowout|lost_circulation|well_integrity_failure`',
    `formation_pressure_psi` DECIMAL(18,2) COMMENT 'Calculated formation pressure at the depth of the influx zone, measured in PSI. Derived from shut-in pressures and hydrostatic calculations.',
    `iadc_code` STRING COMMENT 'IADC classification code for the well control event type, used for industry benchmarking and trend analysis.',
    `influx_type` STRING COMMENT 'Type of formation fluid that entered the wellbore during the kick or influx event.. Valid values are `gas|oil|water|multiphase|unknown`',
    `influx_volume_bbl` DECIMAL(18,2) COMMENT 'Estimated volume of formation fluid that entered the wellbore, measured in barrels. May differ from pit gain due to gas expansion.',
    `injury_count` STRING COMMENT 'Number of personnel injuries resulting from the well control event.',
    `kill_fluid_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of kill fluid pumped during the well control operation, measured in barrels.',
    `kill_method` STRING COMMENT 'Well control kill method used to regain control of the well and circulate out the influx.. Valid values are `drillers_method|wait_and_weight|concurrent|volumetric|bullheading|dynamic_kill`',
    `kill_mud_weight_ppg` DECIMAL(18,2) COMMENT 'Density of the kill mud used to control the well, measured in pounds per gallon. Calculated to provide sufficient hydrostatic pressure to overcome formation pressure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the well control event record was last updated or modified.',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore at which the well control event occurred, measured in feet from the rig floor or kelly bushing.',
    `personnel_evacuated_count` STRING COMMENT 'Number of personnel evacuated from the rig or facility during the well control event for safety reasons.',
    `pit_gain_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of fluid gained in the mud pits indicating influx from the formation, measured in barrels. Key indicator of kick severity.',
    `preventive_measures` STRING COMMENT 'Preventive measures and procedural changes implemented to prevent recurrence of similar well control events.',
    `responsible_party` STRING COMMENT 'Party identified as responsible for the conditions or actions that led to the well control event.. Valid values are `operator|drilling_contractor|service_provider|joint_venture_partner|unknown`',
    `root_cause` STRING COMMENT 'Identified root cause of the well control event based on post-incident investigation and analysis.',
    `sicp_psi` DECIMAL(18,2) COMMENT 'Shut-in casing pressure measured at the surface after closing the blowout preventer, measured in PSI. Used to calculate formation pressure and plan kill operations.',
    `sidpp_psi` DECIMAL(18,2) COMMENT 'Shut-in drill pipe pressure measured at the surface after closing the blowout preventer, measured in PSI. Critical parameter for kill operation planning.',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'True vertical depth at which the well control event occurred, measured in feet from the surface reference point.',
    `wellbore_code` BIGINT COMMENT 'Reference to the specific wellbore section where the control event occurred. Links to wellbore master data.',
    CONSTRAINT pk_well_control_event PRIMARY KEY(`well_control_event_id`)
) COMMENT 'Well control event record capturing any kick, influx, or well control incident during drilling operations. Records event timestamp, depth at time of event, pit gain volume, shut-in drill pipe pressure (SIDPP), shut-in casing pressure (SICP), kill method used (drillers method, wait-and-weight), kill mud weight, barrels of kill fluid pumped, event duration, and regulatory notification status. Feeds BSEE incident reporting and HSE well control performance tracking. Distinct from NPT events in that it captures the technical well control response.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`dst_result` (
    `dst_result_id` BIGINT COMMENT 'Primary key for dst_result',
    `completion_design_id` BIGINT COMMENT 'Foreign key linking to drilling.completion_design. Business justification: DST (Drill Stem Test) results inform completion design decisions. DST is performed during drilling to evaluate formation productivity, and results feed into completion strategy selection. Linking DST ',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key reference to the AFE under which the DST was authorized and costs are tracked.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well where the drill stem test was conducted.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: DST results determine lease commercial viability, trigger lease extension decisions, verify production capability for HBP status, and support reserves booking per lease. Essential for lease valuation ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: DST operations require specific test permits in many jurisdictions (offshore, environmentally sensitive areas). Regulatory approval tracking is essential for well testing operations and BSEE complianc',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Drill stem tests characterize the petroleum product type (oil, gas, condensate) that a formation will produce. Test results (fluid_type, fluid_gravity_api, gas_gravity) directly determine product clas',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: DST results characterize reservoir productivity and properties. Test data feeds reservoir simulation models, material balance calculations, and reserves estimates. Critical for reservoir engineering a',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DST service companies are vendors providing well testing services. Link enables vendor qualification tracking, service invoice validation, and performance evaluation. Standard well testing procurement',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: DST results provide reservoir characterization data used in production forecasting, reserves estimation, and asset valuation. Required for: initial reserves booking, production type curve development,',
    `bsee_report_date` DATE COMMENT 'Date when the drill stem test results were reported to BSEE for regulatory compliance.',
    `bsee_reportable_flag` BOOLEAN COMMENT 'Indicates whether the drill stem test results are required to be reported to BSEE for offshore operations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this drill stem test result record was first created in the data system.',
    `dst_number` STRING COMMENT 'Business identifier for the drill stem test, typically sequential within a well (e.g., DST-1, DST-2).',
    `final_flowing_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure in pounds per square inch measured at the end of the final flow period.',
    `final_shutin_pressure_psi` DECIMAL(18,2) COMMENT 'Final shut-in pressure in pounds per square inch measured after the final buildup period, used for reservoir pressure estimation.',
    `flow_period_count` STRING COMMENT 'Number of distinct flow periods conducted during the drill stem test sequence.',
    `fluid_gravity_api` DECIMAL(18,2) COMMENT 'API gravity of the oil or condensate recovered during the test, measured in API degrees.',
    `fluid_sample_collected_flag` BOOLEAN COMMENT 'Indicates whether formation fluid samples were collected during the drill stem test for laboratory analysis.',
    `fluid_type` STRING COMMENT 'Primary type of formation fluid encountered during the drill stem test.. Valid values are `oil|gas|condensate|water|dry|unknown`',
    `formation_name` STRING COMMENT 'Geological formation or reservoir zone name being evaluated by the drill stem test.',
    `gas_flow_rate_mcfd` DECIMAL(18,2) COMMENT 'Measured or calculated gas production rate in thousand cubic feet per day during the test flow period.',
    `gas_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the gas produced during the test, relative to air (dimensionless).',
    `gor` DECIMAL(18,2) COMMENT 'Gas-oil ratio measured during the test, expressed as standard cubic feet of gas per barrel of oil.',
    `initial_flowing_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure in pounds per square inch measured at the start of the initial flow period.',
    `initial_shutin_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure in pounds per square inch measured immediately after the well is shut in following the initial flow period.',
    `interval_bottom_md` DECIMAL(18,2) COMMENT 'Measured depth in feet to the bottom of the formation interval being tested.',
    `interval_bottom_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet to the bottom of the formation interval being tested.',
    `interval_top_md` DECIMAL(18,2) COMMENT 'Measured depth in feet to the top of the formation interval being tested.',
    `interval_top_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet to the top of the formation interval being tested.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this drill stem test result record was last updated or modified.',
    `oil_flow_rate_bopd` DECIMAL(18,2) COMMENT 'Measured or calculated oil production rate in barrels of oil per day during the test flow period.',
    `permeability_md` DECIMAL(18,2) COMMENT 'Estimated formation permeability in millidarcies derived from pressure transient analysis of the DST data.',
    `reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Estimated static reservoir pressure in pounds per square inch derived from pressure buildup analysis.',
    `shutin_period_count` STRING COMMENT 'Number of distinct shut-in periods conducted during the drill stem test sequence for pressure buildup analysis.',
    `skin_factor` DECIMAL(18,2) COMMENT 'Dimensionless skin factor representing near-wellbore formation damage or stimulation, derived from pressure buildup analysis.',
    `test_conclusion` STRING COMMENT 'Overall conclusion regarding the commercial viability of the tested interval based on DST results.. Valid values are `commercial|sub_commercial|non_commercial|inconclusive`',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from test start to test end, including all flow and shut-in periods.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Date and time when the drill stem test operation was completed or terminated.',
    `test_interpretation_summary` STRING COMMENT 'Narrative summary of the drill stem test results interpretation, including reservoir quality assessment and commerciality indicators.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date and time when the drill stem test operation commenced, marking the beginning of the test sequence.',
    `test_status` STRING COMMENT 'Current lifecycle status of the drill stem test operation.. Valid values are `planned|in_progress|completed|suspended|failed`',
    `test_tool_description` STRING COMMENT 'Description of the drill stem test tool assembly and configuration used during the test.',
    `test_type` STRING COMMENT 'Classification of the DST based on wellbore completion status and conveyance method at the time of testing.. Valid values are `open_hole|cased_hole|tubing_conveyed|wireline_conveyed`',
    `total_flow_duration_hours` DECIMAL(18,2) COMMENT 'Cumulative duration in hours of all flow periods during the drill stem test.',
    `total_shutin_duration_hours` DECIMAL(18,2) COMMENT 'Cumulative duration in hours of all shut-in periods during the drill stem test.',
    `water_cut_percentage` DECIMAL(18,2) COMMENT 'Percentage of water in the total liquid production during the test flow period.',
    `water_flow_rate_bwpd` DECIMAL(18,2) COMMENT 'Measured or calculated water production rate in barrels of water per day during the test flow period.',
    `wellbore_code` BIGINT COMMENT 'Foreign key reference to the specific wellbore section where the DST was performed.',
    CONSTRAINT pk_dst_result PRIMARY KEY(`dst_result_id`)
) COMMENT 'Drill Stem Test (DST) result record capturing formation evaluation data obtained during testing of a potential reservoir interval. Records test interval top and bottom depths, test type (open-hole, cased-hole), flow periods, shut-in periods, initial flowing pressure, final shut-in pressure (FSIP), buildup analysis results, permeability estimate, skin factor, flow rate (BOPD/MCFD), GOR, water cut, fluid samples collected, and test interpretation summary. Feeds reservoir characterization and EUR estimation in the reservoir domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`completion_design` (
    `completion_design_id` BIGINT COMMENT 'Unique identifier for the completion design record. Primary key for the completion design entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Completion designs are funded through AFE completion equipment budgets. Essential for tracking completion costs against approved budgets and managing capital expenditure. Standard completion cost mana',
    `contractor_id` BIGINT COMMENT 'FK to workforce.contractor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Completion contractors are vendors providing completion services. Link enables procurement tracking, vendor performance evaluation, and contract management. Complements existing completion_contractor_',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key reference to the AFE that authorizes and tracks the capital expenditure for this completion operation.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well that this completion design applies to. Links completion design to the specific wellbore that reached Total Depth (TD).',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Completion designs must comply with lease depth/formation restrictions. Completion costs allocated per lease working interest for JIB billing. Required for lease development tracking and regulatory co',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Completion strategies are engineered to achieve production rates required by offtake agreements. Real business process: engineering design optimization to meet contractual flow rate commitments and en',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Completion operations require regulatory approval in many jurisdictions (offshore, high-pressure zones). Design approval is part of permit process for well integrity and environmental protection compl',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Completion designs are optimized for expected petroleum product type. Gas completions require different tubing sizes, pressure ratings, and artificial lift than oil completions. Product type drives co',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Completion designs are engineered for specific reservoir characteristics (pressure regime, permeability, fluid type, drive mechanism). Completion strategy selection and stimulation design depend on re',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Completion design history is required for well integrity assessments, workover planning, stimulation design, and P&A planning. Asset management needs original completion specifications for fitness-for',
    `actual_completion_end_date` DATE COMMENT 'Date when completion operations were finished and the well was ready for production or injection.',
    `actual_completion_start_date` DATE COMMENT 'Date when completion operations commenced in the field after reaching Total Depth (TD).',
    `charge_type` STRING COMMENT 'Type of shaped charge used in the perforating guns. Defines the explosive composition and penetration characteristics (e.g., deep penetrating, big hole, extreme overbalance).',
    `closure_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at which the hydraulic fracture closes after treatment, measured in PSI. Determined from pressure decline analysis and critical for proppant selection.',
    `completion_design_number` STRING COMMENT 'Business identifier for the completion design. Human-readable unique code used in operational communications and AFE documentation.',
    `completion_engineer_name` STRING COMMENT 'Name of the operator completion engineer responsible for the design, execution oversight, and post-job analysis of this completion.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the completion design and execution. Tracks progression from design through field execution to final completion.. Valid values are `design|approved|in_progress|completed|suspended|abandoned`',
    `completion_type` STRING COMMENT 'Classification of the completion architecture. Defines the primary method used to establish communication between the reservoir and the wellbore. [ENUM-REF-CANDIDATE: openhole|perforated_casing|gravel_pack|frac_pack|horizontal_multistage_frac|cemented_liner|slotted_liner — 7 candidates stripped; promote to reference product]',
    `confirmed_shots_count` STRING COMMENT 'Number of perforation shots confirmed to have fired successfully based on surface pressure response, gamma ray correlation, or production logging. Used to verify perforation quality.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this completion design record was first created in the system. Used for data lineage and audit trail.',
    `design_date` DATE COMMENT 'Date when the completion design was finalized and approved by the reservoir and drilling engineering teams.',
    `design_remarks` STRING COMMENT 'Free-text field for engineering notes, design rationale, lessons learned, or special considerations for this completion. Captures qualitative insights for future well planning.',
    `frac_fluid_type` STRING COMMENT 'Primary fluid system used in hydraulic fracturing treatment. Common types include slickwater, crosslinked gel, hybrid, foam, or energized fluids.',
    `isip_psi` DECIMAL(18,2) COMMENT 'Pressure measured immediately after pumping stops during a fracture treatment, measured in PSI. Approximates the minimum principal stress and fracture closure pressure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this completion design record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `maximum_treating_pressure_psi` DECIMAL(18,2) COMMENT 'Peak surface treating pressure recorded during the stimulation job, measured in PSI. Used to assess fracture propagation and equipment limits.',
    `packer_setting_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the packer is set in the wellbore, measured in feet from surface. Critical for pressure isolation and completion integrity.',
    `packer_type` STRING COMMENT 'Classification of the downhole packer used to isolate the annulus. Common types include retrievable, permanent, hydraulic-set, mechanical-set, and inflatable packers.',
    `perforation_bottom_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth of the deepest perforation in the completion interval, measured in feet. Defines the bottom of the producing zone.',
    `perforation_gun_size_inches` DECIMAL(18,2) COMMENT 'Outer diameter of the perforating gun assembly, measured in inches. Must be compatible with the tubing or casing internal diameter.',
    `perforation_gun_type` STRING COMMENT 'Type of perforating gun system used. Common types include wireline conveyed, tubing conveyed, through-tubing, casing gun, and oriented perforating systems.',
    `perforation_top_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth of the shallowest perforation in the completion interval, measured in feet. Defines the top of the producing zone.',
    `post_frac_ip_bopd` DECIMAL(18,2) COMMENT 'Initial Production (IP) rate measured in Barrels of Oil Per Day (BOPD) after the completion and stimulation treatment. Key indicator of completion effectiveness and EUR potential.',
    `post_frac_ip_mcfd` DECIMAL(18,2) COMMENT 'Initial Production (IP) rate measured in Thousand Cubic Feet per Day (MCFD) for gas wells after the completion and stimulation treatment.',
    `proppant_type` STRING COMMENT 'Type of proppant material used to hold fractures open. Common types include sand (white, brown, Brady), resin-coated sand, ceramic (lightweight, intermediate, high-strength), or bauxite.',
    `reservoir_engineer_name` STRING COMMENT 'Name of the reservoir engineer who provided input on completion design, perforation intervals, and production forecasting for this well.',
    `shot_density_spf` STRING COMMENT 'Number of perforation shots per linear foot of interval. Common densities are 4, 6, 8, 12, or 16 shots per foot. Higher density increases reservoir contact.',
    `shot_phasing_degrees` STRING COMMENT 'Angular spacing between perforation shots around the casing circumference, measured in degrees. Common phasing includes 0, 60, 90, 120, or 180 degrees.',
    `stimulation_job_type` STRING COMMENT 'Classification of the well stimulation treatment applied after perforation. [ENUM-REF-CANDIDATE: hydraulic_fracture|acid_fracture|matrix_acid|gravel_pack|frac_pack|nitrogen_lift|coiled_tubing_cleanout — promote to reference product]',
    `stimulation_stage_count` STRING COMMENT 'Total number of stimulation stages or treatment intervals in the completion. Horizontal multistage fracturing completions may have 20-60+ stages.',
    `total_frac_fluid_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of fracturing fluid pumped during the stimulation treatment, measured in barrels. Includes pad, slurry, and flush volumes across all stages.',
    `total_proppant_mass_lbs` DECIMAL(18,2) COMMENT 'Total mass of proppant pumped during the stimulation treatment, measured in pounds. Critical metric for fracture conductivity and Estimated Ultimate Recovery (EUR) forecasting.',
    `tubing_grade` STRING COMMENT 'API grade specification for the tubing material. Defines the steel grade and mechanical properties (e.g., J55, K55, N80, L80, P110, Q125).',
    `tubing_size_inches` DECIMAL(18,2) COMMENT 'Outer diameter of the production tubing string installed in the completion, measured in inches. Common sizes include 2.375, 2.875, 3.5, 4.5 inches.',
    `tubing_weight_lb_per_ft` DECIMAL(18,2) COMMENT 'Nominal weight of the tubing per linear foot, measured in pounds per foot. Used for load calculations and string design.',
    `underbalance_pressure_psi` DECIMAL(18,2) COMMENT 'Differential pressure between reservoir pressure and wellbore pressure at the time of perforating, measured in PSI. Positive underbalance helps clean perforations and establish flow.',
    `wellbore_code` BIGINT COMMENT 'Foreign key reference to the specific wellbore section for this completion design. A well may have multiple wellbores (original, sidetracks).',
    CONSTRAINT pk_completion_design PRIMARY KEY(`completion_design_id`)
) COMMENT 'Well completion record defining the completion architecture, perforation execution, and stimulation treatment for a well after reaching TD. Captures completion type (openhole, perforated casing, gravel pack, frac pack, horizontal multistage frac), tubing size and grade, packer type and setting depth. For perforations: interval depths, gun type/size, shot density (SPF), phasing, charge type, underbalance pressure, confirmed shots, and inflow test results. For stimulation: job type (hydraulic fracture, acid fracture, matrix acid), stage number, fluid type/volume, proppant type/mass, maximum treating pressure, ISIP, closure pressure, and post-job decline analysis. Serves as the SSOT for the complete completion operation from design through execution, supporting production optimization and EUR estimation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`perforation_job` (
    `perforation_job_id` BIGINT COMMENT 'Unique identifier for the perforation job record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Perforation jobs are AFE line items under completion services. Link enables cost tracking against AFE budget, invoice validation, and completion cost roll-up. Standard completion cost control.',
    `completion_design_id` BIGINT COMMENT 'Reference to the completion design that specified this perforation job.',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE under which the perforation job costs are tracked.',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well in which the perforation job was executed.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Perforations target specific reservoir zones for production. Zone-level tracking required for production allocation, zone performance analysis, and commingled production management. Critical for reser',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Perforation jobs define producing intervals and completion configuration. Required for: production allocation by zone, workover planning, recompletion candidate screening, zone management, and underst',
    `bsee_reportable_flag` BOOLEAN COMMENT 'Indicates whether the perforation job is subject to BSEE reporting requirements for offshore operations.',
    `charge_type` STRING COMMENT 'Type and model of shaped charge used in the perforating guns.',
    `charge_weight_grams` DECIMAL(18,2) COMMENT 'Weight of explosive material per charge in grams.',
    `confirmed_shots` STRING COMMENT 'Number of perforation shots confirmed through post-job evaluation (e.g., production logging, pressure response).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the perforation job record was first created in the system.',
    `formation_pressure_psi` DECIMAL(18,2) COMMENT 'Estimated or measured formation pore pressure in pounds per square inch at the perforated interval.',
    `gun_size_inches` DECIMAL(18,2) COMMENT 'Outer diameter of the perforating gun in inches.',
    `gun_type` STRING COMMENT 'Type of perforating gun system used for the job.. Valid values are `tubing_conveyed|wireline_conveyed|coiled_tubing_conveyed|through_tubing|casing_gun`',
    `initial_flow_rate_bopd` DECIMAL(18,2) COMMENT 'Initial oil production rate in barrels of oil per day immediately following perforation and cleanup.',
    `initial_gas_rate_mcfd` DECIMAL(18,2) COMMENT 'Initial gas production rate in thousand cubic feet per day immediately following perforation and cleanup.',
    `interval_bottom_md` DECIMAL(18,2) COMMENT 'Measured depth in feet to the bottom of the perforated interval.',
    `interval_bottom_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet to the bottom of the perforated interval.',
    `interval_top_md` DECIMAL(18,2) COMMENT 'Measured depth in feet to the top of the perforated interval.',
    `interval_top_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet to the top of the perforated interval.',
    `job_number` STRING COMMENT 'Business identifier for the perforation job, typically assigned by the operator or service company.',
    `job_remarks` STRING COMMENT 'Free-text field for additional notes, observations, or issues encountered during the perforation job.',
    `job_status` STRING COMMENT 'Current lifecycle status of the perforation job.. Valid values are `planned|in_progress|completed|failed|suspended|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the perforation job record was last updated in the system.',
    `misfire_count` STRING COMMENT 'Number of charges that failed to detonate during the perforation job.',
    `perforated_interval_length_ft` DECIMAL(18,2) COMMENT 'Total length of the perforated interval in feet, calculated as bottom MD minus top MD.',
    `perforation_date` DATE COMMENT 'Date on which the perforation job was executed downhole.',
    `perforation_fluid_density_ppg` DECIMAL(18,2) COMMENT 'Density of the wellbore fluid during perforation in pounds per gallon.',
    `perforation_fluid_type` STRING COMMENT 'Type of fluid in the wellbore during perforation (e.g., brine, diesel, nitrogen, completion fluid).',
    `perforation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the perforation guns were fired.',
    `phasing_degrees` STRING COMMENT 'Angular spacing between perforation shots in degrees (e.g., 0, 60, 90, 120, 180).',
    `post_job_inflow_test_result` STRING COMMENT 'Result of the inflow test performed after perforation to confirm communication with the reservoir.. Valid values are `positive|negative|inconclusive|not_performed`',
    `service_company_engineer` STRING COMMENT 'Name of the service company engineer responsible for the perforation job execution.',
    `service_company_name` STRING COMMENT 'Name of the service company that performed the perforation job.',
    `shot_density_spf` STRING COMMENT 'Number of perforating charges fired per foot of interval, expressed as shots per foot.',
    `total_shots_fired` STRING COMMENT 'Actual number of perforation shots fired during the job.',
    `total_shots_planned` STRING COMMENT 'Total number of perforation shots planned for the job.',
    `underbalance_pressure_psi` DECIMAL(18,2) COMMENT 'Differential pressure in pounds per square inch between formation pressure and wellbore pressure at the time of perforation, used to enhance perforation cleanup.',
    `wellbore_code` BIGINT COMMENT 'Reference to the specific wellbore section where perforation was performed.',
    `wellbore_pressure_psi` DECIMAL(18,2) COMMENT 'Wellbore fluid pressure in pounds per square inch at the perforated depth during gun firing.',
    CONSTRAINT pk_perforation_job PRIMARY KEY(`perforation_job_id`)
) COMMENT 'Perforation job record capturing the execution of perforating operations in a cased wellbore. Records perforation date, interval top and bottom depths, gun type, gun size, shot density (SPF), phasing, charge type, underbalance pressure, number of shots fired, confirmed shots, and post-job inflow test result. Linked to completion design and stimulation job records. Supports production zone management and recompletion planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` (
    `stimulation_job_id` BIGINT COMMENT 'Unique identifier for the hydraulic fracturing or acid stimulation job record. Primary key for the stimulation job entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Stimulation jobs are major AFE expenditures (often largest completion cost). Critical for tracking frac costs against AFE budget, managing overruns, and financial close-out. Standard completion econom',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE that authorized and budgeted this stimulation job. Used for cost tracking and joint interest billing.',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well where the stimulation job was performed. Links to the well master record.',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Stimulation jobs require supervisor for execution oversight, pressure monitoring, and HSE compliance during high-risk fracturing operations. Essential for screenout response, treatment optimization de',
    `perforation_job_id` BIGINT COMMENT 'Foreign key linking to drilling.perforation_job. Business justification: Stimulation job is performed on a perforated interval. The perforation job creates the entry points into the formation; stimulation job treats those perforations. One stimulation job typically treats ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Stimulation treatments target specific reservoir zones. Treatment design (fluid type, proppant, pressure) depends on zone properties. Post-frac performance evaluation and EUR forecasting require expli',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Stimulation jobs are well construction events affecting production performance. Required for: production decline analysis, restimulation candidate screening, EUR forecasting, completion effectiveness ',
    `average_pump_rate_bpm` DECIMAL(18,2) COMMENT 'Average injection rate during the main treatment phase, measured in barrels per minute. Affects fracture geometry, width, and proppant transport.',
    `average_treating_pressure_psi` DECIMAL(18,2) COMMENT 'Average surface treating pressure maintained during the main pumping phase. Indicates treatment consistency and fracture propagation behavior.',
    `breakdown_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at which the formation initially fractures during the treatment. Used for stress regime characterization and fracture initiation analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stimulation job record was first created in the system. Used for data lineage and audit trail purposes.',
    `estimated_fracture_conductivity_md_ft` DECIMAL(18,2) COMMENT 'Estimated fracture conductivity, the product of proppant pack permeability and fracture width. Key parameter for production forecasting and completion optimization.',
    `estimated_fracture_half_length_ft` DECIMAL(18,2) COMMENT 'Estimated distance from the wellbore to the fracture tip, derived from pressure decline analysis or fracture modeling. Critical for EUR estimation and well spacing decisions.',
    `estimated_fracture_height_ft` DECIMAL(18,2) COMMENT 'Estimated vertical extent of the induced fracture. Used to assess containment within target zone and potential communication with adjacent layers.',
    `fluid_system_type` STRING COMMENT 'Classification of the primary fluid system used in the stimulation treatment. Determines viscosity, proppant transport capability, and cleanup characteristics. [ENUM-REF-CANDIDATE: slickwater|linear_gel|crosslinked_gel|hybrid|foam|acid|energized_fluid — 7 candidates stripped; promote to reference product]',
    `fracture_closure_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at which the induced fracture closes, derived from pressure decline analysis. Represents the minimum principal stress in the reservoir.',
    `hse_incidents_count` STRING COMMENT 'Number of HSE incidents recorded during the stimulation job. Used for safety performance tracking and regulatory compliance reporting.',
    `isip_psi` DECIMAL(18,2) COMMENT 'Instantaneous shut-in pressure measured immediately after pumping stops. Critical for estimating minimum horizontal stress and fracture closure pressure.',
    `job_date` DATE COMMENT 'The date on which the stimulation job was executed. Primary business event timestamp for the treatment.',
    `job_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from job start to job end. Critical for operational efficiency analysis and cost allocation.',
    `job_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the stimulation job was completed and pumping operations ceased. Used to calculate job duration and operational efficiency.',
    `job_number` STRING COMMENT 'Business identifier for the stimulation job, typically assigned by the operator or service company. Used for external communication and reporting.',
    `job_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the stimulation job commenced, including pumping operations. Used for detailed operational analysis and NPT tracking.',
    `job_status` STRING COMMENT 'Current lifecycle status of the stimulation job. Tracks progression from planning through execution to completion or termination.. Valid values are `planned|in_progress|completed|screenout|aborted|suspended`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stimulation job record was last updated. Supports change tracking and data quality monitoring.',
    `maximum_proppant_concentration_ppa` DECIMAL(18,2) COMMENT 'Peak proppant concentration achieved during the treatment, measured in pounds per added gallon. Indicates proppant loading and fracture conductivity potential.',
    `maximum_pump_rate_bpm` DECIMAL(18,2) COMMENT 'Peak injection rate achieved during the stimulation job. Used for equipment capacity planning and fracture design validation.',
    `maximum_treating_pressure_psi` DECIMAL(18,2) COMMENT 'Peak surface treating pressure recorded during the stimulation job, measured in psi. Used for fracture geometry estimation and equipment rating verification.',
    `net_pressure_psi` DECIMAL(18,2) COMMENT 'Difference between bottomhole treating pressure and fracture closure pressure. Indicates fracture width and proppant placement efficiency.',
    `post_job_production_test_date` DATE COMMENT 'Date when the post-stimulation production test was conducted. Used to correlate treatment results with production performance.',
    `post_job_production_test_rate_bopd` DECIMAL(18,2) COMMENT 'Initial production rate measured after the stimulation job, expressed in barrels of oil per day. Used to evaluate treatment effectiveness and estimate EUR uplift.',
    `proppant_mesh_size` STRING COMMENT 'Particle size distribution of the proppant, expressed in mesh size range. Affects proppant transport, pack permeability, and fracture conductivity. [ENUM-REF-CANDIDATE: 100_mesh|40_70_mesh|30_50_mesh|20_40_mesh|16_30_mesh|12_20_mesh|8_12_mesh — 7 candidates stripped; promote to reference product]',
    `proppant_type` STRING COMMENT 'Classification of the proppant material used to maintain fracture conductivity. Determines crush strength, conductivity, and cost.. Valid values are `white_sand|brown_sand|resin_coated_sand|ceramic_lightweight|ceramic_intermediate|ceramic_high_strength`',
    `screenout_flag` BOOLEAN COMMENT 'Indicates whether a screenout event occurred during the treatment, where proppant bridging prevented further pumping. Impacts treatment effectiveness and EUR.',
    `service_company_name` STRING COMMENT 'Name of the service company that performed the stimulation job. Used for vendor performance tracking and contract management.',
    `stage_number` STRING COMMENT 'Sequential stage number within a multi-stage completion program. Used to track individual treatment intervals in horizontal or multi-zone wells.',
    `stimulation_type` STRING COMMENT 'Classification of the stimulation treatment method applied. Determines the treatment design, fluid selection, and expected reservoir response.. Valid values are `hydraulic_fracture|acid_fracture|matrix_acid|foam_frac|hybrid_frac|water_frac`',
    `total_clean_fluid_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of clean base fluid (excluding proppant) pumped during the treatment. Used for fluid efficiency calculations and environmental reporting.',
    `total_fluid_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of fracturing or acid fluid pumped during the stimulation job, measured in barrels. Key metric for treatment size and cost estimation.',
    `total_proppant_mass_lbs` DECIMAL(18,2) COMMENT 'Total mass of proppant pumped during the stimulation job, measured in pounds. Critical for fracture conductivity estimation and EUR forecasting.',
    `treatment_effectiveness_rating` STRING COMMENT 'Qualitative assessment of the stimulation job effectiveness based on post-job production performance, pressure response, and operational execution.. Valid values are `excellent|good|fair|poor|failed`',
    `treatment_interval_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth in feet to the midpoint of the treatment interval. Used for pressure gradient calculations and reservoir characterization.',
    `wellbore_code` BIGINT COMMENT 'Reference to the specific wellbore within the well where stimulation was performed. Supports multi-lateral and re-entry scenarios.',
    CONSTRAINT pk_stimulation_job PRIMARY KEY(`stimulation_job_id`)
) COMMENT 'Hydraulic fracturing or acid stimulation job record capturing the execution details of well stimulation operations. Records job date, stimulation type (hydraulic fracture, acid fracture, matrix acid, foam frac), stage number, treatment interval, fluid type, total fluid volume, proppant type, total proppant mass, maximum treating pressure, instantaneous shut-in pressure (ISIP), fracture closure pressure, net pressure, pump rate, and post-job pressure decline analysis. Critical for completion effectiveness evaluation and EUR estimation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_status_history` (
    `well_status_history_id` BIGINT COMMENT 'Unique identifier for each well status or permit event record in the lifecycle tracking system. Primary key for the well status history product.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Well status changes trigger regulatory notifications (spud notices, completion reports, P&A notifications to BSEE, state agencies). Status events feed filing requirements for well lifecycle compliance',
    `created_by_user_employee_id` BIGINT COMMENT 'User ID or system account that created this event record. Provides accountability and audit trail for data entry.',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key reference to the Authorization for Expenditure that covers the costs associated with this status change or permit event. Links lifecycle events to capital and operating budgets.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well master record. Links this status or permit event to the specific well being tracked.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the petroleum engineer or operations manager who authorized or approved the status change. Provides accountability and audit trail for operational decisions.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID or system account that last modified this event record. Provides accountability for data changes and supports audit requirements.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well status changes during drilling phase must link to well asset for complete lifecycle tracking. Required for: asset status reporting, reserves category changes, regulatory status tracking, SEC repo',
    `well_permit_id` BIGINT COMMENT 'Foreign key linking to drilling.well_permit. Business justification: Well status history tracks permit milestones and regulatory events. When event_type relates to permitting (permit application, approval, expiration), the record should reference the specific permit fo',
    `authorizing_engineer_name` STRING COMMENT 'Full name of the petroleum engineer or operations manager who authorized the status change. Denormalized for reporting convenience and historical preservation.',
    `bond_amount_usd` DECIMAL(18,2) COMMENT 'Financial bond or surety amount required by the regulatory authority to ensure compliance with permit conditions and P&A obligations. Expressed in US dollars. Null for status change events or permits without bond requirements.',
    `bsee_incident_number` STRING COMMENT 'Official BSEE incident tracking number if this status change was triggered by or associated with a reportable incident (e.g., well control event, blowout, H2S release). Null for routine status changes.',
    `bsee_reportable_flag` BOOLEAN COMMENT 'Indicates whether this event is subject to mandatory reporting to BSEE under 30 CFR 250. True for offshore wells and certain onshore federal leases; false for state-only jurisdiction wells.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was first created in the data system. Audit field for data lineage and compliance tracking.',
    `data_source_system` STRING COMMENT 'Name of the operational system or application that originated this event record. Examples: Quorum Land System, Avocet Production Operations, BSEE TIMS portal, state regulatory database.',
    `effective_date` DATE COMMENT 'Date when the status change or permit became legally or operationally effective. Used for regulatory compliance and reserves booking.',
    `event_remarks` STRING COMMENT 'Free-text field for additional context, operational notes, or special circumstances related to the status change or permit event. Used for audit trail and knowledge capture.',
    `event_sequence_number` STRING COMMENT 'Sequential ordering number for events within a single well lifecycle, enabling chronological reconstruction of status and permit history.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the status change or permit event occurred in the real world. This is the business event time, distinct from audit timestamps.',
    `event_type` STRING COMMENT 'Discriminator indicating whether this record represents a well status transition or a regulatory permit milestone.. Valid values are `status_change|permit_event`',
    `joint_venture_code` BIGINT COMMENT 'Foreign key reference to the joint venture or joint operating agreement under which this well is operated. Used for partner notification and JIB (Joint Interest Billing) allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was last updated. Tracks data currency and supports change data capture processes.',
    `operator_code` BIGINT COMMENT 'Foreign key reference to the operating company responsible for the well at the time of this event. Tracks operator changes over the well lifecycle.',
    `permit_conditions` STRING COMMENT 'Special conditions, restrictions, or requirements imposed by the regulatory authority as part of the permit approval. May include environmental monitoring, operational constraints, or reporting obligations. Null for status change events.',
    `previous_status_code` STRING COMMENT 'The well status code immediately prior to this status change event. Enables tracking of status transitions and lifecycle progression. Null for the first status event and for permit events.',
    `regulatory_notification_date` DATE COMMENT 'Date when the operator notified the regulatory authority of the status change or permit event. Required for compliance with BSEE and state reporting timelines.',
    `regulatory_notification_method` STRING COMMENT 'Method used to notify the regulatory authority of the event. Examples: electronic filing through BSEE portal, paper submission, verbal notification followed by written confirmation, email to state commission.. Valid values are `electronic_filing|paper_submission|verbal_notification|email`',
    `reserves_category_after` STRING COMMENT 'SEC/PRMS reserves classification of the well immediately after this status change. Enables tracking of reserves category transitions for SEC disclosure and internal reserves management. [ENUM-REF-CANDIDATE: pdp|pdnp|pud|probable|possible|unproved|not_applicable — 7 candidates stripped; promote to reference product]',
    `reserves_category_before` STRING COMMENT 'SEC/PRMS reserves classification of the well immediately before this status change. PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), PUD (Proved Undeveloped), probable, possible, unproved, not applicable (for pre-drilling phase). Used for reserves reconciliation. [ENUM-REF-CANDIDATE: pdp|pdnp|pud|probable|possible|unproved|not_applicable — 7 candidates stripped; promote to reference product]',
    `sec_reserves_impact_flag` BOOLEAN COMMENT 'Indicates whether this status change affects proved reserves classification under SEC Regulation S-K Item 1200 and PRMS standards. True for events that change PDP/PDNP/PUD status; false for administrative or minor operational changes.',
    `status_change_reason` STRING COMMENT 'Business justification or operational reason for the status transition. Examples: drilling program milestone reached, mechanical failure, economic shut-in, regulatory order, completion of P&A operations.',
    `status_code` STRING COMMENT 'Current operational status of the well at this event. For status change events: permitted (APD approved), spudded (drilling commenced), drilling (active drilling), td_reached (total depth achieved), casing_run (casing installation), completing (completion operations), producing (active production), shut_in (temporarily offline), suspended (long-term inactive), pa_complete (plugged and abandoned). Null for permit events. [ENUM-REF-CANDIDATE: permitted|spudded|drilling|td_reached|casing_run|completing|producing|shut_in|suspended|pa_complete — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_well_status_history PRIMARY KEY(`well_status_history_id`)
) COMMENT 'Lifecycle status and regulatory permit history record tracking every status transition and permit milestone of a well from initial APD submission through final P&A. For status events: status code (permitted, spudded, drilling, TD reached, casing run, completing, producing, shut-in, suspended, P&A), effective date, reason for change, authorizing engineer, and regulatory notification date. For permit events: permit type (APD, sundry notice, workover permit, P&A permit), issuing body (BSEE, state commission, EPA), permit number, application/approval/expiration dates, permit conditions, and bond amount. Provides a complete audit trail of well lifecycle and regulatory events for SEC reserves disclosure, BSEE compliance, and D&C program management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`cost_detail` (
    `cost_detail_id` BIGINT COMMENT 'Unique identifier for the drilling cost detail record. Primary key for granular cost tracking at the AFE line-item level.',
    `cost_center_id` BIGINT COMMENT 'The SAP cost center to which this cost is allocated. Used for organizational cost tracking and management reporting.',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE under which this cost was authorized and incurred. Links cost detail to the approved capital budget and joint venture billing structure.',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well for which this drilling cost was incurred. Enables cost rollup by well and comparison to well economics.',
    `freight_invoice_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_invoice. Business justification: Drilling AFE cost details include freight charges for materials transport. Links drilling cost accounting to logistics invoices for three-way match (PO, receipt, invoice), demurrage dispute resolution',
    `gl_account_id` BIGINT COMMENT 'The general ledger account code to which this cost is posted. Aligns with the chart of accounts for financial statement preparation.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Drilling costs are recharged to JV partner accounts per working interest. Required for: joint interest billing (JIB) invoice generation, partner cost statements, AFE variance reporting to partners, re',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig that incurred this cost. Supports rig performance analysis and day rate reconciliation.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Drilling cost details capture material and freight costs tied to specific shipments. Enables reconciliation of shipment volumes/values to AFE actuals, supports inventory valuation, and provides audit ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or service provider who supplied the goods or services. Links to vendor master data for payment processing.',
    `wbs_element_id` BIGINT COMMENT 'The SAP project systems WBS element for this cost. Links drilling costs to capital projects and enables project-based financial reporting.',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual cost amount incurred for this line item in the transaction currency. Core financial value for cost tracking and variance analysis.',
    `afe_budget_amount` DECIMAL(18,2) COMMENT 'The approved budget amount for this AFE line item. Used as the baseline for variance calculation and over-budget alerting.',
    `afe_line_item` STRING COMMENT 'The specific line item number or code within the AFE budget to which this cost is charged. Enables variance tracking at the line-item level.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The variance between cumulative actual cost and AFE budget amount (cumulative_actual_cost minus afe_budget_amount). Positive values indicate over-budget condition.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the AFE budget amount. Used for variance thresholds and management reporting.',
    `capitalizable_flag` BOOLEAN COMMENT 'Boolean indicator that this cost qualifies for capitalization under successful efforts or full cost accounting methods. Determines balance sheet vs income statement treatment.',
    `cost_category` STRING COMMENT 'Primary classification of the drilling cost type. Aligns with COPAS cost categories for standardized joint venture billing. [ENUM-REF-CANDIDATE: rig_day_rate|mud_and_chemicals|bits|casing_and_tubing|cementing|directional_services|logging|completion_services|fuel|catering|rentals|transportation|waste_disposal|inspection|testing — promote to reference product]. Valid values are `rig_day_rate|mud_and_chemicals|bits|casing_and_tubing|cementing|directional_services`',
    `cost_date` DATE COMMENT 'The date on which the cost was incurred or the service was performed. Used for daily cost tracking and accrual accounting.',
    `cost_detail_description` STRING COMMENT 'Free-text description of the cost detail providing additional context beyond category and subcategory. Includes vendor description and line item details from the invoice.',
    `cost_status` STRING COMMENT 'The current status of the cost detail record in the approval and posting workflow. Tracks lifecycle from vendor invoice receipt through general ledger posting.. Valid values are `pending|approved|posted|disputed|reversed`',
    `cost_subcategory` STRING COMMENT 'Detailed classification within the cost category. Provides granular cost breakdown for analysis (e.g., under cementing: primary cement, squeeze cement, cement additives).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost detail record was first created in the system. Used for audit trail and data lineage tracking.',
    `cumulative_actual_cost` DECIMAL(18,2) COMMENT 'The cumulative actual cost incurred to date for this AFE line item, including this cost detail record. Updated incrementally for real-time budget tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the actual amount (e.g., USD, CAD, GBP). Required for multi-currency operations and foreign exchange reconciliation.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency to functional currency. Stored for audit trail and revaluation purposes.',
    `functional_amount_usd` DECIMAL(18,2) COMMENT 'The cost amount converted to the functional currency (USD) using the exchange rate at the cost date. Used for consolidated financial reporting and cross-border cost comparison.',
    `invoice_date` DATE COMMENT 'The date the vendor invoice was issued. Used for accounts payable reconciliation and payment terms tracking.',
    `invoice_number` STRING COMMENT 'The vendor invoice number or reference. Used for accounts payable reconciliation and audit trail.',
    `jib_billing_code` STRING COMMENT 'The COPAS-compliant billing code used for joint venture partner invoicing. Standardizes cost allocation across working interest owners.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost detail record was last updated. Used for change tracking and audit trail.',
    `non_consent_flag` BOOLEAN COMMENT 'Boolean indicator that one or more joint venture partners elected not to participate in this AFE. Affects cost allocation and revenue interest calculations.',
    `operator_share_amount` DECIMAL(18,2) COMMENT 'The operators share of the cost based on working interest percentage. Calculated as actual_amount multiplied by working_interest_percentage.',
    `over_budget_flag` BOOLEAN COMMENT 'Boolean indicator that the cumulative actual cost has exceeded the AFE budget amount. Triggers alerts and approval workflows for supplemental AFE requests.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the vendor based on invoice date and payment terms. Used for accounts payable aging and cash management.',
    `payment_terms` STRING COMMENT 'The payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Used for cash flow forecasting and accounts payable management.',
    `posting_date` DATE COMMENT 'The date the cost was posted to the general ledger in SAP FI/CO. Used for financial period close and audit trail.',
    `purchase_order_number` STRING COMMENT 'The purchase order number under which the goods or services were procured. Links cost to procurement contracts and terms.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of goods or services purchased (e.g., barrels of mud, feet of casing, hours of service). Used for unit cost analysis.',
    `remarks` STRING COMMENT 'Additional notes or comments regarding this cost detail. Used for dispute resolution, audit explanations, and special handling instructions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount included in the actual cost (e.g., sales tax, VAT, GST). Separated for tax reporting and recoverability analysis.',
    `tax_code` STRING COMMENT 'The tax jurisdiction code or tax type code applied to this cost. Used for tax compliance reporting and audit trail.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity field (e.g., BBL, FT, HR, EA, TON). Standardized to API and COPAS conventions where applicable.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure in the transaction currency. Calculated as actual_amount divided by quantity for unit cost benchmarking.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage applicable to this cost for the operator. Used to calculate the operators share of joint venture costs.',
    CONSTRAINT pk_cost_detail PRIMARY KEY(`cost_detail_id`)
) COMMENT 'Granular drilling cost record capturing actual expenditures incurred during drilling and completion operations at the AFE line-item level. Records cost date, cost category (rig day rate, mud and chemicals, bits, casing and tubing, cementing, directional services, logging, completion services, fuel, catering), vendor name, invoice reference, actual amount, AFE line item, cumulative spend vs AFE budget, and variance flag. Feeds SAP CO/PS cost tracking and COPAS-compliant JIB statements for joint venture partners.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` (
    `plug_and_abandonment_id` BIGINT COMMENT 'Primary key for plug_and_abandonment',
    `abandonment_plan_id` BIGINT COMMENT 'Foreign key linking to asset.abandonment_plan. Business justification: Links P&A execution record to the abandonment plan it implements. Required for: regulatory compliance verification, plan vs actual cost reconciliation, ARO liability adjustment, post-abandonment audit',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: P&A operations require AFE authorization and budget tracking. Essential for abandonment cost management, regulatory compliance reporting, and asset retirement obligation (ARO) accounting. Standard P&A',
    `contractor_id` BIGINT COMMENT 'FK to workforce.contractor',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key reference to the AFE authorizing the plug and abandonment expenditure.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key reference to the well being permanently or temporarily abandoned.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: P&A operations fulfill lease abandonment obligations. Required for lease termination, bond release, surface restoration compliance, and final lease accounting. Standard end-of-life process in oil & ga',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: P&A operations require operator representative for regulatory compliance verification, plug placement approval, and surface restoration sign-off. Replaces denormalized operator_representative text fie',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: P&A operations require regulatory approval and permits from BSEE or state agencies. Regulatory_approval_number exists but no FK to master permit record for unified compliance tracking.',
    `abandonment_reason` STRING COMMENT 'Business justification for abandoning the well, such as economic depletion, mechanical failure, regulatory requirement, or lease expiration.',
    `bridge_plug_setting_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet where the bridge plug was set during the plug and abandonment operation.',
    `bridge_plug_type` STRING COMMENT 'The type or model of mechanical bridge plug used in the plug and abandonment operation, if applicable.',
    `casing_cut_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet where the casing was cut during the plug and abandonment operation.',
    `casing_disposition` STRING COMMENT 'The final disposition of the well casing: removed, cut and capped, left in hole, or recovered.. Valid values are `removed|cut_and_capped|left_in_hole|recovered`',
    `cement_type` STRING COMMENT 'The specific type or class of cement used for plug and abandonment operations (e.g., Class A, Class G, Class H).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this plug and abandonment record was first created in the system.',
    `depth_uom` STRING COMMENT 'The unit of measure for all depth measurements in the plug and abandonment record (feet or meters).. Valid values are `ft|m`',
    `final_well_status` STRING COMMENT 'The final operational status of the well after plug and abandonment operations are completed.. Valid values are `permanently_abandoned|temporarily_abandoned|plugged_and_abandoned`',
    `intermediate_plug_bottom_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet to the bottom of the intermediate cement plug.',
    `intermediate_plug_top_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet to the top of the intermediate cement plug isolating intermediate zones.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this plug and abandonment record was last updated or modified.',
    `offshore_flag` BOOLEAN COMMENT 'Boolean indicator of whether the plug and abandonment operation is for an offshore well (True) or onshore well (False).',
    `pa_completion_date` DATE COMMENT 'The date when all plug and abandonment activities were finalized and the well was secured.',
    `pa_date` DATE COMMENT 'The date when the plug and abandonment operation was completed and the well was officially plugged.',
    `pa_number` STRING COMMENT 'Business identifier for the plug and abandonment operation, typically assigned by the operator or regulatory authority.',
    `pa_remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to the plug and abandonment operation.',
    `pa_start_date` DATE COMMENT 'The date when plug and abandonment operations commenced on the wellbore.',
    `pa_status` STRING COMMENT 'Current lifecycle status of the plug and abandonment operation.. Valid values are `planned|in_progress|completed|approved|rejected`',
    `pa_type` STRING COMMENT 'Classification of the abandonment operation: permanent (final well closure) or temporary (suspension for future re-entry).. Valid values are `permanent|temporary`',
    `plug_material_type` STRING COMMENT 'The primary material used for plugging the wellbore: cement, mechanical plug, bridge plug, or combination.. Valid values are `cement|mechanical|bridge_plug|combination`',
    `production_plug_bottom_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet to the bottom of the production zone cement plug.',
    `production_plug_top_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet to the top of the production zone cement plug isolating the producing formation.',
    `regulatory_agency` STRING COMMENT 'The name of the regulatory agency that approved and oversees the plug and abandonment operation (e.g., BSEE, state oil and gas commission).',
    `regulatory_approval_date` DATE COMMENT 'The date when the regulatory authority approved the plug and abandonment application.',
    `regulatory_approval_number` STRING COMMENT 'The approval or permit number issued by BSEE, state regulatory agency, or other governing body authorizing the plug and abandonment operation.',
    `surface_plug_bottom_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet to the bottom of the surface cement plug.',
    `surface_plug_top_depth_md` DECIMAL(18,2) COMMENT 'The measured depth in feet to the top of the surface cement plug.',
    `surface_restoration_date` DATE COMMENT 'The date when surface restoration and site reclamation activities were completed.',
    `surface_restoration_status` STRING COMMENT 'The status of surface restoration activities required after plug and abandonment, including site remediation and reclamation.. Valid values are `not_started|in_progress|completed|approved`',
    `total_cement_volume_bbl` DECIMAL(18,2) COMMENT 'The total volume of cement in barrels used across all plugs during the plug and abandonment operation.',
    `total_plugs_set` STRING COMMENT 'The total number of cement or mechanical plugs set during the plug and abandonment operation.',
    `tubing_disposition` STRING COMMENT 'The final disposition of the production tubing: removed, cut and capped, left in hole, or recovered.. Valid values are `removed|cut_and_capped|left_in_hole|recovered`',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'The water depth in feet at the well location for offshore plug and abandonment operations.',
    `wellbore_code` BIGINT COMMENT 'Foreign key reference to the specific wellbore being plugged and abandoned.',
    `wellhead_removal_date` DATE COMMENT 'The date when the wellhead equipment was removed as part of the plug and abandonment operation.',
    `wellhead_removed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the wellhead equipment has been removed (True) or remains in place (False).',
    CONSTRAINT pk_plug_and_abandonment PRIMARY KEY(`plug_and_abandonment_id`)
) COMMENT 'Plug and Abandonment (P&A) record capturing the regulatory and operational details of permanently abandoning a wellbore. Records P&A date, P&A type (temporary, permanent), plug depths and intervals, plug material (cement, mechanical), bridge plug settings, tubing and casing disposition, wellhead removal date, surface restoration status, BSEE/state regulatory approval number, and final well status confirmation. Mandatory for BSEE compliance and SEC reserves reclassification from PDP to abandoned.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`mud_program` (
    `mud_program_id` BIGINT COMMENT 'Unique identifier for the drilling fluid (mud) program record. Primary key.',
    `additive_id` BIGINT COMMENT 'Foreign key linking to product.additive. Business justification: Drilling mud programs specify additives (viscosifiers, weighting agents, lost circulation materials, shale inhibitors) by product code, treat rate, and supplier. Essential for AFE cost tracking, vendo',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well for which this mud program is designed. Links to the well master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Mud programs require designated mud engineer for formulation approval, rheology management, and environmental compliance. Replaces denormalized mud_engineer_name field. Critical for HPHT well control,',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Mud service companies are vendors providing drilling fluids and mud engineering. Link enables vendor performance tracking, contract compliance, and invoice validation. Standard drilling services procu',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Mud programs designed based on reservoir pressure, temperature, and fluid characteristics. HPHT classification, pore pressure prediction, and mud weight windows all reservoir-dependent. Essential for ',
    `well_program_id` BIGINT COMMENT 'Foreign key linking to drilling.well_program. Business justification: Mud program is designed as part of the well program engineering document. Each mud program should reference the well program it supports. Well program contains high-level mud_system_type; mud_program ',
    `actual_chloride_content_mg_per_l` STRING COMMENT 'Actual chloride ion concentration measured during drilling operations in milligrams per liter. Captured from daily mud checks and lab analysis.',
    `actual_fluid_loss_ml_per_30min` DECIMAL(18,2) COMMENT 'Actual API fluid loss measured during drilling operations in milliliters per 30 minutes. Captured from daily mud checks and lab analysis.',
    `actual_mud_weight_ppg` DECIMAL(18,2) COMMENT 'Actual mud weight (density) measured during drilling operations in pounds per gallon (ppg). Captured from daily drilling reports and mud checks.',
    `actual_oil_water_ratio` STRING COMMENT 'Actual ratio of oil phase to water phase measured during drilling operations for invert emulsion muds. Captured from retort analysis.',
    `actual_ph` DECIMAL(18,2) COMMENT 'Actual pH measured during drilling operations. Captured from daily mud checks and lab analysis.',
    `actual_plastic_viscosity_cp` STRING COMMENT 'Actual plastic viscosity (PV) measured during drilling operations in centipoise. Calculated from 600 RPM and 300 RPM viscometer readings.',
    `actual_solids_content_percent` DECIMAL(18,2) COMMENT 'Actual total solids content measured during drilling operations as a percentage by volume. Captured from retort analysis.',
    `actual_viscosity_seconds` STRING COMMENT 'Actual viscosity measured during drilling operations in Marsh funnel seconds. Captured from daily mud checks and lab analysis.',
    `actual_yield_point_lb_per_100sqft` STRING COMMENT 'Actual yield point (YP) measured during drilling operations in pounds per 100 square feet. Calculated from viscometer readings (300 RPM reading minus PV).',
    `approval_date` DATE COMMENT 'Date when the mud program was formally approved by the drilling engineer, operations manager, or regulatory authority. Required before implementation.',
    `approved_by` STRING COMMENT 'Name and title of the person who approved the mud program. Typically the drilling engineer, operations manager, or well site leader.',
    `co2_present_flag` BOOLEAN COMMENT 'Indicates whether carbon dioxide gas is expected in the formations to be drilled. True if CO2 is present, which can cause carbonic acid formation and pH reduction in water-based muds.',
    `completion_date` DATE COMMENT 'Date when drilling of this hole section was completed and the mud program was no longer active. Typically when casing is set or total depth is reached.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mud program record was first created in the system. Used for audit trail and data lineage tracking.',
    `design_chloride_content_mg_per_l` STRING COMMENT 'Target chloride ion concentration in milligrams per liter. Critical for saltwater muds and inhibitive systems. High chloride content indicates salt contamination or intentional salt addition for shale inhibition.',
    `design_date` DATE COMMENT 'Date when the mud program was designed and documented. Typically completed during the well planning phase before spud.',
    `design_fluid_loss_ml_per_30min` DECIMAL(18,2) COMMENT 'Target API fluid loss (filtrate volume) in milliliters per 30 minutes at 100 psi differential pressure. Controls formation damage and filter cake quality. Lower values indicate better filtration control.',
    `design_gel_strength_10min_lb_per_100sqft` STRING COMMENT 'Target gel strength measured after 10 minutes of static conditions in pounds per 100 square feet. Higher values indicate progressive gelation which can cause circulation problems.',
    `design_gel_strength_10sec_lb_per_100sqft` STRING COMMENT 'Target gel strength measured after 10 seconds of static conditions in pounds per 100 square feet. Indicates the muds ability to suspend cuttings when circulation stops.',
    `design_mud_weight_max_ppg` DECIMAL(18,2) COMMENT 'Maximum planned mud weight (density) for this hole section in pounds per gallon (ppg). Must not exceed fracture gradient to prevent lost circulation.',
    `design_mud_weight_min_ppg` DECIMAL(18,2) COMMENT 'Minimum planned mud weight (density) for this hole section in pounds per gallon (ppg). Must be sufficient to provide hydrostatic pressure to control formation fluids and prevent kicks.',
    `design_oil_water_ratio` STRING COMMENT 'Target ratio of oil phase to water phase for invert emulsion muds (oil-based and synthetic-based). Expressed as oil:water (e.g., 80:20, 75:25). Higher oil content provides better shale inhibition but increases cost and environmental impact.',
    `design_ph_max` DECIMAL(18,2) COMMENT 'Maximum target pH level for the mud system. Excessive pH can cause formation damage and chemical instability.',
    `design_ph_min` DECIMAL(18,2) COMMENT 'Minimum target pH level for the mud system. Controls corrosion, chemical stability, and solubility of additives. Typical range 8.5-10.5 for water-based muds.',
    `design_plastic_viscosity_cp` STRING COMMENT 'Target plastic viscosity (PV) in centipoise, representing the viscosity of the mud when extrapolated to infinite shear rate. Part of the Bingham plastic rheological model.',
    `design_solids_content_percent` DECIMAL(18,2) COMMENT 'Target total solids content as a percentage by volume. Includes both low-gravity solids (drilled cuttings) and high-gravity solids (barite, hematite). Excessive solids reduce drilling efficiency.',
    `design_viscosity_target_seconds` STRING COMMENT 'Target viscosity for the mud system measured in Marsh funnel seconds. Controls the muds ability to suspend cuttings and transport them to surface.',
    `design_yield_point_lb_per_100sqft` STRING COMMENT 'Target yield point (YP) in pounds per 100 square feet, representing the stress required to initiate flow. Part of the Bingham plastic rheological model. Critical for hole cleaning and cuttings suspension.',
    `environmental_disposal_classification` STRING COMMENT 'Approved method for disposal of spent drilling fluid and cuttings. Overboard discharge is permitted for water-based muds in offshore operations meeting EPA and BSEE toxicity limits. Oil-based and synthetic-based muds require onshore disposal, re-injection, or thermal treatment.. Valid values are `overboard-discharge|onshore-disposal|re-injection|thermal-treatment|bioremediation`',
    `h2s_concentration_ppm` STRING COMMENT 'Expected concentration of hydrogen sulfide in formation gas in parts per million (ppm). Concentrations above 10 ppm require H2S scavengers in the mud system. Concentrations above 100 ppm require enhanced safety protocols.',
    `h2s_present_flag` BOOLEAN COMMENT 'Indicates whether hydrogen sulfide gas is expected in the formations to be drilled. True if H2S is present, requiring specialized mud additives (H2S scavengers) and safety procedures.',
    `hole_section_code` BIGINT COMMENT 'Reference to the specific hole section (e.g., surface, intermediate, production) for which this mud program applies. Links to the hole section master record.',
    `hpht_classification` STRING COMMENT 'Classification of the well environment based on pressure and temperature conditions. HPHT wells (>10,000 psi and >300°F) require specialized mud formulations with thermal stability and pressure resistance. Extreme HPHT exceeds 15,000 psi or 400°F.. Valid values are `standard|hpht|extreme-hpht|non-hpht`',
    `implementation_date` DATE COMMENT 'Date when the mud program was put into active use during drilling operations. Marks the transition from design to execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this mud program record was last updated in the system. Used for audit trail and change tracking.',
    `max_anticipated_pressure_psi` STRING COMMENT 'Maximum formation pressure expected in this hole section in pounds per square inch (psi). Used to design mud weight window and well control procedures.',
    `max_anticipated_temperature_f` STRING COMMENT 'Maximum bottomhole temperature expected in this hole section in degrees Fahrenheit. High temperatures can degrade mud additives and affect rheological properties.',
    `mud_subtype` STRING COMMENT 'Detailed classification of the mud system within the primary type (e.g., freshwater gel, saltwater polymer, low-toxicity oil-based, ester-based synthetic, potassium chloride polymer).',
    `mud_system_type` STRING COMMENT 'Primary classification of the drilling fluid system. Water-based mud (WBM) uses water as the continuous phase; oil-based mud (OBM) uses diesel or mineral oil; synthetic-based mud (SBM) uses synthetic hydrocarbons; pneumatic uses air or gas; foam uses aerated fluids.. Valid values are `water-based|oil-based|synthetic-based|pneumatic|foam`',
    `offshore_discharge_permitted_flag` BOOLEAN COMMENT 'Indicates whether the mud system is approved for overboard discharge in offshore operations. True if the mud meets EPA toxicity limits (96-hour LC50 >30,000 ppm) and BSEE discharge requirements. False if onshore disposal is required.',
    `program_revision_number` STRING COMMENT 'Version number of the mud program. Incremented each time the program is revised due to changes in formation conditions, well control requirements, or operational adjustments.',
    `program_status` STRING COMMENT 'Current lifecycle status of the mud program. Tracks progression from design through execution to completion.. Valid values are `draft|approved|active|completed|superseded|cancelled`',
    `wellbore_code` BIGINT COMMENT 'Reference to the specific wellbore (original, sidetrack, or re-entry) for this mud program. Links to the wellbore master record.',
    CONSTRAINT pk_mud_program PRIMARY KEY(`mud_program_id`)
) COMMENT 'Drilling fluid (mud) program record defining the mud system design for each hole section of a well. Captures hole section, mud type (water-based, oil-based, synthetic-based), mud weight range, viscosity targets, fluid loss specification, pH range, chloride content, solids content, high-pressure high-temperature (HPHT) requirements, and environmental disposal classification. Tracks actual mud properties vs design at each depth interval. Supports well control planning and environmental compliance for offshore discharge regulations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_permit` (
    `well_permit_id` BIGINT COMMENT 'Unique identifier for the well permit record. Primary key for the well permit entity.',
    `block_id` BIGINT COMMENT 'FK to exploration.block',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Drilling well permits should reference master compliance permit record for unified regulatory tracking. Enables consolidated permit management across drilling and compliance domains for audit and repo',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Well permits require designated agent employee for regulatory liaison with BSEE/state agencies, permit condition compliance, and inspection coordination. Replaces denormalized designated_agent text fi',
    `drilling_well_id` BIGINT COMMENT 'Reference to the well for which this permit was issued. Links to the well master record in the drilling domain.',
    `field_id` BIGINT COMMENT 'FK to drilling.field',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Drilling permits issued for specific leases. Permit applications require lease documentation, lessor consent verification, and lease term validation. Regulatory agencies require lease identification i',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Well permits designate operator of record as legal entity. Required for: regulatory compliance (BSEE/state agency filings), operator designation changes, permit transfer workflows, bonding requirement',
    `operator_id` BIGINT COMMENT 'FK to drilling.operator',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Permits are regulatory documents tied to well asset for compliance tracking. Required for: regulatory audits, permit renewal tracking, compliance reporting, demonstrating authorization for well operat',
    `well_program_id` BIGINT COMMENT 'Foreign key linking to drilling.well_program. Business justification: Well permit authorizes execution of a specific well program. The permit references the planned program details for regulatory approval. One permit authorizes one program. Removing attributes that are ',
    `actual_completion_date` DATE COMMENT 'Actual date when drilling and completion operations were finished. Must be reported to regulatory authority for permit closure.',
    `actual_spud_date` DATE COMMENT 'Actual date when drilling operations commenced. Must be reported to regulatory authority and must fall within the permit validity period.',
    `application_date` DATE COMMENT 'Date when the permit application was formally submitted to the regulatory authority. Used to track regulatory review timelines and compliance with submission deadlines.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority officially approved the permit. This is the effective start date for permit validity and the date from which operations may legally commence.',
    `approval_notes` STRING COMMENT 'Notes and comments from the regulatory authority regarding the permit approval, including any special instructions or clarifications.',
    `bond_amount_usd` DECIMAL(18,2) COMMENT 'Financial bond amount required by the regulatory authority to ensure proper well plugging and abandonment. Protects against environmental liability and ensures funds are available for proper well closure.',
    `bond_number` STRING COMMENT 'Unique identifier for the financial bond instrument securing this permit. Used for tracking and verification of financial assurance.',
    `bond_type` STRING COMMENT 'Type of financial bond securing the permit. Individual Well Bond covers a single well, Blanket Bond covers multiple wells, Area-Wide Bond covers all wells in a geographic area, and Supplemental Bond provides additional coverage for high-risk wells.. Valid values are `Individual Well Bond|Blanket Bond|Area-Wide Bond|Supplemental Bond`',
    `bop_pressure_rating_psi` STRING COMMENT 'Required pressure rating for the blowout preventer stack in pounds per square inch. Must meet or exceed maximum anticipated wellbore pressure for regulatory approval.',
    `cancellation_date` DATE COMMENT 'Date when the permit was cancelled by either the operator or the regulatory authority. Used for permit lifecycle tracking and compliance reporting.',
    `cancellation_reason` STRING COMMENT 'Explanation of why the permit was cancelled. May include project abandonment, economic factors, or regulatory non-compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Used for audit trail and data lineage tracking.',
    `denial_reason` STRING COMMENT 'Detailed explanation of why the permit was denied by the regulatory authority. Used for resubmission planning and compliance improvement.',
    `effective_date` DATE COMMENT 'Date when the permit becomes legally effective and operations may begin. May differ from approval date if the permit has a delayed effective date specified by the regulatory authority.',
    `environmental_assessment_date` DATE COMMENT 'Date when the environmental assessment or environmental impact statement was completed and approved. Required before permit can be issued for environmentally sensitive areas.',
    `environmental_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether an environmental assessment or environmental impact statement was required as part of the permit application process. True if environmental review was mandatory.',
    `expiration_date` DATE COMMENT 'Date when the permit expires and is no longer valid for operations. Operations must be completed or a permit extension must be obtained before this date to maintain regulatory compliance.',
    `extension_count` STRING COMMENT 'Number of times the permit has been extended beyond its original expiration date. Tracks regulatory accommodation history and potential compliance risk.',
    `h2s_concentration_ppm` DECIMAL(18,2) COMMENT 'Expected concentration of hydrogen sulfide in parts per million. Used to determine safety equipment requirements and emergency response planning.',
    `h2s_present_flag` BOOLEAN COMMENT 'Indicates whether hydrogen sulfide gas is expected to be present in the well. True if H2S is anticipated, requiring special safety equipment and procedures.',
    `hpht_classification_flag` BOOLEAN COMMENT 'Indicates whether the well is classified as High Pressure High Temperature (HPHT). True if the well meets HPHT criteria, requiring specialized equipment and procedures.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body that issued or is reviewing the permit. Examples include BSEE (Bureau of Safety and Environmental Enforcement) for offshore federal waters, state oil and gas commissions for onshore operations, or EPA (Environmental Protection Agency) for environmental permits.',
    `jurisdiction` STRING COMMENT 'The regulatory jurisdiction under which the permit falls. Determines which regulatory body has authority and which rules apply.. Valid values are `Federal Offshore|State Onshore|State Offshore|Tribal Lands|Private Lands`',
    `last_extension_date` DATE COMMENT 'Date of the most recent permit extension approval. Used to track extension history and calculate current expiration date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated in the system. Used for audit trail and change tracking.',
    `offshore_flag` BOOLEAN COMMENT 'Indicates whether the well is located offshore (true) or onshore (false). Determines applicable regulatory framework and safety requirements.',
    `permit_conditions` STRING COMMENT 'Specific conditions, restrictions, or stipulations imposed by the regulatory authority as part of the permit approval. May include environmental protections, operational restrictions, monitoring requirements, or seasonal limitations.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the regulatory authority. This is the externally-known unique identifier for the permit used in all regulatory correspondence and compliance reporting.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Tracks the permit from initial draft through regulatory approval, active operations, and final closure. Critical for compliance tracking and operational planning. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Approved|Denied|Expired|Suspended|Cancelled|Closed — 9 candidates stripped; promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on the type of drilling or well operation activity. APD (Application for Permit to Drill) is for new wells, Sundry Notice for modifications, Workover Permit for well intervention, P&A (Plug and Abandonment) Permit for well closure, Sidetrack Permit for directional drilling from existing wellbore, and Recompletion Permit for changing production zones.. Valid values are `APD|Sundry Notice|Workover Permit|P&A Permit|Sidetrack Permit|Recompletion Permit`',
    `planned_completion_date` DATE COMMENT 'Planned date to complete drilling and completion operations as stated in the permit application. Used for regulatory timeline compliance tracking.',
    `planned_spud_date` DATE COMMENT 'Planned date to spud (commence drilling) the well as stated in the permit application. Used for regulatory planning and rig scheduling coordination.',
    `reviewer_name` STRING COMMENT 'Name of the regulatory agency staff member assigned to review the permit application. Used for tracking and correspondence.',
    `surety_company` STRING COMMENT 'Name of the surety company or financial institution providing the bond. Must be an approved surety on the U.S. Department of Treasury list.',
    `surface_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the well surface location in decimal degrees. Used for geographic identification and regulatory jurisdiction determination.',
    `surface_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the well surface location in decimal degrees. Used for geographic identification and regulatory jurisdiction determination.',
    `suspension_reason` STRING COMMENT 'Reason why the permit was suspended by the regulatory authority. May include safety violations, environmental concerns, or administrative issues.',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Water depth at the well location in feet for offshore wells. Critical for rig selection, BOP requirements, and regulatory classification (shallow water vs deepwater).',
    CONSTRAINT pk_well_permit PRIMARY KEY(`well_permit_id`)
) COMMENT 'Regulatory drilling permit record tracking all permits required to drill, complete, and operate a well. Captures permit type (APD - Application for Permit to Drill, sundry notice, workover permit, P&A permit), issuing regulatory body (BSEE, state oil and gas commission, EPA), permit number, application date, approval date, expiration date, permit conditions, bond amount, and permit status. Manages the regulatory approval lifecycle from initial APD submission through final well abandonment permit. Mandatory for BSEE offshore and state onshore compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`dc_program` (
    `dc_program_id` BIGINT COMMENT 'Unique identifier for the drilling and completion program. Primary key for the D&C program master record.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Multi-well drilling programs require regulatory approval and reporting (development plans, environmental assessments). Program-level filings are common for field development and BSEE exploration plan ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Drilling campaigns are major capital programs tracked in cost centers for budget management and multi-well cost aggregation. New attribute needed; no existing candidate. Standard oil & gas practice.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Multi-well drilling campaigns in joint ventures require JOA governance. Operating committees approve programs, budget follows JOA terms, non-consent can apply at program level. Essential for tracking ',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Multi-well drilling campaigns planned to fulfill lease development obligations and acreage retention requirements. Program budgets allocated per lease for working interest accounting. Standard practic',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Drilling campaigns have designated operator entities for program-level governance. Required for: master service agreements, program-level JV agreements, regulatory program approvals, consolidated prog',
    `primary_dc_employee_id` BIGINT COMMENT 'System identifier linking to the employee or contractor record of the program manager.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Drilling campaigns map to WBS elements for multi-well project accounting and capital tracking. New attribute needed; no existing candidate. Standard oil & gas project accounting practice.',
    `actual_duration_days` STRING COMMENT 'Actual total duration of the D&C program from start to completion, expressed in calendar days. Updated upon program completion.',
    `actual_total_capex_usd` DECIMAL(18,2) COMMENT 'Cumulative actual capital expenditure incurred to date across all wells and activities in the program. Updated from AFE actuals and JIB postings.',
    `actual_well_count` STRING COMMENT 'Actual number of wells spudded or completed under this program to date. Updated as wells are drilled.',
    `approval_date` DATE COMMENT 'Date when the D&C program and associated CAPEX budget were formally approved by the appropriate authority (management committee, board, or JV partners).',
    `approved_total_capex_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure budget approved for the D&C program, including all AFEs, rig costs, completion costs, and contingencies. Expressed in USD.',
    `authorization_basis` STRING COMMENT 'Business justification or strategic rationale for the D&C program (e.g., FY2024 Capital Plan, Board Resolution 2024-03, JV Development Agreement Commitment). Links to governance and approval documentation.',
    `average_planned_td_md_ft` DECIMAL(18,2) COMMENT 'Average planned total depth (measured depth) across all wells in the program, expressed in feet. Used for program-level drilling performance benchmarking.',
    `average_planned_td_tvd_ft` DECIMAL(18,2) COMMENT 'Average planned total depth (true vertical depth) across all wells in the program, expressed in feet. Used for subsurface planning and reserves estimation.',
    `average_rig_day_rate_usd` DECIMAL(18,2) COMMENT 'Average daily rig rate across all rigs used in the program, expressed in USD. Used for cost benchmarking and budget variance analysis.',
    `basin_name` STRING COMMENT 'Name of the geological basin or play where the program is located (e.g., Permian Basin, Gulf of Mexico, Williston Basin). Used for portfolio-level basin analytics.',
    `block_name` STRING COMMENT 'Lease block or concession area identifier where the program wells are located. Particularly relevant for offshore programs (e.g., Green Canyon Block 123, Mississippi Canyon 252).',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'Budget variance expressed as a percentage of approved CAPEX. Calculated as (actual - approved) / approved * 100.',
    `budget_variance_usd` DECIMAL(18,2) COMMENT 'Variance between approved CAPEX and actual CAPEX (actual minus approved). Positive values indicate over-budget, negative values indicate under-budget.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Contingency reserve as a percentage of approved CAPEX, allocated for unforeseen costs, NPT, or scope changes. Typically ranges from 5% to 20% based on risk category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the D&C program record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program budget. Typically USD for international operations, but may vary by jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `environmental_sensitivity_classification` STRING COMMENT 'Classification of the program area based on environmental sensitivity: standard (routine operations), sensitive (near protected areas), protected (within designated zones), or critical (endangered species habitat or cultural sites).. Valid values are `standard|sensitive|protected|critical`',
    `field_name` STRING COMMENT 'Name of the oil or gas field where the D&C program is being executed. For exploration programs, may reference the prospect or block name.',
    `h2s_present_flag` BOOLEAN COMMENT 'Indicates whether hydrogen sulfide (sour gas) is anticipated in the program wells. Drives HSE protocols, BOP specifications, and personnel safety requirements.',
    `hpht_classification` STRING COMMENT 'Classification of the program based on anticipated downhole pressure and temperature conditions: standard (normal), HPHT (>10,000 psi or >300°F), extreme HPHT (>15,000 psi or >400°F), or not applicable.. Valid values are `standard|hpht|extreme_hpht|not_applicable`',
    `joint_venture_code` BIGINT COMMENT 'Identifier of the joint venture or partnership under which the D&C program is being executed. Links to the JOA and partner working interest structure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the D&C program record was last updated. Used for audit trail and change tracking.',
    `offshore_flag` BOOLEAN COMMENT 'Indicates whether the D&C program is offshore (true) or onshore (false). Drives regulatory reporting requirements and HSE protocols.',
    `operator_code` BIGINT COMMENT 'Identifier of the operating company responsible for executing the D&C program. References the legal entity serving as operator under the JOA.',
    `planned_duration_days` STRING COMMENT 'Planned total duration of the D&C program from start to completion, expressed in calendar days. Used for rig contract planning and schedule optimization.',
    `planned_well_count` STRING COMMENT 'Total number of wells planned for drilling and completion under this program at the time of AFE approval. Used for portfolio planning and rig scheduling.',
    `primary_rig_contractor` STRING COMMENT 'Name of the primary drilling contractor providing rig services for the program (e.g., Nabors, Helmerich & Payne, Transocean). Used for vendor performance tracking.',
    `program_end_date` DATE COMMENT 'Planned or actual end date of the D&C program, typically aligned with the last well TD and rig release or demobilization.',
    `program_name` STRING COMMENT 'Descriptive name of the drilling and completion program, typically reflecting the field, block, or development area (e.g., Eagle Ford 2024 Development Campaign, Offshore Block 15 Appraisal Program).',
    `program_number` STRING COMMENT 'Business identifier for the D&C program, typically used in external communications, AFE references, and capital planning documents. Unique across the organization.',
    `program_start_date` DATE COMMENT 'Planned or actual start date of the D&C program, typically aligned with the first well spud date or rig mobilization.',
    `program_status` STRING COMMENT 'Current lifecycle status of the D&C program: planning (pre-AFE), approved (AFE authorized), active (drilling in progress), suspended (temporarily halted), complete (all wells TD and released), cancelled (terminated before completion), or deferred (postponed to future period). [ENUM-REF-CANDIDATE: planning|approved|active|suspended|complete|cancelled|deferred — 7 candidates stripped; promote to reference product]',
    `program_type` STRING COMMENT 'Classification of the D&C program based on its strategic purpose: exploration (wildcat/new play), appraisal (delineation), development (field development), infill (incremental wells in producing field), workover (re-entry), or sidetrack (directional deviation from existing wellbore).. Valid values are `exploration|appraisal|development|infill|workover|sidetrack`',
    `risk_category` STRING COMMENT 'Overall risk classification for the D&C program based on technical complexity, HSE exposure, regulatory environment, and geological uncertainty: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `target_formation` STRING COMMENT 'Primary geological formation or reservoir target for the D&C program (e.g., Wolfcamp A, Tuscaloosa Marine Shale, Niobrara). Used for reserves classification and technical planning.',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Average water depth for offshore programs, expressed in feet. Null for onshore programs. Used for rig selection and cost estimation.',
    `well_trajectory_type` STRING COMMENT 'Predominant well trajectory type planned for the program: vertical (straight hole), directional (deviated), horizontal (lateral section), or multilateral (multiple laterals from single wellbore).. Valid values are `vertical|directional|horizontal|multilateral`',
    CONSTRAINT pk_dc_program PRIMARY KEY(`dc_program_id`)
) COMMENT 'Drilling and Completion (D&C) program master record representing a portfolio-level grouping of wells planned and executed under a single capital program or development campaign. Captures program name, program type (exploration, appraisal, development, infill), field or block name, planned well count, approved total CAPEX, program start and end dates, program manager, and overall program status (planning, active, complete, deferred). Serves as the top-level organizing entity for rig schedules, AFEs, and well programs within a capital investment cycle. Enables portfolio-level D&C performance benchmarking and capital allocation reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`rig_contract` (
    `rig_contract_id` BIGINT COMMENT 'Primary key for the rig_contract association',
    `rig_id` BIGINT COMMENT 'Foreign key linking to the drilling rig master record',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record (drilling contractor or service provider)',
    `contract_end_date` DATE COMMENT 'Scheduled end date of the rig contract period, after which terms may be renegotiated or the contract may be renewed',
    `contract_number` STRING COMMENT 'Unique business identifier for the rig contract agreement, used for reference in procurement and drilling operations systems',
    `contract_start_date` DATE COMMENT 'Effective start date of the rig contract period when the vendor begins providing the rig under the agreed terms',
    `contract_status` STRING COMMENT 'Current status of the rig contract indicating whether it is currently in force, completed, prematurely terminated, or temporarily suspended',
    `contract_type` STRING COMMENT 'Classification of the contractual arrangement defining the basis of payment and risk allocation between operator and contractor',
    `day_rate_usd` DECIMAL(18,2) COMMENT 'Daily operating rate in USD charged by the vendor for the rig while actively drilling, representing the primary cost component of rig contracting',
    `mobilization_fee_usd` DECIMAL(18,2) COMMENT 'One-time fee in USD charged by the vendor for mobilizing the rig to the drilling location at the start of the contract',
    `performance_rating` STRING COMMENT 'Qualitative assessment of the vendors performance in delivering rig services under this specific contract, used for future vendor selection and contract negotiations',
    `standby_rate_usd` DECIMAL(18,2) COMMENT 'Daily rate in USD charged by the vendor when the rig is on standby (not actively drilling but available), typically lower than the operating day rate',
    CONSTRAINT pk_rig_contract PRIMARY KEY(`rig_contract_id`)
) COMMENT 'This association product represents the contractual relationship between a drilling rig and a vendor (drilling contractor or service provider). It captures the commercial terms, performance metrics, and temporal scope of each rig contracting agreement. Each record links one rig to one vendor for a specific contract period with attributes that exist only in the context of this contractual relationship, including day rates, mobilization fees, contract duration, and performance ratings.. Existence Justification: In oil and gas drilling operations, rigs are contracted from multiple vendors over the lifecycle of drilling programs, and vendors (drilling contractors) provide multiple rigs to operators under separate contractual agreements. Each rig-vendor relationship is governed by a distinct contract with specific commercial terms (day rates, standby rates, mobilization fees), temporal scope (contract start/end dates), and performance metrics. The business actively manages these contracts as operational entities, tracking costs, performance, and contract status.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` (
    `afe_vendor_spend_id` BIGINT COMMENT 'Primary key for the afe_vendor_spend association',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key linking to the Authorization for Expenditure record for which this vendor provided services or materials.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record for the supplier or service provider engaged on this AFE.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'The cumulative actual expenditure in USD for this vendor on this AFE, aggregated from invoices and cost postings. Updated as invoices are received and processed. Used for variance analysis and budget control.',
    `contracted_amount_usd` DECIMAL(18,2) COMMENT 'The total contracted or estimated amount in USD for this vendors services or materials on this AFE, as specified in the purchase order or service agreement. Used for budget allocation and vendor commitment tracking.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this AFE-vendor spend record was created in the system, typically when the vendor was first engaged or a purchase order was issued for this AFE.',
    `first_invoice_date` DATE COMMENT 'Date of the first invoice received from this vendor for this AFE. Marks the start of the financial relationship for this AFE-vendor engagement.',
    `invoice_count` STRING COMMENT 'The number of invoices received from this vendor for this AFE. Used for accounts payable tracking and vendor payment processing.',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice received from this vendor for this AFE. Used to track recency of vendor activity and billing cycles.',
    `payment_status` STRING COMMENT 'Current payment status for this vendor on this AFE: pending (no invoices yet), in progress (invoices received, payment processing), paid (all invoices settled), disputed (invoice or payment dispute), on hold (payment suspended). Used for cash flow management and vendor relations.',
    `purchase_order_count` STRING COMMENT 'The number of purchase orders issued to this vendor for this AFE. Tracks procurement activity and vendor engagement complexity.',
    `service_category` STRING COMMENT 'Classification of the type of service or material provided by this vendor for this AFE, aligned with AFE cost categories such as drilling services, completion services, oilfield equipment, cementing, directional services, logging, casing and tubing, mud and chemicals, bits, fuel, catering, or other.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this AFE-vendor spend record, reflecting changes to spend amounts, invoice counts, or payment status.',
    `variance_amount_usd` DECIMAL(18,2) COMMENT 'Calculated variance between contracted amount and actual spend for this vendor on this AFE (actual_spend_usd - contracted_amount_usd). Positive values indicate overruns, negative values indicate underruns. Used for cost control and vendor performance analysis.',
    CONSTRAINT pk_afe_vendor_spend PRIMARY KEY(`afe_vendor_spend_id`)
) COMMENT 'This association product represents the financial relationship between an Authorization for Expenditure (AFE) and the vendors engaged to deliver services or materials for that AFE. It captures the contracted amounts, actual expenditures, purchase order activity, invoicing, and payment status for each vendor working on a specific AFE. Each record links one AFE to one vendor with financial tracking attributes that exist only in the context of this AFE-vendor engagement.. Existence Justification: In oil and gas drilling operations, a single AFE (Authorization for Expenditure) engages multiple vendors simultaneously—drilling contractors, completion service providers, equipment suppliers, cementing companies, directional drilling firms, logging services, and material suppliers. Conversely, each vendor serves multiple AFEs across different wells and projects. The business actively manages the financial relationship between each AFE and each vendor, tracking contracted amounts, actual spend, purchase orders, invoices, and payment status per AFE-vendor combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` (
    `well_zone_completion_id` BIGINT COMMENT 'Unique system identifier for this well-zone completion record. Primary key.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to the drilling well that was completed in this zone',
    `zone_id` BIGINT COMMENT 'Foreign key linking to the reservoir zone accessed by this completion',
    `completion_type` STRING COMMENT 'Type of completion method used to establish production from this zone. Determines flow characteristics and sand control approach.',
    `cumulative_production_boe` DECIMAL(18,2) COMMENT 'Total cumulative production from this zone completion measured in barrels of oil equivalent (BOE). Tracks zone-specific production performance over the life of the completion.',
    `first_production_date` DATE COMMENT 'Date when production from this specific zone completion first began. May differ from well completion date if zones were brought online sequentially or if this is a workover/recompletion.',
    `last_production_date` DATE COMMENT 'Most recent date when production was recorded from this zone completion. Used to identify inactive or shut-in zones.',
    `perforation_interval_bottom_md` DECIMAL(18,2) COMMENT 'Measured depth in feet to the bottom of the perforated interval for this zone completion. Defines the lower boundary of the physical connection between wellbore and zone.',
    `perforation_interval_top_md` DECIMAL(18,2) COMMENT 'Measured depth in feet to the top of the perforated interval for this zone completion. Defines the upper boundary of the physical connection between wellbore and zone.',
    `stimulation_method` STRING COMMENT 'Stimulation treatment applied to this zone completion (e.g., hydraulic fracturing, acidizing, none). Impacts productivity and EUR.',
    `zone_contribution_fraction` DECIMAL(18,2) COMMENT 'Estimated fraction of total well production attributable to this zone, expressed as a decimal (0.0 to 1.0). Used for production allocation and reserves attribution when wells produce from multiple zones simultaneously (commingled production).',
    `zone_status` STRING COMMENT 'Current operational status of this specific zone completion. Tracks lifecycle from planned through active production to shut-in or abandonment. A well may have multiple zones with different statuses.',
    CONSTRAINT pk_well_zone_completion PRIMARY KEY(`well_zone_completion_id`)
) COMMENT 'This association product represents the completion interval between a drilling well and a reservoir zone. It captures the physical connection established when a wellbore is perforated or completed to produce from a specific zone. Each record links one drilling well to one zone with attributes that describe the perforation interval, production contribution, and zone-specific performance metrics. This is a fundamental operational entity in reservoir management, production allocation, and reserves reporting.. Existence Justification: In oil and gas operations, wells routinely produce from multiple reservoir zones simultaneously (commingled production), and each zone is accessed by multiple wells as part of field development strategy. The well-zone completion is a fundamental operational entity that captures the physical perforation interval, production allocation percentages, zone-specific performance, and completion status. This relationship is actively managed by completion engineers and reservoir engineers for production optimization, reserves reporting, and regulatory compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` (
    `well_service_engagement_id` BIGINT COMMENT 'Unique identifier for this well-vendor service engagement record. Primary key.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to the drilling well receiving the service',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing the service',
    `contract_number` STRING COMMENT 'Reference to the master service agreement or purchase order number governing this specific well-vendor engagement. Links to procurement contract management systems.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this well service engagement record was created in the system.',
    `drilling_contractor` STRING COMMENT 'Name of the drilling contractor company that provided the rig and drilling crew for this wellbore. Used for contractor performance tracking and Engineering Procurement and Construction (EPC) contract management. [Moved from drilling_well: The drilling_contractor attribute in drilling_well is a STRING field containing the contractor company name. This represents ONE specific vendor relationship (the drilling contractor) but should be modeled as a well_service_engagement record with service_type=drilling contractor. This allows proper referential integrity to the vendor master, tracks contract details, service period, costs, and performance rating. The current STRING field prevents proper vendor analytics and violates normalization principles.]',
    `performance_rating` STRING COMMENT 'Post-service performance evaluation of the vendors service delivery on this well. Used for vendor qualification, future bid evaluations, and continuous improvement. Ratings typically assess HSE performance, quality, schedule adherence, and cost management.',
    `service_end_date` DATE COMMENT 'Date when the vendor completed or demobilized from service delivery for this well. For drilling contractors, typically aligns with rig release date. May be null for ongoing services.',
    `service_start_date` DATE COMMENT 'Date when the vendor commenced service delivery for this well. For drilling contractors, typically aligns with spud date or rig mobilization. For other services, represents the date service operations began.',
    `service_type` STRING COMMENT 'Classification of the service provided by the vendor to the well. Examples include drilling contractor, cementing, completion services, mud services, directional drilling, wireline, coiled tubing, stimulation, workover, and P&A services. A single well typically engages multiple vendors for different service types.',
    `total_service_value_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for this vendors services on this specific well, expressed in USD. Represents actual costs invoiced and paid, used for well cost accounting and AFE reconciliation.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this well service engagement record was last modified.',
    CONSTRAINT pk_well_service_engagement PRIMARY KEY(`well_service_engagement_id`)
) COMMENT 'This association product represents the service engagement contract between a drilling well and a vendor. It captures the specific services provided by each vendor to each well throughout the drilling, completion, and workover lifecycle. Each record links one drilling well to one vendor with attributes that exist only in the context of this service relationship, including service type, contract reference, service period, costs, and performance metrics.. Existence Justification: In oil and gas drilling operations, each well engages multiple specialized vendors throughout its lifecycle (drilling contractor, cementing services, directional drilling, wireline, mud services, completion services, etc.), and each vendor serves multiple wells across the operators portfolio. The business actively manages these service engagements as operational contracts, tracking service type, contract reference, service period, costs, and performance ratings for each well-vendor combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`afe_election` (
    `afe_election_id` BIGINT COMMENT 'Unique identifier for this AFE election record. Primary key.',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key linking to the AFE for which this election applies',
    `land_working_interest_id` BIGINT COMMENT 'Foreign key linking to the working interest owner making the election',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual costs incurred and allocated to this working interest owner for this AFE as of the current date. Updated as AFE costs are posted.',
    `afe_election_status` STRING COMMENT 'Current status of the working interest owners election decision for this AFE. Tracks whether the owner has consented to participate, elected non-consent, or been forced pooled.',
    `billing_status` STRING COMMENT 'Current billing and payment status for this working interest owners share of AFE costs. Tracks JIB invoice lifecycle.',
    `consent_flag` BOOLEAN COMMENT 'Boolean indicator of whether the working interest owner consented to participate in this AFE. True = consented (cost-bearing), False = non-consented (may forfeit interest or be penalized per JOA terms).',
    `cost_allocation_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of AFE costs allocated to this working interest owner based on their participating percentage and the AFE approved budget. Used for JIB billing.',
    `election_date` DATE COMMENT 'Date on which the working interest owner submitted their consent or non-consent election for this AFE. Used to enforce JOA election deadlines.',
    `election_received_by` STRING COMMENT 'Name or identifier of the operator representative who received and recorded the working interest owners election.',
    `forced_pooling_flag` BOOLEAN COMMENT 'Indicates whether this working interest owners participation is the result of forced pooling or compulsory integration by regulatory authority rather than voluntary election.',
    `jib_invoice_reference` STRING COMMENT 'Reference number of the Joint Interest Billing invoice issued to this working interest owner for their share of AFE costs.',
    `non_consent_penalty_rate` DECIMAL(18,2) COMMENT 'Penalty multiplier applied to non-consenting working interest owners per JOA terms (e.g., 300% = 3.0). Non-consenting parties may pay a penalty to regain their interest after payout.',
    `notes` STRING COMMENT 'Free-text notes regarding special conditions, disputes, or clarifications related to this working interest owners AFE election.',
    `participating_percentage` DECIMAL(18,2) COMMENT 'The percentage of AFE costs this working interest owner has elected to bear. May differ from their WI decimal if they elect partial participation or non-consent provisions apply.',
    `payment_due_date` DATE COMMENT 'Date by which the working interest owner must pay their allocated share of AFE costs per JOA payment terms.',
    CONSTRAINT pk_afe_election PRIMARY KEY(`afe_election_id`)
) COMMENT 'This association product represents the participation decision and cost allocation between an AFE and a working interest owner. It captures the consent/non-consent election, participating percentage, cost allocation, and billing status for each working interest owners participation in a specific AFE. Each record links one AFE to one working interest owner with attributes that exist only in the context of this AFE-WI relationship.. Existence Justification: In oil and gas joint venture operations, a single AFE authorizes expenditures that multiple working interest owners must elect to participate in (consent or non-consent), and each working interest owner participates in multiple AFEs over time across different wells and projects. The AFE Election is a recognized operational business process governed by Joint Operating Agreements (JOA) and COPAS standards, where operators must track each WI owners consent decision, participating percentage, cost allocation, and billing status for every AFE issued.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` (
    `program_reservoir_allocation_id` BIGINT COMMENT 'Unique identifier for this program-reservoir allocation record. Primary key.',
    `dc_program_id` BIGINT COMMENT 'Foreign key linking to the D&C program under which this reservoir is being developed',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to the target reservoir being developed under this program',
    `actual_capex_usd` DECIMAL(18,2) COMMENT 'Actual capital expenditure incurred for drilling and completing wells in this reservoir under this program to date.',
    `actual_well_count_for_reservoir` STRING COMMENT 'Actual number of wells drilled into this reservoir under this program to date. Updated as wells are spudded.',
    `allocated_capex_usd` DECIMAL(18,2) COMMENT 'Capital expenditure budget allocated to drilling and completing wells in this reservoir under this program. Subset of the programs total approved CAPEX.',
    `allocation_date` DATE COMMENT 'Date when this reservoir was added to the D&C program and budget allocation was made.',
    `allocation_status` STRING COMMENT 'Current status of this program-reservoir allocation: planned (pre-AFE), approved (AFE approved), active (drilling underway), complete (all wells drilled), cancelled (allocation removed).',
    `development_priority` STRING COMMENT 'Priority ranking for developing this reservoir within the program: high (drill first), medium (drill mid-program), low (drill if budget allows), deferred (postponed to future program).',
    `drilling_sequence` STRING COMMENT 'Planned sequence order for drilling wells into this reservoir within the program. Used for rig scheduling and logistics planning.',
    `notes` STRING COMMENT 'Free-text notes capturing rationale for allocation, geological considerations, or operational constraints specific to developing this reservoir under this program.',
    `planned_well_count_for_reservoir` STRING COMMENT 'Number of wells planned to be drilled into this specific reservoir under this D&C program. Subset of the programs total planned well count.',
    `target_completion_date` DATE COMMENT 'Planned date for completing the last well into this reservoir under this program.',
    `target_eur_mmboe` DECIMAL(18,2) COMMENT 'Target estimated ultimate recovery in million barrels of oil equivalent expected from wells drilled into this reservoir under this program. Used for capital allocation and portfolio optimization.',
    `target_start_date` DATE COMMENT 'Planned date for spudding the first well into this reservoir under this program.',
    CONSTRAINT pk_program_reservoir_allocation PRIMARY KEY(`program_reservoir_allocation_id`)
) COMMENT 'This association product represents the capital allocation and drilling plan between a D&C program and a target reservoir. It captures the per-reservoir well count, allocated budget, target reserves, development priority, and drilling sequence within a multi-reservoir drilling campaign. Each record links one dc_program to one reservoir with attributes that exist only in the context of this specific program-reservoir development plan.. Existence Justification: In oil and gas capital planning, D&C programs routinely target multiple reservoirs across a field or basin (e.g., a Permian development program drilling into Wolfcamp A, Wolfcamp B, and Bone Spring reservoirs), and individual reservoirs are developed through multiple drilling campaigns over time (e.g., initial exploration program, appraisal program, full-field development program, infill program). The business actively manages per-reservoir allocations within each program, tracking planned well counts, allocated budgets, target reserves, development priorities, and drilling sequences.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` (
    `well_unit_participation_id` BIGINT COMMENT 'Unique system identifier for this well-unit participation record. Primary key.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to the drilling well participating in this pooling unit',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to the pooling unit in which this well participates',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of production, costs, or revenues allocated to this well within the pooling unit. Used for proportional allocation calculations in joint interest billing and regulatory reporting. Identified in detection phase as relationship-specific data.',
    `cost_bearing_flag` BOOLEAN COMMENT 'Indicates whether this well-unit participation bears drilling and completion costs under the unit agreement. Used in joint interest billing calculations. Identified in detection phase as relationship-specific data.',
    `created_date` TIMESTAMP COMMENT 'System timestamp when this participation record was created.',
    `effective_date` DATE COMMENT 'Date on which this well-unit participation relationship became effective, typically aligned with regulatory approval or unit agreement execution. Identified in detection phase as relationship-specific data.',
    `formation_allocation_flag` BOOLEAN COMMENT 'Indicates whether this participation is specific to a particular formation or zone within a multi-zone pooling unit. True for formation-specific allocations in multi-zone completions.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Companys net revenue interest percentage specific to this well-unit participation after royalty and overriding royalty burdens.',
    `participating_area_acres` DECIMAL(18,2) COMMENT 'Acreage attributed to this specific well within the pooling unit for allocation purposes. May differ from gross unit acres when multiple wells participate. Identified in detection phase as relationship-specific data.',
    `participation_status` STRING COMMENT 'Current status of this well-unit participation relationship. Active participations are used in allocation calculations; suspended or terminated participations are historical.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory order or approval document authorizing this well to participate in the pooling unit, if required by state regulations.',
    `revenue_allocation_method` STRING COMMENT 'Method used to allocate production revenues for this well-unit participation. Common methods include surface acreage, subsurface acreage, well count, production-based, or custom formulas defined in the unit agreement. Identified in detection phase as relationship-specific data.',
    `termination_date` DATE COMMENT 'Date on which this well-unit participation relationship terminated, if applicable. Null for active participations.',
    `updated_date` TIMESTAMP COMMENT 'System timestamp when this participation record was last updated.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Companys working interest percentage specific to this well-unit participation, which may differ from the overall unit working interest if participation varies by well.',
    CONSTRAINT pk_well_unit_participation PRIMARY KEY(`well_unit_participation_id`)
) COMMENT 'This association product represents the participation relationship between a drilling well and a pooling unit in oil and gas operations. It captures the allocation of production, costs, and revenues when a well participates in one or more pooling units, or when a pooling unit contains multiple wells. Each record links one drilling well to one pooling unit with attributes that govern cost-bearing obligations, revenue allocation, and participating acreage specific to that well-unit combination. This is a core operational record required for regulatory compliance, royalty calculation, and joint interest billing.. Existence Justification: In oil and gas operations, a single drilling well can participate in multiple pooling units when it produces from multiple formations or zones that are subject to different unitization agreements (multi-zone completions), and a single pooling unit typically contains multiple wells drilled to develop the pooled acreage. The business actively manages well-unit participation records to track allocation percentages, cost-bearing obligations, revenue distribution methods, and participating acreage for each well-unit combination, which are essential for regulatory compliance, joint interest billing, and royalty calculations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`operator` (
    `operator_id` BIGINT COMMENT 'Primary key for operator',
    `parent_operator_id` BIGINT COMMENT 'Identifier of the parent organization if the operator is a subsidiary.',
    `address_line1` STRING COMMENT 'Primary street address of the operators headquarters.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual revenue in the functional currency.',
    `bse_regulation_compliance` STRING COMMENT 'Operators compliance status with BSEE offshore drilling regulations.',
    `city` STRING COMMENT 'City of the operators headquarters.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the operators headquarters.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the operator record was first created.',
    `currency` STRING COMMENT 'ISO 4217 currency code used for the operators financial reporting.',
    `date_established` DATE COMMENT 'Date the operator entity was legally established.',
    `date_terminated` DATE COMMENT 'Date the operator ceased operations, if applicable.',
    `operator_description` STRING COMMENT 'Free‑form description of the operators business activities and scope.',
    `employee_count` STRING COMMENT 'Total number of employees employed by the operator.',
    `environmental_compliance_status` STRING COMMENT 'Current status of the operators compliance with environmental regulations.',
    `financial_rating` STRING COMMENT 'External credit rating (e.g., S&P, Moodys) of the operator.',
    `industry_classification_code` STRING COMMENT 'North American Industry Classification System code for the operator.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum liability coverage amount held by the operator.',
    `license_number` STRING COMMENT 'Regulatory license number authorizing drilling operations.',
    `operator_name` STRING COMMENT 'Legal name of the operating company.',
    `operational_status` STRING COMMENT 'Current operational condition of the operators drilling assets.',
    `operator_code` STRING COMMENT 'Business-assigned alphanumeric code used to reference the operator in external systems.',
    `operator_type` STRING COMMENT 'Category describing the business model of the operator.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the operators headquarters.',
    `primary_contact_email` STRING COMMENT 'Email address for the primary contact.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary point‑of‑contact for the operator.',
    `primary_contact_phone` STRING COMMENT 'Telephone number for the primary contact.',
    `primary_contact_role` STRING COMMENT 'Job title or function of the primary contact within the operator organization.',
    `registration_number` STRING COMMENT 'Official registration number with the jurisdictional authority.',
    `safety_incident_count` STRING COMMENT 'Number of reportable safety incidents recorded for the operator in the past year.',
    `state_province` STRING COMMENT 'State or province of the operators headquarters.',
    `operator_status` STRING COMMENT 'Current lifecycle state of the operator record.',
    `tax_number` STRING COMMENT 'Government‑issued tax identifier for the operator (e.g., EIN, VAT).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the operator record.',
    `website_url` STRING COMMENT 'Public website address of the operator.',
    CONSTRAINT pk_operator PRIMARY KEY(`operator_id`)
) COMMENT 'Master reference table for operator. Referenced by operator_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`wellbore` (
    `wellbore_id` BIGINT COMMENT 'Primary key for wellbore',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: A wellbore is a child of a drilling well; linking provides proper hierarchy and eliminates duplicated well‑level attributes stored in wellbore.',
    `permit_id` BIGINT COMMENT 'FK to compliance.permit',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig assigned to the wellbore.',
    `parent_wellbore_id` BIGINT COMMENT 'Self-referencing FK on wellbore (parent_wellbore_id)',
    `abandonment_date` DATE COMMENT 'Date when the wellbore was officially abandoned.',
    `abandonment_status` STRING COMMENT 'Current status of the abandonment process.',
    `actual_production_rate_bbl_per_day` DECIMAL(18,2) COMMENT 'Measured oil production rate.',
    `bop_certified` BOOLEAN COMMENT 'Indicates whether the Blowout Preventer is certified for the wellbore.',
    `casing_depth_m` DECIMAL(18,2) COMMENT 'Depth at which the casing is set.',
    `casing_size_inch` DECIMAL(18,2) COMMENT 'Nominal outer diameter of the casing.',
    `casing_type` STRING COMMENT 'Classification of the casing string.',
    `cost_actual_usd` DECIMAL(18,2) COMMENT 'Actual incurred cost for drilling and completion in US dollars.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated drilling and completion cost in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wellbore record was created in the system.',
    `drilling_phase` STRING COMMENT 'Lifecycle phase of the drilling operation.',
    `expected_production_rate_bbl_per_day` DECIMAL(18,2) COMMENT 'Projected oil production rate.',
    `horizontal_length_m` DECIMAL(18,2) COMMENT 'Length of the horizontal section of the wellbore, if applicable.',
    `last_production_date` DATE COMMENT 'Most recent date on which production was recorded.',
    `measured_total_depth_m` DECIMAL(18,2) COMMENT 'Actual measured depth reached during drilling, expressed in meters.',
    `mud_type` STRING COMMENT 'Type of drilling fluid used.',
    `mud_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of mud pumped during drilling.',
    `mud_weight_kg_per_m3` DECIMAL(18,2) COMMENT 'Density of the drilling mud.',
    `planned_total_depth_m` DECIMAL(18,2) COMMENT 'Engineered target total depth for the wellbore, expressed in meters.',
    `regulatory_status` STRING COMMENT 'Current compliance status with drilling regulations.',
    `spud_latitude` DOUBLE COMMENT 'Latitude coordinate of the spud location.',
    `spud_longitude` DOUBLE COMMENT 'Longitude coordinate of the spud location.',
    `torque_drag_analysis_flag` BOOLEAN COMMENT 'Flag indicating if torque and drag analysis was completed.',
    `true_vertical_depth_m` DECIMAL(18,2) COMMENT 'Vertical distance from surface to the deepest point of the wellbore.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the wellbore record.',
    `water_depth_m` DECIMAL(18,2) COMMENT 'Depth of water at the offshore location.',
    `wellbore_category` STRING COMMENT 'Geographic context of the wellbore.',
    `wellbore_classification` STRING COMMENT 'Business purpose of the wellbore.',
    `wellbore_name` STRING COMMENT 'Human‑readable name or label for the wellbore.',
    `wellbore_status` STRING COMMENT 'Current operational status of the wellbore.',
    `wellbore_type` STRING COMMENT 'Geometric classification of the wellbore.',
    CONSTRAINT pk_wellbore PRIMARY KEY(`wellbore_id`)
) COMMENT 'Master reference table for wellbore. Referenced by wellbore_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`drilling`.`field` (
    `field_id` BIGINT COMMENT 'Primary key for field',
    `operator_id` BIGINT COMMENT 'FK to drilling.operator',
    `api_field_number` STRING COMMENT 'American Petroleum Institute (API) field identification number.',
    `basin` STRING COMMENT 'Geological basin in which the field is located.',
    `bsee_permit_number` STRING COMMENT 'Permit number issued by the Bureau of Safety and Environmental Enforcement.',
    `cost_actual_usd` DECIMAL(18,2) COMMENT 'Actual capital expenditures incurred to date, in US dollars.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Projected total capital cost for field development, in US dollars.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the field resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the field record was first created in the system.',
    `cumulative_production_boe` DECIMAL(18,2) COMMENT 'Total hydrocarbons produced to date, expressed in barrels of oil equivalent.',
    `decommissioned_flag` BOOLEAN COMMENT 'Indicates whether the field has been fully decommissioned.',
    `decommissioning_date` DATE COMMENT 'Date when decommissioning activities were completed.',
    `depth_avg_m` DECIMAL(18,2) COMMENT 'Average true vertical depth of the reservoir, in metres.',
    `depth_max_m` DECIMAL(18,2) COMMENT 'Maximum true vertical depth encountered in the field, in metres.',
    `field_description` STRING COMMENT 'Free‑form textual description of the field, its geology, and operational highlights.',
    `development_phase` STRING COMMENT 'Current phase of field development.',
    `discovery_date` DATE COMMENT 'Date the field was first discovered.',
    `environmental_status` STRING COMMENT 'Current environmental compliance status of the field.',
    `field_area_sqkm` DECIMAL(18,2) COMMENT 'Surface area covered by the field, expressed in square kilometres.',
    `field_category` STRING COMMENT 'Primary hydrocarbon product(s) produced by the field.',
    `field_classification` STRING COMMENT 'Technical classification of the fields reservoir type.',
    `field_code` STRING COMMENT 'External business code or alphanumeric identifier assigned to the field (e.g., internal catalog or API code).',
    `field_owner` STRING COMMENT 'Legal owner of the field assets.',
    `field_risk_rating` STRING COMMENT 'Risk rating based on operational, environmental, and financial factors.',
    `field_status` STRING COMMENT 'Current operational status of the field.',
    `field_status_date` DATE COMMENT 'Date when the current field status became effective.',
    `field_type` STRING COMMENT 'Indicates whether the field is onshore or offshore.',
    `first_production_date` DATE COMMENT 'Date of first commercial hydrocarbon production from the field.',
    `fiscal_year` STRING COMMENT 'Fiscal year associated with cost and production reporting.',
    `joint_venture_partners` STRING COMMENT 'Comma‑separated list of joint‑venture partners sharing ownership.',
    `lease_number` STRING COMMENT 'Legal lease or concession number governing the field.',
    `field_name` STRING COMMENT 'Human‑readable name of the field as used in reports and operations.',
    `notes` STRING COMMENT 'Additional remarks, observations, or special instructions related to the field.',
    `number_of_wells` STRING COMMENT 'Total count of active and shut‑in wells within the field.',
    `peak_production_date` DATE COMMENT 'Date on which the peak production rate was recorded.',
    `peak_production_rate_bopd` DECIMAL(18,2) COMMENT 'Maximum daily oil production rate achieved, measured in barrels of oil per day.',
    `region` STRING COMMENT 'Operational region or area name for the field.',
    `regulatory_status` STRING COMMENT 'Regulatory approval status with the relevant authority (e.g., BSEE).',
    `state_province` STRING COMMENT 'State or province name (or equivalent administrative area).',
    `total_estimated_reserves_boe` DECIMAL(18,2) COMMENT 'Estimated ultimate recoverable reserves for the field, expressed in barrels of oil equivalent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the field record.',
    `water_depth_m` DECIMAL(18,2) COMMENT 'Average water depth for offshore fields, in metres.',
    CONSTRAINT pk_field PRIMARY KEY(`field_id`)
) COMMENT 'Master reference table for field. Referenced by field_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`drilling`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_parent_wellbore_drilling_well_id` FOREIGN KEY (`parent_wellbore_drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_dc_program_id` FOREIGN KEY (`dc_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`dc_program`(`dc_program_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_dc_program_id` FOREIGN KEY (`dc_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`dc_program`(`dc_program_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_well_program_id` FOREIGN KEY (`well_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_program`(`well_program_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_bit_run_id` FOREIGN KEY (`bit_run_id`) REFERENCES `oil_gas_ecm`.`drilling`.`bit_run`(`bit_run_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ADD CONSTRAINT `fk_drilling_bha_configuration_bit_run_id` FOREIGN KEY (`bit_run_id`) REFERENCES `oil_gas_ecm`.`drilling`.`bit_run`(`bit_run_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ADD CONSTRAINT `fk_drilling_bha_configuration_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_wellbore_id` FOREIGN KEY (`wellbore_id`) REFERENCES `oil_gas_ecm`.`drilling`.`wellbore`(`wellbore_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_bit_run_id` FOREIGN KEY (`bit_run_id`) REFERENCES `oil_gas_ecm`.`drilling`.`bit_run`(`bit_run_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ADD CONSTRAINT `fk_drilling_mwd_lwd_log_bit_run_id` FOREIGN KEY (`bit_run_id`) REFERENCES `oil_gas_ecm`.`drilling`.`bit_run`(`bit_run_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ADD CONSTRAINT `fk_drilling_mwd_lwd_log_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_casing_design_id` FOREIGN KEY (`casing_design_id`) REFERENCES `oil_gas_ecm`.`drilling`.`casing_design`(`casing_design_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ADD CONSTRAINT `fk_drilling_bop_certification_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ADD CONSTRAINT `fk_drilling_bop_certification_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_completion_design_id` FOREIGN KEY (`completion_design_id`) REFERENCES `oil_gas_ecm`.`drilling`.`completion_design`(`completion_design_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_completion_design_id` FOREIGN KEY (`completion_design_id`) REFERENCES `oil_gas_ecm`.`drilling`.`completion_design`(`completion_design_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_perforation_job_id` FOREIGN KEY (`perforation_job_id`) REFERENCES `oil_gas_ecm`.`drilling`.`perforation_job`(`perforation_job_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_well_permit_id` FOREIGN KEY (`well_permit_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_permit`(`well_permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ADD CONSTRAINT `fk_drilling_mud_program_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ADD CONSTRAINT `fk_drilling_mud_program_well_program_id` FOREIGN KEY (`well_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_program`(`well_program_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`drilling`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_well_program_id` FOREIGN KEY (`well_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_program`(`well_program_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ADD CONSTRAINT `fk_drilling_rig_contract_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ADD CONSTRAINT `fk_drilling_afe_vendor_spend_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ADD CONSTRAINT `fk_drilling_well_zone_completion_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ADD CONSTRAINT `fk_drilling_well_service_engagement_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ADD CONSTRAINT `fk_drilling_afe_election_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ADD CONSTRAINT `fk_drilling_program_reservoir_allocation_dc_program_id` FOREIGN KEY (`dc_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`dc_program`(`dc_program_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ADD CONSTRAINT `fk_drilling_well_unit_participation_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ADD CONSTRAINT `fk_drilling_operator_parent_operator_id` FOREIGN KEY (`parent_operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ADD CONSTRAINT `fk_drilling_wellbore_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ADD CONSTRAINT `fk_drilling_wellbore_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ADD CONSTRAINT `fk_drilling_wellbore_parent_wellbore_id` FOREIGN KEY (`parent_wellbore_id`) REFERENCES `oil_gas_ecm`.`drilling`.`wellbore`(`wellbore_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`field` ADD CONSTRAINT `fk_drilling_field_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`drilling` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`drilling` SET TAGS ('dbx_domain' = 'drilling');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `block_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `norm_record_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `parent_wellbore_drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `rig_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `authorized_afe_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Authorized Authorization for Expenditure (AFE) Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `authorized_afe_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bop_test_date` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Test Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Latitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Longitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `casing_program_design` SET TAGS ('dbx_business_glossary_term' = 'Casing Program Design Description');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Well Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `directional_drilling_flag` SET TAGS ('dbx_business_glossary_term' = 'Directional Drilling Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `drilling_days_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `drilling_days_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `dst_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Performed Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `initial_production_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `initial_production_bopd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `initial_production_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `initial_production_mcfd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `mud_system_type` SET TAGS ('dbx_business_glossary_term' = 'Drilling Mud System Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `mud_system_type` SET TAGS ('dbx_value_regex' = 'water_based|oil_based|synthetic_based|foam|air');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `mwd_lwd_vendor` SET TAGS ('dbx_business_glossary_term' = 'Measurement While Drilling (MWD) and Logging While Drilling (LWD) Vendor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `plugged_abandoned_date` SET TAGS ('dbx_business_glossary_term' = 'Plugged and Abandoned (P&A) Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal_offshore|state_onshore|state_offshore|tribal|private');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `rig_release_date` SET TAGS ('dbx_business_glossary_term' = 'Rig Release Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `target_formation` SET TAGS ('dbx_business_glossary_term' = 'Target Geological Formation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `total_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Total Depth (TD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `total_drilling_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Drilling Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `total_drilling_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `trajectory_type` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Trajectory Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `trajectory_type` SET TAGS ('dbx_value_regex' = 'vertical|directional|horizontal|multilateral|extended_reach');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `well_class` SET TAGS ('dbx_business_glossary_term' = 'Well Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `well_class` SET TAGS ('dbx_value_regex' = 'oil|gas|gas_condensate|dry_hole|suspended|unknown');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `well_status` SET TAGS ('dbx_business_glossary_term' = 'Well Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ALTER COLUMN `well_type` SET TAGS ('dbx_business_glossary_term' = 'Well Type Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `well_program_id` SET TAGS ('dbx_business_glossary_term' = 'Well Program Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `dc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling and Completion (D&C) Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Well Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Program Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Program Approved By');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `bop_configuration` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Configuration');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `bop_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Rating (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `casing_design_summary` SET TAGS ('dbx_business_glossary_term' = 'Casing Design Summary');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `cementing_program_summary` SET TAGS ('dbx_business_glossary_term' = 'Cementing Program Summary');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `co2_present` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Present');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `completion_strategy` SET TAGS ('dbx_business_glossary_term' = 'Completion Strategy');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `completion_strategy` SET TAGS ('dbx_value_regex' = 'openhole|cased_hole|liner|gravel_pack|frac_pack|intelligent_completion');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Program Created Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `depth_uom` SET TAGS ('dbx_business_glossary_term' = 'Depth Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `depth_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `drilling_method` SET TAGS ('dbx_business_glossary_term' = 'Drilling Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `drilling_method` SET TAGS ('dbx_value_regex' = 'rotary|top_drive|coiled_tubing|underbalanced|managed_pressure');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `dst_planned` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Planned');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `environmental_disposal_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Disposal Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `environmental_disposal_classification` SET TAGS ('dbx_value_regex' = 'non_hazardous|hazardous|special_waste|offshore_discharge_permitted');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `estimated_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `estimated_drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `h2s_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration (PPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `h2s_present` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Present');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `hpht_classification` SET TAGS ('dbx_business_glossary_term' = 'High Pressure High Temperature (HPHT) Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `hpht_classification` SET TAGS ('dbx_value_regex' = 'standard|hpht|extreme_hpht|not_applicable');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Program Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `max_anticipated_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Anticipated Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `max_anticipated_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Maximum Anticipated Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `max_dogleg_severity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dogleg Severity');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `max_inclination_angle` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inclination Angle');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mud_system_type` SET TAGS ('dbx_business_glossary_term' = 'Mud System Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mud_system_type` SET TAGS ('dbx_value_regex' = 'water_based|oil_based|synthetic_based|pneumatic');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mud_weight_max` SET TAGS ('dbx_business_glossary_term' = 'Mud Weight Maximum');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mud_weight_min` SET TAGS ('dbx_business_glossary_term' = 'Mud Weight Minimum');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mud_weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Mud Weight Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mud_weight_uom` SET TAGS ('dbx_value_regex' = 'ppg|sg|kg_m3');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `mwd_lwd_program` SET TAGS ('dbx_business_glossary_term' = 'Measurement While Drilling (MWD) Logging While Drilling (LWD) Program');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `planned_td_md` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth (TD) Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `planned_td_tvd` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth (TD) True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Well Program Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Well Program Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Well Program Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Well Program Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'drilling|completion|workover|sidetrack|plug_and_abandonment|recompletion');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Program Revision Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Program Revision Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `rig_type_required` SET TAGS ('dbx_business_glossary_term' = 'Rig Type Required');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `rig_type_required` SET TAGS ('dbx_value_regex' = 'land|jackup|semisubmersible|drillship|platform');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `target_formation` SET TAGS ('dbx_business_glossary_term' = 'Target Formation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `well_trajectory_type` SET TAGS ('dbx_business_glossary_term' = 'Well Trajectory Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ALTER COLUMN `well_trajectory_type` SET TAGS ('dbx_value_regex' = 'vertical|directional|horizontal|extended_reach|multilateral');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `contractor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Carrier Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `accommodation_capacity` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Capacity');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `active_heave_compensation` SET TAGS ('dbx_business_glossary_term' = 'Active Heave Compensation (AHC)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `active_heave_compensation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `active_heave_compensation` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `api_rig_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Rig Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `bop_pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Pressure Rating (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `bop_stack_configuration` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Stack Configuration');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `bsee_rig_code` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `build_year` SET TAGS ('dbx_business_glossary_term' = 'Build Year');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `current_location` SET TAGS ('dbx_business_glossary_term' = 'Current Location');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `derrick_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Derrick Height (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `drawworks_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Drawworks Horsepower (HP)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `dynamic_positioning_class` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Positioning (DP) Class');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `dynamic_positioning_class` SET TAGS ('dbx_value_regex' = 'DP0|DP1|DP2|DP3|not_applicable');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `hook_load_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Hook Load Capacity (Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `hse_rating` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Rating');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `last_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `max_drilling_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Drilling Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `mud_pump_capacity_hp` SET TAGS ('dbx_business_glossary_term' = 'Mud Pump Capacity (Horsepower)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `next_certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Due Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `operating_region` SET TAGS ('dbx_business_glossary_term' = 'Operating Region');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|contracted|leased|joint_venture');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rated_water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Rated Water Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `registration_flag` SET TAGS ('dbx_business_glossary_term' = 'Rig Registration Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `registration_flag` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rig_class` SET TAGS ('dbx_business_glossary_term' = 'Rig Class');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rig_name` SET TAGS ('dbx_business_glossary_term' = 'Rig Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rig_number` SET TAGS ('dbx_business_glossary_term' = 'Rig Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rig_type` SET TAGS ('dbx_business_glossary_term' = 'Rig Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rig_type` SET TAGS ('dbx_value_regex' = 'land|jackup|semi-submersible|drillship|platform|barge');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `rotary_table_size_in` SET TAGS ('dbx_business_glossary_term' = 'Rotary Table Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `top_drive_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Top Drive Capacity (Tons)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `total_recordable_incident_rate` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ALTER COLUMN `variable_deck_load_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Variable Deck Load (VDL) Capacity (Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `rig_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Schedule Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `dc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling and Completion (D&C) Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Superintendent Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `well_program_id` SET TAGS ('dbx_business_glossary_term' = 'Well Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_rig_move_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Rig Move End Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_rig_move_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Rig Move Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_rig_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Rig Release Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `actual_td_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Depth (TD) Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `npt_days` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Operations Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `permit_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Permit Delay Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_completion_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_rig_move_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Rig Move End Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_rig_move_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Rig Move Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_rig_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Rig Release Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `planned_td_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth (TD) Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `rig_move_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Rig Move Duration (Days)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Rig Schedule Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_priority` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Revision Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rig Schedule Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `simops_coordination_notes` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Coordination Notes');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `simops_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `standby_days` SET TAGS ('dbx_business_glossary_term' = 'Standby Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `weather_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Weather Delay Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Partner Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `rig_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `actual_drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `actual_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `actual_total_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Depth (TD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `afe_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `afe_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `afe_type` SET TAGS ('dbx_value_regex' = 'drilling|workover|completion|recompletion|sidetrack|plug_and_abandonment');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `approver_title` SET TAGS ('dbx_business_glossary_term' = 'Approver Title');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `authorization_basis` SET TAGS ('dbx_business_glossary_term' = 'Authorization Basis');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `cumulative_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Actual Cost');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `drilling_program_description` SET TAGS ('dbx_business_glossary_term' = 'Drilling Program Description');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `estimated_drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Drilling Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `estimated_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `estimated_total_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Depth (TD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `jib_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `non_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `over_budget_flag` SET TAGS ('dbx_business_glossary_term' = 'Over Budget Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `rig_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Rig Contractor Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `rig_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `rig_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `rig_day_rate` SET TAGS ('dbx_business_glossary_term' = 'Rig Day Rate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `daily_drilling_report_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Drilling Report (DDR) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `bit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `afe_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Variance (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `afe_variance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `bit_depth_in_ft` SET TAGS ('dbx_business_glossary_term' = 'Bit Depth In (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `bit_depth_out_ft` SET TAGS ('dbx_business_glossary_term' = 'Bit Depth Out (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `bop_test_date` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Test Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `bop_test_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Test Pressure (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `crew_on_board_count` SET TAGS ('dbx_business_glossary_term' = 'Crew on Board Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `cumulative_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Cost (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `cumulative_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `daily_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Daily Cost (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `daily_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `depth_drilled_ft` SET TAGS ('dbx_business_glossary_term' = 'Depth Drilled (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `equivalent_circulating_density_ppg` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Circulating Density (ECD) (ppg)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (gpm)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `formation_top_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Formation Top Depth (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `formation_top_encountered` SET TAGS ('dbx_business_glossary_term' = 'Formation Top Encountered');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `hookload_klbs` SET TAGS ('dbx_business_glossary_term' = 'Hookload (klbs)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `hse_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incidents Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `mud_type` SET TAGS ('dbx_business_glossary_term' = 'Mud Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `mud_type` SET TAGS ('dbx_value_regex' = 'water_based|oil_based|synthetic_based|foam|air');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `mud_viscosity_seconds` SET TAGS ('dbx_business_glossary_term' = 'Mud Viscosity (seconds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `mud_weight_ppg` SET TAGS ('dbx_business_glossary_term' = 'Mud Weight (ppg)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `non_productive_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) (hours)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `npt_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `operations_summary` SET TAGS ('dbx_business_glossary_term' = 'Operations Summary');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `productive_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Productive Time (hours)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `rate_of_penetration_ft_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Rate of Penetration (ROP) (ft/hr)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `rotary_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Rotary Speed (RPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `standpipe_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Standpipe Pressure (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `torque_ft_lbs` SET TAGS ('dbx_business_glossary_term' = 'Torque (ft-lbs)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ALTER COLUMN `weight_on_bit_klbs` SET TAGS ('dbx_business_glossary_term' = 'Weight on Bit (WOB) (klbs)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `npt_event_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Event ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Person ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `bsee_incident_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Incident Notification Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `bsee_incident_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged|under_investigation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `bsee_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Incident Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `estimated_cost_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `estimated_cost_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `event_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Event Subcategory');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `iadc_npt_code` SET TAGS ('dbx_business_glossary_term' = 'International Association of Drilling Contractors (IADC) Non-Productive Time (NPT) Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `kill_method` SET TAGS ('dbx_business_glossary_term' = 'Kill Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `kill_method` SET TAGS ('dbx_value_regex' = 'drillers_method|wait_and_weight|concurrent|volumetric|bullheading|dynamic_kill');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `kill_mud_weight_ppg` SET TAGS ('dbx_business_glossary_term' = 'Kill Mud Weight Pounds per Gallon (PPG)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `operator_npt_code` SET TAGS ('dbx_business_glossary_term' = 'Operator Non-Productive Time (NPT) Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `pit_gain_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Pit Gain Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `preventability_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventability Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|closed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'operator|drilling_contractor|service_provider|third_party|force_majeure');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `rig_system_involved` SET TAGS ('dbx_business_glossary_term' = 'Rig System Involved');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `sicp_psi` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Casing Pressure (SICP) Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `sidpp_psi` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Drill Pipe Pressure (SIDPP) Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ALTER COLUMN `well_control_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bha_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Assembly (BHA) Configuration ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bit Run ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bha_number` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Assembly (BHA) Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bha_purpose` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Assembly (BHA) Purpose');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bha_purpose` SET TAGS ('dbx_value_regex' = 'vertical|directional|horizontal|sidetrack|reaming|coring');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bha_type` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Assembly (BHA) Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bha_type` SET TAGS ('dbx_value_regex' = 'rotary|motor|rss|conventional|hybrid|steerable');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bit_iadc_code` SET TAGS ('dbx_business_glossary_term' = 'Bit International Association of Drilling Contractors (IADC) Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bit_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Bit Serial Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bit_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Bit Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bit_type` SET TAGS ('dbx_business_glossary_term' = 'Bit Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `bit_type` SET TAGS ('dbx_value_regex' = 'pdc|tricone|diamond|hybrid|natural_diamond|tsp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `collar_inner_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Collar Inner Diameter (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `collar_outer_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Collar Outer Diameter (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `collar_weight_per_foot_lbs` SET TAGS ('dbx_business_glossary_term' = 'Collar Weight Per Foot (Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|modified|retired');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `design_date` SET TAGS ('dbx_business_glossary_term' = 'Design Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `float_sub_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Float Sub Included Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `jar_position_from_bit_feet` SET TAGS ('dbx_business_glossary_term' = 'Jar Position From Bit (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `jar_type` SET TAGS ('dbx_business_glossary_term' = 'Jar Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `jar_type` SET TAGS ('dbx_value_regex' = 'hydraulic|mechanical|none');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `makeup_torque_ft_lbs` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Torque (Foot-Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `max_allowable_torque_ft_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Torque (Foot-Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `max_allowable_weight_on_bit_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Weight On Bit (WOB) (Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `motor_bend_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Motor Bend Angle (Degrees)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `motor_type` SET TAGS ('dbx_business_glossary_term' = 'Motor Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `motor_type` SET TAGS ('dbx_value_regex' = 'positive_displacement|turbine|none');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `mwd_lwd_tool_string` SET TAGS ('dbx_business_glossary_term' = 'Measurement While Drilling (MWD) / Logging While Drilling (LWD) Tool String');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `number_of_stabilizers` SET TAGS ('dbx_business_glossary_term' = 'Number of Stabilizers');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `reamer_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Reamer Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `reamer_type` SET TAGS ('dbx_business_glossary_term' = 'Reamer Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `retrieval_date` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `rss_type` SET TAGS ('dbx_business_glossary_term' = 'Rotary Steerable System (RSS) Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `shock_sub_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Shock Sub Included Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `stabilizer_placement` SET TAGS ('dbx_business_glossary_term' = 'Stabilizer Placement');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `torque_drag_analysis_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Torque and Drag (T&D) Analysis Performed Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `total_bha_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Bottom Hole Assembly (BHA) Length (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ALTER COLUMN `total_bha_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Bottom Hole Assembly (BHA) Weight (Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bit Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Bit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `wellbore_id` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `average_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Flow Rate (Gallons per Minute)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `average_rop_ft_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Average Rate of Penetration (ROP) (Feet per Hour)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `average_rpm` SET TAGS ('dbx_business_glossary_term' = 'Average Revolutions per Minute (RPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `average_standpipe_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average Standpipe Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `average_torque_ft_lbs` SET TAGS ('dbx_business_glossary_term' = 'Average Torque (Foot-Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `average_wob_klbs` SET TAGS ('dbx_business_glossary_term' = 'Average Weight on Bit (WOB) (Thousand Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bearing_seal_condition` SET TAGS ('dbx_business_glossary_term' = 'Bearing and Seal Condition');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bearing_seal_condition` SET TAGS ('dbx_value_regex' = 'E|F|N|X');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Bit Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_hydraulic_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Bit Hydraulic Horsepower (HHP)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Bit Manufacturer');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_model` SET TAGS ('dbx_business_glossary_term' = 'Bit Model');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_refurbished_flag` SET TAGS ('dbx_business_glossary_term' = 'Bit Refurbished Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Bit Serial Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Bit Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_type` SET TAGS ('dbx_business_glossary_term' = 'Bit Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `bit_type` SET TAGS ('dbx_value_regex' = 'PDC|tricone|roller_cone|diamond|hybrid|other');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `cost_per_foot_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost per Foot (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `cost_per_foot_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `drilling_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Drilling Fluid Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `drilling_fluid_type` SET TAGS ('dbx_value_regex' = 'water_based|oil_based|synthetic_based|air|foam|other');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `footage_drilled_ft` SET TAGS ('dbx_business_glossary_term' = 'Footage Drilled (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `formation_bottom_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Formation Bottom Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `formation_drilled` SET TAGS ('dbx_business_glossary_term' = 'Formation Drilled');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `formation_top_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Formation Top Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `gauge_wear_sixteenths` SET TAGS ('dbx_business_glossary_term' = 'Gauge Wear (Sixteenths of Inch)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `hours_on_bottom` SET TAGS ('dbx_business_glossary_term' = 'Hours on Bottom');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `iadc_dull_grade` SET TAGS ('dbx_business_glossary_term' = 'International Association of Drilling Contractors (IADC) Dull Grade');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `inner_cutting_structure_wear` SET TAGS ('dbx_business_glossary_term' = 'Inner Cutting Structure Wear');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `jet_impact_force_lbs` SET TAGS ('dbx_business_glossary_term' = 'Jet Impact Force (Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `maximum_rop_ft_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rate of Penetration (ROP) (Feet per Hour)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `maximum_rpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Revolutions per Minute (RPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `maximum_torque_ft_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Torque (Foot-Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `maximum_wob_klbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight on Bit (WOB) (Thousand Pounds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `minimum_rop_ft_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rate of Penetration (ROP) (Feet per Hour)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `mud_weight_ppg` SET TAGS ('dbx_business_glossary_term' = 'Mud Weight (Pounds per Gallon)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `nozzle_configuration` SET TAGS ('dbx_business_glossary_term' = 'Nozzle Configuration');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `outer_cutting_structure_wear` SET TAGS ('dbx_business_glossary_term' = 'Outer Cutting Structure Wear');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `pull_out_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Pull-Out Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `reason_pulled` SET TAGS ('dbx_business_glossary_term' = 'Reason Pulled');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `reason_pulled_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Pulled Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `rerun_number` SET TAGS ('dbx_business_glossary_term' = 'Rerun Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `rotating_hours` SET TAGS ('dbx_business_glossary_term' = 'Rotating Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `run_in_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Run-In Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ALTER COLUMN `total_nozzle_area_sq_in` SET TAGS ('dbx_business_glossary_term' = 'Total Nozzle Area (Square Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `directional_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Directional Survey Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `bit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `anti_collision_zone_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Collision Zone Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `anti_collision_zone_status` SET TAGS ('dbx_value_regex' = 'clear|warning|violation|not_evaluated');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `azimuth` SET TAGS ('dbx_business_glossary_term' = 'Azimuth Angle');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `bsee_reportable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Reportable Indicator');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `closure_azimuth` SET TAGS ('dbx_business_glossary_term' = 'Closure Azimuth');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `closure_distance` SET TAGS ('dbx_business_glossary_term' = 'Closure Distance');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `coordinate_reference_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System (CRS)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `coordinate_uom` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `coordinate_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `dls` SET TAGS ('dbx_business_glossary_term' = 'Dogleg Severity (DLS)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `dls_uom` SET TAGS ('dbx_business_glossary_term' = 'Dogleg Severity (DLS) Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `dls_uom` SET TAGS ('dbx_value_regex' = 'deg/100ft|deg/30m');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `easting` SET TAGS ('dbx_business_glossary_term' = 'Easting Coordinate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `gravity_field_strength` SET TAGS ('dbx_business_glossary_term' = 'Gravity Field Strength');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `grid_convergence_angle` SET TAGS ('dbx_business_glossary_term' = 'Grid Convergence Angle');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `inclination` SET TAGS ('dbx_business_glossary_term' = 'Inclination Angle');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `magnetic_declination` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Declination');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `magnetic_dip_angle` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Dip Angle');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `magnetic_field_strength` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Field Strength');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `md` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `md_uom` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `md_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `northing` SET TAGS ('dbx_business_glossary_term' = 'Northing Coordinate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `reference_datum` SET TAGS ('dbx_business_glossary_term' = 'Reference Datum');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `reference_datum_elevation` SET TAGS ('dbx_business_glossary_term' = 'Reference Datum Elevation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Calculation Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_calculation_method` SET TAGS ('dbx_value_regex' = 'minimum_curvature|balanced_tangential|average_angle|radius_of_curvature|tangential');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_correction_applied` SET TAGS ('dbx_business_glossary_term' = 'Survey Correction Applied Indicator');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'MWD|LWD|gyroscopic|magnetic|inertial|wireline');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Quality Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_quality_code` SET TAGS ('dbx_value_regex' = 'definitive|check|tie-in|interpolated|projected|estimated');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_remarks` SET TAGS ('dbx_business_glossary_term' = 'Survey Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_station_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Station Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'active|superseded|rejected|pending_review|approved');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `survey_tool_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Tool Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `target_hit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Target Hit Indicator');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `tvd` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `tvd_uom` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `tvd_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `vertical_section` SET TAGS ('dbx_business_glossary_term' = 'Vertical Section');
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `mwd_lwd_log_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement While Drilling (MWD) / Logging While Drilling (LWD) Log ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `bit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Bit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `annular_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Annular Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `azimuth_deg` SET TAGS ('dbx_business_glossary_term' = 'Azimuth in Degrees');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `bulk_density_g_cm3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density in Grams per Cubic Centimeter');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `caliper_in` SET TAGS ('dbx_business_glossary_term' = 'Caliper Measurement in Inches');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `correction_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Correction Applied Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|suspect|bad|unchecked');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `equivalent_circulating_density_ppg` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Circulating Density (ECD) in Pounds per Gallon');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `formation_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Formation Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `gamma_ray_api` SET TAGS ('dbx_business_glossary_term' = 'Gamma Ray in American Petroleum Institute (API) Units');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `geosteering_decision` SET TAGS ('dbx_business_glossary_term' = 'Geosteering Decision');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `hydrocarbon_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Indicator');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `hydrocarbon_indicator` SET TAGS ('dbx_value_regex' = 'oil|gas|water|unknown');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `inclination_deg` SET TAGS ('dbx_business_glossary_term' = 'Inclination in Degrees');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `lithology_code` SET TAGS ('dbx_business_glossary_term' = 'Lithology Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `mud_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Mud Flow Rate in Gallons per Minute (GPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `mud_weight_ppg` SET TAGS ('dbx_business_glossary_term' = 'Mud Weight in Pounds per Gallon (PPG)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `neutron_porosity_pct` SET TAGS ('dbx_business_glossary_term' = 'Neutron Porosity Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `rate_of_penetration_ft_hr` SET TAGS ('dbx_business_glossary_term' = 'Rate of Penetration (ROP) in Feet per Hour');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `resistivity_ohmm` SET TAGS ('dbx_business_glossary_term' = 'Resistivity in Ohm-Meters');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `rotary_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Rotary Speed in Revolutions per Minute (RPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `service_company` SET TAGS ('dbx_business_glossary_term' = 'Service Company');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `sonic_transit_time_us_ft` SET TAGS ('dbx_business_glossary_term' = 'Sonic Transit Time in Microseconds per Foot');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `telemetry_type` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `telemetry_type` SET TAGS ('dbx_value_regex' = 'mud_pulse|electromagnetic|wired_drill_pipe|acoustic');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `temperature_degf` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Degrees Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `tool_string_configuration` SET TAGS ('dbx_business_glossary_term' = 'Tool String Configuration');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `toolface_deg` SET TAGS ('dbx_business_glossary_term' = 'Toolface Angle in Degrees');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `torque_ft_lbs` SET TAGS ('dbx_business_glossary_term' = 'Torque in Foot-Pounds');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ALTER COLUMN `weight_on_bit_klbs` SET TAGS ('dbx_business_glossary_term' = 'Weight on Bit (WOB) in Thousand Pounds');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `casing_design_id` SET TAGS ('dbx_business_glossary_term' = 'Casing Design ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer Person ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `bsee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `bsee_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Approval Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `bsee_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not_required|rejected');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `burst_design_factor` SET TAGS ('dbx_business_glossary_term' = 'Burst Design Factor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `burst_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Burst Rating in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `casing_grade` SET TAGS ('dbx_business_glossary_term' = 'Casing Grade');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `casing_string_number` SET TAGS ('dbx_business_glossary_term' = 'Casing String Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `casing_string_type` SET TAGS ('dbx_business_glossary_term' = 'Casing String Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `casing_string_type` SET TAGS ('dbx_value_regex' = 'conductor|surface|intermediate|production|liner|tieback');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `cement_bond_log_result` SET TAGS ('dbx_business_glossary_term' = 'Cement Bond Log (CBL) Result');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `cement_bond_log_result` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|not_run');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `cement_job_type` SET TAGS ('dbx_business_glossary_term' = 'Cement Job Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `cement_job_type` SET TAGS ('dbx_value_regex' = 'primary|squeeze|plug|remedial');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `cement_slurry_design` SET TAGS ('dbx_business_glossary_term' = 'Cement Slurry Design');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `collapse_design_factor` SET TAGS ('dbx_business_glossary_term' = 'Collapse Design Factor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `collapse_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Collapse Rating in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `design_status` SET TAGS ('dbx_business_glossary_term' = 'Design Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `design_status` SET TAGS ('dbx_value_regex' = 'planned|approved|installed|verified|failed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `displacement_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Displacement Fluid Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `displacement_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Displacement Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `final_circulating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Final Circulating Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `installation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `installation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `job_quality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Job Quality Assessment');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `job_quality_assessment` SET TAGS ('dbx_value_regex' = 'successful|marginal|failed|pending_evaluation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `lead_cement_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Lead Cement Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `outer_diameter_in` SET TAGS ('dbx_business_glossary_term' = 'Outer Diameter (OD) in Inches');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `pressure_test_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Pressure Test Duration in Minutes');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `pressure_test_result_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Test Result in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `pump_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Pump Rate in Barrels Per Minute (BPM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `setting_depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Setting Depth Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `setting_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Setting Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `tail_cement_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Tail Cement Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `tension_design_factor` SET TAGS ('dbx_business_glossary_term' = 'Tension Design Factor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `tension_rating_lb` SET TAGS ('dbx_business_glossary_term' = 'Tension Rating in Pounds');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `top_of_casing_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Top of Casing Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `top_of_cement_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Top of Cement (TOC) Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `weight_per_foot_lb` SET TAGS ('dbx_business_glossary_term' = 'Weight Per Foot in Pounds');
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ALTER COLUMN `zonal_isolation_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Zonal Isolation Verified Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `cementing_job_id` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `casing_design_id` SET TAGS ('dbx_business_glossary_term' = 'Casing Design Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Job Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cementing Job Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `bsee_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Report Submitted Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `bsee_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Reporting Required Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `casing_shoe_depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Casing Shoe Depth Measured Depth (MD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `casing_shoe_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Casing Shoe Depth True Vertical Depth (TVD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `cement_bond_log_run_flag` SET TAGS ('dbx_business_glossary_term' = 'Cement Bond Log (CBL) Run Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `cement_bond_quality` SET TAGS ('dbx_business_glossary_term' = 'Cement Bond Quality Assessment');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `cement_bond_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `cement_compressive_strength_psi` SET TAGS ('dbx_business_glossary_term' = 'Cement Compressive Strength in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `displacement_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Displacement Fluid Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `displacement_fluid_type` SET TAGS ('dbx_value_regex' = 'drilling_mud|spacer|water|brine');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `displacement_fluid_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Displacement Fluid Volume in Barrels (bbl)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `final_circulating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Final Circulating Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_quality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Quality Assessment');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_quality_assessment` SET TAGS ('dbx_value_regex' = 'successful|marginal|unsuccessful|requires_remediation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|suspended');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `job_type` SET TAGS ('dbx_value_regex' = 'primary|squeeze|plug|remedial|liner|stage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `lead_slurry_density_ppg` SET TAGS ('dbx_business_glossary_term' = 'Lead Slurry Density in Pounds per Gallon (ppg)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `lead_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Slurry Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `lead_slurry_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Lead Slurry Volume in Barrels (bbl)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `max_pump_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pump Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `plug_bump_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Plug Bump Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `pump_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Pump Rate in Barrels per Minute (bpm)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Cementing Job Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `spacer_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Spacer Volume in Barrels (bbl)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `tail_slurry_density_ppg` SET TAGS ('dbx_business_glossary_term' = 'Tail Slurry Density in Pounds per Gallon (ppg)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `tail_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Tail Slurry Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `tail_slurry_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Tail Slurry Volume in Barrels (bbl)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `top_of_cement_actual_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Top of Cement (TOC) Actual Measured Depth (MD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `top_of_cement_planned_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Top of Cement (TOC) Planned Measured Depth (MD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `wait_on_cement_hours` SET TAGS ('dbx_business_glossary_term' = 'Wait on Cement (WOC) Time in Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ALTER COLUMN `zonal_isolation_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Zonal Isolation Achieved Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `bop_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Certification ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `accumulator_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Capacity (Gallons)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `accumulator_precharge_psi` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Precharge Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `annular_preventer_type` SET TAGS ('dbx_business_glossary_term' = 'Annular Preventer Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `blind_shear_ram_count` SET TAGS ('dbx_business_glossary_term' = 'Blind Shear Ram Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `bop_stack_configuration` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Stack Configuration');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `bop_stack_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Stack Serial Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `bsee_form_reference` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Form Reference');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `certifying_authority` SET TAGS ('dbx_business_glossary_term' = 'Certifying Authority');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `certifying_person_license_number` SET TAGS ('dbx_business_glossary_term' = 'Certifying Person License Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `certifying_person_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `certifying_person_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Person Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `certifying_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `choke_manifold_test_psi` SET TAGS ('dbx_business_glossary_term' = 'Choke Manifold Test Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `corrective_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Taken');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `deficiencies_noted` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Noted');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `function_test_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Function Test Completed Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `high_pressure_test_psi` SET TAGS ('dbx_business_glossary_term' = 'High Pressure Test (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `kill_manifold_test_psi` SET TAGS ('dbx_business_glossary_term' = 'Kill Manifold Test Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `low_pressure_test_psi` SET TAGS ('dbx_business_glossary_term' = 'Low Pressure Test (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `next_scheduled_test_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Test Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `pipe_ram_count` SET TAGS ('dbx_business_glossary_term' = 'Pipe Ram Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `pressure_drop_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Drop (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `ram_preventer_count` SET TAGS ('dbx_business_glossary_term' = 'Ram Preventer Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `retest_result` SET TAGS ('dbx_business_glossary_term' = 'Retest Result');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `retest_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_location` SET TAGS ('dbx_value_regex' = 'onshore|offshore_shallow|offshore_deepwater');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_report_document_code` SET TAGS ('dbx_business_glossary_term' = 'Test Report Document ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'initial|14-day|30-day|post-repair|pre-spud|annual');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `test_witnessed_by_bsee_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Witnessed by Bureau of Safety and Environmental Enforcement (BSEE) Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `well_control_event_id` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Person Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `bop_activation_method` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Activation Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `bop_activation_method` SET TAGS ('dbx_value_regex' = 'manual|automatic|remote|emergency');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `bop_configuration` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Configuration');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `bsee_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Incident Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `bsee_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Notification Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `bsee_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `choke_manifold_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Choke Manifold Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Event Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `environmental_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `estimated_cost_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `estimated_cost_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Severity');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|resolved|under_investigation|closed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'kick|influx|underground_blowout|surface_blowout|lost_circulation|well_integrity_failure');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `formation_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Formation Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `iadc_code` SET TAGS ('dbx_business_glossary_term' = 'International Association of Drilling Contractors (IADC) Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `influx_type` SET TAGS ('dbx_business_glossary_term' = 'Influx Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `influx_type` SET TAGS ('dbx_value_regex' = 'gas|oil|water|multiphase|unknown');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `influx_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Influx Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `kill_fluid_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Kill Fluid Volume Pumped in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `kill_method` SET TAGS ('dbx_business_glossary_term' = 'Kill Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `kill_method` SET TAGS ('dbx_value_regex' = 'drillers_method|wait_and_weight|concurrent|volumetric|bullheading|dynamic_kill');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `kill_mud_weight_ppg` SET TAGS ('dbx_business_glossary_term' = 'Kill Mud Weight in Pounds per Gallon (PPG)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `personnel_evacuated_count` SET TAGS ('dbx_business_glossary_term' = 'Personnel Evacuated Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `pit_gain_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Pit Gain Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `preventive_measures` SET TAGS ('dbx_business_glossary_term' = 'Preventive Measures');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'operator|drilling_contractor|service_provider|joint_venture_partner|unknown');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `sicp_psi` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Casing Pressure (SICP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `sidpp_psi` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Drill Pipe Pressure (SIDPP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `dst_result_id` SET TAGS ('dbx_business_glossary_term' = 'Dst Result Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `completion_design_id` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Company Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `bsee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Report Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `bsee_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `dst_number` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `final_flowing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Final Flowing Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `final_shutin_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Final Shut-In Pressure (FSIP) (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `flow_period_count` SET TAGS ('dbx_business_glossary_term' = 'Flow Period Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `fluid_gravity_api` SET TAGS ('dbx_business_glossary_term' = 'Fluid Gravity American Petroleum Institute (API) Degrees');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `fluid_sample_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Fluid Sample Collected Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Fluid Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `fluid_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|water|dry|unknown');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `gas_flow_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `gas_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Gravity');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `gor` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `initial_flowing_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Flowing Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `initial_shutin_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Shut-In Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `interval_bottom_md` SET TAGS ('dbx_business_glossary_term' = 'Interval Bottom Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `interval_bottom_tvd` SET TAGS ('dbx_business_glossary_term' = 'Interval Bottom True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `interval_top_md` SET TAGS ('dbx_business_glossary_term' = 'Interval Top Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `interval_top_tvd` SET TAGS ('dbx_business_glossary_term' = 'Interval Top True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `oil_flow_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Oil Flow Rate Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Permeability Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `shutin_period_count` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Period Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `skin_factor` SET TAGS ('dbx_business_glossary_term' = 'Skin Factor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Test Conclusion');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_conclusion` SET TAGS ('dbx_value_regex' = 'commercial|sub_commercial|non_commercial|inconclusive');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_interpretation_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Interpretation Summary');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|suspended|failed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_tool_description` SET TAGS ('dbx_business_glossary_term' = 'Test Tool Description');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'open_hole|cased_hole|tubing_conveyed|wireline_conveyed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `total_flow_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Flow Duration Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `total_shutin_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Shut-In Duration Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `water_cut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Water Cut Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `water_flow_rate_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Water Flow Rate Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `completion_design_id` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `contractor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Completion Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `actual_completion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion End Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `actual_completion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Perforation Charge Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `closure_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Fracture Closure Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `completion_design_number` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `completion_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Completion Engineer Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'design|approved|in_progress|completed|suspended|abandoned');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `completion_type` SET TAGS ('dbx_business_glossary_term' = 'Completion Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `confirmed_shots_count` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Shots Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `design_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `design_remarks` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `frac_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Fracturing Fluid Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `isip_psi` SET TAGS ('dbx_business_glossary_term' = 'Instantaneous Shut-In Pressure (ISIP) (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `maximum_treating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Treating Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `packer_setting_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Packer Setting Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `packer_type` SET TAGS ('dbx_business_glossary_term' = 'Packer Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `perforation_bottom_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforation Bottom Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `perforation_gun_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Perforation Gun Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `perforation_gun_type` SET TAGS ('dbx_business_glossary_term' = 'Perforation Gun Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `perforation_top_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforation Top Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `post_frac_ip_bopd` SET TAGS ('dbx_business_glossary_term' = 'Post-Fracture Initial Production (Barrels of Oil Per Day - BOPD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `post_frac_ip_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Post-Fracture Initial Production (Thousand Cubic Feet per Day - MCFD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `proppant_type` SET TAGS ('dbx_business_glossary_term' = 'Proppant Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `reservoir_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Engineer Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `shot_density_spf` SET TAGS ('dbx_business_glossary_term' = 'Shot Density (Shots Per Foot - SPF)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `shot_phasing_degrees` SET TAGS ('dbx_business_glossary_term' = 'Shot Phasing (Degrees)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `stimulation_job_type` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Job Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `stimulation_stage_count` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Stage Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `total_frac_fluid_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Fracturing Fluid Volume (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `total_proppant_mass_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Proppant Mass (Pounds - LBS)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `tubing_grade` SET TAGS ('dbx_business_glossary_term' = 'Tubing Grade');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `tubing_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Tubing Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `tubing_weight_lb_per_ft` SET TAGS ('dbx_business_glossary_term' = 'Tubing Weight (Pounds per Foot)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `underbalance_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Underbalance Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `perforation_job_id` SET TAGS ('dbx_business_glossary_term' = 'Perforation Job Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `completion_design_id` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `bsee_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Perforating Charge Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `charge_weight_grams` SET TAGS ('dbx_business_glossary_term' = 'Charge Weight (Grams)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `confirmed_shots` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Shots');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `formation_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Formation Pressure at Perforation (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `gun_size_inches` SET TAGS ('dbx_business_glossary_term' = 'Perforation Gun Size (Inches)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `gun_type` SET TAGS ('dbx_business_glossary_term' = 'Perforation Gun Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `gun_type` SET TAGS ('dbx_value_regex' = 'tubing_conveyed|wireline_conveyed|coiled_tubing_conveyed|through_tubing|casing_gun');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `initial_flow_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Flow Rate Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `initial_gas_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Gas Rate Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `interval_bottom_md` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Bottom Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `interval_bottom_tvd` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Bottom True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `interval_top_md` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Top Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `interval_top_tvd` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Top True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Perforation Job Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `job_remarks` SET TAGS ('dbx_business_glossary_term' = 'Perforation Job Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Perforation Job Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `job_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|failed|suspended|cancelled');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `misfire_count` SET TAGS ('dbx_business_glossary_term' = 'Misfire Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `perforated_interval_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforated Interval Length (Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `perforation_date` SET TAGS ('dbx_business_glossary_term' = 'Perforation Execution Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `perforation_fluid_density_ppg` SET TAGS ('dbx_business_glossary_term' = 'Perforation Fluid Density (Pounds Per Gallon)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `perforation_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Perforation Fluid Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `perforation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Perforation Execution Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `phasing_degrees` SET TAGS ('dbx_business_glossary_term' = 'Perforation Phasing (Degrees)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `post_job_inflow_test_result` SET TAGS ('dbx_business_glossary_term' = 'Post-Job Inflow Test Result');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `post_job_inflow_test_result` SET TAGS ('dbx_value_regex' = 'positive|negative|inconclusive|not_performed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `service_company_engineer` SET TAGS ('dbx_business_glossary_term' = 'Service Company Engineer');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `service_company_name` SET TAGS ('dbx_business_glossary_term' = 'Service Company Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `shot_density_spf` SET TAGS ('dbx_business_glossary_term' = 'Shot Density Shots Per Foot (SPF)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `total_shots_fired` SET TAGS ('dbx_business_glossary_term' = 'Total Shots Fired');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `total_shots_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Shots Planned');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `underbalance_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Underbalance Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ALTER COLUMN `wellbore_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Pressure at Perforation (PSI)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `stimulation_job_id` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Job Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Job Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `perforation_job_id` SET TAGS ('dbx_business_glossary_term' = 'Perforation Job Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `average_pump_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Average Pump Rate in Barrels per Minute (bpm)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `average_treating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Average Treating Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `breakdown_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Formation Breakdown Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `estimated_fracture_conductivity_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fracture Conductivity in Millidarcy-Feet (md-ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `estimated_fracture_half_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fracture Half-Length in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `estimated_fracture_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fracture Height in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `fluid_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fracturing Fluid System Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `fracture_closure_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Fracture Closure Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `hse_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incidents Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `isip_psi` SET TAGS ('dbx_business_glossary_term' = 'Instantaneous Shut-In Pressure (ISIP) in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_date` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Job Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Job Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Job End Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Job Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Job Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Job Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `job_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|screenout|aborted|suspended');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `maximum_proppant_concentration_ppa` SET TAGS ('dbx_business_glossary_term' = 'Maximum Proppant Concentration in Pounds per Added Gallon (ppa)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `maximum_pump_rate_bpm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pump Rate in Barrels per Minute (bpm)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `maximum_treating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Treating Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `net_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Net Fracture Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `post_job_production_test_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Job Production Test Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `post_job_production_test_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Post-Job Production Test Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `proppant_mesh_size` SET TAGS ('dbx_business_glossary_term' = 'Proppant Mesh Size');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `proppant_type` SET TAGS ('dbx_business_glossary_term' = 'Proppant Material Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `proppant_type` SET TAGS ('dbx_value_regex' = 'white_sand|brown_sand|resin_coated_sand|ceramic_lightweight|ceramic_intermediate|ceramic_high_strength');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `screenout_flag` SET TAGS ('dbx_business_glossary_term' = 'Screenout Event Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `service_company_name` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Service Company Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `stage_number` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Stage Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `stimulation_type` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Treatment Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `stimulation_type` SET TAGS ('dbx_value_regex' = 'hydraulic_fracture|acid_fracture|matrix_acid|foam_frac|hybrid_frac|water_frac');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `total_clean_fluid_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Clean Fluid Volume in Barrels (bbl)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `total_fluid_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Fluid Volume in Barrels (bbl)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `total_proppant_mass_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Proppant Mass in Pounds (lbs)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Treatment Effectiveness Rating');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|failed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_effectiveness_rating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_effectiveness_rating` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_interval_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Treatment Interval True Vertical Depth (TVD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_interval_tvd_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `treatment_interval_tvd_ft` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `well_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Well Status History ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'AFE (Authorization for Expenditure) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Engineer ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `well_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Well Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `authorizing_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Engineer Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `bond_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `bond_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `bsee_incident_number` SET TAGS ('dbx_business_glossary_term' = 'BSEE (Bureau of Safety and Environmental Enforcement) Incident Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `bsee_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'BSEE (Bureau of Safety and Environmental Enforcement) Reportable Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `event_remarks` SET TAGS ('dbx_business_glossary_term' = 'Event Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|permit_event');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `joint_venture_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `operator_code` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `previous_status_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Well Status Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `regulatory_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `regulatory_notification_method` SET TAGS ('dbx_value_regex' = 'electronic_filing|paper_submission|verbal_notification|email');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `reserves_category_after` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category After Event');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `reserves_category_after` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `reserves_category_before` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Before Event');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `reserves_category_before` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `sec_reserves_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'SEC (Securities and Exchange Commission) Reserves Impact Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `status_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ALTER COLUMN `status_code` SET TAGS ('dbx_business_glossary_term' = 'Well Status Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_detail_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Detail ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Billing Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `afe_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Budget Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `afe_line_item` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Line Item');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `capitalizable_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalizable Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'rig_day_rate|mud_and_chemicals|bits|casing_and_tubing|cementing|directional_services');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_detail_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Description');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'pending|approved|posted|disputed|reversed');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `cumulative_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Actual Cost');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `functional_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Functional Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `jib_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `non_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `operator_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Operator Share Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `over_budget_flag` SET TAGS ('dbx_business_glossary_term' = 'Over Budget Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `plug_and_abandonment_id` SET TAGS ('dbx_business_glossary_term' = 'Plug And Abandonment Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `abandonment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `contractor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Representative Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `abandonment_reason` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Reason');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `bridge_plug_setting_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Bridge Plug Setting Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `bridge_plug_type` SET TAGS ('dbx_business_glossary_term' = 'Bridge Plug Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `casing_cut_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Casing Cut Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `casing_disposition` SET TAGS ('dbx_business_glossary_term' = 'Casing Disposition');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `casing_disposition` SET TAGS ('dbx_value_regex' = 'removed|cut_and_capped|left_in_hole|recovered');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `cement_type` SET TAGS ('dbx_business_glossary_term' = 'Cement Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `depth_uom` SET TAGS ('dbx_business_glossary_term' = 'Depth Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `depth_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `final_well_status` SET TAGS ('dbx_business_glossary_term' = 'Final Well Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `final_well_status` SET TAGS ('dbx_value_regex' = 'permanently_abandoned|temporarily_abandoned|plugged_and_abandoned');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `intermediate_plug_bottom_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Intermediate Plug Bottom Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `intermediate_plug_top_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Intermediate Plug Top Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_date` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_number` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_remarks` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Remarks');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_status` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_type` SET TAGS ('dbx_business_glossary_term' = 'Plug and Abandonment (P&A) Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `pa_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `plug_material_type` SET TAGS ('dbx_business_glossary_term' = 'Plug Material Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `plug_material_type` SET TAGS ('dbx_value_regex' = 'cement|mechanical|bridge_plug|combination');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `production_plug_bottom_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Production Plug Bottom Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `production_plug_top_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Production Plug Top Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `surface_plug_bottom_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Surface Plug Bottom Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `surface_plug_top_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Surface Plug Top Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `surface_restoration_date` SET TAGS ('dbx_business_glossary_term' = 'Surface Restoration Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `surface_restoration_status` SET TAGS ('dbx_business_glossary_term' = 'Surface Restoration Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `surface_restoration_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `total_cement_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Cement Volume Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `total_plugs_set` SET TAGS ('dbx_business_glossary_term' = 'Total Plugs Set');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `tubing_disposition` SET TAGS ('dbx_business_glossary_term' = 'Tubing Disposition');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `tubing_disposition` SET TAGS ('dbx_value_regex' = 'removed|cut_and_capped|left_in_hole|recovered');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth Feet (FT)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `wellhead_removal_date` SET TAGS ('dbx_business_glossary_term' = 'Wellhead Removal Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ALTER COLUMN `wellhead_removed_flag` SET TAGS ('dbx_business_glossary_term' = 'Wellhead Removed Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` SET TAGS ('dbx_subdomain' = 'drilling_execution');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `mud_program_id` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `additive_id` SET TAGS ('dbx_business_glossary_term' = 'Additive Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Mud Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Mud Service Company Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `well_program_id` SET TAGS ('dbx_business_glossary_term' = 'Well Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_chloride_content_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Actual Chloride Content (Milligrams Per Liter)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_fluid_loss_ml_per_30min` SET TAGS ('dbx_business_glossary_term' = 'Actual Fluid Loss (Milliliters Per 30 Minutes)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_mud_weight_ppg` SET TAGS ('dbx_business_glossary_term' = 'Actual Mud Weight (Pounds Per Gallon)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_oil_water_ratio` SET TAGS ('dbx_business_glossary_term' = 'Actual Oil-Water Ratio');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_ph` SET TAGS ('dbx_business_glossary_term' = 'Actual pH');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_plastic_viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Actual Plastic Viscosity (Centipoise)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_solids_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Solids Content (Percent by Volume)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_viscosity_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Viscosity (Marsh Funnel Seconds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `actual_yield_point_lb_per_100sqft` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Point (Pounds Per 100 Square Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Approved By');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `co2_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Present Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_chloride_content_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Design Chloride Content (Milligrams Per Liter)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_date` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Design Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_fluid_loss_ml_per_30min` SET TAGS ('dbx_business_glossary_term' = 'Design Fluid Loss (Milliliters Per 30 Minutes)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_gel_strength_10min_lb_per_100sqft` SET TAGS ('dbx_business_glossary_term' = 'Design Gel Strength 10-Minute (Pounds Per 100 Square Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_gel_strength_10sec_lb_per_100sqft` SET TAGS ('dbx_business_glossary_term' = 'Design Gel Strength 10-Second (Pounds Per 100 Square Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_mud_weight_max_ppg` SET TAGS ('dbx_business_glossary_term' = 'Design Mud Weight Maximum (Pounds Per Gallon)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_mud_weight_min_ppg` SET TAGS ('dbx_business_glossary_term' = 'Design Mud Weight Minimum (Pounds Per Gallon)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_oil_water_ratio` SET TAGS ('dbx_business_glossary_term' = 'Design Oil-Water Ratio');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_ph_max` SET TAGS ('dbx_business_glossary_term' = 'Design pH Maximum');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_ph_min` SET TAGS ('dbx_business_glossary_term' = 'Design pH Minimum');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_plastic_viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Design Plastic Viscosity (Centipoise)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_solids_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Design Solids Content (Percent by Volume)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_viscosity_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Design Viscosity Target (Marsh Funnel Seconds)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `design_yield_point_lb_per_100sqft` SET TAGS ('dbx_business_glossary_term' = 'Design Yield Point (Pounds Per 100 Square Feet)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `environmental_disposal_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Disposal Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `environmental_disposal_classification` SET TAGS ('dbx_value_regex' = 'overboard-discharge|onshore-disposal|re-injection|thermal-treatment|bioremediation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `h2s_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `h2s_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Present Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `hole_section_code` SET TAGS ('dbx_business_glossary_term' = 'Hole Section Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `hpht_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Pressure High-Temperature (HPHT) Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `hpht_classification` SET TAGS ('dbx_value_regex' = 'standard|hpht|extreme-hpht|non-hpht');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Implementation Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `max_anticipated_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Anticipated Pressure (Pounds Per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `max_anticipated_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Maximum Anticipated Temperature (Degrees Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `mud_subtype` SET TAGS ('dbx_business_glossary_term' = 'Mud System Subtype');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `mud_system_type` SET TAGS ('dbx_business_glossary_term' = 'Mud System Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `mud_system_type` SET TAGS ('dbx_value_regex' = 'water-based|oil-based|synthetic-based|pneumatic|foam');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `offshore_discharge_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Discharge Permitted Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `program_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Program Revision Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Mud Program Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|completed|superseded|cancelled');
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ALTER COLUMN `wellbore_code` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `well_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Well Permit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `block_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Designated Agent Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `field_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `well_program_id` SET TAGS ('dbx_business_glossary_term' = 'Well Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Well Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `actual_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Notes');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `bond_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Bond Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Bond Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'Individual Well Bond|Blanket Bond|Area-Wide Bond|Supplemental Bond');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `bop_pressure_rating_psi` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Pressure Rating in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Cancellation Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Denial Reason');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `environmental_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `environmental_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Required Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Extension Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `h2s_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Concentration in Parts Per Million (ppm)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `h2s_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Present Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `hpht_classification_flag` SET TAGS ('dbx_business_glossary_term' = 'High Pressure High Temperature (HPHT) Classification Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'Federal Offshore|State Onshore|State Offshore|Tribal Lands|Private Lands');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `last_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Extension Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Location Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions and Stipulations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'APD|Sundry Notice|Workover Permit|P&A Permit|Sidetrack Permit|Recompletion Permit');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Well Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `planned_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Spud Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surety_company` SET TAGS ('dbx_business_glossary_term' = 'Surety Company Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surface_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surface_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surface_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surface_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surface_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `surface_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `dc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling and Completion (D&C) Program ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `primary_dc_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Person ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `primary_dc_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `primary_dc_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `actual_total_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `actual_total_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `actual_well_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Well Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `approved_total_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Total Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `approved_total_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `authorization_basis` SET TAGS ('dbx_business_glossary_term' = 'Authorization Basis');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `average_planned_td_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Average Planned Total Depth (TD) Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `average_planned_td_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Average Planned Total Depth (TD) True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `average_rig_day_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Rig Day Rate in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `average_rig_day_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `basin_name` SET TAGS ('dbx_business_glossary_term' = 'Geological Basin Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block or Lease Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `budget_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `budget_variance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `environmental_sensitivity_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `environmental_sensitivity_classification` SET TAGS ('dbx_value_regex' = 'standard|sensitive|protected|critical');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `h2s_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Present Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `hpht_classification` SET TAGS ('dbx_business_glossary_term' = 'High Pressure High Temperature (HPHT) Classification');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `hpht_classification` SET TAGS ('dbx_value_regex' = 'standard|hpht|extreme_hpht|not_applicable');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `joint_venture_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `operator_code` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration in Days');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `planned_well_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Well Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `primary_rig_contractor` SET TAGS ('dbx_business_glossary_term' = 'Primary Rig Contractor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Program Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'exploration|appraisal|development|infill|workover|sidetrack');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `target_formation` SET TAGS ('dbx_business_glossary_term' = 'Target Formation');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `well_trajectory_type` SET TAGS ('dbx_business_glossary_term' = 'Well Trajectory Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ALTER COLUMN `well_trajectory_type` SET TAGS ('dbx_value_regex' = 'vertical|directional|horizontal|multilateral');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` SET TAGS ('dbx_subdomain' = 'rig_operations');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` SET TAGS ('dbx_association_edges' = 'drilling.rig,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `rig_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Contract - Rig Contract Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Contract - Rig Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Contract - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `day_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Day Rate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `day_rate_usd` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `mobilization_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Fee');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `mobilization_fee_usd` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `standby_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Standby Rate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ALTER COLUMN `standby_rate_usd` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` SET TAGS ('dbx_association_edges' = 'drilling.afe,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `afe_vendor_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Vendor Spend - Afe Vendor Spend Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Vendor Spend - Afe Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Vendor Spend - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend USD');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `contracted_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Contracted Amount USD');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `first_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'First Invoice Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `purchase_order_count` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Count');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Updated Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ALTER COLUMN `variance_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount USD');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` SET TAGS ('dbx_association_edges' = 'drilling.drilling_well,reservoir.zone');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `well_zone_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Well-Zone Completion Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Zone Completion - Drilling Well Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Well Zone Completion - Reservoir Zone Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `completion_type` SET TAGS ('dbx_business_glossary_term' = 'Completion Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `cumulative_production_boe` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production Barrels of Oil Equivalent');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `last_production_date` SET TAGS ('dbx_business_glossary_term' = 'Last Production Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `perforation_interval_bottom_md` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Bottom Measured Depth');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `perforation_interval_top_md` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Top Measured Depth');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `stimulation_method` SET TAGS ('dbx_business_glossary_term' = 'Stimulation Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `zone_contribution_fraction` SET TAGS ('dbx_business_glossary_term' = 'Zone Contribution Fraction');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Completion Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` SET TAGS ('dbx_association_edges' = 'drilling.drilling_well,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `well_service_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Well Service Engagement ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Service Engagement - Drilling Well Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Well Service Engagement - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `drilling_contractor` SET TAGS ('dbx_business_glossary_term' = 'Drilling Contractor Name');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `total_service_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Service Value');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Updated Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` SET TAGS ('dbx_association_edges' = 'drilling.afe,land.working_interest');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `afe_election_id` SET TAGS ('dbx_business_glossary_term' = 'AFE Election ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Election - Afe Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `land_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Election - Working Interest Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost To Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `afe_election_status` SET TAGS ('dbx_business_glossary_term' = 'AFE Election Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `cost_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Amount');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `election_received_by` SET TAGS ('dbx_business_glossary_term' = 'Election Received By');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `forced_pooling_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Pooling Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `jib_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'JIB Invoice Reference');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `non_consent_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Penalty Rate');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Election Notes');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `participating_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participating Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` SET TAGS ('dbx_association_edges' = 'drilling.dc_program,reservoir.reservoir');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `program_reservoir_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Reservoir Allocation ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `dc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Reservoir Allocation - Dc Program Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Program Reservoir Allocation - Reservoir Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `actual_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual CAPEX USD');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `actual_well_count_for_reservoir` SET TAGS ('dbx_business_glossary_term' = 'Actual Well Count for Reservoir');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `allocated_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Allocated CAPEX USD');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `development_priority` SET TAGS ('dbx_business_glossary_term' = 'Development Priority');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `drilling_sequence` SET TAGS ('dbx_business_glossary_term' = 'Drilling Sequence');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `planned_well_count_for_reservoir` SET TAGS ('dbx_business_glossary_term' = 'Planned Well Count for Reservoir');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `target_eur_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Target Estimated Ultimate Recovery (EUR) MMboe');
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` SET TAGS ('dbx_association_edges' = 'drilling.drilling_well,land.pooling_unit');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `well_unit_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Well Unit Participation ID');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Unit Participation - Drilling Well Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Well Unit Participation - Pooling Unit Id');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `cost_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Bearing Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `formation_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Formation Allocation Flag');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percent');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `participating_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Participating Area Acres');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Method');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date');
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percent');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`operator` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ALTER COLUMN `wellbore_id` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ALTER COLUMN `permit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ALTER COLUMN `parent_wellbore_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`drilling`.`field` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`drilling`.`field` SET TAGS ('dbx_subdomain' = 'well_planning');
ALTER TABLE `oil_gas_ecm`.`drilling`.`field` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier');
ALTER TABLE `oil_gas_ecm`.`drilling`.`field` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
