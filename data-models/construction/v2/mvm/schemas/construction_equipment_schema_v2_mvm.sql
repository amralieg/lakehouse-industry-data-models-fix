-- Schema for Domain: equipment | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-22 17:24:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`equipment` COMMENT 'Construction equipment and fleet management domain tracking heavy machinery (cranes, excavators, concrete pumps), tools, generators, and fleet vehicles. Owns asset master data, utilization tracking, maintenance schedules, equipment hours, mobilization/demobilization records, rental vs. owned classification, and asset lifecycle management via SAP PM and HCSS HeavyJob.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the construction equipment or fleet asset. Primary key for the asset master record.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Asset belongs to an asset category; replace free‑text category with FK to asset_category for proper hierarchy and eliminate redundancy.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the asset is currently assigned. Null when asset is idle or in yard storage.',
    `asset_current_location_site_construction_project_id` BIGINT COMMENT 'Identifier of the construction site or yard where the asset is currently located. Updated during mobilization and demobilization events.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Associates each asset with its primary fuel material, enabling accurate fuel consumption tracking and environmental compliance.',
    `jv_structure_id` BIGINT COMMENT 'Foreign key linking to client.jv_structure. Business justification: JV entities in construction maintain dedicated asset registers for JV-owned or JV-committed plant. This link enables JV asset valuation, depreciation allocation, and partner reporting — all mandatory ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Required for Daily Equipment Operator Assignment report, linking each asset to the assigned craft worker for safety compliance and productivity tracking.',
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
) COMMENT 'Core master record for every piece of construction equipment and fleet vehicle owned, long-term leased, or rented by the company. Captures asset identity, classification (crane, excavator, concrete pump, generator, fleet vehicle, small tool), make, model, serial number, year of manufacture, acquisition date, acquisition cost, ownership type (owned/rented/leased), current status (active, idle, under maintenance, disposed), SAP PM equipment number, HCSS HeavyJob asset ID, regulatory compliance class, and asset lifecycle stage. For disposed assets: captures disposal method (sale, auction, scrap, write-off, trade-in), disposal date, disposal proceeds, buyer details, reason for disposal, and authorizing approver. This is the SSOT for all equipment identity and lifecycle data across the enterprise, from commissioning through disposal. Canonical equipment.asset entity (v2 curated).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`asset_category` (
    `asset_category_id` BIGINT COMMENT 'Unique identifier for the asset category. Primary key for the asset category reference hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset category default cost center ensures new assets inherit correct cost center for accounting.',
    `parent_category_asset_category_id` BIGINT COMMENT 'Reference to the parent category in the asset classification hierarchy. Enables multi-level taxonomy (e.g., Heavy Equipment > Earthmoving > Excavators). Null for top-level categories.',
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
    `gl_account_code` STRING COMMENT 'Default General Ledger account code for asset capitalization and depreciation expense posting in SAP S/4HANA Finance. Aligns with chart of accounts structure for fixed asset accounting.. Valid values are `^[0-9]{4,10}$`',
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
) COMMENT 'Reference classification hierarchy for construction equipment and fleet assets. Defines the taxonomy of equipment types used across the enterprise: major categories (heavy earthmoving, lifting, concrete, MEP, fleet, small tools, generators), sub-categories, and equipment class codes aligned with HCSS HeavyJob cost coding and SAP PM functional location structures. Drives cost coding, depreciation rules, maintenance strategy assignment, and utilization benchmarking. Canonical equipment.asset_category entity (v2 curated).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` (
    `fleet_assignment_id` BIGINT COMMENT 'Unique identifier for the fleet assignment record. Primary key.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Equipment deployment planning: fleet assignments are made to support specific schedule activities (e.g., crane assigned to structural steel erection activity). Construction equipment managers and sche',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment lease/assignment to a project is governed by a contract; linking records the contract that authorizes each assignment.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment or fleet vehicle being assigned. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which the equipment is assigned.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Equipment fleet assignments generate costs that must be allocated to project cost accounts for EVM and financial control. Cost account is the primary financial control point in construction — fleet as',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Fleet assignments drive equipment hire charges to specific cost codes on projects. fleet_assignment.cost_allocation_code is a denormalized plain-text field; a proper FK to finance.cost_code enables au',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Equipment is assigned to a specific crew for a project phase. Linking fleet_assignment to crew enables crew-level equipment allocation reporting, productivity analysis (equipment hours per crew), and ',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Crane and heavy equipment fleet assignments are governed by approved lift plan drawings. Regulatory lift planning (ASME B30, local regulations) requires the fleet assignment to reference the approved ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Fleet assignments designate a specific operator (craft_worker) to operate assigned equipment on a project. Supports operator scheduling, equipment-operator pairing for safety compliance, and operator ',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Equipment mobilization into live construction zones (crane erection, plant entry into exclusion zones) requires a PTW. Construction HSE managers track PTW-to-fleet-assignment linkage for mobilization ',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Equipment assignments are planned and tracked by project phase (earthworks, structural, MEP, finishing). Phase-level fleet planning is standard construction scheduling practice — enables phase budget ',
    `project_milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Equipment mobilization and demobilization are milestone-driven in construction (crane arrival triggers structural milestone; equipment demob tied to handover milestone). Milestone-linked fleet assignm',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: When rented equipment is deployed to a project, the fleet_assignment record should reference the governing rental_agreement. This enables direct traceability from deployment to the hire contract — cri',
    `vendor_id` BIGINT COMMENT 'Reference to the rental company or vendor supplying the equipment, if applicable. Null for owned equipment.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Deploying equipment to a specific work front requires a risk assessment for that deployment context (e.g., crane in live traffic zone). Construction HSE process Equipment Deployment Risk Assessment ',
    `site_id` BIGINT COMMENT 'Reference to the specific site or work location where the equipment is deployed.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Equipment deployment to a work front requires the applicable SWMS governing that equipments operation at that location. Construction site managers track which SWMS covers each fleet assignment for WH',
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
    `rate_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for all rate amounts in this assignment record.',
    `source_system_code` STRING COMMENT 'Unique identifier of this assignment record in the source system. Used for data lineage, reconciliation, and incremental updates.',
    `standby_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly standby cost rate when equipment is on site but not actively operating. Lower rate than operating rate, used for idle time cost allocation.',
    `weekly_rate` DECIMAL(18,2) COMMENT 'Internal weekly cost rate for equipment assignment. Alternative to hourly or daily rates for equipment charged on a weekly basis.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this assignment record in the source system.',
    CONSTRAINT pk_fleet_assignment PRIMARY KEY(`fleet_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a specific piece of equipment or fleet vehicle to a project, site, or work front for a defined period. Tracks assignment start and end dates, assigned project, site location, responsible operator or driver, mobilization status, cost allocation code (WBS element), and applicable internal hire rate (ownership rate, operating rate, standby rate per hour/day/week). Supports equipment utilization tracking, inter-project cost allocation, internal charge-back to projects, and site logistics planning. Sourced from HCSS HeavyJob and SAP PS project systems. Canonical equipment.fleet_assignment entity (v2 curated).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`hours` (
    `hours_id` BIGINT COMMENT 'Unique identifier for the equipment hours transaction record. Primary key for daily or shift-level equipment operating time entries.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment usage hours are charged to the project contract; linking supports progress billing and utilization reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment unit (crane, excavator, concrete pump, generator, vehicle) for which hours are being recorded.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the equipment was deployed and operated during this time period.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Equipment operating hour costs are posted to cost codes for labor and equipment cost tracking.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: An hours record captures shift-level operating hours for a piece of equipment. That equipment is deployed to a project/site via a fleet_assignment. Linking hours to fleet_assignment enables assignment',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: hours.rental_invoice_reference is a denormalized plain-text field referencing the rental invoice for billable equipment hours. Replacing it with a proper FK to finance.invoice enables automated rental',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Equipment hours records capture shift-level utilization. Linking to the operating craft_worker enables operator productivity reporting, payroll cross-validation against timesheet hours, and operator-l',
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
    `standby_hours` DECIMAL(18,2) COMMENT 'Hours the equipment was on-site, available for use, but not powered on or actively deployed. Includes weather holds and awaiting instructions.',
    `total_equipment_cost` DECIMAL(18,2) COMMENT 'Total cost charged to the project for this equipment hours record. Calculated as operating_hours * cost_per_hour plus any additional charges. Used for project cost control and EVM.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition during the shift that may have affected equipment operation and productivity. Used for weather impact analysis and EOT claims. [ENUM-REF-CANDIDATE: clear|rain|snow|wind|extreme_heat|extreme_cold|fog — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hours PRIMARY KEY(`hours_id`)
) COMMENT 'Daily or shift-level transactional record of equipment operating hours, idle hours, standby hours, and downtime events captured from HCSS HeavyJob field time tracking. Includes cost code, operator ID, project and WBS reference, fuel consumption, meter reading (odometer or hour meter), shift date, production quantity achieved. For non-productive time: captures downtime start/end timestamps, duration, downtime category (breakdown, awaiting parts, awaiting operator, weather hold, scheduled maintenance), root cause code, resolution action, and impact assessment. Foundational for equipment utilization rate calculation, cost-per-hour analysis, MTTR (Mean Time To Repair), MTBF (Mean Time Between Failures), availability rate reporting, and CPI/SPI reporting under EVM. SSOT for all equipment time and downtime recording. Primary source: HCSS HeavyJob daily time entry. Canonical equipment.hours entity (v2 curated).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Unique identifier for the maintenance plan record. Primary key.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: In SAP PM and construction equipment management, preventive maintenance plans are frequently defined at the equipment category level (e.g., all excavators follow a 250-hour PM plan, all cranes require',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset or equipment class covered by this maintenance plan.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment and its maintenance plan are assigned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance plan budgeting is tracked against a cost center to align planned expenses with financial budgets.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Maintenance plans carry estimated_labor_cost and estimated_material_cost that must be pre-coded to cost codes for maintenance budget planning and forecast vs actual analysis. Construction cost enginee',
    `crew_id` BIGINT COMMENT 'Reference to the maintenance crew or team responsible for executing this maintenance plan.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Planned maintenance on construction plant is high-risk work requiring a SWMS under WHS legislation. The maintenance_plan references the governing SWMS for all scheduled maintenance activities. Constru',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Maintenance plans are derived from and governed by technical specifications (manufacturer requirements, regulatory standards, project specs). Asset management and compliance reporting require traceabi',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether completion of this maintenance plan requires formal certification or inspection sign-off by a qualified authority.',
    `compliance_requirement_code` STRING COMMENT 'Code identifying the regulatory or compliance requirement driving this maintenance plan (e.g., OSHA crane certification, EPA emissions inspection, manufacturer warranty requirement).',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance order record. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset on which this maintenance activity was performed. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment and maintenance activity are assigned. Enables project-level cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance order costs must be charged to the responsible cost center for accurate project cost reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Maintenance orders must be coded to project cost codes (labor, parts, external services) for job cost reporting and budget vs actual analysis. Construction ERP systems (SAP PM) require cost element as',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Maintenance orders are executed by a specific crew (e.g., mechanical crew). Linking the executing crew enables crew-level maintenance labor cost rollup, productivity reporting, and crew utilization an',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Maintenance orders reference specific drawings (as-built drawings, equipment assembly drawings, maintenance procedure drawings) that technicians use during execution. Work order management and mainten',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Corrective maintenance orders are raised to address identified hazards in the hazard register. Linking maintenance_order to hazard_register enables hazard closure tracking — a named HSE compliance pro',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Maintenance orders for external services and parts generate vendor invoices. Linking maintenance_order to the settling invoice enables AP three-way match (work order / PO / invoice) and total maintena',
    `maintenance_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance plan that generated this order, if applicable. Null for corrective or breakdown orders.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Needed to record which material (spare part) is consumed in a maintenance order, supporting inventory control and maintenance cost analysis.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Maintenance execution tracking requires knowing which certified mechanic/technician performed the work. Supports labor cost allocation to maintenance orders, warranty claim validation (technician cred',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Maintenance work on safety-critical plant (confined space, electrical isolation) requires a Permit to Work before execution. Construction HSE regulations mandate PTW-to-maintenance-order traceability.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Individual maintenance work orders require a SWMS for execution under WHS regulations. The order-level SWMS may differ from the plan-level SWMS (e.g., emergency repairs). Construction HSE compliance r',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Corrective maintenance orders are routinely raised in response to safety incidents in construction. Linking maintenance_order to the triggering incident enables incident-to-corrective-action closure t',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to equipment.inspection_record. Business justification: In construction equipment management, inspections frequently identify defects that trigger corrective maintenance work orders. A maintenance_order raised as a result of an inspection finding should re',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`inspection_record` (
    `inspection_record_id` BIGINT COMMENT 'Unique identifier for the equipment inspection record. Primary key for the inspection_record product.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset that was inspected. Links to the equipment master data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment is currently assigned at the time of inspection. Null if equipment is in yard or not assigned to a project.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Inspection costs (inspection_cost field) must be allocated to project cost codes for job cost tracking and regulatory compliance cost reporting. Construction projects track inspection expenditure by c',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Inspection records reference the as-built or equipment drawings used during the inspection (e.g., structural inspection against approved drawings, equipment installation inspection). Regulatory compli',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Regulatory compliance requires recording which certified craft_worker (e.g., certified rigger, licensed inspector) conducted each equipment inspection. Supports certificate issuance, OSHA compliance a',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Third-party inspection services generate vendor invoices that must be matched to the inspection record for AP processing. Linking inspection_record to finance.invoice enables cost reconciliation of in',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_plan. Business justification: Inspections in construction equipment are typically scheduled as part of a preventive maintenance plan (e.g., 250-hour inspection, annual statutory inspection). The inspection_record should reference ',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Statutory equipment inspections (crane, pressure vessel, confined space) require a PTW in construction. WHS regulations mandate PTW-to-inspection traceability. HSE auditors verify this link during com',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: Rented equipment requires mandatory pre-mobilization and post-demobilization inspections to document condition, record defects, and establish liability. The inspection_record for rented equipment shou',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: Equipment inspection is a high-risk work activity in construction requiring a SWMS under WHS legislation. The SWMS governs how the inspection is safely conducted. Construction HSE managers expect insp',
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
    `inspection_checklist_reference` STRING COMMENT 'Reference to the standard inspection checklist, Inspection and Test Plan (ITP), or procedure document used to conduct this inspection. Links to document management system.',
    `inspection_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this inspection event, including inspector fees, third-party inspection charges, testing costs, and administrative overhead. Null if cost not tracked.',
    `inspection_cost_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the inspection cost. Examples: USD, EUR, GBP. Null if cost not tracked.',
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
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement, standard, or code that mandates this inspection. Examples: OSHA 1926.550 for cranes, ASME Section VIII for pressure vessels, manufacturer maintenance manual reference.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for outdoor equipment inspections where environmental factors may affect inspection validity or equipment condition assessment.',
    CONSTRAINT pk_inspection_record PRIMARY KEY(`inspection_record_id`)
) COMMENT 'Transactional record of a statutory, regulatory, or internal safety inspection performed on a piece of equipment, and the master register of all resulting compliance certificates issued. Captures inspection type (pre-start check, periodic statutory inspection, OSHA compliance check, crane load test, lifting gear inspection, pressure vessel test, FAT/SAT), inspection date, inspector name and certification, pass/fail outcome, defects identified, corrective actions required, next inspection due date. For certificates: captures certificate type (crane load test certificate, pressure vessel certificate, lifting gear certificate, OSHA compliance certificate, insurance certificate), certificate number, issuing authority, issue date, expiry date, and document storage reference. SSOT for all equipment inspection events AND asset-level compliance certificates. Supports OSHA compliance, insurance requirements, equipment fitness-for-use certification, pre-mobilization compliance checks, and regulatory audit trails. Distinct from quality ITP inspections (owned by quality domain) and operator certifications (which track people, not assets). Canonical equipment.inspection_record entity (v2 curated).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` (
    `rental_agreement_id` BIGINT COMMENT 'Unique identifier for the equipment rental agreement. Primary key for the rental agreement record.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment unit being rented. Links to the equipment master record in the equipment domain.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this rental equipment is assigned. Links to the project master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rental agreement expenses are allocated to a cost center for cost tracking and billing.',
    `jv_structure_id` BIGINT COMMENT 'Foreign key linking to client.jv_structure. Business justification: JV entities frequently execute their own equipment rental agreements, separate from parent company procurement. Linking rental_agreement to jv_structure enables JV-level rental cost tracking, partner ',
    `vendor_id` BIGINT COMMENT 'Reference to the plant hire company or equipment supplier providing the rental equipment. Links to the supplier master record.',
    `actual_demobilization_date` DATE COMMENT 'Actual date when the equipment was demobilized and removed from the project site. Used for final billing and cost reconciliation.',
    `actual_mobilization_date` DATE COMMENT 'Actual date when the equipment was delivered and mobilized to the project site. May differ from planned rental start date.',
    `approval_date` DATE COMMENT 'Date when the rental agreement was formally approved and authorized for execution.',
    `billing_frequency` DECIMAL(18,2) COMMENT 'Frequency at which rental charges are invoiced by the supplier (daily, weekly, monthly, or milestone-based).',
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
    `payment_terms` DECIMAL(18,2) COMMENT 'Payment terms agreed with the supplier (e.g., Net 30 days, Net 45 days, 2/10 Net 30). Governs invoice payment schedule.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` (
    `fuel_transaction_id` BIGINT COMMENT 'Unique identifier for the fuel transaction record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Fuel supply is frequently contracted; associating each transaction with the governing agreement enables expense allocation and audit.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or fleet vehicle that received fuel. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this fuel transaction is allocated for cost tracking.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Fuel consumption is charged to a cost code for cost allocation and EVM reporting.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: Fuel is issued to equipment that is actively deployed on a fleet assignment. Linking fuel_transaction to fleet_assignment enables assignment-level fuel cost and consumption reporting — critical for pr',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Fuel purchases from vendors generate AP invoices. fuel_transaction.invoice_number is a denormalized plain-text reference; replacing it with a proper FK to finance.invoice enables automated three-way m',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Links fuel transactions to the material master for standardized fuel type, pricing, and regulatory reporting.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Fuel is issued to specific equipment operators (craft_workers). Replacing denormalized operator_name with a proper FK enables operator-level fuel consumption reporting, cost allocation to labor record',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or location where the equipment was operating at the time of fueling.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external fuel vendor or supplier if fuel was purchased from a third-party station. Null for internal fuel depots.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to material.warehouse. Business justification: Fuel transactions must reference the source fuel depot/warehouse for inventory reconciliation and stock depletion. Construction fuel management requires knowing which storage facility dispensed fuel t',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element for detailed project cost allocation and tracking.',
    `approval_status` STRING COMMENT 'Approval status of the fuel transaction. Indicates whether the transaction has been reviewed and approved by a supervisor or cost controller.. Valid values are `approved|pending_approval|rejected|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction was approved. Null if not yet approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the fuel transaction. Null if auto-approved or pending approval.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions in kilograms resulting from the fuel consumed. Calculated based on fuel type and quantity for ISO 14001 environmental reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction record was first created in the system. Represents the audit trail creation time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fuel_card_number` STRING COMMENT 'Fuel card or fleet card number used for the transaction. Masked or tokenized for security. Used for reconciliation with vendor invoices.',
    `hour_meter_reading` DECIMAL(18,2) COMMENT 'Hour meter reading of the equipment at the time of fueling. Used to calculate fuel consumption per operating hour and detect anomalies.',
    `is_emergency_refuel` BOOLEAN COMMENT 'Flag indicating whether this was an emergency or unplanned refueling event. True indicates emergency; False indicates scheduled refueling.',
    `is_theft_suspected` BOOLEAN COMMENT 'Flag indicating whether fuel theft or wastage is suspected based on consumption patterns or anomaly detection. True indicates suspected theft; False indicates normal transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction record was last modified. Used for audit trail and change tracking.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Odometer reading of the fleet vehicle at the time of fueling. Used for mileage-based fuel consumption analysis. Applicable to vehicles with odometers.',
    `purchase_order_number` STRING COMMENT 'Purchase order number if the fuel transaction was part of a formal procurement process. Used for contract compliance and spend tracking.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Quantity of fuel issued to the equipment in the specified unit of measure. Typically measured in litres or gallons.',
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
) COMMENT 'Transactional record of fuel issued to a piece of equipment or fleet vehicle. Captures fuel type (diesel, petrol, LPG), quantity issued (litres), unit cost, total cost, issuing fuel point or bowser, date and time of issue, hour meter or odometer reading at fueling, project and cost code allocation, and operator confirmation. Enables fuel consumption tracking, cost-per-hour analysis, carbon emissions reporting (ISO 14001), and detection of fuel wastage or theft. Canonical equipment.fuel_transaction entity (v2 curated).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_parent_category_asset_category_id` FOREIGN KEY (`parent_category_asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `vibe_construction_v1`.`equipment`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`equipment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`equipment` SET TAGS ('dbx_domain' = 'equipment');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_current_location_site_construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Current Location Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `jv_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Structure Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|cubic_yards|cubic_meters|kilowatts|gallons_per_minute|pounds');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Asset Classification');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Approver Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Buyer Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|auction|scrap|write_off|trade_in|donation');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `emissions_tier` SET TAGS ('dbx_business_glossary_term' = 'Emissions Tier');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `hcss_heavyjob_asset_code` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Asset ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `last_meter_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Stage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'commissioning|operational|aging|end_of_life|disposed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `make` SET TAGS ('dbx_business_glossary_term' = 'Equipment Make');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `operating_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Operating Weight (Kilograms)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|operator_owned');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `regulatory_compliance_class` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Class');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `sap_pm_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Equipment Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `sap_pm_equipment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `total_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `year_of_manufacture` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `parent_category_asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Category ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_category_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_class_sap` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Class');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_class_sap` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `benchmark_utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Utilization Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `capitalization_threshold` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'major|sub|class|specialty');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `hcss_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'HCSS HeavyJob Equipment Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `mobilization_required` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `operator_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `ownership_classification` SET TAGS ('dbx_business_glossary_term' = 'Ownership Classification');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `ownership_classification` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|mixed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `utilization_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Utilization Tracking Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Plan Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Vendor ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `actual_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Utilization Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_purpose` SET TAGS ('dbx_business_glossary_term' = 'Assignment Purpose');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'owned|rental|lease|subcontractor_supplied|client_supplied');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_cost` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_cost` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'not_started|in_transit|on_site|demobilized');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `operating_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Operating Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `operating_rate_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `ownership_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Ownership Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `ownership_rate_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `planned_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Utilization Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `standby_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Standby Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `standby_rate_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `weekly_rate` SET TAGS ('dbx_business_glossary_term' = 'Weekly Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `weekly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `hours_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|disputed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'breakdown|awaiting_parts|awaiting_operator|weather_hold|scheduled_maintenance|unscheduled_repair');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Downtime Impact Assessment');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_impact_assessment` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Downtime Resolution Action');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Root Cause Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_root_cause_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `equipment_availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Equipment Availability Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `equipment_utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Equipment Utilization Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Liters');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `idle_hours` SET TAGS ('dbx_business_glossary_term' = 'Idle Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `meter_reading_end` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading End');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `meter_reading_start` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Start');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|rented|leased|subcontractor_supplied');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `production_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `record_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|swing|weekend|holiday|emergency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `total_equipment_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Equipment Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `total_equipment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Team ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `compliance_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Unit');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `manufacturer_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Recommendation Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `parts_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Parts List Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|inactive|archived');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'time_based|meter_based|condition_based|predictive|statutory');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority Level');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Strategy');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduling_strategy` SET TAGS ('dbx_value_regex' = 'fixed_schedule|floating_schedule|on_demand');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `site_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Task List Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_value_regex' = '^TL[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `tolerance_after_days` SET TAGS ('dbx_business_glossary_term' = 'Tolerance After Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `tolerance_before_days` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Before Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `warranty_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Impact Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|inspection|calibration|overhaul|statutory');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `maintenance_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Inspection Record Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `compliance_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `external_services_cost` SET TAGS ('dbx_business_glossary_term' = 'External Services Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `external_services_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `meter_reading_at_maintenance` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading at Maintenance');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Order Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|breakdown|statutory_inspection|calibration|overhaul');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Maintenance Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `work_performed_description` SET TAGS ('dbx_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuing Authority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `defects_description` SET TAGS ('dbx_business_glossary_term' = 'Defects Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `defects_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified Count');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `equipment_hours_at_inspection` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hours at Inspection');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_checklist_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Checklist Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost Currency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `jv_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Structure Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `actual_demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `actual_mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `daily_hire_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Hire Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `damage_waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Damage Waiver Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `demobilization_charge` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Charge');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Equipment Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `fuel_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Included Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `insurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `late_return_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Return Penalty Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'supplier|contractor|shared');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `minimum_hire_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Hire Period (Days)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `mobilization_charge` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Charge');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `monthly_hire_rate` SET TAGS ('dbx_business_glossary_term' = 'Monthly Hire Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `operator_supplied_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Supplied Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_number` SET TAGS ('dbx_value_regex' = '^RA-[0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rental End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_po_number` SET TAGS ('dbx_business_glossary_term' = 'Rental Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_po_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rental Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_status` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `total_committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Rental Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `weekly_hire_rate` SET TAGS ('dbx_business_glossary_term' = 'Weekly Hire Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|auto_approved');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission (kg CO2)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Card Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `hour_meter_reading` SET TAGS ('dbx_business_glossary_term' = 'Hour Meter Reading');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `is_emergency_refuel` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Refuel');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `is_theft_suspected` SET TAGS ('dbx_business_glossary_term' = 'Is Theft Suspected');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `odometer_reading` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `tank_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tank Capacity Percentage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled|disputed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'litres|gallons|kwh');
