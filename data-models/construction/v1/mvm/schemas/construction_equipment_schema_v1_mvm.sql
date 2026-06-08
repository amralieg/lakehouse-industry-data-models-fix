-- Schema for Domain: equipment | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`equipment` COMMENT 'Construction equipment and fleet management domain tracking heavy machinery (cranes, excavators, concrete pumps), tools, generators, and fleet vehicles. Owns asset master data, utilization tracking, maintenance schedules, equipment hours, mobilization/demobilization records, rental vs. owned classification, and asset lifecycle management via SAP PM and HCSS HeavyJob.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the construction equipment or fleet asset. Primary key for the asset master record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Procurement contracts assign each purchased or leased asset to an agreement; required for contract cost reporting and asset ownership tracking.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Asset belongs to an asset category; replace free‑text category with FK to asset_category for proper hierarchy and eliminate redundancy.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the asset is currently assigned. Null when asset is idle or in yard storage.',
    `asset_current_location_site_construction_project_id` BIGINT COMMENT 'Identifier of the construction site or yard where the asset is currently located. Updated during mobilization and demobilization events.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client-Supplied Plant and Equipment (CSPE) is a standard construction contract mechanism where the client owns and provides specific assets to the project. Asset records must reference the owning clie',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In multi-entity construction groups, each asset is legally owned by a specific company code for statutory asset registers, depreciation, and disposal reporting. Construction ERP (SAP PM/AM) mandates c',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Assets are associated with cost codes for capitalization coding, depreciation allocation, and asset-level job cost tracking. Construction cost controllers assign cost codes to assets for project cost ',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Associates each asset with its primary fuel material, enabling accurate fuel consumption tracking and environmental compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fixed assets are capitalized to specific GL accounts for depreciation posting, disposal entries, and balance sheet reporting. Construction finance controllers configure a GL account per asset for SAP ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Required for Daily Equipment Operator Assignment report, linking each asset to the assigned craft worker for safety compliance and productivity tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assets in multi-division construction companies are assigned to profit centers for internal P&L attribution, divisional asset reporting, and return-on-assets analysis. Construction finance teams requi',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost to acquire the asset including purchase price, delivery, installation, and initial setup. Basis for depreciation calculations and capital asset reporting.',
    `acquisition_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition cost (e.g., USD, EUR, GBP). Required for multi-currency fleet management.. Valid values are `^[A-Z]{3}$`',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired by the company through purchase, lease commencement, or rental agreement start. Used for depreciation start date and asset age calculations.',
    `asset_status` STRING COMMENT 'Current operational status of the asset. Determines availability for project assignment and utilization reporting. [ENUM-REF-CANDIDATE: active|idle|under_maintenance|in_transit|disposed|retired|reserved — 7 candidates stripped; promote to reference product]',
    `capacity_rating` DECIMAL(18,2) COMMENT 'Maximum rated capacity of the equipment in appropriate units (tons for cranes, cubic yards for excavators, kilowatts for generators). Critical for safe operation and project planning.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the capacity rating. Varies by equipment type and regional standards.. Valid values are `tons|cubic_yards|cubic_meters|kilowatts|gallons_per_minute|pounds`',
    `classification` STRING COMMENT 'Primary equipment type classification. Determines maintenance requirements, operator certification needs, and utilization tracking methods. [ENUM-REF-CANDIDATE: crane|excavator|concrete_pump|generator|fleet_vehicle|small_tool|bulldozer|loader|grader|compactor|paver|drill_rig — 12 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset master record was first created in the system. Used for data lineage and audit trail.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset after accumulated depreciation. Updated periodically based on depreciation schedule and impairment assessments.',
    `disposal_approver_name` STRING COMMENT 'Name of the manager or executive who authorized the asset disposal. Required for governance and audit compliance.',
    `disposal_buyer_name` STRING COMMENT 'Name of the party who purchased or received the disposed asset. Required for audit trail and warranty transfer documentation.',
    `disposal_date` DATE COMMENT 'Date the asset was disposed of or removed from active fleet. Triggers final depreciation calculation and asset retirement accounting entries.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the asset at end of life. Populated only for disposed assets. Impacts accounting treatment and tax reporting.. Valid values are `sale|auction|scrap|write_off|trade_in|donation`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from disposal of the asset through sale, auction, or trade-in. Used to calculate gain or loss on disposal for financial reporting.',
    `disposal_reason` STRING COMMENT 'Business justification for disposing of the asset (e.g., end of useful life, excessive maintenance costs, fleet optimization, project completion, regulatory non-compliance).',
    `emissions_tier` STRING COMMENT 'EPA emissions tier classification (e.g., Tier 4 Final, Tier 3). Determines regulatory compliance for site operations and environmental permitting.',
    `hcss_heavyjob_asset_code` STRING COMMENT 'Asset identifier in HCSS HeavyJob field operations system. Used for time tracking, production tracking, and equipment hour logging.',
    `home_yard_location` STRING COMMENT 'Primary equipment yard or depot where the asset is based when not deployed to a project site. Used for logistics planning and idle asset management.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of current insurance coverage. Equipment cannot operate without valid insurance.',
    `insurance_policy_number` STRING COMMENT 'Policy number for equipment insurance coverage. Required for risk management and claims processing.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection. Required for OSHA compliance and equipment certification tracking.',
    `last_meter_reading_date` DATE COMMENT 'Date of the most recent operating hours meter reading. Used to validate meter reading frequency and detect anomalies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the asset master record. Used for change tracking and data quality monitoring.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the asset lifecycle from acquisition through disposal. Used for lifecycle cost analysis and replacement planning.. Valid values are `commissioning|operational|aging|end_of_life|disposed`',
    `make` STRING COMMENT 'Manufacturer or brand name of the equipment (e.g., Caterpillar, Komatsu, Liebherr, Volvo, John Deere).',
    `model` STRING COMMENT 'Manufacturer model designation for the equipment. Used for parts compatibility, operator training, and maintenance procedure lookup.',
    `next_inspection_due_date` DATE COMMENT 'Date by which the next regulatory inspection must be completed. Equipment cannot operate on site after this date without recertification.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance service. Calculated based on operating hours, calendar time, or manufacturer recommendations.',
    `operating_weight_kg` DECIMAL(18,2) COMMENT 'Total operating weight of the equipment in kilograms. Used for transportation planning, site access evaluation, and ground bearing pressure calculations.',
    `ownership_type` STRING COMMENT 'Classification of how the company controls the asset. Owned assets are capitalized, rented assets are expensed, leased assets follow lease accounting standards.. Valid values are `owned|rented|leased|operator_owned`',
    `regulatory_compliance_class` STRING COMMENT 'Regulatory classification determining inspection frequency, operator certification requirements, and safety standards (e.g., OSHA crane certification class, EPA emissions tier).',
    `sap_pm_equipment_number` STRING COMMENT 'Equipment master record number in SAP S/4HANA Plant Maintenance module. System of record identifier for maintenance planning and execution.. Valid values are `^[0-9]{10}$`',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the equipment unit. Critical for warranty claims, parts ordering, and regulatory compliance.',
    `tag_number` STRING COMMENT 'Externally visible unique identifier physically affixed to the equipment. Used for field identification and tracking across sites.. Valid values are `^[A-Z0-9]{6,20}$`',
    `total_operating_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours recorded on the equipment meter. Used for maintenance scheduling, utilization analysis, and residual value estimation.',
    `year_of_manufacture` STRING COMMENT 'Calendar year the equipment was manufactured. Used for depreciation calculations, regulatory compliance age limits, and resale value estimation.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Core master record for every piece of construction equipment and fleet vehicle owned, long-term leased, or rented by the company. Captures asset identity, classification (crane, excavator, concrete pump, generator, fleet vehicle, small tool), make, model, serial number, year of manufacture, acquisition date, acquisition cost, ownership type (owned/rented/leased), current status (active, idle, under maintenance, disposed), SAP PM equipment number, HCSS HeavyJob asset ID, regulatory compliance class, and asset lifecycle stage. For disposed assets: captures disposal method (sale, auction, scrap, write-off, trade-in), disposal date, disposal proceeds, buyer details, reason for disposal, and authorizing approver. This is the SSOT for all equipment identity and lifecycle data across the enterprise, from commissioning through disposal.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`asset_category` (
    `asset_category_id` BIGINT COMMENT 'Unique identifier for the asset category. Primary key for the asset category reference hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset category default cost center ensures new assets inherit correct cost center for accounting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Asset categories drive automatic GL account determination for capitalization and depreciation in SAP Asset Accounting. Construction finance teams configure GL accounts at category level for consistent',
    `parent_category_asset_category_id` BIGINT COMMENT 'Reference to the parent category in the asset classification hierarchy. Enables multi-level taxonomy (e.g., Heavy Equipment > Earthmoving > Excavators). Null for top-level categories.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Asset categories (Lifting Equipment, Pressure Vessels, Electrical Plant) are subject to category-level regulatory obligations that apply uniformly to all assets in that class. Linking asset_category t',
    `asset_category_status` STRING COMMENT 'Current lifecycle status of the asset category in the master taxonomy: active (in use for classification), inactive (no longer used but retained for historical data), deprecated (being phased out), pending (awaiting approval for activation).. Valid values are `active|inactive|deprecated|pending`',
    `asset_class_sap` STRING COMMENT 'SAP S/4HANA Asset Accounting asset class code for assets in this category. Determines account determination, depreciation keys, and asset master data screen layout in SAP FI-AA module.. Valid values are `^[0-9]{4,8}$`',
    `benchmark_utilization_rate` DECIMAL(18,2) COMMENT 'Target utilization rate percentage for assets in this category, used for fleet optimization and equipment productivity benchmarking. Represents industry-standard or company target for equipment hours versus available hours.',
    `capitalization_threshold` DECIMAL(18,2) COMMENT 'Minimum acquisition cost threshold for capitalizing assets in this category as fixed assets versus expensing as consumables. Aligns with company capitalization policy and GAAP/IFRS materiality thresholds.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the asset category. Aligned with HCSS HeavyJob cost coding structure and SAP PM functional location classification. Used for cost allocation, reporting, and system integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `category_description` STRING COMMENT 'Detailed description of the asset category scope, typical equipment types included, and business purpose. Provides context for classification decisions and user guidance.',
    `category_level` STRING COMMENT 'Numeric level in the asset category hierarchy. Level 1 represents top-level categories (e.g., Heavy Equipment), Level 2 represents sub-categories (e.g., Earthmoving), Level 3 represents equipment classes (e.g., Excavators).',
    `category_name` STRING COMMENT 'Full business name of the asset category (e.g., Heavy Earthmoving Equipment, Lifting and Hoisting, Concrete Placement, MEP Tools, Fleet Vehicles, Small Tools, Generators and Power).',
    `category_type` STRING COMMENT 'Classification of the category node type within the taxonomy: major (top-level grouping), sub (intermediate grouping), class (equipment class), specialty (niche/specialized equipment).. Valid values are `major|sub|class|specialty`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset category record was first created in the system. Supports audit trail and data lineage tracking.',
    `depreciation_method` STRING COMMENT 'Standard depreciation method applied to owned assets in this category for financial reporting: straight_line (equal annual depreciation), declining_balance (accelerated depreciation), units_of_production (usage-based depreciation for heavy equipment), none (non-depreciable or rental assets).. Valid values are `straight_line|declining_balance|units_of_production|none`',
    `effective_end_date` DATE COMMENT 'Date when this asset category was retired or deprecated. Null for currently active categories. Supports historical reporting and taxonomy evolution tracking.',
    `effective_start_date` DATE COMMENT 'Date when this asset category became active and available for asset classification. Supports temporal validity and historical taxonomy tracking.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether assets in this category are subject to environmental compliance tracking (emissions monitoring, fuel consumption reporting, EPA regulations). True for generators, diesel equipment, and vehicles; False for non-powered tools.',
    `hcss_equipment_type` STRING COMMENT 'HCSS HeavyJob equipment type classification for field operations time tracking and production reporting. Maps asset category to HeavyJob cost coding and equipment hour tracking structure.',
    `inspection_frequency_days` STRING COMMENT 'Standard inspection interval in days for assets in this category, aligned with manufacturer recommendations and regulatory requirements. Used to generate preventive maintenance schedules in SAP PM. Null for categories not requiring periodic inspection.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether assets in this category require dedicated insurance coverage beyond general liability. True for high-value equipment (cranes, excavators, specialized machinery); False for low-value consumable tools.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset category record was last updated. Supports change tracking and audit trail for taxonomy governance.',
    `maintenance_strategy_code` STRING COMMENT 'Default maintenance strategy code assigned to assets in this category, aligned with SAP PM maintenance strategy master data. Defines preventive maintenance frequency, inspection intervals, and service requirements (e.g., HVYEQ for heavy equipment, LTTOOL for light tools).. Valid values are `^[A-Z0-9]{2,6}$`',
    `mobilization_required` BOOLEAN COMMENT 'Indicates whether assets in this category require formal mobilization and demobilization tracking when deployed to project sites. True for heavy equipment requiring transport logistics; False for small portable tools.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this asset category record. Supports accountability and audit trail for master data governance.',
    `operator_certification_required` BOOLEAN COMMENT 'Indicates whether operation of assets in this category requires certified/licensed operators per OSHA regulations and company HSE policy. True for cranes, forklifts, and heavy machinery; False for hand tools and general equipment.',
    `ownership_classification` STRING COMMENT 'Default ownership model for assets in this category: owned (company-owned assets), rented (short-term rental), leased (long-term lease), mixed (category contains both owned and rented assets). Drives depreciation and cost allocation rules.. Valid values are `owned|rented|leased|mixed`',
    `sort_order` STRING COMMENT 'Numeric sort order for displaying asset categories in user interfaces and reports. Enables custom sequencing independent of alphabetical or hierarchical order.',
    `useful_life_years` STRING COMMENT 'Standard useful life in years for assets in this category, used for depreciation calculation and lifecycle planning. Null for rental/leased assets or categories with variable lifespans.',
    `utilization_tracking_required` BOOLEAN COMMENT 'Indicates whether assets in this category require detailed utilization tracking (equipment hours, production tracking) via HCSS HeavyJob or SAP PM. True for high-value equipment requiring cost recovery and productivity analysis; False for low-value consumable tools.',
    CONSTRAINT pk_asset_category PRIMARY KEY(`asset_category_id`)
) COMMENT 'Reference classification hierarchy for construction equipment and fleet assets. Defines the taxonomy of equipment types used across the enterprise: major categories (heavy earthmoving, lifting, concrete, MEP, fleet, small tools, generators), sub-categories, and equipment class codes aligned with HCSS HeavyJob cost coding and SAP PM functional location structures. Drives cost coding, depreciation rules, maintenance strategy assignment, and utilization benchmarking.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`fleet_assignment` (
    `fleet_assignment_id` BIGINT COMMENT 'Unique identifier for the fleet assignment record. Primary key.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Fleet assignments are made to support specific schedule activities. Equipment managers and schedulers use this link for resource loading, look-ahead readiness checks, and equipment availability report',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment lease/assignment to a project is governed by a contract; linking records the contract that authorizes each assignment.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment or fleet vehicle being assigned. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which the equipment is assigned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fleet assignments are charged to cost centers for departmental equipment cost allocation. Construction ERP systems require cost center on fleet assignments for overhead and equipment cost reporting. N',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Fleet assignments drive equipment cost allocation to cost codes for construction job costing. cost_allocation_code is a denormalized plain attr on fleet_assignment — replace with proper FK to finance.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Equipment operator assignment: fleet assignments designate which certified operator is assigned to operate specific equipment on a project. Equipment utilization reporting, operator certification comp',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: A fleet assignment for rented equipment is governed by a rental agreement. fleet_assignment already has rental_contract_number (a free-text string) and rental_vendor_id, which are denormalized referen',
    `vendor_id` BIGINT COMMENT 'Reference to the rental company or vendor supplying the equipment, if applicable. Null for owned equipment.',
    `site_id` BIGINT COMMENT 'Reference to the specific site or work location where the equipment is deployed.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Equipment fleet assignments to specific work activities require a SWMS governing safe operation of that equipment in the work context. Construction HSE managers verify that a valid SWMS exists for eve',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Trade package cost reporting: equipment deployed via fleet assignments must be allocated to trade packages for cost control and owner billing. Construction project controllers track equipment costs by',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element for cost allocation and project accounting. Used for internal charge-back to projects.',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or activity area within the site where the equipment is operating.',
    `actual_utilization_hours` DECIMAL(18,2) COMMENT 'Actual cumulative equipment operating hours recorded during this assignment. Updated from daily logs and equipment hour meters.',
    `assignment_end_date` DATE COMMENT 'The date when the equipment assignment ends or is planned to end. Nullable for open-ended assignments. Marks the end of cost allocation for this assignment.',
    `assignment_notes` STRING COMMENT 'Free-text notes and comments related to this equipment assignment. Captures special instructions, constraints, or operational considerations.',
    `assignment_number` STRING COMMENT 'Business identifier for the fleet assignment. Externally visible reference number used in mobilization documents and site logistics planning.. Valid values are `^FA-[0-9]{8}$`',
    `assignment_priority` STRING COMMENT 'Business priority level of this equipment assignment. Used for resource allocation decisions and conflict resolution when equipment is in high demand.. Valid values are `critical|high|medium|low`',
    `assignment_purpose` STRING COMMENT 'Business description of the purpose or scope of work for this equipment assignment. Describes the specific activities or tasks the equipment will perform.',
    `assignment_start_date` DATE COMMENT 'The date when the equipment assignment begins. Marks the start of cost allocation and utilization tracking for this assignment.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the equipment assignment. Tracks progression from planning through mobilization, active use, and demobilization. [ENUM-REF-CANDIDATE: planned|mobilizing|active|standby|demobilizing|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `assignment_type` STRING COMMENT 'Classification of the equipment ownership or procurement method for this assignment. Determines applicable cost rates and billing rules.. Valid values are `owned|rental|lease|subcontractor_supplied|client_supplied`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the source system. Audit trail for record creation.',
    `daily_rate` DECIMAL(18,2) COMMENT 'Internal daily cost rate for equipment assignment. Alternative to hourly rates for equipment charged on a daily basis.',
    `demobilization_cost` DECIMAL(18,2) COMMENT 'Actual or estimated cost of demobilizing the equipment from the site, including transportation, cleaning, and inspection. One-time cost allocated to the project.',
    `demobilization_date` DATE COMMENT 'The date when the equipment was demobilized from the site. Actual date of equipment removal and return to fleet pool or rental company.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Cumulative hours the equipment was on site but not actively operating during this assignment. Used for standby cost allocation and utilization analysis.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the equipment during this assignment. Required for high-value equipment and rental assets.',
    `mobilization_cost` DECIMAL(18,2) COMMENT 'Actual or estimated cost of mobilizing the equipment to the site, including transportation, permits, and setup. One-time cost allocated to the project.',
    `mobilization_date` DATE COMMENT 'The date when the equipment was physically mobilized to the site. Actual date of equipment arrival and readiness for work.',
    `mobilization_status` STRING COMMENT 'Current physical mobilization status of the equipment. Tracks whether equipment is in transit, on site, or has been demobilized.. Valid values are `not_started|in_transit|on_site|demobilized`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this assignment record in the source system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified in the source system. Audit trail for record updates.',
    `operating_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly operating cost rate including fuel, maintenance, and operator costs. Used for project cost allocation when equipment is actively operating.',
    `ownership_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly ownership cost rate for owned equipment. Used for project cost allocation and internal charge-back calculations.',
    `permit_number` STRING COMMENT 'Regulatory permit or authorization number required for operating this equipment on the site. Applicable for cranes, heavy lifts, and specialized machinery.',
    `planned_utilization_hours` DECIMAL(18,2) COMMENT 'Planned or estimated total equipment operating hours for this assignment. Used for capacity planning and utilization forecasting.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all rate amounts in this assignment record.. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this assignment record was sourced. Supports data lineage and reconciliation.. Valid values are `HCSS_HEAVYJOB|SAP_PS|PROCORE|MANUAL`',
    `source_system_code` STRING COMMENT 'Unique identifier of this assignment record in the source system. Used for data lineage, reconciliation, and incremental updates.',
    `standby_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly standby cost rate when equipment is on site but not actively operating. Lower rate than operating rate, used for idle time cost allocation.',
    `weekly_rate` DECIMAL(18,2) COMMENT 'Internal weekly cost rate for equipment assignment. Alternative to hourly or daily rates for equipment charged on a weekly basis.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this assignment record in the source system.',
    CONSTRAINT pk_fleet_assignment PRIMARY KEY(`fleet_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a specific piece of equipment or fleet vehicle to a project, site, or work front for a defined period. Tracks assignment start and end dates, assigned project, site location, responsible operator or driver, mobilization status, cost allocation code (WBS element), and applicable internal hire rate (ownership rate, operating rate, standby rate per hour/day/week). Supports equipment utilization tracking, inter-project cost allocation, internal charge-back to projects, and site logistics planning. Sourced from HCSS HeavyJob and SAP PS project systems.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`hours` (
    `hours_id` BIGINT COMMENT 'Unique identifier for the equipment hours transaction record. Primary key for daily or shift-level equipment operating time entries.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Equipment hours records must tie to schedule activities for earned value measurement (BCWP), production rate analysis, and cost-to-complete forecasting. This is a fundamental EVM requirement in constr',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment usage hours are charged to the project contract; linking supports progress billing and utilization reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment unit (crane, excavator, concrete pump, generator, vehicle) for which hours are being recorded.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the equipment was deployed and operated during this time period.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment hours are charged to cost centers for departmental cost allocation and equipment utilization reporting. hours has finance_cost_code_id but no cost_center FK. Construction cost controllers al',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Equipment operating hour costs are posted to cost codes for labor and equipment cost tracking.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: Operating hours are recorded for equipment under a specific fleet assignment. hours already has asset_id and construction_project_id, but the fleet_assignment provides the specific assignment context ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Equipment hours records generate cost postings to GL accounts (equipment usage expense) for P&L reporting. hours has finance_cost_code_id but no GL account FK. Finance teams post equipment usage costs',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Equipment hours records capture downtime with downtime_root_cause_code and downtime_impact_assessment. When downtime is caused by an incident, linking hours to the incident enables incident cost quant',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Shift-level operator productivity and payroll cross-reference: equipment hours records capture which operator ran the equipment each shift. Operator productivity analysis, incident investigation (down',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: Hours recorded for rented equipment must be reconciled against the rental agreement for billing purposes — rental agreements specify daily/weekly/monthly hire rates and the billing_frequency. hours al',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element or work package where equipment hours were charged for granular cost tracking and EVM reporting.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the equipment hours record. Tracks progression from field entry through supervisor approval to final posting for cost allocation.. Valid values are `draft|submitted|approved|rejected|disputed`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment hours record was approved by the authorized supervisor. Used for audit trail and approval cycle time analysis.',
    `cost_per_hour` DECIMAL(18,2) COMMENT 'Calculated or allocated cost per operating hour for this equipment during the shift. Includes ownership cost, fuel, operator labor, and maintenance allocation. Used for job costing and CPI calculation.',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event cause (breakdown, awaiting parts, awaiting operator, weather hold, scheduled maintenance, unscheduled repair). Used for downtime root cause analysis.. Valid values are `breakdown|awaiting_parts|awaiting_operator|weather_hold|scheduled_maintenance|unscheduled_repair`',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when equipment downtime event ended and equipment returned to service. Used for MTTR and downtime duration calculation.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was unavailable due to breakdown, maintenance, repair, or other non-productive events. Sum of all downtime event durations for the shift.',
    `downtime_impact_assessment` STRING COMMENT 'Business assessment of the downtime events impact on project schedule, cost, and critical path activities. Used for prioritizing maintenance and resource allocation.. Valid values are `critical|high|medium|low|none`',
    `downtime_resolution_action` STRING COMMENT 'Free-text description of the corrective action taken to resolve the downtime event and return equipment to service. Includes repair details, parts replaced, or workaround applied.',
    `downtime_root_cause_code` STRING COMMENT 'Detailed alphanumeric code identifying the specific root cause of the downtime event (e.g., hydraulic failure, tire puncture, electrical fault). Used for MTBF and failure pattern analysis.. Valid values are `^[A-Z0-9]{2,8}$`',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when equipment downtime event began. Used for MTTR (Mean Time To Repair) and availability rate calculations.',
    `equipment_availability_rate` DECIMAL(18,2) COMMENT 'Calculated percentage of scheduled time that equipment was available for use (not in downtime). Formula: ((total_hours - downtime_hours) / total_hours) * 100. Used for maintenance effectiveness and reliability analysis.',
    `equipment_utilization_rate` DECIMAL(18,2) COMMENT 'Calculated percentage of available time that equipment was productively operating. Formula: (operating_hours / (operating_hours + idle_hours + standby_hours + downtime_hours)) * 100. Key performance indicator for fleet management.',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed by the equipment during the shift, measured in liters. Used for fuel efficiency analysis, cost allocation, and environmental reporting.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Hours the equipment was powered on but not performing productive work (waiting for materials, operator break, minor delays). Excludes scheduled downtime.',
    `is_billable` BOOLEAN COMMENT 'Flag indicating whether these equipment hours are billable to the client under the contract terms. Used for revenue recognition and client invoicing.',
    `is_overtime` BOOLEAN COMMENT 'Flag indicating whether these equipment hours were logged during overtime shift periods, affecting cost rates and operator compensation.',
    `location_description` STRING COMMENT 'Free-text description of the specific work location or area within the project site where equipment was deployed (e.g., North Excavation Zone, Building A Foundation, Access Road KM 12).',
    `meter_reading_end` DECIMAL(18,2) COMMENT 'Equipment hour meter or odometer reading at the end of the shift. Used to validate reported hours and track cumulative equipment usage for maintenance scheduling.',
    `meter_reading_start` DECIMAL(18,2) COMMENT 'Equipment hour meter or odometer reading at the start of the shift. Used to validate reported hours and track cumulative equipment usage for maintenance scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context about the equipment hours entry. May include operational notes, safety observations, or special conditions.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was actively operating and performing productive work during the shift. Core metric for utilization rate calculation and cost-per-hour analysis.',
    `ownership_type` STRING COMMENT 'Classification of equipment ownership model (owned, rented, leased, subcontractor-supplied). Affects cost allocation method and asset management responsibility.. Valid values are `owned|rented|leased|subcontractor_supplied`',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work output achieved during the shift (e.g., cubic meters excavated, tons hauled, square meters paved). Used for productivity rate calculation and earned value analysis.',
    `production_unit_of_measure` STRING COMMENT 'Unit of measure for the production quantity achieved (cubic meters, tons, square meters, linear meters, each, kilograms, liters). Aligns with project quantity takeoff and BOQ units. [ENUM-REF-CANDIDATE: m3|ton|m2|linear_m|each|kg|liter — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment hours record was first created in the source system. Audit field for data lineage and record lifecycle tracking.',
    `record_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment hours record was last modified in the source system. Audit field for change tracking and data quality monitoring.',
    `shift_date` DATE COMMENT 'Calendar date on which the equipment hours were recorded. Primary business event date for daily time tracking and utilization reporting.',
    `shift_type` STRING COMMENT 'Classification of the work shift during which equipment hours were logged (day, night, swing, weekend, holiday, emergency). Used for shift differential costing and scheduling analysis.. Valid values are `day|night|swing|weekend|holiday|emergency`',
    `source_record_reference` STRING COMMENT 'Unique identifier of the equipment hours record in the source operational system. Used for data lineage traceability and reconciliation.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this equipment hours record originated. Primary source is HCSS HeavyJob field time tracking.. Valid values are `HCSS_HeavyJob|SAP_PM|Procore|Manual_Entry`',
    `standby_hours` DECIMAL(18,2) COMMENT 'Hours the equipment was on-site, available for use, but not powered on or actively deployed. Includes weather holds and awaiting instructions.',
    `total_equipment_cost` DECIMAL(18,2) COMMENT 'Total cost charged to the project for this equipment hours record. Calculated as operating_hours * cost_per_hour plus any additional charges. Used for project cost control and EVM.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition during the shift that may have affected equipment operation and productivity. Used for weather impact analysis and EOT claims. [ENUM-REF-CANDIDATE: clear|rain|snow|wind|extreme_heat|extreme_cold|fog — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hours PRIMARY KEY(`hours_id`)
) COMMENT 'Daily or shift-level transactional record of equipment operating hours, idle hours, standby hours, and downtime events captured from HCSS HeavyJob field time tracking. Includes cost code, operator ID, project and WBS reference, fuel consumption, meter reading (odometer or hour meter), shift date, production quantity achieved. For non-productive time: captures downtime start/end timestamps, duration, downtime category (breakdown, awaiting parts, awaiting operator, weather hold, scheduled maintenance), root cause code, resolution action, and impact assessment. Foundational for equipment utilization rate calculation, cost-per-hour analysis, MTTR (Mean Time To Repair), MTBF (Mean Time Between Failures), availability rate reporting, and CPI/SPI reporting under EVM. SSOT for all equipment time and downtime recording. Primary source: HCSS HeavyJob daily time entry.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Unique identifier for the maintenance plan record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Maintenance plans are defined in equipment service contracts; linking supports schedule and financial tracking per agreement.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: The maintenance_plan product description explicitly states it defines the preventive maintenance strategy and schedule for a CLASS of equipment — meaning plans are defined at the asset_category leve',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset or equipment class covered by this maintenance plan.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment and its maintenance plan are assigned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance plan budgeting is tracked against a cost center to align planned expenses with financial budgets.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Maintenance plans carry estimated_labor_cost and estimated_material_cost that must be budgeted against cost codes for construction project cost planning. maintenance_plan has cost_center_id but no cos',
    `crew_id` BIGINT COMMENT 'Reference to the maintenance crew or team responsible for executing this maintenance plan.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Maintenance plans for safety-critical equipment are developed in alignment with the project HSE Plan, which sets inspection frequencies, regulatory obligations, and safety-critical maintenance require',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Major equipment maintenance activities (crane load tests, pressure vessel inspections) are governed by ITPs specifying hold points and acceptance criteria. Construction QA requires maintenance plans t',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Maintenance plans in construction are structured by project phase — earthworks phase requires different PM schedules than commissioning phase. A maintenance planner and project controls manager both e',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Maintenance plans for regulated equipment classes are structured around regulatory obligations specifying inspection/service intervals (e.g., annual load testing per lifting equipment regulations). Li',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Maintenance plans for high-risk plant are developed based on risk assessments identifying hazards of the maintenance activity. The risk assessment drives maintenance strategy, frequency, and safety co',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Maintenance plans reference the SWMS applicable to the recurring maintenance activity type. The SWMS is prepared once for the activity and referenced by the plan for each execution. Construction maint',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether completion of this maintenance plan requires formal certification or inspection sign-off by a qualified authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance plan record was first created in the system.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment must be taken out of service to perform the maintenance activities in this plan.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance plan expires or is scheduled to be deactivated. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the maintenance plan becomes active and begins generating scheduled maintenance tasks.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan includes activities required for environmental compliance (emissions testing, fluid disposal, spill prevention).',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the equipment will be unavailable during maintenance execution.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required to complete the maintenance activities defined in this plan.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated labor cost in base currency for executing one cycle of this maintenance plan.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of parts, materials, and consumables required for one maintenance cycle.',
    `interval_unit` STRING COMMENT 'Unit of measure for the maintenance interval (hours, days, weeks, months, years, kilometers, cycles). [ENUM-REF-CANDIDATE: hours|days|weeks|months|years|kilometers|cycles — 7 candidates stripped; promote to reference product]',
    `interval_value` DECIMAL(18,2) COMMENT 'Numeric value defining the service interval (e.g., 250 for every 250 engine hours, 6 for every 6 months).',
    `last_execution_date` DATE COMMENT 'Date when the maintenance plan was last executed, used to calculate the next scheduled maintenance date.',
    `lead_time_days` STRING COMMENT 'Number of days advance notice required before the scheduled maintenance date to allow for planning, parts procurement, and resource allocation.',
    `manufacturer_recommendation_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan follows the equipment manufacturers recommended service schedule.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this maintenance plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance plan record was last updated.',
    `next_scheduled_date` DATE COMMENT 'Calculated date for the next scheduled maintenance activity based on the interval and last execution date.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special considerations, or operational notes related to the execution of this maintenance plan.',
    `parts_list_reference` STRING COMMENT 'Reference to the bill of materials (BOM) or parts list defining the spare parts and materials required for this maintenance plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the maintenance plan for human identification and reporting purposes.',
    `plan_number` STRING COMMENT 'Business identifier for the maintenance plan, externally visible and used in operational communications.. Valid values are `^[A-Z0-9]{8,12}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the maintenance plan indicating whether it is generating work orders.. Valid values are `draft|active|suspended|inactive|archived`',
    `plan_type` STRING COMMENT 'Classification of the maintenance strategy: time-based (calendar intervals), meter-based (usage hours/kilometers), condition-based (sensor thresholds), predictive (AI/ML forecasting), or statutory (regulatory compliance).. Valid values are `time_based|meter_based|condition_based|predictive|statutory`',
    `priority_level` STRING COMMENT 'Business priority classification for scheduling and resource allocation of maintenance activities generated by this plan.. Valid values are `critical|high|medium|low`',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan addresses safety-critical equipment or systems where failure could result in injury or fatality.',
    `scheduling_strategy` STRING COMMENT 'Defines how maintenance tasks are scheduled: fixed schedule (specific calendar dates), floating schedule (relative to last completion), or on-demand (triggered by condition).. Valid values are `fixed_schedule|floating_schedule|on_demand`',
    `site_location_code` STRING COMMENT 'Code identifying the construction site, yard, or facility where the equipment is located and maintenance will be performed.. Valid values are `^[A-Z0-9]{3,8}$`',
    `task_list_reference` STRING COMMENT 'Reference code to the detailed maintenance task list or work instruction document that defines the specific activities, steps, and procedures to be performed.. Valid values are `^TL[A-Z0-9]{6,10}$`',
    `tolerance_after_days` STRING COMMENT 'Number of days after the scheduled date that maintenance can be delayed without triggering an overdue alert.',
    `tolerance_before_days` STRING COMMENT 'Number of days before the scheduled date that maintenance can be performed early without resetting the interval counter.',
    `warranty_impact_flag` BOOLEAN COMMENT 'Indicates whether adherence to this maintenance plan is required to maintain equipment warranty coverage.',
    `work_order_type` STRING COMMENT 'Classification of the work orders generated by this maintenance plan (preventive maintenance, inspection, calibration, overhaul, statutory compliance).. Valid values are `preventive|inspection|calibration|overhaul|statutory`',
    CONSTRAINT pk_maintenance_plan PRIMARY KEY(`maintenance_plan_id`)
) COMMENT 'Master record defining the preventive maintenance strategy and schedule for a class of equipment or individual asset. Captures maintenance plan type (time-based, meter-based, condition-based), service intervals (e.g., every 250 engine hours, every 6 months), maintenance task list reference, responsible maintenance team, estimated duration, parts and materials required, and compliance requirements (e.g., crane certification intervals, OSHA inspection schedules). Sourced from SAP PM Maintenance Plan.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance order record. Primary key for this entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Planned major maintenance shutdowns and overhauls are scheduled as activities in the project schedule. Linking maintenance_order to the schedule activity enables critical path impact analysis of equip',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Maintenance services are often covered by service contracts; the link allocates labor and parts costs to the correct agreement.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset on which this maintenance activity was performed. Links to the equipment master data.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Work order execution tracking: maintenance orders are assigned to specific technicians/mechanics for execution. SAP PM and HCSS both require identifying the assigned craft worker on each work order fo',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Multi-technician maintenance execution: large equipment maintenance orders (engine overhauls, crane inspections) require a full crew. Tracking the executing crew on the order enables crew productivity',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: In construction, regulatory authority notices (e.g., defect notices, stop-work orders) directly trigger maintenance orders for corrective repairs. Linking maintenance_order to the originating authorit',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to quality.checklist. Business justification: Maintenance orders in construction are executed against quality-controlled maintenance checklists defining task sequences and acceptance criteria. Linking maintenance_order to quality.checklist enable',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment and maintenance activity are assigned. Enables project-level cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance order costs must be charged to the responsible cost center for accurate project cost reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Maintenance order costs (labor, parts, external services) must be allocated to cost codes for construction job costing and project cost reporting. maintenance_order has cost_center_id but no cost_code',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Maintenance costs are posted to GL accounts (maintenance expense, parts expense) for P&L reporting and accruals. Construction finance teams post maintenance orders to specific GL accounts. No existing',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Corrective maintenance orders are frequently triggered by equipment incidents (breakdown, damage, near-miss). Linking maintenance_order to the triggering incident supports incident cost tracking, corr',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to equipment.inspection_record. Business justification: A maintenance order is frequently triggered by a failed or defective inspection finding. maintenance_order already has compliance_inspection_flag and inspection_certificate_number (string), but no str',
    `maintenance_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance plan that generated this order, if applicable. Null for corrective or breakdown orders.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Needed to record which material (spare part) is consumed in a maintenance order, supporting inventory control and maintenance cost analysis.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCRs identifying equipment defects or failures directly trigger corrective maintenance orders. Construction QA workflow: NCR raised → maintenance_order created to rectify. This FK enables traceability',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Construction maintenance on safety-critical plant (LOTO, confined space, hot work) requires an authorising Permit to Work before work commences. The maintenance_order references the PTW that legally a',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Phase-gate reviews in construction require all maintenance orders to be scoped to a project phase (e.g., commissioning-phase statutory inspections). A project controls engineer expects maintenance cos',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Maintenance orders for safety-critical equipment (cranes, hoists, pressure vessels) are directly mandated by regulatory obligations specifying service intervals. Linking maintenance_order to regulator',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: High-risk construction maintenance activities require a Safe Work Method Statement (SWMS) documenting hazards and controls. The maintenance_order references the governing SWMS for the task. Required u',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Post-maintenance quality inspections verify that maintenance work meets acceptance criteria before equipment is returned to service. Construction QA requires linking the maintenance order to the verif',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Maintenance order costs must be charged to a WBS element for project cost control and EVM. A cost controller and SAP PM user expect maintenance orders to carry a WBS charge code so that equipment main',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the maintenance work was completed. Used to calculate actual downtime and compare against planned duration.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the maintenance work commenced. Captured from field logs or technician time entry systems.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance order was formally closed in the system, indicating all work and cost postings are complete. Null if order is not yet closed.',
    `compliance_inspection_flag` BOOLEAN COMMENT 'Indicates whether this maintenance order includes a statutory or regulatory compliance inspection (e.g., OSHA crane inspection, pressure vessel certification). True if compliance inspection performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance order record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts in this maintenance order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was out of service due to this maintenance activity. Critical metric for availability analysis and project impact assessment.',
    `external_services_cost` DECIMAL(18,2) COMMENT 'Cost of external contractor services or specialized vendor support procured for this maintenance order (e.g., OEM technician, crane inspection service).',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or defect addressed by this maintenance order (e.g., hydraulic leak, engine overheating, electrical fault). Used for failure pattern analysis.',
    `failure_description` STRING COMMENT 'Detailed narrative description of the failure, defect, or maintenance requirement that this order addresses. Captured from technician notes or notification text.',
    `inspection_certificate_number` STRING COMMENT 'Certificate or permit number issued upon successful completion of a statutory inspection, if applicable. Required for regulatory audit trails.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for this maintenance order, calculated from labor hours and technician rates. Excludes parts and external services.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended on this maintenance order, aggregated across all technicians and activities. Used for cost calculation and productivity analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance order record was last updated. Part of the audit trail for compliance and data governance.',
    `meter_reading_at_maintenance` DECIMAL(18,2) COMMENT 'Equipment hour meter or odometer reading captured at the time of maintenance. Used for usage-based maintenance scheduling and lifecycle tracking.',
    `next_inspection_due_date` DATE COMMENT 'Date when the next statutory or preventive inspection is due for this equipment, updated upon completion of this maintenance order.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this maintenance order. May include safety precautions, access requirements, or follow-up actions.',
    `order_number` STRING COMMENT 'Business identifier for the maintenance order, typically the SAP PM order number or HCSS work order reference used for tracking and reporting.',
    `order_status` STRING COMMENT 'Current lifecycle status of the maintenance order. Tracks progression from creation through execution to closure. [ENUM-REF-CANDIDATE: created|released|in_progress|completed|technically_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the maintenance activity: preventive (scheduled), corrective (planned repair), breakdown (emergency), statutory inspection (regulatory), calibration, or overhaul.. Valid values are `preventive|corrective|breakdown|statutory_inspection|calibration|overhaul`',
    `parts_cost` DECIMAL(18,2) COMMENT 'Total cost of parts and materials consumed during this maintenance activity, aggregated from all parts line items.',
    `planned_end_date` DATE COMMENT 'Scheduled date when the maintenance activity is planned to be completed. Used for equipment downtime planning and project scheduling.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the maintenance activity is planned to begin. Used for resource planning and equipment availability forecasting.',
    `priority` STRING COMMENT 'Urgency level of the maintenance order. Critical and high priority orders require immediate attention to prevent safety hazards or project delays.. Valid values are `critical|high|medium|low`',
    `purchase_order_number` STRING COMMENT 'Purchase order number for external services or parts procured for this maintenance order, if applicable. Links to procurement records.',
    `site_location_code` STRING COMMENT 'Code identifying the construction site or yard location where the maintenance was performed. Supports geographic cost analysis and logistics planning.',
    `total_maintenance_cost` DECIMAL(18,2) COMMENT 'Total cost of the maintenance order, summing labor, parts, and external services. Used for asset lifecycle costing and budget tracking.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this maintenance order is associated with a warranty claim against the equipment manufacturer or supplier. True if warranty claim was filed.',
    `warranty_claim_number` STRING COMMENT 'External warranty claim reference number provided by the equipment manufacturer or supplier, if applicable. Null if no warranty claim.',
    `work_center_code` STRING COMMENT 'Code identifying the maintenance work center or shop responsible for executing this order (e.g., heavy equipment shop, electrical shop, hydraulics shop).',
    `work_performed_description` STRING COMMENT 'Detailed narrative of the maintenance work actually performed, including repairs, replacements, adjustments, and inspections. Serves as technical record and warranty evidence.',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Transactional work order record for a specific maintenance activity executed on an asset, generated from a maintenance plan (preventive) or raised as a corrective/breakdown order from a notification. Captures order type (preventive, corrective, breakdown, statutory inspection), priority, planned and actual start/end dates, assigned technician, labor hours, parts consumed (part number, quantity, unit cost per line item), total maintenance cost (labor + parts + external services), order status (created, released, in-progress, completed, technically complete, closed), and SAP PM order number. Supports maintenance cost tracking at labor and parts level, asset downtime analysis, warranty claim evidence, and compliance audit trails. Parts consumption data here serves as the equipment domains record of materials used — material domain owns stock levels and replenishment.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`inspection_record` (
    `inspection_record_id` BIGINT COMMENT 'Unique identifier for the equipment inspection record. Primary key for the inspection_record product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Inspection services are often covered by contracts; associating inspections with the agreement enables compliance and cost tracking.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset that was inspected. Links to the equipment master data product.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to quality.checklist. Business justification: Equipment inspections are executed against quality checklists defining inspection criteria. The inspection_checklist_reference plain column is a denormalized reference to quality.checklist. Constructi',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment is currently assigned at the time of inspection. Null if equipment is in yard or not assigned to a project.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection costs are charged to cost centers for departmental cost allocation and overhead reporting. Construction finance teams require cost center on inspection records to allocate compliance and sa',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Inspection costs (inspection_cost field) must be allocated to cost codes for construction job costing and compliance cost tracking. Cost controllers allocate inspection spend by cost code for project ',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Equipment inspection schedules and requirements are governed by the project HSE Plan, which sets mandatory inspection frequencies and regulatory standards. Linking inspection_record to hse_plan enable',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Regulatory compliance requirement: OSHA and jurisdictional regulations mandate identifying the qualified inspector who performed each equipment inspection. Certificate issuance and corrective action a',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: Equipment inspections are conducted against specific ITP hold/witness points. The ITP line defines acceptance criteria and inspection scope; the inspection_record captures the outcome. Construction QA',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: When an equipment inspection identifies defects or non-conformances, an NCR is raised. Construction QA workflow requires traceability from the equipment inspection record that triggered the NCR, enabl',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Statutory equipment inspections (cranes, hoists, pressure vessels, confined space plant) require a PTW before the inspector can access the equipment. The inspection_record references the authorising P',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Pre-phase-gate equipment inspections are a regulatory and contractual requirement in construction (e.g., pre-commissioning inspection before commissioning phase begins). A QA/HSE manager and project e',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Equipment inspections in construction are mandated by specific regulatory obligations (e.g., OSHA crane inspection requirements, pressure vessel regulations). Linking inspection_record to the governin',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Equipment inspection activities on safety-critical plant are preceded by a risk assessment identifying hazards of the inspection task itself. The risk_assessment_id links the inspection record to its ',
    `certificate_document_reference` STRING COMMENT 'File path, document management system reference, or URL pointing to the stored digital copy of the compliance certificate. Used for audit retrieval and regulatory verification. Null if no certificate was issued.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the compliance certificate expires and the equipment must be re-inspected to maintain certification. Critical for compliance tracking and pre-mobilization checks. Null if no certificate was issued or certificate has no expiry.',
    `certificate_issue_date` DATE COMMENT 'Date on which the compliance certificate was formally issued by the issuing authority. Null if no certificate was issued.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal compliance certificate was issued as a result of this inspection. True indicates a certificate was generated and is on file. False indicates no certificate was issued (typical for routine pre-start checks or failed inspections).',
    `certificate_issuing_authority` STRING COMMENT 'Name of the organization or regulatory body that issued the compliance certificate. Examples include OSHA, ASME authorized inspector, insurance company, third-party certification body, or internal HSE department. Null if no certificate was issued.',
    `certificate_number` STRING COMMENT 'Unique identifier assigned to the compliance certificate issued as a result of this inspection. Used for regulatory audit trails and insurance verification. Null if no certificate was issued.',
    `certificate_type` STRING COMMENT 'Classification of the compliance certificate issued. Crane load test certificate: structural capacity verification. Pressure vessel certificate: boiler and pressure equipment certification. Lifting gear certificate: rigging and lifting equipment certification. OSHA compliance certificate: regulatory safety certification. Insurance certificate: insurer-required equipment certification. FAT: Factory Acceptance Test certificate. SAT: Site Acceptance Test certificate. Fitness for use: general equipment fitness certification. Null if no certificate was issued. [ENUM-REF-CANDIDATE: crane_load_test|pressure_vessel|lifting_gear|osha_compliance|insurance|fat|sat|fitness_for_use — 8 candidates stripped; promote to reference product]',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions must be completed to restore equipment compliance. Null if no corrective actions are required.',
    `corrective_actions_required` STRING COMMENT 'Detailed description of corrective actions, repairs, or remediation work required to address identified defects and restore equipment to compliant, fit-for-use condition.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was first created in the maintenance management or HSE system. Audit trail for data lineage.',
    `defects_description` STRING COMMENT 'Detailed narrative description of all defects, non-conformances, observations, or safety concerns identified during the inspection. Includes location, severity, and nature of each finding.',
    `defects_identified_count` STRING COMMENT 'Total number of defects, non-conformances, or observations identified during the inspection. Zero indicates no issues found.',
    `equipment_hours_at_inspection` DECIMAL(18,2) COMMENT 'Total accumulated operating hours recorded on the equipment hour meter at the time of inspection. Used for usage-based maintenance scheduling and lifecycle tracking.',
    `inspection_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this inspection event, including inspector fees, third-party inspection charges, testing costs, and administrative overhead. Null if cost not tracked.',
    `inspection_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the inspection cost. Examples: USD, EUR, GBP. Null if cost not tracked.. Valid values are `^[A-Z]{3}$`',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was performed. This is the principal business event date for the inspection record.',
    `inspection_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activity was completed and findings were recorded.',
    `inspection_frequency_days` STRING COMMENT 'Standard interval in days between required inspections for this equipment and inspection type. Used to calculate next inspection due date. Examples: 1 day for pre-start checks, 30 days for monthly inspections, 365 days for annual statutory inspections.',
    `inspection_location` STRING COMMENT 'Physical location where the inspection was performed. May be a construction site name, yard location, workshop, factory, or field location identifier.',
    `inspection_notes` STRING COMMENT 'Free-form text field for additional observations, comments, recommendations, or contextual information recorded by the inspector that does not fit into structured fields.',
    `inspection_number` STRING COMMENT 'Externally-known unique business identifier for the inspection event, typically generated by the maintenance management system or HSE system.',
    `inspection_outcome` STRING COMMENT 'Final pass/fail determination of the inspection. Pass: equipment meets all requirements and is fit for use. Fail: equipment does not meet requirements and must not be used until corrective action is completed. Conditional pass: equipment passed with minor observations or time-limited approval. Not applicable: inspection was not completed or outcome not yet determined.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `inspection_scope` STRING COMMENT 'Detailed description of the scope of work covered by this inspection. Specifies which components, systems, or functions were inspected and any exclusions or limitations.',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activity commenced on site or in the facility.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record. Scheduled: inspection planned but not started. In progress: inspection underway. Completed: inspection finished, outcome recorded. Passed: equipment meets all requirements. Failed: equipment does not meet requirements, corrective action required. Conditional pass: equipment passed with minor observations or time-limited approval. Cancelled: inspection was cancelled before completion. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|passed|failed|conditional_pass|cancelled — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Classification of the inspection event. Pre-start check: operator daily verification before use. Periodic statutory: legally mandated recurring inspection. OSHA compliance check: regulatory safety inspection per Occupational Safety and Health Administration requirements. Crane load test: structural load capacity verification. Lifting gear: rigging and lifting equipment inspection. Pressure vessel test: boiler and pressure equipment certification. FAT: Factory Acceptance Test. SAT: Site Acceptance Test. Operator daily: routine operator checklist. Preventive maintenance: scheduled PM inspection. [ENUM-REF-CANDIDATE: pre_start_check|periodic_statutory|osha_compliance|crane_load_test|lifting_gear|pressure_vessel|fat|sat|operator_daily|preventive_maintenance — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was last updated or modified. Audit trail for data lineage and change tracking.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of this equipment, based on regulatory requirements, manufacturer recommendations, or internal maintenance schedules. Critical for compliance tracking and preventive maintenance planning.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this inspection record originated. SAP PM: SAP Plant Maintenance module. Intelex: HSE Management system. HCSS HeavyJob: Field operations system. Procore: Construction management platform. Manual entry: paper-based inspection digitized.. Valid values are `sap_pm|intelex|hcss_heavyjob|procore|manual_entry`',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for outdoor equipment inspections where environmental factors may affect inspection validity or equipment condition assessment.',
    CONSTRAINT pk_inspection_record PRIMARY KEY(`inspection_record_id`)
) COMMENT 'Transactional record of a statutory, regulatory, or internal safety inspection performed on a piece of equipment, and the master register of all resulting compliance certificates issued. Captures inspection type (pre-start check, periodic statutory inspection, OSHA compliance check, crane load test, lifting gear inspection, pressure vessel test, FAT/SAT), inspection date, inspector name and certification, pass/fail outcome, defects identified, corrective actions required, next inspection due date. For certificates: captures certificate type (crane load test certificate, pressure vessel certificate, lifting gear certificate, OSHA compliance certificate, insurance certificate), certificate number, issuing authority, issue date, expiry date, and document storage reference. SSOT for all equipment inspection events AND asset-level compliance certificates. Supports OSHA compliance, insurance requirements, equipment fitness-for-use certification, pre-mobilization compliance checks, and regulatory audit trails. Distinct from quality ITP inspections (owned by quality domain) and operator certifications (which track people, not assets).';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`rental_agreement` (
    `rental_agreement_id` BIGINT COMMENT 'Unique identifier for the equipment rental agreement. Primary key for the rental agreement record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Rental agreements are a type of contract; linking enables compliance, billing, and performance reporting against the governing agreement.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment unit being rented. Links to the equipment master record in the equipment domain.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this rental equipment is assigned. Links to the project master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rental agreement expenses are allocated to a cost center for cost tracking and billing.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Rental hire costs must be allocated to cost codes for construction job costing and project cost reporting. rental_agreement has cost_center_id but no cost_code FK. Cost controllers classify rental exp',
    `estimate_id` BIGINT COMMENT 'Foreign key linking to bid.estimate. Business justification: Post-award cost variance analysis: actual rental agreements are reconciled against the originating bid estimate to measure equipment cost performance. Construction cost controllers routinely compare e',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rental hire costs are posted to GL accounts (equipment hire expense) for P&L reporting and accruals. Construction finance teams post rental commitments to specific GL accounts. No existing FK; total_c',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Equipment rental agreements in construction are negotiated and committed for specific project phases (e.g., cranes rented for structural phase only). A contracts manager and cost controller expect ren',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Equipment rental agreements in construction are frequently governed by a subcontract. Linking rental_agreement to the governing subcontract enables subcontract payment reconciliation, closeout verific',
    `vendor_id` BIGINT COMMENT 'Reference to the plant hire company or equipment supplier providing the rental equipment. Links to the supplier master record.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: rental_agreement carries a plain-text wbs_element_code column — a clear denormalization of the WBS element. Rental costs are directly charged to WBS in construction cost control systems (SAP, Procore)',
    `actual_demobilization_date` DATE COMMENT 'Actual date when the equipment was demobilized and removed from the project site. Used for final billing and cost reconciliation.',
    `actual_mobilization_date` DATE COMMENT 'Actual date when the equipment was delivered and mobilized to the project site. May differ from planned rental start date.',
    `approval_date` DATE COMMENT 'Date when the rental agreement was formally approved and authorized for execution.',
    `billing_frequency` STRING COMMENT 'Frequency at which rental charges are invoiced by the supplier (daily, weekly, monthly, or milestone-based).. Valid values are `daily|weekly|monthly|milestone`',
    `contract_document_reference` STRING COMMENT 'Reference to the physical or digital contract document stored in the document management system (e.g., Aconex document ID).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rental agreement record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rental agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daily_hire_rate` DECIMAL(18,2) COMMENT 'Agreed daily rental rate for the equipment in the contract currency. Used when billing is on a daily basis.',
    `damage_waiver_amount` DECIMAL(18,2) COMMENT 'Optional damage waiver fee paid to limit contractor liability for equipment damage during the rental period.',
    `demobilization_charge` DECIMAL(18,2) COMMENT 'One-time charge for dismantling and removing the equipment from the project site. Invoiced at rental completion.',
    `equipment_description` STRING COMMENT 'Detailed description of the rented equipment including make, model, capacity, and specifications (e.g., Liebherr LTM 1200-5.1 Mobile Crane, 200-ton capacity).',
    `equipment_type` STRING COMMENT 'Classification of the rented equipment by type. Used for fleet management and cost analysis. [ENUM-REF-CANDIDATE: crane|excavator|bulldozer|loader|concrete_pump|generator|compressor|scaffolding|formwork|tower_crane|mobile_crane — 11 candidates stripped; promote to reference product]',
    `fuel_included_flag` BOOLEAN COMMENT 'Indicates whether fuel costs are included in the hire rate (True) or billed separately (False).',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the insurance certificate covering the rented equipment. Used for compliance verification.',
    `insurance_requirement` STRING COMMENT 'Description of insurance coverage requirements for the rented equipment, including liability limits and coverage types.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rental agreement record was last updated. Used for audit trail and change tracking.',
    `late_return_penalty_rate` DECIMAL(18,2) COMMENT 'Daily penalty rate charged by the supplier if equipment is returned after the agreed rental end date.',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for routine maintenance and repairs during the rental period (supplier, contractor, or shared).. Valid values are `supplier|contractor|shared`',
    `minimum_hire_period_days` STRING COMMENT 'Minimum number of days the equipment must be hired as stipulated in the rental agreement. Used for cost commitment calculation.',
    `mobilization_charge` DECIMAL(18,2) COMMENT 'One-time charge for transporting and setting up the equipment at the project site. Invoiced at rental commencement.',
    `monthly_hire_rate` DECIMAL(18,2) COMMENT 'Agreed monthly rental rate for the equipment in the contract currency. Used when billing is on a monthly basis.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or remarks related to the rental agreement.',
    `operator_supplied_flag` BOOLEAN COMMENT 'Indicates whether the rental supplier provides a qualified operator with the equipment (True) or if the contractor provides their own operator (False).',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the supplier (e.g., Net 30 days, Net 45 days, 2/10 Net 30). Governs invoice payment schedule.',
    `rental_agreement_number` STRING COMMENT 'Business-facing unique identifier for the rental agreement, typically used in contracts and invoices. Format: RA-NNNNNN.. Valid values are `^RA-[0-9]{6,10}$`',
    `rental_end_date` DATE COMMENT 'Planned or actual date when the rental period ends and equipment is demobilized. Nullable for open-ended rentals.',
    `rental_po_number` STRING COMMENT 'Purchase order number issued to the supplier for this rental agreement. Links the rental agreement to the procurement transaction.. Valid values are `^PO-[0-9]{8,12}$`',
    `rental_start_date` DATE COMMENT 'Date when the rental period begins and hire charges commence. Typically aligned with equipment mobilization date.',
    `rental_status` STRING COMMENT 'Current lifecycle status of the rental agreement. Tracks the agreement from draft through completion or cancellation. [ENUM-REF-CANDIDATE: draft|approved|active|on_hire|demobilized|completed|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Refundable security deposit held by the supplier to cover potential damage or late return penalties.',
    `site_location` STRING COMMENT 'Physical location or site address where the rented equipment will be deployed. Used for logistics and mobilization planning.',
    `total_committed_cost` DECIMAL(18,2) COMMENT 'Total committed cost for the rental agreement including minimum hire period charges, mobilization, and demobilization. Used for budget commitment and accrual.',
    `weekly_hire_rate` DECIMAL(18,2) COMMENT 'Agreed weekly rental rate for the equipment in the contract currency. Used when billing is on a weekly basis.',
    CONSTRAINT pk_rental_agreement PRIMARY KEY(`rental_agreement_id`)
) COMMENT 'Master record governing the rental or hire of external equipment from a plant hire company or equipment supplier. Captures rental supplier, equipment description and type, rental start and end dates, agreed daily/weekly/monthly hire rate, minimum hire period, mobilization and demobilization charges, insurance requirements, operator-supplied flag, rental PO reference, and total committed rental cost. Distinct from procurement POs (owned by procurement domain) — this is the equipment-domain SSOT for rental fleet management and cost accrual.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`equipment_mobilization` (
    `equipment_mobilization_id` BIGINT COMMENT 'Unique identifier for the equipment mobilization or demobilization event.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Mobilization costs are billed to equipment mobilization contracts; the FK ties each mobilization event to its contract agreement.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset being mobilized or demobilized.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to quality.checklist. Business justification: Equipment mobilization requires pre-mobilization and receipt condition quality checklists (condition assessments, safety compliance checks). Construction site QA processes mandate formal checklist exe',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with this mobilization event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Mobilization costs are charged to cost centers for departmental cost allocation. Construction finance teams require cost center on mobilization records to allocate transport and logistics costs. No ex',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Mobilization/demobilization costs (transport_cost) must be allocated to cost codes for construction job costing. cost_allocation_code is a denormalized plain attr — replace with proper FK to finance.c',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Heavy equipment mobilization crew accountability: crane erection, heavy haul, and rigging mobilizations require a dedicated crew. Tracking the mobilization crew supports cost allocation (transport_cos',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: A mobilization or demobilization event is directly tied to a fleet assignment — equipment is mobilized TO a project because of a specific assignment. fleet_assignment already carries mobilization_date',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Moving heavy equipment across jurisdictions or onto regulated construction sites requires a valid transport or operating permit to be verified and recorded at mobilization. permit_number and permit',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Equipment mobilization and demobilization events are phase-driven in construction — equipment arrives at phase start and departs at phase end. A project scheduler and fleet manager track mobilization ',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: When rented equipment is mobilized to or demobilized from a site, the mobilization event is governed by the rental agreement (which specifies mobilization_charge and demobilization_charge). equipment_',
    `schedule_milestone_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_milestone. Business justification: Equipment mobilization completions directly drive contractual schedule milestones (e.g., Crane on-site milestone with LD exposure). This link enables automated milestone status updates from actual m',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Heavy equipment mobilization is a high-risk construction activity requiring a SWMS (crane lifts, oversized load movements, site access through live work areas). The SWMS for the mobilization activity ',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Trade package cost tracking: mobilization and demobilization costs are significant line items allocated to specific trade packages in construction budgets. Quantity surveyors track mobilization costs ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Transport compliance and insurance documentation: equipment mobilizations require identifying the licensed operator responsible for the move. Oversize/overweight permit compliance, insurance coverage ',
    `vendor_id` BIGINT COMMENT 'Reference to the subcontractor or vendor responsible for transporting the equipment.',
    `actual_arrival_date` DATE COMMENT 'Actual date when the equipment arrived at the destination location.',
    `actual_dispatch_date` DATE COMMENT 'Actual date when the equipment departed from the origin location.',
    `actual_transit_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours that the equipment was in transit from origin to destination.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the mobilization record was first created in the system.',
    `destination_location` STRING COMMENT 'Name or identifier of the location to which the equipment is being mobilized (project site, yard, storage facility).',
    `destination_site_code` STRING COMMENT 'Standardized code identifying the destination site or facility.',
    `dispatch_condition` STRING COMMENT 'Assessed physical and operational condition of the equipment at the time of dispatch from the origin location.. Valid values are `excellent|good|fair|poor|requires_repair`',
    `dispatch_condition_notes` STRING COMMENT 'Detailed notes or observations regarding the equipment condition at dispatch, including any pre-existing damage or defects.',
    `dispatch_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch sign-off was completed.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers between the origin and destination locations.',
    `estimated_transit_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours for the equipment to be transported from origin to destination.',
    `event_type` STRING COMMENT 'Type of equipment movement event: mobilization (to site), demobilization (from site), inter-site transfer, or relocation.. Valid values are `mobilization|demobilization|inter_site_transfer|relocation`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the equipment is covered by insurance during the mobilization transport.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage applicable to this mobilization event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the mobilization record was last updated in the system.',
    `mobilization_number` STRING COMMENT 'Externally-known business identifier for the mobilization event, typically formatted as MOB-YYYYNNNN.. Valid values are `^MOB-[0-9]{8}$`',
    `mobilization_status` STRING COMMENT 'Current lifecycle status of the mobilization event in the workflow.. Valid values are `planned|in_transit|completed|cancelled|delayed`',
    `origin_location` STRING COMMENT 'Name or identifier of the location from which the equipment is being mobilized (yard, warehouse, previous site).',
    `origin_site_code` STRING COMMENT 'Standardized code identifying the origin site or facility.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether special permits (oversize load, road permits, environmental permits) are required for this mobilization.',
    `planned_arrival_date` DATE COMMENT 'Scheduled date when the equipment is expected to arrive at the destination location.',
    `planned_dispatch_date` DATE COMMENT 'Scheduled date when the equipment is planned to depart from the origin location.',
    `reason` STRING COMMENT 'Business justification or reason for the mobilization event, such as project start, equipment replacement, or maintenance requirement.',
    `receipt_condition` STRING COMMENT 'Assessed physical and operational condition of the equipment upon receipt at the destination location.. Valid values are `excellent|good|fair|poor|damaged_in_transit`',
    `receipt_condition_notes` STRING COMMENT 'Detailed notes or observations regarding the equipment condition at receipt, including any damage incurred during transport.',
    `receipt_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the receipt sign-off was completed.',
    `receipt_signed_by` STRING COMMENT 'Name of the site manager or authorized personnel who signed off on the equipment receipt at the destination.',
    `remarks` STRING COMMENT 'Additional comments, notes, or special instructions related to the mobilization event.',
    `transport_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for transporting the equipment, including freight, permits, and handling charges.',
    `transport_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transport cost.. Valid values are `^[A-Z]{3}$`',
    `transport_method` STRING COMMENT 'Method or mode of transportation used to move the equipment.. Valid values are `flatbed_truck|lowboy_trailer|self_propelled|rail|barge|air_freight`',
    CONSTRAINT pk_equipment_mobilization PRIMARY KEY(`equipment_mobilization_id`)
) COMMENT 'Transactional record capturing the mobilization or demobilization event of a piece of equipment to or from a project site. Tracks event type (mobilization, demobilization, inter-site transfer), planned and actual transport dates, origin and destination locations, transport contractor, transport cost, permits required (oversize load, road permits), equipment condition at dispatch and receipt, and sign-off by site manager. Supports site logistics planning, cost allocation, and equipment tracking across the fleet.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`fuel_transaction` (
    `fuel_transaction_id` BIGINT COMMENT 'Unique identifier for the fuel transaction record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Fuel supply is frequently contracted; associating each transaction with the governing agreement enables expense allocation and audit.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or fleet vehicle that received fuel. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this fuel transaction is allocated for cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fuel costs are allocated to cost centers for departmental cost reporting and overhead allocation. fuel_transaction has finance_cost_code_id and site_id but no cost_center FK. Construction cost control',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Fuel consumption is charged to a cost code for cost allocation and EVM reporting.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: Fuel is issued to equipment operating under a specific fleet assignment on a project. While fuel_transaction already has asset_id and construction_project_id, linking to the specific fleet_assignment ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fuel transactions are posted to GL accounts (fuel expense) for P&L reporting. fuel_transaction has finance_cost_code_id but no GL account FK. Finance teams post fuel costs to specific GL accounts for ',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Links fuel transactions to the material master for standardized fuel type, pricing, and regulatory reporting.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Fuel accountability and theft investigation: fuel transactions record which operator received fuel. The is_theft_suspected flag and fuel card reconciliation process require identifying the responsible',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or location where the equipment was operating at the time of fueling.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external fuel vendor or supplier if fuel was purchased from a third-party station. Null for internal fuel depots.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element for detailed project cost allocation and tracking.',
    `approval_status` STRING COMMENT 'Approval status of the fuel transaction. Indicates whether the transaction has been reviewed and approved by a supervisor or cost controller.. Valid values are `approved|pending_approval|rejected|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction was approved. Null if not yet approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the fuel transaction. Null if auto-approved or pending approval.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions in kilograms resulting from the fuel consumed. Calculated based on fuel type and quantity for ISO 14001 environmental reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction record was first created in the system. Represents the audit trail creation time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fuel_card_number` STRING COMMENT 'Fuel card or fleet card number used for the transaction. Masked or tokenized for security. Used for reconciliation with vendor invoices.',
    `fuel_point_name` STRING COMMENT 'Name or description of the fuel point or bowser where the fuel was issued.',
    `hour_meter_reading` DECIMAL(18,2) COMMENT 'Hour meter reading of the equipment at the time of fueling. Used to calculate fuel consumption per operating hour and detect anomalies.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with the fuel transaction. Used for accounts payable reconciliation.',
    `is_emergency_refuel` BOOLEAN COMMENT 'Flag indicating whether this was an emergency or unplanned refueling event. True indicates emergency; False indicates scheduled refueling.',
    `is_theft_suspected` BOOLEAN COMMENT 'Flag indicating whether fuel theft or wastage is suspected based on consumption patterns or anomaly detection. True indicates suspected theft; False indicates normal transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction record was last modified. Used for audit trail and change tracking.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Odometer reading of the fleet vehicle at the time of fueling. Used for mileage-based fuel consumption analysis. Applicable to vehicles with odometers.',
    `purchase_order_number` STRING COMMENT 'Purchase order number if the fuel transaction was part of a formal procurement process. Used for contract compliance and spend tracking.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Quantity of fuel issued to the equipment in the specified unit of measure. Typically measured in litres or gallons.',
    `source_system` STRING COMMENT 'Name of the source system from which the fuel transaction record originated (e.g., HCSS HeavyJob, SAP PM, Viewpoint Vista, fuel card provider system).',
    `source_system_code` STRING COMMENT 'Unique identifier of the fuel transaction in the source system. Used for traceability and reconciliation.',
    `tank_capacity_percentage` DECIMAL(18,2) COMMENT 'Percentage of the equipment fuel tank capacity filled during this transaction. Used to detect partial fills and optimize refueling schedules.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel transaction calculated as quantity issued multiplied by unit cost. Expressed in the transaction currency.',
    `transaction_notes` STRING COMMENT 'Free-text notes or comments about the fuel transaction. May include reasons for emergency refueling, discrepancies, or special circumstances.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or receipt number issued at the time of fueling. Used for audit trail and reconciliation.',
    `transaction_status` STRING COMMENT 'Current status of the fuel transaction in its lifecycle. Completed indicates finalized and posted; pending indicates awaiting approval; cancelled indicates voided; disputed indicates under review.. Valid values are `completed|pending|cancelled|disputed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel was issued to the equipment. Represents the actual business event time of fueling.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of fuel at the time of transaction. Expressed in the transaction currency.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the fuel quantity issued. Common units include litres, gallons, or kWh for electric charging.. Valid values are `litres|gallons|kwh`',
    CONSTRAINT pk_fuel_transaction PRIMARY KEY(`fuel_transaction_id`)
) COMMENT 'Transactional record of fuel issued to a piece of equipment or fleet vehicle. Captures fuel type (diesel, petrol, LPG), quantity issued (litres), unit cost, total cost, issuing fuel point or bowser, date and time of issue, hour meter or odometer reading at fueling, project and cost code allocation, and operator confirmation. Enables fuel consumption tracking, cost-per-hour analysis, carbon emissions reporting (ISO 14001), and detection of fuel wastage or theft.';

