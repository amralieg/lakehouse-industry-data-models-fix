-- Schema for Domain: asset | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`asset` COMMENT 'Serves as the SSOT for physical asset lifecycle management across all facilities — wells, pipelines, FPSOs, compressors, CDUs, and processing plants. Manages asset registry, technical specifications, performance monitoring, integrity management, CAPEX/OPEX classification, DD&A schedules, preventive and corrective maintenance via Maximo CMMS, ISO 55001-aligned asset integrity programs, MOC workflows, turnaround planning, and equipment reliability (MTBF/MTTR). Integrates with Maximo Asset Management and GIS systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset_facility` (
    `asset_facility_id` BIGINT COMMENT 'Unique identifier for the facility asset. Primary key for the facility master registry.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Facilities constructed or modified under AFE authorization for capital expenditure tracking, depreciation basis, and asset capitalization. Essential for financial reporting, joint venture cost allocat',
    `asset_class_id` BIGINT COMMENT 'FK to asset.asset_class',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Facilities operated by third-party operators (common in oil-and-gas) require tracking the operator entity for operational responsibility, HSE accountability, regulatory reporting (operator of record),',
    `field_id` BIGINT COMMENT 'Foreign key linking to asset.field. Business justification: Asset facilities belong to a geological field; adding field_id FK enables facility‑to‑field association.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Facilities must link to fixed asset master for depreciation, accumulated depreciation tracking, and impairment testing - required for property, plant & equipment accounting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Facility capitalization requires GL account for balance sheet classification, depreciation method determination, and financial statement presentation - required for property, plant & equipment account',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Facilities are licensed and designed for specific product types (refinery units for specific crude slates, terminals for specific product grades). Required for regulatory permit compliance, operationa',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Facilities are profit-generating assets requiring profit center assignment for segment reporting, EBITDA calculation, and business unit performance measurement - required for management accounting and',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Facility-level asset accounting, ARO calculations, and depreciation are subject to SOX controls. Financial reporting requirement for material asset balances.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Cumulative depreciation, depletion, and amortization expense recognized since commissioning. Used to calculate net book value and assess remaining asset value.',
    `actual_decommissioning_date` DATE COMMENT 'Actual date when the facility was permanently shut down and decommissioning activities commenced. Triggers final ARO accounting entries and regulatory closure reporting.',
    `asset_retirement_obligation` DECIMAL(18,2) COMMENT 'Estimated present value of future decommissioning and site restoration costs required by regulation or contract. Accrued as a liability and adjusted annually for accretion and estimate changes.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the design capacity field. Varies by facility type: BOPD (Barrels of Oil Per Day) for production, MCFD (Thousand Cubic Feet per Day) for gas, BPD (Barrels Per Day) for refining.. Valid values are `bopd|mcfd|mmcfd|bpd|tpd|mmbtu_per_day`',
    `capex_opex_designation` STRING COMMENT 'Primary accounting classification for facility-related expenditures. Determines whether costs are capitalized and depreciated or expensed immediately per GAAP/IFRS accounting standards.. Valid values are `capex|opex|mixed`',
    `commissioning_date` DATE COMMENT 'Date when the facility was officially placed into commercial service and began contributing to production or processing operations. Marks the start of depreciation schedules and operational performance tracking.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the sovereign jurisdiction where the facility is located. Determines applicable tax regime, regulatory framework, and reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `county_district` STRING COMMENT 'County, district, or local administrative subdivision where the facility is located. Used for local permitting, property tax assessment, and emergency response coordination.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this facility record was first created in the master data registry. Used for data lineage, audit trails, and data governance compliance.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation, depletion, and amortization for the facility asset. Determines annual DD&A expense recognition and impacts financial statement presentation.. Valid values are `straight_line|units_of_production|declining_balance|sum_of_years_digits`',
    `design_capacity` DECIMAL(18,2) COMMENT 'Maximum rated throughput or production capacity of the facility as designed and permitted. Expressed in facility-appropriate units (BOPD for oil, MCFD for gas, barrels per day for refining).',
    `environmental_permit_number` STRING COMMENT 'Unique identifier for the primary environmental permit covering air emissions, water discharge, waste management, or other environmental compliance requirements.',
    `facility_code` STRING COMMENT 'Unique alphanumeric business identifier for the facility used across operational systems, regulatory filings, and joint venture reporting. Typically follows company-specific or API coding standards.. Valid values are `^[A-Z0-9]{4,12}$`',
    `facility_name` STRING COMMENT 'Official business name of the facility as registered with regulatory authorities and used in operational documentation.',
    `facility_type` STRING COMMENT 'Classification of the facility based on its primary operational function within the oil and gas value chain. Determines applicable regulatory frameworks, HSE requirements, and asset management protocols. [ENUM-REF-CANDIDATE: wellpad|compressor_station|fpso|lng_terminal|refinery|petrochemical_plant|processing_plant|storage_facility|pipeline_station|offshore_platform — 10 candidates stripped; promote to reference product]',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking the facility to its spatial representation in the corporate GIS system. Enables map-based visualization, spatial analysis, and integration with land/lease data.',
    `hse_tier` STRING COMMENT 'Risk-based classification of the facility for HSE management purposes. Higher tiers indicate greater hazard potential and require more stringent safety protocols, inspection frequency, and emergency response capabilities.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `iso_55001_classification` STRING COMMENT 'Asset criticality classification per ISO 55001 asset management framework. Drives maintenance strategy, inspection frequency, integrity management protocols, and risk mitigation investment prioritization.. Valid values are `critical|essential|important|support`',
    `last_integrity_assessment_date` DATE COMMENT 'Date of the most recent comprehensive integrity assessment or inspection conducted per API 580 risk-based inspection protocols. Used to schedule next inspection and assess compliance status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this facility record. Supports change tracking, data synchronization, and audit compliance requirements.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility in decimal degrees format. Used for GIS integration, spatial analysis, emergency response planning, and regulatory jurisdiction determination.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility in decimal degrees format. Used for GIS integration, spatial analysis, emergency response planning, and regulatory jurisdiction determination.',
    `maximo_location_code` STRING COMMENT 'Unique location identifier in the Maximo CMMS system. Links facility master data to work orders, preventive maintenance schedules, and asset hierarchy for maintenance management.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that performed the most recent modification to this facility record. Supports audit trails and data stewardship accountability.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the facility on the balance sheet, calculated as original cost minus accumulated depreciation. Used for impairment testing and financial reporting.',
    `next_turnaround_date` DATE COMMENT 'Scheduled date for the next major planned shutdown and turnaround maintenance event. Critical for production planning, budget forecasting, and contractor mobilization.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the facility indicating its operational readiness and production capability. Drives production allocation, OPEX classification, and regulatory reporting obligations.. Valid values are `operating|standby|maintenance|suspended|decommissioned|under_construction`',
    `original_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the facility at the time of commissioning, including construction, equipment, installation, and pre-operational expenses. Forms the basis for depreciation calculations.',
    `pi_system_tag_prefix` STRING COMMENT 'Standardized prefix used for all OSIsoft PI System tags associated with this facility. Enables consistent data historian queries and cross-facility analytics.',
    `planned_decommissioning_date` DATE COMMENT 'Projected date for facility retirement and decommissioning based on reserves depletion, economic life, or regulatory requirements. Used for asset retirement obligation (ARO) calculations and long-term planning.',
    `process_safety_tier` STRING COMMENT 'API RP 754 process safety event classification tier for the facility. Determines incident reporting thresholds, investigation requirements, and performance indicator tracking.. Valid values are `pst_1|pst_2|pst_3|pst_4`',
    `record_status` STRING COMMENT 'Current status of this master data record in the data governance lifecycle. Controls visibility in operational systems and reporting applications.. Valid values are `active|inactive|archived|pending_approval`',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority governing the facility operations. Determines which agency standards apply for permitting, inspection, and compliance reporting (e.g., BSEE for offshore, state commissions for onshore).. Valid values are `federal|state|provincial|offshore|tribal|international`',
    `scada_integration_status` STRING COMMENT 'Status of facility integration with centralized SCADA or DCS systems for real-time monitoring and control. Impacts operational visibility, alarm management, and remote operations capability.. Valid values are `integrated|partial|not_integrated|planned`',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the facility is located. Used for state-level regulatory compliance, tax allocation, and environmental permitting.',
    `useful_life_years` STRING COMMENT 'Estimated economic useful life of the facility in years for depreciation calculation purposes. Based on engineering assessments, reserves life, and historical asset performance data.',
    CONSTRAINT pk_asset_facility PRIMARY KEY(`asset_facility_id`)
) COMMENT 'Master registry of all physical facilities operated by Oil Gas, including upstream wellpads, midstream compressor stations, FPSOs, LNG terminals, refineries, petrochemical plants, and processing plants. Captures facility type, geographic coordinates, regulatory jurisdiction, operational status, ISO 55001 asset management classification, CAPEX/OPEX designation, commissioning date, and decommissioning plan. Serves as the top-level anchor for all asset hierarchy relationships and integrates with GIS systems for spatial context.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Unique identifier for the equipment asset. Primary key for the equipment master record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility or plant where this equipment is installed. Links to the facility master record for location hierarchy and organizational assignment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment ownership/responsibility assignment to cost centers enables depreciation allocation, maintenance cost tracking, and asset accountability - fundamental for fixed asset accounting and cost con',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Equipment must link to fixed asset master for depreciation calculation, net book value tracking, and impairment testing - fundamental fixed asset accounting requirement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Equipment capitalization requires GL account assignment for fixed asset classification, depreciation posting, and balance sheet reporting - fundamental GAAP/IFRS fixed asset accounting requirement.',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Equipment may operate under facility-level or equipment-specific licenses requiring tracking for compliance audits and operational authorization verification.',
    `parent_equipment_id` BIGINT COMMENT 'Reference to the parent equipment in a hierarchical asset structure. Used to model equipment assemblies and sub-components (e.g., a pump as part of a larger processing unit).',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Equipment is designed and operated for specific product service (pumps for crude, compressors for gas). Critical for material compatibility verification, corrosion monitoring programs, and fitness-for',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Tracks original equipment manufacturer/supplier for warranty management, spare parts sourcing, technical support, and vendor performance. Critical for lifecycle asset management and procurement of com',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'The original purchase and installation cost of the equipment in US dollars. Used for asset valuation and depreciation calculations.',
    `api_equipment_class` STRING COMMENT 'The API standard classification code for the equipment type, used for standardized categorization across the oil and gas industry.',
    `asset_number` STRING COMMENT 'The unique asset number assigned in Maximo CMMS for tracking and maintenance management. This is the externally-known business identifier used across maintenance, integrity, and production domains.',
    `capacity_unit` STRING COMMENT 'The unit of measure for the rated capacity. BOPD (Barrels of Oil Per Day), MCFD (Thousand Cubic Feet per Day), HP (Horsepower), GPM (Gallons Per Minute), BBL (Barrels), CFM (Cubic Feet per Minute), KW (Kilowatts), MW (Megawatts). [ENUM-REF-CANDIDATE: BOPD|MCFD|HP|GPM|BBL|CFM|KW|MW|other — 9 candidates stripped; promote to reference product]',
    `capex_classification` STRING COMMENT 'The capital expenditure category under which this equipment was acquired or installed. Used for financial tracking and investment analysis.. Valid values are `new_installation|replacement|upgrade|expansion|sustaining|regulatory`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this equipment record was first created in the system. Used for data lineage and audit trail purposes.',
    `criticality_ranking` STRING COMMENT 'The business criticality classification of the equipment based on its impact on production, safety, and environmental risk. Used to prioritize maintenance and inspection activities.. Valid values are `critical|high|medium|low`',
    `depreciation_method` STRING COMMENT 'The accounting method used to depreciate the equipment asset over its useful life. Used for financial reporting and tax compliance.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `design_code` STRING COMMENT 'The engineering design code or standard under which the equipment was designed and fabricated (e.g., ASME Section VIII Division 1, API 650, ANSI B16.5). Used for compliance verification and inspection planning.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'The maximum allowable working pressure (MAWP) for which the equipment was designed, measured in pounds per square inch (PSI). Critical for integrity management and safe operation.',
    `design_temperature_f` DECIMAL(18,2) COMMENT 'The maximum or minimum design temperature rating for the equipment, measured in degrees Fahrenheit. Used for material selection and operating envelope definition.',
    `driver_type` STRING COMMENT 'The type of prime mover or driver that powers the equipment (e.g., electric motor, steam turbine, gas turbine, diesel engine). [ENUM-REF-CANDIDATE: electric_motor|steam_turbine|gas_turbine|diesel_engine|hydraulic|pneumatic|manual|other — 8 candidates stripped; promote to reference product]',
    `equipment_name` STRING COMMENT 'The descriptive name or title of the equipment asset for human-readable identification.',
    `equipment_type` STRING COMMENT 'The primary classification of equipment based on its function and design. CDU (Crude Distillation Unit), VDU (Vacuum Distillation Unit), FCC (Fluid Catalytic Cracking), BOP (Blowout Preventer). [ENUM-REF-CANDIDATE: CDU|VDU|FCC|compressor|pump|heat_exchanger|BOP_stack|wellhead|separator|turbine|vessel|reactor|column|furnace|boiler|cooler|filter|valve|instrument|piping|electrical|structural|other — 23 candidates stripped; promote to reference product]',
    `heat_duty_mmbtu_hr` DECIMAL(18,2) COMMENT 'The heat transfer rate or thermal duty of heat exchangers, furnaces, and other thermal equipment, measured in million BTU per hour (MMBTU/hr).',
    `installation_date` DATE COMMENT 'The date when the equipment was installed and commissioned at the facility. Used for calculating asset age and depreciation schedules.',
    `insulation_type` STRING COMMENT 'The type of thermal insulation applied to the equipment (e.g., mineral wool, calcium silicate, foam glass, ceramic fiber). Used for energy efficiency and personnel protection.',
    `is_environmental_critical` BOOLEAN COMMENT 'Indicates whether this equipment has environmental protection functions (e.g., emissions control, spill containment) requiring regulatory compliance tracking.',
    `is_safety_critical` BOOLEAN COMMENT 'Indicates whether this equipment is classified as safety-critical under HSE (Health Safety and Environment) regulations, requiring enhanced inspection and maintenance protocols.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent integrity inspection or assessment performed on the equipment. Used for compliance tracking and risk-based inspection planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this equipment record was last updated. Used for change tracking and data quality monitoring.',
    `maintenance_strategy` STRING COMMENT 'The primary maintenance approach applied to this equipment based on its criticality and failure modes. Aligns with ISO 55001 asset management best practices.. Valid values are `preventive|predictive|condition_based|run_to_failure|reliability_centered`',
    `material_of_construction` STRING COMMENT 'The primary material or alloy used in the construction of the equipment (e.g., carbon steel, stainless steel 316L, Inconel, duplex). Critical for corrosion management and integrity assessment.',
    `moc_required` BOOLEAN COMMENT 'Indicates whether any modifications to this equipment require formal Management of Change (MOC) review and approval under process safety management regulations.',
    `model_number` STRING COMMENT 'The manufacturers model or type designation for this equipment, used to identify design specifications and spare parts compatibility.',
    `motor_rating_hp` DECIMAL(18,2) COMMENT 'The horsepower rating of the electric motor or driver associated with rotating equipment such as pumps, compressors, and fans.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'The average time between equipment failures, measured in operating hours. A key reliability metric used for maintenance planning and performance benchmarking.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'The average time required to repair the equipment and return it to service after a failure, measured in hours. Used for maintenance resource planning and availability analysis.',
    `next_inspection_due_date` DATE COMMENT 'The scheduled date for the next required integrity inspection based on regulatory requirements, risk assessment, or manufacturer recommendations.',
    `nozzle_configuration` STRING COMMENT 'Description of the inlet, outlet, and auxiliary nozzle configuration for vessels and process equipment, including sizes, ratings, and orientations.',
    `operational_status` STRING COMMENT 'The current operational state of the equipment in its lifecycle. Indicates whether the equipment is actively producing, on standby, undergoing maintenance, or permanently retired. [ENUM-REF-CANDIDATE: operating|standby|maintenance|shutdown|decommissioned|under_construction|testing — 7 candidates stripped; promote to reference product]',
    `pm_frequency_days` STRING COMMENT 'The scheduled interval in days between preventive maintenance activities for this equipment. Drives work order generation in Maximo CMMS.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'The design or nameplate capacity of the equipment in appropriate units (e.g., barrels per day for processing units, cubic feet for vessels, horsepower for compressors). Represents the maximum throughput or performance capability.',
    `serial_number` STRING COMMENT 'The unique serial number assigned by the manufacturer to this specific equipment unit for traceability and warranty purposes.',
    `tag` STRING COMMENT 'The engineering tag number or equipment designation used in P&ID (Piping and Instrumentation Diagrams) and process flow diagrams. Follows plant-specific tagging conventions.',
    `useful_life_years` STRING COMMENT 'The estimated useful life of the equipment in years for depreciation and lifecycle planning purposes.',
    `vendor_datasheet_reference` STRING COMMENT 'The document reference number or identifier for the vendors technical datasheet containing detailed specifications, performance curves, and operating parameters.',
    `warranty_expiration_date` DATE COMMENT 'The date when the manufacturers warranty coverage for this equipment expires. Used for maintenance cost planning and vendor claim management.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Master record for every individual piece of physical equipment tracked in Maximo CMMS, including CDUs, VDUs, FCC units, compressors, pumps, heat exchangers, BOP stacks, wellheads, separators, and turbines. Stores Maximo asset number, equipment tag, manufacturer, model, serial number, API equipment classification, installation date, design pressure/temperature ratings (MAWP), material of construction, applicable design code (ASME VIII/ANSI/API), rated capacity, motor rating, driver type, criticality ranking, and current operational status. Includes detailed technical specification data (nozzle configuration, insulation type, heat duty, vendor datasheet reference). This is the SSOT for equipment identity and engineering design data across maintenance, integrity, and production domains.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`well_asset` (
    `well_asset_id` BIGINT COMMENT 'Unique identifier for the well asset record within the asset management system. Primary key for the well asset entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Wells are physical assets that should link to the asset.facility master registry. well_asset currently has production_facility_id pointing to production domain (operational facility), but needs facili',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wells must be assigned to cost centers for production cost allocation, LOE tracking, and lifting cost calculation - fundamental for upstream cost accounting and reserves economics.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Wells produce specific crude grades with distinct API gravity and sulfur content. Essential for production accounting, reserves booking (SEC compliance), revenue allocation in JV operations, and pipel',
    `field_id` BIGINT COMMENT 'FK to asset.field',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Wells must link to fixed asset master for DD&A calculation, depletion unit tracking, and ceiling test compliance - mandated by oil-and-gas accounting standards.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Well capitalization requires GL account for proved/unproved property classification, DD&A calculation, and SEC full-cost ceiling test - mandated by oil-and-gas accounting standards.',
    `lease_id` BIGINT COMMENT 'Identifier of the oil and gas lease or mineral rights agreement under which this well operates. Links well asset to land and lease management system for royalty calculations and revenue distribution.',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Wells operate under production licenses, injection licenses, or concession agreements. Direct regulatory requirement for well operations in oil & gas.',
    `operator_id` BIGINT COMMENT 'FK to land.operator',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Wells require drilling, completion, operating, and injection permits. Core regulatory requirement in oil & gas. Existing permit_number column should be removed for normalization.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wells generate revenue and must be assigned to profit centers for reserves accounting, production revenue allocation, and field-level profitability analysis - core upstream financial management requir',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Wells are completed in specific reservoirs - fundamental relationship for production allocation, reserves booking, and well performance analysis. Production allocation by reservoir, reserves booking b',
    `api_number` STRING COMMENT 'Unique 10-14 digit API well identifier assigned by regulatory authorities following API standards. Format: state code (2 digits), county code (3 digits), unique well number (5 digits), optional sidetrack code (2 digits). Serves as the authoritative external identifier for regulatory reporting and cross-system integration.. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `artificial_lift_type` STRING COMMENT 'Type of artificial lift system installed to enhance production: none (natural flow), rod pump (sucker rod pumping), ESP (electric submersible pump), gas lift, plunger lift, PCP (progressive cavity pump), or hydraulic pump. Critical for production optimization and OPEX planning. [ENUM-REF-CANDIDATE: none|rod_pump|esp|gas_lift|plunger_lift|pcp|hydraulic_pump — 7 candidates stripped; promote to reference product]',
    `asset_retirement_obligation_usd` DECIMAL(18,2) COMMENT 'Estimated present value of future plugging and abandonment costs in USD, calculated per ASC 410-20 or IFRS IAS 37. Accrued liability for eventual well decommissioning, updated annually based on cost escalation and discount rate changes.',
    `capex_classification` STRING COMMENT 'Primary capital expenditure category for this well asset: drilling (initial wellbore construction), completion (well completion and stimulation), facilities (surface equipment), workover (major interventions), or enhancement (artificial lift installation). Used for CAPEX tracking and DD&A schedule assignment.. Valid values are `drilling|completion|facilities|workover|enhancement`',
    `completion_date` DATE COMMENT 'Date when well completion operations were finalized and the well was ready for production or injection. Marks the transition from drilling/completion phase to operational phase and triggers asset capitalization for DD&A purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this well asset record was first created in the asset management system. Audit trail for data lineage and SOX compliance.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this well asset record originated (e.g., Maximo Asset Management, Quorum Land System, regulatory database). Used for data lineage tracking and reconciliation.',
    `dda_method` STRING COMMENT 'Accounting method used for depreciation, depletion, and amortization of well capital costs: unit of production (reserves-based), straight line (time-based), or declining balance. Determines annual DD&A expense recognition.. Valid values are `unit_of_production|straight_line|declining_balance`',
    `environmental_classification` STRING COMMENT 'Environmental setting classification for HSE risk assessment and regulatory compliance: onshore, offshore shallow water, offshore deepwater, arctic, or environmentally sensitive area. Drives HSE requirements, insurance premiums, and ARO estimates.. Valid values are `onshore|offshore_shallow|offshore_deepwater|arctic|sensitive_area`',
    `estimated_ultimate_recovery_boe` DECIMAL(18,2) COMMENT 'Estimated total recoverable hydrocarbons from this well over its entire productive life, expressed in barrels of oil equivalent. Used for reserves reporting, economic analysis, and production forecasting.',
    `first_production_date` DATE COMMENT 'Date when the well first produced hydrocarbons to sales or storage. Critical for reserves booking, SEC reporting, and production decline curve analysis.',
    `h2s_present_flag` BOOLEAN COMMENT 'Boolean indicator of whether hydrogen sulfide gas is present in produced fluids. Critical for HSE planning, personnel safety requirements, and corrosion management programs.',
    `integrity_status` STRING COMMENT 'Current well integrity assessment status: compliant (meets all integrity standards), non-compliant (integrity issues identified), pending review (inspection results under evaluation), or remediation required (corrective action needed). Critical for HSE risk management and regulatory compliance.. Valid values are `compliant|non_compliant|pending_review|remediation_required`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent well integrity inspection or mechanical integrity test (MIT). Critical for regulatory compliance, HSE risk management, and preventive maintenance scheduling per ISO 55001 asset integrity programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this well asset record was most recently updated. Audit trail for change tracking and data governance.',
    `maximo_asset_number` STRING COMMENT 'Cross-reference identifier linking this well asset to its corresponding asset record in Maximo Asset Management system. Enables integration of well lifecycle data with CMMS work orders, preventive maintenance schedules, and asset integrity programs.',
    `net_revenue_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest after deducting royalties, overriding royalties, and other burdens from working interest. Represents the actual share of production revenue received. Critical for reserves valuation and economic analysis.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required well integrity inspection or mechanical integrity test. Used for compliance tracking and preventive maintenance planning in Maximo CMMS.',
    `norm_classification` STRING COMMENT 'Classification level of naturally occurring radioactive material risk: none, low, moderate, or high. Impacts waste handling procedures, worker safety protocols, and decommissioning costs.. Valid values are `none|low|moderate|high`',
    `plugged_abandoned_date` DATE COMMENT 'Date when the well was permanently plugged and abandoned according to regulatory requirements. Marks the end of the wells operational lifecycle and triggers asset retirement obligation (ARO) settlement.',
    `record_status` STRING COMMENT 'Lifecycle status of this data record in the lakehouse: active (current and valid), archived (historical but retained), deleted (soft delete for audit trail), or pending approval (awaiting data steward review). Used for data governance and quality management.. Valid values are `active|archived|deleted|pending_approval`',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the regulatory authority or jurisdiction governing this well (e.g., Texas Railroad Commission, BSEE Gulf of Mexico, Alberta Energy Regulator). Determines applicable regulations, reporting requirements, and permitting processes.',
    `reserves_category` STRING COMMENT 'SPE PRMS reserves classification: PDP (proved developed producing), PDNP (proved developed non-producing), PUD (proved undeveloped), probable, possible, or unproved. Determines reserves booking eligibility and SEC disclosure requirements.. Valid values are `PDP|PDNP|PUD|probable|possible|unproved`',
    `spud_date` DATE COMMENT 'Date when drilling operations commenced and the drill bit first penetrated the surface. Marks the official start of well construction and is a key milestone for AFE tracking and regulatory reporting.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the wellhead surface location in decimal degrees (WGS84 datum). Used for GIS mapping, spatial analysis, and regulatory reporting.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the wellhead surface location in decimal degrees (WGS84 datum). Used for GIS mapping, spatial analysis, and regulatory reporting.',
    `total_capex_usd` DECIMAL(18,2) COMMENT 'Cumulative capital expenditure invested in this well asset from spud through completion and subsequent enhancements, in USD. Basis for depreciation, depletion, and amortization (DD&A) calculations and economic performance analysis.',
    `total_depth_md` DECIMAL(18,2) COMMENT 'Total measured depth of the wellbore from surface to total depth (TD) in feet or meters, following the actual path of the wellbore including any deviation. Used for drilling cost analysis and wellbore integrity assessment.',
    `total_depth_tvd` DECIMAL(18,2) COMMENT 'True vertical depth of the wellbore from surface to total depth in feet or meters, representing the straight-line vertical distance. Used for reservoir pressure calculations and subsurface mapping.',
    `well_name` STRING COMMENT 'Human-readable business name or designation for the well, typically including lease name, well number, and sometimes operator-specific naming conventions (e.g., Smith Unit 1H, Eagle Ford A-23).',
    `well_status` STRING COMMENT 'Current lifecycle status of the well asset: active (producing/injecting), shut-in (temporarily closed but capable of production), plugged and abandoned (P&A - permanently decommissioned), drilling (under construction), completing (completion operations in progress), testing (under evaluation), suspended (long-term inactive), or inactive (not currently operational). [ENUM-REF-CANDIDATE: active|shut_in|plugged_abandoned|drilling|completing|testing|suspended|inactive — 8 candidates stripped; promote to reference product]',
    `well_type` STRING COMMENT 'Primary functional classification of the well based on its operational purpose: producer (oil/gas extraction), injector (water/gas/steam injection for EOR/IOR), disposal (produced water disposal), observation (monitoring), suspended (temporarily inactive), or dry hole (non-commercial).. Valid values are `producer|injector|disposal|observation|suspended|dry_hole`',
    `wellbore_trajectory` STRING COMMENT 'Classification of the wellbore path geometry: vertical (straight down), directional (deviated at angle), horizontal (extended lateral section), or multilateral (multiple laterals from single wellbore). Impacts drilling costs, production performance, and completion design.. Valid values are `vertical|directional|horizontal|multilateral`',
    `wellhead_equipment_tag` STRING COMMENT 'Unique equipment tag identifier for the wellhead assembly in the asset registry. Links the well asset to physical wellhead equipment records in Maximo CMMS for maintenance tracking and integrity management.',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of working interest ownership held by the operator or reporting entity in this well. Represents the share of capital costs and operating expenses borne, as well as the share of production before royalties. Used for CAPEX/OPEX allocation and joint interest billing.',
    CONSTRAINT pk_well_asset PRIMARY KEY(`well_asset_id`)
) COMMENT 'Master asset record for each wellbore as a physical infrastructure asset, distinct from the drilling and reservoir domains which own subsurface and completion data. Captures well API number, well name, well type (producer/injector/disposal/observation), surface location coordinates, spud date, completion date, current well status (active/shut-in/P&A), artificial lift type, wellhead equipment tag, and Maximo asset linkage. Serves as the SSOT for well identity within the asset lifecycle management context.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` (
    `pipeline_segment_id` BIGINT COMMENT 'Primary key for pipeline_segment',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Pipeline construction/modification authorized under AFE for capital expenditure tracking, depreciation, and rate base determination. Essential for midstream financial reporting, FERC/regulatory filing',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Pipeline segments certified under integrity management programs (API 1160, 1163, DOT 192/195). Links asset integrity to certification compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline segments require cost center assignment for integrity spending allocation, depreciation tracking, and PHMSA compliance cost reporting - standard midstream asset accounting practice.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Pipeline segments operated by third parties require tracking the operator entity for integrity management, PHMSA regulatory compliance (operator identification), incident reporting, and operational ac',
    `employee_id` BIGINT COMMENT 'Identifier of the legal owner of the pipeline asset, relevant for joint ventures and production sharing agreements.',
    `ferc_tariff_id` BIGINT COMMENT 'Foreign key linking to compliance.ferc_tariff. Business justification: Pipeline segments operate under FERC tariffs for interstate transportation. Direct regulatory and commercial requirement linking asset operations to rate schedules.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Pipeline segments must link to fixed asset master for depreciation, net book value tracking, and regulatory rate base determination - standard midstream asset accounting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pipeline capitalization requires GL account for gathering/transmission asset classification, depreciation posting, and regulatory rate base determination - standard midstream accounting practice.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline segments require construction, right-of-way, and operating permits from PHMSA and state agencies. Fundamental regulatory requirement. Existing permit_number should be normalized.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pipeline segments transport specific products with material compatibility requirements and regulatory classification (hazardous liquid vs gas). Critical for batch scheduling, interface management, PHM',
    `partner_id` BIGINT COMMENT 'Identifier of the operating entity or business unit responsible for the operation and maintenance of this pipeline segment.',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'Original capital expenditure (CAPEX) for acquiring or constructing the pipeline segment, measured in USD, used for asset valuation and depreciation.',
    `book_value_usd` DECIMAL(18,2) COMMENT 'Current net book value of the pipeline segment after depreciation, depletion, and amortization (DD&A), measured in USD.',
    `cathodic_protection_type` STRING COMMENT 'Type of cathodic protection system installed to prevent external corrosion on the pipeline segment.. Valid values are `impressed_current|sacrificial_anode|none|hybrid`',
    `coating_type` STRING COMMENT 'Type of external coating applied to the pipeline for corrosion protection (e.g., fusion bonded epoxy, polyethylene, coal tar).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the pipeline segment is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipeline segment record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the pipeline segment was or is planned to be decommissioned and removed from active service.',
    `depreciation_method` STRING COMMENT 'Accounting method used for calculating depreciation, depletion, and amortization (DD&A) of the pipeline asset.. Valid values are `straight_line|declining_balance|units_of_production`',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum allowable design pressure for the pipeline segment measured in PSI, established during engineering design per ASME B31 codes.',
    `fluid_service_type` STRING COMMENT 'Type of fluid transported through the pipeline segment, determining operational parameters, corrosion management, and regulatory classification. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|water|multiphase|ngl|condensate|co2 — 7 candidates stripped; promote to reference product]',
    `from_node_location` STRING COMMENT 'Starting point or origin node of the pipeline segment, typically a facility, wellhead, or junction point identifier.',
    `geographic_region` STRING COMMENT 'Geographic region or basin where the pipeline segment is located, used for operational reporting and regional analysis.',
    `hca_flag` BOOLEAN COMMENT 'Boolean indicator whether the pipeline segment traverses or is located within a High Consequence Area as defined by PHMSA regulations.',
    `inspection_method` STRING COMMENT 'Primary inspection or assessment method used for integrity evaluation (e.g., inline inspection, hydrostatic test, direct assessment).',
    `installation_date` DATE COMMENT 'Date when the pipeline segment was originally installed and placed into service, critical for age-based integrity assessments and depreciation schedules.',
    `installation_year` STRING COMMENT 'Year the pipeline segment was installed, used for quick age-based filtering and vintage analysis in integrity management programs.',
    `integrity_status` STRING COMMENT 'Current integrity assessment status based on inspection, testing, and risk evaluation programs per pipeline integrity management requirements.. Valid values are `good|fair|poor|critical|unknown`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent integrity inspection or assessment performed on the pipeline segment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pipeline segment record was last updated or modified.',
    `material_grade` STRING COMMENT 'API 5L material grade specification of the pipeline (e.g., X42, X52, X60, X65, X70) indicating minimum yield strength and chemical composition.',
    `maximo_asset_number` STRING COMMENT 'Asset number assigned in Maximo CMMS for work order management, preventive maintenance scheduling, and asset lifecycle tracking.',
    `maximum_operating_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum operating pressure (MOP) at which the pipeline segment is permitted to operate under normal conditions, measured in PSI.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required integrity inspection based on regulatory requirements and risk-based inspection intervals.',
    `nominal_diameter_inches` DECIMAL(18,2) COMMENT 'Nominal inside diameter of the pipeline segment measured in inches, a key specification for flow capacity and design.',
    `operational_status` STRING COMMENT 'Current operational state of the pipeline segment in its asset lifecycle.. Valid values are `active|inactive|standby|decommissioned|under_construction`',
    `phmsa_regulatory_class` STRING COMMENT 'PHMSA location class designation (Class 1-4) or High Consequence Area (HCA) classification determining inspection frequency and operational requirements.. Valid values are `class_1|class_2|class_3|class_4|hca`',
    `pipeline_name` STRING COMMENT 'Name of the overall pipeline system to which this segment belongs, used for grouping and reporting purposes.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the pipeline segment based on consequence and probability of failure analysis per integrity management programs.',
    `scada_tag_code` STRING COMMENT 'SCADA system tag identifier linking the pipeline segment to real-time monitoring and control systems for operational data integration.',
    `segment_length_miles` DECIMAL(18,2) COMMENT 'Physical length of the pipeline segment measured in miles, used for capacity calculations, maintenance planning, and regulatory reporting.',
    `segment_number` STRING COMMENT 'Business identifier for the pipeline segment, typically assigned by engineering or operations for external reference and field identification.',
    `segment_type` STRING COMMENT 'Classification of the pipeline segment based on its operational function within the production and transportation network.. Valid values are `gathering|transmission|distribution|injection|flowline|export`',
    `state_province` STRING COMMENT 'State or province jurisdiction where the pipeline segment is located, relevant for regulatory compliance and permitting.',
    `to_node_location` STRING COMMENT 'Ending point or destination node of the pipeline segment, typically a facility, delivery point, or junction identifier.',
    `useful_life_years` STRING COMMENT 'Estimated useful life of the pipeline segment in years for depreciation and asset lifecycle planning purposes.',
    `wall_thickness_inches` DECIMAL(18,2) COMMENT 'Nominal wall thickness of the pipe measured in inches, critical for pressure rating and structural integrity calculations.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Percentage of working interest held in the pipeline asset, relevant for joint operating agreements and cost allocation.',
    CONSTRAINT pk_pipeline_segment PRIMARY KEY(`pipeline_segment_id`)
) COMMENT 'Master record for each discrete pipeline segment managed as an asset, including gathering lines, transmission pipelines, and injection flowlines. Captures segment ID, pipeline name, from/to node locations, nominal pipe diameter, wall thickness, material grade (API 5L), design pressure, operating pressure, fluid service (crude/gas/water/multiphase), installation year, PHMSA regulatory class, cathodic protection type, and current integrity status. Integrates with GIS for spatial routing and PHMSA compliance reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for the asset hierarchy relationship record. Primary key for the asset hierarchy entity.',
    `asset_id` BIGINT COMMENT 'Reference to the child asset in the hierarchy tree. Links to the asset master record representing the lower-level organizational unit (equipment, component, or instrument).',
    `parent_asset_id` BIGINT COMMENT 'Reference to the parent asset in the hierarchy tree. Links to the asset master record representing the higher-level organizational unit (facility, system, or equipment).',
    `work_center_id` BIGINT COMMENT 'Maintenance work center responsible for executing preventive and corrective maintenance on assets within this hierarchical relationship. Links to CMMS work center master data for maintenance planning and scheduling.',
    `approval_date` DATE COMMENT 'Date when the hierarchical relationship change was formally approved through MOC or asset management governance process.',
    `approved_by` STRING COMMENT 'Name or identifier of the authority who approved the hierarchical relationship change. Required for MOC-controlled assets and safety-critical hierarchy modifications.',
    `asset_class` STRING COMMENT 'Depreciation, Depletion, and Amortization (DD&A) asset class for financial accounting purposes. Determines depreciation method, useful life, and capitalization threshold for assets in this hierarchical relationship.',
    `change_reason` STRING COMMENT 'Business justification or reason code for establishing or modifying the hierarchical relationship. Examples include turnaround reconfiguration, asset relocation, organizational restructuring, MOC implementation, decommissioning.',
    `cost_center` STRING COMMENT 'Financial cost center to which maintenance and operating expenses for this hierarchical relationship are allocated. Aligns with SAP Controlling (CO) cost center master data for OPEX and CAPEX tracking.',
    `cost_rollup_flag` BOOLEAN COMMENT 'Indicates whether maintenance costs, operating expenses (OPEX), and capital expenditures (CAPEX) from the child asset should be aggregated to the parent asset for financial reporting. True enables cost consolidation, False isolates cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the asset hierarchy relationship record was first created in the system. Supports audit trail and data lineage tracking.',
    `criticality_rating` STRING COMMENT 'Risk-based criticality classification of the hierarchical relationship for asset integrity management. Critical indicates safety-critical or production-critical assets requiring enhanced inspection and maintenance. Aligns with ISO 55001 risk-based asset management.. Valid values are `critical|high|medium|low`',
    `depth` STRING COMMENT 'Total number of levels from the root asset to the child asset in this relationship. Supports complexity analysis and organizational structure metrics.',
    `effective_date` DATE COMMENT 'Date when the hierarchical relationship became active and valid for operational use. Supports temporal tracking of asset organizational changes, turnarounds, and Management of Change (MOC) workflows.',
    `end_date` DATE COMMENT 'Date when the hierarchical relationship was terminated or superseded. Null indicates the relationship is currently active. Supports historical analysis of asset configuration changes and decommissioning tracking.',
    `functional_location_code` STRING COMMENT 'SAP Plant Maintenance (PM) functional location identifier representing the process-based organizational position of the child asset within the parent. Aligns with SAP S/4HANA PM module functional location master data.',
    `geographic_location_code` STRING COMMENT 'Geographic location identifier for the hierarchical relationship, typically representing field, platform, or facility location. Supports spatial analysis and GIS integration for asset mapping and logistics planning.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child asset within the organizational hierarchy tree. Level 1 typically represents facility, Level 2 represents system, Level 3 represents equipment, Level 4 represents component. Enables roll-up aggregation and drill-down analysis.',
    `hierarchy_status` STRING COMMENT 'Current lifecycle status of the hierarchical relationship. Active indicates the relationship is currently valid, inactive indicates temporary suspension, pending indicates awaiting MOC approval, superseded indicates replaced by a new relationship, archived indicates historical record retention.. Valid values are `active|inactive|pending|superseded|archived`',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchical relationship structure. Functional location represents process-based organization, physical location represents geographic organization, cost rollup represents financial reporting structure, operational hierarchy represents production organization, maintenance hierarchy represents CMMS work order structure, safety hierarchy represents HSE responsibility structure.. Valid values are `functional_location|physical_location|cost_rollup|operational_hierarchy|maintenance_hierarchy|safety_hierarchy`',
    `hse_classification` STRING COMMENT 'Health, Safety, and Environment classification of the hierarchical relationship. Safety critical indicates assets subject to BSEE or OSHA safety case requirements, environmental critical indicates assets subject to EPA emissions monitoring, process safety indicates assets covered by PSM regulations.. Valid values are `safety_critical|environmental_critical|process_safety|standard`',
    `integrity_management_program` STRING COMMENT 'Asset integrity management program governing inspection, testing, and maintenance requirements for assets in this hierarchical relationship. Examples include pipeline integrity management, pressure vessel inspection programs, rotating equipment reliability programs.',
    `joint_venture_code` STRING COMMENT 'Joint venture or joint operating agreement (JOA) identifier for assets subject to joint interest billing and partner cost allocation. Links to SAP Joint Venture Accounting for AFE and JIB processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the asset hierarchy relationship record was most recently updated. Supports change tracking and audit compliance.',
    `moc_reference_number` STRING COMMENT 'Management of Change workflow reference number authorizing the creation or modification of this hierarchical relationship. Links to Enablon HSE Management MOC tracking system.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this hierarchical relationship require formal Management of Change (MOC) approval workflow. True for safety-critical and process-safety assets subject to OSHA PSM or API RP 754 MOC requirements.',
    `notes` STRING COMMENT 'Free-text notes and comments providing additional context about the hierarchical relationship, including special maintenance considerations, operational constraints, or historical configuration information.',
    `operating_unit` STRING COMMENT 'Business operating unit or division responsible for assets within this hierarchical branch. Supports multi-entity reporting for integrated oil and gas companies with upstream, midstream, downstream, and petrochemical divisions.',
    `path` STRING COMMENT 'Concatenated string representation of the full hierarchical path from root to child asset, typically using delimiter-separated asset codes or identifiers. Enables rapid ancestor queries and breadcrumb navigation. Example: FACILITY-01/SYSTEM-CDU/EQUIPMENT-PUMP-123/COMPONENT-SEAL-456.',
    `performance_rollup_flag` BOOLEAN COMMENT 'Indicates whether performance metrics, reliability indicators (MTBF, MTTR), and availability statistics from the child asset should be aggregated to the parent asset for operational reporting. True enables performance consolidation.',
    `planner_group` STRING COMMENT 'Maintenance planning group assigned to manage work orders and preventive maintenance schedules for assets in this hierarchical branch. Supports maintenance resource allocation and workload balancing.',
    `primary_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this is the primary hierarchical relationship for the child asset when multiple hierarchy types exist. True designates the authoritative organizational structure for default reporting and navigation.',
    `profit_center` STRING COMMENT 'Financial profit center responsible for revenue and cost performance of assets within this hierarchical branch. Supports segment reporting and business unit profitability analysis.',
    `relationship_type` STRING COMMENT 'Semantic nature of the parent-child relationship. Contains indicates containment, consists of indicates composition, part of indicates membership, installed in indicates physical mounting, connected to indicates interface linkage, feeds into indicates process flow, supports indicates dependency. [ENUM-REF-CANDIDATE: contains|consists_of|part_of|installed_in|connected_to|feeds_into|supports — 7 candidates stripped; promote to reference product]',
    `sort_sequence` STRING COMMENT 'Display order sequence number for child assets within the same parent in user interfaces and reports. Enables custom ordering of sibling assets for operational dashboards and maintenance schedules.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Working interest ownership percentage for the operating company in joint venture assets within this hierarchical relationship. Determines cost allocation and revenue distribution for joint interest billing.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the parent-child hierarchical relationships among assets in the Maximo CMMS asset tree, enabling roll-up of maintenance costs, failure events, and performance metrics from component level up to facility level. Captures parent asset reference, child asset reference, hierarchy level (facility → system → equipment → component), effective date, end date, and hierarchy type (functional location, physical location, or cost-rollup). Supports ISO 55001 asset management structure and SAP PM functional location hierarchy. Essential for organizational reporting and maintenance cost allocation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record in the Computerized Maintenance Management System (CMMS). Primary key for the work order entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Work orders require AFE authorization for capital/operating expenditure tracking, cost center allocation, and joint venture billing. Essential for financial controls and audit trails in oil & gas capi',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset (well, pipeline, FPSO, compressor, CDU, processing plant, equipment unit) against which this maintenance work is being performed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders must charge labor, materials, and contractor costs to cost centers for accounting control, budget variance analysis, and LOE tracking - fundamental financial requirement in oil-and-gas ope',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Work orders on customer-owned assets or JV facilities require tracking the customer/partner entity for cost allocation, billing, JV accounting, and AFE reconciliation—standard in joint venture operati',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Work orders are most commonly executed on equipment in Maximo CMMS. Currently work_order has polymorphic asset_id. Adding equipment_id provides typed FK for equipment work orders (most common case). N',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Work orders may execute under regulatory permits (hot work permits in compliance system, confined space permits). Tracks permit-controlled work beyond PTW system.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Work orders often involve product-specific activities: tank cleaning for grade changes, contamination incident response, product-specific corrosion repairs. Needed for root cause analysis, cost alloca',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Work orders executed at production facilities for equipment maintenance, turnarounds, and modifications. Direct FK enables facility-level maintenance reporting (facility downtime, maintenance cost per',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Work orders target production wells for interventions (workovers, stimulations, artificial lift changes). Direct FK enables operational reporting (production impact analysis, well downtime tracking) w',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Work orders directly consume materials and services procured via purchase orders. Critical for three-way matching (PO-GR-Invoice), cost reconciliation, and tracking actual vs. estimated costs in maint',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital work orders must be tracked to WBS elements for project cost control, AFE variance analysis, and investment program reporting - required for capital project accounting.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Work orders are executed on wells (workovers, interventions, artificial lift maintenance). Currently work_order has polymorphic asset_id. Adding well_asset_id provides typed FK for well-specific work ',
    `actual_contractor_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for third-party contractor services upon work completion. Used for OPEX tracking and Joint Interest Billing (JIB) allocation.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when work was completed and asset returned to service. Used for MTTR calculation and PM schedule compliance measurement.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended on the work order upon completion. Used for OPEX tracking and maintenance performance measurement (MTTR calculation).',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual cost of materials, parts, and consumables consumed during work order execution. Used for OPEX tracking and Lease Operating Expense (LOE) allocation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution commenced. Used for Mean Time To Repair (MTTR) calculation and maintenance performance tracking.',
    `assigned_craft` STRING COMMENT 'Primary maintenance craft or discipline required to execute the work. Mechanical: rotating equipment, piping, vessels. Electrical: power systems, motors. Instrumentation: control systems, sensors. Civil: structures, foundations. Operations: operator-performed maintenance. Multi-discipline: requires multiple crafts.. Valid values are `mechanical|electrical|instrumentation|civil|operations|multi_discipline`',
    `capex_opex_classification` STRING COMMENT 'Financial classification of the work order costs. OPEX: routine maintenance charged to Lease Operating Expense (LOE). CAPEX: capital improvement or life extension charged to Authorization for Expenditure (AFE) and subject to Depreciation Depletion and Amortization (DD&A).. Valid values are `OPEX|CAPEX`',
    `completion_notes` STRING COMMENT 'Detailed notes documenting the work performed, findings, parts replaced, test results, and any follow-up actions required. Critical for asset history tracking and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was initially created in the CMMS. Used for audit trail and work order aging analysis.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours the asset was out of service due to this maintenance activity. Used for Non-Productive Time (NPT) tracking and production loss calculation.',
    `equipment_condition_after` STRING COMMENT 'Assessment of the asset condition after maintenance completion. Used to validate maintenance effectiveness and update asset health scores.. Valid values are `excellent|good|fair|poor|critical`',
    `equipment_condition_before` STRING COMMENT 'Assessment of the asset condition prior to maintenance work. Used for condition-based maintenance analytics and Mean Time Between Failures (MTBF) tracking.. Valid values are `excellent|good|fair|poor|critical`',
    `estimated_contractor_cost` DECIMAL(18,2) COMMENT 'Planned cost for third-party contractor services if the work is outsourced. Null for work performed by internal crews.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete the work order, used for resource planning and OPEX budgeting.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Planned cost of materials, parts, and consumables required for the work order. Denominated in the operating entitys functional currency (typically USD for international oil and gas operations).',
    `inspection_due_date` DATE COMMENT 'Regulatory or integrity management deadline by which this inspection or maintenance activity must be completed to maintain compliance and asset integrity certification.',
    `isolation_plan` STRING COMMENT 'Detailed description of the isolation points, lockout devices, and energy control procedures required to safely isolate the asset for maintenance. References specific valves, breakers, and isolation points.',
    `isolation_required` BOOLEAN COMMENT 'Indicates whether the asset requires isolation (lockout/tagout) from energy sources, process fluids, or utilities before work can safely commence. True if isolation is required.',
    `joint_venture_allocation_flag` BOOLEAN COMMENT 'Indicates whether the work order costs must be allocated to joint venture partners per Working Interest (WI) and Net Revenue Interest (NRI) shares. True if joint venture cost allocation is required.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the work order. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last updated. Used for audit trail and change tracking.',
    `moc_reference_number` STRING COMMENT 'Reference to the Management of Change (MOC) approval if this work order involves modifications to asset design, operating parameters, or safety systems. Required for compliance with OSHA PSM and API RP 750.. Valid values are `^MOC-[0-9]{6}$`',
    `permit_to_work_number` STRING COMMENT 'Reference number of the safety permit authorizing the work. Required for all work involving hazardous operations, confined spaces, hot work, or isolation. Managed through Enablon HSE Management system.. Valid values are `^PTW-[0-9]{6}$`',
    `priority` STRING COMMENT 'Business priority level assigned to the work order based on safety impact, production impact, and asset criticality. Critical: immediate safety or production threat. High: significant impact. Medium: moderate impact. Low: minimal impact.. Valid values are `critical|high|medium|low`',
    `production_impact_boe` DECIMAL(18,2) COMMENT 'Estimated production loss in Barrels of Oil Equivalent (BOE) due to asset downtime during this maintenance activity. Used for NPT cost analysis and maintenance optimization.',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Indicates whether this work order fulfills a regulatory inspection requirement mandated by BSEE, API, PHMSA, or other governing body. True if regulatory-driven.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a Health Safety and Environment (HSE) incident occurred during work order execution. True if an incident was reported.',
    `scheduled_finish_date` DATE COMMENT 'Planned date for work order completion. Used for maintenance scheduling and production planning to minimize Non-Productive Time (NPT).',
    `scheduled_start_date` DATE COMMENT 'Planned date for work order execution to begin. Used for maintenance scheduling, resource planning, and turnaround coordination.',
    `work_order_description` STRING COMMENT 'Detailed description of the maintenance work to be performed, including scope, objectives, and any special instructions or safety considerations.',
    `work_order_number` STRING COMMENT 'Business-facing unique work order number assigned by Maximo CMMS for tracking and reference. Format: WO-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^WO-[0-9]{8}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order. Draft: initial creation. Approved: authorized for execution. Scheduled: planned with resources. In Progress: work underway. On Hold: temporarily suspended. Completed: work finished. Closed: administratively closed with costs finalized. Cancelled: work order voided. [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|on_hold|completed|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `work_type` STRING COMMENT 'Classification of the maintenance work being performed. Preventive: scheduled routine maintenance per PM plan. Corrective: repair of identified failure. Predictive: condition-based maintenance triggered by monitoring. Inspection: regulatory or integrity inspection. Turnaround: major planned shutdown. Emergency: unplanned critical repair.. Valid values are `preventive|corrective|predictive|inspection|turnaround|emergency`',
    `created_by` STRING COMMENT 'User ID or name of the person who created the work order. Used for audit trail and accountability.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Maximo CMMS work order record capturing all planned and unplanned maintenance activities executed against assets. Includes work order number, work type (preventive/corrective/predictive/inspection/turnaround), priority, originating failure report or PM plan trigger, assigned craft/crew, estimated and actual labor hours, estimated and actual material costs, scheduled start/finish, actual start/finish, work order status, safety permit reference (PTW), isolation requirements, and completion notes. Core transactional entity for OPEX tracking, maintenance performance measurement (MTTR), and PM schedule compliance. Links to equipment master, failure reports, and PM plans.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` (
    `preventive_maintenance_plan_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance plan. Primary key.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: PM plans support certifications (ISO 55001, API certifications). Provides audit evidence that maintenance programs meet certification requirements.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: PM plans often executed under service contracts (e.g., rotating equipment maintenance, inspection services). Links planned maintenance strategy to contracted vendor obligations, rates, and SLA terms f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM plans require cost center assignment for maintenance budget allocation, variance analysis, and LOE forecasting - essential for integrity program financial planning and cost control.',
    `equipment_id` BIGINT COMMENT 'Reference to the physical asset (well, pipeline, FPSO, compressor, CDU, processing plant, equipment unit) to which this preventive maintenance plan applies.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline segments have PM plans (cathodic protection surveys, valve maintenance, ROW inspections). Currently preventive_maintenance_plan only has equipment_id. Adding pipeline_segment_id enables defin',
    `employee_id` BIGINT COMMENT 'Reference to the maintenance planner or engineer responsible for maintaining and optimizing this preventive maintenance plan.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: PM plans cover facility-level systems (process safety equipment, fire/gas systems, SCADA). Direct FK enables facility maintenance planning, turnaround scheduling, and regulatory compliance (PSM inspec',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: PM plans target production wells for routine maintenance (wellhead inspections, tubing integrity, artificial lift servicing). Direct FK enables well-level PM scheduling, compliance tracking (regulator',
    `tertiary_preventive_approved_by_employee_id` BIGINT COMMENT 'Reference to the asset integrity engineer or maintenance manager who approved this preventive maintenance plan for implementation.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Wells have PM plans (routine inspections, artificial lift maintenance schedules). Currently preventive_maintenance_plan only has equipment_id. Adding well_asset_id enables defining PM plans for wells.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance plan was formally approved for implementation.',
    `capex_opex_classification` STRING COMMENT 'Financial classification of this preventive maintenance activity: CAPEX (capital expenditure for major overhauls or life extension), OPEX (operating expenditure for routine maintenance), or LOE (lease operating expense for production assets).. Valid values are `CAPEX|OPEX|LOE`',
    `condition_monitoring_requirement` STRING COMMENT 'Description of condition monitoring techniques and parameters required to support this preventive maintenance plan (e.g., vibration analysis, thermography, ultrasonic testing, oil analysis, corrosion monitoring, pressure/temperature trending from PI System).',
    `cost_benefit_justification` STRING COMMENT 'Business justification for this preventive maintenance plan, documenting the expected benefits (reduced downtime, extended asset life, safety improvement, regulatory compliance) relative to the cost of execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance plan record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this preventive maintenance plan expires or is retired. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this preventive maintenance plan becomes active and begins generating scheduled work orders.',
    `environmental_critical_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this preventive maintenance plan is for an environmentally-critical asset or system (e.g., spill containment, emissions control, LDAR equipment) requiring environmental compliance oversight.',
    `estimated_contractor_cost` DECIMAL(18,2) COMMENT 'Estimated third-party contractor cost in USD for this preventive maintenance activity, if external services are required (e.g., specialized inspection, NDT services, equipment rental).',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required to complete the preventive maintenance activity, used for scheduling and resource planning.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated labor cost in USD for executing this preventive maintenance activity, used for budgeting and cost-benefit analysis. Includes craft labor, supervision, and support personnel.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated material and spare parts cost in USD for this preventive maintenance activity, used for budgeting and inventory planning.',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval: calendar units (days, weeks, months, years) or usage-based units (operating hours, cycles, barrels processed, cubic feet produced). [ENUM-REF-CANDIDATE: days|weeks|months|years|operating_hours|cycles|barrels_processed|cubic_feet_produced — 8 candidates stripped; promote to reference product]',
    `frequency_value` STRING COMMENT 'Numeric value representing the interval between preventive maintenance activities. Interpreted in conjunction with frequency_unit (e.g., 30 for 30 days, 500 for 500 operating hours).',
    `last_completed_date` DATE COMMENT 'The date when the most recent preventive maintenance work order generated from this plan was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this preventive maintenance plan record was last updated or revised.',
    `maintenance_strategy_type` STRING COMMENT 'The governing maintenance strategy philosophy for this plan: run-to-failure (reactive), time-based (fixed interval), condition-based (triggered by condition monitoring), predictive (using analytics/AI), reliability-centered (RCM methodology), or risk-based (prioritized by risk assessment).. Valid values are `run_to_failure|time_based|condition_based|predictive|reliability_centered|risk_based`',
    `mean_time_between_failures` DECIMAL(18,2) COMMENT 'Historical or target Mean Time Between Failures (MTBF) in hours for the asset covered by this preventive maintenance plan, used to optimize maintenance intervals and assess reliability improvement.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Historical or target Mean Time To Repair (MTTR) in hours for the asset covered by this preventive maintenance plan, used for downtime planning and resource allocation.',
    `moc_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether execution of this preventive maintenance plan requires a formal Management of Change (MOC) review due to potential impact on process safety, equipment design, or operating procedures.',
    `next_scheduled_date` DATE COMMENT 'The next calendar date when a preventive maintenance work order is scheduled to be generated based on this plan.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the preventive maintenance plan, used for reference in Maximo CMMS and operational documentation.',
    `plan_name` STRING COMMENT 'Human-readable descriptive name of the preventive maintenance plan.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance plan: active (generating work orders), inactive (not generating work orders), suspended (temporarily paused), under_review (being revised), or obsolete (retired).. Valid values are `active|inactive|suspended|under_review|obsolete`',
    `priority_level` STRING COMMENT 'Business priority level for this preventive maintenance plan, reflecting the criticality of the asset and the consequence of maintenance deferral.. Valid values are `critical|high|medium|low`',
    `ptw_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether execution of this preventive maintenance activity requires a formal Permit to Work (PTW) due to hazardous conditions (e.g., hot work, confined space entry, energized electrical work, work at height).',
    `rcm_analysis_reference` STRING COMMENT 'Reference to the Reliability-Centered Maintenance (RCM) analysis document or study that supports the maintenance strategy and frequency defined in this plan.',
    `regulatory_inspection_requirement` STRING COMMENT 'Applicable regulatory inspection standards and requirements that this preventive maintenance plan must satisfy (e.g., BSEE offshore inspection, PHMSA pipeline integrity, API RP 510 pressure vessel inspection, API RP 570 piping inspection, API RP 653 storage tank inspection).',
    `required_craft_skills` STRING COMMENT 'Comma-separated list of craft skills or trade qualifications required to execute this preventive maintenance plan (e.g., Instrumentation Technician, Mechanical Fitter, Electrical Engineer, NDT Inspector, API 510 Inspector).',
    `safety_critical_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this preventive maintenance plan is for a safety-critical asset or system (e.g., BOP, pressure relief valve, fire suppression system, H2S detection system) requiring heightened oversight and compliance.',
    `spare_parts_list` STRING COMMENT 'Comma-separated list of spare part numbers or material codes required for this preventive maintenance activity, used for inventory planning and procurement.',
    `task_list_reference` STRING COMMENT 'Reference to the detailed task list or job plan in Maximo CMMS that defines the step-by-step procedures, safety precautions, and quality checks for this preventive maintenance activity.',
    `trigger_type` STRING COMMENT 'The mechanism that triggers work order generation: calendar (time-based schedule), meter (usage-based such as operating hours or cycles), condition (threshold breach from monitoring), or hybrid (combination of triggers).. Valid values are `calendar|meter|condition|hybrid`',
    `turnaround_planning_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this preventive maintenance activity is part of a planned turnaround or major shutdown event, requiring coordination with production scheduling and multi-discipline planning.',
    `work_order_type` STRING COMMENT 'The Maximo work order type code that will be assigned to work orders generated from this preventive maintenance plan (e.g., PM, INSP, CALIB, LUBE).',
    CONSTRAINT pk_preventive_maintenance_plan PRIMARY KEY(`preventive_maintenance_plan_id`)
) COMMENT 'Defines scheduled preventive maintenance (PM) programs and the governing maintenance strategy for assets in Maximo. Captures strategy type (run-to-failure/time-based/condition-based/predictive/reliability-centered), PM frequency, trigger type (calendar/meter/condition), task list, required craft skills, estimated duration, required spare parts references, applicable regulatory inspection requirements (BSEE, PHMSA, API RP 510/570/653), cost-benefit justification, and condition monitoring requirements. Links to equipment master and generates work orders automatically upon trigger. Supports ISO 55001 asset lifecycle planning and reliability-centered maintenance (RCM) methodology.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`failure_report` (
    `failure_report_id` BIGINT COMMENT 'Unique identifier for the equipment failure report record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset (well, pipeline, FPSO, compressor, CDU, processing plant) that experienced the failure.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Failure costs (repair_cost, production_loss_cost) must be allocated to cost centers for financial reporting, LOE tracking, and reliability cost analysis - standard oil-and-gas cost accounting practice',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment unit that failed within the asset.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline failures (leaks, ruptures, corrosion failures) occur on pipeline segments. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline failure events. No columns ',
    `previous_failure_report_id` BIGINT COMMENT 'Reference to the previous failure report if this is a recurring failure.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Facility-level failures (compressor trips, separator upsets, control system failures) impact production throughput. Direct FK enables facility reliability tracking, production loss analysis, and maint',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Failures occur on production wells (tubing leaks, packer failures, artificial lift failures) requiring reliability analysis. Direct FK enables well-level failure tracking, MTBF calculation, and produc',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Failure reporting requires employee accountability for HSE incident investigation, root cause analysis, and competency assessment. Links failure detection to personnel for training needs analysis and ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Tracks failures of vendor-supplied equipment for warranty claims, vendor performance evaluation, and root cause analysis. Essential for vendor scorecarding, quality management, and procurement decisio',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Wells experience failures (tubing leaks, casing failures, artificial lift failures, wellhead failures). Currently failure_report only has equipment_id. Adding well_asset_id enables tracking well failu',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective work order generated in Maximo CMMS to address this failure.',
    `affected_system` STRING COMMENT 'Name or code of the operational system affected by the failure (e.g., gas compression, crude distillation, water injection, power generation).',
    `closure_date` DATE COMMENT 'Date when the failure report was formally closed after all corrective and preventive actions were completed.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective maintenance action performed to restore equipment function (e.g., component replacement, repair, adjustment, cleaning).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the failure report record was first created in the database.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the failure was first detected by operators or monitoring systems.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total equipment downtime in hours from failure occurrence to restoration of service.',
    `environmental_impact` STRING COMMENT 'Assessment of the failures impact on the environment, including spills, emissions, or releases.. Valid values are `none|minor|moderate|major|catastrophic`',
    `failure_cause` STRING COMMENT 'Root cause of the failure identified through root cause analysis (RCA), such as design defect, material defect, operational error, maintenance inadequacy, environmental factor, or age-related degradation.',
    `failure_classification` STRING COMMENT 'Severity classification of the failure based on impact to operations, safety, and environment per API taxonomy.. Valid values are `critical|major|minor|incipient`',
    `failure_date` DATE COMMENT 'Calendar date when the equipment failure occurred.',
    `failure_description` STRING COMMENT 'Detailed narrative description of the failure event, symptoms observed, and conditions at time of failure.',
    `failure_mode` STRING COMMENT 'Classification of how the equipment failed (e.g., mechanical fracture, seal leak, electrical short, corrosion, erosion, fatigue, overpressure, blockage) per API taxonomy.',
    `failure_report_number` STRING COMMENT 'Business identifier for the failure report, typically generated by Maximo or operations system.',
    `failure_status` STRING COMMENT 'Current lifecycle status of the failure report in the asset integrity management workflow.. Valid values are `open|under_investigation|corrective_action_pending|closed|recurrence_monitoring`',
    `failure_timestamp` TIMESTAMP COMMENT 'Precise date and time when the equipment failure was detected or occurred, captured from SCADA or operations log.',
    `failure_type` STRING COMMENT 'Type of failure indicating whether the equipment lost all function (catastrophic), partial function (partial), or experienced performance degradation (degraded).. Valid values are `functional|partial|catastrophic|degraded`',
    `investigated_by` STRING COMMENT 'Name or identifier of the engineer or team who conducted the root cause analysis investigation.',
    `investigation_completed_date` DATE COMMENT 'Date when the root cause analysis investigation was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the failure report record was last updated.',
    `mtbf_impact_flag` BOOLEAN COMMENT 'Indicates whether this failure should be included in MTBF reliability calculations for the equipment class.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Actual time in hours required to repair and restore the equipment to operational status, used for MTTR calculation.',
    `npt_hours` DECIMAL(18,2) COMMENT 'Total non-productive time in hours caused by the equipment failure, impacting operational efficiency.',
    `operating_unit` STRING COMMENT 'Business unit or operating division responsible for the asset where the failure occurred.',
    `preventive_action_recommended` STRING COMMENT 'Recommended preventive actions to avoid recurrence, such as design modification, procedure update, inspection frequency increase, or training enhancement.',
    `production_impact_boe` DECIMAL(18,2) COMMENT 'Total deferred production in barrel of oil equivalent (BOE) combining oil and gas impact.',
    `production_impact_bopd` DECIMAL(18,2) COMMENT 'Deferred oil production in barrels of oil per day (BOPD) due to the equipment failure.',
    `production_impact_mcfd` DECIMAL(18,2) COMMENT 'Deferred gas production in thousand cubic feet per day (MCFD) due to the equipment failure.',
    `production_loss_cost` DECIMAL(18,2) COMMENT 'Estimated financial impact of deferred production due to the failure in USD.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this failure is a recurrence of a previously reported failure on the same equipment.',
    `repair_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for corrective maintenance and repair activities in USD.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the failure report was formally submitted into the system.',
    `safety_impact` STRING COMMENT 'Assessment of the failures impact on personnel safety, ranging from none to catastrophic.. Valid values are `none|minor|moderate|major|catastrophic`',
    CONSTRAINT pk_failure_report PRIMARY KEY(`failure_report_id`)
) COMMENT 'Records equipment failures and functional failures identified during operations or inspections, capturing failure date/time, failure mode, failure cause (root cause analysis), affected equipment, production impact (BOPD/MCFD deferred), NPT hours, failure classification per API taxonomy, corrective action taken, and recurrence flag. Feeds reliability analysis for MTBF calculation and drives corrective work order generation in Maximo. Critical for asset integrity programs and HSE incident correlation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`inspection_event` (
    `inspection_event_id` BIGINT COMMENT 'Unique identifier for the inspection event record. Primary key.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Inspection results feed regulatory filings (API 653 tank reports, PHMSA pipeline integrity reports, state well integrity reports). Direct data lineage for compliance reporting.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Inspection services often executed under master service agreements or call-off contracts. Links inspection execution to contracted rates, SLA terms, and vendor performance metrics. Complements existin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection costs must be allocated to cost centers for integrity program budgeting, regulatory compliance cost tracking, and RBI program financial justification - required for asset integrity financia',
    `equipment_id` BIGINT COMMENT 'Reference to the physical asset being inspected (well, pipeline, FPSO, compressor, CDU, processing plant, pressure vessel, tank, or other equipment).',
    `vendor_id` BIGINT COMMENT 'Reference to the third-party inspection service provider, if the inspection was outsourced.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Inspections verify permit compliance (emissions testing for air permits, integrity testing for pipeline permits). Creates audit trail for permit condition verification.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Inspections assess equipment fitness for specific product service. Corrosion rates, material degradation, and remaining life calculations vary significantly by product characteristics (sour vs sweet c',
    `pipeline_safety_report_id` BIGINT COMMENT 'Foreign key linking to compliance.pipeline_safety_report. Business justification: Pipeline inspection results feed PHMSA annual reports and integrity management program reports. Real data flow for regulatory compliance reporting.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline inspections (ILI runs, hydrostatic tests, visual inspections) are performed on pipeline segments. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline inte',
    `employee_id` BIGINT COMMENT 'Reference to the certified inspector or inspection team lead who performed the inspection.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Facility inspections (API 510 pressure vessel, API 570 piping, PSM inspections) required for regulatory compliance. Direct FK enables facility-level inspection tracking, compliance reporting (OSHA PSM',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Well integrity inspections (mechanical integrity tests per UIC regulations, casing inspections, wellhead pressure tests) are regulatory requirements. Direct FK enables well-level compliance tracking, ',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Wells undergo inspections (mechanical integrity tests, wellbore surveys, casing inspections). Currently inspection_event only has equipment_id. Adding well_asset_id enables tracking well inspections. ',
    `work_order_id` BIGINT COMMENT 'Reference to the Maximo work order under which this inspection was performed, if applicable.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection report and findings were formally approved.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the recommended or required corrective actions to address inspection findings.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which corrective actions must be completed to maintain asset integrity and regulatory compliance.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action (repair, replacement, or mitigation) is required based on inspection findings.',
    `corrosion_rate_mm_per_year` DECIMAL(18,2) COMMENT 'Calculated or measured corrosion rate in millimeters per year based on historical thickness measurements and time intervals.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection event record was first created in the system.',
    `defect_severity` STRING COMMENT 'Classification of the severity of defects or anomalies identified during the inspection.. Valid values are `critical|major|moderate|minor|none`',
    `fitness_for_service_result` STRING COMMENT 'Outcome of the fitness-for-service assessment determining whether the asset can continue to operate safely under current or modified conditions.. Valid values are `fit_for_service|fit_with_monitoring|fit_with_repair|not_fit_for_service|requires_engineering_assessment`',
    `hse_incident_flag` BOOLEAN COMMENT 'Indicates whether a health, safety, or environmental incident occurred during the inspection activity.',
    `inspection_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for performing the inspection, including labor, equipment, and vendor charges.',
    `inspection_date` DATE COMMENT 'The date on which the inspection was performed or completed.',
    `inspection_duration_hours` DECIMAL(18,2) COMMENT 'Total time in hours required to complete the inspection activity.',
    `inspection_findings` STRING COMMENT 'Detailed narrative of the inspection findings, observations, anomalies, defects, or conditions discovered during the inspection.',
    `inspection_interval_months` STRING COMMENT 'Mandated or calculated time interval in months between successive inspections based on risk assessment and regulatory requirements.',
    `inspection_method` STRING COMMENT 'Technical method or technique used to perform the inspection (visual, UT, RT, MFL, ILI, eddy current, acoustic emission, thermography). [ENUM-REF-CANDIDATE: visual|ultrasonic_testing|radiographic_testing|magnetic_flux_leakage|inline_inspection|eddy_current|acoustic_emission|thermography — 8 candidates stripped; promote to reference product]',
    `inspection_number` STRING COMMENT 'Business-assigned unique inspection number or code for tracking and reporting purposes.',
    `inspection_pressure_bar` DECIMAL(18,2) COMMENT 'Operating pressure in bar at the time of inspection, relevant for pressure vessel and piping integrity assessments.',
    `inspection_report_document_code` BIGINT COMMENT 'Reference to the formal inspection report document stored in the document management system.',
    `inspection_scope` STRING COMMENT 'Detailed description of the scope of the inspection, including specific components, areas, or systems examined.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection event.. Valid values are `scheduled|in_progress|completed|cancelled|deferred|overdue`',
    `inspection_temperature_c` DECIMAL(18,2) COMMENT 'Ambient or asset operating temperature in degrees Celsius at the time of inspection, relevant for thermal expansion and material property considerations.',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity based on asset type and regulatory framework (e.g., API RP 510 pressure vessel, API RP 570 piping, API RP 653 tank, BSEE offshore facility, internal condition monitoring). [ENUM-REF-CANDIDATE: pressure_vessel|piping|tank|offshore_facility|condition_monitoring|regulatory|internal|external|baseline|periodic|special — 11 candidates stripped; promote to reference product]',
    `measured_thickness_mm` DECIMAL(18,2) COMMENT 'Actual measured wall thickness in millimeters at the inspection point, typically obtained via ultrasonic testing.',
    `minimum_required_thickness_mm` DECIMAL(18,2) COMMENT 'Minimum allowable wall thickness in millimeters as determined by design calculations and regulatory requirements.',
    `moc_reference_number` STRING COMMENT 'Reference to the Management of Change workflow if the inspection was triggered by or resulted in a change to asset operating conditions or configuration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection event record was last modified or updated.',
    `next_inspection_due_date` DATE COMMENT 'The calculated or mandated date by which the next inspection must be performed based on regulatory requirements, risk assessment, or asset integrity program.',
    `permit_to_work_number` STRING COMMENT 'Reference number of the permit to work authorization under which the inspection was conducted.',
    `regulatory_compliance_status` STRING COMMENT 'Assessment of whether the inspection results and asset condition meet applicable regulatory requirements (API, BSEE, OSHA, EPA).. Valid values are `compliant|non_compliant|conditional_compliance|pending_review`',
    `regulatory_reference` STRING COMMENT 'Specific regulatory code, standard, or requirement that governs this inspection (e.g., API RP 510, BSEE 30 CFR 250).',
    `remaining_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining service life of the asset in years based on current thickness, corrosion rate, and minimum required thickness.',
    `risk_based_inspection_priority` STRING COMMENT 'Risk-based inspection priority classification based on consequence of failure and probability of failure analysis.. Valid values are `high|medium_high|medium|medium_low|low`',
    `scheduled_date` DATE COMMENT 'The originally planned date for the inspection activity.',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Records all asset inspection activities including API RP 510 pressure vessel inspections, API RP 570 piping inspections, API RP 653 tank inspections, BSEE offshore facility inspections, and internal condition monitoring surveys. Captures inspection date, inspector identity, inspection method (visual/UT/RT/MFL/ILI), findings, measured thickness/corrosion rates, fitness-for-service assessment result, next inspection due date, and regulatory compliance status. Integrates with Enablon HSE Management for compliance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`integrity_program` (
    `integrity_program_id` BIGINT COMMENT 'Unique identifier for the asset integrity management program record. Primary key.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Integrity programs are certified under API 570, 510, 653, 1160 standards. Direct business relationship between integrity management and certification compliance.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Integrity programs submitted to PHMSA, BSEE, and state agencies. Direct regulatory requirement for pipeline integrity management and offshore safety management.',
    `equipment_id` BIGINT COMMENT 'Reference to the physical asset or asset class covered by this integrity program.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline integrity management programs are defined for pipeline segments or pipeline systems. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline integrity program',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Integrity programs (mechanical integrity per OSHA PSM, RBI programs per API 580/581) cover production facilities. Direct FK enables facility-level integrity management, inspection planning, and regula',
    `acceptable_risk_threshold` STRING COMMENT 'The maximum acceptable risk level for assets under this program, used to determine inspection priorities and intervals in risk-based inspection frameworks.. Valid values are `low|medium-low|medium|medium-high|high`',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Planned annual budget allocated for executing this integrity program, including inspection, monitoring, and assessment costs.',
    `applicable_standard` STRING COMMENT 'Primary industry standard or code governing this integrity program (e.g., API RP 570, API RP 580, API RP 581, ASME B31.3, NACE SP0169, PHMSA 49 CFR Part 195).',
    `asset_class` STRING COMMENT 'Classification of the asset type covered by this program (e.g., pressure vessel, piping system, storage tank, pipeline, FPSO, compressor, CDU, VDU, heat exchanger).',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual budget amount.. Valid values are `^[A-Z]{3}$`',
    `capex_opex_classification` STRING COMMENT 'Financial classification of integrity program costs as capital expenditure, operating expenditure, or mixed.. Valid values are `CAPEX|OPEX|mixed`',
    `cml_registry_flag` BOOLEAN COMMENT 'Indicates whether this integrity program includes a formal CML registry with defined monitoring points, nominal thickness, minimum thickness, and corrosion rate tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integrity program record was first created in the system.',
    `damage_mechanism` STRING COMMENT 'The primary degradation or damage mechanism addressed by this integrity program (e.g., external corrosion, internal corrosion, stress corrosion cracking, fatigue, erosion, hydrogen embrittlement).',
    `effective_date` DATE COMMENT 'Date when the integrity program became or will become effective and governing for the asset.',
    `expiration_date` DATE COMMENT 'Date when the integrity program expires or is scheduled for renewal. Nullable for programs without defined end dates.',
    `fitness_for_service_flag` BOOLEAN COMMENT 'Indicates whether this integrity program includes formal fitness-for-service assessments per API 579-1/ASME FFS-1 for degraded equipment.',
    `inspection_interval_months` STRING COMMENT 'Standard inspection interval in months for assets governed by this program. Used to generate inspection plans and schedules.',
    `inspection_strategy` STRING COMMENT 'The overarching inspection philosophy and approach used to determine inspection intervals and methods for assets under this program.. Valid values are `time-based|condition-based|risk-based|run-to-failure|predictive`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this integrity program record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review and update of the integrity program.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this integrity program require formal Management of Change (MOC) approval per OSHA PSM or EPA RMP requirements.',
    `monitoring_method` STRING COMMENT 'The primary inspection or monitoring technique used under this program (e.g., ultrasonic testing, radiographic testing, visual inspection, corrosion coupon, cathodic protection survey, inline inspection).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review and update of the integrity program to ensure continued alignment with asset conditions and regulatory requirements.',
    `operating_unit` STRING COMMENT 'The business unit, facility, or operational division responsible for the assets covered by this integrity program.',
    `program_description` STRING COMMENT 'Detailed description of the integrity program scope, objectives, and key activities.',
    `program_name` STRING COMMENT 'Descriptive name of the integrity management program.',
    `program_number` STRING COMMENT 'Business identifier for the integrity program, used for external reference and reporting.',
    `program_owner` STRING COMMENT 'Name or identifier of the individual or organizational unit responsible for maintaining and executing this integrity program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the integrity program indicating whether it is actively governing inspections and assessments.. Valid values are `active|inactive|under review|suspended|retired|planned`',
    `program_type` STRING COMMENT 'Classification of the integrity program based on the primary degradation mechanism or asset system being managed. [ENUM-REF-CANDIDATE: corrosion management|fatigue management|pressure containment|structural integrity|pipeline integrity|mechanical integrity|electrical integrity|instrumentation integrity|erosion management|vibration management|thermal cycling — promote to reference product]',
    `rbi_methodology` STRING COMMENT 'Specific risk-based inspection methodology applied if the inspection strategy is risk-based. Indicates the framework used for probability of failure and consequence of failure assessments.. Valid values are `API 581|semi-quantitative|qualitative|quantitative|not applicable`',
    `regulatory_basis` STRING COMMENT 'The regulatory requirement, consent decree, or legal mandate that necessitates this integrity program (e.g., PHMSA pipeline integrity management, BSEE offshore safety case, EPA consent order).',
    `turnaround_alignment_flag` BOOLEAN COMMENT 'Indicates whether inspection activities under this program are aligned with planned turnaround or shutdown schedules.',
    CONSTRAINT pk_integrity_program PRIMARY KEY(`integrity_program_id`)
) COMMENT 'Defines the ISO 55001-aligned asset integrity management program for each asset or asset class, including program type (corrosion management, fatigue management, pressure containment, structural integrity), applicable standards (API, ASME, NACE), inspection strategy, risk-based inspection (RBI) methodology, acceptable risk threshold, program owner, regulatory basis, and corrosion monitoring location (CML) registry with nominal/minimum thickness, monitoring method, corrosion rates, and remaining life calculations. Serves as the governing framework that drives inspection plans, monitoring programs, and fitness-for-service assessments across the asset portfolio. Supports PHMSA pipeline integrity management and API RP 570/580/581 compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` (
    `corrosion_monitoring_point_id` BIGINT COMMENT 'Unique identifier for the corrosion monitoring location. Primary key for the corrosion monitoring point entity.',
    `asset_id` BIGINT COMMENT 'Reference to the parent asset (pipeline, vessel, equipment) on which this corrosion monitoring point is located.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment unit being monitored for corrosion.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: CML points monitor corrosion from specific process fluids/products. Corrosion rates and damage mechanisms are product-specific (naphthenic acid corrosion, sulfidic corrosion). Essential for integrity ',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: CMLs are installed on pipelines, vessels, and process equipment. Currently only equipment_id exists. Pipeline CMLs need pipeline_segment_id to link to the specific pipeline segment being monitored. No',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Corrosion monitoring locations (CMLs) installed at production facilities to track equipment degradation. Direct FK enables facility-level corrosion tracking, remaining life assessment, and inspection ',
    `alert_status` STRING COMMENT 'Current alert condition based on comparison of last measured thickness to alert threshold and minimum required thickness.. Valid values are `normal|caution|critical|exceeded`',
    `alert_threshold_mm` DECIMAL(18,2) COMMENT 'Thickness value in millimeters that triggers an alert when reached, typically set above the minimum required thickness to allow time for corrective action.',
    `circuit_code` STRING COMMENT 'Identifier for the corrosion circuit or piping system to which this CML belongs, used for grouping related monitoring points.',
    `cml_number` STRING COMMENT 'Business identifier for the corrosion monitoring location, typically following site-specific numbering conventions (e.g., P-101-CML-001).',
    `cml_type` STRING COMMENT 'Classification of the monitoring point type: fixed (permanent location), grid (systematic pattern), or random (opportunistic measurement).. Valid values are `fixed|grid|random`',
    `component_type` STRING COMMENT 'Type of piping or vessel component where the CML is located. [ENUM-REF-CANDIDATE: pipe|elbow|tee|reducer|flange|vessel|nozzle|weld — 8 candidates stripped; promote to reference product]',
    `consequence_category` STRING COMMENT 'Consequence of failure classification for this CML considering safety, environmental, and production impact.. Valid values are `low|medium|high|severe`',
    `corrosion_monitoring_point_status` STRING COMMENT 'Current lifecycle status of the corrosion monitoring point.. Valid values are `active|inactive|retired|pending`',
    `corrosion_rate_mm_per_year` DECIMAL(18,2) COMMENT 'Calculated rate of metal loss in millimeters per year, derived from historical thickness measurements. Also known as mpy (mils per year) when expressed in imperial units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrosion monitoring point record was first created in the system.',
    `damage_mechanism` STRING COMMENT 'Primary corrosion or degradation mechanism expected or observed at this location (e.g., CO2 corrosion, H2S corrosion, erosion-corrosion, chloride stress corrosion cracking).',
    `established_date` DATE COMMENT 'Date when this corrosion monitoring point was first established in the integrity management program.',
    `inspection_document_code` STRING COMMENT 'Reference to the most recent inspection report document for this CML.',
    `last_measured_thickness_mm` DECIMAL(18,2) COMMENT 'Most recent thickness measurement recorded at this CML in millimeters.',
    `last_measurement_date` DATE COMMENT 'Date when the last thickness measurement was performed at this CML.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this corrosion monitoring point record was last updated.',
    `location_description` STRING COMMENT 'Detailed textual description of the physical location of the corrosion monitoring point on the asset (e.g., Elbow downstream of pump discharge, 3 oclock position).',
    `material_grade` STRING COMMENT 'Material specification of the component at this CML (e.g., API 5L X65, ASTM A106 Grade B, 316L stainless steel).',
    `minimum_required_thickness_mm` DECIMAL(18,2) COMMENT 'Minimum allowable wall thickness in millimeters below which the component is no longer fit for service, calculated per ASME/API pressure vessel and piping codes.',
    `monitoring_frequency_months` STRING COMMENT 'Required inspection interval in months for this CML, determined by risk-based inspection methodology and remaining life calculation.',
    `monitoring_method` STRING COMMENT 'Inspection technique used at this monitoring point: ultrasonic thickness (UT), radiographic testing (RT), corrosion coupon, corrosion probe, or visual inspection.. Valid values are `ultrasonic|radiographic|coupon|probe|visual`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection at this CML.',
    `nominal_thickness_mm` DECIMAL(18,2) COMMENT 'Original design thickness of the component at this monitoring location in millimeters, as specified in engineering drawings.',
    `operating_pressure_bar` DECIMAL(18,2) COMMENT 'Normal operating pressure in bar at this monitoring location.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Normal operating temperature in degrees Celsius at this monitoring location.',
    `operating_unit` STRING COMMENT 'Operating unit or process area within the facility where this CML is located (e.g., CDU, FCC, gas processing train).',
    `probability_category` STRING COMMENT 'Probability of failure classification based on corrosion rate, remaining life, and damage mechanism severity.. Valid values are `low|medium|high`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this CML is subject to specific regulatory inspection requirements (e.g., PHMSA pipeline integrity management, BSEE offshore safety).',
    `regulatory_reference` STRING COMMENT 'Citation of specific regulatory requirement applicable to this CML (e.g., 49 CFR 195.452 for hazardous liquid pipelines).',
    `remaining_life_years` DECIMAL(18,2) COMMENT 'Calculated remaining service life in years before the component reaches minimum required thickness, based on current corrosion rate.',
    `retired_date` DATE COMMENT 'Date when this CML was retired from active monitoring, typically due to equipment replacement or decommissioning.',
    `risk_category` STRING COMMENT 'Risk-based inspection category assigned to this CML based on consequence of failure and probability of failure.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_corrosion_monitoring_point PRIMARY KEY(`corrosion_monitoring_point_id`)
) COMMENT 'Master record for each designated corrosion monitoring location (CML) on pipelines, vessels, and process equipment. Captures CML identifier, location description, nominal thickness, minimum required thickness (per ASME/API), monitoring method (UT, coupon, probe), monitoring frequency, last measured thickness, corrosion rate (mpy), remaining life calculation, and alert threshold. Feeds the integrity program and inspection planning cycle. Critical for PHMSA pipeline integrity management and API RP 570 compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`moc_request` (
    `moc_request_id` BIGINT COMMENT 'Unique identifier for the Management of Change request record. Primary key for the MOC request entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Management of Change often requires contract amendments (scope, schedule, cost) or new procurement for modified equipment/services. Links MOC execution to contractual obligations, change order managem',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MOC implementations have financial impacts requiring cost center tracking for capital/opex classification, budget authorization, and change management cost control - standard PSM financial requirement',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: MOC requests affecting customer-owned equipment or JV facilities require tracking the affected customer for approval workflows, notification requirements (contractual obligations), cost allocation, an',
    `work_order_id` BIGINT COMMENT 'Reference to the Maximo work order created to execute the approved change. Links MOC to maintenance management system for implementation tracking.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who initiated the MOC request. Used for accountability and audit trail.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: MOCs trigger permit modifications or new permit applications under PSM/RMP regulations. Real process safety management requirement linking asset changes to regulatory compliance.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: MOC requests are created for pipeline modifications (MAOP changes, material changes, route changes). Currently moc_request has asset_equipment_id and equipment_id. Adding pipeline_segment_id enables t',
    `equipment_id` BIGINT COMMENT 'Reference to the primary physical asset affected by the proposed change. Links to the asset master registry for wells, pipelines, compressors, vessels, or other equipment.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: MOC required for facility modifications (equipment changes, process changes, control system upgrades) per OSHA PSM regulations. Direct FK enables facility-level MOC tracking, PSSR compliance, and regu',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Management of Change required for well modifications (artificial lift changes, completion changes, injection conversions) per OSHA PSM. Direct FK enables well-level MOC tracking, regulatory compliance',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: MOC capital projects require WBS tracking for investment program management, capital authorization, and project portfolio reporting - standard capital project control requirement.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: MOC requests are created for well modifications (completion changes, artificial lift changes, wellbore interventions). Currently moc_request has asset_equipment_id and equipment_id. Adding well_asset_',
    `actual_implementation_date` DATE COMMENT 'Actual date when the change was physically implemented and the modified equipment or process was placed into service.',
    `afe_number` STRING COMMENT 'AFE number authorizing the capital or operating expenditure for this change. Links to financial authorization and budget tracking systems.',
    `affected_process_unit` STRING COMMENT 'Name or identifier of the process unit or operating area impacted by the change (e.g., CDU, FCC, HDS, gas processing train, production separator).',
    `approval_authority_level` STRING COMMENT 'Required organizational approval level for this MOC based on risk classification, cost, and scope. Higher risk changes require higher authority approval.. Valid values are `supervisor|manager|director|vice_president|executive`',
    `approval_date` DATE COMMENT 'Date when the MOC request received final approval and was authorized to proceed to implementation planning.',
    `approver_name` STRING COMMENT 'Name of the individual who provided final approval for the MOC request. Establishes accountability for change authorization.',
    `capex_opex_classification` STRING COMMENT 'Financial classification of the change expenditure as capital expenditure (asset improvement/life extension) or operating expenditure (maintenance/repair). Critical for DD&A and financial reporting.. Valid values are `CAPEX|OPEX|mixed`',
    `change_category` STRING COMMENT 'Classification of the type of change being requested: physical (equipment/asset modification), procedural (operating procedure change), organizational (staffing/responsibility change), software (control system/SCADA change), temporary (time-limited change), or permanent (indefinite change).. Valid values are `physical|procedural|organizational|software|temporary|permanent`',
    `change_description` STRING COMMENT 'Detailed narrative description of the proposed modification to physical assets, process conditions, operating procedures, or organizational changes. Includes scope, rationale, and expected outcomes.',
    `change_type` STRING COMMENT 'Specific type of change within the category: replacement in kind (like-for-like), modification (alteration to existing), new installation, decommissioning, process parameter change, or safety system change.. Valid values are `replacement_in_kind|modification|new_installation|decommissioning|process_change|safety_system_change`',
    `closure_date` DATE COMMENT 'Date when the MOC request was formally closed after successful implementation, PSSR completion, and post-implementation review.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MOC request record was first created in the system. Audit trail for record lifecycle tracking.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the change requires shutdown or production curtailment of the affected equipment or process unit.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost to implement the proposed change, including materials, labor, contractor services, and downtime costs. Used for AFE and budget authorization.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the affected equipment or process will be offline during change implementation. Used for production planning and NPT tracking.',
    `hse_risk_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal HSE risk assessment (HAZOP, LOPA, or similar) is required for this change based on risk screening criteria.',
    `hse_risk_assessment_status` STRING COMMENT 'Current status of the HSE risk assessment process for this MOC request. Tracks completion of HAZOP, LOPA, or other risk analysis activities.. Valid values are `not_required|pending|in_progress|completed|approved`',
    `hse_risk_level` STRING COMMENT 'Overall risk classification assigned to the proposed change based on HSE risk assessment results. Determines approval authority level and review requirements.. Valid values are `low|medium|high|critical`',
    `implementation_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours required to complete the change implementation, including preparation, execution, and testing activities.',
    `initiating_department` STRING COMMENT 'Name of the department or business unit that originated the MOC request (e.g., Production Operations, Maintenance, Engineering, HSE).',
    `initiator_name` STRING COMMENT 'Full name of the individual who submitted the MOC request. Business-confidential workforce information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MOC request record. Tracks record change history for audit and compliance purposes.',
    `moc_number` STRING COMMENT 'Business identifier for the MOC request, typically formatted as MOC-YYYYNNNNNN where YYYY is year and NNNNNN is sequence number. Used for external reference and tracking.. Valid values are `^MOC-[0-9]{6,10}$`',
    `moc_status` STRING COMMENT 'Current lifecycle status of the MOC request in the approval and implementation workflow. Tracks progression from initial draft through technical review, approval, implementation, and closure. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|implementation|completed|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `moc_title` STRING COMMENT 'Brief descriptive title summarizing the proposed change for quick identification and reporting purposes.',
    `permit_to_work_number` STRING COMMENT 'Reference to the Permit to Work issued for the change implementation activities. Links to Enablon HSE Management system for work authorization and safety controls.',
    `planned_implementation_date` DATE COMMENT 'Target date for implementing the approved change. Used for scheduling, resource planning, and turnaround coordination.',
    `post_implementation_review_date` DATE COMMENT 'Date when the post-implementation review was completed. Verifies that the change achieved intended results and identifies any corrective actions needed.',
    `post_implementation_review_required_flag` BOOLEAN COMMENT 'Indicates whether a formal post-implementation review is required to verify change effectiveness and capture lessons learned.',
    `process_safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the change affects process safety management (PSM) covered processes or safety-critical systems per OSHA PSM 1910.119 requirements.',
    `pssr_required_flag` BOOLEAN COMMENT 'Indicates whether a Pre-Startup Safety Review is required before the change can be placed into operation, per OSHA PSM 1910.119 requirements for process safety changes.',
    `pssr_status` STRING COMMENT 'Current status of the Pre-Startup Safety Review process. Tracks completion of PSSR checklist verification before the modified equipment or process is returned to service.. Valid values are `not_required|pending|in_progress|completed|approved`',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the change requires notification to or approval from regulatory agencies (BSEE, EPA, state agencies) before implementation.',
    `regulatory_reference_number` STRING COMMENT 'Reference number for any regulatory notification, permit modification, or approval associated with this change.',
    `technical_review_status` STRING COMMENT 'Status of the technical engineering review process for the proposed change. Includes evaluation of design adequacy, code compliance, and technical feasibility.. Valid values are `pending|in_progress|completed|approved|rejected`',
    `technical_reviewer_name` STRING COMMENT 'Name of the lead technical reviewer or engineering authority responsible for technical evaluation of the MOC request.',
    `training_completion_status` STRING COMMENT 'Status of required training activities for affected personnel. Must be completed before PSSR approval and startup.. Valid values are `not_required|pending|in_progress|completed`',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether operator or maintenance personnel training is required before the change can be placed into service, per OSHA PSM 1910.119 requirements.',
    CONSTRAINT pk_moc_request PRIMARY KEY(`moc_request_id`)
) COMMENT 'Management of Change (MOC) request record tracking proposed modifications to physical assets, process conditions, or operating procedures per OSHA PSM 1910.119 and API RP 750 requirements. Captures MOC number, change description, change category (physical/procedural/temporary/permanent), initiating department, affected equipment/facility reference, technical review status, HSE risk assessment, PSSR (Pre-Startup Safety Review) requirement flag, approval workflow status, implementation date, and post-implementation review date. Integrates with Enablon HSE Management for risk tracking and Maximo for implementation work order linkage.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` (
    `asset_risk_assessment_id` BIGINT COMMENT 'Unique identifier for the asset risk assessment record. Primary key for the asset risk assessment entity.',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset (well, pipeline segment, compressor, vessel, heat exchanger, CDU, FPSO equipment) being assessed for risk.',
    `employee_id` BIGINT COMMENT 'Reference to the engineer or inspector who performed the risk assessment.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment unit within the asset hierarchy being assessed, typically from Maximo Asset Management CMMS.',
    `integrity_program_id` BIGINT COMMENT 'Reference to the asset integrity management program under which this assessment was conducted.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Risk-based inspection (RBI) assessments are performed on pipeline segments as stated in product description. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline ri',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Risk assessments (RBI per API 580/581, process hazard analysis per OSHA PSM) conducted on production facilities. Direct FK enables facility-level risk management, inspection prioritization, and regula',
    `approval_date` DATE COMMENT 'Date when the risk assessment was formally approved by the integrity management authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the authority who approved the risk assessment and recommended actions.',
    `assessment_date` DATE COMMENT 'Date when the risk-based inspection assessment was performed or completed.',
    `assessment_number` STRING COMMENT 'Business identifier for the risk assessment, typically generated by RBI software or integrity management system.',
    `assessment_software` STRING COMMENT 'Name and version of the RBI software tool used to perform the risk assessment (e.g., DNV Synergi, Meridium APM, Visions RBI).',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment record.. Valid values are `draft|in_progress|completed|approved|superseded|cancelled`',
    `assessor_name` STRING COMMENT 'Name of the engineer or inspector who performed the risk assessment.',
    `cof_category` STRING COMMENT 'Categorical classification of the consequence of failure score into risk bands for prioritization and decision-making.. Valid values are `very_low|low|medium|high|very_high`',
    `cof_score` DECIMAL(18,2) COMMENT 'Calculated consequence of failure score representing the total impact of equipment failure including safety, environmental, production, and financial consequences. Typically expressed in monetary units (USD).',
    `corrosion_rate_mm_per_year` DECIMAL(18,2) COMMENT 'Measured or estimated corrosion rate for the asset based on inspection data and operating conditions, used in remaining life calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the system.',
    `damage_factor` DECIMAL(18,2) COMMENT 'Quantitative damage factor representing the severity or progression rate of the dominant damage mechanism, used in PoF calculations.',
    `dominant_damage_mechanism` STRING COMMENT 'Primary damage mechanism identified as the most significant threat to asset integrity (e.g., external corrosion, internal corrosion, stress corrosion cracking, high temperature hydrogen attack, creep, fatigue, erosion, corrosion under insulation).',
    `environmental_consequence_score` DECIMAL(18,2) COMMENT 'Component of the total CoF representing potential environmental impact including spills, emissions, and remediation costs.',
    `financial_consequence_score` DECIMAL(18,2) COMMENT 'Component of the total CoF representing direct financial impact including repair costs, equipment replacement, and property damage.',
    `fitness_for_service_status` STRING COMMENT 'Current fitness-for-service determination indicating whether the equipment is suitable for continued operation per API 579 assessment.. Valid values are `fit_for_service|monitor|repair_required|retire`',
    `fluid_phase` STRING COMMENT 'Phase of the process fluid contained in the equipment (gas, liquid, two-phase, or supercritical) affecting consequence calculations.. Valid values are `gas|liquid|two_phase|supercritical`',
    `fluid_type` STRING COMMENT 'Type or classification of process fluid (e.g., crude oil, natural gas, sour gas, H2S, amine, caustic, hydrocarbon, steam) affecting toxicity and flammability consequences.',
    `inspection_effectiveness_category` STRING COMMENT 'Assessment of the effectiveness of the current inspection program in detecting the dominant damage mechanism, per API RP 581 inspection effectiveness categories.. Valid values are `highly_effective|usually_effective|fairly_effective|poorly_effective|ineffective`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was last updated or modified.',
    `mitigation_action_description` STRING COMMENT 'Detailed description of recommended mitigation actions to reduce risk, such as increased inspection frequency, repair, replacement, or process modifications.',
    `mitigation_action_due_date` DATE COMMENT 'Target completion date for implementing recommended mitigation actions to maintain acceptable risk levels.',
    `mitigation_action_required_flag` BOOLEAN COMMENT 'Indicates whether immediate or near-term mitigation actions are required to reduce risk to acceptable levels.',
    `next_assessment_due_date` DATE COMMENT 'Calculated date when the next risk assessment should be performed to maintain current risk profile and inspection strategy.',
    `operating_pressure_bar` DECIMAL(18,2) COMMENT 'Normal operating pressure of the equipment at the time of assessment, used in consequence calculations.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Normal operating temperature of the equipment at the time of assessment, critical for damage mechanism evaluation.',
    `operating_unit` STRING COMMENT 'Operating unit or business segment responsible for the asset (e.g., upstream, midstream, downstream, refining, petrochemicals).',
    `pof_category` STRING COMMENT 'Categorical classification of the probability of failure score into risk bands for prioritization and decision-making.. Valid values are `very_low|low|medium|high|very_high`',
    `pof_score` DECIMAL(18,2) COMMENT 'Calculated probability of failure score representing the likelihood of equipment failure based on damage mechanisms, inspection history, and operating conditions. Expressed as failures per year or dimensionless score depending on methodology.',
    `production_consequence_score` DECIMAL(18,2) COMMENT 'Component of the total CoF representing potential production loss and business interruption costs due to equipment failure.',
    `recommended_inspection_interval_months` STRING COMMENT 'Recommended time interval in months until the next inspection based on the risk assessment results and asset integrity management strategy.',
    `remaining_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining service life of the equipment in years before reaching minimum required thickness or fitness-for-service limits.',
    `risk_methodology` STRING COMMENT 'Risk assessment methodology applied, typically API RP 581 quantitative or semi-quantitative approach for process equipment and piping.. Valid values are `api_rp_581_quantitative|api_rp_581_semi_quantitative|qualitative|custom`',
    `risk_ranking` STRING COMMENT 'Categorical risk ranking derived from the risk matrix combining PoF and CoF categories. Drives inspection prioritization and resource allocation decisions.. Valid values are `low|medium_low|medium|medium_high|high|very_high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Overall risk score calculated as the product of probability of failure and consequence of failure (Risk = PoF × CoF). Used for ranking and prioritization of inspection activities.',
    `safety_consequence_score` DECIMAL(18,2) COMMENT 'Component of the total CoF representing potential safety impact including injury, fatality, and HSE incident consequences.',
    `secondary_damage_mechanism` STRING COMMENT 'Secondary or contributing damage mechanism that may affect the asset but is not the dominant threat.',
    CONSTRAINT pk_asset_risk_assessment PRIMARY KEY(`asset_risk_assessment_id`)
) COMMENT 'Risk-based inspection (RBI) and asset risk assessment records for equipment and pipeline segments, capturing assessment date, risk methodology (API RP 581 quantitative/semi-quantitative), probability of failure (PoF) score, consequence of failure (CoF) score, risk ranking (low/medium/high/very high), dominant damage mechanism, recommended inspection interval, and next assessment due date. Drives inspection prioritization and integrity program updates. Integrates with API RP 580/581 RBI software outputs.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`transfer_event` (
    `transfer_event_id` BIGINT COMMENT 'Primary key for transfer_event',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Asset transfers often require AFE authorization for transaction costs, transfer taxes, and capital reallocation. Links transfer execution to financial authorization, cost center changes, and joint ven',
    `asset_id` BIGINT COMMENT 'Identifier of the asset being transferred, redeployed, or disposed. Links to the asset master registry.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Asset transfers to external parties (divestments, farm-outs, asset sales) require tracking the acquiring counterparty for transaction management, regulatory approval workflows, warranty tracking, and ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Equipment can be transferred between facilities or cost centers (redeployment). Currently transfer_event has polymorphic asset_id. Adding equipment_id provides typed FK for equipment transfers. No col',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Asset transfers may require AFE authorization for capital reclassification, gain/loss recognition, and intercompany transaction approval - required for JV and intercompany asset transfer accounting.',
    `partner_id` BIGINT COMMENT 'Identifier of the joint venture partner or working interest owner transferring the asset. Applicable for JV partner transfers.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Asset transfers require initiator tracking for audit trail, authorization verification, and accountability. Links transfer request to employee for approval workflow and segregation of duties validatio',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline segments can be transferred between operators (common in midstream). Currently transfer_event has polymorphic asset_id. Adding pipeline_segment_id provides typed FK for pipeline transfers. No',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the originating facility, location, or operational unit from which the asset is being transferred.',
    `to_facility_asset_facility_id` BIGINT COMMENT 'Identifier of the destination facility, location, or operational unit to which the asset is being transferred.',
    `to_jv_partner_id` BIGINT COMMENT 'Identifier of the joint venture partner or working interest owner receiving the asset. Applicable for JV partner transfers.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Wells can be transferred between operators or JV partners (common in oil & gas). Currently transfer_event has polymorphic asset_id. Adding well_asset_id provides typed FK for well transfers. No column',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total accumulated depreciation, depletion, and amortization (DD&A) on the asset up to the transfer date.',
    `approval_date` DATE COMMENT 'Date when the asset transfer was formally approved by the approving authority.',
    `approved_by` STRING COMMENT 'User identifier or name of the person who formally approved the transfer in the system.',
    `approving_authority` STRING COMMENT 'Name or identifier of the individual, role, or committee that authorized and approved the asset transfer.',
    `asset_condition_at_transfer` STRING COMMENT 'Physical and operational condition of the asset at the time of transfer, used for handover documentation and liability determination.. Valid values are `excellent|good|fair|poor|non_operational|decommissioned`',
    `completed_date` DATE COMMENT 'Date when the asset transfer was fully completed and the asset was successfully received at the destination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer event record was first created in the system.',
    `from_cost_center` STRING COMMENT 'Cost center code of the originating business unit or department responsible for the asset prior to transfer.',
    `from_working_interest_percentage` DECIMAL(18,2) COMMENT 'Working interest ownership percentage held by the transferring party prior to the transfer event.',
    `gain_loss_on_transfer` DECIMAL(18,2) COMMENT 'Calculated gain or loss resulting from the transfer, computed as transfer value minus net book value. Positive values indicate gain; negative values indicate loss.',
    `hse_clearance_date` DATE COMMENT 'Date when Health, Safety, and Environment (HSE) clearance was granted for the asset transfer.',
    `hse_clearance_flag` BOOLEAN COMMENT 'Indicates whether Health, Safety, and Environment (HSE) clearance was obtained prior to the transfer. True if clearance was granted; False otherwise.',
    `initiated_date` DATE COMMENT 'Date when the asset transfer request was initiated or submitted for approval.',
    `jib_reference_number` STRING COMMENT 'Joint Interest Billing (JIB) reference number for cost allocation adjustments resulting from the transfer between joint venture partners.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer event record was last updated or modified in the system.',
    `moc_reference_number` STRING COMMENT 'Management of Change (MOC) reference number if the transfer requires formal change management approval due to operational or safety impact.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset at the time of transfer, calculated as original cost minus accumulated depreciation, depletion, and amortization (DD&A).',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for the regulatory approval or permit associated with the asset transfer.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory approval from agencies such as BSEE, BOEM, or EPA is required for the transfer. True if required; False otherwise.',
    `to_cost_center` STRING COMMENT 'Cost center code of the receiving business unit or department that will assume responsibility for the asset after transfer.',
    `to_working_interest_percentage` DECIMAL(18,2) COMMENT 'Working interest ownership percentage to be held by the receiving party after the transfer event.',
    `transfer_date` DATE COMMENT 'Effective date when the asset transfer legally and operationally takes effect. Used for financial cutover and ownership change.',
    `transfer_documentation_code` STRING COMMENT 'Reference identifier for supporting documentation, certificates, or reports associated with the transfer (e.g., bill of sale, transfer certificate, inspection report).',
    `transfer_notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information related to the asset transfer.',
    `transfer_number` STRING COMMENT 'Business-assigned unique reference number for the asset transfer transaction, used for tracking and audit purposes.',
    `transfer_reason` STRING COMMENT 'Business justification or reason for the asset transfer, such as operational optimization, end of life, regulatory requirement, or strategic divestment.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the transfer event in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_transit|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `transfer_timestamp` TIMESTAMP COMMENT 'Precise date and time when the asset transfer was executed or recorded in the system.',
    `transfer_type` STRING COMMENT 'Classification of the transfer event: internal redeployment between facilities, joint venture (JV) partner transfer, sale to external party, disposal, abandonment, plug and abandonment (P&A), or lease transfer. [ENUM-REF-CANDIDATE: internal_redeployment|jv_partner_transfer|sale|disposal|abandonment|plug_and_abandonment|lease_transfer — 7 candidates stripped; promote to reference product]',
    `transfer_value` DECIMAL(18,2) COMMENT 'Monetary value assigned to the asset transfer for accounting, tax, and joint interest billing purposes. Represents the book value or negotiated sale price.',
    `transfer_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer value (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_transfer_event PRIMARY KEY(`transfer_event_id`)
) COMMENT 'Records the transfer, redeployment, or disposal of assets between facilities, cost centers, joint venture partners, or business units, capturing transfer date, from-facility, to-facility, transfer type (internal redeployment/JV partner transfer/sale/abandonment/P&A), transfer value, approving authority, AFE reference, and updated asset register status. Supports JIB cost allocation adjustments and SAP FI-AA asset transfer postings. Critical for joint venture accounting and working interest ownership changes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`equipment_specification` (
    `equipment_specification_id` BIGINT COMMENT 'Unique identifier for the equipment specification record. Primary key for the equipment specification data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Engineering specifications require professional engineer approval tracking for regulatory compliance and design authority validation. Links specification approval to employee for PE license verificati',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment master record for which this specification applies. Links to the equipment registry in the asset management system.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Equipment specifications define design basis for specific product service (material selection, design codes, corrosion allowances). Critical for MOC reviews when changing product service, procurement ',
    `approval_date` DATE COMMENT 'Date when the equipment specification was formally approved for use in engineering and procurement activities.',
    `capacity_unit` STRING COMMENT 'Unit of measure for rated capacity such as Barrels of Oil Per Day (BOPD), Thousand Cubic Feet per Day (MCFD), Million British Thermal Units per hour (MMBTU/hr), gallons per minute (GPM), or barrels.',
    `corrosion_allowance_inches` DECIMAL(18,2) COMMENT 'Additional wall thickness provided beyond the minimum required thickness to account for anticipated corrosion over the equipment design life, expressed in inches.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment specification record was first created in the asset management system. Used for audit trail and data lineage tracking.',
    `datasheet_document_code` STRING COMMENT 'Reference identifier for the vendor datasheet or specification sheet document stored in the document management system. Provides detailed technical specifications and performance curves.',
    `design_code` STRING COMMENT 'Applicable design and construction code standard such as American Society of Mechanical Engineers (ASME) Section VIII Division 1 or 2, American National Standards Institute (ANSI), or API standards. Governs design requirements and safety factors.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum Allowable Working Pressure (MAWP) for which the equipment is designed, expressed in pounds per square inch (PSI). Critical parameter for pressure vessel integrity management.',
    `design_standard` STRING COMMENT 'Additional design standards and specifications applied to the equipment such as API 650 for storage tanks, API 660 for shell-and-tube heat exchangers, or API 618 for reciprocating compressors.',
    `design_temperature_f` DECIMAL(18,2) COMMENT 'Maximum or minimum design temperature for which the equipment is rated, expressed in degrees Fahrenheit. Used to determine material selection and thermal expansion considerations.',
    `drawing_number` STRING COMMENT 'Engineering drawing number or Piping and Instrumentation Diagram (P&ID) reference where the equipment is depicted. Used for cross-referencing with engineering documentation.',
    `driver_type` STRING COMMENT 'Type of prime mover or driver for rotating equipment such as electric motor, steam turbine, gas turbine, diesel engine, hydraulic motor, or pneumatic motor.. Valid values are `electric_motor|steam_turbine|gas_turbine|diesel_engine|hydraulic|pneumatic`',
    `equipment_class` STRING COMMENT 'Hierarchical classification of equipment within the asset taxonomy. Used for grouping similar equipment for maintenance planning and reliability analysis.',
    `heat_duty_mmbtu_hr` DECIMAL(18,2) COMMENT 'Heat transfer rate or thermal duty of heat exchangers, heaters, or coolers, expressed in Million British Thermal Units per hour (MMBTU/hr). Key performance parameter for thermal equipment.',
    `insulation_thickness_inches` DECIMAL(18,2) COMMENT 'Thickness of thermal insulation applied to the equipment, expressed in inches. Impacts heat loss calculations and Corrosion Under Insulation (CUI) risk assessments.',
    `insulation_type` STRING COMMENT 'Type of thermal insulation applied to the equipment such as mineral wool, calcium silicate, polyurethane foam, or ceramic fiber. Used for energy efficiency and personnel protection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the equipment specification record was last updated or modified. Tracks the most recent change to the specification data.',
    `material_of_construction` STRING COMMENT 'Primary material specification for equipment construction such as carbon steel (CS), stainless steel (SS 304, SS 316), duplex stainless, Inconel, Monel, or other alloys. Critical for corrosion resistance and fitness-for-service evaluations.',
    `moc_reference_number` STRING COMMENT 'Reference number for the Management of Change (MOC) process that authorized any modifications to the original equipment specification. Required for tracking design changes and maintaining process safety.',
    `motor_rating_hp` DECIMAL(18,2) COMMENT 'Nameplate power rating of the electric motor driver, expressed in horsepower (HP). Applicable to pumps, compressors, fans, and other rotating equipment.',
    `motor_rating_kw` DECIMAL(18,2) COMMENT 'Nameplate power rating of the electric motor driver, expressed in kilowatts (kW). International standard unit for motor power rating.',
    `nominal_diameter_inches` DECIMAL(18,2) COMMENT 'Nominal pipe size or vessel diameter expressed in inches. Standard dimension for piping and cylindrical vessels.',
    `nozzle_configuration` STRING COMMENT 'Description of inlet, outlet, and auxiliary nozzle locations, sizes, and orientations on pressure vessels and piping equipment. Used for piping design and layout.',
    `number_of_nozzles` STRING COMMENT 'Total count of nozzles, connections, and penetrations on the equipment. Used for piping interface management and integrity inspection planning.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Normal operating pressure of the equipment under typical process conditions, expressed in pounds per square inch (PSI). Must be less than or equal to design pressure.',
    `operating_temperature_f` DECIMAL(18,2) COMMENT 'Normal operating temperature of the equipment under typical process conditions, expressed in degrees Fahrenheit. Used for process optimization and integrity assessments.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Nameplate or design capacity of the equipment expressed in appropriate units. For pumps this is flow rate, for vessels this is volume, for heat exchangers this is heat duty.',
    `shell_material` STRING COMMENT 'Material specification for the equipment shell or pressure boundary. Applicable to pressure vessels, heat exchangers, and piping components.',
    `specification_effective_date` DATE COMMENT 'Date when this specification revision became effective and approved for use. Tracks specification lifecycle through Management of Change (MOC) processes.',
    `specification_notes` STRING COMMENT 'Additional technical notes, special requirements, or clarifications related to the equipment specification. Captures engineering judgment and design rationale.',
    `specification_number` STRING COMMENT 'Unique business identifier for the equipment specification document. Used for cross-referencing with engineering drawings and vendor datasheets.',
    `specification_revision` STRING COMMENT 'Revision level of the specification document. Tracks changes through Management of Change (MOC) processes.',
    `specification_status` STRING COMMENT 'Current lifecycle status of the equipment specification. Indicates whether the specification is active and approved for use in engineering and procurement activities.. Valid values are `draft|approved|superseded|obsolete|under_review|archived`',
    `specification_superseded_date` DATE COMMENT 'Date when this specification was superseded by a newer revision or became obsolete. Used for historical tracking and audit trails.',
    `tube_material` STRING COMMENT 'Material specification for heat exchanger tubes or internal components. Applicable to shell-and-tube heat exchangers and similar equipment.',
    `vendor_model_number` STRING COMMENT 'Manufacturer model or catalog number for the equipment. Used to identify compatible spare parts and reference vendor technical documentation.',
    `vendor_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) or fabricator who designed and built the equipment. Used for warranty claims and spare parts procurement.',
    `voltage_rating` STRING COMMENT 'Electrical voltage rating for motor-driven equipment such as 480V, 4160V, or 13.8kV. Critical for electrical system integration and safety.',
    `wall_thickness_inches` DECIMAL(18,2) COMMENT 'Nominal wall thickness of the equipment shell or piping, expressed in inches. Critical parameter for pressure containment and corrosion allowance calculations.',
    CONSTRAINT pk_equipment_specification PRIMARY KEY(`equipment_specification_id`)
) COMMENT 'Detailed technical specification sheet for each equipment item, capturing design parameters including rated capacity, design pressure (MAWP), design temperature, material of construction (MOC), applicable design code (ASME VIII/ANSI/API), nozzle configuration, insulation type, heat duty, motor rating (kW/HP), driver type, and vendor datasheet reference. Supplements the equipment master with engineering design data required for integrity assessments, modifications, and procurement of replacement equipment.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` (
    `maintenance_strategy_id` BIGINT COMMENT 'Unique identifier for the maintenance strategy record. Primary key.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific asset or asset class to which this maintenance strategy applies. Links to the asset master registry.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline segments have maintenance strategies (integrity management, cathodic protection programs). Currently maintenance_strategy only has equipment_id. Adding pipeline_segment_id enables defining ma',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Maintenance strategies (RCM, condition-based, time-based) defined at facility level for operational assets. Direct FK enables facility-level maintenance planning, budget allocation, and performance tr',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Wells have maintenance strategies (artificial lift maintenance, wellbore integrity programs). Currently maintenance_strategy only has equipment_id. Adding well_asset_id enables defining maintenance st',
    `work_center_id` BIGINT COMMENT 'Identifier of the maintenance work center or craft group responsible for executing maintenance tasks under this strategy. Links to organizational structure in Maximo CMMS.',
    `approval_date` DATE COMMENT 'Date on which this maintenance strategy was formally approved for implementation. Aligns with Management of Change (MOC) approval workflows.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this maintenance strategy for implementation. Provides accountability and audit trail for strategy governance.',
    `asset_class` STRING COMMENT 'Classification of the asset type to which this strategy applies (e.g., rotating equipment, pressure vessels, pipelines, electrical systems, instrumentation). Used for strategy standardization across similar asset types.',
    `condition_monitoring_method` STRING COMMENT 'Specific condition monitoring technique(s) prescribed by this strategy (e.g., vibration analysis, ultrasonic testing, infrared thermography, oil analysis, corrosion monitoring). Applicable when condition_monitoring_required_flag is true.',
    `condition_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether continuous or periodic condition monitoring (e.g., vibration analysis, thermography, oil analysis) is required under this strategy. True for condition-based and predictive strategies.',
    `cost_benefit_justification` STRING COMMENT 'Business case narrative explaining the rationale for selecting this maintenance strategy, including cost-benefit analysis, risk mitigation considerations, and alignment with asset integrity objectives. Supports Authorization for Expenditure (AFE) approval.',
    `cost_center` STRING COMMENT 'Financial cost center to which maintenance costs under this strategy are charged. Used for Operating Expenditure (OPEX) tracking and Lease Operating Expense (LOE) allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance strategy record was first created in the system. Provides audit trail for data lineage and governance.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the asset, reflecting its impact on production, safety, and environmental performance. Drives maintenance resource prioritization and strategy selection.. Valid values are `critical|high|medium|low`',
    `effective_date` DATE COMMENT 'Date from which this maintenance strategy becomes active and governs maintenance planning and execution. Aligns with Management of Change (MOC) approval workflows.',
    `end_date` DATE COMMENT 'Date on which this maintenance strategy is retired or superseded. Null for currently active strategies with no planned retirement.',
    `estimated_annual_cost_usd` DECIMAL(18,2) COMMENT 'Projected annual cost in United States Dollars (USD) to execute this maintenance strategy, including labor, materials, contractor services, and condition monitoring. Used for Lease Operating Expense (LOE) and Operating Expenditure (OPEX) budgeting.',
    `hse_classification` STRING COMMENT 'Health, Safety, and Environment (HSE) classification indicating whether the asset is safety-critical (failure could cause injury or fatality), environmental-critical (failure could cause environmental release), or non-critical. Drives strategy rigor and approval requirements.. Valid values are `safety-critical|environmental-critical|non-critical`',
    `inspection_interval_days` STRING COMMENT 'Frequency in days for scheduled inspections under this strategy. Applicable to time-based and condition-based strategies. Drives inspection event scheduling in the CMMS.',
    `integrity_management_program` STRING COMMENT 'Name of the asset integrity management program under which this strategy is governed (e.g., Pipeline Integrity Management Program, Pressure Equipment Integrity Program, Rotating Equipment Reliability Program). Aligns with ISO 55001 and industry-specific integrity frameworks.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance strategy record was last updated. Tracks change history and supports audit requirements.',
    `moc_reference_number` STRING COMMENT 'Reference number of the Management of Change (MOC) request that authorized the creation or modification of this maintenance strategy. Links to MOC workflow system for audit trail.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this maintenance strategy require formal Management of Change (MOC) review and approval due to safety, environmental, or operational risk implications. True for safety-critical and environmental-critical assets.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this maintenance strategy to assess effectiveness, update intervals, and incorporate lessons learned from failure analysis and performance data.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the maintenance strategy. Used for capturing lessons learned, temporary deviations, or implementation guidance.',
    `planner_group` STRING COMMENT 'Maintenance planning group responsible for scheduling and coordinating work orders generated from this strategy. Used for workload balancing and resource allocation.',
    `pm_interval_days` STRING COMMENT 'Frequency in days for scheduled preventive maintenance tasks under this strategy. Used to generate PM work orders in Maximo CMMS.',
    `rbi_assessment_reference` STRING COMMENT 'Reference identifier for the Risk-Based Inspection (RBI) assessment that determined inspection intervals and methods for pressure equipment and piping. Applicable to refining and processing assets.',
    `rcm_analysis_reference` STRING COMMENT 'Reference identifier for the Reliability-Centered Maintenance (RCM) analysis or Failure Modes and Effects Analysis (FMEA) study that informed the selection of this strategy. Links to engineering documentation.',
    `regulatory_driver` STRING COMMENT 'Regulatory requirement or industry standard that mandates or influences this maintenance strategy (e.g., Bureau of Safety and Environmental Enforcement (BSEE) inspection requirements, Pipeline and Hazardous Materials Safety Administration (PHMSA) integrity management, American Petroleum Institute (API) recommended practices).',
    `spare_parts_policy` STRING COMMENT 'Inventory strategy for spare parts supporting this maintenance strategy: stock-critical (on-site inventory for critical spares), stock-insurance (strategic inventory for long-lead items), procure-on-demand (just-in-time procurement), or vendor-managed (supplier-held consignment stock).. Valid values are `stock-critical|stock-insurance|procure-on-demand|vendor-managed`',
    `strategy_description` STRING COMMENT 'Detailed narrative description of the maintenance strategy, including scope, objectives, key tasks, and special considerations. Provides comprehensive context for maintenance planners and technicians.',
    `strategy_name` STRING COMMENT 'Descriptive name of the maintenance strategy, providing a human-readable label for identification and reporting purposes.',
    `strategy_number` STRING COMMENT 'Business identifier for the maintenance strategy, typically assigned by the Computerized Maintenance Management System (CMMS) such as Maximo. Used for external reference and reporting.',
    `strategy_status` STRING COMMENT 'Current lifecycle status of the maintenance strategy. Active strategies drive preventive maintenance (PM) plan generation; draft and under-review strategies are pending approval; suspended strategies are temporarily inactive; obsolete strategies are retired.. Valid values are `draft|active|suspended|obsolete|under-review`',
    `strategy_type` STRING COMMENT 'Classification of the maintenance approach: run-to-failure (reactive), time-based (preventive), condition-based (monitoring-driven), predictive (analytics-driven), reliability-centered maintenance (RCM), or risk-based inspection (RBI). Determines the governing methodology for maintenance planning.. Valid values are `run-to-failure|time-based|condition-based|predictive|reliability-centered|risk-based`',
    `target_mtbf_hours` DECIMAL(18,2) COMMENT 'Target Mean Time Between Failures (MTBF) in hours that this maintenance strategy is designed to achieve. Used as a key performance indicator (KPI) for strategy effectiveness and reliability improvement.',
    `target_mttr_hours` DECIMAL(18,2) COMMENT 'Target Mean Time To Repair (MTTR) in hours that this maintenance strategy is designed to achieve through optimized maintenance task planning and spare parts availability. Used as a KPI for maintenance efficiency.',
    `turnaround_planning_flag` BOOLEAN COMMENT 'Indicates whether this maintenance strategy includes tasks that are deferred to scheduled plant turnarounds or shutdowns. True for major overhaul activities that require extended downtime.',
    CONSTRAINT pk_maintenance_strategy PRIMARY KEY(`maintenance_strategy_id`)
) COMMENT 'Defines the approved maintenance strategy for each asset class or individual critical asset, specifying strategy type (run-to-failure/time-based/condition-based/predictive/reliability-centered), maintenance task library, inspection intervals, condition monitoring requirements, spare parts policy, and cost-benefit justification. Serves as the governing document that drives PM plan generation and maintenance resource planning. Aligned with RCM methodology and ISO 55001 asset management planning requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` (
    `abandonment_plan_id` BIGINT COMMENT 'Unique identifier for the abandonment plan record. Primary key for the abandonment plan entity.',
    `asset_id` BIGINT COMMENT 'Reference to the asset (well, facility, pipeline) subject to abandonment or decommissioning. Links to the asset master registry.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Abandonment plans submitted as regulatory filings to state/federal agencies for approval. Core requirement for well plugging, facility decommissioning, and ARO management.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Well/facility abandonment typically executed under specialized service contracts (P&A, decommissioning, environmental remediation). Links abandonment execution to contractor agreements, day rates, and',
    `contractor_id` BIGINT COMMENT 'Reference to the primary contractor or service company responsible for executing the abandonment or decommissioning work.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Abandonment costs must be tracked against cost centers for ARO liability management, decommissioning spend authorization, and regulatory cost reporting - required for asset retirement obligation accou',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Abandonment plans for JV assets or divested facilities require tracking the counterparty for cost sharing (working interest allocation), regulatory approval coordination, ARO liability allocation, and',
    `employee_id` BIGINT COMMENT 'Reference to the operator entity responsible for the abandonment plan and regulatory compliance. May differ from asset owner in joint venture scenarios.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Abandonment projects require AFE approval and tracking for ARO spend authorization, decommissioning cost control, and regulatory cost reporting - mandated for asset retirement obligation management.',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to production.injection_well. Business justification: Injection well abandonment requires specific regulatory compliance (EPA UIC permit closure, mechanical integrity demonstration, zone isolation). Direct FK enables injection well-specific abandonment t',
    `joa_id` BIGINT COMMENT 'Reference to the joint venture or partnership under which the asset is operated and abandonment costs will be allocated among working interest owners.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Abandonment requires plugging permits, decommissioning permits, and environmental closure permits. Core regulatory requirement. Existing permit_number should be normalized.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Well abandonment plans required for regulatory compliance (state oil/gas commission approval, EPA UIC closure) and ARO liability management. Direct FK enables well-level abandonment tracking, cost est',
    `abandonment_method` STRING COMMENT 'Method planned for abandonment or decommissioning: plug and abandon (P&A) for wells, decommission in place, complete removal, partial removal, or reef conversion for offshore structures.. Valid values are `plug_and_abandon|decommission_in_place|complete_removal|partial_removal|reef_conversion`',
    `actual_abandonment_date` DATE COMMENT 'Actual date when the abandonment or decommissioning activity was completed. Null if not yet executed.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost incurred in US dollars for the abandonment or decommissioning activity. Null if not yet completed or costs not finalized.',
    `aro_liability_usd` DECIMAL(18,2) COMMENT 'Recorded Asset Retirement Obligation (ARO) liability amount in US dollars on the balance sheet for this abandonment plan, calculated per IFRS IAS 37 or GAAP ASC 410-20.',
    `asset_type` STRING COMMENT 'Classification of the asset being abandoned: well, facility, pipeline, platform, FPSO (Floating Production Storage and Offloading), subsea infrastructure, processing plant, compressor station, or storage tank. [ENUM-REF-CANDIDATE: well|facility|pipeline|platform|fpso|subsea_infrastructure|processing_plant|compressor_station|storage_tank — 9 candidates stripped; promote to reference product]',
    `capex_opex_classification` STRING COMMENT 'Accounting classification of abandonment costs: CAPEX (capital expenditure) if capitalized as part of asset retirement obligation, OPEX (operating expenditure) if expensed, or mixed if both components exist.. Valid values are `capex|opex|mixed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the abandonment plan record was first created in the system. Audit trail field.',
    `environmental_remediation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether environmental remediation (soil cleanup, contamination removal, habitat restoration) is required as part of the abandonment plan.',
    `environmental_remediation_scope` STRING COMMENT 'Description of the environmental remediation activities required, including soil remediation, groundwater treatment, contamination removal, habitat restoration, or spill cleanup.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in US dollars for executing the abandonment or decommissioning plan, including labor, materials, contractor services, environmental remediation, and site restoration.',
    `financial_assurance_amount_usd` DECIMAL(18,2) COMMENT 'Amount of financial assurance (bonding, surety, letter of credit, or trust fund) required by the regulatory authority to guarantee funds are available for abandonment. Required by BSEE for offshore operations.',
    `financial_assurance_type` STRING COMMENT 'Type of financial assurance instrument provided to the regulatory authority: surety bond, letter of credit, trust fund, self-insurance (for qualified operators), or third-party guarantee.. Valid values are `surety_bond|letter_of_credit|trust_fund|self_insurance|third_party_guarantee`',
    `hse_risk_assessment_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a formal HSE (Health Safety and Environment) risk assessment has been completed for the abandonment activities.',
    `hse_risk_level` STRING COMMENT 'Overall HSE risk level assigned to the abandonment project based on risk assessment: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the abandonment plan record was last modified. Audit trail field for tracking changes to the plan.',
    `norm_disposal_plan` STRING COMMENT 'Description of the plan for handling and disposing of NORM contaminated materials, including licensed disposal facility, transportation method, and regulatory compliance measures.',
    `norm_disposal_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether disposal of NORM (Naturally Occurring Radioactive Material) contaminated equipment or materials is required as part of the abandonment plan.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special considerations related to the abandonment plan, including regulatory conditions, stakeholder agreements, or operational constraints.',
    `number_of_plugs` STRING COMMENT 'For well abandonment, the number of cement or mechanical plugs to be set in the wellbore to isolate hydrocarbon zones and aquifers per regulatory requirements.',
    `plan_approved_by` STRING COMMENT 'Name or identifier of the regulatory official or authority who approved the abandonment plan.',
    `plan_approved_date` DATE COMMENT 'Date when the abandonment plan was approved by the regulatory authority. Null if not yet approved.',
    `plan_document_code` STRING COMMENT 'Reference to the document management system identifier for the formal abandonment plan document, including engineering drawings, procedures, and regulatory submissions.',
    `plan_number` STRING COMMENT 'Business identifier for the abandonment plan, typically assigned by the operator or regulatory authority for tracking and reference purposes.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the abandonment plan: draft, submitted to regulatory authority, under review, approved, rejected, in progress (execution underway), completed, or cancelled. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|in_progress|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `plan_submitted_date` DATE COMMENT 'Date when the abandonment plan was submitted to the regulatory authority for review and approval.',
    `planned_abandonment_date` DATE COMMENT 'Target date for commencing or completing the abandonment or decommissioning activity as submitted in the plan.',
    `post_abandonment_monitoring_duration_years` STRING COMMENT 'Duration in years for which post-abandonment monitoring is required after completion of abandonment activities.',
    `post_abandonment_monitoring_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether post-abandonment monitoring (groundwater monitoring, subsidence monitoring, leak detection, or environmental monitoring) is required by regulatory authority or operating agreement.',
    `post_abandonment_monitoring_scope` STRING COMMENT 'Description of post-abandonment monitoring activities required, including groundwater quality monitoring, subsidence surveys, leak detection, methane emissions monitoring, or ecological impact assessment.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval from governing authority (BSEE, state agency, or international regulator): not submitted, pending review, approved, conditional approval, denied, or expired.. Valid values are `not_submitted|pending|approved|conditional_approval|denied|expired`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body with jurisdiction over the abandonment (e.g., BSEE for federal offshore, state oil and gas commission for onshore, international authority for foreign operations).',
    `site_restoration_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether site restoration to original or agreed-upon condition is required after abandonment, including removal of structures, grading, revegetation, or habitat restoration.',
    `site_restoration_scope` STRING COMMENT 'Description of site restoration activities required, including removal of surface equipment, grading and contouring, revegetation, erosion control, or restoration to agricultural or natural habitat condition.',
    `subsea_equipment_removal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether subsea equipment (subsea trees, manifolds, flowlines, umbilicals, risers) will be removed as part of the abandonment plan. Applicable for offshore operations.',
    `surface_equipment_removal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether surface equipment (wellhead, Christmas tree, separators, tanks, piping) will be removed as part of the abandonment plan.',
    `well_plug_method` STRING COMMENT 'For well abandonment, the method used to plug the wellbore: cement plug, mechanical plug, bridge plug, or combination of methods. Applicable only when asset_type is well.. Valid values are `cement_plug|mechanical_plug|bridge_plug|combination`',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the operator or reporting entity in the asset being abandoned. Used for cost allocation in joint venture scenarios.',
    CONSTRAINT pk_abandonment_plan PRIMARY KEY(`abandonment_plan_id`)
) COMMENT 'Plug and Abandonment (P&A) plan record for wells and decommissioning plans for facilities and pipelines, capturing regulatory approval status (BSEE/state), planned P&A date, abandonment method, estimated abandonment cost (OPEX/CAPEX), environmental remediation requirements, NORM disposal plan, site restoration obligations, financial assurance (bonding) amount, and post-abandonment monitoring requirements. Supports ARO (Asset Retirement Obligation) accounting under IFRS/GAAP and BSEE decommissioning compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` (
    `equipment_contract_coverage_id` BIGINT COMMENT 'Unique identifier for this equipment-contract coverage relationship. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract providing coverage',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to the equipment asset covered under this contract',
    `added_to_contract_date` DATE COMMENT 'The date when this equipment was formally added to the contract scope, used for tracking contract amendments and scope changes.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The specific rate or fee applicable to this equipment under this contract. May be per-call, monthly retainer, annual fee, or hourly rate depending on contract type and equipment criticality.',
    `coverage_end_date` DATE COMMENT 'The date when coverage for this equipment under this contract ends. May differ from master contract expiry if equipment is removed from scope.',
    `coverage_scope` STRING COMMENT 'Description of what services are included for this equipment under this contract (e.g., preventive maintenance only, full breakdown repair and PM, calibration and certification, inspection per API 510).',
    `coverage_start_date` DATE COMMENT 'The date when this specific equipment became covered under this contract. May differ from the master contract effective date if equipment was added mid-term.',
    `coverage_status` STRING COMMENT 'Current status of this equipments coverage under this contract. Active indicates coverage is in force, suspended indicates temporary hold, expired indicates coverage has ended, pending_activation indicates coverage is scheduled but not yet effective.',
    `exclusions` STRING COMMENT 'Specific exclusions or limitations that apply to this equipment under this contract (e.g., excludes consumables, excludes damage from operator error, excludes modifications).',
    `priority_level` STRING COMMENT 'The service priority level assigned to this equipment under this contract, which determines response time and resource allocation (critical, high, standard, low).',
    `rate_unit` STRING COMMENT 'The unit of measure for the contracted rate (e.g., per_call, monthly, annual, hourly, per_inspection).',
    `removed_from_contract_date` DATE COMMENT 'The date when this equipment was removed from the contract scope, if applicable. Nullable for equipment still under coverage.',
    `service_level_agreement` STRING COMMENT 'The specific SLA terms applicable to this equipment under this contract, including response time commitments, uptime guarantees, and performance metrics (e.g., 4-hour response, 24-hour repair completion, 98% uptime guarantee).',
    CONSTRAINT pk_equipment_contract_coverage PRIMARY KEY(`equipment_contract_coverage_id`)
) COMMENT 'This association product represents the contractual coverage relationship between equipment assets and procurement contracts. It captures which equipment items are covered under which service, maintenance, inspection, or calibration contracts, along with the specific terms, rates, and service level agreements that apply to each equipment-contract pairing. Each record links one equipment asset to one procurement contract with attributes that exist only in the context of this coverage relationship.. Existence Justification: In oil and gas operations, equipment assets are routinely covered under multiple concurrent procurement contracts (e.g., a compressor may have a maintenance service contract, a separate calibration contract, and an inspection contract all active simultaneously). Conversely, procurement contracts—especially master service agreements and blanket maintenance contracts—typically cover multiple equipment items (e.g., a rotating equipment service agreement covering 50+ pumps and compressors across a facility). The business actively manages these coverage relationships, tracking which equipment is covered under which contracts with specific SLA terms, rates, and scope definitions for each pairing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` (
    `asset_working_interest_id` BIGINT COMMENT 'Primary key for asset_working_interest',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to the facility asset that is subject to joint ownership',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner entity holding the working interest',
    `venture_working_interest_id` BIGINT COMMENT 'Unique identifier for this working interest record. Primary key for the association.',
    `billing_entity_code` STRING COMMENT 'Code identifying the legal entity to be billed for this partners share of joint interest billing for this facility.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was created in the system.',
    `effective_date` DATE COMMENT 'The date when this working interest arrangement became effective. Used for temporal tracking of ownership changes due to farm-ins, farm-outs, acquisitions, or relinquishments.',
    `expiry_date` DATE COMMENT 'The date when this working interest arrangement expires or was superseded by a new arrangement. Null indicates the arrangement is currently active.',
    `joa_agreement_number` STRING COMMENT 'Reference to the Joint Operating Agreement document that governs this working interest arrangement.',
    `last_modified_by` STRING COMMENT 'User ID of the person who last modified this working interest record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was last modified.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of production revenue that this partner is entitled to receive after royalties and overriding royalty interests are deducted. Typically less than or equal to working interest percentage.',
    `operator_flag` BOOLEAN COMMENT 'Boolean indicator of whether this partner serves as the designated operator for this facility. Only one partner per facility should have this flag set to true for any given time period.',
    `participating_status` STRING COMMENT 'Indicates whether the partner is actively participating in costs and revenues, carried by other partners, or has farmed out their interest.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage of operational costs and capital expenditures that this partner is obligated to bear for this facility. Must sum to 100% across all partners for a given facility and time period.',
    `created_by` STRING COMMENT 'User ID of the person who created this working interest record.',
    CONSTRAINT pk_asset_working_interest PRIMARY KEY(`asset_working_interest_id`)
) COMMENT 'This association product represents the ownership stake and operational responsibility between a facility and a partner in oil and gas joint ventures. It captures the working interest percentage, net revenue interest, operator designation, and temporal validity of each partners participation in a facility. Each record links one facility to one partner with attributes that exist only in the context of this ownership relationship.. Existence Justification: In oil and gas joint ventures, facilities are routinely owned by multiple partners with varying working interest percentages, and partners hold stakes in multiple facilities across their portfolio. This is a fundamental operational reality governed by Joint Operating Agreements (JOAs) and Production Sharing Agreements (PSAs). The detection reasoning explicitly states that this relationship is already modeled via venture_working_interest, confirming this is an established business practice, not a theoretical construct.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` (
    `facility_carrier_approval_id` BIGINT COMMENT 'Unique identifier for the facility-carrier approval relationship. Primary key for the association.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to the facility that has approved or is evaluating the carrier for operations',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier that has been approved or is being evaluated for facility access',
    `access_credential_number` STRING COMMENT 'Unique identifier for the physical or digital access credential issued to the carrier for this facility. Used for gate access and security tracking.',
    `approval_date` DATE COMMENT 'Date when the carrier was approved for operations at this facility. Used for approval expiry calculations and audit trail.',
    `approval_notes` STRING COMMENT 'Free-text notes capturing facility-specific conditions, restrictions, or special handling requirements for this carrier.',
    `approval_status` STRING COMMENT 'Current approval status of the carrier for operations at this specific facility. Drives carrier selection logic in logistics planning systems.',
    `approved_product_types_at_facility` STRING COMMENT 'Comma-separated list of petroleum product types that the carrier is approved to transport from or to this specific facility. May be a subset of the carriers overall approved product types based on facility-specific handling capabilities.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this facility-carrier approval record was created in the system.',
    `credential_expiry_date` DATE COMMENT 'Date when the facility access credential expires. Triggers credential renewal process.',
    `credential_issue_date` DATE COMMENT 'Date when the facility access credential was issued to the carrier.',
    `facility_access_level` STRING COMMENT 'Level of physical access granted to the carrier at this facility. Determines which facility zones and operations the carrier can access.',
    `facility_specific_training_completed` BOOLEAN COMMENT 'Indicates whether the carrier personnel have completed facility-specific safety and operational training required for this facility.',
    `hse_clearance_status` STRING COMMENT 'Health, Safety, and Environment clearance status specific to this facility. Facilities may have different HSE requirements based on process safety tier and operational risk.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this facility-carrier approval record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this facility-carrier approval record was last modified in the system.',
    `last_vetting_date` DATE COMMENT 'Date of the most recent facility-specific vetting or audit of this carrier. Facilities may conduct their own vetting beyond corporate-level carrier vetting.',
    `max_daily_movements` STRING COMMENT 'Maximum number of daily pickup or delivery movements allowed for this carrier at this facility. Used for capacity planning and congestion management.',
    `next_vetting_due_date` DATE COMMENT 'Date when the next facility-specific vetting or audit is due for this carrier.',
    `preferred_carrier_flag` BOOLEAN COMMENT 'Indicates whether this carrier is designated as a preferred carrier for this facility. Preferred carriers receive priority in logistics planning and may have expedited access procedures.',
    `training_completion_date` DATE COMMENT 'Date when facility-specific training was completed. Used to track training currency and recertification requirements.',
    `training_expiry_date` DATE COMMENT 'Date when facility-specific training expires and requires renewal. Triggers recertification workflows.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this facility-carrier approval record.',
    CONSTRAINT pk_facility_carrier_approval PRIMARY KEY(`facility_carrier_approval_id`)
) COMMENT 'This association product represents the approval and authorization relationship between facilities and carriers. It captures facility-specific carrier vetting, access authorization, HSE clearance, and operational approval status. Each record links one facility to one carrier with attributes that exist only in the context of this facility-carrier relationship, enabling logistics planning, facility security management, and carrier qualification tracking.. Existence Justification: In oil and gas logistics operations, facilities approve multiple carriers for access and operations (each carrier must pass facility-specific vetting, HSE clearance, and training), and carriers operate at multiple facilities across the network. The approval relationship is actively managed with facility-specific attributes including approval status, access credentials, HSE clearance, training completion, and preferred carrier designation that exist only in the context of each facility-carrier pair.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` (
    `facility_vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the facility-vendor qualification record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to the facility where the vendor is qualified to operate',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the qualified vendor',
    `access_authorization_level` STRING COMMENT 'Level of physical access authorization granted to vendor personnel at this facility. Determines which facility zones vendor staff can access and whether escort is required. Facility-specific based on security classification and vendor trust level.',
    `active_status` STRING COMMENT 'Current status of the vendor qualification at this facility. Active qualifications allow vendor to perform work; suspended/expired/revoked qualifications block vendor access and work orders.',
    `approved_scope` STRING COMMENT 'Detailed description of the scope of work the vendor is authorized to perform at this facility. Facility-specific and may differ from the vendors general capabilities based on local regulatory requirements, facility complexity, and risk assessment.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this qualification record was created in the system.',
    `facility_specific_rating` DECIMAL(18,2) COMMENT 'Performance rating of the vendor specific to this facility, typically on a scale of 0.00 to 5.00. Reflects vendor performance in the context of this facilitys operations, HSE compliance, and service quality. A vendor may have different ratings at different facilities.',
    `hse_induction_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether vendor personnel have completed the facility-specific HSE induction training. Required before vendor can commence work at the facility.',
    `hse_induction_date` DATE COMMENT 'Date when the facility-specific HSE induction was completed by vendor personnel.',
    `insurance_verification_date` DATE COMMENT 'Date when vendor insurance was last verified for this facility.',
    `insurance_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendors insurance coverage has been verified as adequate for work at this facility. Facility-specific based on facility risk tier and scope of work.',
    `last_updated_by` STRING COMMENT 'User ID of the person who last modified this qualification record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified.',
    `last_work_order_date` DATE COMMENT 'Date of the most recent work order issued to this vendor at this facility. Used for tracking vendor activity and identifying inactive qualifications.',
    `qualification_date` DATE COMMENT 'Date when the vendor was qualified and approved to provide services at this specific facility. Triggers facility-specific onboarding and access provisioning workflows.',
    `qualification_expiry_date` DATE COMMENT 'Date when the facility-specific vendor qualification expires and requires renewal. Drives re-qualification workflows and access revocation.',
    `suspension_reason` STRING COMMENT 'Detailed explanation of why the vendor qualification was suspended or revoked at this facility, including reference to incidents, HSE violations, or performance issues.',
    `total_work_orders_count` STRING COMMENT 'Cumulative count of work orders issued to this vendor at this facility since qualification. Used for vendor performance analytics and relationship strength assessment.',
    `vendor_role` STRING COMMENT 'The specific role or service category the vendor is qualified to perform at this facility. A vendor may have different roles at different facilities based on facility-specific needs and qualifications.',
    `created_by` STRING COMMENT 'User ID of the person who created this qualification record.',
    CONSTRAINT pk_facility_vendor_qualification PRIMARY KEY(`facility_vendor_qualification_id`)
) COMMENT 'This association product represents the qualification and authorization relationship between facilities and vendors in the oil and gas procurement ecosystem. It captures facility-specific vendor qualifications, approved scopes of work, access authorization levels, and performance ratings. Each record links one facility to one vendor with attributes that exist only in the context of this facility-vendor relationship, enabling site-specific vendor management, access control, and performance tracking.. Existence Justification: In oil and gas operations, facilities require multiple vendors for different services (maintenance contractors, inspection firms, catering, security, drilling contractors, EPC firms, catalyst suppliers, MRO vendors), and each vendor is typically qualified to work across multiple facilities in the operators portfolio. The facility-vendor qualification is an operational business entity that facility managers and procurement teams actively create, maintain, and revoke based on HSE compliance, performance, and site-specific requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` (
    `program_vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the program vendor qualification record. Primary key.',
    `integrity_program_id` BIGINT COMMENT 'Foreign key linking to the asset integrity management program that requires qualified vendor services',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the qualified vendor authorized to perform services for this integrity program',
    `approval_date` DATE COMMENT 'Date when the qualification was formally approved by the program owner or authorized approver.',
    `approved_by` STRING COMMENT 'Name or identifier of the integrity program owner or authorized approver who qualified the vendor for this program. Used for accountability and audit purposes.',
    `approved_inspection_methods` STRING COMMENT 'Comma-separated list or detailed specification of inspection and monitoring methods the vendor is approved to use for this integrity program (e.g., ultrasonic testing, radiographic testing, magnetic particle inspection, visual inspection, acoustic emission testing). Ensures method compatibility with program requirements.',
    `certification_requirements` STRING COMMENT 'Specific certifications, accreditations, or qualifications required for the vendor to perform work under this integrity program (e.g., ASNT Level III certification, API 510/570/653 inspector certification, ISO 9001 accreditation, NACE certification). Used for compliance verification.',
    `contract_reference` STRING COMMENT 'Reference number or identifier for the master service agreement, purchase order, or contract governing the vendors services for this integrity program. Links qualification to procurement and legal agreements.',
    `hse_qualification_flag` BOOLEAN COMMENT 'Boolean indicator whether the vendor has completed required Health, Safety, and Environmental (HSE) qualification and training specific to the operating unit or facility covered by this integrity program. Required for site access and work authorization.',
    `insurance_requirements_met_flag` BOOLEAN COMMENT 'Boolean indicator whether the vendor has provided proof of required insurance coverage (professional liability, general liability, workers compensation) for work under this integrity program. Required for risk management and HSE compliance.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review or quality audit of the vendors work under this integrity program. Used to track ongoing vendor performance management.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, restrictions, or comments related to the vendor qualification for this integrity program.',
    `performance_rating` STRING COMMENT 'Current performance rating or quality score for the vendors work under this integrity program (e.g., Excellent, Satisfactory, Needs Improvement, Unsatisfactory). Used for vendor management and re-qualification decisions.',
    `qualification_date` DATE COMMENT 'Date when the vendor was qualified and approved to perform services for this specific integrity program. Used for compliance tracking and audit trails.',
    `qualification_expiry_date` DATE COMMENT 'Date when the vendors qualification for this integrity program expires and requires renewal or re-qualification. Nullable for indefinite qualifications subject to periodic review.',
    `qualification_scope` STRING COMMENT 'Detailed description of the specific scope of work, asset types, or inspection activities the vendor is qualified to perform under this integrity program. May reference specific equipment classes, inspection zones, or technical specializations.',
    `qualification_status` STRING COMMENT 'Current status of the vendor qualification for this program: Active, Suspended, Expired, Under Review, Revoked. Used to control vendor authorization and work assignment.',
    `vendor_role` STRING COMMENT 'The specific role or service type the vendor is qualified to perform for this integrity program (e.g., NDE inspection provider, RBI consultant, FFS assessor, corrosion monitoring specialist, third-party verification). Defines the vendors authorized scope of work.',
    CONSTRAINT pk_program_vendor_qualification PRIMARY KEY(`program_vendor_qualification_id`)
) COMMENT 'This association product represents the qualification and approval relationship between integrity programs and vendors authorized to perform inspection, monitoring, and assessment services. It captures vendor-specific qualifications, approved methods, certification requirements, and contractual arrangements that exist only in the context of a specific integrity program. Each record links one integrity program to one qualified vendor with attributes governing their authorized scope of work, compliance requirements, and performance standards for that program.. Existence Justification: In oil and gas asset integrity management, a single integrity program (e.g., pressure vessel corrosion management for a refinery) requires multiple qualified vendors with different specializations: NDE inspection contractors, RBI consultants, fitness-for-service assessors, and third-party verification bodies. Conversely, a qualified vendor (e.g., a specialized NDE contractor) participates in multiple integrity programs across different assets, facilities, and operating units. The business actively manages vendor qualifications per program, tracking approved methods, certifications, contract references, and performance ratings specific to each program-vendor combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset` (
    `asset_id` BIGINT COMMENT 'Primary key for asset',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Assets are classified by asset class; adding asset_class_id FK links each asset to its classification reference.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the asset record.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location or site where the asset resides.',
    `operator_id` BIGINT COMMENT 'Identifier of the company that operates the asset.',
    `parent_asset_id` BIGINT COMMENT 'Identifier of the parent asset in a hierarchical relationship, if applicable.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the asset record.',
    `asset_category_code` STRING COMMENT 'Code representing the assets category within internal taxonomy.',
    `asset_description` STRING COMMENT 'Free‑form description of the asset, including purpose and key characteristics.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the asset.',
    `asset_tag` STRING COMMENT 'Physical tag or barcode assigned to the asset for identification on the shop floor.',
    `asset_type` STRING COMMENT 'Category of the physical asset.',
    `capital_expenditure` DECIMAL(18,2) COMMENT 'Capital cost incurred to acquire or construct the asset.',
    `commissioning_date` DATE COMMENT 'Date the asset entered operational service.',
    `compliance_last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the asset is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system.',
    `current_value` DECIMAL(18,2) COMMENT 'Net book value of the asset after depreciation.',
    `decommission_date` DATE COMMENT 'Date the asset was permanently removed from service, if applicable.',
    `depreciation_method` STRING COMMENT 'Method used to depreciate the asset over its useful life.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the asset began.',
    `environmental_impact_rating` STRING COMMENT 'Rating of the assets environmental impact.',
    `installation_date` DATE COMMENT 'Date the asset was installed at its location.',
    `is_critical_asset` BOOLEAN COMMENT 'Indicates whether the asset is deemed critical to operations (true) or not (false).',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance activity was performed.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the asset location in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the asset location in decimal degrees.',
    `maintenance_strategy` STRING COMMENT 'Approach used for maintaining the asset.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the asset.',
    `mean_time_between_failures` DOUBLE COMMENT 'Average operating time between successive failures, expressed in hours.',
    `mean_time_to_repair` DOUBLE COMMENT 'Average time required to repair the asset after a failure, expressed in hours.',
    `model_number` STRING COMMENT 'Model or type designation assigned by the manufacturer.',
    `next_maintenance_due_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `operational_expenditure` DECIMAL(18,2) COMMENT 'Ongoing cost to operate and maintain the asset.',
    `ownership_type` STRING COMMENT 'Legal ownership arrangement for the asset.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status with applicable regulations.',
    `risk_score` DOUBLE COMMENT 'Quantitative risk score (0‑100) representing overall asset risk.',
    `safety_classification` STRING COMMENT 'Safety class assigned to the asset based on hazard potential.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the asset.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated number of years the asset is expected to be economically usable.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty on the asset expires.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master reference table for asset. Referenced by asset_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Primary key for work_center',
    `location_id` BIGINT COMMENT 'Reference to the geographic location or facility where the work center resides.',
    `parent_work_center_id` BIGINT COMMENT 'Identifier of the parent work center in a hierarchical structure.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee supervising the work center.',
    `asset_tag` STRING COMMENT 'Physical tag or barcode assigned to the work center for inventory tracking.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum production capacity of the work center expressed in megawatts.',
    `work_center_code` STRING COMMENT 'Business code used to reference the work center in operational systems.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the work center.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work center record was first created.',
    `work_center_description` STRING COMMENT 'Detailed textual description of the work centers purpose and capabilities.',
    `effective_end_date` DATE COMMENT 'Date when the work center is scheduled to be retired or decommissioned (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the work center became operational.',
    `environmental_zone` STRING COMMENT 'Designated environmental zone for the work center location.',
    `integration_system` STRING COMMENT 'Enterprise system used to manage the work center data.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the work center is considered critical to production.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the work center (decimal degrees).',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the work center (decimal degrees).',
    `maintenance_window_end` STRING COMMENT 'Planned end time of the regular maintenance window (HH:mm).',
    `maintenance_window_start` STRING COMMENT 'Planned start time of the regular maintenance window (HH:mm).',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between unplanned failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to restore the work center after a failure.',
    `work_center_name` STRING COMMENT 'Human‑readable name of the work center.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the work center.',
    `operating_hours_per_day` STRING COMMENT 'Number of hours the work center is scheduled to operate each day.',
    `operational_status` STRING COMMENT 'Real‑time operational state of the work center.',
    `responsible_department` STRING COMMENT 'Department accountable for the work centers performance.',
    `safety_rating` STRING COMMENT 'Safety classification of the work center based on internal risk assessments.',
    `shift_pattern` STRING COMMENT 'Standard shift arrangement used at the work center.',
    `work_center_status` STRING COMMENT 'Current lifecycle status of the work center.',
    `work_center_type` STRING COMMENT 'Category of work center based on primary function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the work center record.',
    `work_center_group` STRING COMMENT 'Logical grouping or hierarchy name for related work centers.',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master reference table for work_center. Referenced by work_center_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`field` (
    `field_id` BIGINT COMMENT 'Primary key for field',
    `parent_field_id` BIGINT COMMENT 'Self-referencing FK on field (parent_field_id)',
    `basin` STRING COMMENT 'Geologic basin or structural feature containing the field.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the field is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the field record was first created in the system.',
    `field_description` STRING COMMENT 'Free‑form textual description of the fields characteristics and history.',
    `discovery_date` DATE COMMENT 'Date the field was first discovered.',
    `environmental_status` STRING COMMENT 'Current status of environmental regulatory compliance.',
    `expected_end_of_production_date` DATE COMMENT 'Projected date when the field will cease production.',
    `field_capacity_boepd` DECIMAL(18,2) COMMENT 'Maximum designed production rate expressed in BOE per day.',
    `field_classification` STRING COMMENT 'Technical classification of the fields hydrocarbon type and extraction method.',
    `field_code` STRING COMMENT 'External business code or alphanumeric identifier used in operational systems.',
    `field_development_phase` STRING COMMENT 'Current phase of field development lifecycle.',
    `field_risk_rating` STRING COMMENT 'Overall operational and financial risk assessment for the field.',
    `field_type` STRING COMMENT 'Classification of the field based on its location and installation method.',
    `first_production_date` DATE COMMENT 'Date the field began commercial production.',
    `gas_oil_ratio` DECIMAL(18,2) COMMENT 'Ratio of gas volume to oil volume produced, measured in standard cubic feet per barrel.',
    `joint_venture_partners` STRING COMMENT 'Comma‑separated list of other owners sharing interest in the field.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or integrity inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the fields central point.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the fields central point.',
    `field_name` STRING COMMENT 'Human‑readable name of the oil or gas field.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next major maintenance activity.',
    `notes` STRING COMMENT 'Additional remarks, observations, or operational notes.',
    `primary_operator` STRING COMMENT 'Company or entity responsible for day‑to‑day operations.',
    `probable_reserves_bo` DECIMAL(18,2) COMMENT 'Quantity of probable recoverable reserves in BOE.',
    `proven_reserves_bo` DECIMAL(18,2) COMMENT 'Quantity of proven recoverable reserves in BOE.',
    `region` STRING COMMENT 'Broad geographic region or sub‑region (e.g., Gulf of Mexico, North Sea).',
    `regulatory_status` STRING COMMENT 'Regulatory approval state for field development and operation.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the record (e.g., Maximo, GIS).',
    `field_status` STRING COMMENT 'Current operational lifecycle state of the field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the field record.',
    `water_cut_percentage` DECIMAL(18,2) COMMENT 'Average proportion of water in produced fluids, expressed as a percent.',
    CONSTRAINT pk_field PRIMARY KEY(`field_id`)
) COMMENT 'Master reference table for field. Referenced by field_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset_class` (
    `asset_class_id` BIGINT COMMENT 'Primary key for asset_class',
    `parent_class_id` BIGINT COMMENT 'Reference to the parent asset class for hierarchical classification.',
    `parent_asset_class_id` BIGINT COMMENT 'Self-referencing FK on asset_class (parent_asset_class_id)',
    `asset_type` STRING COMMENT 'Broad type of physical asset represented by the class.',
    `average_mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating hours between failures for assets of this class.',
    `average_mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair a failure for this asset class.',
    `capacity_unit` STRING COMMENT 'Unit of measure for typical capacity.',
    `class_code` STRING COMMENT 'Short alphanumeric code used to identify the asset class.',
    `class_description` STRING COMMENT 'Detailed description of the asset class purpose and characteristics.',
    `class_name` STRING COMMENT 'Human‑readable name of the asset class.',
    `classification` STRING COMMENT 'Business classification indicating the importance or role of the asset class.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset class record was first created.',
    `effective_from` DATE COMMENT 'Date when the asset class becomes effective for use.',
    `effective_until` DATE COMMENT 'Date when the asset class is retired or superseded (nullable).',
    `external_reference` STRING COMMENT 'Identifier used in external systems (e.g., ERP, GIS) to reference this asset class.',
    `hierarchy_level` STRING COMMENT 'Numeric level indicating depth in the asset class hierarchy (1 = top level).',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the asset class is deprecated and should not be used for new assets.',
    `maintenance_strategy` STRING COMMENT 'Standard maintenance approach applied to this asset class.',
    `material` STRING COMMENT 'Common material construction for assets in this class.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the asset class.',
    `pressure_unit` STRING COMMENT 'Unit of measure for typical pressure.',
    `regulatory_class` STRING COMMENT 'Regulatory classification governing design and operation.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the asset class.',
    `asset_class_status` STRING COMMENT 'Current lifecycle status of the asset class.',
    `typical_capacity` DECIMAL(18,2) COMMENT 'Typical design capacity associated with the asset class.',
    `typical_pressure` DECIMAL(18,2) COMMENT 'Typical operating pressure for assets of this class.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset class record.',
    CONSTRAINT pk_asset_class PRIMARY KEY(`asset_class_id`)
) COMMENT 'Master reference table for asset_class. Referenced by asset_class_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Self-referencing FK on location (parent_location_id)',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `area_sqkm` DOUBLE COMMENT 'Total surface area covered by the location, useful for fields and sites.',
    `city` STRING COMMENT 'City or town where the location is situated.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center identifier associated with the location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the data lake.',
    `location_description` STRING COMMENT 'Free‑form description providing context, e.g., purpose, notable features.',
    `effective_date` DATE COMMENT 'Date when the location became operational or officially recognized.',
    `elevation_m` DOUBLE COMMENT 'Elevation of the location above mean sea level, expressed in meters.',
    `expiry_date` DATE COMMENT 'Date when the location was decommissioned or retired (nullable).',
    `external_system_id` STRING COMMENT 'Identifier used in external asset management or GIS systems.',
    `gps_accuracy_m` DOUBLE COMMENT 'Estimated positional accuracy of the GPS coordinates.',
    `is_critical` BOOLEAN COMMENT 'True if the location is deemed critical for production continuity.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the location is in a remote/off‑grid area.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or integrity inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude in decimal degrees (WGS‑84).',
    `location_code` STRING COMMENT 'External code or tag used in operational systems (e.g., GIS, Maximo) to uniquely identify the location.',
    `location_type` STRING COMMENT 'Category of the physical asset represented by the location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude in decimal degrees (WGS‑84).',
    `map_reference` STRING COMMENT 'Identifier linking to external GIS map layers or satellite imagery.',
    `location_name` STRING COMMENT 'Human‑readable name of the location (e.g., "Alaska North Field" or "Pipeline Segment A").',
    `next_inspection_due` DATE COMMENT 'Planned date for the next required inspection.',
    `operational_zone` STRING COMMENT 'Logical zone used for operational planning (e.g., "Zone 1", "North Block").',
    `owner_department` STRING COMMENT 'Organizational department responsible for the location.',
    `phone_number` STRING COMMENT 'Contact telephone number for the site office or field office.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location.',
    `region` STRING COMMENT 'Broad geographic region or basin (e.g., "Permian Basin").',
    `regulatory_status` STRING COMMENT 'Current compliance state with applicable oil‑and‑gas regulations.',
    `location_status` STRING COMMENT 'Current operational state of the location.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., "America/Chicago").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_parent_equipment_id` FOREIGN KEY (`parent_equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_parent_asset_id` FOREIGN KEY (`parent_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_center`(`work_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_previous_failure_report_id` FOREIGN KEY (`previous_failure_report_id`) REFERENCES `oil_gas_ecm`.`asset`.`failure_report`(`failure_report_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ADD CONSTRAINT `fk_asset_corrosion_monitoring_point_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ADD CONSTRAINT `fk_asset_corrosion_monitoring_point_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ADD CONSTRAINT `fk_asset_corrosion_monitoring_point_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ADD CONSTRAINT `fk_asset_asset_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ADD CONSTRAINT `fk_asset_asset_risk_assessment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ADD CONSTRAINT `fk_asset_asset_risk_assessment_integrity_program_id` FOREIGN KEY (`integrity_program_id`) REFERENCES `oil_gas_ecm`.`asset`.`integrity_program`(`integrity_program_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ADD CONSTRAINT `fk_asset_asset_risk_assessment_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_to_facility_asset_facility_id` FOREIGN KEY (`to_facility_asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ADD CONSTRAINT `fk_asset_equipment_specification_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ADD CONSTRAINT `fk_asset_maintenance_strategy_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ADD CONSTRAINT `fk_asset_maintenance_strategy_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ADD CONSTRAINT `fk_asset_maintenance_strategy_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ADD CONSTRAINT `fk_asset_maintenance_strategy_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_center`(`work_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ADD CONSTRAINT `fk_asset_equipment_contract_coverage_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ADD CONSTRAINT `fk_asset_asset_working_interest_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ADD CONSTRAINT `fk_asset_facility_carrier_approval_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ADD CONSTRAINT `fk_asset_facility_vendor_qualification_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ADD CONSTRAINT `fk_asset_program_vendor_qualification_integrity_program_id` FOREIGN KEY (`integrity_program_id`) REFERENCES `oil_gas_ecm`.`asset`.`integrity_program`(`integrity_program_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_location_id` FOREIGN KEY (`location_id`) REFERENCES `oil_gas_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_parent_asset_id` FOREIGN KEY (`parent_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_center` ADD CONSTRAINT `fk_asset_work_center_location_id` FOREIGN KEY (`location_id`) REFERENCES `oil_gas_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_center` ADD CONSTRAINT `fk_asset_work_center_parent_work_center_id` FOREIGN KEY (`parent_work_center_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_center`(`work_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`field` ADD CONSTRAINT `fk_asset_field_parent_field_id` FOREIGN KEY (`parent_field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_class` ADD CONSTRAINT `fk_asset_asset_class_parent_class_id` FOREIGN KEY (`parent_class_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_class` ADD CONSTRAINT `fk_asset_asset_class_parent_asset_class_id` FOREIGN KEY (`parent_asset_class_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `oil_gas_ecm`.`asset`.`location`(`location_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Customer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation Depletion and Amortization (DD&A)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `actual_decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decommissioning Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `asset_retirement_obligation` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Obligation (ARO)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `asset_retirement_obligation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'bopd|mcfd|mmcfd|bpd|tpd|mmbtu_per_day');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `capex_opex_designation` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) Designation');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `capex_opex_designation` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `county_district` SET TAGS ('dbx_business_glossary_term' = 'County or District');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance|sum_of_years_digits');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `hse_tier` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Tier');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `hse_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `iso_55001_classification` SET TAGS ('dbx_business_glossary_term' = 'ISO 55001 Asset Management Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `iso_55001_classification` SET TAGS ('dbx_value_regex' = 'critical|essential|important|support');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `last_integrity_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Integrity Assessment Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Management Location Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `next_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Next Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operating|standby|maintenance|suspended|decommissioned|under_construction');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `original_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `pi_system_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Plant Information (PI) System Tag Prefix');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `planned_decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Decommissioning Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `process_safety_tier` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Tier (PST)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `process_safety_tier` SET TAGS ('dbx_value_regex' = 'pst_1|pst_2|pst_3|pst_4');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Master Data Record Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_approval');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|provincial|offshore|tribal|international');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `scada_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `scada_integration_status` SET TAGS ('dbx_value_regex' = 'integrated|partial|not_integrated|planned');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Equipment Acquisition Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `api_equipment_class` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Equipment Classification Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `capex_classification` SET TAGS ('dbx_value_regex' = 'new_installation|replacement|upgrade|expansion|sustaining|regulatory');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `criticality_ranking` SET TAGS ('dbx_business_glossary_term' = 'Equipment Criticality Ranking');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `criticality_ranking` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `design_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Design Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `design_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `driver_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Driver Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `heat_duty_mmbtu_hr` SET TAGS ('dbx_business_glossary_term' = 'Heat Duty (Million British Thermal Units per Hour)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Installation Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `insulation_type` SET TAGS ('dbx_business_glossary_term' = 'Insulation Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `is_environmental_critical` SET TAGS ('dbx_business_glossary_term' = 'Environmental Critical Equipment Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Equipment Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|condition_based|run_to_failure|reliability_centered');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `material_of_construction` SET TAGS ('dbx_business_glossary_term' = 'Material of Construction');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `moc_required` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Model Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `motor_rating_hp` SET TAGS ('dbx_business_glossary_term' = 'Motor Rating (Horsepower)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) in Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) in Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `nozzle_configuration` SET TAGS ('dbx_business_glossary_term' = 'Nozzle Configuration Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Operational Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `pm_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency in Days');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `vendor_datasheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Datasheet Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Warranty Expiration Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `field_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `api_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `artificial_lift_type` SET TAGS ('dbx_business_glossary_term' = 'Artificial Lift Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `asset_retirement_obligation_usd` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Obligation (ARO) Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `asset_retirement_obligation_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `capex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `capex_classification` SET TAGS ('dbx_value_regex' = 'drilling|completion|facilities|workover|enhancement');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Well Completion Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `dda_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Depletion and Amortization (DD&A) Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `dda_method` SET TAGS ('dbx_value_regex' = 'unit_of_production|straight_line|declining_balance');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_value_regex' = 'onshore|offshore_shallow|offshore_deepwater|arctic|sensitive_area');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `h2s_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Present Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `integrity_status` SET TAGS ('dbx_business_glossary_term' = 'Well Integrity Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `integrity_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|remediation_required');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Integrity Inspection Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `net_revenue_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Integrity Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `norm_classification` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `norm_classification` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `plugged_abandoned_date` SET TAGS ('dbx_business_glossary_term' = 'Plugged and Abandoned (P&A) Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted|pending_approval');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD|probable|possible|unproved');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `total_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `total_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `total_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Total Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `total_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Total Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `well_status` SET TAGS ('dbx_business_glossary_term' = 'Well Operational Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `well_type` SET TAGS ('dbx_business_glossary_term' = 'Well Type Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `well_type` SET TAGS ('dbx_value_regex' = 'producer|injector|disposal|observation|suspended|dry_hole');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `wellbore_trajectory` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Trajectory Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `wellbore_trajectory` SET TAGS ('dbx_value_regex' = 'vertical|directional|horizontal|multilateral');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `wellhead_equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Wellhead Equipment Tag Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Customer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `ferc_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Ferc Tariff Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `book_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Book Value (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `book_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `cathodic_protection_type` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `cathodic_protection_type` SET TAGS ('dbx_value_regex' = 'impressed_current|sacrificial_anode|none|hybrid');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `coating_type` SET TAGS ('dbx_business_glossary_term' = 'External Coating Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `fluid_service_type` SET TAGS ('dbx_business_glossary_term' = 'Fluid Service Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `from_node_location` SET TAGS ('dbx_business_glossary_term' = 'From Node Location');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `hca_flag` SET TAGS ('dbx_business_glossary_term' = 'High Consequence Area (HCA) Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `integrity_status` SET TAGS ('dbx_business_glossary_term' = 'Integrity Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `integrity_status` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical|unknown');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `maximum_operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Pressure (MOP) (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `nominal_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Nominal Pipe Diameter (Inches)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|standby|decommissioned|under_construction');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `phmsa_regulatory_class` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Regulatory Class');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `phmsa_regulatory_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4|hca');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `pipeline_name` SET TAGS ('dbx_business_glossary_term' = 'Pipeline System Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `scada_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `segment_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Segment Length (Miles)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `segment_number` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'gathering|transmission|distribution|injection|flowline|export');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `to_node_location` SET TAGS ('dbx_business_glossary_term' = 'To Node Location');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `wall_thickness_inches` SET TAGS ('dbx_business_glossary_term' = 'Wall Thickness (Inches)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Child Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `parent_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `cost_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Roll-Up Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `geographic_location_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|archived');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'functional_location|physical_location|cost_rollup|operational_hierarchy|maintenance_hierarchy|safety_hierarchy');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hse_classification` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hse_classification` SET TAGS ('dbx_value_regex' = 'safety_critical|environmental_critical|process_safety|standard');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `integrity_management_program` SET TAGS ('dbx_business_glossary_term' = 'Integrity Management Program');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `joint_venture_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `operating_unit` SET TAGS ('dbx_business_glossary_term' = 'Operating Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `performance_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Roll-Up Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `primary_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Hierarchy Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `sort_sequence` SET TAGS ('dbx_business_glossary_term' = 'Sort Sequence');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `actual_contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Contractor Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `assigned_craft` SET TAGS ('dbx_business_glossary_term' = 'Assigned Craft');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `assigned_craft` SET TAGS ('dbx_value_regex' = 'mechanical|electrical|instrumentation|civil|operations|multi_discipline');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Work Order Completion Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Work Order Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Asset Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_condition_after` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition After Maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_condition_after` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_condition_before` SET TAGS ('dbx_business_glossary_term' = 'Equipment Condition Before Maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_condition_before` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `estimated_contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contractor Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `isolation_plan` SET TAGS ('dbx_business_glossary_term' = 'Isolation Plan');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `isolation_required` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `joint_venture_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Allocation Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Work Order Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Work Order Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_value_regex' = '^MOC-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work (PTW) Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_value_regex' = '^PTW-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `production_impact_boe` SET TAGS ('dbx_business_glossary_term' = 'Production Impact in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive|inspection|turnaround|emergency');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Work Order Created By User');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `preventive_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Planner ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `tertiary_preventive_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `tertiary_preventive_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `tertiary_preventive_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|LOE');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `condition_monitoring_requirement` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Requirement');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `cost_benefit_justification` SET TAGS ('dbx_business_glossary_term' = 'Cost-Benefit Justification');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `environmental_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Critical Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contractor Cost (United States Dollar)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_contractor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost (United States Dollar)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost (United States Dollar)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `frequency_value` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency Value');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `maintenance_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `maintenance_strategy_type` SET TAGS ('dbx_value_regex' = 'run_to_failure|time_based|condition_based|predictive|reliability_centered|risk_based');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|obsolete');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `ptw_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `rcm_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Reliability-Centered Maintenance (RCM) Analysis Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `regulatory_inspection_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Requirement');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `required_craft_skills` SET TAGS ('dbx_business_glossary_term' = 'Required Craft Skills');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `spare_parts_list` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts List');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Task List Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'calendar|meter|condition|hybrid');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `turnaround_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Planning Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `previous_failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Failure Report ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|catastrophic');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_classification` SET TAGS ('dbx_business_glossary_term' = 'Failure Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_classification` SET TAGS ('dbx_value_regex' = 'critical|major|minor|incipient');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_report_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_pending|closed|recurrence_monitoring');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_type` SET TAGS ('dbx_business_glossary_term' = 'Failure Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_type` SET TAGS ('dbx_value_regex' = 'functional|partial|catastrophic|degraded');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `investigated_by` SET TAGS ('dbx_business_glossary_term' = 'Investigated By');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `mtbf_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Impact Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `npt_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `operating_unit` SET TAGS ('dbx_business_glossary_term' = 'Operating Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `preventive_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Recommended');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_impact_boe` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_impact_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_impact_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_loss_cost` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_loss_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `safety_impact` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `safety_impact` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|catastrophic');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `pipeline_safety_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Safety Report Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `corrosion_rate_mm_per_year` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Rate (Millimeters per Year)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor|none');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `fitness_for_service_result` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Service (FFS) Assessment Result');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `fitness_for_service_result` SET TAGS ('dbx_value_regex' = 'fit_for_service|fit_with_monitoring|fit_with_repair|not_fit_for_service|requires_engineering_assessment');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval (Months)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Inspection Pressure (Bar)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_report_document_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Document Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred|overdue');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Inspection Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `measured_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Measured Thickness (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `minimum_required_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Thickness (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional_compliance|pending_review');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `remaining_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `risk_based_inspection_priority` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Inspection (RBI) Priority');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `risk_based_inspection_priority` SET TAGS ('dbx_value_regex' = 'high|medium_high|medium|medium_low|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `acceptable_risk_threshold` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Risk Threshold');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `acceptable_risk_threshold` SET TAGS ('dbx_value_regex' = 'low|medium-low|medium|medium-high|high');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Industry Standard');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|mixed');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `cml_registry_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Monitoring Location (CML) Registry Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `damage_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Primary Damage Mechanism');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `fitness_for_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Fitness-For-Service (FFS) Assessment Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `inspection_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval in Months');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `inspection_strategy` SET TAGS ('dbx_business_glossary_term' = 'Inspection Strategy');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `inspection_strategy` SET TAGS ('dbx_value_regex' = 'time-based|condition-based|risk-based|run-to-failure|predictive');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Program Review Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Monitoring Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Program Review Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `operating_unit` SET TAGS ('dbx_business_glossary_term' = 'Operating Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Owner');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under review|suspended|retired|planned');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `rbi_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Inspection (RBI) Methodology');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `rbi_methodology` SET TAGS ('dbx_value_regex' = 'API 581|semi-quantitative|qualitative|quantitative|not applicable');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `turnaround_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Alignment Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `corrosion_monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Monitoring Point (CML) Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'normal|caution|critical|exceeded');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `alert_threshold_mm` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `circuit_code` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `cml_number` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Monitoring Location (CML) Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `cml_type` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Monitoring Location (CML) Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `cml_type` SET TAGS ('dbx_value_regex' = 'fixed|grid|random');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `consequence_category` SET TAGS ('dbx_business_glossary_term' = 'Consequence Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `consequence_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|severe');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `corrosion_monitoring_point_status` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Monitoring Point (CML) Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `corrosion_monitoring_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `corrosion_rate_mm_per_year` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Rate (Millimeters Per Year)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `damage_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Damage Mechanism');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `inspection_document_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Document Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `last_measured_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Thickness (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `minimum_required_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Required Thickness (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `monitoring_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (Months)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'ultrasonic|radiographic|coupon|probe|visual');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `nominal_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Nominal Thickness (Millimeters)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `operating_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (Bar)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `operating_unit` SET TAGS ('dbx_business_glossary_term' = 'Operating Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `probability_category` SET TAGS ('dbx_business_glossary_term' = 'Probability Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `probability_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `remaining_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `retired_date` SET TAGS ('dbx_business_glossary_term' = 'Retired Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `moc_request_id` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Request ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Work Order ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Employee ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `affected_process_unit` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'supervisor|manager|director|vice_president|executive');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|mixed');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'physical|procedural|organizational|software|temporary|permanent');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'replacement_in_kind|modification|new_installation|decommissioning|process_change|safety_system_change');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `hse_risk_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Assessment Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `hse_risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Assessment Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `hse_risk_assessment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `implementation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Implementation Duration Hours');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `initiating_department` SET TAGS ('dbx_business_glossary_term' = 'Initiating Department');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `initiator_name` SET TAGS ('dbx_business_glossary_term' = 'Initiator Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `initiator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `moc_number` SET TAGS ('dbx_value_regex' = '^MOC-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `moc_status` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `moc_title` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Title');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `post_implementation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `post_implementation_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `process_safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Impact Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `pssr_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Startup Safety Review (PSSR) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `pssr_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Startup Safety Review (PSSR) Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `pssr_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `technical_review_status` SET TAGS ('dbx_business_glossary_term' = 'Technical Review Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `technical_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `technical_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `technical_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed');
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `asset_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Risk Assessment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `assessment_software` SET TAGS ('dbx_business_glossary_term' = 'Assessment Software');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|superseded|cancelled');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `cof_category` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (CoF) Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `cof_category` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `cof_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (CoF) Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `corrosion_rate_mm_per_year` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Rate (Millimeters per Year)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `damage_factor` SET TAGS ('dbx_business_glossary_term' = 'Damage Factor');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `dominant_damage_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dominant Damage Mechanism');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `environmental_consequence_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Consequence Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `financial_consequence_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Consequence Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `fitness_for_service_status` SET TAGS ('dbx_business_glossary_term' = 'Fitness-For-Service (FFS) Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `fitness_for_service_status` SET TAGS ('dbx_value_regex' = 'fit_for_service|monitor|repair_required|retire');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `fluid_phase` SET TAGS ('dbx_business_glossary_term' = 'Fluid Phase');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `fluid_phase` SET TAGS ('dbx_value_regex' = 'gas|liquid|two_phase|supercritical');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Fluid Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `inspection_effectiveness_category` SET TAGS ('dbx_business_glossary_term' = 'Inspection Effectiveness Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `inspection_effectiveness_category` SET TAGS ('dbx_value_regex' = 'highly_effective|usually_effective|fairly_effective|poorly_effective|ineffective');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `mitigation_action_description` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `mitigation_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `mitigation_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `operating_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (Bar)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `operating_unit` SET TAGS ('dbx_business_glossary_term' = 'Operating Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `pof_category` SET TAGS ('dbx_business_glossary_term' = 'Probability of Failure (PoF) Category');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `pof_category` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `pof_score` SET TAGS ('dbx_business_glossary_term' = 'Probability of Failure (PoF) Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `production_consequence_score` SET TAGS ('dbx_business_glossary_term' = 'Production Consequence Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `recommended_inspection_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recommended Inspection Interval (Months)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `remaining_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Methodology');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_value_regex' = 'api_rp_581_quantitative|api_rp_581_semi_quantitative|qualitative|custom');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `risk_ranking` SET TAGS ('dbx_business_glossary_term' = 'Risk Ranking');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `risk_ranking` SET TAGS ('dbx_value_regex' = 'low|medium_low|medium|medium_high|high|very_high');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `safety_consequence_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Consequence Score');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ALTER COLUMN `secondary_damage_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Secondary Damage Mechanism');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Event Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Customer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'From Joint Venture (JV) Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'From Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `to_facility_asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'To Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `to_jv_partner_id` SET TAGS ('dbx_business_glossary_term' = 'To Joint Venture (JV) Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation Depletion and Amortization (DD&A)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `asset_condition_at_transfer` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition at Transfer');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `asset_condition_at_transfer` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|non_operational|decommissioned');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `from_cost_center` SET TAGS ('dbx_business_glossary_term' = 'From Cost Center');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `from_working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'From Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `gain_loss_on_transfer` SET TAGS ('dbx_business_glossary_term' = 'Gain or Loss on Transfer');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `gain_loss_on_transfer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `hse_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Clearance Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `hse_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Clearance Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Initiated Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `jib_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `to_cost_center` SET TAGS ('dbx_business_glossary_term' = 'To Cost Center');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `to_working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'To Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_documentation_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Documentation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_value` SET TAGS ('dbx_business_glossary_term' = 'Transfer Value');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Value Currency');
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ALTER COLUMN `transfer_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `equipment_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Specification ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `corrosion_allowance_inches` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Allowance (Inches)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `datasheet_document_code` SET TAGS ('dbx_business_glossary_term' = 'Datasheet Document ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `design_code` SET TAGS ('dbx_business_glossary_term' = 'Design Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `design_standard` SET TAGS ('dbx_business_glossary_term' = 'Design Standard');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `design_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `driver_type` SET TAGS ('dbx_business_glossary_term' = 'Driver Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `driver_type` SET TAGS ('dbx_value_regex' = 'electric_motor|steam_turbine|gas_turbine|diesel_engine|hydraulic|pneumatic');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `heat_duty_mmbtu_hr` SET TAGS ('dbx_business_glossary_term' = 'Heat Duty (MMBTU per Hour)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `insulation_thickness_inches` SET TAGS ('dbx_business_glossary_term' = 'Insulation Thickness (Inches)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `insulation_type` SET TAGS ('dbx_business_glossary_term' = 'Insulation Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `material_of_construction` SET TAGS ('dbx_business_glossary_term' = 'Material of Construction (MOC)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `motor_rating_hp` SET TAGS ('dbx_business_glossary_term' = 'Motor Rating (Horsepower)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `motor_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Motor Rating (Kilowatts)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `nominal_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Nominal Diameter (Inches)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `nozzle_configuration` SET TAGS ('dbx_business_glossary_term' = 'Nozzle Configuration');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `number_of_nozzles` SET TAGS ('dbx_business_glossary_term' = 'Number of Nozzles');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `operating_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `shell_material` SET TAGS ('dbx_business_glossary_term' = 'Shell Material');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_notes` SET TAGS ('dbx_business_glossary_term' = 'Specification Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_revision` SET TAGS ('dbx_business_glossary_term' = 'Specification Revision');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|approved|superseded|obsolete|under_review|archived');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `specification_superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Superseded Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `tube_material` SET TAGS ('dbx_business_glossary_term' = 'Tube Material');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `vendor_model_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Model Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `voltage_rating` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ALTER COLUMN `wall_thickness_inches` SET TAGS ('dbx_business_glossary_term' = 'Wall Thickness (Inches)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `maintenance_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `condition_monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `condition_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `cost_benefit_justification` SET TAGS ('dbx_business_glossary_term' = 'Cost-Benefit Justification');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Effective Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy End Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `estimated_annual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Maintenance Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `hse_classification` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `hse_classification` SET TAGS ('dbx_value_regex' = 'safety-critical|environmental-critical|non-critical');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `inspection_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval (Days)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `integrity_management_program` SET TAGS ('dbx_business_glossary_term' = 'Integrity Management Program');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Strategy Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `pm_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Interval (Days)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `rbi_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Inspection (RBI) Assessment Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `rcm_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Reliability-Centered Maintenance (RCM) Analysis Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `spare_parts_policy` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Policy');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `spare_parts_policy` SET TAGS ('dbx_value_regex' = 'stock-critical|stock-insurance|procure-on-demand|vendor-managed');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Description');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Name');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|obsolete|under-review');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_value_regex' = 'run-to-failure|time-based|condition-based|predictive|reliability-centered|risk-based');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `target_mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Mean Time Between Failures (MTBF) (Hours)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `target_mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Mean Time To Repair (MTTR) (Hours)');
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ALTER COLUMN `turnaround_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Planning Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `abandonment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Plan Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `abandonment_method` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `abandonment_method` SET TAGS ('dbx_value_regex' = 'plug_and_abandon|decommission_in_place|complete_removal|partial_removal|reef_conversion');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `actual_abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Abandonment Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Abandonment Cost (USD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `aro_liability_usd` SET TAGS ('dbx_business_glossary_term' = 'Asset Retirement Obligation (ARO) Liability (USD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex|mixed');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `environmental_remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Remediation Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `environmental_remediation_scope` SET TAGS ('dbx_business_glossary_term' = 'Environmental Remediation Scope');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Abandonment Cost (USD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `financial_assurance_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount (USD)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `financial_assurance_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `financial_assurance_type` SET TAGS ('dbx_value_regex' = 'surety_bond|letter_of_credit|trust_fund|self_insurance|third_party_guarantee');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `hse_risk_assessment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Assessment Completed Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `norm_disposal_plan` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Disposal Plan');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `norm_disposal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Disposal Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `number_of_plugs` SET TAGS ('dbx_business_glossary_term' = 'Number of Plugs');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `plan_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved By');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `plan_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `plan_document_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Plan Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `plan_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Submitted Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `planned_abandonment_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Abandonment Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `post_abandonment_monitoring_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Post-Abandonment Monitoring Duration (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `post_abandonment_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Abandonment Monitoring Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `post_abandonment_monitoring_scope` SET TAGS ('dbx_business_glossary_term' = 'Post-Abandonment Monitoring Scope');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|conditional_approval|denied|expired');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `site_restoration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Restoration Required Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `site_restoration_scope` SET TAGS ('dbx_business_glossary_term' = 'Site Restoration Scope');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `subsea_equipment_removal_flag` SET TAGS ('dbx_business_glossary_term' = 'Subsea Equipment Removal Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `surface_equipment_removal_flag` SET TAGS ('dbx_business_glossary_term' = 'Surface Equipment Removal Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `well_plug_method` SET TAGS ('dbx_business_glossary_term' = 'Well Plug Method');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `well_plug_method` SET TAGS ('dbx_value_regex' = 'cement_plug|mechanical_plug|bridge_plug|combination');
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` SET TAGS ('dbx_association_edges' = 'asset.equipment,procurement.procurement_contract');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `equipment_contract_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Contract Coverage ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Contract Coverage - Procurement Contract Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Contract Coverage - Equipment Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `added_to_contract_date` SET TAGS ('dbx_business_glossary_term' = 'Added to Contract Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Equipment Coverage Scope');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Coverage Exclusions');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Service Priority Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `removed_from_contract_date` SET TAGS ('dbx_business_glossary_term' = 'Removed from Contract Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` SET TAGS ('dbx_association_edges' = 'asset.facility,venture.partner');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `asset_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'asset_working_interest Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest - Asset Facility Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Working Interest ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `billing_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Code');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `joa_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'JOA Agreement Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `participating_status` SET TAGS ('dbx_business_glossary_term' = 'Participating Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` SET TAGS ('dbx_association_edges' = 'asset.facility,logistics.carrier');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `facility_carrier_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Carrier Approval ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Carrier Approval - Asset Facility Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Carrier Approval - Carrier Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `access_credential_number` SET TAGS ('dbx_business_glossary_term' = 'Access Credential Number');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `approved_product_types_at_facility` SET TAGS ('dbx_business_glossary_term' = 'Approved Product Types at Facility');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `credential_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiry Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `credential_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Issue Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `facility_access_level` SET TAGS ('dbx_business_glossary_term' = 'Facility Access Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `facility_specific_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Facility Specific Training Completed');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `hse_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'HSE Clearance Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `last_vetting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vetting Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `max_daily_movements` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Movements');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `next_vetting_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Vetting Due Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `preferred_carrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiry Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` SET TAGS ('dbx_association_edges' = 'asset.facility,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `facility_vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Vendor Qualification ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Vendor Qualification - Asset Facility Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Vendor Qualification - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `access_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Access Authorization Level');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `access_authorization_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Active Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `approved_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Scope of Work');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `facility_specific_rating` SET TAGS ('dbx_business_glossary_term' = 'Facility-Specific Performance Rating');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `hse_induction_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'HSE Induction Completed Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `hse_induction_date` SET TAGS ('dbx_business_glossary_term' = 'HSE Induction Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `insurance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `insurance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verified Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated By');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `last_work_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Work Order Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `total_work_orders_count` SET TAGS ('dbx_business_glossary_term' = 'Total Work Orders Count');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `vendor_role` SET TAGS ('dbx_business_glossary_term' = 'Vendor Role at Facility');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ALTER COLUMN `created_by` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` SET TAGS ('dbx_subdomain' = 'ownership_governance');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` SET TAGS ('dbx_association_edges' = 'asset.integrity_program,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `program_vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Integrity Program Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Approval Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Approved By');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `approved_inspection_methods` SET TAGS ('dbx_business_glossary_term' = 'Approved Inspection Methods');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `hse_qualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Hse Qualification Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `insurance_requirements_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Insurance Requirements Met Flag');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Last Performance Review Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Notes');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Performance Rating');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Qualification Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Qualification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Program Vendor Qualification - Qualification Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ALTER COLUMN `vendor_role` SET TAGS ('dbx_business_glossary_term' = 'Vendor Role');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_center` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`field` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`field` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`asset`.`field` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`field` ALTER COLUMN `parent_field_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_class` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_class` SET TAGS ('dbx_subdomain' = 'asset_integrity');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_class` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_class` ALTER COLUMN `parent_asset_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
