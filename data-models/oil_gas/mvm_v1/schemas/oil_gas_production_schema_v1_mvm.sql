-- Schema for Domain: production | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`production` COMMENT 'Manages real-time and historical production data including daily production allocation, well test analysis, BOPD/MCFD/MMCFD reporting, GOR/WOR tracking, artificial lift optimization, decline curve analysis, and facility performance. Serves as the SSOT for production volumes and field performance via OSIsoft PI System, Avocet Production Operations, and SCADA/DCS integration. Supports SEC reserves reporting and regulatory production filings to BSEE and state agencies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`production_well` (
    `production_well_id` BIGINT COMMENT 'Unique system identifier for the production well record. Primary key for the production well entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Well workover AFE budget authorization: every production well workover or recompletion requires an approved AFE budget in the procurement system. O&G operators link wells to their active workover AFE ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wells are fundamental cost objects in upstream operations. Every well accumulates LOE and capital costs tracked by cost center for financial reporting, JIB preparation, budget variance analysis, and S',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Wells produce a specific crude grade that determines pricing differentials, royalty calculations, and refinery routing. Crude grade characterization (API, sulfur) is fundamental to well economics and ',
    `farmout_id` BIGINT COMMENT 'Foreign key linking to venture.farmout. Business justification: Farmout transactions are frequently well-specific (single-well earn-in obligations); linking production_well to farmout enables tracking of which wells are subject to farmout earn-in conditions, work ',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: Every producing well belongs to a field — this is a fundamental O&G master data relationship. production_well is the authoritative well master in this domain and must reference the field it belongs to',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Every production well is authorized via an AFE (Authorization for Expenditure) controlling drilling and completion capex. O&G capital budgeting requires linking the physical well to its AFE for cost t',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Production wells produce from specific geological formations. Formation-level production tracking is required for state/federal regulatory filings, reservoir management decisions, and reserves booking',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Wells are operated under Joint Operating Agreements; essential for cost allocation, AFE tracking, partner billing, and working interest calculations. Core operational relationship in oil-and-gas ventu',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: A production well is drilled on a specific lease; HBP status tracking, royalty calculation, regulatory well filings (API records), and lease revenue accounting all require direct well-to-lease linkage',
    `mineral_right_id` BIGINT COMMENT 'Foreign key linking to land.mineral_right. Business justification: A production well produces from specific mineral rights; payout status tracking, cumulative production against mineral interest, and overriding royalty interest calculations all require direct well-to',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Production wells operate under an operating license defining authorized operations, production capacity, and royalty terms. Regulatory compliance tracking, reserve reporting, and royalty calculations ',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: The designated operator of a production well is required for all state/federal regulatory filings (API well records, BSEE/state production reports). Operator assignment drives JOA operatorship, regula',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Wells require drilling permits, operating permits, and UIC permits for injection operations. Regulatory compliance tracking requires linking wells to their authorizing permits. Well has uic_permit_num',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Wells are classified by primary product (oil well, gas well, condensate well) for regulatory reporting, reserves classification (proved developed producing), and economic limit calculations. Role-pref',
    `play_id` BIGINT COMMENT 'Foreign key linking to exploration.play. Business justification: Production wells are drilled into specific plays. Play-level production performance tracking is essential for portfolio management, PRMS resource classification, and exploration success rate analysis.',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Wells are assigned to pooling/proration units for regulatory spacing compliance, production proration, and royalty allocation. State regulatory agencies require well-to-unit assignment for all product',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Production wells are drilled to develop specific prospects. The prospect-to-well lifecycle is a core upstream business process tracked in portfolio management, post-drill analysis, and exploration suc',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Wells in Production Sharing Contract regimes must link to PSA for cost recovery calculations, profit oil splits, and government entitlement reporting. Fundamental for PSC fiscal regime compliance.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Well workover and completion procurement: POs fund workover services, completion equipment, and well intervention programs. O&G operators link production wells to the most recent workover PO for OPEX/',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Production wells must meet quality specifications for pipeline acceptance (H2S limits, BS&W limits, API gravity ranges). Pipeline operators and purchasers specify wellhead quality requirements that op',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir or producing formation that this well targets. Links to reservoir master data for geological and engineering analysis.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Production wells are completed in specific reservoir zones (e.g., Wolfcamp A). Zone-level completion tracking is fundamental to production engineering, stimulation design, and PRMS reserves booking by',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Surface use agreements govern well pad construction, operations, and reclamation obligations. Environmental compliance, surface damage payments, and decommissioning planning require direct linkage bet',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the operating company responsible for day-to-day operations of this well. May differ from working interest owners.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: In SAP-based O&G systems, production wells are assigned to WBS elements for project cost collection and capitalization under successful-efforts accounting. WBS-level cost tracking is required for well',
    `api_number` STRING COMMENT 'Unique 10-14 digit API well number assigned by regulatory authority. Standard format: state code (2 digits), county code (3 digits), unique well identifier (5 digits), and optional sidetrack code (2 digits). Serves as the regulatory identifier for BSEE and state agency filings.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `artificial_lift_type` STRING COMMENT 'Type of artificial lift system installed on the well: none (flowing naturally), rod_pump (sucker rod pump), ESP (electric submersible pump), gas_lift (gas injection lift), plunger_lift (plunger system), PCP (progressive cavity pump), or hydraulic_pump (hydraulic jet pump). Critical for production optimization and OPEX forecasting. [ENUM-REF-CANDIDATE: none|rod_pump|esp|gas_lift|plunger_lift|pcp|hydraulic_pump — 7 candidates stripped; promote to reference product]',
    `bottom_hole_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the wellbore bottom hole location in decimal degrees (WGS84 datum). Critical for horizontal and directional wells where bottom hole differs significantly from surface location.',
    `bottom_hole_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the wellbore bottom hole location in decimal degrees (WGS84 datum). Critical for horizontal and directional wells where bottom hole differs significantly from surface location.',
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
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'Total measured depth of the wellbore from surface to total depth, measured along the actual wellbore path in feet. Differs from TVD for deviated wells.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Companys net revenue interest percentage in this well after deducting royalties and overriding royalty interests from working interest. Represents actual share of production revenue.',
    `permitted_injection_rate_bpd` DECIMAL(18,2) COMMENT 'Maximum allowable injection rate specified in the UIC permit, measured in barrels per day. Regulatory limit that must not be exceeded. Null for production wells.',
    `regulatory_district` STRING COMMENT 'State or federal regulatory district code where the well is located (e.g., Texas Railroad Commission District 8, BSEE Gulf of Mexico Region). Used for regulatory filing and compliance tracking.',
    `spud_date` DATE COMMENT 'Date when drilling operations commenced (when the drill bit first penetrated the surface). Key milestone for AFE tracking and regulatory reporting.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the wellhead surface location in decimal degrees (WGS84 datum). Used for GIS mapping and regulatory filings.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the wellhead surface location in decimal degrees (WGS84 datum). Used for GIS mapping and regulatory filings.',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'True vertical depth from surface to the deepest point of the wellbore, measured perpendicular to the surface in feet. Used for subsurface mapping and pressure calculations.',
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
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Facility project AFE budget authorization: production facility construction and major modification projects require an approved procurement AFE budget. O&G operators link facilities to their project A',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Production facilities are designed and operated to process specific crude grades. The crude grade processed determines equipment specifications (H2S handling, corrosion allowances, separator design), ',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: Surface production facilities (wellpads, gathering stations, processing plants) are located within a field. This is a fundamental O&G spatial and organizational relationship. field_id does not current',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Facilities are operated under JOAs; critical for JIB billing, overhead allocation, partner cost sharing, and capital expenditure tracking. Essential for multi-partner operations.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: Gas processing facilities produce specific NGL streams as output products. The NGL stream identity defines the facilitys output product for commercial contracts, transportation agreements, and revenu',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Production facilities have a designated operator for regulatory permits, environmental compliance, and JOA operatorship. State and federal facility permits are issued to the operator of record; emerge',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Hot work, confined space entry, and high-hazard maintenance at production facilities require PTW issuance. production_well already has this FK; production_facility is an equally primary PTW anchor for',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production facilities are profit centers in O&G management accounting — throughput revenue and LOE costs are attributed at the facility level. Facility-level P&L reporting and production-cost-per-BOE ',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Facilities in PSC areas must link to PSA for cost recovery eligibility, depreciation calculations, and production sharing allocations. Required for PSC economic modeling.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Production facilities operate under quality specifications for their output streams (pipeline quality gas specs, export crude quality requirements). Facility operators must ensure output meets these c',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Production facilities (tank batteries, compressor stations, processing plants) are built on land governed by SUAs. Facility decommissioning, reclamation bond calculations, and insurance compliance all',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Production facilities are joint-account assets with working interest ownership tracked for JIB cost allocation and depreciation. The venture_working_interest record defines each partners share of fac',
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
    `artificial_lift_id` BIGINT COMMENT 'Foreign key linking to production.artificial_lift. Business justification: daily_production has artificial_lift_type as a denormalized string attribute. The artificial_lift master record is the authoritative source for lift type and all associated parameters. Adding artifici',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Daily production volumes are allocated to term contracts for delivery obligation tracking, revenue recognition, and contract performance monitoring. Oil-and-gas operators routinely track which contrac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Daily production volumes drive revenue recognition and must be attributed to cost centers for profitability analysis, netback calculations, and segment reporting. Essential for daily production accoun',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Daily production volumes must be tied to a specific crude grade for custody transfer pricing, revenue allocation, and regulatory reporting. The crude grade determines the price differential applied to',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Production data must trace to discovery well for reserves reconciliation, EUR validation, and geological model calibration. Required for PRMS compliance, play success analysis, and prospect maturation',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Daily production volumes drive JIB allocations, partner entitlements, lifting schedules, and cash call calculations. Core operational link for partner revenue and cost distribution.',
    `meter_station_id` BIGINT COMMENT 'Identifier of the production meter used to measure volumes. Links to meter calibration and maintenance records.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: Daily production records NGL volumes (ngl_volume_bbl). The specific NGL stream identity determines pricing, allocation methodology, and regulatory reporting requirements. Gas processing agreements spe',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Daily production volumes are compared against customer pipeline/lifting nominations for supply balancing and scheduling. Operators use this link to confirm nomination fulfillment, manage shortfalls, a',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Daily production volumes must be classified by product type (crude grade, gas stream, NGL) for revenue accounting, regulatory reporting, and contract settlement. Essential for joint interest billing a',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Daily production volumes are compared against pipeline nominations for gas balancing and imbalance tracking. Gas marketing and balancing teams require this link to calculate daily imbalances and manag',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility or battery where production is measured and allocated.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production volumes must be attributed to profit centers for segment reporting and profitability analysis. Business unit P&L, management reporting, and SEC segment disclosure all require daily producti',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Daily production volumes are the primary input for PSA cost-oil/profit-oil split calculations and government entitlement reporting. Under PSA fiscal regimes, every daily production record must referen',
    `quality_test_result_id` BIGINT COMMENT 'Foreign key linking to product.quality_test_result. Business justification: Daily production quality is monitored through formal quality tests. Linking daily_production to quality_test_result enables quality-volume correlation for custody transfer validation, off-spec product',
    `reservoir_id` BIGINT COMMENT 'FK to reservoir.reservoir.reservoir_id — MUST-HAVE: Enables linking daily production volumes to reservoir properties (OOIP, drive mechanism, recovery factor) for decline curve analysis and reserves reconciliation. Without this FK, reservoir ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Daily production volumes must be attributed to specific reservoir zones for simulation history-matching and zone-level decline analysis. Reservoir engineers require zone-level daily production data to',
    `separator_id` BIGINT COMMENT 'Foreign key linking to production.separator. Business justification: daily_production captures separator_pressure_psi as a measurement attribute, indicating the specific separator used during production. Linking to the separator master record enables equipment performa',
    `well_test_id` BIGINT COMMENT 'Identifier of the well test used as the basis for production allocation when allocation method is test-based.',
    `allocation_method` STRING COMMENT 'Method used to allocate production volumes to the well. Test-based uses well test data, meter-based uses direct measurement, proportional uses pro-rata allocation, estimated uses decline curves or historical patterns, manual indicates operator override.. Valid values are `test_based|meter_based|proportional|estimated|manual`',
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
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Production allocation distributes volumes to working interest owners for JIB (Joint Interest Billing) and revenue distribution. The crude grade determines the price differential applied to each owner',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Allocation volumes must reconcile against custody transfer measurements at the point of title transfer. This link is required for allocation variance reporting, royalty audits, and PSA lifting reconci',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Production allocation results drive revenue recognition journal entries posted to specific GL accounts (oil revenue, gas revenue, NGL revenue, royalty payable). Month-end close and JIB processes requi',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Allocation results feed directly into JIB statements, partner settlements, and working interest distributions. Essential for multi-partner revenue and volume accounting.',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease or production unit under which this production is allocated. Links to land and lease management system for royalty calculations.',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Production allocation determines each partners net entitlement volume, which directly feeds the lifting program for scheduling partner liftings. Linking enables automated lifting schedule generation ',
    `meter_station_id` BIGINT COMMENT 'Foreign key linking to production.meter_station. Business justification: production_allocation distributes facility-level production volumes. The meter station is the measurement point that provides the metered volumes used as the basis for allocation calculations. Linking',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: Production allocation includes NGL volumes (gross_ngl_volume_bbl, net_ngl_volume_bbl). The NGL stream identity is required for proper allocation to working interest owners under gas processing agreeme',
    `offtake_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.offtake_entitlement. Business justification: Production allocation determines how gross facility volumes are split among equity holders and entitlement owners. Linking allocation to offtake_entitlement is essential for equity oil accounting, JIB',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Production allocation must reconcile against operating license entitlements including royalty_rate_pct and net_revenue_interest_pct. License-level allocation reporting is required for government royal',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Joint interest billing requires product-level allocation (oil vs gas vs NGL) because revenue distribution and royalty calculations differ by product type. Essential for partner accounting and PSA cost',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Gas allocation volumes must reconcile against pipeline nominations for gas balancing and imbalance calculation. FERC and state regulatory gas balancing reports require matching allocated production vo',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Production allocation is performed at the pooling unit level for proration and royalty distribution. Unit allocation calculations, JIB billing, and revenue deck generation all require direct linkage b',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility or battery where commingled production is measured before allocation. Links to facility master data.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: production_allocation distributes facility-level or commingled production volumes back to individual wells. The production_well is the authoritative well master in this domain. Currently production_al',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production allocation to partners must be tracked by profit center for proper revenue recognition in JIB preparation, partner accounting, segment reporting, and business unit P&L. Critical for joint v',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Allocation under PSC regimes determines cost oil, profit oil splits, and government entitlements. Critical for PSC fiscal regime compliance and contractor entitlement calculations.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Production allocation in multi-zone wells requires zone-level volume attribution for SEC/PRMS reserves reporting and JOA partner statements. Allocating metered facility volumes back to individual rese',
    `vendor_id` BIGINT COMMENT 'Reference to the operating company responsible for this production allocation. Links to the operator master data for joint venture and partnership tracking.',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Production allocation distributes volumes to working interest owners; the venture_working_interest record defines each partners WI/NRI percentages used in the allocation calculation. This is the core',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Monthly production is the basis for revenue recognition and must tie to cost centers for financial statement preparation, monthly close process, reserves reconciliation, and SEC reporting. Fundamental',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Monthly production reports submitted to BSEE, state regulators, and used for royalty calculations require crude grade identification. Royalty values depend on crude grade quality and pricing different',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Monthly production volumes must reconcile against custody transfer records for royalty calculation, JIB posting, and state regulatory reporting. This link is required for the standard monthly producti',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Monthly production volumes are reconciled against term contract delivery obligations for invoicing, take-or-pay compliance, and regulatory volume reporting. Contract compliance teams require this link',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: monthly_production supports regulatory production filings to BSEE and state agencies, which often require field-level aggregation. Direct field_id FK enables field-level monthly reporting without requ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Monthly production volumes are the basis for unit-of-production depletion calculations on proved-property fixed assets. Depletion rate = net book value / EUR × monthly production. This direct link is ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Monthly production summaries drive revenue accruals and royalty calculations posted to GL accounts during month-end close. O&G revenue recognition (ASC 606) requires tracing monthly volumes to the spe',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Monthly production is the basis for partner billing, regulatory reporting, royalty calculations, and JIB statement preparation under Joint Operating Agreements.',
    `lease_id` BIGINT COMMENT 'Identifier of the oil and gas lease under which the well or facility operates. Used for royalty calculation and land management.',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Monthly production volumes are reconciled against lifting programs to calculate overlift/underlift positions — a core JOA/PSA accounting requirement. Partners equity entitlements and cash calls depen',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: Monthly production reports NGL volumes (ngl_volume_bbl). NGL stream identity is required for regulatory reporting to state agencies and for royalty calculations on NGL production. Different NGL compon',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Monthly production volumes are reported against offtake agreement commitments for take-or-pay compliance monitoring. Regulatory filings and partner reporting require reconciling actual monthly product',
    `offtake_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.offtake_entitlement. Business justification: Monthly production volumes are reconciled against offtake entitlements to determine over/under-lift positions in PSA and JOA structures. This reconciliation drives equity oil accounting, profit oil sp',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Monthly production reports are submitted against specific operating licenses that define production caps and royalty rates. License-level production reporting is required for BSEE, state regulators, a',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Monthly regulatory reports to state agencies and BSEE require product-level classification of oil, gas, and NGL volumes. Mandatory for reserves booking and SEC financial reporting under ASC 932.',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility or battery where production is aggregated and measured.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: monthly_production is described as aggregated and validated at the well and facility level. It already has production_facility_id but lacks a production_well_id in-domain FK. This is essential for wel',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Monthly production is the basis for profit center revenue recognition in monthly financial close, segment reporting, and performance evaluation. Essential for business unit profitability analysis and ',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Monthly production is the statutory reporting period for PSA cost-recovery calculations, profit-oil splits, and government entitlement volumes. monthly_production already has joa_id but lacks psa_id, ',
    `regulatory_filing_id` BIGINT COMMENT 'Report identifier or confirmation number assigned by the state oil and gas commission upon submission of the monthly production report for onshore operations.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Monthly regulatory filings and PRMS reserves reconciliation require zone-level production attribution. State and federal regulators (BSEE, RRC) require production reported by producing zone, making th',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Monthly production reporting by partner requires the working interest record to apply correct NRI/WI splits for royalty calculation, revenue distribution, and SEC reserves disclosure. This link enable',
    `allocation_method` STRING COMMENT 'Method used to allocate production volumes to the well or facility. Indicates whether volumes are directly measured or allocated from facility totals.. Valid values are `direct_measurement|proration|well_test|estimated`',
    `api_well_number` STRING COMMENT 'Standardized API well number assigned by regulatory authority for unique well identification in production reporting.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
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
    `completion_design_id` BIGINT COMMENT 'Foreign key linking to drilling.completion_design. Business justification: Artificial lift selection and design (ESP sizing, rod pump stroke, gas lift valve depth) are directly constrained by completion design parameters (tubing size, casing ID, perforation depth, packer set',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Artificial lift maintenance service contracts: ESP and rod pump service agreements govern scheduled maintenance, failure response, and pull-and-replace programs. O&G operators link each lift installat',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Artificial lift systems (ESPs, rod pumps, gas lift) are physical equipment assets requiring maintenance tracking, failure analysis, and lifecycle management. Links operational performance data to equi',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Artificial lift installations are capital projects authorized by AFEs for capital project tracking, equipment capitalization, ROI analysis, and cost control. Essential for tracking artificial lift cap',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Artificial lift equipment (ESPs, rod pumps, gas lift compressors) is capitalized as fixed assets with tracked acquisition value and depreciation. artificial_lift has installation_cost_usd confirming c',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Artificial lift equipment manufacturers are vendors for procurement tracking, warranty management, and vendor performance evaluation. Manufacturer field is denormalized string. Role prefix distinguish',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: artificial_lift is described as a master record for artificial lift installations ON producing wells. The production_well is the authoritative well master in this domain. Currently artificial_lift has',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Artificial lift installations and repairs are capital/maintenance expenditures tracked via purchase orders. Links equipment to procurement for cost tracking, warranty management, and AFE reconciliatio',
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
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: Downtime events on EOR wells impact scheme performance and NPV. Attributing downtime to specific EOR schemes enables scheme-level deferred production reporting, performance KPI tracking, and economic ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Downtime events are caused by specific equipment failures. equipment_tag and equipment_type are denormalized plain-text columns on downtime_event. Linking to asset.equipment enables equipment reliabil',
    `field_id` BIGINT COMMENT 'FK to production.field',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Major downtime events requiring significant repair, workover, or equipment replacement are authorized via AFE as unplanned capital expenditure. O&G operators require AFE approval for workovers trigger',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Downtime events may trigger insurance claims or loss recognition posted to specific GL accounts for loss accounting, insurance recovery, and variance analysis. Required when downtime results in financ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Production downtime caused by HSE incidents (emergency shutdown triggered by incident, equipment failure from safety event) must be linked to the causative incident for root cause analysis, insurance ',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to production.injection_well. Business justification: downtime_event captures events at the well or facility level. Injection wells can experience downtime events (pump failures, mechanical integrity issues, permit violations) that cause injection deferm',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Downtime impacts partner entitlements, triggers force majeure clauses, affects AFE performance tracking, and may require partner notification under JOA terms.',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Downtime events cause production shortfalls that directly impact nomination fulfillment. Operators must link downtime to affected nominations to invoke force majeure, notify customers, calculate defer',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Planned production downtime for maintenance requires an authorizing permit-to-work. Linking downtime_event to the PTW supports work management, safety compliance verification, and post-job review of w',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline segment failures (leaks, pigging, integrity events) cause production downtime. Linking downtime_event to pipeline_segment enables pipeline-specific production deferral reporting, PHMSA incide',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Process safety events (LOPC, overpressure, ESD activation) directly cause production downtime. Linking downtime_event to process_safety_event enables production loss quantification required by API RP ',
    `production_facility_id` BIGINT COMMENT 'Identifier of the production facility experiencing downtime. Links to facility master data.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: downtime_event captures production downtime at the well or facility level. It already has production_facility_id for facility-level events but lacks a production_well_id for well-level downtime events',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Downtime deferred production under PSA affects cost-recovery period calculations and government entitlement volumes. The PSA link enables fiscal impact assessment of downtime events on contractor and ',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Downtime events cause deferred production that must be attributed to specific reservoirs for reservoir performance tracking, production accounting, and JOA partner reporting of deferred volumes by res',
    `rig_id` BIGINT COMMENT 'Foreign key linking to drilling.rig. Business justification: Workover and intervention rigs directly cause production downtime (mechanical failure, weather, rig move). Operations teams track rig-caused downtime against specific rigs for contractor performance b',
    `separator_id` BIGINT COMMENT 'Foreign key linking to production.separator. Business justification: downtime_event has equipment_tag and equipment_type as generic string attributes. Separator failures are among the most common causes of production downtime in O&G facilities. Adding separator_id enab',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Spill events (pipeline rupture, tank overflow) directly cause production downtime. Linking downtime_event to spill_event enables production loss attribution to the causative spill for insurance claims',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Downtime deferred revenue impacts are allocated to working interest partners for JIB reporting and partner notifications; the WI link enables per-partner deferred revenue calculation and partner-level',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Downtime events can trigger regulatory violations when they breach permit conditions, emission limits, or safety requirements. Product has regulatory_reportable_flag and regulatory_report_number. Enfo',
    `well_control_event_id` BIGINT COMMENT 'Foreign key linking to drilling.well_control_event. Business justification: Well control events (kicks, blowouts) during workover operations directly cause production downtime. BSEE regulatory reporting requires linking the well control incident to the resulting production im',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: When a downtime event occurs, a corrective work order is raised to restore production. Operations teams link downtime events to resolving work orders for MTTR KPI tracking, production loss attribution',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production forecasts drive budget preparation and must align with cost center structure for annual budgeting, reserves booking, investment decision-making, and long-range planning. Critical for financ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Production forecasts for crude oil are grade-specific. Reserve engineers and commercial teams build grade-specific price decks and revenue forecasts because crude grade (API gravity, sulfur) determine',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Production forecasts are built against term contract volume commitments to confirm supply adequacy. Supply planning teams use this link to assess whether forecast production meets contracted delivery ',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Production forecasts inherit initial resource estimates, EUR, and PRMS classification from discovery evaluation. Essential for reserves booking, FDP economics, and tracking forecast accuracy against o',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: forecast operates at the well, facility, or field level. Field-level production forecasts are standard in O&G for reserves reporting and development planning. Adding field_id enables direct field-leve',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to production.injection_well. Business justification: forecast covers both production and injection volumes. Injection well forecasts are critical for EOR program planning and reservoir pressure maintenance. Adding injection_well_id allows injection-spec',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Forecasts drive AFE approvals, annual budget planning, partner investment decisions, and economic limit calculations under Joint Operating Agreements.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Production forecasts are product-specific (light sweet crude vs heavy sour, dry gas vs wet gas) because pricing, transportation costs, and market demand vary by product grade. Critical for economic mo',
    `play_id` BIGINT COMMENT 'Foreign key linking to exploration.play. Business justification: Production forecasts are built at play level for upstream portfolio planning and resource assessment. Play-level forecasting is a named business process in integrated resource management, enabling com',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Production forecasts are prepared at the pooling unit level for SEC reserve reporting, unit economics, and regulatory proration allowable calculations. Reserve engineers routinely forecast by unit to ',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility or field for which this forecast applies. Links to facility master data.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: forecast covers production volumes at the well, facility, or field level. It already has production_facility_id but lacks a production_well_id in-domain FK. Well-level decline curve analysis and EUR f',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production forecasts must align with profit center structure for budgeting and planning. Strategic planning, reserves booking, investor guidance, and business unit planning all require forecast-to-pro',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Production forecasts are the revenue input to capital project economics (NPV, IRR, payback). Finance project approval gates require a linked production forecast. Project economics and FID (Final Inves',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Forecasts are essential for PSC economic modeling, cost recovery projections, government take calculations, and production bonus threshold planning.',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir or formation from which production is forecasted. Links to reservoir master data for geological and petrophysical context.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Production forecasts are built at the zone level — decline curve analysis and reservoir simulation outputs are zone-specific. Operations forecasting for multi-zone wells requires zone attribution to s',
    `shipping_schedule_id` BIGINT COMMENT 'Foreign key linking to logistics.shipping_schedule. Business justification: Production forecasts drive shipping schedule planning for the planning horizon. The shipping schedule is built from production forecast volumes — this link enables forecast-to-schedule variance analys',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Production forecasts are prepared on a working-interest basis for SEC reserves disclosure, partner planning, and JV budget preparation. The WI link enables net forecast volumes per partner and support',
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
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Injection well program AFE budget authorization: injection well drilling, completion, and workover programs require approved AFE budgets in the procurement system. O&G operators link injection wells t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Injection wells (waterflood, EOR, disposal) are cost centers with operating expenses but no direct revenue. LOE tracking, waterflood project economics, cost allocation, and environmental compliance re',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Injection wells (waterflood, EOR, disposal) originate as drilled wells. UIC permit applications require drilling data (casing design, cement bond logs, mechanical integrity). Operators track drilling ',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: Injection wells are assigned to specific EOR schemes that govern their operating parameters (pressure limits, injectant type, rate targets). This FK is fundamental — an injection wells design and reg',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: injection_well is the master record for water, gas, CO2, and disposal wells. Like producing wells, injection wells belong to a field. This is a fundamental O&G organizational relationship needed for f',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Injection well drilling and conversion projects are AFE-authorized for waterflood project tracking, capital allocation, reserves booking, and project economics. Critical for managing waterflood and EO',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Injection wells are capitalized as fixed assets (Class II UIC wells represent significant capital investment). Fixed_asset record tracks acquisition value, accumulated depreciation, and ARO for well p',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Injection wells inject into specific geological formations. UIC Class II regulatory compliance requires formation-level injection tracking. The existing injection_zone plain-text field is a denormaliz',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Injection wells require UIC Class II permits for legal operation. Compliance tracking, mechanical integrity testing, and permit renewal workflows require linking injection wells to their UIC permits. ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Injection wells are capital assets under JOAs; drilling, completion, and operating costs are allocated to partners via AFEs and JIB statements.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: UIC Class II injection wells are located on leases; EPA/state UIC permit compliance, injection volume reporting by lease, and surface use agreement compliance all require direct injection well-to-leas',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: UIC Class II injection wells require operating licenses/authorizations governing authorized injection volumes, zones, and environmental bond obligations. EPA and state UIC program compliance tracking ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Injection fluids (water, CO2, natural gas, nitrogen) must be tracked as products for EOR cost allocation, UIC permit compliance, and carbon credit accounting. Replaces denormalized injection_fluid tex',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Injection wells in waterflood and EOR programs are assigned to pooling units for injection allocation, regulatory reporting, and unit performance analysis. State agencies require unit-level injection ',
    `production_facility_id` BIGINT COMMENT 'Reference to the injection facility or water plant supplying injection fluid. Links to facility master for operational integration.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Injection wells in PSC areas require PSA link for cost recovery eligibility, EOR cost classification, and depreciation calculations under fiscal terms.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Injection well completion and workover procurement: POs fund tubulars, completion equipment, and well services for injection wells. O&G operators track the specific PO authorizing each completion/work',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Injection wells have regulatory quality specifications for injected fluids under UIC (Underground Injection Control) regulations. Water disposal wells must meet water quality specs; gas injection well',
    `reservoir_id` BIGINT COMMENT 'Reference to the target reservoir or formation receiving injection. Links to reservoir master for geological and engineering parameters.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Injection wells target specific reservoir zones for pressure maintenance and EOR. UIC Class II permit compliance requires zone-level injection reporting. injection_zone is a denormalized text field re',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Injection wells are joint-account assets with WI ownership for cost allocation in JIB statements; linking enables per-partner cost recovery tracking for injection operations and EOR program cost shari',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Waterflood/EOR injection wells source water from terminals or storage facilities. Tracks water logistics supply chain, injection volume planning, and water sourcing costs. Role-prefixed to distinguish',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Injection wells are physical well assets requiring capital accounting, integrity management, and regulatory compliance tracking in the asset register. production_well already links to well_asset; inje',
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
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Injection fluid supply contracts: long-term chemical supply agreements (CO2 purchase contracts, water disposal agreements) govern injection programs. O&G operators link injection records to the govern',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Injection well monitoring for UIC compliance requires drilling data (casing/cement integrity, injection zone isolation). Operators track injection performance against drilling cost for EOR project eco',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: EOR injection records must link to specific EOR schemes for performance tracking, incremental recovery attribution, cost allocation, partner revenue sharing under PSAs, and SEC reserves booking. Curre',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Injection records must comply with UIC permit conditions (max pressure, volume limits). Product has uic_permit_number and uic_compliance_flag. Compliance monitoring workflows require linking injection',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to production.injection_well. Business justification: injection_record captures daily injection volumes for injection wells. The injection_well is the authoritative master record for injection wells in this domain. Currently injection_record has drilling',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Injection operations incur costs (water sourcing, treatment, disposal) billed through JIB; essential for EOR cost recovery and partner allocation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Injection chemical material catalog: injection fluids (CO2, polymers, surfactants, water treatment chemicals) are cataloged in material_master with UNSPSC codes, hazmat classifications, and storage co',
    `meter_station_id` BIGINT COMMENT 'Foreign key linking to production.meter_station. Business justification: injection_record captures daily injection volumes measured at meter stations. The meter_station is the measurement point for injection volumes used in UIC compliance reporting and allocation. Linking ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Each injection record must specify the fluid product for EOR tracking, UIC regulatory reporting, and carbon sequestration verification. Replaces denormalized injection_fluid_type with FK to product sp',
    `production_facility_id` BIGINT COMMENT 'Foreign key reference to the injection facility or plant where the injection operation is managed.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Injection volumes under PSA regimes are cost-recoverable expenditures; each injection record must reference the PSA to correctly classify EOR costs for cost-recovery ceiling calculations and governmen',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Injection chemical procurement: CO2, water treatment chemicals, and EOR polymers are procured via POs. Linking injection records to the supply PO enables cost-per-barrel-injected calculations and chem',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: UIC injection records are submitted to EPA/state as regulatory submissions for Class II well compliance under 40 CFR Part 144. injection_well has regulatory_submission_id for the well; injection_recor',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir receiving the injected fluid for pressure maintenance or Enhanced Oil Recovery (EOR).',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Injection records must be attributed to specific zones for UIC regulatory compliance reporting and reservoir simulation history-matching. injection_zone_name is a denormalized text representation repl',
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
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Run tickets document the physical volume lifted against a cargo nomination. Reconciling nominated vs. actually lifted volumes is a core crude marketing process. Operators must match run ticket volumes',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation company or carrier responsible for moving the crude oil or condensate from the custody transfer point.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Run tickets are the physical custody transfer documents that settle crude volumes under commercial term contracts. Revenue recognition, volume reconciliation, and royalty calculation all require linki',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Run tickets are the primary crude oil custody transfer document. The crude grade determines the price differential applied to the transaction. Every run ticket in real O&G operations references the sp',
    `customer_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to customer.customer_lifting_schedule. Business justification: A run ticket is the physical measurement document confirming an actual lifting event. Linking run_ticket to customer_lifting_schedule enables reconciliation of scheduled vs. actual lifted volumes, bil',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Run tickets record the custody transfer location. The delivery_point defines the contractual handover location for crude sales. Pricing, measurement, and title transfer on run tickets are all delivery',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Run tickets document crude oil sales and must post to revenue GL accounts for revenue recognition, accounts receivable, sales reconciliation, and financial statement preparation. Essential for oil sal',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Run tickets document custody transfer and sales; basis for revenue allocation to partners, royalty calculations, and lifting entitlement reconciliation under JOAs.',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Run tickets document actual crude liftings; each run ticket fulfills a lifting entitlement under JOA/PSA lifting schedules. Linking run_ticket to lifting_entitlement enables real-time overlift/underli',
    `meter_station_id` BIGINT COMMENT 'Reference to the metering point or device used for volume measurement during custody transfer.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Run tickets document custody transfer of specific crude grades; product specification determines pricing differential and contract terms. Replaces denormalized product_type and crude_grade with proper',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: run_ticket documents crude oil and condensate custody transfer measurements at the tank battery/wellsite. Run tickets are typically associated with a specific producing well or lease. Currently run_ti',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Run tickets are crude oil custody transfer and sales documents. Revenue from each run ticket is attributed to a profit center for management P&L reporting. O&G revenue accounting requires profit-cente',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Run tickets document crude liftings; under PSA, each lifting must be attributed to the governing PSA for profit-oil entitlement calculation and government share settlement. run_ticket has joa_id but n',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Run tickets document crude oil custody transfer to a purchaser. The purchaser is a customer_counterparty (legal entity). Crude oil sales accounting, revenue recognition, and regulatory reporting all r',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Run tickets document crude oil sales and support royalty reporting (ONRR Form 2014) and production tax filings. Regulatory audit trails require linking run tickets to the filings they support for reve',
    `contract_id` BIGINT COMMENT 'Reference to the sales contract or offtake agreement governing the terms of this custody transfer and sale.',
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
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the gas sales or transportation contract associated with this measurement. Links measurement to commercial terms for pricing and invoicing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Gas measurement records drive gas revenue accruals and fuel-gas cost allocations posted to cost centers. Gas imbalance accounting and take-or-pay contract management require cost-center-level gas volu',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Gas measurement stations are the physical custody transfer infrastructure at delivery points. Linking gas_measurement to delivery_point enables fiscal measurement traceability, custody transfer audit ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Gas measurements drive revenue postings to GL accounts for gas sales accounting, revenue recognition, and financial statement preparation. Essential for natural gas revenue accounting and custody tran',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Gas measurements at custody transfer points drive revenue allocation, royalty calculations, partner settlements, and regulatory reporting under Joint Operating Agreements.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Gas measurement at custody transfer points is tied to leases for royalty calculation and state regulatory reporting. Revenue accounting systems require direct lease linkage on measurement records to a',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Gas measurement records document actual gas liftings against partner entitlements; linking to lifting_entitlement enables gas overlift/underlift reconciliation under PSA/JOA gas lifting schedules and ',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to logistics.measurement_point. Business justification: Gas measurement records are taken at specific fiscal measurement points defined in the logistics domain for custody transfer and FERC reporting. The measurement_point captures the regulatory and comme',
    `meter_station_id` BIGINT COMMENT 'Identifier of the meter station where the gas measurement was recorded. Links to the physical meter station asset.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: Gas measurement stations measure gas streams that contain NGL components. The specific NGL stream identity is required for NGL allocation, revenue calculation, and gas processing agreement settlements',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Gas measurement records validate actual metered volumes against pipeline nominations for daily balancing. Gas pipeline operators are contractually required to confirm nomination fulfillment via measur',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Gas custody transfer measurements must identify the product (sales gas, fuel gas, NGL) for contract settlement and BTU-based pricing. Required for pipeline quality specifications and commercial counte',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Gas measurement records at meter stations validate actual metered volumes against pipeline nominations for gas balancing and imbalance tracking. FERC and PHMSA regulatory reporting requires matching m',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Gas measurement points are located on pipeline segments for custody transfer, pipeline balancing, and PHMSA regulatory reporting. Linking gas_measurement to pipeline_segment enables pipeline-level thr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Gas measurement volumes drive profit-center-level gas revenue recognition. Management reporting of gas sales by asset/field requires linking measured volumes to profit centers — standard O&G managemen',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Gas measurement records feed PSA gas-profit-split calculations and domestic market obligation (DMO) tracking. Under PSA regimes, measured gas volumes must be attributed to the PSA for fiscal gas entit',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.quality_spec. Business justification: Gas measurement at fiscal/custody transfer points must comply with pipeline quality specifications (BTU content, H2S limits, CO2 limits, water content). Pipeline tariff agreements specify gas quality ',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`flare_record` (
    `flare_record_id` BIGINT COMMENT 'Unique identifier for the flare record. Primary key for the flare_record product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Flared gas represents economic loss and environmental liability tracked by cost center for carbon tax calculations, regulatory penalty assessment, loss reporting, and environmental compliance. Critica',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Flare reporting for GHG compliance and royalty valuation requires well identification (API number) from drilling records. Operators track flared gas against well economics and drilling cost for projec',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Flares are permitted emission sources with capacity limits, monitoring requirements (flow meters, gas composition), and emission factors. Critical for Title V permit compliance, emission inventory, an',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Flare records must be attributed to specific flare tip equipment for EPA/BSEE emissions reporting, equipment performance tracking, and regulatory compliance. Flare stacks and tips are registered in as',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: When flaring is avoided through gas capture, gas is routed to terminals for processing/sales. Tracks gas conservation initiatives, monetization opportunities, and environmental compliance. Supports fl',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to hse.ghg_emission. Business justification: Flaring is a direct GHG emission source requiring quantification for EPA GHGRP Subpart W (petroleum and natural gas systems). Essential for annual GHG inventory, EPA e-GGRT submission, and ESG disclos',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Flared gas losses and environmental penalties post to specific GL accounts for loss recognition, environmental liability accounting, and regulatory reporting. Required for carbon tax accruals and envi',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Flaring impacts partner entitlements (lost revenue), regulatory compliance obligations, environmental liabilities, and may trigger JOA reporting requirements or penalties.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: State oil and gas commissions require flare volume reporting by lease. Flare allowance tracking, regulatory variance requests, and royalty deduction calculations for flared gas all require direct leas',
    `meter_station_id` BIGINT COMMENT 'Identifier of the flow meter or measurement device used to quantify flared gas volume, if direct measurement was used.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Flared gas composition (sales gas, associated gas, sour gas) determines GHG emissions factors for EPA GHGRP reporting and carbon tax calculations. Product linkage provides heating value and emission f',
    `previous_flare_record_id` BIGINT COMMENT 'Self-referencing FK on flare_record (previous_flare_record_id)',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where the flaring event occurred.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Flared volumes reduce cost-recoverable production under many PSAs and must be reported to the host government. The PSA link is required for fiscal impact reporting and government audit of flare losses',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Flare events require regulatory notification and submission to EPA/state agencies under NSPS OOOOa and Title V permit conditions. flare_record has compliance_regulatory_filing_id but not a direct hse.',
    `reservoir_id` BIGINT COMMENT 'Reference to the specific reservoir from which the flared gas originated, if applicable.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Flare records require zone-level attribution for GHG emissions regulatory reporting (EPA Subpart W) and gas composition tracking. flare_record already has reservoir_id but zone-level flare attribution',
    `well_control_event_id` BIGINT COMMENT 'Foreign key linking to drilling.well_control_event. Business justification: Emergency flaring is frequently triggered by well control events (kicks, blowouts, pressure surges). EPA and BSEE regulatory reporting requires linking emergency flare volumes to the causative well co',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`separator` (
    `separator_id` BIGINT COMMENT 'Unique identifier for the production separator equipment. Primary key for the separator master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Separators are capital assets with depreciation and maintenance costs tracked by cost center for fixed asset accounting, maintenance budget tracking, and asset retirement obligation (ARO) calculations',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to hse.emission_source. Business justification: Separators are registered emission sources under EPA NSPS OOOOa/OOOOb and Title V permits (fugitive emissions, pressure relief valves). Linking separator to emission_source enables equipment-level emi',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Separators are pressure vessels requiring API 510 inspection programs, integrity management, and maintenance tracking. Links operational separator to equipment registry for inspection scheduling, fitn',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Separator procurement and installation is authorized via AFE as capital expenditure. separator has installation_cost_usd indicating tracked capex. AFE authorization is required before separator purcha',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Separators are capitalized as fixed assets and depreciated over their useful life. separator has replacement_value_usd and installation_cost_usd confirming capital nature. Fixed_asset record tracks de',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Separators are facility assets; capital costs (installation, replacement) and operating costs (maintenance, inspection) are allocated to partners under JOA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Separator manufacturers are vendors for procurement, warranty claims, spare parts sourcing, and vendor qualification. Manufacturer field is denormalized string. Role prefix distinguishes from facility',
    `parent_separator_id` BIGINT COMMENT 'Self-referencing FK on separator (parent_separator_id)',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where this separator is installed. Links to production_facility master record.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Separators are capital assets whose installation and operating costs are recovered under PSA cost-recovery schedules. Linking separator to PSA enables capex cost-recovery tracking and government audit',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Asset procurement lifecycle: the PO that procured the separator is required for asset capitalization, warranty tracking, and COPAS cost classification. O&G asset registers always link installed equipm',
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
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Meter stations are the physical measurement infrastructure at custody transfer delivery points. This link enables fiscal metering traceability, custody transfer audit, and regulatory measurement repor',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Meter stations contain custody transfer equipment requiring calibration, proving, and regulatory compliance (API MPMS). Links measurement system to equipment registry for calibration scheduling, audit',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Meter station construction and installation is capital expenditure authorized via AFE. Fiscal measurement stations represent significant capital investment requiring AFE approval before construction. ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Meter stations are capitalized as fixed assets and depreciated. Fiscal measurement stations (custody transfer points) represent significant capital investment tracked in fixed_asset for depreciation, ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Meter stations are custody transfer points; critical for partner allocation, revenue distribution, royalty calculations, and fiscal measurement under Joint Operating Agreements.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Meter manufacturers are vendors for procurement, calibration services, spare parts, and vendor performance tracking. Manufacturer field is denormalized string. Role prefix distinguishes from operator.',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to logistics.measurement_point. Business justification: Production meter stations correspond to logistics measurement points for fiscal custody transfer and FERC/PHMSA regulatory reporting. The meter_station IS the physical measurement point — this link en',
    `parent_meter_station_id` BIGINT COMMENT 'Self-referencing FK on meter_station (parent_meter_station_id)',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Fiscal and custody transfer meter stations require regulatory measurement permits (BSEE measurement approvals, state metering permits). meter_station.regulatory_permit_number is a denormalized text fi',
    `production_facility_id` BIGINT COMMENT 'Reference to the production facility where this meter station is located.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Fiscal metering stations under PSA regimes must be attributed to the governing PSA for government measurement verification and audit. The PSA link enables traceability of fiscal measurement infrastruc',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Asset procurement lifecycle: fiscal and custody-transfer meter stations must be traceable to their procurement PO for asset capitalization, calibration certification, and regulatory audit. Standard O&',
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
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether measurements from this meter station must be included in regulatory production reports to BSEE, state agencies, or other governing bodies.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this meter station is integrated with SCADA systems for real-time monitoring and data acquisition.',
    `state_province` STRING COMMENT 'State or province jurisdiction where the meter station is located, relevant for regulatory reporting.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the meter station for identification in operational systems and regulatory filings.',
    `station_name` STRING COMMENT 'Business name or designation of the meter station for operational reference and reporting.',
    `station_type` STRING COMMENT 'Classification of the meter station based on its primary business function: fiscal (revenue measurement), allocation (production distribution), custody transfer (ownership change point), check (verification), proving (calibration), or test (well testing).. Valid values are `fiscal|allocation|custody_transfer|check|proving|test`',
    CONSTRAINT pk_meter_station PRIMARY KEY(`meter_station_id`)
) COMMENT 'Master record for fiscal and allocation metering stations at production facilities, capturing meter type, calibration schedule, proving records, and measurement uncertainty';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`production`.`field` (
    `field_id` BIGINT COMMENT 'Primary key for field',
    `assay_id` BIGINT COMMENT 'Foreign key linking to product.assay. Business justification: Fields are characterized by representative crude assays used for commercial planning, refinery supply agreements, and long-term crude marketing. Field-level assay data drives refinery compatibility as',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field-level operating costs (LOE, workovers, field maintenance) are tracked to cost centers for opex reporting and budget variance analysis. O&G cost management requires linking the field entity to it',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Oil fields produce a primary crude grade that defines the fields commercial identity. crude_grade.origin_field_name is a denormalized field confirming this relationship. Field-level crude grade drive',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Oil and gas fields require field-level emergency response plans under OPA 90, SPCC, and state regulations. Linking field to emergency_response_plan enables field-level ERP management, drill compliance',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Fields operate under operating licenses defining the authorized area, production capacity, and royalty terms — especially in PSA/concession regimes. Field-level license administration is the primary u',
    `play_id` BIGINT COMMENT 'Foreign key linking to exploration.play. Business justification: Fields are classified within plays for portfolio management, PRMS resource classification, and exploration-to-production lifecycle reporting. Play-level field grouping is standard in upstream asset ma',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fields are the primary profit center unit in O&G — all production revenue, royalties, and LOE costs are attributed at the field level. Field-level P&L reporting, reserve valuation, and asset performan',
    `classification` STRING COMMENT 'Current operational classification of the field.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the field is located.',
    `county` STRING COMMENT 'County or district containing the field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the field record was first created in the system.',
    `cumulative_gas_produced` DECIMAL(18,2) COMMENT 'Total gas produced to date, measured in thousand standard cubic feet (Mscf).',
    `cumulative_oil_produced` DECIMAL(18,2) COMMENT 'Total oil produced to date, measured in barrels.',
    `current_production_bopd` DECIMAL(18,2) COMMENT 'Current oil production rate in barrels of oil per day.',
    `depth_ft` STRING COMMENT 'Average true vertical depth of the field in feet.',
    `discovery_date` DATE COMMENT 'Date the field was first discovered.',
    `field_code` STRING COMMENT 'Unique alphanumeric code assigned to the field by the company.',
    `field_description` STRING COMMENT 'Free‑form description of the fields characteristics and history.',
    `field_name` STRING COMMENT 'Human‑readable name of the oil or gas field.',
    `field_status` STRING COMMENT 'Current lifecycle status of the field.',
    `field_type` STRING COMMENT 'Geological/operational classification of the field.',
    `first_production_date` DATE COMMENT 'Date the field produced its first oil or gas.',
    `gas_oil_ratio` DECIMAL(18,2) COMMENT 'Ratio of gas produced to oil produced, measured in standard cubic feet per barrel.',
    `joint_venture_share_percent` DECIMAL(18,2) COMMENT 'Percentage ownership interest held by joint‑venture partners.',
    `last_production_date` DATE COMMENT 'Date of the most recent production reporting.',
    `last_report_date` DATE COMMENT 'Date the most recent regulatory report was filed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the fields central point.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the fields central point.',
    `notes` STRING COMMENT 'Additional remarks, operational notes, or exceptions related to the field.',
    `regulatory_status` STRING COMMENT 'Current compliance status with applicable regulatory bodies.',
    `reporting_status` STRING COMMENT 'Status of the fields required regulatory reporting.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate applied to production, expressed as a percent.',
    `state_province` STRING COMMENT 'State or province of the field location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the field record.',
    `water_cut_percent` DECIMAL(18,2) COMMENT 'Percentage of water in the produced fluid stream.',
    CONSTRAINT pk_field PRIMARY KEY(`field_id`)
) COMMENT 'Master reference table for field. Referenced by field_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_artificial_lift_id` FOREIGN KEY (`artificial_lift_id`) REFERENCES `oil_gas_ecm`.`production`.`artificial_lift`(`artificial_lift_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_separator_id` FOREIGN KEY (`separator_id`) REFERENCES `oil_gas_ecm`.`production`.`separator`(`separator_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_separator_id` FOREIGN KEY (`separator_id`) REFERENCES `oil_gas_ecm`.`production`.`separator`(`separator_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_meter_station_id` FOREIGN KEY (`meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_previous_flare_record_id` FOREIGN KEY (`previous_flare_record_id`) REFERENCES `oil_gas_ecm`.`production`.`flare_record`(`flare_record_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_parent_separator_id` FOREIGN KEY (`parent_separator_id`) REFERENCES `oil_gas_ecm`.`production`.`separator`(`separator_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_parent_meter_station_id` FOREIGN KEY (`parent_meter_station_id`) REFERENCES `oil_gas_ecm`.`production`.`meter_station`(`meter_station_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` SET TAGS ('dbx_subdomain' = 'well_activities');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `farmout_id` SET TAGS ('dbx_business_glossary_term' = 'Farmout Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `mineral_right_id` SET TAGS ('dbx_business_glossary_term' = 'Mineral Right Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Well Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `api_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `artificial_lift_type` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Type');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Latitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Longitude');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `daily_production_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Production ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `artificial_lift_id` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `separator_id` SET TAGS ('dbx_business_glossary_term' = 'Separator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test ID');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'test_based|meter_based|proportional|estimated|manual');
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
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Allocation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `offtake_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `monthly_production_id` SET TAGS ('dbx_business_glossary_term' = 'Monthly Production ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `offtake_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'State Agency Report ID');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct_measurement|proration|well_test|estimated');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
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
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` SET TAGS ('dbx_subdomain' = 'well_activities');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `artificial_lift_id` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Installation ID');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `completion_design_id` SET TAGS ('dbx_business_glossary_term' = 'Completion Design Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` SET TAGS ('dbx_subdomain' = 'well_activities');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event ID');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `field_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `separator_id` SET TAGS ('dbx_business_glossary_term' = 'Separator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `well_control_event_id` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` SET TAGS ('dbx_subdomain' = 'measurement_reporting');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `shipping_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` SET TAGS ('dbx_subdomain' = 'injection_management');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` SET TAGS ('dbx_subdomain' = 'injection_management');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Fluid Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` SET TAGS ('dbx_subdomain' = 'measurement_reporting');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `run_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `customer_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Purchaser Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` SET TAGS ('dbx_subdomain' = 'measurement_reporting');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `gas_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Measurement ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Station ID');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` SET TAGS ('dbx_subdomain' = 'measurement_reporting');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `flare_record_id` SET TAGS ('dbx_business_glossary_term' = 'Flare Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Destination Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `previous_flare_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ALTER COLUMN `well_control_event_id` SET TAGS ('dbx_business_glossary_term' = 'Well Control Event Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`separator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `separator_id` SET TAGS ('dbx_business_glossary_term' = 'Separator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `parent_separator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `meter_station_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `parent_meter_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Code');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Name');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Station Type');
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'fiscal|allocation|custody_transfer|check|proving|test');
ALTER TABLE `oil_gas_ecm`.`production`.`field` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`production`.`field` SET TAGS ('dbx_subdomain' = 'well_activities');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`production`.`field` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