CREATE OR REPLACE TABLE `construction_ecm`.`equipment`.`operator_certification` (
    `operator_certification_id` BIGINT COMMENT 'Unique identifier for the operator certification record. Primary key for the operator certification entity.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Operator certification is tied to an equipment category; replace free‑text category with FK to asset_category to enforce consistency.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification costs are charged to cost centers for departmental training cost allocation and overhead reporting. Construction finance teams require cost center on certification records to allocate wo',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Operator certification costs (cost_amount field) are allocated to cost codes for construction workforce cost tracking and training budget reporting. Cost controllers classify certification spend by co',
    `craft_worker_id` BIGINT COMMENT 'Reference to the equipment operator in the workforce domain who holds this certification. Links to the workforce master data to identify the individual operator.',
    `document_register_id` BIGINT COMMENT 'Reference to the digital document or scanned copy of the physical certification document stored in the document management system. Links to Aconex or BIM 360 document repository.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Operator certifications (crane operator licenses, forklift certifications) are mandated by specific regulatory obligations (OSHA 1926, state licensing boards). Linking operator_certification to the go',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: Tender prequalification compliance: clients require proof of certified operators for specialized plant (cranes, piling rigs) as part of tender submission. Linking certifications to the tender supports',
    `training_id` BIGINT COMMENT 'Foreign key linking to safety.training. Business justification: Operator certifications are issued as outcomes of safety training events. The training_id on operator_certification links the certification to the specific training record that produced it, supporting',
    `assessment_date` DATE COMMENT 'The date on which the operator completed the certification assessment or examination. Represents the formal evaluation event.',
    `assessor_name` STRING COMMENT 'Name of the qualified assessor or examiner who conducted the certification assessment and validated the operators competency.',
    `capacity_rating` STRING COMMENT 'The maximum capacity or tonnage rating of equipment the operator is certified to operate, such as cranes up to 100 tons or forklifts up to 5 tons. Defines operational limits for equipment assignment.',
    `certificate_number` STRING COMMENT 'Unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification document.',
    `certification_level` STRING COMMENT 'The proficiency or skill level represented by the certification, such as basic, intermediate, advanced, or master operator. Indicates the complexity of equipment and operations the operator is qualified to perform. [ENUM-REF-CANDIDATE: basic|intermediate|advanced|master|trainee|journeyman|supervisor — 7 candidates stripped; promote to reference product]',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is valid and active, expired, suspended, revoked, or pending renewal. Critical for HSE pre-start checks and operator assignment validation.. Valid values are `valid|expired|suspended|revoked|pending_renewal|under_review`',
    `certification_type` STRING COMMENT 'The type or nature of the certification, such as operator license, competency card, safety certification, or manufacturer-specific certification.. Valid values are `operator_license|competency_card|safety_certification|manufacturer_certification|trade_qualification|endorsement`',
    `certifying_body` STRING COMMENT 'Name of the organization, authority, or institution that issued the certification. Examples include NCCCO, OSHA-approved training providers, manufacturer training centers, or government licensing authorities.',
    `certifying_body_accreditation_number` STRING COMMENT 'Accreditation or registration number of the certifying body, validating that the issuing organization is authorized to provide certifications.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain or renew this certification, including training fees, examination fees, and administrative charges. Used for workforce development cost tracking.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount. Enables multi-currency cost tracking for international operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this certification record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `endorsements` STRING COMMENT 'Additional endorsements, specializations, or restrictions associated with the certification, such as night operations, confined spaces, or specific attachment types. Comma-separated list of endorsement codes or descriptions.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Operators must renew or recertify before this date to maintain valid certification status.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued to the operator. Represents the start of the certification validity period.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country in which the certification was issued. Important for cross-border projects and international operator mobility.. Valid values are `^[A-Z]{3}$`',
    `issuing_state_province` STRING COMMENT 'State, province, or regional jurisdiction within the issuing country where the certification was granted. Relevant for jurisdictions with state-level licensing requirements.',
    `last_renewal_date` DATE COMMENT 'The most recent date on which the certification was renewed or recertified. Tracks the certification maintenance history.',
    `medical_clearance_date` DATE COMMENT 'The date on which the operator received medical clearance or passed the required health examination for this certification. Nullable if medical clearance is not required.',
    `medical_clearance_expiry_date` DATE COMMENT 'The date on which the medical clearance expires and must be renewed. Nullable if medical clearance is not required or does not expire.',
    `medical_clearance_required` BOOLEAN COMMENT 'Indicates whether a medical examination or health clearance is required as part of the certification or renewal process. True if medical clearance is mandatory, false otherwise.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this certification record. Provides audit trail for data changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this certification record was last modified in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_renewal_due_date` DATE COMMENT 'The date by which the operator must complete renewal requirements to maintain continuous certification. Used for proactive renewal planning and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the certification. Captures contextual information not covered by structured fields.',
    `practical_assessment_score` DECIMAL(18,2) COMMENT 'Score or grade achieved by the operator in the practical hands-on assessment component of the certification. Typically expressed as a percentage or numeric score.',
    `reciprocity_agreements` STRING COMMENT 'List of countries, states, or jurisdictions where this certification is recognized under reciprocity or mutual recognition agreements. Enables cross-jurisdictional operator deployment.',
    `renewal_requirement` STRING COMMENT 'Description of the requirements the operator must fulfill to renew the certification, such as refresher training hours, re-assessment, continuing education credits, or medical examination.',
    `restrictions` STRING COMMENT 'Any limitations or restrictions placed on the certification, such as daylight operations only, supervised operation required, or specific site conditions. Defines operational boundaries for the operator.',
    `source_system` STRING COMMENT 'Name of the operational system from which this certification record originated, such as SAP SuccessFactors, Intelex, or HCSS HeavyJob. Enables data lineage tracking.',
    `source_system_code` STRING COMMENT 'Unique identifier of this certification record in the source operational system. Enables traceability and reconciliation with source systems.',
    `sponsor_organization` STRING COMMENT 'Name of the organization that sponsored or paid for the operators certification training and examination. May be the construction company, a subcontractor, or the operator themselves.',
    `theory_assessment_score` DECIMAL(18,2) COMMENT 'Score or grade achieved by the operator in the theoretical or written examination component of the certification. Typically expressed as a percentage or numeric score.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Total number of training hours completed by the operator to achieve this certification. Demonstrates the depth of training and preparation.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified with the certifying body or through an independent verification process.',
    `verification_status` STRING COMMENT 'Status of the certification verification process, indicating whether the certification has been independently verified with the issuing body. Critical for compliance and audit purposes.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    `verified_by` STRING COMMENT 'Name or identifier of the person, system, or organization that performed the certification verification. Provides audit trail for verification activities.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this certification record in the system. Provides audit trail for data entry.',
    CONSTRAINT pk_operator_certification PRIMARY KEY(`operator_certification_id`)
) COMMENT 'Master record of an equipment operators certification, licence, or competency qualification for a specific equipment type or class. Captures operator reference (linked to workforce domain), equipment category certified for (e.g., tower crane, mobile crane, excavator, forklift), certifying body, certificate number, issue date, expiry date, certification status (valid, expired, suspended), and renewal requirements. Supports OSHA compliance, HSE pre-start checks, and operator-to-equipment assignment validation. Owned by equipment domain as it governs equipment operation rights.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_parent_category_asset_category_id` FOREIGN KEY (`parent_category_asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `construction_ecm`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `construction_ecm`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `construction_ecm`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `construction_ecm`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `construction_ecm`.`equipment`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `construction_ecm`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `construction_ecm`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `construction_ecm`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `construction_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `construction_ecm`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `construction_ecm`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`equipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`equipment` SET TAGS ('dbx_domain' = 'equipment');
ALTER TABLE `construction_ecm`.`equipment`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`equipment`.`asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `asset_current_location_site_construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Site ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `acquisition_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `acquisition_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|cubic_yards|cubic_meters|kilowatts|gallons_per_minute|pounds');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Asset Classification');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Approver Name');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Buyer Name');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|auction|scrap|write_off|trade_in|donation');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `emissions_tier` SET TAGS ('dbx_business_glossary_term' = 'Emissions Tier');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `hcss_heavyjob_asset_code` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Asset ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `home_yard_location` SET TAGS ('dbx_business_glossary_term' = 'Home Yard Location');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `last_meter_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Stage');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'commissioning|operational|aging|end_of_life|disposed');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Equipment Make');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `operating_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Operating Weight (Kilograms)');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|operator_owned');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `regulatory_compliance_class` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Class');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `sap_pm_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Equipment Number');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `sap_pm_equipment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `total_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Hours');
ALTER TABLE `construction_ecm`.`equipment`.`asset` ALTER COLUMN `year_of_manufacture` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `parent_category_asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Category ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `asset_category_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Status');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `asset_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `asset_class_sap` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Class');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `asset_class_sap` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `benchmark_utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Utilization Rate Percentage');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `capitalization_threshold` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Code');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Description');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Name');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Type');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'major|sub|class|specialty');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `hcss_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Equipment Type');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Code');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `mobilization_required` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `operator_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `ownership_classification` SET TAGS ('dbx_business_glossary_term' = 'Ownership Classification');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `ownership_classification` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|mixed');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `construction_ecm`.`equipment`.`asset_category` ALTER COLUMN `utilization_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Utilization Tracking Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` SET TAGS ('dbx_subdomain' = 'fleet_operations');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Vendor ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `actual_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Utilization Hours');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Number');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{8}$');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_purpose` SET TAGS ('dbx_business_glossary_term' = 'Assignment Purpose');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'owned|rental|lease|subcontractor_supplied|client_supplied');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_cost` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Cost');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_cost` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Cost');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'not_started|in_transit|on_site|demobilized');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `operating_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Operating Rate Per Hour');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `operating_rate_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `ownership_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Ownership Rate Per Hour');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `ownership_rate_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `planned_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Utilization Hours');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'HCSS_HEAVYJOB|SAP_PS|PROCORE|MANUAL');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `standby_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Standby Rate Per Hour');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `standby_rate_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `weekly_rate` SET TAGS ('dbx_business_glossary_term' = 'Weekly Rate');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `weekly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fleet_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `construction_ecm`.`equipment`.`hours` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`equipment`.`hours` SET TAGS ('dbx_subdomain' = 'fleet_operations');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `hours_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours ID');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|disputed');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Hour');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'breakdown|awaiting_parts|awaiting_operator|weather_hold|scheduled_maintenance|unscheduled_repair');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Downtime Impact Assessment');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_impact_assessment` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Downtime Resolution Action');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Root Cause Code');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_root_cause_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `equipment_availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Equipment Availability Rate');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `equipment_utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Equipment Utilization Rate');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Liters');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `meter_reading_end` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading End');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `meter_reading_start` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Start');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|subcontractor_supplied');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `record_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|weekend|holiday|emergency');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'HCSS_HeavyJob|SAP_PM|Procore|Manual_Entry');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `total_equipment_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Equipment Cost');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `total_equipment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`hours` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` SET TAGS ('dbx_subdomain' = 'maintenance_control');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Team ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Unit');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Value');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `manufacturer_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Recommendation Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Notes');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `parts_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Parts List Reference');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Name');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Number');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Status');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|inactive|archived');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Type');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'time_based|meter_based|condition_based|predictive|statutory');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority Level');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Strategy');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduling_strategy` SET TAGS ('dbx_value_regex' = 'fixed_schedule|floating_schedule|on_demand');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `site_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Task List Reference');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_value_regex' = '^TL[A-Z0-9]{6,10}$');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `tolerance_after_days` SET TAGS ('dbx_business_glossary_term' = 'Tolerance After Days');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `tolerance_before_days` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Before Days');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `warranty_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Impact Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|inspection|calibration|overhaul|statutory');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` SET TAGS ('dbx_subdomain' = 'maintenance_control');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `compliance_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Hours');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `external_services_cost` SET TAGS ('dbx_business_glossary_term' = 'External Services Cost');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `external_services_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `meter_reading_at_maintenance` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading at Maintenance');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Notes');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Number');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Status');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Type');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|breakdown|statutory_inspection|calibration|overhaul');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `construction_ecm`.`equipment`.`maintenance_order` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` SET TAGS ('dbx_subdomain' = 'maintenance_control');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record ID');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuing Authority');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `defects_description` SET TAGS ('dbx_business_glossary_term' = 'Defects Description');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `defects_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified Count');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `equipment_hours_at_inspection` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours at Inspection');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost Currency');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_pm|intelex|hcss_heavyjob|procore|manual_entry');
ALTER TABLE `construction_ecm`.`equipment`.`inspection_record` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement ID');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `actual_demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Demobilization Date');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `actual_mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Mobilization Date');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|milestone');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `daily_hire_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Hire Rate');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `damage_waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Damage Waiver Amount');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `demobilization_charge` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Charge');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Description');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `fuel_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Included Flag');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `insurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `late_return_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Return Penalty Rate');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'supplier|contractor|shared');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `minimum_hire_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Hire Period (Days)');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `mobilization_charge` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Charge');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `monthly_hire_rate` SET TAGS ('dbx_business_glossary_term' = 'Monthly Hire Rate');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Notes');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `operator_supplied_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Supplied Flag');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Number');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{6,10}$');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rental End Date');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_po_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Purchase Order (PO) Number');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_po_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rental Start Date');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `rental_status` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Status');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `total_committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Rental Cost');
ALTER TABLE `construction_ecm`.`equipment`.`rental_agreement` ALTER COLUMN `weekly_hire_rate` SET TAGS ('dbx_business_glossary_term' = 'Weekly Hire Rate');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` SET TAGS ('dbx_subdomain' = 'fleet_operations');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `equipment_mobilization_id` SET TAGS ('dbx_business_glossary_term' = 'Mobilization ID');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `schedule_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Milestone Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Contractor ID');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `actual_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Dispatch Date');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `actual_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Transit Hours');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `destination_site_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Code');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_condition` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Condition');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|requires_repair');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Condition Notes');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Signature Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance (Kilometers)');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `estimated_transit_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Hours');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'mobilization|demobilization|inter_site_transfer|relocation');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Number');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('dbx_value_regex' = '^MOB-[0-9]{8}$');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|completed|cancelled|delayed');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `origin_site_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Site Code');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `planned_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Date');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `planned_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Dispatch Date');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Reason');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged_in_transit');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition Notes');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Signature Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_signed_by` SET TAGS ('dbx_business_glossary_term' = 'Receipt Signed By');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_cost` SET TAGS ('dbx_business_glossary_term' = 'Transport Cost');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transport Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_method` SET TAGS ('dbx_business_glossary_term' = 'Transport Method');
ALTER TABLE `construction_ecm`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_method` SET TAGS ('dbx_value_regex' = 'flatbed_truck|lowboy_trailer|self_propelled|rail|barge|air_freight');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` SET TAGS ('dbx_subdomain' = 'fleet_operations');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|auto_approved');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission (kg CO2)');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Card Number');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_point_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Point Name');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `hour_meter_reading` SET TAGS ('dbx_business_glossary_term' = 'Hour Meter Reading');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `is_emergency_refuel` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Refuel');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `is_theft_suspected` SET TAGS ('dbx_business_glossary_term' = 'Is Theft Suspected');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `tank_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tank Capacity Percentage');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled|disputed');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'litres|gallons|kwh');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `operator_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Identifier (ID)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Attachment Document Identifier (ID)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'valid|expired|suspended|revoked|pending_renewal|under_review');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'operator_license|competency_card|safety_certification|manufacturer_certification|trade_qualification|endorsement');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `certifying_body_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Accreditation Number');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Endorsements');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Expiry Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Required Flag');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `practical_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Practical Assessment Score');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `reciprocity_agreements` SET TAGS ('dbx_business_glossary_term' = 'Reciprocity Agreements');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `renewal_requirement` SET TAGS ('dbx_business_glossary_term' = 'Renewal Requirement');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Restrictions');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `sponsor_organization` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `theory_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Theory Assessment Score');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `construction_ecm`.`equipment`.`operator_certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
