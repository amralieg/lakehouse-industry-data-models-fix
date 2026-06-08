-- Schema for Domain: asset | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`asset` COMMENT 'Serves as the SSOT for physical asset lifecycle management across all facilities — wells, pipelines, FPSOs, compressors, CDUs, and processing plants. Manages asset registry, technical specifications, performance monitoring, integrity management, CAPEX/OPEX classification, DD&A schedules, preventive and corrective maintenance via Maximo CMMS, ISO 55001-aligned asset integrity programs, MOC workflows, turnaround planning, and equipment reliability (MTBF/MTTR). Integrates with Maximo Asset Management and GIS systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset_facility` (
    `asset_facility_id` BIGINT COMMENT 'Unique identifier for the facility asset. Primary key for the facility master registry.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Facilities constructed or modified under AFE authorization for capital expenditure tracking, depreciation basis, and asset capitalization. Essential for financial reporting, joint venture cost allocat',
    `asset_id` BIGINT COMMENT 'Foreign key linking to asset.asset. Business justification: Asset facilities are specialized asset records that should reference the canonical asset master. The asset table is the SSOT for generic asset attributes. This FK establishes the supertype-subtype rel',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Facility-level O&M contracts (operations & maintenance agreements for processing plants, terminals) are tied to the facility as the primary asset. This link enables contract scope validation against f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Facility operating costs (LOE, utilities, staffing) are posted to cost centers. asset_facility has profit_center and fixed_asset FKs but no cost_center FK — a gap in standard oil and gas cost object a',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Terminal and loading facility management: a physical facility (terminal, tank farm, loading platform) hosts one or more commercial delivery points used in customer nominations and lifting schedules. O',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Facility capitalization requires GL account for balance sheet classification, depreciation method determination, and financial statement presentation - required for property, plant & equipment account',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Production facilities (tank batteries, compressor stations, processing plants) are physically located on leased acreage. Land administration tracks facility-to-lease for HBP status determination, deco',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Refineries, processing plants, and terminals operate under facility-level operating licenses. Linking asset_facility to operating_license is fundamental for facility compliance management, license ren',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Facilities are licensed and designed for specific product types (refinery units for specific crude slates, terminals for specific product grades). Required for regulatory permit compliance, operationa',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Facilities are profit-generating assets requiring profit center assignment for segment reporting, EBITDA calculation, and business unit performance measurement - required for management accounting and',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Facilities are built and expanded under capital projects. Linking facility to finance project enables project-level NPV, budget variance, and FID reporting — standard in oil and gas capital planning.',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Facilities require surface use agreements governing access, reclamation obligations, and compensation. Facility decommissioning triggers SUA reclamation requirements. O&G land administrators must link',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: The primary O&M contractor or EPC contractor for a facility is a standard asset management reference for HSE accountability, emergency response coordination, and contractor performance management. Fac',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Facility CAPEX projects are tracked via WBS elements in ERP for project cost control and asset capitalization. Oil and gas domain experts expect facility-to-WBS linkage for turnaround and construction',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to asset.asset. Business justification: Equipment records are specialized asset instances that should reference the canonical asset master. The asset table holds generic attributes (asset_tag, risk_score, safety_classification, maintenance_',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment ownership/responsibility assignment to cost centers enables depreciation allocation, maintenance cost tracking, and asset accountability - fundamental for fixed asset accounting and cost con',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Fiscal metering and custody transfer: custody transfer meters and flow computers are equipment assets physically located at delivery points. Metering engineers and custody transfer auditors require th',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Equipment must link to fixed asset master for depreciation calculation, net book value tracking, and impairment testing - fundamental fixed asset accounting requirement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Equipment capitalization requires GL account assignment for fixed asset classification, depreciation posting, and balance sheet reporting - fundamental GAAP/IFRS fixed asset accounting requirement.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: PSM-covered equipment, pressure vessels, and fired heaters have specific regulatory obligations (OSHA PSM, EPA RMP, API 510/570). Linking equipment to obligation enables equipment-level compliance tra',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Equipment may operate under facility-level or equipment-specific licenses requiring tracking for compliance audits and operational authorization verification.',
    `parent_equipment_id` BIGINT COMMENT 'Reference to the parent equipment in a hierarchical asset structure. Used to model equipment assemblies and sub-components (e.g., a pump as part of a larger processing unit).',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Individual equipment items require specific permits (e.g., air emission permits for combustion turbines, flares, compressor engines; Title V major source permits). Equipment-level permit linkage is re',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Equipment is designed and operated for specific product service (pumps for crude, compressors for gas). Critical for material compatibility verification, corrosion monitoring programs, and fitness-for',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Equipment is assigned to profit centers for segment P&L reporting and production unit economics. Equipment has cost_center but lacks profit_center FK — required for full cost object assignment in oil ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Tracks original equipment manufacturer/supplier for warranty management, spare parts sourcing, technical support, and vendor performance. Critical for lifecycle asset management and procurement of com',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Equipment procurement and installation CAPEX is tracked against WBS elements for project cost control and capitalization. Standard SAP PM/PS integration in oil and gas operations requires equipment-to',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'The original purchase and installation cost of the equipment in US dollars. Used for asset valuation and depreciation calculations.',
    `api_equipment_class` STRING COMMENT 'The API standard classification code for the equipment type, used for standardized categorization across the oil and gas industry.',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to asset.asset. Business justification: The asset table is described as the Master reference table for asset. Referenced by asset_id. Well assets are specialized asset records that should reference the canonical asset master for generic a',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Well assets must be attributed to exploration/production blocks for JOA cost allocation, working interest reporting, and block-level production entitlement calculations. Regulatory filings (e.g., gove',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wells must be assigned to cost centers for production cost allocation, LOE tracking, and lifting cost calculation - fundamental for upstream cost accounting and reserves economics.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Wells produce specific crude grades with distinct API gravity and sulfur content. Essential for production accounting, reserves booking (SEC compliance), revenue allocation in JV operations, and pipel',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Production allocation and equity oil lifting: a wells produced volumes are allocated to a specific custody transfer delivery point. Oil & gas production accountants and lifting schedulers require thi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: The primary drilling contractor for each well is a core operational record in E&P. Role-prefixed drilling_contractor_vendor_id because well_asset may also reference other vendors; this specifically ',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: BSEE (30 CFR 254) and PHMSA require well-specific emergency response plans for blowout, H2S release, and well control scenarios. O&G operators maintain individual well ERPs linked to each well record.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Wells must link to fixed asset master for DD&A calculation, depletion unit tracking, and ceiling test compliance - mandated by oil-and-gas accounting standards.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Well capitalization requires GL account for proved/unproved property classification, DD&A calculation, and SEC full-cost ceiling test - mandated by oil-and-gas accounting standards.',
    `lease_id` BIGINT COMMENT 'Identifier of the oil and gas lease or mineral rights agreement under which this well operates. Links well asset to land and lease management system for royalty calculations and revenue distribution.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Well assets have specific regulatory obligations (e.g., mechanical integrity testing per UIC, H2S monitoring, plugging & abandonment requirements). Direct FK enables well-level compliance obligation t',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Wells operate under production licenses, injection licenses, or concession agreements. Direct regulatory requirement for well operations in oil & gas.',
    `operator_id` BIGINT COMMENT 'FK to land.operator',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Wells require drilling, completion, operating, and injection permits. Core regulatory requirement in oil & gas. Existing permit_number column should be removed for normalization.',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Every producing well must be assigned to a regulatory pooling/spacing unit for production allocation and royalty calculation. O&G regulatory reporting (state conservation commissions) and revenue acco',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wells generate revenue and must be assigned to profit centers for reserves accounting, production revenue allocation, and field-level profitability analysis - core upstream financial management requir',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Wells are completed in specific reservoirs - fundamental relationship for production allocation, reserves booking, and well performance analysis. Production allocation by reservoir, reserves booking b',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Well pads require surface use agreements with surface owners, which are legally distinct from mineral leases. O&G land administration tracks well-to-SUA for well abandonment reclamation obligations, s',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Wells are located on specific tracts; direct well-to-tract linkage is required for division order preparation, royalty allocation, and state regulatory reporting (API number tied to legal land descrip',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Well drilling and completion CAPEX is tracked via WBS elements. AFE-to-WBS linkage is the standard cost control mechanism in oil and gas ERP for well cost management and capitalization.',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to asset.asset. Business justification: Pipeline segments are specialized asset records that should reference the canonical asset master. The asset table holds generic attributes (asset_tag, risk_score, safety_classification, useful_life_ye',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pipeline segments require cost center assignment for integrity spending allocation, depreciation tracking, and PHMSA compliance cost reporting - standard midstream asset accounting practice.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Pipeline segments operated by third parties require tracking the operator entity for integrity management, PHMSA regulatory compliance (operator identification), incident reporting, and operational ac',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Pipeline scheduling and tariff billing: a pipeline segment terminates at a formal custody transfer delivery point. Pipeline operators use this link for nomination processing, capacity allocation, and ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Pipeline segments must link to fixed asset master for depreciation, net book value tracking, and regulatory rate base determination - standard midstream asset accounting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pipeline capitalization requires GL account for gathering/transmission asset classification, depreciation posting, and regulatory rate base determination - standard midstream accounting practice.',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Pipeline operations require operating licenses in many jurisdictions (e.g., state pipeline operating certificates, federal operating authority). Linking pipeline_segment to operating_license enables l',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pipeline segments require construction, right-of-way, and operating permits from PHMSA and state agencies. Fundamental regulatory requirement. Existing permit_number should be normalized.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pipeline segments transport specific products with material compatibility requirements and regulatory classification (hazardous liquid vs gas). Critical for batch scheduling, interface management, PHM',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Pipeline segments generate tariff revenue assigned to profit centers for midstream segment reporting. pipeline_segment has cost_center but lacks profit_center FK — required for revenue and P&L attribu',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Pipeline ROW management requires linking each segment to its governing right-of-way agreement for renewal tracking, compensation terms, access permissions, and PHMSA regulatory compliance. O&G pipelin',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: The primary integrity/inspection vendor for a pipeline segment is tracked for PHMSA regulatory compliance, ILI tool qualification verification, and vendor performance management. Pipeline operators mu',
    `partner_id` BIGINT COMMENT 'Identifier of the operating entity or business unit responsible for the operation and maintenance of this pipeline segment.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Pipeline construction and integrity CAPEX is tracked via WBS elements for project cost control. Integrity management programs for pipelines require WBS-level budget tracking per PHMSA regulatory requi',
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
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Hierarchy nodes are assigned to profit centers for P&L reporting by asset hierarchy level. hierarchy has profit_center as a plain text denormalization — replacing with FK enforces referential integrit',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Asset hierarchy nodes map to WBS hierarchy in ERP for cost rollup reporting. hierarchy has cost_rollup_flag and performance_rollup_flag indicating cost aggregation — WBS linkage enables project cost r',
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
    `relationship_type` STRING COMMENT 'Semantic nature of the parent-child relationship. Contains indicates containment, consists of indicates composition, part of indicates membership, installed in indicates physical mounting, connected to indicates interface linkage, feeds into indicates process flow, supports indicates dependency. [ENUM-REF-CANDIDATE: contains|consists_of|part_of|installed_in|connected_to|feeds_into|supports — 7 candidates stripped; promote to reference product]',
    `sort_sequence` STRING COMMENT 'Display order sequence number for child assets within the same parent in user interfaces and reports. Enables custom ordering of sibling assets for operational dashboards and maintenance schedules.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Working interest ownership percentage for the operating company in joint venture assets within this hierarchical relationship. Determines cost allocation and revenue distribution for joint interest billing.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the parent-child hierarchical relationships among assets in the Maximo CMMS asset tree, enabling roll-up of maintenance costs, failure events, and performance metrics from component level up to facility level. Captures parent asset reference, child asset reference, hierarchy level (facility → system → equipment → component), effective date, end date, and hierarchy type (functional location, physical location, or cost-rollup). Supports ISO 55001 asset management structure and SAP PM functional location hierarchy. Essential for organizational reporting and maintenance cost allocation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record in the Computerized Maintenance Management System (CMMS). Primary key for the work order entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Work orders require AFE authorization for capital/operating expenditure tracking, cost center allocation, and joint venture billing. Essential for financial controls and audit trails in oil & gas capi',
    `asset_id` BIGINT COMMENT 'Reference to the physical asset (well, pipeline, FPSO, compressor, CDU, processing plant, equipment unit) against which this maintenance work is being performed.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Work orders for contracted services reference the governing contract for day-rate/unit-rate validation and scope authorization. This link drives the SES approval workflow and three-way match (WO→Contr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders must charge labor, materials, and contractor costs to cost centers for accounting control, budget variance analysis, and LOE tracking - fundamental financial requirement in oil-and-gas ope',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Work orders on customer-owned assets or JV facilities require tracking the customer/partner entity for cost allocation, billing, JV accounting, and AFE reconciliation—standard in joint venture operati',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Work orders are most commonly executed on equipment in Maximo CMMS. Currently work_order has polymorphic asset_id. Adding equipment_id provides typed FK for equipment work orders (most common case). N',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Work orders consume AFE-authorized budgets. work_order has afe_budget_id (procurement domain) but no link to finance.finance_afe — the financial authorization record used for CAPEX approval and cost t',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Incident-driven corrective maintenance work orders must trace back to the originating HSE incident for OSHA recordable tracking, insurance claims, and regulatory reporting. O&G maintenance management ',
    `joint_venture_id` BIGINT COMMENT 'Foreign key linking to venture.joint_venture. Business justification: Work orders on jointly-owned assets must be allocated to the correct JV for JIB billing. work_order has joint_venture_allocation_flag but no joint_venture_id FK. Identifying which JV governs a work or',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Work orders are generated to fulfill specific regulatory obligations (e.g., mandatory LDAR surveys, annual pressure vessel inspections per OSHA PSM). Linking work_order to obligation enables complianc',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Work orders on licensed facilities must verify the operating license authorizes the planned activity. In oil & gas PSM/MOC processes, work execution requires confirming the operating license scope bef',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Work orders may execute under regulatory permits (hot work permits in compliance system, confined space permits). Tracks permit-controlled work beyond PTW system.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Every O&G work order requiring hot work, confined space entry, or energy isolation must reference a valid permit-to-work. HSE auditors and maintenance planners use this link for PTW compliance verific',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Work orders often involve product-specific activities: tank cleaning for grade changes, contamination incident response, product-specific corrosion repairs. Needed for root cause analysis, cost alloca',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Work orders are raised against pipeline segments for integrity inspections, pigging operations, repair activities, and cathodic protection maintenance. The existing work_order already has equipment_id',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Emergency and corrective work orders are created directly in response to Process Safety Events (e.g., emergency shutdown, relief valve lift, LOPC). O&G PSM programs require traceability from PSE recor',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Work orders executed at production facilities for equipment maintenance, turnarounds, and modifications. Direct FK enables facility-level maintenance reporting (facility downtime, maintenance cost per',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: CAPEX work orders are linked to finance projects for budget tracking and capitalization decisions. Turnaround and major maintenance work orders require project-level cost reporting in oil and gas oper',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Work orders directly consume materials and services procured via purchase orders. Critical for three-way matching (PO-GR-Invoice), cost reconciliation, and tracking actual vs. estimated costs in maint',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to land.right_of_way. Business justification: Work orders for pipeline maintenance, ROW clearing, and vegetation management must reference the governing ROW agreement to verify access permissions, compensation obligations, and activity restrictio',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Work orders executed by external contractors require direct vendor reference for HSE pre-job safety verification, contractor performance tracking, and cost accrual. Distinct from failure_report.vendor',
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
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: PM plans support certifications (ISO 55001, API certifications). Provides audit evidence that maintenance programs meet certification requirements.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: PM plans often executed under service contracts (e.g., rotating equipment maintenance, inspection services). Links planned maintenance strategy to contracted vendor obligations, rates, and SLA terms f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM plans require cost center assignment for maintenance budget allocation, variance analysis, and LOE forecasting - essential for integrity program financial planning and cost control.',
    `equipment_id` BIGINT COMMENT 'Reference to the physical asset (well, pipeline, FPSO, compressor, CDU, processing plant, equipment unit) to which this preventive maintenance plan applies.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Major preventive maintenance programs (turnarounds, statutory inspections) require AFE financial authorization. Linking PM plans to finance_afe enables budget control and CAPEX/OPEX classification for',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: PM plans are created to satisfy recurring regulatory obligations (e.g., annual pressure relief valve testing per OSHA PSM, monthly flare inspection per EPA). Linking PM plan to obligation enables comp',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline segments have PM plans (cathodic protection surveys, valve maintenance, ROW inspections). Currently preventive_maintenance_plan only has equipment_id. Adding pipeline_segment_id enables defin',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: PM plans cover facility-level systems (process safety equipment, fire/gas systems, SCADA). Direct FK enables facility maintenance planning, turnaround scheduling, and regulatory compliance (PSM inspec',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: PM plans target production wells for routine maintenance (wellhead inspections, tubing integrity, artificial lift servicing). Direct FK enables well-level PM scheduling, compliance tracking (regulator',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: PM plans executed by external contractors (OEM service, specialist maintenance) reference the contracted vendor for scheduling, HSE pre-qualification verification, and performance tracking. Vendor-spe',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Major turnaround and maintenance programs are budgeted via WBS elements. PM plans for safety-critical equipment require WBS-level CAPEX/OPEX tracking for turnaround planning and regulatory cost report',
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
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Repair work executed under frame agreements or call-off contracts references the governing contract on the failure report for cost allocation and contractor liability assessment. Required for warranty',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Failure costs (repair_cost, production_loss_cost) must be allocated to cost centers for financial reporting, LOE tracking, and reliability cost analysis - standard oil-and-gas cost accounting practice',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment unit that failed within the asset.',
    `preventive_maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to asset.preventive_maintenance_plan. Business justification: A failure report may reference the PM plan that was in place at the time of failure (or whose absence contributed to the failure). This FK enables RCM analysis — comparing actual failure rates against',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Equipment failures in O&G are frequently simultaneous HSE incidents (e.g., pipeline rupture = failure report + OSHA/NRC reportable incident). Integrated RCFA and incident investigation require direct ',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline failures (leaks, ruptures, corrosion failures) occur on pipeline segments. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline failure events. No columns ',
    `previous_failure_report_id` BIGINT COMMENT 'Reference to the previous failure report if this is a recurring failure.',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Safety-critical equipment failures (pressure vessel, SIS, relief valve) are the primary trigger for API 754 Process Safety Events. O&G operators must link failure records to PSE tier classifications f',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Facility-level failures (compressor trips, separator upsets, control system failures) impact production throughput. Direct FK enables facility reliability tracking, production loss analysis, and maint',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Failures occur on production wells (tubing leaks, packer failures, artificial lift failures) requiring reliability analysis. Direct FK enables well-level failure tracking, MTBF calculation, and produc',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Emergency repair POs are raised directly against failure events for expedited procurement of parts and services. Linking failure_report to the emergency PO enables repair cost capture, insurance claim',
    `spill_event_id` BIGINT COMMENT 'Foreign key linking to hse.spill_event. Business justification: Pipeline and equipment failures are the leading cause of O&G spill events. NRC/PHMSA incident reporting requires tracing spill events to their root cause failure. Direct FK from failure_report to spil',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Failures are frequently discovered during inspection activities (API RP 510, API RP 570, RBI inspections). Linking failure_report to the triggering inspection_event enables traceability from inspectio',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Tracks failures of vendor-supplied equipment for warranty claims, vendor performance evaluation, and root cause analysis. Essential for vendor scorecarding, quality management, and procurement decisio',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Repair costs from equipment failures are capitalized or tracked against WBS elements when they trigger major corrective projects. Failure-to-WBS linkage supports CAPEX vs. OPEX classification decision',
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
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Inspection services often executed under master service agreements or call-off contracts. Links inspection execution to contracted rates, SLA terms, and vendor performance metrics. Complements existin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection costs must be allocated to cost centers for integrity program budgeting, regulatory compliance cost tracking, and RBI program financial justification - required for asset integrity financia',
    `equipment_id` BIGINT COMMENT 'Reference to the physical asset being inspected (well, pipeline, FPSO, compressor, CDU, processing plant, pressure vessel, tank, or other equipment).',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Major inspection campaigns (pipeline ILI, pressure vessel inspections) require AFE authorization for capital expenditure approval. Linking inspection events to finance_afe enables cost tracking agains',
    `vendor_id` BIGINT COMMENT 'Reference to the third-party inspection service provider, if the inspection was outsourced.',
    `integrity_program_id` BIGINT COMMENT 'Foreign key linking to asset.integrity_program. Business justification: Inspection events are conducted as part of an ISO 55001-aligned integrity management program. Linking inspection_event to integrity_program enables program-level inspection tracking, compliance report',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Inspection events are mandated by specific regulatory obligations (e.g., API 510 pressure vessel inspections, PHMSA IMP inline inspections). Linking inspection_event to obligation enables traceability',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Inspections verify permit compliance (emissions testing for air permits, integrity testing for pipeline permits). Creates audit trail for permit condition verification.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Inspection activities (vessel entry, pressure testing, ILI pig runs) require an active permit-to-work per O&G safety management systems. Regulatory audits verify PTW compliance for each inspection eve',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Inspections assess equipment fitness for specific product service. Corrosion rates, material degradation, and remaining life calculations vary significantly by product characteristics (sour vs sweet c',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline inspections (ILI runs, hydrostatic tests, visual inspections) are performed on pipeline segments. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline inte',
    `preventive_maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to asset.preventive_maintenance_plan. Business justification: Inspection events are often triggered by and executed under a preventive maintenance plan (e.g., a scheduled API RP 570 piping inspection defined in the PM program). This FK links the inspection execu',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Risk-Based Inspection (RBI) programs per API 580/581 require linking inspection findings that reveal loss-of-containment or safety system demands to Process Safety Events. O&G integrity engineers use ',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Facility inspections (API 510 pressure vessel, API 570 piping, PSM inspections) required for regulatory compliance. Direct FK enables facility-level inspection tracking, compliance reporting (OSHA PSM',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Well integrity inspections (mechanical integrity tests per UIC regulations, casing inspections, wellhead pressure tests) are regulatory requirements. Direct FK enables well-level compliance tracking, ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Inspection services procured via spot PO (not under a standing contract) require this link for invoice matching and cost tracking. Inspection_event already has contract_id for contract-based inspectio',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: Regulatory audits (e.g., EPA, PHMSA, OSHA) include specific asset inspection events as audit activities. Linking inspection_event to regulatory_audit enables audit finding traceability and supports re',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Inspection programs (ILI runs, vessel inspections) are budgeted via WBS elements for project cost control. Inspection costs are posted to WBS for integrity management program budget tracking and regul',
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
    `regulatory_compliance_status` STRING COMMENT 'Assessment of whether the inspection results and asset condition meet applicable regulatory requirements (API, BSEE, OSHA, EPA).. Valid values are `compliant|non_compliant|conditional_compliance|pending_review`',
    `regulatory_reference` STRING COMMENT 'Specific regulatory code, standard, or requirement that governs this inspection (e.g., API RP 510, BSEE 30 CFR 250).',
    `remaining_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining service life of the asset in years based on current thickness, corrosion rate, and minimum required thickness.',
    `risk_based_inspection_priority` STRING COMMENT 'Risk-based inspection priority classification based on consequence of failure and probability of failure analysis.. Valid values are `high|medium_high|medium|medium_low|low`',
    `scheduled_date` DATE COMMENT 'The originally planned date for the inspection activity.',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Records all asset inspection activities including API RP 510 pressure vessel inspections, API RP 570 piping inspections, API RP 653 tank inspections, BSEE offshore facility inspections, and internal condition monitoring surveys. Captures inspection date, inspector identity, inspection method (visual/UT/RT/MFL/ILI), findings, measured thickness/corrosion rates, fitness-for-service assessment result, next inspection due date, and regulatory compliance status. Integrates with Enablon HSE Management for compliance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`integrity_program` (
    `integrity_program_id` BIGINT COMMENT 'Unique identifier for the asset integrity management program record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Integrity programs are defined at the facility level (e.g., an ISO 55001 integrity program for an FPSO or a processing plant). The existing integrity_program already links to equipment and pipeline_se',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Integrity programs have annual_budget_amount (plain attr on integrity_program) tracked against formal finance budget records. Linking to finance.budget enables budget vs. actual variance reporting for',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Integrity programs are certified under API 570, 510, 653, 1160 standards. Direct business relationship between integrity management and certification compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Integrity programs are assigned to cost centers for cost allocation and LOE reporting. integrity_program has annual_budget_amount but no cost_center FK — required for cost object assignment in oil and',
    `equipment_id` BIGINT COMMENT 'Reference to the physical asset or asset class covered by this integrity program.',
    `joint_venture_id` BIGINT COMMENT 'Foreign key linking to venture.joint_venture. Business justification: Integrity programs on jointly-owned assets are governed by JV operating committees and costs are shared per working interest. integrity_program has asset_facility_id and pipeline_segment_id but no joi',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Integrity programs (e.g., PHMSA IMP, API RBI, SEMS) are established to fulfill specific regulatory obligations. Direct FK enables obligation-to-program traceability required for regulatory audits and ',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Integrity programs are scoped to assets operating under specific licenses; the operating license defines authorized operating conditions (pressure, temperature, fluid service) that the integrity progr',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Integrity programs for pipelines and facilities are scoped by environmental and operating permits (e.g., air permits constraining flaring during maintenance, water discharge permits). Permit condition',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline integrity management programs are defined for pipeline segments or pipeline systems. Currently only equipment_id exists. Adding pipeline_segment_id enables tracking pipeline integrity program',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Integrity programs submitted to PHMSA, BSEE, and state agencies. Direct regulatory requirement for pipeline integrity management and offshore safety management.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Integrity programs have dedicated WBS elements for CAPEX/OPEX budget tracking. Pipeline and pressure vessel integrity management programs require WBS-level cost control per API 570/510 and PHMSA regul',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Integrity programs cover well assets (wellbore integrity programs per API RP 90, H2S well integrity, etc.). The existing integrity_program links to equipment and pipeline_segment but not well_asset. A',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`asset`.`asset` (
    `asset_id` BIGINT COMMENT 'Primary key for asset',
    `parent_asset_id` BIGINT COMMENT 'Identifier of the parent asset in a hierarchical relationship, if applicable.',
    `asset_description` STRING COMMENT 'Free‑form description of the asset, including purpose and key characteristics.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the asset.',
    `asset_type` STRING COMMENT 'Category of the physical asset.',
    `capital_expenditure` DECIMAL(18,2) COMMENT 'Capital cost incurred to acquire or construct the asset.',
    `category_code` STRING COMMENT 'Code representing the assets category within internal taxonomy.',
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
    `tag` STRING COMMENT 'Physical tag or barcode assigned to the asset for identification on the shop floor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated number of years the asset is expected to be economically usable.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty on the asset expires.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master reference table for asset. Referenced by asset_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_parent_equipment_id` FOREIGN KEY (`parent_equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_parent_asset_id` FOREIGN KEY (`parent_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_preventive_maintenance_plan_id` FOREIGN KEY (`preventive_maintenance_plan_id`) REFERENCES `oil_gas_ecm`.`asset`.`preventive_maintenance_plan`(`preventive_maintenance_plan_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_previous_failure_report_id` FOREIGN KEY (`previous_failure_report_id`) REFERENCES `oil_gas_ecm`.`asset`.`failure_report`(`failure_report_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `oil_gas_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_integrity_program_id` FOREIGN KEY (`integrity_program_id`) REFERENCES `oil_gas_ecm`.`asset`.`integrity_program`(`integrity_program_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_preventive_maintenance_plan_id` FOREIGN KEY (`preventive_maintenance_plan_id`) REFERENCES `oil_gas_ecm`.`asset`.`preventive_maintenance_plan`(`preventive_maintenance_plan_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_parent_asset_id` FOREIGN KEY (`parent_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `parent_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Equipment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Equipment Acquisition Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ALTER COLUMN `api_equipment_class` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Equipment Classification Code');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Contractor Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Customer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Child Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `parent_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `sort_sequence` SET TAGS ('dbx_business_glossary_term' = 'Sort Sequence');
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `preventive_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `preventive_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Preventive Maintenance Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `previous_failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Failure Report ID');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `spill_event_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Inspection Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `preventive_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional_compliance|pending_review');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `remaining_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Life (Years)');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `risk_based_inspection_priority` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Inspection (RBI) Priority');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `risk_based_inspection_priority` SET TAGS ('dbx_value_regex' = 'high|medium_high|medium|medium_low|low');
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
